From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Run Speyside WM8962 at 512fs
Date: Tue, 16 Aug 2011 21:43:25 +0900
Message-ID: <1313498605-13521-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 4A2D62449B
	for <alsa-devel@alsa-project.org>;
	Tue, 16 Aug 2011 17:30:09 +0200 (CEST)
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

Ensure we have access to all the advanced DSP functinality offered by the
WM8962 by running the system clock at 512fs.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/samsung/speyside_wm8962.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/samsung/speyside_wm8962.c b/sound/soc/samsung/speyside_wm8962.c
index 0b9eb5f..753e1c2 100644
--- a/sound/soc/samsung/speyside_wm8962.c
+++ b/sound/soc/samsung/speyside_wm8962.c
@@ -28,13 +28,13 @@ static int speyside_wm8962_set_bias_level(struct snd_soc_card *card,
 		if (dapm->bias_level == SND_SOC_BIAS_STANDBY) {
 			ret = snd_soc_dai_set_pll(codec_dai, WM8962_FLL,
 						  WM8962_FLL_MCLK, 32768,
-						  44100 * 256);
+						  44100 * 512);
 			if (ret < 0)
 				pr_err("Failed to start FLL: %d\n", ret);
 
 			ret = snd_soc_dai_set_sysclk(codec_dai,
 						     WM8962_SYSCLK_FLL,
-						     44100 * 256,
+						     44100 * 512,
 						     SND_SOC_CLOCK_IN);
 			if (ret < 0) {
 				pr_err("Failed to set SYSCLK: %d\n", ret);
-- 
1.7.5.4
