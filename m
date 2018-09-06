From: =?UTF-8?q?S=C3=A9bastien=20Szymanski?= <sebastien.szymanski@armadeus.com>
Subject: [PATCH 1/1] ASoC: cs4265: fix MMTLR Data switch control
Date: Thu,  6 Sep 2018 11:16:00 +0200
Message-ID: <20180906091600.10843-1-sebastien.szymanski@armadeus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from 10.mo1.mail-out.ovh.net (10.mo1.mail-out.ovh.net
 [178.32.96.102])
 by alsa0.perex.cz (Postfix) with ESMTP id 4D0D8267782
 for <alsa-devel@alsa-project.org>; Thu,  6 Sep 2018 11:04:07 +0200 (CEST)
Received: from player691.ha.ovh.net (unknown [10.109.143.216])
 by mo1.mail-out.ovh.net (Postfix) with ESMTP id 607D212B602
 for <alsa-devel@alsa-project.org>; Thu,  6 Sep 2018 11:04:06 +0200 (CEST)
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
Cc: Brian Austin <brian.austin@cirrus.com>, Takashi Iwai <tiwai@suse.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, =?UTF-8?q?S=C3=A9bastien=20Szymanski?= <sebastien.szymanski@armadeus.com>
List-Id: alsa-devel@alsa-project.org

VGhlIE1NVExSIGJpdCBpcyBpbiB0aGUgQ1M0MjY1X1NQRElGX0NUTDIgcmVnaXN0ZXIgYXQgYWRk
cmVzcyAweDEyIGJpdCAwCmFuZCBub3QgYXQgYWRkcmVzcyAweDAgYml0IDEuIEZpeCB0aGlzLgoK
U2lnbmVkLW9mZi1ieTogU8OpYmFzdGllbiBTenltYW5za2kgPHNlYmFzdGllbi5zenltYW5za2lA
YXJtYWRldXMuY29tPgotLS0KIHNvdW5kL3NvYy9jb2RlY3MvY3M0MjY1LmMgfCA0ICsrLS0KIDEg
ZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0
IGEvc291bmQvc29jL2NvZGVjcy9jczQyNjUuYyBiL3NvdW5kL3NvYy9jb2RlY3MvY3M0MjY1LmMK
aW5kZXggMjc1Njc3ZGU2NjlmLi40MDc1NTQxNzUyODIgMTAwNjQ0Ci0tLSBhL3NvdW5kL3NvYy9j
b2RlY3MvY3M0MjY1LmMKKysrIGIvc291bmQvc29jL2NvZGVjcy9jczQyNjUuYwpAQCAtMTU3LDgg
KzE1Nyw4IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgc25kX2tjb250cm9sX25ldyBjczQyNjVfc25k
X2NvbnRyb2xzW10gPSB7CiAJU09DX1NJTkdMRSgiVmFsaWRpdHkgQml0IENvbnRyb2wgU3dpdGNo
IiwgQ1M0MjY1X1NQRElGX0NUTDIsCiAJCQkJMywgMSwgMCksCiAJU09DX0VOVU0oIlNQRElGIE1v
bm8vU3RlcmVvIiwgc3BkaWZfbW9ub19zdGVyZW9fZW51bSksCi0JU09DX1NJTkdMRSgiTU1UTFIg
RGF0YSBTd2l0Y2giLCAwLAotCQkJCTEsIDEsIDApLAorCVNPQ19TSU5HTEUoIk1NVExSIERhdGEg
U3dpdGNoIiwgQ1M0MjY1X1NQRElGX0NUTDIsCisJCQkJMCwgMSwgMCksCiAJU09DX0VOVU0oIk1v
bm8gQ2hhbm5lbCBTZWxlY3QiLCBzcGRpZl9tb25vX3NlbGVjdF9lbnVtKSwKIAlTTkRfU09DX0JZ
VEVTKCJDIERhdGEgQnVmZmVyIiwgQ1M0MjY1X0NfREFUQV9CVUZGLCAyNCksCiB9OwotLSAKMi4x
Ni40CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNh
LWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21h
aWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
