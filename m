From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH 1/3] ASoC: Intel: Merge Baytrail ADSP
	suspend_noirq into suspend_late
Date: Mon, 11 Aug 2014 14:15:36 +0300
Message-ID: <1407755738-31693-2-git-send-email-jarkko.nikula@linux.intel.com>
References: <1407755738-31693-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id E2437261AA5
 for <alsa-devel@alsa-project.org>; Mon, 11 Aug 2014 13:15:45 +0200 (CEST)
In-Reply-To: <1407755738-31693-1-git-send-email-jarkko.nikula@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

Merge DSP reset and cleanup sequence in sst_byt_pcm_dev_suspend_noirq()
into sst_byt_pcm_dev_suspend_late(). First their order was wrong by first
unloading firmware modules in suspend_late and then taking DSP into reset
in suspend_noirq. Second ACPI has put device into OFF state already during
suspend_late so trying to reset the DSP is a no-op at suspend_noirq stage.

Fix these by moving DSP reset and cleanup into
sst_byt_pcm_dev_suspend_late() before firmware unloading.

Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Tested-by: Borun Fu <borun.fu@intel.com>
---
 sound/soc/intel/sst-baytrail-ipc.c | 10 +---------
 sound/soc/intel/sst-baytrail-ipc.h |  1 -
 sound/soc/intel/sst-baytrail-pcm.c | 18 ------------------
 3 files changed, 1 insertion(+), 28 deletions(-)

diff --git a/sound/soc/intel/sst-baytrail-ipc.c b/sound/soc/intel/sst-baytrail-ipc.c
index 67673a2c0f41..b4ad98c43e5c 100644
--- a/sound/soc/intel/sst-baytrail-ipc.c
+++ b/sound/soc/intel/sst-baytrail-ipc.c
@@ -817,7 +817,7 @@ static struct sst_dsp_device byt_dev = {
 	.ops = &sst_byt_ops,
 };
 
-int sst_byt_dsp_suspend_noirq(struct device *dev, struct sst_pdata *pdata)
+int sst_byt_dsp_suspend_late(struct device *dev, struct sst_pdata *pdata)
 {
 	struct sst_byt *byt = pdata->dsp;
 
@@ -826,14 +826,6 @@ int sst_byt_dsp_suspend_noirq(struct device *dev, struct sst_pdata *pdata)
 	sst_byt_drop_all(byt);
 	dev_dbg(byt->dev, "dsp in reset\n");
 
-	return 0;
-}
-EXPORT_SYMBOL_GPL(sst_byt_dsp_suspend_noirq);
-
-int sst_byt_dsp_suspend_late(struct device *dev, struct sst_pdata *pdata)
-{
-	struct sst_byt *byt = pdata->dsp;
-
 	dev_dbg(byt->dev, "free all blocks and unload fw\n");
 	sst_fw_unload(byt->fw);
 
diff --git a/sound/soc/intel/sst-baytrail-ipc.h b/sound/soc/intel/sst-baytrail-ipc.h
index 06a4d202689b..8faff6dcf25d 100644
--- a/sound/soc/intel/sst-baytrail-ipc.h
+++ b/sound/soc/intel/sst-baytrail-ipc.h
@@ -66,7 +66,6 @@ int sst_byt_get_dsp_position(struct sst_byt *byt,
 int sst_byt_dsp_init(struct device *dev, struct sst_pdata *pdata);
 void sst_byt_dsp_free(struct device *dev, struct sst_pdata *pdata);
 struct sst_dsp *sst_byt_get_dsp(struct sst_byt *byt);
-int sst_byt_dsp_suspend_noirq(struct device *dev, struct sst_pdata *pdata);
 int sst_byt_dsp_suspend_late(struct device *dev, struct sst_pdata *pdata);
 int sst_byt_dsp_boot(struct device *dev, struct sst_pdata *pdata);
 int sst_byt_dsp_wait_for_ready(struct device *dev, struct sst_pdata *pdata);
diff --git a/sound/soc/intel/sst-baytrail-pcm.c b/sound/soc/intel/sst-baytrail-pcm.c
index 599401c0c655..ba7ed9720732 100644
--- a/sound/soc/intel/sst-baytrail-pcm.c
+++ b/sound/soc/intel/sst-baytrail-pcm.c
@@ -404,23 +404,6 @@ static const struct snd_soc_component_driver byt_dai_component = {
 };
 
 #ifdef CONFIG_PM
-static int sst_byt_pcm_dev_suspend_noirq(struct device *dev)
-{
-	struct sst_pdata *sst_pdata = dev_get_platdata(dev);
-	int ret;
-
-	dev_dbg(dev, "suspending noirq\n");
-
-	/* at this point all streams will be stopped and context saved */
-	ret = sst_byt_dsp_suspend_noirq(dev, sst_pdata);
-	if (ret < 0) {
-		dev_err(dev, "failed to suspend %d\n", ret);
-		return ret;
-	}
-
-	return ret;
-}
-
 static int sst_byt_pcm_dev_suspend_late(struct device *dev)
 {
 	struct sst_pdata *sst_pdata = dev_get_platdata(dev);
@@ -458,7 +441,6 @@ static int sst_byt_pcm_dev_resume(struct device *dev)
 }
 
 static const struct dev_pm_ops sst_byt_pm_ops = {
-	.suspend_noirq = sst_byt_pcm_dev_suspend_noirq,
 	.suspend_late = sst_byt_pcm_dev_suspend_late,
 	.resume_early = sst_byt_pcm_dev_resume_early,
 	.resume = sst_byt_pcm_dev_resume,
-- 
2.0.1
