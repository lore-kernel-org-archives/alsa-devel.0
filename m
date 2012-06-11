From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 8/8] ASoC: wm8996: Move register default
	configuration to I2C probe
Date: Mon, 11 Jun 2012 19:55:40 +0800
Message-ID: <1339415740-2376-8-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1339415740-2376-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id B9DE124363
	for <alsa-devel@alsa-project.org>;
	Mon, 11 Jun 2012 13:56:23 +0200 (CEST)
In-Reply-To: <1339415740-2376-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

This gets the registers set up as early as possible, mainly useful for the
GPIOs to ensure that they're in the correct mode.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8996.c |  331 ++++++++++++++++++++++++---------------------
 1 file changed, 180 insertions(+), 151 deletions(-)

diff --git a/sound/soc/codecs/wm8996.c b/sound/soc/codecs/wm8996.c
index 1579880..00f183d 100644
--- a/sound/soc/codecs/wm8996.c
+++ b/sound/soc/codecs/wm8996.c
@@ -2619,7 +2619,7 @@ static int wm8996_probe(struct snd_soc_codec *codec)
 	int ret;
 	struct wm8996_priv *wm8996 = snd_soc_codec_get_drvdata(codec);
 	struct i2c_client *i2c = to_i2c_client(codec->dev);
-	int i, irq_flags;
+	int irq_flags;
 
 	wm8996->codec = codec;
 
@@ -2634,162 +2634,12 @@ static int wm8996_probe(struct snd_soc_codec *codec)
 		goto err;
 	}
 
-	/* Apply platform data settings */
-	snd_soc_update_bits(codec, WM8996_LINE_INPUT_CONTROL,
-			    WM8996_INL_MODE_MASK | WM8996_INR_MODE_MASK,
-			    wm8996->pdata.inl_mode << WM8996_INL_MODE_SHIFT |
-			    wm8996->pdata.inr_mode);
-
-	for (i = 0; i < ARRAY_SIZE(wm8996->pdata.gpio_default); i++) {
-		if (!wm8996->pdata.gpio_default[i])
-			continue;
-
-		snd_soc_write(codec, WM8996_GPIO_1 + i,
-			      wm8996->pdata.gpio_default[i] & 0xffff);
-	}
-
-	if (wm8996->pdata.spkmute_seq)
-		snd_soc_update_bits(codec, WM8996_PDM_SPEAKER_MUTE_SEQUENCE,
-				    WM8996_SPK_MUTE_ENDIAN |
-				    WM8996_SPK_MUTE_SEQ1_MASK,
-				    wm8996->pdata.spkmute_seq);
-
-	snd_soc_update_bits(codec, WM8996_ACCESSORY_DETECT_MODE_2,
-			    WM8996_MICD_BIAS_SRC | WM8996_HPOUT1FB_SRC |
-			    WM8996_MICD_SRC, wm8996->pdata.micdet_def);
-
-	/* Latch volume update bits */
-	snd_soc_update_bits(codec, WM8996_LEFT_LINE_INPUT_VOLUME,
-			    WM8996_IN1_VU, WM8996_IN1_VU);
-	snd_soc_update_bits(codec, WM8996_RIGHT_LINE_INPUT_VOLUME,
-			    WM8996_IN1_VU, WM8996_IN1_VU);
-
-	snd_soc_update_bits(codec, WM8996_DAC1_LEFT_VOLUME,
-			    WM8996_DAC1_VU, WM8996_DAC1_VU);
-	snd_soc_update_bits(codec, WM8996_DAC1_RIGHT_VOLUME,
-			    WM8996_DAC1_VU, WM8996_DAC1_VU);
-	snd_soc_update_bits(codec, WM8996_DAC2_LEFT_VOLUME,
-			    WM8996_DAC2_VU, WM8996_DAC2_VU);
-	snd_soc_update_bits(codec, WM8996_DAC2_RIGHT_VOLUME,
-			    WM8996_DAC2_VU, WM8996_DAC2_VU);
-
-	snd_soc_update_bits(codec, WM8996_OUTPUT1_LEFT_VOLUME,
-			    WM8996_DAC1_VU, WM8996_DAC1_VU);
-	snd_soc_update_bits(codec, WM8996_OUTPUT1_RIGHT_VOLUME,
-			    WM8996_DAC1_VU, WM8996_DAC1_VU);
-	snd_soc_update_bits(codec, WM8996_OUTPUT2_LEFT_VOLUME,
-			    WM8996_DAC2_VU, WM8996_DAC2_VU);
-	snd_soc_update_bits(codec, WM8996_OUTPUT2_RIGHT_VOLUME,
-			    WM8996_DAC2_VU, WM8996_DAC2_VU);
-
-	snd_soc_update_bits(codec, WM8996_DSP1_TX_LEFT_VOLUME,
-			    WM8996_DSP1TX_VU, WM8996_DSP1TX_VU);
-	snd_soc_update_bits(codec, WM8996_DSP1_TX_RIGHT_VOLUME,
-			    WM8996_DSP1TX_VU, WM8996_DSP1TX_VU);
-	snd_soc_update_bits(codec, WM8996_DSP2_TX_LEFT_VOLUME,
-			    WM8996_DSP2TX_VU, WM8996_DSP2TX_VU);
-	snd_soc_update_bits(codec, WM8996_DSP2_TX_RIGHT_VOLUME,
-			    WM8996_DSP2TX_VU, WM8996_DSP2TX_VU);
-
-	snd_soc_update_bits(codec, WM8996_DSP1_RX_LEFT_VOLUME,
-			    WM8996_DSP1RX_VU, WM8996_DSP1RX_VU);
-	snd_soc_update_bits(codec, WM8996_DSP1_RX_RIGHT_VOLUME,
-			    WM8996_DSP1RX_VU, WM8996_DSP1RX_VU);
-	snd_soc_update_bits(codec, WM8996_DSP2_RX_LEFT_VOLUME,
-			    WM8996_DSP2RX_VU, WM8996_DSP2RX_VU);
-	snd_soc_update_bits(codec, WM8996_DSP2_RX_RIGHT_VOLUME,
-			    WM8996_DSP2RX_VU, WM8996_DSP2RX_VU);
-
-	/* No support currently for the underclocked TDM modes and
-	 * pick a default TDM layout with each channel pair working with
-	 * slots 0 and 1. */
-	snd_soc_update_bits(codec, WM8996_AIF1RX_CHANNEL_0_CONFIGURATION,
-			    WM8996_AIF1RX_CHAN0_SLOTS_MASK |
-			    WM8996_AIF1RX_CHAN0_START_SLOT_MASK,
-			    1 << WM8996_AIF1RX_CHAN0_SLOTS_SHIFT | 0);
-	snd_soc_update_bits(codec, WM8996_AIF1RX_CHANNEL_1_CONFIGURATION,
-			    WM8996_AIF1RX_CHAN1_SLOTS_MASK |
-			    WM8996_AIF1RX_CHAN1_START_SLOT_MASK,
-			    1 << WM8996_AIF1RX_CHAN1_SLOTS_SHIFT | 1);
-	snd_soc_update_bits(codec, WM8996_AIF1RX_CHANNEL_2_CONFIGURATION,
-			    WM8996_AIF1RX_CHAN2_SLOTS_MASK |
-			    WM8996_AIF1RX_CHAN2_START_SLOT_MASK,
-			    1 << WM8996_AIF1RX_CHAN2_SLOTS_SHIFT | 0);
-	snd_soc_update_bits(codec, WM8996_AIF1RX_CHANNEL_3_CONFIGURATION,
-			    WM8996_AIF1RX_CHAN3_SLOTS_MASK |
-			    WM8996_AIF1RX_CHAN0_START_SLOT_MASK,
-			    1 << WM8996_AIF1RX_CHAN3_SLOTS_SHIFT | 1);
-	snd_soc_update_bits(codec, WM8996_AIF1RX_CHANNEL_4_CONFIGURATION,
-			    WM8996_AIF1RX_CHAN4_SLOTS_MASK |
-			    WM8996_AIF1RX_CHAN0_START_SLOT_MASK,
-			    1 << WM8996_AIF1RX_CHAN4_SLOTS_SHIFT | 0);
-	snd_soc_update_bits(codec, WM8996_AIF1RX_CHANNEL_5_CONFIGURATION,
-			    WM8996_AIF1RX_CHAN5_SLOTS_MASK |
-			    WM8996_AIF1RX_CHAN0_START_SLOT_MASK,
-			    1 << WM8996_AIF1RX_CHAN5_SLOTS_SHIFT | 1);
-
-	snd_soc_update_bits(codec, WM8996_AIF2RX_CHANNEL_0_CONFIGURATION,
-			    WM8996_AIF2RX_CHAN0_SLOTS_MASK |
-			    WM8996_AIF2RX_CHAN0_START_SLOT_MASK,
-			    1 << WM8996_AIF2RX_CHAN0_SLOTS_SHIFT | 0);
-	snd_soc_update_bits(codec, WM8996_AIF2RX_CHANNEL_1_CONFIGURATION,
-			    WM8996_AIF2RX_CHAN1_SLOTS_MASK |
-			    WM8996_AIF2RX_CHAN1_START_SLOT_MASK,
-			    1 << WM8996_AIF2RX_CHAN1_SLOTS_SHIFT | 1);
-
-	snd_soc_update_bits(codec, WM8996_AIF1TX_CHANNEL_0_CONFIGURATION,
-			    WM8996_AIF1TX_CHAN0_SLOTS_MASK |
-			    WM8996_AIF1TX_CHAN0_START_SLOT_MASK,
-			    1 << WM8996_AIF1TX_CHAN0_SLOTS_SHIFT | 0);
-	snd_soc_update_bits(codec, WM8996_AIF1TX_CHANNEL_1_CONFIGURATION,
-			    WM8996_AIF1TX_CHAN1_SLOTS_MASK |
-			    WM8996_AIF1TX_CHAN0_START_SLOT_MASK,
-			    1 << WM8996_AIF1TX_CHAN1_SLOTS_SHIFT | 1);
-	snd_soc_update_bits(codec, WM8996_AIF1TX_CHANNEL_2_CONFIGURATION,
-			    WM8996_AIF1TX_CHAN2_SLOTS_MASK |
-			    WM8996_AIF1TX_CHAN0_START_SLOT_MASK,
-			    1 << WM8996_AIF1TX_CHAN2_SLOTS_SHIFT | 0);
-	snd_soc_update_bits(codec, WM8996_AIF1TX_CHANNEL_3_CONFIGURATION,
-			    WM8996_AIF1TX_CHAN3_SLOTS_MASK |
-			    WM8996_AIF1TX_CHAN0_START_SLOT_MASK,
-			    1 << WM8996_AIF1TX_CHAN3_SLOTS_SHIFT | 1);
-	snd_soc_update_bits(codec, WM8996_AIF1TX_CHANNEL_4_CONFIGURATION,
-			    WM8996_AIF1TX_CHAN4_SLOTS_MASK |
-			    WM8996_AIF1TX_CHAN0_START_SLOT_MASK,
-			    1 << WM8996_AIF1TX_CHAN4_SLOTS_SHIFT | 0);
-	snd_soc_update_bits(codec, WM8996_AIF1TX_CHANNEL_5_CONFIGURATION,
-			    WM8996_AIF1TX_CHAN5_SLOTS_MASK |
-			    WM8996_AIF1TX_CHAN0_START_SLOT_MASK,
-			    1 << WM8996_AIF1TX_CHAN5_SLOTS_SHIFT | 1);
-
-	snd_soc_update_bits(codec, WM8996_AIF2TX_CHANNEL_0_CONFIGURATION,
-			    WM8996_AIF2TX_CHAN0_SLOTS_MASK |
-			    WM8996_AIF2TX_CHAN0_START_SLOT_MASK,
-			    1 << WM8996_AIF2TX_CHAN0_SLOTS_SHIFT | 0);
-	snd_soc_update_bits(codec, WM8996_AIF1TX_CHANNEL_1_CONFIGURATION,
-			    WM8996_AIF2TX_CHAN1_SLOTS_MASK |
-			    WM8996_AIF2TX_CHAN1_START_SLOT_MASK,
-			    1 << WM8996_AIF1TX_CHAN1_SLOTS_SHIFT | 1);
-
 	if (wm8996->pdata.num_retune_mobile_cfgs)
 		wm8996_retune_mobile_pdata(codec);
 	else
 		snd_soc_add_codec_controls(codec, wm8996_eq_controls,
 				     ARRAY_SIZE(wm8996_eq_controls));
 
-	/* If the TX LRCLK pins are not in LRCLK mode configure the
-	 * AIFs to source their clocks from the RX LRCLKs.
-	 */
-	if ((snd_soc_read(codec, WM8996_GPIO_1)))
-		snd_soc_update_bits(codec, WM8996_AIF1_TX_LRCLK_2,
-				    WM8996_AIF1TX_LRCLK_MODE,
-				    WM8996_AIF1TX_LRCLK_MODE);
-
-	if ((snd_soc_read(codec, WM8996_GPIO_2)))
-		snd_soc_update_bits(codec, WM8996_AIF2_TX_LRCLK_2,
-				    WM8996_AIF2TX_LRCLK_MODE,
-				    WM8996_AIF2TX_LRCLK_MODE);
-
 	if (i2c->irq) {
 		if (wm8996->pdata.irq_flags)
 			irq_flags = wm8996->pdata.irq_flags;
@@ -3023,6 +2873,185 @@ static __devinit int wm8996_i2c_probe(struct i2c_client *i2c,
 
 	regulator_bulk_disable(ARRAY_SIZE(wm8996->supplies), wm8996->supplies);
 
+	/* Apply platform data settings */
+	regmap_update_bits(wm8996->regmap, WM8996_LINE_INPUT_CONTROL,
+			   WM8996_INL_MODE_MASK | WM8996_INR_MODE_MASK,
+			   wm8996->pdata.inl_mode << WM8996_INL_MODE_SHIFT |
+			   wm8996->pdata.inr_mode);
+
+	for (i = 0; i < ARRAY_SIZE(wm8996->pdata.gpio_default); i++) {
+		if (!wm8996->pdata.gpio_default[i])
+			continue;
+
+		regmap_write(wm8996->regmap, WM8996_GPIO_1 + i,
+			     wm8996->pdata.gpio_default[i] & 0xffff);
+	}
+
+	if (wm8996->pdata.spkmute_seq)
+		regmap_update_bits(wm8996->regmap,
+				   WM8996_PDM_SPEAKER_MUTE_SEQUENCE,
+				   WM8996_SPK_MUTE_ENDIAN |
+				   WM8996_SPK_MUTE_SEQ1_MASK,
+				   wm8996->pdata.spkmute_seq);
+
+	regmap_update_bits(wm8996->regmap, WM8996_ACCESSORY_DETECT_MODE_2,
+			   WM8996_MICD_BIAS_SRC | WM8996_HPOUT1FB_SRC |
+			   WM8996_MICD_SRC, wm8996->pdata.micdet_def);
+
+	/* Latch volume update bits */
+	regmap_update_bits(wm8996->regmap, WM8996_LEFT_LINE_INPUT_VOLUME,
+			   WM8996_IN1_VU, WM8996_IN1_VU);
+	regmap_update_bits(wm8996->regmap, WM8996_RIGHT_LINE_INPUT_VOLUME,
+			   WM8996_IN1_VU, WM8996_IN1_VU);
+
+	regmap_update_bits(wm8996->regmap, WM8996_DAC1_LEFT_VOLUME,
+			   WM8996_DAC1_VU, WM8996_DAC1_VU);
+	regmap_update_bits(wm8996->regmap, WM8996_DAC1_RIGHT_VOLUME,
+			   WM8996_DAC1_VU, WM8996_DAC1_VU);
+	regmap_update_bits(wm8996->regmap, WM8996_DAC2_LEFT_VOLUME,
+			   WM8996_DAC2_VU, WM8996_DAC2_VU);
+	regmap_update_bits(wm8996->regmap, WM8996_DAC2_RIGHT_VOLUME,
+			   WM8996_DAC2_VU, WM8996_DAC2_VU);
+
+	regmap_update_bits(wm8996->regmap, WM8996_OUTPUT1_LEFT_VOLUME,
+			   WM8996_DAC1_VU, WM8996_DAC1_VU);
+	regmap_update_bits(wm8996->regmap, WM8996_OUTPUT1_RIGHT_VOLUME,
+			   WM8996_DAC1_VU, WM8996_DAC1_VU);
+	regmap_update_bits(wm8996->regmap, WM8996_OUTPUT2_LEFT_VOLUME,
+			   WM8996_DAC2_VU, WM8996_DAC2_VU);
+	regmap_update_bits(wm8996->regmap, WM8996_OUTPUT2_RIGHT_VOLUME,
+			   WM8996_DAC2_VU, WM8996_DAC2_VU);
+
+	regmap_update_bits(wm8996->regmap, WM8996_DSP1_TX_LEFT_VOLUME,
+			   WM8996_DSP1TX_VU, WM8996_DSP1TX_VU);
+	regmap_update_bits(wm8996->regmap, WM8996_DSP1_TX_RIGHT_VOLUME,
+			   WM8996_DSP1TX_VU, WM8996_DSP1TX_VU);
+	regmap_update_bits(wm8996->regmap, WM8996_DSP2_TX_LEFT_VOLUME,
+			   WM8996_DSP2TX_VU, WM8996_DSP2TX_VU);
+	regmap_update_bits(wm8996->regmap, WM8996_DSP2_TX_RIGHT_VOLUME,
+			   WM8996_DSP2TX_VU, WM8996_DSP2TX_VU);
+
+	regmap_update_bits(wm8996->regmap, WM8996_DSP1_RX_LEFT_VOLUME,
+			   WM8996_DSP1RX_VU, WM8996_DSP1RX_VU);
+	regmap_update_bits(wm8996->regmap, WM8996_DSP1_RX_RIGHT_VOLUME,
+			   WM8996_DSP1RX_VU, WM8996_DSP1RX_VU);
+	regmap_update_bits(wm8996->regmap, WM8996_DSP2_RX_LEFT_VOLUME,
+			   WM8996_DSP2RX_VU, WM8996_DSP2RX_VU);
+	regmap_update_bits(wm8996->regmap, WM8996_DSP2_RX_RIGHT_VOLUME,
+			   WM8996_DSP2RX_VU, WM8996_DSP2RX_VU);
+
+	/* No support currently for the underclocked TDM modes and
+	 * pick a default TDM layout with each channel pair working with
+	 * slots 0 and 1. */
+	regmap_update_bits(wm8996->regmap,
+			   WM8996_AIF1RX_CHANNEL_0_CONFIGURATION,
+			   WM8996_AIF1RX_CHAN0_SLOTS_MASK |
+			   WM8996_AIF1RX_CHAN0_START_SLOT_MASK,
+			   1 << WM8996_AIF1RX_CHAN0_SLOTS_SHIFT | 0);
+	regmap_update_bits(wm8996->regmap,
+			   WM8996_AIF1RX_CHANNEL_1_CONFIGURATION,
+			   WM8996_AIF1RX_CHAN1_SLOTS_MASK |
+			   WM8996_AIF1RX_CHAN1_START_SLOT_MASK,
+			   1 << WM8996_AIF1RX_CHAN1_SLOTS_SHIFT | 1);
+	regmap_update_bits(wm8996->regmap,
+			   WM8996_AIF1RX_CHANNEL_2_CONFIGURATION,
+			   WM8996_AIF1RX_CHAN2_SLOTS_MASK |
+			   WM8996_AIF1RX_CHAN2_START_SLOT_MASK,
+			   1 << WM8996_AIF1RX_CHAN2_SLOTS_SHIFT | 0);
+	regmap_update_bits(wm8996->regmap,
+			   WM8996_AIF1RX_CHANNEL_3_CONFIGURATION,
+			   WM8996_AIF1RX_CHAN3_SLOTS_MASK |
+			   WM8996_AIF1RX_CHAN0_START_SLOT_MASK,
+			   1 << WM8996_AIF1RX_CHAN3_SLOTS_SHIFT | 1);
+	regmap_update_bits(wm8996->regmap,
+			   WM8996_AIF1RX_CHANNEL_4_CONFIGURATION,
+			   WM8996_AIF1RX_CHAN4_SLOTS_MASK |
+			   WM8996_AIF1RX_CHAN0_START_SLOT_MASK,
+			   1 << WM8996_AIF1RX_CHAN4_SLOTS_SHIFT | 0);
+	regmap_update_bits(wm8996->regmap,
+			   WM8996_AIF1RX_CHANNEL_5_CONFIGURATION,
+			   WM8996_AIF1RX_CHAN5_SLOTS_MASK |
+			   WM8996_AIF1RX_CHAN0_START_SLOT_MASK,
+			   1 << WM8996_AIF1RX_CHAN5_SLOTS_SHIFT | 1);
+
+	regmap_update_bits(wm8996->regmap,
+			   WM8996_AIF2RX_CHANNEL_0_CONFIGURATION,
+			   WM8996_AIF2RX_CHAN0_SLOTS_MASK |
+			   WM8996_AIF2RX_CHAN0_START_SLOT_MASK,
+			   1 << WM8996_AIF2RX_CHAN0_SLOTS_SHIFT | 0);
+	regmap_update_bits(wm8996->regmap,
+			   WM8996_AIF2RX_CHANNEL_1_CONFIGURATION,
+			   WM8996_AIF2RX_CHAN1_SLOTS_MASK |
+			   WM8996_AIF2RX_CHAN1_START_SLOT_MASK,
+			   1 << WM8996_AIF2RX_CHAN1_SLOTS_SHIFT | 1);
+
+	regmap_update_bits(wm8996->regmap,
+			   WM8996_AIF1TX_CHANNEL_0_CONFIGURATION,
+			   WM8996_AIF1TX_CHAN0_SLOTS_MASK |
+			   WM8996_AIF1TX_CHAN0_START_SLOT_MASK,
+			   1 << WM8996_AIF1TX_CHAN0_SLOTS_SHIFT | 0);
+	regmap_update_bits(wm8996->regmap,
+			   WM8996_AIF1TX_CHANNEL_1_CONFIGURATION,
+			   WM8996_AIF1TX_CHAN1_SLOTS_MASK |
+			   WM8996_AIF1TX_CHAN0_START_SLOT_MASK,
+			   1 << WM8996_AIF1TX_CHAN1_SLOTS_SHIFT | 1);
+	regmap_update_bits(wm8996->regmap,
+			   WM8996_AIF1TX_CHANNEL_2_CONFIGURATION,
+			   WM8996_AIF1TX_CHAN2_SLOTS_MASK |
+			   WM8996_AIF1TX_CHAN0_START_SLOT_MASK,
+			   1 << WM8996_AIF1TX_CHAN2_SLOTS_SHIFT | 0);
+	regmap_update_bits(wm8996->regmap,
+			   WM8996_AIF1TX_CHANNEL_3_CONFIGURATION,
+			   WM8996_AIF1TX_CHAN3_SLOTS_MASK |
+			   WM8996_AIF1TX_CHAN0_START_SLOT_MASK,
+			   1 << WM8996_AIF1TX_CHAN3_SLOTS_SHIFT | 1);
+	regmap_update_bits(wm8996->regmap,
+			   WM8996_AIF1TX_CHANNEL_4_CONFIGURATION,
+			   WM8996_AIF1TX_CHAN4_SLOTS_MASK |
+			   WM8996_AIF1TX_CHAN0_START_SLOT_MASK,
+			   1 << WM8996_AIF1TX_CHAN4_SLOTS_SHIFT | 0);
+	regmap_update_bits(wm8996->regmap,
+			   WM8996_AIF1TX_CHANNEL_5_CONFIGURATION,
+			   WM8996_AIF1TX_CHAN5_SLOTS_MASK |
+			   WM8996_AIF1TX_CHAN0_START_SLOT_MASK,
+			   1 << WM8996_AIF1TX_CHAN5_SLOTS_SHIFT | 1);
+
+	regmap_update_bits(wm8996->regmap,
+			   WM8996_AIF2TX_CHANNEL_0_CONFIGURATION,
+			   WM8996_AIF2TX_CHAN0_SLOTS_MASK |
+			   WM8996_AIF2TX_CHAN0_START_SLOT_MASK,
+			   1 << WM8996_AIF2TX_CHAN0_SLOTS_SHIFT | 0);
+	regmap_update_bits(wm8996->regmap,
+			   WM8996_AIF1TX_CHANNEL_1_CONFIGURATION,
+			   WM8996_AIF2TX_CHAN1_SLOTS_MASK |
+			   WM8996_AIF2TX_CHAN1_START_SLOT_MASK,
+			   1 << WM8996_AIF1TX_CHAN1_SLOTS_SHIFT | 1);
+
+	/* If the TX LRCLK pins are not in LRCLK mode configure the
+	 * AIFs to source their clocks from the RX LRCLKs.
+	 */
+	ret = regmap_read(wm8996->regmap, WM8996_GPIO_1, &reg);
+	if (ret != 0) {
+		dev_err(&i2c->dev, "Failed to read GPIO1: %d\n", ret);
+		goto err_regmap;
+	}
+
+	if (reg & WM8996_GP1_FN_MASK)
+		regmap_update_bits(wm8996->regmap, WM8996_AIF1_TX_LRCLK_2,
+				   WM8996_AIF1TX_LRCLK_MODE,
+				   WM8996_AIF1TX_LRCLK_MODE);
+
+	ret = regmap_read(wm8996->regmap, WM8996_GPIO_2, &reg);
+	if (ret != 0) {
+		dev_err(&i2c->dev, "Failed to read GPIO2: %d\n", ret);
+		goto err_regmap;
+	}
+
+	if (reg & WM8996_GP2_FN_MASK)
+		regmap_update_bits(wm8996->regmap, WM8996_AIF2_TX_LRCLK_2,
+				   WM8996_AIF2TX_LRCLK_MODE,
+				   WM8996_AIF2TX_LRCLK_MODE);
+
 	wm8996_init_gpio(wm8996);
 
 	ret = snd_soc_register_codec(&i2c->dev,
-- 
1.7.10
