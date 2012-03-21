From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: [PATCH 3/3] ASoC: omap-mcbsp: Add period size
	protection mode
Date: Wed, 21 Mar 2012 13:55:24 +0200
Message-ID: <CANOLnOMoeykvt2LiiD3fV1MMixpE6Y+orJc9T1CmdaoyN8O2Pg@mail.gmail.com>
References: <1332242021-7494-1-git-send-email-peter.ujfalusi@ti.com>
	<1332242021-7494-4-git-send-email-peter.ujfalusi@ti.com>
	<20120320160154.GI3445@opensource.wolfsonmicro.com>
	<CANOLnOPjqbeEbSDUHokkGRUa7KwJ-+hAczWSmQ3LEccCh9-c7w@mail.gmail.com>
	<4F699003.9070806@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iy0-f179.google.com (mail-iy0-f179.google.com
	[209.85.210.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 67C9B2456B
	for <alsa-devel@alsa-project.org>; Wed, 21 Mar 2012 12:55:25 +0100 (CET)
Received: by iakh37 with SMTP id h37so1528248iak.38
	for <alsa-devel@alsa-project.org>; Wed, 21 Mar 2012 04:55:24 -0700 (PDT)
In-Reply-To: <4F699003.9070806@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org

T24gV2VkLCBNYXIgMjEsIDIwMTIgYXQgMTA6MjMgQU0sIFBldGVyIFVqZmFsdXNpIDxwZXRlci51
amZhbHVzaUB0aS5jb20+IHdyb3RlOgo+IE9uIDAzLzIwLzIwMTIgMDY6MTUgUE0sIEdyYXp2eWRh
cyBJZ25vdGFzIHdyb3RlOgo+PiBJIHdvdWxkbid0IHJlYWxseSBjYWxsIHRoZW0gYnJva2VuLCBp
dCdzIGVub3VnaCB0byBzZXQgcGVyaW9kIHNpemUgdG8KPj4gNTEyIHdpdGggc21hbGxlciBzdGFy
dF90aHJlc2hvbGQgKHNvbWV0aGluZyBsaWtlIDUwbXMpIHRvIGhhdmUKPj4gcHJvYmxlbXMsIHRo
b3NlIHBhcmFtZXRlcnMgYXJlIHBlcmZlY3RseSB2YWxpZCBmb3IgYSBwcm9ncmFtIHRyeWluZyB0
bwo+PiBhY2hpZXZlIGxvdyBsYXRlbmN5Lgo+Cj4gV2hlcmUgdGhpcyA1MG1zIGNvbWVzIGZyb20/
Cj4gVGhlIE1jQlNQMiBGSUZPIGxlbmd0aCBpczoKPiA0OEtIei9tb25vOiDCoCDCoCAyNi42Nm1z
Cj4gNDhLSHovc3RlcmVvOiDCoCAxMy4zM21zCj4gNDQuMUtIei9tb25vOiDCoCAyOS4wMm1zCj4g
NDQuMUtIei9zdGVyZW86IDE0LjUxbXMKPiA4S2h6L21vbm86IMKgIMKgIMKgMTYwbXMKPiA4S2h6
L3N0ZXJlbzogwqAgwqA4MG1zCj4KPiBEb2VzIFBhbmRvcmEgdXNlcyA4S2h6PwoKTm9wZSwgNTBt
cys4a0h6IHdhcyBqdXN0IHRvIGlsbHVzdHJhdGUgdGhlIHByb2JsZW0gZWFzaWVyLiAyMi80NGtI
egphcmUgdXNlZCBtb3N0IG9mdGVuLCBzb21lIGdhbWVzIHRoYXQgdGVuZCB0byBzZXQgbG93IHRo
cmVzaG9sZHMgYW5kCk9TUyBlbXVsYXRpb24gYXJlIG9uZXMgd2l0aCBwcm9ibGVtcy4KCj4gVGhl
IHNhbWUgdGhpbmcgYXBwbGllcyB0byB0aGUgc3RhcnRfdGhyZXNob2xkIGFzIHRvIHRoZSBwZXJp
b2Qgc2l6ZS4gSXQKPiBoYXMgdG8gYmUgYmlnZ2VyIHRoYW4gdGhlIEZJRk8gc2l6ZS4KPgo+PiBJ
dCdzIGEgc2hhbWUgdGhpcyBzdGlsbCB3b24ndCB3b3JrIG91dC1vZi10aGUgYm94LCBidXQgYXQg
bGVhc3QgdGhlcmUKPj4gd2lsbCBiZSBzb21lIHNvbHV0aW9uLgo+Cj4gRGVmYXVsdGluZyB0aGlz
IGJlaGF2aW9yIHdvdWxkIGJyZWFrIG90aGVyIGRpc3RyaWJ1dGlvbnMgZm9yIE9NQVAKPiBwbGF0
Zm9ybXMuIEkga25vdywgUGFuZG9yYSBpcyBiaXR0ZW4gYnkgdGhpcywgYnV0IE1lZUdvLCB1YnVu
dHUsIExpbmFybwo+IGlzIGZpbmUgKGFzIGZhciBhcyBJIGtub3cpLgoKSSB3b25kZXIgYWJvdXQg
dGhhdCwgaWYgdGhleSBhcmUgYWxyZWFkeSBvayB0aGV5IG11c3QgYmUgdXNpbmcgbGFyZ2VyCnBl
cmlvZC9zdGFydF90aHJlc2hvbGQgYW55d2F5IGFuZCBzaG91bGQgbm90IGJlIGFmZmVjdGVkPwoK
Ci0tIApHcmHFvnZ5ZGFzCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9y
ZwpodHRwOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1k
ZXZlbAo=
