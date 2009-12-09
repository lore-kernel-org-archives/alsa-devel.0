From: jassisinghbrar@gmail.com
Subject: [PATCH 4/7] ASoC: S3C64XX: USE DMA info from platform
	data
Date: Wed,  9 Dec 2009 13:29:38 +0900
Message-ID: <1260332978-11475-1-git-send-email-jassisinghbrar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	by alsa0.perex.cz (Postfix) with ESMTP id 60037243B7
	for <alsa-devel@alsa-project.org>; Wed,  9 Dec 2009 05:36:11 +0100 (CET)
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
Cc: broonie@opensource.wolfsonmicro.com, Jassi Brar <jassi.brar@samsung.com>, ben-linux@fluff.org
List-Id: alsa-devel@alsa-project.org

From: Jassi Brar <jassi.brar@samsung.com>

Instead of hardcoding DMA channel numbers and address, for each controller
in the driver, let the information be read from platform data.

Signed-off-by: Jassi Brar <jassi.brar@samsung.com>
---
 sound/soc/s3c24xx/s3c64xx-i2s.c |   31 +++++++++++++++++++++----------
 1 files changed, 21 insertions(+), 10 deletions(-)

diff --git a/sound/soc/s3c24xx/s3c64xx-i2s.c b/sound/soc/s3c24xx/s3c64xx-i2s.c
index 93ed3aa..8ca3c1d 100644
--- a/sound/soc/s3c24xx/s3c64xx-i2s.c
+++ b/sound/soc/s3c24xx/s3c64xx-i2s.c
@@ -147,6 +147,7 @@ static __devinit int s3c64xx_iis_dev_probe(struct platform_device *pdev)
 {
 	struct s3c_i2sv2_info *i2s;
 	struct snd_soc_dai *dai;
+	struct resource *res;
 	int ret;
 
 	if (pdev->id >= MAX_I2SV3) {
@@ -174,17 +175,27 @@ static __devinit int s3c64xx_iis_dev_probe(struct platform_device *pdev)
 	i2s->dma_capture = &s3c64xx_i2s_pcm_stereo_in[pdev->id];
 	i2s->dma_playback = &s3c64xx_i2s_pcm_stereo_out[pdev->id];
 
-	if (pdev->id == 0) {
-		i2s->dma_capture->channel = DMACH_I2S0_IN;
-		i2s->dma_capture->dma_addr = S3C64XX_PA_IIS0 + S3C2412_IISRXD;
-		i2s->dma_playback->channel = DMACH_I2S0_OUT;
-		i2s->dma_playback->dma_addr = S3C64XX_PA_IIS0 + S3C2412_IISTXD;
-	} else {
-		i2s->dma_capture->channel = DMACH_I2S1_IN;
-		i2s->dma_capture->dma_addr = S3C64XX_PA_IIS1 + S3C2412_IISRXD;
-		i2s->dma_playback->channel = DMACH_I2S1_OUT;
-		i2s->dma_playback->dma_addr = S3C64XX_PA_IIS1 + S3C2412_IISTXD;
+	res = platform_get_resource(pdev, IORESOURCE_DMA, 0);
+	if (!res) {
+		dev_err(&pdev->dev, "Unable to get I2S-TX dma resource\n");
+		return -ENXIO;
 	}
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
+	i2s->dma_capture->dma_addr = res->start + S3C2412_IISRXD;
+	i2s->dma_playback->dma_addr = res->start + S3C2412_IISTXD;
 
 	i2s->dma_capture->client = &s3c64xx_dma_client_in;
 	i2s->dma_capture->dma_size = 4;
-- 
1.6.2.5
