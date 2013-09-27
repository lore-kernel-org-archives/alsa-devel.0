From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] ASoC: rcar: remove unnecessary mach/clock.h
Date: Fri, 27 Sep 2013 14:24:36 +0900
Message-ID: <20130927052434.GC31063@verge.net.au>
References: <87mwn2r5i7.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from kirsty.vergenet.net (kirsty.vergenet.net [202.4.237.240])
 by alsa0.perex.cz (Postfix) with ESMTP id A392C26500D
 for <alsa-devel@alsa-project.org>; Fri, 27 Sep 2013 07:24:41 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <87mwn2r5i7.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
List-Id: alsa-devel@alsa-project.org

T24gVHVlLCBTZXAgMjQsIDIwMTMgYXQgMDE6MjU6MDhBTSAtMDcwMCwgS3VuaW5vcmkgTW9yaW1v
dG8gd3JvdGU6Cj4gJHtMSU5VWH0vc291bmQvc29jL3NoIGRyaXZlciBjYW4gYmUgY29tcGlsZWQg
ZnJvbQo+IFN1cGVySCBhbmQgQVJNLgo+IGJ1dCwgJHtMSU5VWH0vc291bmQvc29jL3NoL3JjYXIg
ZHJpdmVyIGluY2x1ZGVkCj4gU0gtQVJNIHNwZWNpZmljIGhlYWRlci4KPiBUaGlzIHBhdGNoIHJl
bW92ZXMgaXQKPiAKPiBTaWduZWQtb2ZmLWJ5OiBLdW5pbm9yaSBNb3JpbW90byA8a3VuaW5vcmku
bW9yaW1vdG8uZ3hAcmVuZXNhcy5jb20+CgoKQWNrZWQtYnk6IFNpbW9uIEhvcm1hbiA8aG9ybXMr
cmVuZXNhc0B2ZXJnZS5uZXQuYXU+Cgo+IC0tLQo+ICBzb3VuZC9zb2Mvc2gvcmNhci9hZGcuYyB8
ICAgIDEgLQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBkZWxldGlvbigtKQo+IAo+IGRpZmYgLS1naXQg
YS9zb3VuZC9zb2Mvc2gvcmNhci9hZGcuYyBiL3NvdW5kL3NvYy9zaC9yY2FyL2FkZy5jCj4gaW5k
ZXggYWQ5Y2ViOS4uOTQzMDA5NyAxMDA2NDQKPiAtLS0gYS9zb3VuZC9zb2Mvc2gvcmNhci9hZGcu
Ywo+ICsrKyBiL3NvdW5kL3NvYy9zaC9yY2FyL2FkZy5jCj4gQEAgLTgsNyArOCw2IEBACj4gICAq
IGZvciBtb3JlIGRldGFpbHMuCj4gICAqLwo+ICAjaW5jbHVkZSA8bGludXgvc2hfY2xrLmg+Cj4g
LSNpbmNsdWRlIDxtYWNoL2Nsb2NrLmg+Cj4gICNpbmNsdWRlICJyc25kLmgiCj4gIAo+ICAjZGVm
aW5lIENMS0EJMAo+IC0tIAo+IDEuNy45LjUKPiAKCi0tIApTaW1vbiBIb3JtYW4v44Ob44O844Oe
44OzIOOCteOCpOODouODsyAgICAgICAgc2ltb25AaG9ybXMubmV0Ckhvcm1zIFNvbHV0aW9ucyDm
oKrlvI/kvJrnpL4gICAgICAgICAgICAgICAgd3d3Lmhvcm1zLm5ldArjgJI2NTEtMDA4NCDlhbXl
uqvnnIznpZ7miLjluILkuK3lpK7ljLrno6/ovrrpgJo0LTEtOCBJVEPjg5Pjg6s5MDHlj7cKVGVs
OiAwMyA2MzY1IDU5NzcgICAgICAgICAgICAgICAgICAgRmF4OiAwMyA2NjczIDQyNjgKU2t5cGU6
IGhvcm1zNwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpB
bHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDov
L21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
