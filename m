From: Seungwhan Youn <claude.youn@gmail.com>
Subject: Re: [PATCH 2/3] ASoC: multi-component - Modify to use
	common S3C I2S features
Date: Thu, 15 Jul 2010 21:04:55 +0900
Message-ID: <AANLkTikeRGFReWqVIOpouU4_No-qPDdoPyUdEVoeFwUy@mail.gmail.com>
References: <lrg@slimlogic.co.uk> <broonie@opensource.wolfsonmicro.com>
	<jassisinghbrar@gmail.com> <claude.youn@gmail.com>
	<1279184328-31746-1-git-send-email-sw.youn@samsung.com>
	<1279184328-31746-2-git-send-email-sw.youn@samsung.com>
	<20100715093220.GE23529@rakim.wolfsonmicro.main>
	<AANLkTimKZGCYPp5ElEPthi8YY7fbSPMldRQVWDZe0HzX@mail.gmail.com>
	<20100715115401.GH23529@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id 1F386245A7
	for <alsa-devel@alsa-project.org>;
	Thu, 15 Jul 2010 14:04:59 +0200 (CEST)
Received: by wyf19 with SMTP id 19so655585wyf.38
	for <alsa-devel@alsa-project.org>; Thu, 15 Jul 2010 05:04:57 -0700 (PDT)
In-Reply-To: <20100715115401.GH23529@rakim.wolfsonmicro.main>
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
Cc: Jassi Brar <jassisinghbrar@gmail.com>, alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>, Seungwhan Youn <sw.youn@samsung.com>
List-Id: alsa-devel@alsa-project.org

T24gVGh1LCBKdWwgMTUsIDIwMTAgYXQgODo1NCBQTSwgTWFyayBCcm93bgo8YnJvb25pZUBvcGVu
c291cmNlLndvbGZzb25taWNyby5jb20+IHdyb3RlOgo+IE9uIFRodSwgSnVsIDE1LCAyMDEwIGF0
IDA4OjMzOjI4UE0gKzA5MDAsIFNldW5nd2hhbiBZb3VuIHdyb3RlOgo+Cj4+IERvZXMgeW91ciBj
b21tZW50IG1lYW5zIHRoYXQgJ2kycy0+YmFzZScgZ2V0IGJhc2UgYWRkcmVzcyBmcm9tIHRoZQo+
PiByZXNvdXJjZXMgZm9yIHRoZSBwbGF0Zm9ybSBkZXZpY2UgdXNpbmcgJ3BsYXRmb3JtX2dldF9y
ZXNvdXJjZXMoKSc/Cj4KPiBZZXMsIGV4YWN0bHkuCj4KPj4gSSdtIGRvaW5nIG9uIHByZXBhcmlu
ZyB0aGF0IGlzc3VlIGludG8gYW5vdGhlciBwYXRjaCBhbHJlYWR5IChiZWNhdXNlCj4+IEkgdGhp
bmsgdGhpcyBwYXRjaCBpcyBvbmx5IGZvciBMaWFtJ3MgbXVsdGktY29tcCwgbm90IGZvciB0aGF0
IGlzc3VlKS4KPgo+IE15IGNvbW1lbnQgd2FzIHRoYXQgc2luY2UgdGhpcyBwYXRjaCBpcyBnb2lu
ZyBzbyBmYXIgdG93YXJkcyBkb2luZyB0aGUKPiBtb3ZlIHRvIHB1bGxpbmcgdGhlIGRhdGEgZnJv
bSB0aGUgcGxhdGZvcm0gZGV2aWNlIGl0J2QgbWFrZSBzZW5zZSB0bwo+IGp1c3QgZG8gdGhhdCBh
cyBwYXJ0IG9mIHRoaXMgcGF0Y2ggcmF0aGVyIHRoYW4gaW50cm9kdWNlIGEgdGVtcG9yYXJ5Cj4g
d29ya2Fyb3VuZC4gwqBJdCdzIG5vdCByZWFsbHkgYW55IGV4dHJhIGVmZm9ydCBhbmQgaXQncyBt
dWNoIG5pY2VyLgo+CgpPa2F5LAoKSSdsbCBtYWtlIGEgbmV3IHBhdGNoLXNldCB0aGF0IGluY2x1
ZGVzIHRoZSBkYXRhIHB1bGxzIGZyb20gcGxhdGZvcm0gZGV2aWNlLgpUaGFuayB5b3UgZm9yIHlv
dXIgYWR2aWNlLiA6LSkKCkNsYXVkZS4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXBy
b2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5m
by9hbHNhLWRldmVsCg==
