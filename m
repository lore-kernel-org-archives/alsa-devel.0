From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: [PATCH 3/3] ASoC: omap-mcbsp: make minimum period
 size larger than FIFO
Date: Mon, 12 Mar 2012 16:06:40 +0200
Message-ID: <CANOLnOMzTt9qhQL-WbqPvUxJDgUvs-f==Ny=PH+=przEF-fo2g@mail.gmail.com>
References: <1331248757-3408-1-git-send-email-notasas@gmail.com>
	<1331248757-3408-4-git-send-email-notasas@gmail.com>
	<4F59FA9D.8070009@ti.com>
	<CANOLnOM+9M2BTXasnAUqFyYAg03LE0TD266ArYDyxfRsY26QsQ@mail.gmail.com>
	<4F5A08B3.8080705@ti.com>
	<CANOLnOPZ+bMy8FyAJ0s6QSz1NMEZjgjX_ZXDkT+dFU3q8vefgg@mail.gmail.com>
	<1331487544.3326.27.camel@puukko.homenet-68>
	<CANOLnONZTBTOYLjj=Fs5rA1MX0vq2tGrr67UVmHPugykfBoUZw@mail.gmail.com>
	<4F5DEEF4.4050409@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iy0-f179.google.com (mail-iy0-f179.google.com
	[209.85.210.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 49E2C1040D0
	for <alsa-devel@alsa-project.org>; Mon, 12 Mar 2012 15:06:41 +0100 (CET)
Received: by iakh37 with SMTP id h37so7600848iak.38
	for <alsa-devel@alsa-project.org>; Mon, 12 Mar 2012 07:06:40 -0700 (PDT)
In-Reply-To: <4F5DEEF4.4050409@ti.com>
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

T24gTW9uLCBNYXIgMTIsIDIwMTIgYXQgMjo0MSBQTSwgUGV0ZXIgVWpmYWx1c2kgPHBldGVyLnVq
ZmFsdXNpQHRpLmNvbT4gd3JvdGU6Cj4gT24gMDMvMTIvMjAxMiAwMjowNSBQTSwgR3JhenZ5ZGFz
IElnbm90YXMgd3JvdGU6Cj4+IGFwbGF5IC1EIGh3OjAgLWYgczE2X2xlIC1jIDIgLS1wZXJpb2Qt
c2l6ZT01MTIgLS1zdGFydC1kZWxheT01MDAwMCAvZGV2L3VyYW5kb20KPj4KPj4gbm90ZSB0aGF0
IHRoaXMgd2lsbCBvbmx5IHNob3cgcHJvYmxlbXMgb24gT01BUDMgTWNCU1AyIGR1ZSB0byBpdCdz
IGxvbmcgRklGTy4KPgo+IFRoZXJlJ3Mgc29tZXRoaW5nIGVsc2UgaGVyZSBzaW5jZToKPiBhcGxh
eSAtRCBodzowIC1mczE2X2xlIC1jMiAtLXBlcmlvZC1zaXplPTMyMCAtLWJ1ZmZlci1zaXplPTk3
MiBcCj4gLS1zdGFydC1kZWxheT04MTAwMCAtdiAvZGV2L3VyYW5kb20KPgo+IFdvcmtzIGNvcnJl
Y3RseSwgaG93ZXZlcgo+IGFwbGF5IC1EIGh3OjAgLWZzMTZfbGUgLWMyIC0tcGVyaW9kLXNpemU9
MzI0IC0tYnVmZmVyLXNpemU9OTcyIFwKPiAtLXN0YXJ0LWRlbGF5PTgxMDAwIC12IC9kZXYvdXJh
bmRvbQo+Cj4gcHJvZHVjZXMgdW5kZXJydW5zLgo+IEluIGJvdGggY2FzZXMgdGhlIHN0YXJ0X3Ro
cmVzaG9sZCBpcyBzZXQgdG8gNjQ4ICg2NDAgaXMgdGhlIEZJRk8gTWNCU1AyCj4gc2l6ZSkuIEJv
dGggc2hvdWxkIGJlIGZpbmUsIGJ1dCBwZXJpb2Rfc2l6ZT0zMjQgdW5kZXJydW5zLgo+Cj4gU28g
dGhlIGlzc3VlIGlzIG5vdCB0aGF0IHNpbXBsZSBhcyBpdCBzZWFtcy4uLgoKU2VlbXMgdG8gYmUg
YWZmZWN0ZWQgLS1zdG9wLWRlbGF5LCBpbmNyZWFzaW5nIGl0IGhlbHBzIGhlcmUsIG1heWJlCmNv
cmUgc3RvcHMgaXQgZm9yIHRvbyBsb25nLgoKLS0gCkdyYcW+dnlkYXMKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QK
QWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5v
cmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
