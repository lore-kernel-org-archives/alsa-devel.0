From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH v2 1/4] ASoC: acpi: fix machine driver
	selection based on quirk
Date: Fri,  5 Jan 2018 14:55:33 -0600
Message-ID: <20180105205536.10366-2-pierre-louis.bossart@linux.intel.com>
References: <20180105205536.10366-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 8929F267AD3
 for <alsa-devel@alsa-project.org>; Fri,  5 Jan 2018 21:55:46 +0100 (CET)
In-Reply-To: <20180105205536.10366-1-pierre-louis.bossart@linux.intel.com>
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
Cc: liam.r.girdwood@linux.intel.com, tiwai@suse.de, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, jeremy@jcline.org, vinod.koul@intel.com, broonie@kernel.org, andriy.shevchenko@linux.intel.com
List-Id: alsa-devel@alsa-project.org

VGhlIEFDUEkvbWFjaGluZS1kcml2ZXIgY29kZSByZWZhY3RvcmluZyBpbnRyb2R1Y2VkIGluIDQu
MTMgaW50cm9kdWNlZAphIHJlZ3Jlc3Npb24gZm9yIGNhc2VzIHdoZXJlIHdlIG5lZWQgYSBETUkt
YmFzZWQgcXVpcmsgdG8gc2VsZWN0IHRoZQptYWNoaW5lIGRyaXZlciAodGhlIEJJT1MgcmVwb3J0
cyBhbiBpbnZhbGlkIEhJRCkuIFRoZSBmaXggaXMganVzdCB0bwptYWtlIHN1cmUgdGhlIHJlc3Vs
dHMgb2YgdGhlIHF1aXJrIGFyZSBhY3R1YWxseSB1c2VkLgoKRml4ZXM6IDU0NzQ2ZGFiZjc3MCAo
J0FTb0M6IEltcHJvdmUgbWFjaGluZSBkcml2ZXIgc2VsZWN0aW9uIGJhc2VkIG9uIHF1aXJrIGRh
dGEnKQpCdWd6aWxsYTogaHR0cHM6Ly9idWd6aWxsYS5rZXJuZWwub3JnL3Nob3dfYnVnLmNnaT9p
ZD05NjY5MQpUZXN0ZWQtYnk6IE5pY29sZSBGw6ZyYmVyIDxuaWNvbGUuZmFlcmJlckBkcGluLmRl
PgpTaWduZWQtb2ZmLWJ5OiBQaWVycmUtTG91aXMgQm9zc2FydCA8cGllcnJlLWxvdWlzLmJvc3Nh
cnRAbGludXguaW50ZWwuY29tPgotLS0KIHNvdW5kL3NvYy9zb2MtYWNwaS5jIHwgOCArKystLS0t
LQogMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkKCmRpZmYg
LS1naXQgYS9zb3VuZC9zb2Mvc29jLWFjcGkuYyBiL3NvdW5kL3NvYy9zb2MtYWNwaS5jCmluZGV4
IGYyMWRmMjhiYzI4ZS4uZDRkZDJlZmVhNDVlIDEwMDY0NAotLS0gYS9zb3VuZC9zb2Mvc29jLWFj
cGkuYworKysgYi9zb3VuZC9zb2Mvc29jLWFjcGkuYwpAQCAtODQsMTEgKzg0LDkgQEAgc25kX3Nv
Y19hY3BpX2ZpbmRfbWFjaGluZShzdHJ1Y3Qgc25kX3NvY19hY3BpX21hY2ggKm1hY2hpbmVzKQog
CiAJZm9yIChtYWNoID0gbWFjaGluZXM7IG1hY2gtPmlkWzBdOyBtYWNoKyspIHsKIAkJaWYgKHNu
ZF9zb2NfYWNwaV9jaGVja19oaWQobWFjaC0+aWQpID09IHRydWUpIHsKLQkJCWlmIChtYWNoLT5t
YWNoaW5lX3F1aXJrID09IE5VTEwpCi0JCQkJcmV0dXJuIG1hY2g7Ci0KLQkJCWlmIChtYWNoLT5t
YWNoaW5lX3F1aXJrKG1hY2gpICE9IE5VTEwpCi0JCQkJcmV0dXJuIG1hY2g7CisJCQlpZiAobWFj
aC0+bWFjaGluZV9xdWlyaykKKwkJCQltYWNoID0gbWFjaC0+bWFjaGluZV9xdWlyayhtYWNoKTsK
KwkJCXJldHVybiBtYWNoOwogCQl9CiAJfQogCXJldHVybiBOVUxMOwotLSAKMi4xNC4xCgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1h
aWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxz
YS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
