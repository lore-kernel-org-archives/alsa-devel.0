From: Mike Frysinger <vapier@gentoo.org>
Subject: Re: [Device-drivers-devel] [uclinux-dist-devel] [PATCH
 1/4] Blackfin: Use 8bit spi transfers for the ad1836
Date: Fri, 6 May 2011 09:12:34 -0400
Message-ID: <BANLkTimDtzLgG10bV080kXYr8Ujh775pkA@mail.gmail.com>
References: <1304617966-4410-1-git-send-email-lars@metafoo.de>
	<BANLkTi=u+_LBkv2=DAwhZ53FEoRaYcHErA@mail.gmail.com>
	<4DC3E970.2030207@metafoo.de>
	<20110506124858.GA11701@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gw0-f51.google.com (mail-gw0-f51.google.com [74.125.83.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 28F0A243B3
	for <alsa-devel@alsa-project.org>;
	Fri,  6 May 2011 15:12:56 +0200 (CEST)
Received: by gwj17 with SMTP id 17so1308906gwj.38
	for <alsa-devel@alsa-project.org>; Fri, 06 May 2011 06:12:54 -0700 (PDT)
In-Reply-To: <20110506124858.GA11701@sirena.org.uk>
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
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, device-drivers-devel@blackfin.uclinux.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

T24gRnJpLCBNYXkgNiwgMjAxMSBhdCAwODo0OCwgTWFyayBCcm93biB3cm90ZToKPiBPbiBGcmks
IE1heSAwNiwgMjAxMSBhdCAwMjoyODozMlBNICswMjAwLCBMYXJzLVBldGVyIENsYXVzZW4gd3Jv
dGU6Cj4+IFRoZSBzbmRfc29jX2NhY2hlIGluZnJhc3RydWN0dXJlIGhhcyBzZXZlcmFsIGhlbHBl
ciBmdW5jdGlvbnMgZm9yIHdyaXRpbmcgc3BpCj4+IG9uIGEgc3BpIGJ1cy4gVGhlIG9uZSB1c2Vk
IGJ5IHRoZSBhZDE4MzYgd2FzIHNwZWNpZmljYWxseSBhZGRlZCBmb3IgdGhlIGFkMTgzNgo+PiBh
bmQgaXMgc3BlY2lhbCBjb21wYXJlZCB0byB0aGUgb3RoZXIgc3BpIGhlbHBlciBmdW5jdGlvbnMg
aW4gdGhlIHJlZ2FyZCB0aGF0IGl0Cj4+IHN3YXBzIHRoZSB1cHBlciBhbmQgdGhlIGxvd2VyIGJ5
dGUgb2YgdGhlIHRvIGJlIHRyYW5zZmVycmVkIGRhdGEuCj4+IFdoaWxlIHRoaXMgd29ya3Mgb24g
YmxhY2tmaW4gd2hpY2ggaXMgbGl0dGUtZW5kaWFuIHRoaXMgc2NoZW1lIHdpbGwgb2J2aW91c2x5
Cj4+IGZhaWwgb24gYmlnLWVuZGlhbiBtYWNoaW5lcy4gQWxzbyB0aGlzIG1pZ2h0IG5vdCB3b3Jr
IGZvciBvdGhlciBjb2RlY3Mgd2hpY2gKPj4gd2FudCB0byByZXVzZSB0aGUgc2FtZSBoZWxwZXIg
ZnVuY3Rpb24uCj4KPiBTbyBjbGVhcmx5IHRoZSBjYWNoZSBzdHVmZiBvdWdodCB0byBiZSB1c2lu
ZyBjcHVfdG9fYmUxNiBmb3IgdGhpcyBzdHVmZi4KPiBBdCBwcmVzZW50IHdlJ3ZlIGJlZW4gbGF6
eSBhYm91dCB0aGlzIGFzIG9uIG1vc3QgQ1BVcyB0aGUgc3dhcCBib2lscwo+IGRvd24gdG8gYSBu
b29wLiDCoElmIHdlIGRvIGVuZCB1cCBuZWVkaW5nIGJvdGggc3dhcHMgdGhlbiB3ZSBqdXN0IGFk
ZAo+IHRoaXMgYXMgYW5vdGhlciBwYXJhbWV0ZXIgaW4gdGhlIGNhY2hlIGluZnJhc3RydWN0dXJl
LgoKaW5kZWVkIC4uLiB0aGlzIGlzIHRoZSBkaXJlY3Rpb24gaSdkIHJhdGhlciBoZWFkIHJhdGhl
ciB0aGFuIGRyb3AgYWxsCnRoZSBleGlzdGluZyBzdHVmZiBkb3duIHRvIDhiaXQgb25seS4KLW1p
a2UKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQWxzYS1k
ZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHA6Ly9tYWls
bWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
