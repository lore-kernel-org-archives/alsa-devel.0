From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 4/4] ASoC: Add WM8958 enhanced EQ support
Date: Tue, 22 Mar 2011 17:51:58 +0000
Message-ID: <1300816318-1859-4-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1300816318-1859-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1D03C24419
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

DSP2 in the WM8958 can be used to support an upgraded EQ for use in
demanding applications.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 include/linux/mfd/wm8994/pdata.h |   15 +++
 sound/soc/codecs/wm8958-dsp2.c   |  192 +++++++++++++++++++++++++++++++++++++-
 sound/soc/codecs/wm8994.c        |    2 +
 sound/soc/codecs/wm8994.h        |    7 ++
 4 files changed, 213 insertions(+), 3 deletions(-)

diff --git a/include/linux/mfd/wm8994/pdata.h b/include/linux/mfd/wm8994/pdata.h
index c72174a..d12f8d6 100644
--- a/include/linux/mfd/wm8994/pdata.h
+++ b/include/linux/mfd/wm8994/pdata.h
@@ -35,6 +35,7 @@ struct wm8994_ldo_pdata {
 #define WM8958_MBC_COMBINED_REGS 56
 #define WM8958_VSS_HPF_REGS 2
 #define WM8958_VSS_REGS 148
+#define WM8958_ENH_EQ_REGS 32
 
 /**
  * DRC configurations are specified with a label and a set of register
@@ -101,6 +102,17 @@ struct wm8958_vss_cfg {
 	u16 regs[WM8958_VSS_REGS];
 };
 
+/**
+ * Enhanced EQ configurations are specified with a label and array of
+ * values to write.  Configurations are expected to be generated using
+ * the multiband compressor configuration panel in WISCE - see
+ * http://www.wolfsonmicro.com/wisce/
+ */
+struct wm8958_enh_eq_cfg {
+	const char *name;
+	u16 regs[WM8958_ENH_EQ_REGS];
+};
+
 struct wm8994_pdata {
 	int gpio_base;
 
@@ -129,6 +141,9 @@ struct wm8994_pdata {
 	int num_vss_hpf_cfgs;
 	struct wm8958_vss_hpf_cfg *vss_hpf_cfgs;
 
+	int num_enh_eq_cfgs;
+	struct wm8958_enh_eq_cfg *enh_eq_cfgs;
+
         /* LINEOUT can be differential or single ended */
         unsigned int lineout1_diff:1;
         unsigned int lineout2_diff:1;
diff --git a/sound/soc/codecs/wm8958-dsp2.c b/sound/soc/codecs/wm8958-dsp2.c
index d0e2573..74983ee 100644
--- a/sound/soc/codecs/wm8958-dsp2.c
+++ b/sound/soc/codecs/wm8958-dsp2.c
@@ -294,6 +294,36 @@ static void wm8958_dsp_start_vss(struct snd_soc_codec *codec, int path)
 			    path << WM8958_MBC_SEL_SHIFT | WM8958_MBC_ENA);
 }
 
+static void wm8958_dsp_start_enh_eq(struct snd_soc_codec *codec, int path)
+{
+	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
+	struct wm8994_pdata *pdata = wm8994->pdata;
+	int i;
+
+	wm8958_dsp2_fw(codec, "ENH_EQ", wm8994->enh_eq, false);
+
+	snd_soc_update_bits(codec, WM8958_DSP2_PROGRAM,
+			    WM8958_DSP2_ENA, WM8958_DSP2_ENA);
+
+	/* If we've got user supplied settings use them */
+	if (pdata && pdata->num_enh_eq_cfgs) {
+		struct wm8958_enh_eq_cfg *cfg
+			= &pdata->enh_eq_cfgs[wm8994->enh_eq_cfg];
+
+		for (i = 0; i < ARRAY_SIZE(cfg->regs); i++)
+			snd_soc_write(codec, i + 0x2200,
+				      cfg->regs[i]);
+	}
+
+	/* Run the DSP */
+	snd_soc_write(codec, WM8958_DSP2_EXECCONTROL,
+		      WM8958_DSP2_RUNR);
+
+	/* Switch the DSP into the data path */
+	snd_soc_update_bits(codec, WM8958_DSP2_CONFIG,
+			    WM8958_MBC_SEL_MASK | WM8958_MBC_ENA,
+			    path << WM8958_MBC_SEL_SHIFT | WM8958_MBC_ENA);
+}
 
 static void wm8958_dsp_apply(struct snd_soc_codec *codec, int path, int start)
 {
@@ -321,7 +351,8 @@ static void wm8958_dsp_apply(struct snd_soc_codec *codec, int path, int start)
 
 	/* Do we have both an active AIF and an active algorithm? */
 	ena = wm8994->mbc_ena[path] || wm8994->vss_ena[path] ||
-		wm8994->hpf1_ena[path] || wm8994->hpf2_ena[path];
+		wm8994->hpf1_ena[path] || wm8994->hpf2_ena[path] ||
+		wm8994->enh_eq_ena[path];
 	if (!pwr_reg)
 		ena = 0;
 
@@ -344,7 +375,9 @@ static void wm8958_dsp_apply(struct snd_soc_codec *codec, int path, int start)
 				    aif << WM8958_DSP2CLK_SRC_SHIFT |
 				    WM8958_DSP2CLK_ENA);
 
-		if (wm8994->vss_ena[path] || wm8994->hpf1_ena[path] ||
+		if (wm8994->enh_eq_ena[path])
+			wm8958_dsp_start_enh_eq(codec, path);
+		else if (wm8994->vss_ena[path] || wm8994->hpf1_ena[path] ||
 		    wm8994->hpf2_ena[path])
 			wm8958_dsp_start_vss(codec, path);
 		else if (wm8994->mbc_ena[path])
@@ -483,6 +516,9 @@ static int wm8958_mbc_put(struct snd_kcontrol *kcontrol,
 		return -EBUSY;
 	}
 
+	if (wm8994->enh_eq_ena[mbc])
+		return -EBUSY;
+
 	wm8994->mbc_ena[mbc] = ucontrol->value.integer.value[0];
 
 	wm8958_dsp_apply(codec, mbc, wm8994->mbc_ena[mbc]);
@@ -603,6 +639,9 @@ static int wm8958_vss_put(struct snd_kcontrol *kcontrol,
 		return -EBUSY;
 	}
 
+	if (wm8994->enh_eq_ena[vss])
+		return -EBUSY;
+
 	wm8994->vss_ena[vss] = ucontrol->value.integer.value[0];
 
 	wm8958_dsp_apply(codec, vss, wm8994->vss_ena[vss]);
@@ -661,7 +700,7 @@ static int wm8958_hpf_put(struct snd_kcontrol *kcontrol,
 		return -EBUSY;
 	}
 
-	if (wm8994->eq[hpf % 3])
+	if (wm8994->enh_eq_ena[hpf % 3])
 		return -EBUSY;
 
 	if (hpf < 3)
@@ -681,6 +720,97 @@ static int wm8958_hpf_put(struct snd_kcontrol *kcontrol,
 	.get = wm8958_hpf_get, .put = wm8958_hpf_put, \
 	.private_value = xval }
 
+static int wm8958_put_enh_eq_enum(struct snd_kcontrol *kcontrol,
+				  struct snd_ctl_elem_value *ucontrol)
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
+	if (value >= pdata->num_enh_eq_cfgs)
+		return -EINVAL;
+
+	wm8994->enh_eq_cfg = value;
+
+	return 0;
+}
+
+static int wm8958_get_enh_eq_enum(struct snd_kcontrol *kcontrol,
+				  struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
+
+	ucontrol->value.enumerated.item[0] = wm8994->enh_eq_cfg;
+
+	return 0;
+}
+
+static int wm8958_enh_eq_info(struct snd_kcontrol *kcontrol,
+			   struct snd_ctl_elem_info *uinfo)
+{
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_BOOLEAN;
+	uinfo->count = 1;
+	uinfo->value.integer.min = 0;
+	uinfo->value.integer.max = 1;
+	return 0;
+}
+
+static int wm8958_enh_eq_get(struct snd_kcontrol *kcontrol,
+			  struct snd_ctl_elem_value *ucontrol)
+{
+	int eq = kcontrol->private_value;
+	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
+
+	ucontrol->value.integer.value[0] = wm8994->enh_eq_ena[eq];
+
+	return 0;
+}
+
+static int wm8958_enh_eq_put(struct snd_kcontrol *kcontrol,
+			  struct snd_ctl_elem_value *ucontrol)
+{
+	int eq = kcontrol->private_value;
+	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
+
+	if (ucontrol->value.integer.value[0] > 1)
+		return -EINVAL;
+
+	if (!wm8994->enh_eq)
+		return -ENODEV;
+
+	if (wm8958_dsp2_busy(wm8994, eq)) {
+		dev_dbg(codec->dev, "DSP2 active on %d already\n", eq);
+		return -EBUSY;
+	}
+
+	if (wm8994->mbc_ena[eq] || wm8994->vss_ena[eq] ||
+	    wm8994->hpf1_ena[eq] || wm8994->hpf2_ena[eq])
+		return -EBUSY;
+
+	wm8994->enh_eq_ena[eq] = ucontrol->value.integer.value[0];
+
+	wm8958_dsp_apply(codec, eq, ucontrol->value.integer.value[0]);
+
+	return 0;
+}
+
+#define WM8958_ENH_EQ_SWITCH(xname, xval) {\
+	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = (xname), \
+	.access = SNDRV_CTL_ELEM_ACCESS_READWRITE,\
+	.info = wm8958_enh_eq_info, \
+	.get = wm8958_enh_eq_get, .put = wm8958_enh_eq_put, \
+	.private_value = xval }
+
 static const struct snd_kcontrol_new wm8958_mbc_snd_controls[] = {
 WM8958_MBC_SWITCH("AIF1DAC1 MBC Switch", 0),
 WM8958_MBC_SWITCH("AIF1DAC2 MBC Switch", 1),
@@ -699,6 +829,24 @@ WM8958_HPF_SWITCH("AIF1DAC2 HPF2 Switch", 4),
 WM8958_HPF_SWITCH("AIF2DAC HPF2 Switch", 5),
 };
 
+static const struct snd_kcontrol_new wm8958_enh_eq_snd_controls[] = {
+WM8958_ENH_EQ_SWITCH("AIF1DAC1 Enhanced EQ Switch", 0),
+WM8958_ENH_EQ_SWITCH("AIF1DAC2 Enhanced EQ Switch", 1),
+WM8958_ENH_EQ_SWITCH("AIF2DAC Enhanced EQ Switch", 2),
+};
+
+static void wm8958_enh_eq_loaded(const struct firmware *fw, void *context)
+{
+	struct snd_soc_codec *codec = context;
+	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
+
+	if (fw && (wm8958_dsp2_fw(codec, "ENH_EQ", fw, true) == 0)) {
+		mutex_lock(&codec->mutex);
+		wm8994->enh_eq = fw;
+		mutex_unlock(&codec->mutex);
+	}
+}
+
 static void wm8958_mbc_vss_loaded(const struct firmware *fw, void *context)
 {
 	struct snd_soc_codec *codec = context;
@@ -710,6 +858,12 @@ static void wm8958_mbc_vss_loaded(const struct firmware *fw, void *context)
 		mutex_unlock(&codec->mutex);
 	}
 
+	/* We can't have more than one request outstanding at once so
+	 * we daisy chain.
+	 */
+	request_firmware_nowait(THIS_MODULE, FW_ACTION_HOTPLUG,
+				"wm8958_enh_eq.wfw", codec->dev, GFP_KERNEL,
+				codec, wm8958_enh_eq_loaded);
 }
 
 static void wm8958_mbc_loaded(const struct firmware *fw, void *context)
@@ -744,6 +898,8 @@ void wm8958_dsp2_init(struct snd_soc_codec *codec)
 			     ARRAY_SIZE(wm8958_mbc_snd_controls));
 	snd_soc_add_controls(codec, wm8958_vss_snd_controls,
 			     ARRAY_SIZE(wm8958_vss_snd_controls));
+	snd_soc_add_controls(codec, wm8958_enh_eq_snd_controls,
+			     ARRAY_SIZE(wm8958_enh_eq_snd_controls));
 
 
 	/* We don't *require* firmware and don't want to delay boot */
@@ -839,4 +995,34 @@ void wm8958_dsp2_init(struct snd_soc_codec *codec)
 				"Failed to add VSS HPFmode controls: %d\n",
 				ret);
 	}
+
+	if (pdata->num_enh_eq_cfgs) {
+		struct snd_kcontrol_new control[] = {
+			SOC_ENUM_EXT("Enhanced EQ Mode", wm8994->enh_eq_enum,
+				     wm8958_get_enh_eq_enum,
+				     wm8958_put_enh_eq_enum),
+		};
+
+		/* We need an array of texts for the enum API */
+		wm8994->enh_eq_texts = kmalloc(sizeof(char *)
+						* pdata->num_enh_eq_cfgs, GFP_KERNEL);
+		if (!wm8994->enh_eq_texts) {
+			dev_err(wm8994->codec->dev,
+				"Failed to allocate %d enhanced EQ config texts\n",
+				pdata->num_enh_eq_cfgs);
+			return;
+		}
+
+		for (i = 0; i < pdata->num_enh_eq_cfgs; i++)
+			wm8994->enh_eq_texts[i] = pdata->enh_eq_cfgs[i].name;
+
+		wm8994->enh_eq_enum.max = pdata->num_enh_eq_cfgs;
+		wm8994->enh_eq_enum.texts = wm8994->enh_eq_texts;
+
+		ret = snd_soc_add_controls(wm8994->codec, control, 1);
+		if (ret != 0)
+			dev_err(wm8994->codec->dev,
+				"Failed to add enhanced EQ controls: %d\n",
+				ret);
+	}
 }
diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index 01ef5704..03ef624 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -3142,6 +3142,8 @@ static int  wm8994_codec_remove(struct snd_soc_codec *codec)
 		release_firmware(wm8994->mbc);
 	if (wm8994->mbc_vss)
 		release_firmware(wm8994->mbc_vss);
+	if (wm8994->enh_eq)
+		release_firmware(wm8994->enh_eq);
 	kfree(wm8994->retune_mobile_texts);
 	kfree(wm8994->drc_texts);
 	kfree(wm8994);
diff --git a/sound/soc/codecs/wm8994.h b/sound/soc/codecs/wm8994.h
index f337f3d..0a1db04 100644
--- a/sound/soc/codecs/wm8994.h
+++ b/sound/soc/codecs/wm8994.h
@@ -87,6 +87,7 @@ struct wm8994_priv {
 	int hpf1_ena[3];
 	int hpf2_ena[3];
 	int vss_ena[3];
+	int enh_eq_ena[3];
 
 	/* Platform dependant DRC configuration */
 	const char **drc_texts;
@@ -114,6 +115,11 @@ struct wm8994_priv {
 	const char **vss_hpf_texts;
 	struct soc_enum vss_hpf_enum;
 
+	/* Platform dependant enhanced EQ configuration */
+	int enh_eq_cfg;
+	const char **enh_eq_texts;
+	struct soc_enum enh_eq_enum;
+
 	struct wm8994_micdet micdet[2];
 
 	wm8958_micdet_cb jack_cb;
@@ -133,6 +139,7 @@ struct wm8994_priv {
 	const struct firmware *cur_fw;
 	const struct firmware *mbc;
 	const struct firmware *mbc_vss;
+	const struct firmware *enh_eq;
 };
 
 #endif
-- 
1.7.4.1
