From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 1/4] ASoC: tegra_wm9712: Remove __devinitconst
	attribute
Date: Thu, 24 Jan 2013 14:51:15 +0530
Message-ID: <1359019278-1199-2-git-send-email-sachin.kamat@linaro.org>
References: <1359019278-1199-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pb0-f48.google.com (mail-pb0-f48.google.com
 [209.85.160.48])
 by alsa0.perex.cz (Postfix) with ESMTP id 2ABC52615D0
 for <alsa-devel@alsa-project.org>; Thu, 24 Jan 2013 10:30:16 +0100 (CET)
Received: by mail-pb0-f48.google.com with SMTP id wy12so3945869pbc.21
 for <alsa-devel@alsa-project.org>; Thu, 24 Jan 2013 01:30:16 -0800 (PST)
In-Reply-To: <1359019278-1199-1-git-send-email-sachin.kamat@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Lucas Stach <dev@lynxeye.de>, tiwai@suse.de, broonie@opensource.wolfsonmicro.com, lgirdwood@gmail.com, sachin.kamat@linaro.org, swarren@nvidia.com
List-Id: alsa-devel@alsa-project.org

VGhpcyBoYXMgYmVlbiByZW1vdmVkIGZyb20gdGhlIGtlcm5lbCByZWNlbnRseSBhbmQgZ2l2ZXMg
Zm9sbG93aW5nIGJ1aWxkIGVycm9yczoKc291bmQvc29jL3RlZ3JhL3RlZ3JhX3dtOTcxMi5jOjE1
NTo1ODogZXJyb3I6CmV4cGVjdGVkIOKAmD3igJksIOKAmCzigJksIOKAmDvigJksIOKAmGFzbeKA
mSBvciDigJhfX2F0dHJpYnV0ZV9f4oCZIGJlZm9yZSDigJhfX2RldmluaXRjb25zdOKAmQpzb3Vu
ZC9zb2MvdGVncmEvdGVncmFfd205NzEyLmM6MTY1OjIxOiBlcnJvcjoK4oCYdGVncmFfd205NzEy
X29mX21hdGNo4oCZIHVuZGVjbGFyZWQgaGVyZSAobm90IGluIGEgZnVuY3Rpb24pCgpDYzogTHVj
YXMgU3RhY2ggPGRldkBseW54ZXllLmRlPgpTaWduZWQtb2ZmLWJ5OiBTYWNoaW4gS2FtYXQgPHNh
Y2hpbi5rYW1hdEBsaW5hcm8ub3JnPgpSZXZpZXdlZC1ieTogU3RlcGhlbiBXYXJyZW4gPHN3YXJy
ZW5AbnZpZGlhLmNvbT4KLS0tCiBzb3VuZC9zb2MvdGVncmEvdGVncmFfd205NzEyLmMgfCAgICAy
ICstCiAxIGZpbGVzIGNoYW5nZWQsIDEgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbnMoLSkKCmRp
ZmYgLS1naXQgYS9zb3VuZC9zb2MvdGVncmEvdGVncmFfd205NzEyLmMgYi9zb3VuZC9zb2MvdGVn
cmEvdGVncmFfd205NzEyLmMKaW5kZXggY2RiZDJmMC4uNjhkNDI0MCAxMDA2NDQKLS0tIGEvc291
bmQvc29jL3RlZ3JhL3RlZ3JhX3dtOTcxMi5jCisrKyBiL3NvdW5kL3NvYy90ZWdyYS90ZWdyYV93
bTk3MTIuYwpAQCAtMTUyLDcgKzE1Miw3IEBAIHN0YXRpYyBpbnQgdGVncmFfd205NzEyX2RyaXZl
cl9yZW1vdmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikKIAlyZXR1cm4gMDsKIH0KIAot
c3RhdGljIGNvbnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQgdGVncmFfd205NzEyX29mX21hdGNoW10g
X19kZXZpbml0Y29uc3QgPSB7CitzdGF0aWMgY29uc3Qgc3RydWN0IG9mX2RldmljZV9pZCB0ZWdy
YV93bTk3MTJfb2ZfbWF0Y2hbXSA9IHsKIAl7IC5jb21wYXRpYmxlID0gIm52aWRpYSx0ZWdyYS1h
dWRpby13bTk3MTIiLCB9LAogCXt9LAogfTsKLS0gCjEuNy40LjEKCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFs
c2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3Jn
L21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
