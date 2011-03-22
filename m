From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 3/4] ASoC: Add WM8958 VSS support
Date: Tue, 22 Mar 2011 17:51:57 +0000
Message-ID: <1300816318-1859-3-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1300816318-1859-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1CD6B24417
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

With appropriate firmware the WM8958 can support Virtual Surround Sound or
VSS, widening the stereo audio image for improved user experience. Enable
support for this mode of operation when the appropriate firmware can be
loaded at runtime.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 include/linux/mfd/wm8994/pdata.h |   34 ++++
 sound/soc/codecs/wm8958-dsp2.c   |  363 +++++++++++++++++++++++++++++++++++++-
 sound/soc/codecs/wm8994.c        |    2 +
 sound/soc/codecs/wm8994.h        |   14 ++
 4 files changed, 405 insertions(+), 8 deletions(-)

diff --git a/include/linux/mfd/wm8994/pdata.h b/include/linux/mfd/wm8994/pdata.h
index 466b1c7..c72174a 100644
--- a/include/linux/mfd/wm8994/pdata.h
+++ b/include/linux/mfd/wm8994/pdata.h
@@ -32,6 +32,9 @@ struct wm8994_ldo_pdata {
 #define WM8994_EQ_REGS  20
 #define WM8958_MBC_CUTOFF_REGS 20
 #define WM8958_MBC_COEFF_REGS  48
+#define WM8958_MBC_COMBINED_REGS 56
+#define WM8958_VSS_HPF_REGS 2
+#define WM8958_VSS_REGS 148
 
 /**
  * DRC configurations are specified with a label and a set of register
@@ -71,6 +74,31 @@ struct wm8958_mbc_cfg {
 	const char *name;
 	u16 cutoff_regs[WM8958_MBC_CUTOFF_REGS];
 	u16 coeff_regs[WM8958_MBC_COEFF_REGS];
+
+	/* Coefficient layout when using MBC+VSS firmware */
+	u16 combined_regs[WM8958_MBC_COMBINED_REGS];
+};
+
+/**
+ * VSS HPF configurations are specified with a label and two values to
+ * write.  Configurations are expected to be generated using the
+ * multiband compressor configuration panel in WISCE - see
+ * http://www.wolfsonmicro.com/wisce/
+ */
+struct wm8958_vss_hpf_cfg {
+	const char *name;
+	u16 regs[WM8958_VSS_HPF_REGS];
+};
+
+/**
+ * VSS configurations are specified with a label and array of values
+ * to write.  Configurations are expected to be generated using the
+ * multiband compressor configuration panel in WISCE - see
+ * http://www.wolfsonmicro.com/wisce/
+ */
+struct wm8958_vss_cfg {
+	const char *name;
+	u16 regs[WM8958_VSS_REGS];
 };
 
 struct wm8994_pdata {
@@ -95,6 +123,12 @@ struct wm8994_pdata {
 	int num_mbc_cfgs;
 	struct wm8958_mbc_cfg *mbc_cfgs;
 
+	int num_vss_cfgs;
+	struct wm8958_vss_cfg *vss_cfgs;
+
+	int num_vss_hpf_cfgs;
+	struct wm8958_vss_hpf_cfg *vss_hpf_cfgs;
+
         /* LINEOUT can be differential or single ended */
         unsigned int lineout1_diff:1;
         unsigned int lineout2_diff:1;
diff --git a/sound/soc/codecs/wm8958-dsp2.c b/sound/soc/codecs/wm8958-dsp2.c
index 9c1cbe5..d0e2573 100644
--- a/sound/soc/codecs/wm8958-dsp2.c
+++ b/sound/soc/codecs/wm8958-dsp2.c
@@ -233,6 +233,68 @@ static void wm8958_dsp_start_mbc(struct snd_soc_codec *codec, int path)
 			    WM8958_MBC_ENA);
 }
 
+static void wm8958_dsp_start_vss(struct snd_soc_codec *codec, int path)
+{
+	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
+	struct wm8994_pdata *pdata = wm8994->pdata;
+	int i, ena;
+
+	if (wm8994->mbc_vss)
+		wm8958_dsp2_fw(codec, "MBC+VSS", wm8994->mbc_vss, false);
+
+	snd_soc_update_bits(codec, WM8958_DSP2_PROGRAM,
+			    WM8958_DSP2_ENA, WM8958_DSP2_ENA);
+
+	/* If we've got user supplied settings use them */
+	if (pdata && pdata->num_mbc_cfgs) {
+		struct wm8958_mbc_cfg *cfg
+			= &pdata->mbc_cfgs[wm8994->mbc_cfg];
+
+		for (i = 0; i < ARRAY_SIZE(cfg->combined_regs); i++)
+			snd_soc_write(codec, i + 0x2800,
+				      cfg->combined_regs[i]);
+	}
+
+	if (pdata && pdata->num_vss_cfgs) {
+		struct wm8958_vss_cfg *cfg
+			= &pdata->vss_cfgs[wm8994->vss_cfg];
+
+		for (i = 0; i < ARRAY_SIZE(cfg->regs); i++)
+			snd_soc_write(codec, i + 0x2600, cfg->regs[i]);
+	}
+
+	if (pdata && pdata->num_vss_hpf_cfgs) {
+		struct wm8958_vss_hpf_cfg *cfg
+			= &pdata->vss_hpf_cfgs[wm8994->vss_hpf_cfg];
+
+		for (i = 0; i < ARRAY_SIZE(cfg->regs); i++)
+			snd_soc_write(codec, i + 0x2400, cfg->regs[i]);
+	}
+
+	/* Run the DSP */
+	snd_soc_write(codec, WM8958_DSP2_EXECCONTROL,
+		      WM8958_DSP2_RUNR);
+
+	/* Enable the algorithms we've selected */
+	ena = 0;
+	if (wm8994->mbc_ena[path])
+		ena |= 0x8;
+	if (wm8994->hpf2_ena[path])
+		ena |= 0x4;
+	if (wm8994->hpf1_ena[path])
+		ena |= 0x2;
+	if (wm8994->vss_ena[path])
+		ena |= 0x1;
+
+	snd_soc_write(codec, 0x2201, ena);
+
+	/* Switch the DSP into the data path */
+	snd_soc_update_bits(codec, WM8958_DSP2_CONFIG,
+			    WM8958_MBC_SEL_MASK | WM8958_MBC_ENA,
+			    path << WM8958_MBC_SEL_SHIFT | WM8958_MBC_ENA);
+}
+
+
 static void wm8958_dsp_apply(struct snd_soc_codec *codec, int path, int start)
 {
 	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
@@ -258,7 +320,8 @@ static void wm8958_dsp_apply(struct snd_soc_codec *codec, int path, int start)
 	}
 
 	/* Do we have both an active AIF and an active algorithm? */
-	ena = wm8994->mbc_ena[path];
+	ena = wm8994->mbc_ena[path] || wm8994->vss_ena[path] ||
+		wm8994->hpf1_ena[path] || wm8994->hpf2_ena[path];
 	if (!pwr_reg)
 		ena = 0;
 
@@ -281,11 +344,18 @@ static void wm8958_dsp_apply(struct snd_soc_codec *codec, int path, int start)
 				    aif << WM8958_DSP2CLK_SRC_SHIFT |
 				    WM8958_DSP2CLK_ENA);
 
-		if (wm8994->mbc_ena[path])
+		if (wm8994->vss_ena[path] || wm8994->hpf1_ena[path] ||
+		    wm8994->hpf2_ena[path])
+			wm8958_dsp_start_vss(codec, path);
+		else if (wm8994->mbc_ena[path])
 			wm8958_dsp_start_mbc(codec, path);
 
-		dev_dbg(codec->dev, "DSP running\n");
-	} else {
+		wm8994->dsp_active = path;
+
+		dev_dbg(codec->dev, "DSP running in path %d\n", path);
+	}
+
+	if (!start && wm8994->dsp_active == path) {
 		/* If the DSP is already stopped then noop */
 		if (!(reg & WM8958_DSP2_ENA))
 			return;
@@ -335,7 +405,8 @@ static int wm8958_dsp2_busy(struct wm8994_priv *wm8994, int aif)
 	for (i = 0; i < ARRAY_SIZE(wm8994->mbc_ena); i++) {
 		if (i == aif)
 			continue;
-		if (wm8994->mbc_ena[i])
+		if (wm8994->mbc_ena[i] || wm8994->vss_ena[i] ||
+		    wm8994->hpf1_ena[i] || wm8994->hpf2_ena[i])
 			return 1;
 	}
 
@@ -426,22 +497,239 @@ static int wm8958_mbc_put(struct snd_kcontrol *kcontrol,
 	.get = wm8958_mbc_get, .put = wm8958_mbc_put, \
 	.private_value = xval }
 
+static int wm8958_put_vss_enum(struct snd_kcontrol *kcontrol,
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
+	if (value >= pdata->num_vss_cfgs)
+		return -EINVAL;
+
+	wm8994->vss_cfg = value;
+
+	return 0;
+}
+
+static int wm8958_get_vss_enum(struct snd_kcontrol *kcontrol,
+			       struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
+
+	ucontrol->value.enumerated.item[0] = wm8994->vss_cfg;
+
+	return 0;
+}
+
+static int wm8958_put_vss_hpf_enum(struct snd_kcontrol *kcontrol,
+				   struct snd_ctl_elem_value *ucontrol)
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
+	if (value >= pdata->num_vss_hpf_cfgs)
+		return -EINVAL;
+
+	wm8994->vss_hpf_cfg = value;
+
+	return 0;
+}
+
+static int wm8958_get_vss_hpf_enum(struct snd_kcontrol *kcontrol,
+				   struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
+
+	ucontrol->value.enumerated.item[0] = wm8994->vss_hpf_cfg;
+
+	return 0;
+}
+
+static int wm8958_vss_info(struct snd_kcontrol *kcontrol,
+			   struct snd_ctl_elem_info *uinfo)
+{
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_BOOLEAN;
+	uinfo->count = 1;
+	uinfo->value.integer.min = 0;
+	uinfo->value.integer.max = 1;
+	return 0;
+}
+
+static int wm8958_vss_get(struct snd_kcontrol *kcontrol,
+			  struct snd_ctl_elem_value *ucontrol)
+{
+	int vss = kcontrol->private_value;
+	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
+
+	ucontrol->value.integer.value[0] = wm8994->vss_ena[vss];
+
+	return 0;
+}
+
+static int wm8958_vss_put(struct snd_kcontrol *kcontrol,
+			  struct snd_ctl_elem_value *ucontrol)
+{
+	int vss = kcontrol->private_value;
+	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
+
+	if (ucontrol->value.integer.value[0] > 1)
+		return -EINVAL;
+
+	if (!wm8994->mbc_vss)
+		return -ENODEV;
+
+	if (wm8958_dsp2_busy(wm8994, vss)) {
+		dev_dbg(codec->dev, "DSP2 active on %d already\n", vss);
+		return -EBUSY;
+	}
+
+	wm8994->vss_ena[vss] = ucontrol->value.integer.value[0];
+
+	wm8958_dsp_apply(codec, vss, wm8994->vss_ena[vss]);
+
+	return 0;
+}
+
+
+#define WM8958_VSS_SWITCH(xname, xval) {\
+	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = (xname), \
+	.access = SNDRV_CTL_ELEM_ACCESS_READWRITE,\
+	.info = wm8958_vss_info, \
+	.get = wm8958_vss_get, .put = wm8958_vss_put, \
+	.private_value = xval }
+
+static int wm8958_hpf_info(struct snd_kcontrol *kcontrol,
+			   struct snd_ctl_elem_info *uinfo)
+{
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_BOOLEAN;
+	uinfo->count = 1;
+	uinfo->value.integer.min = 0;
+	uinfo->value.integer.max = 1;
+	return 0;
+}
+
+static int wm8958_hpf_get(struct snd_kcontrol *kcontrol,
+			  struct snd_ctl_elem_value *ucontrol)
+{
+	int hpf = kcontrol->private_value;
+	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
+
+	if (hpf < 3)
+		ucontrol->value.integer.value[0] = wm8994->hpf1_ena[hpf % 3];
+	else
+		ucontrol->value.integer.value[0] = wm8994->hpf2_ena[hpf % 3];
+
+	return 0;
+}
+
+static int wm8958_hpf_put(struct snd_kcontrol *kcontrol,
+			  struct snd_ctl_elem_value *ucontrol)
+{
+	int hpf = kcontrol->private_value;
+	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
+
+	if (ucontrol->value.integer.value[0] > 1)
+		return -EINVAL;
+
+	if (!wm8994->mbc_vss)
+		return -ENODEV;
+
+	if (wm8958_dsp2_busy(wm8994, hpf % 3)) {
+		dev_dbg(codec->dev, "DSP2 active on %d already\n", hpf);
+		return -EBUSY;
+	}
+
+	if (wm8994->eq[hpf % 3])
+		return -EBUSY;
+
+	if (hpf < 3)
+		wm8994->hpf1_ena[hpf % 3] = ucontrol->value.integer.value[0];
+	else
+		wm8994->hpf2_ena[hpf % 3] = ucontrol->value.integer.value[0];
+
+	wm8958_dsp_apply(codec, hpf % 3, ucontrol->value.integer.value[0]);
+
+	return 0;
+}
+
+#define WM8958_HPF_SWITCH(xname, xval) {\
+	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = (xname), \
+	.access = SNDRV_CTL_ELEM_ACCESS_READWRITE,\
+	.info = wm8958_hpf_info, \
+	.get = wm8958_hpf_get, .put = wm8958_hpf_put, \
+	.private_value = xval }
+
 static const struct snd_kcontrol_new wm8958_mbc_snd_controls[] = {
 WM8958_MBC_SWITCH("AIF1DAC1 MBC Switch", 0),
 WM8958_MBC_SWITCH("AIF1DAC2 MBC Switch", 1),
 WM8958_MBC_SWITCH("AIF2DAC MBC Switch", 2),
 };
 
-static void wm8958_mbc_loaded(const struct firmware *fw, void *context)
+static const struct snd_kcontrol_new wm8958_vss_snd_controls[] = {
+WM8958_VSS_SWITCH("AIF1DAC1 VSS Switch", 0),
+WM8958_VSS_SWITCH("AIF1DAC2 VSS Switch", 1),
+WM8958_VSS_SWITCH("AIF2DAC VSS Switch", 2),
+WM8958_HPF_SWITCH("AIF1DAC1 HPF1 Switch", 0),
+WM8958_HPF_SWITCH("AIF1DAC2 HPF1 Switch", 1),
+WM8958_HPF_SWITCH("AIF2DAC HPF1 Switch", 2),
+WM8958_HPF_SWITCH("AIF1DAC1 HPF2 Switch", 3),
+WM8958_HPF_SWITCH("AIF1DAC2 HPF2 Switch", 4),
+WM8958_HPF_SWITCH("AIF2DAC HPF2 Switch", 5),
+};
+
+static void wm8958_mbc_vss_loaded(const struct firmware *fw, void *context)
 {
 	struct snd_soc_codec *codec = context;
 	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
 
-	if (fw && wm8958_dsp2_fw(codec, "MBC", fw, true) != 0) {
+	if (fw && (wm8958_dsp2_fw(codec, "MBC+VSS", fw, true) == 0)) {
 		mutex_lock(&codec->mutex);
-		wm8994->mbc = fw;
+		wm8994->mbc_vss = fw;
 		mutex_unlock(&codec->mutex);
 	}
+
+}
+
+static void wm8958_mbc_loaded(const struct firmware *fw, void *context)
+{
+	struct snd_soc_codec *codec = context;
+	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
+
+	if (wm8958_dsp2_fw(codec, "MBC", fw, true) != 0)
+		return;
+
+	mutex_lock(&codec->mutex);
+	wm8994->mbc = fw;
+	mutex_unlock(&codec->mutex);
+
+	/* We can't have more than one request outstanding at once so
+	 * we daisy chain.
+	 */
+	request_firmware_nowait(THIS_MODULE, FW_ACTION_HOTPLUG,
+				"wm8958_mbc_vss.wfw", codec->dev, GFP_KERNEL,
+				codec, wm8958_mbc_vss_loaded);
 }
 
 void wm8958_dsp2_init(struct snd_soc_codec *codec)
@@ -454,6 +742,9 @@ void wm8958_dsp2_init(struct snd_soc_codec *codec)
 
 	snd_soc_add_controls(codec, wm8958_mbc_snd_controls,
 			     ARRAY_SIZE(wm8958_mbc_snd_controls));
+	snd_soc_add_controls(codec, wm8958_vss_snd_controls,
+			     ARRAY_SIZE(wm8958_vss_snd_controls));
+
 
 	/* We don't *require* firmware and don't want to delay boot */
 	request_firmware_nowait(THIS_MODULE, FW_ACTION_HOTPLUG,
@@ -491,5 +782,61 @@ void wm8958_dsp2_init(struct snd_soc_codec *codec)
 				"Failed to add MBC mode controls: %d\n", ret);
 	}
 
+	if (pdata->num_vss_cfgs) {
+		struct snd_kcontrol_new control[] = {
+			SOC_ENUM_EXT("VSS Mode", wm8994->vss_enum,
+				     wm8958_get_vss_enum, wm8958_put_vss_enum),
+		};
 
+		/* We need an array of texts for the enum API */
+		wm8994->vss_texts = kmalloc(sizeof(char *)
+					    * pdata->num_vss_cfgs, GFP_KERNEL);
+		if (!wm8994->vss_texts) {
+			dev_err(wm8994->codec->dev,
+				"Failed to allocate %d VSS config texts\n",
+				pdata->num_vss_cfgs);
+			return;
+		}
+
+		for (i = 0; i < pdata->num_vss_cfgs; i++)
+			wm8994->vss_texts[i] = pdata->vss_cfgs[i].name;
+
+		wm8994->vss_enum.max = pdata->num_vss_cfgs;
+		wm8994->vss_enum.texts = wm8994->vss_texts;
+
+		ret = snd_soc_add_controls(wm8994->codec, control, 1);
+		if (ret != 0)
+			dev_err(wm8994->codec->dev,
+				"Failed to add VSS mode controls: %d\n", ret);
+	}
+
+	if (pdata->num_vss_hpf_cfgs) {
+		struct snd_kcontrol_new control[] = {
+			SOC_ENUM_EXT("VSS HPF Mode", wm8994->vss_hpf_enum,
+				     wm8958_get_vss_hpf_enum,
+				     wm8958_put_vss_hpf_enum),
+		};
+
+		/* We need an array of texts for the enum API */
+		wm8994->vss_hpf_texts = kmalloc(sizeof(char *)
+						* pdata->num_vss_hpf_cfgs, GFP_KERNEL);
+		if (!wm8994->vss_hpf_texts) {
+			dev_err(wm8994->codec->dev,
+				"Failed to allocate %d VSS HPF config texts\n",
+				pdata->num_vss_hpf_cfgs);
+			return;
+		}
+
+		for (i = 0; i < pdata->num_vss_hpf_cfgs; i++)
+			wm8994->vss_hpf_texts[i] = pdata->vss_hpf_cfgs[i].name;
+
+		wm8994->vss_hpf_enum.max = pdata->num_vss_hpf_cfgs;
+		wm8994->vss_hpf_enum.texts = wm8994->vss_hpf_texts;
+
+		ret = snd_soc_add_controls(wm8994->codec, control, 1);
+		if (ret != 0)
+			dev_err(wm8994->codec->dev,
+				"Failed to add VSS HPFmode controls: %d\n",
+				ret);
+	}
 }
diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index f622ff6..01ef5704 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -3140,6 +3140,8 @@ static int  wm8994_codec_remove(struct snd_soc_codec *codec)
 	}
 	if (wm8994->mbc)
 		release_firmware(wm8994->mbc);
+	if (wm8994->mbc_vss)
+		release_firmware(wm8994->mbc_vss);
 	kfree(wm8994->retune_mobile_texts);
 	kfree(wm8994->drc_texts);
 	kfree(wm8994);
diff --git a/sound/soc/codecs/wm8994.h b/sound/soc/codecs/wm8994.h
index a4bfde8..f337f3d 100644
--- a/sound/soc/codecs/wm8994.h
+++ b/sound/soc/codecs/wm8994.h
@@ -84,6 +84,9 @@ struct wm8994_priv {
 	int lrclk_shared[2];
 
 	int mbc_ena[3];
+	int hpf1_ena[3];
+	int hpf2_ena[3];
+	int vss_ena[3];
 
 	/* Platform dependant DRC configuration */
 	const char **drc_texts;
@@ -101,6 +104,16 @@ struct wm8994_priv {
 	const char **mbc_texts;
 	struct soc_enum mbc_enum;
 
+	/* Platform dependant VSS configuration */
+	int vss_cfg;
+	const char **vss_texts;
+	struct soc_enum vss_enum;
+
+	/* Platform dependant VSS HPF configuration */
+	int vss_hpf_cfg;
+	const char **vss_hpf_texts;
+	struct soc_enum vss_hpf_enum;
+
 	struct wm8994_micdet micdet[2];
 
 	wm8958_micdet_cb jack_cb;
@@ -119,6 +132,7 @@ struct wm8994_priv {
 	int dsp_active;
 	const struct firmware *cur_fw;
 	const struct firmware *mbc;
+	const struct firmware *mbc_vss;
 };
 
 #endif
-- 
1.7.4.1
