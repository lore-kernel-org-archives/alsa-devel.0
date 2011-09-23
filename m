From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Support a wider range of sample rates on
	Speyside WM8962
Date: Fri, 23 Sep 2011 16:05:26 +0100
Message-ID: <1316790326-25715-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 4443C103813
	for <alsa-devel@alsa-project.org>;
	Fri, 23 Sep 2011 17:05:30 +0200 (CEST)
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

As we've only got one audio interface and it is symmetric we can just set
SYSCLK based on the sample rate requested by the application layer. Provide
a default so bypass paths work before audio playback.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/samsung/speyside_wm8962.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/sound/soc/samsung/speyside_wm8962.c b/sound/soc/samsung/speyside_wm8962.c
index 3820a6b..98b28ea 100644
--- a/sound/soc/samsung/speyside_wm8962.c
+++ b/sound/soc/samsung/speyside_wm8962.c
@@ -16,6 +16,8 @@
 
 #include "../codecs/wm8962.h"
 
+static int sample_rate = 44100;
+
 static int speyside_wm8962_set_bias_level(struct snd_soc_card *card,
 					  struct snd_soc_dapm_context *dapm,
 					  enum snd_soc_bias_level level)
@@ -31,13 +33,13 @@ static int speyside_wm8962_set_bias_level(struct snd_soc_card *card,
 		if (dapm->bias_level == SND_SOC_BIAS_STANDBY) {
 			ret = snd_soc_dai_set_pll(codec_dai, WM8962_FLL,
 						  WM8962_FLL_MCLK, 32768,
-						  44100 * 512);
+						  sample_rate * 512);
 			if (ret < 0)
 				pr_err("Failed to start FLL: %d\n", ret);
 
 			ret = snd_soc_dai_set_sysclk(codec_dai,
 						     WM8962_SYSCLK_FLL,
-						     44100 * 512,
+						     sample_rate * 512,
 						     SND_SOC_CLOCK_IN);
 			if (ret < 0) {
 				pr_err("Failed to set SYSCLK: %d\n", ret);
@@ -109,6 +111,8 @@ static int speyside_wm8962_hw_params(struct snd_pcm_substream *substream,
 	if (ret < 0)
 		return ret;
 
+	sample_rate = params_rate(params);
+
 	return 0;
 }
 
-- 
1.7.6.3
