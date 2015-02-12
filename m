From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 06/13] ASoC: Intel: add support for platform
	suspend
Date: Thu, 12 Feb 2015 09:59:58 +0530
Message-ID: <1423715405-4562-7-git-send-email-vinod.koul@intel.com>
References: <1423715405-4562-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 4EB1B265133
 for <alsa-devel@alsa-project.org>; Thu, 12 Feb 2015 05:32:57 +0100 (CET)
In-Reply-To: <1423715405-4562-1-git-send-email-vinod.koul@intel.com>
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
Cc: Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

This adds support for platform suspend and resume. We ensure all pcms are
suspended by invoking snd_soc_suspend() and then stop the DSP

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/sst-mfld-platform-pcm.c |   58 +++++++++++++++++++++++++++++++
 sound/soc/intel/sst-mfld-platform.h     |    1 +
 2 files changed, 59 insertions(+)

diff --git a/sound/soc/intel/sst-mfld-platform-pcm.c b/sound/soc/intel/sst-mfld-platform-pcm.c
index ea0fa4b90bb0..2fbaf2c75d17 100644
--- a/sound/soc/intel/sst-mfld-platform-pcm.c
+++ b/sound/soc/intel/sst-mfld-platform-pcm.c
@@ -667,6 +667,9 @@ static int sst_pcm_new(struct snd_soc_pcm_runtime *rtd)
 
 static int sst_soc_probe(struct snd_soc_platform *platform)
 {
+	struct sst_data *drv = dev_get_drvdata(platform->dev);
+
+	drv->soc_card = platform->component.card;
 	return sst_dsp_init_v2_dpcm(platform);
 }
 
@@ -729,9 +732,64 @@ static int sst_platform_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_PM_SLEEP
+
+static int sst_soc_prepare(struct device *dev)
+{
+	struct sst_data *drv = dev_get_drvdata(dev);
+	int i;
+
+	/* suspend all pcms first */
+	snd_soc_suspend(drv->soc_card->dev);
+	snd_soc_poweroff(drv->soc_card->dev);
+
+	/* set the SSPs to idle */
+	for (i = 0; i < drv->soc_card->num_rtd; i++) {
+		struct snd_soc_dai *dai = drv->soc_card->rtd[i].cpu_dai;
+
+		if (dai->active) {
+			send_ssp_cmd(dai, dai->name, 0);
+			sst_handle_vb_timer(dai, false);
+		}
+	}
+
+	return 0;
+}
+
+static void sst_soc_complete(struct device *dev)
+{
+	struct sst_data *drv = dev_get_drvdata(dev);
+	int i;
+
+	/* restart SSPs */
+	for (i = 0; i < drv->soc_card->num_rtd; i++) {
+		struct snd_soc_dai *dai = drv->soc_card->rtd[i].cpu_dai;
+
+		if (dai->active) {
+			sst_handle_vb_timer(dai, true);
+			send_ssp_cmd(dai, dai->name, 1);
+		}
+	}
+	snd_soc_resume(drv->soc_card->dev);
+}
+
+#else
+
+#define sst_soc_prepare NULL
+#define sst_soc_complete NULL
+
+#endif
+
+
+static const struct dev_pm_ops sst_platform_pm = {
+	.prepare	= sst_soc_prepare,
+	.complete	= sst_soc_complete,
+};
+
 static struct platform_driver sst_platform_driver = {
 	.driver		= {
 		.name		= "sst-mfld-platform",
+		.pm             = &sst_platform_pm,
 	},
 	.probe		= sst_platform_probe,
 	.remove		= sst_platform_remove,
diff --git a/sound/soc/intel/sst-mfld-platform.h b/sound/soc/intel/sst-mfld-platform.h
index 79c8d1246a8f..9094314be2b0 100644
--- a/sound/soc/intel/sst-mfld-platform.h
+++ b/sound/soc/intel/sst-mfld-platform.h
@@ -174,6 +174,7 @@ struct sst_data {
 	struct sst_platform_data *pdata;
 	struct snd_sst_bytes_v2 *byte_stream;
 	struct mutex lock;
+	struct snd_soc_card *soc_card;
 };
 int sst_register_dsp(struct sst_device *sst);
 int sst_unregister_dsp(struct sst_device *sst);
-- 
1.7.9.5
