From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 01/14] ASoC: Intel: Skylake: remove unused 'ret'
Date: Thu,  8 Dec 2016 23:01:24 +0530
Message-ID: <1481218297-17568-2-git-send-email-vinod.koul@intel.com>
References: <1481218297-17568-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by alsa0.perex.cz (Postfix) with ESMTP id 7ACB1267519
 for <alsa-devel@alsa-project.org>; Thu,  8 Dec 2016 18:32:19 +0100 (CET)
In-Reply-To: <1481218297-17568-1-git-send-email-vinod.koul@intel.com>
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
Cc: liam.r.girdwood@linux.intel.com, Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

SW4gc2tsX3RwbGdfbWl4ZXJfZGFwbV9wb3N0X3BtZF9ldmVudCgpLCBhIHZhcmlhYmxlICdyZXQn
IGlzIGluaXRpYWxpemVkIGJ1dApub3QgdXNlZC4KCldlIGRvbid0IGNoZWNrIHJldHVybiBvZiBz
a2xfZGVsZXRlX3BpcGUsIHNvIHJlbW92ZSB0aGUgYXNzaWdubWVudCBhcwp3ZWxsLCBzbyByZW1v
dmUgdGhpcyB2YXJpYWJsZS4KCnNvdW5kL3NvYy9pbnRlbC9za3lsYWtlL3NrbC10b3BvbG9neS5j
OiBJbiBmdW5jdGlvbiDigJhza2xfdHBsZ19taXhlcl9kYXBtX3Bvc3RfcG1kX2V2ZW504oCZOgpz
b3VuZC9zb2MvaW50ZWwvc2t5bGFrZS9za2wtdG9wb2xvZ3kuYzo5NzY6Njogd2FybmluZzogdmFy
aWFibGUg4oCYcmV04oCZIHNldCBidXQgbm90IHVzZWQgWy1XdW51c2VkLWJ1dC1zZXQtdmFyaWFi
bGVdCiAgaW50IHJldCA9IDA7CiAgICAgIF4KU2lnbmVkLW9mZi1ieTogVmlub2QgS291bCA8dmlu
b2Qua291bEBpbnRlbC5jb20+Ci0tLQogc291bmQvc29jL2ludGVsL3NreWxha2Uvc2tsLXRvcG9s
b2d5LmMgfCAzICstLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAyIGRlbGV0aW9u
cygtKQoKZGlmZiAtLWdpdCBhL3NvdW5kL3NvYy9pbnRlbC9za3lsYWtlL3NrbC10b3BvbG9neS5j
IGIvc291bmQvc29jL2ludGVsL3NreWxha2Uvc2tsLXRvcG9sb2d5LmMKaW5kZXggNDM1MjIzNmFm
MjFhLi4wNGZkZGMxMTBkM2YgMTAwNjQ0Ci0tLSBhL3NvdW5kL3NvYy9pbnRlbC9za3lsYWtlL3Nr
bC10b3BvbG9neS5jCisrKyBiL3NvdW5kL3NvYy9pbnRlbC9za3lsYWtlL3NrbC10b3BvbG9neS5j
CkBAIC05NzMsNyArOTczLDYgQEAgc3RhdGljIGludCBza2xfdHBsZ19taXhlcl9kYXBtX3Bvc3Rf
cG1kX2V2ZW50KHN0cnVjdCBzbmRfc29jX2RhcG1fd2lkZ2V0ICp3LAogCXN0cnVjdCBza2xfbW9k
dWxlX2NmZyAqc3JjX21vZHVsZSA9IE5VTEwsICpkc3RfbW9kdWxlOwogCXN0cnVjdCBza2xfc3N0
ICpjdHggPSBza2wtPnNrbF9zc3Q7CiAJc3RydWN0IHNrbF9waXBlICpzX3BpcGUgPSBtY29uZmln
LT5waXBlOwotCWludCByZXQgPSAwOwogCiAJaWYgKHNfcGlwZS0+c3RhdGUgPT0gU0tMX1BJUEVf
SU5WQUxJRCkKIAkJcmV0dXJuIC1FSU5WQUw7CkBAIC05OTUsNyArOTk0LDcgQEAgc3RhdGljIGlu
dCBza2xfdHBsZ19taXhlcl9kYXBtX3Bvc3RfcG1kX2V2ZW50KHN0cnVjdCBzbmRfc29jX2RhcG1f
d2lkZ2V0ICp3LAogCQlzcmNfbW9kdWxlID0gZHN0X21vZHVsZTsKIAl9CiAKLQlyZXQgPSBza2xf
ZGVsZXRlX3BpcGUoY3R4LCBtY29uZmlnLT5waXBlKTsKKwlza2xfZGVsZXRlX3BpcGUoY3R4LCBt
Y29uZmlnLT5waXBlKTsKIAogCXJldHVybiBza2xfdHBsZ191bmxvYWRfcGlwZV9tb2R1bGVzKGN0
eCwgc19waXBlKTsKIH0KLS0gCjEuOS4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2Et
cHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2Fsc2EtZGV2ZWwK
