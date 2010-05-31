From: Wan ZongShun <mcuos.com@gmail.com>
Subject: Re: [PATCH v2] alsa/Au1xxx-PSC: use resource_size
Date: Mon, 31 May 2010 20:36:09 +0800
Message-ID: <AANLkTimMrLX-u6GTqX_r6-2j6-ZeEFjoaTBnriPTUkrD@mail.gmail.com>
References: <4BFF33B3.1040506@gmail.com>
	<AANLkTil1hKb8QdsKEfHseOyPdw8uIY6d5mVEUwZ68T-p@mail.gmail.com>
	<AANLkTimQD4TihG2yGsPLGmCmWV968fdoDtZ1nDcW5A-h@mail.gmail.com>
	<4BFF5838.8050403@gmail.com>
	<AANLkTikn3BHn1D3uVQWO6Xuiv4vkk8pMe96F7uUUSAmM@mail.gmail.com>
	<4BFF633B.7030101@gmail.com>
	<AANLkTim9C08G5iOuKE9XOtFRlS616c6yk-7LNLddbVCl@mail.gmail.com>
	<4BFF87DC.4010300@gmail.com>
	<20100531110805.GE3489@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 46E9F1038B3
	for <alsa-devel@alsa-project.org>;
	Mon, 31 May 2010 14:36:11 +0200 (CEST)
Received: by vws5 with SMTP id 5so1889610vws.38
	for <alsa-devel@alsa-project.org>; Mon, 31 May 2010 05:36:10 -0700 (PDT)
In-Reply-To: <20100531110805.GE3489@rakim.wolfsonmicro.main>
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
Cc: Manuel Lauss <manuel.lauss@googlemail.com>, alsa-devel <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

SGkgTWFyaywKClRoYW5rcyBmb3IgeW91ciBjb21tZW50cy4KUmVnYXJkaW5nIHRoZSBwYXRjaCBy
ZWxhdGVkIHRvIEF1MXh4eC1QU0MsCkkgd2lsbCBtb2RpZnkgdGhlIHBhdGNoIGFuZCByZXNlbmQg
aXQgdG9tb3Jyb3csIHBsZWFzZSBkcm9wIGFsbCB0aGUKcHJldmlvdXMgb25lcy4KCjIwMTAvNS8z
MSBNYXJrIEJyb3duIDxicm9vbmllQG9wZW5zb3VyY2Uud29sZnNvbm1pY3JvLmNvbT46Cj4gT24g
RnJpLCBNYXkgMjgsIDIwMTAgYXQgMDU6MDc6NDBQTSArMDgwMCwgV2FuIFpvbmdTaHVuIHdyb3Rl
Ogo+PiBEZWFyIE1hcmsgJiBMaWFtLAo+Pgo+PiBhbHNhIEF1MXh4eC1QU0MgdXNlIHJlc291cmNl
X3NpemUuCj4+Cj4+IE1hbnVlbCBoYXMgYWdyZWVkIHRoaXMgZm9sbG93aW5nIHZlcnNpb24gcGF0
Y2gsIG5vdywgY2FuIGl0IGJlIG1lcmdlZD8KPgo+IFRoaXMgaGFzIHdvcmR3cmFwIGlzc3VlcyBh
bmQgd29uJ3QgYXBwbHksIHBsZWFzZSByZXNlbmQuIMKgQXMgSSBzYWlkCj4gcHJldmlvdXNseSBw
bGVhc2UgYWxzbyB0cnkgdG8gZm9sbG93IERvY3VtZW50YXRpb24vU3VibWl0dGluZ1BhdGNoZXMK
PiAoZWcsIGRvbid0IGhhdmUgbm9uLWNoYW5nZWxvZyB0ZXh0IGFib3ZlIHRoZSAtLS0gaW4gdGhl
IG1haWwgYW5kIHVzZSBhCj4gc3RhbmRhcmQgcHJlZml4IGZvciB0aGUgc3ViamVjdCBsaW5lKS4K
PgoKCgotLSAKKmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0Cm1haWwgYWRkcjpsaW51eC1h
cm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKeW91IGNhbiBzdWJzY3JpYmUgYnk6Cmh0dHA6
Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAoK
KiBsaW51eC1hcm0tTlVDOTAwIG1haWxpbmcgbGlzdAptYWlsIGFkZHI6TlVDOTAwQGdvb2dsZWdy
b3Vwcy5jb20KbWFpbiB3ZWI6IGh0dHBzOi8vZ3JvdXBzLmdvb2dsZS5jb20vZ3JvdXAvTlVDOTAw
CnlvdSBjYW4gc3Vic2NyaWJlIGl0IGJ5IHNlbmRpbmcgbWUgbWFpbDoKbWN1b3MuY29tQGdtYWls
LmNvbQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNh
LWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21h
aWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
