From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Subject: [PATCH 5/6] ASoC: ad1980: verify cache at probe time
Date: Tue, 24 Aug 2010 15:09:43 +0200
Message-ID: <1282655384-13357-5-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1282655384-13357-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id F12F2246CF
	for <alsa-devel@alsa-project.org>;
	Tue, 24 Aug 2010 15:09:55 +0200 (CEST)
In-Reply-To: <1282655384-13357-1-git-send-email-u.kleine-koenig@pengutronix.de>
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
List-Id: alsa-devel@alsa-project.org

U2lnbmVkLW9mZi1ieTogVXdlIEtsZWluZS1Lw7ZuaWcgPHUua2xlaW5lLWtvZW5pZ0BwZW5ndXRy
b25peC5kZT4KLS0tCiBzb3VuZC9zb2MvY29kZWNzL2FkMTk4MC5jIHwgICAxMyArKysrKysrKysr
KysrCiAxIGZpbGVzIGNoYW5nZWQsIDEzIGluc2VydGlvbnMoKyksIDAgZGVsZXRpb25zKC0pCgpk
aWZmIC0tZ2l0IGEvc291bmQvc29jL2NvZGVjcy9hZDE5ODAuYyBiL3NvdW5kL3NvYy9jb2RlY3Mv
YWQxOTgwLmMKaW5kZXggODY0ZTY1ZC4uYTNlNzhkNCAxMDA2NDQKLS0tIGEvc291bmQvc29jL2Nv
ZGVjcy9hZDE5ODAuYworKysgYi9zb3VuZC9zb2MvY29kZWNzL2FkMTk4MC5jCkBAIC0yODgsNiAr
Mjg4LDE5IEBAIHN0YXRpYyBpbnQgYWQxOTgwX3NvY19wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2
aWNlICpwZGV2KQogCXNuZF9zb2NfYWRkX2NvbnRyb2xzKGNvZGVjLCBhZDE5ODBfc25kX2FjOTdf
Y29udHJvbHMsCiAJCQkJQVJSQVlfU0laRShhZDE5ODBfc25kX2FjOTdfY29udHJvbHMpKTsKIAor
I2lmIEFDOTdfVVNFX0NBQ0hFCisJcHJfZGVidWcoIiVzOiBjYWNoZSB2ZXJpZnlcbiIsIF9fZnVu
Y19fKTsKKwlmb3IgKHZlbmRvcl9pZDIgPSAwOyB2ZW5kb3JfaWQyIDwgMHg4MDsgdmVuZG9yX2lk
MiArPSAyKSB7CisKKwkJdTE2ICpjYWNoZSA9IGNvZGVjLT5yZWdfY2FjaGU7CisJCXJldCA9IHNv
Y19hYzk3X29wcy5yZWFkKGNvZGVjLT5hYzk3LCB2ZW5kb3JfaWQyKTsKKwkJaWYgKHJldCAhPSBj
YWNoZVt2ZW5kb3JfaWQyID4+IDFdKQorCQkJcHJfZGVidWcoIiVzOiAlMDJ4IC0+ICUwNHhcbiIs
CisJCQkJCV9fZnVuY19fLCB2ZW5kb3JfaWQyLCByZXQpOworCX0KKwlwcl9kZWJ1ZygiJXM6IC9j
YWNoZSB2ZXJpZnlcbiIsIF9fZnVuY19fKTsKKyNlbmRpZgorCiAJcmV0dXJuIDA7CiAKIHJlc2V0
X2VycjoKLS0gCjEuNy4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5v
cmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2Et
ZGV2ZWwK
