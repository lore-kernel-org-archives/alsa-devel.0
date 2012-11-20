From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH 06/10] ASoC: kirkwood-i2s: use devm_* APIs
Date: Tue, 20 Nov 2012 12:19:33 +0000
Message-ID: <E1Tamnd-0007XT-Lm@rmk-PC.arm.linux.org.uk>
References: <20121120121726.GN3290@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
 [78.32.30.218]) by alsa0.perex.cz (Postfix) with ESMTP id 6E537265376
 for <alsa-devel@alsa-project.org>; Tue, 20 Nov 2012 13:19:35 +0100 (CET)
In-Reply-To: <20121120121726.GN3290@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Takashi Iwai <tiwai@suse.de>, Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>, Liam Girdwood <lrg@ti.com>, Rabeeh Khoury <rabeeh@solid-run.com>
List-Id: alsa-devel@alsa-project.org

Simplify the cleanup paths in the driver by using the devm_* APIs,
ensuring that all error paths are correctly checked.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 sound/soc/kirkwood/kirkwood-i2s.c |   53 ++++++++++--------------------------
 sound/soc/kirkwood/kirkwood.h     |    1 -
 2 files changed, 15 insertions(+), 39 deletions(-)

diff --git a/sound/soc/kirkwood/kirkwood-i2s.c b/sound/soc/kirkwood/kirkwood-i2s.c
index 1d5db48..f059f40 100644
--- a/sound/soc/kirkwood/kirkwood-i2s.c
+++ b/sound/soc/kirkwood/kirkwood-i2s.c
@@ -406,57 +406,47 @@ static __devinit int kirkwood_i2s_dev_probe(struct platform_device *pdev)
 	struct kirkwood_dma_data *priv;
 	int err;
 
-	priv = kzalloc(sizeof(struct kirkwood_dma_data), GFP_KERNEL);
+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv) {
 		dev_err(&pdev->dev, "allocation failed\n");
-		err = -ENOMEM;
-		goto error;
+		return -ENOMEM;
 	}
 	dev_set_drvdata(&pdev->dev, priv);
 
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!mem) {
 		dev_err(&pdev->dev, "platform_get_resource failed\n");
-		err = -ENXIO;
-		goto err_alloc;
+		return -ENXIO;
 	}
 
-	priv->mem = request_mem_region(mem->start, SZ_16K, DRV_NAME);
-	if (!priv->mem) {
-		dev_err(&pdev->dev, "request_mem_region failed\n");
-		err = -EBUSY;
-		goto err_alloc;
-	}
-
-	priv->io = ioremap(priv->mem->start, SZ_16K);
+	priv->io = devm_request_and_ioremap(&pdev->dev, mem);
 	if (!priv->io) {
-		dev_err(&pdev->dev, "ioremap failed\n");
-		err = -ENOMEM;
-		goto err_iomem;
+		dev_err(&pdev->dev, "devm_request_and_ioremap failed\n");
+		return -ENOMEM;
 	}
 
 	priv->irq = platform_get_irq(pdev, 0);
 	if (priv->irq <= 0) {
 		dev_err(&pdev->dev, "platform_get_irq failed\n");
-		err = -ENXIO;
-		goto err_ioremap;
+		return -ENXIO;
 	}
 
 	if (!data) {
 		dev_err(&pdev->dev, "no platform data ?!\n");
-		err = -EINVAL;
-		goto err_ioremap;
+		return -EINVAL;
 	}
 
 	priv->burst = data->burst;
 
-	priv->clk = clk_get(&pdev->dev, NULL);
+	priv->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(priv->clk)) {
 		dev_err(&pdev->dev, "no clock\n");
-		err = PTR_ERR(priv->clk);
-		goto err_ioremap;
+		return PTR_ERR(priv->clk);
 	}
-	clk_prepare_enable(priv->clk);
+
+	err = clk_prepare_enable(priv->clk);
+	if (err < 0)
+		return err;
 
 	err = snd_soc_register_dai(&pdev->dev, &kirkwood_i2s_dai);
 	if (!err)
@@ -464,15 +454,7 @@ static __devinit int kirkwood_i2s_dev_probe(struct platform_device *pdev)
 	dev_err(&pdev->dev, "snd_soc_register_dai failed\n");
 
 	clk_disable_unprepare(priv->clk);
-	clk_put(priv->clk);
-
-err_ioremap:
-	iounmap(priv->io);
-err_iomem:
-	release_mem_region(priv->mem->start, SZ_16K);
-err_alloc:
-	kfree(priv);
-error:
+
 	return err;
 }
 
@@ -483,11 +465,6 @@ static __devexit int kirkwood_i2s_dev_remove(struct platform_device *pdev)
 	snd_soc_unregister_dai(&pdev->dev);
 
 	clk_disable_unprepare(priv->clk);
-	clk_put(priv->clk);
-
-	iounmap(priv->io);
-	release_mem_region(priv->mem->start, SZ_16K);
-	kfree(priv);
 
 	return 0;
 }
diff --git a/sound/soc/kirkwood/kirkwood.h b/sound/soc/kirkwood/kirkwood.h
index f9084d8..7d92b9e 100644
--- a/sound/soc/kirkwood/kirkwood.h
+++ b/sound/soc/kirkwood/kirkwood.h
@@ -119,7 +119,6 @@
 #define KIRKWOOD_SND_MAX_PERIOD_BYTES		0x4000
 
 struct kirkwood_dma_data {
-	struct resource *mem;
 	void __iomem *io;
 	int irq;
 	int burst;
-- 
1.7.4.4
