From: Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH 1/3 v2] ASoC: fsl_sai: Update is_slave_mode with correct value
Date: Sun, 21 Apr 2019 19:39:08 +0000
Message-ID: <20190421193853.10188-2-daniel.baluta@nxp.com>
References: <20190421193853.10188-1-daniel.baluta@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190421193853.10188-1-daniel.baluta@nxp.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "broonie@kernel.org" <broonie@kernel.org>
Cc: "S.j. Wang" <shengjiu.wang@nxp.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "timur@kernel.org" <timur@kernel.org>, "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>, "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>, "festevam@gmail.com" <festevam@gmail.com>, "perex@perex.cz" <perex@perex.cz>, "tiwai@suse.com" <tiwai@suse.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>, Daniel Baluta <daniel.baluta@nxp.com>
List-Id: alsa-devel@alsa-project.org

aXNfc2xhdmVfbW9kZSBkZWZhdWx0cyB0byBmYWxzZSBiZWNhdXNlIHNhaSBzdHJ1Y3R1cmUNCnRo
YXQgY29udGFpbnMgaXQgaXMga3phbGxvYydlZC4NCg0KQW55aG93LCBpZiB3ZSBkZWNpZGUgdG8g
c2V0IHRoZSBmb2xsb3dpbmcgY29uZmlndXJhdGlvbg0KU0FJIHNsYXZlIC0+IFNBSSBtYXN0ZXIs
IGlzX3NsYXZlX21vZGUgd2lsbCByZW1haW4gc2V0IG9uIHRydWUNCmFsdGhvdWdoIFNBSSBiZWlu
ZyBtYXN0ZXIgaXQgc2hvdWxkIGJlIHNldCB0byBmYWxzZS4NCg0KRml4IHRoaXMgYnkgdXBkYXRp
bmcgaXNfc2xhdmVfbW9kZSBmb3IgZWFjaCBjYWxsIG9mDQpmc2xfc2FpX3NldF9kYWlfZm10Lg0K
DQpTaWduZWQtb2ZmLWJ5OiBEYW5pZWwgQmFsdXRhIDxkYW5pZWwuYmFsdXRhQG54cC5jb20+DQot
LS0NCiBzb3VuZC9zb2MvZnNsL2ZzbF9zYWkuYyB8IDIgKysNCiAxIGZpbGUgY2hhbmdlZCwgMiBp
bnNlcnRpb25zKCspDQoNCmRpZmYgLS1naXQgYS9zb3VuZC9zb2MvZnNsL2ZzbF9zYWkuYyBiL3Nv
dW5kL3NvYy9mc2wvZnNsX3NhaS5jDQppbmRleCBiNTYzMDA0ZmI4OWYuLmQ5ZGY5ODk3NWNmOCAx
MDA2NDQNCi0tLSBhL3NvdW5kL3NvYy9mc2wvZnNsX3NhaS5jDQorKysgYi9zb3VuZC9zb2MvZnNs
L2ZzbF9zYWkuYw0KQEAgLTI2OCwxMiArMjY4LDE0IEBAIHN0YXRpYyBpbnQgZnNsX3NhaV9zZXRf
ZGFpX2ZtdF90cihzdHJ1Y3Qgc25kX3NvY19kYWkgKmNwdV9kYWksDQogCWNhc2UgU05EX1NPQ19E
QUlGTVRfQ0JTX0NGUzoNCiAJCXZhbF9jcjIgfD0gRlNMX1NBSV9DUjJfQkNEX01TVFI7DQogCQl2
YWxfY3I0IHw9IEZTTF9TQUlfQ1I0X0ZTRF9NU1RSOw0KKwkJc2FpLT5pc19zbGF2ZV9tb2RlID0g
ZmFsc2U7DQogCQlicmVhazsNCiAJY2FzZSBTTkRfU09DX0RBSUZNVF9DQk1fQ0ZNOg0KIAkJc2Fp
LT5pc19zbGF2ZV9tb2RlID0gdHJ1ZTsNCiAJCWJyZWFrOw0KIAljYXNlIFNORF9TT0NfREFJRk1U
X0NCU19DRk06DQogCQl2YWxfY3IyIHw9IEZTTF9TQUlfQ1IyX0JDRF9NU1RSOw0KKwkJc2FpLT5p
c19zbGF2ZV9tb2RlID0gZmFsc2U7DQogCQlicmVhazsNCiAJY2FzZSBTTkRfU09DX0RBSUZNVF9D
Qk1fQ0ZTOg0KIAkJdmFsX2NyNCB8PSBGU0xfU0FJX0NSNF9GU0RfTVNUUjsNCi0tIA0KMi4xNy4x
DQoNCg==
