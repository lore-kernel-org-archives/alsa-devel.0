From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: [PATCH 3/3] ASoC: omap-mcbsp: Add period size
	protection mode
Date: Tue, 20 Mar 2012 18:15:34 +0200
Message-ID: <CANOLnOPjqbeEbSDUHokkGRUa7KwJ-+hAczWSmQ3LEccCh9-c7w@mail.gmail.com>
References: <1332242021-7494-1-git-send-email-peter.ujfalusi@ti.com>
	<1332242021-7494-4-git-send-email-peter.ujfalusi@ti.com>
	<20120320160154.GI3445@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iy0-f179.google.com (mail-iy0-f179.google.com
	[209.85.210.179])
	by alsa0.perex.cz (Postfix) with ESMTP id C011F10430E
	for <alsa-devel@alsa-project.org>; Tue, 20 Mar 2012 17:15:36 +0100 (CET)
Received: by iakh37 with SMTP id h37so212187iak.38
	for <alsa-devel@alsa-project.org>; Tue, 20 Mar 2012 09:15:34 -0700 (PDT)
In-Reply-To: <20120320160154.GI3445@opensource.wolfsonmicro.com>
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

T24gVHVlLCBNYXIgMjAsIDIwMTIgYXQgNjowMSBQTSwgTWFyayBCcm93bgo8YnJvb25pZUBvcGVu
c291cmNlLndvbGZzb25taWNyby5jb20+IHdyb3RlOgo+IE9uIFR1ZSwgTWFyIDIwLCAyMDEyIGF0
IDAxOjEzOjQxUE0gKzAyMDAsIFBldGVyIFVqZmFsdXNpIHdyb3RlOgo+PiBDZXJ0YWluIGFwcGxp
Y2F0aW9uIGNhbiBleHBlcmllbmNlIHVuZGVycnVuIHJpZ2h0IGFmdGVyIHRoZSBwbGF5YmFjayBz
dGFydC4KPj4gVGhpcyBpcyBjYXVzZWQgYnkgdGhlIE1jQlNQIEZJRk8vc0RNQSBpbnRlZ3JhdGlv
bjoKPj4gVGhlIHNETUEgd2lsbCBwdXNoIHNhbXBsZXMgdG8gdGhlIEZJRk8gdGlsbCBpdCBoYXMg
dGhyZXNob2xkIGFtb3VudCBvZiBmcmVlCj4+IHNsb3RzIGF2YWlsYWJsZSBpbiB0aGUgRklGTy4g
SWYgdGhlIGFwcGxpY2F0aW9uIHBpY2tzIHBlcmlvZCBzaXplIHdoaWNoIGlzCj4+IHNtYWxsZXIg
dGhhbiB0aGUgRklGTyBzaXplLCBhbmQgaXQgZGlkIG5vdCBwcmVwYXJlZCBtdWx0aXBsZSBwZXJp
b2RzLCBvcgo+PiBpdCBkaWQgbm90IHNldCB0aGUgc3RhcnRfdGhyZXNob2xkIGZvciB0aGUgc3Ry
ZWFtIHRvIGNvdmVyIHRoZSBGSUZPIHNpemUKPj4gdGhlIGh3IHBvaW50ZXIgd2lsbCBtb3ZlIGZv
cndhcmQsIHdoaWNoIGlzIGNhdXNpbmcgdGhlIHVuZGVycnVuLgo+Cj4gQWNrZWQtYnk6IE1hcmsg
QnJvd24gPGJyb29uaWVAb3BlbnNvdXJjZS53b2xmc29ubWljcm8uY29tPgo+Cj4gdGhvdWdoIHRo
aXMgc2hvdWxkIHByb2JhYmx5IGhhdmUgdGhlIG5vdGUgYWJvdXQgd29ya2luZyBhcm91bmQgYnJv
a2VuCj4gYXBwbGljYXRpb25zIGZyb20gdGhlIGNvdmVyIGxldHRlciBpbiB0aGUgY2hhbmdlbG9n
IGFzIHdpdGggdGhlCj4gY2hhbmdlbG9nIGFsb25lIGl0J3MgcmVhbGx5IG5vdCBhcHBhcmVudCB3
aHkgd2UncmUgZG9pbmcgdGhpcyBoZXJlIGFzIGEKPiBkcml2ZXIgc3BlY2lmaWMgdGhpbmcuCgpJ
IHdvdWxkbid0IHJlYWxseSBjYWxsIHRoZW0gYnJva2VuLCBpdCdzIGVub3VnaCB0byBzZXQgcGVy
aW9kIHNpemUgdG8KNTEyIHdpdGggc21hbGxlciBzdGFydF90aHJlc2hvbGQgKHNvbWV0aGluZyBs
aWtlIDUwbXMpIHRvIGhhdmUKcHJvYmxlbXMsIHRob3NlIHBhcmFtZXRlcnMgYXJlIHBlcmZlY3Rs
eSB2YWxpZCBmb3IgYSBwcm9ncmFtIHRyeWluZyB0bwphY2hpZXZlIGxvdyBsYXRlbmN5LgoKSXQn
cyBhIHNoYW1lIHRoaXMgc3RpbGwgd29uJ3Qgd29yayBvdXQtb2YtdGhlIGJveCwgYnV0IGF0IGxl
YXN0IHRoZXJlCndpbGwgYmUgc29tZSBzb2x1dGlvbi4KCi0tIApHcmHFvnZ5ZGFzCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGlu
ZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNhLXBy
b2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
