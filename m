From: Ed Blake <ed.blake@sondrel.com>
Subject: [PATCH v2 2/2] ASoC: img-i2s-in: Add runtime PM
Date: Fri,  6 Oct 2017 15:50:40 +0100
Message-ID: <20171006145040.13436-3-ed.blake@sondrel.com>
References: <20171006145040.13436-1-ed.blake@sondrel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from EUR02-VE1-obe.outbound.protection.outlook.com
 (mail-eopbgr20052.outbound.protection.outlook.com [40.107.2.52])
 by alsa0.perex.cz (Postfix) with ESMTP id 61489267605
 for <alsa-devel@alsa-project.org>; Fri,  6 Oct 2017 16:50:55 +0200 (CEST)
In-Reply-To: <20171006145040.13436-1-ed.blake@sondrel.com>
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

Add runtime PM to disable the clock when the device is not in use.
The ASoC core takes care of the pm_runtime_get_sync / put calls so we
just need to provide runtime_suspend / runtime_resume functions and
enable runtime PM.

Signed-off-by: Ed Blake <ed.blake@sondrel.com>
---
Changes in v2:
 - Errors returned from pm_runtime_get_sync are now handled
---
 sound/soc/img/img-i2s-in.c | 88 +++++++++++++++++++++++++++++++++++++---------
 1 file changed, 71 insertions(+), 17 deletions(-)

diff --git a/sound/soc/img/img-i2s-in.c b/sound/soc/img/img-i2s-in.c
index 3d151ddda937..d7fbb0a0a28b 100644
--- a/sound/soc/img/img-i2s-in.c
+++ b/sound/soc/img/img-i2s-in.c
@@ -16,6 +16,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/reset.h>
 
 #include <sound/core.h>
@@ -64,6 +65,29 @@ struct img_i2s_in {
 	u32 *suspend_ch_ctl;
 };
 
+static int img_i2s_in_runtime_suspend(struct device *dev)
+{
+	struct img_i2s_in *i2s = dev_get_drvdata(dev);
+
+	clk_disable_unprepare(i2s->clk_sys);
+
+	return 0;
+}
+
+static int img_i2s_in_runtime_resume(struct device *dev)
+{
+	struct img_i2s_in *i2s = dev_get_drvdata(dev);
+	int ret;
+
+	ret = clk_prepare_enable(i2s->clk_sys);
+	if (ret) {
+		dev_err(dev, "Unable to enable sys clock\n");
+		return ret;
+	}
+
+	return 0;
+}
+
 static inline void img_i2s_in_writel(struct img_i2s_in *i2s, u32 val, u32 reg)
 {
 	writel(val, i2s->base + reg);
@@ -281,7 +305,7 @@ static int img_i2s_in_hw_params(struct snd_pcm_substream *substream,
 static int img_i2s_in_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 {
 	struct img_i2s_in *i2s = snd_soc_dai_get_drvdata(dai);
-	int i;
+	int i, ret;
 	u32 chan_control_mask, lrd_set = 0, blkp_set = 0, chan_control_set = 0;
 	u32 reg;
 
@@ -321,6 +345,10 @@ static int img_i2s_in_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 
 	chan_control_mask = IMG_I2S_IN_CH_CTL_CLK_TRANS_MASK;
 
+	ret = pm_runtime_get_sync(i2s->dev);
+	if (ret < 0)
+		return ret;
+
 	for (i = 0; i < i2s->active_channels; i++)
 		img_i2s_in_ch_disable(i2s, i);
 
@@ -340,6 +368,8 @@ static int img_i2s_in_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 	for (i = 0; i < i2s->active_channels; i++)
 		img_i2s_in_ch_enable(i2s, i);
 
+	pm_runtime_put(i2s->dev);
+
 	return 0;
 }
 
@@ -429,9 +459,15 @@ static int img_i2s_in_probe(struct platform_device *pdev)
 		return PTR_ERR(i2s->clk_sys);
 	}
 
-	ret = clk_prepare_enable(i2s->clk_sys);
-	if (ret)
-		return ret;
+	pm_runtime_enable(&pdev->dev);
+	if (!pm_runtime_enabled(&pdev->dev)) {
+		ret = img_i2s_in_runtime_resume(&pdev->dev);
+		if (ret)
+			goto err_pm_disable;
+	}
+	ret = pm_runtime_get_sync(&pdev->dev);
+	if (ret < 0)
+		goto err_suspend;
 
 	i2s->active_channels = 1;
 	i2s->dma_data.addr = res->start + IMG_I2S_IN_RX_FIFO;
@@ -449,7 +485,7 @@ static int img_i2s_in_probe(struct platform_device *pdev)
 	if (IS_ERR(rst)) {
 		if (PTR_ERR(rst) == -EPROBE_DEFER) {
 			ret = -EPROBE_DEFER;
-			goto err_clk_disable;
+			goto err_suspend;
 		}
 
 		dev_dbg(dev, "No top level reset found\n");
@@ -471,35 +507,40 @@ static int img_i2s_in_probe(struct platform_device *pdev)
 			IMG_I2S_IN_CH_CTL_JUST_MASK |
 			IMG_I2S_IN_CH_CTL_FW_MASK, IMG_I2S_IN_CH_CTL);
 
+	pm_runtime_put(&pdev->dev);
+
 	i2s->suspend_ch_ctl = devm_kzalloc(dev,
 		sizeof(*i2s->suspend_ch_ctl) * i2s->max_i2s_chan, GFP_KERNEL);
 	if (!i2s->suspend_ch_ctl) {
 		ret = -ENOMEM;
-		goto err_clk_disable;
+		goto err_suspend;
 	}
 
 	ret = devm_snd_soc_register_component(dev, &img_i2s_in_component,
 						&i2s->dai_driver, 1);
 	if (ret)
-		goto err_clk_disable;
+		goto err_suspend;
 
 	ret = devm_snd_dmaengine_pcm_register(dev, &img_i2s_in_dma_config, 0);
 	if (ret)
-		goto err_clk_disable;
+		goto err_suspend;
 
 	return 0;
 
-err_clk_disable:
-	clk_disable_unprepare(i2s->clk_sys);
+err_suspend:
+	if (!pm_runtime_enabled(&pdev->dev))
+		img_i2s_in_runtime_suspend(&pdev->dev);
+err_pm_disable:
+	pm_runtime_disable(&pdev->dev);
 
 	return ret;
 }
 
 static int img_i2s_in_dev_remove(struct platform_device *pdev)
 {
-	struct img_i2s_in *i2s = platform_get_drvdata(pdev);
-
-	clk_disable_unprepare(i2s->clk_sys);
+	pm_runtime_disable(&pdev->dev);
+	if (!pm_runtime_status_suspended(&pdev->dev))
+		img_i2s_in_runtime_suspend(&pdev->dev);
 
 	return 0;
 }
@@ -508,9 +549,15 @@ static int img_i2s_in_dev_remove(struct platform_device *pdev)
 static int img_i2s_in_suspend(struct device *dev)
 {
 	struct img_i2s_in *i2s = dev_get_drvdata(dev);
-	int i;
+	int i, ret;
 	u32 reg;
 
+	if (pm_runtime_status_suspended(dev)) {
+		ret = img_i2s_in_runtime_resume(dev);
+		if (ret)
+			return ret;
+	}
+
 	for (i = 0; i < i2s->max_i2s_chan; i++) {
 		reg = img_i2s_in_ch_readl(i2s, i, IMG_I2S_IN_CH_CTL);
 		i2s->suspend_ch_ctl[i] = reg;
@@ -518,7 +565,7 @@ static int img_i2s_in_suspend(struct device *dev)
 
 	i2s->suspend_ctl = img_i2s_in_readl(i2s, IMG_I2S_IN_CTL);
 
-	clk_disable_unprepare(i2s->clk_sys);
+	img_i2s_in_runtime_suspend(dev);
 
 	return 0;
 }
@@ -526,10 +573,12 @@ static int img_i2s_in_suspend(struct device *dev)
 static int img_i2s_in_resume(struct device *dev)
 {
 	struct img_i2s_in *i2s = dev_get_drvdata(dev);
-	int i;
+	int i, ret;
 	u32 reg;
 
-	clk_prepare_enable(i2s->clk_sys);
+	ret = img_i2s_in_runtime_resume(dev);
+	if (ret)
+		return ret;
 
 	for (i = 0; i < i2s->max_i2s_chan; i++) {
 		reg = i2s->suspend_ch_ctl[i];
@@ -538,6 +587,9 @@ static int img_i2s_in_resume(struct device *dev)
 
 	img_i2s_in_writel(i2s, i2s->suspend_ctl, IMG_I2S_IN_CTL);
 
+	if (pm_runtime_status_suspended(dev))
+		img_i2s_in_runtime_suspend(dev);
+
 	return 0;
 }
 #endif
@@ -549,6 +601,8 @@ static const struct of_device_id img_i2s_in_of_match[] = {
 MODULE_DEVICE_TABLE(of, img_i2s_in_of_match);
 
 static const struct dev_pm_ops img_i2s_in_pm_ops = {
+	SET_RUNTIME_PM_OPS(img_i2s_in_runtime_suspend,
+			   img_i2s_in_runtime_resume, NULL)
 	SET_SYSTEM_SLEEP_PM_OPS(img_i2s_in_suspend, img_i2s_in_resume)
 };
 
-- 
2.11.0
