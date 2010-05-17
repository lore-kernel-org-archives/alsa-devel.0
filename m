From: Jassi Brar <jassisinghbrar@gmail.com>
Subject: Re: [PATCH 1/3] add API to allow disabling period
	interrupts
Date: Mon, 17 May 2010 20:27:34 +0900
Message-ID: <AANLkTimzbkgLopAzthKsrLPbv7IyK6fOgz8sNwZKMDU3@mail.gmail.com>
References: <h2l6160a5131004291538w6c7891fbn2db3425846aefd60@mail.gmail.com>
	<4BDABDDD.4050502@ladisch.de>
	<w2s6160a5131004300644o3aedd30bvf0d13a7f9e758575@mail.gmail.com>
	<s5hsk5uq4u4.wl%tiwai@suse.de>
	<AANLkTiljN2IuWnI1g3BsVux33VcnMeCAwBZl7kexDPvU@mail.gmail.com>
	<AANLkTil6ftaJ_wC--Tsq4pxPDAg9zmISstHuTvCWc_pk@mail.gmail.com>
	<4BF1086F.9070900@ladisch.de> <4BF108E9.5020705@ladisch.de>
	<AANLkTilWrR_EQ-ma10q4DmG7ueuXuiVF25KgVEmGAocR@mail.gmail.com>
	<4BF12593.3040001@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51]) by alsa0.perex.cz (Postfix) with ESMTP id F2B5B24343
	for <alsa-devel@alsa-project.org>;
	Mon, 17 May 2010 13:27:35 +0200 (CEST)
Received: by vws14 with SMTP id 14so3082238vws.38
	for <alsa-devel@alsa-project.org>; Mon, 17 May 2010 04:27:35 -0700 (PDT)
In-Reply-To: <4BF12593.3040001@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Takashi Iwai <tiwai@suse.de>, pl bossart <bossart.nospam@gmail.com>, General PulseAudio Discussion <pulseaudio-discuss@mail.0pointer.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

T24gTW9uLCBNYXkgMTcsIDIwMTAgYXQgODoxNiBQTSwgQ2xlbWVucyBMYWRpc2NoIDxjbGVtZW5z
QGxhZGlzY2guZGU+IHdyb3RlOgo+IEphc3NpIEJyYXIgd3JvdGU6Cj4+IEkgYW0gaW4gZmF2b3Ig
b2Ygc3VwcG9ydCB2YXJpYWJsZSBod19pbnRlcnJ1cHQgYXQgbG93ZXN0IGxldmVsLCBpLmUsIGlu
Cj4+IHJpbmcgYnVmZmVyIGRyaXZlciwgaW5zdGVhZCBvZiBkaXNhYmxpbmcgaHdfaW50ZXJydXB0
IGFsdG9nZXRoZXIuCj4KPiBSZW1vdmluZyB0aGUgY29uc3RhbnQtc2l6ZWQgcGVyaW9kcyByZXN0
cmljdGlvbiB3b3VsZCBjZXJ0YWlubHkgYmUKPiB1c2VmdWwuIMKgSG93ZXZlciwgaXQgZG9lc24n
dCBsb29rIGFzIGlmIGFueWJvZHkgaGFzIHRoZSB0aW1lIHRvIHJlZGVzaWduCj4gdGhlIEFMU0Eg
QVBJLCB0aGUga2VybmVsIGZyYW1ld29yayBhbmQgYWxsIHRoZSBkcml2ZXJzLgpObyBuZWVkIHRv
IHJlZGVzaWduIEFMU0EgQVBJIGFuZCBjZXJ0YWlubHkgbm8gbmVlZCB0byBjaGFuZ2UgX2FueV8g
ZHJpdmVyLApqdXN0IGxpa2UgdGhpcyBpbnRlcnJ1cHQgZGlzYWJsZSBjYWxsIGlzIG9wdGlvbmFs
IHNvIHdvdWxkIHBlcmlvZCByZXNpemUgYmUuCgpJIG9ubHkgYXNrIHRvIG1ha2UgdGhpcyBuZXds
eSBhZGRlZCBjYWxsIGFzIHBlcmlvZC1yZXNpemUgcmF0aGVyIHRoYW4KYSBzcGVjaWFsIGNhc2Ug
b2YgcGVyaW9kLWRpc2FibGUuCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0
Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxz
YS1kZXZlbAo=
