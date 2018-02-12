From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: atmel-pdmic: replace codec to
	component" to the asoc tree
Date: Mon, 12 Feb 2018 12:33:11 +0000
Message-ID: <E1elDIF-0003Ym-Sv@debutante>
References: <87y3khwat6.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 0488E26761D
 for <alsa-devel@alsa-project.org>; Mon, 12 Feb 2018 13:33:14 +0100 (CET)
In-Reply-To: <87y3khwat6.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: atmel-pdmic: replace codec to component

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

>From 716c5223171e94a4dd28c6e8891b8ed9921c93a7 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 29 Jan 2018 04:27:08 +0000
Subject: [PATCH] ASoC: atmel-pdmic: replace codec to component

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
 sound/soc/atmel/atmel-pdmic.c | 56 +++++++++++++++++++++----------------------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/sound/soc/atmel/atmel-pdmic.c b/sound/soc/atmel/atmel-pdmic.c
index 8e3d34be9e69..5f72baa5f5c7 100644
--- a/sound/soc/atmel/atmel-pdmic.c
+++ b/sound/soc/atmel/atmel-pdmic.c
@@ -288,14 +288,14 @@ static const DECLARE_TLV_DB_RANGE(mic_gain_tlv,
 static int pdmic_get_mic_volsw(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
 	unsigned int dgain_val, scale_val;
 	int i;
 
-	dgain_val = (snd_soc_read(codec, PDMIC_DSPR1) & PDMIC_DSPR1_DGAIN_MASK)
+	dgain_val = (snd_soc_component_read32(component, PDMIC_DSPR1) & PDMIC_DSPR1_DGAIN_MASK)
 		    >> PDMIC_DSPR1_DGAIN_SHIFT;
 
-	scale_val = (snd_soc_read(codec, PDMIC_DSPR0) & PDMIC_DSPR0_SCALE_MASK)
+	scale_val = (snd_soc_component_read32(component, PDMIC_DSPR0) & PDMIC_DSPR0_SCALE_MASK)
 		    >> PDMIC_DSPR0_SCALE_SHIFT;
 
 	for (i = 0; i < ARRAY_SIZE(mic_gain_table); i++) {
@@ -312,7 +312,7 @@ static int pdmic_put_mic_volsw(struct snd_kcontrol *kcontrol,
 {
 	struct soc_mixer_control *mc =
 		(struct soc_mixer_control *)kcontrol->private_value;
-	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
 	int max = mc->max;
 	unsigned int val;
 	int ret;
@@ -322,12 +322,12 @@ static int pdmic_put_mic_volsw(struct snd_kcontrol *kcontrol,
 	if (val > max)
 		return -EINVAL;
 
-	ret = snd_soc_update_bits(codec, PDMIC_DSPR1, PDMIC_DSPR1_DGAIN_MASK,
+	ret = snd_soc_component_update_bits(component, PDMIC_DSPR1, PDMIC_DSPR1_DGAIN_MASK,
 			 mic_gain_table[val].dgain << PDMIC_DSPR1_DGAIN_SHIFT);
 	if (ret < 0)
 		return ret;
 
-	ret = snd_soc_update_bits(codec, PDMIC_DSPR0, PDMIC_DSPR0_SCALE_MASK,
+	ret = snd_soc_component_update_bits(component, PDMIC_DSPR0, PDMIC_DSPR0_SCALE_MASK,
 			 mic_gain_table[val].scale << PDMIC_DSPR0_SCALE_SHIFT);
 	if (ret < 0)
 		return ret;
@@ -346,23 +346,25 @@ SOC_SINGLE("High Pass Filter Switch", PDMIC_DSPR0,
 SOC_SINGLE("SINCC Filter Switch", PDMIC_DSPR0, PDMIC_DSPR0_SINBYP_SHIFT, 1, 1),
 };
 
-static int atmel_pdmic_codec_probe(struct snd_soc_codec *codec)
+static int atmel_pdmic_component_probe(struct snd_soc_component *component)
 {
-	struct snd_soc_card *card = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_card *card = snd_soc_component_get_drvdata(component);
 	struct atmel_pdmic *dd = snd_soc_card_get_drvdata(card);
 
-	snd_soc_update_bits(codec, PDMIC_DSPR1, PDMIC_DSPR1_OFFSET_MASK,
+	snd_soc_component_update_bits(component, PDMIC_DSPR1, PDMIC_DSPR1_OFFSET_MASK,
 		     (u32)(dd->pdata->mic_offset << PDMIC_DSPR1_OFFSET_SHIFT));
 
 	return 0;
 }
 
-static struct snd_soc_codec_driver soc_codec_dev_pdmic = {
-	.probe		= atmel_pdmic_codec_probe,
-	.component_driver = {
-		.controls		= atmel_pdmic_snd_controls,
-		.num_controls		= ARRAY_SIZE(atmel_pdmic_snd_controls),
-	},
+static struct snd_soc_component_driver soc_component_dev_pdmic = {
+	.probe			= atmel_pdmic_component_probe,
+	.controls		= atmel_pdmic_snd_controls,
+	.num_controls		= ARRAY_SIZE(atmel_pdmic_snd_controls),
+	.idle_bias_on		= 1,
+	.use_pmdown_time	= 1,
+	.endianness		= 1,
+	.non_legacy_dai_naming	= 1,
 };
 
 /* codec dai component */
@@ -375,7 +377,7 @@ atmel_pdmic_codec_dai_hw_params(struct snd_pcm_substream *substream,
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct atmel_pdmic *dd = snd_soc_card_get_drvdata(rtd->card);
-	struct snd_soc_codec *codec = codec_dai->codec;
+	struct snd_soc_component *component = codec_dai->component;
 	unsigned int rate_min = substream->runtime->hw.rate_min;
 	unsigned int rate_max = substream->runtime->hw.rate_max;
 	int fs = params_rate(params);
@@ -385,13 +387,13 @@ atmel_pdmic_codec_dai_hw_params(struct snd_pcm_substream *substream,
 	u32 mr_val, dspr0_val, pclk_prescal, gclk_prescal;
 
 	if (params_channels(params) != 1) {
-		dev_err(codec->dev,
+		dev_err(component->dev,
 			"only supports one channel\n");
 		return -EINVAL;
 	}
 
 	if ((fs < rate_min) || (fs > rate_max)) {
-		dev_err(codec->dev,
+		dev_err(component->dev,
 			"sample rate is %dHz, min rate is %dHz, max rate is %dHz\n",
 			fs, rate_min, rate_max);
 
@@ -436,10 +438,10 @@ atmel_pdmic_codec_dai_hw_params(struct snd_pcm_substream *substream,
 		mr_val |= PDMIC_MR_CLKS_PCK << PDMIC_MR_CLKS_SHIFT;
 	}
 
-	snd_soc_update_bits(codec, PDMIC_MR,
+	snd_soc_component_update_bits(component, PDMIC_MR,
 		PDMIC_MR_PRESCAL_MASK | PDMIC_MR_CLKS_MASK, mr_val);
 
-	snd_soc_update_bits(codec, PDMIC_DSPR0,
+	snd_soc_component_update_bits(component, PDMIC_DSPR0,
 		PDMIC_DSPR0_OSR_MASK | PDMIC_DSPR0_SIZE_MASK, dspr0_val);
 
 	return 0;
@@ -448,9 +450,9 @@ atmel_pdmic_codec_dai_hw_params(struct snd_pcm_substream *substream,
 static int atmel_pdmic_codec_dai_prepare(struct snd_pcm_substream *substream,
 					struct snd_soc_dai *codec_dai)
 {
-	struct snd_soc_codec *codec = codec_dai->codec;
+	struct snd_soc_component *component = codec_dai->component;
 
-	snd_soc_update_bits(codec, PDMIC_CR, PDMIC_CR_ENPDM_MASK,
+	snd_soc_component_update_bits(component, PDMIC_CR, PDMIC_CR_ENPDM_MASK,
 			    PDMIC_CR_ENPDM_DIS << PDMIC_CR_ENPDM_SHIFT);
 
 	return 0;
@@ -459,7 +461,7 @@ static int atmel_pdmic_codec_dai_prepare(struct snd_pcm_substream *substream,
 static int atmel_pdmic_codec_dai_trigger(struct snd_pcm_substream *substream,
 					int cmd, struct snd_soc_dai *codec_dai)
 {
-	struct snd_soc_codec *codec = codec_dai->codec;
+	struct snd_soc_component *component = codec_dai->component;
 	u32 val;
 
 	switch (cmd) {
@@ -477,7 +479,7 @@ static int atmel_pdmic_codec_dai_trigger(struct snd_pcm_substream *substream,
 		return -EINVAL;
 	}
 
-	snd_soc_update_bits(codec, PDMIC_CR, PDMIC_CR_ENPDM_MASK, val);
+	snd_soc_component_update_bits(component, PDMIC_CR, PDMIC_CR_ENPDM_MASK, val);
 
 	return 0;
 }
@@ -679,10 +681,10 @@ static int atmel_pdmic_probe(struct platform_device *pdev)
 	/* register codec and codec dai */
 	atmel_pdmic_codec_dai.capture.rate_min = rate_min;
 	atmel_pdmic_codec_dai.capture.rate_max = rate_max;
-	ret = snd_soc_register_codec(dev, &soc_codec_dev_pdmic,
+	ret = devm_snd_soc_register_component(dev, &soc_component_dev_pdmic,
 				     &atmel_pdmic_codec_dai, 1);
 	if (ret) {
-		dev_err(dev, "could not register codec: %d\n", ret);
+		dev_err(dev, "could not register component: %d\n", ret);
 		return ret;
 	}
 
@@ -710,13 +712,11 @@ static int atmel_pdmic_probe(struct platform_device *pdev)
 	return 0;
 
 unregister_codec:
-	snd_soc_unregister_codec(dev);
 	return ret;
 }
 
 static int atmel_pdmic_remove(struct platform_device *pdev)
 {
-	snd_soc_unregister_codec(&pdev->dev);
 	return 0;
 }
 
-- 
2.16.1
