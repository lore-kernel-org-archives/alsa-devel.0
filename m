From: Mark Brown <broonie@linaro.org>
Subject: [PATCH 1/3] ASoC: psc-ac97: Use devm_ioremap_resource()
Date: Wed, 26 Jun 2013 11:32:28 +0100
Message-ID: <1372242750-8954-1-git-send-email-broonie@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id DEF9F2652F9
 for <alsa-devel@alsa-project.org>; Wed, 26 Jun 2013 12:32:33 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Manuel Lauss <manuel.lauss@googlemail.com>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/au1x/psc-ac97.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/sound/soc/au1x/psc-ac97.c b/sound/soc/au1x/psc-ac97.c
index 8f1862a..f5a3921 100644
--- a/sound/soc/au1x/psc-ac97.c
+++ b/sound/soc/au1x/psc-ac97.c
@@ -383,15 +383,9 @@ static int au1xpsc_ac97_drvprobe(struct platform_device *pdev)
 	if (!iores)
 		return -ENODEV;
 
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
1.8.3.1
