From: Mike Frysinger <vapier.adi@gmail.com>
Subject: Re: [Uclinux-dist-devel] [PATCH 2/5] ASoC codec:
	SSM2602: assign last substream to the master when shutting down
Date: Sat, 13 Jun 2009 06:10:30 -0400
Message-ID: <8bd0f97a0906130310g759797dbif288cd2c1a0d1e12@mail.gmail.com>
References: <1243916337-29953-1-git-send-email-vapier@gentoo.org>
	<1243916337-29953-2-git-send-email-vapier@gentoo.org>
	<20090603105223.GE11507@sirena.org.uk>
	<8bd0f97a0906030537y1e65aa7atec4b0c5cdf4ae2f@mail.gmail.com>
	<20090603145316.GA7315@rakim.wolfsonmicro.main>
	<8bd0f97a0906031826j647efa0bs1ffb6492cfd0ccd8@mail.gmail.com>
	<20090604085921.GD6983@rakim.wolfsonmicro.main>
	<ea2442770906130237s72ff15b3n1168eb3392231149@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yw-out-1718.google.com (yw-out-1718.google.com [74.125.46.152])
	by alsa0.perex.cz (Postfix) with ESMTP id E9F6C243EA
	for <alsa-devel@alsa-project.org>;
	Sat, 13 Jun 2009 12:10:50 +0200 (CEST)
Received: by yw-out-1718.google.com with SMTP id 4so1329557ywq.2
	for <alsa-devel@alsa-project.org>; Sat, 13 Jun 2009 03:10:50 -0700 (PDT)
In-Reply-To: <ea2442770906130237s72ff15b3n1168eb3392231149@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Karl Beldan <karl.beldan@gmail.com>, Takashi Iwai <tiwai@suse.de>
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Cliff Cai <cliff.cai@analog.com>
List-Id: alsa-devel@alsa-project.org

T24gU2F0LCBKdW4gMTMsIDIwMDkgYXQgMDU6MzcsIEthcmwgQmVsZGFuIHdyb3RlOgo+IE9uIFRo
dSwgSnVuIDQsIDIwMDkgYXQgMTA6NTkgQU0sIE1hcmsKPiBCcm93bjxicm9vbmllQG9wZW5zb3Vy
Y2Uud29sZnNvbm1pY3JvLmNvbT4gd3JvdGU6Cj4+IE9uIFdlZCwgSnVuIDAzLCAyMDA5IGF0IDA5
OjI2OjM0UE0gLTA0MDAsIE1pa2UgRnJ5c2luZ2VyIHdyb3RlOgo+Pgo+Pj4gaXQgY291bGQgYmUu
IMKgaSB3YXMgZ29pbmcgYnkgdGhlIGNoYW5nZXMgdGhhdCB3ZXJlbnQgaW4gMi42LjMwLiDCoGkK
Pj4+IHRob3VnaHQgaSBsb29rZWQgZm9yIHByZXZpb3VzIHN1Ym1pc3Npb25zLCBidXQgaSBtdXN0
IGhhdmUgbWlzc2VkCj4+PiBwcmV2aW91cyBhdHRlbXB0cy4gwqBpJ20gbm90IGZhbWlsaWFyIHdp
dGggYWxzYSBzdHVmZiwgc28gaSdtIG5vdAo+Pgo+PiBUaGUgcGF0Y2ggaGFkbid0IHByZXZpb3Vz
bHkgYmVlbiBzZW50IGluIHRoYXQgZm9ybSBidXQgaXQgbG9va3MgbGlrZQo+PiBpdCdzIGF0dGVt
cHRpbmcgdG8gZml4IGEgYnVnIHdoaWNoIGhhZCBoYWQgc29tZSBwcmV2aW91cyBnb2VzIGF0IGZp
eGluZwo+PiBpdCB0aGF0IHJlcXVpcmVkIHVwZGF0ZXMuCj4+Cj4+PiBhbHdheXMgc3VyZSB3aGVu
IGkgbmVlZCB0byBiYW5nIG9uIENsaWZmIHRvIGdldCB0aGluZ3MgZml4ZWQgdXAKPj4+IChjaGFu
Z2VzIHNwbGl0IC8gYmV0dGVyIGNvbW1lbnRzIC8gZXRjLi4uKS4KPj4KPj4gSWYgeW91J3JlIG5v
dCBzdXJlIHRoZXJlJ3MgYSBjYXNlIGZvciBiZXR0ZXIgY2hhbmdlbG9ncyBhdCBsZWFzdCEgOikK
Pj4KPj4+IGlmIGZpeGVzIG1pc3MgYSBtZXJnZSB3aW5kb3csIHRoZW4gdGhhdCdzIGFuIGlzc3Vl
LiDCoGJ1dCBpbiBnZW5lcmFsLAo+Pj4gdXNlcnMgb25seSBzZWUgZml4ZXMgcGVyIHJlbGVhc2Us
IHNvIHNlbmRpbmcgdGhpbmdzIG1vcmUgcXVpY2tseSB0aGVyZQo+Pj4gd291bGRudCByZWFsbHkg
aGVscCA/Cj4+Cj4+IFRoZSBpc3N1ZSBpcyB0aGF0IHRoaW5ncyBhcmUgbWlzc2luZyBtZXJnZSB3
aW5kb3dzIC0gdGhleSdyZSBnZXR0aW5nCj4+IHNlbnQgaW4gYnV0IGlmIHRoZXJlJ3MgYW55IHJl
dmlldyBjb21tZW50cyBhIHJldmlzZWQgdmVyc2lvbiBvZiB0aGUKPj4gcGF0Y2ggaXNuJ3QgZ2V0
dGluZyBwb3N0ZWQgdW50aWwgdGhlIG5leHQgYmF0Y2ggb2Ygc3VibWlzc2lvbnMuIMKgSXQncwo+
PiB0aGVzZSByZXZpc2lvbnMgcmF0aGVyIHRoYW4gdGhlIGluaXRpYWwgc3VibWlzc2lvbnMgdGhh
dCBJJ20gY29uY2VybmVkCj4+IGFib3V0Lgo+Cj4gVGhpcyAtIGY2OTJmY2UgLSBzaG91bGQgbm90
IGhhdmUgcmVhY2hlZCB1cHN0cmVhbSwgaG93IGNvbWUgPwoKaSB3YXMgZ29pbmcgdG8gc2VuZCBh
IHJldmVydCBmb3IgdGhhdCBhbmQgMjU1MmE3MQotbWlrZQpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRl
dmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWls
bWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
