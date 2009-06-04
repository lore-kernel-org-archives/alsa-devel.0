From: Mike Frysinger <vapier.adi@gmail.com>
Subject: Re: [Uclinux-dist-devel] [PATCH 2/5] ASoC codec:
	SSM2602: assign last substream to the master when shutting down
Date: Thu, 4 Jun 2009 04:22:54 -0400
Message-ID: <8bd0f97a0906040122r2e4ca8feo69e6afb06140cef3@mail.gmail.com>
References: <1243916337-29953-1-git-send-email-vapier@gentoo.org>
	<1243916337-29953-2-git-send-email-vapier@gentoo.org>
	<20090603105223.GE11507@sirena.org.uk>
	<8bd0f97a0906030537y1e65aa7atec4b0c5cdf4ae2f@mail.gmail.com>
	<20090603145316.GA7315@rakim.wolfsonmicro.main>
	<8bd0f97a0906031826j647efa0bs1ffb6492cfd0ccd8@mail.gmail.com>
	<4A2782FE.3080103@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yw-out-1718.google.com (yw-out-1718.google.com [74.125.46.153])
	by alsa0.perex.cz (Postfix) with ESMTP id 1856E24445
	for <alsa-devel@alsa-project.org>;
	Thu,  4 Jun 2009 10:22:54 +0200 (CEST)
Received: by yw-out-1718.google.com with SMTP id 4so306559ywq.2
	for <alsa-devel@alsa-project.org>; Thu, 04 Jun 2009 01:22:54 -0700 (PDT)
In-Reply-To: <4A2782FE.3080103@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Karl Beldan <karl.beldan@gmail.com>
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Cliff Cai <cliff.cai@analog.com>
List-Id: alsa-devel@alsa-project.org

T24gVGh1LCBKdW4gNCwgMjAwOSBhdCAwNDoxNywgS2FybCBCZWxkYW4gd3JvdGU6Cj4gTWlrZSBG
cnlzaW5nZXIgd3JvdGU6Cj4+IE9uIFdlZCwgSnVuIDMsIDIwMDkgYXQgMTA6NTMsIE1hcmsgQnJv
d24gd3JvdGU6Cj4+PiBPbiBXZWQsIEp1biAwMywgMjAwOSBhdCAwODozNzo1NEFNIC0wNDAwLCBN
aWtlIEZyeXNpbmdlciB3cm90ZToKPj4+PiBPbiBXZWQsIEp1biAzLCAyMDA5IGF0IDA2OjUyLCBN
YXJrIEJyb3duIHdyb3RlOgo+Pj4+PiBIb3dldmVyLCBnaXZlbiB0aGF0IHRoaXMgZml4IGhhcyBt
aXNzZWQgdHdvIGtlcm5lbCByZWxlYXNlcyBkdWUgdG8gdGhlCj4+Pj4+IHZlcnkgc2xvdyByYXRl
IG9mIHJlc3BvbnNlcyB0byByZXZpZXcgY29tbWVudHMgSSd2ZSBhcHBsaWVkIGl0IHNvIHVzZXJz
Cj4+Pj4+IGdldCB0aGUgYmVuZWZpdCBvZiB0aGUgYnVnIGZpeC4KPj4+PiBub3Qgc3VyZSB3aGF0
IHlvdSdyZSByZWZlcnJpbmcgdG8KPj4+IFRoaXMgbG9va3MgbGlrZSBhIHJlc3BpbiBvZiBhIGZp
eCB3aGljaCB3YXMgb3JpZ2luYWxseSBzdWJtaXR0ZWQgYmFjayBpbgo+Pj4gMi42LjI5IGVyYSBv
ciBzby4gwqBJSVJDIHRoZXJlJ3MgYmVlbiB0d28gb3IgdGhyZWUgdmVyc2lvbnMsIGVhY2ggb2YK
Pj4+IHdoaWNoIG5lZWRlZCBmaXhlcy4KPj4KPj4gaXQgY291bGQgYmUuIMKgaSB3YXMgZ29pbmcg
YnkgdGhlIGNoYW5nZXMgdGhhdCB3ZXJlbnQgaW4gMi42LjMwLiDCoGkKPj4gdGhvdWdodCBpIGxv
b2tlZCBmb3IgcHJldmlvdXMgc3VibWlzc2lvbnMsIGJ1dCBpIG11c3QgaGF2ZSBtaXNzZWQKPj4g
cHJldmlvdXMgYXR0ZW1wdHMuIMKgaSdtIG5vdCBmYW1pbGlhciB3aXRoIGFsc2Egc3R1ZmYsIHNv
IGknbSBub3QKPj4gYWx3YXlzIHN1cmUgd2hlbiBpIG5lZWQgdG8gYmFuZyBvbiBDbGlmZiB0byBn
ZXQgdGhpbmdzIGZpeGVkIHVwCj4+IChjaGFuZ2VzIHNwbGl0IC8gYmV0dGVyIGNvbW1lbnRzIC8g
ZXRjLi4uKS4KPgo+IEFueXdheXMsIHRoaXMgY29tbWl0IGhhcyBiZWVuIHRyeWluZyB0byBmaXgg
c29tZXRoaW5nIGFscmVhZHkgZml4ZWQgc2luY2UgdGhlCj4gZmlyc3Qgc3VibWlzc2lvbiBhbmQg
aWYgeW91IGxvb2sgYXQgaXRzIGVmZmVjdCBvbiB0aGUgY3VycmVudCB0cmVlIHlvdSB3aWxsIHNl
ZQo+IGR1cGxpY2F0ZSBjb2RlLgoKeW91J3JlIGdvaW5nIHRvIGhhdmUgdG8gYmUgYSBiaXQgbW9y
ZSBzcGVjaWZpYy4gIGkgZG9udCBrbm93IGFsc2EsIHNvCndoZW4gaSBsb29rZWQgYXQgdGhlIGNo
YW5nZSBoaXN0b3J5LCBpIHNhdyBmcmFtZXdvcmsgY29udmVyc2lvbnMuCmFib3V0IHRoZSBvbmx5
IHRoaW5nIHRoYXQgbWlnaHQgYmUgcmVsYXRlZCBpcyBmYWFiNWEzMi4gIGlzIHRoYXQgd2hhdAp5
b3UncmUgdGFsa2luZyBhYm91dCA/Ci1taWtlCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxz
YS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlz
dGluZm8vYWxzYS1kZXZlbAo=
