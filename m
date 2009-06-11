From: Eric Miao <eric.y.miao@gmail.com>
Subject: Re: [PATCH 1/4] ASoC: pxa-ssp: enhance I2S and add
	Left_J support
Date: Thu, 11 Jun 2009 21:34:03 +0800
Message-ID: <f17812d70906110634i623eb236ib277e164678a7a34@mail.gmail.com>
References: <f17812d70906030533m49eb023bid19a80231921f59b@mail.gmail.com>
	<74d0deb30906080512q29b9915fvec9b068bf4b2e126@mail.gmail.com>
	<20090608124045.GE7858@sirena.org.uk>
	<1244477000.30582.72.camel@brutus>
	<20090608165328.GB14026@rakim.wolfsonmicro.main>
	<1244481992.17327.22.camel@brutus>
	<20090608180656.GH7858@sirena.org.uk>
	<1244494349.17327.174.camel@brutus>
	<f17812d70906090239p5dee129egda49918b3862c0ca@mail.gmail.com>
	<1244672649.25905.70.camel@brutus>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f171.google.com (mail-qy0-f171.google.com
	[209.85.221.171])
	by alsa0.perex.cz (Postfix) with ESMTP id 9BDB4103812
	for <alsa-devel@alsa-project.org>;
	Thu, 11 Jun 2009 15:34:04 +0200 (CEST)
Received: by qyk1 with SMTP id 1so2053062qyk.16
	for <alsa-devel@alsa-project.org>; Thu, 11 Jun 2009 06:34:04 -0700 (PDT)
In-Reply-To: <1244672649.25905.70.camel@brutus>
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

MjAwOS82LzExIERhbmllbCBSaWJlaXJvIDxkcnd5cm1AZ21haWwuY29tPjoKPiBIaSBFcmljLAo+
Cj4gRW0gVGVyLCAyMDA5LTA2LTA5IMOgcyAxNzozOSArMDgwMCwgRXJpYyBNaWFvIGVzY3JldmV1
Ogo+PiBmcmFtZV93aWR0aCA9IHNhbXBsZV93aWR0aCAqIGNoYW5uZWwgKCA9IExSQ0xLIGZvciBJ
MlMgKQo+Pgo+PiBpcyBubyBsb25nZXIgKGFuZCBldmVyKSBjb3JyZWN0Lgo+Pgo+PiBFLmcuIHRo
ZSBmcmFtZSB3aWR0aCBjb3VsZCBiZSA2NGZzLCBtZWFuaW5nIGEgd2hvbGUgZnJhbWUgaXMKPj4g
Y29uc2lzdGluZwo+PiBvZiA2NCBiaXRjbGtzIC0gdGhhdCdzIHNheWluZywgc2FtcGxlIHdpZHRo
IGZyb20gMSAtIDY0IGFyZSBwb3NzaWJsZSwKPj4gRm9yIHR5cGljYWwgMTYtYml0IHNhbXBsZSB3
aWR0aCBJMlMgZm9ybWF0LCB0aGUgZW52ZWxvcGUgZm9yIGVhY2gKPj4gc2FtcGxlCj4+IGlzIDMy
IGJpdGNsa3MsIGFuZCBvZmZzZXRpbmcgYnkgMSBiaXRjbGsgc3RhcnRzIHRoZSAxNi1iaXQgc2Ft
cGxlLgo+Cj4gSSdtIHdvcmtpbmcgb24gc3VwcG9ydGluZyBJMlMgcmlnaHQgbm93LCBhbmQgSSBm
b3VuZCBzb21lIGlzc3VlcyB3aXRoCj4gdGhpcyBlbnZlbG9waW5nIHRoaW5nLgo+Cj4gRmlyc3Qs
IGl0IGRvZXNuJ3Qgd29yayBvbiBweGEyeHguIERNWVNUT1Agb24gcHhhMnh4IGlzIG9ubHkgMC0z
LgoKV2VsbCwgdGhlcmUgaXMgYSBkZWRpY2F0ZWQgSTJTIGNvbnRyb2xsZXIgb24gcHhhezI1eCwy
N3h9LCBzbyBJJ2QgZXhwZWN0CmlmIGl0J3MgcmVxdWlyZWQgZm9yIERNWVNUT1AgPiAzLCB0aGUg
SFcgZW5naW5lZXIgd291bGQganVzdCByZXNvcnQgdG8KdGhlIEkyUyBjb250cm9sbGVyLgoKPgo+
IFNlY29uZCwgaXMgZW52ZWxvcGluZyBuZWVkZWQgYXQgYWxsPyBUaGUgcGF0Y2ggeW91IHNlbnQg
c3VwcG9ydHMgMzJiaXRzCj4gZnJhbWVzIGZvciAyKjE2Yml0cyBzYW1wbGVzIG9yIDY0Yml0cyBm
cmFtZXMgZm9yIDIqMzJiaXRzIHNhbXBsZXMgdXNpbmcKPiBGU1JULgo+CgpUaGVyZSBhcmUgc29t
ZSBjb2RlY3MgcmVxdWlyaW5nIHRoaXMuCgo+IFdlIGFscmVhZHkgdXNlIEZTUlQgZm9yIERTUF9B
LCBhbmQgaWYgdGhpcyB3b3JrcyBvbiBsaXR0bGV0b24gSTJTIHdlCj4gc2hvdWxkIGp1c3Qgc3Rp
Y2sgd2l0aCBGU1JUIChhbmQgZnJhbWVfd2lkdGggPSBzYW1wbGVfd2lkdGggKiBjaGFubmVscykK
PiB0byBrZWVwIHRoZSBjb2RlIHNpbXBsZS4KPgoKSSBob3BlIHNvLCBidXQgdGhlIGFzc3VtcHRp
b24gb2YgZnJhbWVfd2lkdGggPT0gc2FtcGxlX3dpZHRoICogMiBzaG91bGQKaG9sZCB0cnVlIGZp
cnN0LgoKPj4gQW5kIHRoZSBURE0gbW9kZSBpcyBhY3R1YWxseSBzcGVjaWFsIGZvciBQWEEtU1NQ
IHRvIGVtdWxhdGUgdGhlIEkyUwo+PiBwcm90b2NvbCwgaXQncyBubyB3YXkgZ2VuZXJpYyBURE0g
aW4gYSBjb21tb24gc2Vuc2UuIFNvIHRhbGtpbmcgYWJvdXQKPj4gc2V0X3RkbV9zbG90cygpLCBJ
J2QgcmVhbGx5IGxpa2UgdG8gaGlkZSBpbnRvIHRoZSBmb3JtYXQgc2V0dGluZyBjb2RlCj4+IG9m
IEkyUy9MZWZ0X0ogdG8gYXZvaWQgZnVydGhlciBjb25mdXNpb24uCj4KPiBURE0gaXMgbmVlZGVk
IGZvciBmcmFtZXMgbGFyZ2VyIHRoYW4gMzIgYml0cyBvbiBhbnkgZGFpIGZvcm1hdC4gSXRzIG5v
dAo+IHNvbWV0aGluZyBzcGVjaWZpYyB0byBJMlMuCj4KCldlbGwsIGVtdWxhdGluZyBJMlMgd2l0
aCBTU1AgaGFzIHRvIHVzZSBURE0gbW9kZSBzbyB0aGF0IGEgc2luZ2xlCmZyYW1lIGNhbiBpbmNs
dWRlIHR3byBzYW1wbGVzLgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5v
cmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2Et
ZGV2ZWwK
