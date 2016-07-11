From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 7/7] pcm: add 'default' case for switch
	statement
Date: Mon, 11 Jul 2016 21:06:03 +0900
Message-ID: <1468238763-15547-8-git-send-email-o-takashi@sakamocchi.jp>
References: <1468238763-15547-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy001.phy.lolipop.jp (smtp-proxy001.phy.lolipop.jp
 [157.7.104.42]) by alsa0.perex.cz (Postfix) with ESMTP id 57FA9265ADC
 for <alsa-devel@alsa-project.org>; Mon, 11 Jul 2016 14:06:10 +0200 (CEST)
In-Reply-To: <1468238763-15547-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

VGhpcyBjb21taXQgZml4ZXMgYmVsb3cgY29tcGlsZXIgd2FybmluZ3MuCgpwY21fZGlyZWN0LmM6
IEluIGZ1bmN0aW9uIOKAmHNuZDFfcGNtX2RpcmVjdF9wcmVwYXJl4oCZOgpwY21fZGlyZWN0LmM6
ODIxOjI6IHdhcm5pbmc6IGVudW1lcmF0aW9uIHZhbHVlIOKAmFNORF9QQ01fU1RBVEVfUFJFUEFS
RUTigJkgbm90IGhhbmRsZWQgaW4gc3dpdGNoIFstV3N3aXRjaF0KICBzd2l0Y2ggKHNuZF9wY21f
c3RhdGUoZG1peC0+c3BjbSkpIHsKICBeCgpTaWduZWQtb2ZmLWJ5OiBUYWthc2hpIFNha2Ftb3Rv
IDxvLXRha2FzaGlAc2FrYW1vY2NoaS5qcD4KLS0tCiBzcmMvcGNtL3BjbV9kaXJlY3QuYyB8IDIg
KysKIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9zcmMvcGNt
L3BjbV9kaXJlY3QuYyBiL3NyYy9wY20vcGNtX2RpcmVjdC5jCmluZGV4IDIxZjk4ZTcuLmEzODhk
NGEgMTAwNjQ0Ci0tLSBhL3NyYy9wY20vcGNtX2RpcmVjdC5jCisrKyBiL3NyYy9wY20vcGNtX2Rp
cmVjdC5jCkBAIC04MzAsNiArODMwLDggQEAgaW50IHNuZF9wY21fZGlyZWN0X3ByZXBhcmUoc25k
X3BjbV90ICpwY20pCiAJY2FzZSBTTkRfUENNX1NUQVRFX09QRU46CiAJY2FzZSBTTkRfUENNX1NU
QVRFX0RJU0NPTk5FQ1RFRDoKIAkJcmV0dXJuIC1FQkFERkQ7CisJZGVmYXVsdDoKKwkJYnJlYWs7
CiAJfQogCXNuZF9wY21fZGlyZWN0X2NoZWNrX2ludGVybGVhdmUoZG1peCwgcGNtKTsKIAlkbWl4
LT5zdGF0ZSA9IFNORF9QQ01fU1RBVEVfUFJFUEFSRUQ7Ci0tIAoyLjcuNAoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxp
c3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVj
dC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
