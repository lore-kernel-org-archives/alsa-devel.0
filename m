From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 1/4] ASoC: wm8991: Convert to table based
	control and widget init
Date: Fri, 22 Nov 2013 13:39:13 +0000
Message-ID: <1385127556-1661-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id A049F2625FD
 for <alsa-devel@alsa-project.org>; Fri, 22 Nov 2013 14:39:22 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@linaro.org>

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/codecs/wm8991.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/wm8991.c b/sound/soc/codecs/wm8991.c
index 5078fc8e10f7..86aa33fd11de 100644
--- a/sound/soc/codecs/wm8991.c
+++ b/sound/soc/codecs/wm8991.c
@@ -764,7 +764,7 @@ static const struct snd_soc_dapm_widget wm8991_dapm_widgets[] = {
 	SND_SOC_DAPM_OUTPUT("Internal DAC Sink"),
 };
 
-static const struct snd_soc_dapm_route audio_map[] = {
+static const struct snd_soc_dapm_route wm8991_dapm_routes[] = {
 	/* Make DACs turn on when playing even if not mixed into any outputs */
 	{"Internal DAC Sink", NULL, "Left DAC"},
 	{"Internal DAC Sink", NULL, "Right DAC"},
@@ -1278,13 +1278,6 @@ static int wm8991_probe(struct snd_soc_codec *codec)
 	snd_soc_write(codec, WM8991_LEFT_OUTPUT_VOLUME, 0x50 | (1<<8));
 	snd_soc_write(codec, WM8991_RIGHT_OUTPUT_VOLUME, 0x50 | (1<<8));
 
-	snd_soc_add_codec_controls(codec, wm8991_snd_controls,
-			     ARRAY_SIZE(wm8991_snd_controls));
-
-	snd_soc_dapm_new_controls(&codec->dapm, wm8991_dapm_widgets,
-				  ARRAY_SIZE(wm8991_dapm_widgets));
-	snd_soc_dapm_add_routes(&codec->dapm, audio_map,
-				ARRAY_SIZE(audio_map));
 	return 0;
 }
 
@@ -1333,6 +1326,12 @@ static struct snd_soc_codec_driver soc_codec_dev_wm8991 = {
 	.suspend = wm8991_suspend,
 	.resume = wm8991_resume,
 	.set_bias_level = wm8991_set_bias_level,
+	.controls = wm8991_snd_controls,
+	.num_controls = ARRAY_SIZE(wm8991_snd_controls),
+	.dapm_widgets = wm8991_dapm_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(wm8991_dapm_widgets),
+	.dapm_routes = wm8991_dapm_routes,
+	.num_dapm_routes = ARRAY_SIZE(wm8991_dapm_routes),
 	.reg_cache_size = WM8991_MAX_REGISTER + 1,
 	.reg_word_size = sizeof(u16),
 	.reg_cache_default = wm8991_reg_defs
-- 
1.8.4.4
