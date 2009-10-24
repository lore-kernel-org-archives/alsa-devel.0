From: "=?utf-8?q?R=C3=A9mi?= Denis-Courmont" <rem@videolan.org>
Subject: Re: How to close ALSA device nodes? / ALSA's fds
Date: Sat, 24 Oct 2009 17:37:00 +0300
Message-ID: <200910241737.00517.rem@videolan.org>
References: <200910182038.34252.rem@videolan.org> <4AE1FB41.2020408@real.com>
Reply-To: remi@remlab.net
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yop.chewa.net (yop.chewa.net [91.121.105.214])
	by alsa0.perex.cz (Postfix) with ESMTP id 8614D245B8
	for <alsa-devel@alsa-project.org>;
	Sat, 24 Oct 2009 16:37:02 +0200 (CEST)
Received: from basile.remlab.net (cs27069076.pp.htv.fi [89.27.69.76])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested) (Authenticated sender: remi)
	by yop.chewa.net (Postfix) with ESMTPSA id 058C95FF
	for <alsa-devel@alsa-project.org>;
	Sat, 24 Oct 2009 16:37:02 +0200 (CEST)
In-Reply-To: <4AE1FB41.2020408@real.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

TGUgdmVuZHJlZGkgMjMgb2N0b2JyZSAyMDA5IDIxOjUxOjQ1IERhbmllbCBZZWssIHZvdXMgYXZl
eiDDqWNyaXQgOgo+IFtCcmFuY2ggdGhlIHRocmVhZCBmb3IgYSBzZXBhcmF0ZSBzdWdnZXN0aW9u
Li4uXQo+IAo+IFLDqW1pIERlbmlzLUNvdXJtb250IHdyb3RlOgo+ID4gTGUgZGltYW5jaGUgMTgg
b2N0b2JyZSAyMDA5IDIwOjEzOjE1IFJvYmVydCBIYW5jb2NrLCB2b3VzIGF2ZXogw6ljcml0IDoK
PiA+Pj4gRnJvbSB0aGUgZWFybGllciB0aHJlYWQsIEkgcmVja29uIHRoYXQgQUxTQSBkZXZlbG9w
ZXJzIGNvbnNpZGVyIHRoYXQKPiA+Pj4gdGhpcwo+ID4+PiBpcyBhbiB1cHBlci1sYXllciBpc3N1
ZS4gTWF5YmUgc28sIGJ1dCB0aGVuIGhvdyBpcyB0aGUgdXBwZXItbGF5ZXIKPiA+Pj4gc3VwcG9z
ZWQgdG8gZmluZCB3aGljaCBmaWxlIGRlc2NyaXB0b3JzIEFMU0EtbGliIGhhcyBvcGVuZWQgLSBp
ZiBhbnk/Cj4gPj4+IENvbnZlcnNlbHksIGlmIEFMU0EtIGxpYiB3b24ndCB0ZWxsIHdoaWxlIGZp
bGUgZGVzY3JpcHRvcnMgaXQgaXMgdXNpbmcsCj4gPj4+IHdoYXQgY291bGQgcG9zc2libHkgYmUg
dGhlIHVzZSBjYXNlIGZvciBub3QgY2xvc2luZyB0aG9zZSBvbiBleGVjPwo+ID4+Cj4gPj4gSSBh
Z3JlZSB0aGF0IGl0J3MgYSBkaWZmaWN1bHQgcHJvYmxlbSBmb3IgYW4gYXBwIHRoYXQgd2FudHMg
dG8gZm9yawo+ID4+IGFuZCBleGVjIGFub3RoZXIgcHJvY2Vzcy4uIEknZCB0aGluayByZWFsbHkg
c2hvdWxkIGJlIHNvbWUgd2F5IGZvciBhbgo+ID4+IGFwcCB0byBjb250cm9sIHRoZSBDTE9FWEVD
IGZsYWcgZm9yIHRoZSBmaWxlIGRlc2NyaXB0b3JzIHRoYXQgYWxzYS1saWIKPiA+PiBoYXMgb3Bl
bi4uCj4gPgo+ID4gPHNuaXA+Cj4gPgo+ID4gVGhhdCBzYWlkLCBJIHN0aWxsIGZhaWwgdG8gc2Vl
IGFueSBwb3RlbnRpYWwgdXNlIGNhc2UgdG8gbm90IHNldCB0aGUKPiA+IGZsYWcuCj4gPiBTaW5j
ZSBBTFNBLWxpYiB3b24ndCBsZXQgdGhlIGFwcGxpY2F0aW9uIGtub3cgYWJvdXQgdGhlIGZpbGUg
aGFuZGxlcywgYW55Cj4gPiBhcHBsaWNhdGlvbiBjYW5ub3QgYSB1c2UgdGhlbSBhY3Jvc3MgZXhl
YygpIGluIHRoZSBmaXJzdCBwbGFjZS4KPiAKPiBJcyBzbmRfcGNtX3BvbGxfZGVzY3JpcHRvcnMo
KSBhZGVxdWF0ZSBmb3IgdGhpcyBwYXJ0aWN1bGFyIGlzc3VlPwoKVGhhdCB0ZWxscyB0aGUgYXBw
bGljYXRpb24gd2hhdCBkZXNjcmlwdG9ycyB0byBwb2xsIGZvciBBTFNBIHRvIHVzZS4gVGhhdCBk
b2VzIApub3QgdGVsbCB3aGF0IHRoZSBkZXNjcmlwdG9ycyBkby4gU28gcmUtdXNpbmcgdGhvc2Ug
ZGVzY3JpcHRvcnMgYWNyb3NzIGV4ZWMoKSAKd291bGQgYmUgdmVyeSBmYXItZmV0Y2hlZC4KCi0t
IApSw6ltaSBEZW5pcy1Db3VybW9udApodHRwOi8vZ2l0LnJlbWxhYi5uZXQvY2dpLWJpbi9naXR3
ZWIuY2dpP3A9dmxjLWNvdXJtaXNjaC5naXQ7YT1zdW1tYXJ5Cl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2Et
ZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21h
aWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
