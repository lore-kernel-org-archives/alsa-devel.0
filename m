From: Dong Aisheng <b29396@freescale.com>
Subject: [PATCH v7 3/3] ARM: mx28evk: set a initial clock rate
	for saif
Date: Tue, 22 Nov 2011 23:54:25 +0800
Message-ID: <1321977265-14959-4-git-send-email-b29396@freescale.com>
References: <a>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from DB3EHSOBE005.bigfish.com (db3ehsobe005.messaging.microsoft.com
	[213.199.154.143])
	by alsa0.perex.cz (Postfix) with ESMTP id AB841103B9B
	for <alsa-devel@alsa-project.org>; Tue, 22 Nov 2011 16:42:42 +0100 (CET)
In-Reply-To: <a>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: linux-arm-kernel@lists.infradead.org
Cc: alsa-devel@alsa-project.org, s.hauer@pengutronix.de, broonie@opensource.wolfsonmicro.com, w.sang@pengutronix.de, marek.vasut@gmail.com, kernel@pengutronix.de, u.kleine-koenig@pengutronix.de, lrg@ti.com, shawn.guo@freescale.com
List-Id: alsa-devel@alsa-project.org

U2lnbmVkLW9mZi1ieTogRG9uZyBBaXNoZW5nIDxiMjkzOTZAZnJlZXNjYWxlLmNvbT4KQWNrZWQt
Ynk6IE1hcmVrIFZhc3V0IDxtYXJlay52YXN1dEBnbWFpbC5jb20+CkNjOiBTYXNjaGEgSGF1ZXIg
PHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU+CkNjOiBXb2xmcmFtIFNhbmcgPHcuc2FuZ0BwZW5ndXRy
b25peC5kZT4KQ2M6IFV3ZSBLbGVpbmUtS8O2bmlnIDx1LmtsZWluZS1rb2VuaWdAcGVuZ3V0cm9u
aXguZGU+CkNjOiBNYXJrIEJyb3duIDxicm9vbmllQG9wZW5zb3VyY2Uud29sZnNvbm1pY3JvLmNv
bT4KQ2M6IExpYW0gR2lyZHdvb2QgPGxyZ0B0aS5jb20+CgotLS0KQ2hhbmdlcyBzaW5jZSB2MToK
ICogbWFrZSBjb21tZW50cyBhIGxpdHRsZSBiZXR0ZXIuCiAgIEl0J3Mgb3JpZ2luYWxseSBzdWdn
ZXN0ZWQgYnkgVXdlLgotLS0KIGFyY2gvYXJtL21hY2gtbXhzL2Nsb2NrLW14MjguYyB8ICAgIDkg
KysrKysrKysrCiAxIGZpbGVzIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKSwgMCBkZWxldGlvbnMo
LSkKCmRpZmYgLS1naXQgYS9hcmNoL2FybS9tYWNoLW14cy9jbG9jay1teDI4LmMgYi9hcmNoL2Fy
bS9tYWNoLW14cy9jbG9jay1teDI4LmMKaW5kZXggYzUxZmU4NS4uYjBjMjQ4ZCAxMDA2NDQKLS0t
IGEvYXJjaC9hcm0vbWFjaC1teHMvY2xvY2stbXgyOC5jCisrKyBiL2FyY2gvYXJtL21hY2gtbXhz
L2Nsb2NrLW14MjguYwpAQCAtODA4LDYgKzgwOCwxNSBAQCBpbnQgX19pbml0IG14MjhfY2xvY2tz
X2luaXQodm9pZCkKIAljbGtfc2V0X3BhcmVudCgmc2FpZjBfY2xrLCAmcGxsMF9jbGspOwogCWNs
a19zZXRfcGFyZW50KCZzYWlmMV9jbGssICZwbGwwX2Nsayk7CiAKKwkvKgorCSAqIFNldCBhbiBp
bml0aWFsIGNsb2NrIHJhdGUgZm9yIHRoZSBzYWlmIGludGVybmFsIGxvZ2ljIHRvIHdvcmsKKwkg
KiBwcm9wZXJseS4gVGhpcyBpcyBpbXBvcnRhbnQgd2hlbiB3b3JraW5nIGluIEVYVE1BU1RFUiBt
b2RlIHRoYXQKKwkgKiB1c2VzIHRoZSBvdGhlciBzYWlmJ3MgQklUQ0xLJkxSQ0xLIGJ1dCBpdCBz
dGlsbCBuZWVkcyBhIGJhc2ljCisJICogY2xvY2sgd2hpY2ggc2hvdWxkIGJlIGZhc3QgZW5vdWdo
IGZvciB0aGUgaW50ZXJuYWwgbG9naWMuCisJICovCisJY2xrX3NldF9yYXRlKCZzYWlmMF9jbGss
IDI0MDAwMDAwKTsKKwljbGtfc2V0X3JhdGUoJnNhaWYxX2NsaywgMjQwMDAwMDApOworCiAJY2xr
ZGV2X2FkZF90YWJsZShsb29rdXBzLCBBUlJBWV9TSVpFKGxvb2t1cHMpKTsKIAogCW14c190aW1l
cl9pbml0KCZjbGszMmtfY2xrLCBNWDI4X0lOVF9USU1FUjApOwotLSAKMS43LjAuNAoKCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFp
bGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNh
LXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
