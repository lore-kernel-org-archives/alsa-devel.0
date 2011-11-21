From: Dong Aisheng <b29396@freescale.com>
Subject: [PATCH v6 3/3] ARM: mx28evk: set a initial clock rate
	for saif
Date: Mon, 21 Nov 2011 15:46:42 +0800
Message-ID: <1321861602-12735-4-git-send-email-b29396@freescale.com>
References: <1321861602-12735-1-git-send-email-b29396@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from TX2EHSOBE003.bigfish.com (tx2ehsobe002.messaging.microsoft.com
	[65.55.88.12]) by alsa0.perex.cz (Postfix) with ESMTP id C5FFF10386C
	for <alsa-devel@alsa-project.org>; Mon, 21 Nov 2011 08:34:58 +0100 (CET)
In-Reply-To: <1321861602-12735-1-git-send-email-b29396@freescale.com>
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

U2lnbmVkLW9mZi1ieTogRG9uZyBBaXNoZW5nIDxiMjkzOTZAZnJlZXNjYWxlLmNvbT4KQ2M6IFNh
c2NoYSBIYXVlciA8cy5oYXVlckBwZW5ndXRyb25peC5kZT4KQ2M6IFdvbGZyYW0gU2FuZyA8dy5z
YW5nQHBlbmd1dHJvbml4LmRlPgpDYzogVXdlIEtsZWluZS1Lw7ZuaWcgPHUua2xlaW5lLWtvZW5p
Z0BwZW5ndXRyb25peC5kZT4KQ2M6IE1hcmsgQnJvd24gPGJyb29uaWVAb3BlbnNvdXJjZS53b2xm
c29ubWljcm8uY29tPgpDYzogTGlhbSBHaXJkd29vZCA8bHJnQHRpLmNvbT4KCi0tLQpDaGFuZ2Vz
IHNpbmNlIHYxOgogKiBtYWtlIGNvbW1lbnRzIGEgbGl0dGxlIGJldHRlci4KICAgSXQncyBvcmln
aW5hbGx5IHN1Z2dlc3RlZCBieSBVd2UuCi0tLQogYXJjaC9hcm0vbWFjaC1teHMvY2xvY2stbXgy
OC5jIHwgICAgOSArKysrKysrKysKIDEgZmlsZXMgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCspLCAw
IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2FyY2gvYXJtL21hY2gtbXhzL2Nsb2NrLW14Mjgu
YyBiL2FyY2gvYXJtL21hY2gtbXhzL2Nsb2NrLW14MjguYwppbmRleCBjNTFmZTg1Li5iMGMyNDhk
IDEwMDY0NAotLS0gYS9hcmNoL2FybS9tYWNoLW14cy9jbG9jay1teDI4LmMKKysrIGIvYXJjaC9h
cm0vbWFjaC1teHMvY2xvY2stbXgyOC5jCkBAIC04MDgsNiArODA4LDE1IEBAIGludCBfX2luaXQg
bXgyOF9jbG9ja3NfaW5pdCh2b2lkKQogCWNsa19zZXRfcGFyZW50KCZzYWlmMF9jbGssICZwbGww
X2Nsayk7CiAJY2xrX3NldF9wYXJlbnQoJnNhaWYxX2NsaywgJnBsbDBfY2xrKTsKIAorCS8qCisJ
ICogU2V0IGFuIGluaXRpYWwgY2xvY2sgcmF0ZSBmb3IgdGhlIHNhaWYgaW50ZXJuYWwgbG9naWMg
dG8gd29yaworCSAqIHByb3Blcmx5LiBUaGlzIGlzIGltcG9ydGFudCB3aGVuIHdvcmtpbmcgaW4g
RVhUTUFTVEVSIG1vZGUgdGhhdAorCSAqIHVzZXMgdGhlIG90aGVyIHNhaWYncyBCSVRDTEsmTFJD
TEsgYnV0IGl0IHN0aWxsIG5lZWRzIGEgYmFzaWMKKwkgKiBjbG9jayB3aGljaCBzaG91bGQgYmUg
ZmFzdCBlbm91Z2ggZm9yIHRoZSBpbnRlcm5hbCBsb2dpYy4KKwkgKi8KKwljbGtfc2V0X3JhdGUo
JnNhaWYwX2NsaywgMjQwMDAwMDApOworCWNsa19zZXRfcmF0ZSgmc2FpZjFfY2xrLCAyNDAwMDAw
MCk7CisKIAljbGtkZXZfYWRkX3RhYmxlKGxvb2t1cHMsIEFSUkFZX1NJWkUobG9va3VwcykpOwog
CiAJbXhzX3RpbWVyX2luaXQoJmNsazMya19jbGssIE1YMjhfSU5UX1RJTUVSMCk7Ci0tIAoxLjcu
MC40CgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQWxz
YS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHA6Ly9t
YWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
