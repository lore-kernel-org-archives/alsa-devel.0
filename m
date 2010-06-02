From: Wan ZongShun <mcuos.com@gmail.com>
Subject: Re: [PATCH v2 1/3]AsoC/nuc900: patch for
	SUBSTREAM_TYPE', 'PCM_TX' and 'PCM_RX' removal
Date: Wed, 2 Jun 2010 18:44:23 +0800
Message-ID: <AANLkTilG3lM9YN8iWVpxnZ8XaleLSONihvL_kjLEZgpK@mail.gmail.com>
References: <4C05F211.7070308@gmail.com> <1275471787.3037.28.camel@odin>
	<20100602104056.GC2457@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f218.google.com (mail-ew0-f218.google.com
	[209.85.219.218])
	by alsa0.perex.cz (Postfix) with ESMTP id EDA30103800
	for <alsa-devel@alsa-project.org>;
	Wed,  2 Jun 2010 12:44:23 +0200 (CEST)
Received: by ewy10 with SMTP id 10so1628515ewy.22
	for <alsa-devel@alsa-project.org>; Wed, 02 Jun 2010 03:44:23 -0700 (PDT)
In-Reply-To: <20100602104056.GC2457@opensource.wolfsonmicro.com>
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
Cc: alsa-devel <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

MjAxMC82LzIgTWFyayBCcm93biA8YnJvb25pZUBvcGVuc291cmNlLndvbGZzb25taWNyby5jb20+
Ogo+IE9uIFdlZCwgSnVuIDAyLCAyMDEwIGF0IDEwOjQzOjA3QU0gKzAxMDAsIExpYW0gR2lyZHdv
b2Qgd3JvdGU6Cj4+IE9uIFdlZCwgMjAxMC0wNi0wMiBhdCAxMzo1NCArMDgwMCwgV2FuIFpvbmdT
aHVuIHdyb3RlOgo+PiA+IFRoaXMgcGF0Y2ggaXMgdG8gcmVtb3ZlIHRoZSAnU1VCU1RSRUFNX1RZ
UEUnLCdQQ01fVFgnIGFuZCAnUENNX1JYJyBkZWZpbml0aW9uLgo+PiA+Cj4+ID4gVGhlcmUgaXMg
bm8gbmVlZCB0byByZWRlZmluZSBTTkRSVl9QQ01fU1RSRUFNX1BMQVlCQUNLIGFzIFBDTV9UWCwK
Pj4gPiB0aGUgU1VCU1RSRUFNX1RZUEUoc3Vic3RyZWFtKSBjYW4gYmUgZGVsZXRlZCB0b28sIHRo
ZSBwbGF5YmFjayBvciByZWNvcmQgY2FuIGJlCj4+ID4ganVkZ2VkIGJ5ICdpZiAoc3Vic3RyZWFt
LT5zdHJlYW0gPT0gU05EUlZfUENNX1NUUkVBTV9QTEFZQkFDSyknIGRpcmVjdGx5IHJhdGhlcgo+
PiA+IHRoYW4gJ2lmIChQQ01fVFggPT0gc3R5cGUpJywgd2hpY2ggbWFrZXMgdGhlIGNvZGVzIGVh
c3kgdG8gcmVhZC4KPj4gPgo+PiA+IFNpZ25lZC1vZmYtYnk6IFdhbiBab25nU2h1bjxtY3Vvcy5j
b21AZ21haWwuY29tPgo+Cj4gTm90ZSBoZXJlIHRoYXQgeW91J3JlIHN0aWxsIG1pc3NpbmcgYSBz
cGFjZSBiZXR3ZW4geW91ciBuYW1lIGFuZCBlLW1haWwKPiBhZGRyZXNzLgo+Ck9rYXksIHRoYW5r
IHlvdS4KYnV0IEkgdXNlICdzY3JpcHRzL2NoZWNrcGF0Y2gucGwnIHRvIGNoZWNrIG15IHBhdGNo
LCBpdCBzZWVtcyBubwp3YXJuaW5nIG9yIGVycm9yLjopCgo+PiBBbGwKPgo+PiBBY2tlZC1ieTog
TGlhbSBHaXJkd29vZCA8bHJnQHNsaW1sb2dpYy5jby51az4KPgo+IEkndmUgYXBwbGllZCBhbGwg
dGhlIHBhdGNoZXMsIHNpbmNlIEkgaGFkIHRvIGZpeCB1cCB0aGUgY2hhbmdlbG9ncwo+IGFueXdh
eSBJIHVwZGF0ZWQgdGhlIG1zIHRvIHVzIGluIHRoZSBjaGFuZ2Vsb2cgZm9yIHBhdGNoIDIuIMKg
VGhhbmtzLgo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
Cj4gQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKPiBBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcK
PiBodHRwOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1k
ZXZlbAo+CgoKCi0tIAoqbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbWFpbCBhZGRyOmxp
bnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwp5b3UgY2FuIHN1YnNjcmliZSBieToK
aHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2Vy
bmVsCgoqIGxpbnV4LWFybS1OVUM5MDAgbWFpbGluZyBsaXN0Cm1haWwgYWRkcjpOVUM5MDBAZ29v
Z2xlZ3JvdXBzLmNvbQptYWluIHdlYjogaHR0cHM6Ly9ncm91cHMuZ29vZ2xlLmNvbS9ncm91cC9O
VUM5MDAKeW91IGNhbiBzdWJzY3JpYmUgaXQgYnkgc2VuZGluZyBtZSBtYWlsOgptY3Vvcy5jb21A
Z21haWwuY29tCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRw
Oi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
