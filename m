From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: AMD: add pm ops" to the asoc tree
Date: Sun, 10 Jan 2016 12:50:47 +0000
Message-ID: <E1aIFSJ-0001Iy-IJ@debutante>
References: <1452295331-28476-9-git-send-email-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 913232605EF
 for <alsa-devel@alsa-project.org>; Sun, 10 Jan 2016 13:50:55 +0100 (CET)
In-Reply-To: <1452295331-28476-9-git-send-email-alexander.deucher@amd.com>
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

   ASoC: AMD: add pm ops

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

>From 1927da9355670d04889ce57716bbc671fdca4135 Mon Sep 17 00:00:00 2001
From: Maruthi Srinivas Bayyavarapu <Maruthi.Bayyavarapu@amd.com>
Date: Fri, 8 Jan 2016 18:22:10 -0500
Subject: [PATCH] ASoC: AMD: add pm ops

genpd will power off/on ACP to manage runtime ACP PM. ACP runtime PM
hooks are added to get it deinitialized and initialized respectively,
after it is powered off/on.

When system goes to suspend when audio usecase is active, ACP will
be powered off through genpd. When it resumes, ACP needs to be
initialized and reconfigured.

Signed-off-by: Maruthi Bayyavarapu <maruthi.bayyavarapu@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/amd/acp-pcm-dma.c | 48 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/sound/soc/amd/acp-pcm-dma.c b/sound/soc/amd/acp-pcm-dma.c
index 0724d7847c07..c0819b5f8ba5 100644
--- a/sound/soc/amd/acp-pcm-dma.c
+++ b/sound/soc/amd/acp-pcm-dma.c
@@ -16,6 +16,7 @@
 #include <linux/module.h>
 #include <linux/delay.h>
 #include <linux/sizes.h>
+#include <linux/pm_runtime.h>
 
 #include <sound/soc.h>
 
@@ -885,6 +886,10 @@ static int acp_audio_probe(struct platform_device *pdev)
 		return status;
 	}
 
+	pm_runtime_set_autosuspend_delay(&pdev->dev, 10000);
+	pm_runtime_use_autosuspend(&pdev->dev);
+	pm_runtime_enable(&pdev->dev);
+
 	return status;
 }
 
@@ -894,15 +899,58 @@ static int acp_audio_remove(struct platform_device *pdev)
 
 	acp_deinit(adata->acp_mmio);
 	snd_soc_unregister_platform(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
 
 	return 0;
 }
 
+static int acp_pcm_resume(struct device *dev)
+{
+	struct audio_drv_data *adata = dev_get_drvdata(dev);
+
+	acp_init(adata->acp_mmio);
+
+	if (adata->play_stream && adata->play_stream->runtime)
+		config_acp_dma(adata->acp_mmio,
+				adata->play_stream->runtime->private_data);
+	if (adata->capture_stream && adata->capture_stream->runtime)
+		config_acp_dma(adata->acp_mmio,
+				adata->capture_stream->runtime->private_data);
+
+	acp_reg_write(1, adata->acp_mmio, mmACP_EXTERNAL_INTR_ENB);
+	return 0;
+}
+
+static int acp_pcm_runtime_suspend(struct device *dev)
+{
+	struct audio_drv_data *adata = dev_get_drvdata(dev);
+
+	acp_deinit(adata->acp_mmio);
+	acp_reg_write(0, adata->acp_mmio, mmACP_EXTERNAL_INTR_ENB);
+	return 0;
+}
+
+static int acp_pcm_runtime_resume(struct device *dev)
+{
+	struct audio_drv_data *adata = dev_get_drvdata(dev);
+
+	acp_init(adata->acp_mmio);
+	acp_reg_write(1, adata->acp_mmio, mmACP_EXTERNAL_INTR_ENB);
+	return 0;
+}
+
+static const struct dev_pm_ops acp_pm_ops = {
+	.resume = acp_pcm_resume,
+	.runtime_suspend = acp_pcm_runtime_suspend,
+	.runtime_resume = acp_pcm_runtime_resume,
+};
+
 static struct platform_driver acp_dma_driver = {
 	.probe = acp_audio_probe,
 	.remove = acp_audio_remove,
 	.driver = {
 		.name = "acp_audio_dma",
+		.pm = &acp_pm_ops,
 	},
 };
 
-- 
2.7.0.rc3
