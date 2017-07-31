From: srinivas.kandagatla@linaro.org
Subject: [PATCH v2 2/2] drm/bridge: adv7511: restrict audio sample sizes
Date: Tue,  1 Aug 2017 00:49:44 +0200
Message-ID: <20170731224944.9986-3-srinivas.kandagatla@linaro.org>
References: <20170731224944.9986-1-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20170731224944.9986-1-srinivas.kandagatla@linaro.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Jyri Sarha <jsarha@ti.com>, Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, dri-devel@lists.freedesktop.org, Takashi Iwai <tiwai@suse.com>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Jaroslav Kysela <perex@perex.cz>
List-Id: alsa-devel@alsa-project.org

RnJvbTogU3Jpbml2YXMgS2FuZGFnYXRsYSA8c3Jpbml2YXMua2FuZGFnYXRsYUBsaW5hcm8ub3Jn
PgoKQURWNzUzMyBvbmx5IHN1cHBvcnRzIGF1ZGlvIHNhbXBsZXMgd29yZCB3aWR0aCBmcm9tIDE2
LTI0IGJpdHMuClRoaXMgcGF0Y2ggcmVzdHJpY3RzIHRoZSBhdWRpbyBzYW1wbGUgc2l6ZXMgdG8g
dGhlIHN1cHBvcnRlZCBvbmVzLApzbyB0aGF0IHNvdW5kIGNhcmQgZG9lcyBub3QgcmVwb3J0IHdy
b25nIGxpc3Qgb2Ygc3VwcG9ydGVkIGh3cGFybXMuCgpXaXRob3V0IHRoaXMgcGF0Y2ggYXBsYXkg
d291bGQgZmFpbCB3aGVuIHBsYXlpbmcgYSAzMiBiaXQgYXVkaW8uCgpTaWduZWQtb2ZmLWJ5OiBT
cmluaXZhcyBLYW5kYWdhdGxhIDxzcmluaXZhcy5rYW5kYWdhdGxhQGxpbmFyby5vcmc+Ci0tLQog
ZHJpdmVycy9ncHUvZHJtL2JyaWRnZS9hZHY3NTExL2Fkdjc1MTFfYXVkaW8uYyB8IDIgKysKIDEg
ZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9k
cm0vYnJpZGdlL2Fkdjc1MTEvYWR2NzUxMV9hdWRpby5jIGIvZHJpdmVycy9ncHUvZHJtL2JyaWRn
ZS9hZHY3NTExL2Fkdjc1MTFfYXVkaW8uYwppbmRleCA2NzQ2OWMyNmJhZTguLmQwMWQwYWEwZWVm
NyAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2JyaWRnZS9hZHY3NTExL2Fkdjc1MTFfYXVk
aW8uYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYnJpZGdlL2Fkdjc1MTEvYWR2NzUxMV9hdWRpby5j
CkBAIC0yMTQsNiArMjE0LDggQEAgc3RhdGljIHN0cnVjdCBoZG1pX2NvZGVjX3BkYXRhIGNvZGVj
X2RhdGEgPSB7CiAJLm9wcyA9ICZhZHY3NTExX2NvZGVjX29wcywKIAkubWF4X2kyc19jaGFubmVs
cyA9IDIsCiAJLmkycyA9IDEsCisJLmZvcm1hdHMgPSAoU05EUlZfUENNX0ZNVEJJVF9TMTZfTEUg
fCBTTkRSVl9QQ01fRk1UQklUX1MxNl9CRSB8CisJCSAgICBTTkRSVl9QQ01fRk1UQklUX1MyNF9M
RSB8IFNORFJWX1BDTV9GTVRCSVRfUzI0X0JFKSwKIH07CiAKIGludCBhZHY3NTExX2F1ZGlvX2lu
aXQoc3RydWN0IGRldmljZSAqZGV2LCBzdHJ1Y3QgYWR2NzUxMSAqYWR2NzUxMSkKLS0gCjIuMTEu
MAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRl
dmVsIG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8v
bGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==
