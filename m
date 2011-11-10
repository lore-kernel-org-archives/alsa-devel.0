From: Sven Neumann <s.neumann@raumfeld.com>
Subject: Re: [PATCH] ASoC: sta32x: add workaround for ESD reset
	issue
Date: Thu, 10 Nov 2011 17:49:19 +0100
Message-ID: <1320943759.6338.9.camel@sven>
References: <20111109133001.GA7394@sig21.net>
	<20111109143647.GB587@opensource.wolfsonmicro.com>
	<20111109173419.GA10174@sig21.net>
	<20111109233256.GA5010@opensource.wolfsonmicro.com>
	<20111110142708.GA12808@sig21.net>
	<20111110151136.GH3832@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from vwp2514.webpack.hosteurope.de (vwp2514.webpack.hosteurope.de
	[87.230.42.24]) by alsa0.perex.cz (Postfix) with ESMTP id B4CE5243A0
	for <alsa-devel@alsa-project.org>; Thu, 10 Nov 2011 17:49:23 +0100 (CET)
In-Reply-To: <20111110151136.GH3832@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Liam@alsa-project.org, alsa-devel@alsa-project.org, Daniel Mack <daniel@zonque.org>, Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

T24gVGh1LCAyMDExLTExLTEwIGF0IDE1OjExICswMDAwLCBNYXJrIEJyb3duIHdyb3RlOgo+IE9u
IFRodSwgTm92IDEwLCAyMDExIGF0IDAzOjI3OjA4UE0gKzAxMDAsIEpvaGFubmVzIFN0ZXplbmJh
Y2ggd3JvdGU6Cj4gPiBPbiBXZWQsIE5vdiAwOSwgMjAxMSBhdCAxMTozMjo1N1BNICswMDAwLCBN
YXJrIEJyb3duIHdyb3RlOgo+IAo+ID4gPiBZZWFoLCBidXQgaWYgaXQgc3VkZGVubHkgc3RvcHMg
aW4gdGhlIG1pZGRsZSBvZiBwbGF5YmFjayB0aGVuIHRoYXQnbGwKPiA+ID4gdGVuZCB0byByZWdp
c3RlciB3aXRoIHVzZXJzIGFuZCBpZiB5b3Uga2VlcCBpdCBwb3dlcmVkIG9mZiBhdCBhbGwgb3Ro
ZXIKPiA+ID4gdGltZXMuCj4gCj4gPiBIbSwgdGhlIGdvYWwgaXMgdG8gZml4IHRoZSBpc3N1ZSB3
aXRob3V0IHVzZXIgaW50ZXJhY3Rpb24uCj4gPiBUaGUgYXBwIHdpbGwga2VlcCB0aGUgZGV2aWNl
IG9wZW4gYW5kIHdpbGwgcGxheSBiYWNrCj4gPiB3aXRob3V0IG5vdGljaW5nIHRoZSBwcm9ibGVt
Lgo+IAo+IFdlbGwsIHRoZSB1c2VyIGlzIGdvaW5nIHRvIGhlYXIgYSBob3JyaWZpYyBnbGl0Y2gg
YW55d2F5Li4uCgpXZWxsLCB0aGUgcHJvYmxlbSB3ZSBhcmUgZmFjaW5nIGhlcmUgaXMgbm90IHJl
YWxseSBzaG93aW5nIHVwIGR1cmluZwpub3JtYWwgb3BlcmF0aW9uLiBUaGUgYW1wbGlmaWVyIGlz
IHJlc2V0dGluZyBvbmx5IGlmIHRoZXJlJ3MgYSBzdHJvbmcKZWxlY3Ryb3N0YXRpYyBkaXNjaGFy
Z2Ugb24gdGhlIGZyb250IHBhbmVsIG9mIHRoZSBkZXZpY2UuIFRoaXMgaXMgbW9zdApsaWtlbHkg
b25seSBnb2luZyB0byBvY2N1ciBkdXJpbmcgYW4gRU1DIHRlc3QuIFRvIHBhc3MgdGhlIEVNQyB0
ZXN0IGEKc2hvcnQgZHJvcG91dCBpcyBhY2NlcHRhYmxlIGFzIGxvbmcgYXMgdGhlIGRldmljZSBj
b250aW51ZXMgbm9ybWFsCm9wZXJhdGlvbiBhZnRlcndhcmRzLgoKT2YgY291cnNlIHRoZXJlJ3Mg
YSBzbWFsbCBsaWtlbGlob29kIHRoYXQgc3VjaCBhbiBlbGVjdHJvc3RhdGljCmRpc2NoYXJnZSB3
aWxsIGhhcHBlbiBpbiByZWFsIGxpZmUsIGJ1dCB3ZSBoYXZlIG5ldmVyIHNlZW4gdGhpcwpoYXBw
ZW5pbmcgc28gZmFyIGFuZCBpZiBpdCB3aWxsIGhhcHBlbiB0aGUgdXNlciB3aWxsIG1vc3QgbGlr
ZWx5IHByZWZlcgphIHNob3J0IGRyb3BvdXQgb3ZlciBjb21wbGV0ZSBmYWlsdXJlLgoKClJlZ2Fy
ZHMsClN2ZW4KCgotLSAKU3ZlbiBOZXVtYW5uCkhlYWQgb2YgUkFVTUZFTEQgU29mdHdhcmUgRGV2
ZWxvcG1lbnQKCkxhdXRzcHJlY2hlciBUZXVmZWwgR21iSCB8IELDvGxvd3N0ci4gNjYgfCAxMDc4
MyBCZXJsaW4gfCBHZXJtYW55ClRlbDogKzQ5ICgwKTMwLTMwMCA5MzAgMTUzIHwgcy5uZXVtYW5u
QHJhdW1mZWxkLmNvbQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3Jn
Cmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRl
dmVsCg==
