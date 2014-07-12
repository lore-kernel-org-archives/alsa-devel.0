From: Jianqun <xjq@rock-chips.com>
Subject: Re: [PATCH] ASoC: rockchips: fix build error
Date: Sat, 12 Jul 2014 08:59:21 +0800
Message-ID: <53C08869.5060408@rock-chips.com>
References: <1405084028-1209898-1-git-send-email-arnd@arndb.de>
 <20140711134848.GX30458@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from regular1.263xmail.com (regular1.263xmail.com [211.150.99.132])
 by alsa0.perex.cz (Postfix) with ESMTP id 91CD726513A
 for <alsa-devel@alsa-project.org>; Sat, 12 Jul 2014 02:59:25 +0200 (CEST)
In-Reply-To: <20140711134848.GX30458@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

T24gMjAxNOW5tDA35pyIMTHml6UgMjE6NDgsIE1hcmsgQnJvd24gd3JvdGU6Cj4gT24gRnJpLCBK
dWwgMTEsIDIwMTQgYXQgMDM6MDc6MDhQTSArMDIwMCwgQXJuZCBCZXJnbWFubiB3cm90ZToKPj4g
VGhlIG5ld2x5IGFkZGVkIHJvY2tjaGlwX2kycyBkcml2ZXIgaXMgbGFja2luZyBhbiBpbmNsdWRl
IG9mCj4+IGxpbnV4L21vZHVsZS5oLCBjYXVzaW5nIGEgYnVpbGQgZXJyb3IgaW4gc29tZSBjYXNl
czoKPiAKPiBBIGZpeCBmb3IgdGhpcyBoYXMgYWxyZWFkeSBiZWVuIGFwcGxpZWQuCj4gClRoYW5r
IHlvdSB2ZXJ5IG11Y2ggOiksIGl0J3MgZ3JlYXQgaGVscCBmb3IgYSBiZWdhaW5uZXIuCgotLSAK
LS0tLS0tLS0tLS0tLQrorrgg5YmRIOe+pCBKYXkKUm9ja2NoaXAgRWxlY3Ryb25pY3MgQ28uTHRk
CioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioKKklNUE9SVEFOVCBOT1RJQ0U6KlRoaXMgZW1haWwgaXMgZnJv
bSBGdXpob3UgUm9ja2NoaXAgRWxlY3Ryb25pY3MgQ28uLApMdGQgLlRoZSBjb250ZW50cyBvZiB0
aGlzIGVtYWlsIGFuZCBhbnkgYXR0YWNobWVudHMgbWF5IGNvbnRhaW4KaW5mb3JtYXRpb24gdGhh
dCBpcyBwcml2aWxlZ2VkLCBjb25maWRlbnRpYWwgYW5kL29yIGV4ZW1wdCBmcm9tCmRpc2Nsb3N1
cmUgdW5kZXIgYXBwbGljYWJsZSBsYXcgYW5kIHJlbGV2YW50IE5EQS4gSWYgeW91IGFyZSBub3Qg
dGhlCmludGVuZGVkIHJlY2lwaWVudCwgeW91IGFyZSBoZXJlYnkgbm90aWZpZWQgdGhhdCBhbnkg
ZGlzY2xvc3VyZSwKY29weWluZywgZGlzdHJpYnV0aW9uLCBvciB1c2Ugb2YgdGhlIGluZm9ybWF0
aW9uIGlzIFNUUklDVExZIFBST0hJQklURUQuClBsZWFzZSBpbW1lZGlhdGVseSBjb250YWN0IHRo
ZSBzZW5kZXIgYXMgc29vbiBhcyBwb3NzaWJsZSBhbmQgZGVzdHJveQp0aGUgbWF0ZXJpYWwgaW4g
aXRzIGVudGlyZXR5IGluIGFueSBmb3JtYXQuIFRoYW5rIHlvdS4KKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQWxzYS1k
ZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHA6Ly9tYWls
bWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
