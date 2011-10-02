From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 3/6] ASoC: imx: eukrea_tlv320 needs i2c
Date: Sun,  2 Oct 2011 22:28:01 +0200
Message-ID: <1317587284-2776-4-git-send-email-arnd@arndb.de>
References: <1317587284-2776-1-git-send-email-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from moutng.kundenserver.de (moutng.kundenserver.de [212.227.17.8])
	by alsa0.perex.cz (Postfix) with ESMTP id 6AFFB2435C
	for <alsa-devel@alsa-project.org>;
	Sun,  2 Oct 2011 22:29:37 +0200 (CEST)
In-Reply-To: <1317587284-2776-1-git-send-email-arnd@arndb.de>
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
Cc: alsa-devel@alsa-project.org, Arnd Bergmann <arnd@arndb.de>, Sascha Hauer <s.hauer@pengutronix.de>, linux-kernel@vger.kernel.org, =?UTF-8?q?Eric=20B=C3=A9nard?= <eric@eukrea.com>, Liam Girdwood <lrg@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

QWRkIGEgbWlzc2luZyBkZXBlbmRlbmN5IHRoYXQgaXMgcmVxdWlyZWQgZm9yIHJhbmRvbSBjb25m
aWd1cmF0aW9ucy4KClNpZ25lZC1vZmYtYnk6IEFybmQgQmVyZ21hbm4gPGFybmRAYXJuZGIuZGU+
CkNjOiAiRXJpYyBCw6luYXJkIiA8ZXJpY0BldWtyZWEuY29tPgpDYzogU2FzY2hhIEhhdWVyIDxz
LmhhdWVyQHBlbmd1dHJvbml4LmRlPgotLS0KIHNvdW5kL3NvYy9pbXgvS2NvbmZpZyB8ICAgIDEg
KwogMSBmaWxlcyBjaGFuZ2VkLCAxIGluc2VydGlvbnMoKyksIDAgZGVsZXRpb25zKC0pCgpkaWZm
IC0tZ2l0IGEvc291bmQvc29jL2lteC9LY29uZmlnIGIvc291bmQvc29jL2lteC9LY29uZmlnCmlu
ZGV4IGJiNjk5YmIuLmRjZDk1NGIgMTAwNjQ0Ci0tLSBhL3NvdW5kL3NvYy9pbXgvS2NvbmZpZwor
KysgYi9zb3VuZC9zb2MvaW14L0tjb25maWcKQEAgLTUwLDYgKzUwLDcgQEAgY29uZmlnIFNORF9T
T0NfRVVLUkVBX1RMVjMyMAogCQl8fCBNQUNIX0VVS1JFQV9NQklNWFNEMjVfQkFTRUJPQVJEIFwK
IAkJfHwgTUFDSF9FVUtSRUFfTUJJTVhTRDM1X0JBU0VCT0FSRCBcCiAJCXx8IE1BQ0hfRVVLUkVB
X01CSU1YU0Q1MV9CQVNFQk9BUkQKKwlkZXBlbmRzIG9uIEkyQwogCXNlbGVjdCBTTkRfU09DX1RM
VjMyMEFJQzIzCiAJc2VsZWN0IFNORF9NWENfU09DX0ZJUQogCWhlbHAKLS0gCjEuNy41LjQKCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwg
bWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5h
bHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
