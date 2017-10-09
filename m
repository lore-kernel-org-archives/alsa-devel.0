From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: img-i2s-out: Add suspend / resume
	handling" to the asoc tree
Date: Mon, 09 Oct 2017 09:49:57 +0100
Message-ID: <E1e1Tl7-0006P3-Sq@debutante>
References: <20171006145228.13529-2-ed.blake@sondrel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id B39442671D8
 for <alsa-devel@alsa-project.org>; Mon,  9 Oct 2017 10:50:00 +0200 (CEST)
In-Reply-To: <20171006145228.13529-2-ed.blake@sondrel.com>
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

   ASoC: img-i2s-out: Add suspend / resume handling

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

>From 9b4acd33dd64e84be6db9552b6d43979c05135b1 Mon Sep 17 00:00:00 2001
From: Ed Blake <ed.blake@sondrel.com>
Date: Fri, 6 Oct 2017 15:52:27 +0100
Subject: [PATCH] ASoC: img-i2s-out: Add suspend / resume handling

Implement suspend and resume callbacks to save and restore register
state, to support platforms where the power is disabled during suspend.

In future the driver could be converted to use regmap which would
simplify the suspend and resume code.

Signed-off-by: Ed Blake <ed.blake@sondrel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/img/img-i2s-out.c | 60 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/sound/soc/img/img-i2s-out.c b/sound/soc/img/img-i2s-out.c
index adc6902fcbd4..1d831c625fe2 100644
--- a/sound/soc/img/img-i2s-out.c
+++ b/sound/soc/img/img-i2s-out.c
@@ -63,6 +63,8 @@ struct img_i2s_out {
 	unsigned int active_channels;
 	struct reset_control *rst;
 	struct snd_soc_dai_driver dai_driver;
+	u32 suspend_ctl;
+	u32 *suspend_ch_ctl;
 };
 
 static int img_i2s_out_runtime_suspend(struct device *dev)
@@ -471,6 +473,13 @@ static int img_i2s_out_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	i2s->suspend_ch_ctl = devm_kzalloc(dev,
+		sizeof(*i2s->suspend_ch_ctl) * i2s->max_i2s_chan, GFP_KERNEL);
+	if (!i2s->suspend_ch_ctl) {
+		ret = -ENOMEM;
+		goto err_clk_disable;
+	}
+
 	reg = IMG_I2S_OUT_CTL_FRM_SIZE_MASK;
 	img_i2s_out_writel(i2s, reg, IMG_I2S_OUT_CTL);
 
@@ -520,6 +529,7 @@ static int img_i2s_out_probe(struct platform_device *pdev)
 		img_i2s_out_runtime_suspend(&pdev->dev);
 err_pm_disable:
 	pm_runtime_disable(&pdev->dev);
+err_clk_disable:
 	clk_disable_unprepare(i2s->clk_sys);
 
 	return ret;
@@ -538,6 +548,55 @@ static int img_i2s_out_dev_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_PM_SLEEP
+static int img_i2s_out_suspend(struct device *dev)
+{
+	struct img_i2s_out *i2s = dev_get_drvdata(dev);
+	int i, ret;
+	u32 reg;
+
+	if (pm_runtime_status_suspended(dev)) {
+		ret = img_i2s_out_runtime_resume(dev);
+		if (ret)
+			return ret;
+	}
+
+	for (i = 0; i < i2s->max_i2s_chan; i++) {
+		reg = img_i2s_out_ch_readl(i2s, i, IMG_I2S_OUT_CH_CTL);
+		i2s->suspend_ch_ctl[i] = reg;
+	}
+
+	i2s->suspend_ctl = img_i2s_out_readl(i2s, IMG_I2S_OUT_CTL);
+
+	img_i2s_out_runtime_suspend(dev);
+
+	return 0;
+}
+
+static int img_i2s_out_resume(struct device *dev)
+{
+	struct img_i2s_out *i2s = dev_get_drvdata(dev);
+	int i, ret;
+	u32 reg;
+
+	ret = img_i2s_out_runtime_resume(dev);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < i2s->max_i2s_chan; i++) {
+		reg = i2s->suspend_ch_ctl[i];
+		img_i2s_out_ch_writel(i2s, i, reg, IMG_I2S_OUT_CH_CTL);
+	}
+
+	img_i2s_out_writel(i2s, i2s->suspend_ctl, IMG_I2S_OUT_CTL);
+
+	if (pm_runtime_status_suspended(dev))
+		img_i2s_out_runtime_suspend(dev);
+
+	return 0;
+}
+#endif
+
 static const struct of_device_id img_i2s_out_of_match[] = {
 	{ .compatible = "img,i2s-out" },
 	{}
@@ -547,6 +606,7 @@ MODULE_DEVICE_TABLE(of, img_i2s_out_of_match);
 static const struct dev_pm_ops img_i2s_out_pm_ops = {
 	SET_RUNTIME_PM_OPS(img_i2s_out_runtime_suspend,
 			   img_i2s_out_runtime_resume, NULL)
+	SET_SYSTEM_SLEEP_PM_OPS(img_i2s_out_suspend, img_i2s_out_resume)
 };
 
 static struct platform_driver img_i2s_out_driver = {
-- 
2.14.1
