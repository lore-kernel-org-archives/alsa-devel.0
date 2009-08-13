From: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH 2/4] Allow passing platform_data for
 pxa2xx-ac97
Date: Fri, 14 Aug 2009 03:42:01 +0400
Message-ID: <20090813234201.GA15769@oksana.dev.rtsoft.ru>
References: <200907211633.14388.marek.vasut@gmail.com>
	<200907300255.01675.marek.vasut@gmail.com>
	<20090813204033.GA7519@sirena.org.uk>
	<200908140134.22716.marek.vasut@gmail.com>
Reply-To: avorontsov@ru.mvista.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by alsa0.perex.cz (Postfix) with ESMTP id E9A041038E1
	for <alsa-devel@alsa-project.org>;
	Fri, 14 Aug 2009 01:42:03 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200908140134.22716.marek.vasut@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Marek Vasut <marek.vasut@gmail.com>
Cc: alsa-devel@alsa-project.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, Takashi Iwai <tiwai@suse.de>, dwmw2@infradead.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, cbou@mail.ru, Eric Miao <eric.y.miao@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, linux-arm-kernel@lists.arm.linux.org.uk
List-Id: alsa-devel@alsa-project.org

T24gRnJpLCBBdWcgMTQsIDIwMDkgYXQgMDE6MzQ6MjJBTSArMDIwMCwgTWFyZWsgVmFzdXQgd3Jv
dGU6Cj4gRG5lIMSMdCAxMy4gc3JwbmEgMjAwOSAyMjo0MDozNCBNYXJrIEJyb3duIG5hcHNhbChh
KToKPiA+IE9uIFRodSwgSnVsIDMwLCAyMDA5IGF0IDAyOjU1OjAxQU0gKzAyMDAsIE1hcmVrIFZh
c3V0IHdyb3RlOgo+ID4gPiBGcm9tIDIwN2Q1NDI0NDc2OGU5NGNlMDE0NGNiYTU1YWNmNGFlMDY1
ZTZjZTAgTW9uIFNlcCAxNyAwMDowMDowMCAyMDAxCj4gPiA+IEZyb206IE1hcmVrIFZhc3V0IDxt
YXJlay52YXN1dEBnbWFpbC5jb20+Cj4gPiA+IERhdGU6IFR1ZSwgMjEgSnVsIDIwMDkgMTY6MjI6
MjkgKzAyMDAKPiA+ID4gU3ViamVjdDogW1BBVENIXSBBbGxvdyBwYXNzaW5nIHBsYXRmb3JtX2Rh
dGEgZm9yIHB4YTJ4eC1hYzk3Cj4gPiA+Cj4gPiA+IFRoaXMgcGF0Y2ggYWRkcyBzdXBwb3J0IGZv
ciBwYXNzaW5nIHBsYXRmb3JtIGRhdGEgdG8gYWM5NyBidXMgZGV2aWNlcwo+ID4gPiBmcm9tIFBY
QTJ4eC1BQzk3IGRyaXZlci4uCj4gPgo+ID4gSSd2ZSBhcHBsaWVkIHRoaXMgb25lIHRvbyBzaW5j
ZSBpdCdzIEFMU0Egb25seSBhbmQgaXQnbGwgZWFzZSBtZXJnZQo+ID4gaXNzdWVzIG5leHQgbWVy
Z2Ugd2luZG93IC0gd2UgY2FuIHJldmlzaXQgaWYgYW55IG9mIHRoZSBvdGhlciBwYXRjaGVzCj4g
PiBnZXQgYXBwbGllZCBiZWZvcmUuCj4gCj4gSGksCj4gCj4gdGhhbmtzLCBJIHRoaW5rIHlvdSBj
YW4gYXBwbHkgdGhlIDMvNCBhbmQgNC80IGFzIHdlbGwuIEJ1dCB5b3Ugc2hvdWxkIHByb2JhYmx5
IAo+IHRhbGsgdG8gQW50b24gYWJvdXQgdGhlIDMvNCBpZiBoZSB3YW50cyB0byBtZXJnZSBpdCB0
aHJvdWdoIHlvdXIgdHJlZSBvciBoaXMgCj4gb3Igd2hhdGV2ZXIuIEhlIGFja2VkIGl0IHByZXZp
b3VzbHksIGl0J3MgaW4gdGhhdCBodWdlIHRocmVhZCBmcm9tIGp1bHkuIFRoZSAKPiBtYWlsJ3Mg
c3ViamVjdCBpcyAiW1BBVENIIDIvNF0gQWxsb3cgcGFzc2luZyBwbGF0Zm9ybV9kYXRhIGZvciBw
eGEyeHgtYWM5NyIgCj4gYW5kIGl0J3MgZnJvbSAyMi8wNy8yMDA5LgoKSSdtIGZpbmUgd2l0aCBp
dCBnb2luZyB0aHJvdWdoIE1hcmsncyB0cmVlLiBUaGFua3MhCgotLSAKQW50b24gVm9yb250c292
CmVtYWlsOiBjYm91YXRtYWlscnVAZ21haWwuY29tCmlyYzovL2lyYy5mcmVlbm9kZS5uZXQvYmQy
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkFsc2EtZGV2
ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1h
bi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
