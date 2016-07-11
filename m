From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 2/7] topology: remove unused variable in
	get_tokens()
Date: Mon, 11 Jul 2016 21:05:58 +0900
Message-ID: <1468238763-15547-3-git-send-email-o-takashi@sakamocchi.jp>
References: <1468238763-15547-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy001.phy.lolipop.jp (smtp-proxy001.phy.lolipop.jp
 [157.7.104.42]) by alsa0.perex.cz (Postfix) with ESMTP id D9840265558
 for <alsa-devel@alsa-project.org>; Mon, 11 Jul 2016 14:06:08 +0200 (CEST)
In-Reply-To: <1468238763-15547-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

VGhpcyBjb21taXQgZml4ZXMgYmVsb3cgY29tcGlsZXIgd2FybmluZ3MuCgpkYXRhLmM6IEluIGZ1
bmN0aW9uIOKAmGdldF90b2tlbnPigJk6CmRhdGEuYzoyNzY6Njogd2FybmluZzogdW51c2VkIHZh
cmlhYmxlIOKAmGVycuKAmSBbLVd1bnVzZWQtdmFyaWFibGVdCiAgaW50IGVyciA9IDA7CiAgICAg
IF4KZGF0YS5jOiBJbiBmdW5jdGlvbiDigJhoYXNfdHVwbGVz4oCZOgpkYXRhLmM6MzAyOjY6IHdh
cm5pbmc6IHVudXNlZCB2YXJpYWJsZSDigJhlcnLigJkgWy1XdW51c2VkLXZhcmlhYmxlXQogIGlu
dCBlcnIgPSAwOwogICAgICBeCgpTaWduZWQtb2ZmLWJ5OiBUYWthc2hpIFNha2Ftb3RvIDxvLXRh
a2FzaGlAc2FrYW1vY2NoaS5qcD4KLS0tCiBzcmMvdG9wb2xvZ3kvZGF0YS5jIHwgMiAtLQogMSBm
aWxlIGNoYW5nZWQsIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvc3JjL3RvcG9sb2d5L2Rh
dGEuYyBiL3NyYy90b3BvbG9neS9kYXRhLmMKaW5kZXggOWY4ZDVkMC4uNGVjZDJjMiAxMDA2NDQK
LS0tIGEvc3JjL3RvcG9sb2d5L2RhdGEuYworKysgYi9zcmMvdG9wb2xvZ3kvZGF0YS5jCkBAIC0y
NzMsNyArMjczLDYgQEAgc3RhdGljIHN0cnVjdCB0cGxnX2VsZW0gKmdldF90b2tlbnMoc25kX3Rw
bGdfdCAqdHBsZywgc3RydWN0IHRwbGdfZWxlbSAqZWxlbSkKIHsKIAlzdHJ1Y3QgdHBsZ19yZWYg
KnJlZjsKIAlzdHJ1Y3QgbGlzdF9oZWFkICpiYXNlLCAqcG9zOwotCWludCBlcnIgPSAwOwogCiAJ
YmFzZSA9ICZlbGVtLT5yZWZfbGlzdDsKIAlsaXN0X2Zvcl9lYWNoKHBvcywgYmFzZSkgewpAQCAt
Mjk5LDcgKzI5OCw2IEBAIHN0YXRpYyBib29sIGhhc190dXBsZXMoc3RydWN0IHRwbGdfZWxlbSAq
ZWxlbSkKIHsKIAlzdHJ1Y3QgdHBsZ19yZWYgKnJlZjsKIAlzdHJ1Y3QgbGlzdF9oZWFkICpiYXNl
LCAqcG9zOwotCWludCBlcnIgPSAwOwogCiAJYmFzZSA9ICZlbGVtLT5yZWZfbGlzdDsKIAlsaXN0
X2Zvcl9lYWNoKHBvcywgYmFzZSkgewotLSAKMi43LjQKCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2
ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxt
YW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
