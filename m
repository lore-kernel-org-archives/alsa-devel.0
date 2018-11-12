From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Subject: [PATCH 09/11] ASoC: amd: add acp3x runtime pm ops
Date: Mon, 12 Nov 2018 11:05:00 +0530
Message-ID: <1542000903-19020-10-git-send-email-Vijendar.Mukunda@amd.com>
References: <1542000903-19020-1-git-send-email-Vijendar.Mukunda@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from NAM03-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr790055.outbound.protection.outlook.com [40.107.79.55])
 by alsa0.perex.cz (Postfix) with ESMTP id 52D27267A67
 for <alsa-devel@alsa-project.org>; Mon, 12 Nov 2018 06:33:30 +0100 (CET)
In-Reply-To: <1542000903-19020-1-git-send-email-Vijendar.Mukunda@amd.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER
 MANAGEM..." <alsa-devel@alsa-project.org>, Maruthi Bayyavarapu <maruthi.bayyavarapu@amd.com>, open list <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Vishnuvardhanrao.Ravulapati@amd.com, Mark Brown <broonie@kernel.org>, Vijendar Mukunda <Vijendar.Mukunda@amd.com>, Alexander.Deucher@amd.com
List-Id: alsa-devel@alsa-project.org

Added runtime PM operations for ACP3x PCM platform device.

Signed-off-by: Maruthi Bayyavarapu <maruthi.bayyavarapu@amd.com>
Tested-by: Ravulapati Vishnu vardhan Rao <Vishnuvardhanrao.Ravulapati@amd.com>
Signed-off-by: Vijendar Mukunda <vijendar.mukunda@amd.com>
---
 sound/soc/amd/raven/acp3x-pcm-dma.c | 39 +++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/sound/soc/amd/raven/acp3x-pcm-dma.c b/sound/soc/amd/raven/acp3x-pcm-dma.c
index 15a5f3b..710c5c5 100644
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
2.7.4
