From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 3/3] ASoC: omap-mcbsp: Add period size
	protection mode
Date: Wed, 21 Mar 2012 10:23:31 +0200
Message-ID: <4F699003.9070806@ti.com>
References: <1332242021-7494-1-git-send-email-peter.ujfalusi@ti.com>
	<1332242021-7494-4-git-send-email-peter.ujfalusi@ti.com>
	<20120320160154.GI3445@opensource.wolfsonmicro.com>
	<CANOLnOPjqbeEbSDUHokkGRUa7KwJ-+hAczWSmQ3LEccCh9-c7w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog111.obsmtp.com (na3sys009aog111.obsmtp.com
	[74.125.149.205])
	by alsa0.perex.cz (Postfix) with ESMTP id C432E1043F8
	for <alsa-devel@alsa-project.org>; Wed, 21 Mar 2012 09:23:36 +0100 (CET)
Received: by lagr15 with SMTP id r15so748230lag.30
	for <alsa-devel@alsa-project.org>; Wed, 21 Mar 2012 01:23:34 -0700 (PDT)
In-Reply-To: <CANOLnOPjqbeEbSDUHokkGRUa7KwJ-+hAczWSmQ3LEccCh9-c7w@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org

T24gMDMvMjAvMjAxMiAwNjoxNSBQTSwgR3JhenZ5ZGFzIElnbm90YXMgd3JvdGU6Cj4gSSB3b3Vs
ZG4ndCByZWFsbHkgY2FsbCB0aGVtIGJyb2tlbiwgaXQncyBlbm91Z2ggdG8gc2V0IHBlcmlvZCBz
aXplIHRvCj4gNTEyIHdpdGggc21hbGxlciBzdGFydF90aHJlc2hvbGQgKHNvbWV0aGluZyBsaWtl
IDUwbXMpIHRvIGhhdmUKPiBwcm9ibGVtcywgdGhvc2UgcGFyYW1ldGVycyBhcmUgcGVyZmVjdGx5
IHZhbGlkIGZvciBhIHByb2dyYW0gdHJ5aW5nIHRvCj4gYWNoaWV2ZSBsb3cgbGF0ZW5jeS4KCldo
ZXJlIHRoaXMgNTBtcyBjb21lcyBmcm9tPwpUaGUgTWNCU1AyIEZJRk8gbGVuZ3RoIGlzOgo0OEtI
ei9tb25vOiAgICAgMjYuNjZtcwo0OEtIei9zdGVyZW86ICAgMTMuMzNtcwo0NC4xS0h6L21vbm86
ICAgMjkuMDJtcwo0NC4xS0h6L3N0ZXJlbzogMTQuNTFtcwo4S2h6L21vbm86ICAgICAgMTYwbXMK
OEtoei9zdGVyZW86ICAgIDgwbXMKCkRvZXMgUGFuZG9yYSB1c2VzIDhLaHo/CgpUaGUgc2FtZSB0
aGluZyBhcHBsaWVzIHRvIHRoZSBzdGFydF90aHJlc2hvbGQgYXMgdG8gdGhlIHBlcmlvZCBzaXpl
LiBJdApoYXMgdG8gYmUgYmlnZ2VyIHRoYW4gdGhlIEZJRk8gc2l6ZS4KCj4gSXQncyBhIHNoYW1l
IHRoaXMgc3RpbGwgd29uJ3Qgd29yayBvdXQtb2YtdGhlIGJveCwgYnV0IGF0IGxlYXN0IHRoZXJl
Cj4gd2lsbCBiZSBzb21lIHNvbHV0aW9uLgoKRGVmYXVsdGluZyB0aGlzIGJlaGF2aW9yIHdvdWxk
IGJyZWFrIG90aGVyIGRpc3RyaWJ1dGlvbnMgZm9yIE9NQVAKcGxhdGZvcm1zLiBJIGtub3csIFBh
bmRvcmEgaXMgYml0dGVuIGJ5IHRoaXMsIGJ1dCBNZWVHbywgdWJ1bnR1LCBMaW5hcm8KaXMgZmlu
ZSAoYXMgZmFyIGFzIEkga25vdykuCgotLSAKUMOpdGVyCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2
ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxt
YW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
