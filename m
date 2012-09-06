From: =?UTF-8?B?R2HDq3RhbiBDYXJsaWVy?= <gcembed@gmail.com>
Subject: Re: [PATCH 1/1] [ASoC] Fix v2: Revert 'ASoC: imx-ssi:
 Remove mono support'.
Date: Thu, 06 Sep 2012 08:29:51 +0200
Message-ID: <504842DF.3060503@gmail.com>
References: <1346912753-2030-1-git-send-email-gcembed@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ee0-f51.google.com (mail-ee0-f51.google.com [74.125.83.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 8DF98264F53
 for <alsa-devel@alsa-project.org>; Thu,  6 Sep 2012 08:30:49 +0200 (CEST)
Received: by eeke50 with SMTP id e50so472331eek.38
 for <alsa-devel@alsa-project.org>; Wed, 05 Sep 2012 23:30:49 -0700 (PDT)
In-Reply-To: <1346912753-2030-1-git-send-email-gcembed@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: =?UTF-8?B?R2HDq3RhbiBDYXJsaWVy?= <gcembed@gmail.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Takashi Iwai <tiwai@suse.de>, Sascha Hauer <s.hauer@pengutronix.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Javier Martin <javier.martin@vista-silicon.com>, Shawn Guo <shawn.guo@linaro.org>, Liam Girdwood <lrg@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

SGksClNvcnJ5IEkgbWlzc2VkIHRoZSBwYXRjaCBzZW5kIGJ5IEZhYmlvIGVhcmxpZXIuCklnbm9y
ZSB0aGlzIG9uZS4KUmVnYXJkcywKR2HDq3RhbiBDYXJsaWVyLgoKT24gMDkvMDYvMjAxMiAwODoy
NSBBTSwgR2HDq3RhbiBDYXJsaWVyIHdyb3RlOgo+IFdoZW4gcGF0Y2ggb2YgSmF2aWVyIE1hcnRp
biBpcyBhcHBsaWVkIG9uIGxpbnV4LW5leHQtMjAxMjA4MjQKPiB0aGUgcGF0Y2ggZmFpbGVkIGJl
Y2F1c2UgY29tbWVudCBsaW5lIGlzIG1pc3NpbmcuCj4KPiBTaWduZWQtb2ZmLWJ5OiBHYcOrdGFu
IENhcmxpZXIgPGdjZW1iZWRAZ21haWwuY29tPgo+IFNpZ25lZC1vZmYtYnk6IEphdmllciBNYXJ0
aW4gPGphdmllci5tYXJ0aW5AdmlzdGEtc2lsaWNvbi5jb20+Cj4gLS0tCj4gICBzb3VuZC9zb2Mv
ZnNsL2lteC1zc2kuYyB8ICAgIDUgKystLS0KPiAgIDEgZmlsZXMgY2hhbmdlZCwgMiBpbnNlcnRp
b25zKCspLCAzIGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL3NvdW5kL3NvYy9mc2wvaW14
LXNzaS5jIGIvc291bmQvc29jL2ZzbC9pbXgtc3NpLmMKPiBpbmRleCA3MDc0YWU2Li4zYzUyMGM0
IDEwMDY0NAo+IC0tLSBhL3NvdW5kL3NvYy9mc2wvaW14LXNzaS5jCj4gKysrIGIvc291bmQvc29j
L2ZzbC9pbXgtc3NpLmMKPiBAQCAtMzgwLDE0ICszODAsMTMgQEAgc3RhdGljIGludCBpbXhfc3Np
X2RhaV9wcm9iZShzdHJ1Y3Qgc25kX3NvY19kYWkgKmRhaSkKPiAgIHN0YXRpYyBzdHJ1Y3Qgc25k
X3NvY19kYWlfZHJpdmVyIGlteF9zc2lfZGFpID0gewo+ICAgCS5wcm9iZSA9IGlteF9zc2lfZGFp
X3Byb2JlLAo+ICAgCS5wbGF5YmFjayA9IHsKPiAtCQkvKiBUaGUgU1NJIGRvZXMgbm90IHN1cHBv
cnQgbW9uYXVyYWwgYXVkaW8uICovCj4gLQkJLmNoYW5uZWxzX21pbiA9IDIsCj4gKwkJLmNoYW5u
ZWxzX21pbiA9IDEsCj4gICAJCS5jaGFubmVsc19tYXggPSAyLAo+ICAgCQkucmF0ZXMgPSBTTkRS
Vl9QQ01fUkFURV84MDAwXzk2MDAwLAo+ICAgCQkuZm9ybWF0cyA9IFNORFJWX1BDTV9GTVRCSVRf
UzE2X0xFLAo+ICAgCX0sCj4gICAJLmNhcHR1cmUgPSB7Cj4gLQkJLmNoYW5uZWxzX21pbiA9IDIs
Cj4gKwkJLmNoYW5uZWxzX21pbiA9IDEsCj4gICAJCS5jaGFubmVsc19tYXggPSAyLAo+ICAgCQku
cmF0ZXMgPSBTTkRSVl9QQ01fUkFURV84MDAwXzk2MDAwLAo+ICAgCQkuZm9ybWF0cyA9IFNORFJW
X1BDTV9GTVRCSVRfUzE2X0xFLAo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJv
amVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2Fsc2EtZGV2ZWwK
