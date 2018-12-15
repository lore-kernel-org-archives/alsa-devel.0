From: =?UTF-8?q?Mantas=20Mikul=C4=97nas?= <grawity@gmail.com>
Subject: [PATCH] ALSA: hda: add mute LED support for HP
	EliteBook 840 G4
Date: Sat, 15 Dec 2018 18:43:54 +0200
Message-ID: <20181215164354.6107-1-grawity@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lf1-f66.google.com (mail-lf1-f66.google.com
 [209.85.167.66])
 by alsa0.perex.cz (Postfix) with ESMTP id 5EC16267AA7
 for <alsa-devel@alsa-project.org>; Sat, 15 Dec 2018 17:44:16 +0100 (CET)
Received: by mail-lf1-f66.google.com with SMTP id p86so6524617lfg.5
 for <alsa-devel@alsa-project.org>; Sat, 15 Dec 2018 08:44:16 -0800 (PST)
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
Cc: Takashi Iwai <tiwai@suse.de>, =?UTF-8?q?Mantas=20Mikul=C4=97nas?= <grawity@gmail.com>
List-Id: alsa-devel@alsa-project.org

VGVzdGVkIHdpdGggNC4xOS44LgoKKEV4aXN0aW5nIGVudHJpZXMgZm9yIHNpbWlsYXIgbW9kZWxz
IHVzZSBDWFRfRklYVVBfSFBfRE9DSywgd2hpY2ggbWlnaHQKYmUgYSBiZXR0ZXIgY2hvaWNlIGhl
cmUgYXMgd2VsbCwgYnV0IHRoYXQncyBmYXIgYmV5b25kIG15IGtub3dsZWRnZSAtLQphbmQgSSBk
b24ndCBoYXZlIGEgZG9jayB0byB0ZXN0IGl0IHdpdGggZWl0aGVyLikKClNpZ25lZC1vZmYtYnk6
IE1hbnRhcyBNaWt1bMSXbmFzIDxncmF3aXR5QGdtYWlsLmNvbT4KLS0tCiBzb3VuZC9wY2kvaGRh
L3BhdGNoX2NvbmV4YW50LmMgfCAxICsKIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQoK
ZGlmZiAtLWdpdCBhL3NvdW5kL3BjaS9oZGEvcGF0Y2hfY29uZXhhbnQuYyBiL3NvdW5kL3BjaS9o
ZGEvcGF0Y2hfY29uZXhhbnQuYwppbmRleCA5NTBlMDJlNzE3NjYuLmIwNGZmOGYyY2Y1YyAxMDA2
NDQKLS0tIGEvc291bmQvcGNpL2hkYS9wYXRjaF9jb25leGFudC5jCisrKyBiL3NvdW5kL3BjaS9o
ZGEvcGF0Y2hfY29uZXhhbnQuYwpAQCAtOTIyLDYgKzkyMiw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1
Y3Qgc25kX3BjaV9xdWlyayBjeHQ1MDY2X2ZpeHVwc1tdID0gewogCVNORF9QQ0lfUVVJUksoMHgx
MDI1LCAweDA1NGYsICJBY2VyIEFzcGlyZSA0ODMwVCIsIENYVF9GSVhVUF9BU1BJUkVfRE1JQyks
CiAJU05EX1BDSV9RVUlSSygweDEwM2MsIDB4ODA3OSwgIkhQIEVsaXRlQm9vayA4NDAgRzMiLCBD
WFRfRklYVVBfSFBfRE9DSyksCiAJU05EX1BDSV9RVUlSSygweDEwM2MsIDB4ODA3QywgIkhQIEVs
aXRlQm9vayA4MjAgRzMiLCBDWFRfRklYVVBfSFBfRE9DSyksCisJU05EX1BDSV9RVUlSSygweDEw
M2MsIDB4ODI4YywgIkhQIEVsaXRlQm9vayA4NDAgRzQiLCBDWFRfRklYVVBfTVVURV9MRURfR1BJ
TyksCiAJU05EX1BDSV9RVUlSSygweDEwM2MsIDB4ODBGRCwgIkhQIFByb0Jvb2sgNjQwIEcyIiwg
Q1hUX0ZJWFVQX0hQX0RPQ0spLAogCVNORF9QQ0lfUVVJUksoMHgxMDNjLCAweDgzYjMsICJIUCBF
bGl0ZUJvb2sgODMwIEc1IiwgQ1hUX0ZJWFVQX0hQX0RPQ0spLAogCVNORF9QQ0lfUVVJUksoMHgx
MDNjLCAweDgzZDMsICJIUCBQcm9Cb29rIDY0MCBHNCIsIENYVF9GSVhVUF9IUF9ET0NLKSwKLS0g
CjIuMjAuMAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
QWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHA6
Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
