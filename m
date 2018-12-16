From: =?UTF-8?q?Mantas=20Mikul=C4=97nas?= <grawity@gmail.com>
Subject: [PATCH v2] ALSA: hda: add mute LED support for HP
	EliteBook 840 G4
Date: Sun, 16 Dec 2018 15:44:47 +0200
Message-ID: <20181216134447.2792-1-grawity@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lf1-f66.google.com (mail-lf1-f66.google.com
 [209.85.167.66])
 by alsa0.perex.cz (Postfix) with ESMTP id 187522677E4
 for <alsa-devel@alsa-project.org>; Sun, 16 Dec 2018 14:45:28 +0100 (CET)
Received: by mail-lf1-f66.google.com with SMTP id n18so7529027lfh.6
 for <alsa-devel@alsa-project.org>; Sun, 16 Dec 2018 05:45:28 -0800 (PST)
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

VGVzdGVkIHdpdGggNC4xOS45LgoKdjI6IENoYW5nZWQgZnJvbSBDWFRfRklYVVBfTVVURV9MRURf
R1BJTyB0byBDWFRfRklYVVBfSFBfRE9DSyBiZWNhdXNlCiAgICB0aGF0J3Mgd2hhdCB0aGUgZXhp
c3RpbmcgZml4dXBzIGZvciBFbGl0ZUJvb2tzIHVzZS4KClNpZ25lZC1vZmYtYnk6IE1hbnRhcyBN
aWt1bMSXbmFzIDxncmF3aXR5QGdtYWlsLmNvbT4KLS0tCiBzb3VuZC9wY2kvaGRhL3BhdGNoX2Nv
bmV4YW50LmMgfCAxICsKIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQoKZGlmZiAtLWdp
dCBhL3NvdW5kL3BjaS9oZGEvcGF0Y2hfY29uZXhhbnQuYyBiL3NvdW5kL3BjaS9oZGEvcGF0Y2hf
Y29uZXhhbnQuYwppbmRleCA5NTBlMDJlNzE3NjYuLjUxY2M2NTg5NDQzZiAxMDA2NDQKLS0tIGEv
c291bmQvcGNpL2hkYS9wYXRjaF9jb25leGFudC5jCisrKyBiL3NvdW5kL3BjaS9oZGEvcGF0Y2hf
Y29uZXhhbnQuYwpAQCAtOTIzLDYgKzkyMyw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgc25kX3Bj
aV9xdWlyayBjeHQ1MDY2X2ZpeHVwc1tdID0gewogCVNORF9QQ0lfUVVJUksoMHgxMDNjLCAweDgw
NzksICJIUCBFbGl0ZUJvb2sgODQwIEczIiwgQ1hUX0ZJWFVQX0hQX0RPQ0spLAogCVNORF9QQ0lf
UVVJUksoMHgxMDNjLCAweDgwN0MsICJIUCBFbGl0ZUJvb2sgODIwIEczIiwgQ1hUX0ZJWFVQX0hQ
X0RPQ0spLAogCVNORF9QQ0lfUVVJUksoMHgxMDNjLCAweDgwRkQsICJIUCBQcm9Cb29rIDY0MCBH
MiIsIENYVF9GSVhVUF9IUF9ET0NLKSwKKwlTTkRfUENJX1FVSVJLKDB4MTAzYywgMHg4MjhjLCAi
SFAgRWxpdGVCb29rIDg0MCBHNCIsIENYVF9GSVhVUF9IUF9ET0NLKSwKIAlTTkRfUENJX1FVSVJL
KDB4MTAzYywgMHg4M2IzLCAiSFAgRWxpdGVCb29rIDgzMCBHNSIsIENYVF9GSVhVUF9IUF9ET0NL
KSwKIAlTTkRfUENJX1FVSVJLKDB4MTAzYywgMHg4M2QzLCAiSFAgUHJvQm9vayA2NDAgRzQiLCBD
WFRfRklYVVBfSFBfRE9DSyksCiAJU05EX1BDSV9RVUlSSygweDEwM2MsIDB4ODE3NCwgIkhQIFNw
ZWN0cmUgeDM2MCIsIENYVF9GSVhVUF9IUF9TUEVDVFJFKSwKLS0gCjIuMjAuMQoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5n
IGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJv
amVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
