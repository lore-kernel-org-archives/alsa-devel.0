From: Viorel Suman <viorel.suman@nxp.com>
Subject: [PATCH 1/2] ASoC: ak4458: rstn_control - return a non-zero on error
 only
Date: Thu, 9 May 2019 13:30:36 +0000
Message-ID: <1557408607-25115-2-git-send-email-viorel.suman@nxp.com>
References: <1557408607-25115-1-git-send-email-viorel.suman@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1557408607-25115-1-git-send-email-viorel.suman@nxp.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Viorel Suman <viorel.suman@nxp.com>, "S.j. Wang" <shengjiu.wang@nxp.com>, Julia Lawall <Julia.Lawall@lip6.fr>, Daniel Baluta <daniel.baluta@nxp.com>, Colin Ian King <colin.king@canonical.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: dl-linux-imx <linux-imx@nxp.com>, Viorel Suman <viorel.suman@gmail.com>
List-Id: alsa-devel@alsa-project.org

c25kX3NvY19jb21wb25lbnRfdXBkYXRlX2JpdHMoKSBtYXkgcmV0dXJuIDEgaWYgb3BlcmF0aW9u
DQp3YXMgc3VjY2Vzc2Z1bCBhbmQgdGhlIHZhbHVlIG9mIHRoZSByZWdpc3RlciBjaGFuZ2VkLg0K
UmV0dXJuIGEgbm9uLXplcm8gaW4gYWs0NDU4X3JzdG5fY29udHJvbCBmb3IgYW4gZXJyb3Igb25s
eS4NCg0KU2lnbmVkLW9mZi1ieTogU2hlbmdqaXUgV2FuZyA8c2hlbmdqaXUud2FuZ0BueHAuY29t
Pg0KU2lnbmVkLW9mZi1ieTogVmlvcmVsIFN1bWFuIDx2aW9yZWwuc3VtYW5AbnhwLmNvbT4NCi0t
LQ0KIHNvdW5kL3NvYy9jb2RlY3MvYWs0NDU4LmMgfCAzICsrLQ0KIDEgZmlsZSBjaGFuZ2VkLCAy
IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCg0KZGlmZiAtLWdpdCBhL3NvdW5kL3NvYy9j
b2RlY3MvYWs0NDU4LmMgYi9zb3VuZC9zb2MvY29kZWNzL2FrNDQ1OC5jDQppbmRleCBlYWI3Yzc2
Li40Nzk1ZTMyIDEwMDY0NA0KLS0tIGEvc291bmQvc29jL2NvZGVjcy9hazQ0NTguYw0KKysrIGIv
c291bmQvc29jL2NvZGVjcy9hazQ0NTguYw0KQEAgLTMwNCw3ICszMDQsOCBAQCBzdGF0aWMgaW50
IGFrNDQ1OF9yc3RuX2NvbnRyb2woc3RydWN0IHNuZF9zb2NfY29tcG9uZW50ICpjb21wb25lbnQs
IGludCBiaXQpDQogCQkJCQkgIEFLNDQ1OF8wMF9DT05UUk9MMSwNCiAJCQkJCSAgQUs0NDU4X1JT
VE5fTUFTSywNCiAJCQkJCSAgMHgwKTsNCi0JcmV0dXJuIHJldDsNCisJLyogUmV0dXJuIGEgbmVn
YXRpdmUgZXJyb3IgY29kZSBvbmx5LiAqLw0KKwlyZXR1cm4gKHJldCA8IDAgPyByZXQgOiAwKTsN
CiB9DQogDQogc3RhdGljIGludCBhazQ0NThfaHdfcGFyYW1zKHN0cnVjdCBzbmRfcGNtX3N1YnN0
cmVhbSAqc3Vic3RyZWFtLA0KLS0gDQoyLjcuNA0KDQo=
