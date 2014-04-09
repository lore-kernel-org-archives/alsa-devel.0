From: Nicolin Chen <Guangyu.Chen@freescale.com>
Subject: Re: [PATCH v3 2/2] ARM: dts: Append clock bindings for sai2 on VF610
 platform
Date: Wed, 9 Apr 2014 15:51:55 +0800
Message-ID: <20140409075154.GA12559@MrMyself>
References: <cover.1396605772.git.Guangyu.Chen@freescale.com>
 <08ba57a2fdce1a404a6bcb61e21e25509fcd6b30.1396605772.git.Guangyu.Chen@freescale.com>
 <20140409075812.GC28420@dragon>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
Content-Disposition: inline
In-Reply-To: <20140409075812.GC28420@dragon>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
To: Shawn Guo <shawn.guo@linaro.org>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, pawel.moll@arm.com, linux-doc@vger.kernel.org, broonie@kernel.org, ijc+devicetree@hellion.org.uk, linux-kernel@vger.kernel.org, robh+dt@kernel.org, timur@tabi.org, Li.Xiubo@freescale.com, rob@landley.net, galak@codeaurora.org, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org

T24gV2VkLCBBcHIgMDksIDIwMTQgYXQgMDM6NTg6MTVQTSArMDgwMCwgU2hhd24gR3VvIHdyb3Rl
Ogo+IE9uIEZyaSwgQXByIDA0LCAyMDE0IGF0IDA2OjA4OjEzUE0gKzA4MDAsIE5pY29saW4gQ2hl
biB3cm90ZToKPiA+IFNpbmNlIHdlIGFkZGVkIGZvdXJzIGNsb2NrIHRvIHRoZSBEVCBiaW5kaW5n
LCB3ZSBzaG91bGQgdXBkYXRlIHRoZSBjdXJyZW50Cj4gPiBTQUkgZHRzL2R0c2kgc28gYXMgbm90
IHRvIGJyZWFrIHRoZWlyIGZ1bmN0aW9ucy4KPiAKPiBJZiBzbywgc2hvdWxkbid0IHRoZSBjaGFu
Z2UgYmUgaW4gdGhlIHNhbWUgcGF0Y2ggYXMgZHJpdmVyIGNoYW5nZT8KCk9rYXkuLkknZCBsaWtl
IHRvIG1lcmdlIHRoZW0gaW50byBvbmUgcGF0Y2guCgpUaGFuayB5b3UsCk5pY29saW4KCj4gCj4g
U2hhd24KPiAKPiA+IAo+ID4gU2lnbmVkLW9mZi1ieTogTmljb2xpbiBDaGVuIDxHdWFuZ3l1LkNo
ZW5AZnJlZXNjYWxlLmNvbT4KPiA+IFRlc3RlZC1ieTogWGl1Ym8gTGkgPExpLlhpdWJvQGZyZWVz
Y2FsZS5jb20+Cj4gPiAtLS0KPiA+ICBhcmNoL2FybS9ib290L2R0cy92ZjYxMC5kdHNpIHwgNiAr
KysrLS0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygt
KQo+ID4gCj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vYm9vdC9kdHMvdmY2MTAuZHRzaSBiL2Fy
Y2gvYXJtL2Jvb3QvZHRzL3ZmNjEwLmR0c2kKPiA+IGluZGV4IGQzMWNlMWIuLjlmZDAwMDcgMTAw
NjQ0Cj4gPiAtLS0gYS9hcmNoL2FybS9ib290L2R0cy92ZjYxMC5kdHNpCj4gPiArKysgYi9hcmNo
L2FybS9ib290L2R0cy92ZjYxMC5kdHNpCj4gPiBAQCAtMTM5LDggKzEzOSwxMCBAQAo+ID4gIAkJ
CQljb21wYXRpYmxlID0gImZzbCx2ZjYxMC1zYWkiOwo+ID4gIAkJCQlyZWcgPSA8MHg0MDAzMTAw
MCAweDEwMDA+Owo+ID4gIAkJCQlpbnRlcnJ1cHRzID0gPDAgODYgMHgwND47Cj4gPiAtCQkJCWNs
b2NrcyA9IDwmY2xrcyBWRjYxMF9DTEtfU0FJMj47Cj4gPiAtCQkJCWNsb2NrLW5hbWVzID0gInNh
aSI7Cj4gPiArCQkJCWNsb2NrcyA9IDwmY2xrcyBWRjYxMF9DTEtfU0FJMj4sCj4gPiArCQkJCSAg
ICAgICA8JmNsa3MgVkY2MTBfQ0xLX1NBSTI+LAo+ID4gKwkJCQkgICAgICAgPCZjbGtzIDA+LCA8
JmNsa3MgMD47Cj4gPiArCQkJCWNsb2NrLW5hbWVzID0gImJ1cyIsICJtY2xrMSIsICJtY2xrMiIs
ICJtY2xrMyI7Cj4gPiAgCQkJCXN0YXR1cyA9ICJkaXNhYmxlZCI7Cj4gPiAgCQkJfTsKPiA+ICAK
PiA+IC0tIAo+ID4gMS44LjQKPiA+IAo+ID4gCj4gCgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpMaW51eHBwYy1kZXYgbWFpbGluZyBsaXN0CkxpbnV4cHBj
LWRldkBsaXN0cy5vemxhYnMub3JnCmh0dHBzOi8vbGlzdHMub3psYWJzLm9yZy9saXN0aW5mby9s
aW51eHBwYy1kZXY=
