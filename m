From: =?UTF-8?q?R=C3=A9mi=20Denis-Courmont?= <remi@remlab.net>
Subject: [PATCH 1/3] Open device nodes with close-on-exec flag
Date: Wed,  4 Nov 2009 20:38:51 +0200
Message-ID: <1257359933-3791-1-git-send-email-remi@remlab.net>
References: <200911042038.09618.rem@videolan.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yop.chewa.net (yop.chewa.net [91.121.105.214])
	by alsa0.perex.cz (Postfix) with ESMTP id 9CCC1103843
	for <alsa-devel@alsa-project.org>; Wed,  4 Nov 2009 19:38:54 +0100 (CET)
Received: from basile.remlab.net (localhost.localdomain [127.0.0.1])
	by yop.chewa.net (Postfix) with SMTP id 4F62F346
	for <alsa-devel@alsa-project.org>; Wed,  4 Nov 2009 19:38:53 +0100 (CET)
In-Reply-To: <200911042038.09618.rem@videolan.org>
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
CiBpbmNsdWRlL2xvY2FsLmggfCAgIDIzICsrKysrKysrKysrKysrKysrLS0tLS0tCiAxIGZpbGVz
IGNoYW5nZWQsIDE3IGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEv
aW5jbHVkZS9sb2NhbC5oIGIvaW5jbHVkZS9sb2NhbC5oCmluZGV4IGI1YTFjNDUuLjViNTRkZWYg
MTAwNjQ0Ci0tLSBhL2luY2x1ZGUvbG9jYWwuaAorKysgYi9pbmNsdWRlL2xvY2FsLmgKQEAgLTIz
MCwyMiArMjMwLDMzIEBAIGV4dGVybiBzbmRfbGliX2Vycm9yX2hhbmRsZXJfdCBzbmRfZXJyX21z
ZzsKICMgZGVmaW5lIGxpbmtfd2FybmluZyhzeW1ib2wsIG1zZykKICNlbmRpZgogCi0vKiBvcGVu
IHdpdGggcmVzbWdyICovCi0jaWZkZWYgU1VQUE9SVF9SRVNNR1IKIHN0YXRpYyBpbmxpbmUgaW50
IHNuZF9vcGVuX2RldmljZShjb25zdCBjaGFyICpmaWxlbmFtZSwgaW50IGZtb2RlKQogewotCWlu
dCBmZCA9IG9wZW4oZmlsZW5hbWUsIGZtb2RlKTsKKwlpbnQgZmQ7CisKKyNpZmRlZiBPX0NMT0VY
RUMKKwlmZCA9IG9wZW4oZmlsZW5hbWUsIGZtb2RlfE9fQ0xPRVhFQyk7CiAJaWYgKGZkID49IDAp
CiAJCXJldHVybiBmZDsKKwlpZiAoZXJybm8gPT0gRUlOVkFMKQorI2VuZGlmCisJeworCQlmZCA9
IG9wZW4oZmlsZW5hbWUsIGZtb2RlKTsKKwkJaWYgKGZkID49IDApIHsKKwkJCWZjbnRsKGZkLCBG
X1NFVEZELCBGRF9DTE9FWEVDKTsKKwkJCXJldHVybiBmZDsKKwkJfQorCX0KKworLyogb3BlbiB3
aXRoIHJlc21nciAqLworI2lmZGVmIFNVUFBPUlRfUkVTTUdSCiAJaWYgKGVycm5vID09IEVBR0FJ
TiB8fCBlcnJubyA9PSBFQlVTWSkKIAkJcmV0dXJuIGZkOwogCWlmICghIGFjY2VzcyhmaWxlbmFt
ZSwgRl9PSykpCiAJCXJldHVybiByc21fb3Blbl9kZXZpY2UoZmlsZW5hbWUsIGZtb2RlKTsKKyNl
bmRpZgogCXJldHVybiAtMTsKIH0KLSNlbHNlCi0jZGVmaW5lIHNuZF9vcGVuX2RldmljZShmaWxl
bmFtZSwgZm1vZGUpIG9wZW4oZmlsZW5hbWUsIGZtb2RlKTsKLSNlbmRpZgogCiAvKiBtYWtlIGxv
Y2FsIGZ1bmN0aW9ucyByZWFsbHkgbG9jYWwgKi8KICNkZWZpbmUgc25kX2Rsb2JqX2NhY2hlX2xv
b2t1cCBcCi0tIAoxLjYuNS4yCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVj
dC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fs
c2EtZGV2ZWwK
