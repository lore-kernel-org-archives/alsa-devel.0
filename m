From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH RFC 1/3] ASoC: uda1380: use callbacks
	instead of gpiolib
Date: Sun, 27 Jun 2010 11:21:00 +0100
Message-ID: <20100627102100.GB26394@opensource.wolfsonmicro.com>
References: <1277565285-11563-1-git-send-email-anarsoul@gmail.com>
	<201006262353.58897.anarsoul@gmail.com>
	<8308AEB2-F7DB-4C48-AAED-719311AF7A42@opensource.wolfsonmicro.com>
	<201006270012.12854.anarsoul@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 5FCFB1037E3
	for <alsa-devel@alsa-project.org>;
	Sun, 27 Jun 2010 12:21:01 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <201006270012.12854.anarsoul@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Vasily Khoruzhick <anarsoul@gmail.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>, Philipp Zabel <philipp.zabel@gmail.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

T24gU3VuLCBKdW4gMjcsIDIwMTAgYXQgMTI6MTI6MDVBTSArMDMwMCwgVmFzaWx5IEtob3J1emhp
Y2sgd3JvdGU6Cj4g0JIg0YHQvtC+0LHRidC10L3QuNC4INC+0YIgMjYg0LjRjtC90Y8gMjAxMCAy
Mzo1Nzo0MiDQsNCy0YLQvtGAIE1hcmsgQnJvd24g0L3QsNC/0LjRgdCw0Ls6Cgo+ID4gWW91IGRl
ZmluaXRlbHkgc2hvdWxkIGJlIGRvaW5nIHRoaXMgaW4gdGhlIEkyQyBkcml2ZXIgbm90IHRoZSBD
T0RFQyBkcml2ZXIsCj4gPiB5b3UncmUgcGVlcmluZyBpbnNpZGUgdGhlIGludGVybmFscyBvZiB0
aGUgSTJDIGRyaXZlciBhcyB0aGluZ3Mgc3RhbmQgYW5kCj4gPiBhcmUgbGlrZWx5IHRvIGNhdXNl
IHByb2JsZW1zIGlmIHNvbWVvbmUgY29tZXMgYWxvbmcgYW5kIGltcGxlbWVudHMgdGhpcyBpbgo+
ID4gdGhlIGRyaXZlci4gVGhlcmUncyBhbHNvIHRoZSBmYWN0IHRoYXQgYWxsIHVzZXJzIG9mIHRo
ZSBJMkMgY29udHJvbGxlcgo+ID4gd2lsbCBiZW5lZml0IGlmIHRoZSBjb2RlIGlzIGltcGxlbWVu
dGVkIHRoZXJlLCBub3QganVzdCB0aGlzIG9uZSBhdWRpbwo+ID4gZHJpdmVyLgoKPiBJJ20gYWZy
YWlkIHRoYXQgaXQgY2FuIGNhdXNlIHByb2JsZW1zIHdpdGggb3RoZXIgaTJjLWNvbnRyb2xsZWQg
ZGV2aWNlcywgYW5kIEkgClRoYXQncyBzdGlsbCBub3QgZGVhbGluZyB3aXRoIHRoZSBwcm9ibGVt
cyB0aGF0IHdpbGwgYXJpc2UgaWYgc29tZW9uZQpkb2VzIGltcGxlbWVudCB0aGlzIGluIHRoZSBj
b3JlLiAgVG8gYmUgaG9uZXN0IEknbSBoYXZpbmcgYSBoYXJkIHRpbWUKc2VlaW5nIHdoeSBkZXZp
Y2VzIHdvdWxkIGNhcmUgLSB0aGUgSTJDIGNvbnRyb2xsZXIgb25seSBjbG9ja3MgdGhlIGJ1cwpk
dXJpbmcgYSB0cmFuc2ZlciBhbmQgb3RoZXJ3aXNlIHByb2R1Y2VzIG5vIG91dHB1dCAtIHNvIGl0
IHNob3VsZCBqdXN0CmJlIGFuIGlzc3VlIGZvciB0aGUgY29udHJvbGxlciBJUC4KCj4gY2FuIHRl
c3QgaTJjIG1vZGlmaWNhdGlvbiBvbmx5IG9uIGgxOTQwIGFuZCByeDE5NTAgd2l0aCBzYW1lIGNv
ZGVjICh1ZGExMzgwKS4KCk5vYm9keSBpcyBldmVyIGdvaW5nIHRvIGJlIGFibGUgdG8gdGVzdCBv
biBhbGwgcG9zc2libGUgaGFyZHdhcmUsCnRlc3RpbmcgaXMgYSBjb21tdW5pdHkgZWZmb3J0Lgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVs
IG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4u
YWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
