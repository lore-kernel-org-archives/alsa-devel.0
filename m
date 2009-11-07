From: =?UTF-8?q?R=C3=A9mi=20Denis-Courmont?= <remi@remlab.net>
Subject: [PATCH 1/3] Open device nodes with close-on-exec flag
Date: Sat,  7 Nov 2009 21:29:23 +0200
Message-ID: <1257622163-28612-1-git-send-email-remi@remlab.net>
References: <200911072128.36583.remi@remlab.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yop.chewa.net (yop.chewa.net [91.121.105.214])
	by alsa0.perex.cz (Postfix) with ESMTP id 3280F246B7
	for <alsa-devel@alsa-project.org>; Sat,  7 Nov 2009 20:29:25 +0100 (CET)
Received: from basile.remlab.net (localhost.localdomain [127.0.0.1])
	by yop.chewa.net (Postfix) with SMTP id E24BC3C5
	for <alsa-devel@alsa-project.org>; Sat,  7 Nov 2009 20:29:23 +0100 (CET)
In-Reply-To: <200911072128.36583.remi@remlab.net>
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
List-Id: alsa-devel@alsa-project.org

U2lnbmVkLW9mZi1ieTogUsOpbWkgRGVuaXMtQ291cm1vbnQgPHJlbWlAcmVtbGFiLm5ldD4KLS0t
CiBpbmNsdWRlL2xvY2FsLmggfCAgIDMwICsrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLQog
MSBmaWxlcyBjaGFuZ2VkLCAxOCBpbnNlcnRpb25zKCspLCAxMiBkZWxldGlvbnMoLSkKCmRpZmYg
LS1naXQgYS9pbmNsdWRlL2xvY2FsLmggYi9pbmNsdWRlL2xvY2FsLmgKaW5kZXggYjVhMWM0NS4u
ZmEzZjBiNyAxMDA2NDQKLS0tIGEvaW5jbHVkZS9sb2NhbC5oCisrKyBiL2luY2x1ZGUvbG9jYWwu
aApAQCAtMjMwLDIyICsyMzAsMjggQEAgZXh0ZXJuIHNuZF9saWJfZXJyb3JfaGFuZGxlcl90IHNu
ZF9lcnJfbXNnOwogIyBkZWZpbmUgbGlua193YXJuaW5nKHN5bWJvbCwgbXNnKQogI2VuZGlmCiAK
LS8qIG9wZW4gd2l0aCByZXNtZ3IgKi8KLSNpZmRlZiBTVVBQT1JUX1JFU01HUgogc3RhdGljIGlu
bGluZSBpbnQgc25kX29wZW5fZGV2aWNlKGNvbnN0IGNoYXIgKmZpbGVuYW1lLCBpbnQgZm1vZGUp
CiB7Ci0JaW50IGZkID0gb3BlbihmaWxlbmFtZSwgZm1vZGUpOworCWludCBmZDsKKworI2lmZGVm
IE9fQ0xPRVhFQworCWZtb2RlIHw9IE9fQ0xPRVhFQzsKKyNlbmRpZgorCWZkID0gb3BlbihmaWxl
bmFtZSwgZm1vZGUpOworCisvKiBvcGVuIHdpdGggcmVzbWdyICovCisjaWZkZWYgU1VQUE9SVF9S
RVNNR1IKKwlpZiAoZmQgPCAwKSB7CisJCWlmIChlcnJubyA9PSBFQUdBSU4gfHwgZXJybm8gPT0g
RUJVU1kpCisJCQlyZXR1cm4gZmQ7CisJCWlmICghIGFjY2VzcyhmaWxlbmFtZSwgRl9PSykpCisJ
CQlmZCA9IHJzbV9vcGVuX2RldmljZShmaWxlbmFtZSwgZm1vZGUpOworCX0KKyNlbmRpZgogCWlm
IChmZCA+PSAwKQotCQlyZXR1cm4gZmQ7Ci0JaWYgKGVycm5vID09IEVBR0FJTiB8fCBlcnJubyA9
PSBFQlVTWSkKLQkJcmV0dXJuIGZkOwotCWlmICghIGFjY2VzcyhmaWxlbmFtZSwgRl9PSykpCi0J
CXJldHVybiByc21fb3Blbl9kZXZpY2UoZmlsZW5hbWUsIGZtb2RlKTsKLQlyZXR1cm4gLTE7CisJ
CWZjbnRsKGZkLCBGX1NFVEZELCBGRF9DTE9FWEVDKTsKKwlyZXR1cm4gZmQ7CiB9Ci0jZWxzZQot
I2RlZmluZSBzbmRfb3Blbl9kZXZpY2UoZmlsZW5hbWUsIGZtb2RlKSBvcGVuKGZpbGVuYW1lLCBm
bW9kZSk7Ci0jZW5kaWYKIAogLyogbWFrZSBsb2NhbCBmdW5jdGlvbnMgcmVhbGx5IGxvY2FsICov
CiAjZGVmaW5lIHNuZF9kbG9ial9jYWNoZV9sb29rdXAgXAotLSAKMS42LjUuMgoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5n
IGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJv
amVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
