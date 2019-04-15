From: Jyri Sarha <jsarha@ti.com>
Subject: Re: [PATCH v5 6/6] drm/bridge: sii902x: Implement HDMI audio support
Date: Mon, 15 Apr 2019 10:26:21 +0300
Message-ID: <60b43760-fccd-4c3b-df7a-9afdde3f62a8@ti.com>
References: <cover.1553241734.git.jsarha@ti.com>
 <CGME20190322080653epcas2p3923ec514f775739da7fd517e944ed27f@epcas2p3.samsung.com>
 <ba7ec8ae3188d023575031ab77742c56002a5cde.1553241734.git.jsarha@ti.com>
 <d10b5155-ad7b-b4f3-7b79-c1ecea7c3ff6@samsung.com>
 <2e1298f9-f9a2-9831-69d4-6b1b20260d82@ti.com>
 <e6fbf183-9f19-d749-0d87-54875957949f@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <e6fbf183-9f19-d749-0d87-54875957949f@samsung.com>
Content-Language: en-GB
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Andrzej Hajda <a.hajda@samsung.com>, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: fabrizio.castro@bp.renesas.com, architt@codeaurora.org, Songjun.Wu@atmel.com, peter.ujfalusi@ti.com, tomi.valkeinen@ti.com, laurent.pinchart@ideasonboard.com, voice.shen@atmel.com
List-Id: alsa-devel@alsa-project.org

T24gMTIvMDQvMjAxOSAxNTozMCwgQW5kcnplaiBIYWpkYSB3cm90ZToKPj4+PiArc3RhdGljIGNv
bnN0IHVuc2lnbmVkIGludCBzaWk5MDJ4X21jbGtfZGl2X3RhYmxlW10gPSB7Cj4+Pj4gKwkxMjgs
IDI1NiwgMzg0LCA1MTIsIDc2OCwgMTAyNCwgMTE1MiwgMTkyIH07Cj4+Pj4gKwo+Pj4+ICtzdGF0
aWMgaW50IHNpaTkwMnhfc2VsZWN0X21jbGtfZGl2KHU4ICppMnNfY29uZmlnX3JlZywgdW5zaWdu
ZWQgaW50IHJhdGUsCj4+Pj4gKwkJCQkgICB1bnNpZ25lZCBpbnQgbWNsaykKPj4+PiArewo+Pj4+
ICsJdW5zaWduZWQgaW50IGRpdiA9IG1jbGsgLyByYXRlOwo+Pj4+ICsJaW50IGRpc3RhbmNlID0g
MTAwMDAwOwo+Pj4+ICsJdTggaSwgbmVhcmVzdCA9IDA7Cj4+Pj4gKwo+Pj4+ICsJZm9yIChpID0g
MDsgaSA8IEFSUkFZX1NJWkUoc2lpOTAyeF9tY2xrX2Rpdl90YWJsZSk7IGkrKykgewo+Pj4+ICsJ
CXVuc2lnbmVkIGludCBkID0gYWJzKGRpdiAtIHNpaTkwMnhfbWNsa19kaXZfdGFibGVbaV0pOwo+
Pj4gVXNpbmcgdW5zaWduZWQgdHlwZXMgaW4gdGhpcyBjb250ZXh0IHNlZW1zIHRvIGJlIGFza2lu
ZyBmb3IgdHJvdWJsZXMuCj4+Pgo+PiBXaHk/IElzbid0IHJldHVybiB2YWx1ZSBvZiBhYnMoKSBi
eSBkZWZpbml0aW9uIHVuc2lnbmVkPyBVc2luZyBzaWduZWQKPj4gaW50ZWdlcnMgd2hlbiBjb21w
YXJpbmcgYWJzb2x1dGUgZGlzdGFuY2VzIHdvdWxkIHNlZW0gYXdrd2FyZCB0byBtZS4KPiAKPiAo
ZGl2IC0gc2lpOTAyeF9tY2xrX2Rpdl90YWJsZVtpXSkgaXMgdW5zaWduZWQsIGlmIGRpdiBpcyBs
b3dlciwgdGhlcmUgaXMgb3ZlcmZsb3csIGFuZCB0aGUgdmFsdWUgaXMgYmlnIGludCwgSSBzdXBw
b3NlIHRoaXMgaXMgbm90IHdoYXQgeW91IHdhbnQuCj4gCgpPaCB5ZXMuIEkgaGFkIG15IGV5ZXMg
Zml4ZWQgb24gd3JvbmcgdW5zaWduZWQuIFRoZSBmaXJzdCBvcGVyYW5kIG9mCnN1YnRyYWN0aW9u
IHNob3VsZCBpbmRlZWQgYmUgc2lnbmVkIGZvciB0aGUgcmVzdWx0IHRvIGJlIHNpZ25lZCwgSQpj
b21wbGV0ZWx5IG92ZXJsb29rZWQgdGhhdC4KClRoYW5rcywKSnlyaQoKCgotLSAKVGV4YXMgSW5z
dHJ1bWVudHMgRmlubGFuZCBPeSwgUG9ya2thbGFua2F0dSAyMiwgMDAxODAgSGVsc2lua2kuClkt
dHVubnVzL0J1c2luZXNzIElEOiAwNjE1NTIxLTQuIEtvdGlwYWlra2EvRG9taWNpbGU6IEhlbHNp
bmtpCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmRyaS1k
ZXZlbCBtYWlsaW5nIGxpc3QKZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczov
L2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbA==
