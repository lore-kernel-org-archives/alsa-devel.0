From: Wan ZongShun <mcuos.com@gmail.com>
Subject: Re: [PATCH v2 2/4]AsoC/nuc900: patch for modifing the
	ac97 delays to minimum
Date: Wed, 2 Jun 2010 17:49:14 +0800
Message-ID: <AANLkTilgdkSfTtbDY5O_QovUlF7vL0EASjkdlhhrA7MU@mail.gmail.com>
References: <4C05F2AD.8030700@gmail.com>
	<1275471966.3037.32.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51]) by alsa0.perex.cz (Postfix) with ESMTP id 9CE14245FE
	for <alsa-devel@alsa-project.org>;
	Wed,  2 Jun 2010 11:49:15 +0200 (CEST)
Received: by vws8 with SMTP id 8so1109369vws.38
	for <alsa-devel@alsa-project.org>; Wed, 02 Jun 2010 02:49:14 -0700 (PDT)
In-Reply-To: <1275471966.3037.32.camel@odin>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

MjAxMC82LzIgTGlhbSBHaXJkd29vZCA8bHJnQHNsaW1sb2dpYy5jby51az46Cj4gT24gV2VkLCAy
MDEwLTA2LTAyIGF0IDEzOjU3ICswODAwLCBXYW4gWm9uZ1NodW4gd3JvdGU6Cj4+IFRoaXMgcGF0
Y2ggaXMgdG8gbW9kaWZ5IHRoZSBhYzk3IGRlbGF5cyB0byBtaW5pbXVtLCBhbGwgdGhlc2UgMTAw
MCBtaWNybwo+PiBzZWNvbmRzIGRlbGF5cyBzZWVtIG92ZXIgc3BlYyBmb3IgdGhlIEFDOTcgaW50
ZXJmYWNlLgo+Pgo+PiBJIGRlbGV0ZWQgc29tZSB1bm5lY2Vzc2FyeSBkZWxheXMgaGVyZSBhbmQg
Y2hhbmdlZCB0aGUgQUM5NyBjb2xkIGFuZCB3YXJtIHJlc2V0Cj4+IGRlbGF5cyBmcm9tIDEwMDBt
cyB0byAxMDBtcy4KPj4KPgo+IEkgdGhpbmsgeW91IG1lYW4gImZyb20gMTAwMMK1cyB0byAxMDDC
tXMiIGhlcmUgYXMgbXMgaXMgbWlsbGlzZWNvbmRzLgoKU29ycnkgZm9yIHRoaXMuCllvdSBhcmUg
cmlnaHQsc28gZGlkIEkgbmVlZCB0byByZXNlbnQgdGhlIGZpeCBwYXRjaD8KClRoYW5rcyEKCj4K
PiBMaWFtCj4gLS0KPiBGcmVlbGFuY2UgRGV2ZWxvcGVyLCBTbGltTG9naWMgTHRkCj4gQVNvQyBh
bmQgVm9sdGFnZSBSZWd1bGF0b3IgTWFpbnRhaW5lci4KPiBodHRwOi8vd3d3LnNsaW1sb2dpYy5j
by51awo+Cj4KCgoKLS0gCipsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdAptYWlsIGFkZHI6
bGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCnlvdSBjYW4gc3Vic2NyaWJlIGJ5
OgpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1r
ZXJuZWwKCiogbGludXgtYXJtLU5VQzkwMCBtYWlsaW5nIGxpc3QKbWFpbCBhZGRyOk5VQzkwMEBn
b29nbGVncm91cHMuY29tCm1haW4gd2ViOiBodHRwczovL2dyb3Vwcy5nb29nbGUuY29tL2dyb3Vw
L05VQzkwMAp5b3UgY2FuIHN1YnNjcmliZSBpdCBieSBzZW5kaW5nIG1lIG1haWw6Cm1jdW9zLmNv
bUBnbWFpbC5jb20KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0
dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVs
Cg==
