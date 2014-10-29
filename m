From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: [PATCH 3/3] ASoC: Intel: Add PM support to HSW/BDW PCM
	driver
Date: Wed, 29 Oct 2014 17:40:43 +0000
Message-ID: <1414604443-7712-3-git-send-email-liam.r.girdwood@linux.intel.com>
References: <1414604443-7712-1-git-send-email-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id B1ADA2604FD
 for <alsa-devel@alsa-project.org>; Wed, 29 Oct 2014 18:44:25 +0100 (CET)
In-Reply-To: <1414604443-7712-1-git-send-email-liam.r.girdwood@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Add PM and RTD3 support to the HSW/BDW PCM driver. The PCM driver will
now save DSP context and then power off the DSP when it's not in use.
DSP power and context is then restored when it's next used.

Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
---
 sound/soc/intel/sst-dsp.h         |   3 +
 sound/soc/intel/sst-haswell-pcm.c | 271 ++++++++++++++++++++++++++++++++++++--
 2 files changed, 260 insertions(+), 14 deletions(-)

diff --git a/sound/soc/intel/sst-dsp.h b/sound/soc/intel/sst-dsp.h
index 7bb4820..2753b85 100644
--- a/sound/soc/intel/sst-dsp.h
+++ b/sound/soc/intel/sst-dsp.h
@@ -30,6 +30,9 @@
 #define SST_DMA_TYPE_DW		1
 #define SST_DMA_TYPE_MID	2
 
+/* autosuspend delay 5s*/
+#define SST_RUNTIME_SUSPEND_DELAY	(5 * 1000)
+
 /* SST Shim register map
  * The register naming can differ between products. Some products also
  * contain extra functionality.
diff --git a/sound/soc/intel/sst-haswell-pcm.c b/sound/soc/intel/sst-haswell-pcm.c
index 522edef..4489a35 100644
--- a/sound/soc/intel/sst-haswell-pcm.c
+++ b/sound/soc/intel/sst-haswell-pcm.c
@@ -18,6 +18,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/slab.h>
 #include <linux/delay.h>
+#include <linux/pm_runtime.h>
 #include <asm/page.h>
 #include <asm/pgtable.h>
 #include <sound/core.h>
@@ -73,6 +74,13 @@ static const u32 volume_map[] = {
 #define HSW_PCM_PERIODS_MAX	64
 #define HSW_PCM_PERIODS_MIN	2
 
+#define HSW_PCM_DAI_ID_SYSTEM	0
+#define HSW_PCM_DAI_ID_OFFLOAD0	1
+#define HSW_PCM_DAI_ID_OFFLOAD1	2
+#define HSW_PCM_DAI_ID_LOOPBACK	3
+#define HSW_PCM_DAI_ID_CAPTURE	4
+
+
 static const struct snd_pcm_hardware hsw_pcm_hardware = {
 	.info			= SNDRV_PCM_INFO_MMAP |
 				  SNDRV_PCM_INFO_MMAP_VALID |
@@ -99,6 +107,8 @@ struct hsw_pcm_data {
 	int dai_id;
 	struct sst_hsw_stream *stream;
 	struct sst_module_runtime *runtime;
+	struct sst_module_runtime_context context;
+	struct snd_pcm *hsw_pcm;
 	u32 volume[2];
 	struct snd_pcm_substream *substream;
 	struct snd_compr_stream *cstream;
@@ -108,10 +118,18 @@ struct hsw_pcm_data {
 	int persistent_offset;
 };
 
+enum hsw_pm_state {
+	HSW_PM_STATE_D3 = 0,
+	HSW_PM_STATE_D0 = 1,
+};
+
 /* private data for the driver */
 struct hsw_priv_data {
 	/* runtime DSP */
 	struct sst_hsw *hsw;
+	struct device *dev;
+	enum hsw_pm_state pm_state;
+	struct snd_soc_card *soc_card;
 
 	/* page tables */
 	struct snd_dma_buffer dmab[HSW_PCM_COUNT][2];
@@ -145,21 +163,25 @@ static inline unsigned int hsw_ipc_to_mixer(u32 value)
 static int hsw_stream_volume_put(struct snd_kcontrol *kcontrol,
 				struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_component *cmpnt = snd_soc_kcontrol_component(kcontrol);
-	struct hsw_priv_data *pdata = snd_soc_component_get_drvdata(cmpnt);
+	struct snd_soc_platform *platform = snd_soc_kcontrol_platform(kcontrol);
 	struct soc_mixer_control *mc =
 		(struct soc_mixer_control *)kcontrol->private_value;
+	struct hsw_priv_data *pdata =
+		snd_soc_platform_get_drvdata(platform);
 	struct hsw_pcm_data *pcm_data = &pdata->pcm[mc->reg];
 	struct sst_hsw *hsw = pdata->hsw;
 	u32 volume;
 
 	mutex_lock(&pcm_data->mutex);
+	pm_runtime_get_sync(pdata->dev);
 
 	if (!pcm_data->stream) {
 		pcm_data->volume[0] =
 			hsw_mixer_to_ipc(ucontrol->value.integer.value[0]);
 		pcm_data->volume[1] =
 			hsw_mixer_to_ipc(ucontrol->value.integer.value[1]);
+		pm_runtime_mark_last_busy(pdata->dev);
+		pm_runtime_put_autosuspend(pdata->dev);
 		mutex_unlock(&pcm_data->mutex);
 		return 0;
 	}
@@ -175,6 +197,8 @@ static int hsw_stream_volume_put(struct snd_kcontrol *kcontrol,
 		sst_hsw_stream_set_volume(hsw, pcm_data->stream, 0, 1, volume);
 	}
 
+	pm_runtime_mark_last_busy(pdata->dev);
+	pm_runtime_put_autosuspend(pdata->dev);
 	mutex_unlock(&pcm_data->mutex);
 	return 0;
 }
@@ -182,21 +206,25 @@ static int hsw_stream_volume_put(struct snd_kcontrol *kcontrol,
 static int hsw_stream_volume_get(struct snd_kcontrol *kcontrol,
 				struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_component *cmpnt = snd_soc_kcontrol_component(kcontrol);
-	struct hsw_priv_data *pdata = snd_soc_component_get_drvdata(cmpnt);
+	struct snd_soc_platform *platform = snd_soc_kcontrol_platform(kcontrol);
 	struct soc_mixer_control *mc =
 		(struct soc_mixer_control *)kcontrol->private_value;
+	struct hsw_priv_data *pdata =
+		snd_soc_platform_get_drvdata(platform);
 	struct hsw_pcm_data *pcm_data = &pdata->pcm[mc->reg];
 	struct sst_hsw *hsw = pdata->hsw;
 	u32 volume;
 
 	mutex_lock(&pcm_data->mutex);
+	pm_runtime_get_sync(pdata->dev);
 
 	if (!pcm_data->stream) {
 		ucontrol->value.integer.value[0] =
 			hsw_ipc_to_mixer(pcm_data->volume[0]);
 		ucontrol->value.integer.value[1] =
 			hsw_ipc_to_mixer(pcm_data->volume[1]);
+		pm_runtime_mark_last_busy(pdata->dev);
+		pm_runtime_put_autosuspend(pdata->dev);
 		mutex_unlock(&pcm_data->mutex);
 		return 0;
 	}
@@ -205,6 +233,9 @@ static int hsw_stream_volume_get(struct snd_kcontrol *kcontrol,
 	ucontrol->value.integer.value[0] = hsw_ipc_to_mixer(volume);
 	sst_hsw_stream_get_volume(hsw, pcm_data->stream, 0, 1, &volume);
 	ucontrol->value.integer.value[1] = hsw_ipc_to_mixer(volume);
+
+	pm_runtime_mark_last_busy(pdata->dev);
+	pm_runtime_put_autosuspend(pdata->dev);
 	mutex_unlock(&pcm_data->mutex);
 
 	return 0;
@@ -213,11 +244,13 @@ static int hsw_stream_volume_get(struct snd_kcontrol *kcontrol,
 static int hsw_volume_put(struct snd_kcontrol *kcontrol,
 				struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_component *cmpnt = snd_soc_kcontrol_component(kcontrol);
-	struct hsw_priv_data *pdata = snd_soc_component_get_drvdata(cmpnt);
+	struct snd_soc_platform *platform = snd_soc_kcontrol_platform(kcontrol);
+	struct hsw_priv_data *pdata = snd_soc_platform_get_drvdata(platform);
 	struct sst_hsw *hsw = pdata->hsw;
 	u32 volume;
 
+	pm_runtime_get_sync(pdata->dev);
+
 	if (ucontrol->value.integer.value[0] ==
 		ucontrol->value.integer.value[1]) {
 
@@ -232,23 +265,28 @@ static int hsw_volume_put(struct snd_kcontrol *kcontrol,
 		sst_hsw_mixer_set_volume(hsw, 0, 1, volume);
 	}
 
+	pm_runtime_mark_last_busy(pdata->dev);
+	pm_runtime_put_autosuspend(pdata->dev);
 	return 0;
 }
 
 static int hsw_volume_get(struct snd_kcontrol *kcontrol,
 				struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_component *cmpnt = snd_soc_kcontrol_component(kcontrol);
-	struct hsw_priv_data *pdata = snd_soc_component_get_drvdata(cmpnt);
+	struct snd_soc_platform *platform = snd_soc_kcontrol_platform(kcontrol);
+	struct hsw_priv_data *pdata = snd_soc_platform_get_drvdata(platform);
 	struct sst_hsw *hsw = pdata->hsw;
 	unsigned int volume = 0;
 
+	pm_runtime_get_sync(pdata->dev);
 	sst_hsw_mixer_get_volume(hsw, 0, 0, &volume);
 	ucontrol->value.integer.value[0] = hsw_ipc_to_mixer(volume);
 
 	sst_hsw_mixer_get_volume(hsw, 0, 1, &volume);
 	ucontrol->value.integer.value[1] = hsw_ipc_to_mixer(volume);
 
+	pm_runtime_mark_last_busy(pdata->dev);
+	pm_runtime_put_autosuspend(pdata->dev);
 	return 0;
 }
 
@@ -577,6 +615,7 @@ static int hsw_pcm_open(struct snd_pcm_substream *substream)
 	pcm_data = &pdata->pcm[rtd->cpu_dai->id];
 
 	mutex_lock(&pcm_data->mutex);
+	pm_runtime_get_sync(pdata->dev);
 
 	snd_soc_pcm_set_drvdata(rtd, pcm_data);
 	pcm_data->substream = substream;
@@ -587,6 +626,8 @@ static int hsw_pcm_open(struct snd_pcm_substream *substream)
 		hsw_notify_pointer, pcm_data);
 	if (pcm_data->stream == NULL) {
 		dev_err(rtd->dev, "error: failed to create stream\n");
+		pm_runtime_mark_last_busy(pdata->dev);
+		pm_runtime_put_autosuspend(pdata->dev);
 		mutex_unlock(&pcm_data->mutex);
 		return -EINVAL;
 	}
@@ -626,6 +667,8 @@ static int hsw_pcm_close(struct snd_pcm_substream *substream)
 	pcm_data->stream = NULL;
 
 out:
+	pm_runtime_mark_last_busy(pdata->dev);
+	pm_runtime_put_autosuspend(pdata->dev);
 	mutex_unlock(&pcm_data->mutex);
 	return ret;
 }
@@ -643,11 +686,11 @@ static struct snd_pcm_ops hsw_pcm_ops = {
 
 /* static mappings between PCMs and modules - may be dynamic in future */
 static struct hsw_pcm_module_map mod_map[] = {
-	{0, SST_HSW_MODULE_PCM_SYSTEM},		/* "System Pin" */
-	{1, SST_HSW_MODULE_PCM},		/* "Offload0 Pin" */
-	{2, SST_HSW_MODULE_PCM},		/* "Offload1 Pin" */
-	{3, SST_HSW_MODULE_PCM_REFERENCE},	/* "Loopback Pin" */
-	{4, SST_HSW_MODULE_PCM_CAPTURE},	/* "Capture Pin" */
+	{HSW_PCM_DAI_ID_SYSTEM, SST_HSW_MODULE_PCM_SYSTEM},
+	{HSW_PCM_DAI_ID_OFFLOAD0, SST_HSW_MODULE_PCM},
+	{HSW_PCM_DAI_ID_OFFLOAD1, SST_HSW_MODULE_PCM},
+	{HSW_PCM_DAI_ID_LOOPBACK, SST_HSW_MODULE_PCM_REFERENCE},
+	{HSW_PCM_DAI_ID_CAPTURE, SST_HSW_MODULE_PCM_CAPTURE},
 };
 
 static int hsw_pcm_create_modules(struct hsw_priv_data *pdata)
@@ -659,6 +702,7 @@ static int hsw_pcm_create_modules(struct hsw_priv_data *pdata)
 	for (i = 0; i < ARRAY_SIZE(mod_map); i++) {
 		pcm_data = &pdata->pcm[i];
 
+		/* create new runtime module, use same offset if recreated */
 		pcm_data->runtime = sst_hsw_runtime_module_create(hsw,
 			mod_map[i].mod_id, pcm_data->persistent_offset);
 		if (pcm_data->runtime == NULL)
@@ -700,6 +744,7 @@ static int hsw_pcm_new(struct snd_soc_pcm_runtime *rtd)
 	struct snd_pcm *pcm = rtd->pcm;
 	struct snd_soc_platform *platform = rtd->platform;
 	struct sst_pdata *pdata = dev_get_platdata(platform->dev);
+	struct hsw_priv_data *priv_data = dev_get_drvdata(platform->dev);
 	struct device *dev = pdata->dma_dev;
 	int ret = 0;
 
@@ -716,6 +761,7 @@ static int hsw_pcm_new(struct snd_soc_pcm_runtime *rtd)
 			return ret;
 		}
 	}
+	priv_data->pcm[rtd->cpu_dai->id].hsw_pcm = pcm;
 
 	return ret;
 }
@@ -728,6 +774,7 @@ static int hsw_pcm_new(struct snd_soc_pcm_runtime *rtd)
 static struct snd_soc_dai_driver hsw_dais[] = {
 	{
 		.name  = "System Pin",
+		.id = HSW_PCM_DAI_ID_SYSTEM,
 		.playback = {
 			.stream_name = "System Playback",
 			.channels_min = 2,
@@ -739,6 +786,7 @@ static struct snd_soc_dai_driver hsw_dais[] = {
 	{
 		/* PCM */
 		.name  = "Offload0 Pin",
+		.id = HSW_PCM_DAI_ID_OFFLOAD0,
 		.playback = {
 			.stream_name = "Offload0 Playback",
 			.channels_min = 2,
@@ -750,6 +798,7 @@ static struct snd_soc_dai_driver hsw_dais[] = {
 	{
 		/* PCM */
 		.name  = "Offload1 Pin",
+		.id = HSW_PCM_DAI_ID_OFFLOAD1,
 		.playback = {
 			.stream_name = "Offload1 Playback",
 			.channels_min = 2,
@@ -760,6 +809,7 @@ static struct snd_soc_dai_driver hsw_dais[] = {
 	},
 	{
 		.name  = "Loopback Pin",
+		.id = HSW_PCM_DAI_ID_LOOPBACK,
 		.capture = {
 			.stream_name = "Loopback Capture",
 			.channels_min = 2,
@@ -770,6 +820,7 @@ static struct snd_soc_dai_driver hsw_dais[] = {
 	},
 	{
 		.name  = "Capture Pin",
+		.id = HSW_PCM_DAI_ID_CAPTURE,
 		.capture = {
 			.stream_name = "Analog Capture",
 			.channels_min = 2,
@@ -808,9 +859,21 @@ static int hsw_pcm_probe(struct snd_soc_platform *platform)
 {
 	struct hsw_priv_data *priv_data = snd_soc_platform_get_drvdata(platform);
 	struct sst_pdata *pdata = dev_get_platdata(platform->dev);
-	struct device *dma_dev = pdata->dma_dev;
+	struct device *dma_dev, *dev;
 	int i, ret = 0;
 
+	if (!pdata)
+		return -ENODEV;
+
+	dev = platform->dev;
+	dma_dev = pdata->dma_dev;
+
+	priv_data = devm_kzalloc(platform->dev, sizeof(*priv_data), GFP_KERNEL);
+	priv_data->hsw = pdata->dsp;
+	priv_data->dev = platform->dev;
+	priv_data->pm_state = HSW_PM_STATE_D0;
+	priv_data->soc_card = platform->component.card;
+
 	/* allocate DSP buffer page tables */
 	for (i = 0; i < ARRAY_SIZE(hsw_dais); i++) {
 
@@ -836,6 +899,13 @@ static int hsw_pcm_probe(struct snd_soc_platform *platform)
 	/* allocate runtime modules */
 	hsw_pcm_create_modules(priv_data);
 
+	/* enable runtime PM with auto suspend */
+	pm_runtime_set_autosuspend_delay(platform->dev,
+		SST_RUNTIME_SUSPEND_DELAY);
+	pm_runtime_use_autosuspend(platform->dev);
+	pm_runtime_enable(platform->dev);
+	pm_runtime_idle(platform->dev);
+
 	return 0;
 
 err:
@@ -854,6 +924,9 @@ static int hsw_pcm_remove(struct snd_soc_platform *platform)
 		snd_soc_platform_get_drvdata(platform);
 	int i;
 
+	pm_runtime_disable(platform->dev);
+	hsw_pcm_free_modules(priv_data);
+
 	for (i = 0; i < ARRAY_SIZE(hsw_dais); i++) {
 		if (hsw_dais[i].playback.channels_min)
 			snd_dma_free_pages(&priv_data->dmab[i][0]);
@@ -931,10 +1004,180 @@ static int hsw_pcm_dev_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_PM
+#ifdef CONFIG_PM_RUNTIME
+
+static int hsw_pcm_runtime_idle(struct device *dev)
+{
+	return 0;
+}
+
+static int hsw_pcm_runtime_suspend(struct device *dev)
+{
+	struct hsw_priv_data *pdata = dev_get_drvdata(dev);
+	struct sst_hsw *hsw = pdata->hsw;
+
+	if (pdata->pm_state == HSW_PM_STATE_D3)
+		return 0;
+
+	sst_hsw_dsp_runtime_suspend(hsw);
+	sst_hsw_dsp_runtime_sleep(hsw);
+	pdata->pm_state = HSW_PM_STATE_D3;
+
+	return 0;
+}
+
+static int hsw_pcm_runtime_resume(struct device *dev)
+{
+	struct hsw_priv_data *pdata = dev_get_drvdata(dev);
+	struct sst_hsw *hsw = pdata->hsw;
+	int ret;
+
+	if (pdata->pm_state == HSW_PM_STATE_D0)
+		return 0;
+
+	ret = sst_hsw_dsp_load(hsw);
+	if (ret < 0) {
+		dev_err(dev, "failed to reload %d\n", ret);
+		return ret;
+	}
+
+	ret = hsw_pcm_create_modules(pdata);
+	if (ret < 0) {
+		dev_err(dev, "failed to create modules %d\n", ret);
+		return ret;
+	}
+
+	ret = sst_hsw_dsp_runtime_resume(hsw);
+	if (ret < 0)
+		return ret;
+	else if (ret == 1) /* no action required */
+		return 0;
+
+	pdata->pm_state = HSW_PM_STATE_D0;
+	return ret;
+}
+
+static void hsw_pcm_complete(struct device *dev)
+{
+	struct hsw_priv_data *pdata = dev_get_drvdata(dev);
+	struct sst_hsw *hsw = pdata->hsw;
+	struct hsw_pcm_data *pcm_data;
+	int i, err;
+
+	if (pdata->pm_state == HSW_PM_STATE_D0)
+		return;
+
+	err = sst_hsw_dsp_load(hsw);
+	if (err < 0) {
+		dev_err(dev, "failed to reload %d\n", err);
+		return;
+	}
+
+	err = hsw_pcm_create_modules(pdata);
+	if (err < 0) {
+		dev_err(dev, "failed to create modules %d\n", err);
+		return;
+	}
+
+	for (i = 0; i < HSW_PCM_DAI_ID_CAPTURE + 1; i++) {
+		pcm_data = &pdata->pcm[i];
+
+		if (!pcm_data->substream)
+			continue;
+
+		err = sst_module_runtime_restore(pcm_data->runtime,
+			&pcm_data->context);
+		if (err < 0)
+			dev_err(dev, "failed to restore context for PCM %d\n", i);
+	}
+
+	snd_soc_resume(pdata->soc_card->dev);
+
+	err = sst_hsw_dsp_runtime_resume(hsw);
+	if (err < 0)
+		return;
+	else if (err == 1) /* no action required */
+		return;
+
+	pdata->pm_state = HSW_PM_STATE_D0;
+	return;
+}
+
+static int hsw_pcm_prepare(struct device *dev)
+{
+	struct hsw_priv_data *pdata = dev_get_drvdata(dev);
+	struct sst_hsw *hsw = pdata->hsw;
+	struct hsw_pcm_data *pcm_data;
+	int i, err;
+
+	if (pdata->pm_state == HSW_PM_STATE_D3)
+		return 0;
+	/* suspend all active streams */
+	for (i = 0; i < HSW_PCM_DAI_ID_CAPTURE + 1; i++) {
+		pcm_data = &pdata->pcm[i];
+
+		if (!pcm_data->substream)
+			continue;
+		dev_dbg(dev, "suspending pcm %d\n", i);
+		snd_pcm_suspend_all(pcm_data->hsw_pcm);
+
+		/* We need to wait until the DSP FW stops the streams */
+		msleep(2);
+	}
+
+	snd_soc_suspend(pdata->soc_card->dev);
+	snd_soc_poweroff(pdata->soc_card->dev);
+
+	/* enter D3 state and stall */
+	sst_hsw_dsp_runtime_suspend(hsw);
+
+	/* preserve persistent memory */
+	for (i = 0; i < HSW_PCM_DAI_ID_CAPTURE + 1; i++) {
+		pcm_data = &pdata->pcm[i];
+
+		if (!pcm_data->substream)
+			continue;
+
+		dev_dbg(dev, "saving context pcm %d\n", i);
+		err = sst_module_runtime_save(pcm_data->runtime,
+			&pcm_data->context);
+		if (err < 0)
+			dev_err(dev, "failed to save context for PCM %d\n", i);
+	}
+
+	/* put the DSP to sleep */
+	sst_hsw_dsp_runtime_sleep(hsw);
+	pdata->pm_state = HSW_PM_STATE_D3;
+
+	return 0;
+}
+
+#else
+#define hsw_pcm_runtime_idle		NULL
+#define hsw_pcm_runtime_suspend		NULL
+#define hsw_pcm_runtime_resume		NULL
+#define hsw_pcm_runtime_complete	NULL
+#define hsw_pcm_runtime_prepare		NULL
+#endif
+
+static const struct dev_pm_ops hsw_pcm_pm = {
+	.runtime_idle = hsw_pcm_runtime_idle,
+	.runtime_suspend = hsw_pcm_runtime_suspend,
+	.runtime_resume = hsw_pcm_runtime_resume,
+	.prepare = hsw_pcm_prepare,
+	.complete = hsw_pcm_complete,
+};
+#else
+#define hsw_pcm_pm	NULL
+#endif
+
 static struct platform_driver hsw_pcm_driver = {
 	.driver = {
 		.name = "haswell-pcm-audio",
 		.owner = THIS_MODULE,
+		.pm = &hsw_pcm_pm,
+
 	},
 
 	.probe = hsw_pcm_dev_probe,
-- 
2.1.0
