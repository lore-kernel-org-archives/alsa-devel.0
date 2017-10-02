From: Ed Blake <ed.blake@sondrel.com>
Subject: [PATCH 3/3] ASoC: img-i2s-out: Add control of sys
	clock to runtime PM
Date: Mon,  2 Oct 2017 10:59:47 +0100
Message-ID: <1506938387-627-4-git-send-email-ed.blake@sondrel.com>
References: <1506938387-627-1-git-send-email-ed.blake@sondrel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
 (mail-eopbgr10079.outbound.protection.outlook.com [40.107.1.79])
 by alsa0.perex.cz (Postfix) with ESMTP id 997932671C7
 for <alsa-devel@alsa-project.org>; Mon,  2 Oct 2017 12:00:03 +0200 (CEST)
In-Reply-To: <1506938387-627-1-git-send-email-ed.blake@sondrel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: lgirdwood@gmail.com, broonie@kernel.org
Cc: alsa-devel@alsa-project.org, Ed Blake <ed.blake@sondrel.com>
List-Id: alsa-devel@alsa-project.org

Disable sys clock as well as ref clock when runtime suspended.

Signed-off-by: Ed Blake <ed.blake@sondrel.com>
---
 sound/soc/img/img-i2s-out.c | 55 ++++++++++++++++++++++-----------------------
 1 file changed, 27 insertions(+), 28 deletions(-)

diff --git a/sound/soc/img/img-i2s-out.c b/sound/soc/img/img-i2s-out.c
index f1c3b48..7db58d2 100644
--- a/sound/soc/img/img-i2s-out.c
+++ b/sound/soc/img/img-i2s-out.c
@@ -71,8 +71,8 @@ static int img_i2s_out_runtime_suspend(struct device *dev)
 {
 	struct img_i2s_out *i2s = dev_get_drvdata(dev);
 
-	if (!i2s->force_clk_active)
-		clk_disable_unprepare(i2s->clk_ref);
+	clk_disable_unprepare(i2s->clk_ref);
+	clk_disable_unprepare(i2s->clk_sys);
 
 	return 0;
 }
@@ -82,12 +82,17 @@ static int img_i2s_out_runtime_resume(struct device *dev)
 	struct img_i2s_out *i2s = dev_get_drvdata(dev);
 	int ret;
 
-	if (!i2s->force_clk_active) {
-		ret = clk_prepare_enable(i2s->clk_ref);
-		if (ret) {
-			dev_err(dev, "clk_enable failed: %d\n", ret);
-			return ret;
-		}
+	ret = clk_prepare_enable(i2s->clk_sys);
+	if (ret) {
+		dev_err(dev, "clk_enable failed: %d\n", ret);
+		return ret;
+	}
+
+	ret = clk_prepare_enable(i2s->clk_ref);
+	if (ret) {
+		dev_err(dev, "clk_enable failed: %d\n", ret);
+		clk_disable_unprepare(i2s->clk_sys);
+		return ret;
 	}
 
 	return 0;
@@ -344,6 +349,7 @@ static int img_i2s_out_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 
 	chan_control_mask = IMG_I2S_OUT_CHAN_CTL_CLKT_MASK;
 
+	pm_runtime_get_sync(i2s->dev);
 	img_i2s_out_disable(i2s);
 
 	reg = img_i2s_out_readl(i2s, IMG_I2S_OUT_CTL);
@@ -363,6 +369,7 @@ static int img_i2s_out_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 		img_i2s_out_ch_enable(i2s, i);
 
 	img_i2s_out_enable(i2s);
+	pm_runtime_put(i2s->dev);
 
 	i2s->force_clk_active = force_clk_active;
 
@@ -516,16 +523,20 @@ static int img_i2s_out_probe(struct platform_device *pdev)
 		return PTR_ERR(i2s->clk_ref);
 	}
 
-	ret = clk_prepare_enable(i2s->clk_sys);
-	if (ret)
-		return ret;
-
 	i2s->suspend_ch_ctl = devm_kzalloc(dev,
 		sizeof(*i2s->suspend_ch_ctl) * i2s->max_i2s_chan, GFP_KERNEL);
-	if (!i2s->suspend_ch_ctl) {
-		ret = -ENOMEM;
-		goto err_clk_disable;
+	if (!i2s->suspend_ch_ctl)
+		return -ENOMEM;
+
+	pm_runtime_enable(&pdev->dev);
+	if (!pm_runtime_enabled(&pdev->dev)) {
+		ret = img_i2s_out_runtime_resume(&pdev->dev);
+		if (ret)
+			goto err_pm_disable;
 	}
+	ret = pm_runtime_get_sync(&pdev->dev);
+	if (ret < 0)
+		goto err_suspend;
 
 	reg = IMG_I2S_OUT_CTL_FRM_SIZE_MASK;
 	img_i2s_out_writel(i2s, reg, IMG_I2S_OUT_CTL);
@@ -539,13 +550,7 @@ static int img_i2s_out_probe(struct platform_device *pdev)
 		img_i2s_out_ch_writel(i2s, i, reg, IMG_I2S_OUT_CH_CTL);
 
 	img_i2s_out_reset(i2s);
-
-	pm_runtime_enable(&pdev->dev);
-	if (!pm_runtime_enabled(&pdev->dev)) {
-		ret = img_i2s_out_runtime_resume(&pdev->dev);
-		if (ret)
-			goto err_pm_disable;
-	}
+	pm_runtime_put(&pdev->dev);
 
 	i2s->active_channels = 1;
 	i2s->dma_data.addr = res->start + IMG_I2S_OUT_TX_FIFO;
@@ -578,22 +583,16 @@ static int img_i2s_out_probe(struct platform_device *pdev)
 		img_i2s_out_runtime_suspend(&pdev->dev);
 err_pm_disable:
 	pm_runtime_disable(&pdev->dev);
-err_clk_disable:
-	clk_disable_unprepare(i2s->clk_sys);
 
 	return ret;
 }
 
 static int img_i2s_out_dev_remove(struct platform_device *pdev)
 {
-	struct img_i2s_out *i2s = platform_get_drvdata(pdev);
-
 	pm_runtime_disable(&pdev->dev);
 	if (!pm_runtime_status_suspended(&pdev->dev))
 		img_i2s_out_runtime_suspend(&pdev->dev);
 
-	clk_disable_unprepare(i2s->clk_sys);
-
 	return 0;
 }
 
-- 
1.9.1
