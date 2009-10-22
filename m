From: =?UTF-8?q?R=C3=A9mi=20Denis-Courmont?= <rem@videolan.org>
Subject: [PATCH alsa-lib 1/3] Open device nodes with
	close-on-exec flag
Date: Thu, 22 Oct 2009 18:01:26 +0300
Message-ID: <1256223688-3501-1-git-send-email-rem@videolan.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yop.chewa.net (yop.chewa.net [91.121.105.214])
	by alsa0.perex.cz (Postfix) with ESMTP id E4006243FB
	for <alsa-devel@alsa-project.org>;
	Thu, 22 Oct 2009 17:01:29 +0200 (CEST)
Received: from basile.remlab.net (localhost.localdomain [127.0.0.1])
	by yop.chewa.net (Postfix) with SMTP id 8D9727A5
	for <alsa-devel@alsa-project.org>;
	Thu, 22 Oct 2009 17:01:28 +0200 (CEST)
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

RnJvbTogUsOpbWkgRGVuaXMtQ291cm1vbnQgPHJlbWlAcmVtbGFiLm5ldD4KClRoaXMgYXZvaWQg
bGVha2luZyBkZXZpY2UgZGVzY3JpcHRvcnMgdGhyb3VnaCBleGVjLiBUaHVzIEFMU0EKYXBwbGlj
YXRpb25zIGNhbiBzYWZlbHkgc3Bhd24gb3RoZXIgcHJvY2Vzc2VzIGluIHRoZWlyIGJhY2tncm91
bmQuCgpTaWduZWQtb2ZmLWJ5OiBSw6ltaSBEZW5pcy1Db3VybW9udCA8cmVtaUByZW1sYWIubmV0
PgotLS0KIGluY2x1ZGUvbG9jYWwuaCB8ICAgMjMgKysrKysrKysrKysrKysrKystLS0tLS0KIDEg
ZmlsZXMgY2hhbmdlZCwgMTcgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkKCmRpZmYgLS1n
aXQgYS9pbmNsdWRlL2xvY2FsLmggYi9pbmNsdWRlL2xvY2FsLmgKaW5kZXggYjVhMWM0NS4uNWI1
NGRlZiAxMDA2NDQKLS0tIGEvaW5jbHVkZS9sb2NhbC5oCisrKyBiL2luY2x1ZGUvbG9jYWwuaApA
QCAtMjMwLDIyICsyMzAsMzMgQEAgZXh0ZXJuIHNuZF9saWJfZXJyb3JfaGFuZGxlcl90IHNuZF9l
cnJfbXNnOwogIyBkZWZpbmUgbGlua193YXJuaW5nKHN5bWJvbCwgbXNnKQogI2VuZGlmCiAKLS8q
IG9wZW4gd2l0aCByZXNtZ3IgKi8KLSNpZmRlZiBTVVBQT1JUX1JFU01HUgogc3RhdGljIGlubGlu
ZSBpbnQgc25kX29wZW5fZGV2aWNlKGNvbnN0IGNoYXIgKmZpbGVuYW1lLCBpbnQgZm1vZGUpCiB7
Ci0JaW50IGZkID0gb3BlbihmaWxlbmFtZSwgZm1vZGUpOworCWludCBmZDsKKworI2lmZGVmIE9f
Q0xPRVhFQworCWZkID0gb3BlbihmaWxlbmFtZSwgZm1vZGV8T19DTE9FWEVDKTsKIAlpZiAoZmQg
Pj0gMCkKIAkJcmV0dXJuIGZkOworCWlmIChlcnJubyA9PSBFSU5WQUwpCisjZW5kaWYKKwl7CisJ
CWZkID0gb3BlbihmaWxlbmFtZSwgZm1vZGUpOworCQlpZiAoZmQgPj0gMCkgeworCQkJZmNudGwo
ZmQsIEZfU0VURkQsIEZEX0NMT0VYRUMpOworCQkJcmV0dXJuIGZkOworCQl9CisJfQorCisvKiBv
cGVuIHdpdGggcmVzbWdyICovCisjaWZkZWYgU1VQUE9SVF9SRVNNR1IKIAlpZiAoZXJybm8gPT0g
RUFHQUlOIHx8IGVycm5vID09IEVCVVNZKQogCQlyZXR1cm4gZmQ7CiAJaWYgKCEgYWNjZXNzKGZp
bGVuYW1lLCBGX09LKSkKIAkJcmV0dXJuIHJzbV9vcGVuX2RldmljZShmaWxlbmFtZSwgZm1vZGUp
OworI2VuZGlmCiAJcmV0dXJuIC0xOwogfQotI2Vsc2UKLSNkZWZpbmUgc25kX29wZW5fZGV2aWNl
KGZpbGVuYW1lLCBmbW9kZSkgb3BlbihmaWxlbmFtZSwgZm1vZGUpOwotI2VuZGlmCiAKIC8qIG1h
a2UgbG9jYWwgZnVuY3Rpb25zIHJlYWxseSBsb2NhbCAqLwogI2RlZmluZSBzbmRfZGxvYmpfY2Fj
aGVfbG9va3VwIFwKLS0gCjEuNi41CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJv
amVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2Fsc2EtZGV2ZWwK
