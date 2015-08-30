From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] ASoC: au1x: psc-i2s: Convert to use
	devm_ioremap_resource
Date: Sun, 30 Aug 2015 11:09:49 +0800
Message-ID: <1440904189.32046.3.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f52.google.com (mail-pa0-f52.google.com
 [209.85.220.52])
 by alsa0.perex.cz (Postfix) with ESMTP id 52BAD260703
 for <alsa-devel@alsa-project.org>; Sun, 30 Aug 2015 05:09:54 +0200 (CEST)
Received: by pabzx8 with SMTP id zx8so101971563pab.1
 for <alsa-devel@alsa-project.org>; Sat, 29 Aug 2015 20:09:53 -0700 (PDT)
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
Cc: Manuel Lauss <manuel.lauss@gmail.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

Use devm_ioremap_resource() instead of open code.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 sound/soc/au1x/psc-i2s.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/sound/soc/au1x/psc-i2s.c b/sound/soc/au1x/psc-i2s.c
index e742ef6..38e853a 100644
--- a/sound/soc/au1x/psc-i2s.c
+++ b/sound/soc/au1x/psc-i2s.c
@@ -305,19 +305,9 @@ static int au1xpsc_i2s_drvprobe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	iores = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!iores)
-		return -ENODEV;
-
-	ret = -EBUSY;
-	if (!devm_request_mem_region(&pdev->dev, iores->start,
-				     resource_size(iores),
-				     pdev->name))
-		return -EBUSY;
-
-	wd->mmio = devm_ioremap(&pdev->dev, iores->start,
-				resource_size(iores));
-	if (!wd->mmio)
-		return -EBUSY;
+	wd->mmio = devm_ioremap_resource(&pdev->dev, iores);
+	if (IS_ERR(wd->mmio))
+		return PTR_ERR(wd->mmio);
 
 	dmares = platform_get_resource(pdev, IORESOURCE_DMA, 0);
 	if (!dmares)
-- 
2.1.0
