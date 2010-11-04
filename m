From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 2/7] ASoC i.MX eukrea tlv320: Fix for
	multicomponent
Date: Thu,  4 Nov 2010 17:05:40 +0100
Message-ID: <1288886745-25977-3-git-send-email-s.hauer@pengutronix.de>
References: <1288886745-25977-1-git-send-email-s.hauer@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id D09BC1038AE
	for <alsa-devel@alsa-project.org>; Thu,  4 Nov 2010 17:05:48 +0100 (CET)
In-Reply-To: <1288886745-25977-1-git-send-email-s.hauer@pengutronix.de>
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
Cc: Sascha Hauer <s.hauer@pengutronix.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, =?UTF-8?q?Eric=20B=C3=A9nard?= <eric@eukrea.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

U2lnbmVkLW9mZi1ieTogU2FzY2hhIEhhdWVyIDxzLmhhdWVyQHBlbmd1dHJvbml4LmRlPgpDYzog
RXJpYyBCw6luYXJkIDxlcmljQGV1a3JlYS5jb20+Ci0tLQogc291bmQvc29jL2lteC9ldWtyZWEt
dGx2MzIwLmMgfCAgICA4ICsrKystLS0tCiAxIGZpbGVzIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygr
KSwgNCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9zb3VuZC9zb2MvaW14L2V1a3JlYS10bHYz
MjAuYyBiL3NvdW5kL3NvYy9pbXgvZXVrcmVhLXRsdjMyMC5jCmluZGV4IGI1OTY3NTIuLmRkNGZm
ZmQgMTAwNjQ0Ci0tLSBhL3NvdW5kL3NvYy9pbXgvZXVrcmVhLXRsdjMyMC5jCisrKyBiL3NvdW5k
L3NvYy9pbXgvZXVrcmVhLXRsdjMyMC5jCkBAIC0zNCw4ICszNCw4IEBAIHN0YXRpYyBpbnQgZXVr
cmVhX3RsdjMyMF9od19wYXJhbXMoc3RydWN0IHNuZF9wY21fc3Vic3RyZWFtICpzdWJzdHJlYW0s
CiAJCQkgICAgc3RydWN0IHNuZF9wY21faHdfcGFyYW1zICpwYXJhbXMpCiB7CiAJc3RydWN0IHNu
ZF9zb2NfcGNtX3J1bnRpbWUgKnJ0ZCA9IHN1YnN0cmVhbS0+cHJpdmF0ZV9kYXRhOwotCXN0cnVj
dCBzbmRfc29jX2RhaSAqY29kZWNfZGFpID0gcnRkLT5kYWktPmNvZGVjX2RhaTsKLQlzdHJ1Y3Qg
c25kX3NvY19kYWkgKmNwdV9kYWkgPSBydGQtPmRhaS0+Y3B1X2RhaTsKKwlzdHJ1Y3Qgc25kX3Nv
Y19kYWkgKmNvZGVjX2RhaSA9IHJ0ZC0+Y29kZWNfZGFpOworCXN0cnVjdCBzbmRfc29jX2RhaSAq
Y3B1X2RhaSA9IHJ0ZC0+Y3B1X2RhaTsKIAlpbnQgcmV0OwogCiAJcmV0ID0gc25kX3NvY19kYWlf
c2V0X2ZtdChjcHVfZGFpLCBTTkRfU09DX0RBSUZNVF9JMlMgfApAQCAtNzksMTAgKzc5LDEwIEBA
IHN0YXRpYyBzdHJ1Y3Qgc25kX3NvY19vcHMgZXVrcmVhX3RsdjMyMF9zbmRfb3BzID0gewogc3Rh
dGljIHN0cnVjdCBzbmRfc29jX2RhaV9saW5rIGV1a3JlYV90bHYzMjBfZGFpID0gewogCS5uYW1l
CQk9ICJ0bHYzMjBhaWMyMyIsCiAJLnN0cmVhbV9uYW1lCT0gIlRMVjMyMEFJQzIzIiwKLQkuY29k
ZWNfZGFpCT0gInRsdjMyMGFpYzIzLWhpZmkiLAorCS5jb2RlY19kYWlfbmFtZQk9ICJ0bHYzMjBh
aWMyMy1oaWZpIiwKIAkucGxhdGZvcm1fbmFtZQk9ICJpbXgtcGNtLWF1ZGlvLjAiLAogCS5jb2Rl
Y19uYW1lCT0gInRsdjMyMGFpYzIzLWNvZGVjLjAtMDAxYSIsCi0JLmNwdV9kYWkgPSAiaW14LXNz
aS4wIiwKKwkuY3B1X2RhaV9uYW1lCT0gImlteC1zc2kuMCIsCiAJLm9wcwkJPSAmZXVrcmVhX3Rs
djMyMF9zbmRfb3BzLAogfTsKIAotLSAKMS43LjIuMwoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZl
bEBhbHNhLXByb2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1h
bi9saXN0aW5mby9hbHNhLWRldmVsCg==
