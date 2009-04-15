From: Eric Miao <eric.y.miao@gmail.com>
Subject: Re: [PATCH] General fix for Palm27x aSoC driver
Date: Wed, 15 Apr 2009 10:23:49 +0800
Message-ID: <f17812d70904141923l7f1b5697gbb27e852dfe6dba0@mail.gmail.com>
References: <200904121858.42931.marek.vasut@gmail.com>
	<200904122051.19335.marek.vasut@gmail.com>
	<20090414195035.GA6902@sirena.org.uk>
	<200904142342.34914.marek.vasut@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f130.google.com (mail-qy0-f130.google.com
	[209.85.221.130])
	by alsa0.perex.cz (Postfix) with ESMTP id 4EB152433C
	for <alsa-devel@alsa-project.org>;
	Wed, 15 Apr 2009 04:23:50 +0200 (CEST)
Received: by qyk36 with SMTP id 36so1333217qyk.16
	for <alsa-devel@alsa-project.org>; Tue, 14 Apr 2009 19:23:49 -0700 (PDT)
In-Reply-To: <200904142342.34914.marek.vasut@gmail.com>
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
Cc: alsa-devel@alsa-project.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, Mark Brown <broonie@sirena.org.uk>, linux-arm-kernel@lists.arm.linux.org.uk
List-Id: alsa-devel@alsa-project.org

T24gV2VkLCBBcHIgMTUsIDIwMDkgYXQgNTo0MiBBTSwgTWFyZWsgVmFzdXQgPG1hcmVrLnZhc3V0
QGdtYWlsLmNvbT4gd3JvdGU6Cj4gT24gVHVlc2RheSAxNCBvZiBBcHJpbCAyMDA5IDIxOjUwOjM2
IE1hcmsgQnJvd24gd3JvdGU6Cj4+IE9uIFN1biwgQXByIDEyLCAyMDA5IGF0IDA4OjUxOjE5UE0g
KzAyMDAsIE1hcmVrIFZhc3V0IHdyb3RlOgo+PiA+ICtzdGF0aWMgc3RydWN0IHB4YTJ4eF9hYzk3
X3BsYXRmb3JtX2RhdGEgcGFsbWxkX2FjOTdfcGRhdGEgPSB7Cj4+ID4gKyDCoCAucmVzZXRfZ3Bp
byDCoCDCoCA9IDk1LAo+PiA+ICt9Owo+Pgo+PiBUaGUgdHlwZSBvZiB0aGlzIHdpbGwgbmVlZCBj
aGFuZ2luZyB0byByZWZsZWN0IHRoZSBwYXRjaCB0aGF0IGdvdCBtZXJnZWQKPj4gZm9yIHRoaXMg
YnV0IG90aGVyIHRoYW4gdGhhdCBtaW5vciBwb2ludCB0aGlzIGFwcHJvYWNoIGlzIGZpbmUuCj4K
PiBPSywgc2hhbGwgSSBjaGFuZ2UgaXQgYW5kIHJlc2VuZCAocHMuIHRvIHdoYXQgaWYgeW91IGRv
bnQgbWluZCB0ZWxsaW5nIG1lPykgPwo+IEFsc28sIGRvIHlvdSB3YW50IHRvIHB1c2ggaXQgdGhy
b3VnaCBhbHNvIHRyZWUgb3IgQVJNIHRyZWUgPyBJJ20gZm9yIHRoZQo+IHNlY29uZCBvcHRpb24g
YXMgaXQncyBtb3JlIG9mIGEgYnVnZml4IHN1aXRhYmxlIGZvciB0aGF0IHRyZWUuCj4KClNvcnJ5
LCBsYXRlIG9uIHRoaXMuIFRoZSBjaGFuZ2VzIHRvIHRoZSBwbGF0Zm9ybSBwYXJ0IGxvb2sgT0sg
dG8gbWUsCmFuZCBzb21lIG1pbm9yIHRoaW5ncyB5b3UgbWF5IGhhdmUgYW5vdGhlciBsb29rOgoK
Pgo+IC1zdGF0aWMgaW50IF9faW5pdCBwYWxtMjd4X2Fzb2NfaW5pdCh2b2lkKQo+ICtzdGF0aWMg
aW50IHBhbG0yN3hfYXNvY19wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQoKX19k
ZXZpbml0Cgo+ICB7Cj4gIAlpbnQgcmV0Owo+Cj4gQEAgLTIwOCw2ICsyMDgsMTAgQEAgc3RhdGlj
IGludCBfX2luaXQgcGFsbTI3eF9hc29jX2luaXQodm9pZCkKPiAgCQltYWNoaW5lX2lzX3BhbG1s
ZCgpKSkKPiAgCQlyZXR1cm4gLUVOT0RFVjsKPgo+ICsJaWYgKHBkZXYtPmRldi5wbGF0Zm9ybV9k
YXRhKQo+ICsJCXBhbG0yN3hfZXBfZ3BpbyA9ICgoc3RydWN0IHBhbG0yN3hfYXNvY19pbmZvICop
Cj4gKwkJCShwZGV2LT5kZXYucGxhdGZvcm1fZGF0YSkpLT5qYWNrX2dwaW87Cj4gKwoKVGhpcyBp
cyBub3Qgc28gcmVhZGFibGUsIEknZCBwcmVmZXIgdG8gaW50cm9kdWNlIGEgdmFyaWFibGUgZm9y
IHRoZQonc3RydWN0IHBhbG0yN3hfYXNvY19pbmZvIConIHBvaW50ZXIuCgo+ICAJcmV0ID0gZ3Bp
b19yZXF1ZXN0KHBhbG0yN3hfZXBfZ3BpbywgIkhlYWRwaG9uZSBKYWNrIik7Cj4gIAlpZiAocmV0
KQo+ICAJCXJldHVybiByZXQ7Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0
Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxz
YS1kZXZlbAo=
