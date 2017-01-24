From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 1/3] ASoC: wm_adsp: Correct some missing locking
Date: Tue, 24 Jan 2017 11:43:59 +0000
Message-ID: <1485258241-10575-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id B424B266CC2
 for <alsa-devel@alsa-project.org>; Tue, 24 Jan 2017 12:43:02 +0100 (CET)
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

The recent refactoring overlooked some places which should be covered by
the pwr_lock, all code that affects or depends on the power status of
the DSP should be covered, this patch adds the missing coverage.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm_adsp.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 73dbe4c..08a4a61 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -2575,6 +2575,8 @@ int wm_adsp2_early_event(struct snd_soc_dapm_widget *w,
 		queue_work(system_unbound_wq, &dsp->boot_work);
 		break;
 	case SND_SOC_DAPM_PRE_PMD:
+		mutex_lock(&dsp->pwr_lock);
+
 		wm_adsp_debugfs_clear(dsp);
 
 		dsp->fw_id = 0;
@@ -2590,6 +2592,8 @@ int wm_adsp2_early_event(struct snd_soc_dapm_widget *w,
 
 		wm_adsp_free_alg_regions(dsp);
 
+		mutex_unlock(&dsp->pwr_lock);
+
 		adsp_dbg(dsp, "Shutdown complete\n");
 		break;
 	default:
@@ -2612,8 +2616,12 @@ int wm_adsp2_event(struct snd_soc_dapm_widget *w,
 	case SND_SOC_DAPM_POST_PMU:
 		flush_work(&dsp->boot_work);
 
-		if (!dsp->booted)
-			return -EIO;
+		mutex_lock(&dsp->pwr_lock);
+
+		if (!dsp->booted) {
+			ret = -EIO;
+			goto err;
+		}
 
 		ret = wm_adsp2_ena(dsp);
 		if (ret != 0)
@@ -2633,14 +2641,10 @@ int wm_adsp2_event(struct snd_soc_dapm_widget *w,
 
 		dsp->running = true;
 
-		mutex_lock(&dsp->pwr_lock);
-
 		if (wm_adsp_fw[dsp->fw].num_caps != 0) {
 			ret = wm_adsp_buffer_init(dsp);
-			if (ret < 0) {
-				mutex_unlock(&dsp->pwr_lock);
+			if (ret < 0)
 				goto err;
-			}
 		}
 
 		mutex_unlock(&dsp->pwr_lock);
@@ -2685,6 +2689,7 @@ int wm_adsp2_event(struct snd_soc_dapm_widget *w,
 err:
 	regmap_update_bits(dsp->regmap, dsp->base + ADSP2_CONTROL,
 			   ADSP2_SYS_ENA | ADSP2_CORE_ENA | ADSP2_START, 0);
+	mutex_unlock(&dsp->pwr_lock);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(wm_adsp2_event);
-- 
2.1.4
