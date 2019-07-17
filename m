From: Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [PATCH] ASoC: fsl_sai: mark regmap as fast_io
Date: Wed, 17 Jul 2019 13:44:16 +0200
Message-ID: <1563363856.2676.14.camel@pengutronix.de>
References: <20190717105156.15721-1-l.stach@pengutronix.de>
 <20190717110632.GA4459@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1D69AF800C4
 for <alsa-devel@alsa-project.org>; Wed, 17 Jul 2019 13:44:20 +0200 (CEST)
In-Reply-To: <20190717110632.GA4459@sirena.org.uk>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, patchwork-lst@pengutronix.de, Nicolin Chen <nicoleotsuka@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, kernel@pengutronix.de, Fabio Estevam <festevam@gmail.com>
List-Id: alsa-devel@alsa-project.org

QW0gTWl0dHdvY2gsIGRlbiAxNy4wNy4yMDE5LCAxMjowNiArMDEwMCBzY2hyaWViIE1hcmsgQnJv
d246Cj4gT24gV2VkLCBKdWwgMTcsIDIwMTkgYXQgMTI6NTE6NTZQTSArMDIwMCwgTHVjYXMgU3Rh
Y2ggd3JvdGU6Cj4gCj4gPiBUaGUgcmVnbWFwIGlzIG9ubHkgZXZlciB1c2VkIHRvIGFjY2VzcyBN
TUlPIHJlZ2lzdGVycywgc28gaXQncyBmYWlyCj4gPiB0byBzYXkgdGhhdCByZWdpc3RlciBhY2Nl
c3MgaXMgZmFzdC4KPiAKPiBBcmUgeW91IHN1cmUgdGhlcmUncyBubyBjYWNoZXMgdGhhdCB0cnkg
dG8gZG8gYWxsb2NhdGlvbnMgYXQKPiBydW50aW1lP8KgwqBUaGUgbWFpbiB0aGluZyBmYXN0X2lv
IGRvZXMgaXMgY2hhbmdlIHRoZSBsb2NraW5nIHRvCj4gc3BpbmxvY2tzIHdoaWNoIG1lYW5zIHdl
IHNob3VsZG4ndCBkbyBhbnkgYWxsb2NhdGlvbnMgdW5kZXIgbG9jaywKPiBzdWNoIGFzIHdoZW4g
dXBkYXRpbmcgdGhlIGNhY2hlLgoKVGhpcyBkcml2ZXIgaXMgdXNpbmcgUkVHQ0FDSEVfRkxBVCwg
d2hpY2ggZG9lcyBpdHMgc29sZSBhbGxvY2F0aW9uIG9uCmluaXQgYW5kIG5vbmUgYXQgcmVnIGFj
Y2VzcyB0aW1lIEFGQUlDUy4gU28gdGhpcyBzaG91bGQgYmUgb2theS4KClJlZ2FyZHMsCkx1Y2Fz
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkFsc2EtZGV2
ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwczovL21haWxt
YW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
