From: Jean-Francois Moine <moinejf@free.fr>
Subject: Re: [PATCH v9 1/4] drm/i2c: tda998x: Add DT support for audio
Date: Tue, 13 Jan 2015 16:54:11 +0100
Message-ID: <20150113165411.5469930d@armhf>
References: <20150109145741.GP12302@n2100.arm.linux.org.uk>
 <20150109183857.53d701a4@armhf>
 <20150109200127.GD12302@n2100.arm.linux.org.uk>
 <1421054728.3081.28.camel@pengutronix.de>
 <20150112122527.GF12302@n2100.arm.linux.org.uk>
 <1421071197.3081.44.camel@pengutronix.de>
 <20150112140456.GI12302@n2100.arm.linux.org.uk>
 <20150112181341.4a53ea24@armhf>
 <20150112175705.GN12302@n2100.arm.linux.org.uk>
 <1421151718.4519.24.camel@pengutronix.de>
 <20150113122715.GP12302@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20150113122715.GP12302@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Andrew Jackson <Andrew.Jackson@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jyri Sarha <jsarha@ti.com>, Mark Brown <broonie@kernel.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
List-Id: alsa-devel@alsa-project.org

T24gVHVlLCAxMyBKYW4gMjAxNSAxMjoyNzoxNSArMDAwMApSdXNzZWxsIEtpbmcgLSBBUk0gTGlu
dXggPGxpbnV4QGFybS5saW51eC5vcmcudWs+IHdyb3RlOgoKPiBPbiBUdWUsIEphbiAxMywgMjAx
NSBhdCAwMToyMTo1OFBNICswMTAwLCBQaGlsaXBwIFphYmVsIHdyb3RlOgo+ID4gSSB3b25kZXIg
aWYgaXQgd291bGRuJ3QgYmUgbmljZXIgdG8gaGF2ZSB0aGUgQVAjIGFuZCB0eXBlIGluIHRoZSBk
ZXZpY2UKPiA+IHRyZWUgYW5kIHRoZW4gY2FsY3VsYXRlIHRoZSByZWdpc3RlciB2YWx1ZSBmcm9t
IHRoYXQgaW4gdGhlIGRyaXZlci4KPiA+IAo+ID4gCXBvcnRAMSB7Cj4gPiAJCXJlZyA9IDwxPjsg
LyogQVAxICovCj4gPiAJCW54cCxhdWRpby1wb3J0ID0gImkycyI7Cj4gPiAJCXRkYTk5OHhfaTJz
OiBlbmRwb2ludCB7Cj4gPiAJCQlyZW1vdGUtZW5kcG9pbnQgPSA8JmF1ZGlvMV9pMnM+Owo+ID4g
CQl9Owo+ID4gCX07Cj4gCj4gV2hhdCBhYm91dCB0aGUgY2FzZSB3aGVyZSB3ZSBoYXZlIDQgSTJT
IHN0cmVhbXMgYmVpbmcgc3VwcGxpZWQgdG8gdGhlCj4gZGV2aWNlIG9uIGZvdXIgc2VwYXJhdGUg
QVAgaW5wdXRzPwoKNCBzdHJlYW1zIG9uIDQgZGlmZmVyZW50IEFQcyAoc291cmNlcykgc2hvdWxk
IHdvcmssIGJ1dCA0IHN0cmVhbXMgZnJvbQphIHNhbWUgc291cmNlIHNob3VsZCBiZSBkZXRhaWxl
ZC4KCkluIGFuIG90aGVyIHdheSwgdGhlIHVuaXQgYWRkcmVzcyAoPT0gZmlyc3QgcmVnKSBkb2Vz
IG5vdCBuZWVkIHRvIGJlIGEKc2VxdWVuY2UgbnVtYmVyLiBJdCBpcyB0aGUgSS9PIGJhc2UgaW4g
bW9zdCBEVHMuClNvLCBpdCBjb3VsZCBiZSB0aGUgcG9ydCB2YWx1ZTogCgoJcG9ydEAyMzAxNDUg
ewoJCXBvcnQtdHlwZSA9ICJyZ2IiOwoJCXJlZyA9IDwweDIzMDE0NT47CgkJaGRtaV8wOiBlbmRw
b2ludCB7CgkJCXJlbW90ZS1lbmRwb2ludCA9IDwmbGNkMF8wPjsKCQl9OwoJfTsKCXBvcnRAMyB7
CQkJLyogQVAxID0gSTJTICovCgkJcG9ydC10eXBlID0gImkycyI7CgkJcmVnID0gPDB4MDM+OwoJ
CXRkYTk5OHhfaTJzOiBlbmRwb2ludCB7CgkJCXJlbW90ZS1lbmRwb2ludCA9IDwmYXVkaW8xX2ky
cz47CgkJfTsKCX07Cglwb3J0QDQgewkJCSAvKiBBUDIgPSBTL1BESUYgKi8KCQlwb3J0LXR5cGUg
PSAic3BkaWYiOwoJCXJlZyA9IDwweDA0PjsKCQl0ZGE5OTh4X3NwZGlmOiBlbmRwb2ludCB7CgkJ
CXJlbW90ZS1lbmRwb2ludCA9IDwmYXVkaW8xX3NwZGlmMT47CgkJfTsKCX07CgotLSAKS2VuIGFy
IGMnaGVudGHDsQl8CSAgICAgICoqIEJyZWl6aCBoYSBMaW51eCBhdGF2ISAqKgpKZWYJCXwJCWh0
dHA6Ly9tb2luZWpmLmZyZWUuZnIvCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmRyaS1kZXZlbCBtYWlsaW5nIGxpc3QKZHJpLWRldmVsQGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZwpodHRwOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8v
ZHJpLWRldmVsCg==
