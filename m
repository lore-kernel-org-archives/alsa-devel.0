From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: img-i2s-out: Add control of sys clock
	to runtime PM" to the asoc tree
Date: Mon, 09 Oct 2017 09:49:54 +0100
Message-ID: <E1e1Tl4-0006Nq-Rw@debutante>
References: <20171006145228.13529-3-ed.blake@sondrel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 48E2C2671C0
 for <alsa-devel@alsa-project.org>; Mon,  9 Oct 2017 10:49:57 +0200 (CEST)
In-Reply-To: <20171006145228.13529-3-ed.blake@sondrel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ed Blake <ed.blake@sondrel.com>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: img-i2s-out: Add control of sys clock to runtime PM

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From a38ced17328bae30dabc15dbc2563860e3921c9c Mon Sep 17 00:00:00 2001
From: Ed Blake <ed.blake@sondrel.com>
Date: Fri, 6 Oct 2017 15:52:28 +0100
Subject: [PATCH] ASoC: img-i2s-out: Add control of sys clock to runtime PM

Disable sys clock as well as ref clock when runtime suspended.

Signed-off-by: Ed Blake <ed.blake@sondrel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/img/img-i2s-out.c | 60 +++++++++++++++++++++++----------------------
 1 file changed, 31 insertions(+), 29 deletions(-)

diff --git a/sound/soc/img/img-i2s-out.c b/sound/soc/img/img-i2s-out.c
index 1d831c625fe2..30a95bcef2db 100644
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
@@ -289,7 +294,7 @@ static int img_i2s_out_hw_params(struct snd_pcm_substream *substream,
 static int img_i2s_out_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 {
 	struct img_i2s_out *i2s = snd_soc_dai_get_drvdata(dai);
-	int i;
+	int i, ret;
 	bool force_clk_active;
 	u32 chan_control_mask, control_mask, chan_control_set = 0;
 	u32 reg, control_set = 0;
@@ -344,6 +349,10 @@ static int img_i2s_out_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 
 	chan_control_mask = IMG_I2S_OUT_CHAN_CTL_CLKT_MASK;
 
+	ret = pm_runtime_get_sync(i2s->dev);
+	if (ret < 0)
+		return ret;
+
 	img_i2s_out_disable(i2s);
 
 	reg = img_i2s_out_readl(i2s, IMG_I2S_OUT_CTL);
@@ -363,6 +372,7 @@ static int img_i2s_out_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 		img_i2s_out_ch_enable(i2s, i);
 
 	img_i2s_out_enable(i2s);
+	pm_runtime_put(i2s->dev);
 
 	i2s->force_clk_active = force_clk_active;
 
@@ -469,16 +479,20 @@ static int img_i2s_out_probe(struct platform_device *pdev)
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
@@ -492,13 +506,7 @@ static int img_i2s_out_probe(struct platform_device *pdev)
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
@@ -529,22 +537,16 @@ static int img_i2s_out_probe(struct platform_device *pdev)
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
2.14.1
