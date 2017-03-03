From: Ryan Lee <ryans.lee@maximintegrated.com>
Subject: [PATCH 07/10] Modified initialization code of VI
	sensing
Date: Fri, 3 Mar 2017 23:52:45 +0900
Message-ID: <1488552768-14901-8-git-send-email-ryans.lee@maximintegrated.com>
References: <1488552768-14901-1-git-send-email-ryans.lee@maximintegrated.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from NAM01-BY2-obe.outbound.protection.outlook.com
 (mail-by2nam01on0130.outbound.protection.outlook.com [104.47.34.130])
 by alsa0.perex.cz (Postfix) with ESMTP id 96D9C266B57
 for <alsa-devel@alsa-project.org>; Fri,  3 Mar 2017 15:54:26 +0100 (CET)
In-Reply-To: <1488552768-14901-1-git-send-email-ryans.lee@maximintegrated.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, perex@perex.cz, tiwai@suse.com, arnd@arndb.de, michael@amarulasolutions.com, oder_chiou@realtek.com, yesanishhere@gmail.com, jacob@teenage.engineering, Damien.Horsley@imgtec.com, bardliao@realtek.com, kuninori.morimoto.gx@renesas.com, petr@barix.com, lars@metafoo.de, nh6z@nh6z.net, ryans.lee@maximintegrated.com, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Ryan Lee <ryans.lee@maximintegrated.com>
---
Initialization code of TX(VI sensing) had a problem for interleave mode configuration.
Additional configuration for volume, DC blocker, Voltage/Current limit and ADC have been added.

 sound/soc/codecs/max98927.c | 195 +++++++++++++++++++++++++++++++++-----------
 1 file changed, 146 insertions(+), 49 deletions(-)

diff --git a/sound/soc/codecs/max98927.c b/sound/soc/codecs/max98927.c
index 9e70883..df2f4ff 100755
--- a/sound/soc/codecs/max98927.c
+++ b/sound/soc/codecs/max98927.c
@@ -1,7 +1,7 @@
 /*
  * max98927.c  --  MAX98927 ALSA Soc Audio driver
  *
- * Copyright 2013-15 Maxim Integrated Products
+ * Copyright (C) 2016 Maxim Integrated Products
  * Author: Ryan Lee <ryans.lee@maximintegrated.com>
  *
  *  This program is free software; you can redistribute  it and/or modify it
@@ -230,18 +230,12 @@ static int max98927_dai_set_fmt(struct snd_soc_dai *codec_dai, unsigned int fmt)
 		max98927->iface, max98927->iface);
 
 	/* pcm channel configuration */
-	if (max98927->iface & (SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_LEFT_J)) {
+	if (max98927->iface & (SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_LEFT_J))
 		regmap_write(max98927->regmap,
 			MAX98927_R0018_PCM_RX_EN_A,
 			MAX98927_PCM_RX_CH0_EN|
 			MAX98927_PCM_RX_CH1_EN);
-		regmap_write(max98927->regmap,
-			MAX98927_R0021_PCM_MASTER_MODE,
-			MAX98927_PCM_TX_CH0_EN|
-			MAX98927_PCM_TX_CH1_EN);
-	}
-	regmap_update_bits(max98927->regmap, MAX98927_R0020_PCM_MODE_CFG,
-		MAX98927_PCM_MODE_CFG_PCM_BCLKEDGE, invert);
+
 	return 0;
 }
 
@@ -367,12 +361,27 @@ static int max98927_dai_hw_params(struct snd_pcm_substream *substream,
 		goto err;
 	}
 	/* set DAI_SR to correct LRCLK frequency */
-	regmap_update_bits(max98927->regmap, MAX98927_R0023_PCM_SR_SETUP1,
-		MAX98927_PCM_SR_SET1_SR_MASK, sampling_rate);
-	regmap_update_bits(max98927->regmap, MAX98927_R0024_PCM_SR_SETUP2,
-		MAX98927_PCM_SR_SET2_SR_MASK, sampling_rate<<4);
-	regmap_update_bits(max98927->regmap, MAX98927_R0024_PCM_SR_SETUP2,
-		MAX98927_PCM_SR_SET2_IVADC_SR_MASK, sampling_rate);
+	regmap_update_bits(max98927->regmap,
+		MAX98927_R0023_PCM_SR_SETUP1,
+		MAX98927_PCM_SR_SET1_SR_MASK,
+		sampling_rate);
+	regmap_update_bits(max98927->regmap,
+		MAX98927_R0024_PCM_SR_SETUP2,
+		MAX98927_PCM_SR_SET2_SR_MASK,
+		sampling_rate << MAX98927_PCM_SR_SET2_SR_SHIFT);
+
+	/* set sampling rate of IV */
+	if (max98927->interleave_mode &&
+		sampling_rate > MAX98927_PCM_SR_SET1_SR_16000)
+		regmap_update_bits(max98927->regmap,
+			MAX98927_R0024_PCM_SR_SETUP2,
+			MAX98927_PCM_SR_SET2_IVADC_SR_MASK,
+			sampling_rate - 3);
+	else
+		regmap_update_bits(max98927->regmap,
+			MAX98927_R0024_PCM_SR_SETUP2,
+			MAX98927_PCM_SR_SET2_IVADC_SR_MASK,
+			sampling_rate);
 	return max98927_set_clock(max98927, params);
 err:
 	return -EINVAL;
@@ -408,33 +417,28 @@ static int max98927_dac_event(struct snd_soc_dapm_widget *w,
 	switch (event) {
 	case SND_SOC_DAPM_POST_PMU:
 		regmap_update_bits(max98927->regmap,
-			MAX98927_R003A_AMP_EN, 1, 1);
-		/* enable the v and i for vi feedback */
-		regmap_update_bits(max98927->regmap,
-			MAX98927_R003E_MEAS_EN,
-			MAX98927_MEAS_V_EN,
-			MAX98927_MEAS_V_EN);
+			MAX98927_R003A_AMP_EN,
+			MAX98927_AMP_EN_MASK, 1);
+		/* enable VMON and IMON */
 		regmap_update_bits(max98927->regmap,
 			MAX98927_R003E_MEAS_EN,
-			MAX98927_MEAS_I_EN,
-			MAX98927_MEAS_I_EN);
+			MAX98927_MEAS_V_EN | MAX98927_MEAS_I_EN,
+			MAX98927_MEAS_V_EN | MAX98927_MEAS_I_EN);
 		regmap_update_bits(max98927->regmap,
-			MAX98927_GLOBAL_EN_MASK, 1, 1);
+			MAX98927_R00FF_GLOBAL_SHDN,
+			MAX98927_GLOBAL_EN_MASK, 1);
 		break;
 	case SND_SOC_DAPM_POST_PMD:
 		regmap_update_bits(max98927->regmap,
-			MAX98927_R00FF_GLOBAL_SHDN, 1, 0);
+			MAX98927_R00FF_GLOBAL_SHDN,
+			MAX98927_GLOBAL_EN_MASK, 0);
 		regmap_update_bits(max98927->regmap,
-			MAX98927_R003A_AMP_EN, 1, 0);
-		/* disable the v and i for vi feedback */
+			MAX98927_R003A_AMP_EN,
+			MAX98927_AMP_EN_MASK, 0);
+		/* disable VMON and IMON */
 		regmap_update_bits(max98927->regmap,
 			MAX98927_R003E_MEAS_EN,
-			MAX98927_MEAS_V_EN,
-			0);
-		regmap_update_bits(max98927->regmap,
-			MAX98927_R003E_MEAS_EN,
-			MAX98927_MEAS_I_EN,
-			0);
+			MAX98927_MEAS_V_EN | MAX98927_MEAS_I_EN, 0);
 		break;
 	default:
 		return 0;
@@ -754,13 +758,107 @@ static int max98927_probe(struct snd_soc_codec *codec)
 		dev_info(codec->dev,
 			"MAX98927 revisionID: 0x%02X\n", reg);
 
+	/* IV default slot configuration */
+	regmap_write(max98927->regmap,
+		MAX98927_R001C_PCM_TX_HIZ_CTRL_A,
+		0xFF);
+	regmap_write(max98927->regmap,
+		MAX98927_R001D_PCM_TX_HIZ_CTRL_B,
+		0xFF);
+	regmap_write(max98927->regmap,
+		MAX98927_R0025_PCM_TO_SPK_MONOMIX_A,
+		0x80);
+	regmap_write(max98927->regmap,
+		MAX98927_R0026_PCM_TO_SPK_MONOMIX_B,
+		0x1);
+	/* Set inital volume (+13dB) */
+	regmap_write(max98927->regmap,
+		MAX98927_R0036_AMP_VOL_CTRL,
+		0x38);
+	regmap_write(max98927->regmap,
+		MAX98927_R003C_SPK_GAIN,
+		0x05);
+	/* Enable DC blocker */
+	regmap_write(max98927->regmap,
+		MAX98927_R0037_AMP_DSP_CFG,
+		0x03);
+	/* Enable IMON VMON DC blocker */
+	regmap_write(max98927->regmap,
+		MAX98927_R003F_MEAS_DSP_CFG,
+		0xF7);
+	/* Boost Output Voltage & Current limit */
+	regmap_write(max98927->regmap,
+		MAX98927_R0040_BOOST_CTRL0,
+		0x1C);
+	regmap_write(max98927->regmap,
+		MAX98927_R0042_BOOST_CTRL1,
+		0x3E);
+	/* Measurement ADC config */
+	regmap_write(max98927->regmap,
+		MAX98927_R0043_MEAS_ADC_CFG,
+		0x04);
+	regmap_write(max98927->regmap,
+		MAX98927_R0044_MEAS_ADC_BASE_MSB,
+		0x00);
+	regmap_write(max98927->regmap,
+		MAX98927_R0045_MEAS_ADC_BASE_LSB,
+		0x24);
+	/* Brownout Level */
+	regmap_write(max98927->regmap,
+		MAX98927_R007F_BROWNOUT_LVL4_AMP1_CTRL1,
+		0x06);
+	/* Envelope Tracking configuration */
+	regmap_write(max98927->regmap,
+		MAX98927_R0082_ENV_TRACK_VOUT_HEADROOM,
+		0x08);
+	regmap_write(max98927->regmap,
+		MAX98927_R0086_ENV_TRACK_CTRL,
+		0x01);
+	regmap_write(max98927->regmap,
+		MAX98927_R0087_ENV_TRACK_BOOST_VOUT_READ,
+		0x10);
 
-	if (max98927->regmap)
-		regmap_write(max98927->regmap,
-			MAX98927_R001E_PCM_TX_CH_SRC_A,
-			((max98927->i_l_slot <<
-			MAX98927_PCM_TX_CH_SRC_A_I_SHIFT)
-			| max98927->v_l_slot) & 0xFF);
+	/* voltage, current slot configuration */
+	regmap_write(max98927->regmap,
+		MAX98927_R001E_PCM_TX_CH_SRC_A,
+		(max98927->i_l_slot<<MAX98927_PCM_TX_CH_SRC_A_I_SHIFT|
+		max98927->v_l_slot)&0xFF);
+
+	if (max98927->v_l_slot < 8) {
+		regmap_update_bits(max98927->regmap,
+			MAX98927_R001C_PCM_TX_HIZ_CTRL_A,
+			1 << max98927->v_l_slot, 0);
+		regmap_update_bits(max98927->regmap,
+			MAX98927_R001A_PCM_TX_EN_A,
+			1 << max98927->v_l_slot,
+			1 << max98927->v_l_slot);
+	} else {
+		regmap_update_bits(max98927->regmap,
+			MAX98927_R001D_PCM_TX_HIZ_CTRL_B,
+			1 << (max98927->v_l_slot - 8), 0);
+		regmap_update_bits(max98927->regmap,
+			MAX98927_R001B_PCM_TX_EN_B,
+			1 << (max98927->v_l_slot - 8),
+			1 << (max98927->v_l_slot - 8));
+	}
+
+	if (max98927->i_l_slot < 8) {
+		regmap_update_bits(max98927->regmap,
+			MAX98927_R001C_PCM_TX_HIZ_CTRL_A,
+			1 << max98927->i_l_slot, 0);
+		regmap_update_bits(max98927->regmap,
+			MAX98927_R001A_PCM_TX_EN_A,
+			1 << max98927->i_l_slot,
+			1 << max98927->i_l_slot);
+	} else {
+		regmap_update_bits(max98927->regmap,
+			MAX98927_R001D_PCM_TX_HIZ_CTRL_B,
+			1 << (max98927->i_l_slot - 8), 0);
+		regmap_update_bits(max98927->regmap,
+			MAX98927_R001B_PCM_TX_EN_B,
+			1 << (max98927->i_l_slot - 8),
+			1 << (max98927->i_l_slot - 8));
+	}
 
 	/* Set interleave mode */
 	if (max98927->interleave_mode)
@@ -793,9 +891,10 @@ static const struct regmap_config max98927_regmap = {
 	.cache_type       = REGCACHE_RBTREE,
 };
 
-int probe_common(struct i2c_client *i2c, struct max98927_priv *max98927)
+static void max98927_slot_config(struct i2c_client *i2c,
+	struct max98927_priv *max98927)
 {
-	int ret = 0, value;
+	int value;
 
 	if (!of_property_read_u32(i2c->dev.of_node, "vmon-l-slot", &value))
 		max98927->v_l_slot = value & 0xF;
@@ -805,13 +904,6 @@ int probe_common(struct i2c_client *i2c, struct max98927_priv *max98927)
 		max98927->i_l_slot = value & 0xF;
 	else
 		max98927->i_l_slot = 1;
-
-	ret = snd_soc_register_codec(&i2c->dev, &soc_codec_dev_max98927,
-		max98927_dai, ARRAY_SIZE(max98927_dai));
-	if (ret < 0)
-		dev_err(&i2c->dev,
-		    "Failed to register codec: %d\n", ret);
-	return ret;
 }
 
 static int max98927_i2c_probe(struct i2c_client *i2c,
@@ -850,9 +942,14 @@ static int max98927_i2c_probe(struct i2c_client *i2c,
 		goto err;
 	}
 
+	/* voltage/current slot configuration */
+	max98927_slot_config(i2c, max98927);
 
 	/* codec registeration */
-	ret = probe_common(i2c, max98927);
+	ret = snd_soc_register_codec(&i2c->dev, &soc_codec_dev_max98927,
+		max98927_dai, ARRAY_SIZE(max98927_dai));
+	if (ret < 0)
+		dev_err(&i2c->dev, "Failed to register codec: %d\n", ret);
 
 	return ret;
 
-- 
2.7.4
