From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 3/7] ASoC: topology: Fix memory leak from
	soc_tplg_denum_create_texts
Date: Fri, 25 Jan 2019 14:06:44 -0600
Message-ID: <20190125200648.12470-4-pierre-louis.bossart@linux.intel.com>
References: <20190125200648.12470-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id BFCF4267350
 for <alsa-devel@alsa-project.org>; Fri, 25 Jan 2019 21:06:59 +0100 (CET)
In-Reply-To: <20190125200648.12470-1-pierre-louis.bossart@linux.intel.com>
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
Cc: tiwai@suse.de, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, broonie@kernel.org, =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= <amadeuszx.slawinski@intel.com>
List-Id: alsa-devel@alsa-project.org

RnJvbTogQW1hZGV1c3ogU8WCYXdpxYRza2kgPGFtYWRldXN6eC5zbGF3aW5za2lAaW50ZWwuY29t
PgoKZHRleHRzIGlzIHR3byBkaW1lbnNpb25hbCBhcnJheSwgc28gd2UgYWxzbyBuZWVkIHRvIGZy
ZWUgaXQgYWZ0ZXIKZnJlZWluZyBpdHMgZmllbGRzLgoKU2lnbmVkLW9mZi1ieTogQW1hZGV1c3og
U8WCYXdpxYRza2kgPGFtYWRldXN6eC5zbGF3aW5za2lAaW50ZWwuY29tPgpTaWduZWQtb2ZmLWJ5
OiBQaWVycmUtTG91aXMgQm9zc2FydCA8cGllcnJlLWxvdWlzLmJvc3NhcnRAbGludXguaW50ZWwu
Y29tPgotLS0KIHNvdW5kL3NvYy9zb2MtdG9wb2xvZ3kuYyB8IDMgKysrCiAxIGZpbGUgY2hhbmdl
ZCwgMyBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvc291bmQvc29jL3NvYy10b3BvbG9neS5j
IGIvc291bmQvc29jL3NvYy10b3BvbG9neS5jCmluZGV4IGFiYzJkODA0ZDViZi4uNzFiYzViOGE5
YmQzIDEwMDY0NAotLS0gYS9zb3VuZC9zb2Mvc29jLXRvcG9sb2d5LmMKKysrIGIvc291bmQvc29j
L3NvYy10b3BvbG9neS5jCkBAIC00MTAsNiArNDEwLDcgQEAgc3RhdGljIHZvaWQgcmVtb3ZlX2Vu
dW0oc3RydWN0IHNuZF9zb2NfY29tcG9uZW50ICpjb21wLAogCWtmcmVlKGRvYmotPmNvbnRyb2wu
ZHZhbHVlcyk7CiAJZm9yIChpID0gMDsgaSA8IHNlLT5pdGVtczsgaSsrKQogCQlrZnJlZShkb2Jq
LT5jb250cm9sLmR0ZXh0c1tpXSk7CisJa2ZyZWUoZG9iai0+Y29udHJvbC5kdGV4dHMpOwogCWtm
cmVlKHNlKTsKIH0KIApAQCAtNDY3LDYgKzQ2OCw3IEBAIHN0YXRpYyB2b2lkIHJlbW92ZV93aWRn
ZXQoc3RydWN0IHNuZF9zb2NfY29tcG9uZW50ICpjb21wLAogCQkJa2ZyZWUoZG9iai0+Y29udHJv
bC5kdmFsdWVzKTsKIAkJCWZvciAoaiA9IDA7IGogPCBzZS0+aXRlbXM7IGorKykKIAkJCQlrZnJl
ZShkb2JqLT5jb250cm9sLmR0ZXh0c1tqXSk7CisJCQlrZnJlZShkb2JqLT5jb250cm9sLmR0ZXh0
cyk7CiAKIAkJCWtmcmVlKHNlKTsKIAkJCWtmcmVlKHctPmtjb250cm9sX25ld3NbaV0ubmFtZSk7
CkBAIC0xMzYxLDYgKzEzNjMsNyBAQCBzdGF0aWMgc3RydWN0IHNuZF9rY29udHJvbF9uZXcgKnNv
Y190cGxnX2RhcG1fd2lkZ2V0X2RlbnVtX2NyZWF0ZSgKIAkJa2ZyZWUoc2UtPmRvYmouY29udHJv
bC5kdmFsdWVzKTsKIAkJZm9yIChqID0gMDsgaiA8IGVjLT5pdGVtczsgaisrKQogCQkJa2ZyZWUo
c2UtPmRvYmouY29udHJvbC5kdGV4dHNbal0pOworCQlrZnJlZShzZS0+ZG9iai5jb250cm9sLmR0
ZXh0cyk7CiAKIAkJa2ZyZWUoc2UpOwogCQlrZnJlZShrY1tpXS5uYW1lKTsKLS0gCjIuMTcuMQoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQWxzYS1kZXZl
bCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFu
LmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
