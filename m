From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: [RFC 15/15] ASoC: multi-component - Ingenic J4740
	Platform
Date: Sun, 27 Jun 2010 12:52:14 +0100
Message-ID: <1277639534-5104-16-git-send-email-lrg@slimlogic.co.uk>
References: <1277639534-5104-1-git-send-email-lrg@slimlogic.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 633C71038CD
	for <alsa-devel@alsa-project.org>;
	Sun, 27 Jun 2010 13:52:53 +0200 (CEST)
Received: by wyf23 with SMTP id 23so919417wyf.38
	for <alsa-devel@alsa-project.org>; Sun, 27 Jun 2010 04:52:53 -0700 (PDT)
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

Update the Injenic J4740 platform and machines to new multi-component model.

This patch changes the machine drivers for multi-component as follows :-

 o Removed socdev
 o Each DAI link entry now contains platform and codec fields.
 o DAI link init() now passed snd_soc_pcm_runtime instread of snd_soc_codec.

This patch also changes the DAI and platform DAM drivers as follows :-

 o Each platform DAI and platform DMA driver is a kernel device and can
   have platform data.
 o DAI and Platform DMA drivers have private data accessors.

Signed-off-by: Liam Girdwood <lrg@slimlogic.co.uk>
---
 sound/soc/jz4740/jz4740-i2s.c |   57 ++++++++++++++++++++++------------------
 sound/soc/jz4740/jz4740-i2s.h |    2 +-
 sound/soc/jz4740/jz4740-pcm.c |   14 +++++-----
 sound/soc/jz4740/jz4740-pcm.h |    2 +-
 sound/soc/jz4740/qi_lb60.c    |   20 ++++++--------
 5 files changed, 48 insertions(+), 47 deletions(-)

diff --git a/sound/soc/jz4740/jz4740-i2s.c b/sound/soc/jz4740/jz4740-i2s.c
index eb518f0..218b20e 100644
--- a/sound/soc/jz4740/jz4740-i2s.c
+++ b/sound/soc/jz4740/jz4740-i2s.c
@@ -106,15 +106,10 @@ static inline void jz4740_i2s_write(const struct jz4740_i2s *i2s,
 	writel(value, i2s->base + reg);
 }
 
-static inline struct jz4740_i2s *jz4740_dai_to_i2s(struct snd_soc_dai *dai)
-{
-	return dai->private_data;
-}
-
 static int jz4740_i2s_startup(struct snd_pcm_substream *substream,
 	struct snd_soc_dai *dai)
 {
-	struct jz4740_i2s *i2s = jz4740_dai_to_i2s(dai);
+	struct jz4740_i2s *i2s = snd_soc_dai_get_drvdata(dai);
 	uint32_t conf, ctrl;
 
 	if (dai->active)
@@ -136,7 +131,7 @@ static int jz4740_i2s_startup(struct snd_pcm_substream *substream,
 static void jz4740_i2s_shutdown(struct snd_pcm_substream *substream,
 	struct snd_soc_dai *dai)
 {
-	struct jz4740_i2s *i2s = jz4740_dai_to_i2s(dai);
+	struct jz4740_i2s *i2s = snd_soc_dai_get_drvdata(dai);
 	uint32_t conf;
 
 	if (!dai->active)
@@ -152,7 +147,7 @@ static void jz4740_i2s_shutdown(struct snd_pcm_substream *substream,
 static int jz4740_i2s_trigger(struct snd_pcm_substream *substream, int cmd,
 	struct snd_soc_dai *dai)
 {
-	struct jz4740_i2s *i2s = jz4740_dai_to_i2s(dai);
+	struct jz4740_i2s *i2s = snd_soc_dai_get_drvdata(dai);
 
 	uint32_t ctrl;
 	uint32_t mask;
@@ -186,7 +181,7 @@ static int jz4740_i2s_trigger(struct snd_pcm_substream *substream, int cmd,
 
 static int jz4740_i2s_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 {
-	struct jz4740_i2s *i2s = jz4740_dai_to_i2s(dai);
+	struct jz4740_i2s *i2s = snd_soc_dai_get_drvdata(dai);
 
 	uint32_t format = 0;
 	uint32_t conf;
@@ -238,7 +233,7 @@ static int jz4740_i2s_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 static int jz4740_i2s_hw_params(struct snd_pcm_substream *substream,
 	struct snd_pcm_hw_params *params, struct snd_soc_dai *dai)
 {
-	struct jz4740_i2s *i2s = jz4740_dai_to_i2s(dai);
+	struct jz4740_i2s *i2s = snd_soc_dai_get_drvdata(dai);
 	enum jz4740_dma_width dma_width;
 	struct jz4740_pcm_config *pcm_config;
 	unsigned int sample_size;
@@ -288,7 +283,7 @@ static int jz4740_i2s_hw_params(struct snd_pcm_substream *substream,
 static int jz4740_i2s_set_sysclk(struct snd_soc_dai *dai, int clk_id,
 	unsigned int freq, int dir)
 {
-	struct jz4740_i2s *i2s = jz4740_dai_to_i2s(dai);
+	struct jz4740_i2s *i2s = snd_soc_dai_get_drvdata(dai);
 	struct clk *parent;
 	int ret = 0;
 
@@ -312,7 +307,7 @@ static int jz4740_i2s_set_sysclk(struct snd_soc_dai *dai, int clk_id,
 
 static int jz4740_i2s_suspend(struct snd_soc_dai *dai)
 {
-	struct jz4740_i2s *i2s = jz4740_dai_to_i2s(dai);
+	struct jz4740_i2s *i2s = snd_soc_dai_get_drvdata(dai);
 	uint32_t conf;
 
 	if (dai->active) {
@@ -330,7 +325,7 @@ static int jz4740_i2s_suspend(struct snd_soc_dai *dai)
 
 static int jz4740_i2s_resume(struct snd_soc_dai *dai)
 {
-	struct jz4740_i2s *i2s = jz4740_dai_to_i2s(dai);
+	struct jz4740_i2s *i2s = snd_soc_dai_get_drvdata(dai);
 	uint32_t conf;
 
 	clk_enable(i2s->clk_aic);
@@ -348,7 +343,7 @@ static int jz4740_i2s_resume(struct snd_soc_dai *dai)
 
 static int jz4740_i2s_probe(struct platform_device *pdev, struct snd_soc_dai *dai)
 {
-	struct jz4740_i2s *i2s = jz4740_dai_to_i2s(dai);
+	struct jz4740_i2s *i2s = snd_soc_dai_get_drvdata(dai);
 	uint32_t conf;
 
 	conf = (7 << JZ_AIC_CONF_FIFO_RX_THRESHOLD_OFFSET) |
@@ -375,7 +370,7 @@ static struct snd_soc_dai_ops jz4740_i2s_dai_ops = {
 #define JZ4740_I2S_FMTS (SNDRV_PCM_FMTBIT_S8 | \
 		SNDRV_PCM_FMTBIT_S16_LE)
 
-struct snd_soc_dai jz4740_i2s_dai = {
+struct snd_soc_dai_driver jz4740_i2s_dai = {
 	.name = "jz4740-i2s",
 	.probe = jz4740_i2s_probe,
 	.playback = {
@@ -420,6 +415,24 @@ static void __devinit jz4740_i2c_init_pcm_config(struct jz4740_i2s *i2s)
 	i2s->pcm_config_capture.fifo_addr = i2s->phys_base + JZ_REG_AIC_FIFO;
 }
 
+static int jz4740_i2s_dai_probe(struct snd_soc_dai *dai)
+{
+	struct jz4740_i2s *i2s = snd_soc_dai_get_drvdata(dai);
+
+	clk_enable(i2s->clk_aic);
+
+	jz4740_i2c_init_pcm_config(i2s);
+	return 0;
+}
+
+static int jz4740_i2s_dai_remove(struct snd_soc_dai *dai)
+{
+	struct jz4740_i2s *i2s = snd_soc_dai_get_drvdata(dai);
+
+	clk_disable(i2s->clk_aic);
+	return 0;
+}
+
 static int __devinit jz4740_i2s_dev_probe(struct platform_device *pdev)
 {
 	struct jz4740_i2s *i2s;
@@ -463,24 +476,17 @@ static int __devinit jz4740_i2s_dev_probe(struct platform_device *pdev)
 		goto err_clk_put_aic;
 	}
 
-	clk_enable(i2s->clk_aic);
-
-	jz4740_i2c_init_pcm_config(i2s);
-
-	jz4740_i2s_dai.private_data = i2s;
-	ret = snd_soc_register_dai(&jz4740_i2s_dai);
+	platform_set_drvdata(pdev, i2s);
+	ret = snd_soc_register_dai(&pdev->dev, pdev->id, &jz4740_i2s_dai);
 
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to register DAI\n");
 		goto err_clk_put_i2s;
 	}
 
-	platform_set_drvdata(pdev, i2s);
-
 	return 0;
 
 err_clk_put_i2s:
-	clk_disable(i2s->clk_aic);
 	clk_put(i2s->clk_i2s);
 err_clk_put_aic:
 	clk_put(i2s->clk_aic);
@@ -498,9 +504,8 @@ static int __devexit jz4740_i2s_dev_remove(struct platform_device *pdev)
 {
 	struct jz4740_i2s *i2s = platform_get_drvdata(pdev);
 
-	snd_soc_unregister_dai(&jz4740_i2s_dai);
+	snd_soc_unregister_dai(&pdev->dev, pdev->idi);
 
-	clk_disable(i2s->clk_aic);
 	clk_put(i2s->clk_i2s);
 	clk_put(i2s->clk_aic);
 
diff --git a/sound/soc/jz4740/jz4740-i2s.h b/sound/soc/jz4740/jz4740-i2s.h
index da22ed8..1a70972 100644
--- a/sound/soc/jz4740/jz4740-i2s.h
+++ b/sound/soc/jz4740/jz4740-i2s.h
@@ -13,6 +13,6 @@
 
 #define JZ4740_I2S_BIT_CLK		0
 
-extern struct snd_soc_dai jz4740_i2s_dai;
+extern struct snd_soc_dai_driver jz4740_i2s_dai;
 
 #endif
diff --git a/sound/soc/jz4740/jz4740-pcm.c b/sound/soc/jz4740/jz4740-pcm.c
index ee68d85..4b4819e 100644
--- a/sound/soc/jz4740/jz4740-pcm.c
+++ b/sound/soc/jz4740/jz4740-pcm.c
@@ -109,7 +109,7 @@ static int jz4740_pcm_hw_params(struct snd_pcm_substream *substream,
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct jz4740_pcm_config *config;
 
-	config = snd_soc_dai_get_dma_data(rtd->dai->cpu_dai, substream);
+	config = snd_soc_dai_get_dma_data(rtd->cpu_dai, substream);
 
 	if (!config)
 		return 0;
@@ -310,14 +310,14 @@ int jz4740_pcm_new(struct snd_card *card, struct snd_soc_dai *dai,
 	if (!card->dev->coherent_dma_mask)
 		card->dev->coherent_dma_mask = DMA_BIT_MASK(32);
 
-	if (dai->playback.channels_min) {
+	if (dai->driver->playback.channels_min) {
 		ret = jz4740_pcm_preallocate_dma_buffer(pcm,
 			SNDRV_PCM_STREAM_PLAYBACK);
 		if (ret)
 			goto err;
 	}
 
-	if (dai->capture.channels_min) {
+	if (dai->driver->capture.channels_min) {
 		ret = jz4740_pcm_preallocate_dma_buffer(pcm,
 			SNDRV_PCM_STREAM_CAPTURE);
 		if (ret)
@@ -328,9 +328,9 @@ err:
 	return ret;
 }
 
-struct snd_soc_platform jz4740_soc_platform = {
+struct snd_soc_platform_driver jz4740_soc_platform = {
 		.name		= "jz4740-pcm",
-		.pcm_ops	= &jz4740_pcm_ops,
+		.ops		= &jz4740_pcm_ops,
 		.pcm_new	= jz4740_pcm_new,
 		.pcm_free	= jz4740_pcm_free,
 };
@@ -338,12 +338,12 @@ EXPORT_SYMBOL_GPL(jz4740_soc_platform);
 
 static int __devinit jz4740_pcm_probe(struct platform_device *pdev)
 {
-	return snd_soc_register_platform(&jz4740_soc_platform);
+	return snd_soc_register_platform(&pdev->dev, -1, &jz4740_soc_platform);
 }
 
 static int __devexit jz4740_pcm_remove(struct platform_device *pdev)
 {
-	snd_soc_unregister_platform(&jz4740_soc_platform);
+	snd_soc_unregister_platform(&pdev->dev, -1);
 	return 0;
 }
 
diff --git a/sound/soc/jz4740/jz4740-pcm.h b/sound/soc/jz4740/jz4740-pcm.h
index e3f221e..f2a14da 100644
--- a/sound/soc/jz4740/jz4740-pcm.h
+++ b/sound/soc/jz4740/jz4740-pcm.h
@@ -12,7 +12,7 @@
 #include <asm/mach-jz4740/dma.h>
 
 /* platform data */
-extern struct snd_soc_platform jz4740_soc_platform;
+extern struct snd_soc_platform_driver jz4740_soc_platform;
 
 struct jz4740_pcm_config {
 	struct jz4740_dma_config dma_config;
diff --git a/sound/soc/jz4740/qi_lb60.c b/sound/soc/jz4740/qi_lb60.c
index f15f491..8c23d83 100644
--- a/sound/soc/jz4740/qi_lb60.c
+++ b/sound/soc/jz4740/qi_lb60.c
@@ -60,10 +60,11 @@ static const struct snd_soc_dapm_route qi_lb60_routes[] = {
 			SND_SOC_DAIFMT_NB_NF | \
 			SND_SOC_DAIFMT_CBM_CFM)
 
-static int qi_lb60_codec_init(struct snd_soc_codec *codec)
+static int qi_lb60_codec_init(struct snd_soc_pcm_runtime *rtd)
 {
+	struct snd_soc_codec *codec = rtd->codec;
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
 	int ret;
-	struct snd_soc_dai *cpu_dai = codec->socdev->card->dai_link->cpu_dai;
 
 	snd_soc_dapm_nc_pin(codec, "LIN");
 	snd_soc_dapm_nc_pin(codec, "RIN");
@@ -84,8 +85,10 @@ static int qi_lb60_codec_init(struct snd_soc_codec *codec)
 static struct snd_soc_dai_link qi_lb60_dai = {
 	.name = "jz4740",
 	.stream_name = "jz4740",
-	.cpu_dai = &jz4740_i2s_dai,
-	.codec_dai = &jz4740_codec_dai,
+	.cpu_dai_drv = &jz4740_i2s_dai,
+	.platform_drv = &jz4740_soc_platform,
+	.codec_dai_drv = &jz4740_codec_dai,
+	.codec_drv = &soc_codec_dev_jz4740_codec,
 	.init = qi_lb60_codec_init,
 };
 
@@ -93,12 +96,6 @@ static struct snd_soc_card qi_lb60 = {
 	.name = "QI LB60",
 	.dai_link = &qi_lb60_dai,
 	.num_links = 1,
-	.platform = &jz4740_soc_platform,
-};
-
-static struct snd_soc_device qi_lb60_snd_devdata = {
-	.card = &qi_lb60,
-	.codec_dev = &soc_codec_dev_jz4740_codec,
 };
 
 static struct platform_device *qi_lb60_snd_device;
@@ -129,8 +126,7 @@ static int __init qi_lb60_init(void)
 	gpio_direction_output(QI_LB60_SND_GPIO, 0);
 	gpio_direction_output(QI_LB60_AMP_GPIO, 0);
 
-	platform_set_drvdata(qi_lb60_snd_device, &qi_lb60_snd_devdata);
-	qi_lb60_snd_devdata.dev = &qi_lb60_snd_device->dev;
+	platform_set_drvdata(qi_lb60_snd_device, &qi_lb60);
 
 	ret = platform_device_add(qi_lb60_snd_device);
 	if (ret) {
-- 
1.7.0.4
