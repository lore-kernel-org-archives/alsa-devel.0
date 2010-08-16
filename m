From: Jassi Brar <jassisinghbrar@gmail.com>
Subject: Re: [PATCH 4/7] ASoC: Automatically calculate clock
 ratio for WM8580
Date: Mon, 16 Aug 2010 21:47:29 +0900
Message-ID: <AANLkTimdH_G4u4ecpajh1t4o1meMpigjGXkW3aD1Sp86@mail.gmail.com>
References: <20100813193305.GB3778@sirena.org.uk>
	<1281728107-25386-4-git-send-email-broonie@opensource.wolfsonmicro.com>
	<AANLkTin2DtMjwgdiTnxuu+W8B2Jgfoo0VWT9EO_Tjikc@mail.gmail.com>
	<20100816122122.GC3276@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51]) by alsa0.perex.cz (Postfix) with ESMTP id 5B0C624333
	for <alsa-devel@alsa-project.org>;
	Mon, 16 Aug 2010 14:47:30 +0200 (CEST)
Received: by fxm11 with SMTP id 11so2933306fxm.38
	for <alsa-devel@alsa-project.org>; Mon, 16 Aug 2010 05:47:30 -0700 (PDT)
In-Reply-To: <20100816122122.GC3276@rakim.wolfsonmicro.main>
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

T24gTW9uLCBBdWcgMTYsIDIwMTAgYXQgOToyMSBQTSwgTWFyayBCcm93bgo8YnJvb25pZUBvcGVu
c291cmNlLndvbGZzb25taWNyby5jb20+IHdyb3RlOgo+IE9uIE1vbiwgQXVnIDE2LCAyMDEwIGF0
IDAxOjE2OjE1UE0gKzA5MDAsIFNldW5nd2hhbiBZb3VuIHdyb3RlOgo+PiBPbiBTYXQsIEF1ZyAx
NCwgMjAxMCBhdCA0OjM1IEFNLCBNYXJrIEJyb3duCj4KPiBTbywgdGhpcyBpcyBhIGdyZWF0IGV4
YW1wbGUgb2YgYSBnZW5lcmFsIHByb2JsZW0gd2l0aCB5b3VyIG1haWxzOiB5b3UncmUKPiBnZW5l
cmFsbHkgdmVyeSBsaWdodCBvbiBkZXRhaWwuIMKgVGhpcyBtYWtlcyBpdCBoYXJkIHRvIHdvcmsg
b3V0IGV4YWN0bHkKPiB3aGF0IHlvdSdyZSB0YWxraW5nIGFib3V0LiDCoFRoaXMgYXBwbGllcyB0
byBib3RoIHJlZ3VsYXIgZS1tYWlscyBhbmQKPiBhbHNvIHBhdGNoZXMgd2hlcmUgeW91ciBkZXNj
cmlwdGlvbnMgYWxzbyB0ZW5kIHRvd2FyZHMgdGhlIHRlcnNlLgoKSWYgaXQncyBhIGZhdWx0LCBp
dCdzIG1pbmUuIFNpbmNlIGhlIGNvdWxkbid0IGV4cGxhaW4gY2xlYXJseSB0aGUgbGFzdAp0aW1l
IGFuZC9vcgp5b3UgY291bGRuJ3QgdW5kZXJzdGFuZCwgSSBzdWdnZXN0ZWQgaGUgYmUgdGVyc2Ug
YW5kIGV4YWN0LgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0
cDovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
