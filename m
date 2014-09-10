From: Benoit Cousson <bcousson@baylibre.com>
Subject: Re: [PATCH] ASoC:simple-card: Add multi-CODEC support
Date: Wed, 10 Sep 2014 18:27:26 +0200
Message-ID: <54107BEE.5010602@baylibre.com>
References: <54103671.c36bb40a.2743.ffff969aSMTPIN_ADDED_MISSING@mx.google.com>	<5410394A.1030508@baylibre.com>
 <20140910180639.6a92a33c@armhf>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-we0-f182.google.com (mail-we0-f182.google.com
 [74.125.82.182])
 by alsa0.perex.cz (Postfix) with ESMTP id A60DF261A83
 for <alsa-devel@alsa-project.org>; Wed, 10 Sep 2014 18:27:27 +0200 (CEST)
Received: by mail-we0-f182.google.com with SMTP id k48so3291322wev.27
 for <alsa-devel@alsa-project.org>; Wed, 10 Sep 2014 09:27:27 -0700 (PDT)
In-Reply-To: <20140910180639.6a92a33c@armhf>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jean-Francois Moine <moinejf@free.fr>
Cc: Xiubo Li <Li.Xiubo@freescale.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Jyri Sarha <jsarha@ti.com>
List-Id: alsa-devel@alsa-project.org

T24gMTAvMDkvMjAxNCAxODowNiwgSmVhbi1GcmFuY29pcyBNb2luZSB3cm90ZToKPiBPbiBXZWQs
IDEwIFNlcCAyMDE0IDEzOjQzOjA2ICswMjAwCj4gQmVub2l0IENvdXNzb24gPGJjb3Vzc29uQGJh
eWxpYnJlLmNvbT4gd3JvdGU6Cj4KPj4+ICsJCWNvZGVjQDAgewo+Pj4gKwkJCXNvdW5kLWRhaSA9
IDwmaGRtaSAwPjsKPj4+ICsJCX07Cj4+PiArCQljb2RlY0AxIHsKPj4+ICsJCQlzb3VuZC1kYWkg
PSA8JnNwZGlmX2NvZGVjPjsKPj4+ICAgIAkJfTsKPj4KPj4gSSBkb24ndCBoYXZlIHN0cm9uZyBv
cGluaW9uIG9uIHRoYXQsIGJ1dCBpbiBteSBjYXNlLCBJIHdhcyBjb25zaWRlcmluZwo+PiB1c2lu
ZyBhIHNpbXBsZSBsaXN0IGluc3RlYWQgb2Ygc2V2ZXJhbCBub2Rlcy4KPj4gSSBkb24ndCBsaWtl
IGhhdmluZyB0byBhZGQgZmFrZSBhZGRyZXNzIGp1c3QgdG8gZW5zdXJlIHVuaXF1ZW5lc3MuCj4+
Cj4+IFNvbWV0aGluZyBsaWtlIHRoYXQ6Cj4+Cj4+ICAgIHNvdW5kLWRhaXMgPSA8JnNwZGlmX2Nv
ZGVjIDE+LCA8JmhkbWkgMD47Cj4KPiBZb3UgYXJlIHJpZ2h0LCB0aGlzIHdvdWxkIGJlIHNpbXBs
ZXIgKEkgZGlkIG5vdCBzZWUgdGhhdCB0aGVyZSBjb3VsZCBiZQo+IHBoYW5kbGUncyB3aXRoIGRp
ZmZlcmVudCBjZWxsIHNpemVzIGluIGEgbGlzdCkuCgpJbiBmYWN0IHlvdSBjYW5ub3QsIHRoYXQg
d2h5IEkgYWRkZWQgdGhlIHNhbWUgbnVtYmVyIG9mIHBhcmFtZXRlcnMgZm9yIApib3RoLgoKRm9y
IERULCBpdCBpcyBqdXN0IGEgbGlzdCBvZiBlbGVtZW50cywgaXQgY291bGQgYmUgZW5jb2RlZCBs
aWtlIHRoYXQ6Cjwmc3BkaWZfY29kZWMgMSAmaGRtaSAwPjsKCkF0IHRoZSBlbmQgaXQgd2lsbCBi
ZSBhIGxpc3Qgb2YgdTMyIGluc2lkZSB0aGUgZHRiLgoKQlRXLCB3aGF0IGlzIHRoYXQgZXh0cmEg
cGFyYW1ldGVyIGFmdGVyIHRoZSBwaGFuZGxlPyBJIGNhbm5vdCBmaW5kIGFueSAKcmVmZXJlbmNl
IG9mIHRoYXQgaW5zaWRlIHRoZSBEb2N1bWVudGF0aW9uLgoKSWYgd2UgbmVlZCB0byBoYXZlIGEg
cmFuZG9tIG51bWJlciBvZiBwYXJhbWV0ZXJzIGFmdGVyIHRoZSBjb2RlLWRhaSAKcGhhbmRsZSwg
d2UgY291bGRuJ3QgdXNlIHRoYXQgbGlzdC4KCj4+IFRoYXQgYmVpbmcgc2FpZCwgaXQgd2lsbCBy
ZXF1aXJlIGNoYW5naW5nIHRoZSBuYW1lIHdpdGggYSBwbHVyYWwgZm9ybSwKPj4gYW5kIGVuc3Vy
aW5nIHdlIGhhdmUgdGhlIHNhbWUgbnVtYmVyIG9mIHBhcmFtZXRlcnMgZm9yIGVhY2ggY29kZWMu
Cj4KPiBCdXQgSSBkb24ndCB0aGluayB0aGF0IGNoYW5naW5nIHRoZSBuYW1lIGNvdWxkIGJlIHVz
ZWZ1bDogdGhlIHRyZWF0bWVudAo+IGlzIGV4YWN0bHkgdGhlIHNhbWUgYW5kLCBhcyBhIHJlc3Vs
dCwgYWxsIENPREVDIERBSXMgZ28gdG8gdGhlIERBSQo+IGxpc3Qgb2YgdGhlIERBSSBsaW5rLgoK
WWVhaCwgbWF5YmUgbm90IHRoYXQgdXNlZnVsLCBidXQgdGhhdCB3YXMganVzdCB0byBiZSBhbGln
bmVkIHdpdGggCnNpbWlsYXIgY2FzZXMgaW4gRFQgYmluZGluZ3MuIExpa2UgZ3Bpb3MsIGludGVy
cnVwdHMuLi4KCgpSZWdhcmRzLApCZW5vaXQKCgotLSAKQmVub8OudCBDb3Vzc29uCkJheUxpYnJl
CkVtYmVkZGVkIExpbnV4IFRlY2hub2xvZ3kgTGFiCnd3dy5iYXlsaWJyZS5jb20KX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5n
IGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJv
amVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
