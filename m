From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: [PATCH 06/14] ASoC: multi-component - Renasas SuperH
	Platform
Date: Wed, 11 Aug 2010 09:46:25 +0100
Message-ID: <1281516393-6060-7-git-send-email-lrg@slimlogic.co.uk>
References: <1281516393-6060-1-git-send-email-lrg@slimlogic.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id C6C5D103871
	for <alsa-devel@alsa-project.org>;
	Wed, 11 Aug 2010 10:47:01 +0200 (CEST)
Received: by mail-ww0-f51.google.com with SMTP id 36so2779440wwa.20
	for <alsa-devel@alsa-project.org>; Wed, 11 Aug 2010 01:47:01 -0700 (PDT)
In-Reply-To: <1281516393-6060-1-git-send-email-lrg@slimlogic.co.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Kuninori Morimoto <morimoto.kuninori@renesas.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Update the Renasas SuperH platform and machines to new multi-component model.

This patch changes the machine drivers for multi-component as follows :-

 o Removed socdev
 o Each DAI link entry now contains platform and codec fields.
 o DAI link init() now passed snd_soc_pcm_runtime instread of snd_soc_codec.

This patch also changes the DAI and platform DAM drivers as follows :-

 o Each platform DAI and platform DMA driver is a kernel device and can
   have platform data.
 o DAI and Platform DMA drivers have private data accessors.

Other notable changes required for multi-component support:-

 o Decoupled platform DMA and DAI drivers.
 o Added extern struct siu_info *siu_i2s_data (ideally this should be passed
   around the sui_dai_ops rather than being a global).

CC: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Signed-off-by: Liam Girdwood <lrg@slimlogic.co.uk>
---
 include/sound/sh_fsi.h     |    4 +-
 sound/soc/sh/dma-sh7760.c  |   53 ++++++++++++++++++++++++-----------
 sound/soc/sh/fsi-ak4642.c  |   24 ++++++----------
 sound/soc/sh/fsi-da7210.c  |   22 ++++++--------
 sound/soc/sh/fsi.c         |   47 ++++++++++++-------------------
 sound/soc/sh/hac.c         |   46 +++++++++++++++++++++---------
 sound/soc/sh/migor.c       |   29 ++++++++-----------
 sound/soc/sh/sh7760-ac97.c |   25 ++++++----------
 sound/soc/sh/siu.h         |    5 ++-
 sound/soc/sh/siu_dai.c     |   66 ++++++++++++++++++++++---------------------
 sound/soc/sh/siu_pcm.c     |   32 ++++++++++----------
 sound/soc/sh/ssi.c         |   55 +++++++++++++++++++++++-------------
 12 files changed, 215 insertions(+), 193 deletions(-)

diff --git a/include/sound/sh_fsi.h b/include/sound/sh_fsi.h
index 9d51d6f..3fd6456 100644
--- a/include/sound/sh_fsi.h
+++ b/include/sound/sh_fsi.h
@@ -114,7 +114,7 @@ struct sh_fsi_platform_info {
 	int (*set_rate)(int is_porta, int rate); /* for master mode */
 };
 
-extern struct snd_soc_dai fsi_soc_dai[2];
-extern struct snd_soc_platform fsi_soc_platform;
+extern struct snd_soc_dai_driver fsi_soc_dai[2];
+extern struct snd_soc_platform_driver fsi_soc_platform;
 
 #endif /* __SOUND_FSI_H */
diff --git a/sound/soc/sh/dma-sh7760.c b/sound/soc/sh/dma-sh7760.c
index 0d8bdf0..c326d29 100644
--- a/sound/soc/sh/dma-sh7760.c
+++ b/sound/soc/sh/dma-sh7760.c
@@ -137,7 +137,7 @@ static void camelot_rxdma(void *data)
 static int camelot_pcm_open(struct snd_pcm_substream *substream)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct camelot_pcm *cam = &cam_pcm_data[rtd->dai->cpu_dai->id];
+	struct camelot_pcm *cam = &cam_pcm_data[rtd->cpu_dai->id];
 	int recv = substream->stream == SNDRV_PCM_STREAM_PLAYBACK ? 0:1;
 	int ret, dmairq;
 
@@ -150,7 +150,7 @@ static int camelot_pcm_open(struct snd_pcm_substream *substream)
 		ret = dmabrg_request_irq(dmairq, camelot_rxdma, cam);
 		if (unlikely(ret)) {
 			pr_debug("audio unit %d irqs already taken!\n",
-			     rtd->dai->cpu_dai->id);
+			     rtd->cpu_dai->id);
 			return -EBUSY;
 		}
 		(void)dmabrg_request_irq(dmairq + 1,camelot_rxdma, cam);
@@ -159,7 +159,7 @@ static int camelot_pcm_open(struct snd_pcm_substream *substream)
 		ret = dmabrg_request_irq(dmairq, camelot_txdma, cam);
 		if (unlikely(ret)) {
 			pr_debug("audio unit %d irqs already taken!\n",
-			     rtd->dai->cpu_dai->id);
+			     rtd->cpu_dai->id);
 			return -EBUSY;
 		}
 		(void)dmabrg_request_irq(dmairq + 1, camelot_txdma, cam);
@@ -170,7 +170,7 @@ static int camelot_pcm_open(struct snd_pcm_substream *substream)
 static int camelot_pcm_close(struct snd_pcm_substream *substream)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct camelot_pcm *cam = &cam_pcm_data[rtd->dai->cpu_dai->id];
+	struct camelot_pcm *cam = &cam_pcm_data[rtd->cpu_dai->id];
 	int recv = substream->stream == SNDRV_PCM_STREAM_PLAYBACK ? 0:1;
 	int dmairq;
 
@@ -191,7 +191,7 @@ static int camelot_hw_params(struct snd_pcm_substream *substream,
 			     struct snd_pcm_hw_params *hw_params)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct camelot_pcm *cam = &cam_pcm_data[rtd->dai->cpu_dai->id];
+	struct camelot_pcm *cam = &cam_pcm_data[rtd->cpu_dai->id];
 	int recv = substream->stream == SNDRV_PCM_STREAM_PLAYBACK ? 0:1;
 	int ret;
 
@@ -219,7 +219,7 @@ static int camelot_prepare(struct snd_pcm_substream *substream)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct camelot_pcm *cam = &cam_pcm_data[rtd->dai->cpu_dai->id];
+	struct camelot_pcm *cam = &cam_pcm_data[rtd->cpu_dai->id];
 
 	pr_debug("PCM data: addr 0x%08ulx len %d\n",
 		 (u32)runtime->dma_addr, runtime->dma_bytes);
@@ -266,7 +266,7 @@ static inline void dmabrg_rec_dma_stop(struct camelot_pcm *cam)
 static int camelot_trigger(struct snd_pcm_substream *substream, int cmd)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct camelot_pcm *cam = &cam_pcm_data[rtd->dai->cpu_dai->id];
+	struct camelot_pcm *cam = &cam_pcm_data[rtd->cpu_dai->id];
 	int recv = substream->stream == SNDRV_PCM_STREAM_PLAYBACK ? 0:1;
 
 	switch (cmd) {
@@ -293,7 +293,7 @@ static snd_pcm_uframes_t camelot_pos(struct snd_pcm_substream *substream)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct camelot_pcm *cam = &cam_pcm_data[rtd->dai->cpu_dai->id];
+	struct camelot_pcm *cam = &cam_pcm_data[rtd->cpu_dai->id];
 	int recv = substream->stream == SNDRV_PCM_STREAM_PLAYBACK ? 0:1;
 	unsigned long pos;
 
@@ -342,25 +342,44 @@ static int camelot_pcm_new(struct snd_card *card,
 	return 0;
 }
 
-struct snd_soc_platform sh7760_soc_platform = {
-	.name		= "sh7760-pcm",
+static struct snd_soc_platform sh7760_soc_platform = {
 	.pcm_ops 	= &camelot_pcm_ops,
 	.pcm_new	= camelot_pcm_new,
 	.pcm_free	= camelot_pcm_free,
 };
-EXPORT_SYMBOL_GPL(sh7760_soc_platform);
 
-static int __init sh7760_soc_platform_init(void)
+static int __devinit sh7760_soc_platform_probe(struct platform_device *pdev)
 {
-	return snd_soc_register_platform(&sh7760_soc_platform);
+	return snd_soc_register_platform(&pdev->dev, &sh7760_soc_platform);
 }
-module_init(sh7760_soc_platform_init);
 
-static void __exit sh7760_soc_platform_exit(void)
+static int __devexit sh7760_soc_platform_remove(struct platform_device *pdev)
 {
-	snd_soc_unregister_platform(&sh7760_soc_platform);
+	snd_soc_unregister_platform(&pdev->dev);
+	return 0;
+}
+
+static struct platform_driver sh7760_pcm_driver = {
+	.driver = {
+			.name = "sh7760-pcm-audio",
+			.owner = THIS_MODULE,
+	},
+
+	.probe = sh7760_soc_platform_probe,
+	.remove = __devexit_p(sh7760_soc_platform_remove),
+};
+
+static int __init snd_sh7760_pcm_init(void)
+{
+	return platform_driver_register(&sh7760_pcm_driver);
+}
+module_init(snd_sh7760_pcm_init);
+
+static void __exit snd_sh7760_pcm_exit(void)
+{
+	platform_driver_unregister(&sh7760_pcm_driver);
 }
-module_exit(sh7760_soc_platform_exit);
+module_exit(snd_sh7760_pcm_exit);
 
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("SH7760 Audio DMA (DMABRG) driver");
diff --git a/sound/soc/sh/fsi-ak4642.c b/sound/soc/sh/fsi-ak4642.c
index dad575a..ff17ff3 100644
--- a/sound/soc/sh/fsi-ak4642.c
+++ b/sound/soc/sh/fsi-ak4642.c
@@ -11,17 +11,17 @@
 
 #include <linux/platform_device.h>
 #include <sound/sh_fsi.h>
-#include <../sound/soc/codecs/ak4642.h>
 
-static int fsi_ak4642_dai_init(struct snd_soc_codec *codec)
+static int fsi_ak4642_dai_init(struct snd_soc_pcm_runtime *rtd)
 {
+	struct snd_soc_dai *dai = rtd->codec_dai;
 	int ret;
 
-	ret = snd_soc_dai_set_fmt(&ak4642_dai, SND_SOC_DAIFMT_CBM_CFM);
+	ret = snd_soc_dai_set_fmt(dai, SND_SOC_DAIFMT_CBM_CFM);
 	if (ret < 0)
 		return ret;
 
-	ret = snd_soc_dai_set_sysclk(&ak4642_dai, 0, 11289600, 0);
+	ret = snd_soc_dai_set_sysclk(dai, 0, 11289600, 0);
 
 	return ret;
 }
@@ -29,24 +29,20 @@ static int fsi_ak4642_dai_init(struct snd_soc_codec *codec)
 static struct snd_soc_dai_link fsi_dai_link = {
 	.name		= "AK4642",
 	.stream_name	= "AK4642",
-	.cpu_dai	= &fsi_soc_dai[FSI_PORT_A],
-	.codec_dai	= &ak4642_dai,
+	.cpu_dai_name	= "fsia-dai", /* fsi A */
+	.codec_dai_name	= "ak4642-hifi",
+	.platform_name	= "fsi-pcm-audio",
+	.codec_name	= "ak4642-codec.0-0x12",
 	.init		= fsi_ak4642_dai_init,
 	.ops		= NULL,
 };
 
 static struct snd_soc_card fsi_soc_card  = {
 	.name		= "FSI",
-	.platform	= &fsi_soc_platform,
 	.dai_link	= &fsi_dai_link,
 	.num_links	= 1,
 };
 
-static struct snd_soc_device fsi_snd_devdata = {
-	.card		= &fsi_soc_card,
-	.codec_dev	= &soc_codec_dev_ak4642,
-};
-
 static struct platform_device *fsi_snd_device;
 
 static int __init fsi_ak4642_init(void)
@@ -57,9 +53,7 @@ static int __init fsi_ak4642_init(void)
 	if (!fsi_snd_device)
 		goto out;
 
-	platform_set_drvdata(fsi_snd_device,
-			     &fsi_snd_devdata);
-	fsi_snd_devdata.dev = &fsi_snd_device->dev;
+	platform_set_drvdata(fsi_snd_device, &fsi_soc_card);
 	ret = platform_device_add(fsi_snd_device);
 
 	if (ret)
diff --git a/sound/soc/sh/fsi-da7210.c b/sound/soc/sh/fsi-da7210.c
index 121bbb0..e2f6fe5 100644
--- a/sound/soc/sh/fsi-da7210.c
+++ b/sound/soc/sh/fsi-da7210.c
@@ -12,11 +12,12 @@
 
 #include <linux/platform_device.h>
 #include <sound/sh_fsi.h>
-#include "../codecs/da7210.h"
 
-static int fsi_da7210_init(struct snd_soc_codec *codec)
+static int fsi_da7210_init(struct snd_soc_pcm_runtime *rtd)
 {
-	return snd_soc_dai_set_fmt(&da7210_dai,
+	struct snd_soc_dai *dai = rtd->codec_dai;
+
+	return snd_soc_dai_set_fmt(dai,
 				   SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
 				   SND_SOC_DAIFMT_CBM_CFM);
 }
@@ -24,23 +25,19 @@ static int fsi_da7210_init(struct snd_soc_codec *codec)
 static struct snd_soc_dai_link fsi_da7210_dai = {
 	.name		= "DA7210",
 	.stream_name	= "DA7210",
-	.cpu_dai	= &fsi_soc_dai[FSI_PORT_B],
-	.codec_dai	= &da7210_dai,
+	.cpu_dai_name	= "fsib-dai", /* FSI B */
+	.codec_dai_name	= "da7210-hifi",
+	.platform_name	= "fsi-pcm-audio",
+	.codec_name	= "da7210-codec.0-0x1a",
 	.init		= fsi_da7210_init,
 };
 
 static struct snd_soc_card fsi_soc_card = {
 	.name		= "FSI",
-	.platform	= &fsi_soc_platform,
 	.dai_link	= &fsi_da7210_dai,
 	.num_links	= 1,
 };
 
-static struct snd_soc_device fsi_da7210_snd_devdata = {
-	.card		= &fsi_soc_card,
-	.codec_dev	= &soc_codec_dev_da7210,
-};
-
 static struct platform_device *fsi_da7210_snd_device;
 
 static int __init fsi_da7210_sound_init(void)
@@ -51,8 +48,7 @@ static int __init fsi_da7210_sound_init(void)
 	if (!fsi_da7210_snd_device)
 		return -ENOMEM;
 
-	platform_set_drvdata(fsi_da7210_snd_device, &fsi_da7210_snd_devdata);
-	fsi_da7210_snd_devdata.dev = &fsi_da7210_snd_device->dev;
+	platform_set_drvdata(fsi_da7210_snd_device, &fsi_soc_card);
 	ret = platform_device_add(fsi_da7210_snd_device);
 	if (ret)
 		platform_device_put(fsi_da7210_snd_device);
diff --git a/sound/soc/sh/fsi.c b/sound/soc/sh/fsi.c
index 58c6bec..abc6d83 100644
--- a/sound/soc/sh/fsi.c
+++ b/sound/soc/sh/fsi.c
@@ -271,16 +271,19 @@ static int fsi_is_port_a(struct fsi_priv *fsi)
 static struct snd_soc_dai *fsi_get_dai(struct snd_pcm_substream *substream)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_dai_link *machine = rtd->dai;
 
-	return  machine->cpu_dai;
+	return  rtd->cpu_dai;
 }
 
 static struct fsi_priv *fsi_get_priv(struct snd_pcm_substream *substream)
 {
 	struct snd_soc_dai *dai = fsi_get_dai(substream);
+	struct fsi_master *master = snd_soc_dai_get_drvdata(dai);
 
-	return dai->private_data;
+	if (dai->id == 0)
+		return &master->fsia;
+	else
+		return &master->fsib;
 }
 
 static u32 fsi_get_info_flags(struct fsi_priv *fsi)
@@ -1025,10 +1028,9 @@ static int fsi_pcm_new(struct snd_card *card,
 
 
 ************************************************************************/
-struct snd_soc_dai fsi_soc_dai[] = {
+static struct snd_soc_dai_driver fsi_soc_dai[] = {
 	{
-		.name			= "FSIA",
-		.id			= 0,
+		.name			= "fsia-dai",
 		.playback = {
 			.rates		= FSI_RATES,
 			.formats	= FSI_FMTS,
@@ -1044,8 +1046,7 @@ struct snd_soc_dai fsi_soc_dai[] = {
 		.ops = &fsi_dai_ops,
 	},
 	{
-		.name			= "FSIB",
-		.id			= 1,
+		.name			= "fsib-dai",
 		.playback = {
 			.rates		= FSI_RATES,
 			.formats	= FSI_FMTS,
@@ -1061,15 +1062,12 @@ struct snd_soc_dai fsi_soc_dai[] = {
 		.ops = &fsi_dai_ops,
 	},
 };
-EXPORT_SYMBOL_GPL(fsi_soc_dai);
 
-struct snd_soc_platform fsi_soc_platform = {
-	.name		= "fsi-pcm",
-	.pcm_ops 	= &fsi_pcm_ops,
+static struct snd_soc_platform_driver fsi_soc_platform = {
+	.ops		= &fsi_pcm_ops,
 	.pcm_new	= fsi_pcm_new,
 	.pcm_free	= fsi_pcm_free,
 };
-EXPORT_SYMBOL_GPL(fsi_soc_platform);
 
 /************************************************************************
 
@@ -1132,11 +1130,7 @@ static int fsi_probe(struct platform_device *pdev)
 
 	pm_runtime_enable(&pdev->dev);
 	pm_runtime_resume(&pdev->dev);
-
-	fsi_soc_dai[0].dev		= &pdev->dev;
-	fsi_soc_dai[0].private_data	= &master->fsia;
-	fsi_soc_dai[1].dev		= &pdev->dev;
-	fsi_soc_dai[1].private_data	= &master->fsib;
+	dev_set_drvdata(&pdev->dev, master);
 
 	fsi_soft_all_reset(master);
 
@@ -1147,13 +1141,13 @@ static int fsi_probe(struct platform_device *pdev)
 		goto exit_iounmap;
 	}
 
-	ret = snd_soc_register_platform(&fsi_soc_platform);
+	ret = snd_soc_register_platform(&pdev->dev, &fsi_soc_platform);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "cannot snd soc register\n");
 		goto exit_free_irq;
 	}
 
-	return snd_soc_register_dais(fsi_soc_dai, ARRAY_SIZE(fsi_soc_dai));
+	return snd_soc_register_dais(&pdev->dev, fsi_soc_dai, ARRAY_SIZE(fsi_soc_dai));
 
 exit_free_irq:
 	free_irq(irq, master);
@@ -1171,10 +1165,10 @@ static int fsi_remove(struct platform_device *pdev)
 {
 	struct fsi_master *master;
 
-	master = fsi_get_master(fsi_soc_dai[0].private_data);
+	master = dev_get_drvdata(&pdev->dev);
 
-	snd_soc_unregister_dais(fsi_soc_dai, ARRAY_SIZE(fsi_soc_dai));
-	snd_soc_unregister_platform(&fsi_soc_platform);
+	snd_soc_unregister_dais(&pdev->dev, ARRAY_SIZE(fsi_soc_dai));
+	snd_soc_unregister_platform(&pdev->dev);
 
 	pm_runtime_disable(&pdev->dev);
 
@@ -1183,11 +1177,6 @@ static int fsi_remove(struct platform_device *pdev)
 	iounmap(master->base);
 	kfree(master);
 
-	fsi_soc_dai[0].dev		= NULL;
-	fsi_soc_dai[0].private_data	= NULL;
-	fsi_soc_dai[1].dev		= NULL;
-	fsi_soc_dai[1].private_data	= NULL;
-
 	return 0;
 }
 
@@ -1233,7 +1222,7 @@ static struct platform_device_id fsi_id_table[] = {
 
 static struct platform_driver fsi_driver = {
 	.driver 	= {
-		.name	= "sh_fsi",
+		.name	= "fsi-pcm-audio",
 		.pm	= &fsi_pm_ops,
 	},
 	.probe		= fsi_probe,
diff --git a/sound/soc/sh/hac.c b/sound/soc/sh/hac.c
index 41db75a..c87e3ff 100644
--- a/sound/soc/sh/hac.c
+++ b/sound/soc/sh/hac.c
@@ -239,8 +239,7 @@ static int hac_hw_params(struct snd_pcm_substream *substream,
 			 struct snd_pcm_hw_params *params,
 			 struct snd_soc_dai *dai)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct hac_priv *hac = &hac_cpu_data[rtd->dai->cpu_dai->id];
+	struct hac_priv *hac = &hac_cpu_data[dai->id];
 	int d = substream->stream == SNDRV_PCM_STREAM_PLAYBACK ? 0 : 1;
 
 	switch (params->msbits) {
@@ -271,10 +270,9 @@ static struct snd_soc_dai_ops hac_dai_ops = {
 	.hw_params	= hac_hw_params,
 };
 
-struct snd_soc_dai sh4_hac_dai[] = {
+static struct snd_soc_dai_driver sh4_hac_dai[] = {
 {
-	.name			= "HAC0",
-	.id			= 0,
+	.name			= "hac-dai.0",
 	.ac97_control		= 1,
 	.playback = {
 		.rates		= AC97_RATES,
@@ -292,8 +290,7 @@ struct snd_soc_dai sh4_hac_dai[] = {
 },
 #ifdef CONFIG_CPU_SUBTYPE_SH7760
 {
-	.name			= "HAC1",
-	.ac97_control		= 1,
+	.name			= "hac-dai.1",
 	.id			= 1,
 	.playback = {
 		.rates		= AC97_RATES,
@@ -312,19 +309,40 @@ struct snd_soc_dai sh4_hac_dai[] = {
 },
 #endif
 };
-EXPORT_SYMBOL_GPL(sh4_hac_dai);
 
-static int __init sh4_hac_init(void)
+static int __devinit hac_soc_platform_probe(struct platform_device *pdev)
+{
+	return snd_soc_register_dais(&pdev->dev, sh4_hac_dai,
+			ARRAY_SIZE(sh4_hac_dai));
+}
+
+static int __devexit hac_soc_platform_remove(struct platform_device *pdev)
+{
+	snd_soc_unregister_dais(&pdev->dev, ARRAY_SIZE(sh4_hac_dai));
+	return 0;
+}
+
+static struct platform_driver hac_pcm_driver = {
+	.driver = {
+			.name = "hac-pcm-audio",
+			.owner = THIS_MODULE,
+	},
+
+	.probe = hac_soc_platform_probe,
+	.remove = __devexit_p(hac_soc_platform_remove),
+};
+
+static int __init sh4_hac_pcm_init(void)
 {
-	return snd_soc_register_dais(sh4_hac_dai, ARRAY_SIZE(sh4_hac_dai));
+	return platform_driver_register(&hac_pcm_driver);
 }
-module_init(sh4_hac_init);
+module_init(sh4_hac_pcm_init);
 
-static void __exit sh4_hac_exit(void)
+static void __exit sh4_hac_pcm_exit(void)
 {
-	snd_soc_unregister_dais(sh4_hac_dai, ARRAY_SIZE(sh4_hac_dai));
+	platform_driver_unregister(&hac_pcm_driver);
 }
-module_exit(sh4_hac_exit);
+module_exit(sh4_hac_pcm_exit);
 
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("SuperH onchip HAC (AC97) audio driver");
diff --git a/sound/soc/sh/migor.c b/sound/soc/sh/migor.c
index b823a5c..0dc3a0e 100644
--- a/sound/soc/sh/migor.c
+++ b/sound/soc/sh/migor.c
@@ -50,7 +50,7 @@ static int migor_hw_params(struct snd_pcm_substream *substream,
 			   struct snd_pcm_hw_params *params)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
 	int ret;
 	unsigned int rate = params_rate(params);
 
@@ -68,7 +68,7 @@ static int migor_hw_params(struct snd_pcm_substream *substream,
 	if (ret < 0)
 		return ret;
 
-	ret = snd_soc_dai_set_fmt(rtd->dai->cpu_dai, SND_SOC_DAIFMT_NB_IF |
+	ret = snd_soc_dai_set_fmt(rtd->cpu_dai, SND_SOC_DAIFMT_NB_IF |
 				  SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_CBS_CFS);
 	if (ret < 0)
 		return ret;
@@ -81,7 +81,7 @@ static int migor_hw_params(struct snd_pcm_substream *substream,
 	clk_set_rate(&siumckb_clk, codec_freq);
 	dev_dbg(codec_dai->dev, "%s: configure %luHz\n", __func__, codec_freq);
 
-	ret = snd_soc_dai_set_sysclk(rtd->dai->cpu_dai, SIU_CLKB_EXT,
+	ret = snd_soc_dai_set_sysclk(rtd->cpu_dai, SIU_CLKB_EXT,
 				     codec_freq / 2, SND_SOC_CLOCK_IN);
 
 	if (!ret)
@@ -93,7 +93,7 @@ static int migor_hw_params(struct snd_pcm_substream *substream,
 static int migor_hw_free(struct snd_pcm_substream *substream)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
 
 	if (use_count) {
 		use_count--;
@@ -136,8 +136,10 @@ static const struct snd_soc_dapm_route audio_map[] = {
 	{ "Mic Bias", NULL, "External Microphone" },
 };
 
-static int migor_dai_init(struct snd_soc_codec *codec)
+static int migor_dai_init(struct snd_soc_pcm_runtime *rtd)
 {
+	struct snd_soc_codec *codec = rtd->codec;
+
 	snd_soc_dapm_new_controls(codec, migor_dapm_widgets,
 				  ARRAY_SIZE(migor_dapm_widgets));
 
@@ -150,8 +152,10 @@ static int migor_dai_init(struct snd_soc_codec *codec)
 static struct snd_soc_dai_link migor_dai = {
 	.name = "wm8978",
 	.stream_name = "WM8978",
-	.cpu_dai = &siu_i2s_dai,
-	.codec_dai = &wm8978_dai,
+	.cpu_dai_name = "siu-i2s-dai",
+	.codec_dai_name = "wm8978-hifi",
+	.platform_name = "siu-pcm-audio",
+	.codec_name = "wm8978-codec.0-0x1a",
 	.ops = &migor_dai_ops,
 	.init = migor_dai_init,
 };
@@ -159,17 +163,10 @@ static struct snd_soc_dai_link migor_dai = {
 /* migor audio machine driver */
 static struct snd_soc_card snd_soc_migor = {
 	.name = "Migo-R",
-	.platform = &siu_platform,
 	.dai_link = &migor_dai,
 	.num_links = 1,
 };
 
-/* migor audio subsystem */
-static struct snd_soc_device migor_snd_devdata = {
-	.card = &snd_soc_migor,
-	.codec_dev = &soc_codec_dev_wm8978,
-};
-
 static struct platform_device *migor_snd_device;
 
 static int __init migor_init(void)
@@ -187,9 +184,7 @@ static int __init migor_init(void)
 		goto epdevalloc;
 	}
 
-	platform_set_drvdata(migor_snd_device, &migor_snd_devdata);
-
-	migor_snd_devdata.dev = &migor_snd_device->dev;
+	platform_set_drvdata(migor_snd_device, &snd_soc_migor);
 
 	ret = platform_device_add(migor_snd_device);
 	if (ret)
diff --git a/sound/soc/sh/sh7760-ac97.c b/sound/soc/sh/sh7760-ac97.c
index ce7f95b..b897f7b 100644
--- a/sound/soc/sh/sh7760-ac97.c
+++ b/sound/soc/sh/sh7760-ac97.c
@@ -15,41 +15,35 @@
 #include <sound/soc-dapm.h>
 #include <asm/io.h>
 
-#include "../codecs/ac97.h"
-
 #define IPSEL 0xFE400034
 
 /* platform specific structs can be declared here */
-extern struct snd_soc_dai sh4_hac_dai[2];
-extern struct snd_soc_platform sh7760_soc_platform;
+extern struct snd_soc_dai_driver sh4_hac_dai[2];
+extern struct snd_soc_platform_driver sh7760_soc_platform;
 
-static int machine_init(struct snd_soc_codec *codec)
+static int machine_init(struct snd_soc_pcm_runtime *rtd)
 {
-	snd_soc_dapm_sync(codec);
+	snd_soc_dapm_sync(rtd->codec);
 	return 0;
 }
 
 static struct snd_soc_dai_link sh7760_ac97_dai = {
 	.name = "AC97",
 	.stream_name = "AC97 HiFi",
-	.cpu_dai = &sh4_hac_dai[0],	/* HAC0 */
-	.codec_dai = &ac97_dai,
+	.cpu_dai_name = "hac-dai.0",	/* HAC0 */
+	.codec_dai_name = "ac97-hifi",
+	.platform_name = "sh7760-pcm-audio",
+	.codec_name = "ac97-codec",
 	.init = machine_init,
 	.ops = NULL,
 };
 
 static struct snd_soc_card sh7760_ac97_soc_machine  = {
 	.name = "SH7760 AC97",
-	.platform = &sh7760_soc_platform,
 	.dai_link = &sh7760_ac97_dai,
 	.num_links = 1,
 };
 
-static struct snd_soc_device sh7760_ac97_snd_devdata = {
-	.card = &sh7760_ac97_soc_machine,
-	.codec_dev = &soc_codec_dev_ac97,
-};
-
 static struct platform_device *sh7760_ac97_snd_device;
 
 static int __init sh7760_ac97_init(void)
@@ -67,8 +61,7 @@ static int __init sh7760_ac97_init(void)
 		goto out;
 
 	platform_set_drvdata(sh7760_ac97_snd_device,
-			     &sh7760_ac97_snd_devdata);
-	sh7760_ac97_snd_devdata.dev = &sh7760_ac97_snd_device->dev;
+			     &sh7760_ac97_soc_machine);
 	ret = platform_device_add(sh7760_ac97_snd_device);
 
 	if (ret)
diff --git a/sound/soc/sh/siu.h b/sound/soc/sh/siu.h
index 492b1ca..aa239ff 100644
--- a/sound/soc/sh/siu.h
+++ b/sound/soc/sh/siu.h
@@ -181,8 +181,9 @@ static inline u32 siu_read32(u32 __iomem *addr)
 #define SIU_BRGBSEL	(0x108 / sizeof(u32))
 #define SIU_BRRB	(0x10c / sizeof(u32))
 
-extern struct snd_soc_platform siu_platform;
-extern struct snd_soc_dai siu_i2s_dai;
+extern struct snd_soc_platform_driver siu_platform;
+extern struct snd_soc_dai_driver siu_i2s_dai;
+extern struct siu_info *siu_i2s_data;
 
 int siu_init_port(int port, struct siu_port **port_info, struct snd_card *card);
 void siu_free_port(struct siu_port *port_info);
diff --git a/sound/soc/sh/siu_dai.c b/sound/soc/sh/siu_dai.c
index eeed5ed..827940a 100644
--- a/sound/soc/sh/siu_dai.c
+++ b/sound/soc/sh/siu_dai.c
@@ -71,6 +71,9 @@ struct port_flag {
 	struct format_flag	capture;
 };
 
+struct siu_info *siu_i2s_data = NULL;
+EXPORT_SYMBOL_GPL(siu_i2s_data);
+
 static struct port_flag siu_flags[SIU_PORT_NUM] = {
 	[SIU_PORT_A] = {
 		.playback = {
@@ -104,13 +107,13 @@ static struct port_flag siu_flags[SIU_PORT_NUM] = {
 
 static void siu_dai_start(struct siu_port *port_info)
 {
-	struct siu_info *info = siu_i2s_dai.private_data;
+	struct siu_info *info = siu_i2s_data;
 	u32 __iomem *base = info->reg;
 
 	dev_dbg(port_info->pcm->card->dev, "%s\n", __func__);
 
 	/* Turn on SIU clock */
-	pm_runtime_get_sync(siu_i2s_dai.dev);
+	pm_runtime_get_sync(port_info->pcm->card->dev);
 
 	/* Issue software reset to siu */
 	siu_write32(base + SIU_SRCTL, 0);
@@ -148,21 +151,21 @@ static void siu_dai_start(struct siu_port *port_info)
 	siu_write32(base + SIU_SBDVCB, port_info->capture.volume);
 }
 
-static void siu_dai_stop(void)
+static void siu_dai_stop(struct siu_port *port_info)
 {
-	struct siu_info *info = siu_i2s_dai.private_data;
+	struct siu_info *info = siu_i2s_data;
 	u32 __iomem *base = info->reg;
 
 	/* SIU software reset */
 	siu_write32(base + SIU_SRCTL, 0);
 
 	/* Turn off SIU clock */
-	pm_runtime_put_sync(siu_i2s_dai.dev);
+	pm_runtime_put_sync(port_info->pcm->card->dev);
 }
 
 static void siu_dai_spbAselect(struct siu_port *port_info)
 {
-	struct siu_info *info = siu_i2s_dai.private_data;
+	struct siu_info *info = siu_i2s_data;
 	struct siu_firmware *fw = &info->fw;
 	u32 *ydef = fw->yram0;
 	u32 idx;
@@ -187,7 +190,7 @@ static void siu_dai_spbAselect(struct siu_port *port_info)
 
 static void siu_dai_spbBselect(struct siu_port *port_info)
 {
-	struct siu_info *info = siu_i2s_dai.private_data;
+	struct siu_info *info = siu_i2s_data;
 	struct siu_firmware *fw = &info->fw;
 	u32 *ydef = fw->yram0;
 	u32 idx;
@@ -207,7 +210,7 @@ static void siu_dai_spbBselect(struct siu_port *port_info)
 
 static void siu_dai_open(struct siu_stream *siu_stream)
 {
-	struct siu_info *info = siu_i2s_dai.private_data;
+	struct siu_info *info = siu_i2s_data;
 	u32 __iomem *base = info->reg;
 	u32 srctl, ifctl;
 
@@ -238,7 +241,7 @@ static void siu_dai_open(struct siu_stream *siu_stream)
  */
 static void siu_dai_pcmdatapack(struct siu_stream *siu_stream)
 {
-	struct siu_info *info = siu_i2s_dai.private_data;
+	struct siu_info *info = siu_i2s_data;
 	u32 __iomem *base = info->reg;
 	u32 dpak;
 
@@ -258,7 +261,7 @@ static void siu_dai_pcmdatapack(struct siu_stream *siu_stream)
 
 static int siu_dai_spbstart(struct siu_port *port_info)
 {
-	struct siu_info *info = siu_i2s_dai.private_data;
+	struct siu_info *info = siu_i2s_data;
 	u32 __iomem *base = info->reg;
 	struct siu_firmware *fw = &info->fw;
 	u32 *ydef = fw->yram0;
@@ -323,7 +326,7 @@ static int siu_dai_spbstart(struct siu_port *port_info)
 
 static void siu_dai_spbstop(struct siu_port *port_info)
 {
-	struct siu_info *info = siu_i2s_dai.private_data;
+	struct siu_info *info = siu_i2s_data;
 	u32 __iomem *base = info->reg;
 
 	siu_write32(base + SIU_SBACTIV, 0);
@@ -402,7 +405,7 @@ static int siu_dai_put_volume(struct snd_kcontrol *kctrl,
 {
 	struct siu_port *port_info = snd_kcontrol_chip(kctrl);
 	struct device *dev = port_info->pcm->card->dev;
-	struct siu_info *info = siu_i2s_dai.private_data;
+	struct siu_info *info = siu_i2s_data;
 	u32 __iomem *base = info->reg;
 	u32 new_vol;
 	u32 cur_vol;
@@ -510,7 +513,7 @@ void siu_free_port(struct siu_port *port_info)
 static int siu_dai_startup(struct snd_pcm_substream *substream,
 			   struct snd_soc_dai *dai)
 {
-	struct siu_info *info = siu_i2s_dai.private_data;
+	struct siu_info *info = snd_soc_dai_get_drvdata(dai);
 	struct snd_pcm_runtime *rt = substream->runtime;
 	struct siu_port	*port_info = siu_port_info(substream);
 	int ret;
@@ -532,7 +535,7 @@ static int siu_dai_startup(struct snd_pcm_substream *substream,
 static void siu_dai_shutdown(struct snd_pcm_substream *substream,
 			     struct snd_soc_dai *dai)
 {
-	struct siu_info *info = siu_i2s_dai.private_data;
+	struct siu_info *info = snd_soc_dai_get_drvdata(dai);
 	struct siu_port	*port_info = siu_port_info(substream);
 
 	dev_dbg(substream->pcm->card->dev, "%s: port=%d@%p\n", __func__,
@@ -548,7 +551,7 @@ static void siu_dai_shutdown(struct snd_pcm_substream *substream,
 		/* during stmread or stmwrite ? */
 		BUG_ON(port_info->playback.rw_flg || port_info->capture.rw_flg);
 		siu_dai_spbstop(port_info);
-		siu_dai_stop();
+		siu_dai_stop(port_info);
 	}
 }
 
@@ -556,7 +559,7 @@ static void siu_dai_shutdown(struct snd_pcm_substream *substream,
 static int siu_dai_prepare(struct snd_pcm_substream *substream,
 			   struct snd_soc_dai *dai)
 {
-	struct siu_info *info = siu_i2s_dai.private_data;
+	struct siu_info *info = snd_soc_dai_get_drvdata(dai);
 	struct snd_pcm_runtime *rt = substream->runtime;
 	struct siu_port *port_info = siu_port_info(substream);
 	struct siu_stream *siu_stream;
@@ -605,7 +608,7 @@ fail:
 static int siu_dai_set_fmt(struct snd_soc_dai *dai,
 			   unsigned int fmt)
 {
-	struct siu_info *info = siu_i2s_dai.private_data;
+	struct siu_info *info = snd_soc_dai_get_drvdata(dai);
 	u32 __iomem *base = info->reg;
 	u32 ifctl;
 
@@ -671,11 +674,11 @@ static int siu_dai_set_sysclk(struct snd_soc_dai *dai, int clk_id,
 		return -EINVAL;
 	}
 
-	siu_clk = clk_get(siu_i2s_dai.dev, siu_name);
+	siu_clk = clk_get(dai->dev, siu_name);
 	if (IS_ERR(siu_clk))
 		return PTR_ERR(siu_clk);
 
-	parent_clk = clk_get(siu_i2s_dai.dev, parent_name);
+	parent_clk = clk_get(dai->dev, parent_name);
 	if (!IS_ERR(parent_clk)) {
 		ret = clk_set_parent(siu_clk, parent_clk);
 		if (!ret)
@@ -696,9 +699,8 @@ static struct snd_soc_dai_ops siu_dai_ops = {
 	.set_fmt	= siu_dai_set_fmt,
 };
 
-struct snd_soc_dai siu_i2s_dai = {
-	.name = "sh-siu",
-	.id = 0,
+static struct snd_soc_dai_driver siu_i2s_dai = {
+	.name	= "sui-i2s-dai",
 	.playback = {
 		.channels_min = 2,
 		.channels_max = 2,
@@ -713,7 +715,6 @@ struct snd_soc_dai siu_i2s_dai = {
 	 },
 	.ops = &siu_dai_ops,
 };
-EXPORT_SYMBOL_GPL(siu_i2s_dai);
 
 static int __devinit siu_probe(struct platform_device *pdev)
 {
@@ -725,6 +726,7 @@ static int __devinit siu_probe(struct platform_device *pdev)
 	info = kmalloc(sizeof(*info), GFP_KERNEL);
 	if (!info)
 		return -ENOMEM;
+	siu_i2s_data = info;
 
 	ret = request_firmware(&fw_entry, "siu_spb.bin", &pdev->dev);
 	if (ret)
@@ -767,14 +769,14 @@ static int __devinit siu_probe(struct platform_device *pdev)
 	if (!info->reg)
 		goto emapreg;
 
-	siu_i2s_dai.dev = &pdev->dev;
-	siu_i2s_dai.private_data = info;
+	dev_set_drvdata(&pdev->dev, info);
 
-	ret = snd_soc_register_dais(&siu_i2s_dai, 1);
+	/* register using ARRAY version so we can keep dai name */
+	ret = snd_soc_register_dais(&pdev->dev, &siu_i2s_dai, 1);
 	if (ret < 0)
 		goto edaiinit;
 
-	ret = snd_soc_register_platform(&siu_platform);
+	ret = snd_soc_register_platform(&pdev->dev, &siu_platform);
 	if (ret < 0)
 		goto esocregp;
 
@@ -783,7 +785,7 @@ static int __devinit siu_probe(struct platform_device *pdev)
 	return ret;
 
 esocregp:
-	snd_soc_unregister_dais(&siu_i2s_dai, 1);
+	snd_soc_unregister_dai(&pdev->dev);
 edaiinit:
 	iounmap(info->reg);
 emapreg:
@@ -804,13 +806,13 @@ ereqfw:
 
 static int __devexit siu_remove(struct platform_device *pdev)
 {
-	struct siu_info *info = siu_i2s_dai.private_data;
+	struct siu_info *info = dev_get_drvdata(&pdev->dev);
 	struct resource *res;
 
 	pm_runtime_disable(&pdev->dev);
 
-	snd_soc_unregister_platform(&siu_platform);
-	snd_soc_unregister_dais(&siu_i2s_dai, 1);
+	snd_soc_unregister_platform(&pdev->dev);
+	snd_soc_unregister_dai(&pdev->dev);
 
 	iounmap(info->reg);
 	iounmap(info->yram);
@@ -826,7 +828,7 @@ static int __devexit siu_remove(struct platform_device *pdev)
 
 static struct platform_driver siu_driver = {
 	.driver 	= {
-		.name	= "sh_siu",
+		.name	= "siu-pcm-audio",
 	},
 	.probe		= siu_probe,
 	.remove		= __devexit_p(siu_remove),
diff --git a/sound/soc/sh/siu_pcm.c b/sound/soc/sh/siu_pcm.c
index 36170be..4404769 100644
--- a/sound/soc/sh/siu_pcm.c
+++ b/sound/soc/sh/siu_pcm.c
@@ -48,7 +48,7 @@ struct siu_port *siu_ports[SIU_PORT_NUM];
 /* transfersize is number of u32 dma transfers per period */
 static int siu_pcm_stmwrite_stop(struct siu_port *port_info)
 {
-	struct siu_info *info = siu_i2s_dai.private_data;
+	struct siu_info *info = siu_i2s_data;
 	u32 __iomem *base = info->reg;
 	struct siu_stream *siu_stream = &port_info->playback;
 	u32 stfifo;
@@ -114,7 +114,7 @@ static void siu_dma_tx_complete(void *arg)
 static int siu_pcm_wr_set(struct siu_port *port_info,
 			  dma_addr_t buff, u32 size)
 {
-	struct siu_info *info = siu_i2s_dai.private_data;
+	struct siu_info *info = siu_i2s_data;
 	u32 __iomem *base = info->reg;
 	struct siu_stream *siu_stream = &port_info->playback;
 	struct snd_pcm_substream *substream = siu_stream->substream;
@@ -161,7 +161,7 @@ static int siu_pcm_wr_set(struct siu_port *port_info,
 static int siu_pcm_rd_set(struct siu_port *port_info,
 			  dma_addr_t buff, size_t size)
 {
-	struct siu_info *info = siu_i2s_dai.private_data;
+	struct siu_info *info = siu_i2s_data;
 	u32 __iomem *base = info->reg;
 	struct siu_stream *siu_stream = &port_info->capture;
 	struct snd_pcm_substream *substream = siu_stream->substream;
@@ -270,7 +270,7 @@ static int siu_pcm_stmread_start(struct siu_port *port_info)
 
 static int siu_pcm_stmread_stop(struct siu_port *port_info)
 {
-	struct siu_info *info = siu_i2s_dai.private_data;
+	struct siu_info *info = siu_i2s_data;
 	u32 __iomem *base = info->reg;
 	struct siu_stream *siu_stream = &port_info->capture;
 	struct device *dev = siu_stream->substream->pcm->card->dev;
@@ -294,7 +294,7 @@ static int siu_pcm_stmread_stop(struct siu_port *port_info)
 static int siu_pcm_hw_params(struct snd_pcm_substream *ss,
 			     struct snd_pcm_hw_params *hw_params)
 {
-	struct siu_info *info = siu_i2s_dai.private_data;
+	struct siu_info *info = siu_i2s_data;
 	struct device *dev = ss->pcm->card->dev;
 	int ret;
 
@@ -309,7 +309,7 @@ static int siu_pcm_hw_params(struct snd_pcm_substream *ss,
 
 static int siu_pcm_hw_free(struct snd_pcm_substream *ss)
 {
-	struct siu_info *info = siu_i2s_dai.private_data;
+	struct siu_info *info = siu_i2s_data;
 	struct siu_port	*port_info = siu_port_info(ss);
 	struct device *dev = ss->pcm->card->dev;
 	struct siu_stream *siu_stream;
@@ -340,11 +340,12 @@ static bool filter(struct dma_chan *chan, void *slave)
 static int siu_pcm_open(struct snd_pcm_substream *ss)
 {
 	/* Playback / Capture */
-	struct siu_info *info = siu_i2s_dai.private_data;
+	struct snd_soc_pcm_runtime *rtd = ss->private_data;
+	struct siu_platform *pdata = snd_soc_platform_get_drvdata(rtd->platform);
+	struct siu_info *info = siu_i2s_data;
 	struct siu_port *port_info = siu_port_info(ss);
 	struct siu_stream *siu_stream;
 	u32 port = info->port_id;
-	struct siu_platform *pdata = siu_i2s_dai.dev->platform_data;
 	struct device *dev = ss->pcm->card->dev;
 	dma_cap_mask_t mask;
 	struct sh_dmae_slave *param;
@@ -381,7 +382,7 @@ static int siu_pcm_open(struct snd_pcm_substream *ss)
 
 static int siu_pcm_close(struct snd_pcm_substream *ss)
 {
-	struct siu_info *info = siu_i2s_dai.private_data;
+	struct siu_info *info = siu_i2s_data;
 	struct device *dev = ss->pcm->card->dev;
 	struct siu_port *port_info = siu_port_info(ss);
 	struct siu_stream *siu_stream;
@@ -403,7 +404,7 @@ static int siu_pcm_close(struct snd_pcm_substream *ss)
 
 static int siu_pcm_prepare(struct snd_pcm_substream *ss)
 {
-	struct siu_info *info = siu_i2s_dai.private_data;
+	struct siu_info *info = siu_i2s_data;
 	struct siu_port *port_info = siu_port_info(ss);
 	struct device *dev = ss->pcm->card->dev;
 	struct snd_pcm_runtime 	*rt = ss->runtime;
@@ -449,7 +450,7 @@ static int siu_pcm_prepare(struct snd_pcm_substream *ss)
 
 static int siu_pcm_trigger(struct snd_pcm_substream *ss, int cmd)
 {
-	struct siu_info *info = siu_i2s_dai.private_data;
+	struct siu_info *info = siu_i2s_data;
 	struct device *dev = ss->pcm->card->dev;
 	struct siu_port *port_info = siu_port_info(ss);
 	int ret;
@@ -492,7 +493,7 @@ static int siu_pcm_trigger(struct snd_pcm_substream *ss, int cmd)
 static snd_pcm_uframes_t siu_pcm_pointer_dma(struct snd_pcm_substream *ss)
 {
 	struct device *dev = ss->pcm->card->dev;
-	struct siu_info *info = siu_i2s_dai.private_data;
+	struct siu_info *info = siu_i2s_data;
 	u32 __iomem *base = info->reg;
 	struct siu_port *port_info = siu_port_info(ss);
 	struct snd_pcm_runtime *rt = ss->runtime;
@@ -528,7 +529,7 @@ static int siu_pcm_new(struct snd_card *card, struct snd_soc_dai *dai,
 		       struct snd_pcm *pcm)
 {
 	/* card->dev == socdev->dev, see snd_soc_new_pcms() */
-	struct siu_info *info = siu_i2s_dai.private_data;
+	struct siu_info *info = siu_i2s_data;
 	struct platform_device *pdev = to_platform_device(card->dev);
 	int ret;
 	int i;
@@ -605,9 +606,8 @@ static struct snd_pcm_ops siu_pcm_ops = {
 	.pointer	= siu_pcm_pointer_dma,
 };
 
-struct snd_soc_platform siu_platform = {
-	.name		= "siu-audio",
-	.pcm_ops 	= &siu_pcm_ops,
+struct snd_soc_platform_driver siu_platform = {
+	.ops			= &siu_pcm_ops,
 	.pcm_new	= siu_pcm_new,
 	.pcm_free	= siu_pcm_free,
 };
diff --git a/sound/soc/sh/ssi.c b/sound/soc/sh/ssi.c
index b378096..40bbdf1 100644
--- a/sound/soc/sh/ssi.c
+++ b/sound/soc/sh/ssi.c
@@ -92,8 +92,7 @@ struct ssi_priv {
 static int ssi_startup(struct snd_pcm_substream *substream,
 		       struct snd_soc_dai *dai)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct ssi_priv *ssi = &ssi_cpu_data[rtd->dai->cpu_dai->id];
+	struct ssi_priv *ssi = &ssi_cpu_data[dai->id];
 	if (ssi->inuse) {
 		pr_debug("ssi: already in use!\n");
 		return -EBUSY;
@@ -105,8 +104,7 @@ static int ssi_startup(struct snd_pcm_substream *substream,
 static void ssi_shutdown(struct snd_pcm_substream *substream,
 			 struct snd_soc_dai *dai)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct ssi_priv *ssi = &ssi_cpu_data[rtd->dai->cpu_dai->id];
+	struct ssi_priv *ssi = &ssi_cpu_data[dai->id];
 
 	ssi->inuse = 0;
 }
@@ -114,8 +112,7 @@ static void ssi_shutdown(struct snd_pcm_substream *substream,
 static int ssi_trigger(struct snd_pcm_substream *substream, int cmd,
 		       struct snd_soc_dai *dai)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct ssi_priv *ssi = &ssi_cpu_data[rtd->dai->cpu_dai->id];
+	struct ssi_priv *ssi = &ssi_cpu_data[dai->id];
 
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
@@ -135,8 +132,7 @@ static int ssi_hw_params(struct snd_pcm_substream *substream,
 			 struct snd_pcm_hw_params *params,
 			 struct snd_soc_dai *dai)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct ssi_priv *ssi = &ssi_cpu_data[rtd->dai->cpu_dai->id];
+	struct ssi_priv *ssi = &ssi_cpu_data[dai->id];
 	unsigned long ssicr = SSIREG(SSICR);
 	unsigned int bits, channels, swl, recv, i;
 
@@ -346,10 +342,9 @@ static struct snd_soc_dai_ops ssi_dai_ops = {
 	.set_fmt	= ssi_set_fmt,
 };
 
-struct snd_soc_dai sh4_ssi_dai[] = {
+struct snd_soc_dai_driver sh4_ssi_dai[] = {
 {
-	.name			= "SSI0",
-	.id			= 0,
+	.name			= "ssi-dai.0",
 	.playback = {
 		.rates		= SSI_RATES,
 		.formats	= SSI_FMTS,
@@ -366,8 +361,7 @@ struct snd_soc_dai sh4_ssi_dai[] = {
 },
 #ifdef CONFIG_CPU_SUBTYPE_SH7760
 {
-	.name			= "SSI1",
-	.id			= 1,
+	.name			= "ssi-dai.1",
 	.playback = {
 		.rates		= SSI_RATES,
 		.formats	= SSI_FMTS,
@@ -384,19 +378,40 @@ struct snd_soc_dai sh4_ssi_dai[] = {
 },
 #endif
 };
-EXPORT_SYMBOL_GPL(sh4_ssi_dai);
 
-static int __init sh4_ssi_init(void)
+static int __devinit sh4_soc_dai_probe(struct platform_device *pdev)
+{
+	return snd_soc_register_dais(&pdev->dev, sh4_ssi_dai,
+			ARRAY_SIZE(sh4_ssi_dai));
+}
+
+static int __devexit sh4_soc_dai_remove(struct platform_device *pdev)
+{
+	snd_soc_unregister_dai(&pdev->dev, ARRAY_SIZE(sh4_ssi_dai));
+	return 0;
+}
+
+static struct platform_driver sh4_ssi_driver = {
+	.driver = {
+			.name = "sh4-ssi-dai",
+			.owner = THIS_MODULE,
+	},
+
+	.probe = sh4_soc_dai_probe,
+	.remove = __devexit_p(sh4_soc_dai_remove),
+};
+
+static int __init snd_sh4_ssi_init(void)
 {
-	return snd_soc_register_dais(sh4_ssi_dai, ARRAY_SIZE(sh4_ssi_dai));
+	return platform_driver_register(&sh4_ssi_driver);
 }
-module_init(sh4_ssi_init);
+module_init(snd_sh4_ssi_init);
 
-static void __exit sh4_ssi_exit(void)
+static void __exit snd_sh4_ssi_exit(void)
 {
-	snd_soc_unregister_dais(sh4_ssi_dai, ARRAY_SIZE(sh4_ssi_dai));
+	platform_driver_unregister(&sh4_ssi_driver);
 }
-module_exit(sh4_ssi_exit);
+module_exit(snd_sh4_ssi_exit);
 
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("SuperH onchip SSI (I2S) audio driver");
-- 
1.7.0.4
