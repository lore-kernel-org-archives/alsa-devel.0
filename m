From: Mike Frysinger <vapier.adi@gmail.com>
Subject: Re: [Uclinux-dist-devel] [PATCH 2/2] ASoC: Blackfin
	AD1836/AD1938 machine drivers: require SPI master
Date: Tue, 6 Oct 2009 17:09:42 -0400
Message-ID: <8bd0f97a0910061409x254b5574wdb0125db0548678@mail.gmail.com>
References: <1254808311-3594-1-git-send-email-vapier@gentoo.org>
	<1254808311-3594-2-git-send-email-vapier@gentoo.org>
	<20091006093325.GA10118@rakim.wolfsonmicro.main>
	<8bd0f97a0910060241k1155d38cmafe623501106d598@mail.gmail.com>
	<20091006095018.GB27168@sirena.org.uk>
	<8bd0f97a0910060300m7fa80daas63afd272ba85fb16@mail.gmail.com>
	<20091006103952.GC10118@rakim.wolfsonmicro.main>
	<8bd0f97a0910060432o67e9d00bu84c0139701709e63@mail.gmail.com>
	<20091006115216.GA12993@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gx0-f223.google.com (mail-gx0-f223.google.com
	[209.85.217.223])
	by alsa0.perex.cz (Postfix) with ESMTP id ECFEF10383A
	for <alsa-devel@alsa-project.org>;
	Tue,  6 Oct 2009 23:10:02 +0200 (CEST)
Received: by gxk23 with SMTP id 23so243971gxk.2
	for <alsa-devel@alsa-project.org>; Tue, 06 Oct 2009 14:10:02 -0700 (PDT)
In-Reply-To: <20091006115216.GA12993@rakim.wolfsonmicro.main>
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

T24gVHVlLCBPY3QgNiwgMjAwOSBhdCAwNzo1MiwgTWFyayBCcm93biB3cm90ZToKPiBPbiBUdWUs
IE9jdCAwNiwgMjAwOSBhdCAwNzozMjozMEFNIC0wNDAwLCBNaWtlIEZyeXNpbmdlciB3cm90ZToK
Pj4gYmFjayB0byB0aGUgb3JpZ2luYWwgaXNzdWUuIMKgdGhlIEFEMTgzNi9BRDE5MzggaGF2ZSB0
aGVpciByZWdpc3RlcnMKPj4gcHJvZ3JhbWVkIHZpYSBTUEksIGJ1dCB0aGV5IGRvbnQgY2FyZSB3
aGF0IFNQSSBidXMgdGhleSdyZSBjb25uZWN0ZWQKPj4gdG8uIMKgdGhhdCBpcyBzcGVjaWZpZWQg
aW4gdGhlIGJvYXJkIHJlc291cmNlcy4gwqBiZWNhdXNlIG9mIHRoZSB3YXkgdGhlCj4+IEtjb25m
aWcgb3B0aW9ucyBhcmUgaGFuZGxlZCAobWFjaGluZSBkcml2ZXJzIHNlbGVjdCBjb2RlY3MpLCB0
aGUKPj4gU1BJX01BU1RFUiBkZXBlbmRlbmN5IGNhbm5vdCBiZSBhZGRlZCB0byB0aGUgY29kZWMg
S2NvbmZpZ3MgaW4KPj4gY29kZWNzL0tjb25maWcuIMKgc28gZXZlbiB0aG91Z2ggdGhlIFNQSSBk
ZXBlbmRlbmN5IGlzIG9ubHkgaW4gdGhlCj4+IGNvZGVjIGFuZCBub3QgdGhlIG1hY2hpbmUgZHJp
dmVyLCB0aGUgbWFjaGluZSBkcml2ZXIgbmVlZHMgdG8gZGVjbGFyZQo+PiB0aGUgU1BJX01BU1RF
UiBkZXBlbmRlbmN5IHRvIHByZXZlbnQgaW5jb3JyZWN0IGNvbmZpZyBzZWxlY3Rpb25zIGFuZAo+
PiBsaW5rIGZhaWx1cmVzLgo+Cj4gT3IsIGxpa2UgSSBzYXksIHRoZSBkcml2ZXJzIGZvciB0aGUg
Q09ERUMgc2hvdWxkIGJlIGNoYW5nZWQgdG8gYWxsb3cKPiBidWlsZCB3aXRoIG5vIGNvbnRyb2wg
YnVzLiDCoFRoaXMgaXMgYSBnZW5lcmFsIHByb2JsZW0gZm9yIGFsbCB0aGUgQVNvQwo+IGRyaXZl
cnMgYW5kIEknbSBzdGlsbCBub3Qgc3VyZSB3aGljaCB3YXkgdG8gZ28uIMKgRGVwZW5kaW5nIG9u
IGp1c3QgU1BJCj4gc3VwcG9ydCBmaXhlcyB0aGUgcmFuZG9tIGJ1aWxkIGNhc2UgYnV0IGRvZXNu
J3QgaGVscCBlbmQgdXNlcnMgZ2V0IHRoZQo+IGRyaXZlciB3b3JraW5nIHNvIGl0IGRvZXNuJ3Qg
c2VlbSBzbyB1c2VmdWwuIMKgSWYgd2UncmUgb25seSBnb2luZyB0byBiZQo+IGFibGUgdG8gZml4
IHRoZSByYW5kb20gYnVpbGQgY2FzZSB0aGVuIGl0IHNlZW1zIG1vcmUgdXNlZnVsIHRvIGRvIHNv
IGJ5Cj4gaGF2aW5nIHRoZSBDT0RFQyBkcml2ZXIgYWJsZSB0byBidWlsZCB3aXRob3V0IHRoZSBj
b250cm9sIGJ1cywgdGhhdCB3YXkKPiBpbmRpdmlkdWFsIG1hY2hpbmUgZHJpdmVycyBkb24ndCBu
ZWVkIHRvIHdvcnJ5IGFib3V0IGl0LgoKaSBkb250IHNlZSBob3cgYWJzdHJhY3RpbmcgYXdheSB0
aGUgYnVzIHN1Y2ggdGhhdCBjb2RlYyBkcml2ZXJzIGFyZQphbGxvd2VkIHRvIGJ1aWxkIHdpdGhv
dXQgcHJvcGVyIGJ1cyBzdXBwb3J0IGlzIHVzZWZ1bC4gIHRoZQpBRDE4MzYvQUQxOTM4IG9ubHkg
d29yayB3aXRoIHRoZSBTUEkgYnVzLCBzbyBpZiBzdXBwb3J0IGZvciB0aGF0IGlzCmRpc2FibGVk
LCBoYXZpbmcgdGhlIGRyaXZlciBjb21waWxlZCBhbmQgaW5zdGFsbGVkIGlzIHBvaW50bGVzcy4K
LW1pa2UKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQWxz
YS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHA6Ly9t
YWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
