From: =?UTF-8?Q?=C3=89meric_MASCHINO?= <emeric.maschino@gmail.com>
Subject: Re: [PATCH v1] ALSA: fm801: Initialize chip after IRQ
	handler is registered
Date: Mon, 17 Jul 2017 21:20:55 +0200
Message-ID: <CAA9xbM43nE=Y4RrGwkpchHG8Xho6Tn1fG35Cws2fixE21vHzdg@mail.gmail.com>
References: <20170716184003.54877-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f194.google.com (mail-yw0-f194.google.com
 [209.85.161.194])
 by alsa0.perex.cz (Postfix) with ESMTP id C4410266BA4
 for <alsa-devel@alsa-project.org>; Mon, 17 Jul 2017 21:20:57 +0200 (CEST)
Received: by mail-yw0-f194.google.com with SMTP id l21so7532864ywb.3
 for <alsa-devel@alsa-project.org>; Mon, 17 Jul 2017 12:20:57 -0700 (PDT)
In-Reply-To: <20170716184003.54877-1-andriy.shevchenko@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>
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
a29AbGludXguaW50ZWwuY29tPgpUZXN0ZWQtYnk6IMOJbWVyaWMgTUFTQ0hJTk8gPGVtZXJpYy5t
YXNjaGlub0BnbWFpbC5jb20+Ci0tLQogc291bmQvcGNpL2ZtODAxLmMgfCA0ICsrLS0KIDEgZmls
ZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEv
c291bmQvcGNpL2ZtODAxLmMgYi9zb3VuZC9wY2kvZm04MDEuYwppbmRleCAyZTQwMmVjZTRjODYu
LjhlNmIwNGIzOWRjYyAxMDA2NDQKLS0tIGEvc291bmQvcGNpL2ZtODAxLmMKKysrIGIvc291bmQv
cGNpL2ZtODAxLmMKQEAgLTEyMzUsOCArMTIzNSw2IEBAIHN0YXRpYyBpbnQgc25kX2ZtODAxX2Ny
ZWF0ZShzdHJ1Y3Qgc25kX2NhcmQgKmNhcmQsCiAgICAgICAgICAgICAgICB9CiAgICAgICAgfQoK
LSAgICAgICBzbmRfZm04MDFfY2hpcF9pbml0KGNoaXApOwotCiAgICAgICAgaWYgKChjaGlwLT50
ZWE1NzV4X3R1bmVyICYgVFVORVJfT05MWSkgPT0gMCkgewogICAgICAgICAgICAgICAgaWYgKGRl
dm1fcmVxdWVzdF9pcnEoJnBjaS0+ZGV2LCBwY2ktPmlycSwgc25kX2ZtODAxX2ludGVycnVwdCwK
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBJUlFGX1NIQVJFRCwgS0JVSUxEX01PRE5B
TUUsIGNoaXApKSB7CkBAIC0xMjQ4LDYgKzEyNDYsOCBAQCBzdGF0aWMgaW50IHNuZF9mbTgwMV9j
cmVhdGUoc3RydWN0IHNuZF9jYXJkICpjYXJkLAogICAgICAgICAgICAgICAgcGNpX3NldF9tYXN0
ZXIocGNpKTsKICAgICAgICB9CgorICAgICAgIHNuZF9mbTgwMV9jaGlwX2luaXQoY2hpcCk7CisK
ICAgICAgICBpZiAoKGVyciA9IHNuZF9kZXZpY2VfbmV3KGNhcmQsIFNORFJWX0RFVl9MT1dMRVZF
TCwgY2hpcCwgJm9wcykpIDwgMCkgewogICAgICAgICAgICAgICAgc25kX2ZtODAxX2ZyZWUoY2hp
cCk7CiAgICAgICAgICAgICAgICByZXR1cm4gZXJyOwotLQoyLjExLjAKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QK
QWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5v
cmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
