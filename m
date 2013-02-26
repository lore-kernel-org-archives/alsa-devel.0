From: Michal Bachraty <michal.bachraty@streamunlimited.com>
Subject: [PATCH] davinci-mcasp: Add support for multichannel
	playback
Date: Tue, 26 Feb 2013 17:20:58 +0100
Message-ID: <1361895658-27256-1-git-send-email-michal.bachraty@streamunlimited.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx.inode.at (mx10.lb01.inode.at [62.99.145.10])
 by alsa0.perex.cz (Postfix) with ESMTP id 2773D265324
 for <alsa-devel@alsa-project.org>; Tue, 26 Feb 2013 17:21:10 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: perex@perex.cz, alsa-devel@alsa-project.org
Cc: Michal Bachraty <michal.bachraty@streamunlimited.com>
List-Id: alsa-devel@alsa-project.org

Davinci McASP has support for I2S multichannel playback.
For I2S playback/receive, each serializer is capable to play 2 channels
(L/R) audio data.Serializer function (Playback-receive-none) is configured
in DT, depending on hardware specification. It is possible to play less
channels than configured in DT. For that purpose,only specific number of
active serializers are enabled. McASP FIFO need to have DMA transfer Bcnt
set to number of enabled serializers, otherwise no data are transfered to
McASP and Alsa generates "DMA/IRQ playback write error (DMA or IRQ trouble?)"
error.

Signed-off-by: Michal Bachraty <michal.bachraty@streamunlimited.com>
---
 sound/soc/davinci/davinci-mcasp.c |   49 +++++++++++++++++++++++++++++++------
 sound/soc/davinci/davinci-pcm.c   |   15 ++++++------
 sound/soc/davinci/davinci-pcm.h   |    1 +
 3 files changed, 51 insertions(+), 14 deletions(-)

diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index d2ca682..ebd6ee0 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -657,12 +657,14 @@ static int davinci_config_channel_size(struct davinci_audio_dev *dev,
 	return 0;
 }
 
-static void davinci_hw_common_param(struct davinci_audio_dev *dev, int stream)
+static int davinci_hw_common_param(struct davinci_audio_dev *dev, int stream,
+				    int channels)
 {
 	int i;
 	u8 tx_ser = 0;
 	u8 rx_ser = 0;
-
+	u8 ser;
+	u8 stream_serializers = channels/2 + channels%2;
 	/* Default configuration */
 	mcasp_set_bits(dev->base + DAVINCI_MCASP_PWREMUMGT_REG, MCASP_SOFT);
 
@@ -680,16 +682,44 @@ static void davinci_hw_common_param(struct davinci_audio_dev *dev, int stream)
 	}
 
 	for (i = 0; i < dev->num_serializer; i++) {
+		if (dev->serial_dir[i] == TX_MODE)
+			tx_ser++;
+		if (dev->serial_dir[i] == RX_MODE)
+			rx_ser++;
+	}
+
+	if (stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		ser = tx_ser;
+	} else {
+		ser = rx_ser;
+	}
+
+	if (ser < stream_serializers) {
+		printk(KERN_WARNING "davinci-mcasp: stream has more channels "
+		"(%d) than are enabled in mcasp (%d)",
+			channels, ser * 2);
+		return -EINVAL;
+	}
+
+	tx_ser = 0;
+	rx_ser = 0;
+
+	for (i = 0; i < dev->num_serializer; i++) {
 		mcasp_set_bits(dev->base + DAVINCI_MCASP_XRSRCTL_REG(i),
 					dev->serial_dir[i]);
-		if (dev->serial_dir[i] == TX_MODE) {
+		if (dev->serial_dir[i] == TX_MODE &&
+					tx_ser < stream_serializers) {
 			mcasp_set_bits(dev->base + DAVINCI_MCASP_PDIR_REG,
 					AXR(i));
 			tx_ser++;
-		} else if (dev->serial_dir[i] == RX_MODE) {
+		} else if (dev->serial_dir[i] == RX_MODE &&
+					rx_ser < stream_serializers) {
 			mcasp_clr_bits(dev->base + DAVINCI_MCASP_PDIR_REG,
 					AXR(i));
 			rx_ser++;
+		} else {
+			mcasp_clr_bits(dev->base + DAVINCI_MCASP_XRSRCTL_REG(i),
+					3);
 		}
 	}
 
@@ -812,8 +842,12 @@ static int davinci_mcasp_hw_params(struct snd_pcm_substream *substream,
 					&dev->dma_params[substream->stream];
 	int word_length;
 	u8 fifo_level;
+	int channels;
+	struct snd_interval *pcm_channels = hw_param_interval(params,
+					SNDRV_PCM_HW_PARAM_CHANNELS);
+	channels = pcm_channels->min;
 
-	davinci_hw_common_param(dev, substream->stream);
+	davinci_hw_common_param(dev, substream->stream, channels);
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
 		fifo_level = dev->txnumevt;
 	else
@@ -862,6 +896,7 @@ static int davinci_mcasp_hw_params(struct snd_pcm_substream *substream,
 		dma_params->acnt = dma_params->data_type;
 
 	dma_params->fifo_level = fifo_level;
+	dma_params->active_serializers = channels/2 + channels%2;
 	davinci_config_channel_size(dev, word_length);
 
 	return 0;
@@ -936,13 +971,13 @@ static struct snd_soc_dai_driver davinci_mcasp_dai[] = {
 		.name		= "davinci-mcasp.0",
 		.playback	= {
 			.channels_min	= 2,
-			.channels_max 	= 2,
+			.channels_max	= 8,
 			.rates 		= DAVINCI_MCASP_RATES,
 			.formats	= DAVINCI_MCASP_PCM_FMTS,
 		},
 		.capture 	= {
 			.channels_min 	= 2,
-			.channels_max 	= 2,
+			.channels_max	= 8,
 			.rates 		= DAVINCI_MCASP_RATES,
 			.formats	= DAVINCI_MCASP_PCM_FMTS,
 		},
diff --git a/sound/soc/davinci/davinci-pcm.c b/sound/soc/davinci/davinci-pcm.c
index bb57552..9951973 100644
--- a/sound/soc/davinci/davinci-pcm.c
+++ b/sound/soc/davinci/davinci-pcm.c
@@ -182,6 +182,7 @@ static void davinci_pcm_enqueue_dma(struct snd_pcm_substream *substream)
 	unsigned short acnt;
 	unsigned int count;
 	unsigned int fifo_level;
+	unsigned char serializers = prtd->params->active_serializers;
 
 	period_size = snd_pcm_lib_period_bytes(substream);
 	dma_offset = prtd->period * period_size;
@@ -193,7 +194,7 @@ static void davinci_pcm_enqueue_dma(struct snd_pcm_substream *substream)
 		period_size);
 
 	data_type = prtd->params->data_type;
-	count = period_size / data_type;
+	count = period_size /  (data_type * serializers);
 	if (fifo_level)
 		count /= fifo_level;
 
@@ -201,8 +202,8 @@ static void davinci_pcm_enqueue_dma(struct snd_pcm_substream *substream)
 		src = dma_pos;
 		dst = prtd->params->dma_addr;
 		src_bidx = data_type;
-		dst_bidx = 0;
-		src_cidx = data_type * fifo_level;
+		dst_bidx = 4;
+		src_cidx = data_type * fifo_level * serializers;
 		dst_cidx = 0;
 	} else {
 		src = prtd->params->dma_addr;
@@ -210,7 +211,7 @@ static void davinci_pcm_enqueue_dma(struct snd_pcm_substream *substream)
 		src_bidx = 0;
 		dst_bidx = data_type;
 		src_cidx = 0;
-		dst_cidx = data_type * fifo_level;
+		dst_cidx = data_type * fifo_level * serializers;
 	}
 
 	acnt = prtd->params->acnt;
@@ -224,9 +225,9 @@ static void davinci_pcm_enqueue_dma(struct snd_pcm_substream *substream)
 		edma_set_transfer_params(prtd->asp_link[0], acnt, count, 1, 0,
 							ASYNC);
 	else
-		edma_set_transfer_params(prtd->asp_link[0], acnt, fifo_level,
-							count, fifo_level,
-							ABSYNC);
+		edma_set_transfer_params(prtd->asp_link[0], acnt, serializers,
+						count, fifo_level * serializers,
+						ABSYNC);
 }
 
 static void davinci_pcm_dma_irq(unsigned link, u16 ch_status, void *data)
diff --git a/sound/soc/davinci/davinci-pcm.h b/sound/soc/davinci/davinci-pcm.h
index fbb710c..0d84d32 100644
--- a/sound/soc/davinci/davinci-pcm.h
+++ b/sound/soc/davinci/davinci-pcm.h
@@ -27,6 +27,7 @@ struct davinci_pcm_dma_params {
 	unsigned char data_type;	/* xfer data type */
 	unsigned char convert_mono_stereo;
 	unsigned int fifo_level;
+	unsigned char active_serializers; /* num. of active audio serializers */
 };
 
 int davinci_soc_platform_register(struct device *dev);
-- 
1.7.9.5
