From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 15/21] ASoC: Convert WM8750 to table based DAPM
	and control init
Date: Sat,  3 Dec 2011 21:33:23 +0000
Message-ID: <1322948009-27658-15-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1322948009-27658-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 63990243E4
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
 sound/soc/codecs/wm8750.c |   23 ++++++++---------------
 1 files changed, 8 insertions(+), 15 deletions(-)

diff --git a/sound/soc/codecs/wm8750.c b/sound/soc/codecs/wm8750.c
index b593abf..363328c6e 100644
--- a/sound/soc/codecs/wm8750.c
+++ b/sound/soc/codecs/wm8750.c
@@ -301,7 +301,7 @@ static const struct snd_soc_dapm_widget wm8750_dapm_widgets[] = {
 	SND_SOC_DAPM_INPUT("RINPUT3"),
 };
 
-static const struct snd_soc_dapm_route audio_map[] = {
+static const struct snd_soc_dapm_route wm8750_dapm_routes[] = {
 	/* left mixer */
 	{"Left Mixer", "Playback Switch", "Left DAC"},
 	{"Left Mixer", "Left Bypass Switch", "Left Line Mux"},
@@ -395,17 +395,6 @@ static const struct snd_soc_dapm_route audio_map[] = {
 	{"Right ADC", NULL, "Right ADC Mux"},
 };
 
-static int wm8750_add_widgets(struct snd_soc_codec *codec)
-{
-	struct snd_soc_dapm_context *dapm = &codec->dapm;
-
-	snd_soc_dapm_new_controls(dapm, wm8750_dapm_widgets,
-				  ARRAY_SIZE(wm8750_dapm_widgets));
-	snd_soc_dapm_add_routes(dapm, audio_map, ARRAY_SIZE(audio_map));
-
-	return 0;
-}
-
 struct _coeff_div {
 	u32 mclk;
 	u32 rate;
@@ -708,9 +697,6 @@ static int wm8750_probe(struct snd_soc_codec *codec)
 	snd_soc_update_bits(codec, WM8750_LINVOL, 0x0100, 0x0100);
 	snd_soc_update_bits(codec, WM8750_RINVOL, 0x0100, 0x0100);
 
-	snd_soc_add_controls(codec, wm8750_snd_controls,
-				ARRAY_SIZE(wm8750_snd_controls));
-	wm8750_add_widgets(codec);
 	return ret;
 }
 
@@ -729,6 +715,13 @@ static struct snd_soc_codec_driver soc_codec_dev_wm8750 = {
 	.reg_cache_size = ARRAY_SIZE(wm8750_reg),
 	.reg_word_size = sizeof(u16),
 	.reg_cache_default = wm8750_reg,
+
+	.controls = wm8750_snd_controls,
+	.num_controls = ARRAY_SIZE(wm8750_snd_controls),
+	.dapm_widgets = wm8750_dapm_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(wm8750_dapm_widgets),
+	.dapm_routes = wm8750_dapm_routes,
+	.num_dapm_routes = ARRAY_SIZE(wm8750_dapm_routes),
 };
 
 static const struct of_device_id wm8750_of_match[] = {
-- 
1.7.7.3
