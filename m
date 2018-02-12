From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: msm8916-wcd-digital: replace codec to
	component" to the asoc tree
Date: Mon, 12 Feb 2018 12:39:07 +0000
Message-ID: <E1elDNz-0004RH-1k@debutante>
References: <87h8r5xpms.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 619A2267B18
 for <alsa-devel@alsa-project.org>; Mon, 12 Feb 2018 13:39:09 +0100 (CET)
In-Reply-To: <87h8r5xpms.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: msm8916-wcd-digital: replace codec to component

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 2eec0a15e8d7e2a08acff56701cbd98e24a41097 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 29 Jan 2018 04:21:38 +0000
Subject: [PATCH] ASoC: msm8916-wcd-digital: replace codec to component

Now we can replace Codec to Component. Let's do it.

Note:
	xxx_codec_xxx()		->	xxx_component_xxx()
	.idle_bias_off = 0	->	.idle_bias_on = 1
	.ignore_pmdown_time = 0	->	.use_pmdown_time = 1
	-			->	.endianness = 1
	-			->	.non_legacy_dai_naming = 1

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/msm8916-wcd-digital.c | 115 +++++++++++++++++----------------
 1 file changed, 58 insertions(+), 57 deletions(-)

diff --git a/sound/soc/codecs/msm8916-wcd-digital.c b/sound/soc/codecs/msm8916-wcd-digital.c
index 13354d6304a8..3063dedd21cf 100644
--- a/sound/soc/codecs/msm8916-wcd-digital.c
+++ b/sound/soc/codecs/msm8916-wcd-digital.c
@@ -348,14 +348,14 @@ static int msm8916_wcd_digital_enable_interpolator(
 						struct snd_kcontrol *kcontrol,
 						int event)
 {
-	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
+	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
 
 	switch (event) {
 	case SND_SOC_DAPM_POST_PMU:
 		/* apply the digital gain after the interpolator is enabled */
 		usleep_range(10000, 10100);
-		snd_soc_write(codec, rx_gain_reg[w->shift],
-			      snd_soc_read(codec, rx_gain_reg[w->shift]));
+		snd_soc_component_write(component, rx_gain_reg[w->shift],
+			      snd_soc_component_read32(component, rx_gain_reg[w->shift]));
 		break;
 	}
 	return 0;
@@ -365,7 +365,7 @@ static int msm8916_wcd_digital_enable_dec(struct snd_soc_dapm_widget *w,
 					  struct snd_kcontrol *kcontrol,
 					  int event)
 {
-	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
+	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
 	unsigned int decimator = w->shift + 1;
 	u16 dec_reset_reg, tx_vol_ctl_reg, tx_mux_ctl_reg;
 	u8 dec_hpf_cut_of_freq;
@@ -377,46 +377,46 @@ static int msm8916_wcd_digital_enable_dec(struct snd_soc_dapm_widget *w,
 	switch (event) {
 	case SND_SOC_DAPM_PRE_PMU:
 		/* Enable TX digital mute */
-		snd_soc_update_bits(codec, tx_vol_ctl_reg,
+		snd_soc_component_update_bits(component, tx_vol_ctl_reg,
 				    TX_VOL_CTL_CFG_MUTE_EN_MASK,
 				    TX_VOL_CTL_CFG_MUTE_EN_ENABLE);
-		dec_hpf_cut_of_freq = snd_soc_read(codec, tx_mux_ctl_reg) &
+		dec_hpf_cut_of_freq = snd_soc_component_read32(component, tx_mux_ctl_reg) &
 					TX_MUX_CTL_CUT_OFF_FREQ_MASK;
 		dec_hpf_cut_of_freq >>= TX_MUX_CTL_CUT_OFF_FREQ_SHIFT;
 		if (dec_hpf_cut_of_freq != TX_MUX_CTL_CF_NEG_3DB_150HZ) {
 			/* set cut of freq to CF_MIN_3DB_150HZ (0x1) */
-			snd_soc_update_bits(codec, tx_mux_ctl_reg,
+			snd_soc_component_update_bits(component, tx_mux_ctl_reg,
 					    TX_MUX_CTL_CUT_OFF_FREQ_MASK,
 					    TX_MUX_CTL_CF_NEG_3DB_150HZ);
 		}
 		break;
 	case SND_SOC_DAPM_POST_PMU:
 		/* enable HPF */
-		snd_soc_update_bits(codec, tx_mux_ctl_reg,
+		snd_soc_component_update_bits(component, tx_mux_ctl_reg,
 				    TX_MUX_CTL_HPF_BP_SEL_MASK,
 				    TX_MUX_CTL_HPF_BP_SEL_NO_BYPASS);
 		/* apply the digital gain after the decimator is enabled */
-		snd_soc_write(codec, tx_gain_reg[w->shift],
-			      snd_soc_read(codec, tx_gain_reg[w->shift]));
-		snd_soc_update_bits(codec, tx_vol_ctl_reg,
+		snd_soc_component_write(component, tx_gain_reg[w->shift],
+			      snd_soc_component_read32(component, tx_gain_reg[w->shift]));
+		snd_soc_component_update_bits(component, tx_vol_ctl_reg,
 				    TX_VOL_CTL_CFG_MUTE_EN_MASK, 0);
 		break;
 	case SND_SOC_DAPM_PRE_PMD:
-		snd_soc_update_bits(codec, tx_vol_ctl_reg,
+		snd_soc_component_update_bits(component, tx_vol_ctl_reg,
 				    TX_VOL_CTL_CFG_MUTE_EN_MASK,
 				    TX_VOL_CTL_CFG_MUTE_EN_ENABLE);
-		snd_soc_update_bits(codec, tx_mux_ctl_reg,
+		snd_soc_component_update_bits(component, tx_mux_ctl_reg,
 				    TX_MUX_CTL_HPF_BP_SEL_MASK,
 				    TX_MUX_CTL_HPF_BP_SEL_BYPASS);
 		break;
 	case SND_SOC_DAPM_POST_PMD:
-		snd_soc_update_bits(codec, dec_reset_reg, 1 << w->shift,
+		snd_soc_component_update_bits(component, dec_reset_reg, 1 << w->shift,
 				    1 << w->shift);
-		snd_soc_update_bits(codec, dec_reset_reg, 1 << w->shift, 0x0);
-		snd_soc_update_bits(codec, tx_mux_ctl_reg,
+		snd_soc_component_update_bits(component, dec_reset_reg, 1 << w->shift, 0x0);
+		snd_soc_component_update_bits(component, tx_mux_ctl_reg,
 				    TX_MUX_CTL_HPF_BP_SEL_MASK,
 				    TX_MUX_CTL_HPF_BP_SEL_BYPASS);
-		snd_soc_update_bits(codec, tx_vol_ctl_reg,
+		snd_soc_component_update_bits(component, tx_vol_ctl_reg,
 				    TX_VOL_CTL_CFG_MUTE_EN_MASK, 0);
 		break;
 	}
@@ -428,35 +428,35 @@ static int msm8916_wcd_digital_enable_dmic(struct snd_soc_dapm_widget *w,
 					   struct snd_kcontrol *kcontrol,
 					   int event)
 {
-	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
+	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
 	unsigned int dmic;
 	int ret;
 	/* get dmic number out of widget name */
 	char *dmic_num = strpbrk(w->name, "12");
 
 	if (dmic_num == NULL) {
-		dev_err(codec->dev, "Invalid DMIC\n");
+		dev_err(component->dev, "Invalid DMIC\n");
 		return -EINVAL;
 	}
 	ret = kstrtouint(dmic_num, 10, &dmic);
 	if (ret < 0 || dmic > 2) {
-		dev_err(codec->dev, "Invalid DMIC line on the codec\n");
+		dev_err(component->dev, "Invalid DMIC line on the component\n");
 		return -EINVAL;
 	}
 
 	switch (event) {
 	case SND_SOC_DAPM_PRE_PMU:
-		snd_soc_update_bits(codec, LPASS_CDC_CLK_DMIC_B1_CTL,
+		snd_soc_component_update_bits(component, LPASS_CDC_CLK_DMIC_B1_CTL,
 				    DMIC_B1_CTL_DMIC0_CLK_SEL_MASK,
 				    DMIC_B1_CTL_DMIC0_CLK_SEL_DIV3);
 		switch (dmic) {
 		case 1:
-			snd_soc_update_bits(codec, LPASS_CDC_TX1_DMIC_CTL,
+			snd_soc_component_update_bits(component, LPASS_CDC_TX1_DMIC_CTL,
 					    TXN_DMIC_CTL_CLK_SEL_MASK,
 					    TXN_DMIC_CTL_CLK_SEL_DIV3);
 			break;
 		case 2:
-			snd_soc_update_bits(codec, LPASS_CDC_TX2_DMIC_CTL,
+			snd_soc_component_update_bits(component, LPASS_CDC_TX2_DMIC_CTL,
 					    TXN_DMIC_CTL_CLK_SEL_MASK,
 					    TXN_DMIC_CTL_CLK_SEL_DIV3);
 			break;
@@ -575,20 +575,20 @@ static int msm8916_wcd_digital_get_clks(struct platform_device *pdev,
 	return 0;
 }
 
-static int msm8916_wcd_digital_codec_probe(struct snd_soc_codec *codec)
+static int msm8916_wcd_digital_component_probe(struct snd_soc_component *component)
 {
-	struct msm8916_wcd_digital_priv *priv = dev_get_drvdata(codec->dev);
+	struct msm8916_wcd_digital_priv *priv = dev_get_drvdata(component->dev);
 
-	snd_soc_codec_set_drvdata(codec, priv);
+	snd_soc_component_set_drvdata(component, priv);
 
 	return 0;
 }
 
-static int msm8916_wcd_digital_codec_set_sysclk(struct snd_soc_codec *codec,
+static int msm8916_wcd_digital_component_set_sysclk(struct snd_soc_component *component,
 						int clk_id, int source,
 						unsigned int freq, int dir)
 {
-	struct msm8916_wcd_digital_priv *p = dev_get_drvdata(codec->dev);
+	struct msm8916_wcd_digital_priv *p = dev_get_drvdata(component->dev);
 
 	return clk_set_rate(p->mclk, freq);
 }
@@ -618,18 +618,18 @@ static int msm8916_wcd_digital_hw_params(struct snd_pcm_substream *substream,
 		rx_fs_rate = RX_I2S_CTL_RX_I2S_FS_RATE_F_48_KHZ;
 		break;
 	default:
-		dev_err(dai->codec->dev, "Invalid sampling rate %d\n",
+		dev_err(dai->component->dev, "Invalid sampling rate %d\n",
 			params_rate(params));
 		return -EINVAL;
 	}
 
 	switch (substream->stream) {
 	case SNDRV_PCM_STREAM_CAPTURE:
-		snd_soc_update_bits(dai->codec, LPASS_CDC_CLK_TX_I2S_CTL,
+		snd_soc_component_update_bits(dai->component, LPASS_CDC_CLK_TX_I2S_CTL,
 				    TX_I2S_CTL_TX_I2S_FS_RATE_MASK, tx_fs_rate);
 		break;
 	case SNDRV_PCM_STREAM_PLAYBACK:
-		snd_soc_update_bits(dai->codec, LPASS_CDC_CLK_RX_I2S_CTL,
+		snd_soc_component_update_bits(dai->component, LPASS_CDC_CLK_RX_I2S_CTL,
 				    RX_I2S_CTL_RX_I2S_FS_RATE_MASK, rx_fs_rate);
 		break;
 	default:
@@ -638,18 +638,19 @@ static int msm8916_wcd_digital_hw_params(struct snd_pcm_substream *substream,
 
 	switch (params_format(params)) {
 	case SNDRV_PCM_FORMAT_S16_LE:
-		snd_soc_update_bits(dai->codec, LPASS_CDC_CLK_TX_I2S_CTL,
+		snd_soc_component_update_bits(dai->component, LPASS_CDC_CLK_TX_I2S_CTL,
 				    TX_I2S_CTL_TX_I2S_MODE_MASK,
 				    TX_I2S_CTL_TX_I2S_MODE_16);
-		snd_soc_update_bits(dai->codec, LPASS_CDC_CLK_RX_I2S_CTL,
+		snd_soc_component_update_bits(dai->component, LPASS_CDC_CLK_RX_I2S_CTL,
 				    RX_I2S_CTL_RX_I2S_MODE_MASK,
 				    RX_I2S_CTL_RX_I2S_MODE_16);
 		break;
+
 	case SNDRV_PCM_FORMAT_S32_LE:
-		snd_soc_update_bits(dai->codec, LPASS_CDC_CLK_TX_I2S_CTL,
+		snd_soc_component_update_bits(dai->component, LPASS_CDC_CLK_TX_I2S_CTL,
 				    TX_I2S_CTL_TX_I2S_MODE_MASK,
 				    TX_I2S_CTL_TX_I2S_MODE_32);
-		snd_soc_update_bits(dai->codec, LPASS_CDC_CLK_RX_I2S_CTL,
+		snd_soc_component_update_bits(dai->component, LPASS_CDC_CLK_RX_I2S_CTL,
 				    RX_I2S_CTL_RX_I2S_MODE_MASK,
 				    RX_I2S_CTL_RX_I2S_MODE_32);
 		break;
@@ -780,32 +781,32 @@ static const struct snd_soc_dapm_route msm8916_wcd_digital_audio_map[] = {
 static int msm8916_wcd_digital_startup(struct snd_pcm_substream *substream,
 				       struct snd_soc_dai *dai)
 {
-	struct snd_soc_codec *codec = dai->codec;
+	struct snd_soc_component *component = dai->component;
 	struct msm8916_wcd_digital_priv *msm8916_wcd;
 	unsigned long mclk_rate;
 
-	msm8916_wcd = snd_soc_codec_get_drvdata(codec);
-	snd_soc_update_bits(codec, LPASS_CDC_CLK_MCLK_CTL,
+	msm8916_wcd = snd_soc_component_get_drvdata(component);
+	snd_soc_component_update_bits(component, LPASS_CDC_CLK_MCLK_CTL,
 			    MCLK_CTL_MCLK_EN_MASK,
 			    MCLK_CTL_MCLK_EN_ENABLE);
-	snd_soc_update_bits(codec, LPASS_CDC_CLK_PDM_CTL,
+	snd_soc_component_update_bits(component, LPASS_CDC_CLK_PDM_CTL,
 			    LPASS_CDC_CLK_PDM_CTL_PDM_CLK_SEL_MASK,
 			    LPASS_CDC_CLK_PDM_CTL_PDM_CLK_SEL_FB);
 
 	mclk_rate = clk_get_rate(msm8916_wcd->mclk);
 	switch (mclk_rate) {
 	case 12288000:
-		snd_soc_update_bits(codec, LPASS_CDC_TOP_CTL,
+		snd_soc_component_update_bits(component, LPASS_CDC_TOP_CTL,
 				    TOP_CTL_DIG_MCLK_FREQ_MASK,
 				    TOP_CTL_DIG_MCLK_FREQ_F_12_288MHZ);
 		break;
 	case 9600000:
-		snd_soc_update_bits(codec, LPASS_CDC_TOP_CTL,
+		snd_soc_component_update_bits(component, LPASS_CDC_TOP_CTL,
 				    TOP_CTL_DIG_MCLK_FREQ_MASK,
 				    TOP_CTL_DIG_MCLK_FREQ_F_9_6MHZ);
 		break;
 	default:
-		dev_err(codec->dev, "Invalid mclk rate %ld\n", mclk_rate);
+		dev_err(component->dev, "Invalid mclk rate %ld\n", mclk_rate);
 		break;
 	}
 	return 0;
@@ -814,7 +815,7 @@ static int msm8916_wcd_digital_startup(struct snd_pcm_substream *substream,
 static void msm8916_wcd_digital_shutdown(struct snd_pcm_substream *substream,
 					 struct snd_soc_dai *dai)
 {
-	snd_soc_update_bits(dai->codec, LPASS_CDC_CLK_PDM_CTL,
+	snd_soc_component_update_bits(dai->component, LPASS_CDC_CLK_PDM_CTL,
 			    LPASS_CDC_CLK_PDM_CTL_PDM_CLK_SEL_MASK, 0);
 }
 
@@ -851,18 +852,19 @@ static struct snd_soc_dai_driver msm8916_wcd_digital_dai[] = {
 	       },
 };
 
-static const struct snd_soc_codec_driver msm8916_wcd_digital = {
-	.probe = msm8916_wcd_digital_codec_probe,
-	.set_sysclk = msm8916_wcd_digital_codec_set_sysclk,
-	.component_driver = {
-		.controls = msm8916_wcd_digital_snd_controls,
-		.num_controls = ARRAY_SIZE(msm8916_wcd_digital_snd_controls),
-		.dapm_widgets = msm8916_wcd_digital_dapm_widgets,
-		.num_dapm_widgets =
-				 ARRAY_SIZE(msm8916_wcd_digital_dapm_widgets),
-		.dapm_routes = msm8916_wcd_digital_audio_map,
-		.num_dapm_routes = ARRAY_SIZE(msm8916_wcd_digital_audio_map),
-	},
+static const struct snd_soc_component_driver msm8916_wcd_digital = {
+	.probe			= msm8916_wcd_digital_component_probe,
+	.set_sysclk		= msm8916_wcd_digital_component_set_sysclk,
+	.controls		= msm8916_wcd_digital_snd_controls,
+	.num_controls		= ARRAY_SIZE(msm8916_wcd_digital_snd_controls),
+	.dapm_widgets		= msm8916_wcd_digital_dapm_widgets,
+	.num_dapm_widgets	= ARRAY_SIZE(msm8916_wcd_digital_dapm_widgets),
+	.dapm_routes		= msm8916_wcd_digital_audio_map,
+	.num_dapm_routes	= ARRAY_SIZE(msm8916_wcd_digital_audio_map),
+	.idle_bias_on		= 1,
+	.use_pmdown_time	= 1,
+	.endianness		= 1,
+	.non_legacy_dai_naming	= 1,
 };
 
 static const struct regmap_config msm8916_codec_regmap_config = {
@@ -915,7 +917,7 @@ static int msm8916_wcd_digital_probe(struct platform_device *pdev)
 
 	dev_set_drvdata(dev, priv);
 
-	return snd_soc_register_codec(dev, &msm8916_wcd_digital,
+	return devm_snd_soc_register_component(dev, &msm8916_wcd_digital,
 				      msm8916_wcd_digital_dai,
 				      ARRAY_SIZE(msm8916_wcd_digital_dai));
 }
@@ -924,7 +926,6 @@ static int msm8916_wcd_digital_remove(struct platform_device *pdev)
 {
 	struct msm8916_wcd_digital_priv *priv = dev_get_drvdata(&pdev->dev);
 
-	snd_soc_unregister_codec(&pdev->dev);
 	clk_disable_unprepare(priv->mclk);
 	clk_disable_unprepare(priv->ahbclk);
 
-- 
2.16.1
