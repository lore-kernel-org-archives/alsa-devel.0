From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 2/2] ASoC: rt5514: Fix uninitialized
	calibration value
Date: Tue, 30 Jan 2018 14:19:43 +0100
Message-ID: <1517318383-14420-2-git-send-email-geert@linux-m68k.org>
References: <1517318383-14420-1-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [195.130.137.89])
 by alsa0.perex.cz (Postfix) with ESMTP id 7DB62267232
 for <alsa-devel@alsa-project.org>; Tue, 30 Jan 2018 14:19:51 +0100 (CET)
In-Reply-To: <1517318383-14420-1-git-send-email-geert@linux-m68k.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, Arnd Bergmann <arnd@arndb.de>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>
List-Id: alsa-devel@alsa-project.org

V2l0aCBnY2MtNC4xLjIsIGlmIENPTkZJR19TTkRfU09DX1JUNTUxNF9TUEkgaXMgbm90IHNldDoK
CiAgICBzb3VuZC9zb2MvY29kZWNzL3J0NTUxNC5jOiBJbiBmdW5jdGlvbiDigJhydDU1MTRfZHNw
X3ZvaWNlX3dha2VfdXBfcHV04oCZOgogICAgc291bmQvc29jL2NvZGVjcy9ydDU1MTQuYzozNjM6
IHdhcm5pbmc6IOKAmGJ1ZlswXeKAmSBpcyB1c2VkIHVuaW5pdGlhbGl6ZWQgaW4gdGhpcyBmdW5j
dGlvbgogICAgc291bmQvc29jL2NvZGVjcy9ydDU1MTQuYzozNjM6IHdhcm5pbmc6IOKAmGJ1Zlsx
XeKAmSBpcyB1c2VkIHVuaW5pdGlhbGl6ZWQgaW4gdGhpcyBmdW5jdGlvbgogICAgc291bmQvc29j
L2NvZGVjcy9ydDU1MTQuYzozNjM6IHdhcm5pbmc6IOKAmGJ1ZlsyXeKAmSBpcyB1c2VkIHVuaW5p
dGlhbGl6ZWQgaW4gdGhpcyBmdW5jdGlvbgogICAgc291bmQvc29jL2NvZGVjcy9ydDU1MTQuYzoz
NjM6IHdhcm5pbmc6IOKAmGJ1ZlszXeKAmSBpcyB1c2VkIHVuaW5pdGlhbGl6ZWQgaW4gdGhpcyBm
dW5jdGlvbgoKRml4IHRoaXMgYnkgaW5pdGlhbGl6aW5nIHRoZSBidWZmZXIgd2l0aCB6ZXJvZXMs
IHRvIGF2b2lkIHJhbmRvbSBiaXRzCmJlaW5nIHdyaXR0ZW4gdG8gdGhlIGNhbGlicmF0aW9uIHJl
Z2lzdGVyIGxhdGVyLgoKRml4ZXM6IGZjOWNhYjA1ODM3NjM5Y2UgKCJBU29DOiBydDU1MTQ6IFRo
ZSBEU1AgY2xvY2sgY2FuIGJlIGNhbGlicmF0ZWQgYnkgdGhlIG90aGVyIGNsb2NrIHNvdXJjZSIp
ClNpZ25lZC1vZmYtYnk6IEdlZXJ0IFV5dHRlcmhvZXZlbiA8Z2VlcnRAbGludXgtbTY4ay5vcmc+
Ci0tLQogc291bmQvc29jL2NvZGVjcy9ydDU1MTQuYyB8IDEgKwogMSBmaWxlIGNoYW5nZWQsIDEg
aW5zZXJ0aW9uKCspCgpkaWZmIC0tZ2l0IGEvc291bmQvc29jL2NvZGVjcy9ydDU1MTQuYyBiL3Nv
dW5kL3NvYy9jb2RlY3MvcnQ1NTE0LmMKaW5kZXggMTlmMDE1NThmYmNhNjc3Zi4uZTVmZDAxMTRi
MWZkNGQ4NSAxMDA2NDQKLS0tIGEvc291bmQvc29jL2NvZGVjcy9ydDU1MTQuYworKysgYi9zb3Vu
ZC9zb2MvY29kZWNzL3J0NTUxNC5jCkBAIC0zNTgsNiArMzU4LDcgQEAgc3RhdGljIGludCBydDU1
MTRfZHNwX3ZvaWNlX3dha2VfdXBfcHV0KHN0cnVjdCBzbmRfa2NvbnRyb2wgKmtjb250cm9sLAog
I2Vsc2UKIAkJCQlkZXZfZXJyKGNvZGVjLT5kZXYsICJUaGVyZSBpcyBubyBTUEkgZHJpdmVyIGZv
ciIKIAkJCQkJIiBsb2FkaW5nIHRoZSBmaXJtd2FyZVxuIik7CisJCQkJbWVtc2V0KGJ1ZiwgMCwg
c2l6ZW9mKGJ1ZikpOwogI2VuZGlmCiAJCQkJcnQ1NTE0LT5wbGwzX2NhbF92YWx1ZSA9IGJ1Zlsw
XSB8IGJ1ZlsxXSA8PCA4IHwKIAkJCQkJYnVmWzJdIDw8IDE2IHwgYnVmWzNdIDw8IDI0OwotLSAK
Mi43LjQKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkFs
c2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8v
bWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
