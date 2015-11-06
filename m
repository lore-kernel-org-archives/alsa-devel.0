From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH] ASoC: wm9713: add gpio chip
Date: Fri, 6 Nov 2015 09:29:13 +0000
Message-ID: <20151106092913.GC3378@x1>
References: <1446657164-25012-1-git-send-email-robert.jarzmik@free.fr>
 <20151104183322.GD2549@ck-lbox> <87oaf9bls9.fsf@belgarion.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f54.google.com (mail-wm0-f54.google.com [74.125.82.54])
 by alsa0.perex.cz (Postfix) with ESMTP id 2DFFC265A2D
 for <alsa-devel@alsa-project.org>; Fri,  6 Nov 2015 10:29:16 +0100 (CET)
Received: by wmec201 with SMTP id c201so12373568wme.1
 for <alsa-devel@alsa-project.org>; Fri, 06 Nov 2015 01:29:15 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <87oaf9bls9.fsf@belgarion.home>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, patches@opensource.wolfsonmicro.com, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

T24gV2VkLCAwNCBOb3YgMjAxNSwgUm9iZXJ0IEphcnptaWsgd3JvdGU6Cgo+IENoYXJsZXMgS2Vl
cGF4IDxja2VlcGF4QG9wZW5zb3VyY2Uud29sZnNvbm1pY3JvLmNvbT4gd3JpdGVzOgo+IAo+ID4g
T24gV2VkLCBOb3YgMDQsIDIwMTUgYXQgMDY6MTI6NDRQTSArMDEwMCwgUm9iZXJ0IEphcnptaWsg
d3JvdGU6Cj4gPj4gVGhlIFdvbGZzb24gV005NzEzIHByb3ZpZGVzIDggR1BJT3MuIElmIHRoZSBn
cGlvbGliIGlzIGNvbXBpbGVkIGluIHRoZQo+ID4+IGtlcm5lbCwgZGVjbGFyZSBhIGdwaW8gY2hp
cC4KPiA+PiAKPiA+PiBTaWduZWQtb2ZmLWJ5OiBSb2JlcnQgSmFyem1payA8cm9iZXJ0Lmphcnpt
aWtAZnJlZS5mcj4KPiA+PiAtLS0KPiA+Cj4gPiBZb3Ugc2hvdWxkIHByb2JhYmx5IG1ha2UgYSBz
ZXBlcmF0ZSBkcml2ZXIgd2l0aGluIEdQSU8gZm9yIHRoaXMKPiA+IGFuZCB0aGVuIHRpZSB0aGUg
dHdvIHRvZ2V0aGVyLCB1c2luZyBhbiBNRkQuIEkgYXBwcmVjaWF0ZSB0aGF0IGlzCj4gPiBtb3Jl
IHdvcmsgYnV0IGl0IGlzIGxpa2VseSBhIG5pY2VyIHNvbHV0aW9uIG92ZXJhbGwuCj4gCj4gSSdk
IGxpa2UgdG8gZmlyc3QgaGF2ZSBhIGNvbmZpcm1hdGlvbiBmcm9tIDoKPiAgLSBNYXJrIChCcm93
bikKPiAgLSBhbmQgTGVlIChKb25lcykKPiAKPiBUaGUgY29uZmlybWF0aW9uIEknbSBsb29raW5n
IGZvciBzdGF0ZXMgdGhhdCA6Cj4gIC0gdGhlIHdtOTcxMyBzaG91bGQgaGF2ZSBhIHBhcnQgaW4g
dGhlIG1mZCB0cmVlCj4gIC0gdGhlIGdwaW8gcGFydCBzaG91bGQgYmUgaW4gZHJpdmVycy9ncGlv
Cj4gIC0gdGhlIHNvdW5kIHNvYyBjb2RlY3Mgd2lsbCByZW1haW4gYXMgaXMKPiAgLSBpZiB0aGUg
ZnV0dXJlIGRyaXZlci9tZmQvd205NzEzLmMgaXMgdGVjaG5pY2FsbHkgc291bmQsIGl0IHdpbGwg
YmUgYWNjZXB0ZWQKPiAKPiBJIHJlbWVtYmVyIGF0IGxlYXN0IG9uZSBleGFtcGxlIHdoZXJlIHRo
ZSBNRkQgYXBwcm9hY2ggd2FzIHJlamVjdGVkIGZyb20gbWZkCj4gdHJlZSBmb3IgcHhhIGdwaW9z
LCBzbyBJIHdvbid0IHdvcmsgdW5sZXNzIEkgaGF2ZSBhIGNvbmZpcm1hdGlvbiBmcm9tIGJvdGgK
PiBtYWludGFpbmVycy4KCkkgaGF2ZSBubyBpZGVhIHdoYXQgeW91J3JlIHRhbGtpbmcgYWJvdXQu
ICBDb250ZXh0IHBsZWFzZT8KCi0tIApMZWUgSm9uZXMKTGluYXJvIFNUTWljcm9lbGVjdHJvbmlj
cyBMYW5kaW5nIFRlYW0gTGVhZApMaW5hcm8ub3JnIOKUgiBPcGVuIHNvdXJjZSBzb2Z0d2FyZSBm
b3IgQVJNIFNvQ3MKRm9sbG93IExpbmFybzogRmFjZWJvb2sgfCBUd2l0dGVyIHwgQmxvZwpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1h
aWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxz
YS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
