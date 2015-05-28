From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH 13/13] drm: bridge/dw_hdmi-ahb-audio: parse ELD from HDMI
 driver
Date: Thu, 28 May 2015 08:43:13 +0200
Message-ID: <20150528064313.GR8341@phenom.ffwll.local>
References: <20150509102501.GO2067@n2100.arm.linux.org.uk>
 <E1Yr1yD-0006lK-RC@rmk-PC.arm.linux.org.uk>
 <20150527104308.GA8341@phenom.ffwll.local>
 <20150527173125.GS2067@n2100.arm.linux.org.uk>
 <CAKMK7uFgqyHR4b+Q=_55S2Ojt-9+B-BRM4pKCRNwbRZ7kskpfA@mail.gmail.com>
 <20150527214439.GW2067@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <20150527214439.GW2067@n2100.arm.linux.org.uk>
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, dri-devel <dri-devel@lists.freedesktop.org>, Jaroslav Kysela <perex@perex.cz>, Mark Brown <broonie@kernel.org>, Yakir Yang <ykk@rock-chips.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

T24gV2VkLCBNYXkgMjcsIDIwMTUgYXQgMTA6NDQ6NDBQTSArMDEwMCwgUnVzc2VsbCBLaW5nIC0g
QVJNIExpbnV4IHdyb3RlOgo+IE9uIFdlZCwgTWF5IDI3LCAyMDE1IGF0IDExOjI5OjUyUE0gKzAy
MDAsIERhbmllbCBWZXR0ZXIgd3JvdGU6Cj4gPiBUaGUgb25seSBpc3N1ZSB0aGF0IG1pZ2h0IGJl
Cj4gPiB0aGVyZSB3aXRoIHlvdXIgc3cgYXBwcm9hY2ggaXMgdGhhdCBhIGNvbmN1cnJlbnQgcHJv
YmUvaG90cGx1ZyBpbiBkcm0KPiA+IG1pZ2h0IGZyZWUgdGhlIGVkaWQgYW5kIGhlbmNlIHRoZSBl
bGQsIHdoaWxlIHRoZSBzbmQgc2lkZSBpcyB0cnlpbmcgdG8KPiA+IGNvcHkgdGhhdC4KPiAKPiBU
YWxraW5nIG9ubHkgYWJvdXQgdGhlIHBhcnRpY3VsYXIgY2FzZSBvZiBkdy1oZG1pLWFoYi1hdWRp
by4uLgo+IAo+IFRoZSB3b3JzdCB0aGF0IG1heSBoYXBwZW4gaXMgdGhhdCB0aGUgRUxEIHdpbGwg
YmUgb3ZlcndyaXR0ZW4gd2l0aCBhbgo+IHVwZGF0ZSBvbiBob3RwbHVnIC0gaXQgd29uJ3QgYmUg
ZnJlZWQgdW5sZXNzIHRoZSB1bmRlcmx5aW5nIGNvbm5lY3Rvcgo+IGlzIGZyZWVkLCBhcyB0aGUg
ZWxkIGlzIHN0b3JlZCBhcyBhbiBhcnJheSBpbnNpZGUgc3RydWN0IGRybV9jb25uZWN0b3IuCj4g
QmVmb3JlIHRoZSBEUk0gY29ubmVjdG9yIGlzIGZyZWVkLCB3ZSBwdWxsIHRoZSBhdWRpbyBkcml2
ZXIncyBzdHJ1Y3QKPiBkZXZpY2UsIHdoaWNoIHdpbGwgZGVzdHJveSB0aGUgQUxTQSBkZXZpY2Uu
CgpPaCByaWdodCBJJ3ZlIGZvcmdvdHRlbiB0aGF0IGVsZCBpcyBzdG9yZWQgYXMgYSBmdWxsIGFy
cmF5IGFuZCBvbmx5IHRoZQplZGlkIGZsb2F0cyBhcm91bmQgYXMgYSBwb2ludGVyIGluIGRybV9j
b25uZWN0b3IuIAoKPiBIb3BlZnVsbHkgQUxTQSBhbHJlYWR5IGNvcGVzIGdyYWNlZnVsbHkgd2l0
aCB0aGUgcmVtb3ZhbCBvZiBhbiBpbi11c2UKPiBkZXZpY2UuLi4gaXQgc2hvdWxkIGRvLCBpdCdz
IG5vIGRpZmZlcmVudCBmcm9tIGhhdmluZyBhIFVTQiBhdWRpbyBkZXZpY2UKPiBhbmQgeW91IHB1
bGwgaXQgb3V0IG9mIHRoZSBVU0Igc29ja2V0IHdoaWxlIHRoZSBkZXZpY2UgaXMgaW4tdXNlLgo+
IAo+IChJdCdzIGFsc28gd29ydGggbm90aW5nIGFzIHdlJ3JlIHRhbGtpbmcgYWJvdXQgdGhpcywg
dGhhdCBhcyB0aGUgYXVkaW8KPiBzdHJ1Y3QgZGV2aWNlIGlzIGEgY2hpbGQgb2YgdGhlIEhETUkg
ZGV2aWNlLCBhbnkgUE0gYWN0aXZpdHkgd2lsbCBiZQo+IGNvcnJlY3RseSBvcmRlcmVkOiB0aGUg
Y2hpbGQgZ2V0cyBzdXNwZW5kZWQgYmVmb3JlIHRoZSBwYXJlbnQuLi4gdGhlCj4gYXVkaW8gZGV2
aWNlIGdldHMgc3VzcGVuZGVkIGJlZm9yZSB0aGUgdmlkZW8sIGFuZCByZXN1bWUgaXMgb2YgY291
cnNlCj4gdGhlIHJldmVyc2Ugb3JkZXIuKQoKWWVhaCwgYmVpbmcgYWJsZSB0byBjb250cm9sIHRo
ZSBuZXN0aW5nIHdpdGggRFQgc2VlbXMgc28gbmljZSBjb21wYXJlZCB0bwppbnRlbCAuLi4KLURh
bmllbAotLSAKRGFuaWVsIFZldHRlcgpTb2Z0d2FyZSBFbmdpbmVlciwgSW50ZWwgQ29ycG9yYXRp
b24KaHR0cDovL2Jsb2cuZmZ3bGwuY2gKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KZHJpLWRldmVsIG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnCmh0dHA6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5m
by9kcmktZGV2ZWwK
