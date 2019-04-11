From: "S.j. Wang" <shengjiu.wang@nxp.com>
Subject: [PATCH V5] ASoC: fsl_esai: Fix missing break in switch statement
Date: Thu, 11 Apr 2019 08:43:01 +0000
Message-ID: <a2c4e289d292ac0e691131784962305f8207a4d8.1554971930.git.shengjiu.wang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "timur@kernel.org" <timur@kernel.org>, "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>, "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>, "festevam@gmail.com" <festevam@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "gustavo@embeddedor.com" <gustavo@embeddedor.com>
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Y2FzZSBFU0FJX0hDS1RfRVhUQUwgYW5kIGNhc2UgRVNBSV9IQ0tSX0VYVEFMIHNob3VsZCBiZQ0K
aW5kZXBlbmRlbnQgb2YgZWFjaCBvdGhlciwgc28gcmVwbGFjZSBmYWxsLXRocm91Z2ggd2l0aCBi
cmVhay4NCg0KRml4ZXM6IDQzZDI0ZTc2YjY5OCAoIkFTb0M6IGZzbF9lc2FpOiBBZGQgRVNBSSBD
UFUgREFJIGRyaXZlciIpDQpTaWduZWQtb2ZmLWJ5OiBTaGVuZ2ppdSBXYW5nIDxzaGVuZ2ppdS53
YW5nQG54cC5jb20+DQpBY2tlZC1ieTogTmljb2xpbiBDaGVuIDxuaWNvbGVvdHN1a2FAZ21haWwu
Y29tPg0KQ2M6IDxzdGFibGVAdmdlci5rZXJuZWwub3JnPg0KLS0tDQpDaGFuZ2VzIGluIHY1DQot
IHJlbW92ZSBuZXcgbGluZSBhZnRlciBGaXhlcw0KDQpDaGFuZ2VzIGluIHY0DQotIEFkZCBhY2tl
ZC1ieQ0KDQpDaGFuZ2VzIGluIHYzDQotIFVwZGF0ZSBzdWJqZWN0IGxpbmUgYW5kIGNjIHN0YWJs
ZQ0KDQpDaGFuZ2VzIGluIHYyDQotIEZpeCAiRml4ZXMiIHRhZw0KDQogc291bmQvc29jL2ZzbC9m
c2xfZXNhaS5jIHwgMiArLQ0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxl
dGlvbigtKQ0KDQpkaWZmIC0tZ2l0IGEvc291bmQvc29jL2ZzbC9mc2xfZXNhaS5jIGIvc291bmQv
c29jL2ZzbC9mc2xfZXNhaS5jDQppbmRleCAzNjIzYWE5YTZmMmUuLjE1MjAyYTYzNzE5NyAxMDA2
NDQNCi0tLSBhL3NvdW5kL3NvYy9mc2wvZnNsX2VzYWkuYw0KKysrIGIvc291bmQvc29jL2ZzbC9m
c2xfZXNhaS5jDQpAQCAtMjUxLDcgKzI1MSw3IEBAIHN0YXRpYyBpbnQgZnNsX2VzYWlfc2V0X2Rh
aV9zeXNjbGsoc3RydWN0IHNuZF9zb2NfZGFpICpkYWksIGludCBjbGtfaWQsDQogCQlicmVhazsN
CiAJY2FzZSBFU0FJX0hDS1RfRVhUQUw6DQogCQllY3IgfD0gRVNBSV9FQ1JfRVRJOw0KLQkJLyog
ZmFsbCB0aHJvdWdoICovDQorCQlicmVhazsNCiAJY2FzZSBFU0FJX0hDS1JfRVhUQUw6DQogCQll
Y3IgfD0gRVNBSV9FQ1JfRVJJOw0KIAkJYnJlYWs7DQotLSANCjEuOS4xDQoNCg==
