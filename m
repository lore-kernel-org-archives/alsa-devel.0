From: =?UTF-8?q?Daniel=20Gl=C3=B6ckner?= <daniel-gl@gmx.net>
Subject: [PATCH 1/3] s6000-i2s: fix compilation
Date: Tue, 30 Nov 2010 01:00:16 +0100
Message-ID: <1291075218-7849-1-git-send-email-daniel-gl@gmx.net>
References: <20101129104228.GM30360@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gmx.net (mailout-de.gmx.net [213.165.64.23])
	by alsa0.perex.cz (Postfix) with SMTP id 1ADB2103816
	for <alsa-devel@alsa-project.org>; Tue, 30 Nov 2010 01:01:30 +0100 (CET)
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

QSBzZW1pY29sb24gd2FzIG1pc3NpbmcuCgpTaWduZWQtb2ZmLWJ5OiBEYW5pZWwgR2zDtmNrbmVy
IDxkYW5pZWwtZ2xAZ214Lm5ldD4KLS0tCiBzb3VuZC9zb2MvczYwMDAvczYwMDAtaTJzLmMgfCAg
ICAyICstCiAxIGZpbGVzIGNoYW5nZWQsIDEgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbnMoLSkK
CmRpZmYgLS1naXQgYS9zb3VuZC9zb2MvczYwMDAvczYwMDAtaTJzLmMgYi9zb3VuZC9zb2MvczYw
MDAvczYwMDAtaTJzLmMKaW5kZXggODc3OGZhYS4uMzA1MmY2NCAxMDA2NDQKLS0tIGEvc291bmQv
c29jL3M2MDAwL3M2MDAwLWkycy5jCisrKyBiL3NvdW5kL3NvYy9zNjAwMC9zNjAwMC1pMnMuYwpA
QCAtNDM0LDcgKzQzNCw3IEBAIHN0YXRpYyBzdHJ1Y3Qgc25kX3NvY19kYWlfZHJpdmVyIHM2MDAw
X2kyc19kYWkgPSB7CiAJCS5yYXRlX21heCA9IDE1NjI1MDAsCiAJfSwKIAkub3BzID0gJnM2MDAw
X2kyc19kYWlfb3BzLAotfQorfTsKIAogc3RhdGljIGludCBfX2RldmluaXQgczYwMDBfaTJzX3By
b2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpCiB7Ci0tIAoxLjcuMC41CgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxp
bmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1w
cm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
