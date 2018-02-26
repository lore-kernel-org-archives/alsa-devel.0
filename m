From: Daniel Baluta <daniel.baluta@nxp.com>
Subject: Re: Commit 8f7206d69a ("ASoC: imx-wm8962: Remove
 global variables") looks strange
Date: Mon, 26 Feb 2018 14:51:19 +0000
Message-ID: <1519656678.13463.98.camel@nxp.com>
References: <1519654860.13463.95.camel@nxp.com>
 <CAOMZO5DEF5EW9zu1qxy69x-1GU8rGCVN9iEJpRqLzRxZLEgMrA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01on0089.outbound.protection.outlook.com [104.47.1.89])
 by alsa0.perex.cz (Postfix) with ESMTP id 24F7926757F
 for <alsa-devel@alsa-project.org>; Mon, 26 Feb 2018 15:51:22 +0100 (CET)
In-Reply-To: <CAOMZO5DEF5EW9zu1qxy69x-1GU8rGCVN9iEJpRqLzRxZLEgMrA@mail.gmail.com>
Content-Language: en-US
Content-ID: <6B054C06A526B246B351F1CB88F0BEBF@eurprd04.prod.outlook.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "festevam@gmail.com" <festevam@gmail.com>
Cc: "S.j. Wang" <shengjiu.wang@nxp.com>, Leonard Crestez <leonard.crestez@nxp.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

T24gTHUsIDIwMTgtMDItMjYgYXQgMTE6MzQgLTAzMDAsIEZhYmlvIEVzdGV2YW0gd3JvdGU6DQo+
IEhpIERhbmllbCwNCj4gDQo+IE9uIE1vbiwgRmViIDI2LCAyMDE4IGF0IDExOjIxIEFNLCBEYW5p
ZWwgQmFsdXRhIDxkYW5pZWwuYmFsdXRhQG54cC5jb20+IHdyb3RlOg0KPiA+IA0KPiA+IEhpIEZh
YmlvLA0KPiA+IA0KPiA+IExlb25hcmQgKENjJ2VkKSBub3RpY2VkIHRoYXQgY29tbWl0IGluICRz
dWJqZWN0IGxvb2tzIHZlcnkgc3RyYW5nZS4NCj4gPiANCj4gPiBGb3IgZXhhbXBsZToNCj4gPiAN
Cj4gPiBAQCAtMTM5LDcgKzE0MCw3IEBAIHN0YXRpYyBpbnQgaW14X3dtODk2Ml9sYXRlX3Byb2Jl
KHN0cnVjdCBzbmRfc29jX2NhcmQgKmNhcmQpDQo+ID4gwqB7DQo+ID4gwqDCoMKgwqDCoMKgwqDC
oHN0cnVjdCBzbmRfc29jX3BjbV9ydW50aW1lICpydGQ7DQo+ID4gwqDCoMKgwqDCoMKgwqDCoHN0
cnVjdCBzbmRfc29jX2RhaSAqY29kZWNfZGFpOw0KPiA+IC3CoMKgwqDCoMKgwqDCoHN0cnVjdCBp
bXhfcHJpdiAqcHJpdiA9ICZjYXJkX3ByaXY7DQo+ID4gK8KgwqDCoMKgwqDCoMKgc3RydWN0IGlt
eF9wcml2ICpwcml2ID0gc25kX3NvY19jYXJkX2dldF9kcnZkYXRhKGNhcmQpOw0KPiA+IMKgwqDC
oMKgwqDCoMKgwqBzdHJ1Y3QgaW14X3dtODk2Ml9kYXRhICpkYXRhID0gc25kX3NvY19jYXJkX2dl
dF9kcnZkYXRhKGNhcmQpOw0KPiA+IA0KPiA+IFNvLCBub3cgZGF0YSBhbmQgcHJpdiBwb2ludCB0
byB0aGUgc2FtZSBtZW1vcnkgYXJlYSBidXQgdGhleSBhcmUgY29tcGxldGVseQ0KPiA+IGRpZmZl
cmVudCBzdHJ1Y3R1cmVzIQ0KPiA+IA0KPiA+IFVubGVzcyB3ZSBhcmUgbWlzc2luZyBzb21ldGhp
bmcgdGhpcyBpcyBvYnZpb3VzbHkgYSBidWcuIEkgd2lsbCB0cnkgdG8gaGF2ZSBhIGxvb2sgYXQN
Cj4gPiB0aGUgZW5kIG9mIHRoZSB3ZWVrLCBidXQgYW55IGNvbW1lbnRzIGFyZSB3ZWxjb21lLg0K
PiA+IA0KPiA+IEkgdGhpbmsgdGhlIGZpeCB3b3VsZCBiZSB0byBoYXZlIG9uZSBnbG9iYWwgcHJp
diBzdHJ1Y3R1cmUgYW5kIHRvIHVuaWZ5IGlteF93bTg5NjJfZGF0YQ0KPiA+IHdpdGggaW14X3By
aXYuDQo+IENvdWxkIHlvdSBwbGVhc2UgbG9vayBpbiBtYWlubGluZT8gVGhlIHN0cnVjdHMgd2Vy
ZSByZSBhcnJhbmdlZCB0aGVyZQ0KPiBhbmQgSSBkbyBub3Qgc2VlIHRoaXMgcHJvYmxlbS4NCj4g
DQo+IFBsZWFzZSBjb25maXJtLg0KDQpIbW0sDQoNCkxvb2tpbmcgaW50byBsYXRlc3Q6DQoNCmdp
dDovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9icm9vbmllL3NvdW5k
LmdpdA0KDQpmb3ItbmV4dCBicmFuY2ggYW5kIHRoZSBjb21taXQgaW4gc3ViamVjdCBpcyB0aGUg
bGFzdCBvbiB0aGlzIGZpbGUuDQoNCklzIHRoZXJlIGFueSBvdGhlciBtb3JlIHVwZGF0ZWQgdHJl
ZS9icmFuY2g/IENhbiB5b3UgcG9pbnQgdGhlIGNvbW1pdCBoYXNoIHRoYXQgZGlkIHRoZSByZS1h
cnJhbmdlbWVudC4NCg0KRGFuaWVsLgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJv
amVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2Fsc2EtZGV2ZWwK
