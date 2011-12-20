From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH] ASoC: Convert cs42l51 to table based DAPM and
	control init
Date: Tue, 20 Dec 2011 10:19:54 +0800
Message-ID: <1324347594.19384.4.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qw0-f51.google.com (mail-qw0-f51.google.com
	[209.85.216.51])
	by alsa0.perex.cz (Postfix) with ESMTP id AA72F1038E8
	for <alsa-devel@alsa-project.org>; Tue, 20 Dec 2011 03:20:01 +0100 (CET)
Received: by qadz3 with SMTP id z3so4026004qad.17
	for <alsa-devel@alsa-project.org>; Mon, 19 Dec 2011 18:20:00 -0800 (PST)
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
Cc: Lars-Peter Clausen <lars@metafoo.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Timur Tabi <timur@freescale.com>, Arnaud Patard <arnaud.patard@rtp-net.org>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/codecs/cs42l51.c |   17 ++++++++---------
 1 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/sound/soc/codecs/cs42l51.c b/sound/soc/codecs/cs42l51.c
index 528510b..ffce9f2 100644
--- a/sound/soc/codecs/cs42l51.c
+++ b/sound/soc/codecs/cs42l51.c
@@ -511,7 +511,6 @@ static struct snd_soc_dai_driver cs42l51_dai = {
 static int cs42l51_probe(struct snd_soc_codec *codec)
 {
 	struct cs42l51_private *cs42l51 = snd_soc_codec_get_drvdata(codec);
-	struct snd_soc_dapm_context *dapm = &codec->dapm;
 	int ret, reg;
 
 	ret = cs42l51_fill_cache(codec);
@@ -539,20 +538,20 @@ static int cs42l51_probe(struct snd_soc_codec *codec)
 	if (ret < 0)
 		return ret;
 
-	snd_soc_add_controls(codec, cs42l51_snd_controls,
-		ARRAY_SIZE(cs42l51_snd_controls));
-	snd_soc_dapm_new_controls(dapm, cs42l51_dapm_widgets,
-		ARRAY_SIZE(cs42l51_dapm_widgets));
-	snd_soc_dapm_add_routes(dapm, cs42l51_routes,
-		ARRAY_SIZE(cs42l51_routes));
-
 	return 0;
 }
 
 static struct snd_soc_codec_driver soc_codec_device_cs42l51 = {
-	.probe =	cs42l51_probe,
+	.probe = cs42l51_probe,
 	.reg_cache_size = CS42L51_NUMREGS + 1,
 	.reg_word_size = sizeof(u8),
+
+	.controls = cs42l51_snd_controls,
+	.num_controls = ARRAY_SIZE(cs42l51_snd_controls),
+	.dapm_widgets = cs42l51_dapm_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(cs42l51_dapm_widgets),
+	.dapm_routes = cs42l51_routes,
+	.num_dapm_routes = ARRAY_SIZE(cs42l51_routes),
 };
 
 static int cs42l51_i2c_probe(struct i2c_client *i2c_client,
-- 
1.7.5.4
