From: Mike Frysinger <vapier@gentoo.org>
Subject: Re: [Device-drivers-devel] [PATCH] ASoC: ad74111: new
	codec driver
Date: Sun, 27 Mar 2011 00:10:08 -0400
Message-ID: <AANLkTi=QNDFP6uCG75vkQLL7_AN2Nm_b1Pqb+vyj4qU4@mail.gmail.com>
References: <1301128426-2817-1-git-send-email-vapier@gentoo.org>
	<20110326122108.GD28537@opensource.wolfsonmicro.com>
	<AANLkTinAs+3g1KHDyxBTDze8MnFZn3X7b5vuQSM+yLsN@mail.gmail.com>
	<20110326180942.GA13129@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 3E7E21037F9
	for <alsa-devel@alsa-project.org>;
	Sun, 27 Mar 2011 06:10:28 +0200 (CEST)
Received: by fxm5 with SMTP id 5so1445140fxm.38
	for <alsa-devel@alsa-project.org>; Sat, 26 Mar 2011 21:10:28 -0700 (PDT)
In-Reply-To: <20110326180942.GA13129@opensource.wolfsonmicro.com>
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

T24gU2F0LCBNYXIgMjYsIDIwMTEgYXQgMTQ6MDksIE1hcmsgQnJvd24gd3JvdGU6Cj4gT24gU2F0
LCBNYXIgMjYsIDIwMTEgYXQgMDE6NTI6NDhQTSAtMDQwMCwgTWlrZSBGcnlzaW5nZXIgd3JvdGU6
Cj4+IE9uIFNhdCwgTWFyIDI2LCAyMDExIGF0IDA4OjIxLCBNYXJrIEJyb3duIHdyb3RlOgo+PiA+
IEEgZmV3IG9mIHlvdXIgcGF0Y2hlcyBoYXZlIHRoaXMgc29ydCBvZiBhZGRpdGlvbmFsIGNoYW5n
ZSBpbiB0aGVtLgo+PiA+IFdoaWxlIHRoZSBjbGVhbnVwIGlzIGdvb2QgaXQgd291bGQgYmUgYmV0
dGVyIHRvIHNwbGl0IGl0IGludG8gYSBzZXBhcmF0ZQo+PiA+IHBhdGNoLiDCoFNlZWluZyB0aGUg
dW5yZWxhdGVkIGNoYW5nZSBzbG93cyBkb3duIHJldmlldyBhbmQgaXQnbGwgYWxzbwo+PiA+IGNy
ZWF0ZSBleHRyYSBtZXJnZSBpc3N1ZXMgd2hlbiBhcHBseWluZyBvciBjaGVycnkgcGlja2luZyB0
aGUgZHJpdmVyCj4+ID4gYmFjayB0byBvbGRlciBrZXJuZWxzLgo+Pgo+PiBpbiBnZW5lcmFsIGkg
YWdyZWUsIGJ1dCBmb3IgbW92aW5nIGxpdGVyYWxseSBvbmUgbGluZSBpIGRvbnQgZ2VuZXJhbGx5
Cj4+IHdvcnJ5IGFib3V0IGl0Cj4KPiBJdCdzIGEgb25lIGxpbmUgcGF0Y2ggdGhhdCB0b3RhbGx5
IGNoYW5nZXMgdGhlIHNoYXBlIG9mIHRoZSBkaWZmIGZvcgo+IHRoYXQgaHVuay4gwqBBcyBJIHNh
aWQgYWJvdmUgdGhpcyBzbG93cyBkb3duIHJldmlldywgaXQncyBqYXJyaW5nIGFzIG9uZQo+IGhh
cyB0byBzdG9wIGFuZCByZXZlcnNlIGVuZ2luZWVyIGZyb20gdGhlIGNoYW5nZSBpZiB3YXMgaW50
ZW50aW9uYWwgYW5kCj4gaWYgaXQgaXMgc2Vuc2libGUuIMKgSXQgY291bGQgYmUgc29tZSB1bnJl
bGF0ZWQgY2xlYW51cCwgaXQgY291bGQgYmUgKGFuZAo+IGZyZXF1ZW50bHkgaXMpIGNvbnRleHQg
dGhhdCBnb3QgaW5jbHVkZWQgaW4gdGhlIGRpZmYgYnkgbWlzdGFrZS4KCmkgc3RpbGwgZGlzYWdy
ZWUsIGJ1dCBjb25zaWRlcmluZyB5b3UgaGF2ZSB0aGUgbHV4dXJ5IG9mIG5vdCBhY2NlcHRpbmcK
b3VyIHBhdGNoZXMsIGkgZ3Vlc3MgaXQgZG9lc250IG1hdHRlciB0b28gbXVjaCBodWgKCj4+ID4g
QWdhaW4sIGRyb3AgdGhlIC1jb2RlYyB1bmxlc3MgdGhpcyBpcyBwYXJ0IG9mIGEgTUZELgo+Pgo+
PiB3aGVuIGkgbG9va2VkIGF0IHRoZSBoaXN0b3J5IG9mIHRoaW5ncywgaXQgc2VlbWVkIGxpa2Ug
aXQncyB0aGUgQVNvQwo+PiBtYWludGFpbmVycyBzdGlja2luZyAiLWNvZGVjIiBvbiBzdHVmZi4g
wqBzbyBzaG91bGQgaSBnbyB0aHJvdWdoCj4+IGV4aXN0aW5nIGRyaXZlcnMgYW5kIHJldmVydCB0
aGF0IGJhY2sgPwo+Cj4gWWVzLCB0aGV5IHdlcmUgaW5jbHVkZWQgYnkgbWlzdGFrZSBhcyBhIHJl
c3VsdCBvZiBhdXRvbWF0ZWQgY2hhbmdlcyBpbgo+IHRoZSBtdWx0aS1jb21wb25lbnQgbWVyZ2Vz
LgoKb2ssIHNob3VsZCBiZSBlYXN5IHRvIHNlbmQgb3V0IGZpeGVzIGZvciB0aG9zZQotbWlrZQpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVs
IG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4u
YWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
