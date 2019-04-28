From: "S.j. Wang" <shengjiu.wang@nxp.com>
Subject: [PATCH V6] ASoC: fsl_esai: Fix missing break in switch statement
Date: Sun, 28 Apr 2019 02:24:27 +0000
Message-ID: <1556418264-17810-1-git-send-email-shengjiu.wang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "timur@kernel.org" <timur@kernel.org>, "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>, "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>, "festevam@gmail.com" <festevam@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Y2FzZSBFU0FJX0hDS1RfRVhUQUwgYW5kIGNhc2UgRVNBSV9IQ0tSX0VYVEFMIHNob3VsZCBiZQ0K
aW5kZXBlbmRlbnQgb2YgZWFjaCBvdGhlciwgc28gcmVwbGFjZSBmYWxsLXRocm91Z2ggd2l0aCBi
cmVhay4NCg0KRml4ZXM6IDQzZDI0ZTc2YjY5OCAoIkFTb0M6IGZzbF9lc2FpOiBBZGQgRVNBSSBD
UFUgREFJIGRyaXZlciIpDQpTaWduZWQtb2ZmLWJ5OiBTaGVuZ2ppdSBXYW5nIDxzaGVuZ2ppdS53
YW5nQG54cC5jb20+DQpBY2tlZC1ieTogTmljb2xpbiBDaGVuIDxuaWNvbGVvdHN1a2FAZ21haWwu
Y29tPg0KQ2M6IDxzdGFibGVAdmdlci5rZXJuZWwub3JnPg0KLS0tDQpDaGFuZ2VzIGluIFY2DQot
IHJlc2VuZCBiYXNlIG9uZSBmb3ItNS4yDQoNCkNoYW5nZXMgaW4gdjUNCi0gcmVtb3ZlIG5ldyBs
aW5lIGFmdGVyIEZpeGVzDQoNCkNoYW5nZXMgaW4gdjQNCi0gQWRkIGFja2VkLWJ5DQoNCkNoYW5n
ZXMgaW4gdjMNCi0gVXBkYXRlIHN1YmplY3QgbGluZSBhbmQgY2Mgc3RhYmxlDQoNCkNoYW5nZXMg
aW4gdjINCi0gRml4ICJGaXhlcyIgdGFnDQoNCiBzb3VuZC9zb2MvZnNsL2ZzbF9lc2FpLmMgfCAy
ICstDQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQoNCmRp
ZmYgLS1naXQgYS9zb3VuZC9zb2MvZnNsL2ZzbF9lc2FpLmMgYi9zb3VuZC9zb2MvZnNsL2ZzbF9l
c2FpLmMNCmluZGV4IGM3NDEwYmJmZDJhZi4uYmFkMGRmZWQ2YjY4IDEwMDY0NA0KLS0tIGEvc291
bmQvc29jL2ZzbC9mc2xfZXNhaS5jDQorKysgYi9zb3VuZC9zb2MvZnNsL2ZzbF9lc2FpLmMNCkBA
IC0yNTEsNyArMjUxLDcgQEAgc3RhdGljIGludCBmc2xfZXNhaV9zZXRfZGFpX3N5c2NsayhzdHJ1
Y3Qgc25kX3NvY19kYWkgKmRhaSwgaW50IGNsa19pZCwNCiAJCWJyZWFrOw0KIAljYXNlIEVTQUlf
SENLVF9FWFRBTDoNCiAJCWVjciB8PSBFU0FJX0VDUl9FVEk7DQotCQkvKiBmYWxsIHRocm91Z2gg
Ki8NCisJCWJyZWFrOw0KIAljYXNlIEVTQUlfSENLUl9FWFRBTDoNCiAJCWVjciB8PSBlc2FpX3By
aXYtPnN5bmNocm9ub3VzID8gRVNBSV9FQ1JfRVRJIDogRVNBSV9FQ1JfRVJJOw0KIAkJYnJlYWs7
DQotLSANCjEuOS4xDQoNCg==
