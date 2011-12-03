From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 12/21] ASoC: Convert WM8510 to table based DAPM
	and control init
Date: Sat,  3 Dec 2011 21:33:20 +0000
Message-ID: <1322948009-27658-12-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1322948009-27658-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 161D1243E7
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
 sound/soc/codecs/wm8510.c |   23 ++++++++---------------
 1 files changed, 8 insertions(+), 15 deletions(-)

diff --git a/sound/soc/codecs/wm8510.c b/sound/soc/codecs/wm8510.c
index 9e92bbb..a7506dc 100644
--- a/sound/soc/codecs/wm8510.c
+++ b/sound/soc/codecs/wm8510.c
@@ -181,7 +181,7 @@ SND_SOC_DAPM_OUTPUT("SPKOUTP"),
 SND_SOC_DAPM_OUTPUT("SPKOUTN"),
 };
 
-static const struct snd_soc_dapm_route audio_map[] = {
+static const struct snd_soc_dapm_route wm8510_dapm_routes[] = {
 	/* Mono output mixer */
 	{"Mono Mixer", "PCM Playback Switch", "DAC"},
 	{"Mono Mixer", "Aux Playback Switch", "Aux Input"},
@@ -213,17 +213,6 @@ static const struct snd_soc_dapm_route audio_map[] = {
 	{"ADC", NULL, "Boost Mixer"},
 };
 
-static int wm8510_add_widgets(struct snd_soc_codec *codec)
-{
-	struct snd_soc_dapm_context *dapm = &codec->dapm;
-
-	snd_soc_dapm_new_controls(dapm, wm8510_dapm_widgets,
-				  ARRAY_SIZE(wm8510_dapm_widgets));
-	snd_soc_dapm_add_routes(dapm, audio_map, ARRAY_SIZE(audio_map));
-
-	return 0;
-}
-
 struct pll_ {
 	unsigned int pre_div:4; /* prescale - 1 */
 	unsigned int n:4;
@@ -561,9 +550,6 @@ static int wm8510_probe(struct snd_soc_codec *codec)
 
 	/* power on device */
 	wm8510_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
-	snd_soc_add_controls(codec, wm8510_snd_controls,
-				ARRAY_SIZE(wm8510_snd_controls));
-	wm8510_add_widgets(codec);
 
 	return ret;
 }
@@ -587,6 +573,13 @@ static struct snd_soc_codec_driver soc_codec_dev_wm8510 = {
 	.reg_cache_size = ARRAY_SIZE(wm8510_reg),
 	.reg_word_size = sizeof(u16),
 	.reg_cache_default =wm8510_reg,
+
+	.controls = wm8510_snd_controls,
+	.num_controls = ARRAY_SIZE(wm8510_snd_controls),
+	.dapm_widgets = wm8510_dapm_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(wm8510_dapm_widgets),
+	.dapm_routes = wm8510_dapm_routes,
+	.num_dapm_routes = ARRAY_SIZE(wm8510_dapm_routes),
 };
 
 static const struct of_device_id wm8510_of_match[] = {
-- 
1.7.7.3
