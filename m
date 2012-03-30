From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: wm8994: Don't bother lowering clock
	dividers inside idle AIFs
Date: Fri, 30 Mar 2012 11:22:25 +0100
Message-ID: <1333102945-24753-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 2D3BC24437
	for <alsa-devel@alsa-project.org>;
	Fri, 30 Mar 2012 12:22:28 +0200 (CEST)
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

This increases the chances we'll manage to hit a partially configured
state on restart and the power savings are extremely small.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8994.c |   29 -----------------------------
 1 files changed, 0 insertions(+), 29 deletions(-)

diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index ea68c14..5c83505 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -2626,33 +2626,6 @@ static int wm8994_aif3_hw_params(struct snd_pcm_substream *substream,
 	return snd_soc_update_bits(codec, aif1_reg, WM8994_AIF1_WL_MASK, aif1);
 }
 
-static void wm8994_aif_shutdown(struct snd_pcm_substream *substream,
-				struct snd_soc_dai *dai)
-{
-	struct snd_soc_codec *codec = dai->codec;
-	int rate_reg = 0;
-
-	switch (dai->id) {
-	case 1:
-		rate_reg = WM8994_AIF1_RATE;
-		break;
-	case 2:
-		rate_reg = WM8994_AIF2_RATE;
-		break;
-	default:
-		break;
-	}
-
-	/* If the DAI is idle then configure the divider tree for the
-	 * lowest output rate to save a little power if the clock is
-	 * still active (eg, because it is system clock).
-	 */
-	if (rate_reg && !dai->playback_active && !dai->capture_active)
-		snd_soc_update_bits(codec, rate_reg,
-				    WM8994_AIF1_SR_MASK |
-				    WM8994_AIF1CLK_RATE_MASK, 0x9);
-}
-
 static int wm8994_aif_mute(struct snd_soc_dai *codec_dai, int mute)
 {
 	struct snd_soc_codec *codec = codec_dai->codec;
@@ -2750,7 +2723,6 @@ static const struct snd_soc_dai_ops wm8994_aif1_dai_ops = {
 	.set_sysclk	= wm8994_set_dai_sysclk,
 	.set_fmt	= wm8994_set_dai_fmt,
 	.hw_params	= wm8994_hw_params,
-	.shutdown	= wm8994_aif_shutdown,
 	.digital_mute	= wm8994_aif_mute,
 	.set_pll	= wm8994_set_fll,
 	.set_tristate	= wm8994_set_tristate,
@@ -2760,7 +2732,6 @@ static const struct snd_soc_dai_ops wm8994_aif2_dai_ops = {
 	.set_sysclk	= wm8994_set_dai_sysclk,
 	.set_fmt	= wm8994_set_dai_fmt,
 	.hw_params	= wm8994_hw_params,
-	.shutdown	= wm8994_aif_shutdown,
 	.digital_mute   = wm8994_aif_mute,
 	.set_pll	= wm8994_set_fll,
 	.set_tristate	= wm8994_set_tristate,
-- 
1.7.9.1
