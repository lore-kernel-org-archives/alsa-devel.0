From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH] ALSA: ASoC: Remove const attribute from
	lm49453's snd_soc_dai_driver
Date: Wed, 27 Jun 2012 09:34:36 +0200
Message-ID: <1340782476-5626-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
	by alsa0.perex.cz (Postfix) with ESMTP id 9ED37245E3
	for <alsa-devel@alsa-project.org>;
	Wed, 27 Jun 2012 09:35:14 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: broonie@opensource.wolfsonmicro.com, mr.swami.reddy@ti.com, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

Rml4ZXMgdGhlIGZvbGxvd2luZyBidWlsZCB3YXJuaW5nLgoKICBDQyAgICAgIHNvdW5kL3NvYy9j
b2RlY3MvbG00OTQ1My5vCnNvdW5kL3NvYy9jb2RlY3MvbG00OTQ1My5jOiBJbiBmdW5jdGlvbiDi
gJhsbTQ5NDUzX2kyY19wcm9iZeKAmToKc291bmQvc29jL2NvZGVjcy9sbTQ5NDUzLmM6MTUxMToy
NDogd2FybmluZzogcGFzc2luZyBhcmd1bWVudCAzIG9mCuKAmHNuZF9zb2NfcmVnaXN0ZXJfY29k
ZWPigJkgZGlzY2FyZHMgcXVhbGlmaWVycyBmcm9tIHBvaW50ZXIgdGFyZ2V0IHR5cGUKaW5jbHVk
ZS9zb3VuZC9zb2MuaDozMzM6NTogbm90ZTogZXhwZWN0ZWQg4oCYc3RydWN0IHNuZF9zb2NfZGFp
X2RyaXZlciAq4oCZCmJ1dCBhcmd1bWVudCBpcyBvZiB0eXBlIOKAmGNvbnN0IHN0cnVjdCBzbmRf
c29jX2RhaV9kcml2ZXIgKuKAmQoKU2lnbmVkLW9mZi1ieTogRGFuaWVsIE1hY2sgPHpvbnF1ZUBn
bWFpbC5jb20+Ci0tLQogc291bmQvc29jL2NvZGVjcy9sbTQ5NDUzLmMgfCAgICAyICstCiAxIGZp
bGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9z
b3VuZC9zb2MvY29kZWNzL2xtNDk0NTMuYyBiL3NvdW5kL3NvYy9jb2RlY3MvbG00OTQ1My5jCmlu
ZGV4IDgwMmI5ZjEuLjViZDEyOTQgMTAwNjQ0Ci0tLSBhL3NvdW5kL3NvYy9jb2RlY3MvbG00OTQ1
My5jCisrKyBiL3NvdW5kL3NvYy9jb2RlY3MvbG00OTQ1My5jCkBAIC0xMzU4LDcgKzEzNTgsNyBA
QCBzdGF0aWMgc3RydWN0IHNuZF9zb2NfZGFpX29wcyBsbTQ5NDUzX2xpbmVvdXRfZGFpX29wcyA9
IHsKIH07CiAKIC8qIExNNDk0NTMgZGFpIHN0cnVjdHVyZS4gKi8KLXN0YXRpYyBjb25zdCBzdHJ1
Y3Qgc25kX3NvY19kYWlfZHJpdmVyIGxtNDk0NTNfZGFpW10gPSB7CitzdGF0aWMgc3RydWN0IHNu
ZF9zb2NfZGFpX2RyaXZlciBsbTQ5NDUzX2RhaVtdID0gewogCXsKIAkJLm5hbWUgPSAiTE00OTQ1
MyBIZWFkc2V0IiwKIAkJLnBsYXliYWNrID0gewotLSAKMS43LjEwLjIKCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0
CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qu
b3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
