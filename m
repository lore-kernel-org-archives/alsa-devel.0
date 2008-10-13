From: "Arun KS" <arunks@mistralsolutions.com>
Subject: [PATCH] ALSA: ASoC: Fix compile-time warning for
	tlv320aic23.c
Date: Mon, 13 Oct 2008 18:09:36 +0530
Message-ID: <dfeb90390810130539k425caa6ep9cc03d75b49d7433@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_94041_16473630.1223901576085"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from po-out-1718.google.com (po-out-1718.google.com [72.14.252.158])
	by alsa0.perex.cz (Postfix) with ESMTP id E098A24467
	for <alsa-devel@alsa-project.org>;
	Mon, 13 Oct 2008 14:39:54 +0200 (CEST)
Received: by po-out-1718.google.com with SMTP id b23so2759498poe.2
	for <alsa-devel@alsa-project.org>; Mon, 13 Oct 2008 05:39:36 -0700 (PDT)
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
Cc: Takashi Iwai <tiwai@suse.de>, Andrew Morton <akpm@linux-foundation.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

------=_Part_94041_16473630.1223901576085
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Fixes this warning:

sound/soc/codecs/tlv320aic23.c: In function 'tlv320aic23_write':
sound/soc/codecs/tlv320aic23.c:104: warning: passing argument 2 of
'codec->hw_write' makes pointer from integer without a cast

Replaces i2c smbus write function with standard i2c write function

Signed-off-by: Arun KS <arunks@mistralsolutions.com>
---
 sound/soc/codecs/tlv320aic23.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic23.c b/sound/soc/codecs/tlv320aic23.c
index bac7815..44308da 100644
--- a/sound/soc/codecs/tlv320aic23.c
+++ b/sound/soc/codecs/tlv320aic23.c
@@ -84,7 +84,7 @@ static int tlv320aic23_write(struct snd_soc_codec
*codec, unsigned int reg,
 			     unsigned int value)
 {

-	u8 data;
+	u8 data[2];

 	/* TLV320AIC23 has 7 bit address and 9 bits of data
 	 * so we need to switch one data bit into reg and rest
@@ -96,12 +96,12 @@ static int tlv320aic23_write(struct snd_soc_codec
*codec, unsigned int reg,
 		return -1;
 	}

-	data = (reg << 1) | (value >> 8 & 0x01);
+	data[0] = (reg << 1) | (value >> 8 & 0x01);
+	data[1] = value & 0xff;

 	tlv320aic23_write_reg_cache(codec, reg, value);

-	if (codec->hw_write(codec->control_data, data,
-			    (value & 0xff)) == 0)
+	if (codec->hw_write(codec->control_data, data, 2) == 2)
 		return 0;

 	printk(KERN_ERR "%s cannot write %03x to register R%d\n", __func__,
@@ -674,7 +674,7 @@ static int tlv320aic23_probe(struct platform_device *pdev)

 	tlv320aic23_socdev = socdev;
 #if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
-	codec->hw_write = (hw_write_t) i2c_smbus_write_byte_data;
+	codec->hw_write = (hw_write_t) i2c_master_send;
 	codec->hw_read = NULL;
 	ret = i2c_add_driver(&tlv320aic23_i2c_driver);
 	if (ret != 0)
-- 
1.5.3.4

------=_Part_94041_16473630.1223901576085
Content-Type: text/x-patch;
 name=0001-ALSA-ASoC-Fix-compile-time-warning-for-tlv320aic23.patch
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fm9farzu0
Content-Disposition: attachment;
 filename=0001-ALSA-ASoC-Fix-compile-time-warning-for-tlv320aic23.patch

RnJvbSA1MzU1YjE4YmVjMGQ1Mjg2Nzc2YmU4MDZkYzA2ZWY1OGFjMWE4MThkIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBcnVuIEtTIDxhcnVua3NAbWlzdHJhbHNvbHV0aW9ucy5jb20+
CkRhdGU6IE1vbiwgMTMgT2N0IDIwMDggMTU6NDc6MjUgKzA1MzAKU3ViamVjdDogW1BBVENIXSBB
TFNBOiBBU29DOiBGaXggY29tcGlsZS10aW1lIHdhcm5pbmcgZm9yIHRsdjMyMGFpYzIzLmMKCkZp
eGVzIHRoaXMgd2FybmluZzoKCnNvdW5kL3NvYy9jb2RlY3MvdGx2MzIwYWljMjMuYzogSW4gZnVu
Y3Rpb24gJ3RsdjMyMGFpYzIzX3dyaXRlJzoKc291bmQvc29jL2NvZGVjcy90bHYzMjBhaWMyMy5j
OjEwNDogd2FybmluZzogcGFzc2luZyBhcmd1bWVudCAyIG9mCidjb2RlYy0+aHdfd3JpdGUnIG1h
a2VzIHBvaW50ZXIgZnJvbSBpbnRlZ2VyIHdpdGhvdXQgYSBjYXN0CgpSZXBsYWNlcyBpMmMgc21i
dXMgd3JpdGUgZnVuY3Rpb24gd2l0aCBzdGFuZGFyZCBpMmMgd3JpdGUgZnVuY3Rpb24KClNpZ25l
ZC1vZmYtYnk6IEFydW4gS1MgPGFydW5rc0BtaXN0cmFsc29sdXRpb25zLmNvbT4KLS0tCiBzb3Vu
ZC9zb2MvY29kZWNzL3RsdjMyMGFpYzIzLmMgfCAgIDEwICsrKysrLS0tLS0KIDEgZmlsZXMgY2hh
bmdlZCwgNSBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3NvdW5k
L3NvYy9jb2RlY3MvdGx2MzIwYWljMjMuYyBiL3NvdW5kL3NvYy9jb2RlY3MvdGx2MzIwYWljMjMu
YwppbmRleCBiYWM3ODE1Li40NDMwOGRhIDEwMDY0NAotLS0gYS9zb3VuZC9zb2MvY29kZWNzL3Rs
djMyMGFpYzIzLmMKKysrIGIvc291bmQvc29jL2NvZGVjcy90bHYzMjBhaWMyMy5jCkBAIC04NCw3
ICs4NCw3IEBAIHN0YXRpYyBpbnQgdGx2MzIwYWljMjNfd3JpdGUoc3RydWN0IHNuZF9zb2NfY29k
ZWMgKmNvZGVjLCB1bnNpZ25lZCBpbnQgcmVnLAogCQkJICAgICB1bnNpZ25lZCBpbnQgdmFsdWUp
CiB7CiAKLQl1OCBkYXRhOworCXU4IGRhdGFbMl07CiAKIAkvKiBUTFYzMjBBSUMyMyBoYXMgNyBi
aXQgYWRkcmVzcyBhbmQgOSBiaXRzIG9mIGRhdGEKIAkgKiBzbyB3ZSBuZWVkIHRvIHN3aXRjaCBv
bmUgZGF0YSBiaXQgaW50byByZWcgYW5kIHJlc3QKQEAgLTk2LDEyICs5NiwxMiBAQCBzdGF0aWMg
aW50IHRsdjMyMGFpYzIzX3dyaXRlKHN0cnVjdCBzbmRfc29jX2NvZGVjICpjb2RlYywgdW5zaWdu
ZWQgaW50IHJlZywKIAkJcmV0dXJuIC0xOwogCX0KIAotCWRhdGEgPSAocmVnIDw8IDEpIHwgKHZh
bHVlID4+IDggJiAweDAxKTsKKwlkYXRhWzBdID0gKHJlZyA8PCAxKSB8ICh2YWx1ZSA+PiA4ICYg
MHgwMSk7CisJZGF0YVsxXSA9IHZhbHVlICYgMHhmZjsKIAogCXRsdjMyMGFpYzIzX3dyaXRlX3Jl
Z19jYWNoZShjb2RlYywgcmVnLCB2YWx1ZSk7CiAKLQlpZiAoY29kZWMtPmh3X3dyaXRlKGNvZGVj
LT5jb250cm9sX2RhdGEsIGRhdGEsCi0JCQkgICAgKHZhbHVlICYgMHhmZikpID09IDApCisJaWYg
KGNvZGVjLT5od193cml0ZShjb2RlYy0+Y29udHJvbF9kYXRhLCBkYXRhLCAyKSA9PSAyKQogCQly
ZXR1cm4gMDsKIAogCXByaW50ayhLRVJOX0VSUiAiJXMgY2Fubm90IHdyaXRlICUwM3ggdG8gcmVn
aXN0ZXIgUiVkXG4iLCBfX2Z1bmNfXywKQEAgLTY3NCw3ICs2NzQsNyBAQCBzdGF0aWMgaW50IHRs
djMyMGFpYzIzX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpCiAKIAl0bHYzMjBh
aWMyM19zb2NkZXYgPSBzb2NkZXY7CiAjaWYgZGVmaW5lZChDT05GSUdfSTJDKSB8fCBkZWZpbmVk
KENPTkZJR19JMkNfTU9EVUxFKQotCWNvZGVjLT5od193cml0ZSA9IChod193cml0ZV90KSBpMmNf
c21idXNfd3JpdGVfYnl0ZV9kYXRhOworCWNvZGVjLT5od193cml0ZSA9IChod193cml0ZV90KSBp
MmNfbWFzdGVyX3NlbmQ7CiAJY29kZWMtPmh3X3JlYWQgPSBOVUxMOwogCXJldCA9IGkyY19hZGRf
ZHJpdmVyKCZ0bHYzMjBhaWMyM19pMmNfZHJpdmVyKTsKIAlpZiAocmV0ICE9IDApCi0tIAoxLjUu
My40Cgo=
------=_Part_94041_16473630.1223901576085
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

------=_Part_94041_16473630.1223901576085--
