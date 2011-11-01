From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 3/7] ASoC: Ensure we always delay for WM8962
	FLL when starting from SYSCLK
Date: Tue,  1 Nov 2011 18:40:38 +0000
Message-ID: <1320172842-15790-3-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1320172842-15790-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 3B0C6103852
	for <alsa-devel@alsa-project.org>; Tue,  1 Nov 2011 19:40:46 +0100 (CET)
In-Reply-To: <1320172842-15790-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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
 sound/soc/codecs/wm8962.c |   17 ++++++++---------
 1 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index 95c302a..153b4ac 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -2368,15 +2368,14 @@ static int sysclk_event(struct snd_soc_dapm_widget *w,
 
 			snd_soc_update_bits(codec, WM8962_FLL_CONTROL_1,
 					    WM8962_FLL_ENA, WM8962_FLL_ENA);
-			if (wm8962->irq) {
-				timeout = msecs_to_jiffies(5);
-				timeout = wait_for_completion_timeout(&wm8962->fll_lock,
-								      timeout);
-
-				if (timeout == 0)
-					dev_err(codec->dev,
-						"Timed out starting FLL\n");
-			}
+
+			timeout = msecs_to_jiffies(5);
+			timeout = wait_for_completion_timeout(&wm8962->fll_lock,
+							      timeout);
+
+			if (wm8962->irq && timeout == 0)
+				dev_err(codec->dev,
+					"Timed out starting FLL\n");
 		}
 		break;
 
-- 
1.7.7.1
