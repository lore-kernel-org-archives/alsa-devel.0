From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 10/11] mfd: Drop obsolete JZ4740 driver
Date: Tue, 13 Aug 2019 11:30:22 +0100
Message-ID: <20190813103022.GB26727@dell>
References: <20190725220215.460-1-paul@crapouillou.net>
 <20190725220215.460-11-paul@crapouillou.net>
 <20190812081640.GA26727@dell>
 <4b48e597-951e-45fd-dfb2-4a1292a8b067@amsat.org>
 <1565690508.1856.0@crapouillou.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <1565690508.1856.0@crapouillou.net>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Paul Cercueil <paul@crapouillou.net>
Cc: Mark Rutland <mark.rutland@arm.com>, linux-fbdev@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, James Hogan <jhogan@kernel.org>, alsa-devel@alsa-project.org, dri-devel@lists.freedesktop.org, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, od@zcrc.me, linux-mtd@lists.infradead.org, Miquel Raynal <miquel.raynal@bootlin.com>, Artur Rojek <contact@artur-rojek.eu>, Richard Weinberger <richard@nod.at>, linux-pm@vger.kernel.org, Paul Burton <paul.burton@mips.com>, linux-mips@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, devicetree@vger.kernel.org, Jean Delvare <jdelvare@suse.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Mark Brown <broonie@kernel.org>, linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>, Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>, Sebastian Reichel <sre@kerne>
List-Id: alsa-devel@alsa-project.org

T24gVHVlLCAxMyBBdWcgMjAxOSwgUGF1bCBDZXJjdWVpbCB3cm90ZToKCj4gSGkgUGhpbGlwcGUs
Cj4gCj4gCj4gTGUgbWFyLiAxMyBhb8O7dCAyMDE5IMOgIDEwOjQ0LCBQaGlsaXBwZSA9P2lzby04
ODU5LTE/cT9NYXRoaWV1LURhdWQ9RTk/PQo+IDxmNGJ1Z0BhbXNhdC5vcmc+IGEgw6ljcml0IDoK
PiA+IEhpIExlZSwKPiA+IAo+ID4gT24gOC8xMi8xOSAxMDoxNiBBTSwgTGVlIEpvbmVzIHdyb3Rl
Ogo+ID4gPiAgT24gVGh1LCAyNSBKdWwgMjAxOSwgUGF1bCBDZXJjdWVpbCB3cm90ZToKPiA+ID4g
Cj4gPiA+ID4gIEl0IGhhcyBiZWVuIHJlcGxhY2VkIHdpdGggdGhlIGluZ2VuaWMtaWlvIGRyaXZl
ciBmb3IgdGhlIEFEQy4KPiA+ID4gPiAKPiA+ID4gPiAgU2lnbmVkLW9mZi1ieTogUGF1bCBDZXJj
dWVpbCA8cGF1bEBjcmFwb3VpbGxvdS5uZXQ+Cj4gPiA+ID4gIFRlc3RlZC1ieTogQXJ0dXIgUm9q
ZWsgPGNvbnRhY3RAYXJ0dXItcm9qZWsuZXU+Cj4gPiA+ID4gIC0tLQo+ID4gPiA+ICAgZHJpdmVy
cy9tZmQvS2NvbmZpZyAgICAgIHwgICA5IC0tCj4gPiA+ID4gICBkcml2ZXJzL21mZC9NYWtlZmls
ZSAgICAgfCAgIDEgLQo+ID4gPiA+ICAgZHJpdmVycy9tZmQvano0NzQwLWFkYy5jIHwgMzI0Cj4g
PiA+ID4gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCj4gPiA+ID4gICAz
IGZpbGVzIGNoYW5nZWQsIDMzNCBkZWxldGlvbnMoLSkKPiA+ID4gPiAgIGRlbGV0ZSBtb2RlIDEw
MDY0NCBkcml2ZXJzL21mZC9qejQ3NDAtYWRjLmMKPiA+ID4gCj4gPiA+ICBBcHBsaWVkLCB0aGFu
a3MuCj4gPiAKPiA+IEl0IHNlZW1zIHRoZSByZXBsYWNlbWVudCBpcyBkb25lIGluICJNSVBTOiBx
aV9sYjYwOiBNaWdyYXRlIHRvCj4gPiBkZXZpY2V0cmVlIiB3aGljaCBpcyBub3QgeWV0IG1lcmdl
ZC4KPiAKPiBJdCdzIG1lcmdlZCBpbiB0aGUgTUlQUyB0cmVlLCB0aG91Z2gsIHNvIGl0J2xsIGJs
ZW5kIHRvZ2V0aGVyIGp1c3QKPiBmaW5lIGluIGxpbnV4LW5leHQuCgpXb25kZXJmdWwuICBUaGFu
a3MgUGF1bC4KCi0tIApMZWUgSm9uZXMgW+adjueQvOaWr10KTGluYXJvIFNlcnZpY2VzIFRlY2hu
aWNhbCBMZWFkCkxpbmFyby5vcmcg4pSCIE9wZW4gc291cmNlIHNvZnR3YXJlIGZvciBBUk0gU29D
cwpGb2xsb3cgTGluYXJvOiBGYWNlYm9vayB8IFR3aXR0ZXIgfCBCbG9nCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmRyaS1kZXZlbCBtYWlsaW5nIGxpc3QK
ZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9w
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbA==
