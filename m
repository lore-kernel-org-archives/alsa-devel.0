From: Grazvydas Ignotas <notasas@gmail.com>
Subject: issue with TWL4030
Date: Sat, 3 Jul 2010 01:50:50 +0300
Message-ID: <AANLkTilwdeNLChInBSaFIpVTLDONLXIIHVpLk3Aibk0v@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gx0-f179.google.com (mail-gx0-f179.google.com
	[209.85.161.179])
	by alsa0.perex.cz (Postfix) with ESMTP id B8F901037E3
	for <alsa-devel@alsa-project.org>;
	Sat,  3 Jul 2010 00:50:52 +0200 (CEST)
Received: by gxk26 with SMTP id 26so1822606gxk.38
	for <alsa-devel@alsa-project.org>; Fri, 02 Jul 2010 15:50:51 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

SGksCgp0aGVyZSBzZWVtcyB0byBiZSBhIHByb2JsZW0gd2l0aCBUV0w0MDMwIGh3X3BhcmFtIHBy
b2dyYW1taW5nLCB3aGljaAppcyBlYXN5IHRvIHJlcHJvZHVjZSBvdmVyIE9TUyBlbXVsYXRpb24g
d2l0aCB0aGlzIHNpbXBsZSBwcm9ncmFtOgoKaW50IG9zc19kZXYgPSBvcGVuKCIvZGV2L2RzcCIs
IE9fV1JPTkxZKTsKaW50IHN0ZXJlbyA9IDEsIGJpdHMgPSAxNiwgcmF0ZSA9IDQ0MTAwOwppb2N0
bChvc3NfZGV2LCBTTkRDVExfRFNQX1NFVEZNVCwgJmJpdHMpOwppb2N0bChvc3NfZGV2LCBTTkRD
VExfRFNQX1NQRUVELCAgJnJhdGUpOwppb2N0bChvc3NfZGV2LCBTTkRDVExfRFNQX1NURVJFTywg
JnN0ZXJlbyk7CndyaXRlKG9zc19kZXYsIHNvbWVidWZmLCBzaXplb2Yoc29tZWJ1ZmYpKTsKClRo
ZSBhYm92ZSBwcm9ncmFtIGVuZHMgdXAgcGxheWluZyBhdCA4a0h6LCBpbnN0ZWFkIG9mIGV4cGVj
dGVkIDQ0a0h6LgpJIGRpZCBzb21lIGNhbGwgdHJhY2luZyBhbmQgZ290IHRoaXM6ClsgMTA5Mi4y
NDYwMzJdIHNvY19wY21faHdfcGFyYW1zLCByYXRlIDgwMDAKWyAxMDkyLjI1MDEyMl0gdHdsNDAz
MF9od19wYXJhbXMKWyAxMDkyLjI1MzIzNF0gICBzZXQgcmF0ZSA4MDAwClsgMTA5Mi4yNTYxMDNd
ICAgY29uZmlndXJlZCAxClsgMTA5Mi4yNTkzNjhdIHNvY19wY21faHdfcGFyYW1zLCByYXRlIDgw
MDAKWyAxMDkyLjI2MzQyN10gdHdsNDAzMF9od19wYXJhbXMKWyAxMDkyLjI2Njg0NV0gc29jX3Bj
bV9od19wYXJhbXMsIHJhdGUgNDQxMDAKWyAxMDkyLjI3MDk2NV0gdHdsNDAzMF9od19wYXJhbXMK
WyAxMDk0LjQ1OTEwNl0gdHdsNDAzMF9zaHV0ZG93bgpbIDEwOTQuNDYyMDM2XSAgIGNvbmZpZ3Vy
ZWQgMAoKU28gaXQgbG9va3MgbGlrZSB0d2w0MDMwLT5jb25maWd1cmVkIGlzIHRoZSBjdWxwcml0
IG9mIHRoaXMsIHJlbW92aW5nCml0IHNvbHZlcyB0aGUgcHJvYmxlbSwgYnV0IEkgZ3Vlc3MgdGhh
dCB3aWxsIGJyZWFrIHNvbWV0aGluZyBlbHNlLiBBbnkKaWRlYXMgaG93IHRvIHByb3Blcmx5IGZp
eCB0aGlzPwoKR3Jhxb52eWRhcwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVj
dC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fs
c2EtZGV2ZWwK
