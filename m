From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: [RFC 08/15] ASoC: multi-component - S6000 Platform
Date: Sun, 27 Jun 2010 12:52:07 +0100
Message-ID: <1277639534-5104-9-git-send-email-lrg@slimlogic.co.uk>
References: <1277639534-5104-1-git-send-email-lrg@slimlogic.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 22BA41038A2
	for <alsa-devel@alsa-project.org>;
	Sun, 27 Jun 2010 13:52:42 +0200 (CEST)
Received: by mail-ww0-f51.google.com with SMTP id 13so934011wwb.38
	for <alsa-devel@alsa-project.org>; Sun, 27 Jun 2010 04:52:42 -0700 (PDT)
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

Update the S6000 platform and machines to new multi-component model.

This patch changes the machine drivers for multi-component as follows :-

 o Removed socdev
 o Each DAI link entry now contains platform and codec fields.
 o DAI link init() now passed snd_soc_pcm_runtime instread of snd_soc_codec.

This patch also changes the DAI and platform DAM drivers as follows :-

 o Each platform DAI and platform DMA driver is a kernel device and can
   have platform data.
 o DAI and Platform DMA drivers have private data accessors.

Other notable changes required for multi-component support:-

 o Fix DMA params private data for playback and capture .
 o Removed empty s6105 audio private data. This must be platform data now.

Signed-off-by: Liam Girdwood <lrg@slimlogic.co.uk>
---
 sound/soc/s6000/s6000-i2s.c   |   54 ++++++++++------------
 sound/soc/s6000/s6000-i2s.h   |    2 +-
 sound/soc/s6000/s6000-pcm.c   |   98 +++++++++++++++++++++++++---------------
 sound/soc/s6000/s6000-pcm.h   |    2 +-
 sound/soc/s6000/s6105-ipcam.c |   31 +++++--------
 5 files changed, 99 insertions(+), 88 deletions(-)

diff --git a/sound/soc/s6000/s6000-i2s.c b/sound/soc/s6000/s6000-i2s.c
index 59e3fa7..b60b62f 100644
--- a/sound/soc/s6000/s6000-i2s.c
+++ b/sound/soc/s6000/s6000-i2s.c
@@ -140,7 +140,7 @@ static void s6000_i2s_stop_channel(struct s6000_i2s_dev *dev, int channel)
 static void s6000_i2s_start(struct snd_pcm_substream *substream)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct s6000_i2s_dev *dev = rtd->dai->cpu_dai->private_data;
+	struct s6000_i2s_dev *dev = snd_soc_dai_get_drvdata(rtd->cpu_dai);
 	int channel;
 
 	channel = (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) ?
@@ -152,7 +152,7 @@ static void s6000_i2s_start(struct snd_pcm_substream *substream)
 static void s6000_i2s_stop(struct snd_pcm_substream *substream)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct s6000_i2s_dev *dev = rtd->dai->cpu_dai->private_data;
+	struct s6000_i2s_dev *dev = snd_soc_dai_get_drvdata(rtd->cpu_dai);
 	int channel;
 
 	channel = (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) ?
@@ -194,7 +194,7 @@ static unsigned int s6000_i2s_int_sources(struct s6000_i2s_dev *dev)
 
 static unsigned int s6000_i2s_check_xrun(struct snd_soc_dai *cpu_dai)
 {
-	struct s6000_i2s_dev *dev = cpu_dai->private_data;
+	struct s6000_i2s_dev *dev = snd_soc_dai_get_drvdata(cpu_dai);
 	unsigned int errors;
 	unsigned int ret;
 
@@ -232,7 +232,7 @@ static void s6000_i2s_wait_disabled(struct s6000_i2s_dev *dev)
 static int s6000_i2s_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 				   unsigned int fmt)
 {
-	struct s6000_i2s_dev *dev = cpu_dai->private_data;
+	struct s6000_i2s_dev *dev = snd_soc_dai_get_drvdata(cpu_dai);
 	u32 w;
 
 	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
@@ -273,7 +273,7 @@ static int s6000_i2s_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 
 static int s6000_i2s_set_clkdiv(struct snd_soc_dai *dai, int div_id, int div)
 {
-	struct s6000_i2s_dev *dev = dai->private_data;
+	struct s6000_i2s_dev *dev = snd_soc_dai_get_drvdata(dai);
 
 	if (!div || (div & 1) || div > (S6_I2S_DIV_MASK + 1) * 2)
 		return -EINVAL;
@@ -287,7 +287,7 @@ static int s6000_i2s_hw_params(struct snd_pcm_substream *substream,
 			       struct snd_pcm_hw_params *params,
 			       struct snd_soc_dai *dai)
 {
-	struct s6000_i2s_dev *dev = dai->private_data;
+	struct s6000_i2s_dev *dev = snd_soc_dai_get_drvdata(dai);
 	int interf;
 	u32 w = 0;
 
@@ -326,15 +326,17 @@ static int s6000_i2s_hw_params(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-static int s6000_i2s_dai_probe(struct platform_device *pdev,
-			       struct snd_soc_dai *dai)
+static int s6000_i2s_dai_probe(struct snd_soc_dai *dai)
 {
-	struct s6000_i2s_dev *dev = dai->private_data;
-	struct s6000_snd_platform_data *pdata = pdev->dev.platform_data;
+	struct s6000_i2s_dev *dev = snd_soc_dai_get_drvdata(dai);
+	struct s6000_snd_platform_data *pdata = dai->dev->platform_data;
 
 	if (!pdata)
 		return -EINVAL;
 
+	dai->capture_dma_data = &dev->dma_params;
+	dai->playback_dma_data = &dev->dma_params;
+
 	dev->wide = pdata->wide;
 	dev->channel_in = pdata->channel_in;
 	dev->channel_out = pdata->channel_out;
@@ -352,10 +354,10 @@ static int s6000_i2s_dai_probe(struct platform_device *pdev,
 
 		dev->channel_in = 0;
 		dev->channel_out = 1;
-		dai->capture.channels_min = 2 * dev->lines_in;
-		dai->capture.channels_max = dai->capture.channels_min;
-		dai->playback.channels_min = 2 * dev->lines_out;
-		dai->playback.channels_max = dai->playback.channels_min;
+		dai->driver->capture.channels_min = 2 * dev->lines_in;
+		dai->driver->capture.channels_max = dai->driver->capture.channels_min;
+		dai->driver->playback.channels_min = 2 * dev->lines_out;
+		dai->driver->playback.channels_max = dai->driver->playback.channels_min;
 
 		for (i = 0; i < dev->lines_out; i++)
 			s6_i2s_write_reg(dev, S6_I2S_DATA_CFG(i), S6_I2S_OUT);
@@ -372,10 +374,10 @@ static int s6000_i2s_dai_probe(struct platform_device *pdev,
 		if (dev->lines_in > 1 || dev->lines_out > 1)
 			return -EINVAL;
 
-		dai->capture.channels_min = 2 * dev->lines_in;
-		dai->capture.channels_max = 8 * dev->lines_in;
-		dai->playback.channels_min = 2 * dev->lines_out;
-		dai->playback.channels_max = 8 * dev->lines_out;
+		dai->driver->capture.channels_min = 2 * dev->lines_in;
+		dai->driver->capture.channels_max = 8 * dev->lines_in;
+		dai->driver->playback.channels_min = 2 * dev->lines_out;
+		dai->driver->playback.channels_max = 8 * dev->lines_out;
 
 		if (dev->lines_in)
 			cfg[dev->channel_in] = S6_I2S_IN;
@@ -413,9 +415,8 @@ static struct snd_soc_dai_ops s6000_i2s_dai_ops = {
 	.hw_params = s6000_i2s_hw_params,
 };
 
-struct snd_soc_dai s6000_i2s_dai = {
+struct snd_soc_dai_driver s6000_i2s_dai = {
 	.name = "s6000-i2s",
-	.id = 0,
 	.probe = s6000_i2s_dai_probe,
 	.playback = {
 		.channels_min = 2,
@@ -513,11 +514,7 @@ static int __devinit s6000_i2s_probe(struct platform_device *pdev)
 		ret = -ENOMEM;
 		goto err_release_dma2;
 	}
-
-	s6000_i2s_dai.dev = &pdev->dev;
-	s6000_i2s_dai.private_data = dev;
-	s6000_i2s_dai.capture.dma_data = &dev->dma_params;
-	s6000_i2s_dai.playback.dma_data = &dev->dma_params;
+	dev_set_drvdata(&pdev->dev, dev);
 
 	dev->sifbase = sifmem->start;
 	dev->scbbase = mmio;
@@ -548,7 +545,7 @@ static int __devinit s6000_i2s_probe(struct platform_device *pdev)
 			 S6_I2S_INT_UNDERRUN |
 			 S6_I2S_INT_OVERRUN);
 
-	ret = snd_soc_register_dai(&s6000_i2s_dai);
+	ret = snd_soc_register_dai(&pdev->dev, -1, &s6000_i2s_dai);
 	if (ret)
 		goto err_release_dev;
 
@@ -573,17 +570,16 @@ err_release_none:
 
 static void __devexit s6000_i2s_remove(struct platform_device *pdev)
 {
-	struct s6000_i2s_dev *dev = s6000_i2s_dai.private_data;
+	struct s6000_i2s_dev *dev = dev_get_drvdata(&pdev->dev);
 	struct resource *region;
 	void __iomem *mmio = dev->scbbase;
 
-	snd_soc_unregister_dai(&s6000_i2s_dai);
+	snd_soc_unregister_dai(&pdev->dev, -1);
 
 	s6000_i2s_stop_channel(dev, 0);
 	s6000_i2s_stop_channel(dev, 1);
 
 	s6_i2s_write_reg(dev, S6_I2S_INTERRUPT_ENABLE, 0);
-	s6000_i2s_dai.private_data = 0;
 	kfree(dev);
 
 	region = platform_get_resource(pdev, IORESOURCE_DMA, 0);
diff --git a/sound/soc/s6000/s6000-i2s.h b/sound/soc/s6000/s6000-i2s.h
index 2375fdf..3650241 100644
--- a/sound/soc/s6000/s6000-i2s.h
+++ b/sound/soc/s6000/s6000-i2s.h
@@ -12,7 +12,7 @@
 #ifndef _S6000_I2S_H
 #define _S6000_I2S_H
 
-extern struct snd_soc_dai s6000_i2s_dai;
+extern struct snd_soc_dai_driver s6000_i2s_dai;
 
 struct s6000_snd_platform_data {
 	int lines_in;
diff --git a/sound/soc/s6000/s6000-pcm.c b/sound/soc/s6000/s6000-pcm.c
index 9c7f7f0..3dda283 100644
--- a/sound/soc/s6000/s6000-pcm.c
+++ b/sound/soc/s6000/s6000-pcm.c
@@ -65,7 +65,7 @@ static void s6000_pcm_enqueue_dma(struct snd_pcm_substream *substream)
 	dma_addr_t dma_pos;
 	dma_addr_t src, dst;
 
-	par = snd_soc_dai_get_dma_data(soc_runtime->dai->cpu_dai, substream);
+	par = snd_soc_dai_get_dma_data(soc_runtime->cpu_dai, substream);
 
 	period_size = snd_pcm_lib_period_bytes(substream);
 	dma_offset = prtd->period * period_size;
@@ -103,23 +103,25 @@ static irqreturn_t s6000_pcm_irq(int irq, void *data)
 {
 	struct snd_pcm *pcm = data;
 	struct snd_soc_pcm_runtime *runtime = pcm->private_data;
-	struct s6000_pcm_dma_params *params =
-		snd_soc_dai_get_dma_data(soc_runtime->dai->cpu_dai, substream);
 	struct s6000_runtime_data *prtd;
 	unsigned int has_xrun;
 	int i, ret = IRQ_NONE;
-	u32 channel[2] = {
-		[SNDRV_PCM_STREAM_PLAYBACK] = params->dma_out,
-		[SNDRV_PCM_STREAM_CAPTURE] = params->dma_in
-	};
-
-	has_xrun = params->check_xrun(runtime->dai->cpu_dai);
 
-	for (i = 0; i < ARRAY_SIZE(channel); ++i) {
+	for (i = 0; i < 2; ++i) {
 		struct snd_pcm_substream *substream = pcm->streams[i].substream;
+		struct s6000_pcm_dma_params *params =
+					snd_soc_dai_get_dma_data(runtime->cpu_dai, substream);
+		u32 channel;
 		unsigned int pending;
 
-		if (!channel[i])
+		if (substream == SNDRV_PCM_STREAM_PLAYBACK)
+			channel = params->dma_out;
+		else
+			channel = params->dma_in;
+
+		has_xrun = params->check_xrun(runtime->cpu_dai);
+
+		if (!channel)
 			continue;
 
 		if (unlikely(has_xrun & (1 << i)) &&
@@ -130,8 +132,8 @@ static irqreturn_t s6000_pcm_irq(int irq, void *data)
 			ret = IRQ_HANDLED;
 		}
 
-		pending = s6dmac_int_sources(DMA_MASK_DMAC(channel[i]),
-					     DMA_INDEX_CHNL(channel[i]));
+		pending = s6dmac_int_sources(DMA_MASK_DMAC(channel),
+					     DMA_INDEX_CHNL(channel));
 
 		if (pending & 1) {
 			ret = IRQ_HANDLED;
@@ -139,10 +141,10 @@ static irqreturn_t s6000_pcm_irq(int irq, void *data)
 				   snd_pcm_running(substream))) {
 				snd_pcm_period_elapsed(substream);
 				dev_dbg(pcm->dev, "period elapsed %x %x\n",
-				       s6dmac_cur_src(DMA_MASK_DMAC(channel[i]),
-						   DMA_INDEX_CHNL(channel[i])),
-				       s6dmac_cur_dst(DMA_MASK_DMAC(channel[i]),
-						   DMA_INDEX_CHNL(channel[i])));
+				       s6dmac_cur_src(DMA_MASK_DMAC(channel),
+						   DMA_INDEX_CHNL(channel)),
+				       s6dmac_cur_dst(DMA_MASK_DMAC(channel),
+						   DMA_INDEX_CHNL(channel)));
 				prtd = substream->runtime->private_data;
 				spin_lock(&prtd->lock);
 				s6000_pcm_enqueue_dma(substream);
@@ -154,16 +156,16 @@ static irqreturn_t s6000_pcm_irq(int irq, void *data)
 			if (pending & (1 << 3))
 				printk(KERN_WARNING
 				       "s6000-pcm: DMA %x Underflow\n",
-				       channel[i]);
+				       channel);
 			if (pending & (1 << 4))
 				printk(KERN_WARNING
 				       "s6000-pcm: DMA %x Overflow\n",
-				       channel[i]);
+				       channel);
 			if (pending & 0x1e0)
 				printk(KERN_WARNING
 				       "s6000-pcm: DMA %x Master Error "
 				       "(mask %x)\n",
-				       channel[i], pending >> 5);
+				       channel, pending >> 5);
 
 		}
 	}
@@ -180,7 +182,7 @@ static int s6000_pcm_start(struct snd_pcm_substream *substream)
 	int srcinc;
 	u32 dma;
 
-	par = snd_soc_dai_get_dma_data(soc_runtime->dai->cpu_dai, substream);
+	par = snd_soc_dai_get_dma_data(soc_runtime->cpu_dai, substream);
 
 	spin_lock_irqsave(&prtd->lock, flags);
 
@@ -221,7 +223,7 @@ static int s6000_pcm_stop(struct snd_pcm_substream *substream)
 	unsigned long flags;
 	u32 channel;
 
-	par = snd_soc_dai_get_dma_data(soc_runtime->dai->cpu_dai, substream);
+	par = snd_soc_dai_get_dma_data(soc_runtime->cpu_dai, substream);
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
 		channel = par->dma_out;
@@ -246,7 +248,7 @@ static int s6000_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 	struct s6000_pcm_dma_params *par;
 	int ret;
 
-	par = snd_soc_dai_get_dma_data(soc_runtime->dai->cpu_dai, substream);
+	par = snd_soc_dai_get_dma_data(soc_runtime->cpu_dai, substream);
 
 	ret = par->trigger(substream, cmd, 0);
 	if (ret < 0)
@@ -291,7 +293,7 @@ static snd_pcm_uframes_t s6000_pcm_pointer(struct snd_pcm_substream *substream)
 	unsigned int offset;
 	dma_addr_t count;
 
-	par = snd_soc_dai_get_dma_data(soc_runtime->dai->cpu_dai, substream);
+	par = snd_soc_dai_get_dma_data(soc_runtime->cpu_dai, substream);
 
 	spin_lock_irqsave(&prtd->lock, flags);
 
@@ -321,7 +323,7 @@ static int s6000_pcm_open(struct snd_pcm_substream *substream)
 	struct s6000_runtime_data *prtd;
 	int ret;
 
-	par = snd_soc_dai_get_dma_data(soc_runtime->dai->cpu_dai, substream);
+	par = snd_soc_dai_get_dma_data(soc_runtime->cpu_dai, substream);
 	snd_soc_set_runtime_hwparams(substream, &s6000_pcm_hardware);
 
 	ret = snd_pcm_hw_constraint_step(runtime, 0,
@@ -385,7 +387,7 @@ static int s6000_pcm_hw_params(struct snd_pcm_substream *substream,
 		return ret;
 	}
 
-	par = snd_soc_dai_get_dma_data(soc_runtime->dai->cpu_dai, substream);
+	par = snd_soc_dai_get_dma_data(soc_runtime->cpu_dai, substream);
 
 	if (par->same_rate) {
 		spin_lock(&par->lock);
@@ -407,7 +409,7 @@ static int s6000_pcm_hw_free(struct snd_pcm_substream *substream)
 {
 	struct snd_soc_pcm_runtime *soc_runtime = substream->private_data;
 	struct s6000_pcm_dma_params *par =
-		snd_soc_dai_get_dma_data(soc_runtime->dai->cpu_dai, substream);
+		snd_soc_dai_get_dma_data(soc_runtime->cpu_dai, substream);
 
 	spin_lock(&par->lock);
 	par->in_use &= ~(1 << substream->stream);
@@ -433,7 +435,7 @@ static void s6000_pcm_free(struct snd_pcm *pcm)
 {
 	struct snd_soc_pcm_runtime *runtime = pcm->private_data;
 	struct s6000_pcm_dma_params *params =
-		snd_soc_dai_get_dma_data(soc_runtime->dai->cpu_dai, substream);
+		snd_soc_dai_get_dma_data(runtime->cpu_dai, pcm->streams[0].substream);
 
 	free_irq(params->irq, pcm);
 	snd_pcm_lib_preallocate_free_for_all(pcm);
@@ -448,7 +450,8 @@ static int s6000_pcm_new(struct snd_card *card,
 	struct s6000_pcm_dma_params *params;
 	int res;
 
-	params = snd_soc_dai_get_dma_data(soc_runtime->dai->cpu_dai, substream);
+	params = snd_soc_dai_get_dma_data(runtime->cpu_dai,
+			pcm->streams[0].substream);
 
 	if (!card->dev->dma_mask)
 		card->dev->dma_mask = &s6000_pcm_dmamask;
@@ -490,25 +493,46 @@ static int s6000_pcm_new(struct snd_card *card,
 	return 0;
 }
 
-struct snd_soc_platform s6000_soc_platform = {
+struct snd_soc_platform_driver s6000_soc_platform = {
 	.name = 	"s6000-audio",
-	.pcm_ops = 	&s6000_pcm_ops,
+	.ops =		&s6000_pcm_ops,
 	.pcm_new = 	s6000_pcm_new,
 	.pcm_free = 	s6000_pcm_free,
 };
 EXPORT_SYMBOL_GPL(s6000_soc_platform);
 
-static int __init s6000_pcm_init(void)
+static int __devinit s6000_soc_platform_probe(struct platform_device *pdev)
+{
+	return snd_soc_register_platform(&pdev->dev, -1, &s6000_soc_platform);
+}
+
+static int __devexit s6000_soc_platform_remove(struct platform_device *pdev)
+{
+	snd_soc_unregister_platform(&pdev->dev, -1);
+	return 0;
+}
+
+static struct platform_driver s6000_pcm_driver = {
+	.driver = {
+			.name = "s6000-pcm-audio",
+			.owner = THIS_MODULE,
+	},
+
+	.probe = s6000_soc_platform_probe,
+	.remove = __devexit_p(s6000_soc_platform_remove),
+};
+
+static int __init snd_s6000_pcm_init(void)
 {
-	return snd_soc_register_platform(&s6000_soc_platform);
+	return platform_driver_register(&s6000_pcm_driver);
 }
-module_init(s6000_pcm_init);
+module_init(snd_s6000_pcm_init);
 
-static void __exit s6000_pcm_exit(void)
+static void __exit snd_s6000_pcm_exit(void)
 {
-	snd_soc_unregister_platform(&s6000_soc_platform);
+	platform_driver_unregister(&s6000_pcm_driver);
 }
-module_exit(s6000_pcm_exit);
+module_exit(snd_s6000_pcm_exit);
 
 MODULE_AUTHOR("Daniel Gloeckner");
 MODULE_DESCRIPTION("Stretch s6000 family PCM DMA module");
diff --git a/sound/soc/s6000/s6000-pcm.h b/sound/soc/s6000/s6000-pcm.h
index 96f23f6..4e251f4 100644
--- a/sound/soc/s6000/s6000-pcm.h
+++ b/sound/soc/s6000/s6000-pcm.h
@@ -30,6 +30,6 @@ struct s6000_pcm_dma_params {
 	int rate;
 };
 
-extern struct snd_soc_platform s6000_soc_platform;
+extern struct snd_soc_platform_driver s6000_soc_platform;
 
 #endif
diff --git a/sound/soc/s6000/s6105-ipcam.c b/sound/soc/s6000/s6105-ipcam.c
index c1b40ac..e2299c1 100644
--- a/sound/soc/s6000/s6105-ipcam.c
+++ b/sound/soc/s6000/s6105-ipcam.c
@@ -32,8 +32,8 @@ static int s6105_hw_params(struct snd_pcm_substream *substream,
 			   struct snd_pcm_hw_params *params)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
-	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
 	int ret = 0;
 
 	/* set codec DAI configuration */
@@ -134,8 +134,10 @@ static const struct snd_kcontrol_new audio_out_mux = {
 };
 
 /* Logic for a aic3x as connected on the s6105 ip camera ref design */
-static int s6105_aic3x_init(struct snd_soc_codec *codec)
+static int s6105_aic3x_init(struct snd_soc_pcm_runtime *rtd)
 {
+	struct snd_soc_codec *codec = rtd->codec;
+
 	/* Add s6105 specific widgets */
 	snd_soc_dapm_new_controls(codec, aic3x_dapm_widgets,
 				  ARRAY_SIZE(aic3x_dapm_widgets));
@@ -165,7 +167,7 @@ static int s6105_aic3x_init(struct snd_soc_codec *codec)
 
 	snd_soc_dapm_sync(codec);
 
-	snd_ctl_add(codec->card, snd_ctl_new1(&audio_out_mux, codec));
+	snd_ctl_add(codec->snd_card, snd_ctl_new1(&audio_out_mux, codec));
 
 	return 0;
 }
@@ -174,8 +176,10 @@ static int s6105_aic3x_init(struct snd_soc_codec *codec)
 static struct snd_soc_dai_link s6105_dai = {
 	.name = "TLV320AIC31",
 	.stream_name = "AIC31",
-	.cpu_dai = &s6000_i2s_dai,
-	.codec_dai = &aic3x_dai,
+	.cpu_dai_drv = &s6000_i2s_dai,
+	.codec_dai_drv = &aic3x_dai,
+	.platform_drv = &s6000_soc_platform,
+	.codec_drv = &soc_codec_dev_aic3x,
 	.init = s6105_aic3x_init,
 	.ops = &s6105_ops,
 };
@@ -183,22 +187,10 @@ static struct snd_soc_dai_link s6105_dai = {
 /* s6105 audio machine driver */
 static struct snd_soc_card snd_soc_card_s6105 = {
 	.name = "Stretch IP Camera",
-	.platform = &s6000_soc_platform,
 	.dai_link = &s6105_dai,
 	.num_links = 1,
 };
 
-/* s6105 audio private data */
-static struct aic3x_setup_data s6105_aic3x_setup = {
-};
-
-/* s6105 audio subsystem */
-static struct snd_soc_device s6105_snd_devdata = {
-	.card = &snd_soc_card_s6105,
-	.codec_dev = &soc_codec_dev_aic3x,
-	.codec_data = &s6105_aic3x_setup,
-};
-
 static struct s6000_snd_platform_data __initdata s6105_snd_data = {
 	.wide		= 0,
 	.channel_in	= 0,
@@ -227,8 +219,7 @@ static int __init s6105_init(void)
 	if (!s6105_snd_device)
 		return -ENOMEM;
 
-	platform_set_drvdata(s6105_snd_device, &s6105_snd_devdata);
-	s6105_snd_devdata.dev = &s6105_snd_device->dev;
+	platform_set_drvdata(s6105_snd_device, &snd_soc_card_s6105);
 	platform_device_add_data(s6105_snd_device, &s6105_snd_data,
 				 sizeof(s6105_snd_data));
 
-- 
1.7.0.4
