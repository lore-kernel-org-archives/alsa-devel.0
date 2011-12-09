From: =?utf-8?Q?Lothar_Wa=C3=9Fmann?= <LW@KARO-electronics.de>
Subject: Re: [PATCH 2/5] ASoC: mxs: add .owner to struct
 snd_soc_card
Date: Fri, 9 Dec 2011 15:36:06 +0100
Message-ID: <20194.7382.414612.182139@ipc1.ka-ro>
References: <cover.1323436034.git.LW@KARO-electronics.de>
	<555be1750dd09586d5eede6457f72310890274b0.1323436034.git.LW@KARO-electronics.de>
	<20111209141203.GH3327@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.karo-electronics.de (mail.karo-electronics.de
	[81.173.242.67]) by alsa0.perex.cz (Postfix) with ESMTP id 7378B2433D
	for <alsa-devel@alsa-project.org>; Fri,  9 Dec 2011 15:36:19 +0100 (CET)
In-Reply-To: <20111209141203.GH3327@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Dong Aisheng-B29396 <B29396@freescale.com>, linux-kernel@vger.kernel.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

SGksCgpXb2xmcmFtIFNhbmcgd3JpdGVzOgo+IE9uIEZyaSwgRGVjIDA5LCAyMDExIGF0IDAyOjM4
OjA5UE0gKzAxMDAsIExvdGhhciBXYcOfbWFubiB3cm90ZToKPiA+IFRoaXMgd2lsbCBwcmV2ZW50
IHRoZSBtb2R1bGUgZnJvbSBiZWluZyByZW1vdmVkIGZyb20gdW5kZXJuZWF0aCBpdHMKPiA+IHVz
ZXJzCj4gPiAKPiA+IFNpZ25lZC1vZmYtYnk6IExvdGhhciBXYcOfbWFubiA8TFdAS0FSTy1lbGVj
dHJvbmljcy5kZT4KPiAKPiBJIGNhbid0IGZpbmQgYW55IG90aGVyIGluc3RhbmNlIHNldHRpbmcg
b3duZXIgaW4gc25kX3NvY19jYXJkPwo+IApUaGVuIHRoYXQgb3RoZXIgdXNlcyBhcmUgbW9zdCBw
cm9iYWJseSBmYXVsdHkgdG9vLgoKWW91IGNhbiBlYXNpbHkgdGVzdCBpdCBieSBsb2FkaW5nIGFs
bCBuZWNlc3Nhcnkgc291bmQgbW9kdWxlcywKc3RhcnRpbmcgc29tZSBhcHBsaWNhdGlvbiB0aGF0
IHVzZXMgdGhlIHNvdW5kIGRldmljZSAoZS5nLiBhbHNhbWl4ZXIpCmFuZCB0aGVuIHJlbW92aW5n
IHRoZSBzbmQtc29jLW14cy1zZ3RsNTAwMCBtb2R1bGUuCgpXaXRob3V0IHRoZSBwYXRjaCB0aGUg
cmVtb3ZhbCB3aWxsIHN1Y2NlZWQgY3Jhc2hpbmcgdGhlCmFwcGxpY2F0aW9uLiBXaXRoIHRoaXMg
cGF0Y2ggdGhlIHJlZmNvdW50IG9mIHRoZSBtb2R1bGUgd2lsbCBiZQo+IDAgYXMgbG9uZyBhcyBh
biBhcHBsaWNhdGlvbiBpcyB1c2luZyBpdCwgcHJldmVudGluZyB0aGUKcmVtb3ZhbC4KCgpMb3Ro
YXIgV2HDn21hbm4KLS0gCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCgpLYS1SbyBlbGVjdHJvbmljcyBHbWJIIHwgUGFzY2Fsc3RyYcOf
ZSAyMiB8IEQgLSA1MjA3NiBBYWNoZW4KUGhvbmU6ICs0OSAyNDA4IDE0MDItMCB8IEZheDogKzQ5
IDI0MDggMTQwMi0xMApHZXNjaMOkZnRzZsO8aHJlcjogTWF0dGhpYXMgS2F1c3NlbgpIYW5kZWxz
cmVnaXN0ZXJlaW50cmFnOiBBbXRzZ2VyaWNodCBBYWNoZW4sIEhSQiA0OTk2Cgp3d3cua2Fyby1l
bGVjdHJvbmljcy5kZSB8IGluZm9Aa2Fyby1lbGVjdHJvbmljcy5kZQpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlz
dApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
