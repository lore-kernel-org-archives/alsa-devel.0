From: "=?UTF-8?Q?Vedran_Mileti=C4=87?=" <rivanvx@gmail.com>
Subject: Re: Backported sbxfi driver, possible fix
Date: Tue, 28 Oct 2008 11:53:04 +0100
Message-ID: <fd3eb9bf0810280353ha4e33a7j97da9ff7059680a0@mail.gmail.com>
References: <4900A4FA.7020300@jasonline.co.uk>
	<20081025130652.GA27621@rzle423.uni-duisburg.de>
	<s5hej24psn6.wl%tiwai@suse.de>
	<20081025194255.GA27872@rzle423.uni-duisburg.de>
	<s5hod18fntg.wl%tiwai@suse.de> <49038448.3090704@jasonline.co.uk>
	<5501535d0810251457k165cc4ceid2e34930a2bdc8ec@mail.gmail.com>
	<s5h7i7v22cl.wl%tiwai@suse.de> <ge3irb$knf$1@ger.gmane.org>
	<49061FA4.5010201@superbug.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.173])
	by alsa0.perex.cz (Postfix) with ESMTP id BBA48243BA
	for <alsa-devel@alsa-project.org>; Tue, 28 Oct 2008 11:53:05 +0100 (CET)
Received: by wf-out-1314.google.com with SMTP id 24so2612749wfg.23
	for <alsa-devel@alsa-project.org>; Tue, 28 Oct 2008 03:53:04 -0700 (PDT)
In-Reply-To: <49061FA4.5010201@superbug.co.uk>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: James Courtier-Dutton <James@superbug.co.uk>, alsa-devel mailing list <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

QnV0IHRoYXQgc3VyZWx5IGlzbid0IGJpdHBlcmZlY3QsIHJpZ2h0PwoKMjAwOC8xMC8yNyBKYW1l
cyBDb3VydGllci1EdXR0b24gPEphbWVzQHN1cGVyYnVnLmNvLnVrPgo+IEFsZXgsCj4KPiBJIGFk
ZGVkIHRoYXQgY29tbWVudCAodGFrYXNoaSBjdXQgYW5kIHBhc3RlZCBteSB0ZXh0KS4gTm8gcmVz
YW1wbGluZyBpcwo+IGRvbmUuCj4gU2F5IHlvdSBoYXZlIGEgYnVmZmVyIHRoYXQgaXMgcnVubmlu
ZyBhdCA0OGtIei4KPiBTbyB5b3UgaGF2ZSBzYXkgNDgwIHNhbXBsZXMgYXQgdGhlIDQ4a0h6IHJh
dGUuCj4gQnV0IGlmIHlvdSB3YW50IHRvIHRyYW5zZmVyIDQ0LjFrSHogcmF0ZSBzYW1wbGVzIG92
ZXIgaXQsIHlvdSBvbmx5IHdhbnQKPiA0NDEgc2FtcGxlcyB0byBiZSB0aGVyZSwgc28gd2hhdCB0
byBkbyB3aXRoIHRoZSBsZWZ0IG92ZXIgMzkgc2FtcGxlcy4KPiBXaGF0IHRoZSB4ZmkgZG9lcyBp
cyBuZXh0IHRvIGVhY2ggc2FtcGxlIGl0IGFkZHMgYSAidmFsaWQiIHRhZy4KPiBTbywgdGhlIHhm
aSBhZGRzIHRob3NlIDM5IHNhbXBsZXMgYnV0IG1hcmtzIHRoZW0gYXMgImludmFsaWQiLgo+IFRo
ZSB4ZmkgdGhlbiBkcm9wcyB0aGUgMzkgImludmFsaWQiIHNhbXBsZXMsIGxlYXZpbmcgb25seSB0
aGUgNDQxCj4gInZhbGlkIiBzYW1wbGVzIGp1c3QgYmVmb3JlIHNlbmRpbmcgdGhlbSBhdCA0NC4x
a0h6IHRvIHRoZSBEQUMuCj4gRG9lcyB0aGlzIGV4cGxhaW4gdGhpbmdzIGEgYml0IGJldHRlci4K
PiBGWUksIHRoZSB4ZmkgYWN0dWFsbHkgd29ya3MgaW50ZXJuYWxseSBhdCAzODRrSHosIHNvIGl0
IGlzIGFjdHVhbGx5Cj4gbWFya2luZyBhIGxvdCBvZiBzYW1wbGVzIGFzICJpbnZhbGlkIi4KPgo+
IEtpbmQgUmVnYXJkcwo+Cj4gSmFtZXMKPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwo+IEFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0Cj4gQWxzYS1kZXZlbEBh
bHNhLXByb2plY3Qub3JnCj4gaHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2Fsc2EtZGV2ZWwKPgoKCgotLSAKVmVkcmFuIE1pbGV0acSHCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBs
aXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNhLXByb2pl
Y3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
