From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 3/5] ASoC: wm8990: Convert to table based
	control and DAPM init
Date: Fri, 22 Nov 2013 14:39:50 +0000
Message-ID: <1385131192-28693-3-git-send-email-broonie@kernel.org>
References: <1385131192-28693-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 1DDDA265011
 for <alsa-devel@alsa-project.org>; Fri, 22 Nov 2013 15:40:02 +0100 (CET)
In-Reply-To: <1385131192-28693-1-git-send-email-broonie@kernel.org>
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
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, patches@opensouce.wolfsonmicro.com, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@linaro.org>

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/codecs/wm8990.c | 24 +++++++-----------------
 1 file changed, 7 insertions(+), 17 deletions(-)

diff --git a/sound/soc/codecs/wm8990.c b/sound/soc/codecs/wm8990.c
index 33bec5672418..6ee1cf1d353d 100644
--- a/sound/soc/codecs/wm8990.c
+++ b/sound/soc/codecs/wm8990.c
@@ -787,7 +787,7 @@ SND_SOC_DAPM_OUTPUT("RON"),
 SND_SOC_DAPM_OUTPUT("Internal DAC Sink"),
 };
 
-static const struct snd_soc_dapm_route audio_map[] = {
+static const struct snd_soc_dapm_route wm8990_dapm_routes[] = {
 	/* Make DACs turn on when playing even if not mixed into any outputs */
 	{"Internal DAC Sink", NULL, "Left DAC"},
 	{"Internal DAC Sink", NULL, "Right DAC"},
@@ -912,18 +912,6 @@ static const struct snd_soc_dapm_route audio_map[] = {
 	{"RON", NULL, "RONMIX"},
 };
 
-static int wm8990_add_widgets(struct snd_soc_codec *codec)
-{
-	struct snd_soc_dapm_context *dapm = &codec->dapm;
-
-	snd_soc_dapm_new_controls(dapm, wm8990_dapm_widgets,
-				  ARRAY_SIZE(wm8990_dapm_widgets));
-	/* set up the WM8990 audio map */
-	snd_soc_dapm_add_routes(dapm, audio_map, ARRAY_SIZE(audio_map));
-
-	return 0;
-}
-
 /* PLL divisors */
 struct _pll_div {
 	u32 div2;
@@ -1352,10 +1340,6 @@ static int wm8990_probe(struct snd_soc_codec *codec)
 	snd_soc_write(codec, WM8990_LEFT_OUTPUT_VOLUME, 0x50 | (1<<8));
 	snd_soc_write(codec, WM8990_RIGHT_OUTPUT_VOLUME, 0x50 | (1<<8));
 
-	snd_soc_add_codec_controls(codec, wm8990_snd_controls,
-				ARRAY_SIZE(wm8990_snd_controls));
-	wm8990_add_widgets(codec);
-
 	return 0;
 }
 
@@ -1376,6 +1360,12 @@ static struct snd_soc_codec_driver soc_codec_dev_wm8990 = {
 	.reg_word_size = sizeof(u16),
 	.reg_cache_default = wm8990_reg,
 	.volatile_register = wm8990_volatile_register,
+	.controls =	wm8990_snd_controls,
+	.num_controls = ARRAY_SIZE(wm8990_snd_controls),
+	.dapm_widgets = wm8990_dapm_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(wm8990_dapm_widgets),
+	.dapm_routes =	wm8990_dapm_routes,
+	.num_dapm_routes = ARRAY_SIZE(wm8990_dapm_routes),
 };
 
 static int wm8990_i2c_probe(struct i2c_client *i2c,
-- 
1.8.4.4
