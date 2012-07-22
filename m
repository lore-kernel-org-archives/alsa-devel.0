From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Immediate underrun with PulseAudio ALSA plugin
 when PA and ALSA buffer sizes differ
Date: Sun, 22 Jul 2012 08:34:26 +0800
Message-ID: <CAN8cciag_07kB_FbcV6niuJfbgTXkvQXXXcL2rTGQcG+ds8u9Q@mail.gmail.com>
References: <CAN8ccibduuRoPH1yFVWCbaoV2vqVMJHutmfj=E8DT9xBbAXuyA@mail.gmail.com>
 <5005049C.5000806@canonical.com>
 <1342502963.14027.24.camel@localhost>
 <20120718221439.GA2875@flim.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-we0-f179.google.com (mail-we0-f179.google.com
 [74.125.82.179])
 by alsa0.perex.cz (Postfix) with ESMTP id F2DAF264EFC
 for <alsa-devel@alsa-project.org>; Sun, 22 Jul 2012 02:34:24 +0200 (CEST)
Received: by weyx10 with SMTP id x10so3213848wey.38
 for <alsa-devel@alsa-project.org>; Sat, 21 Jul 2012 17:34:27 -0700 (PDT)
In-Reply-To: <20120718221439.GA2875@flim.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>, pulseaudio-discuss@lists.freedesktop.org, alsa-devel@alsa-project.org, David Henningsson <david.henningsson@canonical.com>, Arun Raghavan <arun.raghavan@collabora.co.uk>
List-Id: alsa-devel@alsa-project.org

MjAxMi03LTE5IOS4iuWNiDY6MTQg5pa8ICJNYXR0aGV3IEdyZWdhbiIgPGtpbmV0aWtAZmxpbS5v
cmc+IOWvq+mBk++8mgo+Cj4KPiBObywgaXQncyBqdXN0IGEgcmFuZG9tIHZhbHVlIGZvciBtZWRp
YSBwbGF5YmFjay4gIEluIGFuIG9sZGVyIHZlcnNpb24gb2YKdGhlCj4gYXVkaW8gYmFja2VuZCB3
ZSdyZSB1c2luZyBpbiBGaXJlZm94ICh3aGljaCB3YXMgcHVzaCByYXRoZXIgdGhhbiBwdWxsCj4g
YmFzZWQpLCB3ZSB1c2VkIDUwMG1zIGFuZCBoYWRuJ3QgcnVuIGludG8gdGhpcyBwcm9ibGVtIGlu
IGEgd2F5IHRoYXQgd2FzCj4gb2J2aW91cyB0byB1c2VycyAoaS5lLiBjYXVzaW5nIGJyb2tlbiBw
bGF5YmFjaykuICBJIGNob3NlIGEgbG93ZXIgbGF0ZW5jeQo+IGZvciBtZWRpYSBwbGF5YmFjayBp
biB0aGUgbmV3IGJhY2tlbmQgaW4gYW4gYXR0ZW1wdCB0byBmbHVzaCBvdXQgYnVncwpiZWZvcmUK
PiB3ZSBpbnRyb2R1Y2UgZmVhdHVyZXMgdGhhdCBkZW1hbmQgbG93IGxhdGVuY3kgKHN1Y2ggYXMg
V2ViUlRDKS4KPgo+ID4gQ291bGQgeW91IGNsYXJpZnkgd2hhdCB2ZXJzaW9ucyBvZiBQdWxzZUF1
ZGlvIGFuZCBhbHNhLXBsdWdpbnMKPiA+IHlvdSdyZSB1c2luZz8gVGhlIGxhdGVzdCBpbXByb3Zl
bWVudCB0byB0aGlzIGhhbmRsaW5nIHdhcyBkb25lIGxlc3MKPiA+IHRoYW4gYSB5ZWFyIGFnbyBh
bmQgbWlnaHQgcmVxdWlyZSB0aGUgbGF0ZXN0IHZlcnNpb25zIG9mIHRoZXNlCj4gPiBjb21wb25l
bnRzLgo+Cj4gSSdtIHVzaW5nIEZlZG9yYSAxNywgd2hpY2ggaGFzIGFsc2EtcGx1Z2lucy1wdWxz
ZWF1ZGlvLTEuMC4yNS0zLmZjMTcgYW5kCj4gcHVsc2VhdWRpby0xLjEtOS5mYzE3LiAgVGhpcyB3
YXMgb3JpZ2luYWxseSBkaXNjb3ZlcmVkIGJ5IHVzZXJzIHJ1bm5pbmcKPiBBTFNBIDEuMC4yNSBv
biB2YXJpb3VzIGRpc3Ryb3MgKFVidW50dSAxMi4wNCBMVFMgYW5kIEFyY2gpLiAgVHdvIG9mIHRo
ZW0KPiBoYXBwZW5lZCB0byBoYXZlIGEgUEEgc2VydmVyIHdoZXJlIHRoZSBsYXRlbmN5IGhhZCBj
cmVwdCB1cCBvdmVyIHRpbWUsCmFuZCBhCj4gdGhpcmQgd2FzIHJ1bm5pbmcgdGhlIHNlcnZlciB3
aXRoIHRzY2hlZD0wIG9uIGFuIEF1ZGlneSBTRSAoQ0EwMTA2KSB3aXRoIGEKPiBtaW5pbXVtIGxh
dGVuY3kgb2YgMjAwbXMuCj4KCndpdGhvdXQgdXNpbmcgYWRqdXN0IGxhdGVuY3kgbW9kZSwgcGEg
c2VydmVyIHVzZSBtYXhpbXVtIGJ1ZmZlciBzaXplIGJ5CmRlZmF1bHQgYW5kIGxhdGVuY3kgaXMg
Zml4ZWQgYXQgYWJvdXQgMzQwbXMgZm9yIGNhMDEwNiB3aGljaCBkb2VzIG5vdApzdXBwb3J0IDQ0
MTAwaHouCgpzbyB0aGlzIGlzIGluY29ycmVjdCBmb3IgcHVsc2UgcGx1Z2luIHRvIGFjY2VwdCAy
MDBtcywgaW4gcHJldmlvdXMgdmVyc2lvbgpvZiBwdWxzZWF1ZGlvIHlvdSBjYW4gc3BlY2lmeSB0
aGUgZnJhZ21lbnQgdGltZSBhbmQgdGhlIG51bWJlciBvZiBmcmFnbWVudHMKdG8gYWNoaWV2ZSBs
b3cgbGF0ZW5jeS4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0
dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVs
Cg==
