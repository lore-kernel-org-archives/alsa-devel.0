From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 10/21] ASoC: Convert WM8350 to table based DAPM
	and control init
Date: Sat,  3 Dec 2011 21:33:18 +0000
Message-ID: <1322948009-27658-10-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1322948009-27658-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id CD836243E2
	for <alsa-devel@alsa-project.org>; Sat,  3 Dec 2011 22:33:39 +0100 (CET)
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
 sound/soc/codecs/wm8350.c |   36 ++++++++----------------------------
 1 files changed, 8 insertions(+), 28 deletions(-)

diff --git a/sound/soc/codecs/wm8350.c b/sound/soc/codecs/wm8350.c
index 6f73ad4..3c441c8 100644
--- a/sound/soc/codecs/wm8350.c
+++ b/sound/soc/codecs/wm8350.c
@@ -696,7 +696,7 @@ static const struct snd_soc_dapm_widget wm8350_dapm_widgets[] = {
 	SND_SOC_DAPM_INPUT("IN3L"),
 };
 
-static const struct snd_soc_dapm_route audio_map[] = {
+static const struct snd_soc_dapm_route wm8350_dapm_routes[] = {
 
 	/* left playback mixer */
 	{"Left Playback Mixer", "Playback Switch", "Left DAC"},
@@ -777,29 +777,6 @@ static const struct snd_soc_dapm_route audio_map[] = {
 	{"Beep", NULL, "IN3R PGA"},
 };
 
-static int wm8350_add_widgets(struct snd_soc_codec *codec)
-{
-	struct snd_soc_dapm_context *dapm = &codec->dapm;
-	int ret;
-
-	ret = snd_soc_dapm_new_controls(dapm,
-					wm8350_dapm_widgets,
-					ARRAY_SIZE(wm8350_dapm_widgets));
-	if (ret != 0) {
-		dev_err(codec->dev, "dapm control register failed\n");
-		return ret;
-	}
-
-	/* set up audio paths */
-	ret = snd_soc_dapm_add_routes(dapm, audio_map, ARRAY_SIZE(audio_map));
-	if (ret != 0) {
-		dev_err(codec->dev, "DAPM route register failed\n");
-		return ret;
-	}
-
-	return 0;
-}
-
 static int wm8350_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 				 int clk_id, unsigned int freq, int dir)
 {
@@ -1634,10 +1611,6 @@ static  int wm8350_codec_probe(struct snd_soc_codec *codec)
 			    wm8350_mic_handler, 0, "Microphone detect", priv);
 
 
-	snd_soc_add_controls(codec, wm8350_snd_controls,
-				ARRAY_SIZE(wm8350_snd_controls));
-	wm8350_add_widgets(codec);
-
 	wm8350_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
 
 	return 0;
@@ -1685,6 +1658,13 @@ static struct snd_soc_codec_driver soc_codec_dev_wm8350 = {
 	.read = wm8350_codec_read,
 	.write = wm8350_codec_write,
 	.set_bias_level = wm8350_set_bias_level,
+
+	.controls = wm8350_snd_controls,
+	.num_controls = ARRAY_SIZE(wm8350_snd_controls),
+	.dapm_widgets = wm8350_dapm_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(wm8350_dapm_widgets),
+	.dapm_routes = wm8350_dapm_routes,
+	.num_dapm_routes = ARRAY_SIZE(wm8350_dapm_routes),
 };
 
 static int __devinit wm8350_probe(struct platform_device *pdev)
-- 
1.7.7.3
