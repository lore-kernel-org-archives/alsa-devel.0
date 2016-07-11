From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 6/7] mixer: remove assignment to unused variable
Date: Mon, 11 Jul 2016 21:06:02 +0900
Message-ID: <1468238763-15547-7-git-send-email-o-takashi@sakamocchi.jp>
References: <1468238763-15547-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy001.phy.lolipop.jp (smtp-proxy001.phy.lolipop.jp
 [157.7.104.42]) by alsa0.perex.cz (Postfix) with ESMTP id 5F6E4265B83
 for <alsa-devel@alsa-project.org>; Mon, 11 Jul 2016 14:06:10 +0200 (CEST)
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

VGhpcyBjb21taXQgZml4ZXMgYmVsb3cgY29tcGlsZXIgd2FybmluZ3MuCgpzYmFzZS5jOjMyNzox
Njogd2FybmluZzogdmFyaWFibGUg4oCYdmFsdWVz4oCZIHNldCBidXQgbm90IHVzZWQgWy1XdW51
c2VkLWJ1dC1zZXQtdmFyaWFibGVdCiAgdW5zaWduZWQgbG9uZyB2YWx1ZXM7CiAgICAgICAgICAg
ICAgICBeCgpTaWduZWQtb2ZmLWJ5OiBUYWthc2hpIFNha2Ftb3RvIDxvLXRha2FzaGlAc2FrYW1v
Y2NoaS5qcD4KLS0tCiBtb2R1bGVzL21peGVyL3NpbXBsZS9zYmFzZS5jIHwgMiAtLQogMSBmaWxl
IGNoYW5nZWQsIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvbW9kdWxlcy9taXhlci9zaW1w
bGUvc2Jhc2UuYyBiL21vZHVsZXMvbWl4ZXIvc2ltcGxlL3NiYXNlLmMKaW5kZXggYmIyZjU5ZC4u
Zjk2NzcwMyAxMDA2NDQKLS0tIGEvbW9kdWxlcy9taXhlci9zaW1wbGUvc2Jhc2UuYworKysgYi9t
b2R1bGVzL21peGVyL3NpbXBsZS9zYmFzZS5jCkBAIC0zMjQsNyArMzI0LDYgQEAgc3RhdGljIGlu
dCBzaW1wbGVfZXZlbnRfYWRkMShzbmRfbWl4ZXJfY2xhc3NfdCAqY2xhc3MsCiAJc3RydWN0IHNl
bGVtX2Jhc2UgKnNpbXBsZTsKIAlzdHJ1Y3QgaGVsZW1fYmFzZSAqaHNpbXBsZTsKIAlzbmRfY3Rs
X2VsZW1fdHlwZV90IGN0eXBlOwotCXVuc2lnbmVkIGxvbmcgdmFsdWVzOwogCWxvbmcgbWluLCBt
YXg7CiAJaW50IGVyciwgbmV3ID0gMDsKIAlzdHJ1Y3QgbGlzdF9oZWFkICpwb3M7CkBAIC0zNDks
NyArMzQ4LDYgQEAgc3RhdGljIGludCBzaW1wbGVfZXZlbnRfYWRkMShzbmRfbWl4ZXJfY2xhc3Nf
dCAqY2xhc3MsCiAJaWYgKGVyciA8IDApCiAJCXJldHVybiBlcnI7CiAJY3R5cGUgPSBzbmRfY3Rs
X2VsZW1faW5mb19nZXRfdHlwZShpbmZvKTsKLQl2YWx1ZXMgPSBzbmRfY3RsX2VsZW1faW5mb19n
ZXRfY291bnQoaW5mbyk7CiAJc3dpdGNoIChjdHlwZSkgewogCWNhc2UgU05EX0NUTF9FTEVNX1RZ
UEVfRU5VTUVSQVRFRDoKIAkJbWluID0gMDsKLS0gCjIuNy40CgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNh
LWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
