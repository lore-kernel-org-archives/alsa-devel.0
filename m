From: Mihai Burduselu <michelcatalin@gmail.com>
Subject: [PATCH] ASoC: dwc: remove 'out of memory' message
Date: Sat, 25 Feb 2017 13:03:23 +0200
Message-ID: <20170225110323.7506-1-michelcatalin@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tiwai@suse.com, perex@perex.cz
Cc: lgirdwood@gmail.com, broonie@kernel.org, Jose.Abreu@synopsys.com, s.nawrocki@samsung.com, colin.king@canonical.com, michelcatalin@gmail.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Reported by checkpatch.pl
Signed-off-by: Mihai Burduselu <michelcatalin@gmail.com>
---
 sound/soc/dwc/designware_i2s.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/soc/dwc/designware_i2s.c b/sound/soc/dwc/designware_i2s.c
index 9c46e4112026..6479768cc6a1 100644
--- a/sound/soc/dwc/designware_i2s.c
+++ b/sound/soc/dwc/designware_i2s.c
@@ -611,10 +611,8 @@ static int dw_i2s_probe(struct platform_device *pdev)
 	const char *clk_id;
 
 	dev = devm_kzalloc(&pdev->dev, sizeof(*dev), GFP_KERNEL);
-	if (!dev) {
-		dev_warn(&pdev->dev, "kzalloc fail\n");
+	if (!dev)
 		return -ENOMEM;
-	}
 
 	dw_i2s_dai = devm_kzalloc(&pdev->dev, sizeof(*dw_i2s_dai), GFP_KERNEL);
 	if (!dw_i2s_dai)
-- 
2.11.0
