From: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH 6/8] ASoC: AMD: add AMD ASoC ACP 2.x DMA driver
Date: Sat, 9 Jan 2016 14:53:50 -0500
Message-ID: <CADnq5_M6L+bMjgxf-30bYpb5zk4y7YDrhKSoAN5yMFzKsbCvpg@mail.gmail.com>
References: <1450897275-17152-1-git-send-email-alexander.deucher@amd.com>
 <1450897275-17152-6-git-send-email-alexander.deucher@amd.com>
 <20160105184343.GL6588@sirena.org.uk>
 <CADnq5_NE4BBYMfLNfFM=eonNy2Lny-5R_dV24UCS5Htioiqz5Q@mail.gmail.com>
 <20160109194138.GU6588@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20160109194138.GU6588@sirena.org.uk>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Mark Brown <broonie@kernel.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Bayyavarapu,
 Maruthi" <maruthi.bayyavarapu@amd.com>, Liam Girdwood <lgirdwood@gmail.com>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>, rajeev kumar <rajeevkumar.linux@gmail.com>, Alex Deucher <alexander.deucher@amd.com>, perex@perex.cz
List-Id: alsa-devel@alsa-project.org

T24gU2F0LCBKYW4gOSwgMjAxNiBhdCAyOjQxIFBNLCBNYXJrIEJyb3duIDxicm9vbmllQGtlcm5l
bC5vcmc+IHdyb3RlOgo+IE9uIEZyaSwgSmFuIDA4LCAyMDE2IGF0IDA2OjAzOjE5UE0gLTA1MDAs
IEFsZXggRGV1Y2hlciB3cm90ZToKPj4gT24gVHVlLCBKYW4gNSwgMjAxNiBhdCAxOjQzIFBNLCBN
YXJrIEJyb3duIDxicm9vbmllQGtlcm5lbC5vcmc+IHdyb3RlOgo+PiA+IE9uIFdlZCwgRGVjIDIz
LCAyMDE1IGF0IDAyOjAxOjEzUE0gLTA1MDAsIEFsZXggRGV1Y2hlciB3cm90ZToKPgo+PiA+PiAt
LS0gL2Rldi9udWxsCj4+ID4+ICsrKyBiL3NvdW5kL3NvYy9hbWQvS2NvbmZpZwo+PiA+PiBAQCAt
MCwwICsxLDQgQEAKPj4gPj4gK2NvbmZpZyBTTkRfU09DX0FNRF9BQ1AKPj4gPj4gKyAgICAgdHJp
c3RhdGUgIkFNRCBBdWRpbyBDb3Byb2Nlc3NvciBzdXBwb3J0Igo+PiA+PiArICAgICBoZWxwCj4+
ID4+ICsgICAgICBUaGlzIG9wdGlvbiBlbmFibGVzIEFDUCBETUEgc3VwcG9ydCBvbiBBTUQgcGxh
dGZvcm0uCj4KPj4gPiBUaGlzIGhhcyBubyBkZXBlbmRlbmNpZXM/Cj4KPj4gTm8gZGVwZW5kZW5j
aWVzLiAgVGhlIEFDUCBkZXZpY2UgZGlzY292ZXJ5IGlzIHRyaWdnZXJlZCBmcm9tIEdQVQo+PiBk
cml2ZXIsIGJ1dCB0aGUgQUNQIGRyaXZlciBoYXMgbm8gZGlyZWN0IGRlcGVuZGVuY2llcyBvbiBp
dC4KPj4gVGhlb3JldGljYWxseSBpdCBjb3VsZCBhY3QgYXMgYSBzdGFuZGFsb25lIGRyaXZlci4K
Pgo+IEluIHRoYXQgY2FzZSB0aGVyZSdzIG5vIG5lZWQgdG8gbWVyZ2UgZXZlcnl0aGluZyB0aHJv
dWdoIHRoZSBEUk0gdHJlZSwKPiBlYWNoIGJpdCBjYW4gZ28gaW4gc2VwYXJhdGVseS4gIFRoYXQg
bWFrZXMgbGlmZSBhIGJpdCBlYXNpZXIgcHJvY2Vzcwo+IHdpc2UsIHBlb3BsZSB3aWxsIG5lZWQg
dG8gbWVyZ2UgdGhlIHR3byB0byBydW4gdGhpbmdzIGJ1dCB0aGF0J3MgZmluZS4KClNvdW5kcyBn
b29kLiAgVGhhbmtzIQoKQWxleApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpkcmktZGV2ZWwgbWFpbGluZyBsaXN0CmRyaS1kZXZlbEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmcKaHR0cDovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Ry
aS1kZXZlbAo=
