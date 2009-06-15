From: Eric Miao <eric.y.miao@gmail.com>
Subject: Re: [RFC] I2S and LEFT_J (was: ASoC: pxa-ssp: enhance
	I2S and add Left_J support)
Date: Mon, 15 Jun 2009 16:45:14 +0800
Message-ID: <f17812d70906150145p763002det5e2699442673d532@mail.gmail.com>
References: <f17812d70906030533m49eb023bid19a80231921f59b@mail.gmail.com>
	<1244477000.30582.72.camel@brutus>
	<20090608165328.GB14026@rakim.wolfsonmicro.main>
	<1244481992.17327.22.camel@brutus>
	<20090608180656.GH7858@sirena.org.uk>
	<1244494349.17327.174.camel@brutus>
	<f17812d70906090239p5dee129egda49918b3862c0ca@mail.gmail.com>
	<1244672649.25905.70.camel@brutus>
	<f17812d70906110634i623eb236ib277e164678a7a34@mail.gmail.com>
	<1244730992.21356.50.camel@brutus>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from qw-out-1920.google.com (qw-out-1920.google.com [74.125.92.146])
	by alsa0.perex.cz (Postfix) with ESMTP id D9B6E1037F9
	for <alsa-devel@alsa-project.org>;
	Mon, 15 Jun 2009 10:45:15 +0200 (CEST)
Received: by qw-out-1920.google.com with SMTP id 9so1761029qwj.56
	for <alsa-devel@alsa-project.org>; Mon, 15 Jun 2009 01:45:14 -0700 (PDT)
In-Reply-To: <1244730992.21356.50.camel@brutus>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Ribeiro <drwyrm@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>, pHilipp Zabel <philipp.zabel@gmail.com>
List-Id: alsa-devel@alsa-project.org

MjAwOS82LzExIERhbmllbCBSaWJlaXJvIDxkcnd5cm1AZ21haWwuY29tPjoKPiBFbSBRdWksIDIw
MDktMDYtMTEgw6BzIDIxOjM0ICswODAwLCBFcmljIE1pYW8gZXNjcmV2ZXU6Cj4+ID4gV2UgYWxy
ZWFkeSB1c2UgRlNSVCBmb3IgRFNQX0EsIGFuZCBpZiB0aGlzIHdvcmtzIG9uIGxpdHRsZXRvbiBJ
MlMgd2UKPj4gPiBzaG91bGQganVzdCBzdGljayB3aXRoIEZTUlQgKGFuZCBmcmFtZV93aWR0aCA9
IHNhbXBsZV93aWR0aCAqIGNoYW5uZWxzKQo+PiA+IHRvIGtlZXAgdGhlIGNvZGUgc2ltcGxlLgo+
PiA+Cj4+Cj4+IEkgaG9wZSBzbywgYnV0IHRoZSBhc3N1bXB0aW9uIG9mIGZyYW1lX3dpZHRoID09
IHNhbXBsZV93aWR0aCAqIDIgc2hvdWxkCj4+IGhvbGQgdHJ1ZSBmaXJzdC4KPgo+IE9rLCBoZXJl
IGlzIHdoYXQgSSB0aGluayB0aGF0IHNob3VsZCB3b3JrIGZvciBJMlMgYWZ0ZXIgbXkgMiBwYXRj
aGVzIHRvCj4gc29ydCB0aGUgVERNIHRoaW5nLgo+Cj4gMiBQYXRjaGVzIGFyZSBpbmxpbmUsIGZp
cnN0IHZlcnNpb24gYXNzdW1lcyB0aGF0IGZyYW1lX3dpZHRoID0KPiBzYW1wbGVfd2lkdGggKiAy
KGNoYW5uZWxzKSwgYW5kIGp1c3QgaW5jcmVhc2VzIHRoZSBTRlJNIGR1cmF0aW9uIHRvCj4gZW11
bGF0ZSB0aGUgTFJDTEsuCj4KPiBTZWNvbmQgdmVyc2lvbiB1c2VzIEVyaWMgYW5kIFBhdWwgY29k
ZSBvbmx5IGZvciBweGEzeHguIEluIHRoaXMgdmVyc2lvbiwKPiBmcmFtZV93aWR0aCA9IHNhbXBs
ZV93aWR0aCAqIDIoY2hhbm5lbHMpICogMihlbnZlbG9wZSkuCj4KPiBUaGlzIHdhcyBvbmx5IGNv
bXBpbGUgdGVzdGVkLCBJIGRvbnQgaGF2ZSBQWEEzWFggaGFyZHdhcmUgdG8gdGVzdCB0aGlzLgo+
IEl0IGFwcGxpZXMgYWZ0ZXIgdGhlIDMgcGF0Y2hlcyBJIHNlbnQgZWFybGllci4KPgoKV2VsbCwg
SSdtIGNvbXBsZXRlbHkgbG9zdCBpbiB0aGlzIHRocmVhZC4gQ2FuIGFueW9uZSBnaXZlIGEgc3Vt
bWFyeQpvbiB0aGlzIGlzc3VlPyBBbmQgaXQgbG9va3MgbGlrZSBzZXRfdGRtX3Nsb3QoKSBpcyB1
c2VkIHRvIGdlbmVyYWxpemUKdGhlIGlzc3VlIG9mIGVudmVsb3AgKG9yIHRoZSBhY3R1YWwgZnJh
bWUvc2FtcGxlIHdpZHRoKSwgYW5kIHRoZSBEQUkKZm9ybWF0IHNldHRpbmcgY29kZSBoZXJlIHdp
bGwgYmUgZ2VuZXJhbGl6ZWQ/PwoKRGFuaWVsLAoKQ291bGQgeW91IHBsZWFzZSBzZW5kIG91dCBh
bGwgdGhlIGZvdXIgcGF0Y2hlcz8gU29ycnkgbGF0ZSBvbiB0aGlzLApidXN5IHdpdGggdGhlIG1l
cmdpbmcgc3R1ZmYuCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpo
dHRwOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZl
bAo=
