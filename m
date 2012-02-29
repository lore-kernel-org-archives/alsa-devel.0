From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: wm8994: Make sure we don't have MICBIAS
	on during jackdet mode
Date: Wed, 29 Feb 2012 10:35:58 +0000
Message-ID: <1330511758-5627-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 74568103C15
	for <alsa-devel@alsa-project.org>; Wed, 29 Feb 2012 11:36:05 +0100 (CET)
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
 sound/soc/codecs/wm8994.c |   25 +++++++++++++------------
 1 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index 33bc718..691e897 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -3170,9 +3170,6 @@ static void wm8958_default_micdet(u16 status, void *data)
 			snd_soc_update_bits(codec, WM8958_MIC_DETECT_1,
 					    WM8958_MICD_ENA, 0);
 
-			wm1811_jackdet_set_mode(codec,
-						WM1811_JACKDET_MODE_JACK);
-
 			if (wm8994->pdata->jd_ext_cap) {
 				mutex_lock(&codec->mutex);
 				snd_soc_dapm_disable_pin(&codec->dapm,
@@ -3180,6 +3177,9 @@ static void wm8958_default_micdet(u16 status, void *data)
 				snd_soc_dapm_sync(&codec->dapm);
 				mutex_unlock(&codec->mutex);
 			}
+
+			wm1811_jackdet_set_mode(codec,
+						WM1811_JACKDET_MODE_JACK);
 		}
 	}
 
@@ -3235,23 +3235,24 @@ static irqreturn_t wm1811_jackdet_irq(int irq, void *data)
 		snd_soc_update_bits(codec, WM8958_MICBIAS2,
 				    WM8958_MICB2_DISCH, 0);
 
-		/* If required for an external cap force MICBIAS on */
-		if (wm8994->pdata->jd_ext_cap) {
-			mutex_lock(&codec->mutex);
-			snd_soc_dapm_force_enable_pin(&codec->dapm,
-						      "MICBIAS2");
-			snd_soc_dapm_sync(&codec->dapm);
-			mutex_unlock(&codec->mutex);
-		}
-
 		/*
 		 * Start off measument of microphone impedence to find
 		 * out what's actually there.
 		 */
 		wm8994->mic_detecting = true;
 		wm1811_jackdet_set_mode(codec, WM1811_JACKDET_MODE_MIC);
+
 		snd_soc_update_bits(codec, WM8958_MIC_DETECT_1,
 				    WM8958_MICD_ENA, WM8958_MICD_ENA);
+
+		/* If required for an external cap force MICBIAS on */
+		if (wm8994->pdata->jd_ext_cap) {
+			mutex_lock(&codec->mutex);
+			snd_soc_dapm_force_enable_pin(&codec->dapm,
+						      "MICBIAS2");
+			snd_soc_dapm_sync(&codec->dapm);
+			mutex_unlock(&codec->mutex);
+		}
 	} else {
 		dev_dbg(codec->dev, "Jack not detected\n");
 
-- 
1.7.9.1
