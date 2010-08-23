From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Log WM8994 separate ADC LRCLKs every
	time we configure
Date: Mon, 23 Aug 2010 10:56:37 +0100
Message-ID: <1282557397-9451-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B68592449B
	for <alsa-devel@alsa-project.org>;
	Mon, 23 Aug 2010 11:56:46 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

This makes it that little bit easier to spot the diagnostics in the
logs.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8994.c |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index 76a066e..e03072c 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -3316,20 +3316,24 @@ static int wm8994_hw_params(struct snd_pcm_substream *substream,
 		bclk_reg = WM8994_AIF1_BCLK;
 		rate_reg = WM8994_AIF1_RATE;
 		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK ||
-		    wm8994->lrclk_shared[0])
+		    wm8994->lrclk_shared[0]) {
 			lrclk_reg = WM8994_AIF1DAC_LRCLK;
-		else
+		} else {
 			lrclk_reg = WM8994_AIF1ADC_LRCLK;
+			dev_dbg(codec->dev, "AIF1 using split LRCLK\n");
+		}
 		break;
 	case 2:
 		aif1_reg = WM8994_AIF2_CONTROL_1;
 		bclk_reg = WM8994_AIF2_BCLK;
 		rate_reg = WM8994_AIF2_RATE;
 		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK ||
-		    wm8994->lrclk_shared[1])
+		    wm8994->lrclk_shared[1]) {
 			lrclk_reg = WM8994_AIF2DAC_LRCLK;
-		else
+		} else {
 			lrclk_reg = WM8994_AIF2ADC_LRCLK;
+			dev_dbg(codec->dev, "AIF2 using split LRCLK\n");
+		}
 		break;
 	default:
 		return -EINVAL;
-- 
1.7.1
