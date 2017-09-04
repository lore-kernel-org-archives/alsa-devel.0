From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH v2 1/2] ASoC: cs43130: Fix possible Oops with
	invalid dev_id
Date: Mon,  4 Sep 2017 15:54:47 +0200
Message-ID: <20170904135448.26314-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id CA960266F04
 for <alsa-devel@alsa-project.org>; Mon,  4 Sep 2017 15:54:50 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

QXMgY29tcGlsZXIgc3BvdHRlZCBvdXQsIHRoZXJlIGlzIHRoZSBwb3RlbnRpYWwgTlVMTC1kZXJl
ZmVyZW5jZSBpbgp0aGUgY29kZSB3aGVuIGRjLW1lYXN1cmUgT0YgaXMgZ2l2ZW4gZm9yIG90aGVy
IHRoYW4gNDMxMzAvNDMxMzE6CiAgc291bmQvc29jL2NvZGVjcy9jczQzMTMwLmM6MjA4OToxODog
d2FybmluZzog4oCYaHBsb2FkX3NlceKAmSBtYXkgYmUgdXNlZCB1bmluaXRpYWxpemVkIGluIHRo
aXMgZnVuY3Rpb24gWy1XbWF5YmUtdW5pbml0aWFsaXplZF0KCldhcm4gaXQgYW5kIHJldHVybiBi
ZWZvcmUgdHJpZ2dlcmluZyBPb3BzLgoKRml4ZXM6IDhmMWU1YmY5YjQ0MCAoIkFTb0M6IGNzNDMx
MzA6IEFkZCBzdXBwb3J0IGZvciBDUzQzMTMwIGNvZGVjIikKU2lnbmVkLW9mZi1ieTogVGFrYXNo
aSBJd2FpIDx0aXdhaUBzdXNlLmRlPgotLS0KIHNvdW5kL3NvYy9jb2RlY3MvY3M0MzEzMC5jIHwg
NCArKysrCiAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvc291
bmQvc29jL2NvZGVjcy9jczQzMTMwLmMgYi9zb3VuZC9zb2MvY29kZWNzL2NzNDMxMzAuYwppbmRl
eCAyMjBlMzAxOTljNWIuLjNmZTNiOGQ2NDRiNyAxMDA2NDQKLS0tIGEvc291bmQvc29jL2NvZGVj
cy9jczQzMTMwLmMKKysrIGIvc291bmQvc29jL2NvZGVjcy9jczQzMTMwLmMKQEAgLTIwNzksNiAr
MjA3OSwxMCBAQCBzdGF0aWMgdm9pZCBjczQzMTMwX2ltcF9tZWFzKHN0cnVjdCB3b3JrX3N0cnVj
dCAqd2spCiAJY2FzZSBDUzQzMTMxX0NISVBfSUQ6CiAJCWhwbG9hZF9zZXEgPSBocGxvYWRfc2Vx
MjsKIAkJc2VxX3NpemUgPSBBUlJBWV9TSVpFKGhwbG9hZF9zZXEyKTsKKwkJYnJlYWs7CisJZGVm
YXVsdDoKKwkJV0FSTigxLCAiSW52YWxpZCBkZXZfaWQgZm9yIG1lYXM6ICVkIiwgY3M0MzEzMC0+
ZGV2X2lkKTsKKwkJcmV0dXJuOwogCX0KIAogCWkgPSAwOwotLSAKMi4xNC4xCgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcg
bGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9q
ZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
