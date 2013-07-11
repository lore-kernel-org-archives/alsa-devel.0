From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 3/6] ASoC: omap-mcpdm: Do not use
	platform_get_resource_byname() for DMA
Date: Thu, 11 Jul 2013 12:18:47 +0200
Message-ID: <1373537930-10467-4-git-send-email-peter.ujfalusi@ti.com>
References: <1373537930-10467-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
 by alsa0.perex.cz (Postfix) with ESMTP id 96B9D2657B7
 for <alsa-devel@alsa-project.org>; Thu, 11 Jul 2013 12:19:01 +0200 (CEST)
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
McPDM is only available on OMAP4/5 and both can boot with DT only.
Configure the dma_data.dma_name so omap-pcm can use different path to
request the DMA channel.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/omap/omap-mcpdm.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/sound/soc/omap/omap-mcpdm.c b/sound/soc/omap/omap-mcpdm.c
index eb05c7e..4f376cb 100644
--- a/sound/soc/omap/omap-mcpdm.c
+++ b/sound/soc/omap/omap-mcpdm.c
@@ -66,7 +66,6 @@ struct omap_mcpdm {
 	bool restart;
 
 	struct snd_dmaengine_dai_dma_data dma_data[2];
-	unsigned int dma_req[2];
 };
 
 /*
@@ -477,19 +476,8 @@ static int asoc_mcpdm_probe(struct platform_device *pdev)
 	mcpdm->dma_data[0].addr = res->start + MCPDM_REG_DN_DATA;
 	mcpdm->dma_data[1].addr = res->start + MCPDM_REG_UP_DATA;
 
-	res = platform_get_resource_byname(pdev, IORESOURCE_DMA, "dn_link");
-	if (!res)
-		return -ENODEV;
-
-	mcpdm->dma_req[0] = res->start;
-	mcpdm->dma_data[0].filter_data = &mcpdm->dma_req[0];
-
-	res = platform_get_resource_byname(pdev, IORESOURCE_DMA, "up_link");
-	if (!res)
-		return -ENODEV;
-
-	mcpdm->dma_req[1] = res->start;
-	mcpdm->dma_data[1].filter_data = &mcpdm->dma_req[1];
+	mcpdm->dma_data[0].dma_name = "dn_link";
+	mcpdm->dma_data[1].dma_name = "up_link";
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "mpu");
 	if (res == NULL)
-- 
1.8.2.1
