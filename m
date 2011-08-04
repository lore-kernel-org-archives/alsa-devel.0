From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Fix warning in Speyside WM8962
Date: Thu,  4 Aug 2011 10:55:40 +0900
Message-ID: <1312422940-2669-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 3D84424361
	for <alsa-devel@alsa-project.org>;
	Thu,  4 Aug 2011 14:38:35 +0200 (CEST)
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
 sound/soc/samsung/speyside_wm8962.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/samsung/speyside_wm8962.c b/sound/soc/samsung/speyside_wm8962.c
index 8ac42bf..0b9eb5f 100644
--- a/sound/soc/samsung/speyside_wm8962.c
+++ b/sound/soc/samsung/speyside_wm8962.c
@@ -37,7 +37,7 @@ static int speyside_wm8962_set_bias_level(struct snd_soc_card *card,
 						     44100 * 256,
 						     SND_SOC_CLOCK_IN);
 			if (ret < 0) {
-				pr_err("Failed to set SYSCLK: %d\n");
+				pr_err("Failed to set SYSCLK: %d\n", ret);
 				return ret;
 			}
 		}
-- 
1.7.5.4
