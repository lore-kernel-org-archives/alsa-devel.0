From: =?UTF-8?q?J=C3=B6rg=20Krause?= <joerg.krause@embedded.rocks>
Subject: [PATCH 2/2] ASoC: mxs-saif: fix setting SAIF1 register
Date: Fri, 13 Jan 2017 21:44:28 +0100
Message-ID: <20170113204428.16703-2-joerg.krause@embedded.rocks>
References: <20170113204428.16703-1-joerg.krause@embedded.rocks>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.142])
 by alsa0.perex.cz (Postfix) with ESMTP id 9F95A266A13
 for <alsa-devel@alsa-project.org>; Fri, 13 Jan 2017 21:44:41 +0100 (CET)
In-Reply-To: <20170113204428.16703-1-joerg.krause@embedded.rocks>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mans Rullgard <mans@mansr.com>, Victorien Vedrine <victorien.vedrine@ophrys.net>, =?UTF-8?q?J=C3=B6rg=20Krause?= <joerg.krause@embedded.rocks>, Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>, Shawn Guo <shawn.guo@freescale.com>
List-Id: alsa-devel@alsa-project.org

SWYgU0FJRjAgaXMgdXNlZCBpbiBtYXN0ZXIgYW5kIFNBSUYxIGluIHNsYXZlIG1vZGUgc2V0dGlu
ZyB0aGUgU0FJRjEKcmVnaXN0ZXIgaW4gbXhzX3NhaWZfc2V0X2RhaV9mbXQoKSBkb2VzIG5vdCBo
YXZlIGFueSBlZmZlY3Qgb24gdGhlCmludGVyZmFjZSBhcyB0aGUgY2xrIGdhdGUgbmVlZHMgdG8g
YmUgY2xlYXJlZCBiZWZvcmUgdGhlIHJlZ2lzdGVyIGNhbiBiZQp3cml0dGVuLgoKU2lnbmVkLW9m
Zi1ieTogSsO2cmcgS3JhdXNlIDxqb2VyZy5rcmF1c2VAZW1iZWRkZWQucm9ja3M+Ci0tLQogc291
bmQvc29jL214cy9teHMtc2FpZi5jIHwgMTAgKysrKysrKysrKwogMSBmaWxlIGNoYW5nZWQsIDEw
IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9zb3VuZC9zb2MvbXhzL214cy1zYWlmLmMgYi9z
b3VuZC9zb2MvbXhzL214cy1zYWlmLmMKaW5kZXggMWU3MjQ1MzNkYzZlLi4yNmMyNDBhZjgwOTkg
MTAwNjQ0Ci0tLSBhL3NvdW5kL3NvYy9teHMvbXhzLXNhaWYuYworKysgYi9zb3VuZC9zb2MvbXhz
L214cy1zYWlmLmMKQEAgLTMwOSw2ICszMDksMTYgQEAgc3RhdGljIGludCBteHNfc2FpZl9zZXRf
ZGFpX2ZtdChzdHJ1Y3Qgc25kX3NvY19kYWkgKmNwdV9kYWksIHVuc2lnbmVkIGludCBmbXQpCiAJ
CXJldHVybiAtRUJVU1k7CiAJfQogCisJLyogSWYgU0FJRjEgaXMgY29uZmlndXJlZCBhcyBzbGF2
ZSwgdGhlIGNsayBnYXRlIG5lZWRzIHRvIGJlIGNsZWFyZWQKKwkgKiBiZWZvcmUgdGhlIHJlZ2lz
dGVyIGNhbiBiZSB3cml0dGVuLgorCSAqLworCWlmIChzYWlmLT5pZCAhPSBzYWlmLT5tYXN0ZXJf
aWQpIHsKKwkJX19yYXdfd3JpdGVsKEJNX1NBSUZfQ1RSTF9TRlRSU1QsCisJCQlzYWlmLT5iYXNl
ICsgU0FJRl9DVFJMICsgTVhTX0NMUl9BRERSKTsKKwkJX19yYXdfd3JpdGVsKEJNX1NBSUZfQ1RS
TF9DTEtHQVRFLAorCQkJc2FpZi0+YmFzZSArIFNBSUZfQ1RSTCArIE1YU19DTFJfQUREUik7CisJ
fQorCiAJc2NyMCA9IF9fcmF3X3JlYWRsKHNhaWYtPmJhc2UgKyBTQUlGX0NUUkwpOwogCXNjcjAg
PSBzY3IwICYgfkJNX1NBSUZfQ1RSTF9CSVRDTEtfRURHRSAmIH5CTV9TQUlGX0NUUkxfTFJDTEtf
UE9MQVJJVFkgXAogCQkmIH5CTV9TQUlGX0NUUkxfSlVTVElGWSAmIH5CTV9TQUlGX0NUUkxfREVM
QVk7Ci0tIAoyLjExLjAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9y
ZwpodHRwOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1k
ZXZlbAo=
