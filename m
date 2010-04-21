From: Barry Song <21cnbao@gmail.com>
Subject: [PATCH 2/3] ad193x: fix wrong register setting in
	ad193x_set_dai_fmt
Date: Wed, 21 Apr 2010 17:36:48 +0800
Message-ID: <1271842609-18276-3-git-send-email-21cnbao@gmail.com>
References: <1271842609-18276-1-git-send-email-21cnbao@gmail.com>
	<1271842609-18276-2-git-send-email-21cnbao@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nwd2mail10.analog.com (nwd2mail10.analog.com [137.71.25.55])
	by alsa0.perex.cz (Postfix) with ESMTP id 82E0910382E
	for <alsa-devel@alsa-project.org>;
	Wed, 21 Apr 2010 11:38:15 +0200 (CEST)
In-Reply-To: <1271842609-18276-2-git-send-email-21cnbao@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org, Barry Song <21cnbao@gmail.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Barry Song <21cnbao@gmail.com>
---
 sound/soc/codecs/ad193x.c |   48 +++++++++++++++++++++++---------------------
 1 files changed, 25 insertions(+), 23 deletions(-)

diff --git a/sound/soc/codecs/ad193x.c b/sound/soc/codecs/ad193x.c
index 8a099ac..e79788c 100644
--- a/sound/soc/codecs/ad193x.c
+++ b/sound/soc/codecs/ad193x.c
@@ -163,9 +163,10 @@ static int ad193x_set_dai_fmt(struct snd_soc_dai *codec_dai,
 		unsigned int fmt)
 {
 	struct snd_soc_codec *codec = codec_dai->codec;
-	int adc_reg, dac_reg;
+	int adc_reg1, adc_reg2, dac_reg;
 
-	adc_reg = snd_soc_read(codec, AD193X_ADC_CTRL2);
+	adc_reg1 = snd_soc_read(codec, AD193X_ADC_CTRL1);
+	adc_reg2 = snd_soc_read(codec, AD193X_ADC_CTRL2);
 	dac_reg = snd_soc_read(codec, AD193X_DAC_CTRL1);
 
 	/* At present, the driver only support AUX ADC mode(SND_SOC_DAIFMT_I2S
@@ -173,12 +174,12 @@ static int ad193x_set_dai_fmt(struct snd_soc_dai *codec_dai,
 	 */
 	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
 	case SND_SOC_DAIFMT_I2S:
-		adc_reg &= ~AD193X_ADC_SERFMT_MASK;
-		adc_reg |= AD193X_ADC_SERFMT_TDM;
+		adc_reg1 &= ~AD193X_ADC_SERFMT_MASK;
+		adc_reg1 |= AD193X_ADC_SERFMT_TDM;
 		break;
 	case SND_SOC_DAIFMT_DSP_A:
-		adc_reg &= ~AD193X_ADC_SERFMT_MASK;
-		adc_reg |= AD193X_ADC_SERFMT_AUX;
+		adc_reg1 &= ~AD193X_ADC_SERFMT_MASK;
+		adc_reg1 |= AD193X_ADC_SERFMT_AUX;
 		break;
 	default:
 		return -EINVAL;
@@ -186,27 +187,27 @@ static int ad193x_set_dai_fmt(struct snd_soc_dai *codec_dai,
 
 	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
 	case SND_SOC_DAIFMT_NB_NF: /* normal bit clock + frame */
-		adc_reg &= ~AD193X_ADC_LEFT_HIGH;
-		adc_reg &= ~AD193X_ADC_BCLK_INV;
+		adc_reg2 &= ~AD193X_ADC_LEFT_HIGH;
+		adc_reg2 &= ~AD193X_ADC_BCLK_INV;
 		dac_reg &= ~AD193X_DAC_LEFT_HIGH;
 		dac_reg &= ~AD193X_DAC_BCLK_INV;
 		break;
 	case SND_SOC_DAIFMT_NB_IF: /* normal bclk + invert frm */
-		adc_reg |= AD193X_ADC_LEFT_HIGH;
-		adc_reg &= ~AD193X_ADC_BCLK_INV;
+		adc_reg2 |= AD193X_ADC_LEFT_HIGH;
+		adc_reg2 &= ~AD193X_ADC_BCLK_INV;
 		dac_reg |= AD193X_DAC_LEFT_HIGH;
 		dac_reg &= ~AD193X_DAC_BCLK_INV;
 		break;
 	case SND_SOC_DAIFMT_IB_NF: /* invert bclk + normal frm */
-		adc_reg &= ~AD193X_ADC_LEFT_HIGH;
-		adc_reg |= AD193X_ADC_BCLK_INV;
+		adc_reg2 &= ~AD193X_ADC_LEFT_HIGH;
+		adc_reg2 |= AD193X_ADC_BCLK_INV;
 		dac_reg &= ~AD193X_DAC_LEFT_HIGH;
 		dac_reg |= AD193X_DAC_BCLK_INV;
 		break;
 
 	case SND_SOC_DAIFMT_IB_IF: /* invert bclk + frm */
-		adc_reg |= AD193X_ADC_LEFT_HIGH;
-		adc_reg |= AD193X_ADC_BCLK_INV;
+		adc_reg2 |= AD193X_ADC_LEFT_HIGH;
+		adc_reg2 |= AD193X_ADC_BCLK_INV;
 		dac_reg |= AD193X_DAC_LEFT_HIGH;
 		dac_reg |= AD193X_DAC_BCLK_INV;
 		break;
@@ -216,26 +217,26 @@ static int ad193x_set_dai_fmt(struct snd_soc_dai *codec_dai,
 
 	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
 	case SND_SOC_DAIFMT_CBM_CFM: /* codec clk & frm master */
-		adc_reg |= AD193X_ADC_LCR_MASTER;
-		adc_reg |= AD193X_ADC_BCLK_MASTER;
+		adc_reg2 |= AD193X_ADC_LCR_MASTER;
+		adc_reg2 |= AD193X_ADC_BCLK_MASTER;
 		dac_reg |= AD193X_DAC_LCR_MASTER;
 		dac_reg |= AD193X_DAC_BCLK_MASTER;
 		break;
 	case SND_SOC_DAIFMT_CBS_CFM: /* codec clk slave & frm master */
-		adc_reg |= AD193X_ADC_LCR_MASTER;
-		adc_reg &= ~AD193X_ADC_BCLK_MASTER;
+		adc_reg2 |= AD193X_ADC_LCR_MASTER;
+		adc_reg2 &= ~AD193X_ADC_BCLK_MASTER;
 		dac_reg |= AD193X_DAC_LCR_MASTER;
 		dac_reg &= ~AD193X_DAC_BCLK_MASTER;
 		break;
 	case SND_SOC_DAIFMT_CBM_CFS: /* codec clk master & frame slave */
-		adc_reg &= ~AD193X_ADC_LCR_MASTER;
-		adc_reg |= AD193X_ADC_BCLK_MASTER;
+		adc_reg2 &= ~AD193X_ADC_LCR_MASTER;
+		adc_reg2 |= AD193X_ADC_BCLK_MASTER;
 		dac_reg &= ~AD193X_DAC_LCR_MASTER;
 		dac_reg |= AD193X_DAC_BCLK_MASTER;
 		break;
 	case SND_SOC_DAIFMT_CBS_CFS: /* codec clk & frm slave */
-		adc_reg &= ~AD193X_ADC_LCR_MASTER;
-		adc_reg &= ~AD193X_ADC_BCLK_MASTER;
+		adc_reg2 &= ~AD193X_ADC_LCR_MASTER;
+		adc_reg2 &= ~AD193X_ADC_BCLK_MASTER;
 		dac_reg &= ~AD193X_DAC_LCR_MASTER;
 		dac_reg &= ~AD193X_DAC_BCLK_MASTER;
 		break;
@@ -243,7 +244,8 @@ static int ad193x_set_dai_fmt(struct snd_soc_dai *codec_dai,
 		return -EINVAL;
 	}
 
-	snd_soc_write(codec, AD193X_ADC_CTRL2, adc_reg);
+	snd_soc_write(codec, AD193X_ADC_CTRL1, adc_reg1);
+	snd_soc_write(codec, AD193X_ADC_CTRL2, adc_reg2);
 	snd_soc_write(codec, AD193X_DAC_CTRL1, dac_reg);
 
 	return 0;
-- 
1.5.6.3
