From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH 6/7] ASoC: Intel: Add Baytrail suspend/resume
	support
Date: Thu,  8 May 2014 16:07:26 +0300
Message-ID: <1399554447-16297-7-git-send-email-jarkko.nikula@linux.intel.com>
References: <1399554447-16297-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id EC0722615EC
 for <alsa-devel@alsa-project.org>; Thu,  8 May 2014 15:08:32 +0200 (CEST)
In-Reply-To: <1399554447-16297-1-git-send-email-jarkko.nikula@linux.intel.com>
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

From: Liam Girdwood <liam.r.girdwood@linux.intel.com>

Add suspend and resume support to Baytrail SST DSP. This is implemented by
unloading firmware modules and putting DSP into reset prior suspend and
restarting DSP again in normal boot state after resume.

Context restore for running streams is implemented by scheduling a work from
sst_byt_pcm_trigger() that will allocate a stream with existing parameters
and start it from last known buffer position before suspend.

[Jarkko: Squashed together 5 WIP patches from Liam and 1 from me]

Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
 sound/soc/intel/sst-baytrail-ipc.c |  69 ++++++++++++++++++++++++
 sound/soc/intel/sst-baytrail-ipc.h |   4 ++
 sound/soc/intel/sst-baytrail-pcm.c | 107 ++++++++++++++++++++++++++++++++++++-
 3 files changed, 179 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/sst-baytrail-ipc.c b/sound/soc/intel/sst-baytrail-ipc.c
index 2487b6e2dfec..7c1ec003d55d 100644
--- a/sound/soc/intel/sst-baytrail-ipc.c
+++ b/sound/soc/intel/sst-baytrail-ipc.c
@@ -173,6 +173,7 @@ struct sst_byt {
 	/* boot */
 	wait_queue_head_t boot_wait;
 	bool boot_complete;
+	struct sst_fw *fw;
 
 	/* IPC messaging */
 	struct list_head tx_list;
@@ -797,6 +798,73 @@ static struct sst_dsp_device byt_dev = {
 	.ops = &sst_byt_ops,
 };
 
+int sst_byt_dsp_suspend_noirq(struct device *dev, struct sst_pdata *pdata)
+{
+	struct sst_byt *byt = pdata->dsp;
+
+	dev_dbg(byt->dev, "dsp reset\n");
+	sst_dsp_reset(byt->dsp);
+	sst_byt_drop_all(byt);
+	dev_dbg(byt->dev, "dsp in reset\n");
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(sst_byt_dsp_suspend_noirq);
+
+int sst_byt_dsp_suspend_late(struct device *dev, struct sst_pdata *pdata)
+{
+	struct sst_byt *byt = pdata->dsp;
+
+	dev_dbg(byt->dev, "free all blocks and unload fw\n");
+	sst_fw_unload(byt->fw);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(sst_byt_dsp_suspend_late);
+
+int sst_byt_dsp_boot(struct device *dev, struct sst_pdata *pdata)
+{
+	struct sst_byt *byt = pdata->dsp;
+	int ret;
+
+	dev_dbg(byt->dev, "reload dsp fw\n");
+
+	sst_dsp_reset(byt->dsp);
+
+	ret = sst_fw_reload(byt->fw);
+	if (ret <  0) {
+		dev_err(dev, "error: failed to reload firmware\n");
+		return ret;
+	}
+
+	/* wait for DSP boot completion */
+	byt->boot_complete = false;
+	sst_dsp_boot(byt->dsp);
+	dev_dbg(byt->dev, "dsp booting...\n");
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(sst_byt_dsp_boot);
+
+int sst_byt_dsp_wait_for_ready(struct device *dev, struct sst_pdata *pdata)
+{
+	struct sst_byt *byt = pdata->dsp;
+	int err;
+
+	dev_dbg(byt->dev, "wait for dsp reboot\n");
+
+	err = wait_event_timeout(byt->boot_wait, byt->boot_complete,
+				 msecs_to_jiffies(IPC_BOOT_MSECS));
+	if (err == 0) {
+		dev_err(byt->dev, "ipc: error DSP boot timeout\n");
+		return -EIO;
+	}
+
+	dev_dbg(byt->dev, "dsp rebooted\n");
+	return 0;
+}
+EXPORT_SYMBOL_GPL(sst_byt_dsp_wait_for_ready);
+
 int sst_byt_dsp_init(struct device *dev, struct sst_pdata *pdata)
 {
 	struct sst_byt *byt;
@@ -863,6 +931,7 @@ int sst_byt_dsp_init(struct device *dev, struct sst_pdata *pdata)
 	}
 
 	pdata->dsp = byt;
+	byt->fw = byt_sst_fw;
 
 	return 0;
 
diff --git a/sound/soc/intel/sst-baytrail-ipc.h b/sound/soc/intel/sst-baytrail-ipc.h
index b643d9892f60..06a4d202689b 100644
--- a/sound/soc/intel/sst-baytrail-ipc.h
+++ b/sound/soc/intel/sst-baytrail-ipc.h
@@ -66,5 +66,9 @@ int sst_byt_get_dsp_position(struct sst_byt *byt,
 int sst_byt_dsp_init(struct device *dev, struct sst_pdata *pdata);
 void sst_byt_dsp_free(struct device *dev, struct sst_pdata *pdata);
 struct sst_dsp *sst_byt_get_dsp(struct sst_byt *byt);
+int sst_byt_dsp_suspend_noirq(struct device *dev, struct sst_pdata *pdata);
+int sst_byt_dsp_suspend_late(struct device *dev, struct sst_pdata *pdata);
+int sst_byt_dsp_boot(struct device *dev, struct sst_pdata *pdata);
+int sst_byt_dsp_wait_for_ready(struct device *dev, struct sst_pdata *pdata);
 
 #endif
diff --git a/sound/soc/intel/sst-baytrail-pcm.c b/sound/soc/intel/sst-baytrail-pcm.c
index e2c2540ffff4..00a2118d20f5 100644
--- a/sound/soc/intel/sst-baytrail-pcm.c
+++ b/sound/soc/intel/sst-baytrail-pcm.c
@@ -48,6 +48,8 @@ struct sst_byt_pcm_data {
 
 	/* latest DSP DMA hw pointer */
 	u32 hw_ptr;
+
+	struct work_struct work;
 };
 
 /* private data for the driver */
@@ -133,6 +135,38 @@ static int sst_byt_pcm_hw_free(struct snd_pcm_substream *substream)
 	return 0;
 }
 
+static int sst_byt_pcm_restore_stream_context(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct sst_byt_priv_data *pdata =
+		snd_soc_platform_get_drvdata(rtd->platform);
+	struct sst_byt_pcm_data *pcm_data = snd_soc_pcm_get_drvdata(rtd);
+	struct sst_byt *byt = pdata->byt;
+	int ret;
+
+	/* commit stream using existing stream params */
+	ret = sst_byt_stream_commit(byt, pcm_data->stream);
+	if (ret < 0) {
+		dev_err(rtd->dev, "PCM: failed stream commit %d\n", ret);
+		return ret;
+	}
+
+	sst_byt_stream_start(byt, pcm_data->stream, pcm_data->hw_ptr);
+
+	dev_dbg(rtd->dev, "stream context restored at offset %d\n",
+		pcm_data->hw_ptr);
+
+	return 0;
+}
+
+static void sst_byt_pcm_work(struct work_struct *work)
+{
+	struct sst_byt_pcm_data *pcm_data =
+		container_of(work, struct sst_byt_pcm_data, work);
+
+	sst_byt_pcm_restore_stream_context(pcm_data->substream);
+}
+
 static int sst_byt_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
@@ -148,6 +182,8 @@ static int sst_byt_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 		sst_byt_stream_start(byt, pcm_data->stream, 0);
 		break;
 	case SNDRV_PCM_TRIGGER_RESUME:
+		schedule_work(&pcm_data->work);
+		break;
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
 		sst_byt_stream_resume(byt, pcm_data->stream);
 		break;
@@ -344,8 +380,10 @@ static int sst_byt_pcm_probe(struct snd_soc_platform *platform)
 	priv_data->byt = plat_data->dsp;
 	snd_soc_platform_set_drvdata(platform, priv_data);
 
-	for (i = 0; i < ARRAY_SIZE(byt_dais); i++)
+	for (i = 0; i < ARRAY_SIZE(byt_dais); i++) {
 		mutex_init(&priv_data->pcm[i].mutex);
+		INIT_WORK(&priv_data->pcm[i].work, sst_byt_pcm_work);
+	}
 
 	return 0;
 }
@@ -367,6 +405,72 @@ static const struct snd_soc_component_driver byt_dai_component = {
 	.name		= "byt-dai",
 };
 
+#ifdef CONFIG_PM
+static int sst_byt_pcm_dev_suspend_noirq(struct device *dev)
+{
+	struct sst_pdata *sst_pdata = dev_get_platdata(dev);
+	int ret;
+
+	dev_dbg(dev, "suspending noirq\n");
+
+	/* at this point all streams will be stopped and context saved */
+	ret = sst_byt_dsp_suspend_noirq(dev, sst_pdata);
+	if (ret < 0) {
+		dev_err(dev, "failed to suspend %d\n", ret);
+		return ret;
+	}
+
+	return ret;
+}
+
+static int sst_byt_pcm_dev_suspend_late(struct device *dev)
+{
+	struct sst_pdata *sst_pdata = dev_get_platdata(dev);
+	int ret;
+
+	dev_dbg(dev, "suspending late\n");
+
+	ret = sst_byt_dsp_suspend_late(dev, sst_pdata);
+	if (ret < 0) {
+		dev_err(dev, "failed to suspend %d\n", ret);
+		return ret;
+	}
+
+	return ret;
+}
+
+static int sst_byt_pcm_dev_resume_early(struct device *dev)
+{
+	struct sst_pdata *sst_pdata = dev_get_platdata(dev);
+
+	dev_dbg(dev, "resume early\n");
+
+	/* load fw and boot DSP */
+	return sst_byt_dsp_boot(dev, sst_pdata);
+}
+
+static int sst_byt_pcm_dev_resume(struct device *dev)
+{
+	struct sst_pdata *sst_pdata = dev_get_platdata(dev);
+
+	dev_dbg(dev, "resume\n");
+
+	/* wait for FW to finish booting */
+	return sst_byt_dsp_wait_for_ready(dev, sst_pdata);
+}
+
+static const struct dev_pm_ops sst_byt_pm_ops = {
+	.suspend_noirq = sst_byt_pcm_dev_suspend_noirq,
+	.suspend_late = sst_byt_pcm_dev_suspend_late,
+	.resume_early = sst_byt_pcm_dev_resume_early,
+	.resume = sst_byt_pcm_dev_resume,
+};
+
+#define SST_BYT_PM_OPS	(&sst_byt_pm_ops)
+#else
+#define SST_BYT_PM_OPS	NULL
+#endif
+
 static int sst_byt_pcm_dev_probe(struct platform_device *pdev)
 {
 	struct sst_pdata *sst_pdata = dev_get_platdata(&pdev->dev);
@@ -409,6 +513,7 @@ static struct platform_driver sst_byt_pcm_driver = {
 	.driver = {
 		.name = "baytrail-pcm-audio",
 		.owner = THIS_MODULE,
+		.pm = SST_BYT_PM_OPS,
 	},
 
 	.probe = sst_byt_pcm_dev_probe,
-- 
2.0.0.rc0
