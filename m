From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: img-spdif-in: Add suspend / resume
	handling" to the asoc tree
Date: Mon, 09 Oct 2017 09:49:51 +0100
Message-ID: <E1e1Tl1-0006N1-QB@debutante>
References: <20171006145355.13616-2-ed.blake@sondrel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 242462671AB
 for <alsa-devel@alsa-project.org>; Mon,  9 Oct 2017 10:49:53 +0200 (CEST)
In-Reply-To: <20171006145355.13616-2-ed.blake@sondrel.com>
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

   ASoC: img-spdif-in: Add suspend / resume handling

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

>From 52eb0ed3ec62d1f22f71332aa2e2de84a0a6c756 Mon Sep 17 00:00:00 2001
From: Ed Blake <ed.blake@sondrel.com>
Date: Fri, 6 Oct 2017 15:53:54 +0100
Subject: [PATCH] ASoC: img-spdif-in: Add suspend / resume handling

Implement suspend and resume callbacks to save and restore register
state, to support platforms where the power is disabled during suspend.

In future the driver could be converted to use regmap which would
simplify the suspend and resume code.

Signed-off-by: Ed Blake <ed.blake@sondrel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/img/img-spdif-in.c | 39 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 38 insertions(+), 1 deletion(-)

diff --git a/sound/soc/img/img-spdif-in.c b/sound/soc/img/img-spdif-in.c
index 8adfd65d4390..be5a64a44252 100644
--- a/sound/soc/img/img-spdif-in.c
+++ b/sound/soc/img/img-spdif-in.c
@@ -82,6 +82,8 @@ struct img_spdif_in {
 	unsigned int single_freq;
 	unsigned int multi_freqs[IMG_SPDIF_IN_NUM_ACLKGEN];
 	bool active;
+	u32 suspend_clkgen;
+	u32 suspend_ctl;
 
 	/* Write-only registers */
 	unsigned int aclkgen_regs[IMG_SPDIF_IN_NUM_ACLKGEN];
@@ -785,16 +787,51 @@ static int img_spdif_in_dev_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_PM_SLEEP
+static int img_spdif_in_suspend(struct device *dev)
+{
+	struct img_spdif_in *spdif = dev_get_drvdata(dev);
+
+	spdif->suspend_clkgen = img_spdif_in_readl(spdif, IMG_SPDIF_IN_CLKGEN);
+	spdif->suspend_ctl = img_spdif_in_readl(spdif, IMG_SPDIF_IN_CTL);
+
+	clk_disable_unprepare(spdif->clk_sys);
+
+	return 0;
+}
+
+static int img_spdif_in_resume(struct device *dev)
+{
+	struct img_spdif_in *spdif = dev_get_drvdata(dev);
+	int i;
+
+	clk_prepare_enable(spdif->clk_sys);
+
+	for (i = 0; i < IMG_SPDIF_IN_NUM_ACLKGEN; i++)
+		img_spdif_in_aclkgen_writel(spdif, i);
+
+	img_spdif_in_writel(spdif, spdif->suspend_clkgen, IMG_SPDIF_IN_CLKGEN);
+	img_spdif_in_writel(spdif, spdif->suspend_ctl, IMG_SPDIF_IN_CTL);
+
+	return 0;
+}
+#endif
+
 static const struct of_device_id img_spdif_in_of_match[] = {
 	{ .compatible = "img,spdif-in" },
 	{}
 };
 MODULE_DEVICE_TABLE(of, img_spdif_in_of_match);
 
+static const struct dev_pm_ops img_spdif_in_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(img_spdif_in_suspend, img_spdif_in_resume)
+};
+
 static struct platform_driver img_spdif_in_driver = {
 	.driver = {
 		.name = "img-spdif-in",
-		.of_match_table = img_spdif_in_of_match
+		.of_match_table = img_spdif_in_of_match,
+		.pm = &img_spdif_in_pm_ops
 	},
 	.probe = img_spdif_in_probe,
 	.remove = img_spdif_in_dev_remove
-- 
2.14.1
