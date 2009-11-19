From: Troy Kisky <troy.kisky@boundarydevices.com>
Subject: [PATCH 1/4] ASoC: DaVinci: i2s,
	reduce underruns by combining into 1 element
Date: Wed, 18 Nov 2009 17:49:51 -0700
Message-ID: <1258591794-18416-1-git-send-email-troy.kisky@boundarydevices.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mpls-qmqp-01.inet.qwest.net (mpls-qmqp-01.inet.qwest.net
	[63.231.195.112])
	by alsa0.perex.cz (Postfix) with ESMTP id E592D103876
	for <alsa-devel@alsa-project.org>; Thu, 19 Nov 2009 01:50:10 +0100 (CET)
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
Cc: broonie@sirena.org.uk, Troy Kisky <troy.kisky@boundarydevices.com>
List-Id: alsa-devel@alsa-project.org

Allow the left and right 16 bit samples to be shifted out as 1
32 bit sample.

Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>
---
 This applies to Marks for-2.6.33 branch

 Sorry about the prior bad patch base.

 arch/arm/mach-davinci/include/mach/asp.h |    6 ++
 sound/soc/davinci/davinci-i2s.c          |   74 ++++++++++++++++++++++--------
 2 files changed, 61 insertions(+), 19 deletions(-)

diff --git a/arch/arm/mach-davinci/include/mach/asp.h b/arch/arm/mach-davinci/include/mach/asp.h
index 18e4ce3..019c647 100644
--- a/arch/arm/mach-davinci/include/mach/asp.h
+++ b/arch/arm/mach-davinci/include/mach/asp.h
@@ -51,6 +51,12 @@ struct snd_platform_data {
 	u32 rx_dma_offset;
 	enum dma_event_q eventq_no;	/* event queue number */
 	unsigned int codec_fmt;
+	/*
+	 * Allowing this is more efficient and eliminates left and right swaps
+	 * caused by underruns, but will swap the left and right channels
+	 * when compared to previous behavior.
+	 */
+	unsigned enable_channel_combine:1;
 
 	/* McASP specific fields */
 	int tdm_slots;
diff --git a/sound/soc/davinci/davinci-i2s.c b/sound/soc/davinci/davinci-i2s.c
index d336786..b2a5372 100644
--- a/sound/soc/davinci/davinci-i2s.c
+++ b/sound/soc/davinci/davinci-i2s.c
@@ -97,6 +97,23 @@ enum {
 	DAVINCI_MCBSP_WORD_32,
 };
 
+static const unsigned char data_type[SNDRV_PCM_FORMAT_S32_LE + 1] = {
+	[SNDRV_PCM_FORMAT_S8]		= 1,
+	[SNDRV_PCM_FORMAT_S16_LE]	= 2,
+	[SNDRV_PCM_FORMAT_S32_LE]	= 4,
+};
+
+static const unsigned char asp_word_length[SNDRV_PCM_FORMAT_S32_LE + 1] = {
+	[SNDRV_PCM_FORMAT_S8]		= DAVINCI_MCBSP_WORD_8,
+	[SNDRV_PCM_FORMAT_S16_LE]	= DAVINCI_MCBSP_WORD_16,
+	[SNDRV_PCM_FORMAT_S32_LE]	= DAVINCI_MCBSP_WORD_32,
+};
+
+static const unsigned char double_fmt[SNDRV_PCM_FORMAT_S32_LE + 1] = {
+	[SNDRV_PCM_FORMAT_S8]		= SNDRV_PCM_FORMAT_S16_LE,
+	[SNDRV_PCM_FORMAT_S16_LE]	= SNDRV_PCM_FORMAT_S32_LE,
+};
+
 struct davinci_mcbsp_dev {
 	struct davinci_pcm_dma_params	dma_params[2];
 	void __iomem			*base;
@@ -105,6 +122,27 @@ struct davinci_mcbsp_dev {
 	int				mode;
 	u32				pcr;
 	struct clk			*clk;
+	/*
+	 * Combining both channels into 1 element will at least double the
+	 * amount of time between servicing the dma channel, increase
+	 * effiency, and reduce the chance of overrun/underrun. But,
+	 * it will result in the left & right channels being swapped.
+	 *
+	 * If relabeling the left and right channels is not possible,
+	 * you may want to let the codec know to swap them back.
+	 *
+	 * It may allow x10 the amount of time to service dma requests,
+	 * if the codec is master and is using an unnecessarily fast bit clock
+	 * (ie. tlvaic23b), independent of the sample rate. So, having an
+	 * entire frame at once means it can be serviced at the sample rate
+	 * instead of the bit clock rate.
+	 *
+	 * In the now unlikely case that an underrun still
+	 * occurs, both the left and right samples will be repeated
+	 * so that no pops are heard, and the left and right channels
+	 * won't end up being swapped because of the underrun.
+	 */
+	unsigned enable_channel_combine:1;
 };
 
 static inline void davinci_mcbsp_write_reg(struct davinci_mcbsp_dev *dev,
@@ -344,6 +382,8 @@ static int davinci_i2s_hw_params(struct snd_pcm_substream *substream,
 	int mcbsp_word_length;
 	unsigned int rcr, xcr, srgr;
 	u32 spcr;
+	snd_pcm_format_t fmt;
+	unsigned element_cnt = 1;
 
 	/* general line settings */
 	spcr = davinci_mcbsp_read_reg(dev, DAVINCI_MCBSP_SPCR_REG);
@@ -373,29 +413,24 @@ static int davinci_i2s_hw_params(struct snd_pcm_substream *substream,
 		xcr |= DAVINCI_MCBSP_XCR_XDATDLY(1);
 	}
 	/* Determine xfer data type */
-	switch (params_format(params)) {
-	case SNDRV_PCM_FORMAT_S8:
-		dma_params->data_type = 1;
-		mcbsp_word_length = DAVINCI_MCBSP_WORD_8;
-		break;
-	case SNDRV_PCM_FORMAT_S16_LE:
-		dma_params->data_type = 2;
-		mcbsp_word_length = DAVINCI_MCBSP_WORD_16;
-		break;
-	case SNDRV_PCM_FORMAT_S32_LE:
-		dma_params->data_type = 4;
-		mcbsp_word_length = DAVINCI_MCBSP_WORD_32;
-		break;
-	default:
+	fmt = params_format(params);
+	if ((fmt > SNDRV_PCM_FORMAT_S32_LE) || !data_type[fmt]) {
 		printk(KERN_WARNING "davinci-i2s: unsupported PCM format\n");
 		return -EINVAL;
 	}
 
-	dma_params->acnt  = dma_params->data_type;
+	if (params_channels(params) == 2) {
+		element_cnt = 2;
+		if (double_fmt[fmt] && dev->enable_channel_combine) {
+			element_cnt = 1;
+			fmt = double_fmt[fmt];
+		}
+	}
+	dma_params->acnt = dma_params->data_type = data_type[fmt];
 	dma_params->fifo_level = 0;
-
-	rcr |= DAVINCI_MCBSP_RCR_RFRLEN1(1);
-	xcr |= DAVINCI_MCBSP_XCR_XFRLEN1(1);
+	mcbsp_word_length = asp_word_length[fmt];
+	rcr |= DAVINCI_MCBSP_RCR_RFRLEN1(element_cnt - 1);
+	xcr |= DAVINCI_MCBSP_XCR_XFRLEN1(element_cnt - 1);
 
 	rcr |= DAVINCI_MCBSP_RCR_RWDLEN1(mcbsp_word_length) |
 		DAVINCI_MCBSP_RCR_RWDLEN2(mcbsp_word_length);
@@ -510,7 +545,8 @@ static int davinci_i2s_probe(struct platform_device *pdev)
 		ret = -ENOMEM;
 		goto err_release_region;
 	}
-
+	if (pdata)
+		dev->enable_channel_combine = pdata->enable_channel_combine;
 	dev->clk = clk_get(&pdev->dev, NULL);
 	if (IS_ERR(dev->clk)) {
 		ret = -ENODEV;
-- 
1.5.6.3
