From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Raise Speyside audio system clock rate
	to 512fs
Date: Sun, 11 Dec 2011 11:54:27 +0800
Message-ID: <1323575667-4521-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 20D5724335
	for <alsa-devel@alsa-project.org>; Mon, 12 Dec 2011 05:54:17 +0100 (CET)
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

To support advanced system functionality for additional components; the
actively used clocks will remain the same for current components. Also
factor the rate out to a single #define while we're at it.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/samsung/speyside.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/sound/soc/samsung/speyside.c b/sound/soc/samsung/speyside.c
index e0f55cb5..8cdd4f4 100644
--- a/sound/soc/samsung/speyside.c
+++ b/sound/soc/samsung/speyside.c
@@ -19,6 +19,7 @@
 #include "../codecs/wm9081.h"
 
 #define WM8996_HPSEL_GPIO 214
+#define MCLK_AUDIO_RATE (512 * 48000)
 
 static int speyside_set_bias_level(struct snd_soc_card *card,
 				   struct snd_soc_dapm_context *dapm,
@@ -67,7 +68,7 @@ static int speyside_set_bias_level_post(struct snd_soc_card *card,
 		if (card->dapm.bias_level == SND_SOC_BIAS_STANDBY) {
 			ret = snd_soc_dai_set_pll(codec_dai, 0,
 						  WM8996_FLL_MCLK2,
-						  32768, 48000 * 256);
+						  32768, MCLK_AUDIO_RATE);
 			if (ret < 0) {
 				pr_err("Failed to start FLL\n");
 				return ret;
@@ -75,7 +76,7 @@ static int speyside_set_bias_level_post(struct snd_soc_card *card,
 
 			ret = snd_soc_dai_set_sysclk(codec_dai,
 						     WM8996_SYSCLK_FLL,
-						     48000 * 256,
+						     MCLK_AUDIO_RATE,
 						     SND_SOC_CLOCK_IN);
 			if (ret < 0)
 				return ret;
@@ -197,7 +198,7 @@ static int speyside_wm9081_init(struct snd_soc_dapm_context *dapm)
 {
 	/* At any time the WM9081 is active it will have this clock */
 	return snd_soc_codec_set_sysclk(dapm->codec, WM9081_SYSCLK_MCLK, 0,
-					48000 * 256, 0);
+					MCLK_AUDIO_RATE, 0);
 }
 
 static struct snd_soc_aux_dev speyside_aux_dev[] = {
-- 
1.7.7.3
