From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Update speyside audio driver for
	hardware revision 2
Date: Wed,  1 Jun 2011 19:32:56 +0100
Message-ID: <1306953176-26990-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8C20F1038B7
	for <alsa-devel@alsa-project.org>;
	Wed,  1 Jun 2011 20:32:59 +0200 (CEST)
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

Revision 2 of the Speyside platform supplies a 32kHz clock on MCLK2 rather
than MCLK1.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/samsung/speyside.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/samsung/speyside.c b/sound/soc/samsung/speyside.c
index 360a333..93078b1 100644
--- a/sound/soc/samsung/speyside.c
+++ b/sound/soc/samsung/speyside.c
@@ -27,12 +27,12 @@ static int speyside_set_bias_level(struct snd_soc_card *card,
 
 	switch (level) {
 	case SND_SOC_BIAS_STANDBY:
-		ret = snd_soc_dai_set_sysclk(codec_dai, WM8915_SYSCLK_MCLK1,
+		ret = snd_soc_dai_set_sysclk(codec_dai, WM8915_SYSCLK_MCLK2,
 					     32768, SND_SOC_CLOCK_IN);
 		if (ret < 0)
 			return ret;
 
-		ret = snd_soc_dai_set_pll(codec_dai, WM8915_FLL_MCLK1,
+		ret = snd_soc_dai_set_pll(codec_dai, WM8915_FLL_MCLK2,
 					  0, 0, 0);
 		if (ret < 0) {
 			pr_err("Failed to stop FLL\n");
@@ -66,7 +66,7 @@ static int speyside_hw_params(struct snd_pcm_substream *substream,
 	if (ret < 0)
 		return ret;
 
-	ret = snd_soc_dai_set_pll(codec_dai, 0, WM8915_FLL_MCLK1,
+	ret = snd_soc_dai_set_pll(codec_dai, 0, WM8915_FLL_MCLK2,
 				  32768, 256 * 48000);
 	if (ret < 0)
 		return ret;
@@ -127,7 +127,7 @@ static int speyside_wm8915_init(struct snd_soc_pcm_runtime *rtd)
 	struct snd_soc_codec *codec = rtd->codec;
 	int ret;
 
-	ret = snd_soc_dai_set_sysclk(dai, WM8915_SYSCLK_MCLK1, 32768, 0);
+	ret = snd_soc_dai_set_sysclk(dai, WM8915_SYSCLK_MCLK2, 32768, 0);
 	if (ret < 0)
 		return ret;
 
-- 
1.7.5.3
