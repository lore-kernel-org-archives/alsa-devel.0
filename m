From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: ALSA: bebob: Use common error handling code in
 snd_bebob_stream_start_duplex()
Date: Wed, 27 Sep 2017 20:09:31 +0900
Message-ID: <8e2bbd25-d8d0-0d7b-2d4e-daf495bd523f@sakamocchi.jp>
References: <85f95150-9cec-7a53-7692-837ba543e1ec@users.sourceforge.net>
 <541f0f9f-fc87-f65b-bbd8-fec5d45d5d2e@users.sourceforge.net>
 <a1dee732-f5c4-5b35-9f82-553fc8ce430d@sakamocchi.jp>
 <3afecbef-b7ac-a4e8-f439-a351916f05e5@users.sourceforge.net>
 <09bb0e83-01fe-cd12-a084-31db3f12d663@sakamocchi.jp>
 <06a8e3ee-c3c3-b4c7-0cf9-69a2efdaf0ba@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id BA137266DE1
 for <alsa-devel@alsa-project.org>; Wed, 27 Sep 2017 13:09:39 +0200 (CEST)
In-Reply-To: <06a8e3ee-c3c3-b4c7-0cf9-69a2efdaf0ba@users.sourceforge.net>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: SF Markus Elfring <elfring@users.sourceforge.net>, alsa-devel@alsa-project.org
Cc: kernel-janitors@vger.kernel.org, Clemens Ladisch <clemens@ladisch.de>, Takashi Iwai <tiwai@suse.com>, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

T24gU2VwIDI3IDIwMTcgMTU6MzgsIFNGIE1hcmt1cyBFbGZyaW5nIHdyb3RlOgo+PiBBcyBsb25n
IGFzIEkga25vdywgdGhlIGxhc3QgcHJvZHVjdCB3aXRoIHRoaXMgc29sdXRpb24gd2FzIHNoaXBw
ZWQKPj4gYXQgMjAxMC4gVGh1cyB0aGUgZHJpdmVyIGlzIHVuZGVyIG1haW50ZW5hbmNlLgo+IAo+
IFRoYW5rcyBmb3IgeW91ciBpbmZvcm1hdGlvbi4KPiAKPiAKPj4gSSBoYXZlIHNvbWUgdGFza3Mg
Zm9yIHRoaXMgZHJpdmVyIGFzIHdlbGwgYXMgZHJpdmVycyBpbiBBTFNBIGZpcmV3aXJlIHN0YWNr
LAo+PiBob3dldmVyIGJhc2ljYWxseSB0aGlzIGRyaXZlciBpcyB1bmRlciBtYWludGVuYW5jZSBh
bmQgbWlnaHQgbm90IGdldAo+PiBmdXJ0aGVyIGludGVncmF0aW9uLgo+IAo+IEdvb2QgdG8ga25v
dyBpbiBwcmluY2lwbGUg4oCmCj4gCj4gCj4+IEkgdGhpbmsgdGhhdCBjb2RlIGNsZWFudXAgZm9y
IHRoZSBkcml2ZXIgZG9uJ3QgaGVscCB0aGUgb3RoZXIgZGV2ZWxvcGVycy4KPiAKPiBJIHRob3Vn
aHQgaW4gYW4gb3RoZXIgZGlyZWN0aW9uIGlmIG90aGVyIGNvbnRyaWJ1dG9ycyB3b3VsZCBsaWtl
IHRvIGNhcmUKPiBmb3IgbG9uZ2VyIHRlcm0gc3VwcG9ydC4KPiAKPiAKPj4gSXQncyBiZXR0ZXIg
dG8gYXBwbHkgc3VjaCBjbGVhbnVwIHRvIG1vcmUgbG9uZy1saXZlIGNvZGVzIHN1Y2ggYXMKPj4g
Y29yZSBmdW5jdGlvbmFsaXR5IG9mIEFMU0EuCj4gCj4gSSBhbSB0cnlpbmcgYW5vdGhlciBnZW5l
cmFsIHRyYW5zZm9ybWF0aW9uIHBhdHRlcm4gb3V0Lgo+IAo+IAo+PiBJbiB0aGlzIHBvaW50IG9m
IHZpZXcsIHdoZXRoZXIgeW91ciBwYXRjaHNldCBpcyB3b3J0aCB0byBiZSBhcHBsaWVkCj4+IG9y
IG5vdCwgUGxlYXNlIGtlZXAgZW5vdWdoIHRpbWUgdG8gdGhpbmsgYWJvdXQuCj4gCj4gQXV0b21h
dGljIHNvdXJjZSBjb2RlIGFuYWx5c2lzIGNhbiBmaW5kIHZhcmlvdXMgdXBkYXRlIGNhbmRpZGF0
ZXMuCj4gSSBhbSBqdXN0IHVuc3VyZSBpZiBhIGJpdCBtb3JlIHNvZnR3YXJlIGRldmVsb3BtZW50
IGF0dGVudGlvbiBpcyBzdGlsbAo+IGFwcHJvcHJpYXRlIGF0IHNvbWUgcGxhY2VzLgo+IAo+IERv
IHlvdSBmaW5kIGFueSBvZiB0aGUgYWZmZWN0ZWQgc29mdHdhcmUgbW9kdWxlcyBzbyBvdXRkYXRl
ZAo+IHNvIHRoYXQgdGhleSBzaG91bGQgbm90IGJlIHRvdWNoZWQgYW55IG1vcmU/CgpQbGVhc2Ug
ZG9uJ3QgaWdub3JlIHRoZSBwcmFjdGljYWxpdHkgSSd2ZSBleHBsYWluZWQsIGFuZCBkb24ndCAK
YWNjdW11bGF0ZSB5b3VyIHF1ZXN0aW9ucyB3aXRob3V0IGl0LgoKClJlZ2FyZHMKClRha2FzaGkg
U2FrYW1vdG8KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
QWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHA6
Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
