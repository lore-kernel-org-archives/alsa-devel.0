From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Improve error reporting in Speyside
	WM8962 driver
Date: Wed, 29 Jun 2011 14:18:51 -0700
Message-ID: <1309382331-30552-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 95EB62457E
	for <alsa-devel@alsa-project.org>;
	Thu, 30 Jun 2011 17:32:15 +0200 (CEST)
Received: from finisterre.wolfsonmicro.main (unknown [75.16.26.133])
	by opensource2.wolfsonmicro.com (Postfix) with ESMTPSA id 1C56A1149BF
	for <alsa-devel@alsa-project.org>; Thu, 30 Jun 2011 16:32:13 +0100 (BST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/samsung/speyside_wm8962.c |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/sound/soc/samsung/speyside_wm8962.c b/sound/soc/samsung/speyside_wm8962.c
index c0ba0bf..55233e8 100644
--- a/sound/soc/samsung/speyside_wm8962.c
+++ b/sound/soc/samsung/speyside_wm8962.c
@@ -30,14 +30,16 @@ static int speyside_wm8962_set_bias_level(struct snd_soc_card *card,
 						  WM8962_FLL_MCLK, 32768,
 						  44100 * 256);
 			if (ret < 0)
-				pr_err("Failed to start FLL\n");
+				pr_err("Failed to start FLL: %d\n");
 
 			ret = snd_soc_dai_set_sysclk(codec_dai,
 						     WM8962_SYSCLK_FLL,
 						     44100 * 256,
 						     SND_SOC_CLOCK_IN);
-			if (ret < 0)
+			if (ret < 0) {
+				pr_err("Failed to set SYSCLK: %d\n");
 				return ret;
+			}
 		}
 		break;
 
@@ -59,13 +61,15 @@ static int speyside_wm8962_set_bias_level_post(struct snd_soc_card *card,
 	case SND_SOC_BIAS_STANDBY:
 		ret = snd_soc_dai_set_sysclk(codec_dai, WM8962_SYSCLK_MCLK,
 					     32768, SND_SOC_CLOCK_IN);
-		if (ret < 0)
+		if (ret < 0) {
+			pr_err("Failed to switch away from FLL: %d\n", ret);
 			return ret;
+		}
 
 		ret = snd_soc_dai_set_pll(codec_dai, WM8962_FLL,
 					  0, 0, 0);
 		if (ret < 0) {
-			pr_err("Failed to stop FLL\n");
+			pr_err("Failed to stop FLL: %d\n", ret);
 			return ret;
 		}
 		break;
-- 
1.7.5.4
