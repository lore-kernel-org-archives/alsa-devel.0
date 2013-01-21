From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 1/5] ASoC: tegra_wm9712: Remove __devinitconst
	attribute
Date: Mon, 21 Jan 2013 14:59:22 +0530
Message-ID: <1358760566-3803-2-git-send-email-sachin.kamat@linaro.org>
References: <1358760566-3803-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pb0-f45.google.com (mail-pb0-f45.google.com
 [209.85.160.45])
 by alsa0.perex.cz (Postfix) with ESMTP id 0CDF4261735
 for <alsa-devel@alsa-project.org>; Mon, 21 Jan 2013 10:38:14 +0100 (CET)
Received: by mail-pb0-f45.google.com with SMTP id mc8so3227712pbc.32
 for <alsa-devel@alsa-project.org>; Mon, 21 Jan 2013 01:38:14 -0800 (PST)
In-Reply-To: <1358760566-3803-1-git-send-email-sachin.kamat@linaro.org>
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
Cc: Lucas Stach <dev@lynxeye.de>, sachin.kamat@linaro.org, broonie@opensource.wolfsonmicro.com, lgirdwood@gmail.com, tiwai@suse.de, swarren@nvidia.com
List-Id: alsa-devel@alsa-project.org

VGhpcyBoYXMgYmVlbiByZW1vdmVkIGZyb20gdGhlIGtlcm5lbCByZWNlbnRseSBhbmQgZ2l2ZXMg
Zm9sbG93aW5nIGJ1aWxkIGVycm9yczoKc291bmQvc29jL3RlZ3JhL3RlZ3JhX3dtOTcxMi5jOjE1
NTo1ODogZXJyb3I6CmV4cGVjdGVkIOKAmD3igJksIOKAmCzigJksIOKAmDvigJksIOKAmGFzbeKA
mSBvciDigJhfX2F0dHJpYnV0ZV9f4oCZIGJlZm9yZSDigJhfX2RldmluaXRjb25zdOKAmQpzb3Vu
ZC9zb2MvdGVncmEvdGVncmFfd205NzEyLmM6MTY1OjIxOiBlcnJvcjoK4oCYdGVncmFfd205NzEy
X29mX21hdGNo4oCZIHVuZGVjbGFyZWQgaGVyZSAobm90IGluIGEgZnVuY3Rpb24pCgpDYzogTHVj
YXMgU3RhY2ggPGRldkBseW54ZXllLmRlPgpTaWduZWQtb2ZmLWJ5OiBTYWNoaW4gS2FtYXQgPHNh
Y2hpbi5rYW1hdEBsaW5hcm8ub3JnPgotLS0KIHNvdW5kL3NvYy90ZWdyYS90ZWdyYV93bTk3MTIu
YyB8ICAgIDIgKy0KIDEgZmlsZXMgY2hhbmdlZCwgMSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9u
cygtKQoKZGlmZiAtLWdpdCBhL3NvdW5kL3NvYy90ZWdyYS90ZWdyYV93bTk3MTIuYyBiL3NvdW5k
L3NvYy90ZWdyYS90ZWdyYV93bTk3MTIuYwppbmRleCBjZGJkMmYwLi42OGQ0MjQwIDEwMDY0NAot
LS0gYS9zb3VuZC9zb2MvdGVncmEvdGVncmFfd205NzEyLmMKKysrIGIvc291bmQvc29jL3RlZ3Jh
L3RlZ3JhX3dtOTcxMi5jCkBAIC0xNTIsNyArMTUyLDcgQEAgc3RhdGljIGludCB0ZWdyYV93bTk3
MTJfZHJpdmVyX3JlbW92ZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQogCXJldHVybiAw
OwogfQogCi1zdGF0aWMgY29uc3Qgc3RydWN0IG9mX2RldmljZV9pZCB0ZWdyYV93bTk3MTJfb2Zf
bWF0Y2hbXSBfX2RldmluaXRjb25zdCA9IHsKK3N0YXRpYyBjb25zdCBzdHJ1Y3Qgb2ZfZGV2aWNl
X2lkIHRlZ3JhX3dtOTcxMl9vZl9tYXRjaFtdID0gewogCXsgLmNvbXBhdGlibGUgPSAibnZpZGlh
LHRlZ3JhLWF1ZGlvLXdtOTcxMiIsIH0sCiAJe30sCiB9OwotLSAKMS43LjQuMQoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5n
IGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJv
amVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
