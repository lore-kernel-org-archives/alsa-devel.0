From: =?UTF-8?B?TXlsw6huZQ==?= Josserand <mylene.josserand@bootlin.com>
Subject: Re: [PATCH v2 1/2] ASoC: codecs: Add support for
	PCM1789
Date: Wed, 7 Mar 2018 15:34:49 +0100
Message-ID: <20180307153449.18769094@dell-desktop.home>
References: <20180305124817.7421-1-mylene.josserand@bootlin.com>
 <20180305124817.7421-2-mylene.josserand@bootlin.com>
 <20180305154910.GJ8588@sirena.org.uk>
 <20180305155715.GJ3035@piout.net>
 <20180305155938.GL8588@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.bootlin.com (mail.bootlin.com [62.4.15.54])
 by alsa0.perex.cz (Postfix) with ESMTP id 685DC26705A
 for <alsa-devel@alsa-project.org>; Wed,  7 Mar 2018 15:34:50 +0100 (CET)
In-Reply-To: <20180305155938.GL8588@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, Alexandre Belloni <alexandre.belloni@bootlin.com>, michael@amarulasolutions.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.com, lgirdwood@gmail.com, robh+dt@kernel.org, thomas.petazzoni@bootlin.com
List-Id: alsa-devel@alsa-project.org

SGVsbG8gTWFyaywKClRoYW5rcyBmb3IgdGhlIHJldmlldy4KCk9uIE1vbiwgNSBNYXIgMjAxOCAx
NTo1OTozOCArMDAwMApNYXJrIEJyb3duIDxicm9vbmllQGtlcm5lbC5vcmc+IHdyb3RlOgoKPiBP
biBNb24sIE1hciAwNSwgMjAxOCBhdCAwNDo1NzoxNVBNICswMTAwLCBBbGV4YW5kcmUgQmVsbG9u
aSB3cm90ZToKPiA+IE9uIDA1LzAzLzIwMTggYXQgMTU6NDk6MTAgKzAwMDAsIE1hcmsgQnJvd24g
d3JvdGU6ICAKPiAKPiA+ID4gUGxlYXNlIGRvbid0IG1peCBDIGFuZCBDKysgc3R5bGUgY29tbWVu
dHMgaW4gYSBzaW5nbGUgY29tbWVudCBsaWtlIHRoaXMKPiA+ID4gLSBpdCBsb29rcyB1bmludGVu
dGlvbmFsLiAgSnVzdCB1c2UgdGhlIHNhbWUgc3R5bGUgZm9yIHRoZSB3aG9sZSB0aGluZy4KPiA+
ID4gWW91IGFsc28gZG9uJ3QgbmVlZCB0byBpbmNsdWRlIGFsbCB0aGUgYm9pbGVycGxhdGUgd2l0
aCB0aGUgU1BEWCBoZWFkZXIuICAKPiAKPiA+IEkgdGhpbmsgTGludXMgbWFkZSBpdCBjbGVhciB0
aGF0IGhlIHdhbnRzIHRoZSBTUERYIGhlYWRlciB0byBiZSBhCj4gPiBDKysgY29tbWVudCwgdGhl
IGRvY3VtZW50YXRpb24gaGFzOiAgCj4gCj4gU3VyZSwgc28gbWFrZSB0aGUgZW50aXJlIHRoaW5n
IGEgQysrIGNvbW1lbnQgdGhlbi4KCk9rLCBJIHNhdyBvdGhlciBkcml2ZXJzIHdpdGggdGhpcyBt
aXggQysrL0MgY29tbWVudCBjb2RlIHNvIEkgd3JvdGUgaXQKbGlrZSB0aGlzIGJ1dCBubyBwcm9i
bGVtIHVzaW5nIG9ubHkgQysrIGNvbW1lbnQuCgpJIHdpbGwgc2VuZCBhIHYzIHdpdGggdGhpcyBt
b2RpZmljYXRpb24gb25seSAoZXhjZXB0IGlmIEkgaGF2ZSBvdGhlcgpyZXZpZXdzKS4KCkJlc3Qg
cmVnYXJkcywKCi0tIApNeWzDqG5lIEpvc3NlcmFuZCwgQm9vdGxpbiAoZm9ybWVybHkgRnJlZSBF
bGVjdHJvbnMpCkVtYmVkZGVkIExpbnV4IGFuZCBLZXJuZWwgZW5naW5lZXJpbmcKaHR0cDovL2Jv
b3RsaW4uY29tCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRw
Oi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
