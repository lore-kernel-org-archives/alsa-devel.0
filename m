From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: ASoC - Support for multiple components
Date: Wed, 21 Apr 2010 08:53:09 +0300
Message-ID: <201004210853.09498.peter.ujfalusi@nokia.com>
References: <1271686144.3208.305.camel@odin>
	<201004201017.47719.peter.ujfalusi@nokia.com>
	<1271760367.3234.159.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id A45AF103802
	for <alsa-devel@alsa-project.org>;
	Wed, 21 Apr 2010 07:53:32 +0200 (CEST)
In-Reply-To: <1271760367.3234.159.camel@odin>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ext Liam Girdwood <lrg@slimlogic.co.uk>
Cc: vbarinov <vbarinov@embeddedalley.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Joonyoung Shim <jy0922.shim@samsung.com>, Sascha Hauer <s.hauer@pengutronix.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Cliff Cai <cliff.cai@analog.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, "dg@emlix.com" <dg@emlix.com>, Grant Likely <grant.likely@secretlab.ca>, Sedji Gaouaou <sedji.gaouaou@atmel.com>, "kyungmin.park" <kyungmin.park@samsung.com>, "Candelaria Villareal, Jorge" <jorge.candelaria@ti.com>, ben-linux <ben-linux@fluff.org>, Kuninori Morimoto <morimoto.kuninori@renesas.com>, "mano@roarinelk.homelinux.net" <mano@roarinelk.homelinux.net>, Timur Tabi <timur@freescale.com>, "anemo@mba.ocn.ne.jp" <anemo@mba.ocn.ne.jp>
List-Id: alsa-devel@alsa-project.org

T24gVHVlc2RheSAyMCBBcHJpbCAyMDEwIDEzOjQ2OjA3IGV4dCBMaWFtIEdpcmR3b29kIHdyb3Rl
Ogo+ID4gSSBoYXZlIG9uZSBxdWVzdGlvbjoKPiA+IEhvdyB0aGUgb3ZlcmxhcHBpbmcga2NvbnRy
b2wgbmFtZXMgYXJlIGdvaW5nIHRvIGhhbmRsZWQgKHBsYWluIGtjb250cm9sCj4gPiBhbmQgREFQ
TSB3aWRnZXQgbmFtZXMpPwo+ID4gV2hhdCB3aWxsIGhhcHBlbiBpZiBsZXQgc2F5IHlvdSBoYXZl
IHdtODcxMSBfYW5kXyB3bTg3MzEgaW4gdGhlIHNhbWUKPiA+IGNhcmQ/IEJvdGggaGF2ZToKPiA+
ICJNYXN0ZXIgUGxheWJhY2sgVm9sdW1lIiwgIk1hc3RlciBQbGF5YmFjayBaQyBTd2l0Y2giIGlu
Cj4gPiBzbmRfa2NvbnRyb2xfbmV3LCBhbmQgYWxzbyBMT1VULCBST1VULCBMSFBPVVQsIFJIUE9V
VCwgYW5kCj4gPiBTTkRfU09DX0RBUE1fTUlYRVIoIk91dHB1dCBNaXhlciIsLi4pIGluIHNuZF9z
b2NfZGFwbV93aWRnZXQuCj4gPiAKPiA+IEhvdyB0aGUgdXNlciB3aWxsIHNlZSB0aGVzZSBpbiBv
bmUgY2FyZD8KPiAKPiBBIHN1YnNlcXVlbnQgcGF0Y2ggd2lsbCBhZGQgYW4gSUQgcXVhbGlmaWVy
IHRvIGtjb250cm9sIG5hbWVzIGFuZCBEQVBNCj4gd2lkZ2V0IG5hbWVzLiBTbyB3ZSBjYW4gaGF2
ZSB0aGluZ3MgbGlrZSAiTWFzdGVyIFBsYXliYWNrIFZvbHVtZS4wIiBhbmQKPiAiTWFzdGVyIFBs
YXliYWNrIFZvbHVtZS4xIiB0byBkaWZmZXJlbnRpYXRlIHRoZSB0d28gc2VwYXJhdGUgY29udHJv
bHMuCgpJIHNlZS4gSG93IHRoZXNlIElEcyB3aWxsIGJlIGFkZGVkPwpXaWxsIGRvZXMgYXJlIGdp
dmVuIGJ5IHRoZSBjb3JlIGF1dG9tYXRpY2FsbHkgYmFzZWQgb24gZGV2aWNlIGxvYWQgb3JkZXIs
IG9yIAp3aWxsIHRoZSBtYWNoaW5lIGRyaXZlciBoYXZlIHRoZSBhYmlsaXR5IHRvIHNwZWNpZnkg
dGhlIElEIGZvciBhIGNvZGVjPwoKQW5vdGhlciBxdWVzdGlvbjogaG93IHRoZSBQQ00gaW50ZXJm
YWNlcyB3aWxsIGJlIHNlZW4gd2hlbiB3ZSBoYXZlIG11bHRpcGxlIApjb2RlYy9kYWkgaW4gYSBj
YXJkPwpJIHN1cHBvc2Ugd2Ugd2lsbCBoYXZlIG11bHRpcGxlIFBDTXMgaW4gYSBjYXJkLCB3aGVu
IHdlIGhhdmUgbXVsdGlwbGUgY29kZWMgCihtdWx0aXBsZSBkYWkgcGFpcnMpLi4/Cgo+IAo+IExp
YW0KCi0tIApQw6l0ZXIKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3Jn
Cmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRl
dmVsCg==
