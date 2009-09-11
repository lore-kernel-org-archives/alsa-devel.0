From: Troy Kisky <troy.kisky@boundarydevices.com>
Subject: [PATCH 2/2] ASoC: Davinci: Fix race with
	cpu_dai->dma_data
Date: Fri, 11 Sep 2009 14:29:03 -0700
Message-ID: <1252704543-25580-2-git-send-email-troy.kisky@boundarydevices.com>
References: <1252704543-25580-1-git-send-email-troy.kisky@boundarydevices.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mpls-qmqp-03.inet.qwest.net (mpls-qmqp-03.inet.qwest.net
	[63.231.195.114])
	by alsa0.perex.cz (Postfix) with ESMTP id 7D3F424347
	for <alsa-devel@alsa-project.org>;
	Fri, 11 Sep 2009 23:28:50 +0200 (CEST)
In-Reply-To: <1252704543-25580-1-git-send-email-troy.kisky@boundarydevices.com>
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

This patch removes references to cpu_dai->dma_data.
It makes struct davinci_pcm_dma_params part of
struct davinci_mcbsp_dev or struct davinci_audio_dev.

It removes the unused name variable from davinci_pcm_dma_params.

Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>
---
 sound/soc/davinci/davinci-i2s.c   |   36 +++++++++---------------------
 sound/soc/davinci/davinci-mcasp.c |   44 ++++++++----------------------------
 sound/soc/davinci/davinci-mcasp.h |    7 +++++-
 sound/soc/davinci/davinci-pcm.c   |    3 +-
 sound/soc/davinci/davinci-pcm.h   |    1 -
 5 files changed, 29 insertions(+), 62 deletions(-)

diff --git a/sound/soc/davinci/davinci-i2s.c b/sound/soc/davinci/davinci-i2s.c
index d32e197..4ae7070 100644
--- a/sound/soc/davinci/davinci-i2s.c
+++ b/sound/soc/davinci/davinci-i2s.c
@@ -97,22 +97,19 @@ enum {
 	DAVINCI_MCBSP_WORD_32,
 };
 
-static struct davinci_pcm_dma_params davinci_i2s_pcm_out = {
-	.name = "I2S PCM Stereo out",
-};
-
-static struct davinci_pcm_dma_params davinci_i2s_pcm_in = {
-	.name = "I2S PCM Stereo in",
-};
-
 struct davinci_mcbsp_dev {
+	/*
+	 * dma_params must be first because rtd->dai->cpu_dai->private_data
+	 * is cast to a pointer of an array of struct davinci_pcm_dma_params in
+	 * davinci_pcm_open.
+	 */
+	struct davinci_pcm_dma_params	dma_params[2];
 	void __iomem			*base;
 #define MOD_DSP_A	0
 #define MOD_DSP_B	1
 	int				mode;
 	u32				pcr;
 	struct clk			*clk;
-	struct davinci_pcm_dma_params	*dma_params[2];
 };
 
 static inline void davinci_mcbsp_write_reg(struct davinci_mcbsp_dev *dev,
@@ -215,14 +212,6 @@ static void davinci_mcbsp_stop(struct davinci_mcbsp_dev *dev, int playback)
 	toggle_clock(dev, playback);
 }
 
-static int davinci_i2s_startup(struct snd_pcm_substream *substream,
-			       struct snd_soc_dai *cpu_dai)
-{
-	struct davinci_mcbsp_dev *dev = cpu_dai->private_data;
-	cpu_dai->dma_data = dev->dma_params[substream->stream];
-	return 0;
-}
-
 #define DEFAULT_BITPERSAMPLE	16
 
 static int davinci_i2s_set_dai_fmt(struct snd_soc_dai *cpu_dai,
@@ -355,7 +344,7 @@ static int davinci_i2s_hw_params(struct snd_pcm_substream *substream,
 {
 	struct davinci_mcbsp_dev *dev = dai->private_data;
 	struct davinci_pcm_dma_params *dma_params =
-					dev->dma_params[substream->stream];
+					&dev->dma_params[substream->stream];
 	struct snd_interval *i = NULL;
 	int mcbsp_word_length;
 	unsigned int rcr, xcr, srgr;
@@ -473,7 +462,6 @@ static void davinci_i2s_shutdown(struct snd_pcm_substream *substream,
 #define DAVINCI_I2S_RATES	SNDRV_PCM_RATE_8000_96000
 
 static struct snd_soc_dai_ops davinci_i2s_dai_ops = {
-	.startup 	= davinci_i2s_startup,
 	.shutdown	= davinci_i2s_shutdown,
 	.prepare	= davinci_i2s_prepare,
 	.trigger	= davinci_i2s_trigger,
@@ -535,12 +523,10 @@ static int davinci_i2s_probe(struct platform_device *pdev)
 
 	dev->base = (void __iomem *)IO_ADDRESS(mem->start);
 
-	dev->dma_params[SNDRV_PCM_STREAM_PLAYBACK] = &davinci_i2s_pcm_out;
-	dev->dma_params[SNDRV_PCM_STREAM_PLAYBACK]->dma_addr =
+	dev->dma_params[SNDRV_PCM_STREAM_PLAYBACK].dma_addr =
 	    (dma_addr_t)(io_v2p(dev->base) + DAVINCI_MCBSP_DXR_REG);
 
-	dev->dma_params[SNDRV_PCM_STREAM_CAPTURE] = &davinci_i2s_pcm_in;
-	dev->dma_params[SNDRV_PCM_STREAM_CAPTURE]->dma_addr =
+	dev->dma_params[SNDRV_PCM_STREAM_CAPTURE].dma_addr =
 	    (dma_addr_t)(io_v2p(dev->base) + DAVINCI_MCBSP_DRR_REG);
 
 	/* first TX, then RX */
@@ -550,7 +536,7 @@ static int davinci_i2s_probe(struct platform_device *pdev)
 		ret = -ENXIO;
 		goto err_free_mem;
 	}
-	dev->dma_params[SNDRV_PCM_STREAM_PLAYBACK]->channel = res->start;
+	dev->dma_params[SNDRV_PCM_STREAM_PLAYBACK].channel = res->start;
 
 	res = platform_get_resource(pdev, IORESOURCE_DMA, 1);
 	if (!res) {
@@ -558,7 +544,7 @@ static int davinci_i2s_probe(struct platform_device *pdev)
 		ret = -ENXIO;
 		goto err_free_mem;
 	}
-	dev->dma_params[SNDRV_PCM_STREAM_CAPTURE]->channel = res->start;
+	dev->dma_params[SNDRV_PCM_STREAM_CAPTURE].channel = res->start;
 
 	davinci_i2s_dai.private_data = dev;
 	ret = snd_soc_register_dai(&davinci_i2s_dai);
diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index eca22d7..e7fc882 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -332,14 +332,6 @@ static inline void mcasp_set_ctl_reg(void __iomem *regs, u32 val)
 		printk(KERN_ERR "GBLCTL write error\n");
 }
 
-static int davinci_mcasp_startup(struct snd_pcm_substream *substream,
-						struct snd_soc_dai *cpu_dai)
-{
-	struct davinci_audio_dev *dev = cpu_dai->private_data;
-	cpu_dai->dma_data = dev->dma_params[substream->stream];
-	return 0;
-}
-
 static void mcasp_start_rx(struct davinci_audio_dev *dev)
 {
 	mcasp_set_ctl_reg(dev->base + DAVINCI_MCASP_GBLCTLR_REG, RXHCLKRST);
@@ -700,7 +692,7 @@ static int davinci_mcasp_hw_params(struct snd_pcm_substream *substream,
 {
 	struct davinci_audio_dev *dev = cpu_dai->private_data;
 	struct davinci_pcm_dma_params *dma_params =
-					dev->dma_params[substream->stream];
+					&dev->dma_params[substream->stream];
 	int word_length;
 	u8 numevt;
 
@@ -778,7 +770,6 @@ static int davinci_mcasp_trigger(struct snd_pcm_substream *substream,
 }
 
 static struct snd_soc_dai_ops davinci_mcasp_dai_ops = {
-	.startup 	= davinci_mcasp_startup,
 	.trigger	= davinci_mcasp_trigger,
 	.hw_params	= davinci_mcasp_hw_params,
 	.set_fmt	= davinci_mcasp_set_dai_fmt,
@@ -829,20 +820,12 @@ static int davinci_mcasp_probe(struct platform_device *pdev)
 	struct resource *mem, *ioarea, *res;
 	struct snd_platform_data *pdata;
 	struct davinci_audio_dev *dev;
-	int count = 0;
 	int ret = 0;
 
 	dev = kzalloc(sizeof(struct davinci_audio_dev), GFP_KERNEL);
 	if (!dev)
 		return	-ENOMEM;
 
-	dma_data = kzalloc(sizeof(struct davinci_pcm_dma_params) * 2,
-								GFP_KERNEL);
-	if (!dma_data) {
-		ret = -ENOMEM;
-		goto err_release_dev;
-	}
-
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!mem) {
 		dev_err(&pdev->dev, "no mem resource?\n");
@@ -877,11 +860,10 @@ static int davinci_mcasp_probe(struct platform_device *pdev)
 	dev->txnumevt = pdata->txnumevt;
 	dev->rxnumevt = pdata->rxnumevt;
 
-	dma_data[count].name = "I2S PCM Stereo out";
-	dma_data[count].eventq_no = pdata->eventq_no;
-	dma_data[count].dma_addr = (dma_addr_t) (pdata->tx_dma_offset +
+	dma_data = &dev->dma_params[SNDRV_PCM_STREAM_PLAYBACK];
+	dma_data->eventq_no = pdata->eventq_no;
+	dma_data->dma_addr = (dma_addr_t) (pdata->tx_dma_offset +
 							io_v2p(dev->base));
-	dev->dma_params[SNDRV_PCM_STREAM_PLAYBACK] = &dma_data[count];
 
 	/* first TX, then RX */
 	res = platform_get_resource(pdev, IORESOURCE_DMA, 0);
@@ -890,13 +872,12 @@ static int davinci_mcasp_probe(struct platform_device *pdev)
 		goto err_release_region;
 	}
 
-	dma_data[count].channel = res->start;
-	count++;
-	dma_data[count].name = "I2S PCM Stereo in";
-	dma_data[count].eventq_no = pdata->eventq_no;
-	dma_data[count].dma_addr = (dma_addr_t)(pdata->rx_dma_offset +
+	dma_data->channel = res->start;
+
+	dma_data = &dev->dma_params[SNDRV_PCM_STREAM_CAPTURE];
+	dma_data->eventq_no = pdata->eventq_no;
+	dma_data->dma_addr = (dma_addr_t)(pdata->rx_dma_offset +
 							io_v2p(dev->base));
-	dev->dma_params[SNDRV_PCM_STREAM_CAPTURE] = &dma_data[count];
 
 	res = platform_get_resource(pdev, IORESOURCE_DMA, 1);
 	if (!res) {
@@ -904,7 +885,7 @@ static int davinci_mcasp_probe(struct platform_device *pdev)
 		goto err_release_region;
 	}
 
-	dma_data[count].channel = res->start;
+	dma_data->channel = res->start;
 	davinci_mcasp_dai[pdata->op_mode].private_data = dev;
 	davinci_mcasp_dai[pdata->op_mode].dev = &pdev->dev;
 	ret = snd_soc_register_dai(&davinci_mcasp_dai[pdata->op_mode]);
@@ -916,8 +897,6 @@ static int davinci_mcasp_probe(struct platform_device *pdev)
 err_release_region:
 	release_mem_region(mem->start, (mem->end - mem->start) + 1);
 err_release_data:
-	kfree(dma_data);
-err_release_dev:
 	kfree(dev);
 
 	return ret;
@@ -926,7 +905,6 @@ err_release_dev:
 static int davinci_mcasp_remove(struct platform_device *pdev)
 {
 	struct snd_platform_data *pdata = pdev->dev.platform_data;
-	struct davinci_pcm_dma_params *dma_data;
 	struct davinci_audio_dev *dev;
 	struct resource *mem;
 
@@ -939,8 +917,6 @@ static int davinci_mcasp_remove(struct platform_device *pdev)
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	release_mem_region(mem->start, (mem->end - mem->start) + 1);
 
-	dma_data = dev->dma_params[SNDRV_PCM_STREAM_PLAYBACK];
-	kfree(dma_data);
 	kfree(dev);
 
 	return 0;
diff --git a/sound/soc/davinci/davinci-mcasp.h b/sound/soc/davinci/davinci-mcasp.h
index 554354c..9d179cc 100644
--- a/sound/soc/davinci/davinci-mcasp.h
+++ b/sound/soc/davinci/davinci-mcasp.h
@@ -39,10 +39,15 @@ enum {
 };
 
 struct davinci_audio_dev {
+	/*
+	 * dma_params must be first because rtd->dai->cpu_dai->private_data
+	 * is cast to a pointer of an array of struct davinci_pcm_dma_params in
+	 * davinci_pcm_open.
+	 */
+	struct davinci_pcm_dma_params dma_params[2];
 	void __iomem *base;
 	int sample_rate;
 	struct clk *clk;
-	struct davinci_pcm_dma_params *dma_params[2];
 	unsigned int codec_fmt;
 
 	/* McASP specific data */
diff --git a/sound/soc/davinci/davinci-pcm.c b/sound/soc/davinci/davinci-pcm.c
index 002808b..359e99e 100644
--- a/sound/soc/davinci/davinci-pcm.c
+++ b/sound/soc/davinci/davinci-pcm.c
@@ -238,7 +238,8 @@ static int davinci_pcm_open(struct snd_pcm_substream *substream)
 	struct davinci_runtime_data *prtd;
 	int ret = 0;
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct davinci_pcm_dma_params *params = rtd->dai->cpu_dai->dma_data;
+	struct davinci_pcm_dma_params *pa = rtd->dai->cpu_dai->private_data;
+	struct davinci_pcm_dma_params *params = &pa[substream->stream];
 	if (!params)
 		return -ENODEV;
 
diff --git a/sound/soc/davinci/davinci-pcm.h b/sound/soc/davinci/davinci-pcm.h
index 63d9625..8746606 100644
--- a/sound/soc/davinci/davinci-pcm.h
+++ b/sound/soc/davinci/davinci-pcm.h
@@ -17,7 +17,6 @@
 
 
 struct davinci_pcm_dma_params {
-	char *name;			/* stream identifier */
 	int channel;			/* sync dma channel ID */
 	unsigned short acnt;
 	dma_addr_t dma_addr;		/* device physical address for DMA */
-- 
1.5.6.3
