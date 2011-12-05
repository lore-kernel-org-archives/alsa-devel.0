From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 1/5] ASoC: Hold runtime PM references to
 components of active DAIs
Date: Mon, 05 Dec 2011 15:32:19 +0200
Message-ID: <4EDCC7E3.6060702@ti.com>
References: <1323043291-6797-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<4EDC7A43.5040409@ti.com>
	<20111205113939.GF11150@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog116.obsmtp.com (na3sys009aog116.obsmtp.com
	[74.125.149.240])
	by alsa0.perex.cz (Postfix) with ESMTP id EC61C1039CB
	for <alsa-devel@alsa-project.org>; Mon,  5 Dec 2011 14:32:15 +0100 (CET)
Received: by mail-fx0-f52.google.com with SMTP id o24so2835467faa.25
	for <alsa-devel@alsa-project.org>; Mon, 05 Dec 2011 05:32:14 -0800 (PST)
In-Reply-To: <20111205113939.GF11150@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>
List-Id: alsa-devel@alsa-project.org

T24gMTIvMDUvMjAxMSAwMTozOSBQTSwgTWFyayBCcm93biB3cm90ZToKPiBUaGlzIGluY3JlYXNl
cyB0aGUgYW1vdW50IG9mIHRpbWUgd2UgYXJlIHNpdHRpbmcgd2l0aCB0aGUgcGNtX211dGV4IGhl
bGQKPiBhbmQgSSBjYW4ndCBzZWUgYSByZWFzb24gd2h5IHdlIHNob3VsZCBuZWVkIHRvIGRvIHRo
YXQuICBJZiB0aGVyZSBpcyBhCj4gcHJvYmxlbSBoZXJlIEknZCByYXRoZXIgaW1wcm92ZSB0aGUg
ZHJpdmVycyBzbyB0aGF0IHRoZXkgY2FuIGNvcGUgd2l0aAo+IGhhdmluZyB0aGUgcG93ZXIgbWFu
YWdlbWVudCBoYXBwZW5pbmcgYWZ0ZXIgdGhlIGxvY2ssIHRoZSBtYWluIHJlYXNvbgo+IHRoZSBk
cml2ZXJzIHdlcmUgZG9pbmcgdGhpcyBwcmV2aW91c2x5IGlzIHRoYXQgdGhlIGxvY2sgaGFwcGVu
ZWQgdG8gYmUKPiBoZWxkIGJ5IHRoZSBjYWxsZXIuCgpJdCBpcyBqdXN0IHRoYXQgdGhlIHBtX3J1
bnRpbWUgY2FsbHMgbWlnaHQgbmVlZCB0aGUgc2FtZSBwcm90ZWN0aW9uIGFzCnRoZSBvdGhlciBv
cGVyYXRpb25zIGZvciBkYWlzL2NvZGVjcy9kcml2ZXIuCkkganVzdCB0aG91Z2h0IGFib3V0IHRo
aXMgc2VyaWVzLCBhbmQgaXQgbWlnaHQgYnJva2UgdGhlIG9tYXAtbWNwZG0KZHJpdmVyIGFzIHNv
b24gYXMgd2UgaGF2ZSB0aGUgQklBU19PRkYgc3VwcG9ydCBmb3IgdGhlIHR3bDYwNDAgY29kZWMK
ZHJpdmVyLiBUaGUgZnVuY3Rpb25hbCBjbG9jayBpcyBjb21pbmcgZnJvbSB0aGUgZXh0ZXJuYWwg
Y29kZWMuIElmIHdlCnBvd2VyIGRvd24gdGhlIGV4dGVybmFsIGZjbGsgd2Ugd2lsbCBzZWUgZXh0
ZXJuYWwgYWJvcnQgY3Jhc2gsIHNpbmNlIHRoZQpNY1BETSBJUCBkb2VzIG5vdCBoYXZlIHRoZSBu
ZWVkZWQgY2xvY2tzIGF0IHRoZSB0aW1lIG9mIHRoZQpwbV9ydW50aW1lX3B1dF9zeW5jIGNhbGwg
KHdoaWNoIHdpbGwgdHJ5IHRvIGNvbmZpZ3VyZSBzb21lIE1jUERNIHJlZ2lzdGVycykuCk5lZWQg
dG8gY2hlY2sgdGhpcy4gQ2FuIHdlIGhvbGQgdGhpcyBzZXJpZXMgYmFjayBmb3IgYSB3aGlsZT8K
Ci0tIApQw6l0ZXIKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0
dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVs
Cg==
