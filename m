From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH] fix the kernel panic due to wrong use the
 dev memory API
Date: Mon, 5 Nov 2018 11:01:38 -0600
Message-ID: <f2e3ffeb-12bd-d60e-e96a-8fa00a17844f@linux.intel.com>
References: <CD6925E8781EFD4D8E11882D20FC406D529FE3B6@SHSMSX104.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by alsa0.perex.cz (Postfix) with ESMTP id 25EAA2678F7
 for <alsa-devel@alsa-project.org>; Mon,  5 Nov 2018 18:01:42 +0100 (CET)
In-Reply-To: <CD6925E8781EFD4D8E11882D20FC406D529FE3B6@SHSMSX104.ccr.corp.intel.com>
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
To: "He, Bo" <bo.he@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "kuninori.morimoto.gx@renesas.com" <kuninori.morimoto.gx@renesas.com>, "Periyasamy, SriramX" <sriramx.periyasamy@intel.com>, "Diwakar,
 Praveen" <praveen.diwakar@intel.com>, "Zhang, Yanmin" <yanmin.zhang@intel.com>, "Singh, Guneshwor O" <guneshwor.o.singh@intel.com>, "tiwai@suse.com" <tiwai@suse.com>, "Prakash,
 Divya1" <divya1.prakash@intel.com>, "liam.r.girdwood@linux.intel.com" <liam.r.girdwood@linux.intel.com>, "guruprasadx.pawse@intel.com" <guruprasadx.pawse@intel.com>, "Ughreja,
 Rakesh A" <rakesh.a.ughreja@intel.com>, "Kesapragada,
 Pardha Saradhi" <pardha.saradhi.kesapragada@intel.com>, "Kale,
 Sanyog R" <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org

Ck9uIDExLzUvMTggMjoyOSBBTSwgSGUsIEJvIHdyb3RlOgo+IHNrbC0+ZGFpcyBpcyBhbGxvY2F0
ZWQgd2l0aCBkZXZtX2tjYWxsb2MsIGNhbid0IGZyZWUgd2l0aAo+IHRoZSBrcmVhbGxvYy4gTWVt
b3J5IGFsbG9jYXRlZCB3aXRoIGRldm0gQVBJIGlzIGF1dG9tYXRpY2FsbHkgZnJlZWQKPiBvbiBk
cml2ZXIgZGV0YWNoLCBMaWtlIGFsbCBvdGhlciBkZXZyZXMgcmVzb3VyY2VzLgo+Cj4gUmVmZXIg
dG8gZHJpdmVycy9iYXNlL2RldnJlcy5jIGRldm1fa21hbGxvYyBmb3IgbW9yZSBkZXRhaWxzLgoK
V2hhdCBjb2RlIGFyZSB5b3UgbG9va2luZyBhdD8KCkkgc2VlIHRoaXMgaW4gdGhlIE1hcmsncyB0
cmVlCgppbnQgc2tsX3BsYXRmb3JtX3JlZ2lzdGVyKHN0cnVjdCBkZXZpY2UgKmRldikKewogwqDC
oMKgIGludCByZXQ7CiDCoMKgwqAgc3RydWN0IHNuZF9zb2NfZGFpX2RyaXZlciAqZGFpczsKIMKg
wqDCoCBpbnQgbnVtX2RhaXMgPSBBUlJBWV9TSVpFKHNrbF9wbGF0Zm9ybV9kYWkpOwogwqDCoMKg
IHN0cnVjdCBoZGFjX2J1cyAqYnVzID0gZGV2X2dldF9kcnZkYXRhKGRldik7CiDCoMKgwqAgc3Ry
dWN0IHNrbCAqc2tsID0gYnVzX3RvX3NrbChidXMpOwoKIMKgwqDCoCBJTklUX0xJU1RfSEVBRCgm
c2tsLT5wcGxfbGlzdCk7CiDCoMKgwqAgSU5JVF9MSVNUX0hFQUQoJnNrbC0+YmluZF9saXN0KTsK
CiDCoMKgwqAgc2tsLT5kYWlzID0ga21lbWR1cChza2xfcGxhdGZvcm1fZGFpLCBzaXplb2Yoc2ts
X3BsYXRmb3JtX2RhaSksCiDCoMKgwqAgwqDCoMKgIMKgwqDCoCDCoMKgwqAgR0ZQX0tFUk5FTCk7
CiDCoMKgwqAgaWYgKCFza2wtPmRhaXMpIHsKIMKgwqDCoCDCoMKgwqAgcmV0ID0gLUVOT01FTTsK
IMKgwqDCoCDCoMKgwqAgZ290byBlcnI7CiDCoMKgwqAgfQoKIMKgwqDCoCBpZiAoIXNrbC0+dXNl
X3RwbGdfcGNtKSB7CiDCoMKgwqAgwqDCoMKgIGRhaXMgPSBrcmVhbGxvYyhza2wtPmRhaXMsIHNp
emVvZihza2xfZmVfZGFpKSArCiDCoMKgwqAgwqDCoMKgIMKgwqDCoCDCoMKgwqAgc2l6ZW9mKHNr
bF9wbGF0Zm9ybV9kYWkpLCBHRlBfS0VSTkVMKTsKCgpObyB0cmFjZSBvZiBkZXZtIGFzIHlvdSBt
ZW50aW9uIGl0PyBJIGNoZWNrZWQgdGhlIENocm9tZSB0cmVlIGFzIHdlbGwgCmFuZCBpdCdzIG5v
dCB0aGVyZS4KCldoYXQgYW0gSSBtaXNzaW5nPwoKCj4KPiBTaWduZWQtb2ZmLWJ5OiBoZSwgYm8g
PGJvLmhlQGludGVsLmNvbT4KPiAtLS0KPiAgIHNvdW5kL3NvYy9pbnRlbC9za3lsYWtlL3NrbC1w
Y20uYyB8IDUgKystLS0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDMgZGVs
ZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvc291bmQvc29jL2ludGVsL3NreWxha2Uvc2tsLXBj
bS5jIGIvc291bmQvc29jL2ludGVsL3NreWxha2Uvc2tsLXBjbS5jCj4gaW5kZXggODIzZTM5MS4u
OTI4ZDMxNCAxMDA2NDQKPiAtLS0gYS9zb3VuZC9zb2MvaW50ZWwvc2t5bGFrZS9za2wtcGNtLmMK
PiArKysgYi9zb3VuZC9zb2MvaW50ZWwvc2t5bGFrZS9za2wtcGNtLmMKPiBAQCAtMTQzOCw3ICsx
NDM4LDggQEAgaW50IHNrbF9wbGF0Zm9ybV9yZWdpc3RlcihzdHJ1Y3QgZGV2aWNlICpkZXYpCj4g
ICAJfQo+ICAgCj4gICAJaWYgKCFza2wtPnVzZV90cGxnX3BjbSkgewo+IC0JCWRhaXMgPSBrcmVh
bGxvYyhza2wtPmRhaXMsIHNpemVvZihza2xfZmVfZGFpKSArCj4gKwkJZGV2bV9rZnJlZShkZXYs
IHNrbC0+ZGFpcyk7Cj4gKwkJZGFpcyA9IGRldm1fa2NhbGxvYyhkZXYsIHNrbC0+ZGFpcywgc2l6
ZW9mKHNrbF9mZV9kYWkpICsKPiAgIAkJCQlzaXplb2Yoc2tsX3BsYXRmb3JtX2RhaSksIEdGUF9L
RVJORUwpOwo+ICAgCQlpZiAoIWRhaXMpIHsKPiAgIAkJCXJldCA9IC1FTk9NRU07Cj4gQEAgLTE0
NzIsNyArMTQ3Myw1IEBAIGludCBza2xfcGxhdGZvcm1fdW5yZWdpc3RlcihzdHJ1Y3QgZGV2aWNl
ICpkZXYpCj4gICAJCX0KPiAgIAl9Cj4gICAKPiAtCWtmcmVlKHNrbC0+ZGFpcyk7Cj4gLQo+ICAg
CXJldHVybiAwOwo+ICAgfQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5v
cmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2Et
ZGV2ZWwK
