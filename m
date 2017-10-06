From: Ed Blake <ed.blake@sondrel.com>
Subject: [PATCH v2 1/2] ASoC: img-spdif-in: Add suspend /
	resume handling
Date: Fri,  6 Oct 2017 15:53:54 +0100
Message-ID: <20171006145355.13616-2-ed.blake@sondrel.com>
References: <20171006145355.13616-1-ed.blake@sondrel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01on0055.outbound.protection.outlook.com [104.47.2.55])
 by alsa0.perex.cz (Postfix) with ESMTP id 4B8F5267621
 for <alsa-devel@alsa-project.org>; Fri,  6 Oct 2017 16:54:05 +0200 (CEST)
In-Reply-To: <20171006145355.13616-1-ed.blake@sondrel.com>
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
2.11.0
