From: jassi brar <jassisinghbrar@gmail.com>
Subject: Re: [PATCH 1/2] ALSA: pcm - Ensure wakeup at each
	periodic interrupt
Date: Thu, 17 Dec 2009 17:21:28 +0900
Message-ID: <1b68c6790912170021x2a7f462en99acc0ffb7480ba2@mail.gmail.com>
References: <1261029602-14407-1-git-send-email-jassisinghbrar@gmail.com>
	<s5hbphyw0a8.wl%tiwai@suse.de>
	<1b68c6790912162331t23ee8c36sb4989b90dc9920c9@mail.gmail.com>
	<s5h7hsmvyea.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f190.google.com (mail-vw0-f190.google.com
	[209.85.212.190])
	by alsa0.perex.cz (Postfix) with ESMTP id 758D0103827
	for <alsa-devel@alsa-project.org>; Thu, 17 Dec 2009 09:21:30 +0100 (CET)
Received: by vws28 with SMTP id 28so554699vws.16
	for <alsa-devel@alsa-project.org>; Thu, 17 Dec 2009 00:21:28 -0800 (PST)
In-Reply-To: <s5h7hsmvyea.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, lrg@slimlogic.co.uk, broonie@opensource.wolfsonmicro.com, Jassi Brar <jassi.brar@samsung.com>
List-Id: alsa-devel@alsa-project.org

T24gVGh1LCBEZWMgMTcsIDIwMDkgYXQgNDo0MyBQTSwgVGFrYXNoaSBJd2FpIDx0aXdhaUBzdXNl
LmRlPiB3cm90ZToKPiBBdCBUaHUsIDE3IERlYyAyMDA5IDE2OjMxOjA4ICswOTAwLAo+IGphc3Np
IGJyYXIgd3JvdGU6Cj4+Cj4+IE9uIFRodSwgRGVjIDE3LCAyMDA5IGF0IDQ6MDIgUE0sIFRha2Fz
aGkgSXdhaSA8dGl3YWlAc3VzZS5kZT4gd3JvdGU6Cj4+ID4gQXQgVGh1LCAxNyBEZWMgMjAwOSAx
NTowMDowMiArMDkwMCwKPj4gPiBqYXNzaXNpbmdoYnJhckBnbWFpbC5jb20gd3JvdGU6Cj4+ID4+
Cj4+ID4+IEZyb206IEphc3NpIEJyYXIgPGphc3NpLmJyYXJAc2Ftc3VuZy5jb20+Cj4+ID4+Cj4+
ID4+IFRoZSBjaGVjayBmb3IgYXQgbGVhc3QgJ2F2YWlsX21pbicgYXZhaWxhYmxlIGRhdGEgYmVm
b3JlIGNhbGxpbmcgd2FrZV91cAo+PiA+PiBkb2Vzbid0IGFsd2F5cyBob2xkIGdvb2QgYXMgaXQg
ZG9lcyBub3QgZ3VhcmFudGVlIGNhbGxiYWNrcyBhdCBlYWNoIHBlcmlvZGljCj4+ID4+IGludGVy
cnVwdC4KPj4gPgo+PiA+IFdlbGwsIGF2YWlsX21pbiBjYW4gYmUgZ3JlYXRlciB0aGFuIHBlcmlv
ZF9zaXplLiDCoEFuZCwgYXZhaWxfbWluIHdvbid0IGJlCj4+ID4gbGVzcyB0aGFuIHBlcmlvZCBz
aXplLgo+PiA+Cj4+ID4gRm9yIGV4YW1wbGUsIHdoZW4gYXZhaWxfbWluID0gMi41IHggcGVyaW9k
X3NpemUsIHRoZSBkcml2ZXIgd2FrZXMgdXAKPj4gPiBpbiBwZXJpb2RzIGxpa2UgMywgMiwgMywg
MiwgLi4uCj4+IGNvcnJlY3QsIGJ1dCBpZiB3ZSBlbnN1cmUgd2FrZV91cCdzIGFmdGVyIGVhY2gg
cGVyaW9kIGFuZCBsZXQgdGhlICdzbGVlcGVycycKPj4gdHJhY2sgaWYgdGhlIGRhdGEgYXZhaWxh
YmxlIGlzIGVub3VnaCBvciBub3QsIHdlIHdpbGwgaGF2ZSBtb3JlIGZpbmUgZ3JhaW5lZAo+PiBj
b250cm9sLgo+PiBUaGUgcG9pbnQgaXM6LSBXYWtpbmcgdXAgX2FmdGVyXyBhdmFpbF9taW4gaXMg
d29ya2luZywgYnV0IGRvZXMgd2FraW5nIHVwIGJlZm9yZQo+PiBhdmFpbF9taW4oYnV0IGF0IHBl
cmlvZCBib3VuZGFyeSkgYnJlYWsgdGhlIHN5c3RlbT8KPgo+IFB1bHNlQXVkaW8gbWF5IGNvbXBs
YWluIDopCkkgbWVhbnQgZWZmZWN0cyBvbiBBTFNBIHN0YXRlLW1hY2hpbmUgd2l0aGluIHRoZSBr
ZXJuZWwuCkZyb20gd2hhdCBpIGhhdmUgc2VlbiwgZXZlcnkgdXNlIG9mIHNsZWVwIGlzIGp1c3Qg
dG8ga2lsbCBzb21lIHRpbWUsCmkuZSwgd2FrZV91cAppcyBub3QgdGFrZW4gYXMgaW5kaWNhdGlv
biBvZiBjb21wbGV0aW9uIG9mIHRoZSBwdXJwb3NlLgoKSWYgeW91IGhhdmUgdGltZSwgY291bGQg
dSBwbGVhc2UgY29uZmlybS9jb3JyZWN0IG15IHVuZGVyc3RhbmRpbmc/ClRoYW5rcy4KCj4+ID4+
IEFuIGV4YW1wbGUgb2Ygc3VjaCBzaXR1YXRpb24gaXMgc25kX3BjbV9saWJfcmVhZDEvd3JpdGUx
IGNvbnN1bWluZyBzb21lIHNwYWNlCj4+ID4+IG9mIHRoZSBwZXJpb2QgYW5kIGdvaW5nIHRvIHNs
ZWVwIGZyb20gd2FpdF9mb3JfYXZhaWxfbWluIHVwb24gc3luY2luZyB3aXRoCj4+ID4+IHRoZSBE
TUEgcG9pbnRlci4gQ2xlYXJseSBqdXN0IHRoZSByZW1haW5kZXIgb2YgcGVyaW9kIHNpemUgaXMg
bmVlZGVkLCBidXQKPj4gPj4gd2FrZV91cCBpcyBjYWxsZWQgb25seSBhZnRlciBfdHdvXyBwZXJp
b2RpYyBpbnRlcnJ1cHRzIGZyb20gdGhhdCBwb2ludC4KPj4gPgo+PiA+IEluIHRoYXQgY2FzZSwg
dGhlIG9yaWdpbmFsIGJlaGF2aW9yIGlzIGNvcnJlY3QuCj4+IGdvaW5nIGJ5IGN1cnJlbnQgaW1w
bGVtZW50YXRpb24sIHRoYXQgaXMgY29ycmVjdCwgYnV0IGlzIHRoYXQgZGVzaXJhYmxlPwo+Cj4g
Q29ycmVjdCA9IHdvcmtpbmcgYXMgZGVzaWduZWQuCj4KPgo+IFRha2FzaGkKPgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcg
bGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9q
ZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
