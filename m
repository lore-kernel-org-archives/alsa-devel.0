From: Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH v3 1/3] ASoC: fsl_sai: Update is_slave_mode with correct value
Date: Mon, 22 Apr 2019 19:02:28 +0000
Message-ID: <20190422190213.30726-2-daniel.baluta@nxp.com>
References: <20190422190213.30726-1-daniel.baluta@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190422190213.30726-1-daniel.baluta@nxp.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "broonie@kernel.org" <broonie@kernel.org>
Cc: "S.j. Wang" <shengjiu.wang@nxp.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "timur@kernel.org" <timur@kernel.org>, "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>, "festevam@gmail.com" <festevam@gmail.com>, "perex@perex.cz" <perex@perex.cz>, "tiwai@suse.com" <tiwai@suse.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>, Daniel Baluta <daniel.baluta@nxp.com>
List-Id: alsa-devel@alsa-project.org

aXNfc2xhdmVfbW9kZSBkZWZhdWx0cyB0byBmYWxzZSBiZWNhdXNlIHNhaSBzdHJ1Y3R1cmUNCnRo
YXQgY29udGFpbnMgaXQgaXMga3phbGxvYydlZC4NCg0KQW55aG93LCBpZiB3ZSBkZWNpZGUgdG8g
c2V0IHRoZSBmb2xsb3dpbmcgY29uZmlndXJhdGlvbg0KU0FJIHNsYXZlIC0+IFNBSSBtYXN0ZXIs
IGlzX3NsYXZlX21vZGUgd2lsbCByZW1haW4gc2V0IG9uIHRydWUNCmFsdG91Z2ggU0FJIGJlaW5n
IG1hc3RlciBpdCBzaG91bGQgYmUgc2V0IHRvIGZhbHNlLg0KDQpGaXggdGhpcyBieSB1cGRhdGlu
ZyBpc19zbGF2ZV9tb2RlIGZvciBlYWNoIGNhbGwgb2YNCmZzbF9zYWlfc2V0X2RhaV9mbXQuDQoN
ClNpZ25lZC1vZmYtYnk6IERhbmllbCBCYWx1dGEgPGRhbmllbC5iYWx1dGFAbnhwLmNvbT4NCkFj
a2VkLWJ5OiBOaWNvbGluIENoZW4gPG5pY29sZW90c3VrYUBnbWFpbC5jb20+DQotLS0NCiBzb3Vu
ZC9zb2MvZnNsL2ZzbF9zYWkuYyB8IDIgKysNCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25z
KCspDQoNCmRpZmYgLS1naXQgYS9zb3VuZC9zb2MvZnNsL2ZzbF9zYWkuYyBiL3NvdW5kL3NvYy9m
c2wvZnNsX3NhaS5jDQppbmRleCBiNTYzMDA0ZmI4OWYuLmQ5ZGY5ODk3NWNmOCAxMDA2NDQNCi0t
LSBhL3NvdW5kL3NvYy9mc2wvZnNsX3NhaS5jDQorKysgYi9zb3VuZC9zb2MvZnNsL2ZzbF9zYWku
Yw0KQEAgLTI2OCwxMiArMjY4LDE0IEBAIHN0YXRpYyBpbnQgZnNsX3NhaV9zZXRfZGFpX2ZtdF90
cihzdHJ1Y3Qgc25kX3NvY19kYWkgKmNwdV9kYWksDQogCWNhc2UgU05EX1NPQ19EQUlGTVRfQ0JT
X0NGUzoNCiAJCXZhbF9jcjIgfD0gRlNMX1NBSV9DUjJfQkNEX01TVFI7DQogCQl2YWxfY3I0IHw9
IEZTTF9TQUlfQ1I0X0ZTRF9NU1RSOw0KKwkJc2FpLT5pc19zbGF2ZV9tb2RlID0gZmFsc2U7DQog
CQlicmVhazsNCiAJY2FzZSBTTkRfU09DX0RBSUZNVF9DQk1fQ0ZNOg0KIAkJc2FpLT5pc19zbGF2
ZV9tb2RlID0gdHJ1ZTsNCiAJCWJyZWFrOw0KIAljYXNlIFNORF9TT0NfREFJRk1UX0NCU19DRk06
DQogCQl2YWxfY3IyIHw9IEZTTF9TQUlfQ1IyX0JDRF9NU1RSOw0KKwkJc2FpLT5pc19zbGF2ZV9t
b2RlID0gZmFsc2U7DQogCQlicmVhazsNCiAJY2FzZSBTTkRfU09DX0RBSUZNVF9DQk1fQ0ZTOg0K
IAkJdmFsX2NyNCB8PSBGU0xfU0FJX0NSNF9GU0RfTVNUUjsNCi0tIA0KMi4xNy4xDQoNCg==
