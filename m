From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: [RFC 06/15] ASoC: multi-component - Toshiba Txx9
	Platform
Date: Sun, 27 Jun 2010 12:52:05 +0100
Message-ID: <1277639534-5104-7-git-send-email-lrg@slimlogic.co.uk>
References: <1277639534-5104-1-git-send-email-lrg@slimlogic.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id DC9341038A0
	for <alsa-devel@alsa-project.org>;
	Sun, 27 Jun 2010 13:52:38 +0200 (CEST)
Received: by mail-wy0-f179.google.com with SMTP id 23so919297wyf.38
	for <alsa-devel@alsa-project.org>; Sun, 27 Jun 2010 04:52:38 -0700 (PDT)
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

Update the Toshiba Txx9 platform and machines to new multi-component model.

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

Signed-off-by: Liam Girdwood <lrg@slimlogic.co.uk>
---
 sound/soc/txx9/txx9aclc-ac97.c    |   53 +++++---------
 sound/soc/txx9/txx9aclc-generic.c |   23 ++----
 sound/soc/txx9/txx9aclc.c         |  143 +++++++++++++++++++++----------------
 sound/soc/txx9/txx9aclc.h         |   14 +---
 4 files changed, 113 insertions(+), 120 deletions(-)

diff --git a/sound/soc/txx9/txx9aclc-ac97.c b/sound/soc/txx9/txx9aclc-ac97.c
index 0ec20b6..4929466 100644
--- a/sound/soc/txx9/txx9aclc-ac97.c
+++ b/sound/soc/txx9/txx9aclc-ac97.c
@@ -36,13 +36,11 @@
 
 static DECLARE_WAIT_QUEUE_HEAD(ac97_waitq);
 
-/* REVISIT: How to find txx9aclc_soc_device from snd_ac97? */
-static struct txx9aclc_soc_device *txx9aclc_soc_dev;
+/* REVISIT: How to find txx9aclc_drvdata from snd_ac97? */
+static struct txx9aclc_plat_drvdata *txx9aclc_drvdata;
 
-static int txx9aclc_regready(struct txx9aclc_soc_device *dev)
+static int txx9aclc_regready(struct txx9aclc_plat_drvdata *drvdata)
 {
-	struct txx9aclc_plat_drvdata *drvdata = txx9aclc_get_plat_drvdata(dev);
-
 	return __raw_readl(drvdata->base + ACINTSTS) & ACINT_REGACCRDY;
 }
 
@@ -50,8 +48,7 @@ static int txx9aclc_regready(struct txx9aclc_soc_device *dev)
 static unsigned short txx9aclc_ac97_read(struct snd_ac97 *ac97,
 					 unsigned short reg)
 {
-	struct txx9aclc_soc_device *dev = txx9aclc_soc_dev;
-	struct txx9aclc_plat_drvdata *drvdata = txx9aclc_get_plat_drvdata(dev);
+	struct txx9aclc_plat_drvdata *drvdata = txx9aclc_drvdata;
 	void __iomem *base = drvdata->base;
 	u32 dat;
 
@@ -61,15 +58,15 @@ static unsigned short txx9aclc_ac97_read(struct snd_ac97 *ac97,
 	dat = (reg << ACREGACC_REG_SHIFT) | ACREGACC_READ;
 	__raw_writel(dat, base + ACREGACC);
 	__raw_writel(ACINT_REGACCRDY, base + ACINTEN);
-	if (!wait_event_timeout(ac97_waitq, txx9aclc_regready(dev), HZ)) {
+	if (!wait_event_timeout(ac97_waitq, txx9aclc_regready(txx9aclc_drvdata), HZ)) {
 		__raw_writel(ACINT_REGACCRDY, base + ACINTDIS);
-		dev_err(dev->soc_dev.dev, "ac97 read timeout (reg %#x)\n", reg);
+		printk(KERN_ERR "ac97 read timeout (reg %#x)\n", reg);
 		dat = 0xffff;
 		goto done;
 	}
 	dat = __raw_readl(base + ACREGACC);
 	if (((dat >> ACREGACC_REG_SHIFT) & 0xff) != reg) {
-		dev_err(dev->soc_dev.dev, "reg mismatch %x with %x\n",
+		printk(KERN_ERR "reg mismatch %x with %x\n",
 			dat, reg);
 		dat = 0xffff;
 		goto done;
@@ -84,16 +81,15 @@ done:
 static void txx9aclc_ac97_write(struct snd_ac97 *ac97, unsigned short reg,
 				unsigned short val)
 {
-	struct txx9aclc_soc_device *dev = txx9aclc_soc_dev;
-	struct txx9aclc_plat_drvdata *drvdata = txx9aclc_get_plat_drvdata(dev);
+	struct txx9aclc_plat_drvdata *drvdata = txx9aclc_drvdata;
 	void __iomem *base = drvdata->base;
 
 	__raw_writel(((reg | (ac97->num << 7)) << ACREGACC_REG_SHIFT) |
 		     (val << ACREGACC_DAT_SHIFT),
 		     base + ACREGACC);
 	__raw_writel(ACINT_REGACCRDY, base + ACINTEN);
-	if (!wait_event_timeout(ac97_waitq, txx9aclc_regready(dev), HZ)) {
-		dev_err(dev->soc_dev.dev,
+	if (!wait_event_timeout(ac97_waitq, txx9aclc_regready(txx9aclc_drvdata), HZ)) {
+		printk(KERN_ERR
 			"ac97 write timeout (reg %#x)\n", reg);
 	}
 	__raw_writel(ACINT_REGACCRDY, base + ACINTDIS);
@@ -101,8 +97,7 @@ static void txx9aclc_ac97_write(struct snd_ac97 *ac97, unsigned short reg,
 
 static void txx9aclc_ac97_cold_reset(struct snd_ac97 *ac97)
 {
-	struct txx9aclc_soc_device *dev = txx9aclc_soc_dev;
-	struct txx9aclc_plat_drvdata *drvdata = txx9aclc_get_plat_drvdata(dev);
+	struct txx9aclc_plat_drvdata *drvdata = txx9aclc_drvdata;
 	void __iomem *base = drvdata->base;
 	u32 ready = ACINT_CODECRDY(ac97->num) | ACINT_REGACCRDY;
 
@@ -141,30 +136,23 @@ static irqreturn_t txx9aclc_ac97_irq(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static int txx9aclc_ac97_probe(struct platform_device *pdev,
-			       struct snd_soc_dai *dai)
+static int txx9aclc_ac97_probe(struct snd_soc_dai *dai)
 {
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct txx9aclc_soc_device *dev =
-		container_of(socdev, struct txx9aclc_soc_device, soc_dev);
-
-	dev->aclc_pdev = to_platform_device(dai->dev);
-	txx9aclc_soc_dev = dev;
+	txx9aclc_drvdata = snd_soc_dai_get_drvdata(dai);
 	return 0;
 }
 
-static void txx9aclc_ac97_remove(struct platform_device *pdev,
-				 struct snd_soc_dai *dai)
+static int txx9aclc_ac97_remove(struct snd_soc_dai *dai)
 {
-	struct platform_device *aclc_pdev = to_platform_device(dai->dev);
-	struct txx9aclc_plat_drvdata *drvdata = platform_get_drvdata(aclc_pdev);
+	struct txx9aclc_plat_drvdata *drvdata = snd_soc_dai_get_drvdata(dai);
 
 	/* disable AC-link */
 	__raw_writel(ACCTL_ENLINK, drvdata->base + ACCTLDIS);
-	txx9aclc_soc_dev = NULL;
+	txx9aclc_drvdata = NULL;
+	return 0;
 }
 
-struct snd_soc_dai txx9aclc_ac97_dai = {
+struct snd_soc_dai_driver txx9aclc_ac97_dai = {
 	.name			= "txx9aclc_ac97",
 	.ac97_control		= 1,
 	.probe			= txx9aclc_ac97_probe,
@@ -219,13 +207,12 @@ static int __devinit txx9aclc_ac97_dev_probe(struct platform_device *pdev)
 	if (err < 0)
 		return err;
 
-	txx9aclc_ac97_dai.dev = &pdev->dev;
-	return snd_soc_register_dai(&txx9aclc_ac97_dai);
+	return snd_soc_register_dai(&pdev->dev, -1, &txx9aclc_ac97_dai);
 }
 
 static int __devexit txx9aclc_ac97_dev_remove(struct platform_device *pdev)
 {
-	snd_soc_unregister_dai(&txx9aclc_ac97_dai);
+	snd_soc_unregister_dai(&pdev->dev, -1);
 	return 0;
 }
 
diff --git a/sound/soc/txx9/txx9aclc-generic.c b/sound/soc/txx9/txx9aclc-generic.c
index 95b17f7..e8a2109 100644
--- a/sound/soc/txx9/txx9aclc-generic.c
+++ b/sound/soc/txx9/txx9aclc-generic.c
@@ -25,48 +25,39 @@
 static struct snd_soc_dai_link txx9aclc_generic_dai = {
 	.name = "AC97",
 	.stream_name = "AC97 HiFi",
-	.cpu_dai = &txx9aclc_ac97_dai,
-	.codec_dai = &ac97_dai,
+	.cpu_dai_drv = &txx9aclc_ac97_dai,
+	.codec_dai_drv = &ac97_dai,
+	.platform_drv	= &txx9aclc_soc_platform,
+	.codec_drv	= &soc_codec_dev_ac97,
 };
 
 static struct snd_soc_card txx9aclc_generic_card = {
 	.name		= "Generic TXx9 ACLC Audio",
-	.platform	= &txx9aclc_soc_platform,
 	.dai_link	= &txx9aclc_generic_dai,
 	.num_links	= 1,
 };
 
-static struct txx9aclc_soc_device txx9aclc_generic_soc_device = {
-	.soc_dev = {
-		.card		= &txx9aclc_generic_card,
-		.codec_dev	= &soc_codec_dev_ac97,
-	},
-};
+static struct platform_device *soc_pdev;
 
 static int __init txx9aclc_generic_probe(struct platform_device *pdev)
 {
-	struct txx9aclc_soc_device *dev = &txx9aclc_generic_soc_device;
-	struct platform_device *soc_pdev;
 	int ret;
 
 	soc_pdev = platform_device_alloc("soc-audio", -1);
 	if (!soc_pdev)
 		return -ENOMEM;
-	platform_set_drvdata(soc_pdev, &dev->soc_dev);
-	dev->soc_dev.dev = &soc_pdev->dev;
+	platform_set_drvdata(soc_pdev, &txx9aclc_generic_card);
 	ret = platform_device_add(soc_pdev);
 	if (ret) {
 		platform_device_put(soc_pdev);
 		return ret;
 	}
-	platform_set_drvdata(pdev, soc_pdev);
+
 	return 0;
 }
 
 static int __exit txx9aclc_generic_remove(struct platform_device *pdev)
 {
-	struct platform_device *soc_pdev = platform_get_drvdata(pdev);
-
 	platform_device_unregister(soc_pdev);
 	return 0;
 }
diff --git a/sound/soc/txx9/txx9aclc.c b/sound/soc/txx9/txx9aclc.c
index 0e34523..003413f 100644
--- a/sound/soc/txx9/txx9aclc.c
+++ b/sound/soc/txx9/txx9aclc.c
@@ -22,6 +22,16 @@
 #include <sound/soc.h>
 #include "txx9aclc.h"
 
+static struct txx9aclc_soc_device {
+	struct txx9aclc_dmadata dmadata[2];
+} txx9aclc_soc_device;
+
+/* REVISIT: How to find txx9aclc_drvdata from snd_ac97? */
+static struct txx9aclc_plat_drvdata *txx9aclc_drvdata;
+
+static int txx9aclc_dma_init(struct txx9aclc_soc_device *dev,
+			     struct txx9aclc_dmadata *dmadata);
+
 static const struct snd_pcm_hardware txx9aclc_pcm_hardware = {
 	/*
 	 * REVISIT: SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_MMAP_VALID
@@ -46,7 +56,6 @@ static int txx9aclc_pcm_hw_params(struct snd_pcm_substream *substream,
 				  struct snd_pcm_hw_params *params)
 {
 	struct snd_soc_pcm_runtime *rtd = snd_pcm_substream_chip(substream);
-	struct snd_soc_device *socdev = rtd->socdev;
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct txx9aclc_dmadata *dmadata = runtime->private_data;
 	int ret;
@@ -55,13 +64,13 @@ static int txx9aclc_pcm_hw_params(struct snd_pcm_substream *substream,
 	if (ret < 0)
 		return ret;
 
-	dev_dbg(socdev->dev,
+	dev_dbg(rtd->platform->dev,
 		"runtime->dma_area = %#lx dma_addr = %#lx dma_bytes = %zd "
 		"runtime->min_align %ld\n",
 		(unsigned long)runtime->dma_area,
 		(unsigned long)runtime->dma_addr, runtime->dma_bytes,
 		runtime->min_align);
-	dev_dbg(socdev->dev,
+	dev_dbg(rtd->platform->dev,
 		"periods %d period_bytes %d stream %d\n",
 		params_periods(params), params_period_bytes(params),
 		substream->stream);
@@ -152,11 +161,7 @@ static void txx9aclc_dma_tasklet(unsigned long data)
 
 	spin_lock_irqsave(&dmadata->dma_lock, flags);
 	if (dmadata->frag_count < 0) {
-		struct txx9aclc_soc_device *dev =
-			container_of(dmadata, struct txx9aclc_soc_device,
-				     dmadata[substream->stream]);
-		struct txx9aclc_plat_drvdata *drvdata =
-			txx9aclc_get_plat_drvdata(dev);
+		struct txx9aclc_plat_drvdata *drvdata = txx9aclc_drvdata;
 		void __iomem *base = drvdata->base;
 
 		spin_unlock_irqrestore(&dmadata->dma_lock, flags);
@@ -202,10 +207,7 @@ static void txx9aclc_dma_tasklet(unsigned long data)
 static int txx9aclc_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 {
 	struct txx9aclc_dmadata *dmadata = substream->runtime->private_data;
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct txx9aclc_soc_device *dev =
-		container_of(rtd->socdev, struct txx9aclc_soc_device, soc_dev);
-	struct txx9aclc_plat_drvdata *drvdata = txx9aclc_get_plat_drvdata(dev);
+	struct txx9aclc_plat_drvdata *drvdata =txx9aclc_drvdata;
 	void __iomem *base = drvdata->base;
 	unsigned long flags;
 	int ret = 0;
@@ -244,9 +246,7 @@ txx9aclc_pcm_pointer(struct snd_pcm_substream *substream)
 
 static int txx9aclc_pcm_open(struct snd_pcm_substream *substream)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct txx9aclc_soc_device *dev =
-		container_of(rtd->socdev, struct txx9aclc_soc_device, soc_dev);
+	struct txx9aclc_soc_device *dev = &txx9aclc_soc_device;
 	struct txx9aclc_dmadata *dmadata = &dev->dmadata[substream->stream];
 	int ret;
 
@@ -291,8 +291,38 @@ static void txx9aclc_pcm_free_dma_buffers(struct snd_pcm *pcm)
 static int txx9aclc_pcm_new(struct snd_card *card, struct snd_soc_dai *dai,
 			    struct snd_pcm *pcm)
 {
+	struct platform_device *pdev = to_platform_device(dai->platform->dev);
+	struct txx9aclc_soc_device *dev;
+	struct resource *r;
+	int i;
+	int ret;
+
+	/* at this point onwards the AC97 component has probed and this will be valid */
+	dev = snd_soc_dai_get_drvdata(dai);
+
+	dev->dmadata[0].stream = SNDRV_PCM_STREAM_PLAYBACK;
+	dev->dmadata[1].stream = SNDRV_PCM_STREAM_CAPTURE;
+	for (i = 0; i < 2; i++) {
+		r = platform_get_resource(pdev, IORESOURCE_DMA, i);
+		if (!r) {
+			ret = -EBUSY;
+			goto exit;
+		}
+		dev->dmadata[i].dma_res = r;
+		ret = txx9aclc_dma_init(dev, &dev->dmadata[i]);
+		if (ret)
+			goto exit;
+	}
 	return snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_DEV,
 		card->dev, 64 * 1024, 4 * 1024 * 1024);
+
+exit:
+	for (i = 0; i < 2; i++) {
+		if (dev->dmadata[i].dma_chan)
+			dma_release_channel(dev->dmadata[i].dma_chan);
+		dev->dmadata[i].dma_chan = NULL;
+	}
+	return ret;
 }
 
 static bool filter(struct dma_chan *chan, void *param)
@@ -314,7 +344,7 @@ static bool filter(struct dma_chan *chan, void *param)
 static int txx9aclc_dma_init(struct txx9aclc_soc_device *dev,
 			     struct txx9aclc_dmadata *dmadata)
 {
-	struct txx9aclc_plat_drvdata *drvdata = txx9aclc_get_plat_drvdata(dev);
+	struct txx9aclc_plat_drvdata *drvdata =txx9aclc_drvdata;
 	struct txx9dmac_slave *ds = &dmadata->dma_slave;
 	dma_cap_mask_t mask;
 
@@ -334,7 +364,7 @@ static int txx9aclc_dma_init(struct txx9aclc_soc_device *dev,
 	dma_cap_set(DMA_SLAVE, mask);
 	dmadata->dma_chan = dma_request_channel(mask, filter, dmadata);
 	if (!dmadata->dma_chan) {
-		dev_err(dev->soc_dev.dev,
+		printk(KERN_ERR
 			"DMA channel for %s is not available\n",
 			dmadata->stream == SNDRV_PCM_STREAM_PLAYBACK ?
 			"playback" : "capture");
@@ -345,45 +375,16 @@ static int txx9aclc_dma_init(struct txx9aclc_soc_device *dev,
 	return 0;
 }
 
-static int txx9aclc_pcm_probe(struct platform_device *pdev)
+static int txx9aclc_pcm_probe(struct snd_soc_platform *platform)
 {
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct txx9aclc_soc_device *dev =
-		container_of(socdev, struct txx9aclc_soc_device, soc_dev);
-	struct resource *r;
-	int i;
-	int ret;
-
-	dev->dmadata[0].stream = SNDRV_PCM_STREAM_PLAYBACK;
-	dev->dmadata[1].stream = SNDRV_PCM_STREAM_CAPTURE;
-	for (i = 0; i < 2; i++) {
-		r = platform_get_resource(dev->aclc_pdev, IORESOURCE_DMA, i);
-		if (!r) {
-			ret = -EBUSY;
-			goto exit;
-		}
-		dev->dmadata[i].dma_res = r;
-		ret = txx9aclc_dma_init(dev, &dev->dmadata[i]);
-		if (ret)
-			goto exit;
-	}
+	snd_soc_platform_set_drvdata(platform, &txx9aclc_soc_device);
 	return 0;
-
-exit:
-	for (i = 0; i < 2; i++) {
-		if (dev->dmadata[i].dma_chan)
-			dma_release_channel(dev->dmadata[i].dma_chan);
-		dev->dmadata[i].dma_chan = NULL;
-	}
-	return ret;
 }
 
-static int txx9aclc_pcm_remove(struct platform_device *pdev)
+static int txx9aclc_pcm_remove(struct snd_soc_platform *platform)
 {
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct txx9aclc_soc_device *dev =
-		container_of(socdev, struct txx9aclc_soc_device, soc_dev);
-	struct txx9aclc_plat_drvdata *drvdata = txx9aclc_get_plat_drvdata(dev);
+	struct txx9aclc_soc_device *dev = snd_soc_platform_get_drvdata(platform);
+	struct txx9aclc_plat_drvdata *drvdata = txx9aclc_drvdata;
 	void __iomem *base = drvdata->base;
 	int i;
 
@@ -406,28 +407,48 @@ static int txx9aclc_pcm_remove(struct platform_device *pdev)
 	return 0;
 }
 
-struct snd_soc_platform txx9aclc_soc_platform = {
+struct snd_soc_platform_driver txx9aclc_soc_platform = {
 	.name		= "txx9aclc-audio",
-	.probe		= txx9aclc_pcm_probe,
-	.remove		= txx9aclc_pcm_remove,
-	.pcm_ops 	= &txx9aclc_pcm_ops,
+	.probe 		= txx9aclc_pcm_probe,
+	.remove 	= txx9aclc_pcm_remove,
+	.ops 		= &txx9aclc_pcm_ops,
 	.pcm_new	= txx9aclc_pcm_new,
 	.pcm_free	= txx9aclc_pcm_free_dma_buffers,
 };
 EXPORT_SYMBOL_GPL(txx9aclc_soc_platform);
 
-static int __init txx9aclc_soc_platform_init(void)
+static int __devinit txx9aclc_soc_platform_probe(struct platform_device *pdev)
 {
-	return snd_soc_register_platform(&txx9aclc_soc_platform);
+	return snd_soc_register_platform(&pdev->dev, -1, &txx9aclc_soc_platform);
 }
 
-static void __exit txx9aclc_soc_platform_exit(void)
+static int __devexit txx9aclc_soc_platform_remove(struct platform_device *pdev)
 {
-	snd_soc_unregister_platform(&txx9aclc_soc_platform);
+	snd_soc_unregister_platform(&pdev->dev, -1);
+	return 0;
 }
 
-module_init(txx9aclc_soc_platform_init);
-module_exit(txx9aclc_soc_platform_exit);
+static struct platform_driver txx9aclc_pcm_driver = {
+	.driver = {
+			.name = "txx9aclc-pcm-audio",
+			.owner = THIS_MODULE,
+	},
+
+	.probe = txx9aclc_soc_platform_probe,
+	.remove = __devexit_p(txx9aclc_soc_platform_remove),
+};
+
+static int __init snd_txx9aclc_pcm_init(void)
+{
+	return platform_driver_register(&txx9aclc_pcm_driver);
+}
+module_init(snd_txx9aclc_pcm_init);
+
+static void __exit snd_txx9aclc_pcm_exit(void)
+{
+	platform_driver_unregister(&txx9aclc_pcm_driver);
+}
+module_exit(snd_txx9aclc_pcm_exit);
 
 MODULE_AUTHOR("Atsushi Nemoto <anemo@mba.ocn.ne.jp>");
 MODULE_DESCRIPTION("TXx9 ACLC Audio DMA driver");
diff --git a/sound/soc/txx9/txx9aclc.h b/sound/soc/txx9/txx9aclc.h
index 6769aab..4967aa7 100644
--- a/sound/soc/txx9/txx9aclc.h
+++ b/sound/soc/txx9/txx9aclc.h
@@ -65,19 +65,13 @@ struct txx9aclc_plat_drvdata {
 	u64 physbase;
 };
 
-struct txx9aclc_soc_device {
-	struct snd_soc_device soc_dev;
-	struct platform_device *aclc_pdev;	/* for ioresources, drvdata */
-	struct txx9aclc_dmadata dmadata[2];
-};
-
 static inline struct txx9aclc_plat_drvdata *txx9aclc_get_plat_drvdata(
-	struct txx9aclc_soc_device *sdev)
+	struct snd_soc_dai *dai)
 {
-	return platform_get_drvdata(sdev->aclc_pdev);
+	return dev_get_drvdata(dai->dev);
 }
 
-extern struct snd_soc_platform txx9aclc_soc_platform;
-extern struct snd_soc_dai txx9aclc_ac97_dai;
+extern struct snd_soc_platform_driver txx9aclc_soc_platform;
+extern struct snd_soc_dai_driver txx9aclc_ac97_dai;
 
 #endif /* __TXX9ACLC_H */
-- 
1.7.0.4
