From: Viorel Suman <viorel.suman@nxp.com>
Subject: Re: [PATCH v3 0/4] Add NXP AUDMIX device and machine
	drivers
Date: Tue, 22 Jan 2019 11:39:39 +0000
Message-ID: <1548157178.13051.19.camel@nxp.com>
References: <1547729177-14317-1-git-send-email-viorel.suman@nxp.com>
 <20190117161804.GA5760@bogus> <1547817384.11482.33.camel@nxp.com>
 <20190118194642.GA11798@Asurada-Nvidia.nvidia.com>
 <20190121152335.GA12284@bogus>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-eopbgr70077.outbound.protection.outlook.com [40.107.7.77])
 by alsa0.perex.cz (Postfix) with ESMTP id 2B4212667E7
 for <alsa-devel@alsa-project.org>; Tue, 22 Jan 2019 12:39:42 +0100 (CET)
In-Reply-To: <20190121152335.GA12284@bogus>
Content-Language: en-US
Content-ID: <105BF5F48250E64DBF5FAE64C9C627EE@eurprd04.prod.outlook.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "robh@kernel.org" <robh@kernel.org>, "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "timur@kernel.org" <timur@kernel.org>, "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "S.j. Wang" <shengjiu.wang@nxp.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Daniel Baluta <daniel.baluta@nxp.com>, "tiwai@suse.com" <tiwai@suse.com>, "viorel.suman@gmail.com" <viorel.suman@gmail.com>, Fabio Estevam <fabio.estevam@nxp.com>, "broonie@kernel.org" <broonie@kernel.org>, dl-linux-imx <linux-imx@nxp.com>, Cosmin Samoila <cosmin.samoila@nxp.com>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: alsa-devel@alsa-project.org

SGkgUm9iLA0KDQpPbiBMdSwgMjAxOS0wMS0yMSBhdCAwOToyMyAtMDYwMCwgUm9iIEhlcnJpbmcg
d3JvdGU6DQo+IE9uIEZyaSwgSmFuIDE4LCAyMDE5IGF0IDExOjQ2OjQyQU0gLTA4MDAsIE5pY29s
aW4gQ2hlbiB3cm90ZToNCj4gPiANCj4gPiBPbiBGcmksIEphbiAxOCwgMjAxOSBhdCAwMToxNjoy
NFBNICswMDAwLCBWaW9yZWwgU3VtYW4gd3JvdGU6DQo+ID4gPiANCj4gPiA+ID4gDQo+ID4gPiA+
ID4gDQo+ID4gPiA+ID4gMS4gTW92ZWQgImRhaXMiIG5vZGUgZnJvbSBtYWNoaW5lIGRyaXZlciBE
VFMgbm9kZSB0byBkZXZpY2UNCj4gPiA+ID4gPiBkcml2ZXINCj4gPiA+ID4gPiBEVFMgbm9kZQ0K
PiA+ID4gPiA+IMKgIGFzIHN1Z2dlc3RlZCBieSBSb2IuDQo+ID4gPiA+IFRoYXQgd2FzIG5vdCB3
aGF0IEkgc3VnZ2VzdGVkLiBZb3Ugc3RpbGwgaGF2ZSBhIHZpcnR1YWwgbm9kZQ0KPiA+ID4gPiB3
aGljaA0KPiA+ID4gPiBsb29rcyB0byBtZSB0byBiZSB1bm5lY2Vzc2FyeS4NCj4gPiA+IFRvIG1l
IHJlbW92aW5nIHZpcnR1YWwgbm9kZSBpbXBsaWVzIHRoYXQgQVVETUlYIG1hY2hpbmUgZHJpdmVy
DQo+ID4gPiAoaW14LQ0KPiA+ID4gYXVkbWl4LmMgKyB2aXJ0dWFsIG5vZGUpIHNoYWxsIGJlIHJl
bW92ZWQgYW5kIG1hY2hpbmUgZHJpdmVyIGNvZGUNCj4gPiA+IG1lcmdlZCBpbnRvIGRldmljZSBk
cml2ZXIgKGZzbF9hdWRtaXguYyArIGRldmljZSBub2RlKSAtIHBsZWFzZQ0KPiA+ID4gbGV0IG1l
DQo+ID4gPiBrbm93IGlmIG15IHVuZGVyc3RhbmRpbmcgaXMgd3JvbmcuDQo+ID4gV2UgY291bGQg
dXNlIGEgbm9uLURUIGNvbmZpZ3VyYXRpb24gcmlnaHQ/IEZyb20gdGhlIGRyaXZlciBsb2dpYywN
Cj4gPiBEVCBqdXN0IHJlZ2lzdGVycyBhIGRldmljZSBjb3JyZXNwb25kaW5nIHRvIHRoZSBtYWNo
aW5lIGRyaXZlciBzbw0KPiA+IHRoYXQgaXQgY2FuIHByb2JlKCkuIFdlIGNvdWxkIHJlZ2lzdGVy
IG9uZSBpbiBmc2xfYXVkbWl4IGluc3RlYWQuDQo+ID4gUGxlYXNlIHJlZmVyIHRvIGhvdyBmc2xf
c3NpIHJlZ2lzdGVycyB0aGUgc291bmQgY2FyZCBkZXZpY2UuIFRoZQ0KPiA+IG1hY2hpbmUgZHJp
dmVyIGNhbiBnZXQgYXVkbWl4X25wIGZyb20gdGhlIHBhcmVudCBkZXZpY2UgcG9pbnRlciwNCj4g
PiBhbmQgSSB0aGluayB0aGF0J3MgYWxsIHlvdSBuZWVkLg0KPiBZZXMuDQoNClRoYW5rIHlvdSwg
c2VudCBWNCB3aGljaCBpbXBsZW1lbnRzIHRoZSBhcHByb2FjaCBzdWdnZXN0ZWQgYnkgTmljb2xp
bi4NCg0KPiANCj4gPiANCj4gPiBPciBtYXliZSBzb21lb25lIGVsc2Ugd291bGQgcHJvdmlkZSBh
IGJldHRlciB3YXkuIEJ1dCBpdCdkIHdvcmsuDQo+IE9yIHRoZSBtYWNoaW5lIGRyaXZlciBjb3Vs
ZCBjcmVhdGUgdGhlIGF1ZG1peCBkZXZpY2UuIFRoYXQgcHJvYmFibHnCoA0KPiBtYWtlcyBsZXNz
IHNlbnNlLCBidXQgZWl0aGVyIHdheSB0aGVyZSBkb2Vzbid0IGhhdmUgdG8gYmUgYSAxLTHCoA0K
PiBjb3JyZXNwb25kZW5jZSBvZiBEVCBub2RlcyBhbmQgKHBsYXRmb3JtKSBkZXZpY2VzLg0KPiAN
Cj4gSSdtIG5vdCBhbiBBU29DIGV4cGVydCwgYnV0IHdoeSBjYW4ndCB0aGUgbWFjaGluZSBkcml2
ZXIganVzdCBjb250cm9sDQo+IHRoZSBhdWRtaXggZGlyZWN0bHkgKHdpdGggREFJcyBhcyBzZXBh
cmF0ZSBkcml2ZXJzKT8gSXMgdGhlIGF1ZG1peA0KPiBldmVyIGdvaW5nIHRvIGEgYmUgYSBjb21w
b25lbnQgZm9yIGEgZGlmZmVyZW50IG1hY2hpbmUgZHJpdmVyPw0KPiANCj4gUm9iDQoNCkN1cnJl
bnRseSBJJ20gbm90IGF3YXJlIG9mIGFueSBpbmZvcm1hdGlvbiB3aXRoIHJlZ2FyZCB0byBpZiBh
dWRtaXggaXMNCmV2ZXIgZ29pbmcgdG8gd29yayB3aXRoIG90aGVyIERBSXMgdGhhbiBTQUkuIEhv
d2VydmVyIGZyb20gYXVkbWl4IElQDQpibG9jayBpbnRlZ3JhdGlvbiBwZXJzcGVjdGl2ZSB0aGUg
b25seSByZXF1aXJlbWVudCBpcyB0aGF0IHRoZSBpbnB1dA0KREFJIG11c3QgYmUgY29ubmVjdGVk
IHRvIGF1ZG1peCBvdmVyIEkyUyBidXMsIHBvc3NpYmxlIERBSSBvcHRpb25zIGFyZQ0KU0FJLCBF
U0FJLCBldGMgLSBJIHRoaW5rIHRoZSBhcHByb2FjaCB0byBtaXggYm90aCBkZXZpY2UgYW5kIG1h
Y2hpbmUNCmRyaXZlcnMgaW50byBhIHNpbmdsZSBlbnRpdHkgaXMgbm90IHRoZSBiZXN0IHdheSB0
byBnby4NCg0KL1Zpb3JlbApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5v
cmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2Et
ZGV2ZWwK
