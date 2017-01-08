From: =?UTF-8?q?J=C3=B6rg=20Krause?= <joerg.krause@embedded.rocks>
Subject: [PATCH] ASoC: wm8731: Adjust clk definitions so that
	simple card can work
Date: Sun,  8 Jan 2017 20:40:48 +0100
Message-ID: <20170108194048.2900-1-joerg.krause@embedded.rocks>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.142])
 by alsa0.perex.cz (Postfix) with ESMTP id 4A44026669C
 for <alsa-devel@alsa-project.org>; Sun,  8 Jan 2017 20:41:00 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: =?UTF-8?q?J=C3=B6rg=20Krause?= <joerg.krause@embedded.rocks>, Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

V2hlbiB0cnlpbmcgdG8gdXNlIHNpbXBsZSBjYXJkIHdpdGggd204OTYyIHRoZSBmb2xsb3dpbmcg
cHJvYmUKZXJyb3IgaGFwcGVuczoKCiAgd204NzMxIDAtMDAxYTogc2ltcGxlLWNhcmQ6IHNldF9z
eXNjbGsgZXJyb3IKCkluIHNpbXBsZS1jYXJkLmMgdGhlIHNuZF9zb2NfZGFpX3NldF9zeXNjbGso
KSBmdW5jdGlvbiBpcyBjYWxsZWQgd2l0aApjbGtfaWQgYXMgMCwgd2hpY2ggaXMgYW4gaW52YWxp
ZCBjbG9jayBmb3Igd204NzMxLgoKQWRqdXN0IHRoZSBjbG9ja3Mgc291cmNlIGRlZmluaXRpb25z
IGluIHdtODczMS5oIHNvIHRoYXQgdGhlIHNpbXBsZQpjYXJkIGRyaXZlciBjYW4gd29yayBzdWNj
ZXNzZnVsbHkKClNpZ25lZC1vZmYtYnk6IErDtnJnIEtyYXVzZSA8am9lcmcua3JhdXNlQGVtYmVk
ZGVkLnJvY2tzPgotLS0KIHNvdW5kL3NvYy9jb2RlY3Mvd204NzMxLmggfCAyICstCiAxIGZpbGUg
Y2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9zb3Vu
ZC9zb2MvY29kZWNzL3dtODczMS5oIGIvc291bmQvc29jL2NvZGVjcy93bTg3MzEuaAppbmRleCBl
OWMwYzc2YWI3M2IuLmM3YzZmMTViMGU0MiAxMDA2NDQKLS0tIGEvc291bmQvc29jL2NvZGVjcy93
bTg3MzEuaAorKysgYi9zb3VuZC9zb2MvY29kZWNzL3dtODczMS5oCkBAIC0zMSw4ICszMSw4IEBA
CiAKICNkZWZpbmUgV004NzMxX0NBQ0hFUkVHTlVNIAkxMAogCisjZGVmaW5lIFdNODczMV9TWVND
TEtfTUNMSyAwCiAjZGVmaW5lIFdNODczMV9TWVNDTEtfWFRBTCAxCi0jZGVmaW5lIFdNODczMV9T
WVNDTEtfTUNMSyAyCiAKICNkZWZpbmUgV004NzMxX0RBSQkJMAogCi0tIAoyLjExLjAKCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFp
bGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNh
LXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
