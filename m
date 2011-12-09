From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 4/4] ASoC: Convert WM8900 to table based DAPM
	and control init
Date: Fri,  9 Dec 2011 20:27:20 +0800
Message-ID: <1323433640-29538-4-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1323433640-29538-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D12D310384B
	for <alsa-devel@alsa-project.org>; Fri,  9 Dec 2011 13:27:31 +0100 (CET)
In-Reply-To: <1323433640-29538-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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
 sound/soc/codecs/wm8900.c |   24 ++++++++----------------
 1 files changed, 8 insertions(+), 16 deletions(-)

diff --git a/sound/soc/codecs/wm8900.c b/sound/soc/codecs/wm8900.c
index e427a38..f18c554 100644
--- a/sound/soc/codecs/wm8900.c
+++ b/sound/soc/codecs/wm8900.c
@@ -542,7 +542,7 @@ SND_SOC_DAPM_MIXER("Right Output Mixer", WM8900_REG_POWER3, 2, 0,
 };
 
 /* Target, Path, Source */
-static const struct snd_soc_dapm_route audio_map[] = {
+static const struct snd_soc_dapm_route wm8900_dapm_routes[] = {
 /* Inputs */
 {"Left Input PGA", "LINPUT1 Switch", "LINPUT1"},
 {"Left Input PGA", "LINPUT2 Switch", "LINPUT2"},
@@ -606,17 +606,6 @@ static const struct snd_soc_dapm_route audio_map[] = {
 {"HP_R", NULL, "Headphone Amplifier"},
 };
 
-static int wm8900_add_widgets(struct snd_soc_codec *codec)
-{
-	struct snd_soc_dapm_context *dapm = &codec->dapm;
-
-	snd_soc_dapm_new_controls(dapm, wm8900_dapm_widgets,
-				  ARRAY_SIZE(wm8900_dapm_widgets));
-	snd_soc_dapm_add_routes(dapm, audio_map, ARRAY_SIZE(audio_map));
-
-	return 0;
-}
-
 static int wm8900_hw_params(struct snd_pcm_substream *substream,
 	struct snd_pcm_hw_params *params,
 	struct snd_soc_dai *dai)
@@ -1203,10 +1192,6 @@ static int wm8900_probe(struct snd_soc_codec *codec)
 	/* Set the DAC and mixer output bias */
 	snd_soc_write(codec, WM8900_REG_OUTBIASCTL, 0x81);
 
-	snd_soc_add_controls(codec, wm8900_snd_controls,
-				ARRAY_SIZE(wm8900_snd_controls));
-	wm8900_add_widgets(codec);
-
 	return 0;
 }
 
@@ -1227,6 +1212,13 @@ static struct snd_soc_codec_driver soc_codec_dev_wm8900 = {
 	.reg_cache_size = ARRAY_SIZE(wm8900_reg_defaults),
 	.reg_word_size = sizeof(u16),
 	.reg_cache_default = wm8900_reg_defaults,
+
+	.controls = wm8900_snd_controls,
+	.num_controls = ARRAY_SIZE(wm8900_snd_controls),
+	.dapm_widgets = wm8900_dapm_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(wm8900_dapm_widgets),
+	.dapm_routes = wm8900_dapm_routes,
+	.num_dapm_routes = ARRAY_SIZE(wm8900_dapm_routes),
 };
 
 #if defined(CONFIG_SPI_MASTER)
-- 
1.7.7.3
