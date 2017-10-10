From: Lucas Stach <l.stach@pengutronix.de>
Subject: Re: regression introduced by commit 70d435ba1cd6
 ("ASoC: imx-pcm-dma: simplify pcm_config")
Date: Tue, 10 Oct 2017 16:49:04 +0200
Message-ID: <1507646944.2398.1.camel@pengutronix.de>
References: <20171004103657.1c6a433d@karo-electronics.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.4.pengutronix.de (metis.ext.4.pengutronix.de
 [92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 7CF31266B38
 for <alsa-devel@alsa-project.org>; Tue, 10 Oct 2017 16:49:05 +0200 (CEST)
In-Reply-To: <20171004103657.1c6a433d@karo-electronics.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lothar =?ISO-8859-1?Q?Wa=DFmann?= <LW@KARO-electronics.de>, alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

SGkgTG90aGFyLAoKQW0gTWl0dHdvY2gsIGRlbiAwNC4xMC4yMDE3LCAxMDozNiArMDIwMCBzY2hy
aWViIExvdGhhciBXYcOfbWFubjoKPiBIaSwKPiAKPiB0aGUgY29tbWl0IDcwZDQzNWJhMWNkNiAo
IkFTb0M6IGlteC1wY20tZG1hOiBzaW1wbGlmeSBwY21fY29uZmlnIikKPiBpbnRyb2R1Y2VkIGEg
cmVncmVzc2lvbiBvbiB0aGUgS2EtUm8gVFggc2VyaWVzIG1vZHVsZXMgKGFuZCBwb3NzaWJseQo+
IG90aGVyIGhhcmR3YXJlIGFzIHdlbGwpLgo+IAo+IFRoZSBwcm9ibGVtIGlzLCB0aGF0IHRoaXMg
Y29tbWl0IHJlc3RyaWN0cyB0aGUgc3VwcG9ydGVkIHNvdW5kCj4gZm9ybWF0cwo+IHRvIFMyNF9M
RSBvbmx5IHJhdGhlciB0aGFuIFMxNl9MRSwgUzI0X0xFLCBTMjBfM0xFIHdpdGhvdXQgdGhlCj4g
cGF0Y2guIFRoZXJlZm9yZSBhcGxheSBmYWlscyB3aXRoIHRoZSBmb2xsb3dpbmcgZXJyb3IgbWVz
c2FnZXMsIHdoZW4KPiB0cnlpbmcgdG8gcGxheSBhIHNvdW5kIGZpbGUgd2l0aCBTMTZfTEUgZm9y
bWF0Ogo+ID4gQUxTQSBsaWIgYWxzYS1saWItCj4gPiAxLjEuMi9zcmMvcGNtL3BjbV9wYXJhbXMu
YzoyMTYyOihzbmQxX3BjbV9od19yZWZpbmVfc2xhdmUpIFNsYXZlCj4gPiBQQ00gbm90IHVzYWJs
ZQo+ID4gYXBsYXk6IHNldF9wYXJhbXM6MTIwNDogQnJva2VuIGNvbmZpZ3VyYXRpb24gZm9yIHRo
aXMgUENNOiBubwo+ID4gY29uZmlndXJhdGlvbnMgYXZhaWxhYmxlCj4gCj4gVGhpcyBpcyB3aXRo
IHRoZSBzaW1wbGUtc291bmQtY2FyZCBkcml2ZXIgYXMgd2VsbCBhcyB0aGUgaW14LXNndGw1MDAw
Cj4gZHJpdmVyLgo+IAo+IENhbiBzb21lb25lIHRlbGwgbWUgb24gd2hhdCBoYXJkd2FyZSBhbmQg
d2l0aCB3aGF0IHNvZnR3YXJlIGhhcyB0aGlzCj4gcGF0Y2ggYmVlbiB0ZXN0ZWQ/CgpNeSBwcmlt
YXJ5IHRlc3QgaGFyZHdhcmUgd2FzIHRoZSB6aWktcmR1MiBib2FyZCwgdGhlIERUUyBmb3IgdGhp
cyBib2FyZApjYW4gYmUgZm91bmQgaW4gcmVjZW50IG1haW5saW5lIGtlcm5lbHMuCgpVc2Vyc3Bh
Y2UgaXMgYmFzZWQgb24gcHVsc2VhdWRpbywgd2hpY2ggbWF5IG1hc2sgdGhlIHJlZ3Jlc3Npb24g
YnkKcmVzYW1wbGluZyB0byB0aGUgc3VwcG9ydGVkIGZvcm1hdC4gU29ycnkgYWJvdXQgdGhhdC4K
CkZyb20gbXkgdW5kZXJzdGFuZGluZyBvZiB0aGUgY29kZSwgaXQgc2hvdWxkIGJlIHBvc3NpYmxl
IHRvIGZpeCB0aGUKcmVncmVzc2lvbiB3aXRob3V0IHJldmVydGluZyB0aGlzIHBhdGNoIGJ5IHNl
dHRpbmcKU05EX0RNQUVOR0lORV9QQ01fREFJX0ZMQUdfUEFDSyBpbiB0aGUgZmxhZ3MgZmllbGQg
b2YgdGhlIERNQSBwYXJhbXMgaW4KZnNsX3NzaS4KClJlZ2FyZHMsCkx1Y2FzCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBs
aXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNhLXByb2pl
Y3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
