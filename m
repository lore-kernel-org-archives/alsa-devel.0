From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: amd: add acp3x runtime pm ops" to the asoc tree
Date: Tue, 13 Nov 2018 19:45:36 +0000 (GMT)
Message-ID: <20181113194536.23989440078@finisterre.ee.mobilebroadband>
References: <1542000903-19020-10-git-send-email-Vijendar.Mukunda@amd.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1542000903-19020-10-git-send-email-Vijendar.Mukunda@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Cc: Maruthi Bayyavarapu <maruthi.bayyavarapu@amd.com>, Ravulapati Vishnu vardhan Rao <Vishnuvardhanrao.Ravulapati@amd.com>, Vijendar Mukunda <vijendar.mukunda@amd.com>, Mark Brown <broonie@kernel.org>, "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER, MANAGEM..." <alsa-devel@alsa-project.org>Maruthi Bayyavarapu <maruthi.bayyavarapu@amd.com>, open list <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>Vishnuvardhanrao.Ravulapati@amd.comMark Brown <broonie@kernel.org>, Alexander.Deucher@amd.comalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: amd: add acp3x runtime pm ops

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 56e4dd8f68019f50a885be9122981f1899cd89ed Mon Sep 17 00:00:00 2001
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Date: Mon, 12 Nov 2018 11:05:00 +0530
Subject: [PATCH] ASoC: amd: add acp3x runtime pm ops

Added runtime PM operations for ACP3x PCM platform device.

Signed-off-by: Maruthi Bayyavarapu <maruthi.bayyavarapu@amd.com>
Tested-by: Ravulapati Vishnu vardhan Rao <Vishnuvardhanrao.Ravulapati@amd.com>
Signed-off-by: Vijendar Mukunda <vijendar.mukunda@amd.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/amd/raven/acp3x-pcm-dma.c | 39 +++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/sound/soc/amd/raven/acp3x-pcm-dma.c b/sound/soc/amd/raven/acp3x-pcm-dma.c
index 15a5f3b4db71..710c5c5ae625 100644
--- a/sound/soc/amd/raven/acp3x-pcm-dma.c
+++ b/sound/soc/amd/raven/acp3x-pcm-dma.c
@@ -17,6 +17,7 @@
 #include <linux/module.h>
 #include <linux/err.h>
 #include <linux/io.h>
+#include <linux/pm_runtime.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
@@ -660,6 +661,9 @@ static int acp3x_audio_probe(struct platform_device *pdev)
 		goto dev_err;
 	}
 
+	pm_runtime_set_autosuspend_delay(&pdev->dev, 10000);
+	pm_runtime_use_autosuspend(&pdev->dev);
+	pm_runtime_enable(&pdev->dev);
 	return 0;
 dev_err:
 	status = acp3x_deinit(adata->acp3x_base);
@@ -682,14 +686,49 @@ static int acp3x_audio_remove(struct platform_device *pdev)
 	else
 		dev_info(&pdev->dev, "ACP de-initialized\n");
 
+	pm_runtime_disable(&pdev->dev);
 	return 0;
 }
 
+static int acp3x_pcm_runtime_suspend(struct device *dev)
+{
+	int status;
+	struct i2s_dev_data *adata = dev_get_drvdata(dev);
+
+	status = acp3x_deinit(adata->acp3x_base);
+	if (status)
+		dev_err(dev, "ACP de-init failed\n");
+	else
+		dev_info(dev, "ACP de-initialized\n");
+
+	rv_writel(0, adata->acp3x_base + mmACP_EXTERNAL_INTR_ENB);
+
+	return 0;
+}
+
+static int acp3x_pcm_runtime_resume(struct device *dev)
+{
+	int status;
+	struct i2s_dev_data *adata = dev_get_drvdata(dev);
+
+	status = acp3x_init(adata->acp3x_base);
+	if (status)
+		return -ENODEV;
+	rv_writel(1, adata->acp3x_base + mmACP_EXTERNAL_INTR_ENB);
+	return 0;
+}
+
+static const struct dev_pm_ops acp3x_pm_ops = {
+	.runtime_suspend = acp3x_pcm_runtime_suspend,
+	.runtime_resume = acp3x_pcm_runtime_resume,
+};
+
 static struct platform_driver acp3x_dma_driver = {
 	.probe = acp3x_audio_probe,
 	.remove = acp3x_audio_remove,
 	.driver = {
 		.name = "acp3x_rv_i2s",
+		.pm = &acp3x_pm_ops,
 	},
 };
 
-- 
2.19.1
