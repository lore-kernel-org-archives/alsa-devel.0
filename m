From: Barry Song <21cnbao@gmail.com>
Subject: Re: [PATCH 2/3] ad193x: fix wrong register setting in
	ad193x_set_dai_fmt
Date: Sun, 25 Apr 2010 01:12:03 +0800
Message-ID: <m2x3c17e3571004241012w63a0f1e9o4eb42ebfdca7aef7@mail.gmail.com>
References: <1271842609-18276-1-git-send-email-21cnbao@gmail.com>
	<1271842609-18276-2-git-send-email-21cnbao@gmail.com>
	<1271842609-18276-3-git-send-email-21cnbao@gmail.com>
	<20100423151427.GD27232@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gy0-f179.google.com (mail-gy0-f179.google.com
	[209.85.160.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 0B9B92455D
	for <alsa-devel@alsa-project.org>;
	Sat, 24 Apr 2010 19:12:24 +0200 (CEST)
Received: by gyd10 with SMTP id 10so5247102gyd.38
	for <alsa-devel@alsa-project.org>; Sat, 24 Apr 2010 10:12:23 -0700 (PDT)
In-Reply-To: <20100423151427.GD27232@rakim.wolfsonmicro.main>
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
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

T24gRnJpLCBBcHIgMjMsIDIwMTAgYXQgMTE6MTQgUE0sIE1hcmsgQnJvd24KPGJyb29uaWVAb3Bl
bnNvdXJjZS53b2xmc29ubWljcm8uY29tPiB3cm90ZToKPiBPbiBXZWQsIEFwciAyMSwgMjAxMCBh
dCAwNTozNjo0OFBNICswODAwLCBCYXJyeSBTb25nIHdyb3RlOgo+PiBTaWduZWQtb2ZmLWJ5OiBC
YXJyeSBTb25nIDwyMWNuYmFvQGdtYWlsLmNvbT4KPgo+IFBsZWFzZSBwcm92aWRlIG1vcmUgZGV0
YWlsZWQgY2hhbmdlbG9ncy4gwqBXaGF0IGlzIHdyb25nIHdpdGggdGhlCj4gcmVnaXN0ZXIgc2V0
dGluZ3M/IMKgSSd2ZSBhcHBsaWVkIHRoZSBwYXRjaCBmb3IgMi42LjM1IHNpbmNlIGl0IGRvZXNu
J3QKPiBhcHBseSBvbiAyLjYuMzQgYnV0IGl0J2QgaGF2ZSBiZWVuIHZlcnkgbXVjaCBtb3JlIGhl
bHBmdWwgaWYgeW91J2Qgc2FpZAo+IHdoYXQgdGhlIHByb2JsZW0geW91IHdlcmUgdHJ5aW5nIHRv
IGZpeCBpcy4KVGhlcmUgd2FzIGFuIGVycm9yIGJlZm9yZS4gREFJRk1UX0ZPUk1BVCBpcyBjb250
cm9sbGVkIGJ5IGFkY19jdHJsMQpyZWcgYW5kIERBSUZNVF9JTlYgaXMgY29udHJvbGxlZCBieSBh
ZGNfY3RybDIgcmVnIGluIGFkMTkzeC4gT2xkIGNvZGVzCnNldCBhbGwgYnkgYWRjX2N0cmwyLCB0
aGVuIHNvbWV0aW1lcywgd2hlbiBydW5uaW5nICJhcmVjb3JkIHwgYXBsYXkiLAphZDE5M3ggaXMg
c2V0IHRvIHdyb25nIG1vZGUsIHdlIGNhbid0IGhlYXIgYW55dGhpbmcuCj4KX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxp
c3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVj
dC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
