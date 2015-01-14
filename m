From: Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH v9 1/4] drm/i2c: tda998x: Add DT support for audio
Date: Wed, 14 Jan 2015 11:46:58 +0100
Message-ID: <1421232418.3155.31.camel@pengutronix.de>
References: <20150112140456.GI12302@n2100.arm.linux.org.uk>
 <20150112181341.4a53ea24@armhf>
 <20150112175705.GN12302@n2100.arm.linux.org.uk>
 <1421151718.4519.24.camel@pengutronix.de>
 <20150113122715.GP12302@n2100.arm.linux.org.uk>
 <20150113165411.5469930d@armhf>
 <20150113160313.GR12302@n2100.arm.linux.org.uk>
 <20150113200252.3dbfab14@armhf>
 <20150113192648.GU12302@n2100.arm.linux.org.uk> <54B574CD.9020905@ti.com>
 <20150113195415.GV12302@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20150113195415.GV12302@n2100.arm.linux.org.uk>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Andrew Jackson <Andrew.Jackson@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jyri Sarha <jsarha@ti.com>, Mark Brown <broonie@kernel.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
List-Id: alsa-devel@alsa-project.org

SGkgUnVzc2VsbCwKCnRoYW5rcyBmb3IgdGhlIGNsYXJpZmljYXRpb24uIAoKQW0gRGllbnN0YWcs
IGRlbiAxMy4wMS4yMDE1LCAxOTo1NCArMDAwMCBzY2hyaWViIFJ1c3NlbGwgS2luZyAtIEFSTQpM
aW51eDoKWy4uLl0KPiBUbyByZXByZXNlbnQgdGhhdCBpbiBEVCwgSSB3b3VsZCBpbWFnaW5lIHdl
J2QgbmVlZCBzb21ldGhpbmcgbGlrZSB0aGlzOgo+IAo+IAkjYWRkcmVzcy1jZWxscyA9IDwxPjsK
PiAJI3NpemUtY2VsbHMgPSA8MD47Cj4gCS4uLgo+ICAgICAgICAgcG9ydEAxIHsgICAgICAgICAg
ICAgICAgICAgICAgICAvKiBBUDEsMiA9IEkyUyAqLwo+IAkJI2FkZHJlc3MtY2VsbHMgPSA8MT47
Cj4gCQkjc2l6ZS1jZWxscyA9IDwwPjsKPiAgICAgICAgICAgICAgICAgcG9ydC10eXBlID0gImky
cyI7Cj4gICAgICAgICAgICAgICAgIHJlZyA9IDwweDAxPjsJCS8qIFdTICovCj4gICAgICAgICAg
ICAgICAgIHRkYTk5OHhfaTJzMTogZW5kcG9pbnRAMiB7Cj4gCQkJcmVnID0gPDB4MDI+OwkvKiBB
UDEgKi8KPiAgICAgICAgICAgICAgICAgICAgICAgICByZW1vdGUtZW5kcG9pbnQgPSA8JmF1ZGlv
MV9pMnM+Owo+ICAgICAgICAgICAgICAgICB9Owo+ICAgICAgICAgICAgICAgICB0ZGE5OTh4X2ky
czI6IGVuZHBvaW50QDQgewo+IAkJCXJlZyA9IDwweDA0PjsJLyogQVAyICovCj4gICAgICAgICAg
ICAgICAgICAgICAgICAgcmVtb3RlLWVuZHBvaW50ID0gPCZhdWRpbzJfaTJzPjsKPiAgICAgICAg
ICAgICAgICAgfTsKPiAgICAgICAgIH07Cj4KPiB3aGVyZSBhdWRpbzFfaTJzIGlzIG9wZXJhdGlu
ZyBpbiBtYXN0ZXIgbW9kZSwgYW5kIGF1ZGlvMl9pMnMgaXMKPiBvcGVyYXRpbmcgaW4gc2xhdmUg
bW9kZSBmb3IgYm90aCBXUyBhbmQgU0NMSy4KPiAKPiBJZiB3ZSBjYW4gYWdyZWUgb24gdGhhdCwg
dGhlbiBJJ20gaGFwcHkgd2l0aCB0aGUgcHJvcG9zZWQgYmluZGluZy4KPiAoUmVtZW1iZXIgdGhh
dCAjYWRkcmVzcy1jZWxscyBhbmQgI3NpemUtY2VsbHMgYXJlIHJlcXVpcmVkIGluIHRoZQo+IHBh
cmVudCB3aGVyZSB3ZSBoYXZlIHJlZz0gaW4gdGhlIGNoaWxkLikKClNvIHRoZSBxdWVzdGlvbiBp
cyBtb3N0bHkgd2hldGhlciBmb3VyIEkyUyBkYXRhIHBpbnMgd2l0aCBhIHNpbmdsZQpzaGFyZWQg
V1MvU0NLIGlucHV0IHNob3VsZCBiZSBjYWxsZWQgImZvdXIgSTJTIHBvcnRzIHdpdGggc2hhcmVk
IGNsb2NrcyIKb3IgIm9uZSBJMlMgcG9ydCB3aXRoIHVwIHRvIGZvdXIgZGF0YSBsYW5lcyIuIEkn
ZCBsZWFuIHRvd2FyZHMgdGhlCmxhdHRlci4KCkhvdyBhdWRpbzJfaTJzIGlzIGZvcmNlZCB0byBz
eW5jaHJvbml6ZSBpdHMgY2xvY2sgb3V0cHV0IHRvIGF1ZGlvMV9pMnMKaXMgYSBwcm9ibGVtIHRo
ZWlyIGJpbmRpbmdzIHdpbGwgaGF2ZSB0byBoYW5kbGUuCgpyZWdhcmRzClBoaWxpcHAKCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmRyaS1kZXZlbCBtYWls
aW5nIGxpc3QKZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwOi8vbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==
