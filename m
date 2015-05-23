From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [V2 PATCH] ALSA: hda - Enable mute/mic-mute LEDs
 for more Thinkpads with Conexant codec
Date: Sun, 24 May 2015 00:06:54 +0800
Message-ID: <CAN8cciZYZ4setSj7dgPqQUVrBrr98tSvofLrD_0zvyQqkWfd2Q@mail.gmail.com>
References: <1385534846-20829-1-git-send-email-hui.wang@canonical.com>
 <53AFF992.5030403@web.de> <53B0C596.6090007@canonical.com>
 <53B1078B.4090101@web.de> <53B219DF.6090807@canonical.com>
 <53B26575.1000003@web.de> <53B27ED7.4070401@canonical.com>
 <53B50062.30200@web.de> <53B51B63.8060809@canonical.com>
 <53B51CF3.8090102@web.de> <53B52146.9050300@canonical.com>
 <55603F22.8070103@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f51.google.com (mail-oi0-f51.google.com
 [209.85.218.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 3FD1C2604B0
 for <alsa-devel@alsa-project.org>; Sat, 23 May 2015 18:06:56 +0200 (CEST)
Received: by oihb142 with SMTP id b142so33410413oih.3
 for <alsa-devel@alsa-project.org>; Sat, 23 May 2015 09:06:55 -0700 (PDT)
In-Reply-To: <55603F22.8070103@web.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jan Kiszka <jan.kiszka@web.de>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>, Hui Wang <jason77.wang@gmail.com>, tiwai@suse.de, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Hui Wang <hui.wang@canonical.com>, alex.hung@canonical.com, yk@canonical.com, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, david.henningsson@canonical.com
List-Id: alsa-devel@alsa-project.org

MjAxNS01LTIzIOS4i+WNiDQ6NTAg5pa8ICJKYW4gS2lzemthIiA8amFuLmtpc3prYUB3ZWIuZGU+
IOWvq+mBk++8mgo+Cj4gPj4+Pj4+Pj4+Pj4gTW9zdCBUaGlua3BhZCBFZGdlIHNlcmllcyBsYXB0
b3BzIHVzZSBjb25leGFudCBjb2RlYywgc28gZmFyCj4gPj4+Pj4+Pj4+Pj4gYWx0aG91Z2gKPiA+
Pj4+PiA8c25pcD4KPiA+Pj4+Pj4+PiBJcyB0aGVyZSBhbnl0aGluZyBJIGNhbiBkZWJ1ZyBvciBh
bnkgaW5mb3JtYXRpb24gSSBjYW4gY29sbGVjdAo+ID4+Pj4+Pj4+IGZyb20gbXkKPiA+Pj4+Pj4+
PiBib3ggdG8gZXhhbWluZSB0aGlzPwo+ID4+Pj4+Pj4gV2hhdCBpcyB0aGUgbGludXggZGlzdHJp
YnV0aW9uIG9uIHlvdXIgbWFjaGluZT8gQW5kIHVzZSBzaG93a2V5IHRvCj4gPj4+Pj4+PiBjYXRj
aAo+ID4+Pj4+Pj4gdGhlIGtleWNvZGUgb2YgdGhhdCBidXR0b24uCj4gPj4+Pj4+IEknbSBydW5u
aW5nIE9wZW5TVVNFIDEzLjEuIFRoZSByZXBvcnRlZCBrZXljb2RlIG9mIHRoZSBwb3dlcgo+ID4+
Pj4+PiBidXR0b24gaXMKPiA+Pj4+Pj4gMTE2Lgo+ID4+Pj4+IEl0IHNlZW1zIHRoZSBrZXljb2Rl
IGlzIGNvcnJlY3QsIGl0IGlzIHBvd2VyIGtleWNvZGUgcmF0aGVyIHRoZSBtdXRlCj4gPj4+Pj4g
a2V5Y29kZS4KPiA+Pj4+Pgo+ID4+Pj4+IENvdWxkIHlvdSBwbGVhc2UgZG8gc29tZSBkZWJ1Zywg
bGV0IHVzIGZpbmQgd2hpY2ggbGluZSBvZiBjb2RlIGlzCnRoZQo+ID4+Pj4+IHJvb3QgY2F1c2Ug
Zm9yIHRoaXMgcHJvYmxlbS4gZm9yIGV4YW1wbGU6Cj4gPj4+Pj4KPiA+Pj4+PiBhZnRlciBydW5u
aW5nIHRoZSBsaW5lLCB0aGUgcHJvYmxlbSBzaG93cyB1cDoKPiA+Pj4+Pgo+ID4+Pj4+IDEuICAg
ICBpZiAoQUNQSV9TVUNDRVNTKGFjcGlfZ2V0X2RldmljZXMoIkxFTjAwNjgiLCBhY3BpX2NoZWNr
X2NiLAo+ID4+Pj4+ICZmb3VuZCwgTlVMTCkpICYmIGZvdW5kKSAvLyBpbiB0aGUgc291bmQvcGNp
L2hkYS90aGlua3BhZF9oZWxwZXIuYywKPiA+Pj4+PiBpc190aGlua3BhZCgpCj4gPj4+PiBUaGlz
IGV2YWx1YXRlcyB0byB0cnVlCj4gPj4+Pgo+ID4+Pj4+IDIuICAgICByZXR1cm4gQUNQSV9TVUND
RVNTKGFjcGlfZ2V0X2RldmljZXMoIklCTTAwNjgiLAphY3BpX2NoZWNrX2NiLAo+ID4+Pj4+ICZm
b3VuZCwgTlVMTCkpICYmIGZvdW5kOyAvLyBzYW1lIGFzIGFib3ZlCj4gPj4+Pj4KPiA+Pj4+PiAz
LiAgICAgICAgIGlmIChsZWRfc2V0X2Z1bmMoVFBBQ1BJX0xFRF9NVVRFLCBmYWxzZSkgPj0gMCkg
eyAvL2luIHRoZQo+ID4+Pj4+IHNvdW5kL3BjaS9oZGEvdGhpbmtwYWRfaGVscGVyLmMsIGhkYV9m
aXh1cF90aGlua3BhZF9hY3BpKCkKPiA+Pj4+IC4uLmFuZCB0aGlzCj4gPj4+Pgo+ID4+Pj4+IDQu
IGlmIChsZWRfc2V0X2Z1bmMoVFBBQ1BJX0xFRF9NSUNNVVRFLCBmYWxzZSkgPj0gMCkgeyAvLyBz
YW1lIGFzCj4gPj4+Pj4gYWJvdmUKPiA+Pj4+Pgo+ID4+Pj4gLi4uYW5kIHRoaXMgYXMgd2VsbC4g
c3BlYy0+bnVtX2FkY19uaWRzIGlzIDEuCj4gPj4+Cj4gPj4+IElmIHdlIGNoYW5nZSB0aGUgY29k
ZSBsaWtlIGJlbG93LCBkb2VzIHRoZSBwb3dlciBidXR0b24gY2FuIHdvcmsgd2VsbD8KPiA+Pj4K
PiA+Pj4gaW4gdGhlIHRoaW5rcGFkX2hlbHBlci5jLCBoZGFfZml4dXBfdGhpbmtwYWRfYWNwaSgp
Cj4gPj4+Cj4gPj4+Cj4gPj4+ICAgICAgICAgIGlmIChsZWRfc2V0X2Z1bmMoVFBBQ1BJX0xFRF9N
VVRFLCBmYWxzZSkgPj0gMCkgewo+ID4+PiAgICAgICAgICAgICAgLyoKPiA+Pj4gICAgICAgICAg
ICAgIG9sZF92bWFzdGVyX2hvb2sgPSBzcGVjLT52bWFzdGVyX211dGUuaG9vazsKPiA+Pj4gICAg
ICAgICAgICAgIHNwZWMtPnZtYXN0ZXJfbXV0ZS5ob29rID0gdXBkYXRlX3RwYWNwaV9tdXRlX2xl
ZDsKPiA+Pj4gICAgICAgICAgICAgIHJlbW92ZWZ1bmMgPSBmYWxzZTsKPiA+Pj4gICAgICAgICAg
ICAgKi8KPiA+PiBEaXNhYmxpbmcgb25seSB0aGlzIGJsb2NrIHJlc29sdmVzIHRoZSBpc3N1ZS4K
PiA+Cj4gPiBTbyBCZWxvdyB0d28gbGluZXMgbWFrZSB0aGUgcG93ZXIgYnV0dG9uIGNoYW5nZSB0
byB0aGUgcmVzZXQgYnV0dG9uLgo+ID4KPiA+IGRyaXZlcnMvcGxhdGZvcm0veDg2L3RoaW5rcGFk
X2FjcGkuYyAgbXV0ZV9sZWRfb25fb2ZmKCk6Cj4gPgo+ID4gYWNwaV9nZXRfaGFuZGxlKGhrZXlf
aGFuZGxlLCAiU1NNUyIsICZ0ZW1wKTsKPiA+IGFjcGlfZXZhbGYoaGtleV9oYW5kbGUsICZvdXRw
dXQsICJTU01TIiwgImRkIiwgMSk7Cj4gPgo+ID4KPiA+IEBhbGV4aHVuZywKPiA+IERvIHlvdSBo
YXZlIGFueSBpZGVhIHdoeSB0aGlzIGNhbiBhZmZlY3QgdGhlIHBvd2VyIGJ1dHRvbiBiZWhhdmlv
cj8KPiA+Cj4KPiBJIHRoaW5rIHdlIGFsbCBsb3N0IHRyYWNrIG9mIHRoaXMgaXNzdWUsIGJ1dCBp
dCB1bmZvcnR1bmF0ZWx5IHN0aWxsCj4gZXhpc3RzIGluIHRoZSBsYXRlc3Qga2VybmVsLCByZXF1
aXJpbmcgY3VzdG9tIGJ1aWxkcyBoZXJlLiBIb3cgY2FuIHdlCj4gcHJvY2VlZD8KCmh0dHA6Ly9t
YWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvcGlwZXJtYWlsL2Fsc2EtZGV2ZWwvMjAxNS1NYXkvMDkx
NTYxLmh0bWwKCklmIHlvdSBjYW5ub3QgZmluZCAiU1NNUyIgaW4gIHlvdXIgVDUyMCBBQ1BJIGR1
bXAsIHRoaXMgbWVhbiBtdXRlIExFRApjYW5ub3QgYmUgdHVybiBvbi9vZmYgc2ltaWxhciB0byBU
NTEwCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkFsc2Et
ZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFp
bG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
