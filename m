From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [PATCH 1/3] ASoC: tlv320aic3x: Use snd_soc_read and
	snd_soc_write
Date: Tue, 14 Sep 2010 14:54:47 +0300
Message-ID: <1284465289-4865-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51]) by alsa0.perex.cz (Postfix) with ESMTP id B14002446F
	for <alsa-devel@alsa-project.org>;
	Tue, 14 Sep 2010 13:55:05 +0200 (CEST)
Received: by ewy21 with SMTP id 21so3012819ewy.38
	for <alsa-devel@alsa-project.org>; Tue, 14 Sep 2010 04:55:03 -0700 (PDT)
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Start phasing out aic3x_read_reg_cache, aic3x_write_reg_cache, aic3x_read and
aic3x_write calls in order to switch to soc-cache helpers.

This patch replaces aic3x_read_reg_cache and aic3x_write with snd_soc_read
and snd_soc_write. This is basically null-op since .read and .write in
soc_codec_dev_aic3x points to aic3x_read_reg_cache and aic3x_write.

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
---
 sound/soc/codecs/tlv320aic3x.c |  194 ++++++++++++++++++++--------------------
 1 files changed, 98 insertions(+), 96 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index 94dc707..138165c 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -839,8 +839,7 @@ static int aic3x_hw_params(struct snd_pcm_substream *substream,
 	int clk;
 
 	/* select data word length */
-	data =
-	    aic3x_read_reg_cache(codec, AIC3X_ASD_INTF_CTRLB) & (~(0x3 << 4));
+	data = snd_soc_read(codec, AIC3X_ASD_INTF_CTRLB) & (~(0x3 << 4));
 	switch (params_format(params)) {
 	case SNDRV_PCM_FORMAT_S16_LE:
 		break;
@@ -854,7 +853,7 @@ static int aic3x_hw_params(struct snd_pcm_substream *substream,
 		data |= (0x03 << 4);
 		break;
 	}
-	aic3x_write(codec, AIC3X_ASD_INTF_CTRLB, data);
+	snd_soc_write(codec, AIC3X_ASD_INTF_CTRLB, data);
 
 	/* Fsref can be 44100 or 48000 */
 	fsref = (params_rate(params) % 11025 == 0) ? 44100 : 48000;
@@ -869,17 +868,17 @@ static int aic3x_hw_params(struct snd_pcm_substream *substream,
 
 	if (bypass_pll) {
 		pll_q &= 0xf;
-		aic3x_write(codec, AIC3X_PLL_PROGA_REG, pll_q << PLLQ_SHIFT);
-		aic3x_write(codec, AIC3X_GPIOB_REG, CODEC_CLKIN_CLKDIV);
+		snd_soc_write(codec, AIC3X_PLL_PROGA_REG, pll_q << PLLQ_SHIFT);
+		snd_soc_write(codec, AIC3X_GPIOB_REG, CODEC_CLKIN_CLKDIV);
 		/* disable PLL if it is bypassed */
-		reg = aic3x_read_reg_cache(codec, AIC3X_PLL_PROGA_REG);
-		aic3x_write(codec, AIC3X_PLL_PROGA_REG, reg & ~PLL_ENABLE);
+		reg = snd_soc_read(codec, AIC3X_PLL_PROGA_REG);
+		snd_soc_write(codec, AIC3X_PLL_PROGA_REG, reg & ~PLL_ENABLE);
 
 	} else {
-		aic3x_write(codec, AIC3X_GPIOB_REG, CODEC_CLKIN_PLLDIV);
+		snd_soc_write(codec, AIC3X_GPIOB_REG, CODEC_CLKIN_PLLDIV);
 		/* enable PLL when it is used */
-		reg = aic3x_read_reg_cache(codec, AIC3X_PLL_PROGA_REG);
-		aic3x_write(codec, AIC3X_PLL_PROGA_REG, reg | PLL_ENABLE);
+		reg = snd_soc_read(codec, AIC3X_PLL_PROGA_REG);
+		snd_soc_write(codec, AIC3X_PLL_PROGA_REG, reg | PLL_ENABLE);
 	}
 
 	/* Route Left DAC to left channel input and
@@ -888,7 +887,7 @@ static int aic3x_hw_params(struct snd_pcm_substream *substream,
 	data |= (fsref == 44100) ? FSREF_44100 : FSREF_48000;
 	if (params_rate(params) >= 64000)
 		data |= DUAL_RATE_MODE;
-	aic3x_write(codec, AIC3X_CODEC_DATAPATH_REG, data);
+	snd_soc_write(codec, AIC3X_CODEC_DATAPATH_REG, data);
 
 	/* codec sample rate select */
 	data = (fsref * 20) / params_rate(params);
@@ -897,7 +896,7 @@ static int aic3x_hw_params(struct snd_pcm_substream *substream,
 	data /= 5;
 	data -= 2;
 	data |= (data << 4);
-	aic3x_write(codec, AIC3X_SAMPLE_RATE_SEL_REG, data);
+	snd_soc_write(codec, AIC3X_SAMPLE_RATE_SEL_REG, data);
 
 	if (bypass_pll)
 		return 0;
@@ -966,13 +965,16 @@ static int aic3x_hw_params(struct snd_pcm_substream *substream,
 	}
 
 found:
-	data = aic3x_read_reg_cache(codec, AIC3X_PLL_PROGA_REG);
-	aic3x_write(codec, AIC3X_PLL_PROGA_REG, data | (pll_p << PLLP_SHIFT));
-	aic3x_write(codec, AIC3X_OVRF_STATUS_AND_PLLR_REG, pll_r << PLLR_SHIFT);
-	aic3x_write(codec, AIC3X_PLL_PROGB_REG, pll_j << PLLJ_SHIFT);
-	aic3x_write(codec, AIC3X_PLL_PROGC_REG, (pll_d >> 6) << PLLD_MSB_SHIFT);
-	aic3x_write(codec, AIC3X_PLL_PROGD_REG,
-		    (pll_d & 0x3F) << PLLD_LSB_SHIFT);
+	data = snd_soc_read(codec, AIC3X_PLL_PROGA_REG);
+	snd_soc_write(codec, AIC3X_PLL_PROGA_REG,
+		      data | (pll_p << PLLP_SHIFT));
+	snd_soc_write(codec, AIC3X_OVRF_STATUS_AND_PLLR_REG,
+		      pll_r << PLLR_SHIFT);
+	snd_soc_write(codec, AIC3X_PLL_PROGB_REG, pll_j << PLLJ_SHIFT);
+	snd_soc_write(codec, AIC3X_PLL_PROGC_REG,
+		      (pll_d >> 6) << PLLD_MSB_SHIFT);
+	snd_soc_write(codec, AIC3X_PLL_PROGD_REG,
+		      (pll_d & 0x3F) << PLLD_LSB_SHIFT);
 
 	return 0;
 }
@@ -980,15 +982,15 @@ found:
 static int aic3x_mute(struct snd_soc_dai *dai, int mute)
 {
 	struct snd_soc_codec *codec = dai->codec;
-	u8 ldac_reg = aic3x_read_reg_cache(codec, LDAC_VOL) & ~MUTE_ON;
-	u8 rdac_reg = aic3x_read_reg_cache(codec, RDAC_VOL) & ~MUTE_ON;
+	u8 ldac_reg = snd_soc_read(codec, LDAC_VOL) & ~MUTE_ON;
+	u8 rdac_reg = snd_soc_read(codec, RDAC_VOL) & ~MUTE_ON;
 
 	if (mute) {
-		aic3x_write(codec, LDAC_VOL, ldac_reg | MUTE_ON);
-		aic3x_write(codec, RDAC_VOL, rdac_reg | MUTE_ON);
+		snd_soc_write(codec, LDAC_VOL, ldac_reg | MUTE_ON);
+		snd_soc_write(codec, RDAC_VOL, rdac_reg | MUTE_ON);
 	} else {
-		aic3x_write(codec, LDAC_VOL, ldac_reg);
-		aic3x_write(codec, RDAC_VOL, rdac_reg);
+		snd_soc_write(codec, LDAC_VOL, ldac_reg);
+		snd_soc_write(codec, RDAC_VOL, rdac_reg);
 	}
 
 	return 0;
@@ -1012,8 +1014,8 @@ static int aic3x_set_dai_fmt(struct snd_soc_dai *codec_dai,
 	u8 iface_areg, iface_breg;
 	int delay = 0;
 
-	iface_areg = aic3x_read_reg_cache(codec, AIC3X_ASD_INTF_CTRLA) & 0x3f;
-	iface_breg = aic3x_read_reg_cache(codec, AIC3X_ASD_INTF_CTRLB) & 0x3f;
+	iface_areg = snd_soc_read(codec, AIC3X_ASD_INTF_CTRLA) & 0x3f;
+	iface_breg = snd_soc_read(codec, AIC3X_ASD_INTF_CTRLB) & 0x3f;
 
 	/* set master/slave audio interface */
 	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
@@ -1052,9 +1054,9 @@ static int aic3x_set_dai_fmt(struct snd_soc_dai *codec_dai,
 	}
 
 	/* set iface */
-	aic3x_write(codec, AIC3X_ASD_INTF_CTRLA, iface_areg);
-	aic3x_write(codec, AIC3X_ASD_INTF_CTRLB, iface_breg);
-	aic3x_write(codec, AIC3X_ASD_INTF_CTRLC, delay);
+	snd_soc_write(codec, AIC3X_ASD_INTF_CTRLA, iface_areg);
+	snd_soc_write(codec, AIC3X_ASD_INTF_CTRLB, iface_breg);
+	snd_soc_write(codec, AIC3X_ASD_INTF_CTRLC, delay);
 
 	return 0;
 }
@@ -1072,18 +1074,18 @@ static int aic3x_set_bias_level(struct snd_soc_codec *codec,
 		if (codec->bias_level == SND_SOC_BIAS_STANDBY &&
 		    aic3x->master) {
 			/* enable pll */
-			reg = aic3x_read_reg_cache(codec, AIC3X_PLL_PROGA_REG);
-			aic3x_write(codec, AIC3X_PLL_PROGA_REG,
-				    reg | PLL_ENABLE);
+			reg = snd_soc_read(codec, AIC3X_PLL_PROGA_REG);
+			snd_soc_write(codec, AIC3X_PLL_PROGA_REG,
+				      reg | PLL_ENABLE);
 		}
 		break;
 	case SND_SOC_BIAS_STANDBY:
 		if (codec->bias_level == SND_SOC_BIAS_PREPARE &&
 		    aic3x->master) {
 			/* disable pll */
-			reg = aic3x_read_reg_cache(codec, AIC3X_PLL_PROGA_REG);
-			aic3x_write(codec, AIC3X_PLL_PROGA_REG,
-				    reg & ~PLL_ENABLE);
+			reg = snd_soc_read(codec, AIC3X_PLL_PROGA_REG);
+			snd_soc_write(codec, AIC3X_PLL_PROGA_REG,
+				      reg & ~PLL_ENABLE);
 		}
 		break;
 	case SND_SOC_BIAS_OFF:
@@ -1098,8 +1100,8 @@ void aic3x_set_gpio(struct snd_soc_codec *codec, int gpio, int state)
 {
 	u8 reg = gpio ? AIC3X_GPIO2_REG : AIC3X_GPIO1_REG;
 	u8 bit = gpio ? 3: 0;
-	u8 val = aic3x_read_reg_cache(codec, reg) & ~(1 << bit);
-	aic3x_write(codec, reg, val | (!!state << bit));
+	u8 val = snd_soc_read(codec, reg) & ~(1 << bit);
+	snd_soc_write(codec, reg, val | (!!state << bit));
 }
 EXPORT_SYMBOL_GPL(aic3x_set_gpio);
 
@@ -1128,7 +1130,7 @@ void aic3x_set_headset_detection(struct snd_soc_codec *codec, int detect,
 	if (detect & AIC3X_HEADSET_DETECT_MASK)
 		val |= AIC3X_HEADSET_DETECT_ENABLED;
 
-	aic3x_write(codec, AIC3X_HEADSET_DETECT_CTRL_A, val);
+	snd_soc_write(codec, AIC3X_HEADSET_DETECT_CTRL_A, val);
 }
 EXPORT_SYMBOL_GPL(aic3x_set_headset_detection);
 
@@ -1211,81 +1213,81 @@ static int aic3x_init(struct snd_soc_codec *codec)
 	struct aic3x_priv *aic3x = snd_soc_codec_get_drvdata(codec);
 	int reg;
 
-	aic3x_write(codec, AIC3X_PAGE_SELECT, PAGE0_SELECT);
-	aic3x_write(codec, AIC3X_RESET, SOFT_RESET);
+	snd_soc_write(codec, AIC3X_PAGE_SELECT, PAGE0_SELECT);
+	snd_soc_write(codec, AIC3X_RESET, SOFT_RESET);
 
 	/* DAC default volume and mute */
-	aic3x_write(codec, LDAC_VOL, DEFAULT_VOL | MUTE_ON);
-	aic3x_write(codec, RDAC_VOL, DEFAULT_VOL | MUTE_ON);
+	snd_soc_write(codec, LDAC_VOL, DEFAULT_VOL | MUTE_ON);
+	snd_soc_write(codec, RDAC_VOL, DEFAULT_VOL | MUTE_ON);
 
 	/* DAC to HP default volume and route to Output mixer */
-	aic3x_write(codec, DACL1_2_HPLOUT_VOL, DEFAULT_VOL | ROUTE_ON);
-	aic3x_write(codec, DACR1_2_HPROUT_VOL, DEFAULT_VOL | ROUTE_ON);
-	aic3x_write(codec, DACL1_2_HPLCOM_VOL, DEFAULT_VOL | ROUTE_ON);
-	aic3x_write(codec, DACR1_2_HPRCOM_VOL, DEFAULT_VOL | ROUTE_ON);
+	snd_soc_write(codec, DACL1_2_HPLOUT_VOL, DEFAULT_VOL | ROUTE_ON);
+	snd_soc_write(codec, DACR1_2_HPROUT_VOL, DEFAULT_VOL | ROUTE_ON);
+	snd_soc_write(codec, DACL1_2_HPLCOM_VOL, DEFAULT_VOL | ROUTE_ON);
+	snd_soc_write(codec, DACR1_2_HPRCOM_VOL, DEFAULT_VOL | ROUTE_ON);
 	/* DAC to Line Out default volume and route to Output mixer */
-	aic3x_write(codec, DACL1_2_LLOPM_VOL, DEFAULT_VOL | ROUTE_ON);
-	aic3x_write(codec, DACR1_2_RLOPM_VOL, DEFAULT_VOL | ROUTE_ON);
+	snd_soc_write(codec, DACL1_2_LLOPM_VOL, DEFAULT_VOL | ROUTE_ON);
+	snd_soc_write(codec, DACR1_2_RLOPM_VOL, DEFAULT_VOL | ROUTE_ON);
 	/* DAC to Mono Line Out default volume and route to Output mixer */
-	aic3x_write(codec, DACL1_2_MONOLOPM_VOL, DEFAULT_VOL | ROUTE_ON);
-	aic3x_write(codec, DACR1_2_MONOLOPM_VOL, DEFAULT_VOL | ROUTE_ON);
+	snd_soc_write(codec, DACL1_2_MONOLOPM_VOL, DEFAULT_VOL | ROUTE_ON);
+	snd_soc_write(codec, DACR1_2_MONOLOPM_VOL, DEFAULT_VOL | ROUTE_ON);
 
 	/* unmute all outputs */
-	reg = aic3x_read_reg_cache(codec, LLOPM_CTRL);
-	aic3x_write(codec, LLOPM_CTRL, reg | UNMUTE);
-	reg = aic3x_read_reg_cache(codec, RLOPM_CTRL);
-	aic3x_write(codec, RLOPM_CTRL, reg | UNMUTE);
-	reg = aic3x_read_reg_cache(codec, MONOLOPM_CTRL);
-	aic3x_write(codec, MONOLOPM_CTRL, reg | UNMUTE);
-	reg = aic3x_read_reg_cache(codec, HPLOUT_CTRL);
-	aic3x_write(codec, HPLOUT_CTRL, reg | UNMUTE);
-	reg = aic3x_read_reg_cache(codec, HPROUT_CTRL);
-	aic3x_write(codec, HPROUT_CTRL, reg | UNMUTE);
-	reg = aic3x_read_reg_cache(codec, HPLCOM_CTRL);
-	aic3x_write(codec, HPLCOM_CTRL, reg | UNMUTE);
-	reg = aic3x_read_reg_cache(codec, HPRCOM_CTRL);
-	aic3x_write(codec, HPRCOM_CTRL, reg | UNMUTE);
+	reg = snd_soc_read(codec, LLOPM_CTRL);
+	snd_soc_write(codec, LLOPM_CTRL, reg | UNMUTE);
+	reg = snd_soc_read(codec, RLOPM_CTRL);
+	snd_soc_write(codec, RLOPM_CTRL, reg | UNMUTE);
+	reg = snd_soc_read(codec, MONOLOPM_CTRL);
+	snd_soc_write(codec, MONOLOPM_CTRL, reg | UNMUTE);
+	reg = snd_soc_read(codec, HPLOUT_CTRL);
+	snd_soc_write(codec, HPLOUT_CTRL, reg | UNMUTE);
+	reg = snd_soc_read(codec, HPROUT_CTRL);
+	snd_soc_write(codec, HPROUT_CTRL, reg | UNMUTE);
+	reg = snd_soc_read(codec, HPLCOM_CTRL);
+	snd_soc_write(codec, HPLCOM_CTRL, reg | UNMUTE);
+	reg = snd_soc_read(codec, HPRCOM_CTRL);
+	snd_soc_write(codec, HPRCOM_CTRL, reg | UNMUTE);
 
 	/* ADC default volume and unmute */
-	aic3x_write(codec, LADC_VOL, DEFAULT_GAIN);
-	aic3x_write(codec, RADC_VOL, DEFAULT_GAIN);
+	snd_soc_write(codec, LADC_VOL, DEFAULT_GAIN);
+	snd_soc_write(codec, RADC_VOL, DEFAULT_GAIN);
 	/* By default route Line1 to ADC PGA mixer */
-	aic3x_write(codec, LINE1L_2_LADC_CTRL, 0x0);
-	aic3x_write(codec, LINE1R_2_RADC_CTRL, 0x0);
+	snd_soc_write(codec, LINE1L_2_LADC_CTRL, 0x0);
+	snd_soc_write(codec, LINE1R_2_RADC_CTRL, 0x0);
 
 	/* PGA to HP Bypass default volume, disconnect from Output Mixer */
-	aic3x_write(codec, PGAL_2_HPLOUT_VOL, DEFAULT_VOL);
-	aic3x_write(codec, PGAR_2_HPROUT_VOL, DEFAULT_VOL);
-	aic3x_write(codec, PGAL_2_HPLCOM_VOL, DEFAULT_VOL);
-	aic3x_write(codec, PGAR_2_HPRCOM_VOL, DEFAULT_VOL);
+	snd_soc_write(codec, PGAL_2_HPLOUT_VOL, DEFAULT_VOL);
+	snd_soc_write(codec, PGAR_2_HPROUT_VOL, DEFAULT_VOL);
+	snd_soc_write(codec, PGAL_2_HPLCOM_VOL, DEFAULT_VOL);
+	snd_soc_write(codec, PGAR_2_HPRCOM_VOL, DEFAULT_VOL);
 	/* PGA to Line Out default volume, disconnect from Output Mixer */
-	aic3x_write(codec, PGAL_2_LLOPM_VOL, DEFAULT_VOL);
-	aic3x_write(codec, PGAR_2_RLOPM_VOL, DEFAULT_VOL);
+	snd_soc_write(codec, PGAL_2_LLOPM_VOL, DEFAULT_VOL);
+	snd_soc_write(codec, PGAR_2_RLOPM_VOL, DEFAULT_VOL);
 	/* PGA to Mono Line Out default volume, disconnect from Output Mixer */
-	aic3x_write(codec, PGAL_2_MONOLOPM_VOL, DEFAULT_VOL);
-	aic3x_write(codec, PGAR_2_MONOLOPM_VOL, DEFAULT_VOL);
+	snd_soc_write(codec, PGAL_2_MONOLOPM_VOL, DEFAULT_VOL);
+	snd_soc_write(codec, PGAR_2_MONOLOPM_VOL, DEFAULT_VOL);
 
 	/* Line2 to HP Bypass default volume, disconnect from Output Mixer */
-	aic3x_write(codec, LINE2L_2_HPLOUT_VOL, DEFAULT_VOL);
-	aic3x_write(codec, LINE2R_2_HPROUT_VOL, DEFAULT_VOL);
-	aic3x_write(codec, LINE2L_2_HPLCOM_VOL, DEFAULT_VOL);
-	aic3x_write(codec, LINE2R_2_HPRCOM_VOL, DEFAULT_VOL);
+	snd_soc_write(codec, LINE2L_2_HPLOUT_VOL, DEFAULT_VOL);
+	snd_soc_write(codec, LINE2R_2_HPROUT_VOL, DEFAULT_VOL);
+	snd_soc_write(codec, LINE2L_2_HPLCOM_VOL, DEFAULT_VOL);
+	snd_soc_write(codec, LINE2R_2_HPRCOM_VOL, DEFAULT_VOL);
 	/* Line2 Line Out default volume, disconnect from Output Mixer */
-	aic3x_write(codec, LINE2L_2_LLOPM_VOL, DEFAULT_VOL);
-	aic3x_write(codec, LINE2R_2_RLOPM_VOL, DEFAULT_VOL);
+	snd_soc_write(codec, LINE2L_2_LLOPM_VOL, DEFAULT_VOL);
+	snd_soc_write(codec, LINE2R_2_RLOPM_VOL, DEFAULT_VOL);
 	/* Line2 to Mono Out default volume, disconnect from Output Mixer */
-	aic3x_write(codec, LINE2L_2_MONOLOPM_VOL, DEFAULT_VOL);
-	aic3x_write(codec, LINE2R_2_MONOLOPM_VOL, DEFAULT_VOL);
+	snd_soc_write(codec, LINE2L_2_MONOLOPM_VOL, DEFAULT_VOL);
+	snd_soc_write(codec, LINE2R_2_MONOLOPM_VOL, DEFAULT_VOL);
 
 	if (aic3x->model == AIC3X_MODEL_3007) {
 		/* Class-D speaker driver init; datasheet p. 46 */
-		aic3x_write(codec, AIC3X_PAGE_SELECT, 0x0D);
-		aic3x_write(codec, 0xD, 0x0D);
-		aic3x_write(codec, 0x8, 0x5C);
-		aic3x_write(codec, 0x8, 0x5D);
-		aic3x_write(codec, 0x8, 0x5C);
-		aic3x_write(codec, AIC3X_PAGE_SELECT, 0x00);
-		aic3x_write(codec, CLASSD_CTRL, 0);
+		snd_soc_write(codec, AIC3X_PAGE_SELECT, 0x0D);
+		snd_soc_write(codec, 0xD, 0x0D);
+		snd_soc_write(codec, 0x8, 0x5C);
+		snd_soc_write(codec, 0x8, 0x5D);
+		snd_soc_write(codec, 0x8, 0x5C);
+		snd_soc_write(codec, AIC3X_PAGE_SELECT, 0x00);
+		snd_soc_write(codec, CLASSD_CTRL, 0);
 	}
 
 	/* off, with power on */
@@ -1305,10 +1307,10 @@ static int aic3x_probe(struct snd_soc_codec *codec)
 
 	if (aic3x->setup) {
 		/* setup GPIO functions */
-		aic3x_write(codec, AIC3X_GPIO1_REG,
-			    (aic3x->setup->gpio_func[0] & 0xf) << 4);
-		aic3x_write(codec, AIC3X_GPIO2_REG,
-			    (aic3x->setup->gpio_func[1] & 0xf) << 4);
+		snd_soc_write(codec, AIC3X_GPIO1_REG,
+			      (aic3x->setup->gpio_func[0] & 0xf) << 4);
+		snd_soc_write(codec, AIC3X_GPIO2_REG,
+			      (aic3x->setup->gpio_func[1] & 0xf) << 4);
 	}
 
 	snd_soc_add_controls(codec, aic3x_snd_controls,
-- 
1.7.1
