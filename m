From: Mark Brown <broonie@kernel.org>
Subject: [PATCH] ASoC: txx9aclc_ac97: Convert to
	devm_ioremap_resource()
Date: Wed, 26 Jun 2013 12:41:43 +0100
Message-ID: <1372246903-16874-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 02E55265379
 for <alsa-devel@alsa-project.org>; Wed, 26 Jun 2013 13:41:53 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@linaro.org>

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/txx9/txx9aclc-ac97.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/sound/soc/txx9/txx9aclc-ac97.c b/sound/soc/txx9/txx9aclc-ac97.c
index 8a28403..8ee8d42 100644
--- a/sound/soc/txx9/txx9aclc-ac97.c
+++ b/sound/soc/txx9/txx9aclc-ac97.c
@@ -188,9 +188,9 @@ static int txx9aclc_ac97_dev_probe(struct platform_device *pdev)
 	if (!r)
 		return -EBUSY;
 
-	if (!devm_request_mem_region(&pdev->dev, r->start, resource_size(r),
-				     dev_name(&pdev->dev)))
-		return -EBUSY;
+	drvdata->base = devm_ioremap_resource(&pdev->dev, r);
+	if (IS_ERR(drvdata->base))
+		return PTR_ERR(drvdata->base);
 
 	drvdata = devm_kzalloc(&pdev->dev, sizeof(*drvdata), GFP_KERNEL);
 	if (!drvdata)
@@ -201,9 +201,6 @@ static int txx9aclc_ac97_dev_probe(struct platform_device *pdev)
 	    r->start >= TXX9_DIRECTMAP_BASE &&
 	    r->start < TXX9_DIRECTMAP_BASE + 0x400000)
 		drvdata->physbase |= 0xf00000000ull;
-	drvdata->base = devm_ioremap(&pdev->dev, r->start, resource_size(r));
-	if (!drvdata->base)
-		return -EBUSY;
 	err = devm_request_irq(&pdev->dev, irq, txx9aclc_ac97_irq,
 			       0, dev_name(&pdev->dev), drvdata);
 	if (err < 0)
-- 
1.8.3.1
