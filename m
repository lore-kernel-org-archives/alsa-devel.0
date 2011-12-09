From: =?utf-8?q?Lothar=20Wa=C3=9Fmann?= <LW@KARO-electronics.de>
Subject: [PATCH 3/5] ASoC: mxs: Export symbols
	'mxs_saif_put_mclk()' and 'mxs_saif_get_mclk()'
Date: Fri,  9 Dec 2011 14:38:10 +0100
Message-ID: <42d1579aefe3a3025f16fb4e38a4acf6b72756f7.1323436034.git.LW@KARO-electronics.de>
References: <cover.1323436034.git.LW@KARO-electronics.de>
	<992d017bd0214a67a836f2d0279b4edb6913da28.1323436034.git.LW@KARO-electronics.de>
	<555be1750dd09586d5eede6457f72310890274b0.1323436034.git.LW@KARO-electronics.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.karo-electronics.de (mail.karo-electronics.de
	[81.173.242.67])
	by alsa0.perex.cz (Postfix) with ESMTP id 3891210383E
	for <alsa-devel@alsa-project.org>; Fri,  9 Dec 2011 14:38:15 +0100 (CET)
In-Reply-To: <555be1750dd09586d5eede6457f72310890274b0.1323436034.git.LW@KARO-electronics.de>
In-Reply-To: <cover.1323436034.git.LW@KARO-electronics.de>
References: <cover.1323436034.git.LW@KARO-electronics.de>
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
IDA7CiB9CitFWFBPUlRfU1lNQk9MKG14c19zYWlmX3B1dF9tY2xrKTsKIAogLyoKICAqIEdldCBN
Q0xLIGFuZCBzZXQgY2xvY2sgcmF0ZSwgdGhlbiBlbmFibGUgaXQKQEAgLTI3NCw2ICsyNzUsNyBA
QCBpbnQgbXhzX3NhaWZfZ2V0X21jbGsodW5zaWduZWQgaW50IHNhaWZfaWQsIHVuc2lnbmVkIGlu
dCBtY2xrLAogCiAJcmV0dXJuIDA7CiB9CitFWFBPUlRfU1lNQk9MKG14c19zYWlmX2dldF9tY2xr
KTsKIAogLyoKICAqIFNBSUYgREFJIGZvcm1hdCBjb25maWd1cmF0aW9uLgotLSAKMS41LjYuNQoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQWxzYS1kZXZl
bCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFu
LmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
