From: Barry Song <21cnbao@gmail.com>
Subject: Re: dev_* output functions and ASoC codecs
Date: Tue, 20 Oct 2009 13:27:14 +0800
Message-ID: <3c17e3570910192227n286b26d9pe58008a4cb4935f@mail.gmail.com>
References: <8bd0f97a0910051718w5d97df8dr443917def9da9ac@mail.gmail.com>
	<20091006102033.GC27168@sirena.org.uk>
	<3c17e3570910111926u186586cdq2646d5aaade3121a@mail.gmail.com>
	<20091012093601.GA22233@sirena.org.uk>
	<3c17e3570910120334u6646b031vb5300645da8b6ce4@mail.gmail.com>
	<20091012104849.GA7994@rakim.wolfsonmicro.main>
	<3c17e3570910120620g7e65f87ekeb854c373375b7a3@mail.gmail.com>
	<20091012142018.GA18283@rakim.wolfsonmicro.main>
	<3c17e3570910130309r3ffed293g9cc8f9bd0c845d4@mail.gmail.com>
	<20091013101445.GA29177@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yx0-f196.google.com (mail-yx0-f196.google.com
	[209.85.210.196])
	by alsa0.perex.cz (Postfix) with ESMTP id C6D5D24570
	for <alsa-devel@alsa-project.org>;
	Tue, 20 Oct 2009 07:27:35 +0200 (CEST)
Received: by yxe34 with SMTP id 34so4521855yxe.16
	for <alsa-devel@alsa-project.org>; Mon, 19 Oct 2009 22:27:34 -0700 (PDT)
In-Reply-To: <20091013101445.GA29177@rakim.wolfsonmicro.main>
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

T24gVHVlLCBPY3QgMTMsIDIwMDkgYXQgNjoxNCBQTSwgTWFyayBCcm93bgo8YnJvb25pZUBvcGVu
c291cmNlLndvbGZzb25taWNyby5jb20+IHdyb3RlOgo+IE9uIFR1ZSwgT2N0IDEzLCAyMDA5IGF0
IDA2OjA5OjA3UE0gKzA4MDAsIEJhcnJ5IFNvbmcgd3JvdGU6Cj4KPj4gQW5vdGhlciBpc3N1ZSBp
cyB0aGF0IHRoZXJlIGlzIG9ubHkgb25lIGdsb2JhbCBzb2NfYWM5N19vcHMgaW4gdGhlCj4+IHdo
b2xlIHN5c3RlbS4gSW4gY2FzZSB0aGVyZSBhcmUgdHdvIGRpZmZlcmVudCBhYzk3IHBvcnRzLCBo
b3cgdG8KPj4gaGFuZGxlPwo+Cj4+IEV2ZW4gdGhvdWdoIHRoZSB0d28gYWM5NyBwb3J0cyBhcmUg
c2FtZSwgaG93IGNvdWxkIENQVSBEQUkgcmVsYXRlZAo+PiBwcml2YXRlIGRhdGEgY2FuIGJlIGdp
dmVuIHRvIHNuZF9hYzk3IHRvIGxldCBpdCB1c2UgdGhhdCBkYXRhIHRvCj4+IGV4ZWN1dGUgZGlm
ZmVyZW50IG9wZXJhdGlvbnM/IEl0IHNlZW1zIHNuZF9hYzk3IGlzIG9ubHkgYXR0YWNoZWQgdG8K
Pj4gY29kZWMuCj4KPiBJJ3ZlIG5vIGN1cnJlbnQgcGxhbiB0byB3b3JrIG9uIG11bHRpcGxlIEFD
OTcgY29udHJvbGxlcnMgc3VwcG9ydCB3aXRoaW4KPiBBU29DIGV4Y2VwdCBpbiBzbyBmYXIgYXMg
aXQgZmFsbHMgb3V0IG9mIG90aGVyIHdvcmsgLSBJJ3ZlIG5ldmVyCj4gZW5jb3VudGVyZWQgYW4g
ZW1iZWRkZWQgc3lzdGVtIHdpdGggbXVsdGlwbGUgQUM5NyBjb250cm9sbGVycyBzbyBpdCdzIGEK
PiBzb21ld2hhdCBhY2FkZW1pYyBpc3N1ZS4gwqBQYXRjaGVzIHdlbGNvbWUsIHRob3VnaCBJJ2Qg
ZXhwZWN0IGl0J2QgYmUKPiBzZW5zaWJsZSB0byB3YWl0IHVudGlsIG11bHRpLWNhcmQgc3VwcG9y
dCBpcyBwcmVzZW50LgpDdXJyZW50bHksICB0aGlzIHBhdGNoIHNob3VsZCBjYW4gaGVscCBwZW9w
bGUgdG8gc2V0IHBsYXRmb3JtX2RhdGEgdG8Kc25kX2FjOTcsIGFuZCBkaWZmZXJlbnQgb3BlcmF0
aW9uIGNhbiBiZSBmdWxmaWxsZWQgYmFzZWQgb24gZGlmZmVyZW50CmFjOTdfcGRhdGEgZXZlbiB3
aXRoIG9ubHkgb25lIGFjOTcgb3BzIGluc3RhbmNlLgoKYXV0aG9yCU1hcmVrIFZhc3V0IDxtYXJl
ay52YXN1dEBnbWFpbC5jb20+CQoJV2VkLCAyMiBKdWwgMjAwOSAxMTowMTowMyArMDAwMCAoMTM6
MDEgKzAyMDApCmNvbW1pdAk0NzQ4MjhhNDBmNmRkYWI2ZTJhMzQ3NWExOWM1Yzg0YWEzZWM3ZDYw
CgpBTFNBOiBBbGxvdyBwYXNzaW5nIHBsYXRmb3JtX2RhdGEgdG8gZGV2aWNlcyBhdHRhY2hlZCB0
byBBQzk3IGJ1cwoKVGhpcyBwYXRjaCBhbGxvd3MgcGFzc2luZyBwbGF0Zm9ybV9kYXRhIHRvIGRl
dmljZXMgYXR0YWNoZWQgdG8gQUM5NyBidXMKKGxpa2UgdG91Y2hzY3JlZW5zLCBiYXR0ZXJ5IG1l
YXN1cmVtZW50IGNoaXBzIC4uLikuCgpTaWduZWQtb2ZmLWJ5OiBNYXJlayBWYXN1dCA8bWFyZWsu
dmFzdXRAZ21haWwuY29tPgpTaWduZWQtb2ZmLWJ5OiBNYXJrIEJyb3duIDxicm9vbmllQG9wZW5z
b3VyY2Uud29sZnNvbm1pY3JvLmNvbT4KCj4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNh
LXByb2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0
aW5mby9hbHNhLWRldmVsCg==
