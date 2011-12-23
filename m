From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 4/8] ASoC: mid-x86: Add .owner to struct
	snd_soc_card
Date: Fri, 23 Dec 2011 14:50:17 +0800
Message-ID: <1324623017.2295.3.camel@phoenix>
References: <1324622828.2295.0.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yx0-f179.google.com (mail-yx0-f179.google.com
	[209.85.213.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 7D969103F35
	for <alsa-devel@alsa-project.org>; Fri, 23 Dec 2011 07:50:24 +0100 (CET)
Received: by yenr11 with SMTP id r11so2294879yen.38
	for <alsa-devel@alsa-project.org>; Thu, 22 Dec 2011 22:50:23 -0800 (PST)
In-Reply-To: <1324622828.2295.0.camel@phoenix>
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
Cc: Lothar@alsa-project.org, Vinod Koul <vinod.koul@linux.intel.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, =?ISO-8859-1?Q?Wa=DFmann?= <LW@KARO-electronics.de>
List-Id: alsa-devel@alsa-project.org

QWRkIG1pc3NpbmcgLm93bmVyIG9mIHN0cnVjdCBzbmRfc29jX2NhcmQuIFRoaXMgcHJldmVudHMg
dGhlIG1vZHVsZSBmcm9tIGJlaW5nCnJlbW92ZWQgZnJvbSB1bmRlcm5lYXRoIGl0cyB1c2Vycy4K
ClJlcG9ydGVkLWJ5OiBMb3RoYXIgV2HDn21hbm4gPExXQEtBUk8tZWxlY3Ryb25pY3MuZGU+ClNp
Z25lZC1vZmYtYnk6IEF4ZWwgTGluIDxheGVsLmxpbkBnbWFpbC5jb20+Ci0tLQogc291bmQvc29j
L21pZC14ODYvbWZsZF9tYWNoaW5lLmMgfCAgICAxICsKIDEgZmlsZXMgY2hhbmdlZCwgMSBpbnNl
cnRpb25zKCspLCAwIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3NvdW5kL3NvYy9taWQteDg2
L21mbGRfbWFjaGluZS5jIGIvc291bmQvc29jL21pZC14ODYvbWZsZF9tYWNoaW5lLmMKaW5kZXgg
NTk4ZjQ4Yy4uM2I5NDJhNyAxMDA2NDQKLS0tIGEvc291bmQvc29jL21pZC14ODYvbWZsZF9tYWNo
aW5lLmMKKysrIGIvc291bmQvc29jL21pZC14ODYvbWZsZF9tYWNoaW5lLmMKQEAgLTMyMiw2ICsz
MjIsNyBAQCBzdHJ1Y3Qgc25kX3NvY19kYWlfbGluayBtZmxkX21zaWNfZGFpbGlua1tdID0gewog
LyogU29DIGNhcmQgKi8KIHN0YXRpYyBzdHJ1Y3Qgc25kX3NvY19jYXJkIHNuZF9zb2NfY2FyZF9t
ZmxkID0gewogCS5uYW1lID0gIm1lZGZpZWxkX2F1ZGlvIiwKKwkub3duZXIgPSBUSElTX01PRFVM
RSwKIAkuZGFpX2xpbmsgPSBtZmxkX21zaWNfZGFpbGluaywKIAkubnVtX2xpbmtzID0gQVJSQVlf
U0laRShtZmxkX21zaWNfZGFpbGluayksCiB9OwotLSAKMS43LjUuNAoKCgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlz
dApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
