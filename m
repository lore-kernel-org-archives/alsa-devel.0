From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 2/7] ASoC: topology: Remove widgets from dobj
	list
Date: Fri, 25 Jan 2019 14:06:43 -0600
Message-ID: <20190125200648.12470-3-pierre-louis.bossart@linux.intel.com>
References: <20190125200648.12470-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id 34DD62666B3
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
PgoKQ3VycmVudGx5IHdoZW4gd2UgdW5sb2FkIGFuZCByZWxvYWQgbWFjaGluZSBkcml2ZXIgZmV3
IHRpbWVzIHdlIGVuZCB3aXRoCmNvcnJ1cHRlZCBsaXN0IGFuZCB0cnkgdG8gY2xlYW51cCBubyBs
b25nZXIgZXhpc3Rpbmcgb2JqZWN0cy4gRml4IHRoaXMKYnkgcmVtb3ZpbmcgZG9iaiBmcm9tIHRo
ZSBsaXN0LgoKU2lnbmVkLW9mZi1ieTogQW1hZGV1c3ogU8WCYXdpxYRza2kgPGFtYWRldXN6eC5z
bGF3aW5za2lAaW50ZWwuY29tPgpTaWduZWQtb2ZmLWJ5OiBQaWVycmUtTG91aXMgQm9zc2FydCA8
cGllcnJlLWxvdWlzLmJvc3NhcnRAbGludXguaW50ZWwuY29tPgotLS0KIHNvdW5kL3NvYy9zb2Mt
dG9wb2xvZ3kuYyB8IDIgKysKIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykKCmRpZmYg
LS1naXQgYS9zb3VuZC9zb2Mvc29jLXRvcG9sb2d5LmMgYi9zb3VuZC9zb2Mvc29jLXRvcG9sb2d5
LmMKaW5kZXggYjAyYzQxNjE0Zjk2Li5hYmMyZDgwNGQ1YmYgMTAwNjQ0Ci0tLSBhL3NvdW5kL3Nv
Yy9zb2MtdG9wb2xvZ3kuYworKysgYi9zb3VuZC9zb2Mvc29jLXRvcG9sb2d5LmMKQEAgLTQ5Myw2
ICs0OTMsOCBAQCBzdGF0aWMgdm9pZCByZW1vdmVfd2lkZ2V0KHN0cnVjdCBzbmRfc29jX2NvbXBv
bmVudCAqY29tcCwKIGZyZWVfbmV3czoKIAlrZnJlZSh3LT5rY29udHJvbF9uZXdzKTsKIAorCWxp
c3RfZGVsKCZkb2JqLT5saXN0KTsKKwogCS8qIHdpZGdldCB3IGlzIGZyZWVkIGJ5IHNvYy1kYXBt
LmMgKi8KIH0KIAotLSAKMi4xNy4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJv
amVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2Fsc2EtZGV2ZWwK
