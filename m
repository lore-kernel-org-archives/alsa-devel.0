From: Mike Frysinger <vapier.adi@gmail.com>
Subject: Re: [Uclinux-dist-devel] [PATCH 2/2] ASoC: Blackfin
	AD1836/AD1938 machine drivers: require SPI master
Date: Tue, 6 Oct 2009 06:00:23 -0400
Message-ID: <8bd0f97a0910060300m7fa80daas63afd272ba85fb16@mail.gmail.com>
References: <1254808311-3594-1-git-send-email-vapier@gentoo.org>
	<1254808311-3594-2-git-send-email-vapier@gentoo.org>
	<20091006093325.GA10118@rakim.wolfsonmicro.main>
	<8bd0f97a0910060241k1155d38cmafe623501106d598@mail.gmail.com>
	<20091006095018.GB27168@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f199.google.com (mail-yw0-f199.google.com
	[209.85.211.199])
	by alsa0.perex.cz (Postfix) with ESMTP id 105F41039EF
	for <alsa-devel@alsa-project.org>;
	Tue,  6 Oct 2009 12:00:43 +0200 (CEST)
Received: by ywh37 with SMTP id 37so3594960ywh.17
	for <alsa-devel@alsa-project.org>; Tue, 06 Oct 2009 03:00:43 -0700 (PDT)
In-Reply-To: <20091006095018.GB27168@sirena.org.uk>
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

T24gVHVlLCBPY3QgNiwgMjAwOSBhdCAwNTo1MCwgTWFyayBCcm93biB3cm90ZToKPiBPbiBUdWUs
IE9jdCAwNiwgMjAwOSBhdCAwNTo0MTo0MEFNIC0wNDAwLCBNaWtlIEZyeXNpbmdlciB3cm90ZToK
Pj4gdGhlcmUgaXMgbm8gZGVwZW5kZW5jeSBvbiBhIHNwZWNpZmljIHNwaSBidXMgbWFzdGVyIGlt
cGxlbWVudGF0aW9uLgo+PiBqdXN0IGxpa2UgdGhlIGkyYyBmcmFtZXdvcmssIHN1Y2ggYSBkZXBl
bmRlbmN5IHdvdWxkIGJlIGFnYWluc3QgdGhlCj4+IHdob2xlIHB1cnBvc2Ugb2YgaGF2aW5nIGEg
Z2VuZXJpYyBmcmFtZXdvcmsgaW4gdGhlIGZpcnN0IHBsYWNlLgo+PiBmb3J0dW5hdGVseSwgdGhp
cyBpcyBvbmUgcGllY2Ugb2YgdGhlIEJsYWNrZmluIEFTb0MgZHJpdmVycyBkb25lCj4+IGNvcnJl
Y3RseS4gwqBpbiBvdGhlciB3b3JkcywgdGhleSBzaG91bGQgd29yayBqdXN0IGZpbmUgaWYgaG9v
a2VkIHVwIHRvCj4+IGEgR1BJTyBTUEkgYnVzIG9yIGEgU1BPUlQgU1BJIGJ1cyBvciBhIEJsYWNr
ZmluIG9uLWNoaXAgU1BJIGJ1cyBvcgo+PiAuLi4uLi4KPgo+IFRoZXNlIGFyZSBib2FyZC1zcGVj
aWZpYyBkcml2ZXJzIHRvIGhvb2sgdGhpbmdzIHVwIG9uIGEgZ2l2ZW4gc3lzdGVtCj4gKHByZXN1
bWFibHkgdmFyaW91cyBldmFsIGJvYXJkcyksIHRoZXkncmUgdGhlIG5vbi1nZW5lcmljIHBhcnQg
b2YgdGhlCj4gc3lzdGVtIHRoYXQgc2F5cyBob3cgdGhlIGdlbmVyaWMgREFJIGFuZCBDT0RFQyBk
cml2ZXJzIGhhdmUgYmVlbiBob29rZWQKPiB1cC4KCmV4Y2VwdCB0aGUgQmxhY2tmaW4gbWFjaGlu
ZSBkcml2ZXJzIGFyZSB3cml0dGVuIGluIHN1Y2ggYSB3YXkgdGhhdAp0aGV5IGFyZW50IHNwZWNp
ZmljIHRvIGEgYm9hcmQuICB0aGV5J2xsIHdvcmsgb24gYW55IHN5c3RlbSB3aXRoIGEKU1BPUlQg
YW5kIGEgU1BJL0kyQyBidXMuCi1taWtlCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1w
cm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlzdGlu
Zm8vYWxzYS1kZXZlbAo=
