From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Convert WM8753 to table based DAPM and
	control init
Date: Mon, 21 Nov 2011 15:51:34 +0000
Message-ID: <1321890694-10667-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 9008E24345
	for <alsa-devel@alsa-project.org>; Mon, 21 Nov 2011 16:51:37 +0100 (CET)
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
 sound/soc/codecs/wm8753.c |   24 ++++++++----------------
 1 files changed, 8 insertions(+), 16 deletions(-)

diff --git a/sound/soc/codecs/wm8753.c b/sound/soc/codecs/wm8753.c
index 3f3541b..03cd46b 100644
--- a/sound/soc/codecs/wm8753.c
+++ b/sound/soc/codecs/wm8753.c
@@ -486,7 +486,7 @@ SND_SOC_DAPM_INPUT("MIC2"),
 SND_SOC_DAPM_VMID("VREF"),
 };
 
-static const struct snd_soc_dapm_route audio_map[] = {
+static const struct snd_soc_dapm_route wm8753_dapm_routes[] = {
 	/* left mixer */
 	{"Left Mixer", "Left Playback Switch", "Left DAC"},
 	{"Left Mixer", "Voice Playback Switch", "Voice DAC"},
@@ -640,17 +640,6 @@ static const struct snd_soc_dapm_route audio_map[] = {
 	{"ACOP", NULL, "ALC Mixer"},
 };
 
-static int wm8753_add_widgets(struct snd_soc_codec *codec)
-{
-	struct snd_soc_dapm_context *dapm = &codec->dapm;
-
-	snd_soc_dapm_new_controls(dapm, wm8753_dapm_widgets,
-				  ARRAY_SIZE(wm8753_dapm_widgets));
-	snd_soc_dapm_add_routes(dapm, audio_map, ARRAY_SIZE(audio_map));
-
-	return 0;
-}
-
 /* PLL divisors */
 struct _pll_div {
 	u32 div2:1;
@@ -1468,10 +1457,6 @@ static int wm8753_probe(struct snd_soc_codec *codec)
 	snd_soc_update_bits(codec, WM8753_LINVOL, 0x0100, 0x0100);
 	snd_soc_update_bits(codec, WM8753_RINVOL, 0x0100, 0x0100);
 
-	snd_soc_add_controls(codec, wm8753_snd_controls,
-			     ARRAY_SIZE(wm8753_snd_controls));
-	wm8753_add_widgets(codec);
-
 	return 0;
 }
 
@@ -1493,6 +1478,13 @@ static struct snd_soc_codec_driver soc_codec_dev_wm8753 = {
 	.reg_cache_size = ARRAY_SIZE(wm8753_reg),
 	.reg_word_size = sizeof(u16),
 	.reg_cache_default = wm8753_reg,
+
+	.controls = wm8753_snd_controls,
+	.num_controls = ARRAY_SIZE(wm8753_snd_controls),
+	.dapm_widgets = wm8753_dapm_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(wm8753_dapm_widgets),
+	.dapm_routes = wm8753_dapm_routes,
+	.num_dapm_routes = ARRAY_SIZE(wm8753_dapm_routes),
 };
 
 static const struct of_device_id wm8753_of_match[] = {
-- 
1.7.7.3
