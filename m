From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: [PATCH 3/3] ASoC: omap-mcbsp: Add period size
	protection mode
Date: Tue, 20 Mar 2012 19:27:02 +0200
Message-ID: <CANOLnONkvk63ABDN_mX2g79EKMgfk0H71CRLaUmXSrwa55+C7A@mail.gmail.com>
References: <1332242021-7494-1-git-send-email-peter.ujfalusi@ti.com>
	<1332242021-7494-4-git-send-email-peter.ujfalusi@ti.com>
	<20120320160154.GI3445@opensource.wolfsonmicro.com>
	<CANOLnOPjqbeEbSDUHokkGRUa7KwJ-+hAczWSmQ3LEccCh9-c7w@mail.gmail.com>
	<20120320170444.GA6938@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iy0-f179.google.com (mail-iy0-f179.google.com
	[209.85.210.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 2D2A22415F
	for <alsa-devel@alsa-project.org>; Tue, 20 Mar 2012 18:27:05 +0100 (CET)
Received: by iakh37 with SMTP id h37so296733iak.38
	for <alsa-devel@alsa-project.org>; Tue, 20 Mar 2012 10:27:02 -0700 (PDT)
In-Reply-To: <20120320170444.GA6938@opensource.wolfsonmicro.com>
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
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org

T24gVHVlLCBNYXIgMjAsIDIwMTIgYXQgNzowNCBQTSwgTWFyayBCcm93bgo8YnJvb25pZUBvcGVu
c291cmNlLndvbGZzb25taWNyby5jb20+IHdyb3RlOgo+IE9uIFR1ZSwgTWFyIDIwLCAyMDEyIGF0
IDA2OjE1OjM0UE0gKzAyMDAsIEdyYXp2eWRhcyBJZ25vdGFzIHdyb3RlOgo+PiBPbiBUdWUsIE1h
ciAyMCwgMjAxMiBhdCA2OjAxIFBNLCBNYXJrIEJyb3duCj4KPj4gPiB0aG91Z2ggdGhpcyBzaG91
bGQgcHJvYmFibHkgaGF2ZSB0aGUgbm90ZSBhYm91dCB3b3JraW5nIGFyb3VuZCBicm9rZW4KPj4g
PiBhcHBsaWNhdGlvbnMgZnJvbSB0aGUgY292ZXIgbGV0dGVyIGluIHRoZSBjaGFuZ2Vsb2cgYXMg
d2l0aCB0aGUKPj4gPiBjaGFuZ2Vsb2cgYWxvbmUgaXQncyByZWFsbHkgbm90IGFwcGFyZW50IHdo
eSB3ZSdyZSBkb2luZyB0aGlzIGhlcmUgYXMgYQo+PiA+IGRyaXZlciBzcGVjaWZpYyB0aGluZy4K
Pgo+PiBJIHdvdWxkbid0IHJlYWxseSBjYWxsIHRoZW0gYnJva2VuLCBpdCdzIGVub3VnaCB0byBz
ZXQgcGVyaW9kIHNpemUgdG8KPj4gNTEyIHdpdGggc21hbGxlciBzdGFydF90aHJlc2hvbGQgKHNv
bWV0aGluZyBsaWtlIDUwbXMpIHRvIGhhdmUKPj4gcHJvYmxlbXMsIHRob3NlIHBhcmFtZXRlcnMg
YXJlIHBlcmZlY3RseSB2YWxpZCBmb3IgYSBwcm9ncmFtIHRyeWluZyB0bwo+PiBhY2hpZXZlIGxv
dyBsYXRlbmN5Lgo+Cj4gSWYgdGhleSBjYW4ndCBjb3BlIHdpdGggdGhlIHBhcmFtZXRlcnMgdGhl
eSd2ZSBzZXQgSSdkIGNhbGwgdGhlbSBicm9rZW4sCj4gdGhleSBzaG91bGQndmUgYXNrZWQgZm9y
IG1vcmUgc2Vuc2libGUgcGFyYW1ldGVycy4KCkhvdyBpcyB0aGUgcHJvZ3JhbSBzdXBwb3NlZCB0
byBrbm93IHRob3NlIHBhcmFtZXRlcnMgYXJlIGludmFsaWQgZm9yCnRoaXMgaGFyZHdhcmU/IEl0
IGNvdWxkIG1heWJlIGRldGVjdCB1bmRlcmZsb3dzIGFuZCBpbmNyZWFzZSBwZXJpb2QKdW50aWwg
dW5kZXJmbG93cyBzdG9wLCBidXQgdGhlcmUgbWlnaHQgYmUgb3RoZXIgcmVhc29ucyBmb3IgdW5k
ZXJmbG93cwpsaWtlIGhpZ2ggc3lzdGVtIGxvYWQuIE9yIGRvIHlvdSBtZWFuIHNldHRpbmcgdXAg
c29tZSBwZXJpb2Qgc2l6ZSBhbmQKZG9pbmcgd3JpdGVzIG9mIHRoYXQgcGVyaW9kIHNpemUgaXMg
bm90IHZhbGlkIHRoaW5nIHRvIGRvPyBDdXJyZW50bHksCm5vIG1hdHRlciBob3cgZmFzdCB0aGUg
d3JpdGVzIGNvbWUsIHRoZXJlIGlzIGFuIHVuZGVyZmxvdyBhZnRlciBmaXJzdAp3cml0ZSBpbiB0
aGVzZSBjb25kaXRpb25zLgoKCi0tIApHcmHFvnZ5ZGFzCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2
ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxt
YW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
