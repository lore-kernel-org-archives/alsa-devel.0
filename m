From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: img-i2s-in: Add suspend / resume
	handling" to the asoc tree
Date: Mon, 09 Oct 2017 09:50:04 +0100
Message-ID: <E1e1TlE-0006R0-6P@debutante>
References: <20171006145040.13436-2-ed.blake@sondrel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 41B032671A9
 for <alsa-devel@alsa-project.org>; Mon,  9 Oct 2017 10:50:06 +0200 (CEST)
In-Reply-To: <20171006145040.13436-2-ed.blake@sondrel.com>
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

   ASoC: img-i2s-in: Add suspend / resume handling

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

>From 8ab7f885da23719aef1ba03f563589e44ca6ab66 Mon Sep 17 00:00:00 2001
From: Ed Blake <ed.blake@sondrel.com>
Date: Fri, 6 Oct 2017 15:50:39 +0100
Subject: [PATCH] ASoC: img-i2s-in: Add suspend / resume handling

Implement suspend and resume callbacks to save and restore register
state, to support platforms where the power is disabled during suspend.

In future the driver could be converted to use regmap which would
simplify the suspend and resume code.

Signed-off-by: Ed Blake <ed.blake@sondrel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/img/img-i2s-in.c | 54 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 53 insertions(+), 1 deletion(-)

diff --git a/sound/soc/img/img-i2s-in.c b/sound/soc/img/img-i2s-in.c
index 567f9767fb73..3d151ddda937 100644
--- a/sound/soc/img/img-i2s-in.c
+++ b/sound/soc/img/img-i2s-in.c
@@ -60,6 +60,8 @@ struct img_i2s_in {
 	void __iomem *channel_base;
 	unsigned int active_channels;
 	struct snd_soc_dai_driver dai_driver;
+	u32 suspend_ctl;
+	u32 *suspend_ch_ctl;
 };
 
 static inline void img_i2s_in_writel(struct img_i2s_in *i2s, u32 val, u32 reg)
@@ -469,6 +471,13 @@ static int img_i2s_in_probe(struct platform_device *pdev)
 			IMG_I2S_IN_CH_CTL_JUST_MASK |
 			IMG_I2S_IN_CH_CTL_FW_MASK, IMG_I2S_IN_CH_CTL);
 
+	i2s->suspend_ch_ctl = devm_kzalloc(dev,
+		sizeof(*i2s->suspend_ch_ctl) * i2s->max_i2s_chan, GFP_KERNEL);
+	if (!i2s->suspend_ch_ctl) {
+		ret = -ENOMEM;
+		goto err_clk_disable;
+	}
+
 	ret = devm_snd_soc_register_component(dev, &img_i2s_in_component,
 						&i2s->dai_driver, 1);
 	if (ret)
@@ -495,16 +504,59 @@ static int img_i2s_in_dev_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_PM_SLEEP
+static int img_i2s_in_suspend(struct device *dev)
+{
+	struct img_i2s_in *i2s = dev_get_drvdata(dev);
+	int i;
+	u32 reg;
+
+	for (i = 0; i < i2s->max_i2s_chan; i++) {
+		reg = img_i2s_in_ch_readl(i2s, i, IMG_I2S_IN_CH_CTL);
+		i2s->suspend_ch_ctl[i] = reg;
+	}
+
+	i2s->suspend_ctl = img_i2s_in_readl(i2s, IMG_I2S_IN_CTL);
+
+	clk_disable_unprepare(i2s->clk_sys);
+
+	return 0;
+}
+
+static int img_i2s_in_resume(struct device *dev)
+{
+	struct img_i2s_in *i2s = dev_get_drvdata(dev);
+	int i;
+	u32 reg;
+
+	clk_prepare_enable(i2s->clk_sys);
+
+	for (i = 0; i < i2s->max_i2s_chan; i++) {
+		reg = i2s->suspend_ch_ctl[i];
+		img_i2s_in_ch_writel(i2s, i, reg, IMG_I2S_IN_CH_CTL);
+	}
+
+	img_i2s_in_writel(i2s, i2s->suspend_ctl, IMG_I2S_IN_CTL);
+
+	return 0;
+}
+#endif
+
 static const struct of_device_id img_i2s_in_of_match[] = {
 	{ .compatible = "img,i2s-in" },
 	{}
 };
 MODULE_DEVICE_TABLE(of, img_i2s_in_of_match);
 
+static const struct dev_pm_ops img_i2s_in_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(img_i2s_in_suspend, img_i2s_in_resume)
+};
+
 static struct platform_driver img_i2s_in_driver = {
 	.driver = {
 		.name = "img-i2s-in",
-		.of_match_table = img_i2s_in_of_match
+		.of_match_table = img_i2s_in_of_match,
+		.pm = &img_i2s_in_pm_ops
 	},
 	.probe = img_i2s_in_probe,
 	.remove = img_i2s_in_dev_remove
-- 
2.14.1
