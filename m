From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 02/13] ASoC: wm_adsp: Replace debugfs lock with
	more general DSP power lock
Date: Tue, 8 Dec 2015 16:08:26 +0000
Message-ID: <1449590917-21170-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1449590917-21170-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 0F0D026043E
 for <alsa-devel@alsa-project.org>; Tue,  8 Dec 2015 17:09:06 +0100 (CET)
In-Reply-To: <1449590917-21170-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, vinod.koul@intel.com, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, tiwai@suse.com
List-Id: alsa-devel@alsa-project.org

Most events around the DSP just need to be locked to ensure that the DSP
can't change power state whilst they are happening. This includes the
debugfs entries and this will make sorting the rest of the locking
simpler.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm_adsp.c | 75 ++++++++++++++++++++++++++--------------------
 sound/soc/codecs/wm_adsp.h |  3 +-
 2 files changed, 44 insertions(+), 34 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 3808190..d3b7726 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -275,30 +275,24 @@ static void wm_adsp_debugfs_save_wmfwname(struct wm_adsp *dsp, const char *s)
 {
 	char *tmp = kasprintf(GFP_KERNEL, "%s\n", s);
 
-	mutex_lock(&dsp->debugfs_lock);
 	kfree(dsp->wmfw_file_name);
 	dsp->wmfw_file_name = tmp;
-	mutex_unlock(&dsp->debugfs_lock);
 }
 
 static void wm_adsp_debugfs_save_binname(struct wm_adsp *dsp, const char *s)
 {
 	char *tmp = kasprintf(GFP_KERNEL, "%s\n", s);
 
-	mutex_lock(&dsp->debugfs_lock);
 	kfree(dsp->bin_file_name);
 	dsp->bin_file_name = tmp;
-	mutex_unlock(&dsp->debugfs_lock);
 }
 
 static void wm_adsp_debugfs_clear(struct wm_adsp *dsp)
 {
-	mutex_lock(&dsp->debugfs_lock);
 	kfree(dsp->wmfw_file_name);
 	kfree(dsp->bin_file_name);
 	dsp->wmfw_file_name = NULL;
 	dsp->bin_file_name = NULL;
-	mutex_unlock(&dsp->debugfs_lock);
 }
 
 static ssize_t wm_adsp_debugfs_wmfw_read(struct file *file,
@@ -308,7 +302,7 @@ static ssize_t wm_adsp_debugfs_wmfw_read(struct file *file,
 	struct wm_adsp *dsp = file->private_data;
 	ssize_t ret;
 
-	mutex_lock(&dsp->debugfs_lock);
+	mutex_lock(&dsp->pwr_lock);
 
 	if (!dsp->wmfw_file_name || !dsp->running)
 		ret = 0;
@@ -317,7 +311,7 @@ static ssize_t wm_adsp_debugfs_wmfw_read(struct file *file,
 					      dsp->wmfw_file_name,
 					      strlen(dsp->wmfw_file_name));
 
-	mutex_unlock(&dsp->debugfs_lock);
+	mutex_unlock(&dsp->pwr_lock);
 	return ret;
 }
 
@@ -328,7 +322,7 @@ static ssize_t wm_adsp_debugfs_bin_read(struct file *file,
 	struct wm_adsp *dsp = file->private_data;
 	ssize_t ret;
 
-	mutex_lock(&dsp->debugfs_lock);
+	mutex_lock(&dsp->pwr_lock);
 
 	if (!dsp->bin_file_name || !dsp->running)
 		ret = 0;
@@ -337,7 +331,7 @@ static ssize_t wm_adsp_debugfs_bin_read(struct file *file,
 					      dsp->bin_file_name,
 					      strlen(dsp->bin_file_name));
 
-	mutex_unlock(&dsp->debugfs_lock);
+	mutex_unlock(&dsp->pwr_lock);
 	return ret;
 }
 
@@ -1798,9 +1792,8 @@ int wm_adsp1_init(struct wm_adsp *dsp)
 {
 	INIT_LIST_HEAD(&dsp->alg_regions);
 
-#ifdef CONFIG_DEBUG_FS
-	mutex_init(&dsp->debugfs_lock);
-#endif
+	mutex_init(&dsp->pwr_lock);
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(wm_adsp1_init);
@@ -1819,6 +1812,8 @@ int wm_adsp1_event(struct snd_soc_dapm_widget *w,
 
 	dsp->card = codec->component.card;
 
+	mutex_lock(&dsp->pwr_lock);
+
 	switch (event) {
 	case SND_SOC_DAPM_POST_PMU:
 		regmap_update_bits(dsp->regmap, dsp->base + ADSP1_CONTROL_30,
@@ -1833,7 +1828,7 @@ int wm_adsp1_event(struct snd_soc_dapm_widget *w,
 			if (ret != 0) {
 				adsp_err(dsp, "Failed to read SYSCLK state: %d\n",
 				ret);
-				return ret;
+				goto err_mutex;
 			}
 
 			val = (val & dsp->sysclk_mask)
@@ -1845,31 +1840,31 @@ int wm_adsp1_event(struct snd_soc_dapm_widget *w,
 			if (ret != 0) {
 				adsp_err(dsp, "Failed to set clock rate: %d\n",
 					 ret);
-				return ret;
+				goto err_mutex;
 			}
 		}
 
 		ret = wm_adsp_load(dsp);
 		if (ret != 0)
-			goto err;
+			goto err_ena;
 
 		ret = wm_adsp1_setup_algs(dsp);
 		if (ret != 0)
-			goto err;
+			goto err_ena;
 
 		ret = wm_adsp_load_coeff(dsp);
 		if (ret != 0)
-			goto err;
+			goto err_ena;
 
 		/* Initialize caches for enabled and unset controls */
 		ret = wm_coeff_init_control_caches(dsp);
 		if (ret != 0)
-			goto err;
+			goto err_ena;
 
 		/* Sync set controls */
 		ret = wm_coeff_sync_controls(dsp);
 		if (ret != 0)
-			goto err;
+			goto err_ena;
 
 		/* Start the core running */
 		regmap_update_bits(dsp->regmap, dsp->base + ADSP1_CONTROL_30,
@@ -1904,11 +1899,16 @@ int wm_adsp1_event(struct snd_soc_dapm_widget *w,
 		break;
 	}
 
+	mutex_unlock(&dsp->pwr_lock);
+
 	return 0;
 
-err:
+err_ena:
 	regmap_update_bits(dsp->regmap, dsp->base + ADSP1_CONTROL_30,
 			   ADSP1_SYS_ENA, 0);
+err_mutex:
+	mutex_unlock(&dsp->pwr_lock);
+
 	return ret;
 }
 EXPORT_SYMBOL_GPL(wm_adsp1_event);
@@ -1954,6 +1954,8 @@ static void wm_adsp2_boot_work(struct work_struct *work)
 	int ret;
 	unsigned int val;
 
+	mutex_lock(&dsp->pwr_lock);
+
 	/*
 	 * For simplicity set the DSP clock rate to be the
 	 * SYSCLK rate rather than making it configurable.
@@ -1961,7 +1963,7 @@ static void wm_adsp2_boot_work(struct work_struct *work)
 	ret = regmap_read(dsp->regmap, ARIZONA_SYSTEM_CLOCK_1, &val);
 	if (ret != 0) {
 		adsp_err(dsp, "Failed to read SYSCLK state: %d\n", ret);
-		return;
+		goto err_mutex;
 	}
 	val = (val & ARIZONA_SYSCLK_FREQ_MASK)
 		>> ARIZONA_SYSCLK_FREQ_SHIFT;
@@ -1971,42 +1973,46 @@ static void wm_adsp2_boot_work(struct work_struct *work)
 				       ADSP2_CLK_SEL_MASK, val);
 	if (ret != 0) {
 		adsp_err(dsp, "Failed to set clock rate: %d\n", ret);
-		return;
+		goto err_mutex;
 	}
 
 	ret = wm_adsp2_ena(dsp);
 	if (ret != 0)
-		return;
+		goto err_mutex;
 
 	ret = wm_adsp_load(dsp);
 	if (ret != 0)
-		goto err;
+		goto err_ena;
 
 	ret = wm_adsp2_setup_algs(dsp);
 	if (ret != 0)
-		goto err;
+		goto err_ena;
 
 	ret = wm_adsp_load_coeff(dsp);
 	if (ret != 0)
-		goto err;
+		goto err_ena;
 
 	/* Initialize caches for enabled and unset controls */
 	ret = wm_coeff_init_control_caches(dsp);
 	if (ret != 0)
-		goto err;
+		goto err_ena;
 
 	/* Sync set controls */
 	ret = wm_coeff_sync_controls(dsp);
 	if (ret != 0)
-		goto err;
+		goto err_ena;
 
 	dsp->running = true;
 
+	mutex_unlock(&dsp->pwr_lock);
+
 	return;
 
-err:
+err_ena:
 	regmap_update_bits(dsp->regmap, dsp->base + ADSP2_CONTROL,
 			   ADSP2_SYS_ENA | ADSP2_CORE_ENA | ADSP2_START, 0);
+err_mutex:
+	mutex_unlock(&dsp->pwr_lock);
 }
 
 int wm_adsp2_early_event(struct snd_soc_dapm_widget *w,
@@ -2059,6 +2065,8 @@ int wm_adsp2_event(struct snd_soc_dapm_widget *w,
 		/* Log firmware state, it can be useful for analysis */
 		wm_adsp2_show_fw_status(dsp);
 
+		mutex_lock(&dsp->pwr_lock);
+
 		wm_adsp_debugfs_clear(dsp);
 
 		dsp->fw_id = 0;
@@ -2085,6 +2093,8 @@ int wm_adsp2_event(struct snd_soc_dapm_widget *w,
 			kfree(alg_region);
 		}
 
+		mutex_unlock(&dsp->pwr_lock);
+
 		adsp_dbg(dsp, "Shutdown complete\n");
 		break;
 
@@ -2137,9 +2147,8 @@ int wm_adsp2_init(struct wm_adsp *dsp)
 	INIT_LIST_HEAD(&dsp->ctl_list);
 	INIT_WORK(&dsp->boot_work, wm_adsp2_boot_work);
 
-#ifdef CONFIG_DEBUG_FS
-	mutex_init(&dsp->debugfs_lock);
-#endif
+	mutex_init(&dsp->pwr_lock);
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(wm_adsp2_init);
diff --git a/sound/soc/codecs/wm_adsp.h b/sound/soc/codecs/wm_adsp.h
index 89b7d71..d2a8c78 100644
--- a/sound/soc/codecs/wm_adsp.h
+++ b/sound/soc/codecs/wm_adsp.h
@@ -59,9 +59,10 @@ struct wm_adsp {
 
 	struct work_struct boot_work;
 
+	struct mutex pwr_lock;
+
 #ifdef CONFIG_DEBUG_FS
 	struct dentry *debugfs_root;
-	struct mutex debugfs_lock;
 	char *wmfw_file_name;
 	char *bin_file_name;
 #endif
-- 
2.1.4
