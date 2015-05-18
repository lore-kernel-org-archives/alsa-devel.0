From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Subject: [PATCH v2 7/9] ASoC: Codec: Add sti platform codec
Date: Mon, 18 May 2015 14:12:54 +0200
Message-ID: <1431951176-24670-8-git-send-email-arnaud.pouliquen@st.com>
References: <1431951176-24670-1-git-send-email-arnaud.pouliquen@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [62.209.51.94]) by alsa0.perex.cz (Postfix) with ESMTP id 850BE260670
 for <alsa-devel@alsa-project.org>; Mon, 18 May 2015 14:13:22 +0200 (CEST)
In-Reply-To: <1431951176-24670-1-git-send-email-arnaud.pouliquen@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: broonie@kernel.org, arnaud.pouliquen@st.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

Codec part of the STi platform that support codec IPs.
This first version does not support HDMI, but only DAC and SPDIF out.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
---
 sound/soc/codecs/Kconfig   |   4 +
 sound/soc/codecs/Makefile  |   2 +
 sound/soc/codecs/sti-sas.c | 645 +++++++++++++++++++++++++++++++++++++++++++++
 sound/soc/sti/Kconfig      |   6 +
 4 files changed, 657 insertions(+)
 create mode 100644 sound/soc/codecs/sti-sas.c

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 061c465..f3fe64e 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -102,6 +102,7 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_STA350 if I2C
 	select SND_SOC_STA529 if I2C
 	select SND_SOC_STAC9766 if SND_SOC_AC97_BUS
+	select SND_SOC_STI_SAS
 	select SND_SOC_TAS2552 if I2C
 	select SND_SOC_TAS5086 if I2C
 	select SND_SOC_TFA9879 if I2C
@@ -603,6 +604,9 @@ config SND_SOC_STA529
 config SND_SOC_STAC9766
 	tristate
 
+config SND_SOC_STI_SAS
+	tristate
+
 config SND_SOC_TAS2552
 	tristate "Texas Instruments TAS2552 Mono Audio amplifier"
 	depends on I2C
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index abe2d7e..249ef0d 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -105,6 +105,7 @@ snd-soc-sta32x-objs := sta32x.o
 snd-soc-sta350-objs := sta350.o
 snd-soc-sta529-objs := sta529.o
 snd-soc-stac9766-objs := stac9766.o
+snd-soc-sti-sas-objs := sti-sas.o
 snd-soc-tas5086-objs := tas5086.o
 snd-soc-tfa9879-objs := tfa9879.o
 snd-soc-tlv320aic23-objs := tlv320aic23.o
@@ -286,6 +287,7 @@ obj-$(CONFIG_SND_SOC_STA32X)   += snd-soc-sta32x.o
 obj-$(CONFIG_SND_SOC_STA350)   += snd-soc-sta350.o
 obj-$(CONFIG_SND_SOC_STA529)   += snd-soc-sta529.o
 obj-$(CONFIG_SND_SOC_STAC9766)	+= snd-soc-stac9766.o
+obj-$(CONFIG_SND_SOC_STI_SAS)	+= snd-soc-sti-sas.o
 obj-$(CONFIG_SND_SOC_TAS2552)	+= snd-soc-tas2552.o
 obj-$(CONFIG_SND_SOC_TAS5086)	+= snd-soc-tas5086.o
 obj-$(CONFIG_SND_SOC_TFA9879)	+= snd-soc-tfa9879.o
diff --git a/sound/soc/codecs/sti-sas.c b/sound/soc/codecs/sti-sas.c
new file mode 100644
index 0000000..6cd4c1d
--- /dev/null
+++ b/sound/soc/codecs/sti-sas.c
@@ -0,0 +1,645 @@
+/*
+ * Copyright (C) STMicroelectronics SA 2015
+ * Authors: Arnaud Pouliquen <arnaud.pouliquen@st.com>
+ *          for STMicroelectronics.
+ * License terms:  GNU General Public License (GPL), version 2
+ */
+
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+#include <linux/reset.h>
+#include <linux/mfd/syscon.h>
+
+#include <sound/soc.h>
+#include <sound/soc-dapm.h>
+
+/* chipID supported */
+#define CHIPID_STIH416 0
+#define CHIPID_STIH407 1
+
+/* DAC definitions */
+
+/* stih416 DAC registers */
+/* sysconf 2517: Audio-DAC-Control */
+#define STIH416_AUDIO_DAC_CTRL 0x00000814
+/* sysconf 2519: Audio-Gue-Control */
+#define STIH416_AUDIO_GLUE_CTRL 0x0000081C
+
+/* stih407 DAC registers */
+/* sysconf 5041: Audio-Gue-Control */
+#define STIH407_AUDIO_GLUE_CTRL 0x000000A4
+/* sysconf 5042: Audio-DAC-Control */
+#define STIH407_AUDIO_DAC_CTRL 0x000000A8
+
+enum {
+	STI_SAS_DAI_SPDIF_OUT,
+	STI_SAS_DAI_ANALOG_OUT,
+};
+
+enum {
+	BIPHASE_ENABLE,
+	BIPHASE_IDLE,
+	STI_SPDIF_MAX_RF
+};
+
+enum {
+	STIH416_DAC_MODE,
+	STIH416_DAC_NOT_STANDBY,
+	STIH416_DAC_SOFTMUTE,
+	STIH416_DAC_ANALOG_PWR_DW,
+	STIH416_DAC_ANALOG_NOT_PWR_DW_BG,
+	STIH416_DAC_MAX_RF
+};
+
+enum {
+	STIH407_DAC_SOFTMUTE,
+	STIH407_DAC_STANDBY_ANA,
+	STIH407_DAC_STANDBY,
+	STIH407_DAC_MAX_RF
+};
+
+/* DAC configuration fields */
+const struct reg_field sti_sas_dac_stih416[STIH416_DAC_MAX_RF] = {
+	/*STIH416_DAC_MODE*/
+	REG_FIELD(STIH416_AUDIO_DAC_CTRL, 1, 2),
+	/*STIH416_DAC_NOT_STANDBY */
+	REG_FIELD(STIH416_AUDIO_DAC_CTRL, 3, 3),
+	/*STIH416_DAC_SOFTMUTE*/
+	REG_FIELD(STIH416_AUDIO_DAC_CTRL, 4, 4),
+	/*STIH416_DAC_ANALOG_PWR_DW*/
+	REG_FIELD(STIH416_AUDIO_DAC_CTRL, 5, 5),
+	/*STIH416_DAC_ANALOG_NOT_PWR_DW_BG*/
+	REG_FIELD(STIH416_AUDIO_DAC_CTRL, 6, 6),
+};
+
+const struct reg_field sti_sas_dac_stih407[STIH407_DAC_MAX_RF] = {
+	/*STIH407_DAC_SOFTMUTE*/
+	REG_FIELD(STIH407_AUDIO_DAC_CTRL, 0, 0),
+	/*STIH407_DAC_STANDBY_ANA*/
+	REG_FIELD(STIH407_AUDIO_DAC_CTRL, 1, 1),
+	/*STIH407_DAC_STANDBY */
+	REG_FIELD(STIH407_AUDIO_DAC_CTRL, 2, 2),
+};
+
+/* SPDIF configuration fields */
+const struct reg_field sti_sas_spdif_stih416[STI_SPDIF_MAX_RF] = {
+	/*BIPHASE_ENABLE */
+	REG_FIELD(STIH416_AUDIO_GLUE_CTRL, 6, 6),
+	/*BIPHASE_IDLE*/
+	REG_FIELD(STIH416_AUDIO_GLUE_CTRL, 7, 7),
+};
+
+const struct reg_field sti_sas_spdif_stih407[STI_SPDIF_MAX_RF] = {
+	/*BIPHASE_ENABLE */
+	REG_FIELD(STIH407_AUDIO_GLUE_CTRL, 6, 6),
+	/*BIPHASE_IDLE*/
+	REG_FIELD(STIH407_AUDIO_GLUE_CTRL, 7, 7),
+};
+
+struct sti_dac_audio {
+	struct regmap *regmap;
+	struct regmap_field  **field;
+	struct reset_control *rst;
+};
+
+struct sti_spdif_audio {
+	struct regmap *regmap;
+	struct regmap_field  **field;
+};
+
+const int sti_sas_dai_clk_div[];
+
+/* device data structure */
+struct sti_sas_dev_data {
+	const int chipid; /* IC version */
+	const struct reg_field *dac; /* DAC register description*/
+	const struct snd_soc_dai_ops *dac_ops;  /* DAC function callbacks */
+	const struct reg_field *spdif; /* SPDIFF register description */
+	const struct snd_soc_dapm_widget *dapm_widgets; /* dapms declaration */
+	const int num_dapm_widgets; /* dapms declaration */
+};
+
+/* driver data structure */
+struct sti_sas_data {
+	struct device *dev;
+	const struct sti_sas_dev_data *dev_data;
+	struct sti_dac_audio dac;
+	struct sti_spdif_audio spdif;
+};
+
+static int sti_sas_map_sas_registers(struct sti_sas_data *data)
+{
+	struct sti_spdif_audio *spdif = &data->spdif;
+	const struct reg_field *spdif_reg = data->dev_data->spdif;
+	struct sti_dac_audio *dac = &data->dac;
+	const struct reg_field *dac_reg = data->dev_data->dac;
+	int i, max_rf;
+
+	/* Allocate device structure */
+	spdif->field = devm_kzalloc(data->dev,
+			     sizeof(struct regmap_field *) * STI_SPDIF_MAX_RF,
+			     GFP_KERNEL);
+	if (!spdif->field)
+		return -ENOMEM;
+
+	if (data->dev_data->chipid == CHIPID_STIH407)
+		max_rf = STIH407_DAC_MAX_RF;
+	else
+		max_rf = STIH416_DAC_MAX_RF;
+	dac->field = devm_kzalloc(data->dev,
+				  sizeof(struct regmap_field *) * max_rf,
+				  GFP_KERNEL);
+	if (!dac->field)
+		return -ENOMEM;
+
+	/* Get spdif regmap fields */
+	for (i = 0; i < STI_SPDIF_MAX_RF; i++)
+		spdif->field[i] = regmap_field_alloc(spdif->regmap,
+						     spdif_reg[i]);
+	/* Get DAC regmap fields */
+	for (i = 0; i < max_rf; i++)
+		dac->field[i] = regmap_field_alloc(dac->regmap, dac_reg[i]);
+
+	return 0;
+}
+
+static int  sti_sas_init_sas_registers(struct device *dev,
+				       struct sti_sas_data *data)
+{
+	struct sti_spdif_audio *spdif = &data->spdif;
+	struct sti_dac_audio *dac = &data->dac;
+	int ret;
+	/*
+	 * DAC and SPDIF are activated by default
+	 * put them in IDLE to save power
+	 */
+
+	/* Initialise bi-phase formatter to disabled */
+	ret = regmap_field_write(spdif->field[BIPHASE_ENABLE], 0);
+
+	if (!ret)
+		/* Initialise bi-phase formatter idle value to 0 */
+		ret = regmap_field_write(spdif->field[BIPHASE_IDLE], 0);
+	if (ret < 0) {
+		dev_err(dev, "Failed to update SPDIF registers");
+		return ret;
+	}
+
+	/* Init DAC configuration */
+	if (data->dev_data->chipid == CHIPID_STIH407) {
+		/* init configuration */
+		ret = regmap_field_write(
+			dac->field[STIH407_DAC_STANDBY], 1);
+
+		if (!ret)
+			ret = regmap_field_write(
+				dac->field[STIH407_DAC_STANDBY_ANA], 1);
+		if (!ret)
+			ret = regmap_field_write(
+				dac->field[STIH407_DAC_SOFTMUTE], 1);
+	} else if (data->dev_data->chipid == CHIPID_STIH416) {
+		ret = regmap_field_write(
+			dac->field[STIH416_DAC_NOT_STANDBY], 0);
+		if (!ret)
+			ret = regmap_field_write(
+				dac->field[STIH416_DAC_ANALOG_PWR_DW], 0);
+		if (!ret)
+			ret = regmap_field_write(
+				dac->field[STIH416_DAC_ANALOG_NOT_PWR_DW_BG],
+				0);
+		if (!ret)
+			ret = regmap_field_write(
+				dac->field[STIH416_DAC_SOFTMUTE], 1);
+	}
+
+	if (ret < 0) {
+		dev_err(dev, "Failed to update DAC registers");
+		return ret;
+	}
+
+	return ret;
+}
+
+/*
+ * DAC
+ */
+static int sti_sas_dac_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
+{
+	/* Sanity check only */
+	if ((fmt & SND_SOC_DAIFMT_MASTER_MASK) != SND_SOC_DAIFMT_CBS_CFS) {
+		dev_err(dai->codec->dev,
+			"%s: ERROR: Unsupporter master mask 0x%x\n",
+			__func__, fmt & SND_SOC_DAIFMT_MASTER_MASK);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int stih416_dac_probe(struct snd_soc_dai *dai)
+{
+	struct snd_soc_codec *codec = dai->codec;
+	struct sti_sas_data *drvdata = dev_get_drvdata(codec->dev);
+	struct sti_dac_audio *dac = &drvdata->dac;
+
+	/* Get reset control */
+	dac->rst = devm_reset_control_get(codec->dev, "dac_rst");
+	if (IS_ERR(dac->rst)) {
+		dev_err(dai->codec->dev,
+			"%s: ERROR: DAC reset control not defined (%d)!\n",
+			__func__, (int)dac->rst);
+		dac->rst = NULL;
+		return -EFAULT;
+	}
+	/* Put the DAC into reset */
+	reset_control_assert(dac->rst);
+
+	return 0;
+}
+
+static int  stih416_sas_dac_supply(struct snd_soc_dapm_widget *w,
+				   struct snd_kcontrol *kcontrol, int event) {
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
+	struct sti_sas_data *drvdata = dev_get_drvdata(codec->dev);
+	struct sti_dac_audio *dac = &drvdata->dac;
+	int ret = 0;
+
+	switch (event) {
+	case SND_SOC_DAPM_PRE_PMU:
+		/* Take the DAC out of reset */
+		reset_control_deassert(dac->rst);
+
+		/* Enable analog */
+		ret = regmap_field_write(
+			dac->field[STIH416_DAC_ANALOG_NOT_PWR_DW_BG], 1);
+		if (!ret)
+			ret = regmap_field_write(
+				dac->field[STIH416_DAC_ANALOG_PWR_DW], 1);
+		/* Disable standby */
+		if (!ret)
+			ret = regmap_field_write(
+				dac->field[STIH416_DAC_NOT_STANDBY], 1);
+
+		break;
+
+	case SND_SOC_DAPM_POST_PMD:
+
+		/* Enable standby */
+		ret = regmap_field_write(
+			dac->field[STIH416_DAC_NOT_STANDBY], 0);
+		/* Disable analog */
+		if (!ret)
+			ret = regmap_field_write(
+				dac->field[STIH416_DAC_ANALOG_PWR_DW], 0);
+		if (!ret)
+			ret = regmap_field_write(
+				dac->field[STIH416_DAC_ANALOG_NOT_PWR_DW_BG],
+				0);
+		/* Put the DAC into reset */
+		reset_control_assert(dac->rst);
+		break;
+	}
+
+	return ret;
+}
+
+static int  stih407_sas_dac_supply(struct snd_soc_dapm_widget *w,
+				   struct snd_kcontrol *kcontrol, int event) {
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
+	struct sti_sas_data *drvdata = dev_get_drvdata(codec->dev);
+	struct sti_dac_audio *dac = &drvdata->dac;
+	int ret = 0;
+
+	switch (event) {
+	case SND_SOC_DAPM_PRE_PMU:
+		/* Enable analog */
+		ret = regmap_field_write(dac->field[STIH407_DAC_STANDBY_ANA],
+					 0);
+		/* Disable standby */
+		if (!ret)
+			ret = regmap_field_write(
+				dac->field[STIH407_DAC_STANDBY], 0);
+		break;
+
+	case SND_SOC_DAPM_POST_PMD:
+		/* Enable standby */
+		ret = regmap_field_write(dac->field[STIH407_DAC_STANDBY], 1);
+		/* Disable analog */
+		if (!ret)
+			ret = regmap_field_write(
+				dac->field[STIH407_DAC_STANDBY_ANA], 1);
+		break;
+	}
+
+	return ret;
+}
+
+const struct snd_soc_dapm_widget stih416_sas_dapm_widgets[] = {
+	SND_SOC_DAPM_DAC_E("DAC enable", "dac_p", SND_SOC_NOPM, 0, 0,
+			   stih416_sas_dac_supply,
+			   SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
+	SND_SOC_DAPM_OUTPUT("DAC Output"),
+};
+
+const struct snd_soc_dapm_widget stih407_sas_dapm_widgets[] = {
+	SND_SOC_DAPM_DAC_E("DAC enable", "dac_p", SND_SOC_NOPM, 0, 0,
+			   stih407_sas_dac_supply,
+			   SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
+	SND_SOC_DAPM_OUTPUT("DAC Output"),
+};
+
+const struct snd_soc_dapm_route sti_sas_route[] = {
+	{"DAC Output", NULL, "DAC enable"},
+};
+
+static int stih416_sas_dac_mute(struct snd_soc_dai *dai, int mute, int stream)
+{
+	struct snd_soc_codec *codec = dai->codec;
+	struct sti_sas_data *drvdata = dev_get_drvdata(codec->dev);
+	struct sti_dac_audio *dac = &drvdata->dac;
+
+	if (mute)
+		return regmap_field_write(
+			dac->field[STIH416_DAC_SOFTMUTE], 1);
+	else
+		return regmap_field_write(
+			dac->field[STIH416_DAC_SOFTMUTE], 0);
+}
+
+static int stih407_sas_dac_mute(struct snd_soc_dai *dai, int mute, int stream)
+{
+	struct snd_soc_codec *codec = dai->codec;
+	struct sti_sas_data *drvdata = dev_get_drvdata(codec->dev);
+	struct sti_dac_audio *dac = &drvdata->dac;
+
+	if (mute)
+		return regmap_field_write(
+			dac->field[STIH407_DAC_SOFTMUTE], 1);
+	else
+		return regmap_field_write(
+			dac->field[STIH407_DAC_SOFTMUTE], 0);
+}
+
+/*
+ * SPDIF
+ */
+static int sti_sas_spdif_set_fmt(struct snd_soc_dai *dai,
+				 unsigned int fmt)
+{
+	if ((fmt & SND_SOC_DAIFMT_MASTER_MASK) != SND_SOC_DAIFMT_CBS_CFS) {
+		dev_err(dai->codec->dev,
+			"%s: ERROR: Unsupporter master mask 0x%x\n",
+			__func__, fmt & SND_SOC_DAIFMT_MASTER_MASK);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+/*
+ * sti_sas_spdif_trigger:
+ * Trigger function is used to ensure that BiPhase Formater is disabled
+ * before CPU dai is stopped.
+ * This is mandatory to avoid that BPF is stalled
+ */
+static int sti_sas_spdif_trigger(struct snd_pcm_substream *substream, int cmd,
+				 struct snd_soc_dai *dai)
+{
+	struct snd_soc_codec *codec = dai->codec;
+	struct sti_sas_data *drvdata = dev_get_drvdata(codec->dev);
+	struct sti_spdif_audio *spdif =  &drvdata->spdif;
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+		return regmap_field_write(spdif->field[BIPHASE_ENABLE],
+					  1);
+		break;
+
+	case SNDRV_PCM_TRIGGER_RESUME:
+	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+	case SNDRV_PCM_TRIGGER_STOP:
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+		return regmap_field_write(spdif->field[BIPHASE_ENABLE],
+					  0);
+		break;
+	default:
+		return -EINVAL;
+	}
+}
+
+/*
+ * CODEC DAIS
+ */
+
+/*
+ * sti_sas_hw_params:
+ * Request MCLK-FS clocks division to CPU_DAI based on requested rate
+ */
+static int sti_sas_hw_params(struct snd_pcm_substream *substream,
+			     struct snd_pcm_hw_params *params,
+			     struct snd_soc_dai *dai)
+{
+	struct snd_soc_codec *codec = dai->codec;
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
+	int div;
+
+	div = sti_sas_dai_clk_div[dai->id];
+	if (cpu_dai->driver->ops->set_clkdiv)
+		return cpu_dai->driver->ops->set_clkdiv(cpu_dai,
+							SND_SOC_CLOCK_OUT, div);
+	dev_warn(codec->dev, "WARN: CPU DAI not support sysclk div");
+
+	return 0;
+}
+
+const struct snd_soc_dai_ops stih416_dac_ops = {
+	.set_fmt = sti_sas_dac_set_fmt,
+	.mute_stream = stih416_sas_dac_mute,
+	.hw_params = sti_sas_hw_params
+};
+
+const struct snd_soc_dai_ops stih407_dac_ops = {
+	.set_fmt = sti_sas_dac_set_fmt,
+	.mute_stream = stih407_sas_dac_mute,
+	.hw_params = sti_sas_hw_params
+};
+
+const struct sti_sas_dev_data stih416_data = {
+	.chipid = CHIPID_STIH416,
+	.dac = sti_sas_dac_stih416,
+	.dac_ops = &stih416_dac_ops,
+	.spdif = sti_sas_spdif_stih416,
+	.dapm_widgets = stih416_sas_dapm_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(stih416_sas_dapm_widgets)
+};
+
+const struct sti_sas_dev_data stih407_data = {
+	.chipid = CHIPID_STIH407,
+	.dac = sti_sas_dac_stih407,
+	.dac_ops = &stih407_dac_ops,
+	.spdif = sti_sas_spdif_stih407,
+	.dapm_widgets = stih407_sas_dapm_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(stih407_sas_dapm_widgets)
+};
+
+static struct snd_soc_dai_driver sti_sas_dai[] = {
+	{
+		.name = "sas-dai-spdif-out",
+		.id = STI_SAS_DAI_SPDIF_OUT,
+		.playback = {
+			.stream_name = "spdif_p",
+			.channels_min = 2,
+			.channels_max = 2,
+			.rates = SNDRV_PCM_RATE_32000 | SNDRV_PCM_RATE_44100 |
+				 SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_64000 |
+				 SNDRV_PCM_RATE_88200 | SNDRV_PCM_RATE_96000 |
+				 SNDRV_PCM_RATE_192000,
+			.formats = SNDRV_PCM_FMTBIT_S16_LE |
+				   SNDRV_PCM_FMTBIT_S32_LE,
+		},
+		.ops = (struct snd_soc_dai_ops[]) {
+			{
+				.set_fmt = sti_sas_spdif_set_fmt,
+				.trigger = sti_sas_spdif_trigger,
+				.hw_params = sti_sas_hw_params,
+			}
+		},
+	},
+	{
+		.name = "sas-dai-dac",
+		.id = STI_SAS_DAI_ANALOG_OUT,
+		.playback = {
+			.stream_name = "dac_p",
+			.channels_min = 2,
+			.channels_max = 2,
+			.rates = SNDRV_PCM_RATE_8000_48000,
+			.formats = SNDRV_PCM_FMTBIT_S16_LE |
+				   SNDRV_PCM_FMTBIT_S32_LE,
+		},
+	},
+};
+
+const int sti_sas_dai_clk_div[ARRAY_SIZE(sti_sas_dai)] = {
+	128, /* spdif out */
+	256, /* dac */
+};
+
+#ifdef CONFIG_PM_SLEEP
+static int sti_sas_resume(struct snd_soc_codec *codec)
+{
+	struct sti_sas_data *drvdata = dev_get_drvdata(codec->dev);
+
+	return sti_sas_init_sas_registers(codec->dev, drvdata);
+}
+#else
+#define sti_sas_resume NULL
+#endif
+
+static int sti_sas_codec_probe(struct snd_soc_codec *codec)
+{
+	struct sti_sas_data *drvdata = dev_get_drvdata(codec->dev);
+	int ret;
+
+	ret = sti_sas_init_sas_registers(codec->dev, drvdata);
+
+	return ret;
+}
+
+static struct snd_soc_codec_driver sti_sas_driver = {
+	.probe = sti_sas_codec_probe,
+	.resume = sti_sas_resume,
+	.dapm_routes =	sti_sas_route,
+	.num_dapm_routes = ARRAY_SIZE(sti_sas_route),
+};
+
+static const struct of_device_id sti_sas_dev_match[] = {
+	{
+		.compatible = "st,stih416-sas-codec",
+		.data = &stih416_data,
+	},
+	{
+		.compatible = "st,stih407-sas-codec",
+		.data = &stih407_data,
+	},
+	{},
+};
+
+static int sti_sas_driver_probe(struct platform_device *pdev)
+{
+	struct device_node *pnode = pdev->dev.of_node;
+	int ret = 0;
+	struct sti_sas_data *drvdata;
+
+	/* Allocate device structure */
+	drvdata = devm_kzalloc(&pdev->dev, sizeof(struct sti_sas_data),
+			       GFP_KERNEL);
+	if (!drvdata)
+		return -ENOMEM;
+
+	/* Populate data structure depending on compatibility */
+	if (!of_match_node(sti_sas_dev_match, pnode)->data) {
+		dev_err(&pdev->dev, "data associated to device is missing");
+		return -EINVAL;
+	}
+
+	drvdata->dev_data = of_match_node(sti_sas_dev_match, pnode)->data;
+
+	/* Initialise device structure */
+	drvdata->dev = &pdev->dev;
+
+	/* Request the DAC & SPDIF registers memory region */
+	drvdata->dac.regmap =
+		syscon_regmap_lookup_by_phandle(pnode, "st,syscfg");
+	if (!drvdata->dac.regmap) {
+		dev_err(&pdev->dev, "audio registers not enabled\n");
+		return -EFAULT;
+	}
+	drvdata->spdif.regmap = drvdata->dac.regmap;
+
+	ret = sti_sas_map_sas_registers(drvdata);
+	if (ret < 0)
+		return ret;
+
+	/* Set DAC dai probe */
+	if (drvdata->dev_data->chipid == CHIPID_STIH416)
+		sti_sas_dai[STI_SAS_DAI_ANALOG_OUT].probe = stih416_dac_probe;
+
+	sti_sas_dai[STI_SAS_DAI_ANALOG_OUT].ops = drvdata->dev_data->dac_ops;
+
+	/* Set dapms*/
+	sti_sas_driver.dapm_widgets = drvdata->dev_data->dapm_widgets;
+	sti_sas_driver.num_dapm_widgets = drvdata->dev_data->num_dapm_widgets;
+
+	/* Store context */
+	dev_set_drvdata(&pdev->dev, drvdata);
+
+	return snd_soc_register_codec(&pdev->dev, &sti_sas_driver,
+					sti_sas_dai,
+					ARRAY_SIZE(sti_sas_dai));
+}
+
+static int sti_sas_driver_remove(struct platform_device *pdev)
+{
+	snd_soc_unregister_codec(&pdev->dev);
+
+	return 0;
+}
+
+static struct platform_driver sti_sas_platform_driver = {
+	.driver = {
+		.name = "sti-sas-codec",
+		.owner = THIS_MODULE,
+		.of_match_table = sti_sas_dev_match,
+	},
+	.probe = sti_sas_driver_probe,
+	.remove = sti_sas_driver_remove,
+};
+
+module_platform_driver(sti_sas_platform_driver);
+
+MODULE_DESCRIPTION("audio codec for STMicroelectronics sti platforms");
+MODULE_AUTHOR("Arnaud.pouliquen@st.com");
+MODULE_LICENSE("GPL v2");
diff --git a/sound/soc/sti/Kconfig b/sound/soc/sti/Kconfig
index c29e219..af5d6fd 100644
--- a/sound/soc/sti/Kconfig
+++ b/sound/soc/sti/Kconfig
@@ -9,3 +9,9 @@ menuconfig SND_SOC_STI
 	help
 		Say Y if you want to enable ASoC-support for
 		any of the STI platforms (e.g. STIH416).
+
+config SND_SOC_STI_SAS
+	tristate "codec Audio support for STI SAS codec"
+	depends on SND_SOC_STI
+	help
+		Say Y if you want to include STI SAS audio codec support
\ No newline at end of file
-- 
1.9.1
