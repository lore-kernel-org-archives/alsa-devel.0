From: Seungwhan Youn <sw.youn@samsung.com>
Subject: [PATCHv2 2/4] ASoC: S3C64XX: Move DMA settings to
	platform
Date: Fri, 16 Jul 2010 15:24:08 +0900
Message-ID: <1279261448-18457-1-git-send-email-sw.youn@samsung.com>
References: <1279260977-18342-1-git-send-email-sw.youn@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	by alsa0.perex.cz (Postfix) with ESMTP id 94C1F103984
	for <alsa-devel@alsa-project.org>;
	Fri, 16 Jul 2010 08:34:58 +0200 (CEST)
In-Reply-To: <1279260977-18342-1-git-send-email-sw.youn@samsung.com>
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
Cc: Seungwhan Youn <sw.youn@samsung.com>, Jassi Brar <jassisinghbrar@gmail.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Seungwhan Youn <claude.youn@gmail.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Remove the hardcoded values for DMA and SFR addresses. Instead enable
the CPU drivers to use the values provided via platform_data

Signed-off-by: Seungwhan Youn <sw.youn@samsung.com>
Reviewed-by: Jassi Brar <jassi.brar@samsung.com>
---
 sound/soc/s3c24xx/s3c64xx-i2s-v4.c |   32 +++++++++++++++++--
 sound/soc/s3c24xx/s3c64xx-i2s.c    |   60 ++++++++++++++++++++++--------------
 2 files changed, 65 insertions(+), 27 deletions(-)

diff --git a/sound/soc/s3c24xx/s3c64xx-i2s-v4.c b/sound/soc/s3c24xx/s3c64xx-i2s-v4.c
index 93ae973..74cf2b2 100644
--- a/sound/soc/s3c24xx/s3c64xx-i2s-v4.c
+++ b/sound/soc/s3c24xx/s3c64xx-i2s-v4.c
@@ -109,6 +109,7 @@ static __devinit int s3c64xx_i2sv4_dev_probe(struct platform_device *pdev)
 {
 	struct s3c_audio_pdata *i2s_pdata;
 	struct s3c_i2sv2_info *i2s;
+	struct resource *res;
 	int ret;
 
 	i2s = &s3c64xx_i2sv4;
@@ -118,10 +119,33 @@ static __devinit int s3c64xx_i2sv4_dev_probe(struct platform_device *pdev)
 	i2s->dma_capture = &s3c64xx_i2sv4_pcm_stereo_in;
 	i2s->dma_playback = &s3c64xx_i2sv4_pcm_stereo_out;
 
-	i2s->dma_capture->channel = DMACH_HSI_I2SV40_RX;
-	i2s->dma_capture->dma_addr = S3C64XX_PA_IISV4 + S3C2412_IISRXD;
-	i2s->dma_playback->channel = DMACH_HSI_I2SV40_TX;
-	i2s->dma_playback->dma_addr = S3C64XX_PA_IISV4 + S3C2412_IISTXD;
+	res = platform_get_resource(pdev, IORESOURCE_DMA, 0);
+	if (!res) {
+		dev_err(&pdev->dev, "Unable to get I2S-TX dma resource\n");
+		return -ENXIO;
+	}
+	i2s->dma_playback->channel = res->start;
+
+	res = platform_get_resource(pdev, IORESOURCE_DMA, 1);
+	if (!res) {
+		dev_err(&pdev->dev, "Unable to get I2S-RX dma resource\n");
+		return -ENXIO;
+	}
+	i2s->dma_capture->channel = res->start;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		dev_err(&pdev->dev, "Unable to get I2S SFR address\n");
+		return -ENXIO;
+	}
+
+	if (!request_mem_region(res->start, resource_size(res),
+				"s3c64xx-i2s-v4")) {
+		dev_err(&pdev->dev, "Unable to request SFR region\n");
+		return -EBUSY;
+	}
+	i2s->dma_capture->dma_addr = res->start + S3C2412_IISRXD;
+	i2s->dma_playback->dma_addr = res->start + S3C2412_IISTXD;
 
 	i2s->dma_capture->client = &s3c64xx_dma_client_in;
 	i2s->dma_capture->dma_size = 4;
diff --git a/sound/soc/s3c24xx/s3c64xx-i2s.c b/sound/soc/s3c24xx/s3c64xx-i2s.c
index ab2ae47..c63925e 100644
--- a/sound/soc/s3c24xx/s3c64xx-i2s.c
+++ b/sound/soc/s3c24xx/s3c64xx-i2s.c
@@ -108,29 +108,6 @@ static int s3c64xx_i2s_probe(struct snd_soc_dai *dai)
 	i2s = &s3c64xx_i2s[dai->id];
 	snd_soc_dai_set_drvdata(dai, i2s);
 
-	i2s->dma_capture = &s3c64xx_i2s_pcm_stereo_in[dai->id];
-	i2s->dma_playback = &s3c64xx_i2s_pcm_stereo_out[dai->id];
-
-	switch (dai->id) {
-	case 0:
-		i2s->dma_capture->channel = DMACH_I2S0_IN;
-		i2s->dma_capture->dma_addr = S3C64XX_PA_IIS0 + S3C2412_IISRXD;
-		i2s->dma_playback->channel = DMACH_I2S0_OUT;
-		i2s->dma_playback->dma_addr = S3C64XX_PA_IIS0 + S3C2412_IISTXD;
-		break;
-	case 1:
-		i2s->dma_capture->channel = DMACH_I2S1_IN;
-		i2s->dma_capture->dma_addr = S3C64XX_PA_IIS1 + S3C2412_IISRXD;
-		i2s->dma_playback->channel = DMACH_I2S1_OUT;
-		i2s->dma_playback->dma_addr = S3C64XX_PA_IIS1 + S3C2412_IISTXD;
-		break;
-	}
-
-	i2s->dma_capture->client = &s3c64xx_dma_client_in;
-	i2s->dma_capture->dma_size = 4;
-	i2s->dma_playback->client = &s3c64xx_dma_client_out;
-	i2s->dma_playback->dma_size = 4;
-
 	i2s->iis_cclk = clk_get(dai->dev, "audio-bus");
 	if (IS_ERR(i2s->iis_cclk)) {
 		dev_err(dai->dev, "failed to get audio-bus\n");
@@ -199,6 +176,7 @@ static __devinit int s3c64xx_iis_dev_probe(struct platform_device *pdev)
 {
 	struct s3c_audio_pdata *i2s_pdata;
 	struct s3c_i2sv2_info *i2s;
+	struct resource *res;
 
 	if (pdev->id >= MAX_I2SV3) {
 		dev_err(&pdev->dev, "id %d out of range\n", pdev->id);
@@ -207,11 +185,47 @@ static __devinit int s3c64xx_iis_dev_probe(struct platform_device *pdev)
 
 	i2s = &s3c64xx_i2s[pdev->id];
 
+	i2s->dma_capture = &s3c64xx_i2s_pcm_stereo_in[pdev->id];
+	i2s->dma_playback = &s3c64xx_i2s_pcm_stereo_out[pdev->id];
+
+	res = platform_get_resource(pdev, IORESOURCE_DMA, 0);
+	if (!res) {
+		dev_err(&pdev->dev, "Unable to get I2S-TX dma resource\n");
+		return -ENXIO;
+	}
+	i2s->dma_playback->channel = res->start;
+
+	res = platform_get_resource(pdev, IORESOURCE_DMA, 1);
+	if (!res) {
+		dev_err(&pdev->dev, "Unable to get I2S-RX dma resource\n");
+		return -ENXIO;
+	}
+	i2s->dma_capture->channel = res->start;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		dev_err(&pdev->dev, "Unable to get I2S SFR address\n");
+		return -ENXIO;
+	}
+
+	if (!request_mem_region(res->start, resource_size(res),
+				"s3c64xx-i2s")) {
+		dev_err(&pdev->dev, "Unable to request SFR region\n");
+		return -EBUSY;
+	}
+
 	i2s_pdata = pdev->dev.platform_data;
 	if (i2s_pdata && i2s_pdata->cfg_gpio && i2s_pdata->cfg_gpio(pdev)) {
 		dev_err(&pdev->dev, "Unable to configure gpio\n");
 		return -EINVAL;
 	}
+	i2s->dma_capture->dma_addr = res->start + S3C2412_IISRXD;
+	i2s->dma_playback->dma_addr = res->start + S3C2412_IISTXD;
+
+	i2s->dma_capture->client = &s3c64xx_dma_client_in;
+	i2s->dma_capture->dma_size = 4;
+	i2s->dma_playback->client = &s3c64xx_dma_client_out;
+	i2s->dma_playback->dma_size = 4;
 
 	return snd_soc_register_dais(&pdev->dev, s3c64xx_i2s_dai,
 			ARRAY_SIZE(s3c64xx_i2s_dai));
-- 
1.6.2.5
