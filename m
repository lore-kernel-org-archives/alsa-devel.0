From: Marek Vasut <marek.vasut@gmail.com>
Subject: Re: [PATCH] General fix for Palm27x aSoC driver
Date: Wed, 15 Apr 2009 07:00:14 +0200
Message-ID: <200904150700.14772.marek.vasut@gmail.com>
References: <200904121858.42931.marek.vasut@gmail.com>
	<200904142342.34914.marek.vasut@gmail.com>
	<f17812d70904141923l7f1b5697gbb27e852dfe6dba0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fk-out-0910.google.com (fk-out-0910.google.com [209.85.128.184])
	by alsa0.perex.cz (Postfix) with ESMTP id 1158B243F7
	for <alsa-devel@alsa-project.org>;
	Wed, 15 Apr 2009 07:00:08 +0200 (CEST)
Received: by fk-out-0910.google.com with SMTP id f40so1197223fka.0
	for <alsa-devel@alsa-project.org>; Tue, 14 Apr 2009 22:00:07 -0700 (PDT)
In-Reply-To: <f17812d70904141923l7f1b5697gbb27e852dfe6dba0@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Eric Miao <eric.y.miao@gmail.com>
Cc: alsa-devel@alsa-project.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, Mark Brown <broonie@sirena.org.uk>, linux-arm-kernel@lists.arm.linux.org.uk
List-Id: alsa-devel@alsa-project.org

T24gV2VkbmVzZGF5IDE1IG9mIEFwcmlsIDIwMDkgMDQ6MjM6NDkgRXJpYyBNaWFvIHdyb3RlOgo+
IE9uIFdlZCwgQXByIDE1LCAyMDA5IGF0IDU6NDIgQU0sIE1hcmVrIFZhc3V0IDxtYXJlay52YXN1
dEBnbWFpbC5jb20+IHdyb3RlOgo+ID4gT24gVHVlc2RheSAxNCBvZiBBcHJpbCAyMDA5IDIxOjUw
OjM2IE1hcmsgQnJvd24gd3JvdGU6Cj4gPj4gT24gU3VuLCBBcHIgMTIsIDIwMDkgYXQgMDg6NTE6
MTlQTSArMDIwMCwgTWFyZWsgVmFzdXQgd3JvdGU6Cj4gPj4gPiArc3RhdGljIHN0cnVjdCBweGEy
eHhfYWM5N19wbGF0Zm9ybV9kYXRhIHBhbG1sZF9hYzk3X3BkYXRhID0gewo+ID4+ID4gKyDCoCAu
cmVzZXRfZ3BpbyDCoCDCoCA9IDk1LAo+ID4+ID4gK307Cj4gPj4KPiA+PiBUaGUgdHlwZSBvZiB0
aGlzIHdpbGwgbmVlZCBjaGFuZ2luZyB0byByZWZsZWN0IHRoZSBwYXRjaCB0aGF0IGdvdCBtZXJn
ZWQKPiA+PiBmb3IgdGhpcyBidXQgb3RoZXIgdGhhbiB0aGF0IG1pbm9yIHBvaW50IHRoaXMgYXBw
cm9hY2ggaXMgZmluZS4KPiA+Cj4gPiBPSywgc2hhbGwgSSBjaGFuZ2UgaXQgYW5kIHJlc2VuZCAo
cHMuIHRvIHdoYXQgaWYgeW91IGRvbnQgbWluZCB0ZWxsaW5nCj4gPiBtZT8pID8gQWxzbywgZG8g
eW91IHdhbnQgdG8gcHVzaCBpdCB0aHJvdWdoIGFsc28gdHJlZSBvciBBUk0gdHJlZSA/IEknbQo+
ID4gZm9yIHRoZSBzZWNvbmQgb3B0aW9uIGFzIGl0J3MgbW9yZSBvZiBhIGJ1Z2ZpeCBzdWl0YWJs
ZSBmb3IgdGhhdCB0cmVlLgo+Cj4gU29ycnksIGxhdGUgb24gdGhpcy4gVGhlIGNoYW5nZXMgdG8g
dGhlIHBsYXRmb3JtIHBhcnQgbG9vayBPSyB0byBtZSwKPgo+IGFuZCBzb21lIG1pbm9yIHRoaW5n
cyB5b3UgbWF5IGhhdmUgYW5vdGhlciBsb29rOgo+ID4gLXN0YXRpYyBpbnQgX19pbml0IHBhbG0y
N3hfYXNvY19pbml0KHZvaWQpCj4gPiArc3RhdGljIGludCBwYWxtMjd4X2Fzb2NfcHJvYmUoc3Ry
dWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikKPgo+IF9fZGV2aW5pdAoKVGhhbmtzLCB0cnVlLCB3
aWxsIHJldmlzZSBpdCBsYXRlciB0b2RheSBhbmQgcmVzZW5kIC4uLgo+Cj4gPiAgewo+ID4gIAlp
bnQgcmV0Owo+ID4KPiA+IEBAIC0yMDgsNiArMjA4LDEwIEBAIHN0YXRpYyBpbnQgX19pbml0IHBh
bG0yN3hfYXNvY19pbml0KHZvaWQpCj4gPiAgCQltYWNoaW5lX2lzX3BhbG1sZCgpKSkKPiA+ICAJ
CXJldHVybiAtRU5PREVWOwo+ID4KPiA+ICsJaWYgKHBkZXYtPmRldi5wbGF0Zm9ybV9kYXRhKQo+
ID4gKwkJcGFsbTI3eF9lcF9ncGlvID0gKChzdHJ1Y3QgcGFsbTI3eF9hc29jX2luZm8gKikKPiA+
ICsJCQkocGRldi0+ZGV2LnBsYXRmb3JtX2RhdGEpKS0+amFja19ncGlvOwo+ID4gKwo+Cj4gVGhp
cyBpcyBub3Qgc28gcmVhZGFibGUsIEknZCBwcmVmZXIgdG8gaW50cm9kdWNlIGEgdmFyaWFibGUg
Zm9yIHRoZQo+ICdzdHJ1Y3QgcGFsbTI3eF9hc29jX2luZm8gKicgcG9pbnRlci4KCkNvbWUgb24s
IHdlIGFyZSBub3QgZG9pbmcgdGhlIGtlcm5lbCBvbmx5IGZvciB1Yi4uLnUgc28gdGhpcyBzaG91
bGQgYmUgT0sgZm9yIApldmVyeW9uZSB3aG8gY2FuIGNvZGUgaW4gQy4gOi0pCj4KPiA+ICAJcmV0
ID0gZ3Bpb19yZXF1ZXN0KHBhbG0yN3hfZXBfZ3BpbywgIkhlYWRwaG9uZSBKYWNrIik7Cj4gPiAg
CWlmIChyZXQpCj4gPiAgCQlyZXR1cm4gcmV0OwoKCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxA
YWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4v
bGlzdGluZm8vYWxzYS1kZXZlbAo=
