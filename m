From: =?UTF-8?q?Daniel=20Gl=C3=B6ckner?= <daniel-gl@gmx.net>
Subject: [PATCH 2/3] s6000-pcm: fix compilation
Date: Tue, 30 Nov 2010 01:00:17 +0100
Message-ID: <1291075218-7849-2-git-send-email-daniel-gl@gmx.net>
References: <20101129104228.GM30360@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gmx.net (mailout-de.gmx.net [213.165.64.23])
	by alsa0.perex.cz (Postfix) with SMTP id 59948103816
	for <alsa-devel@alsa-project.org>; Tue, 30 Nov 2010 01:01:37 +0100 (CET)
In-Reply-To: <20101129104228.GM30360@rakim.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, =?UTF-8?q?Daniel=20Gl=C3=B6ckner?= <daniel-gl@gmx.net>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

czYwMDBfc29jX3BsYXRmb3JtIGhhcyBsb3N0IGl0cyBmb3J3YXJkIGRlY2xhcmF0aW9uIGFuZCB0
aGVyZSBubwpsb25nZXIgaXMgYSBuYW1lIGVsZW1lbnQgaW4gaXQsIHNvIHVzZSBhIHN0cmluZyBj
b25zdGFudCB3aGVuCmNhbGxpbmcgcmVxdWVzdF9pcnEuCgpTaWduZWQtb2ZmLWJ5OiBEYW5pZWwg
R2zDtmNrbmVyIDxkYW5pZWwtZ2xAZ214Lm5ldD4KLS0tCiBzb3VuZC9zb2MvczYwMDAvczYwMDAt
cGNtLmMgfCAgICAyICstCiAxIGZpbGVzIGNoYW5nZWQsIDEgaW5zZXJ0aW9ucygrKSwgMSBkZWxl
dGlvbnMoLSkKCmRpZmYgLS1naXQgYS9zb3VuZC9zb2MvczYwMDAvczYwMDAtcGNtLmMgYi9zb3Vu
ZC9zb2MvczYwMDAvczYwMDAtcGNtLmMKaW5kZXggMjcxZmQyMi4uYWIzY2NhZSAxMDA2NDQKLS0t
IGEvc291bmQvc29jL3M2MDAwL3M2MDAwLXBjbS5jCisrKyBiL3NvdW5kL3NvYy9zNjAwMC9zNjAw
MC1wY20uYwpAQCAtNDczLDcgKzQ3Myw3IEBAIHN0YXRpYyBpbnQgczYwMDBfcGNtX25ldyhzdHJ1
Y3Qgc25kX2NhcmQgKmNhcmQsCiAJfQogCiAJcmVzID0gcmVxdWVzdF9pcnEocGFyYW1zLT5pcnEs
IHM2MDAwX3BjbV9pcnEsIElSUUZfU0hBUkVELAotCQkJICBzNjAwMF9zb2NfcGxhdGZvcm0ubmFt
ZSwgcGNtKTsKKwkJCSAgInM2MDAwLWF1ZGlvIiwgcGNtKTsKIAlpZiAocmVzKSB7CiAJCXByaW50
ayhLRVJOX0VSUiAiczYwMDAtcGNtIGNvdWxkbid0IGdldCBJUlFcbiIpOwogCQlyZXR1cm4gcmVz
OwotLSAKMS43LjAuNQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3Jn
Cmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRl
dmVsCg==
