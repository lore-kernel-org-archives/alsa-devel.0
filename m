From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 1/3] [PATCH] ASoC: acpi: fix machine driver
 selection based on quirk
Date: Thu, 4 Jan 2018 18:58:17 -0600
Message-ID: <79f098ec-1a98-78d3-872e-22b038e16ac2@linux.intel.com>
References: <20180103170242.5363-1-pierre-louis.bossart@linux.intel.com>
 <20180103170242.5363-2-pierre-louis.bossart@linux.intel.com>
 <1515071329.7000.668.camel@linux.intel.com>
 <dbd1e594-9c6f-2780-2a9d-081214e48dd9@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by alsa0.perex.cz (Postfix) with ESMTP id 0F0FA26799C
 for <alsa-devel@alsa-project.org>; Fri,  5 Jan 2018 01:58:20 +0100 (CET)
In-Reply-To: <dbd1e594-9c6f-2780-2a9d-081214e48dd9@linux.intel.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, alsa-devel@alsa-project.org
Cc: tiwai@suse.de, vinod.koul@intel.com, broonie@kernel.org, jeremy@jcline.org, liam.r.girdwood@linux.intel.com
List-Id: alsa-devel@alsa-project.org

CgpPbiAwMS8wNC8yMDE4IDA5OjE4IEFNLCBQaWVycmUtTG91aXMgQm9zc2FydCB3cm90ZToKPiBP
biAxLzQvMTggNzowOCBBTSwgQW5keSBTaGV2Y2hlbmtvIHdyb3RlOgo+PiBPbiBXZWQsIDIwMTgt
MDEtMDMgYXQgMTE6MDIgLTA2MDAsIFBpZXJyZS1Mb3VpcyBCb3NzYXJ0IHdyb3RlOgo+Pj4gVGhl
IEFDUEkvbWFjaGluZS1kcml2ZXIgY29kZSByZWZhY3RvcmluZyBpbnRyb2R1Y2VkIGluIDQuMTMg
aW50cm9kdWNlZAo+Pj4gYSByZWdyZXNzaW9uIGZvciBjYXNlcyB3aGVyZSB3ZSBuZWVkIGEgRE1J
LWJhc2VkIHF1aXJrIHRvIHNlbGVjdCB0aGUKPj4+IG1hY2hpbmUgZHJpdmVyICh0aGUgQklPUyBy
ZXBvcnRzIGFuIGludmFsaWQgSElEKS4gVGhlIGZpeCBpcyBqdXN0IHRvCj4+PiBtYWtlIHN1cmUg
dGhlIHJlc3VsdHMgb2YgdGhlIHF1aXJrIGFyZSBhY3R1YWxseSB1c2VkLgo+Pj4KPj4KPj4+IMKg
wqDCoMKgwqAgZm9yIChtYWNoID0gbWFjaGluZXM7IG1hY2gtPmlkWzBdOyBtYWNoKyspIHsKPj4+
IMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAoc25kX3NvY19hY3BpX2NoZWNrX2hpZChtYWNoLT5pZCkg
PT0gdHJ1ZSkgewo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKG1hY2gtPm1hY2hp
bmVfcXVpcmsobWFjaCkgIT0gTlVMTCkKPj4KPj4gSnVzdCBhIG5pdDogcGVyaGFwcyB1c2UgbW9y
ZSBuYXR1cmFsIHN0eWxlLCBpLmUuIGRyb3AgIiAhPSBOVUxMIiBwYXJ0Cj4+IG9mZj8KPgo+IG9r
LgpJIGZvdW5kIG91dCB3aGlsZSB0ZXN0aW5nIEFuZHkncyBwYXRjaGVzIHRoYXQgdGhlcmUgd2Fz
IGEgCm1lcmdlL2NvcHktcGFzdGUgbWlzdGFrZSBoZXJlIHdoaWNoIHdhc24ndCBkZXRlY3RlZCBp
biBteSB0ZXN0cyAtIG5vdCAKc3VyZSBob3cuIGl0IHNob3VsZCBiZSAoYXMgaW4gdGhlIGluaXRp
YWwgcGF0Y2ggb24gYnVnemlsbGEpCgppZiAobWFjaC0+bWFjaGluZV9xdWlyaykKIMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBtYWNoID0gbWFjaC0+bWFjaGluZV9xdWlyayhtYWNoKTsK
CldpbGwgZml4IGluIHRoZSBuZXh0IHZlcnNpb24KCj4KPj4KPj4+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgbWFjaCA9IG1hY2gtPm1hY2hpbmVfcXVpcmsobWFjaCk7Cj4+PiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gbWFjaDsKPj4+IMKgwqDCoMKgwqDCoMKgwqDCoCB9
Cj4+PiDCoMKgwqDCoMKgIH0KPj4+IMKgwqDCoMKgwqAgcmV0dXJuIE5VTEw7Cj4+Cj4KPiBfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+IEFsc2EtZGV2ZWwg
bWFpbGluZyBsaXN0Cj4gQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCj4gaHR0cDovL21haWxt
YW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwKCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGlu
ZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNhLXBy
b2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
