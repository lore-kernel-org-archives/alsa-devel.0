From: "Opensource [Adam Thomson]" <Adam.Thomson.Opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
Subject: RE: [PATCH 4/8] regulator: da9055: Add DT support
Date: Thu, 6 Feb 2014 12:22:13 +0000
Message-ID: <2E89032DDAA8B9408CB92943514A03376B7E36B9@SW-EX-MBX02.diasemi.com>
References: <cover.1391614923.git.Adam.Thomson.Opensource@diasemi.com>
 <6d76ae40cd435eaae0323f3e806515130b06a376.1391614923.git.Adam.Thomson.Opensource@diasemi.com>
 <20140205183642.GH32298@sirena.org.uk>
 <2E89032DDAA8B9408CB92943514A03376B7E1669@SW-EX-MBX02.diasemi.com>
 <20140206120336.GL32298@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140206120336.GL32298-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "Opensource [Adam Thomson]" <Adam.Thomson.Opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
Cc: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org" <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alessandro Zummo <a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

T24gVGh1LCBGZWIgMDYsIDIwMTQgYXQgMTI6MDQ6NTJQTSArMDAwMCwgTWFyayBCcm93biB3cm90
ZToNCg0KPiA+IFVzZWQgYW5vdGhlciBkcml2ZXIgYXMgYW4gZXhhbXBsZSBmb3IgdGhpcywgYnV0
IGlmIHRoZXJlJ3MgYSBiZXR0ZXIgbWV0aG9kDQo+ID4gdGhlbiBJJ20gaGFwcHkgdG8gdXNlIGl0
LiBXaWxsIGhhdmUgYSBsb29rLg0KPiANCj4gVGhhdCdzIHByb2JhYmx5IGFuIG9sZGVyIGRyaXZl
ciAtIHRoZSBjb2RlIHdhcyBmYWN0b3JlZCBvdXQgYXQgc29tZQ0KPiBwb2ludCBidXQgbG90cyBv
ZiBkcml2ZXJzIGRvbid0IGdldCBtdWNoIGxvdmUuDQoNClllcCwgZmFpciBlbm91Z2guIFdpbGwg
c29ydCBpdC4NCg0KPiBXaGF0J3MgaGFwcGVuaW5nIGhlcmUgaXMgdGhhdCB0aGUgTUZEIGZyYW1l
d29yayBoYXMgZG9uZSB0aGUgbG9va3VwIGZvcg0KPiB5b3Ugd2hlbiBwYXNzaW5nIHRoZSBpbnRl
cnJ1cHQgcmVzb3VyY2UgdGhyb3VnaCAtIHlvdSBzaG91bGQganVzdCB1c2UNCj4gcGxhdGZvcm1f
Z2V0X2lycV9ieW5hbWUoKSBhbmQgc2F2ZSBhIGxpdHRsZSBjb2RlIGluIHRoZSBkcml2ZXIuICBJ
ZiBpdCdzDQo+IGJlaGF2aW5nIGRpZmZlcmVudGx5IG9uIERUIGFuZCBub24tRFQgc3lzdGVtcyBp
dCBzZWVtcyBiZXR0ZXIgdG8gZmlndXJlDQo+IG91dCB3aHkgYW5kIHRoZW4gbWFrZSBpdCBjb25z
aXN0ZW50Lg0KDQpJcyB3aGF0IEkgc3VtbWlzZWQgYnV0IEkgb2J2aW91c2x5IGNob3NlIHRoZSB3
cm9uZyBkaXJlY3Rpb24gZm9yIG15IGZpeC4NCldpbGwgdXNlIHBsYXRmb3JtX2dldF9pcnFfYnlu
YW1lKCkgc29sZWx5LCBhbmQgd2lsbCBtYWtlIHN1cmUgYWxsIHdvcmtzIG9uDQpib3RoIERUIGFu
ZCBub24tRFQgc2V0dXBzLiBJZiBub3QgSSdsbCBkaWcgZnVydGhlci4NCg==
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
