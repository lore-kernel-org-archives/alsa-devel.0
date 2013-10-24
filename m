From: Jean-Francois Moine <moinejf@free.fr>
Subject: [PATCH] ASoC: kirkwood: Fix compile error due to patch
 'add S/PDIF support'
Date: Thu, 24 Oct 2013 17:55:18 +0200
Message-ID: <20131024175518.49b80343@armhf>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp3-g21.free.fr (smtp3-g21.free.fr [212.27.42.3])
 by alsa0.perex.cz (Postfix) with ESMTP id 07B242610A4
 for <alsa-devel@alsa-project.org>; Thu, 24 Oct 2013 17:54:52 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, alsa-devel@alsa-project.org, Jason Cooper <jason@lakedaemon.net>, Liam Girdwood <lgirdwood@gmail.com>, Russell King <rmk+kernel@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: alsa-devel@alsa-project.org

VGhpcyBwYXRjaCBmaXhlcyB0aGUgY29tcGlsYXRpb24gZXJyb3Igb2Yga2lya3dvb2QtaTJzLmMg
aW50cm9kdWNlZApieSB0aGUgY29tbWl0IDc1YjliNjVlZTVhODBlOTllICdBU29DOiBraXJrd29v
ZDogYWRkIFMvUERJRiBzdXBwb3J0Jy4KClNpZ25lZC1vZmYtYnk6IEplYW4tRnJhbmNvaXMgTW9p
bmUgPG1vaW5lamZAZnJlZS5mcj4KLS0tCgpNYXJrLCBzb3JyeSBmb3IgdGhpcyBlcnJvci4KVGhp
cyBwYXRjaCBhcHBsaWVzIG9uIHlvdXIgcmVwb3NpdG9yeSBicm9vbmllL3NvdW5kLmdpdC8gdG9w
aWMva2lya3dvb2QuCkkgbWF5IGdpdmUgeW91IGFuIG90aGVyIHBhdGNoIHRvIGFwcGx5IHdpdGgg
dGhlIGNvbW1pdCByZW1vdmVkLgoKLS0tCiBzb3VuZC9zb2Mva2lya3dvb2Qva2lya3dvb2QtaTJz
LmMgICAgIHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9u
KC0pCgpkaWZmIC0tZ2l0IGEvc291bmQvc29jL2tpcmt3b29kL2tpcmt3b29kLWkycy5jIGIvc291
bmQvc29jL2tpcmt3b29kL2tpcmt3b29kLWkycy5jCmluZGV4IDllYzM4ZDEuLmQzNGQ5MTcgMTAw
NjQ0Ci0tLSBhL3NvdW5kL3NvYy9raXJrd29vZC9raXJrd29vZC1pMnMuYworKysgYi9zb3VuZC9z
b2Mva2lya3dvb2Qva2lya3dvb2QtaTJzLmMKQEAgLTU2OCw3ICs1NjgsNyBAQCBzdGF0aWMgaW50
IGtpcmt3b29kX2kyc19kZXZfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikKIAkJ
fSBlbHNlIHsKIAkJCWRldl9pbmZvKCZwZGV2LT5kZXYsICJmb3VuZCBleHRlcm5hbCBjbG9ja1xu
Iik7CiAJCQljbGtfcHJlcGFyZV9lbmFibGUocHJpdi0+ZXh0Y2xrKTsKLQkJCXNvY19kYWkgPSAm
a2lya3dvb2RfaTJzX2RhaV9leHRjbGs7CisJCQlzb2NfZGFpID0ga2lya3dvb2RfaTJzX2RhaV9l
eHRjbGs7CiAJCX0KIAl9CiAKCgotLSAKS2VuIGFyIGMnaGVudGHDsQl8CSAgICAgICoqIEJyZWl6
aCBoYSBMaW51eCBhdGF2ISAqKgpKZWYJCXwJCWh0dHA6Ly9tb2luZWpmLmZyZWUuZnIvCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFp
bGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNh
LXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
