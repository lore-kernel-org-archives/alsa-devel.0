From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 3/3] ASoC: rockchip: Fix an uninitialized
	variable compile warning
Date: Mon,  6 May 2019 17:02:24 +0200
Message-ID: <20190506150224.1394-4-tiwai@suse.de>
References: <20190506150224.1394-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 37EE8F89701
 for <alsa-devel@alsa-project.org>; Mon,  6 May 2019 17:02:25 +0200 (CEST)
In-Reply-To: <20190506150224.1394-1-tiwai@suse.de>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

UGFwZXIgb3ZlciBhIHRyaXZpYWwgY2FzZSBsZWFkaW5nIHRvIGFuIHVuaW5pdGlhbGl6ZWQgdmFy
aWFibGUgY29tcGlsZQp3YXJuaW5nOgogIHNvdW5kL3NvYy9yb2NrY2hpcC9yb2NrY2hpcF9wZG0u
YzoxNzk6Mzogd2FybmluZzog4oCYY2xrX291dOKAmSBtYXkgYmUgdXNlZCB1bmluaXRpYWxpemVk
IGluIHRoaXMgZnVuY3Rpb24gWy1XbWF5YmUtdW5pbml0aWFsaXplZF0KCkZpeGVzOiA2MjRlOGUw
MGFjYWYgKCJBU29DOiByb2NrY2hpcDogcGRtOiBmaXh1cCBwZG0gZnJhY3Rpb25hbCBkaXYiKQpT
aWduZWQtb2ZmLWJ5OiBUYWthc2hpIEl3YWkgPHRpd2FpQHN1c2UuZGU+Ci0tLQogc291bmQvc29j
L3JvY2tjaGlwL3JvY2tjaGlwX3BkbS5jIHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0
aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvc291bmQvc29jL3JvY2tjaGlwL3Jv
Y2tjaGlwX3BkbS5jIGIvc291bmQvc29jL3JvY2tjaGlwL3JvY2tjaGlwX3BkbS5jCmluZGV4IDZj
MGYyNDJkYjVlZi4uYjljMWQ4YWQ3N2MxIDEwMDY0NAotLS0gYS9zb3VuZC9zb2Mvcm9ja2NoaXAv
cm9ja2NoaXBfcGRtLmMKKysrIGIvc291bmQvc29jL3JvY2tjaGlwL3JvY2tjaGlwX3BkbS5jCkBA
IC0xNTgsNyArMTU4LDcgQEAgc3RhdGljIGludCByb2NrY2hpcF9wZG1faHdfcGFyYW1zKHN0cnVj
dCBzbmRfcGNtX3N1YnN0cmVhbSAqc3Vic3RyZWFtLAogCXN0cnVjdCBya19wZG1fZGV2ICpwZG0g
PSB0b19pbmZvKGRhaSk7CiAJdW5zaWduZWQgaW50IHZhbCA9IDA7CiAJdW5zaWduZWQgaW50IGNs
a19yYXRlLCBjbGtfZGl2LCBzYW1wbGVyYXRlOwotCXVuc2lnbmVkIGludCBjbGtfc3JjLCBjbGtf
b3V0OworCXVuc2lnbmVkIGludCBjbGtfc3JjLCBjbGtfb3V0ID0gMDsKIAl1bnNpZ25lZCBsb25n
IG0sIG47CiAJYm9vbCBjaGFuZ2U7CiAJaW50IHJldDsKLS0gCjIuMTYuNAoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxp
c3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHBzOi8vbWFpbG1hbi5hbHNhLXByb2pl
Y3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
