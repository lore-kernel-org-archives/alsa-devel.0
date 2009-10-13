From: Barry Song <21cnbao@gmail.com>
Subject: Re: dev_* output functions and ASoC codecs
Date: Tue, 13 Oct 2009 18:09:07 +0800
Message-ID: <3c17e3570910130309r3ffed293g9cc8f9bd0c845d4@mail.gmail.com>
References: <8bd0f97a0910051718w5d97df8dr443917def9da9ac@mail.gmail.com>
	<20091006102033.GC27168@sirena.org.uk>
	<3c17e3570910111926u186586cdq2646d5aaade3121a@mail.gmail.com>
	<20091012093601.GA22233@sirena.org.uk>
	<3c17e3570910120334u6646b031vb5300645da8b6ce4@mail.gmail.com>
	<20091012104849.GA7994@rakim.wolfsonmicro.main>
	<3c17e3570910120620g7e65f87ekeb854c373375b7a3@mail.gmail.com>
	<20091012142018.GA18283@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yx0-f183.google.com (mail-yx0-f183.google.com
	[209.85.210.183])
	by alsa0.perex.cz (Postfix) with ESMTP id 272021038B1
	for <alsa-devel@alsa-project.org>;
	Tue, 13 Oct 2009 12:09:29 +0200 (CEST)
Received: by yxe13 with SMTP id 13so2259737yxe.23
	for <alsa-devel@alsa-project.org>; Tue, 13 Oct 2009 03:09:28 -0700 (PDT)
In-Reply-To: <20091012142018.GA18283@rakim.wolfsonmicro.main>
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
Cc: uclinux-dist-devel@blackfin.uclinux.org, "Cai,
	Cliff" <Cliff.Cai@analog.com>, alsa-devel@alsa-project.org, Mike Frysinger <vapier.adi@gmail.com>
List-Id: alsa-devel@alsa-project.org

T24gTW9uLCBPY3QgMTIsIDIwMDkgYXQgMTA6MjAgUE0sIE1hcmsgQnJvd24KPGJyb29uaWVAb3Bl
bnNvdXJjZS53b2xmc29ubWljcm8uY29tPiB3cm90ZToKPiBPbiBNb24sIE9jdCAxMiwgMjAwOSBh
dCAwOToyMDoxOFBNICswODAwLCBCYXJyeSBTb25nIHdyb3RlOgo+Cj4+IFRoYW5rcyBhIGxvdC4g
Rm9ydHVuYXRlbHksIFlvdSBwYXJzZWQgbXkgbWVhbmluZyB3ZWxsLiBJIGp1c3Qgd2FudCB0bwo+
PiBzYXkgaXQgc2VlbXMgbm90IHRvbyBlY29ub21pYyB0byBoYXZlIGFycmF5cyB3aXRoIGFsbW9z
dCBzYW1lIG1lbWJlcnMKPj4gd2hpbGUgQ1BVIGludGVyZmFjZXMgYW5kIGNvZGVjcyBhcmUgc2Ft
ZSBmb3IgYWxsIGRhaV9saW5rcy4gZGFpWzBdIGFuZAo+PiBkYWlbMV0gaW4gYXJyYXkgYXJlIGp1
c3Qgc2FtZS4gwqBJdCBzZWVtcyB0aGF0IHdpbGwgbWFrZSBtb3JlIHNlbnNlIGlmCj4KPiBUaGUg
Y3VycmVudCBwbGFuIGlzIHRvIGFsbG93IGEgZGV2X25hbWUgcGx1cyBEQUkgaW5kZXggaW5zdGVh
ZCBvZiB0aGUKPiBwb2ludGVyIHRvIGJlIHVzZWQgdG8gZXN0YWJsaXNoIHRoZSBsaW5rLCB0aG91
Z2ggSSBjYW4ndCBndWFyYW50ZWUgdGhhdAo+IHBhcnRpY3VsYXIgYXBwcm9hY2ggdW50aWwgaXQn
cyBpbXBsZW1lbnRlZC4KQW5vdGhlciBpc3N1ZSBpcyB0aGF0IHRoZXJlIGlzIG9ubHkgb25lIGds
b2JhbCBzb2NfYWM5N19vcHMgaW4gdGhlCndob2xlIHN5c3RlbS4gSW4gY2FzZSB0aGVyZSBhcmUg
dHdvIGRpZmZlcmVudCBhYzk3IHBvcnRzLCBob3cgdG8KaGFuZGxlPwpFdmVuIHRob3VnaCB0aGUg
dHdvIGFjOTcgcG9ydHMgYXJlIHNhbWUsIGhvdyBjb3VsZCBDUFUgREFJIHJlbGF0ZWQKcHJpdmF0
ZSBkYXRhIGNhbiBiZSBnaXZlbiB0byBzbmRfYWM5NyB0byBsZXQgaXQgdXNlIHRoYXQgZGF0YSB0
bwpleGVjdXRlIGRpZmZlcmVudCBvcGVyYXRpb25zPyBJdCBzZWVtcyBzbmRfYWM5NyBpcyBvbmx5
IGF0dGFjaGVkIHRvCmNvZGVjLgoKPgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJv
amVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2Fsc2EtZGV2ZWwK
