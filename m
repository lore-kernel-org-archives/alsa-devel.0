From: =?UTF-8?Q?Beno=C3=AEt_Th=C3=A9baudeau?= <benoit.thebaudeau.dev@gmail.com>
Subject: Re: [PATCH] ASoC: Document DAI signal polarity
Date: Mon, 5 Oct 2015 21:20:05 +0200
Message-ID: <CA+sos7_1Vo79kNG0dzhBxmaYiGG_7jX3dS+=_zPptgo=M+1N2g@mail.gmail.com>
References: <1443722959-5094-1-git-send-email-anatol.pomozov@gmail.com>
 <20151005151255.GU12635@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f175.google.com (mail-ob0-f175.google.com
 [209.85.214.175])
 by alsa0.perex.cz (Postfix) with ESMTP id CF3092614A9
 for <alsa-devel@alsa-project.org>; Mon,  5 Oct 2015 21:20:25 +0200 (CEST)
Received: by obbzf10 with SMTP id zf10so136773040obb.2
 for <alsa-devel@alsa-project.org>; Mon, 05 Oct 2015 12:20:24 -0700 (PDT)
In-Reply-To: <20151005151255.GU12635@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: albertchen@realtek.com, Alsa-devel <alsa-devel@alsa-project.org>, lars@metafoo.de, Anatol Pomozov <anatol.pomozov@gmail.com>
List-Id: alsa-devel@alsa-project.org

RGVhciBNYXJrIEJyb3duLAoKT24gTW9uLCBPY3QgNSwgMjAxNSBhdCA1OjEyIFBNLCBNYXJrIEJy
b3duIDxicm9vbmllQGtlcm5lbC5vcmc+IHdyb3RlOgo+IE9uIFRodSwgT2N0IDAxLCAyMDE1IGF0
IDExOjA5OjE5QU0gLTA3MDAsIEFuYXRvbCBQb21vem92IHdyb3RlOgo+Cj4+ICsgKiAtIEkyUyBy
aWdodC9sZWZ0IGp1c3RpZmllZDogZnJhbWUgY29uc2lzdHMgb2YgbGVmdCB0aGVuIHJpZ2h0IGNo
YW5uZWwgZGF0YS4KPj4gKyAqICAgICAgTGVmdCBjaGFubmVsIHN0YXJ0cyB3aXRoIHJpc2luZyBG
U1lOQyBlZGdlLCByaWdodCBjaGFubmVsIHN0YXJ0cyB3aXRoCj4+ICsgKiAgICAgIGZhbGxpbmcg
RlNZTkMgZWRnZS4KPgo+IFRoZXNlIGFyZSBqdXN0IGNhbGxlZCBsZWZ0IGFuZCByaWdodCBqdXN0
aWZpZWQgLSB0aGV5IGRvIGxvb2sgYSBsb3QgbGlrZQo+IEkyUyBidXQgSTJTIGlzbid0IHBhcnQg
b2YgdGhlIG5hbWUgaW4gbm9ybWFsIHVzYWdlIHNvIGl0J3MgYSBsaXR0bGUKPiBjb25mdXNpbmcu
Cj4KPiBBbHNvIGl0J3MgbW9yZSBub3JtYWwgd2hlbiB0YWxraW5nIGFib3V0IGJvdGggbGVmdCBh
bmQgcmlnaHQgdG8gbGlzdAo+IGxlZnQgZmlyc3QsIGl0IHNjYW5zIGJldHRlci4KClRoaXMgaGFz
IGFscmVhZHkgYmVlbiBhZGRyZXNzZWQgaW4gdGhlIHYyIGhlcmUgKHlvdSB3ZXJlIENjJ2VkKToK
aHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9waXBlcm1haWwvYWxzYS1kZXZlbC8yMDE1
LU9jdG9iZXIvMDk4MzA3Lmh0bWwKCkJlc3QgcmVnYXJkcywKQmVub8OudApfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlz
dApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
