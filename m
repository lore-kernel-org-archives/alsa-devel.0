From: Andrzej Hajda <a.hajda@samsung.com>
Subject: Re: [PATCH v5 6/6] drm/bridge: sii902x: Implement HDMI audio support
Date: Mon, 15 Apr 2019 11:44:41 +0200
Message-ID: <48622962-6894-fa9f-3f49-cbde390a09e7@samsung.com>
References: <cover.1553241734.git.jsarha@ti.com>
 <CGME20190322080653epcas2p3923ec514f775739da7fd517e944ed27f@epcas2p3.samsung.com>
 <ba7ec8ae3188d023575031ab77742c56002a5cde.1553241734.git.jsarha@ti.com>
 <d10b5155-ad7b-b4f3-7b79-c1ecea7c3ff6@samsung.com>
 <2e1298f9-f9a2-9831-69d4-6b1b20260d82@ti.com>
 <e6fbf183-9f19-d749-0d87-54875957949f@samsung.com>
 <60b43760-fccd-4c3b-df7a-9afdde3f62a8@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <60b43760-fccd-4c3b-df7a-9afdde3f62a8@ti.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Jyri Sarha <jsarha@ti.com>, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: fabrizio.castro@bp.renesas.com, architt@codeaurora.org, Songjun.Wu@atmel.com, peter.ujfalusi@ti.com, tomi.valkeinen@ti.com, laurent.pinchart@ideasonboard.com, voice.shen@atmel.com
List-Id: alsa-devel@alsa-project.org

T24gMTUuMDQuMjAxOSAwOToyNiwgSnlyaSBTYXJoYSB3cm90ZToKPiBPbiAxMi8wNC8yMDE5IDE1
OjMwLCBBbmRyemVqIEhhamRhIHdyb3RlOgo+Pj4+PiArc3RhdGljIGNvbnN0IHVuc2lnbmVkIGlu
dCBzaWk5MDJ4X21jbGtfZGl2X3RhYmxlW10gPSB7Cj4+Pj4+ICsJMTI4LCAyNTYsIDM4NCwgNTEy
LCA3NjgsIDEwMjQsIDExNTIsIDE5MiB9Owo+Pj4+PiArCj4+Pj4+ICtzdGF0aWMgaW50IHNpaTkw
Mnhfc2VsZWN0X21jbGtfZGl2KHU4ICppMnNfY29uZmlnX3JlZywgdW5zaWduZWQgaW50IHJhdGUs
Cj4+Pj4+ICsJCQkJICAgdW5zaWduZWQgaW50IG1jbGspCj4+Pj4+ICt7Cj4+Pj4+ICsJdW5zaWdu
ZWQgaW50IGRpdiA9IG1jbGsgLyByYXRlOwo+Pj4+PiArCWludCBkaXN0YW5jZSA9IDEwMDAwMDsK
Pj4+Pj4gKwl1OCBpLCBuZWFyZXN0ID0gMDsKPj4+Pj4gKwo+Pj4+PiArCWZvciAoaSA9IDA7IGkg
PCBBUlJBWV9TSVpFKHNpaTkwMnhfbWNsa19kaXZfdGFibGUpOyBpKyspIHsKPj4+Pj4gKwkJdW5z
aWduZWQgaW50IGQgPSBhYnMoZGl2IC0gc2lpOTAyeF9tY2xrX2Rpdl90YWJsZVtpXSk7Cj4+Pj4g
VXNpbmcgdW5zaWduZWQgdHlwZXMgaW4gdGhpcyBjb250ZXh0IHNlZW1zIHRvIGJlIGFza2luZyBm
b3IgdHJvdWJsZXMuCj4+Pj4KPj4+IFdoeT8gSXNuJ3QgcmV0dXJuIHZhbHVlIG9mIGFicygpIGJ5
IGRlZmluaXRpb24gdW5zaWduZWQ/IFVzaW5nIHNpZ25lZAo+Pj4gaW50ZWdlcnMgd2hlbiBjb21w
YXJpbmcgYWJzb2x1dGUgZGlzdGFuY2VzIHdvdWxkIHNlZW0gYXdrd2FyZCB0byBtZS4KPj4gKGRp
diAtIHNpaTkwMnhfbWNsa19kaXZfdGFibGVbaV0pIGlzIHVuc2lnbmVkLCBpZiBkaXYgaXMgbG93
ZXIsIHRoZXJlIGlzIG92ZXJmbG93LCBhbmQgdGhlIHZhbHVlIGlzIGJpZyBpbnQsIEkgc3VwcG9z
ZSB0aGlzIGlzIG5vdCB3aGF0IHlvdSB3YW50Lgo+Pgo+IE9oIHllcy4gSSBoYWQgbXkgZXllcyBm
aXhlZCBvbiB3cm9uZyB1bnNpZ25lZC4gVGhlIGZpcnN0IG9wZXJhbmQgb2YKPiBzdWJ0cmFjdGlv
biBzaG91bGQgaW5kZWVkIGJlIHNpZ25lZCBmb3IgdGhlIHJlc3VsdCB0byBiZSBzaWduZWQsIEkK
PiBjb21wbGV0ZWx5IG92ZXJsb29rZWQgdGhhdC4KCgpXb3JzZSwgYm90aCBvcGVyYW5kcyBtdXN0
IGJlIGludCB0byBhdm9pZCBjYXN0aW5nIHRvIHVuc2lnbmVkLgoKClJlZ2FyZHMKCkFuZHJ6ZWoK
Cgo+Cj4gVGhhbmtzLAo+IEp5cmkKPgo+Cj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmRyaS1kZXZlbCBtYWlsaW5nIGxpc3QKZHJpLWRldmVsQGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2RyaS1kZXZlbA==
