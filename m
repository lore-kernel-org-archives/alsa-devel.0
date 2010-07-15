From: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Subject: [PATCH] asoc: davinci: let platform data define edma queue numbers
Date: Thu, 15 Jul 2010 17:44:19 +0530
Message-ID: <1279196059-6031-1-git-send-email-nsekhar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces+gld-davinci-linux-open-source=gmane.org-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: davinci-linux-open-source-bounces+gld-davinci-linux-open-source=gmane.org-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Errors-To: davinci-linux-open-source-bounces+gld-davinci-linux-open-source=gmane.org-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
Cc: davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Liam Girdwood <lrg-kDsPt+C1G03kYMGBc/C6ZA@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

Currently the EDMA queue to be used by for servicing ASP through
internal RAM is fixed to EDMAQ_0 and that to service internal RAM
from external RAM is fixed to EDMAQ_1.

This may not be the desirable configuration on all platforms. For
example, on DM365, queue 0 has large fifo size and is more suitable
for video transfers. Having audio and video transfers on the same
queue may lead to starvation on audio side.

platform data as defined currently passes a queue number to the driver
but that remains unused inside the driver.

Fix this by defining one queue each for ASP and RAM transfers in the
platform data and using it inside the driver.

Since EDMAQ_0 maps to 0, thats the queue that will be used if
the asp queue number is not initialized. None of the platforms
currently utilize ping-pong transfers through internal RAM so that
functionality remains unchanged too.

This patch has been tested on DM644x and OMAP-L138 EVMs.

Signed-off-by: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
---
This patch applies to latest of Linus's tree.

 arch/arm/mach-davinci/board-da830-evm.c  |    2 +-
 arch/arm/mach-davinci/board-da850-evm.c  |    2 +-
 arch/arm/mach-davinci/board-dm646x-evm.c |    4 ++--
 arch/arm/mach-davinci/include/mach/asp.h |    3 ++-
 sound/soc/davinci/davinci-i2s.c          |   10 ++++++++++
 sound/soc/davinci/davinci-mcasp.c        |    6 ++++--
 sound/soc/davinci/davinci-pcm.c          |    5 +++--
 sound/soc/davinci/davinci-pcm.h          |    3 ++-
 8 files changed, 25 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-davinci/board-da830-evm.c b/arch/arm/mach-davinci/board-da830-evm.c
index 212d970..bc384d3 100644
--- a/arch/arm/mach-davinci/board-da830-evm.c
+++ b/arch/arm/mach-davinci/board-da830-evm.c
@@ -208,7 +208,7 @@ static struct snd_platform_data da830_evm_snd_data = {
 	.num_serializer = ARRAY_SIZE(da830_iis_serializer_direction),
 	.tdm_slots      = 2,
 	.serial_dir     = da830_iis_serializer_direction,
-	.eventq_no      = EVENTQ_0,
+	.asp_chan_q     = EVENTQ_0,
 	.version	= MCASP_VERSION_2,
 	.txnumevt	= 1,
 	.rxnumevt	= 1,
diff --git a/arch/arm/mach-davinci/board-da850-evm.c b/arch/arm/mach-davinci/board-da850-evm.c
index 2ec3095..d4ec18d 100644
--- a/arch/arm/mach-davinci/board-da850-evm.c
+++ b/arch/arm/mach-davinci/board-da850-evm.c
@@ -342,7 +342,7 @@ static struct snd_platform_data da850_evm_snd_data = {
 	.num_serializer	= ARRAY_SIZE(da850_iis_serializer_direction),
 	.tdm_slots	= 2,
 	.serial_dir	= da850_iis_serializer_direction,
-	.eventq_no	= EVENTQ_1,
+	.asp_chan_q	= EVENTQ_1,
 	.version	= MCASP_VERSION_2,
 	.txnumevt	= 1,
 	.rxnumevt	= 1,
diff --git a/arch/arm/mach-davinci/board-dm646x-evm.c b/arch/arm/mach-davinci/board-dm646x-evm.c
index 6d88893..87521f2 100644
--- a/arch/arm/mach-davinci/board-dm646x-evm.c
+++ b/arch/arm/mach-davinci/board-dm646x-evm.c
@@ -323,7 +323,7 @@ static struct snd_platform_data dm646x_evm_snd_data[] = {
 		.num_serializer = ARRAY_SIZE(dm646x_iis_serializer_direction),
 		.tdm_slots      = 2,
 		.serial_dir     = dm646x_iis_serializer_direction,
-		.eventq_no      = EVENTQ_0,
+		.asp_chan_q     = EVENTQ_0,
 	},
 	{
 		.tx_dma_offset  = 0x400,
@@ -332,7 +332,7 @@ static struct snd_platform_data dm646x_evm_snd_data[] = {
 		.num_serializer = ARRAY_SIZE(dm646x_dit_serializer_direction),
 		.tdm_slots      = 32,
 		.serial_dir     = dm646x_dit_serializer_direction,
-		.eventq_no      = EVENTQ_0,
+		.asp_chan_q     = EVENTQ_0,
 	},
 };
 
diff --git a/arch/arm/mach-davinci/include/mach/asp.h b/arch/arm/mach-davinci/include/mach/asp.h
index 834725f..5d0a4c7 100644
--- a/arch/arm/mach-davinci/include/mach/asp.h
+++ b/arch/arm/mach-davinci/include/mach/asp.h
@@ -52,7 +52,8 @@
 struct snd_platform_data {
 	u32 tx_dma_offset;
 	u32 rx_dma_offset;
-	enum dma_event_q eventq_no;	/* event queue number */
+	enum dma_event_q asp_chan_q;	/* event queue number for ASP channel */
+	enum dma_event_q ram_chan_q;	/* event queue number for RAM channel */
 	unsigned int codec_fmt;
 	/*
 	 * Allowing this is more efficient and eliminates left and right swaps
diff --git a/sound/soc/davinci/davinci-i2s.c b/sound/soc/davinci/davinci-i2s.c
index adadcd3..4c1a7d2 100644
--- a/sound/soc/davinci/davinci-i2s.c
+++ b/sound/soc/davinci/davinci-i2s.c
@@ -526,6 +526,8 @@ static int davinci_i2s_probe(struct platform_device *pdev)
 	struct snd_platform_data *pdata = pdev->dev.platform_data;
 	struct davinci_mcbsp_dev *dev;
 	struct resource *mem, *ioarea, *res;
+	enum dma_event_q asp_chan_q = EVENTQ_0;
+	enum dma_event_q ram_chan_q = EVENTQ_1;
 	int ret;
 
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -552,7 +554,15 @@ static int davinci_i2s_probe(struct platform_device *pdev)
 			pdata->sram_size_playback;
 		dev->dma_params[SNDRV_PCM_STREAM_CAPTURE].sram_size =
 			pdata->sram_size_capture;
+		asp_chan_q = pdata->asp_chan_q;
+		ram_chan_q = pdata->ram_chan_q;
 	}
+
+	dev->dma_params[SNDRV_PCM_STREAM_PLAYBACK].asp_chan_q	= asp_chan_q;
+	dev->dma_params[SNDRV_PCM_STREAM_PLAYBACK].ram_chan_q	= ram_chan_q;
+	dev->dma_params[SNDRV_PCM_STREAM_CAPTURE].asp_chan_q	= asp_chan_q;
+	dev->dma_params[SNDRV_PCM_STREAM_CAPTURE].ram_chan_q	= ram_chan_q;
+
 	dev->clk = clk_get(&pdev->dev, NULL);
 	if (IS_ERR(dev->clk)) {
 		ret = -ENODEV;
diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index d395509..b247208 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -890,7 +890,8 @@ static int davinci_mcasp_probe(struct platform_device *pdev)
 	dev->rxnumevt = pdata->rxnumevt;
 
 	dma_data = &dev->dma_params[SNDRV_PCM_STREAM_PLAYBACK];
-	dma_data->eventq_no = pdata->eventq_no;
+	dma_data->asp_chan_q = pdata->asp_chan_q;
+	dma_data->ram_chan_q = pdata->ram_chan_q;
 	dma_data->dma_addr = (dma_addr_t) (pdata->tx_dma_offset +
 							io_v2p(dev->base));
 
@@ -904,7 +905,8 @@ static int davinci_mcasp_probe(struct platform_device *pdev)
 	dma_data->channel = res->start;
 
 	dma_data = &dev->dma_params[SNDRV_PCM_STREAM_CAPTURE];
-	dma_data->eventq_no = pdata->eventq_no;
+	dma_data->asp_chan_q = pdata->asp_chan_q;
+	dma_data->ram_chan_q = pdata->ram_chan_q;
 	dma_data->dma_addr = (dma_addr_t)(pdata->rx_dma_offset +
 							io_v2p(dev->base));
 
diff --git a/sound/soc/davinci/davinci-pcm.c b/sound/soc/davinci/davinci-pcm.c
index 2dc406f..f026ac5 100644
--- a/sound/soc/davinci/davinci-pcm.c
+++ b/sound/soc/davinci/davinci-pcm.c
@@ -381,7 +381,7 @@ static int request_ping_pong(struct snd_pcm_substream *substream,
 	/* Request ram master channel */
 	link = prtd->ram_channel = edma_alloc_channel(EDMA_CHANNEL_ANY,
 				  davinci_pcm_dma_irq, substream,
-				  EVENTQ_1);
+				  prtd->params->ram_chan_q);
 	if (link < 0)
 		goto exit1;
 
@@ -477,7 +477,8 @@ static int davinci_pcm_dma_request(struct snd_pcm_substream *substream)
 
 	/* Request asp master DMA channel */
 	link = prtd->asp_channel = edma_alloc_channel(params->channel,
-			davinci_pcm_dma_irq, substream, EVENTQ_0);
+			davinci_pcm_dma_irq, substream,
+			prtd->params->asp_chan_q);
 	if (link < 0)
 		goto exit1;
 
diff --git a/sound/soc/davinci/davinci-pcm.h b/sound/soc/davinci/davinci-pcm.h
index 0764944..b799a02 100644
--- a/sound/soc/davinci/davinci-pcm.h
+++ b/sound/soc/davinci/davinci-pcm.h
@@ -21,7 +21,8 @@ struct davinci_pcm_dma_params {
 	unsigned short acnt;
 	dma_addr_t dma_addr;		/* device physical address for DMA */
 	unsigned sram_size;
-	enum dma_event_q eventq_no;	/* event queue number */
+	enum dma_event_q asp_chan_q;	/* event queue number for ASP channel */
+	enum dma_event_q ram_chan_q;	/* event queue number for RAM channel */
 	unsigned char data_type;	/* xfer data type */
 	unsigned char convert_mono_stereo;
 	unsigned int fifo_level;
-- 
1.6.2.4
