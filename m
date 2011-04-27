From: Jassi Brar <jassisinghbrar@gmail.com>
Subject: Re: [PATCH 1/5] ASoC: Allow platform drivers to have
 no ops structure
Date: Thu, 28 Apr 2011 00:40:19 +0530
Message-ID: <BANLkTikpt8gqi3i0152wpOEtsgM46U=bLg@mail.gmail.com>
References: <1303925257-26920-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<BANLkTimJvDiXxX1GXrHGEZ0kDe3aNMX3pw@mail.gmail.com>
	<20110427190503.GF12249@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 5F12B10390D
	for <alsa-devel@alsa-project.org>;
	Wed, 27 Apr 2011 21:10:20 +0200 (CEST)
Received: by bwz10 with SMTP id 10so1896584bwz.38
	for <alsa-devel@alsa-project.org>; Wed, 27 Apr 2011 12:10:20 -0700 (PDT)
In-Reply-To: <20110427190503.GF12249@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, patches@opensource.wolfsonmicro.com, Chanwoo Choi <cw00.choi@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

T24gVGh1LCBBcHIgMjgsIDIwMTEgYXQgMTI6MzUgQU0sIE1hcmsgQnJvd24KPGJyb29uaWVAb3Bl
bnNvdXJjZS53b2xmc29ubWljcm8uY29tPiB3cm90ZToKPiBPbiBUaHUsIEFwciAyOCwgMjAxMSBh
dCAxMjoxNzo0NkFNICswNTMwLCBKYXNzaSBCcmFyIHdyb3RlOgo+Cj4gUGxlYXNlIGRlbGV0ZSB1
bm5lZWRlZCBjb250ZXh0LCBtYWtlcyBpdCBtdWNoIGVhc2llciB0byBmaW5kIHlvdXIKPiB0ZXh0
Li4uClRoZXJlIHdhc24ndCBhbnl0aGluZyB0byBxdW90ZSBmcm9tIGNoYW5nZWxvZyBhbmQgbXkg
Y29tbWVudHMKZW5jb21wYXNzIHlvdXIgZXZlcnkgY2hhbmdlLCBzbyBJIGNvbW1lbnRlZCAgYXQg
dGhlIGVuZC4KCj4+IEkgaGF2ZSBub3RoaW5nIGFnYWluc3QgdGhpcyBhcHByb2FjaCwgYnV0IGp1
c3QgYSB0aG91Z2h0Li4uCj4+IElzIHRoZXJlIGFueSBvcHRpb24gbGlrZSBoYXZpbmcgJ2R1bW15
JyB2ZXJzaW9ucyBvZiBjcHUsCj4+IGNvZGVjIGFuZCBkbWEgZGFpcywgbWF5YmUgb3BzIHRvbywg
YW5kIGhhdmUgbWFjaGluZQo+PiBkcml2ZXJzIGV4cGxpY2l0bHkgdXNlIHRoZW0uIFRoYXQgd2ls
bCBwcmVzZXJ2ZSB3aGF0IGhhcyBhbHdheXMgYmVlbgo+PiBleHBlY3RlZCBvZmYgb2YgQVNvQyBk
cml2ZXJzIGFuZCBrZWVwIHRoZQo+PiBjb3JlICdzaW1wbGUnIChub3QgdG8gbWVhbiB0aGUgY2hl
Y2tzIHlvdSBhZGQgYWJvdmUgYXJlCj4+IHNlcmlvdXMgb3ZlcmhlYWQpLgo+Cj4gSSBjb25zaWRl
cmVkIHRoYXQsIG15IHRob3VnaHQgd2FzIG1vc3RseSB0aGF0IGl0J3MgYmV0dGVyIGZvciB0aGUg
Y29yZQo+IHRvIGRvIGEgYml0IG9mIHdvcmsgdGhhbiBmb3IgZWFjaCB1c2VyIHRvIGhhdmUgdG8g
ZG8gdHlwaW5nLiDCoEknZAo+IHByb2JhYmx5IGhhdmUgZ29uZSB0aGUgb3RoZXIgd2F5IGlmIHdl
IHdlcmVuJ3QgYWxyZWFkeSBoYXZpbmcgdG8gY2hlY2sKPiB0byBzZWUgaWYgdGhlIG9wIGl0c2Vs
ZiB3YXMgdGhlcmUgLSB0aGlzIGlzIHdoeSB0aGVyZSdzIGEgZHVtbXkgZHJpdmVyCj4gY3JlYXRl
ZCBhbmQgc3Vic3RpdHV0ZWQgaW4gd2hlcmUgdGhlcmUncyBubyBwbGF0Zm9ybSBhdCBhbGwuIMKg
SGFkIEkgZG9uZQo+IHRoZSBzZWNvbmQgcGF0Y2ggZmlyc3QgSSdkIHByb2JhYmx5IG5ldmVyIGhh
dmUgd3JpdHRlbiB0aGlzIG9uZSBidXQgaXQKPiBzZWVtZWQgbGlrZSBzb21ldGhpbmcgc29tZW9u
ZSBtaWdodCBjb21lIHVwIHdpdGggYW5vdGhlciBzYW5lIHVzZSBjYXNlCj4gZm9yIHNvbWUgdGlt
ZS4KPgo+IEluIHRoZSBEQUlzIHdlJ3JlIGFjdHVhbGx5IHN1YnN0aXR1dGluZyBhIGR1bW15IG9w
cyBpbiBidXQgd2Ugc2hvdWxkbid0Cj4gcmVhbGx5IGJlIGRvaW5nIHRoYXQgYXMgaXQgb3VnaHQg
dG8gYmUgcG9zc2libGUgZm9yIHRoZSBkcml2ZXJzIHRvIGJlCj4gY29uc3QuCgpPSy4KCiAgQWNr
ZWQtYnk6IEphc3NpIEJyYXIgPGphc3Npc2luZ2hicmFyQGdtYWlsLmNvbT4KX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxp
c3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVj
dC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
