From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Convert WM8523 to table based control
	and DAPM initialization
Date: Mon, 22 Aug 2011 16:03:07 +0100
Message-ID: <1314025387-21369-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A781C1038D9
	for <alsa-devel@alsa-project.org>;
	Mon, 22 Aug 2011 17:03:11 +0200 (CEST)
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
 sound/soc/codecs/wm8523.c |   26 +++++++++-----------------
 1 files changed, 9 insertions(+), 17 deletions(-)

diff --git a/sound/soc/codecs/wm8523.c b/sound/soc/codecs/wm8523.c
index 52812d1..5355a7a 100644
--- a/sound/soc/codecs/wm8523.c
+++ b/sound/soc/codecs/wm8523.c
@@ -85,7 +85,7 @@ static const char *wm8523_zd_count_text[] = {
 static const struct soc_enum wm8523_zc_count =
 	SOC_ENUM_SINGLE(WM8523_ZERO_DETECT, 0, 2, wm8523_zd_count_text);
 
-static const struct snd_kcontrol_new wm8523_snd_controls[] = {
+static const struct snd_kcontrol_new wm8523_controls[] = {
 SOC_DOUBLE_R_TLV("Playback Volume", WM8523_DAC_GAINL, WM8523_DAC_GAINR,
 		 0, 448, 0, dac_tlv),
 SOC_SINGLE("ZC Switch", WM8523_DAC_CTRL3, 4, 1, 0),
@@ -102,22 +102,11 @@ SND_SOC_DAPM_OUTPUT("LINEVOUTL"),
 SND_SOC_DAPM_OUTPUT("LINEVOUTR"),
 };
 
-static const struct snd_soc_dapm_route intercon[] = {
+static const struct snd_soc_dapm_route wm8523_dapm_routes[] = {
 	{ "LINEVOUTL", NULL, "DAC" },
 	{ "LINEVOUTR", NULL, "DAC" },
 };
 
-static int wm8523_add_widgets(struct snd_soc_codec *codec)
-{
-	struct snd_soc_dapm_context *dapm = &codec->dapm;
-
-	snd_soc_dapm_new_controls(dapm, wm8523_dapm_widgets,
-				  ARRAY_SIZE(wm8523_dapm_widgets));
-	snd_soc_dapm_add_routes(dapm, intercon, ARRAY_SIZE(intercon));
-
-	return 0;
-}
-
 static struct {
 	int value;
 	int ratio;
@@ -480,10 +469,6 @@ static int wm8523_probe(struct snd_soc_codec *codec)
 	/* Bias level configuration will have done an extra enable */
 	regulator_bulk_disable(ARRAY_SIZE(wm8523->supplies), wm8523->supplies);
 
-	snd_soc_add_controls(codec, wm8523_snd_controls,
-			     ARRAY_SIZE(wm8523_snd_controls));
-	wm8523_add_widgets(codec);
-
 	return 0;
 
 err_enable:
@@ -513,6 +498,13 @@ static struct snd_soc_codec_driver soc_codec_dev_wm8523 = {
 	.reg_word_size = sizeof(u16),
 	.reg_cache_default = wm8523_reg,
 	.volatile_register = wm8523_volatile_register,
+
+	.controls = wm8523_controls,
+	.num_controls = ARRAY_SIZE(wm8523_controls),
+	.dapm_widgets = wm8523_dapm_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(wm8523_dapm_widgets),
+	.dapm_routes = wm8523_dapm_routes,
+	.num_dapm_routes = ARRAY_SIZE(wm8523_dapm_routes),
 };
 
 static const struct of_device_id wm8523_of_match[] = {
-- 
1.7.5.4
