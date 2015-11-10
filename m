From: "Opensource [Adam Thomson]" <Adam.Thomson.Opensource@diasemi.com>
Subject: RE: [PATCH 2/2] ASoC: codecs: Add da7218 codec driver
Date: Tue, 10 Nov 2015 14:24:13 +0000
Message-ID: <2E89032DDAA8B9408CB92943514A0337D460CED5@SW-EX-MBX01.diasemi.com>
References: <20151105152736.GO18409@sirena.org.uk>
 <2E89032DDAA8B9408CB92943514A0337D460CA0C@SW-EX-MBX01.diasemi.com>
 <20151106112141.GE18409@sirena.org.uk>
 <2E89032DDAA8B9408CB92943514A0337D460CA3D@SW-EX-MBX01.diasemi.com>
 <20151106115451.GG18409@sirena.org.uk>
 <2E89032DDAA8B9408CB92943514A0337D460CAAD@SW-EX-MBX01.diasemi.com>
 <20151108103429.GC6746@sirena.org.uk>
 <2E89032DDAA8B9408CB92943514A0337D460CC6C@SW-EX-MBX01.diasemi.com>
 <20151109140225.GA26072@sirena.org.uk>
 <2E89032DDAA8B9408CB92943514A0337D460CEA5@SW-EX-MBX01.diasemi.com>
 <20151110141513.GF12392@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151110141513.GF12392@sirena.org.uk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, "Opensource [Adam Thomson]" <Adam.Thomson.Opensource@diasemi.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Support Opensource <Support.Opensource@diasemi.com>
List-Id: alsa-devel@alsa-project.org

T24gTm92ZW1iZXIgMTAsIDIwMTUgMTQ6MTUsIE1hcmsgQnJvd24gd3JvdGU6DQoNCj4gPiA+IFRo
ZSBnZW5lcmFsIHVzZXJzcGFjZSBleHBlY3RhdGlvbiBpcyB0aGF0IHRoZSBkZXRlY3Rpb24gaXMg
YWx3YXlzIGFjdGl2ZQ0KPiA+ID4gYW5kIGNvbnNpc3RlbnQgcmF0aGVyIHRoYW4gdmFyeWluZyBh
dCBydW50aW1lIC0gcnVudGltZSB2YXJpYWJpbGl0eQ0KPiA+ID4gbWlnaHQgYmUgYSBiaXQgc3Vy
cHJpc2luZyBmb3IgaXQsIGFuZCBldmVuIHRoZW4gdmFyaWFiaWxpdHkgaW4gd2hhdCBpcw0KPiA+
ID4gZGV0ZWN0ZWQgYmFzZWQgb24gb3RoZXIgc2V0dGluZ3MgaXMgYSBiaXQgc3VycHJpc2luZy4g
IElmIHRoZSBoYXJkd2FyZQ0KPiA+ID4gaXMgdGhhdCBsaW1pdGVkIEkgZ3Vlc3MgaXQncyBhYm91
dCBhbGwgdGhhdCBjYW4gYmUgZG9uZSBidXQgSSdtIHN0aWxsDQo+ID4gPiBub3QgY2xlYXIgd2hh
dCB0aGUgdXNlIGNhc2VzIGFyZSBmb3IgY29uZmlndXJpbmcgdGhlIGxldmVscyAoYXMgb3Bwb3Nl
ZA0KPiA+ID4gb3QgdGhlIHJvdXRpbmcpLg0KPiANCj4gPiBIb3cgYWJvdXQgdGhlIGV4YW1wbGUg
b2YgYWx3YXlzIG9uIHZvaWNlIGluIEFuZHJvaWQsIHdoaWNoIGNhbiBiZSBlbmFibGVkIGFuZA0K
PiA+IGRpc2FibGVkLCBkZXBlbmRpbmcgb24gdXNlciBzZXR0aW5ncywgYW5kIHJvdXRpbmcgd2ls
bCB2YXJ5IGRlcGVuZGluZyBvbiB3aGljaA0KPiA+IG1pYyBpcyBpbiB1c2UgYXQgdGhlIHRpbWU/
IEZvciB0aGUgbGV2ZWxsaW5nIGlzIGl0IG5vdCBwbGF1c2libGUgdGhhdCBhIHVzZXINCj4gPiBj
b3VsZCBjb25maWd1cmUgdGhlIGxldmVsIGJhc2VkIG9uIHRoZWlyIGN1cnJlbnQgZW52aXJvbm1l
bnQuIFlvdSBoYXZlDQo+ID4gbW9kZXJhdGVseSBsb3VkIGJhY2tncm91bmQgbm9pc2UsIHRoZW4g
eW91ciB0aHJlc2hvbGQgd291bGQgd2FudCB0byBiZQ0KPiA+IGhpZ2hlciwgYnV0IGluIGEgcXVp
ZXQgZW52aXJvbm1lbnQgdGhlIGxpa2VsaWhvb2QgaXMgeW91IHdvdWxkIHdhbnQgdG8gbG93ZXIN
Cj4gPiB0aGF0IHRocmVzaG9sZD8NCj4gDQo+IFNvIHRoaXMgKmlzbid0KiBhIG5vcm1hbCBtaWMg
ZGV0ZWN0aW9uIGZlYXR1cmU/ICBXaGF0J3MgdGhlIHVzZXJzcGFjZQ0KPiBpbnRlcmZhY2UgZm9y
IHJlcG9ydGluZyB0aGVuPw0KDQpCeSBtaWMgZGV0ZWN0aW9uIHlvdSB0aG91Z2h0IHRoaXMgd2Fz
IHRvIGRldGVjdCBpZiBhIG1pYyB3YXMgcHJlc2VudCBvciBub3Q/DQpJdCdzIHRvIGRldGVjdCB0
aGUgbm9pc2UgbGV2ZWwgb24gYSBtaWMgYW5kIHJhaXNlIGFuIGV2ZW50IGlmIHRoZSBjYXB0dXJl
ZA0Kc291bmQgaXMgYWJvdmUgYSBzcGVjaWZpYyB0aHJlc2hvbGQgbGV2ZWwuIEFwb2xvZ2llcyBp
ZiB0aGF0IHdhc24ndCBjbGVhci4NCg0KSW4gdGhlIGRyaXZlciBjb2RlIEknbSB1c2luZyBLRVlf
Vk9JQ0VDT01NQU5ELCBhbmQgc2ltdWxhdGluZyBhIHByZXNzIGFuZA0KcmVsZWFzZSBvZiB0aGlz
IGtleSwgdG8gaW5kaWNhdGUgdG8gdXNlci1zcGFjZS4gVGhpcyBzZWVtZWQgbGlrZSB0aGUgb2J2
aW91cw0KY2hvaWNlIGZvciB0aGlzIGZlYXR1cmUgdG8gbWUsIGFsdGhvdWdoIEknZCBoYXBwaWx5
IGdldCB5b3VyIG9waW5pb24gb24gdGhpcy4NCg==
