From: nrubinstein@aldebaran-robotics.com
Subject: [PATCH - ucm 1/1] ucm: set active_verb when set_verb
	was successful
Date: Wed,  4 Jun 2014 18:52:25 +0200
Message-ID: <1401900745-22796-1-git-send-email-nrubinstein@aldebaran-robotics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-we0-f176.google.com (mail-we0-f176.google.com
 [74.125.82.176])
 by alsa0.perex.cz (Postfix) with ESMTP id 6857A2650AF
 for <alsa-devel@alsa-project.org>; Wed,  4 Jun 2014 18:52:44 +0200 (CEST)
Received: by mail-we0-f176.google.com with SMTP id q59so8618475wes.21
 for <alsa-devel@alsa-project.org>; Wed, 04 Jun 2014 09:52:44 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: =?UTF-8?q?No=C3=A9=20Rubinstein?= <nrubinstein@aldebaran-robotics.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

RnJvbTogTm/DqSBSdWJpbnN0ZWluIDxucnViaW5zdGVpbkBhbGRlYmFyYW4tcm9ib3RpY3MuY29t
PgoKVGhpcyBzZWVtcyB0byBiZSBhIGJ1ZzogZXhlY3V0ZV9zZXF1ZW5jZSByZXR1cm5zIHplcm8g
b24gc3VjY2VzcywKdGhlcmVmb3JlIHRoZSBjdXJyZW50IGNvZGUgY2hhbmdlcyB0aGUgYWN0aXZl
X3ZlcmIgaWZmIGV4ZWN1dGVfc2VxdWVuY2UKZmFpbGVkLgoKU2lnbmVkLW9mZi1ieTogTm/DqSBS
dWJpbnN0ZWluIDxucnViaW5zdGVpbkBhbGRlYmFyYW4tcm9ib3RpY3MuY29tPgoKZGlmZiAtLWdp
dCBhL3NyYy91Y20vbWFpbi5jIGIvc3JjL3VjbS9tYWluLmMKaW5kZXggMDQ5NDcyOC4uM2MwZDdl
NCAxMDA2NDQKLS0tIGEvc3JjL3VjbS9tYWluLmMKKysrIGIvc3JjL3VjbS9tYWluLmMKQEAgLTYy
Myw3ICs2MjMsNyBAQCBzdGF0aWMgaW50IHNldF92ZXJiKHNuZF91c2VfY2FzZV9tZ3JfdCAqdWNf
bWdyLAogCQkJICAgICAgICZ2ZXJiLT52YWx1ZV9saXN0LAogCQkJICAgICAgICZ1Y19tZ3ItPnZh
bHVlX2xpc3QsCiAJCQkgICAgICAgTlVMTCk7Ci0JaWYgKGVuYWJsZSAmJiBlcnIgPj0gMCkKKwlp
ZiAoZW5hYmxlICYmIGVyciA9PSAwKQogCQl1Y19tZ3ItPmFjdGl2ZV92ZXJiID0gdmVyYjsKIAly
ZXR1cm4gZXJyOwogfQotLSAKMS45LjIKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1w
cm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlzdGlu
Zm8vYWxzYS1kZXZlbAo=
