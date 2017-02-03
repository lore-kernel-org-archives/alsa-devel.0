From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: sun4i-i2s: Add quirks to handle a31
	compatible" to the asoc tree
Date: Fri, 03 Feb 2017 13:02:51 +0100
Message-ID: <E1cZcZn-0000h9-V0@finisterre>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0867116358782926660=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A2E26265142
 for <alsa-devel@alsa-project.org>; Fri,  3 Feb 2017 13:03:03 +0100 (CET)
In-Reply-To: 
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>, Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

--===============0867116358782926660==
Content-Type: text/plain

The patch

   ASoC: sun4i-i2s: Add quirks to handle a31 compatible

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

>From 2ad6f30de7087515a0bc2a718fca6681a57739a0 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Myl=C3=A8ne=20Josserand?=
 <mylene.josserand@free-electrons.com>
Date: Thu, 2 Feb 2017 10:24:16 +0100
Subject: [PATCH] ASoC: sun4i-i2s: Add quirks to handle a31 compatible
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Some SoCs have a reset line that must be asserted/deasserted.
This patch adds a quirk to handle the new compatible
"allwinner,sun6i-a31-i2s" which will deassert the reset
line on probe function and assert it on remove's one.

This new compatible is useful in case of A33 codec driver, for example.

Signed-off-by: Mylène Josserand <mylene.josserand@free-electrons.com>
Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sunxi/sun4i-i2s.c | 57 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 55 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index f24d19526603..268f2bf691b3 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -14,9 +14,11 @@
 #include <linux/clk.h>
 #include <linux/dmaengine.h>
 #include <linux/module.h>
+#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/regmap.h>
+#include <linux/reset.h>
 
 #include <sound/dmaengine_pcm.h>
 #include <sound/pcm_params.h>
@@ -92,6 +94,7 @@ struct sun4i_i2s {
 	struct clk	*bus_clk;
 	struct clk	*mod_clk;
 	struct regmap	*regmap;
+	struct reset_control *rst;
 
 	unsigned int	mclk_freq;
 
@@ -651,9 +654,22 @@ static int sun4i_i2s_runtime_suspend(struct device *dev)
 	return 0;
 }
 
+struct sun4i_i2s_quirks {
+	bool has_reset;
+};
+
+static const struct sun4i_i2s_quirks sun4i_a10_i2s_quirks = {
+	.has_reset	= false,
+};
+
+static const struct sun4i_i2s_quirks sun6i_a31_i2s_quirks = {
+	.has_reset	= true,
+};
+
 static int sun4i_i2s_probe(struct platform_device *pdev)
 {
 	struct sun4i_i2s *i2s;
+	const struct sun4i_i2s_quirks *quirks;
 	struct resource *res;
 	void __iomem *regs;
 	int irq, ret;
@@ -674,6 +690,12 @@ static int sun4i_i2s_probe(struct platform_device *pdev)
 		return irq;
 	}
 
+	quirks = of_device_get_match_data(&pdev->dev);
+	if (!quirks) {
+		dev_err(&pdev->dev, "Failed to determine the quirks to use\n");
+		return -ENODEV;
+	}
+
 	i2s->bus_clk = devm_clk_get(&pdev->dev, "apb");
 	if (IS_ERR(i2s->bus_clk)) {
 		dev_err(&pdev->dev, "Can't get our bus clock\n");
@@ -692,7 +714,24 @@ static int sun4i_i2s_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "Can't get our mod clock\n");
 		return PTR_ERR(i2s->mod_clk);
 	}
-	
+
+	if (quirks->has_reset) {
+		i2s->rst = devm_reset_control_get(&pdev->dev, NULL);
+		if (IS_ERR(i2s->rst)) {
+			dev_err(&pdev->dev, "Failed to get reset control\n");
+			return PTR_ERR(i2s->rst);
+		}
+	}
+
+	if (!IS_ERR(i2s->rst)) {
+		ret = reset_control_deassert(i2s->rst);
+		if (ret) {
+			dev_err(&pdev->dev,
+				"Failed to deassert the reset control\n");
+			return -EINVAL;
+		}
+	}
+
 	i2s->playback_dma_data.addr = res->start + SUN4I_I2S_FIFO_TX_REG;
 	i2s->playback_dma_data.maxburst = 4;
 
@@ -727,23 +766,37 @@ static int sun4i_i2s_probe(struct platform_device *pdev)
 		sun4i_i2s_runtime_suspend(&pdev->dev);
 err_pm_disable:
 	pm_runtime_disable(&pdev->dev);
+	if (!IS_ERR(i2s->rst))
+		reset_control_assert(i2s->rst);
 
 	return ret;
 }
 
 static int sun4i_i2s_remove(struct platform_device *pdev)
 {
+	struct sun4i_i2s *i2s = dev_get_drvdata(&pdev->dev);
+
 	snd_dmaengine_pcm_unregister(&pdev->dev);
 
 	pm_runtime_disable(&pdev->dev);
 	if (!pm_runtime_status_suspended(&pdev->dev))
 		sun4i_i2s_runtime_suspend(&pdev->dev);
 
+	if (!IS_ERR(i2s->rst))
+		reset_control_assert(i2s->rst);
+
 	return 0;
 }
 
 static const struct of_device_id sun4i_i2s_match[] = {
-	{ .compatible = "allwinner,sun4i-a10-i2s", },
+	{
+		.compatible = "allwinner,sun4i-a10-i2s",
+		.data = &sun4i_a10_i2s_quirks,
+	},
+	{
+		.compatible = "allwinner,sun6i-a31-i2s",
+		.data = &sun6i_a31_i2s_quirks,
+	},
 	{}
 };
 MODULE_DEVICE_TABLE(of, sun4i_i2s_match);
-- 
2.11.0


--===============0867116358782926660==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0867116358782926660==--
