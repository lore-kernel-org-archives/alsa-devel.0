From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 3/6] ASoC: AD1836: Use snd_soc_update_bits for read-modify-write
Date: Mon,  6 Jun 2011 13:38:37 +0200
Message-ID: <1307360320-4727-3-git-send-email-lars@metafoo.de>
References: <1307360320-4727-1-git-send-email-lars@metafoo.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1307360320-4727-1-git-send-email-lars@metafoo.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, device-drivers-devel@blackfin.uclinux.org, linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

Use snd_soc_update_bits for read-modify-write register access instead of
open-coding it using snd_soc_read and snd_soc_write.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/ad1836.c |   18 ++++++------------
 1 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/sound/soc/codecs/ad1836.c b/sound/soc/codecs/ad1836.c
index 5c6d239..fde0f17 100644
--- a/sound/soc/codecs/ad1836.c
+++ b/sound/soc/codecs/ad1836.c
@@ -174,19 +174,15 @@ static int ad1836_soc_suspend(struct snd_soc_codec *codec,
 		pm_message_t state)
 {
 	/* reset clock control mode */
-	u16 adc_ctrl2 = snd_soc_read(codec, AD1836_ADC_CTRL2);
-	adc_ctrl2 &= ~AD1836_ADC_SERFMT_MASK;
-
-	return snd_soc_write(codec, AD1836_ADC_CTRL2, adc_ctrl2);
+	return snd_soc_update_bits(codec, AD1836_ADC_CTRL2,
+		AD1836_ADC_SERFMT_MASK, 0);
 }
 
 static int ad1836_soc_resume(struct snd_soc_codec *codec)
 {
 	/* restore clock control mode */
-	u16 adc_ctrl2 = snd_soc_read(codec, AD1836_ADC_CTRL2);
-	adc_ctrl2 |= AD1836_ADC_AUX;
-
-	return snd_soc_write(codec, AD1836_ADC_CTRL2, adc_ctrl2);
+	return snd_soc_update_bits(codec, AD1836_ADC_CTRL2,
+		AD1836_ADC_SERFMT_MASK, AD1836_ADC_AUX);
 }
 #else
 #define ad1836_soc_suspend NULL
@@ -266,10 +262,8 @@ static int ad1836_probe(struct snd_soc_codec *codec)
 static int ad1836_remove(struct snd_soc_codec *codec)
 {
 	/* reset clock control mode */
-	u16 adc_ctrl2 = snd_soc_read(codec, AD1836_ADC_CTRL2);
-	adc_ctrl2 &= ~AD1836_ADC_SERFMT_MASK;
-
-	return snd_soc_write(codec, AD1836_ADC_CTRL2, adc_ctrl2);
+	return snd_soc_update_bits(codec, AD1836_ADC_CTRL2,
+		AD1836_ADC_SERFMT_MASK, 0);
 }
 
 static struct snd_soc_codec_driver soc_codec_dev_ad1836 = {
-- 
1.7.2.5
