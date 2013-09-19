From: Jean-Francois Moine <moinejf@free.fr>
Subject: [PATCH] ASoc: kirkwood: Extend the min and max number
 of bytes per period
Date: Thu, 19 Sep 2013 11:20:43 +0200
Message-ID: <20130919112043.5ad16147@armhf>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp2-g21.free.fr (smtp2-g21.free.fr [212.27.42.2])
 by alsa0.perex.cz (Postfix) with ESMTP id DE9982619E3
 for <alsa-devel@alsa-project.org>; Thu, 19 Sep 2013 11:18:38 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>, Russell King <rmk+kernel@arm.linux.org.uk>, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

VGhpcyBwYXRjaCBleHRlbmRzIHRoZSBtaW4gYW5kIG1heCBudW1iZXIgb2YgYnl0ZXMgcGVyIHBl
cmlvZC4KSXQgbWFpbmx5IHBlcm1pdHMgdG8gcmVkdWNlIHRoZSBzb3VuZCBkZWxheSBpbiBNSURJ
IHJlYWwtdGltZSBwbGF5aW5nLgoKU2lnbmVkLW9mZi1ieTogSmVhbi1GcmFuY29pcyBNb2luZSA8
bW9pbmVqZkBmcmVlLmZyPgotLS0KIHNvdW5kL3NvYy9raXJrd29vZC9raXJrd29vZC5oIHwgNCAr
Ky0tCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlm
ZiAtLWdpdCBhL3NvdW5kL3NvYy9raXJrd29vZC9raXJrd29vZC5oIGIvc291bmQvc29jL2tpcmt3
b29kL2tpcmt3b29kLmgKaW5kZXggZjhlMWNjYy4uYmYyM2FmYiAxMDA2NDQKLS0tIGEvc291bmQv
c29jL2tpcmt3b29kL2tpcmt3b29kLmgKKysrIGIvc291bmQvc29jL2tpcmt3b29kL2tpcmt3b29k
LmgKQEAgLTEyMyw4ICsxMjMsOCBAQAogLyogbmVlZCB0byBmaW5kIHdoZXJlIHRoZXkgY29tZSBm
cm9tICAgICAgICAgICAgICAgKi8KICNkZWZpbmUgS0lSS1dPT0RfU05EX01JTl9QRVJJT0RTCQk4
CiAjZGVmaW5lIEtJUktXT09EX1NORF9NQVhfUEVSSU9EUwkJMTYKLSNkZWZpbmUgS0lSS1dPT0Rf
U05EX01JTl9QRVJJT0RfQllURVMJCTB4NDAwMAotI2RlZmluZSBLSVJLV09PRF9TTkRfTUFYX1BF
UklPRF9CWVRFUwkJMHg0MDAwCisjZGVmaW5lIEtJUktXT09EX1NORF9NSU5fUEVSSU9EX0JZVEVT
CQkweDgwMAorI2RlZmluZSBLSVJLV09PRF9TTkRfTUFYX1BFUklPRF9CWVRFUwkJMHg4MDAwCiAj
ZGVmaW5lIEtJUktXT09EX1NORF9NQVhfQlVGRkVSX0JZVEVTCQkoS0lSS1dPT0RfU05EX01BWF9Q
RVJJT0RfQllURVMgXAogCQkJCQkJICogS0lSS1dPT0RfU05EX01BWF9QRVJJT0RTKQogCi0tIApL
ZW4gYXIgYydoZW50YcOxCXwJICAgICAgKiogQnJlaXpoIGhhIExpbnV4IGF0YXYhICoqCkplZgkJ
fAkJaHR0cDovL21vaW5lamYuZnJlZS5mci8KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNh
LXByb2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0
aW5mby9hbHNhLWRldmVsCg==
