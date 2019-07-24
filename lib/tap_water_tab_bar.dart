import 'package:flutter/material.dart';
import 'package:tap_water_tab_bar/tab_item.dart';

class WaterTabBar extends StatefulWidget {
  final bool isButton;
  List<Map<String, dynamic>> btmNavbar = [];
  final Function onTabClick;
  int len = 0;
  WaterTabBar({Key key, this.btmNavbar, this.isButton = false, this.onTabClick})
      : super(key: key) {
    this.btmNavbar.asMap().map((i, v) => MapEntry(i, v['index'] = i));
    this.len = this.btmNavbar.length;
    if (this.isButton) {
      if (len % 2 == 0) {
        this.btmNavbar.insert(len ~/ 2, null);
      } else {
        this.btmNavbar.insert(len ~/ 2 + 1, null);
        this.btmNavbar.insert(len ~/ 2 + 2, null);
      }
    }
  }
  @override
  State<StatefulWidget> createState() => _WaterTabBarState();
}

class _WaterTabBarState extends State<WaterTabBar> {
  int _activeIndex = 0;
  String _bigImg = 'images/post_normal.png';

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Align(
            alignment: Alignment.bottomCenter,
            child: Stack(
              overflow: Overflow.visible,
              alignment: Alignment.bottomCenter,
              children: <Widget>[
                Container(
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          offset: Offset(0, -1),
                          blurRadius: 8)
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: widget.btmNavbar
                        .asMap()
                        .map((i, v) => MapEntry(
                            i,
                            v != null
                                ? TabItem(
                                    title: v['title'],
                                    icon: v['icon'],
                                    activeIcon: v['avtiveIcon'],
                                    isActive: v['index'] == _activeIndex,
                                    index: v['index'],
                                    onTabClick: _onTabClick)
                                : (widget.isButton ? TabItem() : Text(''))))
                        .values
                        .toList(),
                  ),
                ),
                Positioned(
                  child: widget.isButton
                      ? Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          width: 60,
                          child: GestureDetector(
                              onTap: () {
                                _onTabClick(null, widget.len);
                              },
                              child: Image.asset(_bigImg)),
                        )
                      : Text(''),
                ),
                // IgnorePointer(
                //   child: Container(
                //     decoration: const BoxDecoration(color: Colors.transparent),
                //     child: Align(
                //       heightFactor: 1,
                //       child: OverflowBox(
                //           //  child: ,
                //           ),
                //     ),
                //   ),
                // )
              ],
            )),
      ],
    );
  }

  void _onTabClick(node, i) {
    print(i);
    setState(() {
      _activeIndex = i;
      _bigImg =
          node == null ? 'images/post_highlight.png' : 'images/post_normal.png';
    });
    widget.onTabClick(node, i);
  }
}
