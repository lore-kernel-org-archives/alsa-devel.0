From: Mark Brown <broonie@kernel.org>
Subject: [PATCH] ASoC: nuc900-ac97: Convert to use devm_ APIs
Date: Wed, 26 Jun 2013 12:08:30 +0100
Message-ID: <1372244910-14027-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 4AA18265312
 for <alsa-devel@alsa-project.org>; Wed, 26 Jun 2013 13:08:39 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@linaro.org>

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/nuc900/nuc900-ac97.c | 43 ++++++++++--------------------------------
 1 file changed, 10 insertions(+), 33 deletions(-)

diff --git a/sound/soc/nuc900/nuc900-ac97.c b/sound/soc/nuc900/nuc900-ac97.c
index fe3285c..08e4c6b 100644
--- a/sound/soc/nuc900/nuc900-ac97.c
+++ b/sound/soc/nuc900/nuc900-ac97.c
@@ -326,32 +326,23 @@ static int nuc900_ac97_drvprobe(struct platform_device *pdev)
 	if (nuc900_ac97_data)
 		return -EBUSY;
 
-	nuc900_audio = kzalloc(sizeof(struct nuc900_audio), GFP_KERNEL);
+	nuc900_audio = devm_kzalloc(&pdev->dev, sizeof(struct nuc900_audio),
+				    GFP_KERNEL);
 	if (!nuc900_audio)
 		return -ENOMEM;
 
 	spin_lock_init(&nuc900_audio->lock);
 
 	nuc900_audio->res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!nuc900_audio->res) {
-		ret = -ENODEV;
-		goto out0;
-	}
+	if (!nuc900_audio->res)
+		return ret;
 
-	if (!request_mem_region(nuc900_audio->res->start,
-			resource_size(nuc900_audio->res), pdev->name)) {
-		ret = -EBUSY;
-		goto out0;
-	}
+	nuc900_audio->mmio = devm_ioremap_resource(&pdev->dev,
+						   nuc900_audio->res);
+	if (IS_ERR(nuc900_audio->mmio))
+		return PTR_ERR(nuc900_audio->mmio);
 
-	nuc900_audio->mmio = ioremap(nuc900_audio->res->start,
-					resource_size(nuc900_audio->res));
-	if (!nuc900_audio->mmio) {
-		ret = -ENOMEM;
-		goto out1;
-	}
-
-	nuc900_audio->clk = clk_get(&pdev->dev, NULL);
+	nuc900_audio->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(nuc900_audio->clk)) {
 		ret = PTR_ERR(nuc900_audio->clk);
 		goto out2;
@@ -375,15 +366,7 @@ static int nuc900_ac97_drvprobe(struct platform_device *pdev)
 
 	return 0;
 
-out3:
-	clk_put(nuc900_audio->clk);
-out2:
-	iounmap(nuc900_audio->mmio);
-out1:
-	release_mem_region(nuc900_audio->res->start,
-					resource_size(nuc900_audio->res));
-out0:
-	kfree(nuc900_audio);
+out:
 	return ret;
 }
 
@@ -391,12 +374,6 @@ static int nuc900_ac97_drvremove(struct platform_device *pdev)
 {
 	snd_soc_unregister_component(&pdev->dev);
 
-	clk_put(nuc900_ac97_data->clk);
-	iounmap(nuc900_ac97_data->mmio);
-	release_mem_region(nuc900_ac97_data->res->start,
-				resource_size(nuc900_ac97_data->res));
-
-	kfree(nuc900_ac97_data);
 	nuc900_ac97_data = NULL;
 
 	return 0;
-- 
1.8.3.1
