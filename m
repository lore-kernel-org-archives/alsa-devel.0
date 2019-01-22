From: Viorel Suman <viorel.suman@nxp.com>
Subject: Re: [PATCH v3 0/4] Add NXP AUDMIX device and machine drivers
Date: Tue, 22 Jan 2019 11:19:36 +0000
Message-ID: <1548155976.13051.2.camel@nxp.com>
References: <1547729177-14317-1-git-send-email-viorel.suman@nxp.com>
         <20190117161804.GA5760@bogus> <1547817384.11482.33.camel@nxp.com>
         <20190118194642.GA11798@Asurada-Nvidia.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190118194642.GA11798@Asurada-Nvidia.nvidia.com>
Content-Language: en-US
Content-ID: <DFCA4B8C8F29DB4A830D39B318FDA373@eurprd04.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>
Cc: dl-linux-imx <linux-imx@nxp.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Cosmin Samoila <cosmin.samoila@nxp.com>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "timur@kernel.org" <timur@kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>, "viorel.suman@gmail.com" <viorel.suman@gmail.com>, Fabio Estevam <fabio.estevam@nxp.com>, "broonie@kernel.org" <broonie@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "tiwai@suse.com" <tiwai@suse.com>, "robh@kernel.org" <robh@kernel.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "S.j. Wang" <shengjiu.wang@nxp.com>, Daniel Baluta <daniel.baluta@nxp.com>, "perex@perex.cz" <perex@perex.cz>, alsa-
List-Id: alsa-devel@alsa-project.org

SGkgTmljb2xpbiwNCg0KT24gVmksIDIwMTktMDEtMTggYXQgMTE6NDYgLTA4MDAsIE5pY29saW4g
Q2hlbiB3cm90ZToNCj4gT24gRnJpLCBKYW4gMTgsIDIwMTkgYXQgMDE6MTY6MjRQTSArMDAwMCwg
VmlvcmVsIFN1bWFuIHdyb3RlOg0KPiA+IA0KPiA+ID4gDQo+ID4gPiA+IA0KPiA+ID4gPiAxLiBN
b3ZlZCAiZGFpcyIgbm9kZSBmcm9tIG1hY2hpbmUgZHJpdmVyIERUUyBub2RlIHRvIGRldmljZQ0K
PiA+ID4gPiBkcml2ZXINCj4gPiA+ID4gRFRTIG5vZGUNCj4gPiA+ID4gwqAgYXMgc3VnZ2VzdGVk
IGJ5IFJvYi4NCj4gPiA+IFRoYXQgd2FzIG5vdCB3aGF0IEkgc3VnZ2VzdGVkLiBZb3Ugc3RpbGwg
aGF2ZSBhIHZpcnR1YWwgbm9kZQ0KPiA+ID4gd2hpY2gNCj4gPiA+IGxvb2tzIHRvIG1lIHRvIGJl
IHVubmVjZXNzYXJ5Lg0KPiA+IFRvIG1lIHJlbW92aW5nIHZpcnR1YWwgbm9kZSBpbXBsaWVzIHRo
YXQgQVVETUlYIG1hY2hpbmUgZHJpdmVyDQo+ID4gKGlteC0NCj4gPiBhdWRtaXguYyArIHZpcnR1
YWwgbm9kZSkgc2hhbGwgYmUgcmVtb3ZlZCBhbmQgbWFjaGluZSBkcml2ZXIgY29kZQ0KPiA+IG1l
cmdlZCBpbnRvIGRldmljZSBkcml2ZXIgKGZzbF9hdWRtaXguYyArIGRldmljZSBub2RlKSAtIHBs
ZWFzZSBsZXQNCj4gPiBtZQ0KPiA+IGtub3cgaWYgbXkgdW5kZXJzdGFuZGluZyBpcyB3cm9uZy4N
Cj4gV2UgY291bGQgdXNlIGEgbm9uLURUIGNvbmZpZ3VyYXRpb24gcmlnaHQ/IEZyb20gdGhlIGRy
aXZlciBsb2dpYywNCj4gRFQganVzdCByZWdpc3RlcnMgYSBkZXZpY2UgY29ycmVzcG9uZGluZyB0
byB0aGUgbWFjaGluZSBkcml2ZXIgc28NCj4gdGhhdCBpdCBjYW4gcHJvYmUoKS4gV2UgY291bGQg
cmVnaXN0ZXIgb25lIGluIGZzbF9hdWRtaXggaW5zdGVhZC4NCj4gUGxlYXNlIHJlZmVyIHRvIGhv
dyBmc2xfc3NpIHJlZ2lzdGVycyB0aGUgc291bmQgY2FyZCBkZXZpY2UuIFRoZQ0KPiBtYWNoaW5l
IGRyaXZlciBjYW4gZ2V0IGF1ZG1peF9ucCBmcm9tIHRoZSBwYXJlbnQgZGV2aWNlIHBvaW50ZXIs
DQo+IGFuZCBJIHRoaW5rIHRoYXQncyBhbGwgeW91IG5lZWQuDQo+IA0KPiBPciBtYXliZSBzb21l
b25lIGVsc2Ugd291bGQgcHJvdmlkZSBhIGJldHRlciB3YXkuIEJ1dCBpdCdkIHdvcmsuDQoNClNl
bnQgVjQgLSBpdCBpbXBsZW1lbnRzIHRoZSBhcHByb2FjaCB5b3Ugc3VnZ2VzdGVkLiBUaGFuayB5
b3UgZm9yIHRoZQ0KaGludCwgd29ya3Mgd2VsbCBpbmRlZWQuDQoNClJlZ2FyZHMsDQpWaW9yZWwN
Cg0K
