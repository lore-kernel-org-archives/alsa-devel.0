From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH RFC 3/3] uda1380: make driver more
	powersave-friendly
Date: Sun, 27 Jun 2010 21:55:29 +0100
Message-ID: <047B7693-6E49-4FB6-99C4-9C9DE53E0486@opensource.wolfsonmicro.com>
References: <1277565285-11563-1-git-send-email-anarsoul@gmail.com>
	<201006270007.34271.anarsoul@gmail.com>
	<20100627101053.GA26394@opensource.wolfsonmicro.com>
	<201006271343.36646.anarsoul@gmail.com>
	(sfid-20100627_114347_646520_449CB691)
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A0879244C2
	for <alsa-devel@alsa-project.org>;
	Sun, 27 Jun 2010 22:55:31 +0200 (CEST)
In-Reply-To: <201006271343.36646.anarsoul@gmail.com>
	(sfid-20100627_114347_646520_449CB691)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Vasily Khoruzhick <anarsoul@gmail.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>, Philipp Zabel <philipp.zabel@gmail.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

T24gMjcgSnVuIDIwMTAsIGF0IDExOjQzLCBWYXNpbHkgS2hvcnV6aGljayB3cm90ZToKCj4g0JIg
0YHQvtC+0LHRidC10L3QuNC4INC+0YIgMjcg0LjRjtC90Y8gMjAxMCAxMzoxMDo1NCDQsNCy0YLQ
vtGAIE1hcmsgQnJvd24g0L3QsNC/0LjRgdCw0Ls6Cj4+IE9sZCBkcml2ZXJzIGZvciBmYWlybHkg
b2JzY3VyZSBjaGlwcyBhcmVuJ3QgYWx3YXlzIGEgZ29vZCBndWlkZSB0byBiZXN0Cj4+IHByYWN0
aWNlcyBmb3IgdGhpbmdzLgoKPiBPaywgd2hhdCBkcml2ZXIgc2hvdWxkIEkgdXNlIGFzIHJlZmVy
ZW5jZT8KCk9mZiB0aGUgdG9wIG9mIG15IGhlYWQgV004OTA0IGRvZXMgcmVndWxhdG9yIGJhc2Vk
IHBvd2VyIG1hbmFnZW1lbnQuCgo+Pj4gSXQncyBzb2Z0cmVzZXQgYW5kIGl0J3MgcGVyZm9ybWVk
IGJ5IHdyaXRpbmcgc29tZSB2YWx1ZSB0byBzb21lIHJlZy4gaTJjCj4+PiB4ZmVycyBpcyBub3Qg
cG9zc2libGUgd2hlbiBjb2RlYyBpcyBub3QgZW5hYmxlZCAoaXQgaXMgbm90IGF0IHRoaXMKPj4+
IHBvaW50KQo+PiAKPj4gSXQgbmVlZHMgdG8gaGFwcGVuIGF0IHNvbWUgcG9pbnQuCj4gCj4gU29m
dHJlc2V0IGlzIHBlcmZvcm1lZCByaWdodCBhZnRlciBjb2RlYyBwb3dlciBvbiwgaXQgY2FuJ3Qg
YmUgcGVyZm9ybWVkIAo+IGVhcmxpZXIuCgpBZnRlciBwb3dlciBvbiBpdCdzIG5vdCBuZWVkZWQs
IHRoZSBkZXZpY2Ugc2hvdWxkIGJlIGluIHRoZSBkZWZhdWx0IHN0YXRlCmFscmVhZHkuIEl0J3Mg
b25seSByZXF1aXJlZCBvbiBzdGFydHVwIHdoZW4gdGhlcmUncyBubyBwb3dlciBjb250cm9sIGZv
ciB0aGUKZGV2aWNlLgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcK
aHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2
ZWwK
