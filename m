From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 11/21] ASoC: Convert WM8400 to table based DAPM
	and control init
Date: Sat,  3 Dec 2011 21:33:19 +0000
Message-ID: <1322948009-27658-11-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1322948009-27658-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 03C97243D4
	for <alsa-devel@alsa-project.org>; Sat,  3 Dec 2011 22:33:40 +0100 (CET)
In-Reply-To: <1322948009-27658-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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
 sound/soc/codecs/wm8400.c |   29 ++++++++---------------------
 1 files changed, 8 insertions(+), 21 deletions(-)

diff --git a/sound/soc/codecs/wm8400.c b/sound/soc/codecs/wm8400.c
index 1add977..6cdfe26 100644
--- a/sound/soc/codecs/wm8400.c
+++ b/sound/soc/codecs/wm8400.c
@@ -353,13 +353,6 @@ SOC_SINGLE("RIN34 Mute Switch", WM8400_RIGHT_LINE_INPUT_3_4_VOLUME,
 
 };
 
-/* add non dapm controls */
-static int wm8400_add_controls(struct snd_soc_codec *codec)
-{
-	return snd_soc_add_controls(codec, wm8400_snd_controls,
-				ARRAY_SIZE(wm8400_snd_controls));
-}
-
 /*
  * _DAPM_ Controls
  */
@@ -783,7 +776,7 @@ SND_SOC_DAPM_OUTPUT("RON"),
 SND_SOC_DAPM_OUTPUT("Internal DAC Sink"),
 };
 
-static const struct snd_soc_dapm_route audio_map[] = {
+static const struct snd_soc_dapm_route wm8400_dapm_routes[] = {
 	/* Make DACs turn on when playing even if not mixed into any outputs */
 	{"Internal DAC Sink", NULL, "Left DAC"},
 	{"Internal DAC Sink", NULL, "Right DAC"},
@@ -909,17 +902,6 @@ static const struct snd_soc_dapm_route audio_map[] = {
 	{"RON", NULL, "RONMIX"},
 };
 
-static int wm8400_add_widgets(struct snd_soc_codec *codec)
-{
-	struct snd_soc_dapm_context *dapm = &codec->dapm;
-
-	snd_soc_dapm_new_controls(dapm, wm8400_dapm_widgets,
-				  ARRAY_SIZE(wm8400_dapm_widgets));
-	snd_soc_dapm_add_routes(dapm, audio_map, ARRAY_SIZE(audio_map));
-
-	return 0;
-}
-
 /*
  * Clock after FLL and dividers
  */
@@ -1421,8 +1403,6 @@ static int wm8400_codec_probe(struct snd_soc_codec *codec)
 		ret = -EINVAL;
 		goto err_regulator;
 	}
-	wm8400_add_controls(codec);
-	wm8400_add_widgets(codec);
 	return 0;
 
 err_regulator:
@@ -1451,6 +1431,13 @@ static struct snd_soc_codec_driver soc_codec_dev_wm8400 = {
 	.read = wm8400_read,
 	.write = wm8400_write,
 	.set_bias_level = wm8400_set_bias_level,
+
+	.controls = wm8400_snd_controls,
+	.num_controls = ARRAY_SIZE(wm8400_snd_controls),
+	.dapm_widgets = wm8400_dapm_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(wm8400_dapm_widgets),
+	.dapm_routes = wm8400_dapm_routes,
+	.num_dapm_routes = ARRAY_SIZE(wm8400_dapm_routes),
 };
 
 static int __devinit wm8400_probe(struct platform_device *pdev)
-- 
1.7.7.3
