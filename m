From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/2] ASoC: wm8994: Use pdata cached in MFD
	driver
Date: Thu, 22 Nov 2012 17:12:17 +0900
Message-ID: <1353571937-23506-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1353571937-23506-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id BDAE926030F
 for <alsa-devel@alsa-project.org>; Fri, 23 Nov 2012 01:49:35 +0100 (CET)
In-Reply-To: <1353571937-23506-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Samuel Ortiz <sameo@linux.intel.com>, Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

This is better style and facilitates implementation of device tree support
for the driver.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8958-dsp2.c |   48 +++++++++++++++++++---------------------
 sound/soc/codecs/wm8994.c      |   48 ++++++++++++++++++++++------------------
 sound/soc/codecs/wm8994.h      |    1 -
 3 files changed, 50 insertions(+), 47 deletions(-)

diff --git a/sound/soc/codecs/wm8958-dsp2.c b/sound/soc/codecs/wm8958-dsp2.c
index bff9650..b0710d8 100644
--- a/sound/soc/codecs/wm8958-dsp2.c
+++ b/sound/soc/codecs/wm8958-dsp2.c
@@ -195,7 +195,7 @@ ok:
 static void wm8958_dsp_start_mbc(struct snd_soc_codec *codec, int path)
 {
 	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
-	struct wm8994_pdata *pdata = wm8994->pdata;
+	struct wm8994 *control = wm8994->wm8994;
 	int i;
 
 	/* If the DSP is already running then noop */
@@ -210,9 +210,9 @@ static void wm8958_dsp_start_mbc(struct snd_soc_codec *codec, int path)
 			    WM8958_DSP2_ENA, WM8958_DSP2_ENA);
 
 	/* If we've got user supplied MBC settings use them */
-	if (pdata && pdata->num_mbc_cfgs) {
+	if (control->pdata.num_mbc_cfgs) {
 		struct wm8958_mbc_cfg *cfg
-			= &pdata->mbc_cfgs[wm8994->mbc_cfg];
+			= &control->pdata.mbc_cfgs[wm8994->mbc_cfg];
 
 		for (i = 0; i < ARRAY_SIZE(cfg->coeff_regs); i++)
 			snd_soc_write(codec, i + WM8958_MBC_BAND_1_K_1,
@@ -239,7 +239,7 @@ static void wm8958_dsp_start_mbc(struct snd_soc_codec *codec, int path)
 static void wm8958_dsp_start_vss(struct snd_soc_codec *codec, int path)
 {
 	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
-	struct wm8994_pdata *pdata = wm8994->pdata;
+	struct wm8994 *control = wm8994->wm8994;
 	int i, ena;
 
 	if (wm8994->mbc_vss)
@@ -249,26 +249,26 @@ static void wm8958_dsp_start_vss(struct snd_soc_codec *codec, int path)
 			    WM8958_DSP2_ENA, WM8958_DSP2_ENA);
 
 	/* If we've got user supplied settings use them */
-	if (pdata && pdata->num_mbc_cfgs) {
+	if (control->pdata.num_mbc_cfgs) {
 		struct wm8958_mbc_cfg *cfg
-			= &pdata->mbc_cfgs[wm8994->mbc_cfg];
+			= &control->pdata.mbc_cfgs[wm8994->mbc_cfg];
 
 		for (i = 0; i < ARRAY_SIZE(cfg->combined_regs); i++)
 			snd_soc_write(codec, i + 0x2800,
 				      cfg->combined_regs[i]);
 	}
 
-	if (pdata && pdata->num_vss_cfgs) {
+	if (control->pdata.num_vss_cfgs) {
 		struct wm8958_vss_cfg *cfg
-			= &pdata->vss_cfgs[wm8994->vss_cfg];
+			= &control->pdata.vss_cfgs[wm8994->vss_cfg];
 
 		for (i = 0; i < ARRAY_SIZE(cfg->regs); i++)
 			snd_soc_write(codec, i + 0x2600, cfg->regs[i]);
 	}
 
-	if (pdata && pdata->num_vss_hpf_cfgs) {
+	if (control->pdata.num_vss_hpf_cfgs) {
 		struct wm8958_vss_hpf_cfg *cfg
-			= &pdata->vss_hpf_cfgs[wm8994->vss_hpf_cfg];
+			= &control->pdata.vss_hpf_cfgs[wm8994->vss_hpf_cfg];
 
 		for (i = 0; i < ARRAY_SIZE(cfg->regs); i++)
 			snd_soc_write(codec, i + 0x2400, cfg->regs[i]);
@@ -300,7 +300,7 @@ static void wm8958_dsp_start_vss(struct snd_soc_codec *codec, int path)
 static void wm8958_dsp_start_enh_eq(struct snd_soc_codec *codec, int path)
 {
 	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
-	struct wm8994_pdata *pdata = wm8994->pdata;
+	struct wm8994 *control = wm8994->wm8994;
 	int i;
 
 	wm8958_dsp2_fw(codec, "ENH_EQ", wm8994->enh_eq, false);
@@ -309,9 +309,9 @@ static void wm8958_dsp_start_enh_eq(struct snd_soc_codec *codec, int path)
 			    WM8958_DSP2_ENA, WM8958_DSP2_ENA);
 
 	/* If we've got user supplied settings use them */
-	if (pdata && pdata->num_enh_eq_cfgs) {
+	if (control->pdata.num_enh_eq_cfgs) {
 		struct wm8958_enh_eq_cfg *cfg
-			= &pdata->enh_eq_cfgs[wm8994->enh_eq_cfg];
+			= &control->pdata.enh_eq_cfgs[wm8994->enh_eq_cfg];
 
 		for (i = 0; i < ARRAY_SIZE(cfg->regs); i++)
 			snd_soc_write(codec, i + 0x2200,
@@ -458,7 +458,7 @@ static int wm8958_put_mbc_enum(struct snd_kcontrol *kcontrol,
 {
 	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
 	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
-	struct wm8994_pdata *pdata = wm8994->pdata;
+	struct wm8994 *control = wm8994->wm8994;
 	int value = ucontrol->value.integer.value[0];
 	int reg;
 
@@ -467,7 +467,7 @@ static int wm8958_put_mbc_enum(struct snd_kcontrol *kcontrol,
 	if (reg < 0 || reg & WM8958_DSP2CLK_ENA)
 		return -EBUSY;
 
-	if (value >= pdata->num_mbc_cfgs)
+	if (value >= control->pdata.num_mbc_cfgs)
 		return -EINVAL;
 
 	wm8994->mbc_cfg = value;
@@ -548,7 +548,7 @@ static int wm8958_put_vss_enum(struct snd_kcontrol *kcontrol,
 {
 	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
 	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
-	struct wm8994_pdata *pdata = wm8994->pdata;
+	struct wm8994 *control = wm8994->wm8994;
 	int value = ucontrol->value.integer.value[0];
 	int reg;
 
@@ -557,7 +557,7 @@ static int wm8958_put_vss_enum(struct snd_kcontrol *kcontrol,
 	if (reg < 0 || reg & WM8958_DSP2CLK_ENA)
 		return -EBUSY;
 
-	if (value >= pdata->num_vss_cfgs)
+	if (value >= control->pdata.num_vss_cfgs)
 		return -EINVAL;
 
 	wm8994->vss_cfg = value;
@@ -581,7 +581,7 @@ static int wm8958_put_vss_hpf_enum(struct snd_kcontrol *kcontrol,
 {
 	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
 	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
-	struct wm8994_pdata *pdata = wm8994->pdata;
+	struct wm8994 *control = wm8994->wm8994;
 	int value = ucontrol->value.integer.value[0];
 	int reg;
 
@@ -590,7 +590,7 @@ static int wm8958_put_vss_hpf_enum(struct snd_kcontrol *kcontrol,
 	if (reg < 0 || reg & WM8958_DSP2CLK_ENA)
 		return -EBUSY;
 
-	if (value >= pdata->num_vss_hpf_cfgs)
+	if (value >= control->pdata.num_vss_hpf_cfgs)
 		return -EINVAL;
 
 	wm8994->vss_hpf_cfg = value;
@@ -748,7 +748,7 @@ static int wm8958_put_enh_eq_enum(struct snd_kcontrol *kcontrol,
 {
 	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
 	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
-	struct wm8994_pdata *pdata = wm8994->pdata;
+	struct wm8994 *control = wm8994->wm8994;
 	int value = ucontrol->value.integer.value[0];
 	int reg;
 
@@ -757,7 +757,7 @@ static int wm8958_put_enh_eq_enum(struct snd_kcontrol *kcontrol,
 	if (reg < 0 || reg & WM8958_DSP2CLK_ENA)
 		return -EBUSY;
 
-	if (value >= pdata->num_enh_eq_cfgs)
+	if (value >= control->pdata.num_enh_eq_cfgs)
 		return -EINVAL;
 
 	wm8994->enh_eq_cfg = value;
@@ -900,7 +900,8 @@ static void wm8958_mbc_loaded(const struct firmware *fw, void *context)
 void wm8958_dsp2_init(struct snd_soc_codec *codec)
 {
 	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
-	struct wm8994_pdata *pdata = wm8994->pdata;
+	struct wm8994 *control = wm8994->wm8994;
+	struct wm8994_pdata *pdata = &control->pdata;
 	int ret, i;
 
 	wm8994->dsp_active = -1;
@@ -924,9 +925,6 @@ void wm8958_dsp2_init(struct snd_soc_codec *codec)
 				"wm8958_enh_eq.wfw", codec->dev, GFP_KERNEL,
 				codec, wm8958_enh_eq_loaded);
 
-	if (!pdata)
-		return;
-
 	if (pdata->num_mbc_cfgs) {
 		struct snd_kcontrol_new control[] = {
 			SOC_ENUM_EXT("MBC Mode", wm8994->mbc_enum,
diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index 2484133..13c8869 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -110,13 +110,13 @@ static const struct wm8958_micd_rate jackdet_rates[] = {
 static void wm8958_micd_set_rate(struct snd_soc_codec *codec)
 {
 	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
+	struct wm8994 *control = wm8994->wm8994;
 	int best, i, sysclk, val;
 	bool idle;
 	const struct wm8958_micd_rate *rates;
 	int num_rates;
 
-	if (!(wm8994->pdata && wm8994->pdata->micd_rates) &&
-	    wm8994->jack_cb != wm8958_default_micdet)
+	if (wm8994->jack_cb != wm8958_default_micdet)
 		return;
 
 	idle = !wm8994->jack_mic;
@@ -127,9 +127,9 @@ static void wm8958_micd_set_rate(struct snd_soc_codec *codec)
 	else
 		sysclk = wm8994->aifclk[0];
 
-	if (wm8994->pdata && wm8994->pdata->micd_rates) {
-		rates = wm8994->pdata->micd_rates;
-		num_rates = wm8994->pdata->num_micd_rates;
+	if (control->pdata.micd_rates) {
+		rates = control->pdata.micd_rates;
+		num_rates = control->pdata.num_micd_rates;
 	} else if (wm8994->jackdet) {
 		rates = jackdet_rates;
 		num_rates = ARRAY_SIZE(jackdet_rates);
@@ -326,7 +326,8 @@ static int wm8994_put_drc_sw(struct snd_kcontrol *kcontrol,
 static void wm8994_set_drc(struct snd_soc_codec *codec, int drc)
 {
 	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
-	struct wm8994_pdata *pdata = wm8994->pdata;
+	struct wm8994 *control = wm8994->wm8994;
+	struct wm8994_pdata *pdata = &control->pdata;
 	int base = wm8994_drc_base[drc];
 	int cfg = wm8994->drc_cfg[drc];
 	int save, i;
@@ -362,7 +363,8 @@ static int wm8994_put_drc_enum(struct snd_kcontrol *kcontrol,
 {
 	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
 	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
-	struct wm8994_pdata *pdata = wm8994->pdata;
+	struct wm8994 *control = wm8994->wm8994;
+	struct wm8994_pdata *pdata = &control->pdata;
 	int drc = wm8994_get_drc(kcontrol->id.name);
 	int value = ucontrol->value.integer.value[0];
 
@@ -394,7 +396,8 @@ static int wm8994_get_drc_enum(struct snd_kcontrol *kcontrol,
 static void wm8994_set_retune_mobile(struct snd_soc_codec *codec, int block)
 {
 	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
-	struct wm8994_pdata *pdata = wm8994->pdata;
+	struct wm8994 *control = wm8994->wm8994;
+	struct wm8994_pdata *pdata = &control->pdata;
 	int base = wm8994_retune_mobile_base[block];
 	int iface, best, best_val, save, i, cfg;
 
@@ -465,7 +468,8 @@ static int wm8994_put_retune_mobile_enum(struct snd_kcontrol *kcontrol,
 {
 	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
 	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
-	struct wm8994_pdata *pdata = wm8994->pdata;
+	struct wm8994 *control = wm8994->wm8994;
+	struct wm8994_pdata *pdata = &control->pdata;
 	int block = wm8994_get_retune_mobile_block(kcontrol->id.name);
 	int value = ucontrol->value.integer.value[0];
 
@@ -3080,7 +3084,8 @@ static int wm8994_codec_resume(struct snd_soc_codec *codec)
 static void wm8994_handle_retune_mobile_pdata(struct wm8994_priv *wm8994)
 {
 	struct snd_soc_codec *codec = wm8994->hubs.codec;
-	struct wm8994_pdata *pdata = wm8994->pdata;
+	struct wm8994 *control = wm8994->wm8994;
+	struct wm8994_pdata *pdata = &control->pdata;
 	struct snd_kcontrol_new controls[] = {
 		SOC_ENUM_EXT("AIF1.1 EQ Mode",
 			     wm8994->retune_mobile_enum,
@@ -3147,7 +3152,8 @@ static void wm8994_handle_retune_mobile_pdata(struct wm8994_priv *wm8994)
 static void wm8994_handle_pdata(struct wm8994_priv *wm8994)
 {
 	struct snd_soc_codec *codec = wm8994->hubs.codec;
-	struct wm8994_pdata *pdata = wm8994->pdata;
+	struct wm8994 *control = wm8994->wm8994;
+	struct wm8994_pdata *pdata = &control->pdata;
 	int ret, i;
 
 	if (!pdata)
@@ -3489,12 +3495,13 @@ static void wm1811_mic_work(struct work_struct *work)
 {
 	struct wm8994_priv *wm8994 = container_of(work, struct wm8994_priv,
 						  mic_work.work);
+	struct wm8994 *control = wm8994->wm8994;
 	struct snd_soc_codec *codec = wm8994->hubs.codec;
 
 	pm_runtime_get_sync(codec->dev);
 
 	/* If required for an external cap force MICBIAS on */
-	if (wm8994->pdata->jd_ext_cap) {
+	if (control->pdata.jd_ext_cap) {
 		snd_soc_dapm_force_enable_pin(&codec->dapm,
 					      "MICBIAS2");
 		snd_soc_dapm_sync(&codec->dapm);
@@ -3522,6 +3529,7 @@ static void wm1811_mic_work(struct work_struct *work)
 static irqreturn_t wm1811_jackdet_irq(int irq, void *data)
 {
 	struct wm8994_priv *wm8994 = data;
+	struct wm8994 *control = wm8994->wm8994;
 	struct snd_soc_codec *codec = wm8994->hubs.codec;
 	int reg, delay;
 	bool present;
@@ -3554,7 +3562,7 @@ static irqreturn_t wm1811_jackdet_irq(int irq, void *data)
 		snd_soc_update_bits(codec, WM1811_JACKDET_CTRL,
 				    WM1811_JACKDET_DB, 0);
 
-		delay = wm8994->pdata->micdet_delay;
+		delay = control->pdata.micdet_delay;
 		schedule_delayed_work(&wm8994->mic_work,
 				      msecs_to_jiffies(delay));
 	} else {
@@ -3579,7 +3587,7 @@ static irqreturn_t wm1811_jackdet_irq(int irq, void *data)
 	mutex_unlock(&wm8994->accdet_lock);
 
 	/* Turn off MICBIAS if it was on for an external cap */
-	if (wm8994->pdata->jd_ext_cap && !present)
+	if (control->pdata.jd_ext_cap && !present)
 		snd_soc_dapm_disable_pin(&codec->dapm, "MICBIAS2");
 
 	if (present)
@@ -3657,8 +3665,8 @@ int wm8958_mic_detect(struct snd_soc_codec *codec, struct snd_soc_jack *jack,
 		wm8958_micd_set_rate(codec);
 
 		/* Detect microphones and short circuits by default */
-		if (wm8994->pdata->micd_lvl_sel)
-			micd_lvl_sel = wm8994->pdata->micd_lvl_sel;
+		if (control->pdata.micd_lvl_sel)
+			micd_lvl_sel = control->pdata.micd_lvl_sel;
 		else
 			micd_lvl_sel = 0x41;
 
@@ -3820,8 +3828,7 @@ static int wm8994_codec_probe(struct snd_soc_codec *codec)
 	for (i = 0; i < ARRAY_SIZE(wm8994->fll_locked); i++)
 		init_completion(&wm8994->fll_locked[i]);
 
-	if (wm8994->pdata && wm8994->pdata->micdet_irq)
-		wm8994->micdet_irq = wm8994->pdata->micdet_irq;
+	wm8994->micdet_irq = control->pdata.micdet_irq;
 
 	pm_runtime_enable(codec->dev);
 	pm_runtime_idle(codec->dev);
@@ -3834,8 +3841,8 @@ static int wm8994_codec_probe(struct snd_soc_codec *codec)
 	switch (control->type) {
 	case WM8994:
 		/* Single ended line outputs should have VMID on. */
-		if (!wm8994->pdata->lineout1_diff ||
-		    !wm8994->pdata->lineout2_diff)
+		if (!control->pdata.lineout1_diff ||
+		    !control->pdata.lineout2_diff)
 			codec->dapm.idle_bias_off = 0;
 
 		switch (wm8994->revision) {
@@ -4270,7 +4277,6 @@ static int __devinit wm8994_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, wm8994);
 
 	wm8994->wm8994 = dev_get_drvdata(pdev->dev.parent);
-	wm8994->pdata = dev_get_platdata(pdev->dev.parent);
 
 	return snd_soc_register_codec(&pdev->dev, &soc_codec_dev_wm8994,
 			wm8994_dai, ARRAY_SIZE(wm8994_dai));
diff --git a/sound/soc/codecs/wm8994.h b/sound/soc/codecs/wm8994.h
index ccbce57..3120c0f 100644
--- a/sound/soc/codecs/wm8994.h
+++ b/sound/soc/codecs/wm8994.h
@@ -143,7 +143,6 @@ struct wm8994_priv {
 	int micdet_irq;
 
 	int revision;
-	struct wm8994_pdata *pdata;
 
 	unsigned int aif1clk_enable:1;
 	unsigned int aif2clk_enable:1;
-- 
1.7.10.4
