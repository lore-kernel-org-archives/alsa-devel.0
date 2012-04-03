From: Brian Austin <brian.austin@cirrus.com>
Subject: [PATCH v2] ASoC: core: Initialize err for
	snd_soc_put_volsw_sx
Date: Tue, 3 Apr 2012 11:33:50 -0500
Message-ID: <1333470830-27137-1-git-send-email-brian.austin@cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from db3outboundpool.messaging.microsoft.com
	(db3ehsobe004.messaging.microsoft.com [213.199.154.142])
	by alsa0.perex.cz (Postfix) with ESMTP id EE3C410427D
	for <alsa-devel@alsa-project.org>;
	Tue,  3 Apr 2012 18:34:47 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Brian Austin <brian.austin@cirrus.com>, broonie@opensource.wolfsonmicro.com, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

c291bmQvc29jL3NvYy1jb3JlLmM6IEluIGZ1bmN0aW9uIOKAmHNuZF9zb2NfcHV0X3ZvbHN3X3N4
4oCZOgpzb3VuZC9zb2Mvc29jLWNvcmUuYzoyNjAwOiB3YXJuaW5nOiDigJhlcnLigJkgbWF5IGJl
IHVzZWQgdW5pbml0aWFsaXplZCBpbiB0aGlzIGZ1bmN0aW9uCgpTaWduZWQtb2ZmLWJ5OiBCcmlh
biBBdXN0aW4gPGJyaWFuLmF1c3RpbkBjaXJydXMuY29tPgotLS0KIHNvdW5kL3NvYy9zb2MtY29y
ZS5jIHwgICAgMiArLQogMSBmaWxlcyBjaGFuZ2VkLCAxIGluc2VydGlvbnMoKyksIDEgZGVsZXRp
b25zKC0pCgpkaWZmIC0tZ2l0IGEvc291bmQvc29jL3NvYy1jb3JlLmMgYi9zb3VuZC9zb2Mvc29j
LWNvcmUuYwppbmRleCA3YjFhNGZkLi5hNjkyMmJjIDEwMDY0NAotLS0gYS9zb3VuZC9zb2Mvc29j
LWNvcmUuYworKysgYi9zb3VuZC9zb2Mvc29jLWNvcmUuYwpAQCAtMjU4Niw3ICsyNTg2LDcgQEAg
aW50IHNuZF9zb2NfcHV0X3ZvbHN3X3N4KHN0cnVjdCBzbmRfa2NvbnRyb2wgKmtjb250cm9sLAog
CWludCBtYXggPSBtYy0+bWF4OwogCWludCBtaW4gPSBtYy0+bWluOwogCWludCBtYXNrID0gKDEg
PDwgKGZscyhtaW4gKyBtYXgpIC0gMSkpIC0gMTsKLQlpbnQgZXJyOworCWludCBlcnIgPSAwOwog
CXVuc2lnbmVkIHNob3J0IHZhbCwgdmFsX21hc2ssIHZhbDIgPSAwOwogCiAJdmFsX21hc2sgPSBt
YXNrIDw8IHNoaWZ0OwotLSAKMS43LjkuMQoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxz
YS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlz
dGluZm8vYWxzYS1kZXZlbAo=
