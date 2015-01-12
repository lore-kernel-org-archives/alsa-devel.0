From: Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH v9 1/4] drm/i2c: tda998x: Add DT support for audio
Date: Mon, 12 Jan 2015 14:59:57 +0100
Message-ID: <1421071197.3081.44.camel@pengutronix.de>
References: <54AFA9B0.6040405@ti.com> <20150109123036.4bc4bbf6@armhf>
 <20150109114529.GH12302@n2100.arm.linux.org.uk>
 <20150109135401.5b270d46@armhf>
 <20150109130725.GN12302@n2100.arm.linux.org.uk> <54AFDE8D.3000504@arm.com>
 <20150109145741.GP12302@n2100.arm.linux.org.uk>
 <20150109183857.53d701a4@armhf>
 <20150109200127.GD12302@n2100.arm.linux.org.uk>
 <1421054728.3081.28.camel@pengutronix.de>
 <20150112122527.GF12302@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20150112122527.GF12302@n2100.arm.linux.org.uk>
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

QW0gTW9udGFnLCBkZW4gMTIuMDEuMjAxNSwgMTI6MjUgKzAwMDAgc2NocmllYiBSdXNzZWxsIEtp
bmcgLSBBUk0gTGludXg6Cj4gT24gTW9uLCBKYW4gMTIsIDIwMTUgYXQgMTA6MjU6MjhBTSArMDEw
MCwgUGhpbGlwcCBaYWJlbCB3cm90ZToKPiA+IEplYW4tRnJhbmNvaXMnIHJlcGx5IGFscmVhZHkg
cmVmbGVjdHMgdGhpcywgYnV0IHRoZSAncG9ydCcgbm9kZXMgc2hvdWxkCj4gPiBjb3JyZXNwb25k
IHRvIHBoeXNpY2FsIHBvcnRzIG9mIHRoZSBkZXZpY2UgaWYgcG9zc2libGUuIElmIHlvdSBjYW4K
PiA+IGNvbmZpZ3VyZSB0aGUgZGV2aWNlIHRvIGhhdmUgZGVkaWNhdGVkIGlucHV0IHBpbnMgZm9y
IEkyUywgU1BESUYwLCBhbmQKPiA+IFNQRElGMSBhdCB0aGUgc2FtZSB0aW1lLCB0aGV5IHNob3Vs
ZCBhcHBlYXIgaW4gdGhlIGRldmljZSB0cmVlIGFzCj4gPiBzZXBhcmF0ZSBwb3J0czoKPiA+IAo+
ID4gdGRhOTk4eDogaGRtaS1lbmNvZGVyIHsKPiA+IAlwb3J0QDAgeyAvKiBwaXhlbCBkYXRhIGFj
Y29yZGluZyB0byB2aWRlby1wb3J0cyAqLwo+ID4gCQlyZWcgPSA8MHgwMD47Cj4gPiAJfTsKPiA+
IAlwb3J0QDEgeyAvKiBBUDE6IFNQRElGMCAqLwo+ID4gCQlyZWcgPSA8MHgwMT47Cj4gPiAJfTsK
PiA+IAlwb3J0QDIgeyAvKiBBUDI6IFNQRElGMSAqLwo+ID4gCQlyZWcgPSA8MHgwMj47Cj4gPiAJ
fTsKPiA+IAlwb3J0QDMgeyAvKiBBUDM6IEkyUyAqLwo+ID4gCQlyZWcgPSA8MHgwMz47Cj4gPiAJ
fTsKPiA+IH07Cj4gPiAKPiA+IFRoZSB0ZGE5OTh4IGJpbmRpbmcgd291bGQgZGVmaW5lIGhvdyB0
aGUgcG9ydHMgYXJlIG51bWJlcmVkLCBzb21lCj4gPiBjb3JyZXNwb25kZW5jZSB0byB0aGUgQVAg
cGluIG51bWJlcnMgd291bGQgYmUgZ29vZC4KPiAKPiBJdCdzIG5vdCBxdWl0ZSB0aGF0IHNpbXBs
ZSwgYmVjYXVzZSB0aGUgU1BESUYgQVAgcGlucyBhcmUgbXVsdGlwbGV4ZWQKPiB3aXRoIHRoZSBJ
MlMgcGlucyAtIGFuZCB0aGVyZSBpcyB2YXJpYXRpb24gYmV0d2VlbiBjaGlwIG1vZGVscyBhbmQK
PiBwYWNrYWdlcy4KPgo+IFNvLCBpdCdzIHByb2JhYmx5IGJlc3QgaWYgcG9ydEAwIGlzIHRoZSB2
aWRlbyBwb3J0LCBhbmQgdGhlbiBwb3J0QDEuLm4KPiBjYW4gZGVzY3JpYmUgdGhlIGF1ZGlvIGlu
cHV0cywgaW5jbHVkaW5nIGEgcHJvcGVydHkgd2hpY2ggc3BlY2lmaWVzCj4gd2hldGhlciB0aGV5
IGFyZSBJMlMgb3IgU1BESUYsIGFuZCB0aGUgdmFsdWUgdG8gYmUgcHJvZ3JhbW1lZCBpbnRvCj4g
dGhlIEFQIGVuYWJsZSByZWdpc3RlciAod2hpY2ggaXMgYSBiaXQgZmllbGQgb2YgdGhlIEFQIHBp
bnMgd2hpY2gKPiBzaG91bGQgYmUgdW5tYXNrZWQuKSAgSSBndWVzcyB3ZSBjYW4gcmUtdXNlIHRo
ZSByZWc9IHByb3BlcnR5IGZvciB0aGF0Cj4gdmFsdWUsIHNpbmNlIHZpZGVvIHdpbGwgYWx3YXlz
IGJlIHplcm8uCgpOb3RlIHRoYXQgb2ZfZ3JhcGhfcGFyc2VfZW5kcG9pbnQgaW50ZXJwcmV0cyB0
aGUgcG9ydCBub2RlJ3MgcmVnCnByb3BlcnR5IGFzIHBvcnQgaWQuIEFuZCB0aGUgdW5pdCBhZGRy
ZXNzIHBhcnQgb2YgdGhlIG5vZGUgbmFtZSBzaG91bGQKbWF0Y2ggdGhlIGZpcnN0IGFkZHJlc3Mg
aW4gdGhlIHJlZyBwcm9wZXJ0eS4KCnJlZ2FyZHMKUGhpbGlwcAoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVsIG1haWxpbmcgbGlzdApkcmkt
ZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHA6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcv
bWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWwK
