From: Mika Westerberg <mika.westerberg@iki.fi>
Subject: Re: [RFC 7/7] ASoC: ep93xx-pcm: Use dmaengine PCM
	helper functions
Date: Mon, 27 Feb 2012 21:01:59 +0200
Message-ID: <20120227190159.GC3868@mwesterb-mobl.ger.corp.intel.com>
References: <1329904151-5927-1-git-send-email-lars@metafoo.de>
	<1329904151-5927-8-git-send-email-lars@metafoo.de>
	<20120227081933.GA3868@mwesterb-mobl.ger.corp.intel.com>
	<4F4B442D.2050902@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lpp01m010-f51.google.com (mail-lpp01m010-f51.google.com
	[209.85.215.51]) by alsa0.perex.cz (Postfix) with ESMTP id 50344246B5
	for <alsa-devel@alsa-project.org>; Mon, 27 Feb 2012 20:02:48 +0100 (CET)
Received: by laap9 with SMTP id p9so2358476laa.38
	for <alsa-devel@alsa-project.org>; Mon, 27 Feb 2012 11:02:46 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4F4B442D.2050902@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Vinod Koul <vinod.koul@linux.intel.com>, Russell King <linux@arm.linux.org.uk>, Ryan Mallon <rmallon@gmail.com>, alsa-devel@alsa-project.org, Sascha Hauer <s.hauer@pengutronix.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Wolfram Sang <w.sang@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

T24gTW9uLCBGZWIgMjcsIDIwMTIgYXQgMDk6NTE6NTdBTSArMDEwMCwgTGFycy1QZXRlciBDbGF1
c2VuIHdyb3RlOgo+IE9uIDAyLzI3LzIwMTIgMDk6MTkgQU0sIE1pa2EgV2VzdGVyYmVyZyB3cm90
ZToKPiA+IE9uIFdlZCwgRmViIDIyLCAyMDEyIGF0IDEwOjQ5OjExQU0gKzAxMDAsIExhcnMtUGV0
ZXIgQ2xhdXNlbiB3cm90ZToKPiA+PiBTaWduZWQtb2ZmLWJ5OiBMYXJzLVBldGVyIENsYXVzZW4g
PGxhcnNAbWV0YWZvby5kZT4KPiA+IAo+ID4gRm9yIHNvbWUgcmVhc29uLCB0aGlzIGRvZXNuJ3Qg
d29yayBvbiBteSBlcDkzeHggYmFzZWQgU2ltLk9uZSBib2FyZC4gT24KPiA+IHBsYXliYWNrIHdp
dGggbXBnMTIzIHdoZW4gSSBwcmVzcyBzdG9wLCBpdCBjb250aW51ZXMgdG8gcGxheSB3aGF0ZXZl
ciB3YXMgb24KPiA+IHRoZSByaW5nLWJ1ZmZlciBmb3JldmVyLiBXaXRob3V0IHRoZSBwYXRjaGVz
IGl0IHdvcmtzIGZpbmUuCj4gPiAKPiA+IEknbGwgdHJ5IHRvIGZpbmQgc29tZSB0aW1lIHRvIGRl
YnVnIHRoaXMgZnVydGhlci4KPiAKPiBIbSwgdGhhdOKAmXMgaW50ZXJlc3RpbmcuIFRoZSBvcmln
aW5hbCBlcDkzeHggcGNtIGRyaXZlciB3YXMgYWxtb3N0IGlkZW50aWNhbAo+IHRvIHdoYXQgdGhl
IGNvbW1vbiBoZWxwZXIgZnVuY3Rpb25zIGRvLiBUaGUgb25seSBkaWZmZXJlbmNlIEkgY2FuIHNw
b3QgcmlnaHQKPiBub3cgaXMsIHRoYXQgaXQgZG9lc24ndCBjYWxsIGRtYV9pc3N1ZV9wZW5kaW5n
IGFmdGVyIHN1Ym1pdHRpbmcgdGhlCj4gZGVzY3JpcHRvci4gQ291bGQgeW91IHRyeSB0byBjb21t
ZW50IG91dCB0aGUgZG1hX2lzc3VlX3BlbmRpbmcgaW4KPiBzb2MtZG1hZW5naW5lLXBjbS5jIGFu
ZCB0ZXN0IHdoZXRoZXIgaXQgbWFrZXMgYSBkaWZmZXJlbmNlPwoKSSBkaWQgdHJ5IHRoYXQgYnV0
IHRoZXJlIHdhcyBubyBlZmZlY3QsIHVuZm9ydHVuYXRlbHkuCgpIb3dldmVyLCBJIG5vdGljZWQg
dGhhdCBwcnRkLT5wb3Mgd2FzIG5ldmVyIHNldCB0byB6ZXJvIGFzIGl0IHdhcyBpbiB0aGUKb3Jp
Z2luYWwgZXA5M3h4LXBjbSBkcml2ZXIuIFdpdGggZm9sbG93aW5nIGFkZGl0aW9uIHRvIHlvdXIg
cGF0Y2gsIHBsYXliYWNrCndvcmtzIGZpbmUuCgpkaWZmIC0tZ2l0IGEvc291bmQvc29jL3NvYy1k
bWFlbmdpbmUtcGNtLmMgYi9zb3VuZC9zb2Mvc29jLWRtYWVuZ2luZS1wY20uYwppbmRleCAwNTI2
Y2Y4Li40NDIwYjcwIDEwMDY0NAotLS0gYS9zb3VuZC9zb2Mvc29jLWRtYWVuZ2luZS1wY20uYwor
KysgYi9zb3VuZC9zb2Mvc29jLWRtYWVuZ2luZS1wY20uYwpAQCAtMTQyLDYgKzE0Miw3IEBAIHN0
YXRpYyBpbnQgZG1hZW5naW5lX3BjbV9wcmVwYXJlX2FuZF9zdWJtaXQoc3RydWN0IHNuZF9wY21f
c3Vic3RyZWFtICpzdWJzdHJlYW0pCiAKIAlkaXJlY3Rpb24gPSBzbmRfcGNtX3N1YnN0cmVhbV90
b19kbWFfZGlyZWN0aW9uKHN1YnN0cmVhbSk7CiAKKwlwcnRkLT5wb3MgPSAwOwogCWRlc2MgPSBj
aGFuLT5kZXZpY2UtPmRldmljZV9wcmVwX2RtYV9jeWNsaWMoY2hhbiwKIAkJc3Vic3RyZWFtLT5y
dW50aW1lLT5kbWFfYWRkciwKIAkJc25kX3BjbV9saWJfYnVmZmVyX2J5dGVzKHN1YnN0cmVhbSks
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkFsc2EtZGV2
ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1h
bi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
