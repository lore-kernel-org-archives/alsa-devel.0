From: "Agrawal, Akshu" <Akshu.Agrawal@amd.com>
Subject: [PATCH v2] ASoC: DA7219: Implement error check on reg read and write
Date: Wed, 5 Dec 2018 09:37:35 +0000
Message-ID: <1544002365-15473-1-git-send-email-akshu.agrawal@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Cc: "Agrawal, Akshu" <Akshu.Agrawal@amd.com>, "djkurtz@chromium.org" <djkurtz@chromium.org>, "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Adam.Thomson@diasemi.com" <Adam.Thomson@diasemi.com>, Support Opensource <support.opensource@diasemi.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, open list <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Failed i2c transaction can lead to failure in reg read or write.
Need to have error check for each read write operation.

Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
---
v2: replaced snd_soc_component_read32 by snd_soc_component_read
Since, snd_soc_component_read32 implementation has error, in coming patches
we can remove snd_soc_component_read32 from soc-io and replace all codecs b=
y
snd_soc_component_read

 sound/soc/codecs/da7219.c | 349 +++++++++++++++++++++++++++++++++++-------=
----
 sound/soc/codecs/da7219.h |   2 +-
 2 files changed, 265 insertions(+), 86 deletions(-)

diff --git a/sound/soc/codecs/da7219.c b/sound/soc/codecs/da7219.c
index e46e9f4..c65e734 100644
--- a/sound/soc/codecs/da7219.c
+++ b/sound/soc/codecs/da7219.c
@@ -312,69 +312,105 @@ static int da7219_enum_locked_put(struct snd_kcontro=
l *kcontrol,
 }
=20
 /* ALC */
-static void da7219_alc_calib(struct snd_soc_component *component)
+static int da7219_alc_calib(struct snd_soc_component *component)
 {
-	u8 mic_ctrl, mixin_ctrl, adc_ctrl, calib_ctrl;
+	unsigned int mic_ctrl, mixin_ctrl, adc_ctrl, calib_ctrl;
+	int ret;
=20
 	/* Save current state of mic control register */
-	mic_ctrl =3D snd_soc_component_read32(component, DA7219_MIC_1_CTRL);
+	ret =3D snd_soc_component_read(component, DA7219_MIC_1_CTRL, &mic_ctrl);
+	if (ret)
+		return ret;
=20
 	/* Save current state of input mixer control register */
-	mixin_ctrl =3D snd_soc_component_read32(component, DA7219_MIXIN_L_CTRL);
+	ret =3D snd_soc_component_read(component, DA7219_MIXIN_L_CTRL,
+			    &mixin_ctrl);
+	if (ret)
+		return ret;
=20
 	/* Save current state of input ADC control register */
-	adc_ctrl =3D snd_soc_component_read32(component, DA7219_ADC_L_CTRL);
+	ret =3D snd_soc_component_read(component, DA7219_ADC_L_CTRL, &adc_ctrl);
+	if (ret)
+		return ret;
=20
 	/* Enable then Mute MIC PGAs */
-	snd_soc_component_update_bits(component, DA7219_MIC_1_CTRL, DA7219_MIC_1_=
AMP_EN_MASK,
+	ret =3D snd_soc_component_update_bits(component, DA7219_MIC_1_CTRL,
+			    DA7219_MIC_1_AMP_EN_MASK,
 			    DA7219_MIC_1_AMP_EN_MASK);
-	snd_soc_component_update_bits(component, DA7219_MIC_1_CTRL,
+	if (ret < 0)
+		return ret;
+
+	ret =3D snd_soc_component_update_bits(component, DA7219_MIC_1_CTRL,
 			    DA7219_MIC_1_AMP_MUTE_EN_MASK,
 			    DA7219_MIC_1_AMP_MUTE_EN_MASK);
+	if (ret < 0)
+		return ret;
=20
 	/* Enable input mixers unmuted */
-	snd_soc_component_update_bits(component, DA7219_MIXIN_L_CTRL,
+	ret =3D snd_soc_component_update_bits(component, DA7219_MIXIN_L_CTRL,
 			    DA7219_MIXIN_L_AMP_EN_MASK |
 			    DA7219_MIXIN_L_AMP_MUTE_EN_MASK,
 			    DA7219_MIXIN_L_AMP_EN_MASK);
+	if (ret < 0)
+		return ret;
=20
 	/* Enable input filters unmuted */
-	snd_soc_component_update_bits(component, DA7219_ADC_L_CTRL,
+	ret =3D snd_soc_component_update_bits(component, DA7219_ADC_L_CTRL,
 			    DA7219_ADC_L_MUTE_EN_MASK | DA7219_ADC_L_EN_MASK,
 			    DA7219_ADC_L_EN_MASK);
+	if (ret < 0)
+		return ret;
=20
 	/* Perform auto calibration */
-	snd_soc_component_update_bits(component, DA7219_ALC_CTRL1,
+	ret =3D snd_soc_component_update_bits(component, DA7219_ALC_CTRL1,
 			    DA7219_ALC_AUTO_CALIB_EN_MASK,
 			    DA7219_ALC_AUTO_CALIB_EN_MASK);
+	if (ret < 0)
+		return ret;
 	do {
-		calib_ctrl =3D snd_soc_component_read32(component, DA7219_ALC_CTRL1);
+		ret =3D snd_soc_component_read(component, DA7219_ALC_CTRL1,
+				&calib_ctrl);
+		if (ret)
+			return ret;
 	} while (calib_ctrl & DA7219_ALC_AUTO_CALIB_EN_MASK);
=20
 	/* If auto calibration fails, disable DC offset, hybrid ALC */
 	if (calib_ctrl & DA7219_ALC_CALIB_OVERFLOW_MASK) {
 		dev_warn(component->dev,
 			 "ALC auto calibration failed with overflow\n");
-		snd_soc_component_update_bits(component, DA7219_ALC_CTRL1,
+		ret =3D snd_soc_component_update_bits(component, DA7219_ALC_CTRL1,
 				    DA7219_ALC_OFFSET_EN_MASK |
 				    DA7219_ALC_SYNC_MODE_MASK, 0);
+		if (ret < 0)
+			return ret;
 	} else {
 		/* Enable DC offset cancellation, hybrid mode */
-		snd_soc_component_update_bits(component, DA7219_ALC_CTRL1,
+		ret =3D snd_soc_component_update_bits(component, DA7219_ALC_CTRL1,
 				    DA7219_ALC_OFFSET_EN_MASK |
 				    DA7219_ALC_SYNC_MODE_MASK,
 				    DA7219_ALC_OFFSET_EN_MASK |
 				    DA7219_ALC_SYNC_MODE_MASK);
+		if (ret < 0)
+			return ret;
 	}
=20
 	/* Restore input filter control register to original state */
-	snd_soc_component_write(component, DA7219_ADC_L_CTRL, adc_ctrl);
+	ret =3D snd_soc_component_write(component, DA7219_ADC_L_CTRL, adc_ctrl);
+	if (ret)
+		return ret;
=20
 	/* Restore input mixer control registers to original state */
-	snd_soc_component_write(component, DA7219_MIXIN_L_CTRL, mixin_ctrl);
+	ret =3D snd_soc_component_write(component, DA7219_MIXIN_L_CTRL,
+				mixin_ctrl);
+	if (ret)
+		return ret;
=20
 	/* Restore MIC control registers to original states */
-	snd_soc_component_write(component, DA7219_MIC_1_CTRL, mic_ctrl);
+	ret =3D snd_soc_component_write(component, DA7219_MIC_1_CTRL, mic_ctrl);
+	if (ret)
+		return ret;
+
+	return 0;
 }
=20
 static int da7219_mixin_gain_put(struct snd_kcontrol *kcontrol,
@@ -391,7 +427,7 @@ static int da7219_mixin_gain_put(struct snd_kcontrol *k=
control,
 	 * make sure calibrated offsets are updated.
 	 */
 	if ((ret =3D=3D 1) && (da7219->alc_en))
-		da7219_alc_calib(component);
+		ret =3D da7219_alc_calib(component);
=20
 	return ret;
 }
@@ -401,11 +437,14 @@ static int da7219_alc_sw_put(struct snd_kcontrol *kco=
ntrol,
 {
 	struct snd_soc_component *component =3D snd_soc_kcontrol_component(kcontr=
ol);
 	struct da7219_priv *da7219 =3D snd_soc_component_get_drvdata(component);
+	int ret;
=20
=20
 	/* Force ALC offset calibration if enabling ALC */
 	if ((ucontrol->value.integer.value[0]) && (!da7219->alc_en)) {
-		da7219_alc_calib(component);
+		ret =3D da7219_alc_calib(component);
+		if (ret)
+			return ret;
 		da7219->alc_en =3D true;
 	} else {
 		da7219->alc_en =3D false;
@@ -797,7 +836,7 @@ static int da7219_dai_event(struct snd_soc_dapm_widget =
*w,
 {
 	struct snd_soc_component *component =3D snd_soc_dapm_to_component(w->dapm=
);
 	struct da7219_priv *da7219 =3D snd_soc_component_get_drvdata(component);
-	u8 pll_ctrl, pll_status;
+	unsigned int pll_ctrl, pll_status;
 	int i =3D 0, ret;
 	bool srm_lock =3D false;
=20
@@ -813,25 +852,35 @@ static int da7219_dai_event(struct snd_soc_dapm_widge=
t *w,
 					return ret;
 				}
 			} else {
-				snd_soc_component_update_bits(component,
+				ret =3D snd_soc_component_update_bits(component,
 							      DA7219_DAI_CLK_MODE,
 							      DA7219_DAI_CLK_EN_MASK,
 							      DA7219_DAI_CLK_EN_MASK);
+				if (ret < 0)
+					return ret;
 			}
 		}
=20
 		/* PC synchronised to DAI */
-		snd_soc_component_update_bits(component, DA7219_PC_COUNT,
+		ret =3D snd_soc_component_update_bits(component, DA7219_PC_COUNT,
 				    DA7219_PC_FREERUN_MASK, 0);
+		if (ret < 0)
+			return ret;
=20
 		/* Slave mode, if SRM not enabled no need for status checks */
-		pll_ctrl =3D snd_soc_component_read32(component, DA7219_PLL_CTRL);
+		ret =3D snd_soc_component_read(component, DA7219_PLL_CTRL,
+				    &pll_ctrl);
+		if (ret)
+			return ret;
 		if ((pll_ctrl & DA7219_PLL_MODE_MASK) !=3D DA7219_PLL_MODE_SRM)
 			return 0;
=20
 		/* Check SRM has locked */
 		do {
-			pll_status =3D snd_soc_component_read32(component, DA7219_PLL_SRM_STS);
+			ret =3D snd_soc_component_read(component,
+				     DA7219_PLL_SRM_STS, &pll_status);
+			if (ret)
+				return ret;
 			if (pll_status & DA7219_PLL_SRM_STS_SRM_LOCK) {
 				srm_lock =3D true;
 			} else {
@@ -846,19 +895,23 @@ static int da7219_dai_event(struct snd_soc_dapm_widge=
t *w,
 		return 0;
 	case SND_SOC_DAPM_POST_PMD:
 		/* PC free-running */
-		snd_soc_component_update_bits(component, DA7219_PC_COUNT,
+		ret =3D snd_soc_component_update_bits(component, DA7219_PC_COUNT,
 				    DA7219_PC_FREERUN_MASK,
 				    DA7219_PC_FREERUN_MASK);
+		if (ret < 0)
+			return ret;
=20
 		/* Disable DAI clks if in master mode */
 		if (da7219->master) {
 			if (da7219->dai_clks)
 				clk_disable_unprepare(da7219->dai_clks);
 			else
-				snd_soc_component_update_bits(component,
+				ret =3D snd_soc_component_update_bits(component,
 							      DA7219_DAI_CLK_MODE,
 							      DA7219_DAI_CLK_EN_MASK,
 							      0);
+				if (ret < 0)
+					return ret;
 		}
=20
 		return 0;
@@ -887,6 +940,7 @@ static int da7219_mixout_event(struct snd_soc_dapm_widg=
et *w,
 {
 	struct snd_soc_component *component =3D snd_soc_dapm_to_component(w->dapm=
);
 	u8 hp_ctrl, min_gain_mask;
+	int ret;
=20
 	switch (w->reg) {
 	case DA7219_MIXOUT_L_CTRL:
@@ -904,15 +958,20 @@ static int da7219_mixout_event(struct snd_soc_dapm_wi=
dget *w,
 	switch (event) {
 	case SND_SOC_DAPM_PRE_PMD:
 		/* Enable minimum gain on HP to avoid pops */
-		snd_soc_component_update_bits(component, hp_ctrl, min_gain_mask,
-				    min_gain_mask);
+		ret =3D snd_soc_component_update_bits(component, hp_ctrl,
+				    min_gain_mask, min_gain_mask);
+		if (ret < 0)
+			return ret;
=20
 		msleep(DA7219_MIN_GAIN_DELAY);
=20
 		break;
 	case SND_SOC_DAPM_POST_PMU:
 		/* Remove minimum gain on HP */
-		snd_soc_component_update_bits(component, hp_ctrl, min_gain_mask, 0);
+		ret =3D snd_soc_component_update_bits(component, hp_ctrl,
+				    min_gain_mask, 0);
+		if (ret < 0)
+			return ret;
=20
 		break;
 	}
@@ -925,21 +984,30 @@ static int da7219_gain_ramp_event(struct snd_soc_dapm=
_widget *w,
 {
 	struct snd_soc_component *component =3D snd_soc_dapm_to_component(w->dapm=
);
 	struct da7219_priv *da7219 =3D snd_soc_component_get_drvdata(component);
+	int ret;
=20
 	switch (event) {
 	case SND_SOC_DAPM_PRE_PMU:
 	case SND_SOC_DAPM_PRE_PMD:
 		/* Ensure nominal gain ramping for DAPM sequence */
-		da7219->gain_ramp_ctrl =3D
-			snd_soc_component_read32(component, DA7219_GAIN_RAMP_CTRL);
-		snd_soc_component_write(component, DA7219_GAIN_RAMP_CTRL,
-			      DA7219_GAIN_RAMP_RATE_NOMINAL);
+		ret =3D snd_soc_component_read(component,
+				DA7219_GAIN_RAMP_CTRL,
+				&da7219->gain_ramp_ctrl);
+		if (ret)
+			return ret;
+		 ret =3D snd_soc_component_write(component,
+				DA7219_GAIN_RAMP_CTRL,
+				DA7219_GAIN_RAMP_RATE_NOMINAL);
+		if (ret)
+			return ret;
 		break;
 	case SND_SOC_DAPM_POST_PMU:
 	case SND_SOC_DAPM_POST_PMD:
 		/* Restore previous gain ramp settings */
-		snd_soc_component_write(component, DA7219_GAIN_RAMP_CTRL,
+		ret =3D snd_soc_component_write(component, DA7219_GAIN_RAMP_CTRL,
 			      da7219->gain_ramp_ctrl);
+		if (ret)
+			return ret;
 		break;
 	}
=20
@@ -1177,13 +1245,17 @@ static int da7219_set_dai_sysclk(struct snd_soc_dai=
 *codec_dai,
=20
 	switch (clk_id) {
 	case DA7219_CLKSRC_MCLK_SQR:
-		snd_soc_component_update_bits(component, DA7219_PLL_CTRL,
+		ret =3D snd_soc_component_update_bits(component, DA7219_PLL_CTRL,
 				    DA7219_PLL_MCLK_SQR_EN_MASK,
 				    DA7219_PLL_MCLK_SQR_EN_MASK);
+		if (ret < 0)
+			return ret;
 		break;
 	case DA7219_CLKSRC_MCLK:
-		snd_soc_component_update_bits(component, DA7219_PLL_CTRL,
+		ret =3D snd_soc_component_update_bits(component, DA7219_PLL_CTRL,
 				    DA7219_PLL_MCLK_SQR_EN_MASK, 0);
+		if (ret < 0)
+			return ret;
 		break;
 	default:
 		dev_err(codec_dai->dev, "Unknown clock source %d\n", clk_id);
@@ -1219,6 +1291,7 @@ int da7219_set_pll(struct snd_soc_component *componen=
t, int source, unsigned int
 	u8 pll_frac_top, pll_frac_bot, pll_integer;
 	u32 freq_ref;
 	u64 frac_div;
+	int ret;
=20
 	/* Verify 2MHz - 54MHz MCLK provided, and set input divider */
 	if (da7219->mclk_rate < 2000000) {
@@ -1252,9 +1325,11 @@ int da7219_set_pll(struct snd_soc_component *compone=
nt, int source, unsigned int
 	switch (source) {
 	case DA7219_SYSCLK_MCLK:
 		pll_ctrl |=3D DA7219_PLL_MODE_BYPASS;
-		snd_soc_component_update_bits(component, DA7219_PLL_CTRL,
+		ret =3D snd_soc_component_update_bits(component, DA7219_PLL_CTRL,
 				    DA7219_PLL_INDIV_MASK |
 				    DA7219_PLL_MODE_MASK, pll_ctrl);
+		if (ret < 0)
+			return ret;
 		return 0;
 	case DA7219_SYSCLK_PLL:
 		pll_ctrl |=3D DA7219_PLL_MODE_NORMAL;
@@ -1275,12 +1350,23 @@ int da7219_set_pll(struct snd_soc_component *compon=
ent, int source, unsigned int
 	pll_frac_bot =3D (frac_div) & DA7219_BYTE_MASK;
=20
 	/* Write PLL config & dividers */
-	snd_soc_component_write(component, DA7219_PLL_FRAC_TOP, pll_frac_top);
-	snd_soc_component_write(component, DA7219_PLL_FRAC_BOT, pll_frac_bot);
-	snd_soc_component_write(component, DA7219_PLL_INTEGER, pll_integer);
-	snd_soc_component_update_bits(component, DA7219_PLL_CTRL,
+	ret =3D snd_soc_component_write(component, DA7219_PLL_FRAC_TOP,
+				pll_frac_top);
+	if (ret)
+		return ret;
+	ret =3D snd_soc_component_write(component, DA7219_PLL_FRAC_BOT,
+				pll_frac_bot);
+	if (ret)
+		return ret;
+	ret =3D snd_soc_component_write(component, DA7219_PLL_INTEGER,
+				pll_integer);
+	if (ret)
+		return ret;
+	ret =3D snd_soc_component_update_bits(component, DA7219_PLL_CTRL,
 			    DA7219_PLL_INDIV_MASK | DA7219_PLL_MODE_MASK,
 			    pll_ctrl);
+	if (ret < 0)
+		return ret;
=20
 	return 0;
 }
@@ -1304,6 +1390,7 @@ static int da7219_set_dai_fmt(struct snd_soc_dai *cod=
ec_dai, unsigned int fmt)
 	struct snd_soc_component *component =3D codec_dai->component;
 	struct da7219_priv *da7219 =3D snd_soc_component_get_drvdata(component);
 	u8 dai_clk_mode =3D 0, dai_ctrl =3D 0;
+	int ret;
=20
 	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
 	case SND_SOC_DAIFMT_CBM_CFM:
@@ -1379,12 +1466,16 @@ static int da7219_set_dai_fmt(struct snd_soc_dai *c=
odec_dai, unsigned int fmt)
 	/* By default 64 BCLKs per WCLK is supported */
 	dai_clk_mode |=3D DA7219_DAI_BCLKS_PER_WCLK_64;
=20
-	snd_soc_component_update_bits(component, DA7219_DAI_CLK_MODE,
+	ret =3D snd_soc_component_update_bits(component, DA7219_DAI_CLK_MODE,
 			    DA7219_DAI_BCLKS_PER_WCLK_MASK |
 			    DA7219_DAI_CLK_POL_MASK | DA7219_DAI_WCLK_POL_MASK,
 			    dai_clk_mode);
-	snd_soc_component_update_bits(component, DA7219_DAI_CTRL, DA7219_DAI_FORM=
AT_MASK,
-			    dai_ctrl);
+	if (ret < 0)
+		return ret;
+	ret =3D snd_soc_component_update_bits(component, DA7219_DAI_CTRL,
+			    DA7219_DAI_FORMAT_MASK, dai_ctrl);
+	if (ret < 0)
+		return ret;
=20
 	return 0;
 }
@@ -1398,15 +1489,22 @@ static int da7219_set_dai_tdm_slot(struct snd_soc_d=
ai *dai,
 	u8 dai_bclks_per_wclk;
 	u16 offset;
 	u32 frame_size;
+	int ret;
=20
 	/* No channels enabled so disable TDM, revert to 64-bit frames */
 	if (!tx_mask) {
-		snd_soc_component_update_bits(component, DA7219_DAI_TDM_CTRL,
+		ret =3D snd_soc_component_update_bits(component,
+				    DA7219_DAI_TDM_CTRL,
 				    DA7219_DAI_TDM_CH_EN_MASK |
 				    DA7219_DAI_TDM_MODE_EN_MASK, 0);
-		snd_soc_component_update_bits(component, DA7219_DAI_CLK_MODE,
+		if (ret < 0)
+			return ret;
+		ret =3D snd_soc_component_update_bits(component,
+				    DA7219_DAI_CLK_MODE,
 				    DA7219_DAI_BCLKS_PER_WCLK_MASK,
 				    DA7219_DAI_BCLKS_PER_WCLK_64);
+		if (ret < 0)
+			return ret;
 		return 0;
 	}
=20
@@ -1444,19 +1542,25 @@ static int da7219_set_dai_tdm_slot(struct snd_soc_d=
ai *dai,
 		return -EINVAL;
 	}
=20
-	snd_soc_component_update_bits(component, DA7219_DAI_CLK_MODE,
+	ret =3D snd_soc_component_update_bits(component, DA7219_DAI_CLK_MODE,
 			    DA7219_DAI_BCLKS_PER_WCLK_MASK,
 			    dai_bclks_per_wclk);
+	if (ret < 0)
+		return ret;
=20
 	offset =3D cpu_to_le16(rx_mask);
-	regmap_bulk_write(da7219->regmap, DA7219_DAI_OFFSET_LOWER,
+	ret =3D regmap_bulk_write(da7219->regmap, DA7219_DAI_OFFSET_LOWER,
 			  &offset, sizeof(offset));
+	if (ret)
+		return ret;
=20
-	snd_soc_component_update_bits(component, DA7219_DAI_TDM_CTRL,
+	ret =3D snd_soc_component_update_bits(component, DA7219_DAI_TDM_CTRL,
 			    DA7219_DAI_TDM_CH_EN_MASK |
 			    DA7219_DAI_TDM_MODE_EN_MASK,
 			    (tx_mask << DA7219_DAI_TDM_CH_EN_SHIFT) |
 			    DA7219_DAI_TDM_MODE_EN_MASK);
+	if (ret < 0)
+		return ret;
=20
 	return 0;
 }
@@ -1468,6 +1572,7 @@ static int da7219_hw_params(struct snd_pcm_substream =
*substream,
 	struct snd_soc_component *component =3D dai->component;
 	u8 dai_ctrl =3D 0, fs;
 	unsigned int channels;
+	int ret;
=20
 	switch (params_width(params)) {
 	case 16:
@@ -1533,11 +1638,15 @@ static int da7219_hw_params(struct snd_pcm_substrea=
m *substream,
 		return -EINVAL;
 	}
=20
-	snd_soc_component_update_bits(component, DA7219_DAI_CTRL,
+	ret =3D snd_soc_component_update_bits(component, DA7219_DAI_CTRL,
 			    DA7219_DAI_WORD_LENGTH_MASK |
 			    DA7219_DAI_CH_NUM_MASK,
 			    dai_ctrl);
-	snd_soc_component_write(component, DA7219_SR, fs);
+	if (ret < 0)
+		return ret;
+	ret =3D snd_soc_component_write(component, DA7219_SR, fs);
+	if (ret)
+		return ret;
=20
 	return 0;
 }
@@ -1692,9 +1801,12 @@ static int da7219_set_bias_level(struct snd_soc_comp=
onent *component,
 	case SND_SOC_BIAS_STANDBY:
 		if (snd_soc_component_get_bias_level(component) =3D=3D SND_SOC_BIAS_OFF)
 			/* Master bias */
-			snd_soc_component_update_bits(component, DA7219_REFERENCES,
+			ret =3D snd_soc_component_update_bits(component,
+					    DA7219_REFERENCES,
 					    DA7219_BIAS_EN_MASK,
 					    DA7219_BIAS_EN_MASK);
+			if (ret < 0)
+				return ret;
=20
 		if (snd_soc_component_get_bias_level(component) =3D=3D SND_SOC_BIAS_PREP=
ARE) {
 			/* Remove MCLK */
@@ -1705,8 +1817,11 @@ static int da7219_set_bias_level(struct snd_soc_comp=
onent *component,
 	case SND_SOC_BIAS_OFF:
 		/* Only disable master bias if we're not a wake-up source */
 		if (!da7219->wakeup_source)
-			snd_soc_component_update_bits(component, DA7219_REFERENCES,
+			ret =3D snd_soc_component_update_bits(component,
+					    DA7219_REFERENCES,
 					    DA7219_BIAS_EN_MASK, 0);
+			if (ret < 0)
+				return ret;
=20
 		break;
 	}
@@ -1754,10 +1869,16 @@ static int da7219_handle_supplies(struct snd_soc_co=
mponent *component)
 	}
=20
 	/* Ensure device in active mode */
-	snd_soc_component_write(component, DA7219_SYSTEM_ACTIVE, DA7219_SYSTEM_AC=
TIVE_MASK);
+	ret =3D snd_soc_component_write(component, DA7219_SYSTEM_ACTIVE,
+				DA7219_SYSTEM_ACTIVE_MASK);
+	if (ret)
+		return ret;
=20
 	/* Update IO voltage level range */
-	snd_soc_component_write(component, DA7219_IO_CTRL, io_voltage_lvl);
+	ret =3D snd_soc_component_write(component, DA7219_IO_CTRL,
+				io_voltage_lvl);
+	if (ret)
+		return ret;
=20
 	return 0;
 }
@@ -1768,10 +1889,13 @@ static int da7219_dai_clks_prepare(struct clk_hw *h=
w)
 	struct da7219_priv *da7219 =3D
 		container_of(hw, struct da7219_priv, dai_clks_hw);
 	struct snd_soc_component *component =3D da7219->aad->component;
+	int ret;
=20
-	snd_soc_component_update_bits(component, DA7219_DAI_CLK_MODE,
+	ret =3D snd_soc_component_update_bits(component, DA7219_DAI_CLK_MODE,
 				      DA7219_DAI_CLK_EN_MASK,
 				      DA7219_DAI_CLK_EN_MASK);
+	if (ret < 0)
+		return ret;
=20
 	return 0;
 }
@@ -1781,9 +1905,12 @@ static void da7219_dai_clks_unprepare(struct clk_hw =
*hw)
 	struct da7219_priv *da7219 =3D
 		container_of(hw, struct da7219_priv, dai_clks_hw);
 	struct snd_soc_component *component =3D da7219->aad->component;
+	int ret;
=20
-	snd_soc_component_update_bits(component, DA7219_DAI_CLK_MODE,
+	ret =3D snd_soc_component_update_bits(component, DA7219_DAI_CLK_MODE,
 				      DA7219_DAI_CLK_EN_MASK, 0);
+	if (ret < 0)
+		dev_err(component->dev, "Failed to disable clk: %d\n", ret);
 }
=20
 static int da7219_dai_clks_is_prepared(struct clk_hw *hw)
@@ -1791,9 +1918,12 @@ static int da7219_dai_clks_is_prepared(struct clk_hw=
 *hw)
 	struct da7219_priv *da7219 =3D
 		container_of(hw, struct da7219_priv, dai_clks_hw);
 	struct snd_soc_component *component =3D da7219->aad->component;
-	u8 clk_reg;
+	unsigned int clk_reg;
+	int ret;
=20
-	clk_reg =3D snd_soc_component_read32(component, DA7219_DAI_CLK_MODE);
+	ret =3D snd_soc_component_read(component, DA7219_DAI_CLK_MODE, &clk_reg);
+	if (ret)
+		return ret;
=20
 	return !!(clk_reg & DA7219_DAI_CLK_EN_MASK);
 }
@@ -1844,10 +1974,11 @@ static void da7219_register_dai_clks(struct snd_soc=
_component *component)
 static inline void da7219_register_dai_clks(struct snd_soc_component *comp=
onent) {}
 #endif /* CONFIG_COMMON_CLK */
=20
-static void da7219_handle_pdata(struct snd_soc_component *component)
+static int da7219_handle_pdata(struct snd_soc_component *component)
 {
 	struct da7219_priv *da7219 =3D snd_soc_component_get_drvdata(component);
 	struct da7219_pdata *pdata =3D da7219->pdata;
+	int ret;
=20
 	if (pdata) {
 		u8 micbias_lvl =3D 0;
@@ -1869,7 +2000,10 @@ static void da7219_handle_pdata(struct snd_soc_compo=
nent *component)
 			break;
 		}
=20
-		snd_soc_component_write(component, DA7219_MICBIAS_CTRL, micbias_lvl);
+		ret =3D snd_soc_component_write(component, DA7219_MICBIAS_CTRL,
+					micbias_lvl);
+		if (ret)
+			return ret;
=20
 		/*
 		 * Calculate delay required to compensate for DC offset in
@@ -1884,11 +2018,15 @@ static void da7219_handle_pdata(struct snd_soc_comp=
onent *component)
 		case DA7219_MIC_AMP_IN_SEL_DIFF:
 		case DA7219_MIC_AMP_IN_SEL_SE_P:
 		case DA7219_MIC_AMP_IN_SEL_SE_N:
-			snd_soc_component_write(component, DA7219_MIC_1_SELECT,
-				      pdata->mic_amp_in_sel);
+			ret =3D snd_soc_component_write(component,
+					DA7219_MIC_1_SELECT,
+					pdata->mic_amp_in_sel);
+			if (ret)
+				return ret;
 			break;
 		}
 	}
+	return 0;
 }
=20
 static struct reg_sequence da7219_rev_aa_patch[] =3D {
@@ -1934,7 +2072,9 @@ static int da7219_probe(struct snd_soc_component *com=
ponent)
 	if (!da7219->pdata)
 		da7219->pdata =3D da7219_fw_to_pdata(component);
=20
-	da7219_handle_pdata(component);
+	ret =3D da7219_handle_pdata(component);
+	if (ret)
+		return ret;
=20
 	/* Check if MCLK provided */
 	da7219->mclk =3D devm_clk_get(component->dev, "mclk");
@@ -1948,36 +2088,57 @@ static int da7219_probe(struct snd_soc_component *c=
omponent)
 	}
=20
 	/* Default PC counter to free-running */
-	snd_soc_component_update_bits(component, DA7219_PC_COUNT, DA7219_PC_FREER=
UN_MASK,
-			    DA7219_PC_FREERUN_MASK);
+	ret =3D snd_soc_component_update_bits(component, DA7219_PC_COUNT,
+			DA7219_PC_FREERUN_MASK, DA7219_PC_FREERUN_MASK);
+	if (ret < 0)
+		return ret;
=20
 	/* Default gain ramping */
-	snd_soc_component_update_bits(component, DA7219_MIXIN_L_CTRL,
+	ret =3D snd_soc_component_update_bits(component, DA7219_MIXIN_L_CTRL,
 			    DA7219_MIXIN_L_AMP_RAMP_EN_MASK,
 			    DA7219_MIXIN_L_AMP_RAMP_EN_MASK);
-	snd_soc_component_update_bits(component, DA7219_ADC_L_CTRL, DA7219_ADC_L_=
RAMP_EN_MASK,
-			    DA7219_ADC_L_RAMP_EN_MASK);
-	snd_soc_component_update_bits(component, DA7219_DAC_L_CTRL, DA7219_DAC_L_=
RAMP_EN_MASK,
-			    DA7219_DAC_L_RAMP_EN_MASK);
-	snd_soc_component_update_bits(component, DA7219_DAC_R_CTRL, DA7219_DAC_R_=
RAMP_EN_MASK,
-			    DA7219_DAC_R_RAMP_EN_MASK);
-	snd_soc_component_update_bits(component, DA7219_HP_L_CTRL,
+	if (ret < 0)
+		return ret;
+	ret =3D snd_soc_component_update_bits(component, DA7219_ADC_L_CTRL,
+			DA7219_ADC_L_RAMP_EN_MASK, DA7219_ADC_L_RAMP_EN_MASK);
+	if (ret < 0)
+		return ret;
+	ret =3D snd_soc_component_update_bits(component, DA7219_DAC_L_CTRL,
+			DA7219_DAC_L_RAMP_EN_MASK, DA7219_DAC_L_RAMP_EN_MASK);
+	if (ret < 0)
+		return ret;
+	ret =3D snd_soc_component_update_bits(component, DA7219_DAC_R_CTRL,
+			DA7219_DAC_R_RAMP_EN_MASK, DA7219_DAC_R_RAMP_EN_MASK);
+	if (ret < 0)
+		return ret;
+	ret =3D snd_soc_component_update_bits(component, DA7219_HP_L_CTRL,
 			    DA7219_HP_L_AMP_RAMP_EN_MASK,
 			    DA7219_HP_L_AMP_RAMP_EN_MASK);
-	snd_soc_component_update_bits(component, DA7219_HP_R_CTRL,
+	if (ret < 0)
+		return ret;
+	ret =3D snd_soc_component_update_bits(component, DA7219_HP_R_CTRL,
 			    DA7219_HP_R_AMP_RAMP_EN_MASK,
 			    DA7219_HP_R_AMP_RAMP_EN_MASK);
+	if (ret < 0)
+		return ret;
=20
 	/* Default minimum gain on HP to avoid pops during DAPM sequencing */
-	snd_soc_component_update_bits(component, DA7219_HP_L_CTRL,
+	ret =3D snd_soc_component_update_bits(component, DA7219_HP_L_CTRL,
 			    DA7219_HP_L_AMP_MIN_GAIN_EN_MASK,
 			    DA7219_HP_L_AMP_MIN_GAIN_EN_MASK);
-	snd_soc_component_update_bits(component, DA7219_HP_R_CTRL,
+	if (ret < 0)
+		return ret;
+	ret =3D snd_soc_component_update_bits(component, DA7219_HP_R_CTRL,
 			    DA7219_HP_R_AMP_MIN_GAIN_EN_MASK,
 			    DA7219_HP_R_AMP_MIN_GAIN_EN_MASK);
+	if (ret < 0)
+		return ret;
=20
 	/* Default infinite tone gen, start/stop by Kcontrol */
-	snd_soc_component_write(component, DA7219_TONE_GEN_CYCLES, DA7219_BEEP_CY=
CLES_MASK);
+	ret =3D snd_soc_component_write(component, DA7219_TONE_GEN_CYCLES,
+			DA7219_BEEP_CYCLES_MASK);
+	if (ret)
+		return ret;
=20
 	/* Initialise AAD block */
 	ret =3D da7219_aad_init(component);
@@ -2221,16 +2382,28 @@ static int da7219_i2c_probe(struct i2c_client *i2c,
 	regcache_cache_bypass(da7219->regmap, true);
=20
 	/* Disable audio paths if still active from previous start */
-	regmap_read(da7219->regmap, DA7219_SYSTEM_ACTIVE, &system_active);
+	ret =3D regmap_read(da7219->regmap, DA7219_SYSTEM_ACTIVE, &system_active)=
;
+	if (ret)
+		return ret;
 	if (system_active) {
-		regmap_write(da7219->regmap, DA7219_GAIN_RAMP_CTRL,
+		ret =3D regmap_write(da7219->regmap, DA7219_GAIN_RAMP_CTRL,
 			     DA7219_GAIN_RAMP_RATE_NOMINAL);
-		regmap_write(da7219->regmap, DA7219_SYSTEM_MODES_INPUT, 0x00);
-		regmap_write(da7219->regmap, DA7219_SYSTEM_MODES_OUTPUT, 0x01);
+		if (ret)
+			return ret;
+		ret =3D regmap_write(da7219->regmap, DA7219_SYSTEM_MODES_INPUT,
+				0x00);
+		if (ret)
+			return ret;
+		ret =3D regmap_write(da7219->regmap, DA7219_SYSTEM_MODES_OUTPUT,
+				0x01);
+		if (ret)
+			return ret;
=20
 		for (i =3D 0; i < DA7219_SYS_STAT_CHECK_RETRIES; ++i) {
-			regmap_read(da7219->regmap, DA7219_SYSTEM_STATUS,
+			ret =3D regmap_read(da7219->regmap, DA7219_SYSTEM_STATUS,
 				    &system_status);
+			if (ret)
+				return ret;
 			if (!system_status)
 				break;
=20
@@ -2239,13 +2412,19 @@ static int da7219_i2c_probe(struct i2c_client *i2c,
 	}
=20
 	/* Soft reset component */
-	regmap_write_bits(da7219->regmap, DA7219_ACCDET_CONFIG_1,
+	ret =3D regmap_write_bits(da7219->regmap, DA7219_ACCDET_CONFIG_1,
 			  DA7219_ACCDET_EN_MASK, 0);
-	regmap_write_bits(da7219->regmap, DA7219_CIF_CTRL,
+	if (ret)
+		return ret;
+	ret =3D regmap_write_bits(da7219->regmap, DA7219_CIF_CTRL,
 			  DA7219_CIF_REG_SOFT_RESET_MASK,
 			  DA7219_CIF_REG_SOFT_RESET_MASK);
-	regmap_write_bits(da7219->regmap, DA7219_SYSTEM_ACTIVE,
+	if (ret)
+		return ret;
+	ret =3D regmap_write_bits(da7219->regmap, DA7219_SYSTEM_ACTIVE,
 			  DA7219_SYSTEM_ACTIVE_MASK, 0);
+	if (ret)
+		return ret;
=20
 	regcache_cache_bypass(da7219->regmap, false);
=20
diff --git a/sound/soc/codecs/da7219.h b/sound/soc/codecs/da7219.h
index 3a00686..78d2194 100644
--- a/sound/soc/codecs/da7219.h
+++ b/sound/soc/codecs/da7219.h
@@ -832,7 +832,7 @@ struct da7219_priv {
 	bool alc_en;
 	bool micbias_on_event;
 	unsigned int mic_pga_delay;
-	u8 gain_ramp_ctrl;
+	unsigned int gain_ramp_ctrl;
 };
=20
 int da7219_set_pll(struct snd_soc_component *component, int source, unsign=
ed int fout);
--=20
1.9.1
