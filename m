From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] ASoC: fsl: select SND_SOC_IMX_PCM_DMA
	where needed
Date: Tue, 29 Apr 2014 12:37:45 +0200
Message-ID: <4270904.84oGcCXL4B@wuerfel>
References: <6606961.lAGLvkNsEj@wuerfel> <6285923.UQqcZVikjI@wuerfel>
 <1398740853.880576398@f238.i.mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
 by alsa0.perex.cz (Postfix) with ESMTP id 6F575264F26
 for <alsa-devel@alsa-project.org>; Tue, 29 Apr 2014 12:38:14 +0200 (CEST)
In-Reply-To: <1398740853.880576398@f238.i.mail.ru>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: linux-arm-kernel@lists.infradead.org, Alexander Shiyan <shc_work@mail.ru>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

T24gVHVlc2RheSAyOSBBcHJpbCAyMDE0IDA3OjA3OjMzIEFsZXhhbmRlciBTaGl5YW4gd3JvdGU6
Cj4gTW9uLCAyOCBBcHIgMjAxNCAyMzoxMjoxNCArMDIwMCDQvtGCIEFybmQgQmVyZ21hbm4gPGFy
bmRAYXJuZGIuZGU+Ogo+ID4gT24gVHVlc2RheSAyOSBBcHJpbCAyMDE0IDAwOjM1OjQxIEFsZXhh
bmRlciBTaGl5YW4gd3JvdGU6Cj4gPiA+IAo+ID4gPiBTbywgSSBkb24ndCB1bmRlcnN0YW5kIHdo
eSB0aGlzIGVycm9yIGhhcHBlbiwgYXMgd2VsbCBhcyBJIGNhbiBub3QKPiA+ID4gcmVwcm9kdWNl
IHRoaXMuLi4KPiA+IAo+ID4gSXQncyBwcm9iYWJseSBDT05GSUdfU05EX1NPQ19JTVhfUENNX0RN
QT1tIGFuZCBDT05GSUdfU05EX1NPQ19GU0xfU1NJPXkgdGhlbi4KPiA+IFdoYXQgaXMgdGhlIGlu
dGVuZGVkIGJlaGF2aW9yIGluIHRoaXMgY2FzZT8gU2hvdWxkIENPTkZJR19TTkRfU09DX0ZTTF9T
U0kKPiA+IGJlIGZvcmNlZCB0byBiZSBhIG1vZHVsZSBhcyB3ZWxsPwo+IAo+IEhtbSwgeWVzLi4u
Cj4gSSB0aG91Z2h0IHRoYXQgSSBoYWQgYWxyZWFkeSBzb2x2ZWQgYSBzaW1pbGFyIHByb2JsZW0g
Zm9yIHRoZSBlYXJsaWVyCj4gdmVyc2lvbiBvZiB0aGUgcGF0Y2ggLi4uCgpIb3cgYWJvdXQgdGhp
cz8KClNpZ25lZC1vZmYtYnk6IEFybmQgQmVyZ21hbm4gPGFybmRAYXJuZGIuZGU+CgpkaWZmIC0t
Z2l0IGEvc291bmQvc29jL2ZzbC9LY29uZmlnIGIvc291bmQvc29jL2ZzbC9LY29uZmlnCmluZGV4
IGZiMjYzNDUuLmFmMGJiOTIgMTAwNjQ0Ci0tLSBhL3NvdW5kL3NvYy9mc2wvS2NvbmZpZworKysg
Yi9zb3VuZC9zb2MvZnNsL0tjb25maWcKQEAgLTksNiArOSw3IEBAIGNvbmZpZyBTTkRfU09DX0ZT
TF9TQUkKIAogY29uZmlnIFNORF9TT0NfRlNMX1NTSQogCXRyaXN0YXRlICJTeW5jaHJvbm91cyBT
ZXJpYWwgSW50ZXJmYWNlIG1vZHVsZSBzdXBwb3J0IgorCWRlcGVuZHMgb24gbSB8fCBTTkRfU09D
X0lNWF9QQ01fRE1BICE9IG0KIAloZWxwCiAJICBTYXkgWSBpZiB5b3Ugd2FudCB0byBhZGQgU3lu
Y2hyb25vdXMgU2VyaWFsIEludGVyZmFjZSAoU1NJKQogCSAgc3VwcG9ydCBmb3IgdGhlIEZyZWVz
Y2FsZSBDUFVzLgpAQCAtMTgsNiArMTksNyBAQCBjb25maWcgU05EX1NPQ19GU0xfU1NJCiBjb25m
aWcgU05EX1NPQ19GU0xfU1BESUYKIAl0cmlzdGF0ZSAiU29ueS9QaGlsaXBzIERpZ2l0YWwgSW50
ZXJmYWNlIG1vZHVsZSBzdXBwb3J0IgogCXNlbGVjdCBSRUdNQVBfTU1JTworCWRlcGVuZHMgb24g
bSB8fCBTTkRfU09DX0lNWF9QQ01fRE1BICE9IG0KIAloZWxwCiAJICBTYXkgWSBpZiB5b3Ugd2Fu
dCB0byBhZGQgU29ueS9QaGlsaXBzIERpZ2l0YWwgSW50ZXJmYWNlIChTUERJRikKIAkgIHN1cHBv
cnQgZm9yIHRoZSBGcmVlc2NhbGUgQ1BVcy4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxz
YS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlz
dGluZm8vYWxzYS1kZXZlbAo=
