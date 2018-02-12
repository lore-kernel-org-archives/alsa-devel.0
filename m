From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5631: replace codec to component" to
	the asoc tree
Date: Mon, 12 Feb 2018 12:44:57 +0000
Message-ID: <E1elDTd-0005EC-MF@debutante>
References: <87tvv51g4h.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 02C97267A4B
 for <alsa-devel@alsa-project.org>; Mon, 12 Feb 2018 13:45:00 +0100 (CET)
In-Reply-To: <87tvv51g4h.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: rt5631: replace codec to component

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

>From 46295e5e7ae53bf3c508892589b269576cd62bc3 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 29 Jan 2018 03:48:05 +0000
Subject: [PATCH] ASoC: rt5631: replace codec to component

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
 sound/soc/codecs/rt5631.c | 324 +++++++++++++++++++++++-----------------------
 1 file changed, 163 insertions(+), 161 deletions(-)

diff --git a/sound/soc/codecs/rt5631.c b/sound/soc/codecs/rt5631.c
index 55b04c55fb4b..cf6dce69eb2a 100644
--- a/sound/soc/codecs/rt5631.c
+++ b/sound/soc/codecs/rt5631.c
@@ -71,30 +71,30 @@ static const struct reg_default rt5631_reg[] = {
 /**
  * rt5631_write_index - write index register of 2nd layer
  */
-static void rt5631_write_index(struct snd_soc_codec *codec,
+static void rt5631_write_index(struct snd_soc_component *component,
 		unsigned int reg, unsigned int value)
 {
-	snd_soc_write(codec, RT5631_INDEX_ADD, reg);
-	snd_soc_write(codec, RT5631_INDEX_DATA, value);
+	snd_soc_component_write(component, RT5631_INDEX_ADD, reg);
+	snd_soc_component_write(component, RT5631_INDEX_DATA, value);
 }
 
 /**
  * rt5631_read_index - read index register of 2nd layer
  */
-static unsigned int rt5631_read_index(struct snd_soc_codec *codec,
+static unsigned int rt5631_read_index(struct snd_soc_component *component,
 				unsigned int reg)
 {
 	unsigned int value;
 
-	snd_soc_write(codec, RT5631_INDEX_ADD, reg);
-	value = snd_soc_read(codec, RT5631_INDEX_DATA);
+	snd_soc_component_write(component, RT5631_INDEX_ADD, reg);
+	value = snd_soc_component_read32(component, RT5631_INDEX_DATA);
 
 	return value;
 }
 
-static int rt5631_reset(struct snd_soc_codec *codec)
+static int rt5631_reset(struct snd_soc_component *component)
 {
-	return snd_soc_write(codec, RT5631_RESET, 0);
+	return snd_soc_component_write(component, RT5631_RESET, 0);
 }
 
 static bool rt5631_volatile_register(struct device *dev, unsigned int reg)
@@ -187,8 +187,8 @@ static const DECLARE_TLV_DB_RANGE(mic_bst_tlv,
 static int rt5631_dmic_get(struct snd_kcontrol *kcontrol,
 		struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
-	struct rt5631_priv *rt5631 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
+	struct rt5631_priv *rt5631 = snd_soc_component_get_drvdata(component);
 
 	ucontrol->value.integer.value[0] = rt5631->dmic_used_flag;
 
@@ -198,8 +198,8 @@ static int rt5631_dmic_get(struct snd_kcontrol *kcontrol,
 static int rt5631_dmic_put(struct snd_kcontrol *kcontrol,
 		struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
-	struct rt5631_priv *rt5631 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
+	struct rt5631_priv *rt5631 = snd_soc_component_get_drvdata(component);
 
 	rt5631->dmic_used_flag = ucontrol->value.integer.value[0];
 	return 0;
@@ -286,78 +286,78 @@ static const struct snd_kcontrol_new rt5631_snd_controls[] = {
 static int check_sysclk1_source(struct snd_soc_dapm_widget *source,
 			 struct snd_soc_dapm_widget *sink)
 {
-	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(source->dapm);
+	struct snd_soc_component *component = snd_soc_dapm_to_component(source->dapm);
 	unsigned int reg;
 
-	reg = snd_soc_read(codec, RT5631_GLOBAL_CLK_CTRL);
+	reg = snd_soc_component_read32(component, RT5631_GLOBAL_CLK_CTRL);
 	return reg & RT5631_SYSCLK_SOUR_SEL_PLL;
 }
 
 static int check_dmic_used(struct snd_soc_dapm_widget *source,
 			 struct snd_soc_dapm_widget *sink)
 {
-	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(source->dapm);
-	struct rt5631_priv *rt5631 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = snd_soc_dapm_to_component(source->dapm);
+	struct rt5631_priv *rt5631 = snd_soc_component_get_drvdata(component);
 	return rt5631->dmic_used_flag;
 }
 
 static int check_dacl_to_outmixl(struct snd_soc_dapm_widget *source,
 			 struct snd_soc_dapm_widget *sink)
 {
-	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(source->dapm);
+	struct snd_soc_component *component = snd_soc_dapm_to_component(source->dapm);
 	unsigned int reg;
 
-	reg = snd_soc_read(codec, RT5631_OUTMIXER_L_CTRL);
+	reg = snd_soc_component_read32(component, RT5631_OUTMIXER_L_CTRL);
 	return !(reg & RT5631_M_DAC_L_TO_OUTMIXER_L);
 }
 
 static int check_dacr_to_outmixr(struct snd_soc_dapm_widget *source,
 			 struct snd_soc_dapm_widget *sink)
 {
-	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(source->dapm);
+	struct snd_soc_component *component = snd_soc_dapm_to_component(source->dapm);
 	unsigned int reg;
 
-	reg = snd_soc_read(codec, RT5631_OUTMIXER_R_CTRL);
+	reg = snd_soc_component_read32(component, RT5631_OUTMIXER_R_CTRL);
 	return !(reg & RT5631_M_DAC_R_TO_OUTMIXER_R);
 }
 
 static int check_dacl_to_spkmixl(struct snd_soc_dapm_widget *source,
 			 struct snd_soc_dapm_widget *sink)
 {
-	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(source->dapm);
+	struct snd_soc_component *component = snd_soc_dapm_to_component(source->dapm);
 	unsigned int reg;
 
-	reg = snd_soc_read(codec, RT5631_SPK_MIXER_CTRL);
+	reg = snd_soc_component_read32(component, RT5631_SPK_MIXER_CTRL);
 	return !(reg & RT5631_M_DAC_L_TO_SPKMIXER_L);
 }
 
 static int check_dacr_to_spkmixr(struct snd_soc_dapm_widget *source,
 			 struct snd_soc_dapm_widget *sink)
 {
-	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(source->dapm);
+	struct snd_soc_component *component = snd_soc_dapm_to_component(source->dapm);
 	unsigned int reg;
 
-	reg = snd_soc_read(codec, RT5631_SPK_MIXER_CTRL);
+	reg = snd_soc_component_read32(component, RT5631_SPK_MIXER_CTRL);
 	return !(reg & RT5631_M_DAC_R_TO_SPKMIXER_R);
 }
 
 static int check_adcl_select(struct snd_soc_dapm_widget *source,
 			 struct snd_soc_dapm_widget *sink)
 {
-	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(source->dapm);
+	struct snd_soc_component *component = snd_soc_dapm_to_component(source->dapm);
 	unsigned int reg;
 
-	reg = snd_soc_read(codec, RT5631_ADC_REC_MIXER);
+	reg = snd_soc_component_read32(component, RT5631_ADC_REC_MIXER);
 	return !(reg & RT5631_M_MIC1_TO_RECMIXER_L);
 }
 
 static int check_adcr_select(struct snd_soc_dapm_widget *source,
 			 struct snd_soc_dapm_widget *sink)
 {
-	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(source->dapm);
+	struct snd_soc_component *component = snd_soc_dapm_to_component(source->dapm);
 	unsigned int reg;
 
-	reg = snd_soc_read(codec, RT5631_ADC_REC_MIXER);
+	reg = snd_soc_component_read32(component, RT5631_ADC_REC_MIXER);
 	return !(reg & RT5631_M_MIC2_TO_RECMIXER_R);
 }
 
@@ -367,36 +367,36 @@ static int check_adcr_select(struct snd_soc_dapm_widget *source,
  *
  * When power on/off headphone, the depop sequence is done by hardware.
  */
-static void onebit_depop_power_stage(struct snd_soc_codec *codec, int enable)
+static void onebit_depop_power_stage(struct snd_soc_component *component, int enable)
 {
 	unsigned int soft_vol, hp_zc;
 
 	/* enable one-bit depop function */
-	snd_soc_update_bits(codec, RT5631_DEPOP_FUN_CTRL_2,
+	snd_soc_component_update_bits(component, RT5631_DEPOP_FUN_CTRL_2,
 				RT5631_EN_ONE_BIT_DEPOP, 0);
 
 	/* keep soft volume and zero crossing setting */
-	soft_vol = snd_soc_read(codec, RT5631_SOFT_VOL_CTRL);
-	snd_soc_write(codec, RT5631_SOFT_VOL_CTRL, 0);
-	hp_zc = snd_soc_read(codec, RT5631_INT_ST_IRQ_CTRL_2);
-	snd_soc_write(codec, RT5631_INT_ST_IRQ_CTRL_2, hp_zc & 0xf7ff);
+	soft_vol = snd_soc_component_read32(component, RT5631_SOFT_VOL_CTRL);
+	snd_soc_component_write(component, RT5631_SOFT_VOL_CTRL, 0);
+	hp_zc = snd_soc_component_read32(component, RT5631_INT_ST_IRQ_CTRL_2);
+	snd_soc_component_write(component, RT5631_INT_ST_IRQ_CTRL_2, hp_zc & 0xf7ff);
 	if (enable) {
 		/* config one-bit depop parameter */
-		rt5631_write_index(codec, RT5631_TEST_MODE_CTRL, 0x84c0);
-		rt5631_write_index(codec, RT5631_SPK_INTL_CTRL, 0x309f);
-		rt5631_write_index(codec, RT5631_CP_INTL_REG2, 0x6530);
+		rt5631_write_index(component, RT5631_TEST_MODE_CTRL, 0x84c0);
+		rt5631_write_index(component, RT5631_SPK_INTL_CTRL, 0x309f);
+		rt5631_write_index(component, RT5631_CP_INTL_REG2, 0x6530);
 		/* power on capless block */
-		snd_soc_write(codec, RT5631_DEPOP_FUN_CTRL_2,
+		snd_soc_component_write(component, RT5631_DEPOP_FUN_CTRL_2,
 				RT5631_EN_CAP_FREE_DEPOP);
 	} else {
 		/* power off capless block */
-		snd_soc_write(codec, RT5631_DEPOP_FUN_CTRL_2, 0);
+		snd_soc_component_write(component, RT5631_DEPOP_FUN_CTRL_2, 0);
 		msleep(100);
 	}
 
 	/* recover soft volume and zero crossing setting */
-	snd_soc_write(codec, RT5631_SOFT_VOL_CTRL, soft_vol);
-	snd_soc_write(codec, RT5631_INT_ST_IRQ_CTRL_2, hp_zc);
+	snd_soc_component_write(component, RT5631_SOFT_VOL_CTRL, soft_vol);
+	snd_soc_component_write(component, RT5631_INT_ST_IRQ_CTRL_2, hp_zc);
 }
 
 /**
@@ -405,36 +405,36 @@ static void onebit_depop_power_stage(struct snd_soc_codec *codec, int enable)
  *
  * When mute/unmute headphone, the depop sequence is done by hardware.
  */
-static void onebit_depop_mute_stage(struct snd_soc_codec *codec, int enable)
+static void onebit_depop_mute_stage(struct snd_soc_component *component, int enable)
 {
 	unsigned int soft_vol, hp_zc;
 
 	/* enable one-bit depop function */
-	snd_soc_update_bits(codec, RT5631_DEPOP_FUN_CTRL_2,
+	snd_soc_component_update_bits(component, RT5631_DEPOP_FUN_CTRL_2,
 				RT5631_EN_ONE_BIT_DEPOP, 0);
 
 	/* keep soft volume and zero crossing setting */
-	soft_vol = snd_soc_read(codec, RT5631_SOFT_VOL_CTRL);
-	snd_soc_write(codec, RT5631_SOFT_VOL_CTRL, 0);
-	hp_zc = snd_soc_read(codec, RT5631_INT_ST_IRQ_CTRL_2);
-	snd_soc_write(codec, RT5631_INT_ST_IRQ_CTRL_2, hp_zc & 0xf7ff);
+	soft_vol = snd_soc_component_read32(component, RT5631_SOFT_VOL_CTRL);
+	snd_soc_component_write(component, RT5631_SOFT_VOL_CTRL, 0);
+	hp_zc = snd_soc_component_read32(component, RT5631_INT_ST_IRQ_CTRL_2);
+	snd_soc_component_write(component, RT5631_INT_ST_IRQ_CTRL_2, hp_zc & 0xf7ff);
 	if (enable) {
 		schedule_timeout_uninterruptible(msecs_to_jiffies(10));
 		/* config one-bit depop parameter */
-		rt5631_write_index(codec, RT5631_SPK_INTL_CTRL, 0x307f);
-		snd_soc_update_bits(codec, RT5631_HP_OUT_VOL,
+		rt5631_write_index(component, RT5631_SPK_INTL_CTRL, 0x307f);
+		snd_soc_component_update_bits(component, RT5631_HP_OUT_VOL,
 				RT5631_L_MUTE | RT5631_R_MUTE, 0);
 		msleep(300);
 	} else {
-		snd_soc_update_bits(codec, RT5631_HP_OUT_VOL,
+		snd_soc_component_update_bits(component, RT5631_HP_OUT_VOL,
 			RT5631_L_MUTE | RT5631_R_MUTE,
 			RT5631_L_MUTE | RT5631_R_MUTE);
 		msleep(100);
 	}
 
 	/* recover soft volume and zero crossing setting */
-	snd_soc_write(codec, RT5631_SOFT_VOL_CTRL, soft_vol);
-	snd_soc_write(codec, RT5631_INT_ST_IRQ_CTRL_2, hp_zc);
+	snd_soc_component_write(component, RT5631_SOFT_VOL_CTRL, soft_vol);
+	snd_soc_component_write(component, RT5631_INT_ST_IRQ_CTRL_2, hp_zc);
 }
 
 /**
@@ -443,70 +443,70 @@ static void onebit_depop_mute_stage(struct snd_soc_codec *codec, int enable)
  *
  * When power on/off headphone, the depop sequence is done in step by step.
  */
-static void depop_seq_power_stage(struct snd_soc_codec *codec, int enable)
+static void depop_seq_power_stage(struct snd_soc_component *component, int enable)
 {
 	unsigned int soft_vol, hp_zc;
 
 	/* depop control by register */
-	snd_soc_update_bits(codec, RT5631_DEPOP_FUN_CTRL_2,
+	snd_soc_component_update_bits(component, RT5631_DEPOP_FUN_CTRL_2,
 		RT5631_EN_ONE_BIT_DEPOP, RT5631_EN_ONE_BIT_DEPOP);
 
 	/* keep soft volume and zero crossing setting */
-	soft_vol = snd_soc_read(codec, RT5631_SOFT_VOL_CTRL);
-	snd_soc_write(codec, RT5631_SOFT_VOL_CTRL, 0);
-	hp_zc = snd_soc_read(codec, RT5631_INT_ST_IRQ_CTRL_2);
-	snd_soc_write(codec, RT5631_INT_ST_IRQ_CTRL_2, hp_zc & 0xf7ff);
+	soft_vol = snd_soc_component_read32(component, RT5631_SOFT_VOL_CTRL);
+	snd_soc_component_write(component, RT5631_SOFT_VOL_CTRL, 0);
+	hp_zc = snd_soc_component_read32(component, RT5631_INT_ST_IRQ_CTRL_2);
+	snd_soc_component_write(component, RT5631_INT_ST_IRQ_CTRL_2, hp_zc & 0xf7ff);
 	if (enable) {
 		/* config depop sequence parameter */
-		rt5631_write_index(codec, RT5631_SPK_INTL_CTRL, 0x303e);
+		rt5631_write_index(component, RT5631_SPK_INTL_CTRL, 0x303e);
 
 		/* power on headphone and charge pump */
-		snd_soc_update_bits(codec, RT5631_PWR_MANAG_ADD3,
+		snd_soc_component_update_bits(component, RT5631_PWR_MANAG_ADD3,
 			RT5631_PWR_CHARGE_PUMP | RT5631_PWR_HP_L_AMP |
 			RT5631_PWR_HP_R_AMP,
 			RT5631_PWR_CHARGE_PUMP | RT5631_PWR_HP_L_AMP |
 			RT5631_PWR_HP_R_AMP);
 
 		/* power on soft generator and depop mode2 */
-		snd_soc_write(codec, RT5631_DEPOP_FUN_CTRL_1,
+		snd_soc_component_write(component, RT5631_DEPOP_FUN_CTRL_1,
 			RT5631_POW_ON_SOFT_GEN | RT5631_EN_DEPOP2_FOR_HP);
 		msleep(100);
 
 		/* stop depop mode */
-		snd_soc_update_bits(codec, RT5631_PWR_MANAG_ADD3,
+		snd_soc_component_update_bits(component, RT5631_PWR_MANAG_ADD3,
 			RT5631_PWR_HP_DEPOP_DIS, RT5631_PWR_HP_DEPOP_DIS);
 	} else {
 		/* config depop sequence parameter */
-		rt5631_write_index(codec, RT5631_SPK_INTL_CTRL, 0x303F);
-		snd_soc_write(codec, RT5631_DEPOP_FUN_CTRL_1,
+		rt5631_write_index(component, RT5631_SPK_INTL_CTRL, 0x303F);
+		snd_soc_component_write(component, RT5631_DEPOP_FUN_CTRL_1,
 			RT5631_POW_ON_SOFT_GEN | RT5631_EN_MUTE_UNMUTE_DEPOP |
 			RT5631_PD_HPAMP_L_ST_UP | RT5631_PD_HPAMP_R_ST_UP);
 		msleep(75);
-		snd_soc_write(codec, RT5631_DEPOP_FUN_CTRL_1,
+		snd_soc_component_write(component, RT5631_DEPOP_FUN_CTRL_1,
 			RT5631_POW_ON_SOFT_GEN | RT5631_PD_HPAMP_L_ST_UP |
 			RT5631_PD_HPAMP_R_ST_UP);
 
 		/* start depop mode */
-		snd_soc_update_bits(codec, RT5631_PWR_MANAG_ADD3,
+		snd_soc_component_update_bits(component, RT5631_PWR_MANAG_ADD3,
 				RT5631_PWR_HP_DEPOP_DIS, 0);
 
 		/* config depop sequence parameter */
-		snd_soc_write(codec, RT5631_DEPOP_FUN_CTRL_1,
+		snd_soc_component_write(component, RT5631_DEPOP_FUN_CTRL_1,
 			RT5631_POW_ON_SOFT_GEN | RT5631_EN_DEPOP2_FOR_HP |
 			RT5631_PD_HPAMP_L_ST_UP | RT5631_PD_HPAMP_R_ST_UP);
 		msleep(80);
-		snd_soc_write(codec, RT5631_DEPOP_FUN_CTRL_1,
+		snd_soc_component_write(component, RT5631_DEPOP_FUN_CTRL_1,
 			RT5631_POW_ON_SOFT_GEN);
 
 		/* power down headphone and charge pump */
-		snd_soc_update_bits(codec, RT5631_PWR_MANAG_ADD3,
+		snd_soc_component_update_bits(component, RT5631_PWR_MANAG_ADD3,
 			RT5631_PWR_CHARGE_PUMP | RT5631_PWR_HP_L_AMP |
 			RT5631_PWR_HP_R_AMP, 0);
 	}
 
 	/* recover soft volume and zero crossing setting */
-	snd_soc_write(codec, RT5631_SOFT_VOL_CTRL, soft_vol);
-	snd_soc_write(codec, RT5631_INT_ST_IRQ_CTRL_2, hp_zc);
+	snd_soc_component_write(component, RT5631_SOFT_VOL_CTRL, soft_vol);
+	snd_soc_component_write(component, RT5631_INT_ST_IRQ_CTRL_2, hp_zc);
 }
 
 /**
@@ -515,75 +515,75 @@ static void depop_seq_power_stage(struct snd_soc_codec *codec, int enable)
  *
  * When mute/unmute headphone, the depop sequence is done in step by step.
  */
-static void depop_seq_mute_stage(struct snd_soc_codec *codec, int enable)
+static void depop_seq_mute_stage(struct snd_soc_component *component, int enable)
 {
 	unsigned int soft_vol, hp_zc;
 
 	/* depop control by register */
-	snd_soc_update_bits(codec, RT5631_DEPOP_FUN_CTRL_2,
+	snd_soc_component_update_bits(component, RT5631_DEPOP_FUN_CTRL_2,
 		RT5631_EN_ONE_BIT_DEPOP, RT5631_EN_ONE_BIT_DEPOP);
 
 	/* keep soft volume and zero crossing setting */
-	soft_vol = snd_soc_read(codec, RT5631_SOFT_VOL_CTRL);
-	snd_soc_write(codec, RT5631_SOFT_VOL_CTRL, 0);
-	hp_zc = snd_soc_read(codec, RT5631_INT_ST_IRQ_CTRL_2);
-	snd_soc_write(codec, RT5631_INT_ST_IRQ_CTRL_2, hp_zc & 0xf7ff);
+	soft_vol = snd_soc_component_read32(component, RT5631_SOFT_VOL_CTRL);
+	snd_soc_component_write(component, RT5631_SOFT_VOL_CTRL, 0);
+	hp_zc = snd_soc_component_read32(component, RT5631_INT_ST_IRQ_CTRL_2);
+	snd_soc_component_write(component, RT5631_INT_ST_IRQ_CTRL_2, hp_zc & 0xf7ff);
 	if (enable) {
 		schedule_timeout_uninterruptible(msecs_to_jiffies(10));
 
 		/* config depop sequence parameter */
-		rt5631_write_index(codec, RT5631_SPK_INTL_CTRL, 0x302f);
-		snd_soc_write(codec, RT5631_DEPOP_FUN_CTRL_1,
+		rt5631_write_index(component, RT5631_SPK_INTL_CTRL, 0x302f);
+		snd_soc_component_write(component, RT5631_DEPOP_FUN_CTRL_1,
 			RT5631_POW_ON_SOFT_GEN | RT5631_EN_MUTE_UNMUTE_DEPOP |
 			RT5631_EN_HP_R_M_UN_MUTE_DEPOP |
 			RT5631_EN_HP_L_M_UN_MUTE_DEPOP);
 
-		snd_soc_update_bits(codec, RT5631_HP_OUT_VOL,
+		snd_soc_component_update_bits(component, RT5631_HP_OUT_VOL,
 				RT5631_L_MUTE | RT5631_R_MUTE, 0);
 		msleep(160);
 	} else {
 		/* config depop sequence parameter */
-		rt5631_write_index(codec, RT5631_SPK_INTL_CTRL, 0x302f);
-		snd_soc_write(codec, RT5631_DEPOP_FUN_CTRL_1,
+		rt5631_write_index(component, RT5631_SPK_INTL_CTRL, 0x302f);
+		snd_soc_component_write(component, RT5631_DEPOP_FUN_CTRL_1,
 			RT5631_POW_ON_SOFT_GEN | RT5631_EN_MUTE_UNMUTE_DEPOP |
 			RT5631_EN_HP_R_M_UN_MUTE_DEPOP |
 			RT5631_EN_HP_L_M_UN_MUTE_DEPOP);
 
-		snd_soc_update_bits(codec, RT5631_HP_OUT_VOL,
+		snd_soc_component_update_bits(component, RT5631_HP_OUT_VOL,
 			RT5631_L_MUTE | RT5631_R_MUTE,
 			RT5631_L_MUTE | RT5631_R_MUTE);
 		msleep(150);
 	}
 
 	/* recover soft volume and zero crossing setting */
-	snd_soc_write(codec, RT5631_SOFT_VOL_CTRL, soft_vol);
-	snd_soc_write(codec, RT5631_INT_ST_IRQ_CTRL_2, hp_zc);
+	snd_soc_component_write(component, RT5631_SOFT_VOL_CTRL, soft_vol);
+	snd_soc_component_write(component, RT5631_INT_ST_IRQ_CTRL_2, hp_zc);
 }
 
 static int hp_event(struct snd_soc_dapm_widget *w,
 	struct snd_kcontrol *kcontrol, int event)
 {
-	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
-	struct rt5631_priv *rt5631 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
+	struct rt5631_priv *rt5631 = snd_soc_component_get_drvdata(component);
 
 	switch (event) {
 	case SND_SOC_DAPM_PRE_PMD:
 		if (rt5631->codec_version) {
-			onebit_depop_mute_stage(codec, 0);
-			onebit_depop_power_stage(codec, 0);
+			onebit_depop_mute_stage(component, 0);
+			onebit_depop_power_stage(component, 0);
 		} else {
-			depop_seq_mute_stage(codec, 0);
-			depop_seq_power_stage(codec, 0);
+			depop_seq_mute_stage(component, 0);
+			depop_seq_power_stage(component, 0);
 		}
 		break;
 
 	case SND_SOC_DAPM_POST_PMU:
 		if (rt5631->codec_version) {
-			onebit_depop_power_stage(codec, 1);
-			onebit_depop_mute_stage(codec, 1);
+			onebit_depop_power_stage(component, 1);
+			onebit_depop_mute_stage(component, 1);
 		} else {
-			depop_seq_power_stage(codec, 1);
-			depop_seq_mute_stage(codec, 1);
+			depop_seq_power_stage(component, 1);
+			depop_seq_mute_stage(component, 1);
 		}
 		break;
 
@@ -597,20 +597,20 @@ static int hp_event(struct snd_soc_dapm_widget *w,
 static int set_dmic_params(struct snd_soc_dapm_widget *w,
 	struct snd_kcontrol *kcontrol, int event)
 {
-	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
-	struct rt5631_priv *rt5631 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
+	struct rt5631_priv *rt5631 = snd_soc_component_get_drvdata(component);
 
 	switch (rt5631->rx_rate) {
 	case 44100:
 	case 48000:
-		snd_soc_update_bits(codec, RT5631_DIG_MIC_CTRL,
+		snd_soc_component_update_bits(component, RT5631_DIG_MIC_CTRL,
 			RT5631_DMIC_CLK_CTRL_MASK,
 			RT5631_DMIC_CLK_CTRL_TO_32FS);
 		break;
 
 	case 32000:
 	case 22050:
-		snd_soc_update_bits(codec, RT5631_DIG_MIC_CTRL,
+		snd_soc_component_update_bits(component, RT5631_DIG_MIC_CTRL,
 			RT5631_DMIC_CLK_CTRL_MASK,
 			RT5631_DMIC_CLK_CTRL_TO_64FS);
 		break;
@@ -618,7 +618,7 @@ static int set_dmic_params(struct snd_soc_dapm_widget *w,
 	case 16000:
 	case 11025:
 	case 8000:
-		snd_soc_update_bits(codec, RT5631_DIG_MIC_CTRL,
+		snd_soc_component_update_bits(component, RT5631_DIG_MIC_CTRL,
 			RT5631_DMIC_CLK_CTRL_MASK,
 			RT5631_DMIC_CLK_CTRL_TO_128FS);
 		break;
@@ -1352,16 +1352,16 @@ static int get_coeff(int mclk, int rate, int timesofbclk)
 static int rt5631_hifi_pcm_params(struct snd_pcm_substream *substream,
 		struct snd_pcm_hw_params *params, struct snd_soc_dai *dai)
 {
-	struct snd_soc_codec *codec = dai->codec;
-	struct rt5631_priv *rt5631 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = dai->component;
+	struct rt5631_priv *rt5631 = snd_soc_component_get_drvdata(component);
 	int timesofbclk = 32, coeff;
 	unsigned int iface = 0;
 
-	dev_dbg(codec->dev, "enter %s\n", __func__);
+	dev_dbg(component->dev, "enter %s\n", __func__);
 
 	rt5631->bclk_rate = snd_soc_params_to_bclk(params);
 	if (rt5631->bclk_rate < 0) {
-		dev_err(codec->dev, "Fail to get BCLK rate\n");
+		dev_err(component->dev, "Fail to get BCLK rate\n");
 		return rt5631->bclk_rate;
 	}
 	rt5631->rx_rate = params_rate(params);
@@ -1373,7 +1373,7 @@ static int rt5631_hifi_pcm_params(struct snd_pcm_substream *substream,
 		coeff = get_coeff(rt5631->sysclk, rt5631->rx_rate,
 					timesofbclk);
 	if (coeff < 0) {
-		dev_err(codec->dev, "Fail to get coeff\n");
+		dev_err(component->dev, "Fail to get coeff\n");
 		return coeff;
 	}
 
@@ -1393,9 +1393,9 @@ static int rt5631_hifi_pcm_params(struct snd_pcm_substream *substream,
 		return -EINVAL;
 	}
 
-	snd_soc_update_bits(codec, RT5631_SDP_CTRL,
+	snd_soc_component_update_bits(component, RT5631_SDP_CTRL,
 		RT5631_SDP_I2S_DL_MASK, iface);
-	snd_soc_write(codec, RT5631_STEREO_AD_DA_CLK_CTRL,
+	snd_soc_component_write(component, RT5631_STEREO_AD_DA_CLK_CTRL,
 					coeff_div[coeff].reg_val);
 
 	return 0;
@@ -1404,11 +1404,11 @@ static int rt5631_hifi_pcm_params(struct snd_pcm_substream *substream,
 static int rt5631_hifi_codec_set_dai_fmt(struct snd_soc_dai *codec_dai,
 						unsigned int fmt)
 {
-	struct snd_soc_codec *codec = codec_dai->codec;
-	struct rt5631_priv *rt5631 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = codec_dai->component;
+	struct rt5631_priv *rt5631 = snd_soc_component_get_drvdata(component);
 	unsigned int iface = 0;
 
-	dev_dbg(codec->dev, "enter %s\n", __func__);
+	dev_dbg(component->dev, "enter %s\n", __func__);
 
 	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
 	case SND_SOC_DAIFMT_CBM_CFM:
@@ -1448,7 +1448,7 @@ static int rt5631_hifi_codec_set_dai_fmt(struct snd_soc_dai *codec_dai,
 		return -EINVAL;
 	}
 
-	snd_soc_write(codec, RT5631_SDP_CTRL, iface);
+	snd_soc_component_write(component, RT5631_SDP_CTRL, iface);
 
 	return 0;
 }
@@ -1456,10 +1456,10 @@ static int rt5631_hifi_codec_set_dai_fmt(struct snd_soc_dai *codec_dai,
 static int rt5631_hifi_codec_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 				int clk_id, unsigned int freq, int dir)
 {
-	struct snd_soc_codec *codec = codec_dai->codec;
-	struct rt5631_priv *rt5631 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = codec_dai->component;
+	struct rt5631_priv *rt5631 = snd_soc_component_get_drvdata(component);
 
-	dev_dbg(codec->dev, "enter %s, syclk=%d\n", __func__, freq);
+	dev_dbg(component->dev, "enter %s, syclk=%d\n", __func__, freq);
 
 	if ((freq >= (256 * 8000)) && (freq <= (512 * 96000))) {
 		rt5631->sysclk = freq;
@@ -1472,16 +1472,16 @@ static int rt5631_hifi_codec_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 static int rt5631_codec_set_dai_pll(struct snd_soc_dai *codec_dai, int pll_id,
 		int source, unsigned int freq_in, unsigned int freq_out)
 {
-	struct snd_soc_codec *codec = codec_dai->codec;
-	struct rt5631_priv *rt5631 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = codec_dai->component;
+	struct rt5631_priv *rt5631 = snd_soc_component_get_drvdata(component);
 	int i, ret = -EINVAL;
 
-	dev_dbg(codec->dev, "enter %s\n", __func__);
+	dev_dbg(component->dev, "enter %s\n", __func__);
 
 	if (!freq_in || !freq_out) {
-		dev_dbg(codec->dev, "PLL disabled\n");
+		dev_dbg(component->dev, "PLL disabled\n");
 
-		snd_soc_update_bits(codec, RT5631_GLOBAL_CLK_CTRL,
+		snd_soc_component_update_bits(component, RT5631_GLOBAL_CLK_CTRL,
 			RT5631_SYSCLK_SOUR_SEL_MASK,
 			RT5631_SYSCLK_SOUR_SEL_MCLK);
 
@@ -1492,13 +1492,13 @@ static int rt5631_codec_set_dai_pll(struct snd_soc_dai *codec_dai, int pll_id,
 		for (i = 0; i < ARRAY_SIZE(codec_master_pll_div); i++)
 			if (freq_in == codec_master_pll_div[i].pll_in &&
 			freq_out == codec_master_pll_div[i].pll_out) {
-				dev_info(codec->dev,
+				dev_info(component->dev,
 					"change PLL in master mode\n");
-				snd_soc_write(codec, RT5631_PLL_CTRL,
+				snd_soc_component_write(component, RT5631_PLL_CTRL,
 					codec_master_pll_div[i].reg_val);
 				schedule_timeout_uninterruptible(
 					msecs_to_jiffies(20));
-				snd_soc_update_bits(codec,
+				snd_soc_component_update_bits(component,
 					RT5631_GLOBAL_CLK_CTRL,
 					RT5631_SYSCLK_SOUR_SEL_MASK |
 					RT5631_PLLCLK_SOUR_SEL_MASK,
@@ -1511,13 +1511,13 @@ static int rt5631_codec_set_dai_pll(struct snd_soc_dai *codec_dai, int pll_id,
 		for (i = 0; i < ARRAY_SIZE(codec_slave_pll_div); i++)
 			if (freq_in == codec_slave_pll_div[i].pll_in &&
 			freq_out == codec_slave_pll_div[i].pll_out) {
-				dev_info(codec->dev,
+				dev_info(component->dev,
 					"change PLL in slave mode\n");
-				snd_soc_write(codec, RT5631_PLL_CTRL,
+				snd_soc_component_write(component, RT5631_PLL_CTRL,
 					codec_slave_pll_div[i].reg_val);
 				schedule_timeout_uninterruptible(
 					msecs_to_jiffies(20));
-				snd_soc_update_bits(codec,
+				snd_soc_component_update_bits(component,
 					RT5631_GLOBAL_CLK_CTRL,
 					RT5631_SYSCLK_SOUR_SEL_MASK |
 					RT5631_PLLCLK_SOUR_SEL_MASK,
@@ -1531,26 +1531,26 @@ static int rt5631_codec_set_dai_pll(struct snd_soc_dai *codec_dai, int pll_id,
 	return ret;
 }
 
-static int rt5631_set_bias_level(struct snd_soc_codec *codec,
+static int rt5631_set_bias_level(struct snd_soc_component *component,
 			enum snd_soc_bias_level level)
 {
-	struct rt5631_priv *rt5631 = snd_soc_codec_get_drvdata(codec);
+	struct rt5631_priv *rt5631 = snd_soc_component_get_drvdata(component);
 
 	switch (level) {
 	case SND_SOC_BIAS_ON:
 	case SND_SOC_BIAS_PREPARE:
-		snd_soc_update_bits(codec, RT5631_PWR_MANAG_ADD2,
+		snd_soc_component_update_bits(component, RT5631_PWR_MANAG_ADD2,
 			RT5631_PWR_MICBIAS1_VOL | RT5631_PWR_MICBIAS2_VOL,
 			RT5631_PWR_MICBIAS1_VOL | RT5631_PWR_MICBIAS2_VOL);
 		break;
 
 	case SND_SOC_BIAS_STANDBY:
-		if (snd_soc_codec_get_bias_level(codec) == SND_SOC_BIAS_OFF) {
-			snd_soc_update_bits(codec, RT5631_PWR_MANAG_ADD3,
+		if (snd_soc_component_get_bias_level(component) == SND_SOC_BIAS_OFF) {
+			snd_soc_component_update_bits(component, RT5631_PWR_MANAG_ADD3,
 				RT5631_PWR_VREF | RT5631_PWR_MAIN_BIAS,
 				RT5631_PWR_VREF | RT5631_PWR_MAIN_BIAS);
 			msleep(80);
-			snd_soc_update_bits(codec, RT5631_PWR_MANAG_ADD3,
+			snd_soc_component_update_bits(component, RT5631_PWR_MANAG_ADD3,
 				RT5631_PWR_FAST_VREF_CTRL,
 				RT5631_PWR_FAST_VREF_CTRL);
 			regcache_cache_only(rt5631->regmap, false);
@@ -1559,10 +1559,10 @@ static int rt5631_set_bias_level(struct snd_soc_codec *codec,
 		break;
 
 	case SND_SOC_BIAS_OFF:
-		snd_soc_write(codec, RT5631_PWR_MANAG_ADD1, 0x0000);
-		snd_soc_write(codec, RT5631_PWR_MANAG_ADD2, 0x0000);
-		snd_soc_write(codec, RT5631_PWR_MANAG_ADD3, 0x0000);
-		snd_soc_write(codec, RT5631_PWR_MANAG_ADD4, 0x0000);
+		snd_soc_component_write(component, RT5631_PWR_MANAG_ADD1, 0x0000);
+		snd_soc_component_write(component, RT5631_PWR_MANAG_ADD2, 0x0000);
+		snd_soc_component_write(component, RT5631_PWR_MANAG_ADD3, 0x0000);
+		snd_soc_component_write(component, RT5631_PWR_MANAG_ADD4, 0x0000);
 		break;
 
 	default:
@@ -1572,48 +1572,48 @@ static int rt5631_set_bias_level(struct snd_soc_codec *codec,
 	return 0;
 }
 
-static int rt5631_probe(struct snd_soc_codec *codec)
+static int rt5631_probe(struct snd_soc_component *component)
 {
-	struct rt5631_priv *rt5631 = snd_soc_codec_get_drvdata(codec);
+	struct rt5631_priv *rt5631 = snd_soc_component_get_drvdata(component);
 	unsigned int val;
 
-	val = rt5631_read_index(codec, RT5631_ADDA_MIXER_INTL_REG3);
+	val = rt5631_read_index(component, RT5631_ADDA_MIXER_INTL_REG3);
 	if (val & 0x0002)
 		rt5631->codec_version = 1;
 	else
 		rt5631->codec_version = 0;
 
-	rt5631_reset(codec);
-	snd_soc_update_bits(codec, RT5631_PWR_MANAG_ADD3,
+	rt5631_reset(component);
+	snd_soc_component_update_bits(component, RT5631_PWR_MANAG_ADD3,
 		RT5631_PWR_VREF | RT5631_PWR_MAIN_BIAS,
 		RT5631_PWR_VREF | RT5631_PWR_MAIN_BIAS);
 	msleep(80);
-	snd_soc_update_bits(codec, RT5631_PWR_MANAG_ADD3,
+	snd_soc_component_update_bits(component, RT5631_PWR_MANAG_ADD3,
 		RT5631_PWR_FAST_VREF_CTRL, RT5631_PWR_FAST_VREF_CTRL);
 	/* enable HP zero cross */
-	snd_soc_write(codec, RT5631_INT_ST_IRQ_CTRL_2, 0x0f18);
+	snd_soc_component_write(component, RT5631_INT_ST_IRQ_CTRL_2, 0x0f18);
 	/* power off ClassD auto Recovery */
 	if (rt5631->codec_version)
-		snd_soc_update_bits(codec, RT5631_INT_ST_IRQ_CTRL_2,
+		snd_soc_component_update_bits(component, RT5631_INT_ST_IRQ_CTRL_2,
 					0x2000, 0x2000);
 	else
-		snd_soc_update_bits(codec, RT5631_INT_ST_IRQ_CTRL_2,
+		snd_soc_component_update_bits(component, RT5631_INT_ST_IRQ_CTRL_2,
 					0x2000, 0);
 	/* DMIC */
 	if (rt5631->dmic_used_flag) {
-		snd_soc_update_bits(codec, RT5631_GPIO_CTRL,
+		snd_soc_component_update_bits(component, RT5631_GPIO_CTRL,
 			RT5631_GPIO_PIN_FUN_SEL_MASK |
 			RT5631_GPIO_DMIC_FUN_SEL_MASK,
 			RT5631_GPIO_PIN_FUN_SEL_GPIO_DIMC |
 			RT5631_GPIO_DMIC_FUN_SEL_DIMC);
-		snd_soc_update_bits(codec, RT5631_DIG_MIC_CTRL,
+		snd_soc_component_update_bits(component, RT5631_DIG_MIC_CTRL,
 			RT5631_DMIC_L_CH_LATCH_MASK |
 			RT5631_DMIC_R_CH_LATCH_MASK,
 			RT5631_DMIC_L_CH_LATCH_FALLING |
 			RT5631_DMIC_R_CH_LATCH_RISING);
 	}
 
-	snd_soc_codec_init_bias_level(codec, SND_SOC_BIAS_STANDBY);
+	snd_soc_component_init_bias_level(component, SND_SOC_BIAS_STANDBY);
 
 	return 0;
 }
@@ -1653,18 +1653,20 @@ static struct snd_soc_dai_driver rt5631_dai[] = {
 	},
 };
 
-static const struct snd_soc_codec_driver soc_codec_dev_rt5631 = {
-	.probe = rt5631_probe,
-	.set_bias_level = rt5631_set_bias_level,
-	.suspend_bias_off = true,
-	.component_driver = {
-		.controls		= rt5631_snd_controls,
-		.num_controls		= ARRAY_SIZE(rt5631_snd_controls),
-		.dapm_widgets		= rt5631_dapm_widgets,
-		.num_dapm_widgets	= ARRAY_SIZE(rt5631_dapm_widgets),
-		.dapm_routes		= rt5631_dapm_routes,
-		.num_dapm_routes	= ARRAY_SIZE(rt5631_dapm_routes),
-	},
+static const struct snd_soc_component_driver soc_component_dev_rt5631 = {
+	.probe			= rt5631_probe,
+	.set_bias_level		= rt5631_set_bias_level,
+	.controls		= rt5631_snd_controls,
+	.num_controls		= ARRAY_SIZE(rt5631_snd_controls),
+	.dapm_widgets		= rt5631_dapm_widgets,
+	.num_dapm_widgets	= ARRAY_SIZE(rt5631_dapm_widgets),
+	.dapm_routes		= rt5631_dapm_routes,
+	.num_dapm_routes	= ARRAY_SIZE(rt5631_dapm_routes),
+	.suspend_bias_off	= 1,
+	.idle_bias_on		= 1,
+	.use_pmdown_time	= 1,
+	.endianness		= 1,
+	.non_legacy_dai_naming	= 1,
 };
 
 static const struct i2c_device_id rt5631_i2c_id[] = {
@@ -1712,14 +1714,14 @@ static int rt5631_i2c_probe(struct i2c_client *i2c,
 	if (IS_ERR(rt5631->regmap))
 		return PTR_ERR(rt5631->regmap);
 
-	ret = snd_soc_register_codec(&i2c->dev, &soc_codec_dev_rt5631,
+	ret = devm_snd_soc_register_component(&i2c->dev,
+			&soc_component_dev_rt5631,
 			rt5631_dai, ARRAY_SIZE(rt5631_dai));
 	return ret;
 }
 
 static int rt5631_i2c_remove(struct i2c_client *client)
 {
-	snd_soc_unregister_codec(&client->dev);
 	return 0;
 }
 
-- 
2.16.1
