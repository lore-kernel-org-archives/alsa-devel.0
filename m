From: Brian Austin <brian.austin@cirrus.com>
Subject: [PATCH] ASoC: core: Initialize err for
	snd_soc_put_volsw_sx
Date: Tue, 3 Apr 2012 10:42:32 -0500
Message-ID: <1333467752-19132-1-git-send-email-brian.austin@cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tx2outboundpool.messaging.microsoft.com
	(tx2ehsobe004.messaging.microsoft.com [65.55.88.14])
	by alsa0.perex.cz (Postfix) with ESMTP id 6123A103B6F
	for <alsa-devel@alsa-project.org>;
	Tue,  3 Apr 2012 17:43:48 +0200 (CEST)
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
IHVzZWQgdW5pbml0aWFsaXplZCBpbiB0aGlzIGZ1bmN0aW9uCgpBY2tlZC1ieTpCcmlhbiBBdXN0
aW4gPGJyaWFuLmF1c3RpbkBjaXJydXMuY29tPgotLS0KIHNvdW5kL3NvYy9zb2MtY29yZS5jIHwg
ICAgMiArLQogMSBmaWxlcyBjaGFuZ2VkLCAxIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb25zKC0p
CgpkaWZmIC0tZ2l0IGEvc291bmQvc29jL3NvYy1jb3JlLmMgYi9zb3VuZC9zb2Mvc29jLWNvcmUu
YwppbmRleCA3YjFhNGZkLi5hNjkyMmJjIDEwMDY0NAotLS0gYS9zb3VuZC9zb2Mvc29jLWNvcmUu
YworKysgYi9zb3VuZC9zb2Mvc29jLWNvcmUuYwpAQCAtMjU4Niw3ICsyNTg2LDcgQEAgaW50IHNu
ZF9zb2NfcHV0X3ZvbHN3X3N4KHN0cnVjdCBzbmRfa2NvbnRyb2wgKmtjb250cm9sLAogCWludCBt
YXggPSBtYy0+bWF4OwogCWludCBtaW4gPSBtYy0+bWluOwogCWludCBtYXNrID0gKDEgPDwgKGZs
cyhtaW4gKyBtYXgpIC0gMSkpIC0gMTsKLQlpbnQgZXJyOworCWludCBlcnIgPSAwOwogCXVuc2ln
bmVkIHNob3J0IHZhbCwgdmFsX21hc2ssIHZhbDIgPSAwOwogCiAJdmFsX21hc2sgPSBtYXNrIDw8
IHNoaWZ0OwotLSAKMS43LjkuMQoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9q
ZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8v
YWxzYS1kZXZlbAo=
