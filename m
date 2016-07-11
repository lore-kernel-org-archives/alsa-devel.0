From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 1/7] topology: remove unused variable in
	tplg_parse_fe_dai()
Date: Mon, 11 Jul 2016 21:05:57 +0900
Message-ID: <1468238763-15547-2-git-send-email-o-takashi@sakamocchi.jp>
References: <1468238763-15547-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy001.phy.lolipop.jp (smtp-proxy001.phy.lolipop.jp
 [157.7.104.42]) by alsa0.perex.cz (Postfix) with ESMTP id DB75C265AA7
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

VGhpcyBjb21taXQgZml4ZXMgYmVsb3cgY29tcGlsZXIgd2FybmluZ3MuCgpwY20uYzogSW4gZnVu
Y3Rpb24g4oCYdHBsZ19wYXJzZV9mZV9kYWnigJk6CnBjbS5jOjMzMzo2OiB3YXJuaW5nOiB1bnVz
ZWQgdmFyaWFibGUg4oCYZXJy4oCZIFstV3VudXNlZC12YXJpYWJsZV0KICBpbnQgZXJyOwogICAg
ICBeCgpTaWduZWQtb2ZmLWJ5OiBUYWthc2hpIFNha2Ftb3RvIDxvLXRha2FzaGlAc2FrYW1vY2No
aS5qcD4KLS0tCiBzcmMvdG9wb2xvZ3kvcGNtLmMgfCAxIC0KIDEgZmlsZSBjaGFuZ2VkLCAxIGRl
bGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvc3JjL3RvcG9sb2d5L3BjbS5jIGIvc3JjL3RvcG9sb2d5
L3BjbS5jCmluZGV4IGVmZWU1OGIuLjI4MWU2ZWYgMTAwNjQ0Ci0tLSBhL3NyYy90b3BvbG9neS9w
Y20uYworKysgYi9zcmMvdG9wb2xvZ3kvcGNtLmMKQEAgLTMzMCw3ICszMzAsNiBAQCBzdGF0aWMg
aW50IHRwbGdfcGFyc2VfZmVfZGFpKHNuZF90cGxnX3QgKnRwbGcsIHNuZF9jb25maWdfdCAqY2Zn
LAogCXNuZF9jb25maWdfdCAqbjsKIAljb25zdCBjaGFyICppZCwgKnZhbHVlID0gTlVMTDsKIAl1
bnNpZ25lZCBsb25nIGludCBpZF92YWw7Ci0JaW50IGVycjsKIAogCXNuZF9jb25maWdfZ2V0X2lk
KGNmZywgJmlkKTsKIAl0cGxnX2RiZygiXHRcdEZFIERBSSAlczpcbiIsIGlkKTsKLS0gCjIuNy40
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRl
dmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxt
YW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
