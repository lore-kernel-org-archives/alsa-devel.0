From: Mike Frysinger <vapier.adi@gmail.com>
Subject: Re: [Uclinux-dist-devel] [PATCH 2/5] ASoC codec:
	SSM2602: assign last substream to the master when shutting down
Date: Sat, 13 Jun 2009 06:47:17 -0400
Message-ID: <8bd0f97a0906130347x74973be2nf5c26641a09c5e24@mail.gmail.com>
References: <1243916337-29953-1-git-send-email-vapier@gentoo.org>
	<1243916337-29953-2-git-send-email-vapier@gentoo.org>
	<20090603105223.GE11507@sirena.org.uk>
	<8bd0f97a0906030537y1e65aa7atec4b0c5cdf4ae2f@mail.gmail.com>
	<20090603145316.GA7315@rakim.wolfsonmicro.main>
	<8bd0f97a0906031826j647efa0bs1ffb6492cfd0ccd8@mail.gmail.com>
	<20090604085921.GD6983@rakim.wolfsonmicro.main>
	<ea2442770906130237s72ff15b3n1168eb3392231149@mail.gmail.com>
	<20090613104435.GA4795@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gx0-f217.google.com (mail-gx0-f217.google.com
	[209.85.217.217])
	by alsa0.perex.cz (Postfix) with ESMTP id EA00424429
	for <alsa-devel@alsa-project.org>;
	Sat, 13 Jun 2009 12:47:37 +0200 (CEST)
Received: by gxk17 with SMTP id 17so4251256gxk.8
	for <alsa-devel@alsa-project.org>; Sat, 13 Jun 2009 03:47:37 -0700 (PDT)
In-Reply-To: <20090613104435.GA4795@sirena.org.uk>
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
Cc: Karl Beldan <karl.beldan@gmail.com>, uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org, Cliff Cai <cliff.cai@analog.com>
List-Id: alsa-devel@alsa-project.org

T24gU2F0LCBKdW4gMTMsIDIwMDkgYXQgMDY6NDQsIE1hcmsgQnJvd24gd3JvdGU6Cj4gT24gU2F0
LCBKdW4gMTMsIDIwMDkgYXQgMTE6Mzc6MzNBTSArMDIwMCwgS2FybCBCZWxkYW4gd3JvdGU6Cj4+
IFRoaXMgLSBmNjkyZmNlIC0gc2hvdWxkIG5vdCBoYXZlIHJlYWNoZWQgdXBzdHJlYW0sIGhvdyBj
b21lID8KPgo+IFRoZSBlbnRpcmUgZGlzY3Vzc2lvbiBvZiB0aGUgcGF0Y2ggb2NjdXJyZWQgaW4g
cmVzcG9uc2UgdG8gbXkgc2F5aW5nIEknZAo+IGFwcGxpZWQgaXQsIHdpdGggbW9zdCBvZiB0aGUg
ZGlzY3Vzc2lvbiBiZWluZyBhIGNvdXBsZSBvZiBkYXlzIGxhdGVyCj4gYWZ0ZXIgaXQnZCBoYXZl
IGFscmVhZHkgZ29uZSBpbnRvIEFMU0EuIMKgU2luY2Ugbm9ib2R5IGFza2VkIHRvIGhhdmUgaXQK
PiByZXZlcnRlZCBvciBpbmRpY2F0ZWQgdGhhdCB0aGVyZSB3YXMgYW55IGFjdHVhbCBwcm9ibGVt
IG90aGVyIHRoYW4gYQo+IHJlcGl0aXRpb24gb2YgY29kZSBpdCB3YXNuJ3QgcmV2ZXJ0ZWQuIMKg
Rm9yIHRoZSBtb3N0IHBhcnQgcmVwaXRpdGlvbgo+IGluIEFTb0Mgd291bGQganVzdCBiZSBhIG5v
LW9wIGFuZCB0aGVyZWZvcmUgYSBjb2RlIHF1YWxpdHkgcmF0aGVyCj4gdGhhbiBiZWhhdmlvdXJh
bCBpc3N1ZS4gwqBBcyBJIGluZGljYXRlZCB3aGVuIGFjY2VwdGluZyB0aGUgcGF0Y2ggSSd2ZQo+
IGxvd2VyZWQgbXkgc3RhbmRhcmRzIHRoZXJlIGZvciBibGFja2ZpbiBkdWUgdG8gdGhlIHBhc3Qg
aXNzdWVzIHdpdGgKPiBpdGVyYXRpb24gc3BlZWQgKHdoaWNoIE1pa2UgaGFzIGFscmVhZHkgc2Fp
ZCB3aWxsIGJlIGJlaW5nIGFkZHJlc3NlZAo+IG5vdykuCj4KPiBJJ3ZlIG5vdyByZXZlcnRlZCB0
aGUgc2h1dGRvd24gaHVuayBvZiB0aGUgcGF0Y2ggd2hlcmUgZHVwbGljYXRpb24gd2lsbAo+IGFj
dHVhbGx5IGludHJvZHVjZSBhIGJ1Zy4KCmkgdGhpbmsgQ2xpZmYgdmVyaWZpZWQgdGhhdCB0aGUg
b3RoZXIgcGFydCBvZiB0aGUgY2hhbmdlIHdhcyBubyBsb25nZXIKbmVlZGVkIGluIGhpcyB0ZXN0
aW5nLCBzbyByZXZlcnRpbmcgdGhlIHdob2xlIHBhdGNoIGlzIGZpbmUuICB3ZSd2ZQpkb25lIHRo
YXQgaW4gdGhlIEJsYWNrZmluIHRyZWUuCi1taWtlCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxA
YWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4v
bGlzdGluZm8vYWxzYS1kZXZlbAo=
