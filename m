From: Chaithrika U S <chaithrika@ti.com>
Subject: [PATCH v2 1/2] ASoC: DaVinci: McASP driver enhacements
Date: Tue, 11 Aug 2009 16:58:52 -0400
Message-ID: <1250024332-26859-1-git-send-email-chaithrika@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
	by alsa0.perex.cz (Postfix) with ESMTP id 7B5EB24B99
	for <alsa-devel@alsa-project.org>;
	Tue, 11 Aug 2009 13:29:59 +0200 (CEST)
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
Cc: khilman@deeprootsystems.com, Chaithrika U S <chaithrika@ti.com>, davinci-linux-open-source@linux.davincidsp.com, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On DA830/OMAP-L137 and DA850/OMAP-L138 SoCs, the McASP peripheral has FIFO
support. This FIFO provides additional data buffering. It also provides
tolerance to variation in host/DMA controller response times.
The read and write FIFO sizes are 256 bytes each. If FIFO is enabled,
the DMA events from McASP are sent to the FIFO which in turn sends DMA requests
to the host CPU according to the thresholds programmed.
More details of the FIFO operation can be found at
http://focus.ti.com/general/docs/lit/getliterature.tsp?literatureNumber=
sprufm1&fileType=pdf

This patch adds support for FIFO configuration. The platform data has a
version field which differentiates the McASP on different SoCs.

Signed-off-by: Chaithrika U S <chaithrika@ti.com>
---
In this version of the patch, the davinci-i2s driver changes have been done
to account acnt member introduced in the dma_params structure. Also, the DAI
format addition has been removed from this patch.

Applies to ALSA GIT tree on branch topic/asoc at
http://git.kernel.org/?p=linux/kernel/git/tiwai/sound-2.6.git;a=shortlog;
h=topic/asoc

 sound/soc/davinci/davinci-i2s.c   |    1 +
 sound/soc/davinci/davinci-mcasp.c |  105 ++++++++++++++++++++++++++++++++++---
 sound/soc/davinci/davinci-mcasp.h |    5 ++
 sound/soc/davinci/davinci-pcm.c   |    4 +-
 sound/soc/davinci/davinci-pcm.h   |    1 +
 5 files changed, 107 insertions(+), 9 deletions(-)

diff --git a/sound/soc/davinci/davinci-i2s.c b/sound/soc/davinci/davinci-i2s.c
index 2a56fb7..12a6c54 100644
--- a/sound/soc/davinci/davinci-i2s.c
+++ b/sound/soc/davinci/davinci-i2s.c
@@ -406,6 +406,7 @@ static int davinci_i2s_hw_params(struct snd_pcm_substream *substream,
 		return -EINVAL;
 	}
 
+	dma_params->acnt  = dma_params->data_type;
 	rcr |= DAVINCI_MCBSP_RCR_RFRLEN1(1);
 	xcr |= DAVINCI_MCBSP_XCR_XFRLEN1(1);
 
diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index f0c0347..e672f43 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -102,6 +102,11 @@
 /* Receive Buffer for Serializer n */
 #define DAVINCI_MCASP_RXBUF_REG		0x280
 
+/* McASP FIFO Registers */
+#define DAVINCI_MCASP_WFIFOCTL		(0x1010)
+#define DAVINCI_MCASP_WFIFOSTS		(0x1014)
+#define DAVINCI_MCASP_RFIFOCTL		(0x1018)
+#define DAVINCI_MCASP_RFIFOSTS		(0x101C)
 
 /*
  * DAVINCI_MCASP_PWREMUMGT_REG - Power Down and Emulation Management
@@ -276,6 +281,13 @@
  */
 #define TXDATADMADIS	BIT(0)
 
+/*
+ * DAVINCI_MCASP_W[R]FIFOCTL - Write/Read FIFO Control Register bits
+ */
+#define FIFO_ENABLE	BIT(16)
+#define NUMEVT_MASK	(0xFF << 8)
+#define NUMDMA_MASK	(0xFF)
+
 #define DAVINCI_MCASP_NUM_SERIALIZER	16
 
 static inline void mcasp_set_bits(void __iomem *reg, u32 val)
@@ -345,6 +357,9 @@ static void mcasp_start_rx(struct davinci_audio_dev *dev)
 
 static void mcasp_start_tx(struct davinci_audio_dev *dev)
 {
+	u8 offset = 0, i;
+	u32 cnt;
+
 	mcasp_set_ctl_reg(dev->base + DAVINCI_MCASP_GBLCTLX_REG, TXHCLKRST);
 	mcasp_set_ctl_reg(dev->base + DAVINCI_MCASP_GBLCTLX_REG, TXCLKRST);
 	mcasp_set_ctl_reg(dev->base + DAVINCI_MCASP_GBLCTLX_REG, TXSERCLR);
@@ -353,6 +368,19 @@ static void mcasp_start_tx(struct davinci_audio_dev *dev)
 	mcasp_set_ctl_reg(dev->base + DAVINCI_MCASP_GBLCTLX_REG, TXSMRST);
 	mcasp_set_ctl_reg(dev->base + DAVINCI_MCASP_GBLCTLX_REG, TXFSRST);
 	mcasp_set_reg(dev->base + DAVINCI_MCASP_TXBUF_REG, 0);
+	for (i = 0; i < dev->num_serializer; i++) {
+		if (dev->serial_dir[i] == TX_MODE) {
+			offset = i;
+			break;
+		}
+	}
+
+	/* wait for TX ready */
+	cnt = 0;
+	while (!(mcasp_get_reg(dev->base + DAVINCI_MCASP_XRSRCTL_REG(offset)) &
+		 TXSTATE) && (cnt < 100000))
+		cnt++;
+
 	mcasp_set_reg(dev->base + DAVINCI_MCASP_TXBUF_REG, 0);
 }
 
@@ -362,6 +390,13 @@ static void davinci_mcasp_start(struct davinci_audio_dev *dev, int stream)
 		mcasp_start_tx(dev);
 	else
 		mcasp_start_rx(dev);
+
+	/* enable FIFO */
+	if (dev->txnumevt)
+		mcasp_set_bits(dev->base + DAVINCI_MCASP_WFIFOCTL, FIFO_ENABLE);
+
+	if (dev->rxnumevt)
+		mcasp_set_bits(dev->base + DAVINCI_MCASP_RFIFOCTL, FIFO_ENABLE);
 }
 
 static void mcasp_stop_rx(struct davinci_audio_dev *dev)
@@ -382,6 +417,13 @@ static void davinci_mcasp_stop(struct davinci_audio_dev *dev, int stream)
 		mcasp_stop_tx(dev);
 	else
 		mcasp_stop_rx(dev);
+
+	/* disable FIFO */
+	if (dev->txnumevt)
+		mcasp_clr_bits(dev->base + DAVINCI_MCASP_WFIFOCTL, FIFO_ENABLE);
+
+	if (dev->rxnumevt)
+		mcasp_clr_bits(dev->base + DAVINCI_MCASP_RFIFOCTL, FIFO_ENABLE);
 }
 
 static int davinci_mcasp_set_dai_fmt(struct snd_soc_dai *cpu_dai,
@@ -401,7 +443,6 @@ static int davinci_mcasp_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 
 		mcasp_set_bits(base + DAVINCI_MCASP_PDIR_REG, (0x7 << 26));
 		break;
-
 	case SND_SOC_DAIFMT_CBM_CFM:
 		/* codec is clock and frame master */
 		mcasp_clr_bits(base + DAVINCI_MCASP_ACLKXCTL_REG, ACLKXE);
@@ -505,6 +546,8 @@ static int davinci_config_channel_size(struct davinci_audio_dev *dev,
 static void davinci_hw_common_param(struct davinci_audio_dev *dev, int stream)
 {
 	int i;
+	u8 tx_ser = 0;
+	u8 rx_ser = 0;
 
 	/* Default configuration */
 	mcasp_set_bits(dev->base + DAVINCI_MCASP_PWREMUMGT_REG, MCASP_SOFT);
@@ -525,12 +568,37 @@ static void davinci_hw_common_param(struct davinci_audio_dev *dev, int stream)
 	for (i = 0; i < dev->num_serializer; i++) {
 		mcasp_set_bits(dev->base + DAVINCI_MCASP_XRSRCTL_REG(i),
 					dev->serial_dir[i]);
-		if (dev->serial_dir[i] == TX_MODE)
+		if (dev->serial_dir[i] == TX_MODE) {
 			mcasp_set_bits(dev->base + DAVINCI_MCASP_PDIR_REG,
 					AXR(i));
-		else if (dev->serial_dir[i] == RX_MODE)
+			tx_ser++;
+		} else if (dev->serial_dir[i] == RX_MODE) {
 			mcasp_clr_bits(dev->base + DAVINCI_MCASP_PDIR_REG,
 					AXR(i));
+			rx_ser++;
+		}
+	}
+
+	if (dev->txnumevt && stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		if (dev->txnumevt * tx_ser > 64)
+			dev->txnumevt = 1;
+
+		mcasp_mod_bits(dev->base + DAVINCI_MCASP_WFIFOCTL, tx_ser,
+								NUMDMA_MASK);
+		mcasp_mod_bits(dev->base + DAVINCI_MCASP_WFIFOCTL,
+				((dev->txnumevt * tx_ser) << 8), NUMEVT_MASK);
+		mcasp_set_bits(dev->base + DAVINCI_MCASP_WFIFOCTL, FIFO_ENABLE);
+	}
+
+	if (dev->rxnumevt && stream == SNDRV_PCM_STREAM_CAPTURE) {
+		if (dev->rxnumevt * rx_ser > 64)
+			dev->rxnumevt = 1;
+
+		mcasp_mod_bits(dev->base + DAVINCI_MCASP_RFIFOCTL, rx_ser,
+								NUMDMA_MASK);
+		mcasp_mod_bits(dev->base + DAVINCI_MCASP_RFIFOCTL,
+				((dev->rxnumevt * rx_ser) << 8), NUMEVT_MASK);
+		mcasp_set_bits(dev->base + DAVINCI_MCASP_RFIFOCTL, FIFO_ENABLE);
 	}
 }
 
@@ -543,6 +611,8 @@ static void davinci_hw_param(struct davinci_audio_dev *dev, int stream)
 	for (i = 0; i < active_slots; i++)
 		mask |= (1 << i);
 
+	mcasp_clr_bits(dev->base + DAVINCI_MCASP_ACLKXCTL_REG, TX_ASYNC);
+
 	if (stream == SNDRV_PCM_STREAM_PLAYBACK) {
 		/* bit stream is MSB first  with no delay */
 		/* DSP_B mode */
@@ -622,8 +692,16 @@ static int davinci_mcasp_hw_params(struct snd_pcm_substream *substream,
 	struct davinci_pcm_dma_params *dma_params =
 					dev->dma_params[substream->stream];
 	int word_length;
+	u8 numevt;
 
 	davinci_hw_common_param(dev, substream->stream);
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		numevt = dev->txnumevt;
+	else
+		numevt = dev->rxnumevt;
+
+	if (!numevt)
+		numevt = 1;
 
 	if (dev->op_mode == DAVINCI_MCASP_DIT_MODE)
 		davinci_hw_dit_param(dev);
@@ -650,6 +728,13 @@ static int davinci_mcasp_hw_params(struct snd_pcm_substream *substream,
 		printk(KERN_WARNING "davinci-mcasp: unsupported PCM format");
 		return -EINVAL;
 	}
+
+	if (dev->version == MCASP_VERSION_2) {
+		dma_params->data_type *= numevt;
+		dma_params->acnt = 4 * numevt;
+	} else
+		dma_params->acnt = dma_params->data_type;
+
 	davinci_config_channel_size(dev, word_length);
 
 	return 0;
@@ -778,6 +863,9 @@ static int davinci_mcasp_probe(struct platform_device *pdev)
 	dev->num_serializer = pdata->num_serializer;
 	dev->serial_dir = pdata->serial_dir;
 	dev->codec_fmt = pdata->codec_fmt;
+	dev->version = pdata->version;
+	dev->txnumevt = pdata->txnumevt;
+	dev->rxnumevt = pdata->rxnumevt;
 
 	dma_data[count].name = "I2S PCM Stereo out";
 	dma_data[count].eventq_no = pdata->eventq_no;
@@ -807,9 +895,9 @@ static int davinci_mcasp_probe(struct platform_device *pdev)
 	}
 
 	dma_data[count].channel = res->start;
-	davinci_mcasp_dai[pdev->id].private_data = dev;
-	davinci_mcasp_dai[pdev->id].dev = &pdev->dev;
-	ret = snd_soc_register_dai(&davinci_mcasp_dai[pdev->id]);
+	davinci_mcasp_dai[pdata->op_mode].private_data = dev;
+	davinci_mcasp_dai[pdata->op_mode].dev = &pdev->dev;
+	ret = snd_soc_register_dai(&davinci_mcasp_dai[pdata->op_mode]);
 
 	if (ret != 0)
 		goto err_release_region;
@@ -827,12 +915,13 @@ err_release_dev:
 
 static int davinci_mcasp_remove(struct platform_device *pdev)
 {
+	struct snd_platform_data *pdata = pdev->dev.platform_data;
 	struct davinci_pcm_dma_params *dma_data;
 	struct davinci_audio_dev *dev;
 	struct resource *mem;
 
-	snd_soc_unregister_dai(&davinci_mcasp_dai[pdev->id]);
-	dev = davinci_mcasp_dai[pdev->id].private_data;
+	snd_soc_unregister_dai(&davinci_mcasp_dai[pdata->op_mode]);
+	dev = davinci_mcasp_dai[pdata->op_mode].private_data;
 	clk_disable(dev->clk);
 	clk_put(dev->clk);
 	dev->clk = NULL;
diff --git a/sound/soc/davinci/davinci-mcasp.h b/sound/soc/davinci/davinci-mcasp.h
index 36b7104..554354c 100644
--- a/sound/soc/davinci/davinci-mcasp.h
+++ b/sound/soc/davinci/davinci-mcasp.h
@@ -50,6 +50,11 @@ struct davinci_audio_dev {
 	u8	op_mode;
 	u8	num_serializer;
 	u8	*serial_dir;
+	u8	version;
+
+	/* McASP FIFO related */
+	u8	txnumevt;
+	u8	rxnumevt;
 };
 
 #endif	/* DAVINCI_MCASP_H */
diff --git a/sound/soc/davinci/davinci-pcm.c b/sound/soc/davinci/davinci-pcm.c
index ab43a53..091dacb 100644
--- a/sound/soc/davinci/davinci-pcm.c
+++ b/sound/soc/davinci/davinci-pcm.c
@@ -67,6 +67,7 @@ static void davinci_pcm_enqueue_dma(struct snd_pcm_substream *substream)
 	dma_addr_t src, dst;
 	unsigned short src_bidx, dst_bidx;
 	unsigned int data_type;
+	unsigned short acnt;
 	unsigned int count;
 
 	period_size = snd_pcm_lib_period_bytes(substream);
@@ -91,11 +92,12 @@ static void davinci_pcm_enqueue_dma(struct snd_pcm_substream *substream)
 		dst_bidx = data_type;
 	}
 
+	acnt = prtd->params->acnt;
 	edma_set_src(lch, src, INCR, W8BIT);
 	edma_set_dest(lch, dst, INCR, W8BIT);
 	edma_set_src_index(lch, src_bidx, 0);
 	edma_set_dest_index(lch, dst_bidx, 0);
-	edma_set_transfer_params(lch, data_type, count, 1, 0, ASYNC);
+	edma_set_transfer_params(lch, acnt, count, 1, 0, ASYNC);
 
 	prtd->period++;
 	if (unlikely(prtd->period >= runtime->periods))
diff --git a/sound/soc/davinci/davinci-pcm.h b/sound/soc/davinci/davinci-pcm.h
index eb4287f..63d9625 100644
--- a/sound/soc/davinci/davinci-pcm.h
+++ b/sound/soc/davinci/davinci-pcm.h
@@ -19,6 +19,7 @@
 struct davinci_pcm_dma_params {
 	char *name;			/* stream identifier */
 	int channel;			/* sync dma channel ID */
+	unsigned short acnt;
 	dma_addr_t dma_addr;		/* device physical address for DMA */
 	enum dma_event_q eventq_no;	/* event queue number */
 	unsigned char data_type;	/* xfer data type */
-- 
1.5.6
