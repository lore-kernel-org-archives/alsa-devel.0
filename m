From: Troy Kisky <troy.kisky@boundarydevices.com>
Subject: [PATCH V1 08/11] ASoc: DaVinci: i2s, Improve underrun,
	support mono
Date: Sat,  4 Jul 2009 19:29:58 -0700
Message-ID: <1246761001-21982-9-git-send-email-troy.kisky@boundarydevices.com>
References: <1246761001-21982-1-git-send-email-troy.kisky@boundarydevices.com>
	<1246761001-21982-2-git-send-email-troy.kisky@boundarydevices.com>
	<1246761001-21982-3-git-send-email-troy.kisky@boundarydevices.com>
	<1246761001-21982-4-git-send-email-troy.kisky@boundarydevices.com>
	<1246761001-21982-5-git-send-email-troy.kisky@boundarydevices.com>
	<1246761001-21982-6-git-send-email-troy.kisky@boundarydevices.com>
	<1246761001-21982-7-git-send-email-troy.kisky@boundarydevices.com>
	<1246761001-21982-8-git-send-email-troy.kisky@boundarydevices.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mpls-qmqp-02.inet.qwest.net (mpls-qmqp-02.inet.qwest.net
	[63.231.195.113])
	by alsa0.perex.cz (Postfix) with ESMTP id D4F63103868
	for <alsa-devel@alsa-project.org>;
	Sun,  5 Jul 2009 04:30:12 +0200 (CEST)
In-Reply-To: <1246761001-21982-8-git-send-email-troy.kisky@boundarydevices.com>
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
Cc: davinci-linux-open-source@linux.davincidsp.com, broonie@sirena.org.uk, Troy Kisky <troy.kisky@boundarydevices.com>
List-Id: alsa-devel@alsa-project.org

This patch will reduce the number of underruns by
shifting out 32 bit values instead of 16 bit. It also
adds mono support.

Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>
---
 sound/soc/davinci/davinci-i2s.c |  124 +++++++++++++++++++++++++++------------
 sound/soc/davinci/davinci-pcm.c |   31 +++++++---
 sound/soc/davinci/davinci-pcm.h |    3 +-
 3 files changed, 110 insertions(+), 48 deletions(-)

diff --git a/sound/soc/davinci/davinci-i2s.c b/sound/soc/davinci/davinci-i2s.c
index 6fa1b6a..a2ad53e 100644
--- a/sound/soc/davinci/davinci-i2s.c
+++ b/sound/soc/davinci/davinci-i2s.c
@@ -356,26 +356,29 @@ static int davinci_i2s_hw_params(struct snd_pcm_substream *substream,
 	struct davinci_mcbsp_dev *dev = rtd->dai->cpu_dai->private_data;
 	struct snd_interval *i = NULL;
 	int mcbsp_word_length;
+	int bits_per_sample;
+	int bits_per_frame;
 	unsigned int rcr, xcr, srgr;
+	int channels;
+	int format;
+	int element_cnt = 1;
 	u32 spcr;
 
-	/* general line settings */
-	spcr = davinci_mcbsp_read_reg(dev, DAVINCI_MCBSP_SPCR_REG);
-	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE) {
-		spcr |= DAVINCI_MCBSP_SPCR_RINTM(3) | DAVINCI_MCBSP_SPCR_FREE;
-		davinci_mcbsp_write_reg(dev, DAVINCI_MCBSP_SPCR_REG, spcr);
-	} else {
-		spcr |= DAVINCI_MCBSP_SPCR_XINTM(3) | DAVINCI_MCBSP_SPCR_FREE;
-		davinci_mcbsp_write_reg(dev, DAVINCI_MCBSP_SPCR_REG, spcr);
-	}
-
 	i = hw_param_interval(params, SNDRV_PCM_HW_PARAM_SAMPLE_BITS);
-	srgr = DAVINCI_MCBSP_SRGR_FSGM;
-	srgr |= DAVINCI_MCBSP_SRGR_FWID(snd_interval_value(i) - 1);
+	bits_per_sample = snd_interval_value(i);
+	/* always 2 samples/frame, mono will convert to stereo */
+	bits_per_frame = bits_per_sample << 1;
+	srgr = DAVINCI_MCBSP_SRGR_FSGM |
+		DAVINCI_MCBSP_SRGR_FPER(bits_per_frame - 1) |
+		DAVINCI_MCBSP_SRGR_FWID(bits_per_sample - 1);
 
-	i = hw_param_interval(params, SNDRV_PCM_HW_PARAM_FRAME_BITS);
-	srgr |= DAVINCI_MCBSP_SRGR_FPER(snd_interval_value(i) - 1);
-	davinci_mcbsp_write_reg(dev, DAVINCI_MCBSP_SRGR_REG, srgr);
+	/* general line settings */
+	spcr = davinci_mcbsp_read_reg(dev, DAVINCI_MCBSP_SPCR_REG);
+	spcr |= DAVINCI_MCBSP_SPCR_FREE;
+	spcr |= (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) ?
+			DAVINCI_MCBSP_SPCR_XINTM(3) :
+			DAVINCI_MCBSP_SPCR_RINTM(3);
+	davinci_mcbsp_write_reg(dev, DAVINCI_MCBSP_SPCR_REG, spcr);
 
 	rcr = DAVINCI_MCBSP_RCR_RFIG;
 	xcr = DAVINCI_MCBSP_XCR_XFIG;
@@ -386,33 +389,80 @@ static int davinci_i2s_hw_params(struct snd_pcm_substream *substream,
 		rcr |= DAVINCI_MCBSP_RCR_RDATDLY(1);
 		xcr |= DAVINCI_MCBSP_XCR_XDATDLY(1);
 	}
+	channels = params_channels(params);
+	format = params_format(params);
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
-		printk(KERN_WARNING "davinci-i2s: unsupported PCM format\n");
-		return -EINVAL;
+	if (channels == 2) {
+		/* Combining both channels into 1 element can allow x10 the
+		 * amount of time between servicing the dma channel, increase
+		 * effiency, and reduce the chance of overrun/underrun. But,
+		 * it will result in the left & right channels being swapped.
+		 * So, you may want to let the codec know to swap them back.
+		 *
+		 * It may be x10 instead of x2 because the clock from the codec
+		 * may run at mclk speed (ie. tlvaic23b), independent of the
+		 * sample rate. So, having an entire frame at once means it can
+		 * be serviced at the sample rate instead of the mclk speed.
+		 *
+		 * In the now very unlikely case that an underrun still
+		 * occurs, both the left and right samples will be repeated
+		 * so that no pops are heard, and the left and right channels
+		 * won't end up being swapped because of the underrun.
+		 */
+		dma_params->convert_mono_stereo = 0;
+		switch (format) {
+		case SNDRV_PCM_FORMAT_S8:
+			dma_params->data_type = 2;	/* 2 byte frame */
+			mcbsp_word_length = DAVINCI_MCBSP_WORD_16;
+			break;
+		case SNDRV_PCM_FORMAT_S16_LE:
+			dma_params->data_type = 4;	/* 4 byte frame */
+			mcbsp_word_length = DAVINCI_MCBSP_WORD_32;
+			break;
+		case SNDRV_PCM_FORMAT_S32_LE:
+			element_cnt = 2;
+			dma_params->data_type = 4;	/* 4 byte element */
+			mcbsp_word_length = DAVINCI_MCBSP_WORD_32;
+			break;
+		default:
+			printk(KERN_WARNING
+					"davinci-i2s: unsupported PCM format");
+			return -EINVAL;
+		}
+	} else {
+		dma_params->convert_mono_stereo = 1;
+		/* 1 element in ram becomes 2 for stereo */
+		element_cnt = 2;
+		switch (format) {
+		case SNDRV_PCM_FORMAT_S8:
+			/* 1 byte frame in ram */
+			dma_params->data_type = 1;
+			mcbsp_word_length = DAVINCI_MCBSP_WORD_8;
+			break;
+		case SNDRV_PCM_FORMAT_S16_LE:
+			/* 2 byte frame in ram */
+			dma_params->data_type = 2;
+			mcbsp_word_length = DAVINCI_MCBSP_WORD_16;
+			break;
+		case SNDRV_PCM_FORMAT_S32_LE:
+			/* 4 byte element */
+			dma_params->data_type = 4;
+			mcbsp_word_length = DAVINCI_MCBSP_WORD_32;
+			break;
+		default:
+			printk(KERN_WARNING
+					"davinci-i2s: unsupported PCM format");
+			return -EINVAL;
+		}
 	}
-
-	rcr |= DAVINCI_MCBSP_RCR_RFRLEN1(1);
-	xcr |= DAVINCI_MCBSP_XCR_XFRLEN1(1);
+	rcr |= DAVINCI_MCBSP_RCR_RFRLEN1(element_cnt - 1);
+	xcr |= DAVINCI_MCBSP_XCR_XFRLEN1(element_cnt - 1);
 
 	rcr |= DAVINCI_MCBSP_RCR_RWDLEN1(mcbsp_word_length) |
 		DAVINCI_MCBSP_RCR_RWDLEN2(mcbsp_word_length);
 	xcr |= DAVINCI_MCBSP_XCR_XWDLEN1(mcbsp_word_length) |
 		DAVINCI_MCBSP_XCR_XWDLEN2(mcbsp_word_length);
-
+	davinci_mcbsp_write_reg(dev, DAVINCI_MCBSP_SRGR_REG, srgr);
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
 		davinci_mcbsp_write_reg(dev, DAVINCI_MCBSP_XCR_REG, xcr);
 	else
@@ -542,12 +592,12 @@ struct snd_soc_dai davinci_i2s_dai = {
 	.probe = davinci_i2s_probe,
 	.remove = davinci_i2s_remove,
 	.playback = {
-		.channels_min = 2,
+		.channels_min = 1,
 		.channels_max = 2,
 		.rates = DAVINCI_I2S_RATES,
 		.formats = SNDRV_PCM_FMTBIT_S16_LE,},
 	.capture = {
-		.channels_min = 2,
+		.channels_min = 1,
 		.channels_max = 2,
 		.rates = DAVINCI_I2S_RATES,
 		.formats = SNDRV_PCM_FMTBIT_S16_LE,},
diff --git a/sound/soc/davinci/davinci-pcm.c b/sound/soc/davinci/davinci-pcm.c
index a059965..2002fdc 100644
--- a/sound/soc/davinci/davinci-pcm.c
+++ b/sound/soc/davinci/davinci-pcm.c
@@ -65,9 +65,9 @@ static void davinci_pcm_enqueue_dma(struct snd_pcm_substream *substream)
 	unsigned int dma_offset;
 	dma_addr_t dma_pos;
 	dma_addr_t src, dst;
-	unsigned short src_bidx, dst_bidx;
-	unsigned int data_type;
 	unsigned int count;
+	unsigned int data_type = prtd->params->data_type;
+	unsigned int convert_mono_stereo = prtd->params->convert_mono_stereo;
 
 	period_size = snd_pcm_lib_period_bytes(substream);
 	dma_offset = prtd->period * period_size;
@@ -76,26 +76,37 @@ static void davinci_pcm_enqueue_dma(struct snd_pcm_substream *substream)
 	pr_debug("davinci_pcm: audio_set_dma_params_play channel = %d "
 		"dma_ptr = %x period_size=%x\n", lch, dma_pos, period_size);
 
-	data_type = prtd->params->data_type;
 	count = period_size / data_type;
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
 		src = dma_pos;
 		dst = prtd->params->dma_addr;
-		src_bidx = data_type;
-		dst_bidx = 0;
+		if (convert_mono_stereo)
+			edma_set_src_index(lch, 0, data_type);
+		else
+			edma_set_src_index(lch, data_type, 0);
+		edma_set_dest_index(lch, 0, 0);
 	} else {
 		src = prtd->params->dma_addr;
 		dst = dma_pos;
-		src_bidx = 0;
-		dst_bidx = data_type;
+		edma_set_src_index(lch, 0, 0);
+		if (convert_mono_stereo)
+			edma_set_dest_index(lch, 0, data_type);
+		else
+			edma_set_dest_index(lch, data_type, 0);
 	}
 
 	edma_set_src(lch, src, INCR, W8BIT);
 	edma_set_dest(lch, dst, INCR, W8BIT);
-	edma_set_src_index(lch, src_bidx, 0);
-	edma_set_dest_index(lch, dst_bidx, 0);
-	edma_set_transfer_params(lch, data_type, count, 1, 0, ASYNC);
+	if (convert_mono_stereo) {
+		/*
+		 * Each byte is sent twice, so
+		 * A_CNT * B_CNT * C_CNT = 2 * period_size
+		 */
+		edma_set_transfer_params(lch, data_type, 2, count, 2, ASYNC);
+	} else {
+		edma_set_transfer_params(lch, data_type, count, 1, 0, ASYNC);
+	}
 
 	prtd->period++;
 	if (unlikely(prtd->period >= runtime->periods))
diff --git a/sound/soc/davinci/davinci-pcm.h b/sound/soc/davinci/davinci-pcm.h
index 62cb4eb..fc70161 100644
--- a/sound/soc/davinci/davinci-pcm.h
+++ b/sound/soc/davinci/davinci-pcm.h
@@ -16,7 +16,8 @@ struct davinci_pcm_dma_params {
 	char *name;		/* stream identifier */
 	int channel;		/* sync dma channel ID */
 	dma_addr_t dma_addr;	/* device physical address for DMA */
-	unsigned int data_type;	/* xfer data type */
+	unsigned char data_type;	/* xfer data type */
+	unsigned char convert_mono_stereo;
 };
 
 struct evm_snd_platform_data {
-- 
1.5.6.3
