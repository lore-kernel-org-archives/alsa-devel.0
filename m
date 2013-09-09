From: <oku@iki.fi>
Subject: [PATCH RFC 4/8] ASoC: davinci-mcasp: Extract DMA
	channels directly from DT
Date: Mon, 9 Sep 2013 18:12:15 +0300
Message-ID: <77252c8cec5eec2754d2449be2515dd8d5663e5b.1378738436.git.jsarha@ti.com>
References: <cover.1378738436.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
 by alsa0.perex.cz (Postfix) with ESMTP id 2752126510C
 for <alsa-devel@alsa-project.org>; Mon,  9 Sep 2013 17:12:31 +0200 (CEST)
In-Reply-To: <cover.1378738436.git.jsarha@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: liam.r.girdwood@linux.intel.com, devicetree-discuss@lists.ozlabs.org, broonie@kernel.org, Jyri Sarha <jsarha@ti.com>
List-Id: alsa-devel@alsa-project.org

From: Jyri Sarha <jsarha@ti.com>

Extract DMA channels directly from DT as they can not be found from
platform resources anymore. This is a work-around until davinci audio
driver is updated to use dmaengine.

Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 include/linux/platform_data/davinci_asp.h |    2 ++
 sound/soc/davinci/davinci-mcasp.c         |   47 ++++++++++++++++++++---------
 2 files changed, 34 insertions(+), 15 deletions(-)

diff --git a/include/linux/platform_data/davinci_asp.h b/include/linux/platform_data/davinci_asp.h
index 8db5ae0..689a856 100644
--- a/include/linux/platform_data/davinci_asp.h
+++ b/include/linux/platform_data/davinci_asp.h
@@ -84,6 +84,8 @@ struct snd_platform_data {
 	u8 version;
 	u8 txnumevt;
 	u8 rxnumevt;
+	int tx_dma_channel;
+	int rx_dma_channel;
 };
 
 enum {
diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index cc02255..1ca8891 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -1026,6 +1026,7 @@ static struct snd_platform_data *davinci_mcasp_set_pdata_from_of(
 	struct snd_platform_data *pdata = NULL;
 	const struct of_device_id *match =
 			of_match_device(mcasp_dt_ids, &pdev->dev);
+	struct of_phandle_args dma_spec;
 
 	const u32 *of_serial_dir32;
 	u8 *of_serial_dir;
@@ -1103,6 +1104,28 @@ static struct snd_platform_data *davinci_mcasp_set_pdata_from_of(
 	if (ret >= 0)
 		pdata->ram_chan_q = val;
 
+	ret = of_property_match_string(np, "dma-names", "tx");
+	if (ret < 0)
+		goto nodata;
+
+	ret = of_parse_phandle_with_args(np, "dmas", "#dma-cells", ret,
+					 &dma_spec);
+	if (ret < 0)
+		goto nodata;
+
+	pdata->tx_dma_channel = dma_spec.args[0];
+
+	ret = of_property_match_string(np, "dma-names", "rx");
+	if (ret < 0)
+		goto nodata;
+
+	ret = of_parse_phandle_with_args(np, "dmas", "#dma-cells", ret,
+					 &dma_spec);
+	if (ret < 0)
+		goto nodata;
+
+	pdata->rx_dma_channel = dma_spec.args[0];
+
 	ret = of_property_read_u32(np, "tx-num-evt", &val);
 	if (ret >= 0)
 		pdata->txnumevt = val;
@@ -1133,7 +1156,7 @@ nodata:
 static int davinci_mcasp_probe(struct platform_device *pdev)
 {
 	struct davinci_pcm_dma_params *dma_data;
-	struct resource *mem, *ioarea, *res;
+	struct resource *mem, *ioarea, *res, *dma;
 	struct snd_platform_data *pdata;
 	struct davinci_audio_dev *dev;
 	struct pinctrl *pinctrl;
@@ -1218,15 +1241,11 @@ static int davinci_mcasp_probe(struct platform_device *pdev)
 	dma_data->sram_size = pdata->sram_size_playback;
 	dma_data->dma_addr = pdata->tx_dma_offset;
 
-	/* first TX, then RX */
 	res = platform_get_resource(pdev, IORESOURCE_DMA, 0);
-	if (!res) {
-		dev_err(&pdev->dev, "no DMA resource\n");
-		ret = -ENODEV;
-		goto err_release_clk;
-	}
-
-	dma_data->channel = res->start;
+	if (res)
+		dma_data->channel = res->start;
+	else
+		dma_data->channel = pdata->tx_dma_channel;
 
 	dma_data = &dev->dma_params[SNDRV_PCM_STREAM_CAPTURE];
 	dma_data->asp_chan_q = pdata->asp_chan_q;
@@ -1236,13 +1255,11 @@ static int davinci_mcasp_probe(struct platform_device *pdev)
 	dma_data->dma_addr = pdata->rx_dma_offset;
 
 	res = platform_get_resource(pdev, IORESOURCE_DMA, 1);
-	if (!res) {
-		dev_err(&pdev->dev, "no DMA resource\n");
-		ret = -ENODEV;
-		goto err_release_clk;
-	}
+	if (res)
+		dma_data->channel = res->start;
+	else
+		dma_data->channel = pdata->rx_dma_channel;
 
-	dma_data->channel = res->start;
 	dev_set_drvdata(&pdev->dev, dev);
 	ret = snd_soc_register_component(&pdev->dev, &davinci_mcasp_component,
 					 &davinci_mcasp_dai[pdata->op_mode], 1);
-- 
1.7.9.5
