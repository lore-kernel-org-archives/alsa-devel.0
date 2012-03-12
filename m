From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 3/3] ASoC: omap-mcbsp: make minimum period
 size larger than FIFO
Date: Mon, 12 Mar 2012 14:41:24 +0200
Message-ID: <4F5DEEF4.4050409@ti.com>
References: <1331248757-3408-1-git-send-email-notasas@gmail.com>
	<1331248757-3408-4-git-send-email-notasas@gmail.com>
	<4F59FA9D.8070009@ti.com>
	<CANOLnOM+9M2BTXasnAUqFyYAg03LE0TD266ArYDyxfRsY26QsQ@mail.gmail.com>
	<4F5A08B3.8080705@ti.com>
	<CANOLnOPZ+bMy8FyAJ0s6QSz1NMEZjgjX_ZXDkT+dFU3q8vefgg@mail.gmail.com>
	<1331487544.3326.27.camel@puukko.homenet-68>
	<CANOLnONZTBTOYLjj=Fs5rA1MX0vq2tGrr67UVmHPugykfBoUZw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog120.obsmtp.com (na3sys009aog120.obsmtp.com
	[74.125.149.140])
	by alsa0.perex.cz (Postfix) with ESMTP id 7AA10103F4F
	for <alsa-devel@alsa-project.org>; Mon, 12 Mar 2012 13:41:44 +0100 (CET)
Received: by mail-lpp01m010-f42.google.com with SMTP id l5so8456446lah.1
	for <alsa-devel@alsa-project.org>; Mon, 12 Mar 2012 05:41:28 -0700 (PDT)
In-Reply-To: <CANOLnONZTBTOYLjj=Fs5rA1MX0vq2tGrr67UVmHPugykfBoUZw@mail.gmail.com>
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

T24gMDMvMTIvMjAxMiAwMjowNSBQTSwgR3JhenZ5ZGFzIElnbm90YXMgd3JvdGU6Cj4gYXBsYXkg
LUQgaHc6MCAtZiBzMTZfbGUgLWMgMiAtLXBlcmlvZC1zaXplPTUxMiAtLXN0YXJ0LWRlbGF5PTUw
MDAwIC9kZXYvdXJhbmRvbQo+IAo+IG5vdGUgdGhhdCB0aGlzIHdpbGwgb25seSBzaG93IHByb2Js
ZW1zIG9uIE9NQVAzIE1jQlNQMiBkdWUgdG8gaXQncyBsb25nIEZJRk8uCgpUaGVyZSdzIHNvbWV0
aGluZyBlbHNlIGhlcmUgc2luY2U6CmFwbGF5IC1EIGh3OjAgLWZzMTZfbGUgLWMyIC0tcGVyaW9k
LXNpemU9MzIwIC0tYnVmZmVyLXNpemU9OTcyIFwKLS1zdGFydC1kZWxheT04MTAwMCAtdiAvZGV2
L3VyYW5kb20KCldvcmtzIGNvcnJlY3RseSwgaG93ZXZlcgphcGxheSAtRCBodzowIC1mczE2X2xl
IC1jMiAtLXBlcmlvZC1zaXplPTMyNCAtLWJ1ZmZlci1zaXplPTk3MiBcCi0tc3RhcnQtZGVsYXk9
ODEwMDAgLXYgL2Rldi91cmFuZG9tCgpwcm9kdWNlcyB1bmRlcnJ1bnMuCkluIGJvdGggY2FzZXMg
dGhlIHN0YXJ0X3RocmVzaG9sZCBpcyBzZXQgdG8gNjQ4ICg2NDAgaXMgdGhlIEZJRk8gTWNCU1Ay
CnNpemUpLiBCb3RoIHNob3VsZCBiZSBmaW5lLCBidXQgcGVyaW9kX3NpemU9MzI0IHVuZGVycnVu
cy4KClNvIHRoZSBpc3N1ZSBpcyBub3QgdGhhdCBzaW1wbGUgYXMgaXQgc2VhbXMuLi4KCi0tIApQ
w6l0ZXIKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQWxz
YS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHA6Ly9t
YWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
