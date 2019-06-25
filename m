From: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
Subject: [PATCH v2 5/6] ASoC: Define a set of DAPM pre/post-up events
Date: Tue, 25 Jun 2019 07:49:54 +0000
Message-ID: <20190625074937.2621-6-oleksandr.suvorov@toradex.com>
References: <20190625074937.2621-1-oleksandr.suvorov@toradex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190625074937.2621-1-oleksandr.suvorov@toradex.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Marcel Ziswiler <marcel.ziswiler@toradex.com>, Igor Opaniuk <igor.opaniuk@toradex.com>, Oleksandr Suvorov <oleksandr.suvorov@toradex.com>, Jaroslav Kysela <perex@perex.cz>, Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

UHJlcGFyZSB0byB1c2UgU05EX1NPQ19EQVBNX1BSRV9QT1NUX1BNVSBkZWZpbml0aW9uIHRvDQpy
ZWR1Y2UgY29taW5nIGNvZGUgc2l6ZSBhbmQgbWFrZSBpdCBtb3JlIHJlYWRhYmxlLg0KDQpTaWdu
ZWQtb2ZmLWJ5OiBPbGVrc2FuZHIgU3V2b3JvdiA8b2xla3NhbmRyLnN1dm9yb3ZAdG9yYWRleC5j
b20+DQotLS0NCg0KIGluY2x1ZGUvc291bmQvc29jLWRhcG0uaCB8IDIgKysNCiAxIGZpbGUgY2hh
bmdlZCwgMiBpbnNlcnRpb25zKCspDQoNCmRpZmYgLS1naXQgYS9pbmNsdWRlL3NvdW5kL3NvYy1k
YXBtLmggYi9pbmNsdWRlL3NvdW5kL3NvYy1kYXBtLmgNCmluZGV4IGMwMGEwYjhhZGUwODYuLjZj
NjY5NDE2MDEzMDcgMTAwNjQ0DQotLS0gYS9pbmNsdWRlL3NvdW5kL3NvYy1kYXBtLmgNCisrKyBi
L2luY2x1ZGUvc291bmQvc29jLWRhcG0uaA0KQEAgLTM1Myw2ICszNTMsOCBAQCBzdHJ1Y3QgZGV2
aWNlOw0KICNkZWZpbmUgU05EX1NPQ19EQVBNX1dJTExfUE1EICAgMHg4MCAgICAvKiBjYWxsZWQg
YXQgc3RhcnQgb2Ygc2VxdWVuY2UgKi8NCiAjZGVmaW5lIFNORF9TT0NfREFQTV9QUkVfUE9TVF9Q
TUQgXA0KIAkJCQkoU05EX1NPQ19EQVBNX1BSRV9QTUQgfCBTTkRfU09DX0RBUE1fUE9TVF9QTUQp
DQorI2RlZmluZSBTTkRfU09DX0RBUE1fUFJFX1BPU1RfUE1VIFwNCisJCQkJKFNORF9TT0NfREFQ
TV9QUkVfUE1VIHwgU05EX1NPQ19EQVBNX1BPU1RfUE1VKQ0KIA0KIC8qIGNvbnZlbmllbmNlIGV2
ZW50IHR5cGUgZGV0ZWN0aW9uICovDQogI2RlZmluZSBTTkRfU09DX0RBUE1fRVZFTlRfT04oZSkJ
XA0KLS0gDQoyLjIwLjENCg0K
