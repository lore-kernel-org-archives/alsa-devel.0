From: Eric Miao <eric.y.miao@gmail.com>
Subject: Re: [RFC PATCH 3/5] pxa: clean up the legacy SSP API
Date: Wed, 29 Apr 2009 10:18:32 +0800
Message-ID: <f17812d70904281918p7a69fd03hd2fd51b1eb024b2@mail.gmail.com>
References: <f17812d70904222206n73b3f7d1se18a2615c7aad2bc@mail.gmail.com>
	<20090428222035.GG29277@n2100.arm.linux.org.uk>
	<1240959968.30410.1.camel@brutus>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from qw-out-1920.google.com (qw-out-1920.google.com [74.125.92.145])
	by alsa0.perex.cz (Postfix) with ESMTP id 283A724363
	for <alsa-devel@alsa-project.org>;
	Wed, 29 Apr 2009 04:18:34 +0200 (CEST)
Received: by qw-out-1920.google.com with SMTP id 4so715819qwk.56
	for <alsa-devel@alsa-project.org>; Tue, 28 Apr 2009 19:18:33 -0700 (PDT)
In-Reply-To: <1240959968.30410.1.camel@brutus>
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
Cc: alsa-devel@alsa-project.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, Mark Brown <broonie@sirena.org.uk>, Philipp Zabel <philipp.zabel@gmail.com>, Paul Shen <bshen9@marvell.com>, linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>
List-Id: alsa-devel@alsa-project.org

T24gV2VkLCBBcHIgMjksIDIwMDkgYXQgNzowNiBBTSwgRGFuaWVsIFJpYmVpcm8gPGRyd3lybUBn
bWFpbC5jb20+IHdyb3RlOgo+IEVtIFRlciwgMjAwOS0wNC0yOCDDoHMgMjM6MjAgKzAxMDAsIFJ1
c3NlbGwgS2luZyAtIEFSTSBMaW51eCBlc2NyZXZldToKPj4gT24gVGh1LCBBcHIgMjMsIDIwMDkg
YXQgMDE6MDY6MTJQTSArMDgwMCwgRXJpYyBNaWFvIHdyb3RlOgo+PiA+IEFjdHVhbGx5LCBkdWUg
dG8gdGhlIG51bWJlciBvZiBwb3NzaWJsZSBTU1AgY29uZmlndXJhdGlvbnMsIGl0J3MgcXVpdGUg
YQo+PiA+IGRpZmZpY3VsdCBqb2IgdG8gbWFpbnRhaW4gYW4gQVBJIHRoYXQgY2FuIGJlIHdlbGwg
cmUtdXNlZC4gVGhlIGd1aWRlbGluZQo+PiA+IGhlcmUgaXMgdG8ga2VlcCBvbmx5IGEgbGlzdCBv
ZiBTU1AgZGV2aWNlcyBhbmQgdGhlaXIgYmFzaWMgaW5mb3JtYXRpb24sCj4+ID4gYW5kIGl0J3Mg
dXAgdG8gdGhlIHVzZXIgZHJpdmVyIChsaWtlIFNQSSBvciBBdWRpbyBTU1ApIHRvIGNvbmZpZ3Vy
ZSB0aGUKPj4gPiBTU1AgaW4gYSBkZXNpcmVkIHdheS4KPj4KPj4gSG1tLCB0aGUgTFggYmF0dGVy
eSBkcml2ZXIgdXNlcyB0aGlzIEFQSSBmb3IgaXRzIHJ1ZGltZW50YXJ5IGJhdHRlcnkKPj4gY29t
bXVuaWNhdGlvbiBjaGFubmVsIHdpdGggdGhlIFBDT04uCj4+Cj4+IFdoYXQgYXJlIHlvdSBzdWdn
ZXN0aW5nIGFzIHRoZSByZXBsYWNlbWVudCBBUEk/IMKgRGlyZWN0IHJlZ2lzdGVyIGFjY2Vzcz8K
Pgo+IFRoZSBTUEkgc3Vic3lzdGVtPwo+CgpZZWFoLCBJIGxvb2tlZCBpbnRvIHRoZSBwYXRjaCBh
IGJpdC4gSXQgbG9va3MgbGlrZSB0aGUgU1NQIGNvbmZpZ3VyYXRpb24KZmFsbHMgaW50byB0aGUg
U1BJIHN1YnlzdGVtIHF1aXRlIHdlbGwuCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1w
cm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlzdGlu
Zm8vYWxzYS1kZXZlbAo=
