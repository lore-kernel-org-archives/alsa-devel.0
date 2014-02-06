From: "Opensource [Adam Thomson]" <Adam.Thomson.Opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
Subject: RE: [PATCH 0/8] da9055: Driver initialisation fixes, add DT support
Date: Thu, 6 Feb 2014 11:46:25 +0000
Message-ID: <2E89032DDAA8B9408CB92943514A03376B7E368A@SW-EX-MBX02.diasemi.com>
References: <cover.1391614923.git.Adam.Thomson.Opensource@diasemi.com>
 <20140206005406.GC1308@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140206005406.GC1308-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, "Opensource [Adam Thomson]" <Adam.Thomson.Opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org" <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alessandro Zummo <a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

T24gVGh1LCBGZWIgMDYsIDIwMTQgYXQgMDA6NTQ6MTFBTSArMDAwMCwgR3VlbnRlciBSb2VjayB3
cm90ZToNCg0KPiBBZGFtLA0KPiANCj4gWW91IGRvbid0IHJlYWxseSBleHBsYWluIHdoYXQgdGhl
IHByb2JsZW0gYWN0dWFsbHkgaXMuIENhbiB5b3UgZWxhYm9yYXRlID8NCg0KU29ycnksIHllcy4g
Rm9yIHRoZSBjb25mbGljdGluZyBkZXZpY2UgSWRzLCBib3RoIHRoZSBQTUlDIGFuZCB0aGUgQ09E
RUMgdXNlZA0KdGhlIHNhbWUgSTJDIElkIHN0cmluZywgd2hpY2ggbWVhbnQgaWYgeW91IHRyaWVk
IHRvIGludGlhdGUgYm90aCB0b2dldGhlciBvbiB0aGUNCnNhbWUgYnVzLCB0aGVuIHRoZSBzZWNv
bmQgd291bGQgZmFpbC4NCg0KRm9yIHRoZSByZW1vdmFsIG9mIHBsYXRmb3JtX2dldF9pcnFfYnlu
YW1lKCksIHRoZSByZWFzb24gZm9yIHRoaXMgd2FzIHRoYXQgaXQNCndhcyBjb25mbGljdGluZyB3
aXRoIHJlZ21hcF9pcnFfZ2V0X3ZpcnEoKSB3aGVuIHRoZSBJUlEgdmFsdWUgcmV0dXJuZWQgZnJv
bQ0KcGxhdGZvcm1fZ2V0X2lycV9ieW5hbWUoKSB3YXMgYmVpbmcgcGFzc2VkIHRvIHJlZ21hcF9p
cnFfZ2V0X3ZpcnEoKS4gVGhlIHJlc3VsdA0KZm9yIHRoZSBjb2RlIHdhcyB0aGF0IGl0IHdvdWxk
IHRyeSB0byByZXF1ZXN0IGEgdGhyZWFkZWQgSVJRIHVzaW5nIGFuIGludmFsaWQNCklSUSBudW1i
ZXIgKGhhdmUgYWxzbyBkZXNjcmliZWQgdGhpcyBmdXJ0aGVyIGluIHBhdGNoIDAwMDQgbWFpbCB0
aHJlYWQsDQpodHRwczovL2xrbWwub3JnL2xrbWwvMjAxNC8yLzYvMTI2KS4NCg0KPiANCj4gQWxz
bywgSSBoYXZlIGJlZW4gdXNpbmcgcGxhdGZvcm1fZ2V0X2lycSgpIHRvIGdldCB0aGUgaW50ZXJy
dXB0IHJlc291cmNlDQo+IGluIG1mZCBjbGllbnQgZHJpdmVycyBhbmQgc2ltaWxhciBzaXR1YXRp
b25zLiBXb3VsZG4ndCB0aGlzIHdvcmsgaGVyZSBhcyB3ZWxsDQo+IGlmIHlvdSBkb24ndCB3YW50
IHRvIHVzZSBwbGF0Zm9ybV9nZXRfaXJxX2J5bmFtZSgpID8NCg0KV2hhdCBJIGNvdWxkJ3ZlIGRv
bmUgaXMgdXNlIHBsYXRmb3JtX2dldF9pcnFfYnluYW1lKCkgYW5kIGF2b2lkZWQgdXNpbmcNCnJl
Z21hcF9pcnFfZ2V0X3ZpcnEoKSBhcyBJIHdvdWxkIGFscmVhZHkgaGF2ZSB0aGUgY29ycmVjdCBW
SVJRIHRvIHBhc3MgdG8NCnJlcXVlc3RfdGhyZWFkZWRfaXJxKCksIGJ1dCBJIGZpZ3VyZWQgdGhh
dCB1c2luZyByZWdtYXBfaXJxX2dldF92aXJxKCkgbWFkZQ0KbW9yZSBzZW5zZSBhdCB0aGUgdGlt
ZSwgYW5kIHdhcyB1bmFibGUgdG8gdXNlIGJvdGguDQo=
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
