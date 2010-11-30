From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/2] ASoC: Allow user-specified WM8958
	multiband compressor configurations
Date: Tue, 30 Nov 2010 17:06:36 +0000
Message-ID: <1291136796-8525-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1291136796-8525-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1F2A2103805
	for <alsa-devel@alsa-project.org>; Tue, 30 Nov 2010 18:06:45 +0100 (CET)
In-Reply-To: <1291136796-8525-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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

The paramters of the WM8958 multiband compressor can be tuned by the
user for their system using a graphical configuration tool on the host.
Allow the user to specify a set of such paramters in platform data and
select between them at runtime.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 include/linux/mfd/wm8994/pdata.h     |   17 +++++++
 include/linux/mfd/wm8994/registers.h |   68 +++++++++++++++++++++++++++
 sound/soc/codecs/wm8994.c            |   84 +++++++++++++++++++++++++++++++++-
 3 files changed, 167 insertions(+), 2 deletions(-)

diff --git a/include/linux/mfd/wm8994/pdata.h b/include/linux/mfd/wm8994/pdata.h
index 5c51f36..882b51a 100644
--- a/include/linux/mfd/wm8994/pdata.h
+++ b/include/linux/mfd/wm8994/pdata.h
@@ -30,6 +30,8 @@ struct wm8994_ldo_pdata {
 
 #define WM8994_DRC_REGS 5
 #define WM8994_EQ_REGS  19
+#define WM8958_MBC_CUTOFF_REGS 20
+#define WM8958_MBC_COEFF_REGS  48
 
 /**
  * DRC configurations are specified with a label and a set of register
@@ -59,6 +61,18 @@ struct wm8994_retune_mobile_cfg {
         u16 regs[WM8994_EQ_REGS];
 };
 
+/**
+ * Multiband compressor configurations are specified with a label and
+ * two sets of values to write.  Configurations are expected to be
+ * generated using the multiband compressor configuration panel in
+ * WISCE - see http://www.wolfsonmicro.com/wisce/
+ */
+struct wm8958_mbc_cfg {
+	const char *name;
+	u16 cutoff_regs[WM8958_MBC_CUTOFF_REGS];
+	u16 coeff_regs[WM8958_MBC_COEFF_REGS];
+};
+
 struct wm8994_pdata {
 	int gpio_base;
 
@@ -78,6 +92,9 @@ struct wm8994_pdata {
         int num_retune_mobile_cfgs;
         struct wm8994_retune_mobile_cfg *retune_mobile_cfgs;
 
+	int num_mbc_cfgs;
+	struct wm8958_mbc_cfg *mbc_cfgs;
+
         /* LINEOUT can be differential or single ended */
         unsigned int lineout1_diff:1;
         unsigned int lineout2_diff:1;
diff --git a/include/linux/mfd/wm8994/registers.h b/include/linux/mfd/wm8994/registers.h
index 4d5a561..be072fa 100644
--- a/include/linux/mfd/wm8994/registers.h
+++ b/include/linux/mfd/wm8994/registers.h
@@ -259,6 +259,74 @@
 #define WM8958_DSP2_VERMAJMIN                   0xA04
 #define WM8958_DSP2_VERBUILD                    0xA05
 #define WM8958_DSP2_EXECCONTROL                 0xA0D
+#define WM8958_MBC_BAND_2_LOWER_CUTOFF_C1_1     0x2200
+#define WM8958_MBC_BAND_2_LOWER_CUTOFF_C1_2     0x2201
+#define WM8958_MBC_BAND_2_LOWER_CUTOFF_C2_1     0x2202
+#define WM8958_MBC_BAND_2_LOWER_CUTOFF_C2_2     0x2203
+#define WM8958_MBC_BAND_2_LOWER_CUTOFF_C3_1     0x2204
+#define WM8958_MBC_BAND_2_LOWER_CUTOFF_C3_2     0x2205
+#define WM8958_MBC_BAND_2_UPPER_CUTOFF_C2_1     0x2206
+#define WM8958_MBC_BAND_2_UPPER_CUTOFF_C2_2     0x2207
+#define WM8958_MBC_BAND_2_UPPER_CUTOFF_C3_1     0x2208
+#define WM8958_MBC_BAND_2_UPPER_CUTOFF_C3_2     0x2209
+#define WM8958_MBC_BAND_2_UPPER_CUTOFF_C1_1     0x220A
+#define WM8958_MBC_BAND_2_UPPER_CUTOFF_C1_2     0x220B
+#define WM8958_MBC_BAND_1_UPPER_CUTOFF_C1_1     0x220C
+#define WM8958_MBC_BAND_1_UPPER_CUTOFF_C1_2     0x220D
+#define WM8958_MBC_BAND_1_UPPER_CUTOFF_C2_1     0x220E
+#define WM8958_MBC_BAND_1_UPPER_CUTOFF_C2_2     0x220F
+#define WM8958_MBC_BAND_1_UPPER_CUTOFF_C3_1     0x2210
+#define WM8958_MBC_BAND_1_UPPER_CUTOFF_C3_2     0x2211
+#define WM8958_MBC_BAND_1_LOWER_CUTOFF_1        0x2212
+#define WM8958_MBC_BAND_1_LOWER_CUTOFF_2        0x2213
+#define WM8958_MBC_BAND_1_K_1                   0x2400
+#define WM8958_MBC_BAND_1_K_2                   0x2401
+#define WM8958_MBC_BAND_1_N1_1                  0x2402
+#define WM8958_MBC_BAND_1_N1_2                  0x2403
+#define WM8958_MBC_BAND_1_N2_1                  0x2404
+#define WM8958_MBC_BAND_1_N2_2                  0x2405
+#define WM8958_MBC_BAND_1_N3_1                  0x2406
+#define WM8958_MBC_BAND_1_N3_2                  0x2407
+#define WM8958_MBC_BAND_1_N4_1                  0x2408
+#define WM8958_MBC_BAND_1_N4_2                  0x2409
+#define WM8958_MBC_BAND_1_N5_1                  0x240A
+#define WM8958_MBC_BAND_1_N5_2                  0x240B
+#define WM8958_MBC_BAND_1_X1_1                  0x240C
+#define WM8958_MBC_BAND_1_X1_2                  0x240D
+#define WM8958_MBC_BAND_1_X2_1                  0x240E
+#define WM8958_MBC_BAND_1_X2_2                  0x240F
+#define WM8958_MBC_BAND_1_X3_1                  0x2410
+#define WM8958_MBC_BAND_1_X3_2                  0x2411
+#define WM8958_MBC_BAND_1_ATTACK_1              0x2412
+#define WM8958_MBC_BAND_1_ATTACK_2              0x2413
+#define WM8958_MBC_BAND_1_DECAY_1               0x2414
+#define WM8958_MBC_BAND_1_DECAY_2               0x2415
+#define WM8958_MBC_BAND_2_K_1                   0x2416
+#define WM8958_MBC_BAND_2_K_2                   0x2417
+#define WM8958_MBC_BAND_2_N1_1                  0x2418
+#define WM8958_MBC_BAND_2_N1_2                  0x2419
+#define WM8958_MBC_BAND_2_N2_1                  0x241A
+#define WM8958_MBC_BAND_2_N2_2                  0x241B
+#define WM8958_MBC_BAND_2_N3_1                  0x241C
+#define WM8958_MBC_BAND_2_N3_2                  0x241D
+#define WM8958_MBC_BAND_2_N4_1                  0x241E
+#define WM8958_MBC_BAND_2_N4_2                  0x241F
+#define WM8958_MBC_BAND_2_N5_1                  0x2420
+#define WM8958_MBC_BAND_2_N5_2                  0x2421
+#define WM8958_MBC_BAND_2_X1_1                  0x2422
+#define WM8958_MBC_BAND_2_X1_2                  0x2423
+#define WM8958_MBC_BAND_2_X2_1                  0x2424
+#define WM8958_MBC_BAND_2_X2_2                  0x2425
+#define WM8958_MBC_BAND_2_X3_1                  0x2426
+#define WM8958_MBC_BAND_2_X3_2                  0x2427
+#define WM8958_MBC_BAND_2_ATTACK_1              0x2428
+#define WM8958_MBC_BAND_2_ATTACK_2              0x2429
+#define WM8958_MBC_BAND_2_DECAY_1               0x242A
+#define WM8958_MBC_BAND_2_DECAY_2               0x242B
+#define WM8958_MBC_B2_PG2_1                     0x242C
+#define WM8958_MBC_B2_PG2_2                     0x242D
+#define WM8958_MBC_B1_PG2_1                     0x242E
+#define WM8958_MBC_B1_PG2_2                     0x242F
 #define WM8994_WRITE_SEQUENCER_0                0x3000
 #define WM8994_WRITE_SEQUENCER_1                0x3001
 #define WM8994_WRITE_SEQUENCER_2                0x3002
diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index c9e5f38..af3a98a 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -92,6 +92,11 @@ struct wm8994_priv {
 	int retune_mobile_cfg[WM8994_NUM_EQ];
 	struct soc_enum retune_mobile_enum;
 
+	/* Platform dependant MBC configuration */
+	int mbc_cfg;
+	const char **mbc_texts;
+	struct soc_enum mbc_enum;
+
 	struct wm8994_micdet micdet[2];
 
 	wm8958_micdet_cb jack_cb;
@@ -543,8 +548,9 @@ static const struct soc_enum aif2dacr_src =
 static void wm8958_mbc_apply(struct snd_soc_codec *codec, int mbc, int start)
 {
 	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
+	struct wm8994_pdata *pdata = wm8994->pdata;
 	int pwr_reg = snd_soc_read(codec, WM8994_POWER_MANAGEMENT_5);
-	int ena, reg, aif;
+	int ena, reg, aif, i;
 
 	switch (mbc) {
 	case 0:
@@ -587,7 +593,20 @@ static void wm8958_mbc_apply(struct snd_soc_codec *codec, int mbc, int start)
 		snd_soc_update_bits(codec, WM8958_DSP2_PROGRAM,
 				    WM8958_DSP2_ENA, WM8958_DSP2_ENA);
 
-		/* TODO: Apply any user specified MBC settings */
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
 
 		/* Run the DSP */
 		snd_soc_write(codec, WM8958_DSP2_EXECCONTROL,
@@ -648,6 +667,39 @@ static int wm8958_aif_ev(struct snd_soc_dapm_widget *w,
 	return 0;
 }
 
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
 static int wm8958_mbc_info(struct snd_kcontrol *kcontrol,
 			   struct snd_ctl_elem_info *uinfo)
 {
@@ -2557,6 +2609,34 @@ static void wm8994_handle_pdata(struct wm8994_priv *wm8994)
 	dev_dbg(codec->dev, "%d ReTune Mobile configurations\n",
 		pdata->num_retune_mobile_cfgs);
 
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
 	if (pdata->num_retune_mobile_cfgs)
 		wm8994_handle_retune_mobile_pdata(wm8994);
 	else
-- 
1.7.1
