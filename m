From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/4] ASoC: Refactor WM8958 DSP to support
	additional algorithms
Date: Tue, 22 Mar 2011 17:51:56 +0000
Message-ID: <1300816318-1859-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1300816318-1859-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1763B2440F
	for <alsa-devel@alsa-project.org>; Tue, 22 Mar 2011 18:52:47 +0100 (CET)
In-Reply-To: <1300816318-1859-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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

In preparation for the addition of additional WM8958 algorithms
reorganise the code to make it easier to add such support later.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8958-dsp2.c |   98 +++++++++++++++++-----------------------
 sound/soc/codecs/wm8994.h      |    1 +
 2 files changed, 43 insertions(+), 56 deletions(-)

diff --git a/sound/soc/codecs/wm8958-dsp2.c b/sound/soc/codecs/wm8958-dsp2.c
index 88fd4a9..9c1cbe5 100644
--- a/sound/soc/codecs/wm8958-dsp2.c
+++ b/sound/soc/codecs/wm8958-dsp2.c
@@ -189,7 +189,7 @@ ok:
 	return ret;
 }
 
-static void wm8958_mbc_apply(struct snd_soc_codec *codec, int mbc, int start)
+static void wm8958_dsp_start_mbc(struct snd_soc_codec *codec, int path)
 {
 	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
 	struct wm8994_pdata *pdata = wm8994->pdata;
@@ -237,9 +237,9 @@ static void wm8958_dsp_apply(struct snd_soc_codec *codec, int path, int start)
 {
 	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
 	int pwr_reg = snd_soc_read(codec, WM8994_POWER_MANAGEMENT_5);
-	int ena, reg, aif, i;
+	int ena, reg, aif;
 
-	switch (mbc) {
+	switch (path) {
 	case 0:
 		pwr_reg &= (WM8994_AIF1DAC1L_ENA | WM8994_AIF1DAC1R_ENA);
 		aif = 0;
@@ -257,66 +257,34 @@ static void wm8958_dsp_apply(struct snd_soc_codec *codec, int path, int start)
 		return;
 	}
 
-	/* We can only enable the MBC if the AIF is enabled and we
-	 * want it to be enabled. */
-	ena = pwr_reg && wm8994->mbc_ena[mbc];
+	/* Do we have both an active AIF and an active algorithm? */
+	ena = wm8994->mbc_ena[path];
+	if (!pwr_reg)
+		ena = 0;
 
 	reg = snd_soc_read(codec, WM8958_DSP2_PROGRAM);
 
-	dev_dbg(codec->dev, "MBC %d startup: %d, power: %x, DSP: %x\n",
-		mbc, start, pwr_reg, reg);
+	dev_dbg(codec->dev, "DSP path %d %d startup: %d, power: %x, DSP: %x\n",
+		path, wm8994->dsp_active, start, pwr_reg, reg);
 
 	if (start && ena) {
-		/* If the DSP is already running then noop */
-		if (reg & WM8958_DSP2_ENA)
-			return;
-
-		/* If neither AIFnCLK is not yet enabled postpone */
+		/* If either AIFnCLK is not yet enabled postpone */
 		if (!(snd_soc_read(codec, WM8994_AIF1_CLOCKING_1)
 		      & WM8994_AIF1CLK_ENA_MASK) &&
 		    !(snd_soc_read(codec, WM8994_AIF2_CLOCKING_1)
 		      & WM8994_AIF2CLK_ENA_MASK))
 			return;
 
-		/* If we have MBC firmware download it */
-		if (wm8994->mbc && wm8994->mbc_ena[mbc])
-			wm8958_dsp2_fw(codec, "MBC", wm8994->mbc, false);
-
 		/* Switch the clock over to the appropriate AIF */
 		snd_soc_update_bits(codec, WM8994_CLOCKING_1,
 				    WM8958_DSP2CLK_SRC | WM8958_DSP2CLK_ENA,
 				    aif << WM8958_DSP2CLK_SRC_SHIFT |
 				    WM8958_DSP2CLK_ENA);
 
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
+		if (wm8994->mbc_ena[path])
+			wm8958_dsp_start_mbc(codec, path);
 
-		/* And we're off! */
-		snd_soc_update_bits(codec, WM8958_DSP2_CONFIG,
-				    WM8958_MBC_ENA | WM8958_MBC_SEL_MASK,
-				    mbc << WM8958_MBC_SEL_SHIFT |
-				    WM8958_MBC_ENA);
-
-		dev_dbg(codec->dev, "MBC running\n");
+		dev_dbg(codec->dev, "DSP running\n");
 	} else {
 		/* If the DSP is already stopped then noop */
 		if (!(reg & WM8958_DSP2_ENA))
@@ -324,12 +292,16 @@ static void wm8958_dsp_apply(struct snd_soc_codec *codec, int path, int start)
 
 		snd_soc_update_bits(codec, WM8958_DSP2_CONFIG,
 				    WM8958_MBC_ENA, 0);	
+		snd_soc_write(codec, WM8958_DSP2_EXECCONTROL,
+			      WM8958_DSP2_STOP);
 		snd_soc_update_bits(codec, WM8958_DSP2_PROGRAM,
 				    WM8958_DSP2_ENA, 0);
 		snd_soc_update_bits(codec, WM8994_CLOCKING_1,
 				    WM8958_DSP2CLK_ENA, 0);
 
-		dev_dbg(codec->dev, "MBC stopped\n");
+		wm8994->dsp_active = -1;
+
+		dev_dbg(codec->dev, "DSP stopped\n");
 	}
 }
 
@@ -343,18 +315,33 @@ int wm8958_aif_ev(struct snd_soc_dapm_widget *w,
 	case SND_SOC_DAPM_POST_PMU:
 	case SND_SOC_DAPM_PRE_PMU:
 		for (i = 0; i < 3; i++)
-			wm8958_mbc_apply(codec, i, 1);
+			wm8958_dsp_apply(codec, i, 1);
 		break;
 	case SND_SOC_DAPM_POST_PMD:
 	case SND_SOC_DAPM_PRE_PMD:
 		for (i = 0; i < 3; i++)
-			wm8958_mbc_apply(codec, i, 0);
+			wm8958_dsp_apply(codec, i, 0);
 		break;
 	}
 
 	return 0;
 }
 
+/* Check if DSP2 is in use on another AIF */
+static int wm8958_dsp2_busy(struct wm8994_priv *wm8994, int aif)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(wm8994->mbc_ena); i++) {
+		if (i == aif)
+			continue;
+		if (wm8994->mbc_ena[i])
+			return 1;
+	}
+
+	return 0;
+}
+
 static int wm8958_put_mbc_enum(struct snd_kcontrol *kcontrol,
 			       struct snd_ctl_elem_value *ucontrol)
 {
@@ -414,23 +401,20 @@ static int wm8958_mbc_put(struct snd_kcontrol *kcontrol,
 			  struct snd_ctl_elem_value *ucontrol)
 {
 	int mbc = kcontrol->private_value;
-	int i;
 	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
 	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
 
 	if (ucontrol->value.integer.value[0] > 1)
 		return -EINVAL;
 
-	for (i = 0; i < ARRAY_SIZE(wm8994->mbc_ena); i++) {
-		if (mbc != i && wm8994->mbc_ena[i]) {
-			dev_dbg(codec->dev, "MBC %d active already\n", mbc);
-			return -EBUSY;
-		}
+	if (wm8958_dsp2_busy(wm8994, mbc)) {
+		dev_dbg(codec->dev, "DSP2 active on %d already\n", mbc);
+		return -EBUSY;
 	}
 
 	wm8994->mbc_ena[mbc] = ucontrol->value.integer.value[0];
 
-	wm8958_mbc_apply(codec, mbc, wm8994->mbc_ena[mbc]);
+	wm8958_dsp_apply(codec, mbc, wm8994->mbc_ena[mbc]);
 
 	return 0;
 }
@@ -466,10 +450,12 @@ void wm8958_dsp2_init(struct snd_soc_codec *codec)
 	struct wm8994_pdata *pdata = wm8994->pdata;
 	int ret, i;
 
+	wm8994->dsp_active = -1;
+
 	snd_soc_add_controls(codec, wm8958_mbc_snd_controls,
 			     ARRAY_SIZE(wm8958_mbc_snd_controls));
 
-	/* We don't require firmware and don't want to delay boot */
+	/* We don't *require* firmware and don't want to delay boot */
 	request_firmware_nowait(THIS_MODULE, FW_ACTION_HOTPLUG,
 				"wm8958_mbc.wfw", codec->dev, GFP_KERNEL,
 				codec, wm8958_mbc_loaded);
diff --git a/sound/soc/codecs/wm8994.h b/sound/soc/codecs/wm8994.h
index 1aa365b..a4bfde8 100644
--- a/sound/soc/codecs/wm8994.h
+++ b/sound/soc/codecs/wm8994.h
@@ -116,6 +116,7 @@ struct wm8994_priv {
 	unsigned int aif1clk_disable:1;
 	unsigned int aif2clk_disable:1;
 
+	int dsp_active;
 	const struct firmware *cur_fw;
 	const struct firmware *mbc;
 };
-- 
1.7.4.1
