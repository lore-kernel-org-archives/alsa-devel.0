From: "=?UTF-8?Q?Vedran_Mileti=C4=87?=" <rivanvx@gmail.com>
Subject: Re: [PATCH] ALSA: hda: add more board-specific
	information for Realtek ALC662 rev1
Date: Sat, 4 Oct 2008 19:35:23 +0200
Message-ID: <fd3eb9bf0810041035j6d59ee22ibd3b8cb2e37d1cc3@mail.gmail.com>
References: <fd3eb9bf0809291139y4252c1e1h75abbfdb68b21225@mail.gmail.com>
	<s5hmyhq85q5.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0708.google.com (rv-out-0708.google.com [209.85.198.245])
	by alsa0.perex.cz (Postfix) with ESMTP id 5EA70244FC
	for <alsa-devel@alsa-project.org>;
	Sat,  4 Oct 2008 19:35:25 +0200 (CEST)
Received: by rv-out-0708.google.com with SMTP id f25so1907137rvb.32
	for <alsa-devel@alsa-project.org>; Sat, 04 Oct 2008 10:35:23 -0700 (PDT)
In-Reply-To: <s5hmyhq85q5.wl%tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>, alsa-devel mailing list <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

UGxlYXNlIGNvcnJlY3QgdGhpcywgSSBnb3QgdGhlIHNlY29uZCBQQ0kgSUQgd3JvbmcuCkluc3Rl
YWQgb2Y6CgpTTkRfUENJX1FVSVJLKDB4MTg0OSwgMHgwNzc0LCAiQVNST0NLIEsxME43OEZ1bGxI
RC1oU0xJIFIzLjAiLAoKaXQgc2hvdWxkIGJlOgoKU05EX1BDSV9RVUlSSygweDE4NDksIDB4MzY2
MiwgIkFTUk9DSyBLMTBONzhGdWxsSEQtaFNMSSBSMy4wIiwKCmFjY29yZGluZyB0bzoKCjAwOjA3
LjAgQXVkaW8gZGV2aWNlIFswNDAzXTogblZpZGlhIENvcnBvcmF0aW9uIERldmljZSBbMTBkZTow
Nzc0XSAocmV2IGExKQoJU3Vic3lzdGVtOiBBU1JvY2sgSW5jb3Jwb3JhdGlvbiBEZXZpY2UgWzE4
NDk6MzY2Ml0KCUZsYWdzOiBidXMgbWFzdGVyLCA2Nk1IeiwgZmFzdCBkZXZzZWwsIGxhdGVuY3kg
MCwgSVJRIDIxCglNZW1vcnkgYXQgZjllNzgwMDAgKDMyLWJpdCwgbm9uLXByZWZldGNoYWJsZSkg
W3NpemU9MTZLXQoJQ2FwYWJpbGl0aWVzOiA8YWNjZXNzIGRlbmllZD4KCUtlcm5lbCBkcml2ZXIg
aW4gdXNlOiBIREEgSW50ZWwKCUtlcm5lbCBtb2R1bGVzOiBzbmQtaGRhLWludGVsCgpTb3JyeSBm
b3IgbXkgbWlzdGFrZS4gSWYgeW91IG5lZWQgbWUgdG8gc2VuZCBhIHBhdGNoIGZvciB0aGlzLCBq
dXN0IG1lbnRpb24gaXQuCgoyMDA4LzkvMzAgVGFrYXNoaSBJd2FpIDx0aXdhaUBzdXNlLmRlPjoK
PiBBdCBNb24sIDI5IFNlcCAyMDA4IDIwOjM5OjMzICswMjAwLAo+ID0/VVRGLTg/UT9WZWRyYW5f
TWlsZXRpPUM0PTg3Pz0gd3JvdGU6Cj4+Cj4+IEkgcmVjZW50bHkgZ290IGEgY2hhbmNlIHRvIHBs
YXkgd2l0aCB0d28gYm9hcmRzIHdpdGggQUxDNjYyIHJldjE6Cj4+ICogQklPU1RBUiBUQTc4MEcg
TTIrCj4+ICogQVNST0NLIEsxME43OEZ1bGxIRC1oU0xJIFIzLjAKPj4gQm90aCB1c2UgMyBzdGFj
aywgNmNoIG1vZGUgd2l0aCBkaWdpdGFsIG91dC4gU2luY2UgYXV0b2RldGVjdGlvbiBpc24ndCBh
YmxlCj4+IHRvIGZpZ3VyZSB0aGF0IG91dCBmcm9tIEJJT1MsIHdlIG5lZWQgdG8gc3BlY2lmeSB0
aGF0IG1hbnVhbGx5Lgo+Cj4gVGhhbmtzLCBhcHBsaWVkIG5vdy4KPgo+Cj4gVGFrYXNoaQo+CgoK
Ci0tIApWZWRyYW4gTWlsZXRpxIcKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2pl
Y3Qub3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9h
bHNhLWRldmVsCg==
