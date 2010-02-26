From: jassi brar <jassisinghbrar@gmail.com>
Subject: Re: [RFC] ASoC: Allow mulitple usage of codec and cpu
	dai
Date: Fri, 26 Feb 2010 09:32:27 +0900
Message-ID: <1b68c6791002251632q79cffa03r4a51a013c6bad81b@mail.gmail.com>
References: <1267072011-11744-1-git-send-email-jassi.brar@samsung.com>
	<20100225100326.GC10141@rakim.wolfsonmicro.main>
	<1b68c6791002250300u4c6ff89am5009dc56187be6b1@mail.gmail.com>
	<20100225130619.GB11071@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 5ED171039CC
	for <alsa-devel@alsa-project.org>; Fri, 26 Feb 2010 01:32:29 +0100 (CET)
Received: by vws13 with SMTP id 13so1942910vws.38
	for <alsa-devel@alsa-project.org>; Thu, 25 Feb 2010 16:32:27 -0800 (PST)
In-Reply-To: <20100225130619.GB11071@rakim.wolfsonmicro.main>
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
Cc: alsa-devel@alsa-project.org, Jassi Brar <jassi.brar@samsung.com>, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

T24gVGh1LCBGZWIgMjUsIDIwMTAgYXQgMTA6MDYgUE0sIE1hcmsgQnJvd24KPGJyb29uaWVAb3Bl
bnNvdXJjZS53b2xmc29ubWljcm8uY29tPiB3cm90ZToKPiBPbiBUaHUsIEZlYiAyNSwgMjAxMCBh
dCAwODowMDoxM1BNICswOTAwLCBqYXNzaSBicmFyIHdyb3RlOgo+PiBPbiBUaHUsIEZlYiAyNSwg
MjAxMCBhdCA3OjAzIFBNLCBNYXJrIEJyb3duCj4KPj4gPiBJIHRob3VnaHQgSSdkIGJlZW4gZmFp
cmx5IGNsZWFyIGxhc3QgdGltZSB0aGF0IHRoZSBkcml2ZXJzIG5lZWQgdG8gaGF2ZQo+PiA+IGFu
IG9wdGlvbiB0byBkbyBzdHVmZiBvbiBzdGFydHVwKCkuIMKgQXMgSSBzYWlkIHRoZW4gYSBzZXBh
cmF0ZSBjYWxsYmFjawo+PiA+IHdoaWNoIGlzIGNhbGxlZCBvbmx5IG9uIHRoZSB0cmFuc2l0aW9u
cyBpbnRvIGFuZCBvdXQgb2YgYWN0aXZlIHdvdWxkIGJlCj4+ID4gZmluZS4KPgo+PiBUaGlzIGlz
IHNpbXBseSB0aGUgcGF0Y2gsIHRoYXQgeW91IGFza2VkIG1lIHRvIGRpZyBvdXQgZnJvbSBzYW1z
dW5nLWdpdAo+PiBhbmQgcG9zdCB0byB0aGUgbGlzdCwgYWRhcHRlZCB0byBmb3ItMi42LjM1Cj4K
PiBJIGFza2VkIHlvdSB0byBwdWxsIG91dCB0aGUgYml0cyB0aGF0IG1haW50YWluIGFjdGl2ZS4K
aG1tLi4uIGkgbWlzcmVhZCB1ciByZXBseS4gSnVzdCBzdWJtaXR0ZWQgcmVmcmVzaGVkIHBhdGNo
IGZvciBqdXN0IHRoYXQuCgo+PiBJIGNvdWxkIGRyb3Agc3RhcnR1cCxzaHV0ZG93bixtdXRlLW9u
L29mZiBhcyB3ZWxsLCBidXQgbm8gY29kZWMgZHJpdmVyCj4+IHdvdWxkIHdvcmsgd2l0aCB0aGF0
IGFzIHN1Y2guIElmIHRoYXQncyBvaywgaSdsbCByZXNlbmQgdGhlIHBhdGNoLgo+Cj4gSG9uZXN0
bHkgSSBkaWRuJ3QgcmVhZCB0aGUgcmVzdCBvZiB0aGUgcGF0Y2ggYWZ0ZXIgSSBzYXcgdGhlIGNo
YW5nZSB0bwo+IHJlbW92ZSB0aGUgc3RhcnR1cCgpIGNhbGxiYWNrLiDCoENsZWFybHkgZmlkZGxp
bmcgYXJvdW5kIHdpdGggdGhlIGFjdGl2ZQo+IGNvdW50IGlzbid0IGdvaW5nIHRvIG1ha2UgZXZl
cnkgcG9zc2libGUgc3lzdGVtIHdvcmssIGFuZCBpdCBtYXkgbm90IGJlCj4gYW55IHVzZSBhdCBh
bGwsIGJ1dCBzbyBsb25nIGFzIGl0IGRvZXNuJ3QgaW50ZXJmZXJlIHdpdGggb3RoZXIgdXNlcnMK
PiBpdCdzIG5vdCByZWFsbHkgYSBwcm9ibGVtLgpBbHNvLCBJIHRoaW5rIHdlIHNob3VsZCBsb29r
IGludG8gaWYgd2UgY2FuIGRvIHdpdGhvdXQgc25kX3NvY19jb2RlYy5hY3RpdmUKd2hlbiB3ZSBo
YXZlIHNuZF9zb2NfZGFpLnBsYXliYWNrL2NhcHR1cmUuYWN0aXZlIGNvdW50ZXJzLgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxp
bmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1w
cm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
