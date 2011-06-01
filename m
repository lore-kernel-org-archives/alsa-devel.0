From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Use a lower detection rate when
	monitoring headphones on WM8915
Date: Wed,  1 Jun 2011 20:17:19 +0100
Message-ID: <1306955839-12097-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 5250C2450D
	for <alsa-devel@alsa-project.org>;
	Wed,  1 Jun 2011 21:17:23 +0200 (CEST)
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

We only need to increase the detection rate to maximum if we're monitoring
for button presses as the response times needed for user interaction there
are much lower.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8915.c |   20 ++++++++++++++------
 1 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/wm8915.c b/sound/soc/codecs/wm8915.c
index 5ff6a77..5a59ef7 100644
--- a/sound/soc/codecs/wm8915.c
+++ b/sound/soc/codecs/wm8915.c
@@ -2288,6 +2288,12 @@ static void wm8915_micd(struct snd_soc_codec *codec)
 				    SND_JACK_HEADSET | SND_JACK_BTN_0);
 		wm8915->jack_mic = true;
 		wm8915->detecting = false;
+
+		/* Increase poll rate to give better responsiveness
+		 * for buttons */
+		snd_soc_update_bits(codec, WM8915_MIC_DETECT_1,
+				    WM8915_MICD_RATE_MASK,
+				    5 << WM8915_MICD_RATE_SHIFT);
 	}
 
 	/* If we detected a lower impedence during initial startup
@@ -2328,15 +2334,17 @@ static void wm8915_micd(struct snd_soc_codec *codec)
 					    SND_JACK_HEADPHONE,
 					    SND_JACK_HEADSET |
 					    SND_JACK_BTN_0);
+
+			/* Increase the detection rate a bit for
+			 * responsiveness.
+			 */
+			snd_soc_update_bits(codec, WM8915_MIC_DETECT_1,
+					    WM8915_MICD_RATE_MASK,
+					    7 << WM8915_MICD_RATE_SHIFT);
+
 			wm8915->detecting = false;
 		}
 	}
-
-	/* Increase poll rate to give better responsiveness for buttons */
-	if (!wm8915->detecting)
-		snd_soc_update_bits(codec, WM8915_MIC_DETECT_1,
-				    WM8915_MICD_RATE_MASK,
-				    5 << WM8915_MICD_RATE_SHIFT);
 }
 
 static irqreturn_t wm8915_irq(int irq, void *data)
-- 
1.7.5.3
