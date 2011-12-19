From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH] ASoC: Convert uda1380 to table based DAPM and
	control init
Date: Mon, 19 Dec 2011 13:54:38 +0800
Message-ID: <1324274078.12952.6.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gy0-f179.google.com (mail-gy0-f179.google.com
	[209.85.160.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 01C8824723
	for <alsa-devel@alsa-project.org>; Mon, 19 Dec 2011 06:54:46 +0100 (CET)
Received: by ghrr11 with SMTP id r11so3332754ghr.38
	for <alsa-devel@alsa-project.org>; Sun, 18 Dec 2011 21:54:45 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lrg@ti.com>, Philipp Zabel <philipp.zabel@gmail.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/codecs/uda1380.c |   24 ++++++++----------------
 1 files changed, 8 insertions(+), 16 deletions(-)

diff --git a/sound/soc/codecs/uda1380.c b/sound/soc/codecs/uda1380.c
index 83e45d2..8f734d6 100644
--- a/sound/soc/codecs/uda1380.c
+++ b/sound/soc/codecs/uda1380.c
@@ -373,7 +373,7 @@ static const struct snd_soc_dapm_widget uda1380_dapm_widgets[] = {
 	SND_SOC_DAPM_PGA("HeadPhone Driver", UDA1380_PM, 13, 0, NULL, 0),
 };
 
-static const struct snd_soc_dapm_route audio_map[] = {
+static const struct snd_soc_dapm_route uda1380_dapm_routes[] = {
 
 	/* output mux */
 	{"HeadPhone Driver", NULL, "Output Mux"},
@@ -410,17 +410,6 @@ static const struct snd_soc_dapm_route audio_map[] = {
 	{"Right PGA", NULL, "VINR"},
 };
 
-static int uda1380_add_widgets(struct snd_soc_codec *codec)
-{
-	struct snd_soc_dapm_context *dapm = &codec->dapm;
-
-	snd_soc_dapm_new_controls(dapm, uda1380_dapm_widgets,
-				  ARRAY_SIZE(uda1380_dapm_widgets));
-	snd_soc_dapm_add_routes(dapm, audio_map, ARRAY_SIZE(audio_map));
-
-	return 0;
-}
-
 static int uda1380_set_dai_fmt_both(struct snd_soc_dai *codec_dai,
 		unsigned int fmt)
 {
@@ -764,10 +753,6 @@ static int uda1380_probe(struct snd_soc_codec *codec)
 		break;
 	}
 
-	snd_soc_add_controls(codec, uda1380_snd_controls,
-				ARRAY_SIZE(uda1380_snd_controls));
-	uda1380_add_widgets(codec);
-
 	return 0;
 
 err_free_gpio:
@@ -802,6 +787,13 @@ static struct snd_soc_codec_driver soc_codec_dev_uda1380 = {
 	.reg_word_size = sizeof(u16),
 	.reg_cache_default = uda1380_reg,
 	.reg_cache_step = 1,
+
+	.controls = uda1380_snd_controls,
+	.num_controls = ARRAY_SIZE(uda1380_snd_controls),
+	.dapm_widgets = uda1380_dapm_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(uda1380_dapm_widgets),
+	.dapm_routes = uda1380_dapm_routes,
+	.num_dapm_routes = ARRAY_SIZE(uda1380_dapm_routes),
 };
 
 #if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
-- 
1.7.5.4
