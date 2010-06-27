From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: [RFC 04/15] ASoC: multi-component - TI DaVinci Platform
Date: Sun, 27 Jun 2010 12:52:03 +0100
Message-ID: <1277639534-5104-5-git-send-email-lrg@slimlogic.co.uk>
References: <1277639534-5104-1-git-send-email-lrg@slimlogic.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id D3E97103844
	for <alsa-devel@alsa-project.org>;
	Sun, 27 Jun 2010 13:52:36 +0200 (CEST)
Received: by mail-ww0-f51.google.com with SMTP id 13so934011wwb.38
	for <alsa-devel@alsa-project.org>; Sun, 27 Jun 2010 04:52:36 -0700 (PDT)
In-Reply-To: <1277639534-5104-1-git-send-email-lrg@slimlogic.co.uk>
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Update the TI DaVinci platform and machines to new multi-component model.

This patch changes the machine drivers for multi-component as follows :-

 o Removed socdev
 o Each DAI link entry now contains platform and codec fields.
 o DAI link init() now passed snd_soc_pcm_runtime instread of snd_soc_codec.

This patch also changes the DAI and platform DAM drivers as follows :-

 o Each platform DAI and platform DMA driver is a kernel device and can
   have platform data.
 o DAI and Platform DMA drivers have private data accessors.

Other notable changes required for multi-component support:-

 o Added ASoC DMA platform device.
 o EVM now has 2 DAI links instead of #ifdef around CODEC choice.
 o aic3x_setup data is now platform data.

Signed-off-by: Liam Girdwood <lrg@slimlogic.co.uk>
---
 arch/arm/mach-davinci/devices.c    |   13 ++++
 sound/soc/davinci/davinci-evm.c    |  109 +++++++++++++-----------------------
 sound/soc/davinci/davinci-i2s.c    |   38 ++++++------
 sound/soc/davinci/davinci-i2s.h    |    2 +-
 sound/soc/davinci/davinci-mcasp.c  |   27 ++++-----
 sound/soc/davinci/davinci-mcasp.h  |    2 +-
 sound/soc/davinci/davinci-pcm.c    |   43 +++++++++++----
 sound/soc/davinci/davinci-pcm.h    |    2 +-
 sound/soc/davinci/davinci-sffsdr.c |   27 +++++----
 sound/soc/davinci/davinci-vcif.c   |   20 +++---
 sound/soc/davinci/davinci-vcif.h   |    2 +-
 11 files changed, 144 insertions(+), 141 deletions(-)

diff --git a/arch/arm/mach-davinci/devices.c b/arch/arm/mach-davinci/devices.c
index 8b7201e..de40e9c 100644
--- a/arch/arm/mach-davinci/devices.c
+++ b/arch/arm/mach-davinci/devices.c
@@ -295,6 +295,18 @@ static void davinci_init_wdt(void)
 
 /*-------------------------------------------------------------------------*/
 
+struct platform_device davinci_pcm_device = {
+	.name		= "davinci-pcm-audio",
+	.id		= -1,
+};
+
+static void davinci_init_pcm(void)
+{
+	platform_device_register(&davinci_pcm_device);
+}
+
+/*-------------------------------------------------------------------------*/
+
 struct davinci_timer_instance davinci_timer_instance[2] = {
 	{
 		.base		= DAVINCI_TIMER0_BASE,
@@ -315,6 +327,7 @@ static int __init davinci_init_devices(void)
 	/* please keep these calls, and their implementations above,
 	 * in alphabetical order so they're easier to sort through.
 	 */
+	davinci_init_pcm();
 	davinci_init_wdt();
 
 	return 0;
diff --git a/sound/soc/davinci/davinci-evm.c b/sound/soc/davinci/davinci-evm.c
index 97f74d6..b34b65a 100644
--- a/sound/soc/davinci/davinci-evm.c
+++ b/sound/soc/davinci/davinci-evm.c
@@ -41,8 +41,8 @@ static int evm_hw_params(struct snd_pcm_substream *substream,
 			 struct snd_pcm_hw_params *params)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
-	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
 	int ret = 0;
 	unsigned sysclk;
 
@@ -87,7 +87,7 @@ static int evm_spdif_hw_params(struct snd_pcm_substream *substream,
 				struct snd_pcm_hw_params *params)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
 
 	/* set cpu DAI configuration */
 	return snd_soc_dai_set_fmt(cpu_dai, AUDIO_FORMAT);
@@ -132,8 +132,10 @@ static const struct snd_soc_dapm_route audio_map[] = {
 };
 
 /* Logic for a aic3x as connected on a davinci-evm */
-static int evm_aic3x_init(struct snd_soc_codec *codec)
+static int evm_aic3x_init(struct snd_soc_pcm_runtime *rtd)
 {
+	struct snd_soc_codec *codec = rtd->codec;
+
 	/* Add davinci-evm specific widgets */
 	snd_soc_dapm_new_controls(codec, aic3x_dapm_widgets,
 				  ARRAY_SIZE(aic3x_dapm_widgets));
@@ -161,8 +163,10 @@ static int evm_aic3x_init(struct snd_soc_codec *codec)
 static struct snd_soc_dai_link evm_dai = {
 	.name = "TLV320AIC3X",
 	.stream_name = "AIC3X",
-	.cpu_dai = &davinci_i2s_dai,
-	.codec_dai = &aic3x_dai,
+	.cpu_dai_drv = &davinci_i2s_dai,
+	.codec_dai_drv = &aic3x_dai,
+	.codec_drv = &soc_codec_dev_aic3x,
+	.platform_drv = &davinci_soc_platform,
 	.init = evm_aic3x_init,
 	.ops = &evm_ops,
 };
@@ -171,40 +175,52 @@ static struct snd_soc_dai_link dm365_evm_dai = {
 #ifdef CONFIG_SND_DM365_AIC3X_CODEC
 	.name = "TLV320AIC3X",
 	.stream_name = "AIC3X",
-	.cpu_dai = &davinci_i2s_dai,
-	.codec_dai = &aic3x_dai,
+	.cpu_dai_drv = &davinci_i2s_dai,
+	.codec_dai_drv = &aic3x_dai,
 	.init = evm_aic3x_init,
+	.codec_drv = &soc_codec_dev_aic3x,
 	.ops = &evm_ops,
 #elif defined(CONFIG_SND_DM365_VOICE_CODEC)
 	.name = "Voice Codec - CQ93VC",
 	.stream_name = "CQ93",
-	.cpu_dai = &davinci_vcif_dai,
-	.codec_dai = &cq93vc_dai,
+	.cpu_dai_drv = &davinci_vcif_dai,
+	.codec_dai_drv = &cq93vc_dai,
+	.codec_drv = &soc_codec_dev_cq93vc,
 #endif
+	.platform_drv = &davinci_soc_platform,
 };
 
 static struct snd_soc_dai_link dm6467_evm_dai[] = {
 	{
 		.name = "TLV320AIC3X",
 		.stream_name = "AIC3X",
-		.cpu_dai = &davinci_mcasp_dai[DAVINCI_MCASP_I2S_DAI],
-		.codec_dai = &aic3x_dai,
+		.cpu_dai_drv= &davinci_mcasp_dai[DAVINCI_MCASP_I2S_DAI],
+		.cpu_dai_id = DAVINCI_MCASP_I2S_DAI,
+		.codec_dai_drv = &aic3x_dai,
+		.platform_drv = &davinci_soc_platform,
+		.codec_drv = &soc_codec_dev_aic3x,
 		.init = evm_aic3x_init,
 		.ops = &evm_ops,
 	},
 	{
 		.name = "McASP",
 		.stream_name = "spdif",
-		.cpu_dai = &davinci_mcasp_dai[DAVINCI_MCASP_DIT_DAI],
-		.codec_dai = &dit_stub_dai,
+		.cpu_dai_drv = &davinci_mcasp_dai[DAVINCI_MCASP_DIT_DAI],
+		.cpu_dai_id = DAVINCI_MCASP_DIT_DAI,
+		.codec_dai_drv = &dit_stub_dai,
+		.codec_drv = &soc_codec_spdif_dit,
+		.platform_drv = &davinci_soc_platform,
 		.ops = &evm_spdif_ops,
 	},
 };
 static struct snd_soc_dai_link da8xx_evm_dai = {
 	.name = "TLV320AIC3X",
 	.stream_name = "AIC3X",
-	.cpu_dai = &davinci_mcasp_dai[DAVINCI_MCASP_I2S_DAI],
-	.codec_dai = &aic3x_dai,
+	.cpu_dai_drv = &davinci_mcasp_dai[DAVINCI_MCASP_I2S_DAI],
+	.cpu_dai_id = DAVINCI_MCASP_I2S_DAI,
+	.codec_dai_drv = &aic3x_dai,
+	.codec_drv = &soc_codec_dev_aic3x,
+	.platform_drv = &davinci_soc_platform,
 	.init = evm_aic3x_init,
 	.ops = &evm_ops,
 };
@@ -212,7 +228,6 @@ static struct snd_soc_dai_link da8xx_evm_dai = {
 /* davinci dm6446, dm355 evm audio machine driver */
 static struct snd_soc_card snd_soc_card_evm = {
 	.name = "DaVinci EVM",
-	.platform = &davinci_soc_platform,
 	.dai_link = &evm_dai,
 	.num_links = 1,
 };
@@ -220,16 +235,13 @@ static struct snd_soc_card snd_soc_card_evm = {
 /* davinci dm365 evm audio machine driver */
 static struct snd_soc_card dm365_snd_soc_card_evm = {
 	.name = "DaVinci DM365 EVM",
-	.platform = &davinci_soc_platform,
 	.dai_link = &dm365_evm_dai,
 	.num_links = 1,
 };
 
-
 /* davinci dm6467 evm audio machine driver */
 static struct snd_soc_card dm6467_snd_soc_card_evm = {
 	.name = "DaVinci DM6467 EVM",
-	.platform = &davinci_soc_platform,
 	.dai_link = dm6467_evm_dai,
 	.num_links = ARRAY_SIZE(dm6467_evm_dai),
 };
@@ -237,82 +249,40 @@ static struct snd_soc_card dm6467_snd_soc_card_evm = {
 static struct snd_soc_card da830_snd_soc_card = {
 	.name = "DA830/OMAP-L137 EVM",
 	.dai_link = &da8xx_evm_dai,
-	.platform = &davinci_soc_platform,
 	.num_links = 1,
 };
 
 static struct snd_soc_card da850_snd_soc_card = {
 	.name = "DA850/OMAP-L138 EVM",
 	.dai_link = &da8xx_evm_dai,
-	.platform = &davinci_soc_platform,
 	.num_links = 1,
 };
 
-static struct aic3x_setup_data aic3x_setup;
-
-/* evm audio subsystem */
-static struct snd_soc_device evm_snd_devdata = {
-	.card = &snd_soc_card_evm,
-	.codec_dev = &soc_codec_dev_aic3x,
-	.codec_data = &aic3x_setup,
-};
-
-/* evm audio subsystem */
-static struct snd_soc_device dm365_evm_snd_devdata = {
-	.card = &dm365_snd_soc_card_evm,
-#ifdef CONFIG_SND_DM365_AIC3X_CODEC
-	.codec_dev = &soc_codec_dev_aic3x,
-	.codec_data = &aic3x_setup,
-#elif defined(CONFIG_SND_DM365_VOICE_CODEC)
-	.codec_dev = &soc_codec_dev_cq93vc,
-#endif
-};
-
-/* evm audio subsystem */
-static struct snd_soc_device dm6467_evm_snd_devdata = {
-	.card = &dm6467_snd_soc_card_evm,
-	.codec_dev = &soc_codec_dev_aic3x,
-	.codec_data = &aic3x_setup,
-};
-
-/* evm audio subsystem */
-static struct snd_soc_device da830_evm_snd_devdata = {
-	.card = &da830_snd_soc_card,
-	.codec_dev = &soc_codec_dev_aic3x,
-	.codec_data = &aic3x_setup,
-};
-
-static struct snd_soc_device da850_evm_snd_devdata = {
-	.card		= &da850_snd_soc_card,
-	.codec_dev	= &soc_codec_dev_aic3x,
-	.codec_data	= &aic3x_setup,
-};
-
 static struct platform_device *evm_snd_device;
 
 static int __init evm_init(void)
 {
-	struct snd_soc_device *evm_snd_dev_data;
+	struct snd_soc_card *evm_snd_dev_data;
 	int index;
 	int ret;
 
 	if (machine_is_davinci_evm()) {
-		evm_snd_dev_data = &evm_snd_devdata;
+		evm_snd_dev_data = &snd_soc_card_evm;
 		index = 0;
 	} else if (machine_is_davinci_dm355_evm()) {
-		evm_snd_dev_data = &evm_snd_devdata;
+		evm_snd_dev_data = &snd_soc_card_evm;
 		index = 1;
 	} else if (machine_is_davinci_dm365_evm()) {
-		evm_snd_dev_data = &dm365_evm_snd_devdata;
+		evm_snd_dev_data = &dm365_snd_soc_card_evm;
 		index = 0;
 	} else if (machine_is_davinci_dm6467_evm()) {
-		evm_snd_dev_data = &dm6467_evm_snd_devdata;
+		evm_snd_dev_data = &dm6467_snd_soc_card_evm;
 		index = 0;
 	} else if (machine_is_davinci_da830_evm()) {
-		evm_snd_dev_data = &da830_evm_snd_devdata;
+		evm_snd_dev_data = &da830_snd_soc_card;
 		index = 1;
 	} else if (machine_is_davinci_da850_evm()) {
-		evm_snd_dev_data = &da850_evm_snd_devdata;
+		evm_snd_dev_data = &da850_snd_soc_card;
 		index = 0;
 	} else
 		return -EINVAL;
@@ -322,7 +292,6 @@ static int __init evm_init(void)
 		return -ENOMEM;
 
 	platform_set_drvdata(evm_snd_device, evm_snd_dev_data);
-	evm_snd_dev_data->dev = &evm_snd_device->dev;
 	ret = platform_device_add(evm_snd_device);
 	if (ret)
 		platform_device_put(evm_snd_device);
diff --git a/sound/soc/davinci/davinci-i2s.c b/sound/soc/davinci/davinci-i2s.c
index adadcd3..668d91c 100644
--- a/sound/soc/davinci/davinci-i2s.c
+++ b/sound/soc/davinci/davinci-i2s.c
@@ -171,8 +171,7 @@ static void davinci_mcbsp_start(struct davinci_mcbsp_dev *dev,
 		struct snd_pcm_substream *substream)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_device *socdev = rtd->socdev;
-	struct snd_soc_platform *platform = socdev->card->platform;
+	struct snd_soc_platform *platform = rtd->platform;
 	int playback = (substream->stream == SNDRV_PCM_STREAM_PLAYBACK);
 	u32 spcr;
 	u32 mask = playback ? DAVINCI_MCBSP_SPCR_XRST : DAVINCI_MCBSP_SPCR_RRST;
@@ -193,8 +192,8 @@ static void davinci_mcbsp_start(struct davinci_mcbsp_dev *dev,
 	if (playback) {
 		/* Stop the DMA to avoid data loss */
 		/* while the transmitter is out of reset to handle XSYNCERR */
-		if (platform->pcm_ops->trigger) {
-			int ret = platform->pcm_ops->trigger(substream,
+		if (platform->driver->ops->trigger) {
+			int ret = platform->driver->ops->trigger(substream,
 				SNDRV_PCM_TRIGGER_STOP);
 			if (ret < 0)
 				printk(KERN_DEBUG "Playback DMA stop failed\n");
@@ -215,8 +214,8 @@ static void davinci_mcbsp_start(struct davinci_mcbsp_dev *dev,
 		toggle_clock(dev, playback);
 
 		/* Restart the DMA */
-		if (platform->pcm_ops->trigger) {
-			int ret = platform->pcm_ops->trigger(substream,
+		if (platform->driver->ops->trigger) {
+			int ret = platform->driver->ops->trigger(substream,
 				SNDRV_PCM_TRIGGER_START);
 			if (ret < 0)
 				printk(KERN_DEBUG "Playback DMA start failed\n");
@@ -251,7 +250,7 @@ static void davinci_mcbsp_stop(struct davinci_mcbsp_dev *dev, int playback)
 static int davinci_i2s_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 				   unsigned int fmt)
 {
-	struct davinci_mcbsp_dev *dev = cpu_dai->private_data;
+	struct davinci_mcbsp_dev *dev = snd_soc_dai_get_drvdata(cpu_dai);
 	unsigned int pcr;
 	unsigned int srgr;
 	srgr = DAVINCI_MCBSP_SRGR_FSGM |
@@ -376,7 +375,7 @@ static int davinci_i2s_hw_params(struct snd_pcm_substream *substream,
 				 struct snd_pcm_hw_params *params,
 				 struct snd_soc_dai *dai)
 {
-	struct davinci_mcbsp_dev *dev = dai->private_data;
+	struct davinci_mcbsp_dev *dev = snd_soc_dai_get_drvdata(dai);
 	struct davinci_pcm_dma_params *dma_params =
 					&dev->dma_params[substream->stream];
 	struct snd_interval *i = NULL;
@@ -386,6 +385,9 @@ static int davinci_i2s_hw_params(struct snd_pcm_substream *substream,
 	snd_pcm_format_t fmt;
 	unsigned element_cnt = 1;
 
+	dai->capture_dma_data = dev->dma_params;
+	dai->playback_dma_data = dev->dma_params;
+
 	/* general line settings */
 	spcr = davinci_mcbsp_read_reg(dev, DAVINCI_MCBSP_SPCR_REG);
 	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE) {
@@ -448,7 +450,7 @@ static int davinci_i2s_hw_params(struct snd_pcm_substream *substream,
 static int davinci_i2s_prepare(struct snd_pcm_substream *substream,
 		struct snd_soc_dai *dai)
 {
-	struct davinci_mcbsp_dev *dev = dai->private_data;
+	struct davinci_mcbsp_dev *dev = snd_soc_dai_get_drvdata(dai);
 	int playback = (substream->stream == SNDRV_PCM_STREAM_PLAYBACK);
 	davinci_mcbsp_stop(dev, playback);
 	if ((dev->pcr & DAVINCI_MCBSP_PCR_FSXM) == 0) {
@@ -461,7 +463,7 @@ static int davinci_i2s_prepare(struct snd_pcm_substream *substream,
 static int davinci_i2s_trigger(struct snd_pcm_substream *substream, int cmd,
 			       struct snd_soc_dai *dai)
 {
-	struct davinci_mcbsp_dev *dev = dai->private_data;
+	struct davinci_mcbsp_dev *dev = snd_soc_dai_get_drvdata(dai);
 	int ret = 0;
 	int playback = (substream->stream == SNDRV_PCM_STREAM_PLAYBACK);
 	if ((dev->pcr & DAVINCI_MCBSP_PCR_FSXM) == 0)
@@ -487,7 +489,7 @@ static int davinci_i2s_trigger(struct snd_pcm_substream *substream, int cmd,
 static void davinci_i2s_shutdown(struct snd_pcm_substream *substream,
 		struct snd_soc_dai *dai)
 {
-	struct davinci_mcbsp_dev *dev = dai->private_data;
+	struct davinci_mcbsp_dev *dev = snd_soc_dai_get_drvdata(dai);
 	int playback = (substream->stream == SNDRV_PCM_STREAM_PLAYBACK);
 	davinci_mcbsp_stop(dev, playback);
 }
@@ -503,9 +505,8 @@ static struct snd_soc_dai_ops davinci_i2s_dai_ops = {
 
 };
 
-struct snd_soc_dai davinci_i2s_dai = {
+struct snd_soc_dai_driver davinci_i2s_dai = {
 	.name = "davinci-i2s",
-	.id = 0,
 	.playback = {
 		.channels_min = 2,
 		.channels_max = 2,
@@ -585,10 +586,9 @@ static int davinci_i2s_probe(struct platform_device *pdev)
 	}
 	dev->dma_params[SNDRV_PCM_STREAM_CAPTURE].channel = res->start;
 
-	davinci_i2s_dai.private_data = dev;
-	davinci_i2s_dai.capture.dma_data = dev->dma_params;
-	davinci_i2s_dai.playback.dma_data = dev->dma_params;
-	ret = snd_soc_register_dai(&davinci_i2s_dai);
+	dev_set_drvdata(&pdev->dev, dev);
+
+	ret = snd_soc_register_dai(&pdev->dev, -1, &davinci_i2s_dai);
 	if (ret != 0)
 		goto err_free_mem;
 
@@ -604,10 +604,10 @@ err_release_region:
 
 static int davinci_i2s_remove(struct platform_device *pdev)
 {
-	struct davinci_mcbsp_dev *dev = davinci_i2s_dai.private_data;
+	struct davinci_mcbsp_dev *dev = dev_get_drvdata(&pdev->dev);
 	struct resource *mem;
 
-	snd_soc_unregister_dai(&davinci_i2s_dai);
+	snd_soc_unregister_dai(&pdev->dev, -1);
 	clk_disable(dev->clk);
 	clk_put(dev->clk);
 	dev->clk = NULL;
diff --git a/sound/soc/davinci/davinci-i2s.h b/sound/soc/davinci/davinci-i2s.h
index 241648c..74c0a3c 100644
--- a/sound/soc/davinci/davinci-i2s.h
+++ b/sound/soc/davinci/davinci-i2s.h
@@ -12,6 +12,6 @@
 #ifndef _DAVINCI_I2S_H
 #define _DAVINCI_I2S_H
 
-extern struct snd_soc_dai davinci_i2s_dai;
+extern struct snd_soc_dai_driver davinci_i2s_dai;
 
 #endif
diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index d395509..387b583 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -422,7 +422,7 @@ static void davinci_mcasp_stop(struct davinci_audio_dev *dev, int stream)
 static int davinci_mcasp_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 					 unsigned int fmt)
 {
-	struct davinci_audio_dev *dev = cpu_dai->private_data;
+	struct davinci_audio_dev *dev = snd_soc_dai_get_drvdata(cpu_dai);
 	void __iomem *base = dev->base;
 
 	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
@@ -709,12 +709,15 @@ static int davinci_mcasp_hw_params(struct snd_pcm_substream *substream,
 					struct snd_pcm_hw_params *params,
 					struct snd_soc_dai *cpu_dai)
 {
-	struct davinci_audio_dev *dev = cpu_dai->private_data;
+	struct davinci_audio_dev *dev = snd_soc_dai_get_drvdata(cpu_dai);
 	struct davinci_pcm_dma_params *dma_params =
 					&dev->dma_params[substream->stream];
 	int word_length;
 	u8 fifo_level;
 
+	cpu_dai->capture_dma_data = dev->dma_params;
+	cpu_dai->playback_dma_data = dev->dma_params;
+
 	davinci_hw_common_param(dev, substream->stream);
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
 		fifo_level = dev->txnumevt;
@@ -761,8 +764,7 @@ static int davinci_mcasp_hw_params(struct snd_pcm_substream *substream,
 static int davinci_mcasp_trigger(struct snd_pcm_substream *substream,
 				     int cmd, struct snd_soc_dai *cpu_dai)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct davinci_audio_dev *dev = rtd->dai->cpu_dai->private_data;
+	struct davinci_audio_dev *dev = snd_soc_dai_get_drvdata(cpu_dai);
 	int ret = 0;
 
 	switch (cmd) {
@@ -804,10 +806,9 @@ static struct snd_soc_dai_ops davinci_mcasp_dai_ops = {
 
 };
 
-struct snd_soc_dai davinci_mcasp_dai[] = {
+struct snd_soc_dai_driver davinci_mcasp_dai[] = {
 	{
 		.name 		= "davinci-i2s",
-		.id 		= 0,
 		.playback	= {
 			.channels_min	= 2,
 			.channels_max 	= 2,
@@ -829,7 +830,6 @@ struct snd_soc_dai davinci_mcasp_dai[] = {
 	},
 	{
 		.name 		= "davinci-dit",
-		.id 		= 1,
 		.playback 	= {
 			.channels_min	= 1,
 			.channels_max	= 384,
@@ -915,11 +915,9 @@ static int davinci_mcasp_probe(struct platform_device *pdev)
 	}
 
 	dma_data->channel = res->start;
-	davinci_mcasp_dai[pdata->op_mode].private_data = dev;
-	davinci_mcasp_dai[pdata->op_mode].capture.dma_data = dev->dma_params;
-	davinci_mcasp_dai[pdata->op_mode].playback.dma_data = dev->dma_params;
-	davinci_mcasp_dai[pdata->op_mode].dev = &pdev->dev;
-	ret = snd_soc_register_dai(&davinci_mcasp_dai[pdata->op_mode]);
+	dev_set_drvdata(&pdev->dev, dev);
+	ret = snd_soc_register_dai(&pdev->dev, pdata->op_mode,
+			&davinci_mcasp_dai[pdata->op_mode]);
 
 	if (ret != 0)
 		goto err_release_region;
@@ -936,11 +934,10 @@ err_release_data:
 static int davinci_mcasp_remove(struct platform_device *pdev)
 {
 	struct snd_platform_data *pdata = pdev->dev.platform_data;
-	struct davinci_audio_dev *dev;
+	struct davinci_audio_dev *dev = dev_get_drvdata(&pdev->dev);
 	struct resource *mem;
 
-	snd_soc_unregister_dai(&davinci_mcasp_dai[pdata->op_mode]);
-	dev = davinci_mcasp_dai[pdata->op_mode].private_data;
+	snd_soc_unregister_dai(&pdev->dev, pdata->op_mode);
 	clk_disable(dev->clk);
 	clk_put(dev->clk);
 	dev->clk = NULL;
diff --git a/sound/soc/davinci/davinci-mcasp.h b/sound/soc/davinci/davinci-mcasp.h
index e755b51..9ad0520 100644
--- a/sound/soc/davinci/davinci-mcasp.h
+++ b/sound/soc/davinci/davinci-mcasp.h
@@ -22,7 +22,7 @@
 #include <mach/asp.h>
 #include "davinci-pcm.h"
 
-extern struct snd_soc_dai davinci_mcasp_dai[];
+extern struct snd_soc_dai_driver davinci_mcasp_dai[];
 
 #define DAVINCI_MCASP_RATES	SNDRV_PCM_RATE_8000_96000
 #define DAVINCI_MCASP_I2S_DAI	0
diff --git a/sound/soc/davinci/davinci-pcm.c b/sound/soc/davinci/davinci-pcm.c
index 2dc406f..2d4674e 100644
--- a/sound/soc/davinci/davinci-pcm.c
+++ b/sound/soc/davinci/davinci-pcm.c
@@ -652,7 +652,7 @@ static int davinci_pcm_open(struct snd_pcm_substream *substream)
 	struct davinci_pcm_dma_params *pa;
 	struct davinci_pcm_dma_params *params;
 
-	pa = snd_soc_dai_get_dma_data(rtd->dai->cpu_dai, substream);
+	pa = snd_soc_dai_get_dma_data(rtd->cpu_dai, substream);
 	if (!pa)
 		return -ENODEV;
 	params = &pa[substream->stream];
@@ -820,7 +820,7 @@ static int davinci_pcm_new(struct snd_card *card,
 	if (!card->dev->coherent_dma_mask)
 		card->dev->coherent_dma_mask = 0xffffffff;
 
-	if (dai->playback.channels_min) {
+	if (dai->driver->playback.channels_min) {
 		ret = davinci_pcm_preallocate_dma_buffer(pcm,
 			SNDRV_PCM_STREAM_PLAYBACK,
 			pcm_hardware_playback.buffer_bytes_max);
@@ -828,7 +828,7 @@ static int davinci_pcm_new(struct snd_card *card,
 			return ret;
 	}
 
-	if (dai->capture.channels_min) {
+	if (dai->driver->capture.channels_min) {
 		ret = davinci_pcm_preallocate_dma_buffer(pcm,
 			SNDRV_PCM_STREAM_CAPTURE,
 			pcm_hardware_capture.buffer_bytes_max);
@@ -839,25 +839,46 @@ static int davinci_pcm_new(struct snd_card *card,
 	return 0;
 }
 
-struct snd_soc_platform davinci_soc_platform = {
+struct snd_soc_platform_driver davinci_soc_platform = {
 	.name = 	"davinci-audio",
-	.pcm_ops = 	&davinci_pcm_ops,
+	.ops =		&davinci_pcm_ops,
 	.pcm_new = 	davinci_pcm_new,
 	.pcm_free = 	davinci_pcm_free,
 };
 EXPORT_SYMBOL_GPL(davinci_soc_platform);
 
-static int __init davinci_soc_platform_init(void)
+static int __devinit davinci_soc_platform_probe(struct platform_device *pdev)
 {
-	return snd_soc_register_platform(&davinci_soc_platform);
+	return snd_soc_register_platform(&pdev->dev, -1, &davinci_soc_platform);
 }
-module_init(davinci_soc_platform_init);
 
-static void __exit davinci_soc_platform_exit(void)
+static int __devexit davinci_soc_platform_remove(struct platform_device *pdev)
 {
-	snd_soc_unregister_platform(&davinci_soc_platform);
+	snd_soc_unregister_platform(&pdev->dev, -1);
+	return 0;
+}
+
+static struct platform_driver davinci_pcm_driver = {
+	.driver = {
+			.name = "davinci-pcm-audio",
+			.owner = THIS_MODULE,
+	},
+
+	.probe = davinci_soc_platform_probe,
+	.remove = __devexit_p(davinci_soc_platform_remove),
+};
+
+static int __init snd_davinci_pcm_init(void)
+{
+	return platform_driver_register(&davinci_pcm_driver);
+}
+module_init(snd_davinci_pcm_init);
+
+static void __exit snd_davinci_pcm_exit(void)
+{
+	platform_driver_unregister(&davinci_pcm_driver);
 }
-module_exit(davinci_soc_platform_exit);
+module_exit(snd_davinci_pcm_exit);
 
 MODULE_AUTHOR("Vladimir Barinov");
 MODULE_DESCRIPTION("TI DAVINCI PCM DMA module");
diff --git a/sound/soc/davinci/davinci-pcm.h b/sound/soc/davinci/davinci-pcm.h
index 0764944..96ed253 100644
--- a/sound/soc/davinci/davinci-pcm.h
+++ b/sound/soc/davinci/davinci-pcm.h
@@ -28,6 +28,6 @@ struct davinci_pcm_dma_params {
 };
 
 
-extern struct snd_soc_platform davinci_soc_platform;
+extern struct snd_soc_platform_driver davinci_soc_platform;
 
 #endif
diff --git a/sound/soc/davinci/davinci-sffsdr.c b/sound/soc/davinci/davinci-sffsdr.c
index 40eccfe..0f89c88 100644
--- a/sound/soc/davinci/davinci-sffsdr.c
+++ b/sound/soc/davinci/davinci-sffsdr.c
@@ -29,7 +29,6 @@
 #include <asm/plat-sffsdr/sffsdr-fpga.h>
 #endif
 
-#include <mach/mcbsp.h>
 #include <mach/edma.h>
 
 #include "../codecs/pcm3008.h"
@@ -48,7 +47,7 @@ static int sffsdr_hw_params(struct snd_pcm_substream *substream,
 			    struct snd_pcm_hw_params *params)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
 	int fs;
 	int ret = 0;
 
@@ -85,15 +84,16 @@ static struct snd_soc_ops sffsdr_ops = {
 static struct snd_soc_dai_link sffsdr_dai = {
 	.name = "PCM3008", /* Codec name */
 	.stream_name = "PCM3008 HiFi",
-	.cpu_dai = &davinci_i2s_dai,
-	.codec_dai = &pcm3008_dai,
+	.cpu_dai_drv = &davinci_i2s_dai,
+	.codec_dai_drv = &pcm3008_dai,
+	.codec_drv = &soc_codec_dev_pcm3008,
+	.platform_drv = &davinci_soc_platform,
 	.ops = &sffsdr_ops,
 };
 
 /* davinci-sffsdr audio machine driver */
 static struct snd_soc_card snd_soc_sffsdr = {
 	.name = "DaVinci SFFSDR",
-	.platform = &davinci_soc_platform,
 	.dai_link = &sffsdr_dai,
 	.num_links = 1,
 };
@@ -106,11 +106,12 @@ static struct pcm3008_setup_data sffsdr_pcm3008_setup = {
 	.pdda_pin = GPIO(38),
 };
 
-/* sffsdr audio subsystem */
-static struct snd_soc_device sffsdr_snd_devdata = {
-	.card = &snd_soc_sffsdr,
-	.codec_dev = &soc_codec_dev_pcm3008,
-	.codec_data = &sffsdr_pcm3008_setup,
+struct platform_device pcm3008_codec = {
+		.name = "pcm3008_codec_audio",
+		.id = 0,
+		.dev = {
+				.platform_data = &sffsdr_pcm3008_setup,
+		},
 };
 
 static struct resource sffsdr_snd_resources[] = {
@@ -135,14 +136,15 @@ static int __init sffsdr_init(void)
 	if (!machine_is_sffsdr())
 		return -EINVAL;
 
+	platform_device_register(&pcm3008_codec);
+
 	sffsdr_snd_device = platform_device_alloc("soc-audio", 0);
 	if (!sffsdr_snd_device) {
 		printk(KERN_ERR "platform device allocation failed\n");
 		return -ENOMEM;
 	}
 
-	platform_set_drvdata(sffsdr_snd_device, &sffsdr_snd_devdata);
-	sffsdr_snd_devdata.dev = &sffsdr_snd_device->dev;
+	platform_set_drvdata(sffsdr_snd_device, &snd_soc_sffsdr);
 	platform_device_add_data(sffsdr_snd_device, &sffsdr_snd_data,
 				 sizeof(sffsdr_snd_data));
 
@@ -168,6 +170,7 @@ error:
 static void __exit sffsdr_exit(void)
 {
 	platform_device_unregister(sffsdr_snd_device);
+	platform_device_unregister(&pcm3008_codec);
 }
 
 module_init(sffsdr_init);
diff --git a/sound/soc/davinci/davinci-vcif.c b/sound/soc/davinci/davinci-vcif.c
index 9aa980d..9d1daef 100644
--- a/sound/soc/davinci/davinci-vcif.c
+++ b/sound/soc/davinci/davinci-vcif.c
@@ -55,7 +55,7 @@ static void davinci_vcif_start(struct snd_pcm_substream *substream)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct davinci_vcif_dev *davinci_vcif_dev =
-					rtd->dai->cpu_dai->private_data;
+			snd_soc_dai_get_drvdata(rtd->cpu_dai);
 	struct davinci_vc *davinci_vc = davinci_vcif_dev->davinci_vc;
 	u32 w;
 
@@ -74,7 +74,7 @@ static void davinci_vcif_stop(struct snd_pcm_substream *substream)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct davinci_vcif_dev *davinci_vcif_dev =
-					rtd->dai->cpu_dai->private_data;
+			snd_soc_dai_get_drvdata(rtd->cpu_dai);
 	struct davinci_vc *davinci_vc = davinci_vcif_dev->davinci_vc;
 	u32 w;
 
@@ -92,12 +92,15 @@ static int davinci_vcif_hw_params(struct snd_pcm_substream *substream,
 				  struct snd_pcm_hw_params *params,
 				  struct snd_soc_dai *dai)
 {
-	struct davinci_vcif_dev *davinci_vcif_dev = dai->private_data;
+	struct davinci_vcif_dev *davinci_vcif_dev = snd_soc_dai_get_drvdata(dai);
 	struct davinci_vc *davinci_vc = davinci_vcif_dev->davinci_vc;
 	struct davinci_pcm_dma_params *dma_params =
 			&davinci_vcif_dev->dma_params[substream->stream];
 	u32 w;
 
+	dai->capture_dma_data = davinci_vcif_dev->dma_params;
+	dai->playback_dma_data = davinci_vcif_dev->dma_params;
+
 	/* Restart the codec before setup */
 	davinci_vcif_stop(substream);
 	davinci_vcif_start(substream);
@@ -179,7 +182,7 @@ static struct snd_soc_dai_ops davinci_vcif_dai_ops = {
 	.hw_params	= davinci_vcif_hw_params,
 };
 
-struct snd_soc_dai davinci_vcif_dai = {
+struct snd_soc_dai_driver davinci_vcif_dai = {
 	.name = "davinci-vcif",
 	.playback = {
 		.channels_min = 1,
@@ -222,12 +225,9 @@ static int davinci_vcif_probe(struct platform_device *pdev)
 	davinci_vcif_dev->dma_params[SNDRV_PCM_STREAM_CAPTURE].dma_addr =
 					davinci_vc->davinci_vcif.dma_rx_addr;
 
-	davinci_vcif_dai.dev = &pdev->dev;
-	davinci_vcif_dai.capture.dma_data = davinci_vcif_dev->dma_params;
-	davinci_vcif_dai.playback.dma_data = davinci_vcif_dev->dma_params;
-	davinci_vcif_dai.private_data = davinci_vcif_dev;
+	dev_set_drvdata(&pdev->dev, davinci_vcif_dev);
 
-	ret = snd_soc_register_dai(&davinci_vcif_dai);
+	ret = snd_soc_register_dai(&pdev->dev, -1, &davinci_vcif_dai);
 	if (ret != 0) {
 		dev_err(&pdev->dev, "could not register dai\n");
 		goto fail;
@@ -243,7 +243,7 @@ fail:
 
 static int davinci_vcif_remove(struct platform_device *pdev)
 {
-	snd_soc_unregister_dai(&davinci_vcif_dai);
+	snd_soc_unregister_dai(&pdev->dev, -1);
 
 	return 0;
 }
diff --git a/sound/soc/davinci/davinci-vcif.h b/sound/soc/davinci/davinci-vcif.h
index 571c994..9627b7e 100644
--- a/sound/soc/davinci/davinci-vcif.h
+++ b/sound/soc/davinci/davinci-vcif.h
@@ -23,6 +23,6 @@
 #ifndef _DAVINCI_VCIF_H
 #define _DAVINCI_VCIF_H
 
-extern struct snd_soc_dai davinci_vcif_dai;
+extern struct snd_soc_dai_driver davinci_vcif_dai;
 
 #endif
-- 
1.7.0.4
