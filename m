From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH RFC 09/11] sound/core: add IEC958 channel status helper
Date: Tue, 31 Mar 2015 10:16:03 +0100
Message-ID: <20150331091603.GQ24899@n2100.arm.linux.org.uk>
References: <20150330193911.GM24899@n2100.arm.linux.org.uk>
 <E1YcfYA-0002vc-Al@rmk-PC.arm.linux.org.uk>
 <1427793034.2969.17.camel@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <1427793034.2969.17.camel@pengutronix.de>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, dri-devel@lists.freedesktop.org, Jaroslav Kysela <perex@perex.cz>, Mark Brown <broonie@kernel.org>, Yakir Yang <ykk@rock-chips.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

T24gVHVlLCBNYXIgMzEsIDIwMTUgYXQgMTE6MTA6MzRBTSArMDIwMCwgUGhpbGlwcCBaYWJlbCB3
cm90ZToKPiBUaGlzIGZhaWxzIHRvIGJ1aWxkIGZvciBtZSBvbiA0LjAtcmM2Ogo+IG1ha2VbMl06
ICoqKiBObyBydWxlIHRvIG1ha2UgdGFyZ2V0ICdzb3VuZC9jb3JlL3NuZC1wY20taWVjOTU4Lm8n
LCBuZWVkZWQgYnkgJ3NvdW5kL2NvcmUvc25kLXBjbS5vJy4gIFN0b3AuCj4gc2NyaXB0cy9NYWtl
ZmlsZS5idWlsZDo0MDM6IHJlY2lwZSBmb3IgdGFyZ2V0ICdzb3VuZC9jb3JlJyBmYWlsZWQKClll
cywgSSBvcmlnaW5hbGx5IGhhZCB0aGlzIGFzIGEgc2VwYXJhdGUgbW9kdWxlLCBidXQgZGVjaWRl
ZCBpdCB3YXMgc2lsbHksCnNvIHB1dCBpdCBpbiB0aGUgbWFpbiBzbmQtcGNtIG1vZHVsZSBpbnN0
ZWFkLgoKTmF0dXJhbGx5LCBpdCBidWlsZHMgZm9yIG1lIGJlY2F1c2UgdGhlIHRhcmdldCBvYmpl
Y3QgZXhpc3RzIGluIG15IGJ1aWxkCnRyZWUgZnJvbSB0aGUgZmlyc3Qgd2F5Li4uCgo+IC0tLSBh
L3NvdW5kL2NvcmUvTWFrZWZpbGUKPiArKysgYi9zb3VuZC9jb3JlL01ha2VmaWxlCj4gQEAgLTE0
LDEyICsxNCwxMSBAQCBzbmQtcGNtLXkgOj0gcGNtLm8gcGNtX25hdGl2ZS5vIHBjbV9saWIubyBw
Y21fdGltZXIubyBwY21fbWlzYy5vIFwKPiAgICAgICAgICAgICAgICAgcGNtX21lbW9yeS5vIG1l
bWFsbG9jLm8KPiAgc25kLXBjbS0kKENPTkZJR19TTkRfRE1BX1NHQlVGKSArPSBzZ2J1Zi5vCj4g
IHNuZC1wY20tJChDT05GSUdfU05EX1BDTV9FTEQpICs9IHBjbV9kcm1fZWxkLm8KPiAtc25kLXBj
bS0kKENPTkZJR19TTkRfUENNX0lFQzk1OCkgKz0gc25kLXBjbS1pZWM5NTgubwo+ICtzbmQtcGNt
LSQoQ09ORklHX1NORF9QQ01fSUVDOTU4KSArPSBwY21faWVjOTU4Lm8KPiAgCj4gICMgZm9yIHRy
YWNlLXBvaW50cwo+ICBDRkxBR1NfcGNtX2xpYi5vIDo9IC1JJChzcmMpCj4gIAo+IC1zbmQtcGNt
LWllYzk1OC1vYmpzIDo9IHBjbV9pZWM5NTgubwo+ICBzbmQtcGNtLWRtYWVuZ2luZS1vYmpzIDo9
IHBjbV9kbWFlbmdpbmUubwo+ICAKPiAgc25kLXJhd21pZGktb2JqcyAgOj0gcmF3bWlkaS5vCgpZ
ZXAsIHRoYXQncyBvYnZpb3VzbHkgd2hhdCBJIHdhbnRlZCAtIGdvb2QgY2F0Y2gsIHRoYW5rcyEK
Ci0tIApGVFRDIGJyb2FkYmFuZCBmb3IgMC44bWlsZSBsaW5lOiBjdXJyZW50bHkgYXQgMTAuNU1i
cHMgZG93biA0MDBrYnBzIHVwCmFjY29yZGluZyB0byBzcGVlZHRlc3QubmV0LgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpkcmktZGV2ZWwgbWFpbGluZyBs
aXN0CmRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cDovL2xpc3RzLmZyZWVkZXNr
dG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbAo=
