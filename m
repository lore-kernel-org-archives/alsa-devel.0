From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: dwc: add runtime suspend/resume
	functionality" to the asoc tree
Date: Mon, 07 Dec 2015 19:54:06 +0000
Message-ID: <E1a61rK-0003Vh-Qy@debutante>
References: <1449272440-8735-4-git-send-email-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 2C5E52650E7
 for <alsa-devel@alsa-project.org>; Mon,  7 Dec 2015 20:54:15 +0100 (CET)
In-Reply-To: <1449272440-8735-4-git-send-email-alexander.deucher@amd.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Maruthi Bayyavarapu <maruthi.bayyavarapu@amd.com>, Alex Deucher <alexander.deucher@amd.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: dwc: add runtime suspend/resume functionality

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

>From f48303122d2fd94b719e546cf8a39d412c7eee69 Mon Sep 17 00:00:00 2001
From: Maruthi Srinivas Bayyavarapu <Maruthi.Bayyavarapu@amd.com>
Date: Fri, 4 Dec 2015 18:40:31 -0500
Subject: [PATCH] ASoC: dwc: add runtime suspend/resume functionality

When DW controller is in master mode, it can disable/enable clock
during the device runtime suspend/resume sequence.

Signed-off-by: Maruthi Bayyavarapu <maruthi.bayyavarapu@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/dwc/designware_i2s.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/sound/soc/dwc/designware_i2s.c b/sound/soc/dwc/designware_i2s.c
index 6e6a70c5c2bd..3d7754c115ec 100644
--- a/sound/soc/dwc/designware_i2s.c
+++ b/sound/soc/dwc/designware_i2s.c
@@ -18,6 +18,7 @@
 #include <linux/interrupt.h>
 #include <linux/module.h>
 #include <linux/slab.h>
+#include <linux/pm_runtime.h>
 #include <sound/designware_i2s.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
@@ -394,6 +395,23 @@ static const struct snd_soc_component_driver dw_i2s_component = {
 };
 
 #ifdef CONFIG_PM
+static int dw_i2s_runtime_suspend(struct device *dev)
+{
+	struct dw_i2s_dev *dw_dev = dev_get_drvdata(dev);
+
+	if (dw_dev->capability & DW_I2S_MASTER)
+		clk_disable(dw_dev->clk);
+	return 0;
+}
+
+static int dw_i2s_runtime_resume(struct device *dev)
+{
+	struct dw_i2s_dev *dw_dev = dev_get_drvdata(dev);
+
+	if (dw_dev->capability & DW_I2S_MASTER)
+		clk_enable(dw_dev->clk);
+	return 0;
+}
 
 static int dw_i2s_suspend(struct snd_soc_dai *dai)
 {
@@ -649,7 +667,7 @@ static int dw_i2s_probe(struct platform_device *pdev)
 			goto err_clk_disable;
 		}
 	}
-
+	pm_runtime_enable(&pdev->dev);
 	return 0;
 
 err_clk_disable:
@@ -665,6 +683,7 @@ static int dw_i2s_remove(struct platform_device *pdev)
 	if (dev->capability & DW_I2S_MASTER)
 		clk_disable_unprepare(dev->clk);
 
+	pm_runtime_disable(&pdev->dev);
 	return 0;
 }
 
@@ -677,12 +696,17 @@ static const struct of_device_id dw_i2s_of_match[] = {
 MODULE_DEVICE_TABLE(of, dw_i2s_of_match);
 #endif
 
+static const struct dev_pm_ops dwc_pm_ops = {
+	SET_RUNTIME_PM_OPS(dw_i2s_runtime_suspend, dw_i2s_runtime_resume, NULL)
+};
+
 static struct platform_driver dw_i2s_driver = {
 	.probe		= dw_i2s_probe,
 	.remove		= dw_i2s_remove,
 	.driver		= {
 		.name	= "designware-i2s",
 		.of_match_table = of_match_ptr(dw_i2s_of_match),
+		.pm = &dwc_pm_ops,
 	},
 };
 
-- 
2.6.2
