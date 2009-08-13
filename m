From: Barry Song <21cnbao@gmail.com>
Subject: Re: [PATCH 1/3] new ad1836 codec driver based on asoc
Date: Thu, 13 Aug 2009 17:52:42 +0800
Message-ID: <3c17e3570908130252n1b85f618i974b9867dbef2a5d@mail.gmail.com>
References: <1250051574-25119-1-git-send-email-21cnbao@gmail.com>
	<1250051574-25119-2-git-send-email-21cnbao@gmail.com>
	<20090812134645.GC11898@rakim.wolfsonmicro.main>
	<3c17e3570908122041m29a1843agd0f9fd0e415181c3@mail.gmail.com>
	<20090813090801.GA31504@sirena.org.uk>
	<3c17e3570908130237g34f34228v1d57d872dfba20ea@mail.gmail.com>
	<20090813094633.GA21652@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yx0-f176.google.com (mail-yx0-f176.google.com
	[209.85.210.176])
	by alsa0.perex.cz (Postfix) with ESMTP id 9F08624403
	for <alsa-devel@alsa-project.org>;
	Thu, 13 Aug 2009 11:53:04 +0200 (CEST)
Received: by yxe6 with SMTP id 6so814988yxe.16
	for <alsa-devel@alsa-project.org>; Thu, 13 Aug 2009 02:53:02 -0700 (PDT)
In-Reply-To: <20090813094633.GA21652@rakim.wolfsonmicro.main>
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

T24gVGh1LCBBdWcgMTMsIDIwMDkgYXQgNTo0NiBQTSwgTWFyawpCcm93bjxicm9vbmllQG9wZW5z
b3VyY2Uud29sZnNvbm1pY3JvLmNvbT4gd3JvdGU6Cj4gT24gVGh1LCBBdWcgMTMsIDIwMDkgYXQg
MDU6Mzc6MDlQTSArMDgwMCwgQmFycnkgU29uZyB3cm90ZToKPgo+PiBJZiBzbywgYWxsIGNvZGVj
IGRyaXZlcnMgbmVlZCB0byBzYXZlIHNldHRpbmcgdGhlbiByZXN0b3JlIHRoZW0gd2hlbgo+PiBy
ZXN1bWUuIFRoZSBwaHlzaWNhbCBzaHV0ZG93biBkZXBlbmRzIG9uIGJvYXJkcyBncmVhdC4gSWYg
d2UgZ2V0IGFuCj4+IGluZGl2aWR1YWwgcHJvZ3JhbW1hYmxlIFBNVS9MRE8gdG8gY29udHJvbCB0
aGUgdm9sdGFnZSBpbnB1dCB0byB0aGlzCj4+IGNoaXAsIEkgY2FuIHNodXRkb3duIHBvd2VyLWlu
cHV0IHRvIGNvZGVjIHBoeXNpY2FsbHkgYW5kIHNhdmUgdGhlCj4+IHJlZ2lzdGVycyB3aGVuIHN1
c3BlbmQsIMKgdGhlbiByZXN0b3JlIHRoZW0gd2hlbiByZXN1bWUuIElmIG5vIHRoaXMKPj4gdW5p
dCwgc2hvdWxkIGV2ZXJ5IGNvZGVjIGRyaXZlciBoYW5kbGUgdGhpcyBjYXNlPwo+Cj4gWWVzLCBl
dmVyeSBDT0RFQyBkcml2ZXIgdGhhdCBzdXBwb3J0cyBzdXNwZW5kIGFuZCByZXN1bWUgbmVlZHMg
dG8gaGFuZGxlCj4gdGhpcy4gwqBTaW5jZSB0aGUgQ09ERUMgZHJpdmVycyBnZW5lcmFsbHkgdXNl
IGEgcmVnaXN0ZXIgY2FjaGUgaXQncwo+IG5vcm1hbGx5IGp1c3QgYSBjYXNlIG9mIHdyaXRpbmcg
dGhlIHZhbHVlcyBpbiB0aGUgY2FjaGUgYmFjayB0byB0aGUKPiBkZXZpY2UgYXQgdGhlIHN0YXJ0
IG9mIHJlc3VtZS4KPgpXZWxsLiBJZiBhbGwgY2hpcHMgbmVlZCB0aGlzIHNhbWUgb3BlcmF0aW9u
LCBjYW4gaXQgYmUgYWJzdHJhY3RlZCB0bwp0aGUgc29jIGNvcmUgbGF5ZXI/Cl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBs
aXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNhLXByb2pl
Y3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
