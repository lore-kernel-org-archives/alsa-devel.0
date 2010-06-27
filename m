From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: [RFC 05/15] ASoC: multi-component - Freescale i.MX
	Platform
Date: Sun, 27 Jun 2010 12:52:04 +0100
Message-ID: <1277639534-5104-6-git-send-email-lrg@slimlogic.co.uk>
References: <1277639534-5104-1-git-send-email-lrg@slimlogic.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id A7DB7103892
	for <alsa-devel@alsa-project.org>;
	Sun, 27 Jun 2010 13:52:37 +0200 (CEST)
Received: by mail-wy0-f179.google.com with SMTP id 23so919297wyf.38
	for <alsa-devel@alsa-project.org>; Sun, 27 Jun 2010 04:52:37 -0700 (PDT)
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

Update the Freescale i.MX platform and machines to new multi-component model.

This patch changes the machine drivers for multi-component as follows :-

 o Removed socdev
 o Each DAI link entry now contains platform and codec fields.
 o DAI link init() now passed snd_soc_pcm_runtime instread of snd_soc_codec.

This patch also changes the DAI and platform DAM drivers as follows :-

 o Each platform DAI and platform DMA driver is a kernel device and can
   have platform data.
 o DAI and Platform DMA drivers have private data accessors.

Other notable changes required for multi-component support:-

 o Decoupled platform DMA, DAI and FIQ drivers.

Signed-off-by: Liam Girdwood <lrg@slimlogic.co.uk>
---
 sound/soc/imx/Kconfig           |    7 +++
 sound/soc/imx/Makefile          |   10 ++--
 sound/soc/imx/imx-pcm-dma-mx2.c |   43 ++++++++++++---
 sound/soc/imx/imx-pcm-fiq.c     |   82 ++++++++++++++++++++---------
 sound/soc/imx/imx-ssi.c         |  109 +++++++++++++-------------------------
 sound/soc/imx/imx-ssi.h         |    8 ++-
 sound/soc/imx/phycore-ac97.c    |   17 ++----
 sound/soc/imx/wm1133-ev1.c      |   27 ++++------
 8 files changed, 161 insertions(+), 142 deletions(-)

diff --git a/sound/soc/imx/Kconfig b/sound/soc/imx/Kconfig
index 6ef57e0..51b7dff 100644
--- a/sound/soc/imx/Kconfig
+++ b/sound/soc/imx/Kconfig
@@ -10,12 +10,19 @@ config SND_IMX_SOC
 
 config SND_MXC_SOC_SSI
 	tristate
+	
+config SND_MXC_SOC_FIQ
+	tristate
+
+config SND_MXC_SOC_MX2
+	tristate
 
 config SND_MXC_SOC_WM1133_EV1
 	tristate "Audio on the the i.MX31ADS with WM1133-EV1 fitted"
 	depends on SND_IMX_SOC && MACH_MX31ADS_WM1133_EV1 && EXPERIMENTAL
 	select SND_SOC_WM8350
 	select SND_MXC_SOC_SSI
+	select SND_MXC_SOC_FIQ
 	help
 	  Enable support for audio on the i.MX31ADS with the WM1133-EV1
 	  PMIC board with WM8835x fitted.
diff --git a/sound/soc/imx/Makefile b/sound/soc/imx/Makefile
index 7bc57ba..b67fc02 100644
--- a/sound/soc/imx/Makefile
+++ b/sound/soc/imx/Makefile
@@ -1,11 +1,11 @@
 # i.MX Platform Support
-snd-soc-imx-objs := imx-ssi.o imx-pcm-fiq.o
-
-ifdef CONFIG_MACH_MX27
-snd-soc-imx-objs += imx-pcm-dma-mx2.o
-endif
+snd-soc-imx-objs := imx-ssi.o
+snd-soc-imx-fiq-objs := imx-pcm-fiq.o
+snd-soc-imx-mx2-objs := imx-pcm-dma-mx2.o
 
 obj-$(CONFIG_SND_IMX_SOC) += snd-soc-imx.o
+obj-$(CONFIG_SND_MXC_SOC_FIQ) += snd-soc-imx-fiq.o
+obj-$(CONFIG_SND_MXC_SOC_MX2) += snd-soc-imx-mx2.o
 
 # i.MX Machine Support
 snd-soc-eukrea-tlv320-objs := eukrea-tlv320.o
diff --git a/sound/soc/imx/imx-pcm-dma-mx2.c b/sound/soc/imx/imx-pcm-dma-mx2.c
index 05f19c9..8d6a793 100644
--- a/sound/soc/imx/imx-pcm-dma-mx2.c
+++ b/sound/soc/imx/imx-pcm-dma-mx2.c
@@ -103,7 +103,7 @@ static int imx_ssi_dma_alloc(struct snd_pcm_substream *substream)
 	struct imx_pcm_runtime_data *iprtd = runtime->private_data;
 	int ret;
 
-	dma_params = snd_soc_dai_get_dma_data(rtd->dai->cpu_dai, substream);
+	dma_params = snd_soc_dai_get_dma_data(rtd->cpu_dai, substream);
 
 	iprtd->dma = imx_dma_request_by_prio(DRV_NAME, DMA_PRIO_HIGH);
 	if (iprtd->dma < 0) {
@@ -213,7 +213,7 @@ static int snd_imx_pcm_prepare(struct snd_pcm_substream *substream)
 	struct imx_pcm_runtime_data *iprtd = runtime->private_data;
 	int err;
 
-	dma_params = snd_soc_dai_get_dma_data(rtd->dai->cpu_dai, substream);
+	dma_params = snd_soc_dai_get_dma_data(rtd->cpu_dai, substream);
 
 	iprtd->substream = substream;
 	iprtd->buf = (unsigned int *)substream->dma_buffer.area;
@@ -314,19 +314,44 @@ static struct snd_pcm_ops imx_pcm_ops = {
 	.mmap		= snd_imx_pcm_mmap,
 };
 
-static struct snd_soc_platform imx_soc_platform_dma = {
+struct snd_soc_platform_driver imx_soc_platform_mx2 = {
 	.name		= "imx-audio",
-	.pcm_ops 	= &imx_pcm_ops,
+	.ops 		= &imx_pcm_ops,
 	.pcm_new	= imx_pcm_new,
 	.pcm_free	= imx_pcm_free,
 };
+EXPORT_SYMBOL_GPL(imx_soc_platform_mx2);
 
-struct snd_soc_platform *imx_ssi_dma_mx2_init(struct platform_device *pdev,
-		struct imx_ssi *ssi)
+static int __devinit imx_soc_platform_probe(struct platform_device *pdev)
 {
-	ssi->dma_params_tx.burstsize = DMA_TXFIFO_BURST;
-	ssi->dma_params_rx.burstsize = DMA_RXFIFO_BURST;
+	return snd_soc_register_platform(&pdev->dev, -1, &imx_soc_platform_mx2);
+}
+
+static int __devexit imx_soc_platform_remove(struct platform_device *pdev)
+{
+	snd_soc_unregister_platform(&pdev->dev, -1);
+	return 0;
+}
+
+static struct platform_driver imx_pcm_driver = {
+	.driver = {
+			.name = "imx-pcm-audio",
+			.owner = THIS_MODULE,
+	},
 
-	return &imx_soc_platform_dma;
+	.probe = imx_soc_platform_probe,
+	.remove = __devexit_p(imx_soc_platform_remove),
+};
+
+static int __init snd_imx_pcm_init(void)
+{
+	return platform_driver_register(&imx_pcm_driver);
+}
+module_init(snd_imx_pcm_init);
+
+static void __exit snd_imx_pcm_exit(void)
+{
+	platform_driver_unregister(&imx_pcm_driver);
 }
+module_exit(snd_imx_pcm_exit);
 
diff --git a/sound/soc/imx/imx-pcm-fiq.c b/sound/soc/imx/imx-pcm-fiq.c
index 6b518e0..50e3076 100644
--- a/sound/soc/imx/imx-pcm-fiq.c
+++ b/sound/soc/imx/imx-pcm-fiq.c
@@ -232,16 +232,25 @@ static struct snd_pcm_ops imx_pcm_ops = {
 	.mmap		= snd_imx_pcm_mmap,
 };
 
+static int ssi_irq = 0;
+
 static int imx_pcm_fiq_new(struct snd_card *card, struct snd_soc_dai *dai,
 	struct snd_pcm *pcm)
 {
+	struct imx_ssi *ssi = snd_soc_dai_get_drvdata(dai);
 	int ret;
 
+	ret = claim_fiq(&fh);
+	if (ret) {
+		dev_err(dai->dev, "failed to claim fiq: %d", ret);
+		return ret;
+	}
+
 	ret = imx_pcm_new(card, dai, pcm);
 	if (ret)
 		return ret;
 
-	if (dai->playback.channels_min) {
+	if (dai->driver->playback.channels_min) {
 		struct snd_pcm_substream *substream =
 			pcm->streams[SNDRV_PCM_STREAM_PLAYBACK].substream;
 		struct snd_dma_buffer *buf = &substream->dma_buffer;
@@ -249,7 +258,7 @@ static int imx_pcm_fiq_new(struct snd_card *card, struct snd_soc_dai *dai,
 		imx_ssi_fiq_tx_buffer = (unsigned long)buf->area;
 	}
 
-	if (dai->capture.channels_min) {
+	if (dai->driver->capture.channels_min) {
 		struct snd_pcm_substream *substream =
 			pcm->streams[SNDRV_PCM_STREAM_CAPTURE].substream;
 		struct snd_dma_buffer *buf = &substream->dma_buffer;
@@ -257,45 +266,66 @@ static int imx_pcm_fiq_new(struct snd_card *card, struct snd_soc_dai *dai,
 		imx_ssi_fiq_rx_buffer = (unsigned long)buf->area;
 	}
 
+	mxc_set_irq_fiq(ssi->irq, 1);
+	ssi_irq = ssi->irq;
+
+	imx_pcm_fiq = ssi->irq;
+
+	imx_ssi_fiq_base = (unsigned long)ssi->base;
+
+	ssi->dma_params_tx.burstsize = 4;
+	ssi->dma_params_rx.burstsize = 6;
+
+
 	set_fiq_handler(&imx_ssi_fiq_start,
 		&imx_ssi_fiq_end - &imx_ssi_fiq_start);
 
 	return 0;
 }
 
-static struct snd_soc_platform imx_soc_platform_fiq = {
-	.pcm_ops 	= &imx_pcm_ops,
+static void imx_pcm_fiq_free(struct snd_pcm *pcm)
+{
+	mxc_set_irq_fiq(ssi_irq, 0);
+	release_fiq(&fh);
+	imx_pcm_free(pcm);
+}
+
+struct snd_soc_platform_driver imx_soc_platform_fiq = {
+	.ops 		= &imx_pcm_ops,
 	.pcm_new	= imx_pcm_fiq_new,
-	.pcm_free	= imx_pcm_free,
+	.pcm_free	= imx_pcm_fiq_free,
 };
+EXPORT_SYMBOL_GPL(imx_soc_platform_fiq);
 
-struct snd_soc_platform *imx_ssi_fiq_init(struct platform_device *pdev,
-		struct imx_ssi *ssi)
+static int __devinit imx_soc_platform_probe(struct platform_device *pdev)
 {
-	int ret = 0;
-
-	ret = claim_fiq(&fh);
-	if (ret) {
-		dev_err(&pdev->dev, "failed to claim fiq: %d", ret);
-		return ERR_PTR(ret);
-	}
-
-	mxc_set_irq_fiq(ssi->irq, 1);
+	return snd_soc_register_platform(&pdev->dev, -1, &imx_soc_platform_fiq);
+}
 
-	imx_pcm_fiq = ssi->irq;
+static int __devexit imx_soc_platform_remove(struct platform_device *pdev)
+{
+	snd_soc_unregister_platform(&pdev->dev, -1);
+	return 0;
+}
 
-	imx_ssi_fiq_base = (unsigned long)ssi->base;
+static struct platform_driver imx_pcm_driver = {
+	.driver = {
+			.name = "imx-fiq-pcm-audio",
+			.owner = THIS_MODULE,
+	},
 
-	ssi->dma_params_tx.burstsize = 4;
-	ssi->dma_params_rx.burstsize = 6;
+	.probe = imx_soc_platform_probe,
+	.remove = __devexit_p(imx_soc_platform_remove),
+};
 
-	return &imx_soc_platform_fiq;
+static int __init snd_imx_pcm_init(void)
+{
+	return platform_driver_register(&imx_pcm_driver);
 }
+module_init(snd_imx_pcm_init);
 
-void imx_ssi_fiq_exit(struct platform_device *pdev,
-		struct imx_ssi *ssi)
+static void __exit snd_imx_pcm_exit(void)
 {
-	mxc_set_irq_fiq(ssi->irq, 0);
-	release_fiq(&fh);
+	platform_driver_unregister(&imx_pcm_driver);
 }
-
+module_exit(snd_imx_pcm_exit);
diff --git a/sound/soc/imx/imx-ssi.c b/sound/soc/imx/imx-ssi.c
index 50f5162..8f7fb4a 100644
--- a/sound/soc/imx/imx-ssi.c
+++ b/sound/soc/imx/imx-ssi.c
@@ -61,7 +61,7 @@
 static int imx_ssi_set_dai_tdm_slot(struct snd_soc_dai *cpu_dai,
 	unsigned int tx_mask, unsigned int rx_mask, int slots, int slot_width)
 {
-	struct imx_ssi *ssi = cpu_dai->private_data;
+	struct imx_ssi *ssi = snd_soc_dai_get_drvdata(cpu_dai);
 	u32 sccr;
 
 	sccr = readl(ssi->base + SSI_STCCR);
@@ -86,7 +86,7 @@ static int imx_ssi_set_dai_tdm_slot(struct snd_soc_dai *cpu_dai,
  */
 static int imx_ssi_set_dai_fmt(struct snd_soc_dai *cpu_dai, unsigned int fmt)
 {
-	struct imx_ssi *ssi = cpu_dai->private_data;
+	struct imx_ssi *ssi = snd_soc_dai_get_drvdata(cpu_dai);
 	u32 strcr = 0, scr;
 
 	scr = readl(ssi->base + SSI_SCR) & ~(SSI_SCR_SYN | SSI_SCR_NET);
@@ -164,7 +164,7 @@ static int imx_ssi_set_dai_fmt(struct snd_soc_dai *cpu_dai, unsigned int fmt)
 static int imx_ssi_set_dai_sysclk(struct snd_soc_dai *cpu_dai,
 				  int clk_id, unsigned int freq, int dir)
 {
-	struct imx_ssi *ssi = cpu_dai->private_data;
+	struct imx_ssi *ssi = snd_soc_dai_get_drvdata(cpu_dai);
 	u32 scr;
 
 	scr = readl(ssi->base + SSI_SCR);
@@ -192,7 +192,7 @@ static int imx_ssi_set_dai_sysclk(struct snd_soc_dai *cpu_dai,
 static int imx_ssi_set_dai_clkdiv(struct snd_soc_dai *cpu_dai,
 				  int div_id, int div)
 {
-	struct imx_ssi *ssi = cpu_dai->private_data;
+	struct imx_ssi *ssi = snd_soc_dai_get_drvdata(cpu_dai);
 	u32 stccr, srccr;
 
 	stccr = readl(ssi->base + SSI_STCCR);
@@ -241,7 +241,7 @@ static int imx_ssi_hw_params(struct snd_pcm_substream *substream,
 			     struct snd_pcm_hw_params *params,
 			     struct snd_soc_dai *cpu_dai)
 {
-	struct imx_ssi *ssi = cpu_dai->private_data;
+	struct imx_ssi *ssi = snd_soc_dai_get_drvdata(cpu_dai);
 	struct imx_pcm_dma_params *dma_data;
 	u32 reg, sccr;
 
@@ -279,9 +279,7 @@ static int imx_ssi_hw_params(struct snd_pcm_substream *substream,
 static int imx_ssi_trigger(struct snd_pcm_substream *substream, int cmd,
 		struct snd_soc_dai *dai)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
-	struct imx_ssi *ssi = cpu_dai->private_data;
+	struct imx_ssi *ssi = snd_soc_dai_get_drvdata(dai);
 	unsigned int sier_bits, sier;
 	unsigned int scr;
 
@@ -350,22 +348,6 @@ static struct snd_soc_dai_ops imx_ssi_pcm_dai_ops = {
 	.trigger	= imx_ssi_trigger,
 };
 
-static struct snd_soc_dai imx_ssi_dai = {
-	.playback = {
-		.channels_min = 2,
-		.channels_max = 2,
-		.rates = SNDRV_PCM_RATE_8000_96000,
-		.formats = SNDRV_PCM_FMTBIT_S16_LE,
-	},
-	.capture = {
-		.channels_min = 2,
-		.channels_max = 2,
-		.rates = SNDRV_PCM_RATE_8000_96000,
-		.formats = SNDRV_PCM_FMTBIT_S16_LE,
-	},
-	.ops = &imx_ssi_pcm_dai_ops,
-};
-
 int snd_imx_pcm_mmap(struct snd_pcm_substream *substream,
 		struct vm_area_struct *vma)
 {
@@ -381,6 +363,7 @@ int snd_imx_pcm_mmap(struct snd_pcm_substream *substream,
 			runtime->dma_bytes);
 	return ret;
 }
+EXPORT_SYMBOL_GPL(snd_imx_pcm_mmap);
 
 static int imx_pcm_preallocate_dma_buffer(struct snd_pcm *pcm, int stream)
 {
@@ -412,14 +395,14 @@ int imx_pcm_new(struct snd_card *card, struct snd_soc_dai *dai,
 		card->dev->dma_mask = &imx_pcm_dmamask;
 	if (!card->dev->coherent_dma_mask)
 		card->dev->coherent_dma_mask = DMA_BIT_MASK(32);
-	if (dai->playback.channels_min) {
+	if (dai->driver->playback.channels_min) {
 		ret = imx_pcm_preallocate_dma_buffer(pcm,
 			SNDRV_PCM_STREAM_PLAYBACK);
 		if (ret)
 			goto out;
 	}
 
-	if (dai->capture.channels_min) {
+	if (dai->driver->capture.channels_min) {
 		ret = imx_pcm_preallocate_dma_buffer(pcm,
 			SNDRV_PCM_STREAM_CAPTURE);
 		if (ret)
@@ -429,6 +412,7 @@ int imx_pcm_new(struct snd_card *card, struct snd_soc_dai *dai,
 out:
 	return ret;
 }
+EXPORT_SYMBOL_GPL(imx_pcm_new);
 
 void imx_pcm_free(struct snd_pcm *pcm)
 {
@@ -450,13 +434,26 @@ void imx_pcm_free(struct snd_pcm *pcm)
 		buf->area = NULL;
 	}
 }
+EXPORT_SYMBOL_GPL(imx_pcm_free);
 
-struct snd_soc_platform imx_soc_platform = {
-	.name		= "imx-audio",
+struct snd_soc_dai_driver imx_ssi_dai = {
+	.playback = {
+		.channels_min = 2,
+		.channels_max = 2,
+		.rates = SNDRV_PCM_RATE_8000_96000,
+		.formats = SNDRV_PCM_FMTBIT_S16_LE,
+	},
+	.capture = {
+		.channels_min = 2,
+		.channels_max = 2,
+		.rates = SNDRV_PCM_RATE_8000_96000,
+		.formats = SNDRV_PCM_FMTBIT_S16_LE,
+	},
+	.ops = &imx_ssi_pcm_dai_ops,
 };
-EXPORT_SYMBOL_GPL(imx_soc_platform);
+EXPORT_SYMBOL_GPL(imx_ssi_dai);
 
-static struct snd_soc_dai imx_ac97_dai = {
+struct snd_soc_dai_driver imx_ac97_dai = {
 	.name = "AC97",
 	.ac97_control = 1,
 	.playback = {
@@ -475,6 +472,7 @@ static struct snd_soc_dai imx_ac97_dai = {
 	},
 	.ops = &imx_ssi_pcm_dai_ops,
 };
+EXPORT_SYMBOL_GPL(imx_ac97_dai);
 
 static void setup_channel_to_ac97(struct imx_ssi *imx_ssi)
 {
@@ -577,7 +575,7 @@ struct snd_ac97_bus_ops soc_ac97_ops = {
 };
 EXPORT_SYMBOL_GPL(soc_ac97_ops);
 
-struct snd_soc_dai imx_ssi_pcm_dai[2];
+struct snd_soc_dai_driver imx_ssi_pcm_dai[2];
 EXPORT_SYMBOL_GPL(imx_ssi_pcm_dai);
 
 static int imx_ssi_probe(struct platform_device *pdev)
@@ -585,17 +583,14 @@ static int imx_ssi_probe(struct platform_device *pdev)
 	struct resource *res;
 	struct imx_ssi *ssi;
 	struct imx_ssi_platform_data *pdata = pdev->dev.platform_data;
-	struct snd_soc_platform *platform;
 	int ret = 0;
 	unsigned int val;
-	struct snd_soc_dai *dai = &imx_ssi_pcm_dai[pdev->id];
-
-	if (dai->id >= ARRAY_SIZE(imx_ssi_pcm_dai))
-		return -EINVAL;
+	struct snd_soc_dai_driver *dai;
 
 	ssi = kzalloc(sizeof(*ssi), GFP_KERNEL);
 	if (!ssi)
 		return -ENOMEM;
+	dev_set_drvdata(&pdev->dev, ssi);
 
 	if (pdata) {
 		ssi->ac97_reset = pdata->ac97_reset;
@@ -640,9 +635,9 @@ static int imx_ssi_probe(struct platform_device *pdev)
 		}
 		ac97_ssi = ssi;
 		setup_channel_to_ac97(ssi);
-		memcpy(dai, &imx_ac97_dai, sizeof(imx_ac97_dai));
+		dai = &imx_ac97_dai;
 	} else
-		memcpy(dai, &imx_ssi_dai, sizeof(imx_ssi_dai));
+		dai = &imx_ssi_dai;
 
 	writel(0x0, ssi->base + SSI_SIER);
 
@@ -657,28 +652,17 @@ static int imx_ssi_probe(struct platform_device *pdev)
 	if (res)
 		ssi->dma_params_rx.dma = res->start;
 
-	dai->id = pdev->id;
-	dai->dev = &pdev->dev;
-	dai->name = kasprintf(GFP_KERNEL, "imx-ssi.%d", pdev->id);
-	dai->private_data = ssi;
-
 	if ((cpu_is_mx27() || cpu_is_mx21()) &&
 			!(ssi->flags & IMX_SSI_USE_AC97) &&
 			(ssi->flags & IMX_SSI_DMA)) {
 		ssi->flags |= IMX_SSI_DMA;
-		platform = imx_ssi_dma_mx2_init(pdev, ssi);
-	} else
-		platform = imx_ssi_fiq_init(pdev, ssi);
-
-	imx_soc_platform.pcm_ops = platform->pcm_ops;
-	imx_soc_platform.pcm_new = platform->pcm_new;
-	imx_soc_platform.pcm_free = platform->pcm_free;
+	}
 
 	val = SSI_SFCSR_TFWM0(ssi->dma_params_tx.burstsize) |
 		SSI_SFCSR_RFWM0(ssi->dma_params_rx.burstsize);
 	writel(val, ssi->base + SSI_SFCSR);
 
-	ret = snd_soc_register_dai(dai);
+	ret = snd_soc_register_dai(&pdev->dev, pdev->id, dai);
 	if (ret) {
 		dev_err(&pdev->dev, "register DAI failed\n");
 		goto failed_register;
@@ -706,16 +690,12 @@ static int __devexit imx_ssi_remove(struct platform_device *pdev)
 {
 	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	struct imx_ssi *ssi = platform_get_drvdata(pdev);
-	struct snd_soc_dai *dai = &imx_ssi_pcm_dai[pdev->id];
 
-	snd_soc_unregister_dai(dai);
+	snd_soc_unregister_dai(&pdev->dev, pdev->id);
 
 	if (ssi->flags & IMX_SSI_USE_AC97)
 		ac97_ssi = NULL;
 
-	if (!(ssi->flags & IMX_SSI_DMA))
-		imx_ssi_fiq_exit(pdev, ssi);
-
 	iounmap(ssi->base);
 	release_mem_region(res->start, resource_size(res));
 	clk_disable(ssi->clk);
@@ -737,27 +717,12 @@ static struct platform_driver imx_ssi_driver = {
 
 static int __init imx_ssi_init(void)
 {
-	int ret;
-
-	ret = snd_soc_register_platform(&imx_soc_platform);
-	if (ret) {
-		pr_err("failed to register soc platform: %d\n", ret);
-		return ret;
-	}
-
-	ret = platform_driver_register(&imx_ssi_driver);
-	if (ret) {
-		snd_soc_unregister_platform(&imx_soc_platform);
-		return ret;
-	}
-
-	return 0;
+	return platform_driver_register(&imx_ssi_driver);
 }
 
 static void __exit imx_ssi_exit(void)
 {
 	platform_driver_unregister(&imx_ssi_driver);
-	snd_soc_unregister_platform(&imx_soc_platform);
 }
 
 module_init(imx_ssi_init);
diff --git a/sound/soc/imx/imx-ssi.h b/sound/soc/imx/imx-ssi.h
index 55f26eb..cd3c8a9 100644
--- a/sound/soc/imx/imx-ssi.h
+++ b/sound/soc/imx/imx-ssi.h
@@ -183,8 +183,10 @@
 #define IMX_SSI_RX_DIV_PSR	4
 #define IMX_SSI_RX_DIV_PM	5
 
-extern struct snd_soc_dai imx_ssi_pcm_dai[2];
-extern struct snd_soc_platform imx_soc_platform;
+extern struct snd_soc_dai_driver imx_ssi_dai;
+extern struct snd_soc_dai_driver imx_ac97_dai;
+extern struct snd_soc_platform_driver imx_soc_platform_mx2;
+extern struct snd_soc_platform_driver imx_soc_platform_fiq;
 
 #define DRV_NAME "imx-ssi"
 
@@ -197,7 +199,7 @@ struct imx_pcm_dma_params {
 struct imx_ssi {
 	struct platform_device *ac97_dev;
 
-	struct snd_soc_device imx_ac97;
+	struct snd_soc_dai *imx_ac97;
 	struct clk *clk;
 	void __iomem *base;
 	int irq;
diff --git a/sound/soc/imx/phycore-ac97.c b/sound/soc/imx/phycore-ac97.c
index a8307d5..1e2daed 100644
--- a/sound/soc/imx/phycore-ac97.c
+++ b/sound/soc/imx/phycore-ac97.c
@@ -32,23 +32,21 @@ static struct snd_soc_dai_link imx_phycore_dai_ac97[] = {
 	{
 		.name		= "HiFi",
 		.stream_name	= "HiFi",
-		.codec_dai	= &wm9712_dai[WM9712_DAI_AC97_HIFI],
+		.codec_dai_drv 	= &wm9712_dai[WM9712_DAI_AC97_HIFI],
+		.codec_dai_id 	= WM9712_DAI_AC97_HIFI,
+		.codec_drv	= &soc_codec_dev_wm9712,
+		.cpu_dai_drv 	= &imx_ac97_dai,
+		.platform_drv	= &imx_soc_platform,
 		.ops		= &imx_phycore_hifi_ops,
 	},
 };
 
 static struct snd_soc_card imx_phycore = {
 	.name		= "PhyCORE-audio",
-	.platform	= &imx_soc_platform,
 	.dai_link	= imx_phycore_dai_ac97,
 	.num_links	= ARRAY_SIZE(imx_phycore_dai_ac97),
 };
 
-static struct snd_soc_device imx_phycore_snd_devdata = {
-	.card		= &imx_phycore,
-	.codec_dev	= &soc_codec_dev_wm9712,
-};
-
 static struct platform_device *imx_phycore_snd_device;
 
 static int __init imx_phycore_init(void)
@@ -63,10 +61,7 @@ static int __init imx_phycore_init(void)
 	if (!imx_phycore_snd_device)
 		return -ENOMEM;
 
-	imx_phycore_dai_ac97[0].cpu_dai = &imx_ssi_pcm_dai[0];
-
-	platform_set_drvdata(imx_phycore_snd_device, &imx_phycore_snd_devdata);
-	imx_phycore_snd_devdata.dev = &imx_phycore_snd_device->dev;
+	platform_set_drvdata(imx_phycore_snd_device, &imx_phycore);
 	ret = platform_device_add(imx_phycore_snd_device);
 
 	if (ret) {
diff --git a/sound/soc/imx/wm1133-ev1.c b/sound/soc/imx/wm1133-ev1.c
index a6e7d94..146ab83 100644
--- a/sound/soc/imx/wm1133-ev1.c
+++ b/sound/soc/imx/wm1133-ev1.c
@@ -82,8 +82,8 @@ static int wm1133_ev1_hw_params(struct snd_pcm_substream *substream,
 				struct snd_pcm_hw_params *params)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
-	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
 	int i, found = 0;
 	snd_pcm_format_t format = params_format(params);
 	unsigned int rate = params_rate(params);
@@ -210,9 +210,9 @@ static struct snd_soc_jack_pin mic_jack_pins[] = {
 	{ .pin = "Mic2 Jack", .mask = SND_JACK_MICROPHONE },
 };
 
-static int wm1133_ev1_init(struct snd_soc_codec *codec)
+static int wm1133_ev1_init(struct snd_soc_pcm_runtime *rtd)
 {
-	struct snd_soc_card *card = codec->socdev->card;
+	struct snd_soc_codec *codec = rtd->codec;
 
 	snd_soc_dapm_new_controls(codec, wm1133_ev1_widgets,
 				  ARRAY_SIZE(wm1133_ev1_widgets));
@@ -221,13 +221,13 @@ static int wm1133_ev1_init(struct snd_soc_codec *codec)
 				ARRAY_SIZE(wm1133_ev1_map));
 
 	/* Headphone jack detection */
-	snd_soc_jack_new(card, "Headphone", SND_JACK_HEADPHONE, &hp_jack);
+	snd_soc_jack_new(codec, "Headphone", SND_JACK_HEADPHONE, &hp_jack);
 	snd_soc_jack_add_pins(&hp_jack, ARRAY_SIZE(hp_jack_pins),
 			      hp_jack_pins);
 	wm8350_hp_jack_detect(codec, WM8350_JDR, &hp_jack, SND_JACK_HEADPHONE);
 
 	/* Microphone jack detection */
-	snd_soc_jack_new(card, "Microphone",
+	snd_soc_jack_new(codec, "Microphone",
 			 SND_JACK_MICROPHONE | SND_JACK_BTN_0, &mic_jack);
 	snd_soc_jack_add_pins(&mic_jack, ARRAY_SIZE(mic_jack_pins),
 			      mic_jack_pins);
@@ -243,8 +243,10 @@ static int wm1133_ev1_init(struct snd_soc_codec *codec)
 static struct snd_soc_dai_link wm1133_ev1_dai = {
 	.name = "WM1133-EV1",
 	.stream_name = "Audio",
-	.cpu_dai = &imx_ssi_pcm_dai[0],
-	.codec_dai = &wm8350_dai,
+	.cpu_dai_drv = &imx_ssi_dai,
+	.codec_dai_drv = &wm8350_dai,
+	.platform_drv = &imx_soc_platform_fiq,
+	.codec_drv = &soc_codec_dev_wm8350,
 	.init = wm1133_ev1_init,
 	.ops = &wm1133_ev1_ops,
 	.symmetric_rates = 1,
@@ -252,16 +254,10 @@ static struct snd_soc_dai_link wm1133_ev1_dai = {
 
 static struct snd_soc_card wm1133_ev1 = {
 	.name = "WM1133-EV1",
-	.platform = &imx_soc_platform,
 	.dai_link = &wm1133_ev1_dai,
 	.num_links = 1,
 };
 
-static struct snd_soc_device wm1133_ev1_snd_devdata = {
-	.card = &wm1133_ev1,
-	.codec_dev = &soc_codec_dev_wm8350,
-};
-
 static struct platform_device *wm1133_ev1_snd_device;
 
 static int __init wm1133_ev1_audio_init(void)
@@ -286,8 +282,7 @@ static int __init wm1133_ev1_audio_init(void)
 	if (!wm1133_ev1_snd_device)
 		return -ENOMEM;
 
-	platform_set_drvdata(wm1133_ev1_snd_device, &wm1133_ev1_snd_devdata);
-	wm1133_ev1_snd_devdata.dev = &wm1133_ev1_snd_device->dev;
+	platform_set_drvdata(wm1133_ev1_snd_device, &wm1133_ev1);
 	ret = platform_device_add(wm1133_ev1_snd_device);
 
 	if (ret)
-- 
1.7.0.4
