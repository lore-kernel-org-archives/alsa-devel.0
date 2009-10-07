From: Mike Frysinger <vapier.adi@gmail.com>
Subject: Re: [Uclinux-dist-devel] [PATCH 2/2] ASoC: Blackfin
	AD1836/AD1938 machine drivers: require SPI master
Date: Wed, 7 Oct 2009 04:32:06 -0400
Message-ID: <8bd0f97a0910070132x2c6a1a38w373cf929d4645ef6@mail.gmail.com>
References: <1254808311-3594-1-git-send-email-vapier@gentoo.org>
	<20091006093325.GA10118@rakim.wolfsonmicro.main>
	<8bd0f97a0910060241k1155d38cmafe623501106d598@mail.gmail.com>
	<20091006095018.GB27168@sirena.org.uk>
	<8bd0f97a0910060300m7fa80daas63afd272ba85fb16@mail.gmail.com>
	<20091006103952.GC10118@rakim.wolfsonmicro.main>
	<8bd0f97a0910060432o67e9d00bu84c0139701709e63@mail.gmail.com>
	<20091006115216.GA12993@rakim.wolfsonmicro.main>
	<8bd0f97a0910061409x254b5574wdb0125db0548678@mail.gmail.com>
	<20091006220725.GA32267@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yx0-f175.google.com (mail-yx0-f175.google.com
	[209.85.210.175])
	by alsa0.perex.cz (Postfix) with ESMTP id 1E78D244B7
	for <alsa-devel@alsa-project.org>;
	Wed,  7 Oct 2009 10:32:27 +0200 (CEST)
Received: by yxe5 with SMTP id 5so5025369yxe.24
	for <alsa-devel@alsa-project.org>; Wed, 07 Oct 2009 01:32:26 -0700 (PDT)
In-Reply-To: <20091006220725.GA32267@opensource.wolfsonmicro.com>
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
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

T24gVHVlLCBPY3QgNiwgMjAwOSBhdCAxODowNywgTWFyayBCcm93biB3cm90ZToKPiBPbiBUdWUs
IE9jdCAwNiwgMjAwOSBhdCAwNTowOTo0MlBNIC0wNDAwLCBNaWtlIEZyeXNpbmdlciB3cm90ZToK
Pj4gaSBkb250IHNlZSBob3cgYWJzdHJhY3RpbmcgYXdheSB0aGUgYnVzIHN1Y2ggdGhhdCBjb2Rl
YyBkcml2ZXJzIGFyZQo+PiBhbGxvd2VkIHRvIGJ1aWxkIHdpdGhvdXQgcHJvcGVyIGJ1cyBzdXBw
b3J0IGlzIHVzZWZ1bC4gwqB0aGUKPj4gQUQxODM2L0FEMTkzOCBvbmx5IHdvcmsgd2l0aCB0aGUg
U1BJIGJ1cywgc28gaWYgc3VwcG9ydCBmb3IgdGhhdCBpcwo+PiBkaXNhYmxlZCwgaGF2aW5nIHRo
ZSBkcml2ZXIgY29tcGlsZWQgYW5kIGluc3RhbGxlZCBpcyBwb2ludGxlc3MuCj4KPiBCb3RoIGFw
cHJvYWNoZXMgYWxsb3cgZHJpdmVycyB0byBiZSBidWlsdCB3aGljaCBjYW4ndCBhY3R1YWxseSBi
ZSB1c2VkCj4gc2luY2UgbmVpdGhlciBndWFyYW50ZWVzIHRoYXQgdGhlcmUgd2lsbCBiZSBhIGRy
aXZlciBmb3IgdGhlIFNQSQo+IGNvbnRyb2xsZXIuIMKgRWl0aGVyIHdheSBhbGwgd2UncmUgZG9p
bmcgaXMgbWFraW5nIHN1cmUgdGhhdCB0aGUga2VybmVsCj4gd2lsbCBidWlsZCwgdGhlIHVzZXIg
Y2FuIHN0aWxsIGJ1aWxkIHRoaW5ncyBzbyB0aGF0IHRoZSBhdWRpbyBkcml2ZXIKPiB3b24ndCBk
byBhbnl0aGluZyB1c2VmdWwuCgpobW0sIHRoYXQncyBjZXJ0YWlubHkgdHJ1ZS4gIGlmIHdlIGxv
b2sgYXQgaXQgYXMgInNjcmV3ZWQgZWl0aGVyIHdheSIsCnRoZW4gZ29pbmcgdG8gYSBnZW5lcmlj
IGJ1cyBpbmRpcmVjdGlvbiBzb3VuZHMgbGlrZSBpdCdkIG9ubHkgYWRkCnJ1bnRpbWUgb3Zlcmhl
YWQgZm9yIG5vIHJlYWwgZ2FpbiA/CgppbiB0aGUgZmFjZSBvZiB0aGlzIHByb3Bvc2VkIGVmZm9y
dCBiZWluZyBhIHdheXMgb2ZmLCBkb2VzbnQgaXQgbWFrZQpzZW5zZSB0byBzdGlsbCBtZXJnZSB0
aGUgb3JpZ2luYWwgcHJvcG9zZWQgcGF0Y2ggPwotbWlrZQpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRl
dmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWls
bWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
