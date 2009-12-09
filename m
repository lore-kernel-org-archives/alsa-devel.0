From: jassisinghbrar@gmail.com
Subject: [PATCH 6/7] ASoC: S3C64XX: Pass I2S base address from
	platform data
Date: Wed,  9 Dec 2009 13:29:54 +0900
Message-ID: <1260332994-11535-1-git-send-email-jassisinghbrar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	by alsa0.perex.cz (Postfix) with ESMTP id BF7BB243B2
	for <alsa-devel@alsa-project.org>; Wed,  9 Dec 2009 05:36:10 +0100 (CET)
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

Instead of having I2Sv2 core to figure out the base address of I2Sv3 controller
pass the address directly.

Signed-off-by: Jassi Brar <jassi.brar@samsung.com>
---
 sound/soc/s3c24xx/s3c64xx-i2s.c |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/sound/soc/s3c24xx/s3c64xx-i2s.c b/sound/soc/s3c24xx/s3c64xx-i2s.c
index 751a1b6..9cf62c2 100644
--- a/sound/soc/s3c24xx/s3c64xx-i2s.c
+++ b/sound/soc/s3c24xx/s3c64xx-i2s.c
@@ -166,6 +166,13 @@ static __devinit int s3c64xx_iis_dev_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "Unable to get I2S SFR address\n");
 		return -ENXIO;
 	}
+
+	if (!request_mem_region(res->start, resource_size(res),
+							"s3c64xx-i2s")) {
+		dev_err(&pdev->dev, "Unable to request SFR region\n");
+		return -EBUSY;
+	}
+
 	i2s->dma_capture->dma_addr = res->start + S3C2412_IISRXD;
 	i2s->dma_playback->dma_addr = res->start + S3C2412_IISTXD;
 
@@ -191,7 +198,8 @@ static __devinit int s3c64xx_iis_dev_probe(struct platform_device *pdev)
 
 	clk_enable(i2s->iis_cclk);
 
-	ret = s3c_i2sv2_probe(pdev, dai, i2s, 0);
+	ret = s3c_i2sv2_probe(pdev, dai, i2s,
+			i2s->dma_playback->dma_addr - S3C2412_IISTXD);
 	if (ret)
 		goto err_clk;
 
-- 
1.6.2.5
