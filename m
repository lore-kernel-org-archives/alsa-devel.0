From: Jeremy McDermond <nh6z@nh6z.net>
Subject: Re: [PATCH 2/3] ASoC: simple-card: Add support jack
	detection via codec
Date: Fri, 22 Apr 2016 09:40:09 -0700
Message-ID: <3EB722B2-2818-459C-8640-A3C2FC713F05@nh6z.net>
References: <1460967452-24574-1-git-send-email-zhengxing@rock-chips.com>
 <1460967452-24574-3-git-send-email-zhengxing@rock-chips.com>
 <20160421141921.GA25900@rob-hp-laptop> <57197BBA.50304@rock-chips.com>
 <20160422092250.GA3217@sirena.org.uk>
Mime-Version: 1.0 (Mac OS X Mail 9.1 \(3096.5\))
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.xenotropic.com (mail.xenotropic.com [198.178.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 8DFF32604BE
 for <alsa-devel@alsa-project.org>; Fri, 22 Apr 2016 18:40:16 +0200 (CEST)
In-Reply-To: <20160422092250.GA3217@sirena.org.uk>
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
Cc: Mark Rutland <mark.rutland@arm.com>, Andrew Lunn <andrew@lunn.ch>, alsa-devel@alsa-project.org, Mengdong Lin <mengdong.lin@linux.intel.com>, heiko@sntech.de, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>, Xing Zheng <zhengxing@rock-chips.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Takashi Iwai <tiwai@suse.com>, sugar.zhang@rock-chips.com, linux-rockchip@lists.infradead.org, jay.xu@rock-chips.com, devicetree@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Jyri Sarha <jsarha@ti.com>, Arnaud Pouliquen <arnaud.pouliquen@st.com>, linux-kernel@vger.kernel.org, Adam.Thomson@diasemi.com, Kumar Gala <galak@codeaurora.org>, Jun Nie <jun.nie@linaro.org>
List-Id: alsa-devel@alsa-project.org

Cj4gT24gQXByIDIyLCAyMDE2LCBhdCAyOjIyIEFNLCBNYXJrIEJyb3duIDxicm9vbmllQGtlcm5l
bC5vcmc+IHdyb3RlOgo+IAo+IE9uIEZyaSwgQXByIDIyLCAyMDE2IGF0IDA5OjE3OjQ2QU0gKzA4
MDAsIFhpbmcgWmhlbmcgd3JvdGU6Cj4gCj4+IEhpIE1hcmssIHRoZSBvdGhlciBxdWVzdGlvbiBo
ZXJlLCBob3cgZG8gd2UgbWFrZSBzZW5zZSB0byB1c2UgdGhlCj4+IHNpbXBsZS1jYXJkIHRvIGNh
bGwgdGhlICJzbmRfc29jX2RhaV9zZXRfcGxsIiBpZiB0aGUgY29kZWMgKGxpa2UgZGE3MjE5KQo+
PiByZXF1aXJlcyBkbyB0aGlzPwo+IAo+IFdoYXQgd2Ugc2hvdWxkIGRvIHRoZXJlIGlzIG1vdmUg
dGhlIENPREVDIGNsb2NraW5nIHRvIGJlIHJlcHJlc2VudGVkCj4gdXNpbmcgdGhlIGNsb2NrIEFQ
SSBhbmQgdGhlbiB0aGVyZSBhcmUgY29tbW9uIGNsb2NrIGJpbmRpbmdzIHRoYXQKPiBhbHJlYWR5
IGV4aXN0IGZvciBjb25maWd1cmluZyBjbG9ja3MuCgpJ4oCZbSBhIGxpdHRsZSBiaXQgY3VyaW91
cyBhYm91dCB0aGlzLiAgSeKAmW0gd29ya2luZyB3aXRoIHRoZSBjbG9ja2luZwpvbiB0aGUgdGx2
MzIwYWljMzJ4NCBkcml2ZXIgYmVjYXVzZSBJ4oCZbSBkZWFsaW5nIHdpdGggYSBwbGF0Zm9ybSB0
aGF0CndpbGwgYmUgY2xvY2tpbmcgaXQgZnJvbSBhIGR5bmFtaWMgY2xvY2sgY29udHJvbGxlZCBi
eSB0aGUgQ0NGLiAgVGhhdApwcmVzZW50cyBzb21lIHByb2JsZW1zIGJlY2F1c2UgdGhlIGFpYzMy
eDQgZHJpdmVyIGhhcyBhIHRhYmxlIG9mIGNsb2NrCnBhcmFtZXRlcnMgYW5kIHRob3NlIHJlbHkg
b24gdGhlIG1jbGsgcmF0ZSBiZWluZyBhIHByZWNpc2UgdmFsdWUuClRoZSBtY2xrIG1pZ2h0IG5v
dCBiZSBhYmxlIHRvIHByb3ZpZGUgdGhvc2UgZXhhY3QgdmFsdWVzLCBzbyB0aGUKYWljMzJ4NCBk
cml2ZXIgbmVlZHMgdG8gc2V0IGl0cyBQTExzIGFuZCBkaXZpZGVycyBhY2NvcmRpbmdseS4KClRo
ZSBoYXJkd2FyZSBoYXMgYSBjb3VwbGUgb2YgY2xvY2sgbXV4ZXMsIGEgZmV3IGRpdmlkZXJzIGFu
ZCB0aGUKUExMLiAgSXQgc2VlbXMgdG8gYmUgYWJsZSB0byBiZSBtb2RlbGVkIGJ5IHRoZSBjdXJy
ZW50IENDRgpjb21wb25lbnRzIGZhaXJseSB3ZWxsLiAgSeKAmW0ganVzdCB0cnlpbmcgdG8gd3Jh
cCBteSBoZWFkIGFyb3VuZAp3aGVyZSB0aGlzIGFsbCB3b3VsZCBmaXQgaW4uICBTaG91bGQgdGhl
IGNvZGVjIGRyaXZlciBqdXN0IHJlZ2lzdGVyCmEgYnVuY2ggb2YgY2xvY2sgY29tcG9uZW50cyBp
biBpdHMgaW5pdGlhbGl6YXRpb24gc29tZXdoZXJlPwpJ4oCZbSB0aGlua2luZyB0aGF0IGl0IGNh
buKAmXQgaGF2ZSBpdHMgb3duIENDRiBkcml2ZXIgc2VwYXJhdGUgZnJvbQp0aGUgY29kZWMgZHJp
dmVyIGJlY2F1c2UgeW91IHdvbuKAmXQgaGF2ZSBwcm9wZXIgYWNjZXNzIHRvIHRoZQpyZWdpc3Rl
cnMgb3ZlciBJMkMgb3IgU1BJLiAgSSBkb27igJl0IGZpbmQgYSBsb3Qgb2YgZXhhbXBsZXMgaW4g
dGhlCmNvZGVjIGRyaXZlcnMsIGFuZCB0aGVyZSBhcmVu4oCZdCB2ZXJ5IG1hbnkgb3RoZXIgZHJp
dmVycyBpbiB0aGUgdHJlZQp0aGF0IHNlZW0gdG8gcmVnaXN0ZXIgY2xvY2tzIHdpdGggQ0NGIHRo
YXQgSSBjYW4gZmluZC4KCknigJltIGhhcHB5IHRvIHdvcmsgdGhyb3VnaCB0aGlzIHdpdGggdGhl
IGFpYzMyeDQgZHJpdmVyLiAgSSBqdXN0Cm5lZWQgc29tZSBndWlkYW5jZSBvbiBob3cgdG8gZG8g
aXQgc28gaXQgZml0cyBpbiB3ZWxsIHdpdGgKZXZlcnl0aGluZyBlbHNlIHN1cnJvdW5kaW5nIGl0
LgoKLS0KSmVyZW15IE1jRGVybW9uZCAoTkg2WikKWGVub3Ryb3BpYyBTeXN0ZW1zCm1jZGVybWpA
eGVub3Ryb3BpYy5jb20KCgoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0
Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxz
YS1kZXZlbAo=
