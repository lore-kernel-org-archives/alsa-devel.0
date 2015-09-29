From: Rick Mann <rmann@latencyzero.com>
Subject: Re: Found bugs in tlv320aic3x.c driver,
	how do I report them?
Date: Tue, 29 Sep 2015 12:21:05 -0700
Message-ID: <5871EAD1-2BC3-4236-B008-76822A51F422@latencyzero.com>
References: <B9E728AE-223C-4BA7-961A-ED107AF03407@latencyzero.com>
 <CA+sos79twXY1fC8kqrORJvDbXv9Lvu6SjY05N7VFcRcOEKx7LA@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com
 [66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id 70B212605C1
 for <alsa-devel@alsa-project.org>; Tue, 29 Sep 2015 21:21:08 +0200 (CEST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailout.nyi.internal (Postfix) with ESMTP id 6BF3720290
 for <alsa-devel@alsa-project.org>; Tue, 29 Sep 2015 15:21:07 -0400 (EDT)
In-Reply-To: <CA+sos79twXY1fC8kqrORJvDbXv9Lvu6SjY05N7VFcRcOEKx7LA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: =?utf-8?Q?Beno=C3=AEt_Th=C3=A9baudeau?= <benoit.thebaudeau.dev@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Cj4gT24gU2VwIDI5LCAyMDE1LCBhdCAxMTo0NyAsIEJlbm/DrnQgVGjDqWJhdWRlYXUgPGJlbm9p
dC50aGViYXVkZWF1LmRldkBnbWFpbC5jb20+IHdyb3RlOgo+IAo+IERlYXIgUmljayBNYW5uLAo+
IAo+IE9uIFR1ZSwgU2VwIDI5LCAyMDE1IGF0IDEyOjM4IFBNLCBSaWNrIE1hbm4gPHJtYW5uQGxh
dGVuY3l6ZXJvLmNvbT4gd3JvdGU6Cj4+IEhpLiBJIGNhbWUgYWNyb3NzIHNvbWUgYnVncyBpbiBz
b3VuZC9zb2MvY29kZWNzL3RsdjMyMGFpYzN4LmMsIHdoZXJlaW4gaXQgd3JpdGVzIG5vbi16ZXJv
IHZhbHVlcyB0byByZXNlcnZlZCByZWdpc3RlcnMgb24gdGhlIHRsdjMyMGFpYzMxMDQgKEkgZm91
bmQgaXQgaW4gNC4xLjQsIGJ1dCBpdCdzIHN0aWxsIGluIDQuMy1yYzMpLiBJIGhhdmUgYW4gdW50
ZXN0ZWQgcHJvcG9zZWQgcGF0Y2guIEJ1dCBJIGRvbid0IGtub3cgYW55dGhpbmcgYWJvdXQgaG93
IHRvIHJlcG9ydCBpdCBvciBvZmZlciBpdC4KPj4gCj4+IFdoYXQgc2hvdWxkIEkgZG8/IFRoYW5r
cy4KPiAKPiBGb2xsb3cgdGhpczoKPiBodHRwczovL2dpdC5rZXJuZWwub3JnL2NnaXQvbGludXgv
a2VybmVsL2dpdC90b3J2YWxkcy9saW51eC5naXQvdHJlZS9Eb2N1bWVudGF0aW9uL1N1Ym1pdHRp
bmdQYXRjaGVzP2lkPXJlZnMvdGFncy92NC4zLXJjMwoKVGhhbmtzLCB3aWxsIGRvLgo+IAo+IE5v
dGhpbmcgc2hvdWxkIGJlIGRvbmUgZm9yIHRoZXNlIHJlZ2lzdGVycyBvbiAzMTA0LCBub3QgZXZl
biBzZXR0aW5nCj4gdGhlbSB0byAwLiBUaGUgZGF0YXNoZWV0IHNheXMgIkRvIG5vdCB3cml0ZSB0
byB0aGlzIHJlZ2lzdGVyLiIuCgpJbmRlZWQsIGl0IGRvZXMgc2F5IHRoYXQuIEknbGwgY2hhbmdl
IHRoZSBjb2RlLgoKSG93ZXZlciwgaXQgYWxzbyBzYXlzIG5vdCB0byB3cml0ZSBjZXJ0YWluIGJp
dHMgd2l0aGluIGEgcmVnaXN0ZXIsIHdoaWNoIGlzIGltcG9zc2libGUgKGUuZy4gVGFibGUgODgs
IFJlZ2lzdGVyIDg2LCBiaXQgRDIsICJSZXNlcnZlZC4gRG8gbm90IHdyaXRlIHRvIHRoaXMgcmVn
aXN0ZXIgYml0LiIpLgoKPiAKPj4gKyAgICAgICB9IGVsc2Ugewo+PiArICAgICAgICAgICAgICAg
LyogTGluZTIgdG8gSFAgQnlwYXNzIGRlZmF1bHQgdm9sdW1lLCBkaXNjb25uZWN0IGZyb20gT3V0
cHV0IE1peGVyICovCj4+ICsgICAgICAgICAgICAgICBzbmRfc29jX3dyaXRlKGNvZGVjLCBMSU5F
MkxfMl9IUExPVVRfVk9MLCBERUZBVUxUX1ZPTCk7Cj4+ICsgICAgICAgICAgICAgICBzbmRfc29j
X3dyaXRlKGNvZGVjLCBMSU5FMlJfMl9IUFJPVVRfVk9MLCBERUZBVUxUX1ZPTCk7Cj4+ICsgICAg
ICAgICAgICAgICBzbmRfc29jX3dyaXRlKGNvZGVjLCBMSU5FMkxfMl9IUExDT01fVk9MLCBERUZB
VUxUX1ZPTCk7Cj4+ICsgICAgICAgICAgICAgICBzbmRfc29jX3dyaXRlKGNvZGVjLCBMSU5FMlJf
Ml9IUFJDT01fVk9MLCBERUZBVUxUX1ZPTCk7Cj4+ICsgICAgICAgICAgICAgICAvKiBMaW5lMiBM
aW5lIE91dCBkZWZhdWx0IHZvbHVtZSwgZGlzY29ubmVjdCBmcm9tIE91dHB1dCBNaXhlciAqLwo+
PiArICAgICAgICAgICAgICAgc25kX3NvY193cml0ZShjb2RlYywgTElORTJMXzJfTExPUE1fVk9M
LCBERUZBVUxUX1ZPTCk7Cj4+ICsgICAgICAgICAgICAgICBzbmRfc29jX3dyaXRlKGNvZGVjLCBM
SU5FMlJfMl9STE9QTV9WT0wsIERFRkFVTFRfVk9MKTsKPj4gKyAgICAgICB9Cj4gCj4gQ29ycmVj
dC4KClRoYW5rcyEKCgotLSAKUmljayBNYW5uCnJtYW5uQGxhdGVuY3l6ZXJvLmNvbQoKCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFp
bGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNh
LXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
