From: "Andrew F. Davis" <afd@ti.com>
Subject: Re: [PATCH 4/9] ARM: dts: am335x-pepper: Fix the audio
 CODEC's reset pin
Date: Thu, 9 Nov 2017 10:40:52 -0600
Message-ID: <8d40b3f4-40a6-70e1-8b67-ae805e701aca@ti.com>
References: <20171108212505.28320-1-afd@ti.com>
 <20171108212505.28320-5-afd@ti.com> <1510237521.7659.11.camel@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fllnx209.ext.ti.com (fllnx209.ext.ti.com [198.47.19.16])
 by alsa0.perex.cz (Postfix) with ESMTP id C2071267826
 for <alsa-devel@alsa-project.org>; Thu,  9 Nov 2017 17:41:14 +0100 (CET)
In-Reply-To: <1510237521.7659.11.camel@pengutronix.de>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Philipp Zabel <p.zabel@pengutronix.de>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

T24gMTEvMDkvMjAxNyAwODoyNSBBTSwgUGhpbGlwcCBaYWJlbCB3cm90ZToKPiBPbiBXZWQsIDIw
MTctMTEtMDggYXQgMTU6MjUgLTA2MDAsIEFuZHJldyBGLiBEYXZpcyB3cm90ZToKPj4gVGhlIGNv
cnJlY3QgRFQgcHJvcGVydHkgZm9yIHNwZWNpZnlpbmcgYSBHUElPIHVzZWQgZm9yIHJlc2V0Cj4+
IGlzICJyZXNldC1ncGlvIiwgZml4IHRoaXMgaGVyZS4KPj4KPj4gRml4ZXM6IDQzNDE4ODFkMDU2
MiAoIkFSTTogZHRzOiBBZGQgZGV2aWNldHJlZSBmb3IgR3Vtc3RpeCBQZXBwZXIgYm9hcmQiKQo+
Pgo+PiBTaWduZWQtb2ZmLWJ5OiBBbmRyZXcgRi4gRGF2aXMgPGFmZEB0aS5jb20+Cj4+IC0tLQo+
PiAgYXJjaC9hcm0vYm9vdC9kdHMvYW0zMzV4LXBlcHBlci5kdHMgfCAyICstCj4+ICAxIGZpbGUg
Y2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKPj4KPj4gZGlmZiAtLWdpdCBh
L2FyY2gvYXJtL2Jvb3QvZHRzL2FtMzM1eC1wZXBwZXIuZHRzIGIvYXJjaC9hcm0vYm9vdC9kdHMv
YW0zMzV4LXBlcHBlci5kdHMKPj4gaW5kZXggMDNjN2Q3NzAyM2M2Li5kNjUyYWJkNzYzMzMgMTAw
NjQ0Cj4+IC0tLSBhL2FyY2gvYXJtL2Jvb3QvZHRzL2FtMzM1eC1wZXBwZXIuZHRzCj4+ICsrKyBi
L2FyY2gvYXJtL2Jvb3QvZHRzL2FtMzM1eC1wZXBwZXIuZHRzCj4+IEBAIC0xMzksNyArMTM5LDcg
QEAKPj4gICZhdWRpb19jb2RlYyB7Cj4+ICAJc3RhdHVzID0gIm9rYXkiOwo+PiAgCj4+IC0JZ3Bp
by1yZXNldCA9IDwmZ3BpbzEgMTYgR1BJT19BQ1RJVkVfTE9XPjsKPj4gKwlyZXNldC1ncGlvID0g
PCZncGlvMSAxNiBHUElPX0FDVElWRV9MT1c+Owo+IAo+IFRoaXMgcG90ZW50aWFsbHkgYnJlYWtz
IGF1ZGlvIG9uIGFtMzM1eC1wZXBwZXIgdW50aWwgdGhlIGRyaXZlciBwYXRjaGVzCj4gYXJlIGFw
cGxpZWQsIHNhbWUgZm9yIHRoZSBvdGhlciBkZXZpY2UgdHJlZXMuIFRvIG1ha2UgdGhpcyBiaXNl
Y3RhYmxlLAo+IGFkZCBzdXBwb3J0IGZvciB0aGUgbmV3IHByb3BlcnR5IG5hbWXCoHRvIHRoZSBk
cml2ZXIgYmVmb3JlIGNoYW5naW5nIHRoZQo+IGRldmljZSB0cmVlcy4KCkFGQUlLIHRoaXMgY2hh
bmdlIGRvZXNuJ3QgYnJlYWsgYW55dGhpbmcgYXMgdGhpcyByZXNldCB3YXMgbm90IHVzZWQgaW4g
YQpmdW5jdGlvbmFsIHdheSAoaXQgd2FzIGp1c3QgcHVsbGVkIGhpZ2ggaW4gcHJvYmUgaWYgcHJv
dmlkZWQsIGJ1dCB0aGUKcGluX211eCBhbmQvb3IgYW5kIG9uLWJvYXJkIHJlc2lzdG9yIHNob3Vs
ZCBoYXZlIGRvbmUgdGhlIHNhbWUgYWxyZWFkeSwKYnV0IGEgc2VyaWVzIEkganVzdCBwb3N0ZWQg
d2lsbCBhY3R1YWxseSBnZXQgc29tZSB1c2Ugb3V0IG9mIGl0IGFuZCBzbyBJCndhbnQgdG8gZ2V0
IHRoaXMgZml4ZWQgYmVmb3JlIHRoZW4pLgoKQXMgY29udHJvdmVyc2lhbCBhcyBpdCBtYXkgYmUs
IG15IHBsYW4gaXMgdG8gc2ltcGx5IG5vdCBzdXBwb3J0IHRoZSBvbGQKYmluZGluZyBhdCBhbGws
IHN1cHBvcnRpbmcgaXQgd291bGQgYWRkIHVubmVjZXNzYXJ5IGJsb2F0IHRvIHRoZSBkcml2ZXIs
CnByZXZlbnQgbW92aW5nIHRvIG5ldyBmcmFtZXdvcmtzIHRoYXQgZXhwZWN0IHRoZSBjb3JyZWN0
IGJpbmRpbmcKKGZ3bm9kZV9nZXRfbmFtZWRfZ3Bpb2QpLCBhbmQgaW4gdGhpcyBjYXNlIHByb3Zp
ZGUgbm8gYmVuZWZpdCBhcyBmYXIgYXMKSSBjYW4gdGVsbC4KCkFuZHJldwoKPiAKPiByZWdhcmRz
Cj4gUGhpbGlwcAo+IApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcK
aHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2
ZWwK
