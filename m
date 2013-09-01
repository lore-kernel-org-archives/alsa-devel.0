From: Jean-Francois Moine <moinejf@free.fr>
Subject: Re: [PATCH 08/14] ASoC: kirkwood: prefer external
 clock over internal clock
Date: Sun, 1 Sep 2013 18:41:53 +0200
Message-ID: <20130901184153.353c644f@armhf>
References: <20130831123458.GF6617@n2100.arm.linux.org.uk>
 <E1VFkVg-0003Ip-G7@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
 by alsa0.perex.cz (Postfix) with ESMTP id C5A2C260845
 for <alsa-devel@alsa-project.org>; Sun,  1 Sep 2013 18:40:47 +0200 (CEST)
In-Reply-To: <E1VFkVg-0003Ip-G7@rmk-PC.arm.linux.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, alsa-devel@alsa-project.org, Jason Cooper <jason@lakedaemon.net>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: alsa-devel@alsa-project.org

T24gU2F0LCAzMSBBdWcgMjAxMyAxMzo0MjozNiArMDEwMApSdXNzZWxsIEtpbmcgPHJtaytrZXJu
ZWxAYXJtLmxpbnV4Lm9yZy51az4gd3JvdGU6Cgo+IFNpZ25lZC1vZmYtYnk6IFJ1c3NlbGwgS2lu
ZyA8cm1rK2tlcm5lbEBhcm0ubGludXgub3JnLnVrPgo+IC0tLQo+ICBzb3VuZC9zb2Mva2lya3dv
b2Qva2lya3dvb2QtaTJzLmMgfCAgIDE2ICsrKysrKysrLS0tLS0tLS0KPiAgMSBmaWxlcyBjaGFu
Z2VkLCA4IGluc2VydGlvbnMoKyksIDggZGVsZXRpb25zKC0pCj4gCj4gZGlmZiAtLWdpdCBhL3Nv
dW5kL3NvYy9raXJrd29vZC9raXJrd29vZC1pMnMuYyBiL3NvdW5kL3NvYy9raXJrd29vZC9raXJr
d29vZC1pMnMuYwo+IGluZGV4IDg0ZGQ5YjAuLjhlMTAzNjkgMTAwNjQ0Cj4gLS0tIGEvc291bmQv
c29jL2tpcmt3b29kL2tpcmt3b29kLWkycy5jCj4gKysrIGIvc291bmQvc29jL2tpcmt3b29kL2tp
cmt3b29kLWkycy5jCj4gQEAgLTEwNCwyMCArMTA0LDIwIEBAIHN0YXRpYyB2b2lkIGtpcmt3b29k
X3NldF9yYXRlKHN0cnVjdCBzbmRfc29jX2RhaSAqZGFpLAo+ICB7Cj4gIAl1aW50MzJfdCBjbGtz
X2N0cmw7Cj4gIAo+IC0JaWYgKHJhdGUgPT0gNDQxMDAgfHwgcmF0ZSA9PSA0ODAwMCB8fCByYXRl
ID09IDk2MDAwKSB7Cj4gLQkJLyogdXNlIGludGVybmFsIGRjbyBmb3Igc3VwcG9ydGVkIHJhdGVz
ICovCj4gLQkJZGV2X2RiZyhkYWktPmRldiwgIiVzOiBkY28gc2V0IHJhdGUgPSAlbHVcbiIsCj4g
LQkJCV9fZnVuY19fLCByYXRlKTsKPiAtCQlraXJrd29vZF9zZXRfZGNvKHByaXYtPmlvLCByYXRl
KTsKPiAtCj4gLQkJY2xrc19jdHJsID0gS0lSS1dPT0RfTUNMS19TT1VSQ0VfRENPOwo+IC0JfSBl
bHNlIGlmICghSVNfRVJSKHByaXYtPmV4dGNsaykpIHsKPiArCWlmICghSVNfRVJSKHByaXYtPmV4
dGNsaykpIHsKPiAgCQkvKiB1c2Ugb3B0aW9uYWwgZXh0ZXJuYWwgY2xrIGZvciBvdGhlciByYXRl
cyAqLwo+ICAJCWRldl9kYmcoZGFpLT5kZXYsICIlczogZXh0Y2xrIHNldCByYXRlID0gJWx1IC0+
ICVsdVxuIiwKPiAgCQkJX19mdW5jX18sIHJhdGUsIDI1NiAqIHJhdGUpOwo+ICAJCWNsa19zZXRf
cmF0ZShwcml2LT5leHRjbGssIDI1NiAqIHJhdGUpOwo+ICAKPiAgCQljbGtzX2N0cmwgPSBLSVJL
V09PRF9NQ0xLX1NPVVJDRV9FWFRDTEs7Cj4gKwl9IGVsc2UgaWYgKHJhdGUgPT0gNDQxMDAgfHwg
cmF0ZSA9PSA0ODAwMCB8fCByYXRlID09IDk2MDAwKSB7CgpUaGUgcmF0ZSBpcyBhbHdheXMgZ29v
ZCwgYW5kIGhhdmluZyB0aGlzIHRlc3QgcmFpc2VzIGEgY29tcGlsYXRpb24gd2FybmluZwooY2xr
c19jdHJsIG1heSBiZSBub3QgaW5pdGlhbGl6ZWQpLgoKCj4gKwkJLyogdXNlIGludGVybmFsIGRj
byBmb3Igc3VwcG9ydGVkIHJhdGVzICovCj4gKwkJZGV2X2RiZyhkYWktPmRldiwgIiVzOiBkY28g
c2V0IHJhdGUgPSAlbHVcbiIsCj4gKwkJCV9fZnVuY19fLCByYXRlKTsKPiArCQlraXJrd29vZF9z
ZXRfZGNvKHByaXYtPmlvLCByYXRlKTsKPiArCj4gKwkJY2xrc19jdHJsID0gS0lSS1dPT0RfTUNM
S19TT1VSQ0VfRENPOwo+ICAJfQo+ICAJd3JpdGVsKGNsa3NfY3RybCwgcHJpdi0+aW8gKyBLSVJL
V09PRF9DTE9DS1NfQ1RSTCk7Cj4gIH0KCgoKLS0gCktlbiBhciBjJ2hlbnRhw7EJfAkgICAgICAq
KiBCcmVpemggaGEgTGludXggYXRhdiEgKioKSmVmCQl8CQlodHRwOi8vbW9pbmVqZi5mcmVlLmZy
LwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRl
dmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxt
YW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
