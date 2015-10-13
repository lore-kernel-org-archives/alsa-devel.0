From: "Jie, Yang" <yang.jie@intel.com>
Subject: Re: [PATCH v3 2/2] ASoC: soc-compress: split
 soc-compress to a module
Date: Tue, 13 Oct 2015 12:42:11 +0000
Message-ID: <E7B1D079BA13FB44A978CC8F69C7D6A9229C5CB0@SHSMSX101.ccr.corp.intel.com>
References: <1444727464-10385-1-git-send-email-yang.jie@intel.com>
 <1444727464-10385-3-git-send-email-yang.jie@intel.com>
 <1444736994.2926.9.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id AAD32261A3B
 for <alsa-devel@alsa-project.org>; Tue, 13 Oct 2015 14:42:27 +0200 (CEST)
In-Reply-To: <1444736994.2926.9.camel@intel.com>
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
To: "Koul, Vinod" <vinod.koul@intel.com>, "broonie@kernel.org" <broonie@kernel.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Girdwood,
 Liam R" <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLb3VsLCBWaW5vZA0KPiBTZW50
OiBUdWVzZGF5LCBPY3RvYmVyIDEzLCAyMDE1IDc6NTAgUE0NCj4gVG86IEppZSwgWWFuZzsgYnJv
b25pZUBrZXJuZWwub3JnDQo+IENjOiBHaXJkd29vZCwgTGlhbSBSOyBhbHNhLWRldmVsQGFsc2Et
cHJvamVjdC5vcmcNCj4gU3ViamVjdDogUmU6IFthbHNhLWRldmVsXSBbUEFUQ0ggdjMgMi8yXSBB
U29DOiBzb2MtY29tcHJlc3M6IHNwbGl0IHNvYy0NCj4gY29tcHJlc3MgdG8gYSBtb2R1bGUNCj4g
DQo+IE9uIFR1ZSwgMjAxNS0xMC0xMyBhdCAxNzoxMSArMDgwMCwgSmllIFlhbmcgd3JvdGU6DQo+
ID4gKy8qIE1vZHVsZSBpbmZvcm1hdGlvbiAqLw0KPiA+ICtNT0RVTEVfQVVUSE9SKCJOYW1hcnRh
IEtvaGxpIDxuYW1hcnRheC5rb2hsaUBpbnRlbC5jb20+Iik7DQo+ID4gK01PRFVMRV9BVVRIT1Io
IlJhbWVzaCBCYWJ1IEsgViA8cmFtZXNoLmJhYnVAbGludXguaW50ZWwuY29tPiIpOw0KPiA+ICtN
T0RVTEVfQVVUSE9SKCJWaW5vZCBLb3VsIDx2aW5vZC5rb3VsQGxpbnV4LmludGVsLmNvbT4iKTsN
Cj4gDQo+IFZpbm9kIEtvdWwgPHZpbm9kLmtvdWxAaW50ZWwuY29tPiBwbGVhc2UNCj4gDQoNCk9L
LCBJIHdpbGwgY2hhbmdlIHRoaXMgb25lLiANCg0KPiBJIG5lZWQgdG8gbW92ZSBvdGhlciBpbnN0
YW5jZXMgdG9vIDooDQo+IA0KPiANCj4gPiArTU9EVUxFX0RFU0NSSVBUSU9OKCJBTFNBIFNvQyBD
b21wcmVzcyIpOw0KPiBNT0RVTEVfTElDRU5TRSgiR1BMIik7DQo+ID4gK01PRFVMRV9BTElBUygi
cGxhdGZvcm06c29jLWNvbXByZXNzIik7DQo+ID4gZGlmZiAtLWdpdCBhL3NvdW5kL3NvYy9zb2Mt
ZGFwbS5jIGIvc291bmQvc29jL3NvYy1kYXBtLmMgaW5kZXgNCj4gPiBmZjhiZGE0Li45ZTMyMTUx
IDEwMDY0NA0KPiA+IC0tLSBhL3NvdW5kL3NvYy9zb2MtZGFwbS5jDQo+ID4gKysrIGIvc291bmQv
c29jL3NvYy1kYXBtLmMNCj4gPiBAQCAtMzg5Niw2ICszODk2LDcgQEAgdm9pZCBzbmRfc29jX2Rh
cG1fc3RyZWFtX2V2ZW50KHN0cnVjdA0KPiA+IHNuZF9zb2NfcGNtX3J1bnRpbWUgKnJ0ZCwgaW50
IHN0cmVhbSwNCj4gPiAgCXNvY19kYXBtX3N0cmVhbV9ldmVudChydGQsIHN0cmVhbSwgZXZlbnQp
Ow0KPiA+ICAJbXV0ZXhfdW5sb2NrKCZjYXJkLT5kYXBtX211dGV4KTsNCj4gPiAgfQ0KPiA+ICtF
WFBPUlRfU1lNQk9MX0dQTChzbmRfc29jX2RhcG1fc3RyZWFtX2V2ZW50KTsNCj4gDQo+IFRoZXNl
IGV4cG9ydHMgc2hvdWxkIGJlIGEgbmV3IHBhdGNoDQo+IA0KPiBBbmQgYXMgd2UgYWdyZWVkIHRo
aXMgc2hvdWxkIGhhdmUgRG9jdW1lbnRhdGlvbiBpZiBub3QgYWxyZWFkeSBkb25lIDopDQoNCkl0
J3Mgbm90IHdoYXQgSSByZWFsbHkgd2FudCB0byBkbywgaXQgaW50cm9kdWNlIDEzIGV4cG9ydHMN
CihFWFBPUlRfU1lNQk9MX0dQTCkgd2hlbiB3ZSB3YW50IHNwbGl0IHNvYy1jb21wcmVzcy5jIHRv
IGEgc2VwYXJhdGUNCk1vZHVsZSwgYW5kIGFkZGluZyBkb2N1bWVudGF0aW9uIHRvIGFsbCBvZiB0
aGVzZSAxMyBmdW5jdGlvbnMob25seSBmb3INCnNvYy1jb21wcmVzcy5jIHRvIHVzZSB0aGVtKSBs
b29rcyBzb21ld2hhdCB1bmdyYWNlZnVsIDooDQoNCkhpIFRha2FzaGksIHdoYXQncyB5b3VyIG9w
aW5pb24/IE1heWJlIHdlIHNob3VsZCBrZWVwIHNvYy1jb21wcmVzcy5jDQppbiBzbmQtc29jLWNv
cmUua28sIHdoaWNoIG1lYW5zIHNraXAvaWdub3JlIHRoaXMgcGF0Y2ggYW5kIGRvbuKAmXQgc3Bs
aXQgaXQ/DQoNCn5LZXlvbg0KPiANCj4gLS0NCj4gflZpbm9kDQpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNh
LWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
