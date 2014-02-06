From: "Opensource [Adam Thomson]" <Adam.Thomson.Opensource@diasemi.com>
Subject: RE: [PATCH 0/8] da9055: Driver initialisation fixes, add DT support
Date: Thu, 6 Feb 2014 13:31:22 +0000
Message-ID: <2E89032DDAA8B9408CB92943514A03376B7E36D8@SW-EX-MBX02.diasemi.com>
References: <cover.1391614923.git.Adam.Thomson.Opensource@diasemi.com>
 <20140206005406.GC1308@roeck-us.net>
 <2E89032DDAA8B9408CB92943514A03376B7E368A@SW-EX-MBX02.diasemi.com>
 <52F38CA1.8020806@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <52F38CA1.8020806@roeck-us.net>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>, "Opensource [Adam Thomson]" <Adam.Thomson.Opensource@diasemi.com>
Cc: Mark Brown <broonie@kernel.org>, Lee Jones <lee.jones@linaro.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Alessandro Zummo <a.zummo@towertech.it>
List-Id: alsa-devel@alsa-project.org

T24gVGh1LCBGZWIgMDYsIDIwMTQgYXQgMTM6MjM6NDdQTSArMDAwMCwgR3VlbnRlciBSb2VjayB3
cm90ZToNCg0KPiA+IFdoYXQgSSBjb3VsZCd2ZSBkb25lIGlzIHVzZSBwbGF0Zm9ybV9nZXRfaXJx
X2J5bmFtZSgpIGFuZCBhdm9pZGVkIHVzaW5nDQo+ID4gcmVnbWFwX2lycV9nZXRfdmlycSgpIGFz
IEkgd291bGQgYWxyZWFkeSBoYXZlIHRoZSBjb3JyZWN0IFZJUlEgdG8gcGFzcyB0bw0KPiA+IHJl
cXVlc3RfdGhyZWFkZWRfaXJxKCksIGJ1dCBJIGZpZ3VyZWQgdGhhdCB1c2luZyByZWdtYXBfaXJx
X2dldF92aXJxKCkgbWFkZQ0KPiA+IG1vcmUgc2Vuc2UgYXQgdGhlIHRpbWUsIGFuZCB3YXMgdW5h
YmxlIHRvIHVzZSBib3RoLg0KPiA+DQo+IA0KPiBJIG1heSBiZSBtaXNzaW5nIHNvbWV0aGluZywg
YnV0IEkgdGhpbmsgdGhlIHByb2JsZW0gbWF5IGJlIHRoYXQgeW91IGFyZQ0KPiBkb2luZyB0d28g
bWFwcGluZ3MgaW5zdGVhZCBvZiBqdXN0IG9uZS4gSSBkb24ndCB0aGluayB5b3UgbmVlZCB0byBj
YWxsDQo+IHJlZ21hcF9pcnFfZ2V0X3ZpcnEoKSBhdCBhbGwuDQoNClllcywgeW91J3JlIGNvcnJl
Y3QuIFRoZSBpc3N1ZSB3YXMgYWxyZWFkeSB0aGVyZSBpbiB0aGUgY29kZSBhbmQgSSB3YXMNCmF0
dGVtcHRpbmcgdG8gZml4IGl0LiBXaGVuIEkgbWFkZSB0aGUgY2hhbmdlIEkgZmlndXJlZCB1c2lu
ZyBvbmx5DQpyZWdtYXBfaXJxX2dldF92aXJxKCkgd2FzIHRoZSB3YXkgdG8gZ28sIGJ1dCBzZWVt
cyBsaWtlIEkgY2hvc2UgdGhlIHdyb25nDQpvcHRpb24uIFdpbGwgbWFrZSB0aGUgY2hhbmdlcyAo
cmVtb3ZlIHJlZ21hcF9pcnFfZ2V0X3ZpcnEoKSksIHRlc3Qgb24gYm90aCBEVA0KYW5kIG5vbi1E
VCBwbGF0Zm9ybXMsIGFuZCB0aGVuIHdpbGwgcmUtc3VibWl0IHRoZSBwYXRjaGVzLg0K
