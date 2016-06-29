From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH 2/2] ASoC: fsl_ssi: Fix number of words per
 frame for I2S-slave mode
Date: Wed, 29 Jun 2016 13:56:57 -0700
Message-ID: <20160629205656.GA31609@Asurada-Nvidia>
References: <1466830762-31646-1-git-send-email-shc_work@mail.ru>
 <1467186721.688218396@f75.i.mail.ru>
 <20160629182609.GA17986@Asurada-Nvidia>
 <1467226224.156244316@f360.i.mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f65.google.com (mail-pa0-f65.google.com
 [209.85.220.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 460E2266A28
 for <alsa-devel@alsa-project.org>; Wed, 29 Jun 2016 22:57:01 +0200 (CEST)
Received: by mail-pa0-f65.google.com with SMTP id hf6so5247002pac.2
 for <alsa-devel@alsa-project.org>; Wed, 29 Jun 2016 13:57:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1467226224.156244316@f360.i.mail.ru>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alexander Shiyan <shc_work@mail.ru>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>, Timur Tabi <timur@tabi.org>, Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>
List-Id: alsa-devel@alsa-project.org

T24gV2VkLCBKdW4gMjksIDIwMTYgYXQgMDk6NTA6MjRQTSArMDMwMCwgQWxleGFuZGVyIFNoaXlh
biB3cm90ZToKPiA+0KHRgNC10LTQsCwgMjkg0LjRjtC90Y8gMjAxNiwgMjE6MjYgKzAzOjAwINC+
0YIgTmljb2xpbiBDaGVuIDxuaWNvbGVvdHN1a2FAZ21haWwuY29tPjoKPiA+Cj4gPk9uIFdlZCwg
SnVuIDI5LCAyMDE2IGF0IDEwOjUyOjAxQU0gKzAzMDAsIEFsZXhhbmRlciBTaGl5YW4gd3JvdGU6
Cj4gPgo+ID4+ID55b3VyIGZhaWxlZCBjYXNlLiBDb3VsZCB5b3UgcGxlYXNlIHRlbGwgbWUgd2hh
dCB3ZXJlIHRoZSBGU2NsaywKPiA+PiA+QklUY2xrIGFuZCBzaXplIG9mIHlvdXIgY2FzZT8KPiA+
wqAKPiA+PiBIZXJlIGlzIG15IG9zY2lsbG9ncmFtcyB3aXRoL3dpdGhvdXQgcGF0Y2g6Cj4gPj4g
QmNsaz0xMiBNSHosIHNvdW5kIGlzIGp1c3QgYSAiY2F0IC9kZXYvdXJhbmRvbSA+IC9kZXYvZHNw
IiwgaS5lLiBGUz04IEtIeiwgTU9OTy4KPiA+PiBVcHBlciAoeWVsbG93KSBsaW5lIGlzIFRYREFU
QSwgTG93ZXIgKGJsdWUpIGlzIEZTLgo+ID4+IAo+ID4+IE1lYXN1cmVtZW50IHdpdGhvdXQgcGF0
Y2g6ICBodHRwczovL2Nsb3VkLm1haWwucnUvcHVibGljL1Jjc3YveHI4OFY1U2ExCj4gPj4gTWVh
c3VyZW1lbnQgd2l0aCBwYXRjaDogIGh0dHBzOi8vY2xvdWQubWFpbC5ydS9wdWJsaWMvTkN3bi9E
UW56aW9RRUwKPiA+Cj4gPlRoYW5rcyBmb3IgdGhlIHJlcGx5LiBTbyBpbiB0aGUgY2FzZSB3aXRo
b3V0IHBhdGNoLCBpdCBsb29rcyBsaWtlCj4gPlNTSSBqdXN0IHNlbnQgdGhlIGRhdGEgaWdub3Jp
bmcgdGhlIHNsb3Qgc2l6ZSByaWdodD8KPiAKPiBJIGNvdWxkIGJlIHdyb25nLCBidXQgdGhpbmsg
dGhhdCBXTCAod29yZCBsZW5ndGgpIHN0aWxsIHBvaW50IHRvIG51bWJlciBvZiB2YWxpZAo+IGRh
dGEgYml0cyB3aXRoaW4gMzJiaXQgY2h1bmsgKGFzIGRlZmluZWQgZm9yIEkyUy1NYXN0ZXIgbW9k
ZSksCj4gYnV0IHNpbmNlIERDPTAsIHRoaXMgY2F1c2UgdG8gc2VuZCBuZXh0IHdvcmQgdG8gdGhl
IGNoYW5uZWwgYWdhaW4gYW5kIGFnYWluLgoKSSBzZWUuIFRoYW5rcyBmb3IgdGhlIGZpeC4KX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQWxzYS1kZXZlbCBt
YWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFuLmFs
c2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
