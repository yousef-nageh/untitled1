import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
// use this for  http: ^0.13.5

class Test extends StatefulWidget {
  const Test({Key? key}) : super(key: key);

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  List post = [];

  Future getpost() async {
    var url = "https://fakestoreapi.com/products";
    var response = await http.get(Uri.parse(url));
    var responsebody = jsonDecode(response.body);
    setState(
      () {
        post.addAll(responsebody);
      },
    );
  }

  @override
  void initState() {
    getpost();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(

        itemCount: post.length,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (context, i) {
          return Container(
            color: Colors.white,
            padding: EdgeInsets.all(25),
            margin: EdgeInsets.all(8),
            child: ListTile(
              title: Image.network("${post[i]['image']}"),
              subtitle: Container(
                alignment: Alignment.topCenter,
                child: Text(
                  "price= ${post[i]['price']}",
                  style: TextStyle(
                      color: Colors.black87,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
              ),

              //  backgroundImage: NetworkImage("${post[i]['image']}"),
            ),
          );
        },
      ),
    );
  }
}
