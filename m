From: Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: [PATCHES] Integrate minimal systemd support in
	alsa-utils
Date: Wed, 24 Nov 2010 11:50:28 +0100
Message-ID: <AANLkTinENtJ8dhdmRAc9yd1Ef9Xt9D-dA4Rqc_BPd2Em@mail.gmail.com>
References: <20101123021657.GA17275@tango.0pointer.de>
	<s5h4ob8r2dz.wl%tiwai@suse.de>
	<AANLkTikbP_yRSDWD1DL0EKza=EpRdnDHLpUMhoXVnDiE@mail.gmail.com>
	<s5h1v6bp9dv.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yx0-f179.google.com (mail-yx0-f179.google.com
	[209.85.213.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 64097245CB
	for <alsa-devel@alsa-project.org>; Wed, 24 Nov 2010 11:50:45 +0100 (CET)
Received: by yxf34 with SMTP id 34so1476192yxf.38
	for <alsa-devel@alsa-project.org>; Wed, 24 Nov 2010 02:50:45 -0800 (PST)
In-Reply-To: <s5h1v6bp9dv.wl%tiwai@suse.de>
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
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>, jkysela@redhat.com, Lennart Poettering <mznyfn@0pointer.de>
List-Id: alsa-devel@alsa-project.org

T24gV2VkLCBOb3YgMjQsIDIwMTAgYXQgMDY6NDAsIFRha2FzaGkgSXdhaSA8dGl3YWlAc3VzZS5k
ZT4gd3JvdGU6Cj4gQXQgVHVlLCAyMyBOb3YgMjAxMCAxODowNTowMCArMDEwMCwgS2F5IFNpZXZl
cnMgd3JvdGU6Cgo+PiBOb3cgdGhhdCBib3RoIGlzIG1lcmdlZCwgbWluZCBwdXR0aW5nIHRoYXQg
aW4gb3BlblNVU0UgRmFjdG9yeT8KPgo+IFN1cmUuIMKgQSBmZXcgcXVlc3Rpb25zLCB0aG91Z2g6
Cj4KPj4gV2UgbmVlZCB0byBlbmFibGUgc3lzdGVtZCBzZXJ2aWNlcyB3aXRoOgo+PiDCoCAtLXdp
dGgtc3lzdGVtZHN5c3RlbXVuaXRkaXI9L2xpYi9zeXN0ZW1kL3N5c3RlbQo+Pgo+PiBsaXN0IHRo
ZSBmaWxlcy9kaXJzIGluOgo+PiDCoCAvbGliL3N5c3RlbWQvc3lzdGVtLyouc2VydmljZQo+PiDC
oCAvbGliL3VkZXYvcnVsZXMuZC8qLnJ1bGVzCj4KPiBUaGVzZSBjb21lIGZyb20gYWxzYS11dGls
cywgb2J2aW91c2x5LiDCoEJ1dCBhbHNhLnJwbSByZXF1aXJlcwo+IGFsc2EtdXRpbHMsIHNvIHRo
aXMgc2hvdWxkIGJlIE9LLgoKRmluZS4KCj4+IERyb3AgdGhlIGN1cnJlbnQgY3VzdG9tIHVkZXYg
cnVsZToKPj4gwqAgL2V0Yy91ZGV2L3J1bGVzLmQvNDAtYWxzYS5ydWxlcwo+PiBhbmQgdXNlIG9u
bHkgdGhlIHN5c3RlbWQgb25lIGluIC9saWIvdWRldi8uIEl0IHNob3VsZCB3b3JrIGFsc28gZm9y
Cj4+IG5vbi1zeXN0ZW1kIHNldHVwcy4KPgo+IERvIHlvdSBtZWFuIEkgY29weSBzeXN0ZW1kJ3Mg
cnVsZXMgZmlsZSB0byBhbHNhLnJwbS4uLj8KCkNhbid0IHdlIGp1c3QgbGV0IHRoZW0gZ2V0IGlu
c3RhbGxlZCBmcm9tIGFsc2EtdXRpbHMucnBtPwpBbmQgZHJvcCB0aGUgY3VycmVudCBydWxlIGZy
b20gYWxzYS5ycG0/Cgo+IFdlIG5lZWQgYSBydWxlcyBmaWxlIGZvciBub24tc3lzdGVtZCAoaS5l
LiB3aXRob3V0IHN5c3RlbWQucnBtKSwgc28KPiBzb21lb25lIHN0aWxsIG5lZWRzIHRvIHByb3Zp
ZGUgYSB1ZGV2IHN0dWZmIGZvciBzb3VuZCwgSSBzdXBwb3NlPwoKT2gsIHdlIGp1c3QgZW5hYmxl
IC0td2l0aC1zeXN0ZW1kIGFuZCBpbnN0YWxsIHRoZSBzeXN0ZW1kIGZpbGVzIGFuZAp1ZGV2IHJ1
bGVzIHVuY29uZGl0aW9uYWxseSwgdGhleSBkb24ndCBwdWxsIHN5c3RlbWQucnBtIGluLCB0aGUK
c3lzdGVtZCBmaWxlcyB3aWxsIGpzdXQgYmUgaWdub3JlZCBvbiBTWVNWIGJveGVzLCBidXQgdGhl
IHVkZXYgcnVsZQp3aWxsIHN0aWxsIGJlIHVzZWQuIFRoYXQgc2hvdWxkIHdvcmsgYW5kIGlzIGhv
dyBpdCB1c3VhbGx5IHdvcmtzLgoKS2F5Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1w
cm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlzdGlu
Zm8vYWxzYS1kZXZlbAo=
