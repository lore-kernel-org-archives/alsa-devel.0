From: =?utf-8?Q?Beno=C3=AEt_Th=C3=A9baudeau?= <benoit.thebaudeau@advansee.com>
Subject: Re: [PATCH] ASoC: tlv320aic3x: Fix mono
Date: Mon, 28 Jan 2013 22:03:40 +0100 (CET)
Message-ID: <1064296906.226931.1359407020092.JavaMail.root@advansee.com>
References: <1359134360-25482-1-git-send-email-benoit.thebaudeau@advansee.com>
 <20130126085512.GC30594@opensource.wolfsonmicro.com>
 <1343658253.242147.1359209821129.JavaMail.root@advansee.com>
 <20130127025844.GC4650@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from zose-mta11.web4all.fr (zose-mta11.web4all.fr [178.33.204.87])
 by alsa0.perex.cz (Postfix) with ESMTP id 42B38265371
 for <alsa-devel@alsa-project.org>; Mon, 28 Jan 2013 22:03:41 +0100 (CET)
In-Reply-To: <20130127025844.GC4650@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

T24gU3VuZGF5LCBKYW51YXJ5IDI3LCAyMDEzIDM6NTg6NDcgQU0sIE1hcmsgQnJvd24gd3JvdGU6
Cj4gT24gU2F0LCBKYW4gMjYsIDIwMTMgYXQgMDM6MTc6MDFQTSArMDEwMCwgQmVub8OudCBUaMOp
YmF1ZGVhdSB3cm90ZToKPiA+IE9uIFNhdHVyZGF5LCBKYW51YXJ5IDI2LCAyMDEzIDk6NTU6MTQg
QU0sIE1hcmsgQnJvd24gd3JvdGU6Cj4gPiBJJ3ZlIG9ubHkgdGVzdGVkIHdpdGggScKyUyAoaW14
LXNzaSkuIEJ1dCBmb3IgYWxsIHRoZSBhdmFpbGFibGUgREFJIG1vZGVzLAo+ID4gdGhlCj4gPiBk
YXRhIHNoZWV0IGdpdmVzIHRoZSBlbmNvZGluZyBmb3IgYm90aCBzdGVyZW8gY2hhbm5lbHMgKGZy
b20gcC4gMjEpLCBhbmQKPiA+IG5vd2hlcmUKPiA+IGl0IHNheXMgdGhhdCBtb25vIGlzIGFuIG9w
dGlvbiBmb3IgREFJOgo+IAo+IEkyUyBpc24ndCByZWFsbHkgcmVsZXZhbnQgaGVyZSwgaXQncyBu
b3QgcG9zc2libGUgdG8gY2xvY2sgSTJTIGFzIGEgbW9ubwo+IGludGVyZmFjZS4KPiAKPiA+IEkg
d2lsbCByZXRlc3Qgd2l0aCBEU1AgbW9kZXMgaWYgeW91IHByZWZlci4KPiAKPiBZZXMsIHBsZWFz
ZS4KCkkgaGF2ZSBub3cgdGVzdGVkIGFsbCB0aGUgREFJIGZvcm1hdHMgY29tcGF0aWJsZSB3aXRo
IGJvdGggaW14LXNzaSBhbmQKdGx2MzIwYWljM3gsIGkuZS46CiAtIEkyUyB8IE5CX05GIHwgQ0JN
X0NGTSwKIC0gRFNQX0EgfCBJQl9ORiB8IENCTV9DRk0sCiAtIERTUF9CIHwgSUJfTkYgfCBDQk1f
Q0ZNLAogLSBMRUZUX0ogfCBOQl9ORiB8IENCTV9DRk0uCgpJbiBhbGwgY2FzZXMsIHN0ZXJlbyB3
b3JrcyBqdXN0IGZpbmUuCgpBcyB0byBtb25vLCBzZXR0aW5nIC5jaGFubmVsc19taW4gdG8gMiBh
bHNvIGFsd2F5cyB3b3JrcyBmaW5lIChhcyBleHBlY3RlZCwgYnV0Cm5vdCBpbnRlcmVzdGluZyBo
ZXJlKS4KCkZvciBtb25vIHdpdGggLmNoYW5uZWxzX21pbiA9IDEgKGkuZS4gd2l0aG91dCB0aGlz
IHBhdGNoKSwgSSBoYXZlIHRyaWVkIHdpdGg6CgoxKSBzbmRfc29jX2RhaV9zZXRfdGRtX3Nsb3Qo
Y3B1X2RhaSwgMHhmZmZmZmZjLCAweGZmZmZmZmMsIDIsIDApOwotPiBhbGwgREFJIGZvcm1hdHM6
IHdyb25nIHNhbXBsZSByYXRlIGZvciBML1IsIHBsYXlpbmcgdHdpY2UgdG9vIGZhc3QKCjIpIHNu
ZF9zb2NfZGFpX3NldF90ZG1fc2xvdChjcHVfZGFpLCAweGZmZmZmZmUsIDB4ZmZmZmZmZSwgMSwg
MCk7Ci0+IGFsbCBEQUkgZm9ybWF0czogbm90aGluZyBvbiBSLCB3cm9uZyBzYW1wbGUgcmF0ZSBm
b3IgTCwgcGxheWluZyB0d2ljZSB0b28KICAgZmFzdCwgcGx1cyBsb3VkIG5vaXNlIHN1cGVyaW1w
b3NlZCBmb3IgTEVGVF9KCgpTbywgSSBkb24ndCBzZWUgaG93IHRvIGF2b2lkIHRoaXMgcGF0Y2gu
CgpJIHdpbGwgc2VuZCBhIHJld29yZGVkIHVwZGF0ZS4KCkJlc3QgcmVnYXJkcywKQmVub8OudApf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVs
IG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4u
YWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
