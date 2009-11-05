From: =?UTF-8?q?R=C3=A9mi=20Denis-Courmont?= <remi@remlab.net>
Subject: [PATCH 1/3] Open device nodes with close-on-exec flag
Date: Thu,  5 Nov 2009 21:17:40 +0200
Message-ID: <1257448662-5124-1-git-send-email-remi@remlab.net>
References: <200911052116.53251.remi@remlab.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yop.chewa.net (yop.chewa.net [91.121.105.214])
	by alsa0.perex.cz (Postfix) with ESMTP id ADF03103969
	for <alsa-devel@alsa-project.org>; Thu,  5 Nov 2009 20:17:43 +0100 (CET)
Received: from basile.remlab.net (localhost.localdomain [127.0.0.1])
	by yop.chewa.net (Postfix) with SMTP id 62EAF35F
	for <alsa-devel@alsa-project.org>; Thu,  5 Nov 2009 20:17:42 +0100 (CET)
In-Reply-To: <200911052116.53251.remi@remlab.net>
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
CiBpbmNsdWRlL2xvY2FsLmggfCAgIDE3ICsrKysrKysrKysrLS0tLS0tCiAxIGZpbGVzIGNoYW5n
ZWQsIDExIGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvaW5jbHVk
ZS9sb2NhbC5oIGIvaW5jbHVkZS9sb2NhbC5oCmluZGV4IGI1YTFjNDUuLmFmYzRhY2QgMTAwNjQ0
Ci0tLSBhL2luY2x1ZGUvbG9jYWwuaAorKysgYi9pbmNsdWRlL2xvY2FsLmgKQEAgLTIzMCwyMiAr
MjMwLDI3IEBAIGV4dGVybiBzbmRfbGliX2Vycm9yX2hhbmRsZXJfdCBzbmRfZXJyX21zZzsKICMg
ZGVmaW5lIGxpbmtfd2FybmluZyhzeW1ib2wsIG1zZykKICNlbmRpZgogCi0vKiBvcGVuIHdpdGgg
cmVzbWdyICovCi0jaWZkZWYgU1VQUE9SVF9SRVNNR1IKIHN0YXRpYyBpbmxpbmUgaW50IHNuZF9v
cGVuX2RldmljZShjb25zdCBjaGFyICpmaWxlbmFtZSwgaW50IGZtb2RlKQogeworI2lmZGVmIE9f
Q0xPRVhFQworCWludCBmZCA9IG9wZW4oZmlsZW5hbWUsIGZtb2RlfE9fQ0xPRVhFQyk7CisjZWxz
ZQogCWludCBmZCA9IG9wZW4oZmlsZW5hbWUsIGZtb2RlKTsKLQlpZiAoZmQgPj0gMCkKKyNlbmRp
ZgorCWlmIChmZCA+PSAwKSB7CisJCWZjbnRsKGZkLCBGX1NFVEZELCBGRF9DTE9FWEVDKTsKIAkJ
cmV0dXJuIGZkOworCX0KKworLyogb3BlbiB3aXRoIHJlc21nciAqLworI2lmZGVmIFNVUFBPUlRf
UkVTTUdSCiAJaWYgKGVycm5vID09IEVBR0FJTiB8fCBlcnJubyA9PSBFQlVTWSkKIAkJcmV0dXJu
IGZkOwogCWlmICghIGFjY2VzcyhmaWxlbmFtZSwgRl9PSykpCiAJCXJldHVybiByc21fb3Blbl9k
ZXZpY2UoZmlsZW5hbWUsIGZtb2RlKTsKKyNlbmRpZgogCXJldHVybiAtMTsKIH0KLSNlbHNlCi0j
ZGVmaW5lIHNuZF9vcGVuX2RldmljZShmaWxlbmFtZSwgZm1vZGUpIG9wZW4oZmlsZW5hbWUsIGZt
b2RlKTsKLSNlbmRpZgogCiAvKiBtYWtlIGxvY2FsIGZ1bmN0aW9ucyByZWFsbHkgbG9jYWwgKi8K
ICNkZWZpbmUgc25kX2Rsb2JqX2NhY2hlX2xvb2t1cCBcCi0tIAoxLjYuNS4yCgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcg
bGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9q
ZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
