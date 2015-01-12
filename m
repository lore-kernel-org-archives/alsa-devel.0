From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v9 1/4] drm/i2c: tda998x: Add DT support for audio
Date: Mon, 12 Jan 2015 14:04:56 +0000
Message-ID: <20150112140456.GI12302@n2100.arm.linux.org.uk>
References: <20150109114529.GH12302@n2100.arm.linux.org.uk>
 <20150109135401.5b270d46@armhf>
 <20150109130725.GN12302@n2100.arm.linux.org.uk>
 <54AFDE8D.3000504@arm.com>
 <20150109145741.GP12302@n2100.arm.linux.org.uk>
 <20150109183857.53d701a4@armhf>
 <20150109200127.GD12302@n2100.arm.linux.org.uk>
 <1421054728.3081.28.camel@pengutronix.de>
 <20150112122527.GF12302@n2100.arm.linux.org.uk>
 <1421071197.3081.44.camel@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <1421071197.3081.44.camel@pengutronix.de>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Andrew Jackson <Andrew.Jackson@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jyri Sarha <jsarha@ti.com>, Mark Brown <broonie@kernel.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
List-Id: alsa-devel@alsa-project.org

T24gTW9uLCBKYW4gMTIsIDIwMTUgYXQgMDI6NTk6NTdQTSArMDEwMCwgUGhpbGlwcCBaYWJlbCB3
cm90ZToKPiBBbSBNb250YWcsIGRlbiAxMi4wMS4yMDE1LCAxMjoyNSArMDAwMCBzY2hyaWViIFJ1
c3NlbGwgS2luZyAtIEFSTSBMaW51eDoKPiA+IEl0J3Mgbm90IHF1aXRlIHRoYXQgc2ltcGxlLCBi
ZWNhdXNlIHRoZSBTUERJRiBBUCBwaW5zIGFyZSBtdWx0aXBsZXhlZAo+ID4gd2l0aCB0aGUgSTJT
IHBpbnMgLSBhbmQgdGhlcmUgaXMgdmFyaWF0aW9uIGJldHdlZW4gY2hpcCBtb2RlbHMgYW5kCj4g
PiBwYWNrYWdlcy4KPiA+Cj4gPiBTbywgaXQncyBwcm9iYWJseSBiZXN0IGlmIHBvcnRAMCBpcyB0
aGUgdmlkZW8gcG9ydCwgYW5kIHRoZW4gcG9ydEAxLi5uCj4gPiBjYW4gZGVzY3JpYmUgdGhlIGF1
ZGlvIGlucHV0cywgaW5jbHVkaW5nIGEgcHJvcGVydHkgd2hpY2ggc3BlY2lmaWVzCj4gPiB3aGV0
aGVyIHRoZXkgYXJlIEkyUyBvciBTUERJRiwgYW5kIHRoZSB2YWx1ZSB0byBiZSBwcm9ncmFtbWVk
IGludG8KPiA+IHRoZSBBUCBlbmFibGUgcmVnaXN0ZXIgKHdoaWNoIGlzIGEgYml0IGZpZWxkIG9m
IHRoZSBBUCBwaW5zIHdoaWNoCj4gPiBzaG91bGQgYmUgdW5tYXNrZWQuKSAgSSBndWVzcyB3ZSBj
YW4gcmUtdXNlIHRoZSByZWc9IHByb3BlcnR5IGZvciB0aGF0Cj4gPiB2YWx1ZSwgc2luY2Ugdmlk
ZW8gd2lsbCBhbHdheXMgYmUgemVyby4KPiAKPiBOb3RlIHRoYXQgb2ZfZ3JhcGhfcGFyc2VfZW5k
cG9pbnQgaW50ZXJwcmV0cyB0aGUgcG9ydCBub2RlJ3MgcmVnCj4gcHJvcGVydHkgYXMgcG9ydCBp
ZC4gQW5kIHRoZSB1bml0IGFkZHJlc3MgcGFydCBvZiB0aGUgbm9kZSBuYW1lIHNob3VsZAo+IG1h
dGNoIHRoZSBmaXJzdCBhZGRyZXNzIGluIHRoZSByZWcgcHJvcGVydHkuCgpTbyB0aGF0J3Mgbm90
IGdvaW5nIHRvIHdvcmsgdmVyeSB3ZWxsLi4uIGJlY2F1c2UgdGhlIEFQIHJlZ2lzdGVyIGlzIGEK
Yml0bWFzay4KCkkgZ3Vlc3Mgd2UgY291bGQgc3BlY2lmeSBhIG5vZGUgdW5pdCBhbmQgcmVnLCB3
aGljaCB0aGUgY29kZSBvdGhlcndpc2UKaWdub3JlcywgYW5kIHNwZWNpZnkgYSBwaGlsaXBwcyxh
cC1tYXNrID0gcHJvcGVydHkgZm9yIHRoZSBhdWRpbyBwb3J0cwppbnN0ZWFkLgoKLS0gCkZUVEMg
YnJvYWRiYW5kIGZvciAwLjhtaWxlIGxpbmU6IGN1cnJlbnRseSBhdCAxMC41TWJwcyBkb3duIDQw
MGticHMgdXAKYWNjb3JkaW5nIHRvIHNwZWVkdGVzdC5uZXQuCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmRyaS1kZXZlbCBtYWlsaW5nIGxpc3QKZHJpLWRl
dmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21h
aWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==
