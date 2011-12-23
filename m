From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 3/8] ASoC: kirkwood: Add .owner to struct
	snd_soc_card
Date: Fri, 23 Dec 2011 14:49:28 +0800
Message-ID: <1324622968.2295.2.camel@phoenix>
References: <1324622828.2295.0.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gy0-f179.google.com (mail-gy0-f179.google.com
	[209.85.160.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 2B87A103F1A
	for <alsa-devel@alsa-project.org>; Fri, 23 Dec 2011 07:49:35 +0100 (CET)
Received: by ghbz2 with SMTP id z2so1332888ghb.38
	for <alsa-devel@alsa-project.org>; Thu, 22 Dec 2011 22:49:34 -0800 (PST)
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
Cc: Lothar@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Arnaud Patard <arnaud.patard@rtp-net.org>, =?ISO-8859-1?Q?Wa=DFmann?= <LW@KARO-electronics.de>
List-Id: alsa-devel@alsa-project.org

QWRkIG1pc3NpbmcgLm93bmVyIG9mIHN0cnVjdCBzbmRfc29jX2NhcmQuIFRoaXMgcHJldmVudHMg
dGhlIG1vZHVsZSBmcm9tIGJlaW5nCnJlbW92ZWQgZnJvbSB1bmRlcm5lYXRoIGl0cyB1c2Vycy4K
ClJlcG9ydGVkLWJ5OiBMb3RoYXIgV2HDn21hbm4gPExXQEtBUk8tZWxlY3Ryb25pY3MuZGU+ClNp
Z25lZC1vZmYtYnk6IEF4ZWwgTGluIDxheGVsLmxpbkBnbWFpbC5jb20+Ci0tLQogc291bmQvc29j
L2tpcmt3b29kL2tpcmt3b29kLW9wZW5yZC5jIHwgICAgMSArCiBzb3VuZC9zb2Mva2lya3dvb2Qv
a2lya3dvb2QtdDUzMjUuYyAgfCAgICAxICsKIDIgZmlsZXMgY2hhbmdlZCwgMiBpbnNlcnRpb25z
KCspLCAwIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3NvdW5kL3NvYy9raXJrd29vZC9raXJr
d29vZC1vcGVucmQuYyBiL3NvdW5kL3NvYy9raXJrd29vZC9raXJrd29vZC1vcGVucmQuYwppbmRl
eCBkODYzYWZiLi44YTVhM2RkIDEwMDY0NAotLS0gYS9zb3VuZC9zb2Mva2lya3dvb2Qva2lya3dv
b2Qtb3BlbnJkLmMKKysrIGIvc291bmQvc29jL2tpcmt3b29kL2tpcmt3b29kLW9wZW5yZC5jCkBA
IC03Niw2ICs3Niw3IEBAIHN0YXRpYyBzdHJ1Y3Qgc25kX3NvY19kYWlfbGluayBvcGVucmRfY2xp
ZW50X2RhaVtdID0gewogCiBzdGF0aWMgc3RydWN0IHNuZF9zb2NfY2FyZCBvcGVucmRfY2xpZW50
ID0gewogCS5uYW1lID0gIk9wZW5SRCBDbGllbnQiLAorCS5vd25lciA9IFRISVNfTU9EVUxFLAog
CS5kYWlfbGluayA9IG9wZW5yZF9jbGllbnRfZGFpLAogCS5udW1fbGlua3MgPSBBUlJBWV9TSVpF
KG9wZW5yZF9jbGllbnRfZGFpKSwKIH07CmRpZmYgLS1naXQgYS9zb3VuZC9zb2Mva2lya3dvb2Qv
a2lya3dvb2QtdDUzMjUuYyBiL3NvdW5kL3NvYy9raXJrd29vZC9raXJrd29vZC10NTMyNS5jCmlu
ZGV4IGM3NzJiM2MuLmE4OTMwYzcgMTAwNjQ0Ci0tLSBhL3NvdW5kL3NvYy9raXJrd29vZC9raXJr
d29vZC10NTMyNS5jCisrKyBiL3NvdW5kL3NvYy9raXJrd29vZC9raXJrd29vZC10NTMyNS5jCkBA
IC05OCw2ICs5OCw3IEBAIHN0YXRpYyBzdHJ1Y3Qgc25kX3NvY19kYWlfbGluayB0NTMyNV9kYWlb
XSA9IHsKIAogc3RhdGljIHN0cnVjdCBzbmRfc29jX2NhcmQgdDUzMjUgPSB7CiAJLm5hbWUgPSAi
dDUzMjUiLAorCS5vd25lciA9IFRISVNfTU9EVUxFLAogCS5kYWlfbGluayA9IHQ1MzI1X2RhaSwK
IAkubnVtX2xpbmtzID0gQVJSQVlfU0laRSh0NTMyNV9kYWkpLAogfTsKLS0gCjEuNy41LjQKCgoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQWxzYS1kZXZl
bCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFu
LmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
