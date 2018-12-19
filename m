From: =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH 4/4] ASoC: wm8904: enable MCLK in STANDBY
Date: Wed, 19 Dec 2018 21:11:16 +0100
Message-ID: <af3940da408c4489678afcc82760356339e0dc0c.1545249666.git.mirq-linux@rere.qmqm.pl>
References: <cover.1545249666.git.mirq-linux@rere.qmqm.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rere.qmqm.pl (rere.qmqm.pl [91.227.64.183])
 by alsa0.perex.cz (Postfix) with ESMTP id 4C1C826782E
 for <alsa-devel@alsa-project.org>; Wed, 19 Dec 2018 21:11:16 +0100 (CET)
In-Reply-To: <cover.1545249666.git.mirq-linux@rere.qmqm.pl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: patches@opensource.cirrus.com, alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

TUNMSyBpbnB1dCBpcyBuZWVkZWQgd2hlbiBhY2Nlc3NpbmcgYW55IHJlZ2lzdGVyIGFmdGVyIGVu
YWJsaW5nIFNZU0NMSy4KClRoaXMgYWxzbyBmaXhlcyBpbWJhbGFuY2Ugb2YgY2xrX2VuYWJsZSAv
IGNsa19kaXNhYmxlIHdoZW4gdHJhbnNpdGlvbmluZwpiZXR3ZWVuIE9OIC0+IFNUQU5EQlkgLT4g
T04gYmlhcyBsZXZlbHMuCgpTaWduZWQtb2ZmLWJ5OiBNaWNoYcWCIE1pcm9zxYJhdyA8bWlycS1s
aW51eEByZXJlLnFtcW0ucGw+Ci0tLQogc291bmQvc29jL2NvZGVjcy93bTg5MDQuYyB8IDEyICsr
KysrKysrKy0tLQogMSBmaWxlIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMo
LSkKCmRpZmYgLS1naXQgYS9zb3VuZC9zb2MvY29kZWNzL3dtODkwNC5jIGIvc291bmQvc29jL2Nv
ZGVjcy93bTg5MDQuYwppbmRleCAyODEzYjdmNmE1OGUuLjlmMDE2N2EzOWU1MSAxMDA2NDQKLS0t
IGEvc291bmQvc29jL2NvZGVjcy93bTg5MDQuYworKysgYi9zb3VuZC9zb2MvY29kZWNzL3dtODkw
NC5jCkBAIC0xODUyLDkgKzE4NTIsNiBAQCBzdGF0aWMgaW50IHdtODkwNF9zZXRfYmlhc19sZXZl
bChzdHJ1Y3Qgc25kX3NvY19jb21wb25lbnQgKmNvbXBvbmVudCwKIAogCXN3aXRjaCAobGV2ZWwp
IHsKIAljYXNlIFNORF9TT0NfQklBU19PTjoKLQkJcmV0ID0gY2xrX3ByZXBhcmVfZW5hYmxlKHdt
ODkwNC0+bWNsayk7Ci0JCWlmIChyZXQpCi0JCQlyZXR1cm4gcmV0OwogCQlicmVhazsKIAogCWNh
c2UgU05EX1NPQ19CSUFTX1BSRVBBUkU6CkBAIC0xODc5LDYgKzE4NzYsMTUgQEAgc3RhdGljIGlu
dCB3bTg5MDRfc2V0X2JpYXNfbGV2ZWwoc3RydWN0IHNuZF9zb2NfY29tcG9uZW50ICpjb21wb25l
bnQsCiAJCQkJcmV0dXJuIHJldDsKIAkJCX0KIAorCQkJcmV0ID0gY2xrX3ByZXBhcmVfZW5hYmxl
KHdtODkwNC0+bWNsayk7CisJCQlpZiAocmV0KSB7CisJCQkJZGV2X2Vycihjb21wb25lbnQtPmRl
diwKKwkJCQkJIkZhaWxlZCB0byBlbmFibGUgTUNMSzogJWRcbiIsIHJldCk7CisJCQkJcmVndWxh
dG9yX2J1bGtfZGlzYWJsZShBUlJBWV9TSVpFKHdtODkwNC0+c3VwcGxpZXMpLAorCQkJCQkJICAg
ICAgIHdtODkwNC0+c3VwcGxpZXMpOworCQkJCXJldHVybiByZXQ7CisJCQl9CisKIAkJCXJlZ2Nh
Y2hlX2NhY2hlX29ubHkod204OTA0LT5yZWdtYXAsIGZhbHNlKTsKIAkJCXJlZ2NhY2hlX3N5bmMo
d204OTA0LT5yZWdtYXApOwogCi0tIAoyLjE5LjIKCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxA
YWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4v
bGlzdGluZm8vYWxzYS1kZXZlbAo=
