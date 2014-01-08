From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 1/2 v2] ASoC: wm_adsp: Factor out ADSP2 boot
	proceedure
Date: Wed,  8 Jan 2014 17:42:18 +0000
Message-ID: <1389202939-13741-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A9575261AB6
 for <alsa-devel@alsa-project.org>; Wed,  8 Jan 2014 18:50:24 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

Move the ADSP2 boot proceedure into a work structure in preparation for
running it asynchronously with the reset of the audio path bring up.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm_adsp.c |  181 +++++++++++++++++++++++++-------------------
 sound/soc/codecs/wm_adsp.h |    2 +
 2 files changed, 105 insertions(+), 78 deletions(-)

Changes since v1:
  - Schedule to the system unbound work queue since it is
    likely to be a fairly long task.
  - Move final start signal to the DSP to be an out_drv
    widget such that the download is overlapped with the
    output enables.

Thanks,
Charles

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index fb0c678..41bbac9 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -1497,107 +1497,131 @@ static int wm_adsp2_ena(struct wm_adsp *dsp)
 	return 0;
 }
 
-int wm_adsp2_event(struct snd_soc_dapm_widget *w,
-		   struct snd_kcontrol *kcontrol, int event)
+void wm_adsp2_boot_work(struct work_struct *work)
 {
-	struct snd_soc_codec *codec = w->codec;
-	struct wm_adsp *dsps = snd_soc_codec_get_drvdata(codec);
-	struct wm_adsp *dsp = &dsps[w->shift];
-	struct wm_adsp_alg_region *alg_region;
-	struct wm_coeff_ctl *ctl;
-	unsigned int val;
+	struct wm_adsp *dsp = container_of(work,
+					   struct wm_adsp,
+					   boot_work);
 	int ret;
+	unsigned int val;
 
-	dsp->card = codec->card;
+	/*
+	 * For simplicity set the DSP clock rate to be the
+	 * SYSCLK rate rather than making it configurable.
+	 */
+	ret = regmap_read(dsp->regmap, ARIZONA_SYSTEM_CLOCK_1, &val);
+	if (ret != 0) {
+		adsp_err(dsp, "Failed to read SYSCLK state: %d\n", ret);
+		return;
+	}
+	val = (val & ARIZONA_SYSCLK_FREQ_MASK)
+		>> ARIZONA_SYSCLK_FREQ_SHIFT;
 
-	switch (event) {
-	case SND_SOC_DAPM_POST_PMU:
-		/*
-		 * For simplicity set the DSP clock rate to be the
-		 * SYSCLK rate rather than making it configurable.
-		 */
-		ret = regmap_read(dsp->regmap, ARIZONA_SYSTEM_CLOCK_1, &val);
-		if (ret != 0) {
-			adsp_err(dsp, "Failed to read SYSCLK state: %d\n",
-				 ret);
-			return ret;
-		}
-		val = (val & ARIZONA_SYSCLK_FREQ_MASK)
-			>> ARIZONA_SYSCLK_FREQ_SHIFT;
+	ret = regmap_update_bits_async(dsp->regmap,
+				       dsp->base + ADSP2_CLOCKING,
+				       ADSP2_CLK_SEL_MASK, val);
+	if (ret != 0) {
+		adsp_err(dsp, "Failed to set clock rate: %d\n", ret);
+		return;
+	}
 
-		ret = regmap_update_bits_async(dsp->regmap,
-					       dsp->base + ADSP2_CLOCKING,
-					       ADSP2_CLK_SEL_MASK, val);
+	if (dsp->dvfs) {
+		ret = regmap_read(dsp->regmap,
+				  dsp->base + ADSP2_CLOCKING, &val);
 		if (ret != 0) {
-			adsp_err(dsp, "Failed to set clock rate: %d\n",
-				 ret);
-			return ret;
+			dev_err(dsp->dev, "Failed to read clocking: %d\n", ret);
+			return;
 		}
 
-		if (dsp->dvfs) {
-			ret = regmap_read(dsp->regmap,
-					  dsp->base + ADSP2_CLOCKING, &val);
+		if ((val & ADSP2_CLK_SEL_MASK) >= 3) {
+			ret = regulator_enable(dsp->dvfs);
 			if (ret != 0) {
 				dev_err(dsp->dev,
-					"Failed to read clocking: %d\n", ret);
-				return ret;
+					"Failed to enable supply: %d\n",
+					ret);
+				return;
 			}
 
-			if ((val & ADSP2_CLK_SEL_MASK) >= 3) {
-				ret = regulator_enable(dsp->dvfs);
-				if (ret != 0) {
-					dev_err(dsp->dev,
-						"Failed to enable supply: %d\n",
-						ret);
-					return ret;
-				}
-
-				ret = regulator_set_voltage(dsp->dvfs,
-							    1800000,
-							    1800000);
-				if (ret != 0) {
-					dev_err(dsp->dev,
-						"Failed to raise supply: %d\n",
-						ret);
-					return ret;
-				}
+			ret = regulator_set_voltage(dsp->dvfs,
+						    1800000,
+						    1800000);
+			if (ret != 0) {
+				dev_err(dsp->dev,
+					"Failed to raise supply: %d\n",
+					ret);
+				return;
 			}
 		}
+	}
 
-		ret = wm_adsp2_ena(dsp);
-		if (ret != 0)
-			return ret;
+	ret = wm_adsp2_ena(dsp);
+	if (ret != 0)
+		return;
 
-		ret = wm_adsp_load(dsp);
-		if (ret != 0)
-			goto err;
+	ret = wm_adsp_load(dsp);
+	if (ret != 0)
+		goto err;
 
-		ret = wm_adsp_setup_algs(dsp);
-		if (ret != 0)
-			goto err;
+	ret = wm_adsp_setup_algs(dsp);
+	if (ret != 0)
+		goto err;
 
-		ret = wm_adsp_load_coeff(dsp);
-		if (ret != 0)
-			goto err;
+	ret = wm_adsp_load_coeff(dsp);
+	if (ret != 0)
+		goto err;
 
-		/* Initialize caches for enabled and unset controls */
-		ret = wm_coeff_init_control_caches(dsp);
-		if (ret != 0)
-			goto err;
+	/* Initialize caches for enabled and unset controls */
+	ret = wm_coeff_init_control_caches(dsp);
+	if (ret != 0)
+		goto err;
 
-		/* Sync set controls */
-		ret = wm_coeff_sync_controls(dsp);
-		if (ret != 0)
-			goto err;
+	/* Sync set controls */
+	ret = wm_coeff_sync_controls(dsp);
+	if (ret != 0)
+		goto err;
+
+	ret = regmap_update_bits_async(dsp->regmap,
+				       dsp->base + ADSP2_CONTROL,
+				       ADSP2_CORE_ENA,
+				       ADSP2_CORE_ENA);
+	if (ret != 0)
+		goto err;
+
+	dsp->running = true;
+
+	return;
 
-		ret = regmap_update_bits_async(dsp->regmap,
-					       dsp->base + ADSP2_CONTROL,
-					       ADSP2_CORE_ENA | ADSP2_START,
-					       ADSP2_CORE_ENA | ADSP2_START);
+err:
+	regmap_update_bits(dsp->regmap, dsp->base + ADSP2_CONTROL,
+			   ADSP2_SYS_ENA | ADSP2_CORE_ENA | ADSP2_START, 0);
+}
+
+int wm_adsp2_event(struct snd_soc_dapm_widget *w,
+		   struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_codec *codec = w->codec;
+	struct wm_adsp *dsps = snd_soc_codec_get_drvdata(codec);
+	struct wm_adsp *dsp = &dsps[w->shift];
+	struct wm_adsp_alg_region *alg_region;
+	struct wm_coeff_ctl *ctl;
+	int ret;
+
+	dsp->card = codec->card;
+
+	switch (event) {
+	case SND_SOC_DAPM_POST_PMU:
+		queue_work(system_unbound_wq, &dsp->boot_work);
+		flush_work(&dsp->boot_work);
+
+		if (!dsp->running)
+			return -EIO;
+
+		ret = regmap_update_bits(dsp->regmap,
+					 dsp->base + ADSP2_CONTROL,
+					 ADSP2_START,
+					 ADSP2_START);
 		if (ret != 0)
 			goto err;
-
-		dsp->running = true;
 		break;
 
 	case SND_SOC_DAPM_PRE_PMD:
@@ -1668,6 +1692,7 @@ int wm_adsp2_init(struct wm_adsp *adsp, bool dvfs)
 
 	INIT_LIST_HEAD(&adsp->alg_regions);
 	INIT_LIST_HEAD(&adsp->ctl_list);
+	INIT_WORK(&adsp->boot_work, wm_adsp2_boot_work);
 
 	if (dvfs) {
 		adsp->dvfs = devm_regulator_get(adsp->dev, "DCVDD");
diff --git a/sound/soc/codecs/wm_adsp.h b/sound/soc/codecs/wm_adsp.h
index d018dea..b172c1d 100644
--- a/sound/soc/codecs/wm_adsp.h
+++ b/sound/soc/codecs/wm_adsp.h
@@ -59,6 +59,8 @@ struct wm_adsp {
 	struct regulator *dvfs;
 
 	struct list_head ctl_list;
+
+	struct work_struct boot_work;
 };
 
 #define WM_ADSP1(wname, num) \
-- 
1.7.2.5
