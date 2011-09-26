From: Dong Aisheng <b29396@freescale.com>
Subject: [PATCH v3 3/3] ARM: mx28evk: set a initial clock rate
	for saif
Date: Mon, 26 Sep 2011 23:52:33 +0800
Message-ID: <1317052353-6029-4-git-send-email-b29396@freescale.com>
References: <1317052353-6029-1-git-send-email-b29396@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from TX2EHSOBE006.bigfish.com (tx2ehsobe003.messaging.microsoft.com
	[65.55.88.13]) by alsa0.perex.cz (Postfix) with ESMTP id 68CFE24158
	for <alsa-devel@alsa-project.org>;
	Mon, 26 Sep 2011 17:42:22 +0200 (CEST)
In-Reply-To: <1317052353-6029-1-git-send-email-b29396@freescale.com>
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
Cc: s.hauer@pengutronix.de, broonie@opensource.wolfsonmicro.com, w.sang@pengutronix.de, u.kleine-koenig@pengutronix.de, lrg@ti.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

U2lnbmVkLW9mZi1ieTogRG9uZyBBaXNoZW5nIDxiMjkzOTZAZnJlZXNjYWxlLmNvbT4KQ2M6IFNh
c2NoYSBIYXVlciA8cy5oYXVlckBwZW5ndXRyb25peC5kZT4KQ2M6IFdvbGZyYW0gU2FuZyA8dy5z
YW5nQHBlbmd1dHJvbml4LmRlPgpDYzogVXdlIEtsZWluZS1Lw7ZuaWcgPHUua2xlaW5lLWtvZW5p
Z0BwZW5ndXRyb25peC5kZT4KQ2M6IE1hcmsgQnJvd24gPGJyb29uaWVAb3BlbnNvdXJjZS53b2xm
c29ubWljcm8uY29tPgpDYzogTGlhbSBHaXJkd29vZCA8bHJnQHRpLmNvbT4KCi0tLQpObyBjaGFu
Z2VzIHNpbmNlIHYxLgotLS0KIGFyY2gvYXJtL21hY2gtbXhzL2Nsb2NrLW14MjguYyB8ICAgIDkg
KysrKysrKysrCiAxIGZpbGVzIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKSwgMCBkZWxldGlvbnMo
LSkKCmRpZmYgLS1naXQgYS9hcmNoL2FybS9tYWNoLW14cy9jbG9jay1teDI4LmMgYi9hcmNoL2Fy
bS9tYWNoLW14cy9jbG9jay1teDI4LmMKaW5kZXggOTQ5NzM0Ni4uMmRhYWI0OSAxMDA2NDQKLS0t
IGEvYXJjaC9hcm0vbWFjaC1teHMvY2xvY2stbXgyOC5jCisrKyBiL2FyY2gvYXJtL21hY2gtbXhz
L2Nsb2NrLW14MjguYwpAQCAtODM3LDYgKzgzNywxNSBAQCBpbnQgX19pbml0IG14MjhfY2xvY2tz
X2luaXQodm9pZCkKIAljbGtfc2V0X3BhcmVudCgmc2FpZjBfY2xrLCAmcGxsMF9jbGspOwogCWNs
a19zZXRfcGFyZW50KCZzYWlmMV9jbGssICZwbGwwX2Nsayk7CiAKKwkvKgorCSAqIFNldCBhbiBp
bml0aWFsIGNsayByYXRlIGZvciBzYWlmJ3MgaW50ZXJuYWwgbG9naWMgdG8gd29yayBwcm9wZXJs
eSwKKwkgKiB0aGlzIGlzIGVzcGVjaWFsbHkgZm9yIHRoZSBzYWlmIHdvcmtpbmcgb24gRVhUTUFT
VEVSIG1vZGUgdGhhdCB3aG8KKwkgKiB1c2VzIG90aGVyIHNhaWYncyBCSVRDTEsmTFJDTEsgYnV0
IGl0IHN0aWxsIG5lZWRzIGEgYmFzaWMgY2xrIHdoaWNoCisJICogc2hvdWxkIGJlIGJpZ2dlciBl
bm91Z2ggZm9yIGl0cyBpbnRlcm5hbCBsb2dpYy4KKwkgKi8KKwljbGtfc2V0X3JhdGUoJnNhaWYw
X2NsaywgMjQwMDAwMDApOworCWNsa19zZXRfcmF0ZSgmc2FpZjFfY2xrLCAyNDAwMDAwMCk7CisK
IAljbGtkZXZfYWRkX3RhYmxlKGxvb2t1cHMsIEFSUkFZX1NJWkUobG9va3VwcykpOwogCiAJbXhz
X3RpbWVyX2luaXQoJmNsazMya19jbGssIE1YMjhfSU5UX1RJTUVSMCk7Ci0tIAoxLjcuMC40CgoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQWxzYS1kZXZl
bCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFu
LmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
