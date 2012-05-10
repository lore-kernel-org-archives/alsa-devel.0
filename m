From: Jassi Brar <jassisinghbrar@gmail.com>
Subject: Re: ALSA calling pcm_pointer excessively?
Date: Thu, 10 May 2012 22:48:43 +0530
Message-ID: <CABb+yY3ZSHxtArJJg0V0E2e85igjRk6gxDwshYSpdOJU1wrJng@mail.gmail.com>
References: <20120510160601.GC12727@n2100.arm.linux.org.uk>
	<CABb+yY2ivTKqg9q6hB1OLzBHo7zCWO74As048o-jacKkx0wD1w@mail.gmail.com>
	<20120510170441.GE12727@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f51.google.com (mail-bk0-f51.google.com
	[209.85.214.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 6635610BAE9
	for <alsa-devel@alsa-project.org>;
	Thu, 10 May 2012 19:18:44 +0200 (CEST)
Received: by bkcjg15 with SMTP id jg15so1593221bkc.38
	for <alsa-devel@alsa-project.org>; Thu, 10 May 2012 10:18:44 -0700 (PDT)
In-Reply-To: <20120510170441.GE12727@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

T24gVGh1LCBNYXkgMTAsIDIwMTIgYXQgMTA6MzQgUE0sIFJ1c3NlbGwgS2luZyAtIEFSTSBMaW51
eAo8bGludXhAYXJtLmxpbnV4Lm9yZy51az4gd3JvdGU6Cj4gT24gVGh1LCBNYXkgMTAsIDIwMTIg
YXQgMTA6MzA6NDRQTSArMDUzMCwgSmFzc2kgQnJhciB3cm90ZToKPj4gT24gVGh1LCBNYXkgMTAs
IDIwMTIgYXQgOTozNiBQTSwgUnVzc2VsbCBLaW5nIC0gQVJNIExpbnV4Cj4+IDxsaW51eEBhcm0u
bGludXgub3JnLnVrPiB3cm90ZToKPj4gPgo+PiA+IFRoZSBxdWVzdGlvbiBpcyAtIHdoYXQgd291
bGQgY2F1c2UgQUxTQSB0byBoYW1tZXIgYXdheSBhdCB0aGUgYnVmZmVyCj4+ID4gbGlrZSB0aGF0
IC0gY2hlY2tpbmcgaXQgZXZlcnkgMTYgb3IgOCBETUEgYnl0ZXMgdHJhbnNmZXJyZWQ/IMKgSSdt
IGFsc28KPj4gPiBzZWVpbmcgYXJvdW5kIDc1JSBzeXN0ZW0gQ1BVIHRpbWUsIHdoaWNoIHJlYWxs
eSBpc24ndCBnb29kLgo+PiA+Cj4+ID4gVGhlIGFib3ZlIHdhcyBjYXB0dXJlZCB3aGlsZSBhcGxh
eSB3YXMgcnVubmluZywgd2l0aCBubyBhcHBhcmFudCBhdWRpbwo+PiA+IGNvcnJ1cHRpb24uCj4+
ID4KPj4gPiBBbnkgaWRlYXM/Cj4+ID4KPj4gSSBiZWxpZXZlIGl0J3MgYmVjYXVzZSB0aGUgcGNt
J3Mgd3JpdGUgdHJpZXMgdG8ga2VlcCB0aGUgZGF0YSBpbiByaW5nCj4+IGJ1ZmZlciBmaWxsZWQK
Pj4gdXB0byBicmltIGFuZCBrZWVwcyBwb2xsaW5nIHRoZSBkbWEgcG9zaXRpb24gdGlsbCBpdCBr
ZWVwcyByZXBvcnRpbmcKPj4gc29tZSBwcm9ncmVzcy4KPj4KPj4gSSB0aGluayBpZiB5b3UgY291
bGQgYXZvaWQgdGhhdCBiZWhhdmlvciBpZiB5b3VyIGRyaXZlciBjYXJlZnVsbHkKPj4ga2VlcHMg
bmVnbGlnaWJsZQo+PiBwcm9ncmVzc2VzIHRvIGl0c2VsZiBhbmQgcmVwb3J0IG9ubHkgY29uc2lk
ZXJhYmxlIG9uZXMuIEJhc2ljYWxseSwgY29yZSB3b3VsZAo+PiBzdG9wIHBvbGxpbmcgYW5kIHdh
aXQgb24gcXVldWUgd2hlbiB0d28gcG9pbnRlciBjYWxscyByZXR1cm4gc2FtZSB2YWx1ZSBpLmUg
bm8KPj4gcHJvZ3Jlc3MuCj4KPiBZb3UgX2NvdWxkXyBidXQgd2h5IHNob3VsZCBkcml2ZXJzIHdv
cmsgYXJvdW5kIHNpbGx5IGJlaGF2aW91ciBpbiB0aGUKPiBBTFNBIGNvcmU/Cj4KT25lIHJlYXNv
biBJIGNvdWxkIHRoaW5rIG9mIGlzIHRvIHNhdmUgdXMgZnJvbSB1bmRlci1ydW5zIGZvciBhcyBs
b25nCmFzIHBvc3NpYmxlLgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5v
cmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2Et
ZGV2ZWwK
