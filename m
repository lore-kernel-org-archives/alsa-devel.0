From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] ASoC: fsl: select SND_SOC_IMX_PCM_DMA
	where needed
Date: Tue, 29 Apr 2014 15:30:16 +0200
Message-ID: <4275868.O962kiiyJa@wuerfel>
References: <6606961.lAGLvkNsEj@wuerfel> <4270904.84oGcCXL4B@wuerfel>
 <535F8594.40609@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
 by alsa0.perex.cz (Postfix) with ESMTP id 2BB6226508C
 for <alsa-devel@alsa-project.org>; Tue, 29 Apr 2014 15:30:21 +0200 (CEST)
In-Reply-To: <535F8594.40609@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, Alexander Shiyan <shc_work@mail.ru>, linux-arm-kernel@lists.infradead.org, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

T24gVHVlc2RheSAyOSBBcHJpbCAyMDE0IDEyOjU3OjI0IExhcnMtUGV0ZXIgQ2xhdXNlbiB3cm90
ZToKPiBPbiAwNC8yOS8yMDE0IDEyOjM3IFBNLCBBcm5kIEJlcmdtYW5uIHdyb3RlOgo+ID4gT24g
VHVlc2RheSAyOSBBcHJpbCAyMDE0IDA3OjA3OjMzIEFsZXhhbmRlciBTaGl5YW4gd3JvdGU6Cj4g
Pj4gTW9uLCAyOCBBcHIgMjAxNCAyMzoxMjoxNCArMDIwMCDQvtGCIEFybmQgQmVyZ21hbm4gPGFy
bmRAYXJuZGIuZGU+Ogo+ID4+PiBPbiBUdWVzZGF5IDI5IEFwcmlsIDIwMTQgMDA6MzU6NDEgQWxl
eGFuZGVyIFNoaXlhbiB3cm90ZToKPiA+Pj4+Cj4gPj4+PiBTbywgSSBkb24ndCB1bmRlcnN0YW5k
IHdoeSB0aGlzIGVycm9yIGhhcHBlbiwgYXMgd2VsbCBhcyBJIGNhbiBub3QKPiA+Pj4+IHJlcHJv
ZHVjZSB0aGlzLi4uCj4gPj4+Cj4gPj4+IEl0J3MgcHJvYmFibHkgQ09ORklHX1NORF9TT0NfSU1Y
X1BDTV9ETUE9bSBhbmQgQ09ORklHX1NORF9TT0NfRlNMX1NTST15IHRoZW4uCj4gPj4+IFdoYXQg
aXMgdGhlIGludGVuZGVkIGJlaGF2aW9yIGluIHRoaXMgY2FzZT8gU2hvdWxkIENPTkZJR19TTkRf
U09DX0ZTTF9TU0kKPiA+Pj4gYmUgZm9yY2VkIHRvIGJlIGEgbW9kdWxlIGFzIHdlbGw/Cj4gPj4K
PiA+PiBIbW0sIHllcy4uLgo+ID4+IEkgdGhvdWdodCB0aGF0IEkgaGFkIGFscmVhZHkgc29sdmVk
IGEgc2ltaWxhciBwcm9ibGVtIGZvciB0aGUgZWFybGllcgo+ID4+IHZlcnNpb24gb2YgdGhlIHBh
dGNoIC4uLgo+ID4KPiA+IEhvdyBhYm91dCB0aGlzPwo+IAo+IEhhdmluZyBGU0xfU1NJL0ZTTF9T
UERJRiwgYnV0IG5vdCBTTkRfU09DX0lNWF9QQ01fRE1BIGRvZXMgbm90IG1ha2Ugc2Vuc2Ugb24g
Cj4gaU1YLgo+IFNvIGhvdyBhYm91dDoKPiAKPiAgICAgICAgIHNlbGVjdCBTTkRfU09DX0lNWF9Q
Q01fRE1BIGlmIFNORF9JTVhfU09DCj4gCj4gYW5kIHJlbW92ZSBhbGwgdGhlIG90aGVyICdzZWxl
Y3QgU05EX1NPQ19JTVhfUENNX0RNQScgc3RhdGVtZW50cy4gVGhhdCdzIGluIAo+IG15IG9waW5p
b24gbXVjaCBuaWNlci4KClllcywgbWFrZXMgc2Vuc2UuIFNob3VsZCBJIGRvIGFub3RoZXIgdmVy
c2lvbiBvZiB0aGUgcGF0Y2g/CgoJQXJuZApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2Et
cHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2Fsc2EtZGV2ZWwK
