From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/2] ASoC: wm8988: Convert to table based DAPM
	and control init
Date: Sat, 21 Jan 2012 23:28:02 +0000
Message-ID: <1327188483-23756-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 3BEB42436E
	for <alsa-devel@alsa-project.org>; Sun, 22 Jan 2012 00:28:12 +0100 (CET)
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
 sound/soc/codecs/wm8988.c |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/wm8988.c b/sound/soc/codecs/wm8988.c
index ab52963d..40aebaf 100644
--- a/sound/soc/codecs/wm8988.c
+++ b/sound/soc/codecs/wm8988.c
@@ -317,7 +317,7 @@ static const struct snd_soc_dapm_widget wm8988_dapm_widgets[] = {
 	SND_SOC_DAPM_INPUT("RINPUT2"),
 };
 
-static const struct snd_soc_dapm_route audio_map[] = {
+static const struct snd_soc_dapm_route wm8988_dapm_routes[] = {
 
 	{ "Left Line Mux", "Line 1", "LINPUT1" },
 	{ "Left Line Mux", "Line 2", "LINPUT2" },
@@ -743,7 +743,6 @@ static int wm8988_resume(struct snd_soc_codec *codec)
 static int wm8988_probe(struct snd_soc_codec *codec)
 {
 	struct wm8988_priv *wm8988 = snd_soc_codec_get_drvdata(codec);
-	struct snd_soc_dapm_context *dapm = &codec->dapm;
 	int ret = 0;
 
 	ret = snd_soc_codec_set_cache_io(codec, 7, 9, wm8988->control_type);
@@ -767,12 +766,6 @@ static int wm8988_probe(struct snd_soc_codec *codec)
 
 	wm8988_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
 
-	snd_soc_add_controls(codec, wm8988_snd_controls,
-				ARRAY_SIZE(wm8988_snd_controls));
-	snd_soc_dapm_new_controls(dapm, wm8988_dapm_widgets,
-				  ARRAY_SIZE(wm8988_dapm_widgets));
-	snd_soc_dapm_add_routes(dapm, audio_map, ARRAY_SIZE(audio_map));
-
 	return 0;
 }
 
@@ -791,6 +784,13 @@ static struct snd_soc_codec_driver soc_codec_dev_wm8988 = {
 	.reg_cache_size = ARRAY_SIZE(wm8988_reg),
 	.reg_word_size = sizeof(u16),
 	.reg_cache_default = wm8988_reg,
+
+	.controls = wm8988_snd_controls,
+	.num_controls = ARRAY_SIZE(wm8988_snd_controls),
+	.dapm_widgets = wm8988_dapm_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(wm8988_dapm_widgets),
+	.dapm_routes = wm8988_dapm_routes,
+	.num_dapm_routes = ARRAY_SIZE(wm8988_dapm_routes),
 };
 
 #if defined(CONFIG_SPI_MASTER)
-- 
1.7.7.3
