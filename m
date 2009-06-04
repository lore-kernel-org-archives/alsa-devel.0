From: Mike Frysinger <vapier.adi@gmail.com>
Subject: Re: [Uclinux-dist-devel] [PATCH 2/5] ASoC codec:
	SSM2602: assign last substream to the master when shutting down
Date: Wed, 3 Jun 2009 21:26:34 -0400
Message-ID: <8bd0f97a0906031826j647efa0bs1ffb6492cfd0ccd8@mail.gmail.com>
References: <1243916337-29953-1-git-send-email-vapier@gentoo.org>
	<1243916337-29953-2-git-send-email-vapier@gentoo.org>
	<20090603105223.GE11507@sirena.org.uk>
	<8bd0f97a0906030537y1e65aa7atec4b0c5cdf4ae2f@mail.gmail.com>
	<20090603145316.GA7315@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yw-out-1718.google.com (yw-out-1718.google.com [74.125.46.155])
	by alsa0.perex.cz (Postfix) with ESMTP id 06C571037F7
	for <alsa-devel@alsa-project.org>;
	Thu,  4 Jun 2009 03:26:35 +0200 (CEST)
Received: by yw-out-1718.google.com with SMTP id 4so201279ywq.2
	for <alsa-devel@alsa-project.org>; Wed, 03 Jun 2009 18:26:34 -0700 (PDT)
In-Reply-To: <20090603145316.GA7315@rakim.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org, Cliff Cai <cliff.cai@analog.com>
List-Id: alsa-devel@alsa-project.org

T24gV2VkLCBKdW4gMywgMjAwOSBhdCAxMDo1MywgTWFyayBCcm93biB3cm90ZToKPiBPbiBXZWQs
IEp1biAwMywgMjAwOSBhdCAwODozNzo1NEFNIC0wNDAwLCBNaWtlIEZyeXNpbmdlciB3cm90ZToK
Pj4gT24gV2VkLCBKdW4gMywgMjAwOSBhdCAwNjo1MiwgTWFyayBCcm93biB3cm90ZToKPj4gPiBI
b3dldmVyLCBnaXZlbiB0aGF0IHRoaXMgZml4IGhhcyBtaXNzZWQgdHdvIGtlcm5lbCByZWxlYXNl
cyBkdWUgdG8gdGhlCj4+ID4gdmVyeSBzbG93IHJhdGUgb2YgcmVzcG9uc2VzIHRvIHJldmlldyBj
b21tZW50cyBJJ3ZlIGFwcGxpZWQgaXQgc28gdXNlcnMKPj4gPiBnZXQgdGhlIGJlbmVmaXQgb2Yg
dGhlIGJ1ZyBmaXguCj4+IG5vdCBzdXJlIHdoYXQgeW91J3JlIHJlZmVycmluZyB0bwo+Cj4gVGhp
cyBsb29rcyBsaWtlIGEgcmVzcGluIG9mIGEgZml4IHdoaWNoIHdhcyBvcmlnaW5hbGx5IHN1Ym1p
dHRlZCBiYWNrIGluCj4gMi42LjI5IGVyYSBvciBzby4gwqBJSVJDIHRoZXJlJ3MgYmVlbiB0d28g
b3IgdGhyZWUgdmVyc2lvbnMsIGVhY2ggb2YKPiB3aGljaCBuZWVkZWQgZml4ZXMuCgppdCBjb3Vs
ZCBiZS4gIGkgd2FzIGdvaW5nIGJ5IHRoZSBjaGFuZ2VzIHRoYXQgd2VyZW50IGluIDIuNi4zMC4g
IGkKdGhvdWdodCBpIGxvb2tlZCBmb3IgcHJldmlvdXMgc3VibWlzc2lvbnMsIGJ1dCBpIG11c3Qg
aGF2ZSBtaXNzZWQKcHJldmlvdXMgYXR0ZW1wdHMuICBpJ20gbm90IGZhbWlsaWFyIHdpdGggYWxz
YSBzdHVmZiwgc28gaSdtIG5vdAphbHdheXMgc3VyZSB3aGVuIGkgbmVlZCB0byBiYW5nIG9uIENs
aWZmIHRvIGdldCB0aGluZ3MgZml4ZWQgdXAKKGNoYW5nZXMgc3BsaXQgLyBiZXR0ZXIgY29tbWVu
dHMgLyBldGMuLi4pLgoKPj4gPsKgVGhpbmdzIHdvdWxkIGdvIG1vcmUgc21vb3RobHkgaWYgeW91
Cj4+ID4gY291bGQgZ2V0IG5ldyB2ZXJzaW9ucyBvZiBwYXRjaGVzIHN1Ym1pdHRlZCBmYXN0ZXIg
YWZ0ZXIgdGhlIG9yaWdpbmFsCj4+ID4gcmV2aWV3Lgo+Cj4+IHRoZSBwcmV2aW91cyBCbGFja2Zp
biBrZXJuZWwgbWFpbnRhaW5lciBjaGFuZ2VkIGpvYnMgc28gd2UndmUgYmVlbgo+PiB0cmFuc2l0
aW9uaW5nLiDCoHJlYWxpdHkgaXMsIHRoaXMgZG9lc250IGhhcHBlbiBvdmVyIG5pdGUuCj4KPiBJ
IGFwcHJlY2lhdGUgdGhhdCBCcmlhbiBsZWF2aW5nIHdvbid0IGhhdmUgaGVscGVkIGhlcmUgYnV0
IHRoaXMgd2FzIGFuCj4gaXNzdWUgYmVmb3JlIHRoZW4sIGl0IGZlZWxzIGxpa2UgdGhlcmUncyBz
b21lIHNvcnQgb2YgZ2VuZXJhbCBwcm9jZXNzCj4gaXNzdWUgZ29pbmcgb24uIMKgSSdtIG5vdCBz
dXJlIHdoYXQgaXQgaXMgLSBJSVJDIHRoZXJlIHRlbmRzIHRvIGJlIGFib3V0Cj4gb25lIHNldCBv
ZiBCbGFja2ZpbiBwYXRjaGVzIHBlciBrZXJuZWwgcmVsZWFzZS4KPgo+IEl0J3Mgbm90IHNwZWNp
ZmljYWxseSBjYXVzaW5nIG1lIHByb2JsZW1zLCBpdCdzIG1vcmUgb2YgYSBjb25jZXJuIGZyb20K
PiB0aGUgcG9pbnQgb2YgdmlldyBvZiBnZXR0aW5nIHN0dWZmIHRvIHVzZXJzLgoKaWYgZml4ZXMg
bWlzcyBhIG1lcmdlIHdpbmRvdywgdGhlbiB0aGF0J3MgYW4gaXNzdWUuICBidXQgaW4gZ2VuZXJh
bCwKdXNlcnMgb25seSBzZWUgZml4ZXMgcGVyIHJlbGVhc2UsIHNvIHNlbmRpbmcgdGhpbmdzIG1v
cmUgcXVpY2tseSB0aGVyZQp3b3VsZG50IHJlYWxseSBoZWxwID8KLW1pa2UKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxp
c3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVj
dC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
