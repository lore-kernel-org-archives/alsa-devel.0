From: Jassi Brar <jassisinghbrar@gmail.com>
Subject: Re: [PATCH 4/7] ASoC: Automatically calculate clock
 ratio for WM8580
Date: Mon, 16 Aug 2010 21:51:35 +0900
Message-ID: <AANLkTinTYo6_BBSkhTt8Km-MR4wwexDS3orFJdNSiufT@mail.gmail.com>
References: <20100813193305.GB3778@sirena.org.uk>
	<1281728107-25386-4-git-send-email-broonie@opensource.wolfsonmicro.com>
	<AANLkTi=6Op9C3adxhN8HsZu9FewFYqeCWRoQs=P3LP18@mail.gmail.com>
	<20100815110924.GA25723@opensource.wolfsonmicro.com>
	<AANLkTi=9Y=uhX2b+Y=OMGCVA=gJNif8HwXe3Eg517nbq@mail.gmail.com>
	<20100816102010.GB3276@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51]) by alsa0.perex.cz (Postfix) with ESMTP id 1ADA524333
	for <alsa-devel@alsa-project.org>;
	Mon, 16 Aug 2010 14:51:36 +0200 (CEST)
Received: by fxm11 with SMTP id 11so2935244fxm.38
	for <alsa-devel@alsa-project.org>; Mon, 16 Aug 2010 05:51:35 -0700 (PDT)
In-Reply-To: <20100816102010.GB3276@rakim.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Seungwhan Youn <sw.youn@samsung.com>, alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>, Seungwhan Youn <claude.youn@gmail.com>
List-Id: alsa-devel@alsa-project.org

T24gTW9uLCBBdWcgMTYsIDIwMTAgYXQgNzoyMCBQTSwgTWFyayBCcm93bgo8YnJvb25pZUBvcGVu
c291cmNlLndvbGZzb25taWNyby5jb20+IHdyb3RlOgo+IE9uIE1vbiwgQXVnIDE2LCAyMDEwIGF0
IDAxOjM2OjUwUE0gKzA5MDAsIEphc3NpIEJyYXIgd3JvdGU6Cj4KPj4gRm9yIHVzLCBoYXZpbmcg
Q1BVIGluIHNsYXZlIG1vZGUgaXMgbW9yZSBpbXBvcnRhbnQgdGhhbiBjbGVhcmluZyBhbGwgdGhl
Cj4+IHVzZSBjYXNlcyBwZXJmZWN0bHkgb24gYSBfcmVmZXJlbmNlXyBwbGF0Zm9ybS4KPj4gTW9y
ZSBzbyB3aGVuIHRoZSAncHJvYmxlbScgY2FuIGJlIG9idmlvdXNseSBhdHRyaWJ1dGVkIHRvIHRo
ZSBoL3cgZGVzaWduLgo+Cj4gSHJtLCBPSyAtIHRoaXMgaXMgdGhlIG9wcG9zaXRlIHdheSBhcm91
bmQgdG8gd2hhdCBtb3N0IENQVSB2ZW5kb3JzIHdvdWxkCj4gYXNrIGZvci4gwqBJcyB0aGVyZSBh
bnkgcGFydGljdWxhciByZWFzb24gZm9yIHRoaXMgcHJlZmVyZW5jZT8KV2hlbiBDUFUgTUFTVEVS
IHdhcyBkZWZhdWx0LCBwZW9wbGUgYXNrZWQgZm9yIFNMQVZFLiBCdXQgbm9ib2R5IGFza2VkCmZv
ciBNQVNURVIgc2luY2Ugd2Ugc2VsZWN0ZWQgU0xBVkUgYnkgZGVmYXVsdC4gQm90aCB3b3JrIGVx
dWFsbHkgd2VsbCwgaXQganVzdApzYXZlcyBvdXIgZWZmb3J0cy4KQnR3LCBJIHRob3VnaHQgQ09E
RUMgdXN1YWxseSBwcm92aWRlIG1vcmUgYWNjdXJhdGUgc2lnbmFscyBhbmQgaGVuY2UgQ1BVIFNM
QVZFCmlzIGJldHRlci4gSXMgaXMgdG9vIHdyb25nPwpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVs
QGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
