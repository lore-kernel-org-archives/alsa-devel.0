From: Mike Frysinger <vapier@gentoo.org>
Subject: [PATCH 3/3] ASoC: Blackfin: push down SPORT settings
	from global variables
Date: Mon, 28 Mar 2011 01:45:10 -0400
Message-ID: <1301291110-2443-3-git-send-email-vapier@gentoo.org>
References: <1301291110-2443-1-git-send-email-vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.gentoo.org (smtp.gentoo.org [140.211.166.183])
	by alsa0.perex.cz (Postfix) with ESMTP id F2F1810382C
	for <alsa-devel@alsa-project.org>;
	Mon, 28 Mar 2011 08:44:02 +0200 (CEST)
In-Reply-To: <1301291110-2443-1-git-send-email-vapier@gentoo.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: uclinux-dist-devel@blackfin.uclinux.org, Scott Jiang <scott.jiang@analog.com>, Barry Song <barry.song@analog.com>
List-Id: alsa-devel@alsa-project.org

From: Barry Song <barry.song@analog.com>

Now that we have multi-component support, take the time to unify the
SPORT implementations a bit and make the setup dynamic.  This kills
off the global sport_handle which was shared across all the Blackfin
machine drivers.  The pin management aspect is off loaded to platform
resources, and now multiple SPORTs can be instantiated simultaneously.

Signed-off-by: Barry Song <barry.song@analog.com>
Signed-off-by: Scott Jiang <scott.jiang@analog.com>
Signed-off-by: Mike Frysinger <vapier@gentoo.org>
---
 sound/soc/blackfin/bf5xx-ac97-pcm.c |   11 ++-
 sound/soc/blackfin/bf5xx-ac97.c     |  166 +++++++++++------------------------
 sound/soc/blackfin/bf5xx-ad1836.c   |   40 ++++----
 sound/soc/blackfin/bf5xx-ad193x.c   |   40 ++++----
 sound/soc/blackfin/bf5xx-ad1980.c   |   43 ++++-----
 sound/soc/blackfin/bf5xx-ad73311.c  |   40 ++++----
 sound/soc/blackfin/bf5xx-i2s-pcm.c  |   21 +++--
 sound/soc/blackfin/bf5xx-i2s.c      |  159 +++++++++++++--------------------
 sound/soc/blackfin/bf5xx-sport.c    |  159 +++++++++++++++++++++++++---------
 sound/soc/blackfin/bf5xx-sport.h    |   16 +++-
 sound/soc/blackfin/bf5xx-ssm2602.c  |   40 ++++----
 sound/soc/blackfin/bf5xx-tdm-pcm.c  |   21 +++--
 sound/soc/blackfin/bf5xx-tdm.c      |  110 ++++++++---------------
 13 files changed, 416 insertions(+), 450 deletions(-)

diff --git a/sound/soc/blackfin/bf5xx-ac97-pcm.c b/sound/soc/blackfin/bf5xx-ac97-pcm.c
index e940d26..98b44b3 100644
--- a/sound/soc/blackfin/bf5xx-ac97-pcm.c
+++ b/sound/soc/blackfin/bf5xx-ac97-pcm.c
@@ -243,6 +243,9 @@ static snd_pcm_uframes_t bf5xx_pcm_pointer(struct snd_pcm_substream *substream)
 
 static int bf5xx_pcm_open(struct snd_pcm_substream *substream)
 {
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
+	struct sport_device *sport_handle = snd_soc_dai_get_drvdata(cpu_dai);
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	int ret;
 
@@ -314,6 +317,9 @@ static struct snd_pcm_ops bf5xx_pcm_ac97_ops = {
 
 static int bf5xx_pcm_preallocate_dma_buffer(struct snd_pcm *pcm, int stream)
 {
+	struct snd_soc_pcm_runtime *rtd = pcm->private_data;
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
+	struct sport_device *sport_handle = snd_soc_dai_get_drvdata(cpu_dai);
 	struct snd_pcm_substream *substream = pcm->streams[stream].substream;
 	struct snd_dma_buffer *buf = &substream->dma_buffer;
 	size_t size = bf5xx_pcm_hardware.buffer_bytes_max
@@ -377,6 +383,9 @@ static void bf5xx_pcm_free_dma_buffers(struct snd_pcm *pcm)
 	struct snd_dma_buffer *buf;
 	int stream;
 #if defined(CONFIG_SND_BF5XX_MMAP_SUPPORT)
+	struct snd_soc_pcm_runtime *rtd = pcm->private_data;
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
+	struct sport_device *sport_handle = snd_soc_dai_get_drvdata(cpu_dai);
 	size_t size = bf5xx_pcm_hardware.buffer_bytes_max *
 		sizeof(struct ac97_frame) / 4;
 #endif
@@ -405,8 +414,6 @@ static void bf5xx_pcm_free_dma_buffers(struct snd_pcm *pcm)
 	}
 #endif
 	}
-	if (sport_handle)
-		sport_done(sport_handle);
 }
 
 static u64 bf5xx_pcm_dmamask = DMA_BIT_MASK(32);
diff --git a/sound/soc/blackfin/bf5xx-ac97.c b/sound/soc/blackfin/bf5xx-ac97.c
index ffbac26..6d21625 100644
--- a/sound/soc/blackfin/bf5xx-ac97.c
+++ b/sound/soc/blackfin/bf5xx-ac97.c
@@ -41,48 +41,7 @@
  *		anomaly does not affect blackfin sound drivers.
 */
 
-static int *cmd_count;
-static int sport_num = CONFIG_SND_BF5XX_SPORT_NUM;
-
-#define SPORT_REQ(x) \
-	[x] = {P_SPORT##x##_TFS, P_SPORT##x##_DTPRI, P_SPORT##x##_TSCLK, \
-	       P_SPORT##x##_RFS, P_SPORT##x##_DRPRI, P_SPORT##x##_RSCLK, 0}
-static u16 sport_req[][7] = {
-#ifdef SPORT0_TCR1
-	SPORT_REQ(0),
-#endif
-#ifdef SPORT1_TCR1
-	SPORT_REQ(1),
-#endif
-#ifdef SPORT2_TCR1
-	SPORT_REQ(2),
-#endif
-#ifdef SPORT3_TCR1
-	SPORT_REQ(3),
-#endif
-};
-
-#define SPORT_PARAMS(x) \
-	[x] = { \
-		.dma_rx_chan = CH_SPORT##x##_RX, \
-		.dma_tx_chan = CH_SPORT##x##_TX, \
-		.err_irq     = IRQ_SPORT##x##_ERROR, \
-		.regs        = (struct sport_register *)SPORT##x##_TCR1, \
-	}
-static struct sport_param sport_params[4] = {
-#ifdef SPORT0_TCR1
-	SPORT_PARAMS(0),
-#endif
-#ifdef SPORT1_TCR1
-	SPORT_PARAMS(1),
-#endif
-#ifdef SPORT2_TCR1
-	SPORT_PARAMS(2),
-#endif
-#ifdef SPORT3_TCR1
-	SPORT_PARAMS(3),
-#endif
-};
+static struct sport_device *ac97_sport_handle;
 
 void bf5xx_pcm_to_ac97(struct ac97_frame *dst, const __u16 *src,
 		size_t count, unsigned int chan_mask)
@@ -140,7 +99,8 @@ static unsigned int sport_tx_curr_frag(struct sport_device *sport)
 
 static void enqueue_cmd(struct snd_ac97 *ac97, __u16 addr, __u16 data)
 {
-	struct sport_device *sport = sport_handle;
+	struct sport_device *sport = ac97_sport_handle;
+	int *cmd_count = sport->private_data;
 	int nextfrag = sport_tx_curr_frag(sport);
 	struct ac97_frame *nextwrite;
 
@@ -161,6 +121,7 @@ static void enqueue_cmd(struct snd_ac97 *ac97, __u16 addr, __u16 data)
 static unsigned short bf5xx_ac97_read(struct snd_ac97 *ac97,
 	unsigned short reg)
 {
+	struct sport_device *sport_handle = ac97_sport_handle;
 	struct ac97_frame out_frame[2], in_frame[2];
 
 	pr_debug("%s enter 0x%x\n", __func__, reg);
@@ -185,6 +146,8 @@ static unsigned short bf5xx_ac97_read(struct snd_ac97 *ac97,
 void bf5xx_ac97_write(struct snd_ac97 *ac97, unsigned short reg,
 	unsigned short val)
 {
+	struct sport_device *sport_handle = ac97_sport_handle;
+
 	pr_debug("%s enter 0x%x:0x%04x\n", __func__, reg, val);
 
 	if (sport_handle->tx_run) {
@@ -203,28 +166,19 @@ void bf5xx_ac97_write(struct snd_ac97 *ac97, unsigned short reg,
 
 static void bf5xx_ac97_warm_reset(struct snd_ac97 *ac97)
 {
-#if defined(CONFIG_BF54x) || defined(CONFIG_BF561) || \
- (defined(BF537_FAMILY) && (CONFIG_SND_BF5XX_SPORT_NUM == 1))
-
-#define CONCAT(a, b, c) a ## b ## c
-#define BFIN_SPORT_RFS(x) CONCAT(P_SPORT, x, _RFS)
-
-	u16 per = BFIN_SPORT_RFS(CONFIG_SND_BF5XX_SPORT_NUM);
-	u16 gpio = P_IDENT(BFIN_SPORT_RFS(CONFIG_SND_BF5XX_SPORT_NUM));
+	struct sport_device *sport_handle = ac97_sport_handle;
+	u16 gpio = P_IDENT(sport_handle->pin_req[3]);
 
 	pr_debug("%s enter\n", __func__);
 
-	peripheral_free(per);
+	peripheral_free_list(sport_handle->pin_req);
 	gpio_request(gpio, "bf5xx-ac97");
 	gpio_direction_output(gpio, 1);
 	udelay(2);
 	gpio_set_value(gpio, 0);
 	udelay(1);
 	gpio_free(gpio);
-	peripheral_request(per, "soc-audio");
-#else
-	pr_info("%s: Not implemented\n", __func__);
-#endif
+	peripheral_request_list(sport_handle->pin_req, "soc-audio");
 }
 
 static void bf5xx_ac97_cold_reset(struct snd_ac97 *ac97)
@@ -306,18 +260,32 @@ static int bf5xx_ac97_resume(struct snd_soc_dai *dai)
 #define bf5xx_ac97_resume	NULL
 #endif
 
-static int bf5xx_ac97_probe(struct snd_soc_dai *dai)
+static struct snd_soc_dai_driver bfin_ac97_dai = {
+	.ac97_control = 1,
+	.suspend = bf5xx_ac97_suspend,
+	.resume = bf5xx_ac97_resume,
+	.playback = {
+		.stream_name = "AC97 Playback",
+		.channels_min = 2,
+#if defined(CONFIG_SND_BF5XX_MULTICHAN_SUPPORT)
+		.channels_max = 6,
+#else
+		.channels_max = 2,
+#endif
+		.rates = SNDRV_PCM_RATE_48000,
+		.formats = SNDRV_PCM_FMTBIT_S16_LE, },
+	.capture = {
+		.stream_name = "AC97 Capture",
+		.channels_min = 2,
+		.channels_max = 2,
+		.rates = SNDRV_PCM_RATE_48000,
+		.formats = SNDRV_PCM_FMTBIT_S16_LE, },
+};
+
+static int __devinit asoc_bfin_ac97_probe(struct platform_device *pdev)
 {
-	int ret = 0;
-	cmd_count = (int *)get_zeroed_page(GFP_KERNEL);
-	if (cmd_count == NULL)
-		return -ENOMEM;
-
-	if (peripheral_request_list(sport_req[sport_num], "soc-audio")) {
-		pr_err("Requesting Peripherals failed\n");
-		ret =  -EFAULT;
-		goto peripheral_err;
-	}
+	struct sport_device *sport_handle;
+	int ret;
 
 #ifdef CONFIG_SND_BF5XX_HAVE_COLD_RESET
 	/* Request PB3 as reset pin */
@@ -329,12 +297,14 @@ static int bf5xx_ac97_probe(struct snd_soc_dai *dai)
 	}
 	gpio_direction_output(CONFIG_SND_BF5XX_RESET_GPIO_NUM, 1);
 #endif
-	sport_handle = sport_init(&sport_params[sport_num], 2, \
-			sizeof(struct ac97_frame), NULL);
+
+	sport_handle = sport_init(pdev, 2, sizeof(struct ac97_frame),
+		PAGE_SIZE);
 	if (!sport_handle) {
 		ret = -ENODEV;
 		goto sport_err;
 	}
+
 	/*SPORT works in TDM mode to simulate AC97 transfers*/
 #if defined(CONFIG_SND_BF5XX_MULTICHAN_SUPPORT)
 	ret = sport_set_multichannel(sport_handle, 16, 0x3FF, 1);
@@ -361,67 +331,37 @@ static int bf5xx_ac97_probe(struct snd_soc_dai *dai)
 		goto sport_config_err;
 	}
 
+	ret = snd_soc_register_dai(&pdev->dev, &bfin_ac97_dai);
+	if (ret) {
+		pr_err("Failed to register DAI: %d\n", ret);
+		goto sport_config_err;
+	}
+
+	ac97_sport_handle = sport_handle;
+
 	return 0;
 
 sport_config_err:
-	kfree(sport_handle);
+	sport_done(sport_handle);
 sport_err:
 #ifdef CONFIG_SND_BF5XX_HAVE_COLD_RESET
 	gpio_free(CONFIG_SND_BF5XX_RESET_GPIO_NUM);
 gpio_err:
 #endif
-	peripheral_free_list(sport_req[sport_num]);
-peripheral_err:
-	free_page((unsigned long)cmd_count);
-	cmd_count = NULL;
 
 	return ret;
 }
 
-static int bf5xx_ac97_remove(struct snd_soc_dai *dai)
+static int __devexit asoc_bfin_ac97_remove(struct platform_device *pdev)
 {
-	free_page((unsigned long)cmd_count);
-	cmd_count = NULL;
-	peripheral_free_list(sport_req[sport_num]);
+	struct sport_device *sport_handle = platform_get_drvdata(pdev);
+
+	snd_soc_unregister_dai(&pdev->dev);
+	sport_done(sport_handle);
 #ifdef CONFIG_SND_BF5XX_HAVE_COLD_RESET
 	gpio_free(CONFIG_SND_BF5XX_RESET_GPIO_NUM);
 #endif
-	return 0;
-}
-
-struct snd_soc_dai_driver bfin_ac97_dai = {
-	.ac97_control = 1,
-	.probe = bf5xx_ac97_probe,
-	.remove = bf5xx_ac97_remove,
-	.suspend = bf5xx_ac97_suspend,
-	.resume = bf5xx_ac97_resume,
-	.playback = {
-		.stream_name = "AC97 Playback",
-		.channels_min = 2,
-#if defined(CONFIG_SND_BF5XX_MULTICHAN_SUPPORT)
-		.channels_max = 6,
-#else
-		.channels_max = 2,
-#endif
-		.rates = SNDRV_PCM_RATE_48000,
-		.formats = SNDRV_PCM_FMTBIT_S16_LE, },
-	.capture = {
-		.stream_name = "AC97 Capture",
-		.channels_min = 2,
-		.channels_max = 2,
-		.rates = SNDRV_PCM_RATE_48000,
-		.formats = SNDRV_PCM_FMTBIT_S16_LE, },
-};
-EXPORT_SYMBOL_GPL(bfin_ac97_dai);
-
-static __devinit int asoc_bfin_ac97_probe(struct platform_device *pdev)
-{
-	return snd_soc_register_dai(&pdev->dev, &bfin_ac97_dai);
-}
 
-static int __devexit asoc_bfin_ac97_remove(struct platform_device *pdev)
-{
-	snd_soc_unregister_dai(&pdev->dev);
 	return 0;
 }
 
diff --git a/sound/soc/blackfin/bf5xx-ad1836.c b/sound/soc/blackfin/bf5xx-ad1836.c
index 5d9d9e2..ea4951c 100644
--- a/sound/soc/blackfin/bf5xx-ad1836.c
+++ b/sound/soc/blackfin/bf5xx-ad1836.c
@@ -29,22 +29,12 @@
 #include <asm/portmux.h>
 
 #include "../codecs/ad1836.h"
-#include "bf5xx-sport.h"
 
 #include "bf5xx-tdm-pcm.h"
 #include "bf5xx-tdm.h"
 
 static struct snd_soc_card bf5xx_ad1836;
 
-static int bf5xx_ad1836_startup(struct snd_pcm_substream *substream)
-{
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
-
-	snd_soc_dai_set_drvdata(cpu_dai, sport_handle);
-	return 0;
-}
-
 static int bf5xx_ad1836_hw_params(struct snd_pcm_substream *substream,
 	struct snd_pcm_hw_params *params)
 {
@@ -75,23 +65,33 @@ static int bf5xx_ad1836_hw_params(struct snd_pcm_substream *substream,
 }
 
 static struct snd_soc_ops bf5xx_ad1836_ops = {
-	.startup = bf5xx_ad1836_startup,
 	.hw_params = bf5xx_ad1836_hw_params,
 };
 
-static struct snd_soc_dai_link bf5xx_ad1836_dai = {
-	.name = "ad1836",
-	.stream_name = "AD1836",
-	.cpu_dai_name = "bfin-tdm",
-	.codec_dai_name = "ad1836-hifi",
-	.platform_name = "bfin-tdm-pcm-audio",
-	.codec_name = "ad1836.0",
-	.ops = &bf5xx_ad1836_ops,
+static struct snd_soc_dai_link bf5xx_ad1836_dai[] = {
+	{
+		.name = "ad1836",
+		.stream_name = "AD1836",
+		.cpu_dai_name = "bfin-tdm.0",
+		.codec_dai_name = "ad1836-hifi",
+		.platform_name = "bfin-tdm-pcm-audio",
+		.codec_name = "ad1836.0",
+		.ops = &bf5xx_ad1836_ops,
+	},
+	{
+		.name = "ad1836",
+		.stream_name = "AD1836",
+		.cpu_dai_name = "bfin-tdm.1",
+		.codec_dai_name = "ad1836-hifi",
+		.platform_name = "bfin-tdm-pcm-audio",
+		.codec_name = "ad1836.0",
+		.ops = &bf5xx_ad1836_ops,
+	},
 };
 
 static struct snd_soc_card bf5xx_ad1836 = {
 	.name = "bfin-ad1836",
-	.dai_link = &bf5xx_ad1836_dai,
+	.dai_link = &bf5xx_ad1836_dai[CONFIG_SND_BF5XX_SPORT_NUM],
 	.num_links = 1,
 };
 
diff --git a/sound/soc/blackfin/bf5xx-ad193x.c b/sound/soc/blackfin/bf5xx-ad193x.c
index 355094f..d6651c0 100644
--- a/sound/soc/blackfin/bf5xx-ad193x.c
+++ b/sound/soc/blackfin/bf5xx-ad193x.c
@@ -38,22 +38,12 @@
 #include <asm/portmux.h>
 
 #include "../codecs/ad193x.h"
-#include "bf5xx-sport.h"
 
 #include "bf5xx-tdm-pcm.h"
 #include "bf5xx-tdm.h"
 
 static struct snd_soc_card bf5xx_ad193x;
 
-static int bf5xx_ad193x_startup(struct snd_pcm_substream *substream)
-{
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
-
-	snd_soc_dai_set_drvdata(cpu_dai, sport_handle);
-	return 0;
-}
-
 static int bf5xx_ad193x_hw_params(struct snd_pcm_substream *substream,
 	struct snd_pcm_hw_params *params)
 {
@@ -103,23 +93,33 @@ static int bf5xx_ad193x_hw_params(struct snd_pcm_substream *substream,
 }
 
 static struct snd_soc_ops bf5xx_ad193x_ops = {
-	.startup = bf5xx_ad193x_startup,
 	.hw_params = bf5xx_ad193x_hw_params,
 };
 
-static struct snd_soc_dai_link bf5xx_ad193x_dai = {
-	.name = "ad193x",
-	.stream_name = "AD193X",
-	.cpu_dai_name = "bfin-tdm",
-	.codec_dai_name ="ad193x-hifi",
-	.platform_name = "bfin-tdm-pcm-audio",
-	.codec_name = "ad193x.5",
-	.ops = &bf5xx_ad193x_ops,
+static struct snd_soc_dai_link bf5xx_ad193x_dai[] = {
+	{
+		.name = "ad193x",
+		.stream_name = "AD193X",
+		.cpu_dai_name = "bfin-tdm.0",
+		.codec_dai_name ="ad193x-hifi",
+		.platform_name = "bfin-tdm-pcm-audio",
+		.codec_name = "ad193x.5",
+		.ops = &bf5xx_ad193x_ops,
+	},
+	{
+		.name = "ad193x",
+		.stream_name = "AD193X",
+		.cpu_dai_name = "bfin-tdm.1",
+		.codec_dai_name ="ad193x-hifi",
+		.platform_name = "bfin-tdm-pcm-audio",
+		.codec_name = "ad193x.5",
+		.ops = &bf5xx_ad193x_ops,
+	},
 };
 
 static struct snd_soc_card bf5xx_ad193x = {
 	.name = "bfin-ad193x",
-	.dai_link = &bf5xx_ad193x_dai,
+	.dai_link = &bf5xx_ad193x_dai[CONFIG_SND_BF5XX_SPORT_NUM],
 	.num_links = 1,
 };
 
diff --git a/sound/soc/blackfin/bf5xx-ad1980.c b/sound/soc/blackfin/bf5xx-ad1980.c
index a381240..06a84b2 100644
--- a/sound/soc/blackfin/bf5xx-ad1980.c
+++ b/sound/soc/blackfin/bf5xx-ad1980.c
@@ -47,39 +47,34 @@
 #include <asm/portmux.h>
 
 #include "../codecs/ad1980.h"
-#include "bf5xx-sport.h"
+
 #include "bf5xx-ac97-pcm.h"
 #include "bf5xx-ac97.h"
 
 static struct snd_soc_card bf5xx_board;
 
-static int bf5xx_board_startup(struct snd_pcm_substream *substream)
-{
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
-
-	pr_debug("%s enter\n", __func__);
-	snd_soc_dai_set_drvdata(cpu_dai, sport_handle);
-	return 0;
-}
-
-static struct snd_soc_ops bf5xx_board_ops = {
-	.startup = bf5xx_board_startup,
-};
-
-static struct snd_soc_dai_link bf5xx_board_dai = {
-	.name = "AC97",
-	.stream_name = "AC97 HiFi",
-	.cpu_dai_name = "bfin-ac97",
-	.codec_dai_name = "ad1980-hifi",
-	.platform_name = "bfin-ac97-pcm-audio",
-	.codec_name = "ad1980",
-	.ops = &bf5xx_board_ops,
+static struct snd_soc_dai_link bf5xx_board_dai[] = {
+	{
+		.name = "AC97",
+		.stream_name = "AC97 HiFi",
+		.cpu_dai_name = "bfin-ac97.0",
+		.codec_dai_name = "ad1980-hifi",
+		.platform_name = "bfin-ac97-pcm-audio",
+		.codec_name = "ad1980",
+	},
+	{
+		.name = "AC97",
+		.stream_name = "AC97 HiFi",
+		.cpu_dai_name = "bfin-ac97.1",
+		.codec_dai_name = "ad1980-hifi",
+		.platform_name = "bfin-ac97-pcm-audio",
+		.codec_name = "ad1980",
+	},
 };
 
 static struct snd_soc_card bf5xx_board = {
 	.name = "bfin-ad1980",
-	.dai_link = &bf5xx_board_dai,
+	.dai_link = &bf5xx_board_dai[CONFIG_SND_BF5XX_SPORT_NUM],
 	.num_links = 1,
 };
 
diff --git a/sound/soc/blackfin/bf5xx-ad73311.c b/sound/soc/blackfin/bf5xx-ad73311.c
index 9f0d4f3..732a247 100644
--- a/sound/soc/blackfin/bf5xx-ad73311.c
+++ b/sound/soc/blackfin/bf5xx-ad73311.c
@@ -145,16 +145,6 @@ static int bf5xx_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int bf5xx_ad73311_startup(struct snd_pcm_substream *substream)
-{
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
-
-	pr_debug("%s enter\n", __func__);
-	snd_soc_dai_set_drvdata(cpu_dai, sport_handle);
-	return 0;
-}
-
 static int bf5xx_ad73311_hw_params(struct snd_pcm_substream *substream,
 	struct snd_pcm_hw_params *params)
 {
@@ -176,24 +166,34 @@ static int bf5xx_ad73311_hw_params(struct snd_pcm_substream *substream,
 
 
 static struct snd_soc_ops bf5xx_ad73311_ops = {
-	.startup = bf5xx_ad73311_startup,
 	.hw_params = bf5xx_ad73311_hw_params,
 };
 
-static struct snd_soc_dai_link bf5xx_ad73311_dai = {
-	.name = "ad73311",
-	.stream_name = "AD73311",
-	.cpu_dai_name = "bfin-i2s",
-	.codec_dai_name = "ad73311-hifi",
-	.platform_name = "bfin-i2s-pcm-audio",
-	.codec_name = "ad73311",
-	.ops = &bf5xx_ad73311_ops,
+static struct snd_soc_dai_link bf5xx_ad73311_dai[] = {
+	{
+		.name = "ad73311",
+		.stream_name = "AD73311",
+		.cpu_dai_name = "bfin-i2s.0",
+		.codec_dai_name = "ad73311-hifi",
+		.platform_name = "bfin-i2s-pcm-audio",
+		.codec_name = "ad73311",
+		.ops = &bf5xx_ad73311_ops,
+	},
+	{
+		.name = "ad73311",
+		.stream_name = "AD73311",
+		.cpu_dai_name = "bfin-i2s.1",
+		.codec_dai_name = "ad73311-hifi",
+		.platform_name = "bfin-i2s-pcm-audio",
+		.codec_name = "ad73311",
+		.ops = &bf5xx_ad73311_ops,
+	},
 };
 
 static struct snd_soc_card bf5xx_ad73311 = {
 	.name = "bfin-ad73311",
 	.probe = bf5xx_probe,
-	.dai_link = &bf5xx_ad73311_dai,
+	.dai_link = &bf5xx_ad73311_dai[CONFIG_SND_BF5XX_SPORT_NUM],
 	.num_links = 1,
 };
 
diff --git a/sound/soc/blackfin/bf5xx-i2s-pcm.c b/sound/soc/blackfin/bf5xx-i2s-pcm.c
index 50b1df8..b5101ef 100644
--- a/sound/soc/blackfin/bf5xx-i2s-pcm.c
+++ b/sound/soc/blackfin/bf5xx-i2s-pcm.c
@@ -148,10 +148,15 @@ static snd_pcm_uframes_t bf5xx_pcm_pointer(struct snd_pcm_substream *substream)
 
 static int bf5xx_pcm_open(struct snd_pcm_substream *substream)
 {
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
+	struct sport_device *sport_handle = snd_soc_dai_get_drvdata(cpu_dai);
 	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct snd_dma_buffer *buf = &substream->dma_buffer;
 	int ret;
 
 	pr_debug("%s enter\n", __func__);
+
 	snd_soc_set_runtime_hwparams(substream, &bf5xx_pcm_hardware);
 
 	ret = snd_pcm_hw_constraint_integer(runtime, \
@@ -159,9 +164,14 @@ static int bf5xx_pcm_open(struct snd_pcm_substream *substream)
 	if (ret < 0)
 		goto out;
 
-	if (sport_handle != NULL)
+	if (sport_handle != NULL) {
+		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+			sport_handle->tx_buf = buf->area;
+		else
+			sport_handle->rx_buf = buf->area;
+
 		runtime->private_data = sport_handle;
-	else {
+	} else {
 		pr_err("sport_handle is NULL\n");
 		return -1;
 	}
@@ -214,11 +224,6 @@ static int bf5xx_pcm_preallocate_dma_buffer(struct snd_pcm *pcm, int stream)
 	pr_debug("%s, area:%p, size:0x%08lx\n", __func__,
 		buf->area, buf->bytes);
 
-	if (stream == SNDRV_PCM_STREAM_PLAYBACK)
-		sport_handle->tx_buf = buf->area;
-	else
-		sport_handle->rx_buf = buf->area;
-
 	return 0;
 }
 
@@ -239,8 +244,6 @@ static void bf5xx_pcm_free_dma_buffers(struct snd_pcm *pcm)
 		dma_free_coherent(NULL, buf->bytes, buf->area, 0);
 		buf->area = NULL;
 	}
-	if (sport_handle)
-		sport_done(sport_handle);
 }
 
 static u64 bf5xx_pcm_dmamask = DMA_BIT_MASK(32);
diff --git a/sound/soc/blackfin/bf5xx-i2s.c b/sound/soc/blackfin/bf5xx-i2s.c
index dacd86c..00cc3e0 100644
--- a/sound/soc/blackfin/bf5xx-i2s.c
+++ b/sound/soc/blackfin/bf5xx-i2s.c
@@ -51,59 +51,24 @@ struct bf5xx_i2s_port {
 	int configured;
 };
 
-static struct bf5xx_i2s_port bf5xx_i2s;
-static int sport_num = CONFIG_SND_BF5XX_SPORT_NUM;
-
-static struct sport_param sport_params[2] = {
-	{
-		.dma_rx_chan	= CH_SPORT0_RX,
-		.dma_tx_chan	= CH_SPORT0_TX,
-		.err_irq	= IRQ_SPORT0_ERROR,
-		.regs		= (struct sport_register *)SPORT0_TCR1,
-	},
-	{
-		.dma_rx_chan	= CH_SPORT1_RX,
-		.dma_tx_chan	= CH_SPORT1_TX,
-		.err_irq	= IRQ_SPORT1_ERROR,
-		.regs		= (struct sport_register *)SPORT1_TCR1,
-	}
-};
-
-/*
- * Setting the TFS pin selector for SPORT 0 based on whether the selected
- * port id F or G. If the port is F then no conflict should exist for the
- * TFS. When Port G is selected and EMAC then there is a conflict between
- * the PHY interrupt line and TFS.  Current settings prevent the conflict
- * by ignoring the TFS pin when Port G is selected. This allows both
- * codecs and EMAC using Port G concurrently.
- */
-#ifdef CONFIG_BF527_SPORT0_PORTG
-#define LOCAL_SPORT0_TFS (0)
-#else
-#define LOCAL_SPORT0_TFS (P_SPORT0_TFS)
-#endif
-
-static u16 sport_req[][7] = { {P_SPORT0_DTPRI, P_SPORT0_TSCLK, P_SPORT0_RFS,
-		P_SPORT0_DRPRI, P_SPORT0_RSCLK, LOCAL_SPORT0_TFS, 0},
-		{P_SPORT1_DTPRI, P_SPORT1_TSCLK, P_SPORT1_RFS, P_SPORT1_DRPRI,
-		P_SPORT1_RSCLK, P_SPORT1_TFS, 0} };
-
 static int bf5xx_i2s_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 		unsigned int fmt)
 {
+	struct sport_device *sport_handle = snd_soc_dai_get_drvdata(cpu_dai);
+	struct bf5xx_i2s_port *bf5xx_i2s = sport_handle->private_data;
 	int ret = 0;
 
 	/* interface format:support I2S,slave mode */
 	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
 	case SND_SOC_DAIFMT_I2S:
-		bf5xx_i2s.tcr1 |= TFSR | TCKFE;
-		bf5xx_i2s.rcr1 |= RFSR | RCKFE;
-		bf5xx_i2s.tcr2 |= TSFSE;
-		bf5xx_i2s.rcr2 |= RSFSE;
+		bf5xx_i2s->tcr1 |= TFSR | TCKFE;
+		bf5xx_i2s->rcr1 |= RFSR | RCKFE;
+		bf5xx_i2s->tcr2 |= TSFSE;
+		bf5xx_i2s->rcr2 |= RSFSE;
 		break;
 	case SND_SOC_DAIFMT_DSP_A:
-		bf5xx_i2s.tcr1 |= TFSR;
-		bf5xx_i2s.rcr1 |= RFSR;
+		bf5xx_i2s->tcr1 |= TFSR;
+		bf5xx_i2s->rcr1 |= RFSR;
 		break;
 	case SND_SOC_DAIFMT_LEFT_J:
 		ret = -EINVAL;
@@ -135,33 +100,35 @@ static int bf5xx_i2s_hw_params(struct snd_pcm_substream *substream,
 				struct snd_pcm_hw_params *params,
 				struct snd_soc_dai *dai)
 {
+	struct sport_device *sport_handle = snd_soc_dai_get_drvdata(dai);
+	struct bf5xx_i2s_port *bf5xx_i2s = sport_handle->private_data;
 	int ret = 0;
 
-	bf5xx_i2s.tcr2 &= ~0x1f;
-	bf5xx_i2s.rcr2 &= ~0x1f;
+	bf5xx_i2s->tcr2 &= ~0x1f;
+	bf5xx_i2s->rcr2 &= ~0x1f;
 	switch (params_format(params)) {
 	case SNDRV_PCM_FORMAT_S8:
 		bf5xx_i2s->tcr2 |= 7;
 		bf5xx_i2s->rcr2 |= 7;
 		sport_handle->wdsize = 1;
 	case SNDRV_PCM_FORMAT_S16_LE:
-		bf5xx_i2s.tcr2 |= 15;
-		bf5xx_i2s.rcr2 |= 15;
+		bf5xx_i2s->tcr2 |= 15;
+		bf5xx_i2s->rcr2 |= 15;
 		sport_handle->wdsize = 2;
 		break;
 	case SNDRV_PCM_FORMAT_S24_LE:
-		bf5xx_i2s.tcr2 |= 23;
-		bf5xx_i2s.rcr2 |= 23;
+		bf5xx_i2s->tcr2 |= 23;
+		bf5xx_i2s->rcr2 |= 23;
 		sport_handle->wdsize = 3;
 		break;
 	case SNDRV_PCM_FORMAT_S32_LE:
-		bf5xx_i2s.tcr2 |= 31;
-		bf5xx_i2s.rcr2 |= 31;
+		bf5xx_i2s->tcr2 |= 31;
+		bf5xx_i2s->rcr2 |= 31;
 		sport_handle->wdsize = 4;
 		break;
 	}
 
-	if (!bf5xx_i2s.configured) {
+	if (!bf5xx_i2s->configured) {
 		/*
 		 * TX and RX are not independent,they are enabled at the
 		 * same time, even if only one side is running. So, we
@@ -170,16 +137,16 @@ static int bf5xx_i2s_hw_params(struct snd_pcm_substream *substream,
 		 *
 		 * CPU DAI:slave mode.
 		 */
-		bf5xx_i2s.configured = 1;
-		ret = sport_config_rx(sport_handle, bf5xx_i2s.rcr1,
-				      bf5xx_i2s.rcr2, 0, 0);
+		bf5xx_i2s->configured = 1;
+		ret = sport_config_rx(sport_handle, bf5xx_i2s->rcr1,
+				      bf5xx_i2s->rcr2, 0, 0);
 		if (ret) {
 			pr_err("SPORT is busy!\n");
 			return -EBUSY;
 		}
 
-		ret = sport_config_tx(sport_handle, bf5xx_i2s.tcr1,
-				      bf5xx_i2s.tcr2, 0, 0);
+		ret = sport_config_tx(sport_handle, bf5xx_i2s->tcr1,
+				      bf5xx_i2s->tcr2, 0, 0);
 		if (ret) {
 			pr_err("SPORT is busy!\n");
 			return -EBUSY;
@@ -192,41 +159,19 @@ static int bf5xx_i2s_hw_params(struct snd_pcm_substream *substream,
 static void bf5xx_i2s_shutdown(struct snd_pcm_substream *substream,
 			       struct snd_soc_dai *dai)
 {
+	struct sport_device *sport_handle = snd_soc_dai_get_drvdata(dai);
+	struct bf5xx_i2s_port *bf5xx_i2s = sport_handle->private_data;
+
 	pr_debug("%s enter\n", __func__);
 	/* No active stream, SPORT is allowed to be configured again. */
 	if (!dai->active)
-		bf5xx_i2s.configured = 0;
-}
-
-static int bf5xx_i2s_probe(struct snd_soc_dai *dai)
-{
-	pr_debug("%s enter\n", __func__);
-	if (peripheral_request_list(&sport_req[sport_num][0], "soc-audio")) {
-		pr_err("Requesting Peripherals failed\n");
-		return -EFAULT;
-	}
-
-	/* request DMA for SPORT */
-	sport_handle = sport_init(&sport_params[sport_num], 4, \
-			2 * sizeof(u32), NULL);
-	if (!sport_handle) {
-		peripheral_free_list(&sport_req[sport_num][0]);
-		return -ENODEV;
-	}
-
-	return 0;
-}
-
-static int bf5xx_i2s_remove(struct snd_soc_dai *dai)
-{
-	pr_debug("%s enter\n", __func__);
-	peripheral_free_list(&sport_req[sport_num][0]);
-	return 0;
+		bf5xx_i2s->configured = 0;
 }
 
 #ifdef CONFIG_PM
 static int bf5xx_i2s_suspend(struct snd_soc_dai *dai)
 {
+	struct sport_device *sport_handle = snd_soc_dai_get_drvdata(dai);
 
 	pr_debug("%s : sport %d\n", __func__, dai->id);
 
@@ -239,19 +184,21 @@ static int bf5xx_i2s_suspend(struct snd_soc_dai *dai)
 
 static int bf5xx_i2s_resume(struct snd_soc_dai *dai)
 {
+	struct sport_device *sport_handle = snd_soc_dai_get_drvdata(dai);
+	struct bf5xx_i2s_port *bf5xx_i2s = sport_handle->private_data;
 	int ret;
 
 	pr_debug("%s : sport %d\n", __func__, dai->id);
 
-	ret = sport_config_rx(sport_handle, bf5xx_i2s.rcr1,
-				      bf5xx_i2s.rcr2, 0, 0);
+	ret = sport_config_rx(sport_handle, bf5xx_i2s->rcr1,
+				      bf5xx_i2s->rcr2, 0, 0);
 	if (ret) {
 		pr_err("SPORT is busy!\n");
 		return -EBUSY;
 	}
 
-	ret = sport_config_tx(sport_handle, bf5xx_i2s.tcr1,
-				      bf5xx_i2s.tcr2, 0, 0);
+	ret = sport_config_tx(sport_handle, bf5xx_i2s->tcr1,
+				      bf5xx_i2s->tcr2, 0, 0);
 	if (ret) {
 		pr_err("SPORT is busy!\n");
 		return -EBUSY;
@@ -283,8 +230,6 @@ static struct snd_soc_dai_ops bf5xx_i2s_dai_ops = {
 };
 
 static struct snd_soc_dai_driver bf5xx_i2s_dai = {
-	.probe = bf5xx_i2s_probe,
-	.remove = bf5xx_i2s_remove,
 	.suspend = bf5xx_i2s_suspend,
 	.resume = bf5xx_i2s_resume,
 	.playback = {
@@ -300,21 +245,43 @@ static struct snd_soc_dai_driver bf5xx_i2s_dai = {
 	.ops = &bf5xx_i2s_dai_ops,
 };
 
-static int bfin_i2s_drv_probe(struct platform_device *pdev)
+static int __devinit bf5xx_i2s_probe(struct platform_device *pdev)
 {
-	return snd_soc_register_dai(&pdev->dev, &bf5xx_i2s_dai);
+	struct sport_device *sport_handle;
+	int ret;
+
+	/* configure SPORT for I2S */
+	sport_handle = sport_init(pdev, 4, 2 * sizeof(u32),
+		sizeof(struct bf5xx_i2s_port));
+	if (!sport_handle)
+		return -ENODEV;
+
+	/* register with the ASoC layers */
+	ret = snd_soc_register_dai(&pdev->dev, &bf5xx_i2s_dai);
+	if (ret) {
+		pr_err("Failed to register DAI: %d\n", ret);
+		sport_done(sport_handle);
+		return ret;
+	}
+
+	return 0;
 }
 
-static int __devexit bfin_i2s_drv_remove(struct platform_device *pdev)
+static int __devexit bf5xx_i2s_remove(struct platform_device *pdev)
 {
+	struct sport_device *sport_handle = platform_get_drvdata(pdev);
+
+	pr_debug("%s enter\n", __func__);
+
 	snd_soc_unregister_dai(&pdev->dev);
+	sport_done(sport_handle);
+
 	return 0;
 }
 
 static struct platform_driver bfin_i2s_driver = {
-	.probe = bfin_i2s_drv_probe,
-	.remove = __devexit_p(bfin_i2s_drv_remove),
-
+	.probe  = bf5xx_i2s_probe,
+	.remove = __devexit_p(bf5xx_i2s_remove),
 	.driver = {
 		.name = "bfin-i2s",
 		.owner = THIS_MODULE,
diff --git a/sound/soc/blackfin/bf5xx-sport.c b/sound/soc/blackfin/bf5xx-sport.c
index 99051ff..a2d4034 100644
--- a/sound/soc/blackfin/bf5xx-sport.c
+++ b/sound/soc/blackfin/bf5xx-sport.c
@@ -42,8 +42,6 @@
 /* delay between frame sync pulse and first data bit in multichannel mode */
 #define FRAME_DELAY (1<<12)
 
-struct sport_device *sport_handle;
-EXPORT_SYMBOL(sport_handle);
 /* note: multichannel is in units of 8 channels,
  * tdm_count is # channels NOT / 8 ! */
 int sport_set_multichannel(struct sport_device *sport,
@@ -798,86 +796,164 @@ int sport_set_err_callback(struct sport_device *sport,
 }
 EXPORT_SYMBOL(sport_set_err_callback);
 
-struct sport_device *sport_init(struct sport_param *param, unsigned wdsize,
-		unsigned dummy_count, void *private_data)
+static int sport_config_pdev(struct platform_device *pdev, struct sport_param *param)
 {
-	int ret;
+	/* Extract settings from platform data */
+	struct device *dev = &pdev->dev;
+	struct bfin_snd_platform_data *pdata = dev->platform_data;
+	struct resource *res;
+
+	param->num = pdev->id;
+
+	if (!pdata) {
+		dev_err(dev, "no platform_data\n");
+		return -ENODEV;
+	}
+	param->pin_req = pdata->pin_req;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		dev_err(dev, "no MEM resource\n");
+		return -ENODEV;
+	}
+	param->regs = (struct sport_register *)res->start;
+
+	/* first RX, then TX */
+	res = platform_get_resource(pdev, IORESOURCE_DMA, 0);
+	if (!res) {
+		dev_err(dev, "no rx DMA resource\n");
+		return -ENODEV;
+	}
+	param->dma_rx_chan = res->start;
+
+	res = platform_get_resource(pdev, IORESOURCE_DMA, 1);
+	if (!res) {
+		dev_err(dev, "no tx DMA resource\n");
+		return -ENODEV;
+	}
+	param->dma_tx_chan = res->start;
+
+	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
+	if (!res) {
+		dev_err(dev, "no irq resource\n");
+		return -ENODEV;
+	}
+	param->err_irq = res->start;
+
+	return 0;
+}
+
+struct sport_device *sport_init(struct platform_device *pdev,
+	unsigned int wdsize, unsigned int dummy_count, size_t priv_size)
+{
+	struct device *dev = &pdev->dev;
+	struct sport_param param;
 	struct sport_device *sport;
-	pr_debug("%s enter\n", __func__);
-	BUG_ON(param == NULL);
-	BUG_ON(wdsize == 0 || dummy_count == 0);
-	sport = kmalloc(sizeof(struct sport_device), GFP_KERNEL);
-	if (!sport) {
-		pr_err("Failed to allocate for sport device\n");
+	int ret;
+
+	dev_dbg(dev, "%s enter\n", __func__);
+
+	param.wdsize = wdsize;
+	param.dummy_count = dummy_count;
+	BUG_ON(param.wdsize == 0 || param.dummy_count == 0);
+
+	ret = sport_config_pdev(pdev, &param);
+	if (ret)
+		return NULL;
+
+	if (peripheral_request_list(param.pin_req, "soc-audio")) {
+		dev_err(dev, "requesting Peripherals failed\n");
 		return NULL;
 	}
 
-	memset(sport, 0, sizeof(struct sport_device));
-	sport->dma_rx_chan = param->dma_rx_chan;
-	sport->dma_tx_chan = param->dma_tx_chan;
-	sport->err_irq = param->err_irq;
-	sport->regs = param->regs;
-	sport->private_data = private_data;
+	sport = kzalloc(sizeof(*sport), GFP_KERNEL);
+	if (!sport) {
+		dev_err(dev, "failed to allocate for sport device\n");
+		goto __init_err0;
+	}
+
+	sport->num = param.num;
+	sport->dma_rx_chan = param.dma_rx_chan;
+	sport->dma_tx_chan = param.dma_tx_chan;
+	sport->err_irq = param.err_irq;
+	sport->regs = param.regs;
+	sport->pin_req = param.pin_req;
 
 	if (request_dma(sport->dma_rx_chan, "SPORT RX Data") == -EBUSY) {
-		pr_err("Failed to request RX dma %d\n", \
-				sport->dma_rx_chan);
+		dev_err(dev, "failed to request RX dma %d\n", sport->dma_rx_chan);
 		goto __init_err1;
 	}
 	if (set_dma_callback(sport->dma_rx_chan, rx_handler, sport) != 0) {
-		pr_err("Failed to request RX irq %d\n", \
-				sport->dma_rx_chan);
+		dev_err(dev, "failed to request RX irq %d\n", sport->dma_rx_chan);
 		goto __init_err2;
 	}
 
 	if (request_dma(sport->dma_tx_chan, "SPORT TX Data") == -EBUSY) {
-		pr_err("Failed to request TX dma %d\n", \
-				sport->dma_tx_chan);
+		dev_err(dev, "failed to request TX dma %d\n", sport->dma_tx_chan);
 		goto __init_err2;
 	}
 
 	if (set_dma_callback(sport->dma_tx_chan, tx_handler, sport) != 0) {
-		pr_err("Failed to request TX irq %d\n", \
-				sport->dma_tx_chan);
+		dev_err(dev, "failed to request TX irq %d\n", sport->dma_tx_chan);
 		goto __init_err3;
 	}
 
 	if (request_irq(sport->err_irq, err_handler, IRQF_SHARED, "SPORT err",
 			sport) < 0) {
-		pr_err("Failed to request err irq:%d\n", \
-				sport->err_irq);
+		dev_err(dev, "failed to request err irq %d\n", sport->err_irq);
 		goto __init_err3;
 	}
 
-	pr_err("dma rx:%d tx:%d, err irq:%d, regs:%p\n",
+	dev_info(dev, "dma rx:%d tx:%d, err irq:%d, regs:%p\n",
 			sport->dma_rx_chan, sport->dma_tx_chan,
 			sport->err_irq, sport->regs);
 
-	sport->wdsize = wdsize;
-	sport->dummy_count = dummy_count;
+	sport->wdsize = param.wdsize;
+	sport->dummy_count = param.dummy_count;
+
+	sport->private_data = kzalloc(priv_size, GFP_KERNEL);
+	if (!sport->private_data) {
+		dev_err(dev, "could not alloc priv data %zu bytes\n", priv_size);
+		goto __init_err4;
+	}
 
 	if (L1_DATA_A_LENGTH)
-		sport->dummy_buf = l1_data_sram_zalloc(dummy_count * 2);
+		sport->dummy_buf = l1_data_sram_zalloc(param.dummy_count * 2);
 	else
-		sport->dummy_buf = kzalloc(dummy_count * 2, GFP_KERNEL);
+		sport->dummy_buf = kzalloc(param.dummy_count * 2, GFP_KERNEL);
 	if (sport->dummy_buf == NULL) {
-		pr_err("Failed to allocate dummy buffer\n");
-		goto __error;
+		dev_err(dev, "failed to allocate dummy buffer\n");
+		goto __error1;
 	}
 
 	ret = sport_config_rx_dummy(sport);
 	if (ret) {
-		pr_err("Failed to config rx dummy ring\n");
-		goto __error;
+		dev_err(dev, "failed to config rx dummy ring\n");
+		goto __error2;
 	}
 	ret = sport_config_tx_dummy(sport);
 	if (ret) {
-		pr_err("Failed to config tx dummy ring\n");
-		goto __error;
+		dev_err(dev, "failed to config tx dummy ring\n");
+		goto __error3;
 	}
 
+	platform_set_drvdata(pdev, sport);
+
 	return sport;
-__error:
+__error3:
+	if (L1_DATA_A_LENGTH)
+		l1_data_sram_free(sport->dummy_rx_desc);
+	else
+		dma_free_coherent(NULL, 2*sizeof(struct dmasg),
+				sport->dummy_rx_desc, 0);
+__error2:
+	if (L1_DATA_A_LENGTH)
+		l1_data_sram_free(sport->dummy_buf);
+	else
+		kfree(sport->dummy_buf);
+__error1:
+	kfree(sport->private_data);
+__init_err4:
 	free_irq(sport->err_irq, sport);
 __init_err3:
 	free_dma(sport->dma_tx_chan);
@@ -885,6 +961,8 @@ __init_err2:
 	free_dma(sport->dma_rx_chan);
 __init_err1:
 	kfree(sport);
+__init_err0:
+	peripheral_free_list(param.pin_req);
 	return NULL;
 }
 EXPORT_SYMBOL(sport_init);
@@ -917,8 +995,9 @@ void sport_done(struct sport_device *sport)
 	free_dma(sport->dma_tx_chan);
 	free_irq(sport->err_irq, sport);
 
+	kfree(sport->private_data);
+	peripheral_free_list(sport->pin_req);
 	kfree(sport);
-		sport = NULL;
 }
 EXPORT_SYMBOL(sport_done);
 
diff --git a/sound/soc/blackfin/bf5xx-sport.h b/sound/soc/blackfin/bf5xx-sport.h
index a86e8cc..5ab60bd 100644
--- a/sound/soc/blackfin/bf5xx-sport.h
+++ b/sound/soc/blackfin/bf5xx-sport.h
@@ -1,5 +1,5 @@
 /*
- * File:         bf5xx_ac97_sport.h
+ * File:         bf5xx_sport.h
  * Based on:
  * Author:       Roy Huang <roy.huang@analog.com>
  *
@@ -33,15 +33,18 @@
 #include <linux/types.h>
 #include <linux/wait.h>
 #include <linux/workqueue.h>
+#include <linux/platform_device.h>
 #include <asm/dma.h>
 #include <asm/bfin_sport.h>
 
 #define DESC_ELEMENT_COUNT 9
 
 struct sport_device {
+	int num;
 	int dma_rx_chan;
 	int dma_tx_chan;
 	int err_irq;
+	const unsigned short *pin_req;
 	struct sport_register *regs;
 
 	unsigned char *rx_buf;
@@ -103,17 +106,20 @@ struct sport_device {
 	void *private_data;
 };
 
-extern struct sport_device *sport_handle;
-
 struct sport_param {
+	int num;
 	int dma_rx_chan;
 	int dma_tx_chan;
 	int err_irq;
+	const unsigned short *pin_req;
 	struct sport_register *regs;
+	unsigned int wdsize;
+	unsigned int dummy_count;
+	void *private_data;
 };
 
-struct sport_device *sport_init(struct sport_param *param, unsigned wdsize,
-		unsigned dummy_count, void *private_data);
+struct sport_device *sport_init(struct platform_device *pdev,
+	unsigned int wdsize, unsigned int dummy_count, size_t priv_size);
 
 void sport_done(struct sport_device *sport);
 
diff --git a/sound/soc/blackfin/bf5xx-ssm2602.c b/sound/soc/blackfin/bf5xx-ssm2602.c
index 8a7b589..767e772 100644
--- a/sound/soc/blackfin/bf5xx-ssm2602.c
+++ b/sound/soc/blackfin/bf5xx-ssm2602.c
@@ -44,16 +44,6 @@
 
 static struct snd_soc_card bf5xx_ssm2602;
 
-static int bf5xx_ssm2602_startup(struct snd_pcm_substream *substream)
-{
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
-
-	pr_debug("%s enter\n", __func__);
-	snd_soc_dai_set_drvdata(cpu_dai, sport_handle);
-	return 0;
-}
-
 static int bf5xx_ssm2602_hw_params(struct snd_pcm_substream *substream,
 	struct snd_pcm_hw_params *params)
 {
@@ -109,23 +99,33 @@ static int bf5xx_ssm2602_hw_params(struct snd_pcm_substream *substream,
 }
 
 static struct snd_soc_ops bf5xx_ssm2602_ops = {
-	.startup = bf5xx_ssm2602_startup,
 	.hw_params = bf5xx_ssm2602_hw_params,
 };
 
-static struct snd_soc_dai_link bf5xx_ssm2602_dai = {
-	.name = "ssm2602",
-	.stream_name = "SSM2602",
-	.cpu_dai_name = "bfin-i2s",
-	.codec_dai_name = "ssm2602-hifi",
-	.platform_name = "bfin-i2s-pcm-audio",
-	.codec_name = "ssm2602.0-001b",
-	.ops = &bf5xx_ssm2602_ops,
+static struct snd_soc_dai_link bf5xx_ssm2602_dai[] = {
+	{
+		.name = "ssm2602",
+		.stream_name = "SSM2602",
+		.cpu_dai_name = "bfin-i2s.0",
+		.codec_dai_name = "ssm2602-hifi",
+		.platform_name = "bfin-i2s-pcm-audio",
+		.codec_name = "ssm2602.0-001b",
+		.ops = &bf5xx_ssm2602_ops,
+	},
+	{
+		.name = "ssm2602",
+		.stream_name = "SSM2602",
+		.cpu_dai_name = "bfin-i2s.1",
+		.codec_dai_name = "ssm2602-hifi",
+		.platform_name = "bfin-i2s-pcm-audio",
+		.codec_name = "ssm2602.0-001b",
+		.ops = &bf5xx_ssm2602_ops,
+	},
 };
 
 static struct snd_soc_card bf5xx_ssm2602 = {
 	.name = "bfin-ssm2602",
-	.dai_link = &bf5xx_ssm2602_dai,
+	.dai_link = &bf5xx_ssm2602_dai[CONFIG_SND_BF5XX_SPORT_NUM],
 	.num_links = 1,
 };
 
diff --git a/sound/soc/blackfin/bf5xx-tdm-pcm.c b/sound/soc/blackfin/bf5xx-tdm-pcm.c
index d1bd745..07cfc7a 100644
--- a/sound/soc/blackfin/bf5xx-tdm-pcm.c
+++ b/sound/soc/blackfin/bf5xx-tdm-pcm.c
@@ -154,7 +154,12 @@ static snd_pcm_uframes_t bf5xx_pcm_pointer(struct snd_pcm_substream *substream)
 
 static int bf5xx_pcm_open(struct snd_pcm_substream *substream)
 {
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
+	struct sport_device *sport_handle = snd_soc_dai_get_drvdata(cpu_dai);
 	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct snd_dma_buffer *buf = &substream->dma_buffer;
+
 	int ret = 0;
 
 	snd_soc_set_runtime_hwparams(substream, &bf5xx_pcm_hardware);
@@ -164,9 +169,14 @@ static int bf5xx_pcm_open(struct snd_pcm_substream *substream)
 	if (ret < 0)
 		goto out;
 
-	if (sport_handle != NULL)
+	if (sport_handle != NULL) {
+		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+			sport_handle->tx_buf = buf->area;
+		else
+			sport_handle->rx_buf = buf->area;
+
 		runtime->private_data = sport_handle;
-	else {
+	} else {
 		pr_err("sport_handle is NULL\n");
 		ret = -ENODEV;
 	}
@@ -249,11 +259,6 @@ static int bf5xx_pcm_preallocate_dma_buffer(struct snd_pcm *pcm, int stream)
 	}
 	buf->bytes = size;
 
-	if (stream == SNDRV_PCM_STREAM_PLAYBACK)
-		sport_handle->tx_buf = buf->area;
-	else
-		sport_handle->rx_buf = buf->area;
-
 	return 0;
 }
 
@@ -274,8 +279,6 @@ static void bf5xx_pcm_free_dma_buffers(struct snd_pcm *pcm)
 		dma_free_coherent(NULL, buf->bytes, buf->area, 0);
 		buf->area = NULL;
 	}
-	if (sport_handle)
-		sport_done(sport_handle);
 }
 
 static u64 bf5xx_pcm_dmamask = DMA_BIT_MASK(32);
diff --git a/sound/soc/blackfin/bf5xx-tdm.c b/sound/soc/blackfin/bf5xx-tdm.c
index 5515ac9..a822d1e 100644
--- a/sound/soc/blackfin/bf5xx-tdm.c
+++ b/sound/soc/blackfin/bf5xx-tdm.c
@@ -46,43 +46,6 @@
 #include "bf5xx-sport.h"
 #include "bf5xx-tdm.h"
 
-static struct bf5xx_tdm_port bf5xx_tdm;
-static int sport_num = CONFIG_SND_BF5XX_SPORT_NUM;
-
-static struct sport_param sport_params[2] = {
-	{
-		.dma_rx_chan    = CH_SPORT0_RX,
-		.dma_tx_chan    = CH_SPORT0_TX,
-		.err_irq        = IRQ_SPORT0_ERROR,
-		.regs           = (struct sport_register *)SPORT0_TCR1,
-	},
-	{
-		.dma_rx_chan    = CH_SPORT1_RX,
-		.dma_tx_chan    = CH_SPORT1_TX,
-		.err_irq        = IRQ_SPORT1_ERROR,
-		.regs           = (struct sport_register *)SPORT1_TCR1,
-	}
-};
-
-/*
- * Setting the TFS pin selector for SPORT 0 based on whether the selected
- * port id F or G. If the port is F then no conflict should exist for the
- * TFS. When Port G is selected and EMAC then there is a conflict between
- * the PHY interrupt line and TFS.  Current settings prevent the conflict
- * by ignoring the TFS pin when Port G is selected. This allows both
- * codecs and EMAC using Port G concurrently.
- */
-#ifdef CONFIG_BF527_SPORT0_PORTG
-#define LOCAL_SPORT0_TFS (0)
-#else
-#define LOCAL_SPORT0_TFS (P_SPORT0_TFS)
-#endif
-
-static u16 sport_req[][7] = { {P_SPORT0_DTPRI, P_SPORT0_TSCLK, P_SPORT0_RFS,
-	P_SPORT0_DRPRI, P_SPORT0_RSCLK, LOCAL_SPORT0_TFS, 0},
-	   {P_SPORT1_DTPRI, P_SPORT1_TSCLK, P_SPORT1_RFS, P_SPORT1_DRPRI,
-		   P_SPORT1_RSCLK, P_SPORT1_TFS, 0} };
-
 static int bf5xx_tdm_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 	unsigned int fmt)
 {
@@ -119,14 +82,16 @@ static int bf5xx_tdm_hw_params(struct snd_pcm_substream *substream,
 	struct snd_pcm_hw_params *params,
 	struct snd_soc_dai *dai)
 {
+	struct sport_device *sport_handle = snd_soc_dai_get_drvdata(dai);
+	struct bf5xx_tdm_port *bf5xx_tdm = sport_handle->private_data;
 	int ret = 0;
 
-	bf5xx_tdm.tcr2 &= ~0x1f;
-	bf5xx_tdm.rcr2 &= ~0x1f;
+	bf5xx_tdm->tcr2 &= ~0x1f;
+	bf5xx_tdm->rcr2 &= ~0x1f;
 	switch (params_format(params)) {
 	case SNDRV_PCM_FORMAT_S32_LE:
-		bf5xx_tdm.tcr2 |= 31;
-		bf5xx_tdm.rcr2 |= 31;
+		bf5xx_tdm->tcr2 |= 31;
+		bf5xx_tdm->rcr2 |= 31;
 		sport_handle->wdsize = 4;
 		break;
 		/* at present, we only support 32bit transfer */
@@ -136,7 +101,7 @@ static int bf5xx_tdm_hw_params(struct snd_pcm_substream *substream,
 		break;
 	}
 
-	if (!bf5xx_tdm.configured) {
+	if (!bf5xx_tdm->configured) {
 		/*
 		 * TX and RX are not independent,they are enabled at the
 		 * same time, even if only one side is running. So, we
@@ -145,21 +110,21 @@ static int bf5xx_tdm_hw_params(struct snd_pcm_substream *substream,
 		 *
 		 * CPU DAI:slave mode.
 		 */
-		ret = sport_config_rx(sport_handle, bf5xx_tdm.rcr1,
-			bf5xx_tdm.rcr2, 0, 0);
+		ret = sport_config_rx(sport_handle, bf5xx_tdm->rcr1,
+			bf5xx_tdm->rcr2, 0, 0);
 		if (ret) {
 			pr_err("SPORT is busy!\n");
 			return -EBUSY;
 		}
 
-		ret = sport_config_tx(sport_handle, bf5xx_tdm.tcr1,
-			bf5xx_tdm.tcr2, 0, 0);
+		ret = sport_config_tx(sport_handle, bf5xx_tdm->tcr1,
+			bf5xx_tdm->tcr2, 0, 0);
 		if (ret) {
 			pr_err("SPORT is busy!\n");
 			return -EBUSY;
 		}
 
-		bf5xx_tdm.configured = 1;
+		bf5xx_tdm->configured = 1;
 	}
 
 	return 0;
@@ -168,15 +133,20 @@ static int bf5xx_tdm_hw_params(struct snd_pcm_substream *substream,
 static void bf5xx_tdm_shutdown(struct snd_pcm_substream *substream,
 	struct snd_soc_dai *dai)
 {
+	struct sport_device *sport_handle = snd_soc_dai_get_drvdata(dai);
+	struct bf5xx_tdm_port *bf5xx_tdm = sport_handle->private_data;
+
 	/* No active stream, SPORT is allowed to be configured again. */
 	if (!dai->active)
-		bf5xx_tdm.configured = 0;
+		bf5xx_tdm->configured = 0;
 }
 
 static int bf5xx_tdm_set_channel_map(struct snd_soc_dai *dai,
 		unsigned int tx_num, unsigned int *tx_slot,
 		unsigned int rx_num, unsigned int *rx_slot)
 {
+	struct sport_device *sport_handle = snd_soc_dai_get_drvdata(dai);
+	struct bf5xx_tdm_port *bf5xx_tdm = sport_handle->private_data;
 	int i;
 	unsigned int slot;
 	unsigned int tx_mapped = 0, rx_mapped = 0;
@@ -189,7 +159,7 @@ static int bf5xx_tdm_set_channel_map(struct snd_soc_dai *dai,
 		slot = tx_slot[i];
 		if ((slot < BFIN_TDM_DAI_MAX_SLOTS) &&
 				(!(tx_mapped & (1 << slot)))) {
-			bf5xx_tdm.tx_map[i] = slot;
+			bf5xx_tdm->tx_map[i] = slot;
 			tx_mapped |= 1 << slot;
 		} else
 			return -EINVAL;
@@ -198,7 +168,7 @@ static int bf5xx_tdm_set_channel_map(struct snd_soc_dai *dai,
 		slot = rx_slot[i];
 		if ((slot < BFIN_TDM_DAI_MAX_SLOTS) &&
 				(!(rx_mapped & (1 << slot)))) {
-			bf5xx_tdm.rx_map[i] = slot;
+			bf5xx_tdm->rx_map[i] = slot;
 			rx_mapped |= 1 << slot;
 		} else
 			return -EINVAL;
@@ -212,12 +182,14 @@ static int bf5xx_tdm_suspend(struct snd_soc_dai *dai)
 {
 	struct sport_device *sport = snd_soc_dai_get_drvdata(dai);
 
-	if (!dai->active)
-		return 0;
-	if (dai->capture_active)
-		sport_rx_stop(sport);
 	if (dai->playback_active)
 		sport_tx_stop(sport);
+	if (dai->capture_active)
+		sport_rx_stop(sport);
+
+	/* isolate sync/clock pins from codec while sports resume */
+	peripheral_free_list(sport->pin_req);
+
 	return 0;
 }
 
@@ -226,9 +198,6 @@ static int bf5xx_tdm_resume(struct snd_soc_dai *dai)
 	int ret;
 	struct sport_device *sport = snd_soc_dai_get_drvdata(dai);
 
-	if (!dai->active)
-		return 0;
-
 	ret = sport_set_multichannel(sport, 8, 0xFF, 1);
 	if (ret) {
 		pr_err("SPORT is busy!\n");
@@ -247,6 +216,8 @@ static int bf5xx_tdm_resume(struct snd_soc_dai *dai)
 		ret = -EBUSY;
 	}
 
+	peripheral_request_list(sport->pin_req, "soc-audio");
+
 	return 0;
 }
 
@@ -280,20 +251,14 @@ static struct snd_soc_dai_driver bf5xx_tdm_dai = {
 
 static int __devinit bfin_tdm_probe(struct platform_device *pdev)
 {
-	int ret = 0;
-
-	if (peripheral_request_list(&sport_req[sport_num][0], "soc-audio")) {
-		pr_err("Requesting Peripherals failed\n");
-		return -EFAULT;
-	}
+	struct sport_device *sport_handle;
+	int ret;
 
-	/* request DMA for SPORT */
-	sport_handle = sport_init(&sport_params[sport_num], 4, \
-		8 * sizeof(u32), NULL);
-	if (!sport_handle) {
-		peripheral_free_list(&sport_req[sport_num][0]);
+	/* configure SPORT for TDM */
+	sport_handle = sport_init(pdev, 4, 8 * sizeof(u32),
+		sizeof(struct bf5xx_tdm_port));
+	if (!sport_handle)
 		return -ENODEV;
-	}
 
 	/* SPORT works in TDM mode */
 	ret = sport_set_multichannel(sport_handle, 8, 0xFF, 1);
@@ -323,18 +288,19 @@ static int __devinit bfin_tdm_probe(struct platform_device *pdev)
 		goto sport_config_err;
 	}
 
-	sport_handle->private_data = &bf5xx_tdm;
 	return 0;
 
 sport_config_err:
-	peripheral_free_list(&sport_req[sport_num][0]);
+	sport_done(sport_handle);
 	return ret;
 }
 
 static int __devexit bfin_tdm_remove(struct platform_device *pdev)
 {
-	peripheral_free_list(&sport_req[sport_num][0]);
+	struct sport_device *sport_handle = platform_get_drvdata(pdev);
+
 	snd_soc_unregister_dai(&pdev->dev);
+	sport_done(sport_handle);
 
 	return 0;
 }
-- 
1.7.4.1
