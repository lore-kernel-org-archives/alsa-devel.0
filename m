From: Jassi Brar <jassisinghbrar@gmail.com>
Subject: Re: [PATCH 4/7] ASoC: Automatically calculate clock
 ratio for WM8580
Date: Tue, 17 Aug 2010 08:14:43 +0900
Message-ID: <AANLkTindYfm3vh_OgF-0tt_MS+Uxii2s7Dw=Kk487RTd@mail.gmail.com>
References: <20100813193305.GB3778@sirena.org.uk>
	<1281728107-25386-4-git-send-email-broonie@opensource.wolfsonmicro.com>
	<AANLkTi=6Op9C3adxhN8HsZu9FewFYqeCWRoQs=P3LP18@mail.gmail.com>
	<20100815110924.GA25723@opensource.wolfsonmicro.com>
	<AANLkTi=9Y=uhX2b+Y=OMGCVA=gJNif8HwXe3Eg517nbq@mail.gmail.com>
	<20100816102010.GB3276@rakim.wolfsonmicro.main>
	<AANLkTinTYo6_BBSkhTt8Km-MR4wwexDS3orFJdNSiufT@mail.gmail.com>
	<20100816151958.GE3276@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 0B46B10383E
	for <alsa-devel@alsa-project.org>;
	Tue, 17 Aug 2010 01:14:47 +0200 (CEST)
Received: by fxm11 with SMTP id 11so3244344fxm.38
	for <alsa-devel@alsa-project.org>; Mon, 16 Aug 2010 16:14:43 -0700 (PDT)
In-Reply-To: <20100816151958.GE3276@rakim.wolfsonmicro.main>
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

T24gVHVlLCBBdWcgMTcsIDIwMTAgYXQgMTI6MTkgQU0sIE1hcmsgQnJvd24KPGJyb29uaWVAb3Bl
bnNvdXJjZS53b2xmc29ubWljcm8uY29tPiB3cm90ZToKPiBPbiBNb24sIEF1ZyAxNiwgMjAxMCBh
dCAwOTo1MTozNVBNICswOTAwLCBKYXNzaSBCcmFyIHdyb3RlOgo+Cj4+IFdoZW4gQ1BVIE1BU1RF
UiB3YXMgZGVmYXVsdCwgcGVvcGxlIGFza2VkIGZvciBTTEFWRS4gQnV0IG5vYm9keSBhc2tlZAo+
PiBmb3IgTUFTVEVSIHNpbmNlIHdlIHNlbGVjdGVkIFNMQVZFIGJ5IGRlZmF1bHQuIEJvdGggd29y
ayBlcXVhbGx5IHdlbGwsIGl0IGp1c3QKPj4gc2F2ZXMgb3VyIGVmZm9ydHMuCj4KPiBXaGF0IHdl
cmUgcGVvcGxlIGFjdHVhbGx5IGNvbXBsYWluaW5nIGFib3V0PyDCoEkgc3VzcGVjdCBpdCB3YXMg
dGhlIHJvb3QKPiBjbG9jayBmb3IgdGhlIGF1ZGlvIHRyZWUgdGhhdCB0aGV5IHdlcmUgY29uY2Vy
bmVkIGFib3V0IHJhdGhlciB0aGFuIHRoZQo+IEkyUyBidXMgY2xvY2suCk5vIGNvbXBsYWludHMu
IEkganVzdCBnZXQgdGhlIHRhc2sgdG8gZG8uCkkgZ3Vlc3MgbW9zdCBxdWFsaXR5IGNvbnNjaW91
cyBwcm9kdWN0cyBjYW4gYWZmb3JkIHRvIGF0dGFjaCBhIGRlZGljYXRlZApPU0MgdG8gYSBnb29k
IENPREVDLiBBIENPREVDIGFscmVhZHkgc3BlY2lmaWVzIHRoZSBjbG9ja3MgaXQgc3VwcG9ydAph
bmQgdXN1YWxseSBjb21lcyB3aXRoICdwcmVmZXJyZWQnIGlucHV0IGNsb2Nrcy4gU28sIGp1c3Qg
aGF2aW5nIGEgc3BlY2lmaWVkCnJhdGluZyBhY2N1cmF0ZSBlbm91Z2ggT1NDIGNhbiB0YWtlIGNh
cmUgb2YgcXVhbGl0eS4gT24gdGhlIG90aGVyIGhhbmQKdGhlIGNsb2NrIHNvdXJjZXMgb24gQ1BV
IHNpZGUgYXJlIG5vdCBwYXJ0aWN1bGFybHkgYWNjdXJhdGUgZm9yIGF1ZGlvLWNsb2NrCmdlbmVy
YXRpb24uIE9yIHNvIGhhdmUgSSBzZWVuIHNvIGZhci4KX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZl
bEBhbHNhLXByb2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1h
bi9saXN0aW5mby9hbHNhLWRldmVsCg==
