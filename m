From: Mike Frysinger <vapier@gentoo.org>
Subject: Re: [Device-drivers-devel] [PATCH 2/3] ASoC: Blackfin:
 Add bf5xx-adau1701 machine driver
Date: Fri, 10 Jun 2011 13:47:34 -0400
Message-ID: <BANLkTimBJbkYJnU5vgmo+a5eerRroE1uBg@mail.gmail.com>
References: <1307726331-28618-1-git-send-email-lars@metafoo.de>
	<1307726331-28618-2-git-send-email-lars@metafoo.de>
	<20110610173004.GJ26441@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 592AD103C49
	for <alsa-devel@alsa-project.org>;
	Fri, 10 Jun 2011 19:47:54 +0200 (CEST)
Received: by fxm5 with SMTP id 5so1924706fxm.38
	for <alsa-devel@alsa-project.org>; Fri, 10 Jun 2011 10:47:54 -0700 (PDT)
In-Reply-To: <20110610173004.GJ26441@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, linux-kernel@vger.kernel.org, device-drivers-devel@blackfin.uclinux.org, uclinux-dist-devel@blackfin.uclinux.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

T24gRnJpLCBKdW4gMTAsIDIwMTEgYXQgMTM6MzAsIE1hcmsgQnJvd24gd3JvdGU6Cj4gT24gRnJp
LCBKdW4gMTAsIDIwMTEgYXQgMDc6MTg6NTBQTSArMDIwMCwgTGFycy1QZXRlciBDbGF1c2VuIHdy
b3RlOgo+PiBBZGQgYSBtYWNoaW5lIGRyaXZlciB0byBzdXBwb3J0IHRoZSBBREFVMTcwMSBTaWdt
YURTUCBwcm9jZXNzb3JzIG9uCj4+IEFuYWxvZyBEZXZpY2VzIEJGNVhYIGV2YWx1YXRpb24gYm9h
cmRzLgo+Cj4gU28sIEkga2VlcCBvbiBjb21wbGFpbmluZyBhYm91dCB0aGUgd2F5IHRoZXNlIGRy
aXZlcnMgYXJlIGp1c3QgZ2VuZXJpYwo+IHRvIGFueSByYW5kb20gQmxhY2tmaW4gcGx1cyBDT0RF
QyBjb21iaW5hdGlvbiByYXRoZXIgdGhhbiBiZWluZyBib2FyZAo+IHNwZWNpZmljLiDCoEl0J2Qg
YmUgZ29vZCBpZiB3ZSBjb3VsZCBpbXByb3ZlIHRoaXMsIGV2ZW4gYWRkaW5nIHNvbWV0aGluZwo+
IGludG8gdGhlIGRyaXZlciBuYW1lIHRvIG1ha2UgaXQgY2xlYXIgdGhlc2UgYXJlIGZvciB0aGUg
RVZCIHdvdWxkIGhlbHAuCgppIGtub3cgeW91IGtlZXAgY29tcGxhaW5pbmcsIGJ1dCBpIGhvbmVz
dGx5IGRvbnQgdW5kZXJzdGFuZCB3aHkgdGhpcwppcyB1bmRlc2lyYWJsZS4gIGNvbm5lY3Rpbmcg
YSBjb2RlYyB0byBhIEJsYWNrZmluIGlzIHByZXR0eSBtdWNoCmFsd2F5cyB0aGUgc2FtZS4gIHlv
dSBwaWNrIGEgU1BPUlQgIyBhbmQgdGhhdCdzIGFib3V0IGl0LgoKdGhlIHNwaSBjcyBhbmQgaTJj
IGFkZHJlc3MgY291bGQgZGlmZmVyIChzbyBtYXliZSBtYWtlIHRoYXQgYSBmaWVsZApmb3IgdGhl
IHBsYXRmb3JtIHJlc291cmNlcyksIGJ1dCBvdGhlcndpc2UgaSBkb250IHNlZSB3aHkgcGVvcGxl
CnNob3VsZCBoYXZlIHRvIGNvcHkgJiBwYXN0ZSB0aGUgc2FtZSBjb2RlIHRvIGNoYW5nZSBhbGwg
b2YgNCBieXRlcy4KLW1pa2UKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qu
b3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNh
LWRldmVsCg==
