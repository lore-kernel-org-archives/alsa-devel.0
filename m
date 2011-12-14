From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Tune the accessory detection rates for
	WM8996
Date: Wed, 14 Dec 2011 19:33:55 +0800
Message-ID: <1323862435-13143-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B1EF2103C8F
	for <alsa-devel@alsa-project.org>; Wed, 14 Dec 2011 12:34:38 +0100 (CET)
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

Use longer intervals when the microphone is not inserted to increase
robustness against leisurely insertion.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8996.c |   18 ++++++++++++------
 1 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/wm8996.c b/sound/soc/codecs/wm8996.c
index 8f88f5a..da7acae 100644
--- a/sound/soc/codecs/wm8996.c
+++ b/sound/soc/codecs/wm8996.c
@@ -2572,8 +2572,10 @@ static void wm8996_micd(struct snd_soc_codec *codec)
 				    SND_JACK_BTN_0);
 
 		snd_soc_update_bits(codec, WM8996_MIC_DETECT_1,
-				    WM8996_MICD_RATE_MASK,
-				    WM8996_MICD_RATE_MASK);
+				    WM8996_MICD_RATE_MASK |
+				    WM8996_MICD_BIAS_STARTTIME_MASK,
+				    WM8996_MICD_RATE_MASK |
+				    9 << WM8996_MICD_BIAS_STARTTIME_SHIFT);
 		return;
 	}
 
@@ -2590,8 +2592,10 @@ static void wm8996_micd(struct snd_soc_codec *codec)
 			/* Increase poll rate to give better responsiveness
 			 * for buttons */
 			snd_soc_update_bits(codec, WM8996_MIC_DETECT_1,
-					    WM8996_MICD_RATE_MASK,
-					    5 << WM8996_MICD_RATE_SHIFT);
+					    WM8996_MICD_RATE_MASK |
+					    WM8996_MICD_BIAS_STARTTIME_MASK,
+					    5 << WM8996_MICD_RATE_SHIFT |
+					    7 << WM8996_MICD_BIAS_STARTTIME_SHIFT);
 		} else {
 			dev_dbg(codec->dev, "Mic button up\n");
 			snd_soc_jack_report(wm8996->jack, 0, SND_JACK_BTN_0);
@@ -2639,8 +2643,10 @@ static void wm8996_micd(struct snd_soc_codec *codec)
 			 * responsiveness.
 			 */
 			snd_soc_update_bits(codec, WM8996_MIC_DETECT_1,
-					    WM8996_MICD_RATE_MASK,
-					    7 << WM8996_MICD_RATE_SHIFT);
+					    WM8996_MICD_RATE_MASK |
+					    WM8996_MICD_BIAS_STARTTIME_MASK,
+					    7 << WM8996_MICD_RATE_SHIFT |
+					    7 << WM8996_MICD_BIAS_STARTTIME_SHIFT);
 		}
 	}
 }
-- 
1.7.7.3
