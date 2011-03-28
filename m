From: Mike Frysinger <vapier@gentoo.org>
Subject: Re: [Device-drivers-devel] [PATCH] ASoC: ad74111: new
	codec driver
Date: Mon, 28 Mar 2011 03:22:11 -0400
Message-ID: <AANLkTincrRKARvVwuJe52VA26AZHeDsN9sWWnrBNXeyf@mail.gmail.com>
References: <1301128426-2817-1-git-send-email-vapier@gentoo.org>
	<20110326122108.GD28537@opensource.wolfsonmicro.com>
	<AANLkTinAs+3g1KHDyxBTDze8MnFZn3X7b5vuQSM+yLsN@mail.gmail.com>
	<20110326180942.GA13129@opensource.wolfsonmicro.com>
	<AANLkTi=QNDFP6uCG75vkQLL7_AN2Nm_b1Pqb+vyj4qU4@mail.gmail.com>
	<20110327134343.GA6292@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 4D55E103815
	for <alsa-devel@alsa-project.org>;
	Mon, 28 Mar 2011 09:22:33 +0200 (CEST)
Received: by fxm5 with SMTP id 5so1914534fxm.38
	for <alsa-devel@alsa-project.org>; Mon, 28 Mar 2011 00:22:31 -0700 (PDT)
In-Reply-To: <20110327134343.GA6292@opensource.wolfsonmicro.com>
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
Cc: Scott Jiang <scott.jiang@analog.com>, alsa-devel@alsa-project.org, Cliff Cai <cliff.cai@analog.com>, device-drivers-devel@blackfin.uclinux.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

T24gU3VuLCBNYXIgMjcsIDIwMTEgYXQgMDk6NDMsIE1hcmsgQnJvd24gd3JvdGU6Cj4gwqAtIEZv
bGxvdyB1cCBwcm9tcHRseSBvbiByZXZpZXdzIC0gSSdtIHJhcmVseSBzZWVpbmcgdXBkYXRlcyB0
byBwYXRjaGVzCj4gwqAgdGhhdCBpbnZvbHZlIGFueSBkb21haW4gc3BlY2lmaWMgY2hhbmdlcywg
YW5kIHdoZXJlIHRoZXJlIGlzIGZvbGxvd3VwCj4gwqAgaXQncyBvZnRlbiBhdCB0aGUgbmV4dCBy
ZWxlYXNlLiDCoFRoaXMgaW50ZXJhY3RzIGJhZGx5IHdpdGggdGhlCj4gwqAgc3VibWlzc2lvbiBh
Z2FpbnN0IG9sZCBjb2RlIGlzc3VlcyBhcyB0aGF0IG1lYW5zIHlvdSdyZSBsaWtlbHkgdG8KPiDC
oCByZXF1aXJlIHNvbWUgZmFpcmx5IHN0cmFpZ2h0Zm9yd2FyZCBBUEkgdXBkYXRlcyBidXQgd2Fp
dGluZyB0bwo+IMKgIHJlc3VibWl0IG1lYW5zIHRoYXQgeW91J2xsIG9mdGVuIGVuZCB1cCByZXF1
aXJpbmcgZnVydGhlciB1cGRhdGVzCj4gwqAgbmV4dCB0aW1lIGFyb3VuZC4KPgo+IEZvciBleGFt
cGxlLCB0aGUgU1NNMjYwNCBkcml2ZXIgeW91J3JlIHN1Ym1pdHRpbmcgbm93IHdhcyBvcmlnaW5h
bGx5Cj4gc2VudCBsYXN0IEF1Z3VzdCBhbmQgeW91IHNlbnQgcGF0Y2hlcyBmb3IgQURBVjgwMS8z
LCBBREFVMTM2MSwgQURBVTEzODEKPiBhbmQgQURBVTE3NjEgYXQgdGhlIGVuZCBvZiBsYXN0IHll
YXIgd2hpY2ggbW9zdGx5IGp1c3QgbmVlZGVkIGZhaXJseQo+IHN0cmFpZ2h0Zm9yd2FyZCB1cGRh
dGVzIGZvciBvbGQga2VybmVsIGlzc3VlcyBidXQgd2hpY2ggaGF2ZW4ndCBiZWVuCj4gcmVzdWJt
aXR0ZWQgc2luY2UuIMKgTm9uZSBvZiB0aGVzZSBkZXZpY2VzIGxvb2sgbGlrZSB0aGV5IHNob3Vs
ZCBiZSBoYXJkCj4gdG8gZ2V0IHN1cHBvcnQgaW50ZWdyYXRlZCBpbnRvIG1haW5saW5lIGJ1dCB0
aGUgYWJvdmUgaXNzdWVzIGFyZSBtYWtpbmcKPiB0aGF0IGhhcmRlciB3b3JrIHRoYW4gaXQgbmVl
ZHMgdG8gYmUuCgphdG0sIGl0J3MgYmFzaWNhbGx5IGxhY2sgb2YgZGV2ZWxvcGVyIHRpbWUuICB0
ZWNobmljYWxseSwgQURJIGNvZGVjcwphcmUgbm8gbG9uZ2VyIG15IGpvYiAodGhleSB3ZXJlIG1h
cmdpbmFsbHkgc28gaW4gdGhlIHBhc3QpLiAgaSBkbyBhbnkKdXBkYXRlcyB0aGF0IGkgY2FuIHNs
YXAgdG9nZXRoZXIgaW4gbXkgb2ZmIHRpbWUsIGJ1dCBhcyBzb29uIGFzIHlvdQpzdGFydCB0YWxr
aW5nIGFib3V0IHJlYWwgaXNzdWVzIChzdWNoIGFzIGV4cG9zaW5nIHJlZ2lzdGVycyBvcgpwcm9n
cmFtbWluZyB0aGUgcGFydCBkaWZmZXJlbnRseSksIGl0J3MgYmV5b25kIG15IGV4cGVyaWVuY2Uu
ICBtb3N0IG9mCnRoZSBUTEEncyB5b3UgdGhyb3cgYXJvdW5kIGkgaGF2ZSB0byBsb29rIHVwIDsp
LgoKc28gYmFzaWNhbGx5IHllcywgaSBhZ3JlZSBpdCdzIGN1cnJlbnRseSBzY3Jld2VkIHVwLgot
bWlrZQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNh
LWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21h
aWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
