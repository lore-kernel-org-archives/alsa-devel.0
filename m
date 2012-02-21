From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: wm8994: Actively discharge idle MICBIAS
	with jack detect
Date: Tue, 21 Feb 2012 13:48:51 +0000
Message-ID: <1329832131-32761-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 28A8610396C
	for <alsa-devel@alsa-project.org>; Tue, 21 Feb 2012 14:48:56 +0100 (CET)
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

This minimises the chance of any external capacitors that are fitted
being discharged into headphones as they insert.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8994.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index ee102d6..c20f376 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -3201,6 +3201,9 @@ static irqreturn_t wm1811_jackdet_irq(int irq, void *data)
 		snd_soc_jack_report(wm8994->micdet[0].jack,
 				    SND_JACK_MECHANICAL, SND_JACK_MECHANICAL);
 
+		snd_soc_update_bits(codec, WM8958_MICBIAS2,
+				    WM8958_MICB2_DISCH, 0);
+
 		/*
 		 * Start off measument of microphone impedence to find
 		 * out what's actually there.
@@ -3212,6 +3215,9 @@ static irqreturn_t wm1811_jackdet_irq(int irq, void *data)
 	} else {
 		dev_dbg(codec->dev, "Jack not detected\n");
 
+		snd_soc_update_bits(codec, WM8958_MICBIAS2,
+				    WM8958_MICB2_DISCH, WM8958_MICB2_DISCH);
+
 		snd_soc_jack_report(wm8994->micdet[0].jack, 0,
 				    SND_JACK_MECHANICAL | SND_JACK_HEADSET |
 				    wm8994->btn_mask);
@@ -3297,6 +3303,9 @@ int wm8958_mic_detect(struct snd_soc_codec *codec, struct snd_soc_jack *jack,
 		 * otherwise jump straight to microphone detection.
 		 */
 		if (wm8994->jackdet) {
+			snd_soc_update_bits(codec, WM8958_MICBIAS2,
+					    WM8958_MICB2_DISCH,
+					    WM8958_MICB2_DISCH);
 			snd_soc_update_bits(codec, WM8994_LDO_1,
 					    WM8994_LDO1_DISCH, 0);
 			wm1811_jackdet_set_mode(codec,
-- 
1.7.9.1
