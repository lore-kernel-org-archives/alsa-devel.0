From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Subject: [PATCH 1/6] ASoC: ad1980: Stay in 20bit mode for
	architectures other than blackfin
Date: Tue, 24 Aug 2010 15:09:39 +0200
Message-ID: <1282655384-13357-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 0558E246D3
	for <alsa-devel@alsa-project.org>;
	Tue, 24 Aug 2010 15:09:56 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Sonic Zhang <sonic.zhang@analog.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
List-Id: alsa-devel@alsa-project.org

RnJvbTogU2FzY2hhIEhhdWVyIDxzLmhhdWVyQHBlbmd1dHJvbml4LmRlPgoKU2lnbmVkLW9mZi1i
eTogU2FzY2hhIEhhdWVyIDxzLmhhdWVyQHBlbmd1dHJvbml4LmRlPgpTaWduZWQtb2ZmLWJ5OiBV
d2UgS2xlaW5lLUvDtm5pZyA8dS5rbGVpbmUta29lbmlnQHBlbmd1dHJvbml4LmRlPgotLS0KIHNv
dW5kL3NvYy9jb2RlY3MvYWQxOTgwLmMgfCAgIDEwICsrKysrKysrKy0KIDEgZmlsZXMgY2hhbmdl
ZCwgOSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3NvdW5kL3Nv
Yy9jb2RlY3MvYWQxOTgwLmMgYi9zb3VuZC9zb2MvY29kZWNzL2FkMTk4MC5jCmluZGV4IDcwY2Zh
ZWMuLjM1YzA1ODAgMTAwNjQ0Ci0tLSBhL3NvdW5kL3NvYy9jb2RlY3MvYWQxOTgwLmMKKysrIGIv
c291bmQvc29jL2NvZGVjcy9hZDE5ODAuYwpAQCAtMTY4LDEzICsxNjgsMjEgQEAgcmV0cnk6CiAJ
fQogCiAJc29jX2FjOTdfb3BzLnJlc2V0KGNvZGVjLT5hYzk3KTsKKworI2lmZGVmIFNORF9CRjVY
WF9TT0NfQUQxOTgwCiAJLyogU2V0IGJpdCAxNnNsb3QgaW4gcmVnaXN0ZXIgNzRoLCB0aGVuIGV2
ZXJ5IHNsb3Qgd2lsbCBoYXMgb25seSAxNgogCSAqIGJpdHMuIFRoaXMgY29tbWFuZCBpcyBzZW50
IG91dCBpbiAyMGJpdCBtb2RlLCBpbiB3aGljaCBjYXNlIHRoZQotCSAqIGZpcnN0IG5pYmJsZSBv
ZiBkYXRhIGlzIGVhdGVuIGJ5IHRoZSBhZGRyLiAoVGFnIGlzIGFsd2F5cyAxNiBiaXQpKi8KKwkg
KiBmaXJzdCBuaWJibGUgb2YgZGF0YSBpcyBlYXRlbiBieSB0aGUgYWRkci4gKFRhZyBpcyBhbHdh
eXMgMTYgYml0KS4KKwkgKgorCSAqIFRoaXMgc2VlbXMgdG8gYmUgYmxhY2tmaW4gc3BlY2lmaWMu
IE9uIG90aGVyIHN5c3RlbXMgd2Ugd2FudCAyMGJpdAorCSAqIG1vZGUuCisJICovCiAJYWM5N193
cml0ZShjb2RlYywgQUM5N19BRF9TRVJJQUxfQ0ZHLCAweDk5MDApOworI2VuZGlmCiAKIAlpZiAo
YWM5N19yZWFkKGNvZGVjLCBBQzk3X1JFU0VUKSAgIT0gMHgwMDkwKQogCQlnb3RvIGVycjsKKwog
CXJldHVybiAwOwogCiBlcnI6Ci0tIAoxLjcuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBh
bHNhLXByb2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9hbHNhLWRldmVsCg==
