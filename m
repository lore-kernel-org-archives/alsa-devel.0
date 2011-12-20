From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH] ASoC: Convert 88pm860x-codec to table based
 DAPM and control init
Date: Tue, 20 Dec 2011 10:14:25 +0800
Message-ID: <1324347265.19384.2.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f179.google.com (mail-qy0-f179.google.com
	[209.85.216.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 99F1D1038B9
	for <alsa-devel@alsa-project.org>; Tue, 20 Dec 2011 03:14:38 +0100 (CET)
Received: by qcol42 with SMTP id l42so3687951qco.38
	for <alsa-devel@alsa-project.org>; Mon, 19 Dec 2011 18:14:37 -0800 (PST)
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Haojian Zhuang <haojian.zhuang@marvell.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/codecs/88pm860x-codec.c |   15 ++++++++-------
 1 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/88pm860x-codec.c b/sound/soc/codecs/88pm860x-codec.c
index 2d39123..99ca53c 100644
--- a/sound/soc/codecs/88pm860x-codec.c
+++ b/sound/soc/codecs/88pm860x-codec.c
@@ -861,7 +861,7 @@ static const struct snd_soc_dapm_widget pm860x_dapm_widgets[] = {
 	PM860X_DAPM_OUTPUT("RSYNC", pm860x_rsync_event),
 };
 
-static const struct snd_soc_dapm_route audio_map[] = {
+static const struct snd_soc_dapm_route pm860x_dapm_routes[] = {
 	/* supply */
 	{"Left DAC", NULL, "VCODEC"},
 	{"Right DAC", NULL, "VCODEC"},
@@ -1361,7 +1361,6 @@ EXPORT_SYMBOL_GPL(pm860x_mic_jack_detect);
 static int pm860x_probe(struct snd_soc_codec *codec)
 {
 	struct pm860x_priv *pm860x = snd_soc_codec_get_drvdata(codec);
-	struct snd_soc_dapm_context *dapm = &codec->dapm;
 	int i, ret;
 
 	pm860x->codec = codec;
@@ -1388,11 +1387,6 @@ static int pm860x_probe(struct snd_soc_codec *codec)
 		goto out;
 	}
 
-	snd_soc_add_controls(codec, pm860x_snd_controls,
-			     ARRAY_SIZE(pm860x_snd_controls));
-	snd_soc_dapm_new_controls(dapm, pm860x_dapm_widgets,
-				  ARRAY_SIZE(pm860x_dapm_widgets));
-	snd_soc_dapm_add_routes(dapm, audio_map, ARRAY_SIZE(audio_map));
 	return 0;
 
 out:
@@ -1420,6 +1414,13 @@ static struct snd_soc_codec_driver soc_codec_dev_pm860x = {
 	.reg_cache_size	= REG_CACHE_SIZE,
 	.reg_word_size	= sizeof(u8),
 	.set_bias_level	= pm860x_set_bias_level,
+
+	.controls = pm860x_snd_controls,
+	.num_controls = ARRAY_SIZE(pm860x_snd_controls),
+	.dapm_widgets = pm860x_dapm_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(pm860x_dapm_widgets),
+	.dapm_routes = pm860x_dapm_routes,
+	.num_dapm_routes = ARRAY_SIZE(pm860x_dapm_routes),
 };
 
 static int __devinit pm860x_codec_probe(struct platform_device *pdev)
-- 
1.7.5.4
