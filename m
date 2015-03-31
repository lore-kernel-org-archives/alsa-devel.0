From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Subject: [PATCH v2 2/4] ASoC: fsi: mark several data structures
	as const
Date: Tue, 31 Mar 2015 16:48:57 +0200
Message-ID: <1427813339-23817-3-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1427813339-23817-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 47E39261B07
 for <alsa-devel@alsa-project.org>; Tue, 31 Mar 2015 16:49:08 +0200 (CEST)
In-Reply-To: <1427813339-23817-1-git-send-email-u.kleine-koenig@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org
Cc: Oder Chiou <oder_chiou@realtek.com>, Bard Liao <bardliao@realtek.com>, Fabian Frederick <fabf@skynet.be>, kernel@pengutronix.de
List-Id: alsa-devel@alsa-project.org

QSBkcml2ZXIncyBwbGF0Zm9ybV9kZXZpY2VfaWQgYW5kIGRldmljZSBkYXRhIHNob3VsZCBhbmQg
Y2FuIGJlIGNvbnN0LgoKU2lnbmVkLW9mZi1ieTogVXdlIEtsZWluZS1Lw7ZuaWcgPHUua2xlaW5l
LWtvZW5pZ0BwZW5ndXRyb25peC5kZT4KLS0tCiBzb3VuZC9zb2Mvc2gvZnNpLmMgfCA2ICsrKy0t
LQogMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkKCmRpZmYg
LS1naXQgYS9zb3VuZC9zb2Mvc2gvZnNpLmMgYi9zb3VuZC9zb2Mvc2gvZnNpLmMKaW5kZXggZTk0
OWYwNDY2ZWZmLi5jNGQ3MDMyNzRkN2EgMTAwNjQ0Ci0tLSBhL3NvdW5kL3NvYy9zaC9mc2kuYwor
KysgYi9zb3VuZC9zb2Mvc2gvZnNpLmMKQEAgLTE4ODIsNyArMTg4Miw3IEBAIHN0YXRpYyB2b2lk
IGZzaV9oYW5kbGVyX2luaXQoc3RydWN0IGZzaV9wcml2ICpmc2ksCiAJfQogfQogCi1zdGF0aWMg
c3RydWN0IGZzaV9jb3JlIGZzaTFfY29yZSA9IHsKK3N0YXRpYyBjb25zdCBzdHJ1Y3QgZnNpX2Nv
cmUgZnNpMV9jb3JlID0gewogCS52ZXIJPSAxLAogCiAJLyogSW50ZXJydXB0ICovCkBAIC0xODkx
LDcgKzE4OTEsNyBAQCBzdGF0aWMgc3RydWN0IGZzaV9jb3JlIGZzaTFfY29yZSA9IHsKIAkuaW1z
awk9IElNU0ssCiB9OwogCi1zdGF0aWMgc3RydWN0IGZzaV9jb3JlIGZzaTJfY29yZSA9IHsKK3N0
YXRpYyBjb25zdCBzdHJ1Y3QgZnNpX2NvcmUgZnNpMl9jb3JlID0gewogCS52ZXIJPSAyLAogCiAJ
LyogSW50ZXJydXB0ICovCkBAIC0xOTA5LDcgKzE5MDksNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0
IG9mX2RldmljZV9pZCBmc2lfb2ZfbWF0Y2hbXSA9IHsKIH07CiBNT0RVTEVfREVWSUNFX1RBQkxF
KG9mLCBmc2lfb2ZfbWF0Y2gpOwogCi1zdGF0aWMgc3RydWN0IHBsYXRmb3JtX2RldmljZV9pZCBm
c2lfaWRfdGFibGVbXSA9IHsKK3N0YXRpYyBjb25zdCBzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlX2lk
IGZzaV9pZF90YWJsZVtdID0gewogCXsgInNoX2ZzaSIsCShrZXJuZWxfdWxvbmdfdCkmZnNpMV9j
b3JlIH0sCiAJeyAic2hfZnNpMiIsCShrZXJuZWxfdWxvbmdfdCkmZnNpMl9jb3JlIH0sCiAJe30s
Ci0tIAoyLjEuNAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0
dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVs
Cg==
