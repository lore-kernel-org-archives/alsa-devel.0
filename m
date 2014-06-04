From: ShaRab Shaik <sharab.shaik@gmail.com>
Subject: [PATCH] sound: tlv320aic32x4: Fixed Coding style issues
Date: Wed, 4 Jun 2014 16:49:54 +0530
Message-ID: <CAHWZSxgM17azkvwxOAcR3skaUXRcaoxbiHxE3bMNrfg2dNTRkw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=f46d0442685a3806c204fb00d16f
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f181.google.com (mail-wi0-f181.google.com
 [209.85.212.181])
 by alsa0.perex.cz (Postfix) with ESMTP id 17726262634
 for <alsa-devel@alsa-project.org>; Wed,  4 Jun 2014 13:20:38 +0200 (CEST)
Received: by mail-wi0-f181.google.com with SMTP id n15so1218584wiw.14
 for <alsa-devel@alsa-project.org>; Wed, 04 Jun 2014 04:20:36 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: perex@perex.cz, tiwai@suse.de, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, broonie@kernel.org, lgirdwood@gmail.com
Cc: ShaRab Shaik <sharab.shaik@gmail.com>
List-Id: alsa-devel@alsa-project.org

--f46d0442685a3806c204fb00d16f
Content-Type: text/plain; charset=UTF-8

>From 617d7a25f3c0c08e0b95b24de2d1ea0f3f4b98c7 Mon Sep 17 00:00:00 2001
From: Shahina Shaik <sharab.shaik@gmail.com>
Date: Wed, 4 Jun 2014 16:27:19 +0530
Subject: [PATCH] sound: tlv320aic32x4: Fixed Coding style issues.

Fixed brace coding style, lines morethan 80 characters issues.
Replaced printk with pr_err as pr_err is prefered than printk.

Signed-off-by: Shahina Shaik <sharab.shaik@gmail.com>
---
 sound/soc/codecs/tlv320aic32x4.c |   34 +++++++++++++++++++---------------
 1 files changed, 19 insertions(+), 15 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic32x4.c
b/sound/soc/codecs/tlv320aic32x4.c
index 1d9b117..9e45490 100644
--- a/sound/soc/codecs/tlv320aic32x4.c
+++ b/sound/soc/codecs/tlv320aic32x4.c
@@ -306,7 +306,7 @@ static inline int aic32x4_get_divs(int mclk, int rate)
             return i;
         }
     }
-    printk(KERN_ERR "aic32x4: master clock and sample rate is not
supported\n");
+    pr_err(KERN_ERR "aic32x4: master clock and sample rate is not
supported\n");
     return -EINVAL;
 }

@@ -323,7 +323,7 @@ static int aic32x4_set_dai_sysclk(struct snd_soc_dai
*codec_dai,
         aic32x4->sysclk = freq;
         return 0;
     }
-    printk(KERN_ERR "aic32x4: invalid frequency to set DAI system
clock\n");
+    pr_err(KERN_ERR "aic32x4: invalid frequency to set DAI system
clock\n");
     return -EINVAL;
 }

@@ -349,7 +349,7 @@ static int aic32x4_set_dai_fmt(struct snd_soc_dai
*codec_dai, unsigned int fmt)
     case SND_SOC_DAIFMT_CBS_CFS:
         break;
     default:
-        printk(KERN_ERR "aic32x4: invalid DAI master/slave interface\n");
+        pr_err(KERN_ERR "aic32x4: invalid DAI master/slave interface\n");
         return -EINVAL;
     }

@@ -374,7 +374,7 @@ static int aic32x4_set_dai_fmt(struct snd_soc_dai
*codec_dai, unsigned int fmt)
             (AIC32X4_LEFT_JUSTIFIED_MODE << AIC32X4_PLLJ_SHIFT);
         break;
     default:
-        printk(KERN_ERR "aic32x4: invalid DAI interface format\n");
+        pr_err(KERN_ERR "aic32x4: invalid DAI interface format\n");
         return -EINVAL;
     }

@@ -395,7 +395,7 @@ static int aic32x4_hw_params(struct snd_pcm_substream
*substream,

     i = aic32x4_get_divs(aic32x4->sysclk, params_rate(params));
     if (i < 0) {
-        printk(KERN_ERR "aic32x4: sampling rate not supported\n");
+        pr_err(KERN_ERR "aic32x4: sampling rate not supported\n");
         return i;
     }

@@ -626,32 +626,36 @@ static int aic32x4_probe(struct snd_soc_codec *codec)
         snd_soc_write(codec, AIC32X4_MICBIAS, AIC32X4_MICBIAS_LDOIN |
                               AIC32X4_MICBIAS_2075V);
     }
-    if (aic32x4->power_cfg & AIC32X4_PWR_AVDD_DVDD_WEAK_DISABLE) {
+    if (aic32x4->power_cfg & AIC32X4_PWR_AVDD_DVDD_WEAK_DISABLE)
         snd_soc_write(codec, AIC32X4_PWRCFG, AIC32X4_AVDDWEAKDISABLE);
-    }
+

     tmp_reg = (aic32x4->power_cfg & AIC32X4_PWR_AIC32X4_LDO_ENABLE) ?
             AIC32X4_LDOCTLEN : 0;
     snd_soc_write(codec, AIC32X4_LDOCTL, tmp_reg);

     tmp_reg = snd_soc_read(codec, AIC32X4_CMMODE);
-    if (aic32x4->power_cfg & AIC32X4_PWR_CMMODE_LDOIN_RANGE_18_36) {
+    if (aic32x4->power_cfg & AIC32X4_PWR_CMMODE_LDOIN_RANGE_18_36)
         tmp_reg |= AIC32X4_LDOIN_18_36;
-    }
-    if (aic32x4->power_cfg & AIC32X4_PWR_CMMODE_HP_LDOIN_POWERED) {
+
+    if (aic32x4->power_cfg & AIC32X4_PWR_CMMODE_HP_LDOIN_POWERED)
         tmp_reg |= AIC32X4_LDOIN2HP;
-    }
+
     snd_soc_write(codec, AIC32X4_CMMODE, tmp_reg);

     /* Mic PGA routing */
     if (aic32x4->micpga_routing & AIC32X4_MICPGA_ROUTE_LMIC_IN2R_10K)
-        snd_soc_write(codec, AIC32X4_LMICPGANIN,
AIC32X4_LMICPGANIN_IN2R_10K);
+        snd_soc_write(codec, AIC32X4_LMICPGANIN,
+                AIC32X4_LMICPGANIN_IN2R_10K);
     else
-        snd_soc_write(codec, AIC32X4_LMICPGANIN,
AIC32X4_LMICPGANIN_CM1L_10K);
+        snd_soc_write(codec, AIC32X4_LMICPGANIN,
+                AIC32X4_LMICPGANIN_CM1L_10K);
     if (aic32x4->micpga_routing & AIC32X4_MICPGA_ROUTE_RMIC_IN1L_10K)
-        snd_soc_write(codec, AIC32X4_RMICPGANIN,
AIC32X4_RMICPGANIN_IN1L_10K);
+        snd_soc_write(codec, AIC32X4_RMICPGANIN,
+                AIC32X4_RMICPGANIN_IN1L_10K);
     else
-        snd_soc_write(codec, AIC32X4_RMICPGANIN,
AIC32X4_RMICPGANIN_CM1R_10K);
+        snd_soc_write(codec, AIC32X4_RMICPGANIN,
+                AIC32X4_RMICPGANIN_CM1R_10K);

     aic32x4_set_bias_level(codec, SND_SOC_BIAS_STANDBY);

--f46d0442685a3806c204fb00d16f
Content-Type: text/x-patch; charset=US-ASCII;
	name="0001-sound-tlv320aic32x4-Fixed-Coding-style-issues.patch"
Content-Disposition: attachment;
	filename="0001-sound-tlv320aic32x4-Fixed-Coding-style-issues.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_hw0jpsdt0

RnJvbSA2MTdkN2EyNWYzYzBjMDhlMGI5NWIyNGRlMmQxZWEwZjNmNGI5OGM3IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTaGFoaW5hIFNoYWlrIDxzaGFyYWIuc2hhaWtAZ21haWwuY29t
PgpEYXRlOiBXZWQsIDQgSnVuIDIwMTQgMTY6Mjc6MTkgKzA1MzAKU3ViamVjdDogW1BBVENIXSBz
b3VuZDogdGx2MzIwYWljMzJ4NDogRml4ZWQgQ29kaW5nIHN0eWxlIGlzc3Vlcy4KCkZpeGVkIGJy
YWNlIGNvZGluZyBzdHlsZSwgbGluZXMgbW9yZXRoYW4gODAgY2hhcmFjdGVycyBpc3N1ZXMuClJl
cGxhY2VkIHByaW50ayB3aXRoIHByX2VyciBhcyBwcl9lcnIgaXMgcHJlZmVyZWQgdGhhbiBwcmlu
dGsuCgpTaWduZWQtb2ZmLWJ5OiBTaGFoaW5hIFNoYWlrIDxzaGFyYWIuc2hhaWtAZ21haWwuY29t
PgotLS0KIHNvdW5kL3NvYy9jb2RlY3MvdGx2MzIwYWljMzJ4NC5jIHwgICAzNCArKysrKysrKysr
KysrKysrKysrLS0tLS0tLS0tLS0tLS0tCiAxIGZpbGVzIGNoYW5nZWQsIDE5IGluc2VydGlvbnMo
KyksIDE1IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3NvdW5kL3NvYy9jb2RlY3MvdGx2MzIw
YWljMzJ4NC5jIGIvc291bmQvc29jL2NvZGVjcy90bHYzMjBhaWMzMng0LmMKaW5kZXggMWQ5YjEx
Ny4uOWU0NTQ5MCAxMDA2NDQKLS0tIGEvc291bmQvc29jL2NvZGVjcy90bHYzMjBhaWMzMng0LmMK
KysrIGIvc291bmQvc29jL2NvZGVjcy90bHYzMjBhaWMzMng0LmMKQEAgLTMwNiw3ICszMDYsNyBA
QCBzdGF0aWMgaW5saW5lIGludCBhaWMzMng0X2dldF9kaXZzKGludCBtY2xrLCBpbnQgcmF0ZSkK
IAkJCXJldHVybiBpOwogCQl9CiAJfQotCXByaW50ayhLRVJOX0VSUiAiYWljMzJ4NDogbWFzdGVy
IGNsb2NrIGFuZCBzYW1wbGUgcmF0ZSBpcyBub3Qgc3VwcG9ydGVkXG4iKTsKKwlwcl9lcnIoS0VS
Tl9FUlIgImFpYzMyeDQ6IG1hc3RlciBjbG9jayBhbmQgc2FtcGxlIHJhdGUgaXMgbm90IHN1cHBv
cnRlZFxuIik7CiAJcmV0dXJuIC1FSU5WQUw7CiB9CiAKQEAgLTMyMyw3ICszMjMsNyBAQCBzdGF0
aWMgaW50IGFpYzMyeDRfc2V0X2RhaV9zeXNjbGsoc3RydWN0IHNuZF9zb2NfZGFpICpjb2RlY19k
YWksCiAJCWFpYzMyeDQtPnN5c2NsayA9IGZyZXE7CiAJCXJldHVybiAwOwogCX0KLQlwcmludGso
S0VSTl9FUlIgImFpYzMyeDQ6IGludmFsaWQgZnJlcXVlbmN5IHRvIHNldCBEQUkgc3lzdGVtIGNs
b2NrXG4iKTsKKwlwcl9lcnIoS0VSTl9FUlIgImFpYzMyeDQ6IGludmFsaWQgZnJlcXVlbmN5IHRv
IHNldCBEQUkgc3lzdGVtIGNsb2NrXG4iKTsKIAlyZXR1cm4gLUVJTlZBTDsKIH0KIApAQCAtMzQ5
LDcgKzM0OSw3IEBAIHN0YXRpYyBpbnQgYWljMzJ4NF9zZXRfZGFpX2ZtdChzdHJ1Y3Qgc25kX3Nv
Y19kYWkgKmNvZGVjX2RhaSwgdW5zaWduZWQgaW50IGZtdCkKIAljYXNlIFNORF9TT0NfREFJRk1U
X0NCU19DRlM6CiAJCWJyZWFrOwogCWRlZmF1bHQ6Ci0JCXByaW50ayhLRVJOX0VSUiAiYWljMzJ4
NDogaW52YWxpZCBEQUkgbWFzdGVyL3NsYXZlIGludGVyZmFjZVxuIik7CisJCXByX2VycihLRVJO
X0VSUiAiYWljMzJ4NDogaW52YWxpZCBEQUkgbWFzdGVyL3NsYXZlIGludGVyZmFjZVxuIik7CiAJ
CXJldHVybiAtRUlOVkFMOwogCX0KIApAQCAtMzc0LDcgKzM3NCw3IEBAIHN0YXRpYyBpbnQgYWlj
MzJ4NF9zZXRfZGFpX2ZtdChzdHJ1Y3Qgc25kX3NvY19kYWkgKmNvZGVjX2RhaSwgdW5zaWduZWQg
aW50IGZtdCkKIAkJCShBSUMzMlg0X0xFRlRfSlVTVElGSUVEX01PREUgPDwgQUlDMzJYNF9QTExK
X1NISUZUKTsKIAkJYnJlYWs7CiAJZGVmYXVsdDoKLQkJcHJpbnRrKEtFUk5fRVJSICJhaWMzMng0
OiBpbnZhbGlkIERBSSBpbnRlcmZhY2UgZm9ybWF0XG4iKTsKKwkJcHJfZXJyKEtFUk5fRVJSICJh
aWMzMng0OiBpbnZhbGlkIERBSSBpbnRlcmZhY2UgZm9ybWF0XG4iKTsKIAkJcmV0dXJuIC1FSU5W
QUw7CiAJfQogCkBAIC0zOTUsNyArMzk1LDcgQEAgc3RhdGljIGludCBhaWMzMng0X2h3X3BhcmFt
cyhzdHJ1Y3Qgc25kX3BjbV9zdWJzdHJlYW0gKnN1YnN0cmVhbSwKIAogCWkgPSBhaWMzMng0X2dl
dF9kaXZzKGFpYzMyeDQtPnN5c2NsaywgcGFyYW1zX3JhdGUocGFyYW1zKSk7CiAJaWYgKGkgPCAw
KSB7Ci0JCXByaW50ayhLRVJOX0VSUiAiYWljMzJ4NDogc2FtcGxpbmcgcmF0ZSBub3Qgc3VwcG9y
dGVkXG4iKTsKKwkJcHJfZXJyKEtFUk5fRVJSICJhaWMzMng0OiBzYW1wbGluZyByYXRlIG5vdCBz
dXBwb3J0ZWRcbiIpOwogCQlyZXR1cm4gaTsKIAl9CiAKQEAgLTYyNiwzMiArNjI2LDM2IEBAIHN0
YXRpYyBpbnQgYWljMzJ4NF9wcm9iZShzdHJ1Y3Qgc25kX3NvY19jb2RlYyAqY29kZWMpCiAJCXNu
ZF9zb2Nfd3JpdGUoY29kZWMsIEFJQzMyWDRfTUlDQklBUywgQUlDMzJYNF9NSUNCSUFTX0xET0lO
IHwKIAkJCQkJCSAgICAgIEFJQzMyWDRfTUlDQklBU18yMDc1Vik7CiAJfQotCWlmIChhaWMzMng0
LT5wb3dlcl9jZmcgJiBBSUMzMlg0X1BXUl9BVkREX0RWRERfV0VBS19ESVNBQkxFKSB7CisJaWYg
KGFpYzMyeDQtPnBvd2VyX2NmZyAmIEFJQzMyWDRfUFdSX0FWRERfRFZERF9XRUFLX0RJU0FCTEUp
CiAJCXNuZF9zb2Nfd3JpdGUoY29kZWMsIEFJQzMyWDRfUFdSQ0ZHLCBBSUMzMlg0X0FWRERXRUFL
RElTQUJMRSk7Ci0JfQorCiAKIAl0bXBfcmVnID0gKGFpYzMyeDQtPnBvd2VyX2NmZyAmIEFJQzMy
WDRfUFdSX0FJQzMyWDRfTERPX0VOQUJMRSkgPwogCQkJQUlDMzJYNF9MRE9DVExFTiA6IDA7CiAJ
c25kX3NvY193cml0ZShjb2RlYywgQUlDMzJYNF9MRE9DVEwsIHRtcF9yZWcpOwogCiAJdG1wX3Jl
ZyA9IHNuZF9zb2NfcmVhZChjb2RlYywgQUlDMzJYNF9DTU1PREUpOwotCWlmIChhaWMzMng0LT5w
b3dlcl9jZmcgJiBBSUMzMlg0X1BXUl9DTU1PREVfTERPSU5fUkFOR0VfMThfMzYpIHsKKwlpZiAo
YWljMzJ4NC0+cG93ZXJfY2ZnICYgQUlDMzJYNF9QV1JfQ01NT0RFX0xET0lOX1JBTkdFXzE4XzM2
KQogCQl0bXBfcmVnIHw9IEFJQzMyWDRfTERPSU5fMThfMzY7Ci0JfQotCWlmIChhaWMzMng0LT5w
b3dlcl9jZmcgJiBBSUMzMlg0X1BXUl9DTU1PREVfSFBfTERPSU5fUE9XRVJFRCkgeworCisJaWYg
KGFpYzMyeDQtPnBvd2VyX2NmZyAmIEFJQzMyWDRfUFdSX0NNTU9ERV9IUF9MRE9JTl9QT1dFUkVE
KQogCQl0bXBfcmVnIHw9IEFJQzMyWDRfTERPSU4ySFA7Ci0JfQorCiAJc25kX3NvY193cml0ZShj
b2RlYywgQUlDMzJYNF9DTU1PREUsIHRtcF9yZWcpOwogCiAJLyogTWljIFBHQSByb3V0aW5nICov
CiAJaWYgKGFpYzMyeDQtPm1pY3BnYV9yb3V0aW5nICYgQUlDMzJYNF9NSUNQR0FfUk9VVEVfTE1J
Q19JTjJSXzEwSykKLQkJc25kX3NvY193cml0ZShjb2RlYywgQUlDMzJYNF9MTUlDUEdBTklOLCBB
SUMzMlg0X0xNSUNQR0FOSU5fSU4yUl8xMEspOworCQlzbmRfc29jX3dyaXRlKGNvZGVjLCBBSUMz
Mlg0X0xNSUNQR0FOSU4sCisJCQkJQUlDMzJYNF9MTUlDUEdBTklOX0lOMlJfMTBLKTsKIAllbHNl
Ci0JCXNuZF9zb2Nfd3JpdGUoY29kZWMsIEFJQzMyWDRfTE1JQ1BHQU5JTiwgQUlDMzJYNF9MTUlD
UEdBTklOX0NNMUxfMTBLKTsKKwkJc25kX3NvY193cml0ZShjb2RlYywgQUlDMzJYNF9MTUlDUEdB
TklOLAorCQkJCUFJQzMyWDRfTE1JQ1BHQU5JTl9DTTFMXzEwSyk7CiAJaWYgKGFpYzMyeDQtPm1p
Y3BnYV9yb3V0aW5nICYgQUlDMzJYNF9NSUNQR0FfUk9VVEVfUk1JQ19JTjFMXzEwSykKLQkJc25k
X3NvY193cml0ZShjb2RlYywgQUlDMzJYNF9STUlDUEdBTklOLCBBSUMzMlg0X1JNSUNQR0FOSU5f
SU4xTF8xMEspOworCQlzbmRfc29jX3dyaXRlKGNvZGVjLCBBSUMzMlg0X1JNSUNQR0FOSU4sCisJ
CQkJQUlDMzJYNF9STUlDUEdBTklOX0lOMUxfMTBLKTsKIAllbHNlCi0JCXNuZF9zb2Nfd3JpdGUo
Y29kZWMsIEFJQzMyWDRfUk1JQ1BHQU5JTiwgQUlDMzJYNF9STUlDUEdBTklOX0NNMVJfMTBLKTsK
KwkJc25kX3NvY193cml0ZShjb2RlYywgQUlDMzJYNF9STUlDUEdBTklOLAorCQkJCUFJQzMyWDRf
Uk1JQ1BHQU5JTl9DTTFSXzEwSyk7CiAKIAlhaWMzMng0X3NldF9iaWFzX2xldmVsKGNvZGVjLCBT
TkRfU09DX0JJQVNfU1RBTkRCWSk7CiAKLS0gCjEuNy4wLjQKCg==
--f46d0442685a3806c204fb00d16f
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--f46d0442685a3806c204fb00d16f--
