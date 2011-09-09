From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH] ASoC: playpaq_wm8510: Return proper error if clk_get fails
Date: Fri, 09 Sep 2011 10:15:37 +0800
Message-ID: <1315534538.3275.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Geoffrey Wossum <gwossum@acm.org>, Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Return proper error instead of 0 if clk_get fails.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/atmel/playpaq_wm8510.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/sound/soc/atmel/playpaq_wm8510.c b/sound/soc/atmel/playpaq_wm8510.c
index 1aac2f4..2909bfa 100644
--- a/sound/soc/atmel/playpaq_wm8510.c
+++ b/sound/soc/atmel/playpaq_wm8510.c
@@ -383,14 +383,17 @@ static int __init playpaq_asoc_init(void)
 	_gclk0 = clk_get(NULL, "gclk0");
 	if (IS_ERR(_gclk0)) {
 		_gclk0 = NULL;
+		ret = PTR_ERR(_gclk0);
 		goto err_gclk0;
 	}
 	_pll0 = clk_get(NULL, "pll0");
 	if (IS_ERR(_pll0)) {
 		_pll0 = NULL;
+		ret = PTR_ERR(_pll0);
 		goto err_pll0;
 	}
-	if (clk_set_parent(_gclk0, _pll0)) {
+	ret = clk_set_parent(_gclk0, _pll0);
+	if (ret) {
 		pr_warning("snd-soc-playpaq: "
 			   "Failed to set PLL0 as parent for DAC clock\n");
 		goto err_set_clk;
-- 
1.7.4.1
