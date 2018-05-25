From: Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH] ASoC: ssm2602: Fix ADC powerup sequencing
Date: Fri, 25 May 2018 17:18:09 +0200
Message-ID: <1527261489.4938.9.camel@pengutronix.de>
References: <20180517133009.26079-1-m.felsch@pengutronix.de>
 <CAL_JsqKhkVOYf+XEA3MYpK4JYfMrZTbHZtoXgaH=wCBRoU6cfQ@mail.gmail.com>
 <1526640409.3948.5.camel@pengutronix.de>
 <20180523165352.GA6187@rob-hp-laptop>
 <20180525094724.3f4edofopk52i3v6@pengutronix.de>
 <20180525102609.GK4828@sirena.org.uk>
 <20180525114253.jj6akdazsbxqkbfu@pengutronix.de>
 <20180525145245.GM4828@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [85.220.165.71])
 by alsa0.perex.cz (Postfix) with ESMTP id 9F7D5267669
 for <alsa-devel@alsa-project.org>; Fri, 25 May 2018 17:18:16 +0200 (CEST)
In-Reply-To: <20180525145245.GM4828@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Marco Felsch <m.felsch@pengutronix.de>
Cc: Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, devicetree@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>, Liam Girdwood <lgirdwood@gmail.com>, kernel@pengutronix.de
List-Id: alsa-devel@alsa-project.org

T24gRnJpLCAyMDE4LTA1LTI1IGF0IDE1OjUyICswMTAwLCBNYXJrIEJyb3duIHdyb3RlOgo+IE9u
IEZyaSwgTWF5IDI1LCAyMDE4IGF0IDAxOjQyOjUzUE0gKzAyMDAsIE1hcmNvIEZlbHNjaCB3cm90
ZToKPiAKPiA+IEFsc28gdGhlIGZvcm11bGEgZm9yIHRoZSBkZWxheSB0aW1lICh0ID0gQyDDlyAy
NSwwMDAvMy41KSBkZXBlbmRzIG9ubHkgb24KPiA+IHRoZSBjYXBhY2l0eSBzaXplLgo+IAo+IFdo
eSBub3QganVzdCBoYXZlIHRoZSB1c2VyIHNwZWNpZnkgdGhlIGNhcGFjaXRhbmNlIG9mIHRoZSBj
YXBhY2l0b3Igb24KPiB0aGUgcmFpbCB3aGljaCB0aGV5IGNhbiBkaXJlY3RseSByZWFkIGZyb20g
dGhlIHNjaGVtYXRpYyByYXRoZXIgdGhhbgo+IGZvcmNpbmcgdGhlbSB0byBkbyB0aGUgY2FsY3Vh
bHRpb24/ICBUaGF0IHNlZW1zIGEgYml0IGNsZWFyZXIgYW5kIG1vcmUKPiB1c2VyIGZyaWVuZGx5
IChwbHVzIGlmIHNvbWVvbmUgZGVjaWRlcyB0aGUgc3BlYyB3YXMgd3JvbmcgaXQncyBlYXNpZXIg
dG8KPiByb2xsIG91dCBmaXhlcykuCgpUaGUgZXhhY3QgY2FwYWNpdGFuY2UgbWF5IG5vdCBiZSBr
bm93biBvciB2YXJ5IGFib3ZlIHRoZSBub21pbmFsIHZhbHVlCmJlY2F1c2Ugb2YgY2hlYXAgY29t
cG9uZW50cywgYW5kIHRoZSBmb3JtdWxhIGZyb20gdGhlIGRhdGFzaGVldCBpcyBqdXN0CmEgZ3Vp
ZGVsaW5lLgoKSSdkIGV4cGVjdCB0aGUgdXN1YWwgbWV0aG9kIHRvIHNldCB0aGlzIGRlbGF5IHRv
IGJlIHNlbWktZW1waXJpY2FsOgoic3RhcnQgZnJvbSB0aGUgdmFsdWUgY2FsY3VsYXRlZCBmcm9t
IGRhdGFzaGVldCBhbmQgc2NoZW1hdGljcyBhbmQgdGhlbgppbmNyZWFzZSB1bnRpbCBubyBtb3Jl
IGF1ZGlvIGFydGlmYWN0cyBvbiBhIHJlcHJlc2VudGF0aXZlIHNhbXBsZSBvZgpib2FyZHMiLgpJ
IHRoaW5rIGl0IGlzIGJlIGJldHRlciB0byBzcGVjaWZ5IGEgZGVsYXkgdGhhdCB3b3JrcyB0aGFu
IGEgYm9ndXMKY2FwYWNpdGFuY2UgdmFsdWUgdGhhdCBoYXBwZW5zIHRvIGNvcnJlc3BvbmQgdG8g
YSBkZWxheSB0aGF0IHdvcmtzLgoKcmVnYXJkcwpQaGlsaXBwCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2Et
ZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21h
aWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
