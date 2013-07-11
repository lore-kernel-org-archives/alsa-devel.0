From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 4/6] ASoC: omap-dmic: Do not use
	platform_get_resource_byname() for DMA
Date: Thu, 11 Jul 2013 12:18:48 +0200
Message-ID: <1373537930-10467-5-git-send-email-peter.ujfalusi@ti.com>
References: <1373537930-10467-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
 by alsa0.perex.cz (Postfix) with ESMTP id 8D2492657BC
 for <alsa-devel@alsa-project.org>; Thu, 11 Jul 2013 12:19:02 +0200 (CEST)
In-Reply-To: <1373537930-10467-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org

The DMA resource no longer available via this API when booting with DT.
DMIC is only available on OMAP4/5 and both can boot with DT only.
Configure the dma_data.dma_name so omap-pcm can use different path to
request the DMA channel.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/omap/omap-dmic.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/sound/soc/omap/omap-dmic.c b/sound/soc/omap/omap-dmic.c
index 2ad0370..f66b033 100644
--- a/sound/soc/omap/omap-dmic.c
+++ b/sound/soc/omap/omap-dmic.c
@@ -57,7 +57,6 @@ struct omap_dmic {
 	struct mutex mutex;
 
 	struct snd_dmaengine_dai_dma_data dma_data;
-	unsigned int dma_req;
 };
 
 static inline void omap_dmic_write(struct omap_dmic *dmic, u16 reg, u32 val)
@@ -478,15 +477,7 @@ static int asoc_dmic_probe(struct platform_device *pdev)
 	}
 	dmic->dma_data.addr = res->start + OMAP_DMIC_DATA_REG;
 
-	res = platform_get_resource(pdev, IORESOURCE_DMA, 0);
-	if (!res) {
-		dev_err(dmic->dev, "invalid dma resource\n");
-		ret = -ENODEV;
-		goto err_put_clk;
-	}
-
-	dmic->dma_req = res->start;
-	dmic->dma_data.filter_data = &dmic->dma_req;
+	dmic->dma_data.dma_name = "up_link";
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "mpu");
 	if (!res) {
-- 
1.8.2.1
