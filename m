From: =?UTF-8?Q?Beno=C3=AEt_Th=C3=A9baudeau?= <benoit.thebaudeau.dev@gmail.com>
Subject: Re: Found bugs in tlv320aic3x.c driver,
	how do I report them?
Date: Tue, 29 Sep 2015 21:31:15 +0200
Message-ID: <CA+sos7_X9Vsr8myVVGUBe9ibQe4qiV_183EDK-0un_2XkjdMsA@mail.gmail.com>
References: <B9E728AE-223C-4BA7-961A-ED107AF03407@latencyzero.com>
 <CA+sos79twXY1fC8kqrORJvDbXv9Lvu6SjY05N7VFcRcOEKx7LA@mail.gmail.com>
 <5871EAD1-2BC3-4236-B008-76822A51F422@latencyzero.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f176.google.com (mail-ob0-f176.google.com
 [209.85.214.176])
 by alsa0.perex.cz (Postfix) with ESMTP id 1A27D2605C1
 for <alsa-devel@alsa-project.org>; Tue, 29 Sep 2015 21:31:36 +0200 (CEST)
Received: by obbda8 with SMTP id da8so14161884obb.1
 for <alsa-devel@alsa-project.org>; Tue, 29 Sep 2015 12:31:35 -0700 (PDT)
In-Reply-To: <5871EAD1-2BC3-4236-B008-76822A51F422@latencyzero.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Rick Mann <rmann@latencyzero.com>
Cc: Alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

RGVhciBSaWNrIE1hbm4sCgpPbiBUdWUsIFNlcCAyOSwgMjAxNSBhdCA5OjIxIFBNLCBSaWNrIE1h
bm4gPHJtYW5uQGxhdGVuY3l6ZXJvLmNvbT4gd3JvdGU6Cj4+IE9uIFNlcCAyOSwgMjAxNSwgYXQg
MTE6NDcgLCBCZW5vw650IFRow6liYXVkZWF1IDxiZW5vaXQudGhlYmF1ZGVhdS5kZXZAZ21haWwu
Y29tPiB3cm90ZToKPj4gT24gVHVlLCBTZXAgMjksIDIwMTUgYXQgMTI6MzggUE0sIFJpY2sgTWFu
biA8cm1hbm5AbGF0ZW5jeXplcm8uY29tPiB3cm90ZToKPj4gTm90aGluZyBzaG91bGQgYmUgZG9u
ZSBmb3IgdGhlc2UgcmVnaXN0ZXJzIG9uIDMxMDQsIG5vdCBldmVuIHNldHRpbmcKPj4gdGhlbSB0
byAwLiBUaGUgZGF0YXNoZWV0IHNheXMgIkRvIG5vdCB3cml0ZSB0byB0aGlzIHJlZ2lzdGVyLiIu
Cj4KPiBJbmRlZWQsIGl0IGRvZXMgc2F5IHRoYXQuIEknbGwgY2hhbmdlIHRoZSBjb2RlLgo+Cj4g
SG93ZXZlciwgaXQgYWxzbyBzYXlzIG5vdCB0byB3cml0ZSBjZXJ0YWluIGJpdHMgd2l0aGluIGEg
cmVnaXN0ZXIsIHdoaWNoIGlzIGltcG9zc2libGUgKGUuZy4gVGFibGUgODgsIFJlZ2lzdGVyIDg2
LCBiaXQgRDIsICJSZXNlcnZlZC4gRG8gbm90IHdyaXRlIHRvIHRoaXMgcmVnaXN0ZXIgYml0LiIp
LgoKVGhpcyBpcyBqdXN0IGEgYnVnIHJlc3VsdGluZyBmcm9tIGEgY29weS9wYXN0ZSBpbiB0aGUg
ZGF0YXNoZWV0LCBidXQKdGhlIGlkZWEgaXMgY2xlYXI6IGRvIG5vdCB0b3VjaCByZXNlcnZlZCBp
dGVtcyB3aGVuIHlvdSBjYW4gYXZvaWQKZG9pbmcgc28uIFRoaXMgYml0IGlzIGV2ZW4gcmVhZC1v
bmx5IGJlc2lkZXMgYmVpbmcgcmVzZXJ2ZWQsIHNvCndyaXRpbmcgaXQgY2FuJ3QgYmUgaGFybWZ1
bC4gVGhlIGdlbmVyYWwgcnVsZSBmb3Igc2ltaWxhciBiaXRzIHRoYXQKYXJlIHdyaXRhYmxlIGFu
ZCByZXNlcnZlZCBpcyBlaXRoZXIgdG8gd3JpdGUgdGhlbSB0byAwIG9yIHRvIGxlYXZlCnRoZW0g
dW5jaGFuZ2VkIHdoZW4gd3JpdGluZyB0aGUgb3RoZXIgYml0cyBvZiB0aGUgcmVnaXN0ZXIsIGRl
cGVuZGluZwpvbiB0aGUgY2hpcCBhbmQgcmVnaXN0ZXJzLgoKQmVzdCByZWdhcmRzLApCZW5vw650
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkFsc2EtZGV2
ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1h
bi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
