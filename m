From: =?UTF-8?q?Toralf=20F=C3=B6rster?= <toralf.foerster@gmx.de>
Subject: [PATCH] fix format type mismatch in
	sound/pci/hda/patch_sigmatel.c
Date: Tue, 20 May 2014 19:19:24 +0200
Message-ID: <1400606364-21649-1-git-send-email-toralf.foerster@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 by alsa0.perex.cz (Postfix) with ESMTP id B1969261B09
 for <alsa-devel@alsa-project.org>; Tue, 20 May 2014 19:19:29 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: =?UTF-8?q?Toralf=20F=C3=B6rster?= <toralf.foerster@gmx.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

U2lnbmVkLW9mZi1ieTogVG9yYWxmIEbDtnJzdGVyIDx0b3JhbGYuZm9lcnN0ZXJAZ214LmRlPgot
LS0KIHNvdW5kL3BjaS9oZGEvcGF0Y2hfc2lnbWF0ZWwuYyB8IDQgKystLQogMSBmaWxlIGNoYW5n
ZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9zb3VuZC9w
Y2kvaGRhL3BhdGNoX3NpZ21hdGVsLmMgYi9zb3VuZC9wY2kvaGRhL3BhdGNoX3NpZ21hdGVsLmMK
aW5kZXggNzU1MTViNC4uN2Y0MGExNSAxMDA2NDQKLS0tIGEvc291bmQvcGNpL2hkYS9wYXRjaF9z
aWdtYXRlbC5jCisrKyBiL3NvdW5kL3BjaS9oZGEvcGF0Y2hfc2lnbWF0ZWwuYwpAQCAtNzk1LDcg
Kzc5NSw3IEBAIHN0YXRpYyBpbnQgZmluZF9tdXRlX2xlZF9jZmcoc3RydWN0IGhkYV9jb2RlYyAq
Y29kZWMsIGludCBkZWZhdWx0X3BvbGFyaXR5KQogCX0KIAogCXdoaWxlICgoZGV2ID0gZG1pX2Zp
bmRfZGV2aWNlKERNSV9ERVZfVFlQRV9PRU1fU1RSSU5HLCBOVUxMLCBkZXYpKSkgewotCQlpZiAo
c3NjYW5mKGRldi0+bmFtZSwgIkhQX011dGVfTEVEXyVkXyV4IiwKKwkJaWYgKHNzY2FuZihkZXYt
Pm5hbWUsICJIUF9NdXRlX0xFRF8ldV8leCIsCiAJCQkgICAmc3BlYy0+Z3Bpb19sZWRfcG9sYXJp
dHksCiAJCQkgICAmc3BlYy0+Z3Bpb19sZWQpID09IDIpIHsKIAkJCXVuc2lnbmVkIGludCBtYXhf
Z3BpbzsKQEAgLTgwOCw3ICs4MDgsNyBAQCBzdGF0aWMgaW50IGZpbmRfbXV0ZV9sZWRfY2ZnKHN0
cnVjdCBoZGFfY29kZWMgKmNvZGVjLCBpbnQgZGVmYXVsdF9wb2xhcml0eSkKIAkJCQlzcGVjLT52
cmVmX211dGVfbGVkX25pZCA9IHNwZWMtPmdwaW9fbGVkOwogCQkJcmV0dXJuIDE7CiAJCX0KLQkJ
aWYgKHNzY2FuZihkZXYtPm5hbWUsICJIUF9NdXRlX0xFRF8lZCIsCisJCWlmIChzc2NhbmYoZGV2
LT5uYW1lLCAiSFBfTXV0ZV9MRURfJXUiLAogCQkJICAgJnNwZWMtPmdwaW9fbGVkX3BvbGFyaXR5
KSA9PSAxKSB7CiAJCQlzZXRfaHBfbGVkX2dwaW8oY29kZWMpOwogCQkJcmV0dXJuIDE7Ci0tIAox
LjkuMwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQWxz
YS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHA6Ly9t
YWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
