From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 6/8] ASoC: s6000: Add .owner to struct
	snd_soc_card
Date: Fri, 23 Dec 2011 14:52:22 +0800
Message-ID: <1324623142.2295.5.camel@phoenix>
References: <1324622828.2295.0.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gx0-f179.google.com (mail-gx0-f179.google.com
	[209.85.161.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 8D0D6103F4D
	for <alsa-devel@alsa-project.org>; Fri, 23 Dec 2011 07:52:29 +0100 (CET)
Received: by ggnv5 with SMTP id v5so6771694ggn.38
	for <alsa-devel@alsa-project.org>; Thu, 22 Dec 2011 22:52:28 -0800 (PST)
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
Cc: Lothar =?ISO-8859-1?Q?Wa=DFmann?= <LW@KARO-electronics.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Daniel Gloeckner <dg@emlix.com>
List-Id: alsa-devel@alsa-project.org

QWRkIG1pc3NpbmcgLm93bmVyIG9mIHN0cnVjdCBzbmRfc29jX2NhcmQuIFRoaXMgcHJldmVudHMg
dGhlIG1vZHVsZSBmcm9tIGJlaW5nCnJlbW92ZWQgZnJvbSB1bmRlcm5lYXRoIGl0cyB1c2Vycy4K
ClJlcG9ydGVkLWJ5OiBMb3RoYXIgV2HDn21hbm4gPExXQEtBUk8tZWxlY3Ryb25pY3MuZGU+ClNp
Z25lZC1vZmYtYnk6IEF4ZWwgTGluIDxheGVsLmxpbkBnbWFpbC5jb20+Ci0tLQogc291bmQvc29j
L3M2MDAwL3M2MTA1LWlwY2FtLmMgfCAgICAxICsKIDEgZmlsZXMgY2hhbmdlZCwgMSBpbnNlcnRp
b25zKCspLCAwIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3NvdW5kL3NvYy9zNjAwMC9zNjEw
NS1pcGNhbS5jIGIvc291bmQvc29jL3M2MDAwL3M2MTA1LWlwY2FtLmMKaW5kZXggNTg5MGU0My4u
NThjZmIxZSAxMDA2NDQKLS0tIGEvc291bmQvc29jL3M2MDAwL3M2MTA1LWlwY2FtLmMKKysrIGIv
c291bmQvc29jL3M2MDAwL3M2MTA1LWlwY2FtLmMKQEAgLTE4Nyw2ICsxODcsNyBAQCBzdGF0aWMg
c3RydWN0IHNuZF9zb2NfZGFpX2xpbmsgczYxMDVfZGFpID0gewogLyogczYxMDUgYXVkaW8gbWFj
aGluZSBkcml2ZXIgKi8KIHN0YXRpYyBzdHJ1Y3Qgc25kX3NvY19jYXJkIHNuZF9zb2NfY2FyZF9z
NjEwNSA9IHsKIAkubmFtZSA9ICJTdHJldGNoIElQIENhbWVyYSIsCisJLm93bmVyID0gVEhJU19N
T0RVTEUsCiAJLmRhaV9saW5rID0gJnM2MTA1X2RhaSwKIAkubnVtX2xpbmtzID0gMSwKIH07Ci0t
IAoxLjcuNS40CgoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpo
dHRwOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZl
bAo=
