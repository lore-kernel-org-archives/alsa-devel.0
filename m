From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v9 1/4] drm/i2c: tda998x: Add DT support for audio
Date: Wed, 14 Jan 2015 14:23:27 +0000
Message-ID: <20150114142327.GX12302@n2100.arm.linux.org.uk>
References: <1421151718.4519.24.camel@pengutronix.de>
 <20150113122715.GP12302@n2100.arm.linux.org.uk>
 <20150113165411.5469930d@armhf>
 <20150113160313.GR12302@n2100.arm.linux.org.uk>
 <20150113200252.3dbfab14@armhf>
 <20150113192648.GU12302@n2100.arm.linux.org.uk>
 <54B574CD.9020905@ti.com>
 <20150113195415.GV12302@n2100.arm.linux.org.uk>
 <1421232418.3155.31.camel@pengutronix.de>
 <20150114125056.GU4160@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <20150114125056.GU4160@sirena.org.uk>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Mark Brown <broonie@kernel.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Andrew Jackson <Andrew.Jackson@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jyri Sarha <jsarha@ti.com>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
List-Id: alsa-devel@alsa-project.org

T24gV2VkLCBKYW4gMTQsIDIwMTUgYXQgMTI6NTA6NTZQTSArMDAwMCwgTWFyayBCcm93biB3cm90
ZToKPiBUcnlpbmcgdG8gaG9vayB1cCBhIGNvbnRyb2xsZXIgdGhhdCBkb2Vzbid0IG5hdGl2ZWx5
IHN1cHBvcnQgdGhpcyBmb3JtYXQKPiB0byBhIGRldmljZSB0aGF0IHVzZXMgaXQgaXMgZGVmaW5p
dGVseSB0cmlja3ksIGFzIHdlbGwgYXMgZGVzY3JpYmluZyB0aGUKPiBwaHlzaWNhbCBob29rdXAg
d2UgYWxzbyBuZWVkIHRvIHdvcnJ5IGFib3V0IGhvdyB0aGluZ3MgbG9vayB0byB1c2Vyc3BhY2UK
PiAtIGl0J3MgaWRlYWxseSBnb2luZyB0byB3YW50IGEgc2luZ2xlIG11bHRpLWNoYW5uZWwgYXVk
aW8gc3RyZWFtLgoKVHJ5aW5nIHRvIGdldCB0aGUgc3luY2hyb25pc2F0aW9uIGNvcnJlY3QgZm9y
IHByb3BlciBzdXJyb3VuZCBhdWRpbwpyZXByb2R1Y3Rpb24gd291bGQgYWxzbyBiZSBpbnRlcmVz
dGluZy4gIEkgc3VzcGVjdCB0aGF0IHVzZXJzcGFjZQp3b3VsZCBoYXZlIHRvIGJlIHRhdWdodCBz
cGVjaWZpY2FsbHkgYWJvdXQgYSBoYXJkd2FyZSBzZXR1cCBsaWtlIHRoaXMgLQppbiBvcmRlciB0
byBlbnN1cmUgdGhhdCB0aGUgc2xhdmUgSTJTIGJsb2NrcyBhcmUgcmVhZHkgYmVmb3JlIHRoZSBt
YXN0ZXIKc3RhcnRzIG91dHB1dHRpbmcgdGhlIEkyUyBjbG9ja3MuCgpJJ20gL25vdC8gdGhhdCB0
aHJpbGxlZCB3aXRoIHRoZSB3aG9sZSBpZGVhOyBJJ2QgbXVjaCByYXRoZXIgc3VnZ2VzdAp0aGF0
IHdlIHNob3VsZCBjb25jZW50cmF0ZSBvbiBzYW5lIHNldHVwcywgYnV0IHdlIGtub3cgdGhhdCBo
YXJkd2FyZQplbmdpbmVlcnMgZG8gY3JlYXRlIHNvbWUgc2lsbHkgc2V0dXBzICJiZWNhdXNlIHRo
ZXkgY2FuIi4KCj4gSSB0aGluayBmcm9tIGEgYmluZGluZyBwb2ludCBvZiB2aWV3IHdlIG5lZWQg
YSB3YXkgdG8gc2F5ICJ0aGlzIGVuZHBvaW50Cj4gb24gdGhlIGxpbmsgaXMgY29uc3RydWN0ZWQg
ZnJvbSB0aGVzZSBEQUlzIG9uIHRoZSBkZXZpY2Ugc2lkZSIgYW5kIHNheQo+IGlmIHRoaXMgaXMg
VERNIG9yIG11bHRpLWRhdGEsIGFuZCB3aGF0J3MgZHJpdmluZyB0aGUgY2xvY2tzLgoKVGhpcyBz
ZWVtcyB0byBmYXZvdXIgdGhlICJvbmUgRFQgcG9ydCBmb3IgSTJTIiBtb2RlbCAtIHBvc3NpYmx5
IHdpdGgKbXVsdGlwbGUgZW5kcG9pbnRzIGZvciBlYWNoIEkyUyBjaGFubmVsIChpZiBkZXNpcmVk
KS4gIFRoZXJlJ3Mgbm90aGluZwppbiB0aGF0IG1vZGVsIHdoaWNoIHdvdWxkIHByZXZlbnQgaGF2
aW5nIG9uZSBlbmQgcG9pbnQgZm9yIGFsbCBmb3VyCmNoYW5uZWxzLiAgVG8gcHV0IHRoYXQgYW5v
dGhlciB3YXksIHdlIGNhbiByZW1haW4gZmxleGlibGUuCgpNYXliZSB3ZSBzaG91bGQgZG9jdW1l
bnQgdGhlIGJpbmRpbmcgaW5kaWNhdGluZyB0aGF0IGZvciBJMlMsIG9uZSBwb3J0CmFuZCBvbmUg
ZW5kcG9pbnQgY29ubmVjdGVkIHRvIG9uZSBJMlMgYmxvY2sgd2hpY2ggc3VwcGxpZXMgYWxsIEky
UwpjaGFubmVscyBpcyB0aGUgcHJlZmVycmVkIG1vZGVsLCBidXQgb3RoZXJzIGFyZSBwZXJtaXR0
ZWQgYnV0IG5vdApuZWNlc3NhcmlseSBndWFyYW50ZWVkIHRvIHdvcmsgY29ycmVjdGx5LgoKLS0g
CkZUVEMgYnJvYWRiYW5kIGZvciAwLjhtaWxlIGxpbmU6IGN1cnJlbnRseSBhdCAxMC41TWJwcyBk
b3duIDQwMGticHMgdXAKYWNjb3JkaW5nIHRvIHNwZWVkdGVzdC5uZXQuCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmRyaS1kZXZlbCBtYWlsaW5nIGxpc3QK
ZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwOi8vbGlzdHMuZnJlZWRlc2t0b3Au
b3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==
