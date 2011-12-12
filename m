From: =?utf-8?q?Lothar=20Wa=C3=9Fmann?= <LW@KARO-electronics.de>
Subject: [PATCH v2] Export symbols 'mxs_saif_put_mclk()' and
	'mxs_saif_get_mclk()'
Date: Mon, 12 Dec 2011 10:44:04 +0100
Message-ID: <1323683044-11694-1-git-send-email-LW@KARO-electronics.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.karo-electronics.de (mail.karo-electronics.de
	[81.173.242.67]) by alsa0.perex.cz (Postfix) with ESMTP id 5B3C72448D
	for <alsa-devel@alsa-project.org>; Mon, 12 Dec 2011 10:44:09 +0100 (CET)
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Dong Aisheng-B29396 <B29396@freescale.com>, linux-kernel@vger.kernel.org, =?utf-8?q?Lothar=20Wa=C3=9Fmann?= <LW@KARO-electronics.de>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Rml4ZXMgdGhlIGZvbGxvd2luZyBlcnJvcnMgd2l0aCBNWFMgc291bmQgc3VwcG9ydCBidWlsdCBh
cyBtb2R1bGU6CnxFUlJPUjogIm14c19zYWlmX3B1dF9tY2xrIiBbc291bmQvc29jL214cy9zbmQt
c29jLW14cy1zZ3RsNTAwMC5rb10gdW5kZWZpbmVkIQp8RVJST1I6ICJteHNfc2FpZl9nZXRfbWNs
ayIgW3NvdW5kL3NvYy9teHMvc25kLXNvYy1teHMtc2d0bDUwMDAua29dIHVuZGVmaW5lZCEKClNp
Z25lZC1vZmYtYnk6IExvdGhhciBXYcOfbWFubiA8TFdAS0FSTy1lbGVjdHJvbmljcy5kZT4KLS0t
CiBzb3VuZC9zb2MvbXhzL214cy1zYWlmLmMgfCAgICAyICsrCiAxIGZpbGVzIGNoYW5nZWQsIDIg
aW5zZXJ0aW9ucygrKSwgMCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9zb3VuZC9zb2MvbXhz
L214cy1zYWlmLmMgYi9zb3VuZC9zb2MvbXhzL214cy1zYWlmLmMKaW5kZXggNDg3ZDJmZi4uZWM2
NmEyOSAxMDA2NDQKLS0tIGEvc291bmQvc29jL214cy9teHMtc2FpZi5jCisrKyBiL3NvdW5kL3Nv
Yy9teHMvbXhzLXNhaWYuYwpAQCAtMjIxLDYgKzIyMSw3IEBAIGludCBteHNfc2FpZl9wdXRfbWNs
ayh1bnNpZ25lZCBpbnQgc2FpZl9pZCkKIAlzYWlmLT5tY2xrX2luX3VzZSA9IDA7CiAJcmV0dXJu
IDA7CiB9CitFWFBPUlRfU1lNQk9MX0dQTChteHNfc2FpZl9wdXRfbWNsayk7CiAKIC8qCiAgKiBH
ZXQgTUNMSyBhbmQgc2V0IGNsb2NrIHJhdGUsIHRoZW4gZW5hYmxlIGl0CkBAIC0yNzQsNyArMjc1
LDcgQEAgaW50IG14c19zYWlmX2dldF9tY2xrKHVuc2lnbmVkIGludCBzYWlmX2lkLCB1bnNpZ25l
ZCBpbnQgbWNsaywKIAogCXJldHVybiAwOwogfQorRVhQT1JUX1NZTUJPTF9HUEwobXhzX3NhaWZf
Z2V0X21jbGspOwogCiAvKgogICogU0FJRiBEQUkgZm9ybWF0IGNvbmZpZ3VyYXRpb24uCi0tIAox
LjUuNi41CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpB
bHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDov
L21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
