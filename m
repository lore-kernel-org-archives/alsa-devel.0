From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] ALSA: fm801: Initialize chip after IRQ
	handler is registered
Date: Sun, 16 Jul 2017 21:40:03 +0300
Message-ID: <20170716184003.54877-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 60998266AA1
 for <alsa-devel@alsa-project.org>; Sun, 16 Jul 2017 20:41:09 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, =?UTF-8?q?=C3=89meric=20MASCHINO?= <emeric.maschino@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

VGhlIGNvbW1pdCBiNTZmYTY4N2UwMmIgKCJBTFNBOiBmbTgwMTogZGV0ZWN0IEZNLW9ubHkgY2Fy
ZCBlYXJsaWVyIikKcmVhcnJhbmdlZCBpbml0aWFsaXphdGlvbiBjYWxscywgaS5lLiBpdCBtYWtl
cyBzbmRfZm04MDFfY2hpcF9pbml0KCkgdG8KYmUgY2FsbGVkIGJlZm9yZSB3ZSByZWdpc3RlciBp
bnRlcnJ1cHQgaGFuZGxlciBhbmQgc2V0IFBDSSBidXMKbWFzdGVyaW5nLgoKU29tZWhvdyBpdCBw
cmV2ZW50cyBGTTgwMS1BVSB0byB3b3JrIHByb3Blcmx5LiBUaHVzLCBwYXJ0aWFsbHkgcmV2ZXJ0
CmluaXRpYWxpemF0aW9uIG9yZGVyIGNoYW5nZWQgYnkgY29tbWl0IG1lbnRpb25lZCBhYm92ZS4K
CkZpeGVzOiBiNTZmYTY4N2UwMmIgKCJBTFNBOiBmbTgwMTogZGV0ZWN0IEZNLW9ubHkgY2FyZCBl
YXJsaWVyIikKUmVwb3J0ZWQtYnk6IMOJbWVyaWMgTUFTQ0hJTk8gPGVtZXJpYy5tYXNjaGlub0Bn
bWFpbC5jb20+ClNpZ25lZC1vZmYtYnk6IEFuZHkgU2hldmNoZW5rbyA8YW5kcml5LnNoZXZjaGVu
a29AbGludXguaW50ZWwuY29tPgotLS0KIHNvdW5kL3BjaS9mbTgwMS5jIHwgNCArKy0tCiAxIGZp
bGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBh
L3NvdW5kL3BjaS9mbTgwMS5jIGIvc291bmQvcGNpL2ZtODAxLmMKaW5kZXggMmU0MDJlY2U0Yzg2
Li44ZTZiMDRiMzlkY2MgMTAwNjQ0Ci0tLSBhL3NvdW5kL3BjaS9mbTgwMS5jCisrKyBiL3NvdW5k
L3BjaS9mbTgwMS5jCkBAIC0xMjM1LDggKzEyMzUsNiBAQCBzdGF0aWMgaW50IHNuZF9mbTgwMV9j
cmVhdGUoc3RydWN0IHNuZF9jYXJkICpjYXJkLAogCQl9CiAJfQogCi0Jc25kX2ZtODAxX2NoaXBf
aW5pdChjaGlwKTsKLQogCWlmICgoY2hpcC0+dGVhNTc1eF90dW5lciAmIFRVTkVSX09OTFkpID09
IDApIHsKIAkJaWYgKGRldm1fcmVxdWVzdF9pcnEoJnBjaS0+ZGV2LCBwY2ktPmlycSwgc25kX2Zt
ODAxX2ludGVycnVwdCwKIAkJCQlJUlFGX1NIQVJFRCwgS0JVSUxEX01PRE5BTUUsIGNoaXApKSB7
CkBAIC0xMjQ4LDYgKzEyNDYsOCBAQCBzdGF0aWMgaW50IHNuZF9mbTgwMV9jcmVhdGUoc3RydWN0
IHNuZF9jYXJkICpjYXJkLAogCQlwY2lfc2V0X21hc3RlcihwY2kpOwogCX0KIAorCXNuZF9mbTgw
MV9jaGlwX2luaXQoY2hpcCk7CisKIAlpZiAoKGVyciA9IHNuZF9kZXZpY2VfbmV3KGNhcmQsIFNO
RFJWX0RFVl9MT1dMRVZFTCwgY2hpcCwgJm9wcykpIDwgMCkgewogCQlzbmRfZm04MDFfZnJlZShj
aGlwKTsKIAkJcmV0dXJuIGVycjsKLS0gCjIuMTEuMAoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZl
bEBhbHNhLXByb2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1h
bi9saXN0aW5mby9hbHNhLWRldmVsCg==
