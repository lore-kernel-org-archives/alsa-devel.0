From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm_adsp: Replace debugfs lock with more
	general DSP power lock" to the asoc tree
Date: Sat, 12 Dec 2015 23:07:32 +0000
Message-ID: <E1a7tGG-0002fD-S3@finisterre>
References: <1449590917-21170-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 6427C2606E5
 for <alsa-devel@alsa-project.org>; Sun, 13 Dec 2015 00:07:40 +0100 (CET)
In-Reply-To: <1449590917-21170-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: wm_adsp: Replace debugfs lock with more general DSP power lock

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 078e71838cdff1c2a1a33e65459954adda9a4641 Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Date: Tue, 8 Dec 2015 16:08:26 +0000
Subject: [PATCH] ASoC: wm_adsp: Replace debugfs lock with more general DSP
 power lock

Most events around the DSP just need to be locked to ensure that the DSP
can't change power state whilst they are happening. This includes the
debugfs entries and this will make sorting the rest of the locking
simpler.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm_adsp.c | 75 ++++++++++++++++++++++++++--------------------
 sound/soc/codecs/wm_adsp.h |  3 +-
 2 files changed, 44 insertions(+), 34 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 905ae99..19f0593 100644
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
 
@@ -1799,9 +1793,8 @@ int wm_adsp1_init(struct wm_adsp *dsp)
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
@@ -1820,6 +1813,8 @@ int wm_adsp1_event(struct snd_soc_dapm_widget *w,
 
 	dsp->card = codec->component.card;
 
+	mutex_lock(&dsp->pwr_lock);
+
 	switch (event) {
 	case SND_SOC_DAPM_POST_PMU:
 		regmap_update_bits(dsp->regmap, dsp->base + ADSP1_CONTROL_30,
@@ -1834,7 +1829,7 @@ int wm_adsp1_event(struct snd_soc_dapm_widget *w,
 			if (ret != 0) {
 				adsp_err(dsp, "Failed to read SYSCLK state: %d\n",
 				ret);
-				return ret;
+				goto err_mutex;
 			}
 
 			val = (val & dsp->sysclk_mask)
@@ -1846,31 +1841,31 @@ int wm_adsp1_event(struct snd_soc_dapm_widget *w,
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
@@ -1905,11 +1900,16 @@ int wm_adsp1_event(struct snd_soc_dapm_widget *w,
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
@@ -1955,6 +1955,8 @@ static void wm_adsp2_boot_work(struct work_struct *work)
 	int ret;
 	unsigned int val;
 
+	mutex_lock(&dsp->pwr_lock);
+
 	/*
 	 * For simplicity set the DSP clock rate to be the
 	 * SYSCLK rate rather than making it configurable.
@@ -1962,7 +1964,7 @@ static void wm_adsp2_boot_work(struct work_struct *work)
 	ret = regmap_read(dsp->regmap, ARIZONA_SYSTEM_CLOCK_1, &val);
 	if (ret != 0) {
 		adsp_err(dsp, "Failed to read SYSCLK state: %d\n", ret);
-		return;
+		goto err_mutex;
 	}
 	val = (val & ARIZONA_SYSCLK_FREQ_MASK)
 		>> ARIZONA_SYSCLK_FREQ_SHIFT;
@@ -1972,42 +1974,46 @@ static void wm_adsp2_boot_work(struct work_struct *work)
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
@@ -2060,6 +2066,8 @@ int wm_adsp2_event(struct snd_soc_dapm_widget *w,
 		/* Log firmware state, it can be useful for analysis */
 		wm_adsp2_show_fw_status(dsp);
 
+		mutex_lock(&dsp->pwr_lock);
+
 		wm_adsp_debugfs_clear(dsp);
 
 		dsp->fw_id = 0;
@@ -2086,6 +2094,8 @@ int wm_adsp2_event(struct snd_soc_dapm_widget *w,
 			kfree(alg_region);
 		}
 
+		mutex_unlock(&dsp->pwr_lock);
+
 		adsp_dbg(dsp, "Shutdown complete\n");
 		break;
 
@@ -2138,9 +2148,8 @@ int wm_adsp2_init(struct wm_adsp *dsp)
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
index 2d117cf..93764139 100644
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
2.6.4
