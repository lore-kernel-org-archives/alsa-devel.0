From: "Agrawal, Akshu" <Akshu.Agrawal@amd.com>
Subject: Re: [PATCH 6/6 v3] ASoC: AMD: Add machine driver for cz rt5650
Date: Fri, 1 Sep 2017 11:08:14 +0000
Message-ID: <MWHPR1201MB019226E9EDE45E14FFE2746CF8920@MWHPR1201MB0192.namprd12.prod.outlook.com>
References: <1503079830-16072-1-git-send-email-alexander.deucher@amd.com>
 <1503079830-16072-7-git-send-email-alexander.deucher@amd.com>
 <20170831113802.x75watdrylvjivkl@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20170831113802.x75watdrylvjivkl@sirena.org.uk>
Content-Language: en-US
Content-ID: <FFBB21E1FD326D4AA8E8C62506316E4E@amdcloud.onmicrosoft.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Mark Brown <broonie@kernel.org>, Alex Deucher <alexdeucher@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "rajeevkumar.linux@gmail.com" <rajeevkumar.linux@gmail.com>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Mukunda,
 Vijendar" <Vijendar.Mukunda@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "perex@perex.cz" <perex@perex.cz>
List-Id: alsa-devel@alsa-project.org

CgpPbiA4LzMxLzIwMTcgNTowOCBQTSwgTWFyayBCcm93biB3cm90ZToKPiBPbiBGcmksIEF1ZyAx
OCwgMjAxNyBhdCAwMjoxMDozMFBNIC0wNDAwLCBBbGV4IERldWNoZXIgd3JvdGU6Cj4gCj4+ICsr
KyBiL3NvdW5kL3NvYy9hbWQvS2NvbmZpZwo+PiBAQCAtMiwzICsyLDEwIEBAIGNvbmZpZyBTTkRf
U09DX0FNRF9BQ1AKPj4gICAJdHJpc3RhdGUgIkFNRCBBdWRpbyBDb3Byb2Nlc3NvciBzdXBwb3J0
Igo+PiAgIAloZWxwCj4+ICAgCSBUaGlzIG9wdGlvbiBlbmFibGVzIEFDUCBETUEgc3VwcG9ydCBv
biBBTUQgcGxhdGZvcm0uCj4+ICtjb25maWcgU05EX1NPQ19BTURfQ1pfUlQ1NjQ1X01BQ0gKPj4g
Kwl0cmlzdGF0ZSAiQU1EIENaIHN1cHBvcnQgZm9yIFJUNTY0NSIKPiAKPiBNaXNzaW5nIGJsYW5r
IGxpbmUgYmV0d2VlbiB0aGUgc3Rhbnphcy4KCkRvbmUuIFdpbGwgcHVzaCB0aGUgY2hhbmdlIGlu
IG5leHQgcmV2aXNpb24uCgo+IAo+PiArCXNlbGVjdCBTTkRfU09DX1JUNTY0NQo+PiArCXNlbGVj
dCBTTkRfU09DX0FNRF9BQ1AKPj4gKwlkZXBlbmRzIG9uIEkyQ19ERVNJR05XQVJFX1BMQVRGT1JN
Cj4gCj4gTm8gc3lzdGVtIGRlcGVuZGVuY2llcyBvZiBhbnkga2luZD8gIExvb2tpbmcgYXQgdGhp
cyBJJ2QgZXhwZWN0IGF0IGxlYXN0Cj4gQ09ORklHX0FDUEkgfHwgQ09NUElMRV9URVNULiAgSXQn
cyBhbHNvIHVuY2xlYXIgdG8gbWUgaG93IHRoZSBEZXNpZ25XYXJlCj4gZGV2aWNlIGlzIGdvaW5n
IHRvIGJlIGluc3RhbnRpYXRlZCBoZXJlIG9yIGlmIHRoYXQgc2hvdWxkIGJlIGEgZGlyZWN0Cj4g
ZGVwZW5lbmN5IGF0IGFsbCBoZXJlLgo+CgpBZGRlZCBJMkMgZm9yIHN5c3RlbSBkZXBlbmRlbmN5
IGFuZCByZW1vdmVkIApJMkNfREVTSUdOV0FSRV9QTEFURk9STSBhcyBkZXBlbmRlbmN5Cgo+PiAr
CXJldCA9IHNuZF9zb2NfcmVnaXN0ZXJfY2FyZChjYXJkKTsKPiAKPiBkZXZtX3NuZF9zb2NfcmVn
aXN0ZXJfY2FyZCgpIGFuZCB0aGVuIHlvdSBkb24ndCBuZWVkIHRoZSByZW1vdmUKPiBmdW5jdGlv
bi4KPgoKRG9uZS4KCj4+ICtzdGF0aWMgY29uc3Qgc3RydWN0IGFjcGlfZGV2aWNlX2lkIGN6X2F1
ZGlvX2FjcGlfbWF0Y2hbXSA9IHsKPj4gKwl7ICJBTURJMTAwMiIsIDAgfSwKPj4gKwl7fSwKPj4g
K307Cj4+ICsKPiAKPiBNaXNzaW5nIE1PRFVMRV9ERVZJQ0VfVEFCTEUoKS4KPgoKRG9uZS4KCgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpkcmktZGV2ZWwg
bWFpbGluZyBsaXN0CmRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWwK
