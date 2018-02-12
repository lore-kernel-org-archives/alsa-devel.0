From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: tlv320dac33: replace codec to
	component" to the asoc tree
Date: Mon, 12 Feb 2018 12:39:57 +0000
Message-ID: <E1elDOn-0004cr-Du@debutante>
References: <871si9z4jc.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 5ACFC26765F
 for <alsa-devel@alsa-project.org>; Mon, 12 Feb 2018 13:40:02 +0100 (CET)
In-Reply-To: <871si9z4jc.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: tlv320dac33: replace codec to component

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

>From cd21ac8c161ac2a88422387298b30e33ab29012c Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 29 Jan 2018 04:14:21 +0000
Subject: [PATCH] ASoC: tlv320dac33: replace codec to component

Now we can replace Codec to Component. Let's do it.

Note:
	xxx_codec_xxx()		->	xxx_component_xxx()
	.idle_bias_off = 1	->	.idle_bias_on = 0
	.ignore_pmdown_time = 0	->	.use_pmdown_time = 1
	-			->	.endianness = 1
	-			->	.non_legacy_dai_naming = 1

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/tlv320dac33.c | 402 ++++++++++++++++++++---------------------
 1 file changed, 199 insertions(+), 203 deletions(-)

diff --git a/sound/soc/codecs/tlv320dac33.c b/sound/soc/codecs/tlv320dac33.c
index 8c71d2f876ff..a957eaeb7bc1 100644
--- a/sound/soc/codecs/tlv320dac33.c
+++ b/sound/soc/codecs/tlv320dac33.c
@@ -63,9 +63,9 @@
 	(((samples)*5000) / (((burstrate)*5000) / ((burstrate) - (playrate))))
 
 static void dac33_calculate_times(struct snd_pcm_substream *substream,
-				  struct snd_soc_codec *codec);
+				  struct snd_soc_component *component);
 static int dac33_prepare_chip(struct snd_pcm_substream *substream,
-			      struct snd_soc_codec *codec);
+			      struct snd_soc_component *component);
 
 enum dac33_state {
 	DAC33_IDLE = 0,
@@ -91,7 +91,7 @@ static const char *dac33_supply_names[DAC33_NUM_SUPPLIES] = {
 struct tlv320dac33_priv {
 	struct mutex mutex;
 	struct work_struct work;
-	struct snd_soc_codec *codec;
+	struct snd_soc_component *component;
 	struct regulator_bulk_data supplies[DAC33_NUM_SUPPLIES];
 	struct snd_pcm_substream *substream;
 	int power_gpio;
@@ -171,10 +171,10 @@ static const u8 dac33_reg[DAC33_CACHEREGNUM] = {
 };
 
 /* Register read and write */
-static inline unsigned int dac33_read_reg_cache(struct snd_soc_codec *codec,
+static inline unsigned int dac33_read_reg_cache(struct snd_soc_component *component,
 						unsigned reg)
 {
-	struct tlv320dac33_priv *dac33 = snd_soc_codec_get_drvdata(codec);
+	struct tlv320dac33_priv *dac33 = snd_soc_component_get_drvdata(component);
 	u8 *cache = dac33->reg_cache;
 	if (reg >= DAC33_CACHEREGNUM)
 		return 0;
@@ -182,10 +182,10 @@ static inline unsigned int dac33_read_reg_cache(struct snd_soc_codec *codec,
 	return cache[reg];
 }
 
-static inline void dac33_write_reg_cache(struct snd_soc_codec *codec,
+static inline void dac33_write_reg_cache(struct snd_soc_component *component,
 					 u8 reg, u8 value)
 {
-	struct tlv320dac33_priv *dac33 = snd_soc_codec_get_drvdata(codec);
+	struct tlv320dac33_priv *dac33 = snd_soc_component_get_drvdata(component);
 	u8 *cache = dac33->reg_cache;
 	if (reg >= DAC33_CACHEREGNUM)
 		return;
@@ -193,10 +193,10 @@ static inline void dac33_write_reg_cache(struct snd_soc_codec *codec,
 	cache[reg] = value;
 }
 
-static int dac33_read(struct snd_soc_codec *codec, unsigned int reg,
+static int dac33_read(struct snd_soc_component *component, unsigned int reg,
 		      u8 *value)
 {
-	struct tlv320dac33_priv *dac33 = snd_soc_codec_get_drvdata(codec);
+	struct tlv320dac33_priv *dac33 = snd_soc_component_get_drvdata(component);
 	int val, ret = 0;
 
 	*value = reg & 0xff;
@@ -205,24 +205,24 @@ static int dac33_read(struct snd_soc_codec *codec, unsigned int reg,
 	if (dac33->chip_power) {
 		val = i2c_smbus_read_byte_data(dac33->i2c, value[0]);
 		if (val < 0) {
-			dev_err(codec->dev, "Read failed (%d)\n", val);
-			value[0] = dac33_read_reg_cache(codec, reg);
+			dev_err(component->dev, "Read failed (%d)\n", val);
+			value[0] = dac33_read_reg_cache(component, reg);
 			ret = val;
 		} else {
 			value[0] = val;
-			dac33_write_reg_cache(codec, reg, val);
+			dac33_write_reg_cache(component, reg, val);
 		}
 	} else {
-		value[0] = dac33_read_reg_cache(codec, reg);
+		value[0] = dac33_read_reg_cache(component, reg);
 	}
 
 	return ret;
 }
 
-static int dac33_write(struct snd_soc_codec *codec, unsigned int reg,
+static int dac33_write(struct snd_soc_component *component, unsigned int reg,
 		       unsigned int value)
 {
-	struct tlv320dac33_priv *dac33 = snd_soc_codec_get_drvdata(codec);
+	struct tlv320dac33_priv *dac33 = snd_soc_component_get_drvdata(component);
 	u8 data[2];
 	int ret = 0;
 
@@ -234,11 +234,11 @@ static int dac33_write(struct snd_soc_codec *codec, unsigned int reg,
 	data[0] = reg & 0xff;
 	data[1] = value & 0xff;
 
-	dac33_write_reg_cache(codec, data[0], data[1]);
+	dac33_write_reg_cache(component, data[0], data[1]);
 	if (dac33->chip_power) {
 		ret = i2c_master_send(dac33->i2c, data, 2);
 		if (ret != 2)
-			dev_err(codec->dev, "Write failed (%d)\n", ret);
+			dev_err(component->dev, "Write failed (%d)\n", ret);
 		else
 			ret = 0;
 	}
@@ -246,24 +246,24 @@ static int dac33_write(struct snd_soc_codec *codec, unsigned int reg,
 	return ret;
 }
 
-static int dac33_write_locked(struct snd_soc_codec *codec, unsigned int reg,
+static int dac33_write_locked(struct snd_soc_component *component, unsigned int reg,
 			      unsigned int value)
 {
-	struct tlv320dac33_priv *dac33 = snd_soc_codec_get_drvdata(codec);
+	struct tlv320dac33_priv *dac33 = snd_soc_component_get_drvdata(component);
 	int ret;
 
 	mutex_lock(&dac33->mutex);
-	ret = dac33_write(codec, reg, value);
+	ret = dac33_write(component, reg, value);
 	mutex_unlock(&dac33->mutex);
 
 	return ret;
 }
 
 #define DAC33_I2C_ADDR_AUTOINC	0x80
-static int dac33_write16(struct snd_soc_codec *codec, unsigned int reg,
+static int dac33_write16(struct snd_soc_component *component, unsigned int reg,
 		       unsigned int value)
 {
-	struct tlv320dac33_priv *dac33 = snd_soc_codec_get_drvdata(codec);
+	struct tlv320dac33_priv *dac33 = snd_soc_component_get_drvdata(component);
 	u8 data[3];
 	int ret = 0;
 
@@ -277,15 +277,15 @@ static int dac33_write16(struct snd_soc_codec *codec, unsigned int reg,
 	data[1] = (value >> 8) & 0xff;
 	data[2] = value & 0xff;
 
-	dac33_write_reg_cache(codec, data[0], data[1]);
-	dac33_write_reg_cache(codec, data[0] + 1, data[2]);
+	dac33_write_reg_cache(component, data[0], data[1]);
+	dac33_write_reg_cache(component, data[0] + 1, data[2]);
 
 	if (dac33->chip_power) {
 		/* We need to set autoincrement mode for 16 bit writes */
 		data[0] |= DAC33_I2C_ADDR_AUTOINC;
 		ret = i2c_master_send(dac33->i2c, data, 3);
 		if (ret != 3)
-			dev_err(codec->dev, "Write failed (%d)\n", ret);
+			dev_err(component->dev, "Write failed (%d)\n", ret);
 		else
 			ret = 0;
 	}
@@ -293,52 +293,52 @@ static int dac33_write16(struct snd_soc_codec *codec, unsigned int reg,
 	return ret;
 }
 
-static void dac33_init_chip(struct snd_soc_codec *codec)
+static void dac33_init_chip(struct snd_soc_component *component)
 {
-	struct tlv320dac33_priv *dac33 = snd_soc_codec_get_drvdata(codec);
+	struct tlv320dac33_priv *dac33 = snd_soc_component_get_drvdata(component);
 
 	if (unlikely(!dac33->chip_power))
 		return;
 
 	/* A : DAC sample rate Fsref/1.5 */
-	dac33_write(codec, DAC33_DAC_CTRL_A, DAC33_DACRATE(0));
+	dac33_write(component, DAC33_DAC_CTRL_A, DAC33_DACRATE(0));
 	/* B : DAC src=normal, not muted */
-	dac33_write(codec, DAC33_DAC_CTRL_B, DAC33_DACSRCR_RIGHT |
+	dac33_write(component, DAC33_DAC_CTRL_B, DAC33_DACSRCR_RIGHT |
 					     DAC33_DACSRCL_LEFT);
 	/* C : (defaults) */
-	dac33_write(codec, DAC33_DAC_CTRL_C, 0x00);
+	dac33_write(component, DAC33_DAC_CTRL_C, 0x00);
 
 	/* 73 : volume soft stepping control,
 	 clock source = internal osc (?) */
-	dac33_write(codec, DAC33_ANA_VOL_SOFT_STEP_CTRL, DAC33_VOLCLKEN);
+	dac33_write(component, DAC33_ANA_VOL_SOFT_STEP_CTRL, DAC33_VOLCLKEN);
 
 	/* Restore only selected registers (gains mostly) */
-	dac33_write(codec, DAC33_LDAC_DIG_VOL_CTRL,
-		    dac33_read_reg_cache(codec, DAC33_LDAC_DIG_VOL_CTRL));
-	dac33_write(codec, DAC33_RDAC_DIG_VOL_CTRL,
-		    dac33_read_reg_cache(codec, DAC33_RDAC_DIG_VOL_CTRL));
-
-	dac33_write(codec, DAC33_LINEL_TO_LLO_VOL,
-		    dac33_read_reg_cache(codec, DAC33_LINEL_TO_LLO_VOL));
-	dac33_write(codec, DAC33_LINER_TO_RLO_VOL,
-		    dac33_read_reg_cache(codec, DAC33_LINER_TO_RLO_VOL));
-
-	dac33_write(codec, DAC33_OUT_AMP_CTRL,
-		    dac33_read_reg_cache(codec, DAC33_OUT_AMP_CTRL));
-
-	dac33_write(codec, DAC33_LDAC_PWR_CTRL,
-		    dac33_read_reg_cache(codec, DAC33_LDAC_PWR_CTRL));
-	dac33_write(codec, DAC33_RDAC_PWR_CTRL,
-		    dac33_read_reg_cache(codec, DAC33_RDAC_PWR_CTRL));
+	dac33_write(component, DAC33_LDAC_DIG_VOL_CTRL,
+		    dac33_read_reg_cache(component, DAC33_LDAC_DIG_VOL_CTRL));
+	dac33_write(component, DAC33_RDAC_DIG_VOL_CTRL,
+		    dac33_read_reg_cache(component, DAC33_RDAC_DIG_VOL_CTRL));
+
+	dac33_write(component, DAC33_LINEL_TO_LLO_VOL,
+		    dac33_read_reg_cache(component, DAC33_LINEL_TO_LLO_VOL));
+	dac33_write(component, DAC33_LINER_TO_RLO_VOL,
+		    dac33_read_reg_cache(component, DAC33_LINER_TO_RLO_VOL));
+
+	dac33_write(component, DAC33_OUT_AMP_CTRL,
+		    dac33_read_reg_cache(component, DAC33_OUT_AMP_CTRL));
+
+	dac33_write(component, DAC33_LDAC_PWR_CTRL,
+		    dac33_read_reg_cache(component, DAC33_LDAC_PWR_CTRL));
+	dac33_write(component, DAC33_RDAC_PWR_CTRL,
+		    dac33_read_reg_cache(component, DAC33_RDAC_PWR_CTRL));
 }
 
-static inline int dac33_read_id(struct snd_soc_codec *codec)
+static inline int dac33_read_id(struct snd_soc_component *component)
 {
 	int i, ret = 0;
 	u8 reg;
 
 	for (i = 0; i < 3; i++) {
-		ret = dac33_read(codec, DAC33_DEVICE_ID_MSB + i, &reg);
+		ret = dac33_read(component, DAC33_DEVICE_ID_MSB + i, &reg);
 		if (ret < 0)
 			break;
 	}
@@ -346,44 +346,44 @@ static inline int dac33_read_id(struct snd_soc_codec *codec)
 	return ret;
 }
 
-static inline void dac33_soft_power(struct snd_soc_codec *codec, int power)
+static inline void dac33_soft_power(struct snd_soc_component *component, int power)
 {
 	u8 reg;
 
-	reg = dac33_read_reg_cache(codec, DAC33_PWR_CTRL);
+	reg = dac33_read_reg_cache(component, DAC33_PWR_CTRL);
 	if (power)
 		reg |= DAC33_PDNALLB;
 	else
 		reg &= ~(DAC33_PDNALLB | DAC33_OSCPDNB |
 			 DAC33_DACRPDNB | DAC33_DACLPDNB);
-	dac33_write(codec, DAC33_PWR_CTRL, reg);
+	dac33_write(component, DAC33_PWR_CTRL, reg);
 }
 
-static inline void dac33_disable_digital(struct snd_soc_codec *codec)
+static inline void dac33_disable_digital(struct snd_soc_component *component)
 {
 	u8 reg;
 
 	/* Stop the DAI clock */
-	reg = dac33_read_reg_cache(codec, DAC33_SER_AUDIOIF_CTRL_B);
+	reg = dac33_read_reg_cache(component, DAC33_SER_AUDIOIF_CTRL_B);
 	reg &= ~DAC33_BCLKON;
-	dac33_write(codec, DAC33_SER_AUDIOIF_CTRL_B, reg);
+	dac33_write(component, DAC33_SER_AUDIOIF_CTRL_B, reg);
 
 	/* Power down the Oscillator, and DACs */
-	reg = dac33_read_reg_cache(codec, DAC33_PWR_CTRL);
+	reg = dac33_read_reg_cache(component, DAC33_PWR_CTRL);
 	reg &= ~(DAC33_OSCPDNB | DAC33_DACRPDNB | DAC33_DACLPDNB);
-	dac33_write(codec, DAC33_PWR_CTRL, reg);
+	dac33_write(component, DAC33_PWR_CTRL, reg);
 }
 
-static int dac33_hard_power(struct snd_soc_codec *codec, int power)
+static int dac33_hard_power(struct snd_soc_component *component, int power)
 {
-	struct tlv320dac33_priv *dac33 = snd_soc_codec_get_drvdata(codec);
+	struct tlv320dac33_priv *dac33 = snd_soc_component_get_drvdata(component);
 	int ret = 0;
 
 	mutex_lock(&dac33->mutex);
 
 	/* Safety check */
 	if (unlikely(power == dac33->chip_power)) {
-		dev_dbg(codec->dev, "Trying to set the same power state: %s\n",
+		dev_dbg(component->dev, "Trying to set the same power state: %s\n",
 			power ? "ON" : "OFF");
 		goto exit;
 	}
@@ -392,7 +392,7 @@ static int dac33_hard_power(struct snd_soc_codec *codec, int power)
 		ret = regulator_bulk_enable(ARRAY_SIZE(dac33->supplies),
 					  dac33->supplies);
 		if (ret != 0) {
-			dev_err(codec->dev,
+			dev_err(component->dev,
 				"Failed to enable supplies: %d\n", ret);
 				goto exit;
 		}
@@ -402,14 +402,14 @@ static int dac33_hard_power(struct snd_soc_codec *codec, int power)
 
 		dac33->chip_power = 1;
 	} else {
-		dac33_soft_power(codec, 0);
+		dac33_soft_power(component, 0);
 		if (dac33->power_gpio >= 0)
 			gpio_set_value(dac33->power_gpio, 0);
 
 		ret = regulator_bulk_disable(ARRAY_SIZE(dac33->supplies),
 					     dac33->supplies);
 		if (ret != 0) {
-			dev_err(codec->dev,
+			dev_err(component->dev,
 				"Failed to disable supplies: %d\n", ret);
 			goto exit;
 		}
@@ -425,18 +425,18 @@ static int dac33_hard_power(struct snd_soc_codec *codec, int power)
 static int dac33_playback_event(struct snd_soc_dapm_widget *w,
 		struct snd_kcontrol *kcontrol, int event)
 {
-	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
-	struct tlv320dac33_priv *dac33 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
+	struct tlv320dac33_priv *dac33 = snd_soc_component_get_drvdata(component);
 
 	switch (event) {
 	case SND_SOC_DAPM_PRE_PMU:
 		if (likely(dac33->substream)) {
-			dac33_calculate_times(dac33->substream, codec);
-			dac33_prepare_chip(dac33->substream, codec);
+			dac33_calculate_times(dac33->substream, component);
+			dac33_prepare_chip(dac33->substream, component);
 		}
 		break;
 	case SND_SOC_DAPM_POST_PMD:
-		dac33_disable_digital(codec);
+		dac33_disable_digital(component);
 		break;
 	}
 	return 0;
@@ -445,8 +445,8 @@ static int dac33_playback_event(struct snd_soc_dapm_widget *w,
 static int dac33_get_fifo_mode(struct snd_kcontrol *kcontrol,
 			 struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
-	struct tlv320dac33_priv *dac33 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
+	struct tlv320dac33_priv *dac33 = snd_soc_component_get_drvdata(component);
 
 	ucontrol->value.enumerated.item[0] = dac33->fifo_mode;
 
@@ -456,14 +456,14 @@ static int dac33_get_fifo_mode(struct snd_kcontrol *kcontrol,
 static int dac33_set_fifo_mode(struct snd_kcontrol *kcontrol,
 			 struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
-	struct tlv320dac33_priv *dac33 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
+	struct tlv320dac33_priv *dac33 = snd_soc_component_get_drvdata(component);
 	int ret = 0;
 
 	if (dac33->fifo_mode == ucontrol->value.enumerated.item[0])
 		return 0;
 	/* Do not allow changes while stream is running*/
-	if (snd_soc_codec_is_active(codec))
+	if (snd_soc_component_is_active(component))
 		return -EPERM;
 
 	if (ucontrol->value.enumerated.item[0] >= DAC33_FIFO_LAST_MODE)
@@ -623,7 +623,7 @@ static const struct snd_soc_dapm_route audio_map[] = {
 	{"RIGHT_LO", NULL, "Codec Power"},
 };
 
-static int dac33_set_bias_level(struct snd_soc_codec *codec,
+static int dac33_set_bias_level(struct snd_soc_component *component,
 				enum snd_soc_bias_level level)
 {
 	int ret;
@@ -634,20 +634,20 @@ static int dac33_set_bias_level(struct snd_soc_codec *codec,
 	case SND_SOC_BIAS_PREPARE:
 		break;
 	case SND_SOC_BIAS_STANDBY:
-		if (snd_soc_codec_get_bias_level(codec) == SND_SOC_BIAS_OFF) {
-			/* Coming from OFF, switch on the codec */
-			ret = dac33_hard_power(codec, 1);
+		if (snd_soc_component_get_bias_level(component) == SND_SOC_BIAS_OFF) {
+			/* Coming from OFF, switch on the component */
+			ret = dac33_hard_power(component, 1);
 			if (ret != 0)
 				return ret;
 
-			dac33_init_chip(codec);
+			dac33_init_chip(component);
 		}
 		break;
 	case SND_SOC_BIAS_OFF:
-		/* Do not power off, when the codec is already off */
-		if (snd_soc_codec_get_bias_level(codec) == SND_SOC_BIAS_OFF)
+		/* Do not power off, when the component is already off */
+		if (snd_soc_component_get_bias_level(component) == SND_SOC_BIAS_OFF)
 			return 0;
-		ret = dac33_hard_power(codec, 0);
+		ret = dac33_hard_power(component, 0);
 		if (ret != 0)
 			return ret;
 		break;
@@ -658,13 +658,13 @@ static int dac33_set_bias_level(struct snd_soc_codec *codec,
 
 static inline void dac33_prefill_handler(struct tlv320dac33_priv *dac33)
 {
-	struct snd_soc_codec *codec = dac33->codec;
+	struct snd_soc_component *component = dac33->component;
 	unsigned int delay;
 	unsigned long flags;
 
 	switch (dac33->fifo_mode) {
 	case DAC33_FIFO_MODE1:
-		dac33_write16(codec, DAC33_NSAMPLE_MSB,
+		dac33_write16(component, DAC33_NSAMPLE_MSB,
 			DAC33_THRREG(dac33->nsample));
 
 		/* Take the timestamps */
@@ -673,13 +673,13 @@ static inline void dac33_prefill_handler(struct tlv320dac33_priv *dac33)
 		dac33->t_stamp1 = dac33->t_stamp2;
 		spin_unlock_irqrestore(&dac33->lock, flags);
 
-		dac33_write16(codec, DAC33_PREFILL_MSB,
+		dac33_write16(component, DAC33_PREFILL_MSB,
 				DAC33_THRREG(dac33->alarm_threshold));
 		/* Enable Alarm Threshold IRQ with a delay */
 		delay = SAMPLES_TO_US(dac33->burst_rate,
 				     dac33->alarm_threshold) + 1000;
 		usleep_range(delay, delay + 500);
-		dac33_write(codec, DAC33_FIFO_IRQ_MASK, DAC33_MAT);
+		dac33_write(component, DAC33_FIFO_IRQ_MASK, DAC33_MAT);
 		break;
 	case DAC33_FIFO_MODE7:
 		/* Take the timestamp */
@@ -689,14 +689,14 @@ static inline void dac33_prefill_handler(struct tlv320dac33_priv *dac33)
 		dac33->t_stamp1 -= dac33->mode7_us_to_lthr;
 		spin_unlock_irqrestore(&dac33->lock, flags);
 
-		dac33_write16(codec, DAC33_PREFILL_MSB,
+		dac33_write16(component, DAC33_PREFILL_MSB,
 				DAC33_THRREG(DAC33_MODE7_MARGIN));
 
 		/* Enable Upper Threshold IRQ */
-		dac33_write(codec, DAC33_FIFO_IRQ_MASK, DAC33_MUT);
+		dac33_write(component, DAC33_FIFO_IRQ_MASK, DAC33_MUT);
 		break;
 	default:
-		dev_warn(codec->dev, "Unhandled FIFO mode: %d\n",
+		dev_warn(component->dev, "Unhandled FIFO mode: %d\n",
 							dac33->fifo_mode);
 		break;
 	}
@@ -704,7 +704,7 @@ static inline void dac33_prefill_handler(struct tlv320dac33_priv *dac33)
 
 static inline void dac33_playback_handler(struct tlv320dac33_priv *dac33)
 {
-	struct snd_soc_codec *codec = dac33->codec;
+	struct snd_soc_component *component = dac33->component;
 	unsigned long flags;
 
 	switch (dac33->fifo_mode) {
@@ -714,14 +714,14 @@ static inline void dac33_playback_handler(struct tlv320dac33_priv *dac33)
 		dac33->t_stamp2 = ktime_to_us(ktime_get());
 		spin_unlock_irqrestore(&dac33->lock, flags);
 
-		dac33_write16(codec, DAC33_NSAMPLE_MSB,
+		dac33_write16(component, DAC33_NSAMPLE_MSB,
 				DAC33_THRREG(dac33->nsample));
 		break;
 	case DAC33_FIFO_MODE7:
 		/* At the moment we are not using interrupts in mode7 */
 		break;
 	default:
-		dev_warn(codec->dev, "Unhandled FIFO mode: %d\n",
+		dev_warn(component->dev, "Unhandled FIFO mode: %d\n",
 							dac33->fifo_mode);
 		break;
 	}
@@ -729,12 +729,12 @@ static inline void dac33_playback_handler(struct tlv320dac33_priv *dac33)
 
 static void dac33_work(struct work_struct *work)
 {
-	struct snd_soc_codec *codec;
+	struct snd_soc_component *component;
 	struct tlv320dac33_priv *dac33;
 	u8 reg;
 
 	dac33 = container_of(work, struct tlv320dac33_priv, work);
-	codec = dac33->codec;
+	component = dac33->component;
 
 	mutex_lock(&dac33->mutex);
 	switch (dac33->state) {
@@ -750,12 +750,12 @@ static void dac33_work(struct work_struct *work)
 	case DAC33_FLUSH:
 		dac33->state = DAC33_IDLE;
 		/* Mask all interrupts from dac33 */
-		dac33_write(codec, DAC33_FIFO_IRQ_MASK, 0);
+		dac33_write(component, DAC33_FIFO_IRQ_MASK, 0);
 
 		/* flush fifo */
-		reg = dac33_read_reg_cache(codec, DAC33_FIFO_CTRL_A);
+		reg = dac33_read_reg_cache(component, DAC33_FIFO_CTRL_A);
 		reg |= DAC33_FIFOFLUSH;
-		dac33_write(codec, DAC33_FIFO_CTRL_A, reg);
+		dac33_write(component, DAC33_FIFO_CTRL_A, reg);
 		break;
 	}
 	mutex_unlock(&dac33->mutex);
@@ -763,8 +763,8 @@ static void dac33_work(struct work_struct *work)
 
 static irqreturn_t dac33_interrupt_handler(int irq, void *dev)
 {
-	struct snd_soc_codec *codec = dev;
-	struct tlv320dac33_priv *dac33 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = dev;
+	struct tlv320dac33_priv *dac33 = snd_soc_component_get_drvdata(component);
 	unsigned long flags;
 
 	spin_lock_irqsave(&dac33->lock, flags);
@@ -778,25 +778,25 @@ static irqreturn_t dac33_interrupt_handler(int irq, void *dev)
 	return IRQ_HANDLED;
 }
 
-static void dac33_oscwait(struct snd_soc_codec *codec)
+static void dac33_oscwait(struct snd_soc_component *component)
 {
 	int timeout = 60;
 	u8 reg;
 
 	do {
 		usleep_range(1000, 2000);
-		dac33_read(codec, DAC33_INT_OSC_STATUS, &reg);
+		dac33_read(component, DAC33_INT_OSC_STATUS, &reg);
 	} while (((reg & 0x03) != DAC33_OSCSTATUS_NORMAL) && timeout--);
 	if ((reg & 0x03) != DAC33_OSCSTATUS_NORMAL)
-		dev_err(codec->dev,
+		dev_err(component->dev,
 			"internal oscillator calibration failed\n");
 }
 
 static int dac33_startup(struct snd_pcm_substream *substream,
 			   struct snd_soc_dai *dai)
 {
-	struct snd_soc_codec *codec = dai->codec;
-	struct tlv320dac33_priv *dac33 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = dai->component;
+	struct tlv320dac33_priv *dac33 = snd_soc_component_get_drvdata(component);
 
 	/* Stream started, save the substream pointer */
 	dac33->substream = substream;
@@ -807,8 +807,8 @@ static int dac33_startup(struct snd_pcm_substream *substream,
 static void dac33_shutdown(struct snd_pcm_substream *substream,
 			     struct snd_soc_dai *dai)
 {
-	struct snd_soc_codec *codec = dai->codec;
-	struct tlv320dac33_priv *dac33 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = dai->component;
+	struct tlv320dac33_priv *dac33 = snd_soc_component_get_drvdata(component);
 
 	dac33->substream = NULL;
 }
@@ -819,8 +819,8 @@ static int dac33_hw_params(struct snd_pcm_substream *substream,
 			   struct snd_pcm_hw_params *params,
 			   struct snd_soc_dai *dai)
 {
-	struct snd_soc_codec *codec = dai->codec;
-	struct tlv320dac33_priv *dac33 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = dai->component;
+	struct tlv320dac33_priv *dac33 = snd_soc_component_get_drvdata(component);
 
 	/* Check parameters for validity */
 	switch (params_rate(params)) {
@@ -828,7 +828,7 @@ static int dac33_hw_params(struct snd_pcm_substream *substream,
 	case 48000:
 		break;
 	default:
-		dev_err(codec->dev, "unsupported rate %d\n",
+		dev_err(component->dev, "unsupported rate %d\n",
 			params_rate(params));
 		return -EINVAL;
 	}
@@ -843,7 +843,7 @@ static int dac33_hw_params(struct snd_pcm_substream *substream,
 		dac33->burst_rate = CALC_BURST_RATE(dac33->burst_bclkdiv, 64);
 		break;
 	default:
-		dev_err(codec->dev, "unsupported width %d\n",
+		dev_err(component->dev, "unsupported width %d\n",
 			params_width(params));
 		return -EINVAL;
 	}
@@ -862,9 +862,9 @@ static int dac33_hw_params(struct snd_pcm_substream *substream,
  * Use the known, working sequence of register writes to initialize the dac33.
  */
 static int dac33_prepare_chip(struct snd_pcm_substream *substream,
-			      struct snd_soc_codec *codec)
+			      struct snd_soc_component *component)
 {
-	struct tlv320dac33_priv *dac33 = snd_soc_codec_get_drvdata(codec);
+	struct tlv320dac33_priv *dac33 = snd_soc_component_get_drvdata(component);
 	unsigned int oscset, ratioset, pwr_ctrl, reg_tmp;
 	u8 aictrl_a, aictrl_b, fifoctrl_a;
 
@@ -876,16 +876,16 @@ static int dac33_prepare_chip(struct snd_pcm_substream *substream,
 					 dac33->refclk);
 		break;
 	default:
-		dev_err(codec->dev, "unsupported rate %d\n",
+		dev_err(component->dev, "unsupported rate %d\n",
 			substream->runtime->rate);
 		return -EINVAL;
 	}
 
 
-	aictrl_a = dac33_read_reg_cache(codec, DAC33_SER_AUDIOIF_CTRL_A);
+	aictrl_a = dac33_read_reg_cache(component, DAC33_SER_AUDIOIF_CTRL_A);
 	aictrl_a &= ~(DAC33_NCYCL_MASK | DAC33_WLEN_MASK);
 	/* Read FIFO control A, and clear FIFO flush bit */
-	fifoctrl_a = dac33_read_reg_cache(codec, DAC33_FIFO_CTRL_A);
+	fifoctrl_a = dac33_read_reg_cache(component, DAC33_FIFO_CTRL_A);
 	fifoctrl_a &= ~DAC33_FIFOFLUSH;
 
 	fifoctrl_a &= ~DAC33_WIDTH;
@@ -898,7 +898,7 @@ static int dac33_prepare_chip(struct snd_pcm_substream *substream,
 		aictrl_a |= (DAC33_NCYCL_32 | DAC33_WLEN_24);
 		break;
 	default:
-		dev_err(codec->dev, "unsupported format %d\n",
+		dev_err(component->dev, "unsupported format %d\n",
 			substream->runtime->format);
 		return -EINVAL;
 	}
@@ -914,57 +914,57 @@ static int dac33_prepare_chip(struct snd_pcm_substream *substream,
 		return 0;
 	}
 
-	dac33_soft_power(codec, 0);
-	dac33_soft_power(codec, 1);
+	dac33_soft_power(component, 0);
+	dac33_soft_power(component, 1);
 
-	reg_tmp = dac33_read_reg_cache(codec, DAC33_INT_OSC_CTRL);
-	dac33_write(codec, DAC33_INT_OSC_CTRL, reg_tmp);
+	reg_tmp = dac33_read_reg_cache(component, DAC33_INT_OSC_CTRL);
+	dac33_write(component, DAC33_INT_OSC_CTRL, reg_tmp);
 
 	/* Write registers 0x08 and 0x09 (MSB, LSB) */
-	dac33_write16(codec, DAC33_INT_OSC_FREQ_RAT_A, oscset);
+	dac33_write16(component, DAC33_INT_OSC_FREQ_RAT_A, oscset);
 
 	/* OSC calibration time */
-	dac33_write(codec, DAC33_CALIB_TIME, 96);
+	dac33_write(component, DAC33_CALIB_TIME, 96);
 
 	/* adjustment treshold & step */
-	dac33_write(codec, DAC33_INT_OSC_CTRL_B, DAC33_ADJTHRSHLD(2) |
+	dac33_write(component, DAC33_INT_OSC_CTRL_B, DAC33_ADJTHRSHLD(2) |
 						 DAC33_ADJSTEP(1));
 
 	/* div=4 / gain=1 / div */
-	dac33_write(codec, DAC33_INT_OSC_CTRL_C, DAC33_REFDIV(4));
+	dac33_write(component, DAC33_INT_OSC_CTRL_C, DAC33_REFDIV(4));
 
-	pwr_ctrl = dac33_read_reg_cache(codec, DAC33_PWR_CTRL);
+	pwr_ctrl = dac33_read_reg_cache(component, DAC33_PWR_CTRL);
 	pwr_ctrl |= DAC33_OSCPDNB | DAC33_DACRPDNB | DAC33_DACLPDNB;
-	dac33_write(codec, DAC33_PWR_CTRL, pwr_ctrl);
+	dac33_write(component, DAC33_PWR_CTRL, pwr_ctrl);
 
-	dac33_oscwait(codec);
+	dac33_oscwait(component);
 
 	if (dac33->fifo_mode) {
 		/* Generic for all FIFO modes */
 		/* 50-51 : ASRC Control registers */
-		dac33_write(codec, DAC33_ASRC_CTRL_A, DAC33_SRCLKDIV(1));
-		dac33_write(codec, DAC33_ASRC_CTRL_B, 1); /* ??? */
+		dac33_write(component, DAC33_ASRC_CTRL_A, DAC33_SRCLKDIV(1));
+		dac33_write(component, DAC33_ASRC_CTRL_B, 1); /* ??? */
 
 		/* Write registers 0x34 and 0x35 (MSB, LSB) */
-		dac33_write16(codec, DAC33_SRC_REF_CLK_RATIO_A, ratioset);
+		dac33_write16(component, DAC33_SRC_REF_CLK_RATIO_A, ratioset);
 
 		/* Set interrupts to high active */
-		dac33_write(codec, DAC33_INTP_CTRL_A, DAC33_INTPM_AHIGH);
+		dac33_write(component, DAC33_INTP_CTRL_A, DAC33_INTPM_AHIGH);
 	} else {
 		/* FIFO bypass mode */
 		/* 50-51 : ASRC Control registers */
-		dac33_write(codec, DAC33_ASRC_CTRL_A, DAC33_SRCBYP);
-		dac33_write(codec, DAC33_ASRC_CTRL_B, 0); /* ??? */
+		dac33_write(component, DAC33_ASRC_CTRL_A, DAC33_SRCBYP);
+		dac33_write(component, DAC33_ASRC_CTRL_B, 0); /* ??? */
 	}
 
 	/* Interrupt behaviour configuration */
 	switch (dac33->fifo_mode) {
 	case DAC33_FIFO_MODE1:
-		dac33_write(codec, DAC33_FIFO_IRQ_MODE_B,
+		dac33_write(component, DAC33_FIFO_IRQ_MODE_B,
 			    DAC33_ATM(DAC33_FIFO_IRQ_MODE_LEVEL));
 		break;
 	case DAC33_FIFO_MODE7:
-		dac33_write(codec, DAC33_FIFO_IRQ_MODE_A,
+		dac33_write(component, DAC33_FIFO_IRQ_MODE_A,
 			DAC33_UTM(DAC33_FIFO_IRQ_MODE_LEVEL));
 		break;
 	default:
@@ -972,7 +972,7 @@ static int dac33_prepare_chip(struct snd_pcm_substream *substream,
 		break;
 	}
 
-	aictrl_b = dac33_read_reg_cache(codec, DAC33_SER_AUDIOIF_CTRL_B);
+	aictrl_b = dac33_read_reg_cache(component, DAC33_SER_AUDIOIF_CTRL_B);
 
 	switch (dac33->fifo_mode) {
 	case DAC33_FIFO_MODE1:
@@ -1014,9 +1014,9 @@ static int dac33_prepare_chip(struct snd_pcm_substream *substream,
 		break;
 	}
 
-	dac33_write(codec, DAC33_FIFO_CTRL_A, fifoctrl_a);
-	dac33_write(codec, DAC33_SER_AUDIOIF_CTRL_A, aictrl_a);
-	dac33_write(codec, DAC33_SER_AUDIOIF_CTRL_B, aictrl_b);
+	dac33_write(component, DAC33_FIFO_CTRL_A, fifoctrl_a);
+	dac33_write(component, DAC33_SER_AUDIOIF_CTRL_A, aictrl_a);
+	dac33_write(component, DAC33_SER_AUDIOIF_CTRL_B, aictrl_b);
 
 	/*
 	 * BCLK divide ratio
@@ -1028,17 +1028,17 @@ static int dac33_prepare_chip(struct snd_pcm_substream *substream,
 	 * 255: 255
 	 */
 	if (dac33->fifo_mode)
-		dac33_write(codec, DAC33_SER_AUDIOIF_CTRL_C,
+		dac33_write(component, DAC33_SER_AUDIOIF_CTRL_C,
 							dac33->burst_bclkdiv);
 	else
 		if (substream->runtime->format == SNDRV_PCM_FORMAT_S16_LE)
-			dac33_write(codec, DAC33_SER_AUDIOIF_CTRL_C, 32);
+			dac33_write(component, DAC33_SER_AUDIOIF_CTRL_C, 32);
 		else
-			dac33_write(codec, DAC33_SER_AUDIOIF_CTRL_C, 16);
+			dac33_write(component, DAC33_SER_AUDIOIF_CTRL_C, 16);
 
 	switch (dac33->fifo_mode) {
 	case DAC33_FIFO_MODE1:
-		dac33_write16(codec, DAC33_ATHR_MSB,
+		dac33_write16(component, DAC33_ATHR_MSB,
 			      DAC33_THRREG(dac33->alarm_threshold));
 		break;
 	case DAC33_FIFO_MODE7:
@@ -1046,8 +1046,8 @@ static int dac33_prepare_chip(struct snd_pcm_substream *substream,
 		 * Configure the threshold levels, and leave 10 sample space
 		 * at the bottom, and also at the top of the FIFO
 		 */
-		dac33_write16(codec, DAC33_UTHR_MSB, DAC33_THRREG(dac33->uthr));
-		dac33_write16(codec, DAC33_LTHR_MSB,
+		dac33_write16(component, DAC33_UTHR_MSB, DAC33_THRREG(dac33->uthr));
+		dac33_write16(component, DAC33_LTHR_MSB,
 			      DAC33_THRREG(DAC33_MODE7_MARGIN));
 		break;
 	default:
@@ -1060,9 +1060,9 @@ static int dac33_prepare_chip(struct snd_pcm_substream *substream,
 }
 
 static void dac33_calculate_times(struct snd_pcm_substream *substream,
-				  struct snd_soc_codec *codec)
+				  struct snd_soc_component *component)
 {
-	struct tlv320dac33_priv *dac33 = snd_soc_codec_get_drvdata(codec);
+	struct tlv320dac33_priv *dac33 = snd_soc_component_get_drvdata(component);
 	unsigned int period_size = substream->runtime->period_size;
 	unsigned int rate = substream->runtime->rate;
 	unsigned int nsample_limit;
@@ -1119,8 +1119,8 @@ static void dac33_calculate_times(struct snd_pcm_substream *substream,
 static int dac33_pcm_trigger(struct snd_pcm_substream *substream, int cmd,
 			     struct snd_soc_dai *dai)
 {
-	struct snd_soc_codec *codec = dai->codec;
-	struct tlv320dac33_priv *dac33 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = dai->component;
+	struct tlv320dac33_priv *dac33 = snd_soc_component_get_drvdata(component);
 	int ret = 0;
 
 	switch (cmd) {
@@ -1151,8 +1151,8 @@ static snd_pcm_sframes_t dac33_dai_delay(
 			struct snd_pcm_substream *substream,
 			struct snd_soc_dai *dai)
 {
-	struct snd_soc_codec *codec = dai->codec;
-	struct tlv320dac33_priv *dac33 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = dai->component;
+	struct tlv320dac33_priv *dac33 = snd_soc_component_get_drvdata(component);
 	unsigned long long t0, t1, t_now;
 	unsigned int time_delta, uthr;
 	int samples_out, samples_in, samples;
@@ -1284,7 +1284,7 @@ static snd_pcm_sframes_t dac33_dai_delay(
 		}
 		break;
 	default:
-		dev_warn(codec->dev, "Unhandled FIFO mode: %d\n",
+		dev_warn(component->dev, "Unhandled FIFO mode: %d\n",
 							dac33->fifo_mode);
 		break;
 	}
@@ -1295,12 +1295,12 @@ static snd_pcm_sframes_t dac33_dai_delay(
 static int dac33_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 		int clk_id, unsigned int freq, int dir)
 {
-	struct snd_soc_codec *codec = codec_dai->codec;
-	struct tlv320dac33_priv *dac33 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = codec_dai->component;
+	struct tlv320dac33_priv *dac33 = snd_soc_component_get_drvdata(component);
 	u8 ioc_reg, asrcb_reg;
 
-	ioc_reg = dac33_read_reg_cache(codec, DAC33_INT_OSC_CTRL);
-	asrcb_reg = dac33_read_reg_cache(codec, DAC33_ASRC_CTRL_B);
+	ioc_reg = dac33_read_reg_cache(component, DAC33_INT_OSC_CTRL);
+	asrcb_reg = dac33_read_reg_cache(component, DAC33_ASRC_CTRL_B);
 	switch (clk_id) {
 	case TLV320DAC33_MCLK:
 		ioc_reg |= DAC33_REFSEL;
@@ -1311,13 +1311,13 @@ static int dac33_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 		asrcb_reg &= ~DAC33_SRCREFSEL;
 		break;
 	default:
-		dev_err(codec->dev, "Invalid clock ID (%d)\n", clk_id);
+		dev_err(component->dev, "Invalid clock ID (%d)\n", clk_id);
 		break;
 	}
 	dac33->refclk = freq;
 
-	dac33_write_reg_cache(codec, DAC33_INT_OSC_CTRL, ioc_reg);
-	dac33_write_reg_cache(codec, DAC33_ASRC_CTRL_B, asrcb_reg);
+	dac33_write_reg_cache(component, DAC33_INT_OSC_CTRL, ioc_reg);
+	dac33_write_reg_cache(component, DAC33_ASRC_CTRL_B, asrcb_reg);
 
 	return 0;
 }
@@ -1325,12 +1325,12 @@ static int dac33_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 static int dac33_set_dai_fmt(struct snd_soc_dai *codec_dai,
 			     unsigned int fmt)
 {
-	struct snd_soc_codec *codec = codec_dai->codec;
-	struct tlv320dac33_priv *dac33 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = codec_dai->component;
+	struct tlv320dac33_priv *dac33 = snd_soc_component_get_drvdata(component);
 	u8 aictrl_a, aictrl_b;
 
-	aictrl_a = dac33_read_reg_cache(codec, DAC33_SER_AUDIOIF_CTRL_A);
-	aictrl_b = dac33_read_reg_cache(codec, DAC33_SER_AUDIOIF_CTRL_B);
+	aictrl_a = dac33_read_reg_cache(component, DAC33_SER_AUDIOIF_CTRL_A);
+	aictrl_b = dac33_read_reg_cache(component, DAC33_SER_AUDIOIF_CTRL_B);
 	/* set master/slave audio interface */
 	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
 	case SND_SOC_DAIFMT_CBM_CFM:
@@ -1340,7 +1340,7 @@ static int dac33_set_dai_fmt(struct snd_soc_dai *codec_dai,
 	case SND_SOC_DAIFMT_CBS_CFS:
 		/* Codec Slave */
 		if (dac33->fifo_mode) {
-			dev_err(codec->dev, "FIFO mode requires master mode\n");
+			dev_err(component->dev, "FIFO mode requires master mode\n");
 			return -EINVAL;
 		} else
 			aictrl_a &= ~(DAC33_MSBCLK | DAC33_MSWCLK);
@@ -1366,35 +1366,35 @@ static int dac33_set_dai_fmt(struct snd_soc_dai *codec_dai,
 		aictrl_a |= DAC33_AFMT_LEFT_J;
 		break;
 	default:
-		dev_err(codec->dev, "Unsupported format (%u)\n",
+		dev_err(component->dev, "Unsupported format (%u)\n",
 			fmt & SND_SOC_DAIFMT_FORMAT_MASK);
 		return -EINVAL;
 	}
 
-	dac33_write_reg_cache(codec, DAC33_SER_AUDIOIF_CTRL_A, aictrl_a);
-	dac33_write_reg_cache(codec, DAC33_SER_AUDIOIF_CTRL_B, aictrl_b);
+	dac33_write_reg_cache(component, DAC33_SER_AUDIOIF_CTRL_A, aictrl_a);
+	dac33_write_reg_cache(component, DAC33_SER_AUDIOIF_CTRL_B, aictrl_b);
 
 	return 0;
 }
 
-static int dac33_soc_probe(struct snd_soc_codec *codec)
+static int dac33_soc_probe(struct snd_soc_component *component)
 {
-	struct tlv320dac33_priv *dac33 = snd_soc_codec_get_drvdata(codec);
+	struct tlv320dac33_priv *dac33 = snd_soc_component_get_drvdata(component);
 	int ret = 0;
 
-	dac33->codec = codec;
+	dac33->component = component;
 
 	/* Read the tlv320dac33 ID registers */
-	ret = dac33_hard_power(codec, 1);
+	ret = dac33_hard_power(component, 1);
 	if (ret != 0) {
-		dev_err(codec->dev, "Failed to power up codec: %d\n", ret);
+		dev_err(component->dev, "Failed to power up component: %d\n", ret);
 		goto err_power;
 	}
-	ret = dac33_read_id(codec);
-	dac33_hard_power(codec, 0);
+	ret = dac33_read_id(component);
+	dac33_hard_power(component, 0);
 
 	if (ret < 0) {
-		dev_err(codec->dev, "Failed to read chip ID: %d\n", ret);
+		dev_err(component->dev, "Failed to read chip ID: %d\n", ret);
 		ret = -ENODEV;
 		goto err_power;
 	}
@@ -1403,9 +1403,9 @@ static int dac33_soc_probe(struct snd_soc_codec *codec)
 	if (dac33->irq >= 0) {
 		ret = request_irq(dac33->irq, dac33_interrupt_handler,
 				  IRQF_TRIGGER_RISING,
-				  codec->component.name, codec);
+				  component->name, component);
 		if (ret < 0) {
-			dev_err(codec->dev, "Could not request IRQ%d (%d)\n",
+			dev_err(component->dev, "Could not request IRQ%d (%d)\n",
 						dac33->irq, ret);
 			dac33->irq = -1;
 		}
@@ -1416,41 +1416,38 @@ static int dac33_soc_probe(struct snd_soc_codec *codec)
 
 	/* Only add the FIFO controls, if we have valid IRQ number */
 	if (dac33->irq >= 0)
-		snd_soc_add_codec_controls(codec, dac33_mode_snd_controls,
+		snd_soc_add_component_controls(component, dac33_mode_snd_controls,
 				     ARRAY_SIZE(dac33_mode_snd_controls));
 
 err_power:
 	return ret;
 }
 
-static int dac33_soc_remove(struct snd_soc_codec *codec)
+static void dac33_soc_remove(struct snd_soc_component *component)
 {
-	struct tlv320dac33_priv *dac33 = snd_soc_codec_get_drvdata(codec);
+	struct tlv320dac33_priv *dac33 = snd_soc_component_get_drvdata(component);
 
 	if (dac33->irq >= 0) {
-		free_irq(dac33->irq, dac33->codec);
+		free_irq(dac33->irq, dac33->component);
 		flush_work(&dac33->work);
 	}
-	return 0;
 }
 
-static const struct snd_soc_codec_driver soc_codec_dev_tlv320dac33 = {
-	.read = dac33_read_reg_cache,
-	.write = dac33_write_locked,
-	.set_bias_level = dac33_set_bias_level,
-	.idle_bias_off = true,
-
-	.probe = dac33_soc_probe,
-	.remove = dac33_soc_remove,
-
-	.component_driver = {
-		.controls		= dac33_snd_controls,
-		.num_controls		= ARRAY_SIZE(dac33_snd_controls),
-		.dapm_widgets		= dac33_dapm_widgets,
-		.num_dapm_widgets	= ARRAY_SIZE(dac33_dapm_widgets),
-		.dapm_routes		= audio_map,
-		.num_dapm_routes	= ARRAY_SIZE(audio_map),
-	},
+static const struct snd_soc_component_driver soc_component_dev_tlv320dac33 = {
+	.read			= dac33_read_reg_cache,
+	.write			= dac33_write_locked,
+	.set_bias_level		= dac33_set_bias_level,
+	.probe			= dac33_soc_probe,
+	.remove			= dac33_soc_remove,
+	.controls		= dac33_snd_controls,
+	.num_controls		= ARRAY_SIZE(dac33_snd_controls),
+	.dapm_widgets		= dac33_dapm_widgets,
+	.num_dapm_widgets	= ARRAY_SIZE(dac33_dapm_widgets),
+	.dapm_routes		= audio_map,
+	.num_dapm_routes	= ARRAY_SIZE(audio_map),
+	.use_pmdown_time	= 1,
+	.endianness		= 1,
+	.non_legacy_dai_naming	= 1,
 };
 
 #define DAC33_RATES	(SNDRV_PCM_RATE_44100 | \
@@ -1544,8 +1541,8 @@ static int dac33_i2c_probe(struct i2c_client *client,
 		goto err_get;
 	}
 
-	ret = snd_soc_register_codec(&client->dev,
-			&soc_codec_dev_tlv320dac33, &dac33_dai, 1);
+	ret = devm_snd_soc_register_component(&client->dev,
+			&soc_component_dev_tlv320dac33, &dac33_dai, 1);
 	if (ret < 0)
 		goto err_get;
 
@@ -1562,12 +1559,11 @@ static int dac33_i2c_remove(struct i2c_client *client)
 	struct tlv320dac33_priv *dac33 = i2c_get_clientdata(client);
 
 	if (unlikely(dac33->chip_power))
-		dac33_hard_power(dac33->codec, 0);
+		dac33_hard_power(dac33->component, 0);
 
 	if (dac33->power_gpio >= 0)
 		gpio_free(dac33->power_gpio);
 
-	snd_soc_unregister_codec(&client->dev);
 	return 0;
 }
 
-- 
2.16.1
