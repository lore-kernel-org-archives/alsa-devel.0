From: Ed Blake <ed.blake@sondrel.com>
Subject: [PATCH v2 1/2] ASoC: img-spdif-out: Add suspend /
	resume handling
Date: Fri,  6 Oct 2017 15:56:06 +0100
Message-ID: <20171006145607.13709-2-ed.blake@sondrel.com>
References: <20171006145607.13709-1-ed.blake@sondrel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
 (mail-eopbgr10070.outbound.protection.outlook.com [40.107.1.70])
 by alsa0.perex.cz (Postfix) with ESMTP id 81E65266991
 for <alsa-devel@alsa-project.org>; Fri,  6 Oct 2017 16:56:16 +0200 (CEST)
In-Reply-To: <20171006145607.13709-1-ed.blake@sondrel.com>
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

Implement suspend and resume callbacks to save and restore register
state, to support platforms where the power is disabled during suspend.

In future the driver could be converted to use regmap which would
simplify the suspend and resume code.

Signed-off-by: Ed Blake <ed.blake@sondrel.com>
---
Changes in v2:
 - Changed from ASoC specific pm callbacks to device ones
---
 sound/soc/img/img-spdif-out.c | 44 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/sound/soc/img/img-spdif-out.c b/sound/soc/img/img-spdif-out.c
index 416aa5786b93..1808a5542fd1 100644
--- a/sound/soc/img/img-spdif-out.c
+++ b/sound/soc/img/img-spdif-out.c
@@ -47,6 +47,9 @@ struct img_spdif_out {
 	struct snd_dmaengine_dai_dma_data dma_data;
 	struct device *dev;
 	struct reset_control *rst;
+	u32 suspend_ctl;
+	u32 suspend_csl;
+	u32 suspend_csh;
 };
 
 static int img_spdif_out_runtime_suspend(struct device *dev)
@@ -414,6 +417,46 @@ static int img_spdif_out_dev_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_PM_SLEEP
+static int img_spdif_out_suspend(struct device *dev)
+{
+	struct img_spdif_out *spdif = dev_get_drvdata(dev);
+	int ret;
+
+	if (pm_runtime_status_suspended(dev)) {
+		ret = img_spdif_out_runtime_resume(dev);
+		if (ret)
+			return ret;
+	}
+
+	spdif->suspend_ctl = img_spdif_out_readl(spdif, IMG_SPDIF_OUT_CTL);
+	spdif->suspend_csl = img_spdif_out_readl(spdif, IMG_SPDIF_OUT_CSL);
+	spdif->suspend_csh = img_spdif_out_readl(spdif, IMG_SPDIF_OUT_CSH_UV);
+
+	img_spdif_out_runtime_suspend(dev);
+
+	return 0;
+}
+
+static int img_spdif_out_resume(struct device *dev)
+{
+	struct img_spdif_out *spdif = dev_get_drvdata(dev);
+	int ret;
+
+	ret = img_spdif_out_runtime_resume(dev);
+	if (ret)
+		return ret;
+
+	img_spdif_out_writel(spdif, spdif->suspend_ctl, IMG_SPDIF_OUT_CTL);
+	img_spdif_out_writel(spdif, spdif->suspend_csl, IMG_SPDIF_OUT_CSL);
+	img_spdif_out_writel(spdif, spdif->suspend_csh, IMG_SPDIF_OUT_CSH_UV);
+
+	if (pm_runtime_status_suspended(dev))
+		img_spdif_out_runtime_suspend(dev);
+
+	return 0;
+}
+#endif
 static const struct of_device_id img_spdif_out_of_match[] = {
 	{ .compatible = "img,spdif-out" },
 	{}
@@ -423,6 +466,7 @@ MODULE_DEVICE_TABLE(of, img_spdif_out_of_match);
 static const struct dev_pm_ops img_spdif_out_pm_ops = {
 	SET_RUNTIME_PM_OPS(img_spdif_out_runtime_suspend,
 			   img_spdif_out_runtime_resume, NULL)
+	SET_SYSTEM_SLEEP_PM_OPS(img_spdif_out_suspend, img_spdif_out_resume)
 };
 
 static struct platform_driver img_spdif_out_driver = {
-- 
2.11.0
