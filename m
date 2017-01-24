From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm_adsp: Correct some missing locking"
	to the asoc tree
Date: Tue, 24 Jan 2017 18:39:13 +0000
Message-ID: <E1cW5zt-0006XF-6m@debutante>
References: <1485258241-10575-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C5A7B267474
 for <alsa-devel@alsa-project.org>; Tue, 24 Jan 2017 19:39:22 +0100 (CET)
In-Reply-To: <1485258241-10575-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: wm_adsp: Correct some missing locking

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

>From bb24ee411ae949eaffe24c6be2b3d87f271507b5 Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Date: Tue, 24 Jan 2017 11:43:59 +0000
Subject: [PATCH] ASoC: wm_adsp: Correct some missing locking

The recent refactoring overlooked some places which should be covered by
the pwr_lock, all code that affects or depends on the power status of
the DSP should be covered, this patch adds the missing coverage.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm_adsp.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index ed615ce8a496..09e50e5e7870 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -2552,6 +2552,8 @@ int wm_adsp2_early_event(struct snd_soc_dapm_widget *w,
 		queue_work(system_unbound_wq, &dsp->boot_work);
 		break;
 	case SND_SOC_DAPM_PRE_PMD:
+		mutex_lock(&dsp->pwr_lock);
+
 		wm_adsp_debugfs_clear(dsp);
 
 		dsp->fw_id = 0;
@@ -2567,6 +2569,8 @@ int wm_adsp2_early_event(struct snd_soc_dapm_widget *w,
 
 		wm_adsp_free_alg_regions(dsp);
 
+		mutex_unlock(&dsp->pwr_lock);
+
 		adsp_dbg(dsp, "Shutdown complete\n");
 		break;
 	default:
@@ -2589,8 +2593,12 @@ int wm_adsp2_event(struct snd_soc_dapm_widget *w,
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
@@ -2610,14 +2618,10 @@ int wm_adsp2_event(struct snd_soc_dapm_widget *w,
 
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
@@ -2662,6 +2666,7 @@ int wm_adsp2_event(struct snd_soc_dapm_widget *w,
 err:
 	regmap_update_bits(dsp->regmap, dsp->base + ADSP2_CONTROL,
 			   ADSP2_SYS_ENA | ADSP2_CORE_ENA | ADSP2_START, 0);
+	mutex_unlock(&dsp->pwr_lock);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(wm_adsp2_event);
-- 
2.11.0
