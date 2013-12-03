From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/2] ASoC: jz4740-i2s: Use managed resources
Date: Tue,  3 Dec 2013 18:53:02 +0100
Message-ID: <1386093183-14625-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-110.synserver.de (smtp-out-012.synserver.de
 [212.40.185.12])
 by alsa0.perex.cz (Postfix) with ESMTP id D68E926524C
 for <alsa-devel@alsa-project.org>; Tue,  3 Dec 2013 18:52:03 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

Makes the code a bit shorter.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/jz4740/jz4740-i2s.c |   85 ++++++++---------------------------------
 1 file changed, 15 insertions(+), 70 deletions(-)

diff --git a/sound/soc/jz4740/jz4740-i2s.c b/sound/soc/jz4740/jz4740-i2s.c
index 4c849a4..a0b6a85 100644
--- a/sound/soc/jz4740/jz4740-i2s.c
+++ b/sound/soc/jz4740/jz4740-i2s.c
@@ -432,91 +432,36 @@ static const struct snd_soc_component_driver jz4740_i2s_component = {
 static int jz4740_i2s_dev_probe(struct platform_device *pdev)
 {
 	struct jz4740_i2s *i2s;
+	struct resource *mem;
 	int ret;
 
-	i2s = kzalloc(sizeof(*i2s), GFP_KERNEL);
-
+	i2s = devm_kzalloc(&pdev->dev, sizeof(*i2s), GFP_KERNEL);
 	if (!i2s)
 		return -ENOMEM;
 
-	i2s->mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!i2s->mem) {
-		ret = -ENOENT;
-		goto err_free;
-	}
-
-	i2s->mem = request_mem_region(i2s->mem->start, resource_size(i2s->mem),
-				pdev->name);
-	if (!i2s->mem) {
-		ret = -EBUSY;
-		goto err_free;
-	}
-
-	i2s->base = ioremap_nocache(i2s->mem->start, resource_size(i2s->mem));
-	if (!i2s->base) {
-		ret = -EBUSY;
-		goto err_release_mem_region;
-	}
+	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	i2s->base = devm_ioremap_resource(&pdev->dev, mem);
+	if (IS_ERR(i2s->base))
+		return PTR_ERR(i2s->base);
 
-	i2s->phys_base = i2s->mem->start;
+	i2s->phys_base = mem->start;
 
-	i2s->clk_aic = clk_get(&pdev->dev, "aic");
-	if (IS_ERR(i2s->clk_aic)) {
-		ret = PTR_ERR(i2s->clk_aic);
-		goto err_iounmap;
-	}
+	i2s->clk_aic = devm_clk_get(&pdev->dev, "aic");
+	if (IS_ERR(i2s->clk_aic))
+		return PTR_ERR(i2s->clk_aic);
 
-	i2s->clk_i2s = clk_get(&pdev->dev, "i2s");
-	if (IS_ERR(i2s->clk_i2s)) {
-		ret = PTR_ERR(i2s->clk_i2s);
-		goto err_clk_put_aic;
-	}
+	i2s->clk_i2s = devm_clk_get(&pdev->dev, "i2s");
+	if (IS_ERR(i2s->clk_i2s))
+		return PTR_ERR(i2s->clk_i2s);
 
 	platform_set_drvdata(pdev, i2s);
-	ret = snd_soc_register_component(&pdev->dev, &jz4740_i2s_component,
-					 &jz4740_i2s_dai, 1);
-
-	if (ret) {
-		dev_err(&pdev->dev, "Failed to register DAI\n");
-		goto err_clk_put_i2s;
-	}
-
-	return 0;
-
-err_clk_put_i2s:
-	clk_put(i2s->clk_i2s);
-err_clk_put_aic:
-	clk_put(i2s->clk_aic);
-err_iounmap:
-	iounmap(i2s->base);
-err_release_mem_region:
-	release_mem_region(i2s->mem->start, resource_size(i2s->mem));
-err_free:
-	kfree(i2s);
-
-	return ret;
-}
-
-static int jz4740_i2s_dev_remove(struct platform_device *pdev)
-{
-	struct jz4740_i2s *i2s = platform_get_drvdata(pdev);
-
-	snd_soc_unregister_component(&pdev->dev);
-
-	clk_put(i2s->clk_i2s);
-	clk_put(i2s->clk_aic);
 
-	iounmap(i2s->base);
-	release_mem_region(i2s->mem->start, resource_size(i2s->mem));
-
-	kfree(i2s);
-
-	return 0;
+	return devm_snd_soc_register_component(&pdev->dev,
+		&jz4740_i2s_component, &jz4740_i2s_dai, 1);
 }
 
 static struct platform_driver jz4740_i2s_driver = {
 	.probe = jz4740_i2s_dev_probe,
-	.remove = jz4740_i2s_dev_remove,
 	.driver = {
 		.name = "jz4740-i2s",
 		.owner = THIS_MODULE,
-- 
1.7.10.4
