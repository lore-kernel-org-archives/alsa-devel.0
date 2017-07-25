From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 08/11] ASoC: sun4i-spdif: Handle return value of clk_prepare_enable.
Date: Tue, 25 Jul 2017 15:45:18 +0530
Message-ID: <1500977718-28010-1-git-send-email-arvind.yadav.cs@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz, tiwai@suse.com, broonie@kernel.org, krzk@kernel.org, sbkim73@samsung.com, maxime.ripard@free-electrons.com, wens@csie.org, lgirdwood@gmail.com
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

clk_prepare_enable() can fail here and we must check its return value.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 sound/soc/sunxi/sun4i-spdif.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-spdif.c b/sound/soc/sunxi/sun4i-spdif.c
index eaefd07..4a316c0 100644
--- a/sound/soc/sunxi/sun4i-spdif.c
+++ b/sound/soc/sunxi/sun4i-spdif.c
@@ -458,11 +458,16 @@ static int sun4i_spdif_runtime_suspend(struct device *dev)
 static int sun4i_spdif_runtime_resume(struct device *dev)
 {
 	struct sun4i_spdif_dev *host  = dev_get_drvdata(dev);
+	int ret;
 
-	clk_prepare_enable(host->spdif_clk);
-	clk_prepare_enable(host->apb_clk);
+	ret = clk_prepare_enable(host->spdif_clk);
+	if (ret)
+		return ret;
+	ret = clk_prepare_enable(host->apb_clk);
+	if (ret)
+		clk_disable_unprepare(host->spdif_clk);
 
-	return 0;
+	return ret;
 }
 
 static int sun4i_spdif_probe(struct platform_device *pdev)
-- 
1.9.1
