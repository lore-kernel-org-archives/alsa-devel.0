From: =?utf-8?Q?Beno=C3=AEt_Th=C3=A9baudeau?= <benoit.thebaudeau@advansee.com>
Subject: [PATCH] ASoC: dapm: Fix dapm_set_path_status() connect
Date: Mon, 2 Jul 2012 13:45:21 +0200 (CEST)
Message-ID: <1035078102.502287.1341229521711.JavaMail.root@advansee.com>
References: <1535746789.386644.1341061383351.JavaMail.root@advansee.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from zose-mta13.web4all.fr (zose-mta13.web4all.fr [178.33.204.91])
	by alsa0.perex.cz (Postfix) with ESMTP id 2FEE524590
	for <alsa-devel@alsa-project.org>;
	Mon,  2 Jul 2012 13:40:42 +0200 (CEST)
In-Reply-To: <1535746789.386644.1341061383351.JavaMail.root@advansee.com>
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
Cc: Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

ZGFwbV9zZXRfcGF0aF9zdGF0dXMoKSBzZXRzIGNvbm5lY3QgaW5jb3JyZWN0bHkgaW4gdGhlIGNh
c2UgbWF4ID4gMSB3aXRoIGludmVydC4KSW4gdGhhdCBjYXNlLCB0aGUgcmF3IGRpc2Nvbm5lY3Qg
dmFsdWUgc2hvdWxkIGJlIG1heCwgd2hpY2ggY29ycmVzcG9uZHMgdG8gdGhlCnVzZXJzcGFjZSB2
YWx1ZSAwLgoKVGhpcyB1c2UgY2FzZSBjdXJyZW50bHkgZG9lcyBub3QgYXBwZWFyIHVwc3RyZWFt
LCBidXQgaXQgY291bGQgYnJlYWsKU09DX0RBUE1fU0lOR0xFKCkgb3IgU09DX0RBUE1fU0lOR0xF
X1RMVigpIGVsc2V3aGVyZSBvciBpbiB0aGUgZnV0dXJlLgoKVGhpcyBwYXRjaCBjb21wbGV0ZXMg
Y29tbWl0IDNhOWFiZTguCgpDYzogTGlhbSBHaXJkd29vZCA8bHJnQHRpLmNvbT4KQ2M6IE1hcmsg
QnJvd24gPGJyb29uaWVAb3BlbnNvdXJjZS53b2xmc29ubWljcm8uY29tPgpDYzogPGFsc2EtZGV2
ZWxAYWxzYS1wcm9qZWN0Lm9yZz4KU2lnbmVkLW9mZi1ieTogQmVub8OudCBUaMOpYmF1ZGVhdSA8
YmVub2l0LnRoZWJhdWRlYXVAYWR2YW5zZWUuY29tPgotLS0KIC4uLi9zb3VuZC9zb2Mvc29jLWRh
cG0uYyAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAgNyArKystLS0tCiAxIGZpbGUgY2hh
bmdlZCwgMyBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBsaW51eC1u
ZXh0LUhFQUQtZDFkMmQzYS5vcmlnL3NvdW5kL3NvYy9zb2MtZGFwbS5jIGxpbnV4LW5leHQtSEVB
RC1kMWQyZDNhL3NvdW5kL3NvYy9zb2MtZGFwbS5jCmluZGV4IDk2NzA2NjguLjdmMmE0YmIgMTAw
NjQ0Ci0tLSBsaW51eC1uZXh0LUhFQUQtZDFkMmQzYS5vcmlnL3NvdW5kL3NvYy9zb2MtZGFwbS5j
CisrKyBsaW51eC1uZXh0LUhFQUQtZDFkMmQzYS9zb3VuZC9zb2Mvc29jLWRhcG0uYwpAQCAtMzI0
LDExICszMjQsMTAgQEAgc3RhdGljIHZvaWQgZGFwbV9zZXRfcGF0aF9zdGF0dXMoc3RydWN0IHNu
ZF9zb2NfZGFwbV93aWRnZXQgKncsCiAKIAkJdmFsID0gc29jX3dpZGdldF9yZWFkKHcsIHJlZyk7
CiAJCXZhbCA9ICh2YWwgPj4gc2hpZnQpICYgbWFzazsKKwkJaWYgKGludmVydCkKKwkJCXZhbCA9
IG1heCAtIHZhbDsKIAotCQlpZiAoKGludmVydCAmJiAhdmFsKSB8fCAoIWludmVydCAmJiB2YWwp
KQotCQkJcC0+Y29ubmVjdCA9IDE7Ci0JCWVsc2UKLQkJCXAtPmNvbm5lY3QgPSAwOworCQlwLT5j
b25uZWN0ID0gISF2YWw7CiAJfQogCWJyZWFrOwogCWNhc2Ugc25kX3NvY19kYXBtX211eDogewpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVs
IG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4u
YWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
