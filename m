From: Jassi Brar <jassisinghbrar@gmail.com>
Subject: Re: [PATCH v5 4/4] ASoC: SAMSUNG: Add I2S0 internal
	dma driver
Date: Wed, 13 Jul 2011 19:50:21 +0530
Message-ID: <CABb+yY0CuNj45w-dAJR49Y3ms_g-4wsOe5GbPMavevCwqJ2MNQ@mail.gmail.com>
References: <1310520321-11106-1-git-send-email-sbkim73@samsung.com>
	<CA+s+8rc=nwggHhX7qZ0sCsH=z6qTDj9Gc2385xLgK0R+An85wQ@mail.gmail.com>
	<CABb+yY31mq-uber-iaXBSsCCYoq0W04whVzFHd6XEfshxwpT+w@mail.gmail.com>
	<s5hoc0yg1yy.wl%tiwai@suse.de>
	<CABb+yY1GXVXnWL2sdTWm5_d4SQtbJ3FpZe8_XyFrsHODG5GRag@mail.gmail.com>
	<s5hk4bmfw8x.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51]) by alsa0.perex.cz (Postfix) with ESMTP id 4BD1224392
	for <alsa-devel@alsa-project.org>;
	Wed, 13 Jul 2011 16:20:22 +0200 (CEST)
Received: by bwa18 with SMTP id 18so5411807bwa.38
	for <alsa-devel@alsa-project.org>; Wed, 13 Jul 2011 07:20:21 -0700 (PDT)
In-Reply-To: <s5hk4bmfw8x.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Sangbeom Kim <sbkim73@samsung.com>, alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk, Seungwhan Youn <claude.youn@gmail.com>
List-Id: alsa-devel@alsa-project.org

T24gV2VkLCBKdWwgMTMsIDIwMTEgYXQgMToyNyBQTSwgVGFrYXNoaSBJd2FpIDx0aXdhaUBzdXNl
LmRlPiB3cm90ZToKCj4+IEFuIGltcG9ydGFudCBwYXJ0IG1pc3NpbmcgaW4gQ2xhdWRlJ3MgcXVv
dGUgaXMKPj4gKyDCoCDCoCDCoCAucGVyaW9kc19taW4gPSAxLAo+PiArIMKgIMKgIMKgIC5wZXJp
b2RzX21heCA9IDIsCj4+Cj4+IFdoZW4gdGhlIHBlcmlvZHNfbWF4IGlzIG9ubHkgMiwgdGhlIGNh
bGN1bGF0aW9ucyBpbiBBTFNBIG1pZC1sYXllcgo+PiBzZWVtIHRvIGFsd2F5cwo+PiBkZWNpZGUg
b24gdXNpbmcgdHdvIGVxdWFsIHNpemUgcGVyaW9kcy4KPj4KPj4gSSBkaWRuJ3QgZGlnIGluIHRo
ZSBsb2dpYyBidXQgd2Fzbid0IGFibGUgdG8gZ2V0IGFueSBhcHBsaWNhdGlvbiB0bwo+PiBjb25m
aWd1cmUgc29tZXRoaW5nCj4+IGxpa2Uge1BlcmlvZF9zaXplID0gOTAlIG9mIEJ1ZmZlcl9zaXpl
fSDCoHdoaWNoIGlzIGFjdHVhbGx5IGJlbmVmaWNpYWwgZm9yCj4+IExvdy1Qb3dlci1BdWRpby1N
b2RlLgo+Cj4gRXZlbiB5b3UgZG9uJ3Qgc2V0IHRoZSBpbnRlZ2VyIGNvbnN0cmFpbnQsIHJpZ2h0
PwpSaWdodCwgSSBkaWRuJ3Qgc2V0IHNldCB0aGUgaW50ZWdlciBjb25zdHJhaW50IGluIHRoaXMg
aWRtYSBkcml2ZXIuCgo+IERvZXMgaXQgaGFwcGVuIHdpdGggYXBsYXkgd2l0aCAtRGh3PwpZZXMs
IEkgcmVtZW1iZXIgdGVzdGluZyB3aXRob3V0IHBsdWdpbnMuCgo+IEluIHRoZSBkcml2ZXIgc2lk
ZSwgdGhlcmUgaXMgYSBkZWZpbmUgUlVMRVNfREVCVUcgaW4KPiBzb3VuZC9jb3JlL3BjbV9uYXRp
dmUuYywgd2hpY2ggd2lsbCBlbmFibGUgZGVidWcgcHJpbnRzIG9mIGh3LXJlZmluZXMuCj4gQSBz
aW1pbGFyIGZsYWcgaXMgZm91bmQgaW4gYWxzYS1saWIvc3JjL3BjbS9wY21fcGFyYW1zLmMsIHRv
by4KSSBkb24ndCBoYXZlIGFjY2VzcyB0byB0aGUgaC93IGFueW1vcmUuCk1heWJlIHNvbWVvbmUg
ZnJvbSBTYW1zdW5nIGNvdWxkIGRpZyBpbnRvIGl0IGFuZCBmaW5kIHNvbWV0aGluZyB1c2VmdWwg
PwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRl
dmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxt
YW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
