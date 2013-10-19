From: Jean-Francois Moine <moinejf@free.fr>
Subject: Re: [PATCH v3 2/2] ASoC: kirkwood: fix loss of
 external clock at probe time
Date: Sat, 19 Oct 2013 10:28:09 +0200
Message-ID: <20131019102809.180dc4ff@armhf>
References: <20131018203555.4d974251@armhf>
 <20131018191259.GF10079@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
 by alsa0.perex.cz (Postfix) with ESMTP id 6A66B2615D1
 for <alsa-devel@alsa-project.org>; Sat, 19 Oct 2013 10:28:04 +0200 (CEST)
In-Reply-To: <20131018191259.GF10079@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@pengutronix.de>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, alsa-devel@alsa-project.org, Jason Cooper <jason@lakedaemon.net>, Mark Brown <broonie@kernel.org>, Russell King <rmk+kernel@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: alsa-devel@alsa-project.org

T24gRnJpLCAxOCBPY3QgMjAxMyAyMToxMjo1OSArMDIwMApVd2UgS2xlaW5lLUvDtm5pZyA8dS5r
bGVpbmUta29lbmlnQHBlbmd1dHJvbml4LmRlPiB3cm90ZToKCj4gPiArCWlmIChJU19FUlIocHJp
di0+ZXh0Y2xrKSkgewo+ID4gKwkJaWYgKFBUUl9FUlIocHJpdi0+ZXh0Y2xrKSA9PSAtRVBST0JF
X0RFRkVSKQo+ID4gKwkJCXJldHVybiAtRVBST0JFX0RFRkVSOyAgCj4gTWF5YmUgdGhlIGJldHRl
ciBsb2dpYyBoZXJlIGlzOgo+IAkJaWYgKCFQVFJfRVJSKHByaXYtPmV4dGNsaykgPT0gLUVOT0VO
VCkKPiAJCQlyZXR1cm4gUFRSX0VSUihwcml2LT5leHRjbGspOwo+IAo+ID8KCk5vLiBUaGlzIHBh
dGNoIGlzIGFzc29jaWF0ZWQgd2l0aCBhbiBvdGhlciBvbmUgd2hpY2ggcmV0dXJucwotRVBST0JF
X0RFRkVSIHdoZW4gdGhlIGV4dGVybmFsIGNsb2NrIGlzIGRlY2xhcmVkIGluIHRoZSBEVCBhbmQg
d2hlbgp0aGUgY2xvY2sgZHJpdmVyIGlzIG5vdCB5ZXQgaW5pdGlhbGl6ZWQuIFRoZW4sIHRoZSBr
aXJrd29vZCBtb2R1bGVzCm11c3QgYmUgcHJvYmVkIGxhdGVyLgoKRm9yIGFueSBvdGhlciBlcnJv
ciwgdGhlIGV4dGVybmFsIGNsb2NrIGlzIG5vdCB1c2VkLCBhbmQgaXQgaXMgbm90IGVhc3kKdG8g
a25vdyBpZiB0aGUgZXJyb3IgaXMgZHVlIHRvIHRoZSBhYnNlbmNlIG9mIGV4dGVybmFsIGNsb2Nr
IGluIHRoZSBEVApvciB0byBhIERUIHBhcnNpbmcgZXJyb3Igb3IgdG8gYW55dGhpbmcgZWxzZS4K
Cj4gPiArCX0gZWxzZSB7Cj4gPiArCQlkZXZfaW5mbygmcGRldi0+ZGV2LCAiZm91bmQgZXh0ZXJu
YWwgY2xvY2tcbiIpOwo+ID4gKwkJY2xrX3ByZXBhcmVfZW5hYmxlKHByaXYtPmV4dGNsayk7Cj4g
PiArCQlzb2NfZGFpID0ga2lya3dvb2RfaTJzX2RhaV9leHRjbGs7ICAKPiBBbm90aGVyIHRvZG8g
KHRoYXQgaXMgYWxyZWFkeSBpbiB0aGUgcGF0Y2hlZCBjb2RlKSBpcyB0aGF0IHlvdSBzaG91bGQK
PiBjaGVjayB0aGUgcmV0dXJuIHZhbHVlIG9mIGNsa19wcmVwYXJlX2VuYWJsZS4KCllvdSBhcmUg
cmlnaHQsIGJ1dCBhbiBlcnJvciBhdCB0aGlzIGxldmVsIHNob3VsZCBub3Qgb2Z0ZW4gb2NjdXIu
Li4KCi0tIApLZW4gYXIgYydoZW50YcOxCXwJICAgICAgKiogQnJlaXpoIGhhIExpbnV4IGF0YXYh
ICoqCkplZgkJfAkJaHR0cDovL21vaW5lamYuZnJlZS5mci8KX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1k
ZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFp
bG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
