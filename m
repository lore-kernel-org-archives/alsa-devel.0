From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/3] ASoC: Factor WM8958 DSP2 handling into
	separate file
Date: Wed, 16 Mar 2011 15:48:51 +0000
Message-ID: <1300290532-30555-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1300290532-30555-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D308824499
	for <alsa-devel@alsa-project.org>; Wed, 16 Mar 2011 16:49:02 +0100 (CET)
In-Reply-To: <1300290532-30555-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

DSP2 on the WM8958 has a default ROM which provides a multi-band
compressor for enhanced performance on mobile devices but can also
support runtime download of alternative firmware. In preparation for
more exploiting this functionality refactor the code to split the
handling of DSP2 into a separate file.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/Makefile      |    2 +-
 sound/soc/codecs/wm8958-dsp2.c |  289 +++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/wm8994.c      |  305 +---------------------------------------
 sound/soc/codecs/wm8994.h      |   71 +++++++++
 4 files changed, 364 insertions(+), 303 deletions(-)
 create mode 100644 sound/soc/codecs/wm8958-dsp2.c

diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index 379bc55..49121ad 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -69,7 +69,7 @@ snd-soc-wm8988-objs := wm8988.o
 snd-soc-wm8990-objs := wm8990.o
 snd-soc-wm8991-objs := wm8991.o
 snd-soc-wm8993-objs := wm8993.o
-snd-soc-wm8994-objs := wm8994.o wm8994-tables.o
+snd-soc-wm8994-objs := wm8994.o wm8994-tables.o wm8958-dsp2.o
 snd-soc-wm8995-objs := wm8995.o
 snd-soc-wm9081-objs := wm9081.o
 snd-soc-wm9705-objs := wm9705.o
diff --git a/sound/soc/codecs/wm8958-dsp2.c b/sound/soc/codecs/wm8958-dsp2.c
new file mode 100644
index 0000000..4b4c93c
--- /dev/null
+++ b/sound/soc/codecs/wm8958-dsp2.c
@@ -0,0 +1,289 @@
+/*
+ * wm8958-dsp2.c  --  WM8958 DSP2 support
+ *
+ * Copyright 2011 Wolfson Microelectronics plc
+ *
+ * Author: Mark Brown <broonie@opensource.wolfsonmicro.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/init.h>
+#include <linux/delay.h>
+#include <linux/pm.h>
+#include <linux/i2c.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <sound/soc.h>
+#include <sound/initval.h>
+#include <sound/tlv.h>
+#include <trace/events/asoc.h>
+
+#include <linux/mfd/wm8994/core.h>
+#include <linux/mfd/wm8994/registers.h>
+#include <linux/mfd/wm8994/pdata.h>
+#include <linux/mfd/wm8994/gpio.h>
+
+#include "wm8994.h"
+
+static void wm8958_mbc_apply(struct snd_soc_codec *codec, int mbc, int start)
+{
+	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
+	struct wm8994_pdata *pdata = wm8994->pdata;
+	int pwr_reg = snd_soc_read(codec, WM8994_POWER_MANAGEMENT_5);
+	int ena, reg, aif, i;
+
+	switch (mbc) {
+	case 0:
+		pwr_reg &= (WM8994_AIF1DAC1L_ENA | WM8994_AIF1DAC1R_ENA);
+		aif = 0;
+		break;
+	case 1:
+		pwr_reg &= (WM8994_AIF1DAC2L_ENA | WM8994_AIF1DAC2R_ENA);
+		aif = 0;
+		break;
+	case 2:
+		pwr_reg &= (WM8994_AIF2DACL_ENA | WM8994_AIF2DACR_ENA);
+		aif = 1;
+		break;
+	default:
+		BUG();
+		return;
+	}
+
+	/* We can only enable the MBC if the AIF is enabled and we
+	 * want it to be enabled. */
+	ena = pwr_reg && wm8994->mbc_ena[mbc];
+
+	reg = snd_soc_read(codec, WM8958_DSP2_PROGRAM);
+
+	dev_dbg(codec->dev, "MBC %d startup: %d, power: %x, DSP: %x\n",
+		mbc, start, pwr_reg, reg);
+
+	if (start && ena) {
+		/* If the DSP is already running then noop */
+		if (reg & WM8958_DSP2_ENA)
+			return;
+
+		/* Switch the clock over to the appropriate AIF */
+		snd_soc_update_bits(codec, WM8994_CLOCKING_1,
+				    WM8958_DSP2CLK_SRC | WM8958_DSP2CLK_ENA,
+				    aif << WM8958_DSP2CLK_SRC_SHIFT |
+				    WM8958_DSP2CLK_ENA);
+
+		snd_soc_update_bits(codec, WM8958_DSP2_PROGRAM,
+				    WM8958_DSP2_ENA, WM8958_DSP2_ENA);
+
+		/* If we've got user supplied MBC settings use them */
+		if (pdata && pdata->num_mbc_cfgs) {
+			struct wm8958_mbc_cfg *cfg
+				= &pdata->mbc_cfgs[wm8994->mbc_cfg];
+
+			for (i = 0; i < ARRAY_SIZE(cfg->coeff_regs); i++)
+				snd_soc_write(codec, i + WM8958_MBC_BAND_1_K_1,
+					      cfg->coeff_regs[i]);
+
+			for (i = 0; i < ARRAY_SIZE(cfg->cutoff_regs); i++)
+				snd_soc_write(codec,
+					      i + WM8958_MBC_BAND_2_LOWER_CUTOFF_C1_1,
+					      cfg->cutoff_regs[i]);
+		}
+
+		/* Run the DSP */
+		snd_soc_write(codec, WM8958_DSP2_EXECCONTROL,
+			      WM8958_DSP2_RUNR);
+
+		/* And we're off! */
+		snd_soc_update_bits(codec, WM8958_DSP2_CONFIG,
+				    WM8958_MBC_ENA | WM8958_MBC_SEL_MASK,
+				    mbc << WM8958_MBC_SEL_SHIFT |
+				    WM8958_MBC_ENA);
+	} else {
+		/* If the DSP is already stopped then noop */
+		if (!(reg & WM8958_DSP2_ENA))
+			return;
+
+		snd_soc_update_bits(codec, WM8958_DSP2_CONFIG,
+				    WM8958_MBC_ENA, 0);	
+		snd_soc_update_bits(codec, WM8958_DSP2_PROGRAM,
+				    WM8958_DSP2_ENA, 0);
+		snd_soc_update_bits(codec, WM8994_CLOCKING_1,
+				    WM8958_DSP2CLK_ENA, 0);
+	}
+}
+
+int wm8958_aif_ev(struct snd_soc_dapm_widget *w,
+		  struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_codec *codec = w->codec;
+	int mbc;
+
+	switch (w->shift) {
+	case 13:
+	case 12:
+		mbc = 2;
+		break;
+	case 11:
+	case 10:
+		mbc = 1;
+		break;
+	case 9:
+	case 8:
+		mbc = 0;
+		break;
+	default:
+		BUG();
+		return -EINVAL;
+	}
+
+	switch (event) {
+	case SND_SOC_DAPM_POST_PMU:
+		wm8958_mbc_apply(codec, mbc, 1);
+		break;
+	case SND_SOC_DAPM_POST_PMD:
+		wm8958_mbc_apply(codec, mbc, 0);
+		break;
+	}
+
+	return 0;
+}
+
+static int wm8958_put_mbc_enum(struct snd_kcontrol *kcontrol,
+			       struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
+	struct wm8994_pdata *pdata = wm8994->pdata;
+	int value = ucontrol->value.integer.value[0];
+	int reg;
+
+	/* Don't allow on the fly reconfiguration */
+	reg = snd_soc_read(codec, WM8994_CLOCKING_1);
+	if (reg < 0 || reg & WM8958_DSP2CLK_ENA)
+		return -EBUSY;
+
+	if (value >= pdata->num_mbc_cfgs)
+		return -EINVAL;
+
+	wm8994->mbc_cfg = value;
+
+	return 0;
+}
+
+static int wm8958_get_mbc_enum(struct snd_kcontrol *kcontrol,
+			       struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
+
+	ucontrol->value.enumerated.item[0] = wm8994->mbc_cfg;
+
+	return 0;
+}
+
+static int wm8958_mbc_info(struct snd_kcontrol *kcontrol,
+			   struct snd_ctl_elem_info *uinfo)
+{
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_BOOLEAN;
+	uinfo->count = 1;
+	uinfo->value.integer.min = 0;
+	uinfo->value.integer.max = 1;
+	return 0;
+}
+
+static int wm8958_mbc_get(struct snd_kcontrol *kcontrol,
+			  struct snd_ctl_elem_value *ucontrol)
+{
+	int mbc = kcontrol->private_value;
+	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
+
+	ucontrol->value.integer.value[0] = wm8994->mbc_ena[mbc];
+
+	return 0;
+}
+
+static int wm8958_mbc_put(struct snd_kcontrol *kcontrol,
+			  struct snd_ctl_elem_value *ucontrol)
+{
+	int mbc = kcontrol->private_value;
+	int i;
+	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
+
+	if (ucontrol->value.integer.value[0] > 1)
+		return -EINVAL;
+
+	for (i = 0; i < ARRAY_SIZE(wm8994->mbc_ena); i++) {
+		if (mbc != i && wm8994->mbc_ena[i]) {
+			dev_dbg(codec->dev, "MBC %d active already\n", mbc);
+			return -EBUSY;
+		}
+	}
+
+	wm8994->mbc_ena[mbc] = ucontrol->value.integer.value[0];
+
+	wm8958_mbc_apply(codec, mbc, wm8994->mbc_ena[mbc]);
+
+	return 0;
+}
+
+#define WM8958_MBC_SWITCH(xname, xval) {\
+	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = (xname), \
+	.access = SNDRV_CTL_ELEM_ACCESS_READWRITE,\
+	.info = wm8958_mbc_info, \
+	.get = wm8958_mbc_get, .put = wm8958_mbc_put, \
+	.private_value = xval }
+
+static const struct snd_kcontrol_new wm8958_mbc_snd_controls[] = {
+WM8958_MBC_SWITCH("AIF1DAC1 MBC Switch", 0),
+WM8958_MBC_SWITCH("AIF1DAC2 MBC Switch", 1),
+WM8958_MBC_SWITCH("AIF2DAC MBC Switch", 2),
+};
+
+void wm8958_dsp2_init(struct snd_soc_codec *codec)
+{
+	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
+	struct wm8994_pdata *pdata = wm8994->pdata;
+	int ret, i;
+
+	snd_soc_add_controls(codec, wm8958_mbc_snd_controls,
+			     ARRAY_SIZE(wm8958_mbc_snd_controls));
+
+	if (!pdata)
+		return;
+
+	if (pdata->num_mbc_cfgs) {
+		struct snd_kcontrol_new control[] = {
+			SOC_ENUM_EXT("MBC Mode", wm8994->mbc_enum,
+				     wm8958_get_mbc_enum, wm8958_put_mbc_enum),
+		};
+
+		/* We need an array of texts for the enum API */
+		wm8994->mbc_texts = kmalloc(sizeof(char *)
+					    * pdata->num_mbc_cfgs, GFP_KERNEL);
+		if (!wm8994->mbc_texts) {
+			dev_err(wm8994->codec->dev,
+				"Failed to allocate %d MBC config texts\n",
+				pdata->num_mbc_cfgs);
+			return;
+		}
+
+		for (i = 0; i < pdata->num_mbc_cfgs; i++)
+			wm8994->mbc_texts[i] = pdata->mbc_cfgs[i].name;
+
+		wm8994->mbc_enum.max = pdata->num_mbc_cfgs;
+		wm8994->mbc_enum.texts = wm8994->mbc_texts;
+
+		ret = snd_soc_add_controls(wm8994->codec, control, 1);
+		if (ret != 0)
+			dev_err(wm8994->codec->dev,
+				"Failed to add MBC mode controls: %d\n", ret);
+	}
+
+
+}
diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index 9458289..96e1379 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -38,12 +38,6 @@
 #include "wm8994.h"
 #include "wm_hubs.h"
 
-struct fll_config {
-	int src;
-	int in;
-	int out;
-};
-
 #define WM8994_NUM_DRC 3
 #define WM8994_NUM_EQ  3
 
@@ -59,61 +53,6 @@ static int wm8994_retune_mobile_base[] = {
 	WM8994_AIF2_EQ_GAINS_1,
 };
 
-struct wm8994_micdet {
-	struct snd_soc_jack *jack;
-	int det;
-	int shrt;
-};
-
-/* codec private data */
-struct wm8994_priv {
-	struct wm_hubs_data hubs;
-	enum snd_soc_control_type control_type;
-	void *control_data;
-	struct snd_soc_codec *codec;
-	int sysclk[2];
-	int sysclk_rate[2];
-	int mclk[2];
-	int aifclk[2];
-	struct fll_config fll[2], fll_suspend[2];
-
-	int dac_rates[2];
-	int lrclk_shared[2];
-
-	int mbc_ena[3];
-
-	/* Platform dependant DRC configuration */
-	const char **drc_texts;
-	int drc_cfg[WM8994_NUM_DRC];
-	struct soc_enum drc_enum;
-
-	/* Platform dependant ReTune mobile configuration */
-	int num_retune_mobile_texts;
-	const char **retune_mobile_texts;
-	int retune_mobile_cfg[WM8994_NUM_EQ];
-	struct soc_enum retune_mobile_enum;
-
-	/* Platform dependant MBC configuration */
-	int mbc_cfg;
-	const char **mbc_texts;
-	struct soc_enum mbc_enum;
-
-	struct wm8994_micdet micdet[2];
-
-	wm8958_micdet_cb jack_cb;
-	void *jack_cb_data;
-	int micdet_irq;
-
-	int revision;
-	struct wm8994_pdata *pdata;
-
-	unsigned int aif1clk_enable:1;
-	unsigned int aif2clk_enable:1;
-
-	unsigned int aif1clk_disable:1;
-	unsigned int aif2clk_disable:1;
-};
-
 static int wm8994_readable(struct snd_soc_codec *codec, unsigned int reg)
 {
 	switch (reg) {
@@ -574,215 +513,6 @@ static const struct soc_enum dac_osr =
 static const struct soc_enum adc_osr =
 	SOC_ENUM_SINGLE(WM8994_OVERSAMPLING, 1, 2, osr_text);
 
-static void wm8958_mbc_apply(struct snd_soc_codec *codec, int mbc, int start)
-{
-	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
-	struct wm8994_pdata *pdata = wm8994->pdata;
-	int pwr_reg = snd_soc_read(codec, WM8994_POWER_MANAGEMENT_5);
-	int ena, reg, aif, i;
-
-	switch (mbc) {
-	case 0:
-		pwr_reg &= (WM8994_AIF1DAC1L_ENA | WM8994_AIF1DAC1R_ENA);
-		aif = 0;
-		break;
-	case 1:
-		pwr_reg &= (WM8994_AIF1DAC2L_ENA | WM8994_AIF1DAC2R_ENA);
-		aif = 0;
-		break;
-	case 2:
-		pwr_reg &= (WM8994_AIF2DACL_ENA | WM8994_AIF2DACR_ENA);
-		aif = 1;
-		break;
-	default:
-		BUG();
-		return;
-	}
-
-	/* We can only enable the MBC if the AIF is enabled and we
-	 * want it to be enabled. */
-	ena = pwr_reg && wm8994->mbc_ena[mbc];
-
-	reg = snd_soc_read(codec, WM8958_DSP2_PROGRAM);
-
-	dev_dbg(codec->dev, "MBC %d startup: %d, power: %x, DSP: %x\n",
-		mbc, start, pwr_reg, reg);
-
-	if (start && ena) {
-		/* If the DSP is already running then noop */
-		if (reg & WM8958_DSP2_ENA)
-			return;
-
-		/* Switch the clock over to the appropriate AIF */
-		snd_soc_update_bits(codec, WM8994_CLOCKING_1,
-				    WM8958_DSP2CLK_SRC | WM8958_DSP2CLK_ENA,
-				    aif << WM8958_DSP2CLK_SRC_SHIFT |
-				    WM8958_DSP2CLK_ENA);
-
-		snd_soc_update_bits(codec, WM8958_DSP2_PROGRAM,
-				    WM8958_DSP2_ENA, WM8958_DSP2_ENA);
-
-		/* If we've got user supplied MBC settings use them */
-		if (pdata && pdata->num_mbc_cfgs) {
-			struct wm8958_mbc_cfg *cfg
-				= &pdata->mbc_cfgs[wm8994->mbc_cfg];
-
-			for (i = 0; i < ARRAY_SIZE(cfg->coeff_regs); i++)
-				snd_soc_write(codec, i + WM8958_MBC_BAND_1_K_1,
-					      cfg->coeff_regs[i]);
-
-			for (i = 0; i < ARRAY_SIZE(cfg->cutoff_regs); i++)
-				snd_soc_write(codec,
-					      i + WM8958_MBC_BAND_2_LOWER_CUTOFF_C1_1,
-					      cfg->cutoff_regs[i]);
-		}
-
-		/* Run the DSP */
-		snd_soc_write(codec, WM8958_DSP2_EXECCONTROL,
-			      WM8958_DSP2_RUNR);
-
-		/* And we're off! */
-		snd_soc_update_bits(codec, WM8958_DSP2_CONFIG,
-				    WM8958_MBC_ENA | WM8958_MBC_SEL_MASK,
-				    mbc << WM8958_MBC_SEL_SHIFT |
-				    WM8958_MBC_ENA);
-	} else {
-		/* If the DSP is already stopped then noop */
-		if (!(reg & WM8958_DSP2_ENA))
-			return;
-
-		snd_soc_update_bits(codec, WM8958_DSP2_CONFIG,
-				    WM8958_MBC_ENA, 0);	
-		snd_soc_update_bits(codec, WM8958_DSP2_PROGRAM,
-				    WM8958_DSP2_ENA, 0);
-		snd_soc_update_bits(codec, WM8994_CLOCKING_1,
-				    WM8958_DSP2CLK_ENA, 0);
-	}
-}
-
-static int wm8958_aif_ev(struct snd_soc_dapm_widget *w,
-		    struct snd_kcontrol *kcontrol, int event)
-{
-	struct snd_soc_codec *codec = w->codec;
-	int mbc;
-
-	switch (w->shift) {
-	case 13:
-	case 12:
-		mbc = 2;
-		break;
-	case 11:
-	case 10:
-		mbc = 1;
-		break;
-	case 9:
-	case 8:
-		mbc = 0;
-		break;
-	default:
-		BUG();
-		return -EINVAL;
-	}
-
-	switch (event) {
-	case SND_SOC_DAPM_POST_PMU:
-		wm8958_mbc_apply(codec, mbc, 1);
-		break;
-	case SND_SOC_DAPM_POST_PMD:
-		wm8958_mbc_apply(codec, mbc, 0);
-		break;
-	}
-
-	return 0;
-}
-
-static int wm8958_put_mbc_enum(struct snd_kcontrol *kcontrol,
-			       struct snd_ctl_elem_value *ucontrol)
-{
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
-	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
-	struct wm8994_pdata *pdata = wm8994->pdata;
-	int value = ucontrol->value.integer.value[0];
-	int reg;
-
-	/* Don't allow on the fly reconfiguration */
-	reg = snd_soc_read(codec, WM8994_CLOCKING_1);
-	if (reg < 0 || reg & WM8958_DSP2CLK_ENA)
-		return -EBUSY;
-
-	if (value >= pdata->num_mbc_cfgs)
-		return -EINVAL;
-
-	wm8994->mbc_cfg = value;
-
-	return 0;
-}
-
-static int wm8958_get_mbc_enum(struct snd_kcontrol *kcontrol,
-			       struct snd_ctl_elem_value *ucontrol)
-{
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
-	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
-
-	ucontrol->value.enumerated.item[0] = wm8994->mbc_cfg;
-
-	return 0;
-}
-
-static int wm8958_mbc_info(struct snd_kcontrol *kcontrol,
-			   struct snd_ctl_elem_info *uinfo)
-{
-	uinfo->type = SNDRV_CTL_ELEM_TYPE_BOOLEAN;
-	uinfo->count = 1;
-	uinfo->value.integer.min = 0;
-	uinfo->value.integer.max = 1;
-	return 0;
-}
-
-static int wm8958_mbc_get(struct snd_kcontrol *kcontrol,
-			  struct snd_ctl_elem_value *ucontrol)
-{
-	int mbc = kcontrol->private_value;
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
-	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
-
-	ucontrol->value.integer.value[0] = wm8994->mbc_ena[mbc];
-
-	return 0;
-}
-
-static int wm8958_mbc_put(struct snd_kcontrol *kcontrol,
-			  struct snd_ctl_elem_value *ucontrol)
-{
-	int mbc = kcontrol->private_value;
-	int i;
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
-	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
-
-	if (ucontrol->value.integer.value[0] > 1)
-		return -EINVAL;
-
-	for (i = 0; i < ARRAY_SIZE(wm8994->mbc_ena); i++) {
-		if (mbc != i && wm8994->mbc_ena[i]) {
-			dev_dbg(codec->dev, "MBC %d active already\n", mbc);
-			return -EBUSY;
-		}
-	}
-
-	wm8994->mbc_ena[mbc] = ucontrol->value.integer.value[0];
-
-	wm8958_mbc_apply(codec, mbc, wm8994->mbc_ena[mbc]);
-
-	return 0;
-}
-
-#define WM8958_MBC_SWITCH(xname, xval) {\
-	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = (xname), \
-	.access = SNDRV_CTL_ELEM_ACCESS_READWRITE,\
-	.info = wm8958_mbc_info, \
-	.get = wm8958_mbc_get, .put = wm8958_mbc_put, \
-	.private_value = xval }
-
 static const struct snd_kcontrol_new wm8994_snd_controls[] = {
 SOC_DOUBLE_R_TLV("AIF1ADC1 Volume", WM8994_AIF1_ADC1_LEFT_VOLUME,
 		 WM8994_AIF1_ADC1_RIGHT_VOLUME,
@@ -924,9 +654,6 @@ SOC_SINGLE_TLV("AIF2 EQ5 Volume", WM8994_AIF2_EQ_GAINS_2, 6, 31, 0,
 
 static const struct snd_kcontrol_new wm8958_snd_controls[] = {
 SOC_SINGLE_TLV("AIF3 Boost Volume", WM8958_AIF3_CONTROL_2, 10, 3, 0, aif_tlv),
-WM8958_MBC_SWITCH("AIF1DAC1 MBC Switch", 0),
-WM8958_MBC_SWITCH("AIF1DAC2 MBC Switch", 1),
-WM8958_MBC_SWITCH("AIF2DAC MBC Switch", 2),
 };
 
 static int clk_sys_event(struct snd_soc_dapm_widget *w,
@@ -2676,7 +2403,7 @@ static int wm8994_suspend(struct snd_soc_codec *codec, pm_message_t state)
 
 	for (i = 0; i < ARRAY_SIZE(wm8994->fll); i++) {
 		memcpy(&wm8994->fll_suspend[i], &wm8994->fll[i],
-		       sizeof(struct fll_config));
+		       sizeof(struct wm8994_fll_config));
 		ret = _wm8994_set_fll(codec, i + 1, 0, 0, 0);
 		if (ret < 0)
 			dev_warn(codec->dev, "Failed to stop FLL%d: %d\n",
@@ -2862,34 +2589,6 @@ static void wm8994_handle_pdata(struct wm8994_priv *wm8994)
 	dev_dbg(codec->dev, "%d ReTune Mobile configurations\n",
 		pdata->num_retune_mobile_cfgs);
 
-	if (pdata->num_mbc_cfgs) {
-		struct snd_kcontrol_new control[] = {
-			SOC_ENUM_EXT("MBC Mode", wm8994->mbc_enum,
-				     wm8958_get_mbc_enum, wm8958_put_mbc_enum),
-		};
-
-		/* We need an array of texts for the enum API */
-		wm8994->mbc_texts = kmalloc(sizeof(char *)
-					    * pdata->num_mbc_cfgs, GFP_KERNEL);
-		if (!wm8994->mbc_texts) {
-			dev_err(wm8994->codec->dev,
-				"Failed to allocate %d MBC config texts\n",
-				pdata->num_mbc_cfgs);
-			return;
-		}
-
-		for (i = 0; i < pdata->num_mbc_cfgs; i++)
-			wm8994->mbc_texts[i] = pdata->mbc_cfgs[i].name;
-
-		wm8994->mbc_enum.max = pdata->num_mbc_cfgs;
-		wm8994->mbc_enum.texts = wm8994->mbc_texts;
-
-		ret = snd_soc_add_controls(wm8994->codec, control, 1);
-		if (ret != 0)
-			dev_err(wm8994->codec->dev,
-				"Failed to add MBC mode controls: %d\n", ret);
-	}
-
 	if (pdata->num_retune_mobile_cfgs)
 		wm8994_handle_retune_mobile_pdata(wm8994);
 	else
@@ -3378,6 +3077,8 @@ static int wm8994_codec_probe(struct snd_soc_codec *codec)
 			snd_soc_dapm_add_routes(dapm, wm8958_intercon,
 						ARRAY_SIZE(wm8958_intercon));
 		}
+
+		wm8958_dsp2_init(codec);
 		break;
 	}
 
diff --git a/sound/soc/codecs/wm8994.h b/sound/soc/codecs/wm8994.h
index 999b885..93a6cf1 100644
--- a/sound/soc/codecs/wm8994.h
+++ b/sound/soc/codecs/wm8994.h
@@ -11,6 +11,8 @@
 
 #include <sound/soc.h>
 
+#include "wm_hubs.h"
+
 /* Sources for AIF1/2 SYSCLK - use with set_dai_sysclk() */
 #define WM8994_SYSCLK_MCLK1 1
 #define WM8994_SYSCLK_MCLK2 2
@@ -45,4 +47,73 @@ struct wm8994_access_mask {
 extern const struct wm8994_access_mask wm8994_access_masks[WM8994_CACHE_SIZE];
 extern const u16 wm8994_reg_defaults[WM8994_CACHE_SIZE];
 
+int wm8958_aif_ev(struct snd_soc_dapm_widget *w,
+		  struct snd_kcontrol *kcontrol, int event);
+
+void wm8958_dsp2_init(struct snd_soc_codec *codec);
+
+struct wm8994_micdet {
+	struct snd_soc_jack *jack;
+	int det;
+	int shrt;
+};
+
+/* codec private data */
+struct wm8994_fll_config {
+	int src;
+	int in;
+	int out;
+};
+
+#define WM8994_NUM_DRC 3
+#define WM8994_NUM_EQ  3
+
+struct wm8994_priv {
+	struct wm_hubs_data hubs;
+	enum snd_soc_control_type control_type;
+	void *control_data;
+	struct snd_soc_codec *codec;
+	int sysclk[2];
+	int sysclk_rate[2];
+	int mclk[2];
+	int aifclk[2];
+	struct wm8994_fll_config fll[2], fll_suspend[2];
+
+	int dac_rates[2];
+	int lrclk_shared[2];
+
+	int mbc_ena[3];
+
+	/* Platform dependant DRC configuration */
+	const char **drc_texts;
+	int drc_cfg[WM8994_NUM_DRC];
+	struct soc_enum drc_enum;
+
+	/* Platform dependant ReTune mobile configuration */
+	int num_retune_mobile_texts;
+	const char **retune_mobile_texts;
+	int retune_mobile_cfg[WM8994_NUM_EQ];
+	struct soc_enum retune_mobile_enum;
+
+	/* Platform dependant MBC configuration */
+	int mbc_cfg;
+	const char **mbc_texts;
+	struct soc_enum mbc_enum;
+
+	struct wm8994_micdet micdet[2];
+
+	wm8958_micdet_cb jack_cb;
+	void *jack_cb_data;
+	int micdet_irq;
+
+	int revision;
+	struct wm8994_pdata *pdata;
+
+	unsigned int aif1clk_enable:1;
+	unsigned int aif2clk_enable:1;
+
+	unsigned int aif1clk_disable:1;
+	unsigned int aif2clk_disable:1;
+};
+
 #endif
-- 
1.7.4.1
