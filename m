From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH RFC 1/3] ASoC: uda1380: use callbacks
	instead of gpiolib
Date: Mon, 28 Jun 2010 15:15:40 +0100
Message-ID: <20100628141539.GC7403@rakim.wolfsonmicro.main>
References: <1277565285-11563-1-git-send-email-anarsoul@gmail.com>
	<201006281649.39572.anarsoul@gmail.com>
	<20100628135046.GB7403@rakim.wolfsonmicro.main>
	<201006281705.57779.anarsoul@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 87C75244C5
	for <alsa-devel@alsa-project.org>;
	Mon, 28 Jun 2010 16:15:41 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <201006281705.57779.anarsoul@gmail.com>
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

T24gTW9uLCBKdW4gMjgsIDIwMTAgYXQgMDU6MDU6NTFQTSArMDMwMCwgVmFzaWx5IEtob3J1emhp
Y2sgd3JvdGU6Cj4g0JIg0YHQvtC+0LHRidC10L3QuNC4INC+0YIgMjgg0LjRjtC90Y8gMjAxMCAx
Njo1MDo0NiDQsNCy0YLQvtGAIE1hcmsgQnJvd24g0L3QsNC/0LjRgdCw0Ls6Cj4gPiBTbyB0aGlz
IGlzIGFuIG9uLWJvYXJkIHBvd2VyIHNvdXJjZSB0aGF0J3MgYmVpbmcgY29udHJvbGxlZCBieSB0
aGUgR1BJTwo+ID4gcmF0aGVyIHRoYW4gYW4gZXh0ZXJuYWwgZGV2aWNlPwoKPiBUaGF0J3MganVz
dCBncGlvLWJhc2VkIHBvd2VyIGNvbnRyb2wgZm9yIHVkYTEzODAgKG5vdCBzdXJlIGFib3V0IHNj
aGVtYXRpY3MsIAo+IGl0J3Mgbm90IGF2YWlsYWJsZSkuIFNhbWUgYXBwcm9hY2ggaXMgdXNlZCBp
biBoMTk0MCBhbmQgbWFnaWNpYW4uCgpXaGF0IEknbSB0cnlpbmcgdG8gZmlndXJlIG91dCBpcyBp
ZiB0aGUgR1BJTyBpcyB3aXJlZCBkaXJlY3RseSB0byB0aGUKVURBMTM4MCBvciBpZiB0aGlzIGlz
IGNvbnRyb2xsaW5nIHNvbWV0aGluZyBleHRlcm5hbCB0byB0aGUgVURBMTM4MAp3aGljaCB0aGVz
ZSBkZXNpZ25zIGp1c3QgaGFwcGVuIHRvIGhhdmUgY29waWVkLiAgSWYgaXQncyBhIGRpcmVjdApj
b25uZWN0aW9uIHRvIHRoZSBVREExMzgwIHRoZW4gdXNpbmcgR1BJT3MgZGlyZWN0bHkgaXMgcGVy
ZmVjdGx5CnNlbnNpYmxlLgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5v
cmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2Et
ZGV2ZWwK
