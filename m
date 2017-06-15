From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 0/3] ASoC: rt5677: Move platform code to
 where it belongs
Date: Thu, 15 Jun 2017 15:49:10 +0300
Message-ID: <1497530950.22624.143.camel@linux.intel.com>
References: <20170615124638.65971-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 3FB9B2673CE
 for <alsa-devel@alsa-project.org>; Thu, 15 Jun 2017 14:50:44 +0200 (CEST)
In-Reply-To: <20170615124638.65971-1-andriy.shevchenko@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, John Keeping <john@metanate.com>
List-Id: alsa-devel@alsa-project.org

T24gVGh1LCAyMDE3LTA2LTE1IGF0IDE1OjQ2ICswMzAwLCBBbmR5IFNoZXZjaGVua28gd3JvdGU6
Cj4gVGhlcmUgYXJlIGZldyBpc3N1ZXMgd2l0aCBjdXJyZW50IGFwcHJvYWNoOgo+IC0gQUNQSSBl
bnVtZXJhdGlvbiBzaG91bGQgYmUgZG9uZSBieSBJRHMsIGFuZCBub3QgYnkgaW5zdGFuY2VzCj4g
LSBQbGF0Zm9ybSBjb2RlIHdpdGggYm9hcmQgcmVsYXRlZCBzdHVmZiBzaG91bGQgcmVzaWRlIGlu
Cj4gY29ycmVzcG9uZGluZyBtb2R1bGUKPiAKPiBGaXggdGhvc2UgaXNzdWVzIGhlcmUuCgpDaGFu
Z2Vsb2cgdjI6Ci0gYXNzaWduIEdQSU8gQUNQSSB0YWJsZSB0byBjb3JyZWN0IGRldmljZSBpbiBw
YXRjaCAyCgo+IAo+IEFuZHkgU2hldmNoZW5rbyAoMyk6Cj4gwqAgQVNvQzogcnQ1Njc3OiBJbnRy
b2R1Y2UgcHJvcGVyIHRhYmxlIGZvciBBQ1BJIGVudW1lcmF0aW9uCj4gwqAgQVNvQzogcnQ1Njc3
OiBNb3ZlIHBsYXRmb3JtIGNvZGUgdG8gYm9hcmQgZmlsZQo+IMKgIEFTb0M6IEludGVsOiBiZHct
cnQ1Njc3OiBTd2l0Y2ggdG8gZGV2bV9hY3BpX2Rldl9hZGRfZHJpdmVyX2dwaW9zKCkKPiAKPiDC
oHNvdW5kL3NvYy9jb2RlY3MvcnQ1Njc3LmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgfCAzMiArKysr
KysrLS0tLS0tLS0tLS0tLS0tLS0tLS0tCj4gLS0tLQo+IMKgc291bmQvc29jL2ludGVsL2JvYXJk
cy9iZHctcnQ1Njc3LmMgfCAyNiArKysrKysrKysrKysrKysrKysrKysrKysrKwo+IMKgMiBmaWxl
cyBjaGFuZ2VkLCAzMyBpbnNlcnRpb25zKCspLCAyNSBkZWxldGlvbnMoLSkKPiAKCi0tIApBbmR5
IFNoZXZjaGVua28gPGFuZHJpeS5zaGV2Y2hlbmtvQGxpbnV4LmludGVsLmNvbT4KSW50ZWwgRmlu
bGFuZCBPeQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpB
bHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDov
L21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
