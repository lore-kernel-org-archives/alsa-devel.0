From: Bryan Wu <cooloney@kernel.org>
Subject: [PATCH 2/3] ASoC: Blackfin: add multi-channel
	supporting in Blackfin ASoC driver and AD1980 codec driver
Date: Tue, 21 Oct 2008 11:36:12 +0800
Message-ID: <1224560173-8728-3-git-send-email-cooloney@kernel.org>
References: <1224560173-8728-1-git-send-email-cooloney@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nwd2mail10.analog.com (nwd2mail10.analog.com [137.71.25.55])
	by alsa0.perex.cz (Postfix) with ESMTP id 43F6424705
	for <alsa-devel@alsa-project.org>;
	Tue, 21 Oct 2008 05:35:49 +0200 (CEST)
In-Reply-To: <1224560173-8728-1-git-send-email-cooloney@kernel.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: broonie@sirena.org.uk
Cc: alsa-devel@alsa-project.org, Cliff Cai <cliff.cai@analog.com>, Bryan Wu <cooloney@kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Cliff Cai <cliff.cai@analog.com>

Signed-off-by: Cliff Cai <cliff.cai@analog.com>
Signed-off-by: Bryan Wu <cooloney@kernel.org>
---
 sound/soc/blackfin/Kconfig          |    8 ++
 sound/soc/blackfin/bf5xx-ac97-pcm.c |   45 +++++++----
 sound/soc/blackfin/bf5xx-ac97.c     |  152 +++++++++++++++++++++--------------
 sound/soc/blackfin/bf5xx-ac97.h     |   35 +++++++-
 sound/soc/codecs/ad1980.c           |    5 +-
 5 files changed, 163 insertions(+), 82 deletions(-)

diff --git a/sound/soc/blackfin/Kconfig b/sound/soc/blackfin/Kconfig
index 3fce187..e58d5b1 100644
--- a/sound/soc/blackfin/Kconfig
+++ b/sound/soc/blackfin/Kconfig
@@ -55,6 +55,14 @@ config SND_MMAP_SUPPORT
 	  Say y if you want AC97 driver to support mmap mode.
 	  We introduce an intermediate buffer to simulate mmap.
 
+config SND_MULTICHAN_SUPPORT
+	bool "Enable Multichannel Support"
+	depends on SND_BF5XX_AC97
+	default n
+	help
+	  Say y if you want AC97 driver to support up to 5.1 channel audio.
+	  this mode will consume much more memory for DMA. 
+
 config SND_BF5XX_SOC_SPORT
 	tristate
 	
diff --git a/sound/soc/blackfin/bf5xx-ac97-pcm.c b/sound/soc/blackfin/bf5xx-ac97-pcm.c
index 25e50d2..eb1531f 100644
--- a/sound/soc/blackfin/bf5xx-ac97-pcm.c
+++ b/sound/soc/blackfin/bf5xx-ac97-pcm.c
@@ -43,24 +43,34 @@
 #include "bf5xx-ac97.h"
 #include "bf5xx-sport.h"
 
+static unsigned int ac97_chan_mask[] = {
+	SP_FL, /* Mono */
+	SP_STEREO, /* Stereo */
+	SP_2DOT1, /* 2.1*/
+	SP_QUAD,/*Quadraquic*/
+	SP_FL | SP_FR | SP_FC | SP_SL | SP_SR,/*5 channels */
+	SP_5DOT1, /* 5.1 */
+};
+
 #if defined(CONFIG_SND_MMAP_SUPPORT)
 static void bf5xx_mmap_copy(struct snd_pcm_substream *substream,
 	 snd_pcm_uframes_t count)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct sport_device *sport = runtime->private_data;
+	unsigned int chan_mask = ac97_chan_mask[substream->runtime->channels - 1];
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
-		bf5xx_pcm_to_ac97(
-			(struct ac97_frame *)sport->tx_dma_buf + sport->tx_pos,
-			(__u32 *)runtime->dma_area + sport->tx_pos, count);
+		bf5xx_pcm_to_ac97((struct ac97_frame *)sport->tx_dma_buf + sport->tx_pos,
+			(__u16 *)runtime->dma_area + sport->tx_pos * substream->runtime->channels,
+				count, chan_mask);
 		sport->tx_pos += runtime->period_size;
 		if (sport->tx_pos >= runtime->buffer_size)
 			sport->tx_pos %= runtime->buffer_size;
 		sport->tx_delay_pos = sport->tx_pos;
 	} else {
-		bf5xx_ac97_to_pcm(
-			(struct ac97_frame *)sport->rx_dma_buf + sport->rx_pos,
-			(__u32 *)runtime->dma_area + sport->rx_pos, count);
+		bf5xx_ac97_to_pcm((struct ac97_frame *)sport->rx_dma_buf + sport->rx_pos,
+			(__u16 *)runtime->dma_area + sport->rx_pos * substream->runtime->channels,
+				count);
 		sport->rx_pos += runtime->period_size;
 		if (sport->rx_pos >= runtime->buffer_size)
 			sport->rx_pos %= runtime->buffer_size;
@@ -123,10 +133,18 @@ static int bf5xx_pcm_hw_params(struct snd_pcm_substream *substream,
 
 static int bf5xx_pcm_hw_free(struct snd_pcm_substream *substream)
 {
+	#if defined(CONFIG_SND_MMAP_SUPPORT)
 	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct sport_device *sport = runtime->private_data;
 
-	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
-	memset(runtime->dma_area, 0, runtime->buffer_size);
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		sport->once = 0;
+		if (runtime->dma_area)
+			memset(runtime->dma_area, 0, runtime->buffer_size);
+		memset(sport->tx_dma_buf, 0, runtime->buffer_size * sizeof(struct ac97_frame));
+	} else
+		memset(sport->rx_dma_buf, 0, runtime->buffer_size * sizeof(struct ac97_frame));
+#endif
 	snd_pcm_lib_free_pages(substream);
 	return 0;
 }
@@ -174,7 +192,6 @@ static int bf5xx_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 	case SNDRV_PCM_TRIGGER_START:
 		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
 			bf5xx_mmap_copy(substream, runtime->period_size);
-			snd_pcm_period_elapsed(substream);
 			sport->tx_delay_pos = 0;
 			sport_tx_start(sport);
 		}
@@ -286,13 +303,11 @@ static	int bf5xx_pcm_copy(struct snd_pcm_substream *substream, int channel,
 			substream->stream ? "Capture" : "Playback", pos, count);
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
-		bf5xx_pcm_to_ac97(
-				(struct ac97_frame *)runtime->dma_area + pos,
-				buf, count);
+		bf5xx_pcm_to_ac97((struct ac97_frame *)runtime->dma_area + pos,
+			(__u16 *)buf, count, chan_mask);
 	else
-		bf5xx_ac97_to_pcm(
-				(struct ac97_frame *)runtime->dma_area + pos,
-				buf, count);
+		bf5xx_ac97_to_pcm((struct ac97_frame *)runtime->dma_area + pos,
+			(__u16 *)buf, count);
 	return 0;
 }
 #endif
diff --git a/sound/soc/blackfin/bf5xx-ac97.c b/sound/soc/blackfin/bf5xx-ac97.c
index 5e5aafb..b88f796 100644
--- a/sound/soc/blackfin/bf5xx-ac97.c
+++ b/sound/soc/blackfin/bf5xx-ac97.c
@@ -54,65 +54,97 @@
 static int *cmd_count;
 static int sport_num = CONFIG_SND_BF5XX_SPORT_NUM;
 
-#if defined(CONFIG_BF54x)
+static u16 sport_req[][7] = {
+		PIN_REQ_SPORT_0,
+#ifdef PIN_REQ_SPORT_1
+		PIN_REQ_SPORT_1,
+#endif
+#ifdef PIN_REQ_SPORT_2
+		PIN_REQ_SPORT_2,
+#endif
+#ifdef PIN_REQ_SPORT_3
+		PIN_REQ_SPORT_3,
+#endif
+	};
+
 static struct sport_param sport_params[4] = {
 	{
 		.dma_rx_chan	= CH_SPORT0_RX,
 		.dma_tx_chan	= CH_SPORT0_TX,
-		.err_irq	= IRQ_SPORT0_ERR,
+		.err_irq	= IRQ_SPORT0_ERROR,
 		.regs		= (struct sport_register *)SPORT0_TCR1,
 	},
+#ifdef PIN_REQ_SPORT_1
 	{
 		.dma_rx_chan	= CH_SPORT1_RX,
 		.dma_tx_chan	= CH_SPORT1_TX,
-		.err_irq	= IRQ_SPORT1_ERR,
+		.err_irq	= IRQ_SPORT1_ERROR,
 		.regs		= (struct sport_register *)SPORT1_TCR1,
 	},
+#endif
+#ifdef PIN_REQ_SPORT_2
 	{
 		.dma_rx_chan	= CH_SPORT2_RX,
 		.dma_tx_chan	= CH_SPORT2_TX,
-		.err_irq	= IRQ_SPORT2_ERR,
+		.err_irq	= IRQ_SPORT2_ERROR,
 		.regs		= (struct sport_register *)SPORT2_TCR1,
 	},
+#endif
+#ifdef PIN_REQ_SPORT_3
 	{
 		.dma_rx_chan	= CH_SPORT3_RX,
 		.dma_tx_chan	= CH_SPORT3_TX,
-		.err_irq	= IRQ_SPORT3_ERR,
+		.err_irq	= IRQ_SPORT3_ERROR,
 		.regs		= (struct sport_register *)SPORT3_TCR1,
 	}
-};
-#else
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
 #endif
+};
 
-void bf5xx_pcm_to_ac97(struct ac97_frame *dst, const __u32 *src, \
-		size_t count)
+void bf5xx_pcm_to_ac97(struct ac97_frame *dst, const __u16 *src, \
+		size_t count, unsigned int chan_mask)
 {
 	while (count--) {
-		dst->ac97_tag = TAG_VALID | TAG_PCM;
-		(dst++)->ac97_pcm = *src++;
+		dst->ac97_tag = TAG_VALID;
+		if (chan_mask & SP_FL) {
+			dst->ac97_pcm_r = *src++;
+			dst->ac97_tag |= TAG_PCM_RIGHT;
+		}
+		if (chan_mask & SP_FR) {
+			dst->ac97_pcm_l = *src++;
+			dst->ac97_tag |= TAG_PCM_LEFT;
+
+		}
+#if defined(CONFIG_SND_MULTICHAN_SUPPORT)
+		if (chan_mask & SP_SR) {
+			dst->ac97_sl = *src++;
+			dst->ac97_tag |= TAG_PCM_SL;
+		}
+		if (chan_mask & SP_SL) {
+			dst->ac97_sr = *src++;
+			dst->ac97_tag |= TAG_PCM_SR;
+		}
+		if (chan_mask & SP_LFE) {
+			dst->ac97_lfe = *src++;
+			dst->ac97_tag |= TAG_PCM_LFE;
+		}
+		if (chan_mask & SP_FC) {
+			dst->ac97_center = *src++;
+			dst->ac97_tag |= TAG_PCM_CENTER;
+		}
+#endif
+		dst++;
 	}
 }
 EXPORT_SYMBOL(bf5xx_pcm_to_ac97);
 
-void bf5xx_ac97_to_pcm(const struct ac97_frame *src, __u32 *dst, \
+void bf5xx_ac97_to_pcm(const struct ac97_frame *src, __u16 *dst, \
 		size_t count)
 {
-	while (count--)
-		*(dst++) = (src++)->ac97_pcm;
+	while (count--) {
+		*(dst++) = src->ac97_pcm_l;
+		*(dst++) = src->ac97_pcm_r;
+		src++;
+	}
 }
 EXPORT_SYMBOL(bf5xx_ac97_to_pcm);
 
@@ -297,20 +329,15 @@ static int bf5xx_ac97_resume(struct platform_device *pdev,
 static int bf5xx_ac97_probe(struct platform_device *pdev,
 			    struct snd_soc_dai *dai)
 {
-	int ret;
-#if defined(CONFIG_BF54x)
-	u16 sport_req[][7] = {PIN_REQ_SPORT_0, PIN_REQ_SPORT_1,
-				 PIN_REQ_SPORT_2, PIN_REQ_SPORT_3};
-#else
-	u16 sport_req[][7] = {PIN_REQ_SPORT_0, PIN_REQ_SPORT_1};
-#endif
+	int ret = 0;
 	cmd_count = (int *)get_zeroed_page(GFP_KERNEL);
 	if (cmd_count == NULL)
 		return -ENOMEM;
 
 	if (peripheral_request_list(&sport_req[sport_num][0], "soc-audio")) {
 		pr_err("Requesting Peripherals failed\n");
-		return -EFAULT;
+		ret =  -EFAULT;
+		goto peripheral_err;
 		}
 
 #ifdef CONFIG_SND_BF5XX_HAVE_COLD_RESET
@@ -318,54 +345,52 @@ static int bf5xx_ac97_probe(struct platform_device *pdev,
 	if (gpio_request(CONFIG_SND_BF5XX_RESET_GPIO_NUM, "SND_AD198x RESET")) {
 		pr_err("Failed to request GPIO_%d for reset\n",
 				CONFIG_SND_BF5XX_RESET_GPIO_NUM);
-		peripheral_free_list(&sport_req[sport_num][0]);
-		return -1;
+		ret =  -1;
+		goto gpio_err;
 	}
 	gpio_direction_output(CONFIG_SND_BF5XX_RESET_GPIO_NUM, 1);
 #endif
 	sport_handle = sport_init(&sport_params[sport_num], 2, \
 			sizeof(struct ac97_frame), NULL);
 	if (!sport_handle) {
-		peripheral_free_list(&sport_req[sport_num][0]);
-#ifdef CONFIG_SND_BF5XX_HAVE_COLD_RESET
-		gpio_free(CONFIG_SND_BF5XX_RESET_GPIO_NUM);
-#endif
-		return -ENODEV;
+		ret = -ENODEV;
+		goto sport_err;
 	}
 	/*SPORT works in TDM mode to simulate AC97 transfers*/
 	ret = sport_set_multichannel(sport_handle, 16, 0x1F, 1);
 	if (ret) {
 		pr_err("SPORT is busy!\n");
-		kfree(sport_handle);
-		peripheral_free_list(&sport_req[sport_num][0]);
-#ifdef CONFIG_SND_BF5XX_HAVE_COLD_RESET
-		gpio_free(CONFIG_SND_BF5XX_RESET_GPIO_NUM);
-#endif
-		return -EBUSY;
+		ret = -EBUSY;
+		goto sport_config_err;
 	}
 
 	ret = sport_config_rx(sport_handle, IRFS, 0xF, 0, (16*16-1));
 	if (ret) {
 		pr_err("SPORT is busy!\n");
-		kfree(sport_handle);
-		peripheral_free_list(&sport_req[sport_num][0]);
-#ifdef CONFIG_SND_BF5XX_HAVE_COLD_RESET
-		gpio_free(CONFIG_SND_BF5XX_RESET_GPIO_NUM);
-#endif
-		return -EBUSY;
+		ret = -EBUSY;
+		goto sport_config_err;
 	}
 
 	ret = sport_config_tx(sport_handle, ITFS, 0xF, 0, (16*16-1));
 	if (ret) {
 		pr_err("SPORT is busy!\n");
-		kfree(sport_handle);
-		peripheral_free_list(&sport_req[sport_num][0]);
+		ret = -EBUSY;
+		goto sport_config_err;
+	}
+
+sport_config_err:
+	kfree(sport_handle);
+sport_err:
 #ifdef CONFIG_SND_BF5XX_HAVE_COLD_RESET
-		gpio_free(CONFIG_SND_BF5XX_RESET_GPIO_NUM);
+	gpio_free(CONFIG_SND_BF5XX_RESET_GPIO_NUM);
 #endif
-		return -EBUSY;
-	}
-	return 0;
+gpio_err:
+	peripheral_free_list(&sport_req[sport_num][0]);	
+peripheral_err:
+	free_page((unsigned long)cmd_count);
+	cmd_count = NULL;
+
+	return ret;
 }
 
 static void bf5xx_ac97_remove(struct platform_device *pdev,
@@ -373,6 +398,7 @@ static void bf5xx_ac97_remove(struct platform_device *pdev,
 {
 	free_page((unsigned long)cmd_count);
 	cmd_count = NULL;
+	peripheral_free_list(&sport_req[sport_num][0]);	
 #ifdef CONFIG_SND_BF5XX_HAVE_COLD_RESET
 	gpio_free(CONFIG_SND_BF5XX_RESET_GPIO_NUM);
 #endif
@@ -389,7 +415,11 @@ struct snd_soc_dai bfin_ac97_dai = {
 	.playback = {
 		.stream_name = "AC97 Playback",
 		.channels_min = 2,
+#if defined(CONFIG_SND_MULTICHAN_SUPPORT)
+		.channels_max = 6,
+#else
 		.channels_max = 2,
+#endif
 		.rates = SNDRV_PCM_RATE_48000,
 		.formats = SNDRV_PCM_FMTBIT_S16_LE, },
 	.capture = {
diff --git a/sound/soc/blackfin/bf5xx-ac97.h b/sound/soc/blackfin/bf5xx-ac97.h
index 3f77cc5..04284d2 100644
--- a/sound/soc/blackfin/bf5xx-ac97.h
+++ b/sound/soc/blackfin/bf5xx-ac97.h
@@ -16,21 +16,46 @@ struct ac97_frame {
 	u16 ac97_tag;		/* slot 0 */
 	u16 ac97_addr;		/* slot 1 */
 	u16 ac97_data;		/* slot 2 */
-	u32 ac97_pcm;		/* slot 3 and 4: left and right pcm data */
+	u16 ac97_pcm_l;		/*slot 3:front left*/
+	u16 ac97_pcm_r;		/*slot 4:front left*/
+#if defined(CONFIG_SND_MULTICHAN_SUPPORT)
+	u16 ac97_mdm_l1;
+	u16 ac97_center;	/*slot 6:center*/
+	u16 ac97_sl;		/*slot 7:surround left*/
+	u16 ac97_sr;		/*slot 8:surround right*/
+	u16 ac97_lfe;		/*slot 9:lfe*/
+#endif
 } __attribute__ ((packed));
 
+/* Speaker location */
+#define SP_FL		0x0001
+#define SP_FR		0x0010
+#define SP_FC		0x0002
+#define SP_LFE		0x0020
+#define SP_SL		0x0004
+#define SP_SR		0x0040
+
+#define SP_STEREO	(SP_FL | SP_FR)
+#define SP_2DOT1	(SP_FL | SP_FR | SP_LFE)
+#define SP_QUAD		(SP_FL | SP_FR | SP_SL | SP_SR)
+#define SP_5DOT1	(SP_FL | SP_FR | SP_FC | SP_LFE | SP_SL | SP_SR)
+
 #define TAG_VALID		0x8000
 #define TAG_CMD			0x6000
 #define TAG_PCM_LEFT		0x1000
 #define TAG_PCM_RIGHT		0x0800
-#define TAG_PCM			(TAG_PCM_LEFT | TAG_PCM_RIGHT)
+#define TAG_PCM_MDM_L1		0x0400
+#define TAG_PCM_CENTER		0x0200
+#define TAG_PCM_SL		0x0100
+#define TAG_PCM_SR		0x0080
+#define TAG_PCM_LFE		0x0040
 
 extern struct snd_soc_dai bfin_ac97_dai;
 
-void bf5xx_pcm_to_ac97(struct ac97_frame *dst, const __u32 *src, \
-		size_t count);
+void bf5xx_pcm_to_ac97(struct ac97_frame *dst, const __u16 *src, \
+		size_t count, unsigned int chan_mask);
 
-void bf5xx_ac97_to_pcm(const struct ac97_frame *src, __u32 *dst, \
+void bf5xx_ac97_to_pcm(const struct ac97_frame *src, __u16 *dst, \
 		size_t count);
 
 #endif
diff --git a/sound/soc/codecs/ad1980.c b/sound/soc/codecs/ad1980.c
index 1397b8e..e22fbdf 100644
--- a/sound/soc/codecs/ad1980.c
+++ b/sound/soc/codecs/ad1980.c
@@ -145,7 +145,7 @@ struct snd_soc_dai ad1980_dai = {
 	.playback = {
 		.stream_name = "Playback",
 		.channels_min = 2,
-		.channels_max = 2,
+		.channels_max = 6,
 		.rates = SNDRV_PCM_RATE_48000,
 		.formats = SNDRV_PCM_FMTBIT_S16_LE, },
 	.capture = {
@@ -256,6 +256,9 @@ static int ad1980_soc_probe(struct platform_device *pdev)
 	ac97_write(codec, AC97_MASTER, 0x0000); /* unmute line out volume */
 	ac97_write(codec, AC97_PCM, 0x0000);	/* unmute PCM out volume */
 	ac97_write(codec, AC97_REC_GAIN, 0x0000);/* unmute record volume */
+	ac97_write(codec, AC97_CENTER_LFE_MASTER, 0x0000); /* unmute center and lfe volume */
+	ac97_write(codec, AC97_SURROUND_MASTER, 0x0000); /* unmute surround volume */
+	ac97_write(codec, AC97_EXTENDED_STATUS, 0x0000);/*power on LFE CENTER and Surround DACs*/
 
 	ad1980_add_controls(codec);
 	ret = snd_soc_register_card(socdev);
-- 
1.5.6
