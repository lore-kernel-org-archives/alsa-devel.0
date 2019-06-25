From: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
Subject: [PATCH v2 2/6] ASoC: sgtl5000: add ADC mute control
Date: Tue, 25 Jun 2019 07:49:49 +0000
Message-ID: <20190625074937.2621-3-oleksandr.suvorov@toradex.com>
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

VGhpcyBjb250cm9sIG11dGUvdW5tdXRlIHRoZSBBREMgaW5wdXQgb2YgU0dUTDUwMDANCnVzaW5n
IGl0cyBDSElQX0FOQV9DVFJMIHJlZ2lzdGVyLg0KDQpTaWduZWQtb2ZmLWJ5OiBPbGVrc2FuZHIg
U3V2b3JvdiA8b2xla3NhbmRyLnN1dm9yb3ZAdG9yYWRleC5jb20+DQotLS0NCg0KIHNvdW5kL3Nv
Yy9jb2RlY3Mvc2d0bDUwMDAuYyB8IDEgKw0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigr
KQ0KDQpkaWZmIC0tZ2l0IGEvc291bmQvc29jL2NvZGVjcy9zZ3RsNTAwMC5jIGIvc291bmQvc29j
L2NvZGVjcy9zZ3RsNTAwMC5jDQppbmRleCA1ZTQ5NTIzZWUwYjY3Li5iYjU4Yzk5N2M2OTE0IDEw
MDY0NA0KLS0tIGEvc291bmQvc29jL2NvZGVjcy9zZ3RsNTAwMC5jDQorKysgYi9zb3VuZC9zb2Mv
Y29kZWNzL3NndGw1MDAwLmMNCkBAIC01NTYsNiArNTU2LDcgQEAgc3RhdGljIGNvbnN0IHN0cnVj
dCBzbmRfa2NvbnRyb2xfbmV3IHNndGw1MDAwX3NuZF9jb250cm9sc1tdID0gew0KIAkJCVNHVEw1
MDAwX0NISVBfQU5BX0FEQ19DVFJMLA0KIAkJCTgsIDEsIDAsIGNhcHR1cmVfNmRiX2F0dGVudWF0
ZSksDQogCVNPQ19TSU5HTEUoIkNhcHR1cmUgWkMgU3dpdGNoIiwgU0dUTDUwMDBfQ0hJUF9BTkFf
Q1RSTCwgMSwgMSwgMCksDQorCVNPQ19TSU5HTEUoIkNhcHR1cmUgU3dpdGNoIiwgU0dUTDUwMDBf
Q0hJUF9BTkFfQ1RSTCwgMCwgMSwgMSksDQogDQogCVNPQ19ET1VCTEVfVExWKCJIZWFkcGhvbmUg
UGxheWJhY2sgVm9sdW1lIiwNCiAJCQlTR1RMNTAwMF9DSElQX0FOQV9IUF9DVFJMLA0KLS0gDQoy
LjIwLjENCg0K
