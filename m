From: Jassi Brar <jassisinghbrar@gmail.com>
Subject: Re: [PATCH 4/4] ASoC: ep93xx: add Simplemachines
 Sim.One AC97 audio support
Date: Mon, 11 Oct 2010 16:46:29 +0900
Message-ID: <AANLkTinWdma1673ayrnvwzPgD9M51YZRF60rad8CnU-y@mail.gmail.com>
References: <cover.1286707213.git.mika.westerberg@iki.fi>
	<cbadad77a7e11b27fedd9e92fe05322291ca1377.1286707213.git.mika.westerberg@iki.fi>
	<AANLkTi=PAp8pQeVM=GWYVVeKnf2-f+YG2bdSuu5QZH87@mail.gmail.com>
	<20101011073816.GC27142@gw.healthdatacare.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51]) by alsa0.perex.cz (Postfix) with ESMTP id 5DA17243EB
	for <alsa-devel@alsa-project.org>;
	Mon, 11 Oct 2010 09:46:31 +0200 (CEST)
Received: by bwz18 with SMTP id 18so1931927bwz.38
	for <alsa-devel@alsa-project.org>; Mon, 11 Oct 2010 00:46:31 -0700 (PDT)
In-Reply-To: <20101011073816.GC27142@gw.healthdatacare.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mika Westerberg <mika.westerberg@iki.fi>
Cc: alsa-devel@alsa-project.org, martinwguy@gmail.com, broonie@opensource.wolfsonmicro.com, hsweeten@visionengravers.com, ryan@bluewatersys.com, linux-arm-kernel@lists.infradead.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

T24gTW9uLCBPY3QgMTEsIDIwMTAgYXQgNDozOCBQTSwgTWlrYSBXZXN0ZXJiZXJnIDxtaWthLndl
c3RlcmJlcmdAaWtpLmZpPiB3cm90ZToKPiBPbiBNb24sIE9jdCAxMSwgMjAxMCBhdCAwOToyMjo1
MUFNICswOTAwLCBKYXNzaSBCcmFyIHdyb3RlOgo+PiBPbiBTdW4sIE9jdCAxMCwgMjAxMCBhdCA3
OjU0IFBNLCBNaWthIFdlc3RlcmJlcmcgPG1pa2Eud2VzdGVyYmVyZ0Bpa2kuZmk+IHdyb3RlOgo+
Pgo+PiA+ICsKPj4gPiArc3RhdGljIHN0cnVjdCBzbmRfc29jX2RhaV9saW5rIHNpbW9uZV9kYWkg
PSB7Cj4+ID4gKyDCoCDCoCDCoCAubmFtZSDCoCDCoCDCoCDCoCDCoCA9ICJBQzk3IiwKPj4gPiAr
IMKgIMKgIMKgIC5zdHJlYW1fbmFtZSDCoCDCoD0gIkFDOTcgSGlGaSIsCj4+ID4gKyDCoCDCoCDC
oCAuY3B1X2RhaSDCoCDCoCDCoCDCoD0gJmVwOTN4eF9hYzk3X2RhaSwKPj4gPiArIMKgIMKgIMKg
IC5jb2RlY19kYWkgwqAgwqAgwqA9ICZhYzk3X2RhaSwKPj4gPiArfTsKPj4gQVNvQyBubyBsb25n
ZXIgd29ya3Mgb24gY3B1IGFuZCBjb2RlY19kYWkuIFlvdSBuZWVkIHRvIG9ubHkKPj4gcHJvdmlk
ZSB0aGUgbmFtZSBvZiB0aGUgZGFpcy4uLiBBU29DIGRvZXMgc3RyaW5nIG1hdGNoaW5nIHRvCj4+
IGxpbmsgYXBwcm9wcmlhdGUgZGFpcyBpbiBhIGxpbmsuCj4+Cj4+IFlvdSBtaWdodCB3YW50IHRv
IGdpdmUgYW5vdGhlciB0aG9yb3VnaCBsb29rIHRvIGFsbCBvZiB5b3VyIGRyaXZlcnMKPj4gdW5k
ZXIgdGhlIG5ldyBBU29DLgo+Cj4gVGhhbmtzLgo+Cj4gV2hpY2ggdHJlZS9icmFuY2ggc2hvdWxk
IEkgdXNlIGZvciBwcmVwYXJpbmcgdGhlIGRyaXZlciB0byB3b3JrCj4gd2l0aCB0aGUgbmV3IEFT
b0M/IElzIGl0IHRoZSBvZmZpY2lhbAo+IGdpdDovL2dpdC5hbHNhLXByb2plY3Qub3JnL2Fsc2Et
a2VybmVsIHRyZWUgb3Igc29tZXRoaW5nIGVsc2U/CgpodHRwOi8vZ2l0Lmtlcm5lbC5vcmcvP3A9
bGludXgva2VybmVsL2dpdC9icm9vbmllL3NvdW5kLTIuNi5naXQ7YT1zaG9ydGxvZztoPXJlZnMv
aGVhZHMvZm9yLTIuNi4zNwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5v
cmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2Et
ZGV2ZWwK
