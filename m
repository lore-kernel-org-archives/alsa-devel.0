From: =?UTF-8?q?Eric=20B=C3=A9nard?= <eric@eukrea.com>
Subject: [PATCH] eukrea-tlv320: add MBIMXSD51 support
Date: Fri, 25 Feb 2011 13:48:15 +0100
Message-ID: <1298638095-4084-1-git-send-email-eric@eukrea.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from 26.mail-out.ovh.net (1.26.mail-out.ovh.net [46.105.43.121])
	by alsa0.perex.cz (Postfix) with SMTP id 46978103962
	for <alsa-devel@alsa-project.org>; Fri, 25 Feb 2011 13:48:18 +0100 (CET)
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
Cc: s.hauer@pengutronix.de, broonie@opensource.wolfsonmicro.com, linux-arm-kernel@lists.infradead.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

U2lnbmVkLW9mZi1ieTogRXJpYyBCw6luYXJkIDxlcmljQGV1a3JlYS5jb20+Ci0tLQogc291bmQv
c29jL2lteC9LY29uZmlnICAgICAgICAgfCAgICAzICsrLQogc291bmQvc29jL2lteC9ldWtyZWEt
dGx2MzIwLmMgfCAgICAzICsrLQogMiBmaWxlcyBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDIg
ZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvc291bmQvc29jL2lteC9LY29uZmlnIGIvc291bmQv
c29jL2lteC9LY29uZmlnCmluZGV4IDY0MjI3MGEuLjllZWI4ZjAgMTAwNjQ0Ci0tLSBhL3NvdW5k
L3NvYy9pbXgvS2NvbmZpZworKysgYi9zb3VuZC9zb2MvaW14L0tjb25maWcKQEAgLTQ0LDcgKzQ0
LDggQEAgY29uZmlnIFNORF9TT0NfRVVLUkVBX1RMVjMyMAogCXRyaXN0YXRlICJFdWtyZWEgVExW
MzIwIgogCWRlcGVuZHMgb24gTUFDSF9FVUtSRUFfTUJJTVgyN19CQVNFQk9BUkQgXAogCQl8fCBN
QUNIX0VVS1JFQV9NQklNWFNEMjVfQkFTRUJPQVJEIFwKLQkJfHwgTUFDSF9FVUtSRUFfTUJJTVhT
RDM1X0JBU0VCT0FSRAorCQl8fCBNQUNIX0VVS1JFQV9NQklNWFNEMzVfQkFTRUJPQVJEIFwKKwkJ
fHwgTUFDSF9FVUtSRUFfTUJJTVhTRDUxX0JBU0VCT0FSRAogCXNlbGVjdCBTTkRfU09DX1RMVjMy
MEFJQzIzCiAJc2VsZWN0IFNORF9NWENfU09DX1NTSQogCXNlbGVjdCBTTkRfTVhDX1NPQ19GSVEK
ZGlmZiAtLWdpdCBhL3NvdW5kL3NvYy9pbXgvZXVrcmVhLXRsdjMyMC5jIGIvc291bmQvc29jL2lt
eC9ldWtyZWEtdGx2MzIwLmMKaW5kZXggMWU5YmNjYS4uNzVmYjRiOCAxMDA2NDQKLS0tIGEvc291
bmQvc29jL2lteC9ldWtyZWEtdGx2MzIwLmMKKysrIGIvc291bmQvc29jL2lteC9ldWtyZWEtdGx2
MzIwLmMKQEAgLTk4LDcgKzk4LDggQEAgc3RhdGljIGludCBfX2luaXQgZXVrcmVhX3RsdjMyMF9p
bml0KHZvaWQpCiAJaW50IHJldDsKIAogCWlmICghbWFjaGluZV9pc19ldWtyZWFfY3B1aW14Mjco
KSAmJiAhbWFjaGluZV9pc19ldWtyZWFfY3B1aW14MjVzZCgpCi0JCSYmICFtYWNoaW5lX2lzX2V1
a3JlYV9jcHVpbXgzNXNkKCkpCisJCSYmICFtYWNoaW5lX2lzX2V1a3JlYV9jcHVpbXgzNXNkKCkK
KwkJJiYgIW1hY2hpbmVfaXNfZXVrcmVhX2NwdWlteDUxc2QoKSkKIAkJLyogcmV0dXJuIGhhcHB5
LiBXZSBtaWdodCBydW4gb24gYSB0b3RhbGx5IGRpZmZlcmVudCBtYWNoaW5lICovCiAJCXJldHVy
biAwOwogCi0tIAoxLjcuNAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qu
b3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNh
LWRldmVsCg==
