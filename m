From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 2/3] ASoC: omap-mcbsp: Convert to use
	devm_ioremap_resource
Date: Mon, 24 Aug 2015 16:49:05 +0800
Message-ID: <1440406145.27868.2.camel@ingics.com>
References: <1440406056.27868.0.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f45.google.com (mail-pa0-f45.google.com
 [209.85.220.45])
 by alsa0.perex.cz (Postfix) with ESMTP id 1F0B326063A
 for <alsa-devel@alsa-project.org>; Mon, 24 Aug 2015 10:49:11 +0200 (CEST)
Received: by padfa11 with SMTP id fa11so4883957pad.3
 for <alsa-devel@alsa-project.org>; Mon, 24 Aug 2015 01:49:10 -0700 (PDT)
In-Reply-To: <1440406056.27868.0.camel@ingics.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Vipin Kumar <vipin.kumar@st.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Jyri Sarha <jsarha@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Thomas =?ISO-8859-1?Q?Niederpr=FCm?= <niederp@physik.uni-kl.de>
List-Id: alsa-devel@alsa-project.org

Use devm_ioremap_resource() instead of open code.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 sound/soc/omap/mcbsp.c | 20 +++++---------------
 1 file changed, 5 insertions(+), 15 deletions(-)

diff --git a/sound/soc/omap/mcbsp.c b/sound/soc/omap/mcbsp.c
index 68a1252..c7563e2 100644
--- a/sound/soc/omap/mcbsp.c
+++ b/sound/soc/omap/mcbsp.c
@@ -965,25 +965,15 @@ int omap_mcbsp_init(struct platform_device *pdev)
 	mcbsp->free = true;
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "mpu");
-	if (!res) {
+	if (!res)
 		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-		if (!res) {
-			dev_err(mcbsp->dev, "invalid memory resource\n");
-			return -ENOMEM;
-		}
-	}
-	if (!devm_request_mem_region(&pdev->dev, res->start, resource_size(res),
-				     dev_name(&pdev->dev))) {
-		dev_err(mcbsp->dev, "memory region already claimed\n");
-		return -ENODEV;
-	}
+
+	mcbsp->io_base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(mcbsp->io_base))
+		return PTR_ERR(mcbsp->io_base);
 
 	mcbsp->phys_base = res->start;
 	mcbsp->reg_cache_size = resource_size(res);
-	mcbsp->io_base = devm_ioremap(&pdev->dev, res->start,
-				      resource_size(res));
-	if (!mcbsp->io_base)
-		return -ENOMEM;
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dma");
 	if (!res)
-- 
2.1.0
