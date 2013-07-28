From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/2] ASoC: lm4857: Use table based setup for
	DAPM and controls
Date: Sun, 28 Jul 2013 18:45:28 +0200
Message-ID: <1375029929-19036-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-015.synserver.de (smtp-out-015.synserver.de
 [212.40.185.15])
 by alsa0.perex.cz (Postfix) with ESMTP id D24C7261738
 for <alsa-devel@alsa-project.org>; Sun, 28 Jul 2013 18:44:37 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

Let the ASoC core take care of registering the DAPM widget and routes as well as
the controls. This makes the code a bit shorter.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/lm4857.c | 26 +++++++-------------------
 1 file changed, 7 insertions(+), 19 deletions(-)

diff --git a/sound/soc/codecs/lm4857.c b/sound/soc/codecs/lm4857.c
index 9f9f595..5ea2ed0 100644
--- a/sound/soc/codecs/lm4857.c
+++ b/sound/soc/codecs/lm4857.c
@@ -174,28 +174,9 @@ static const struct snd_soc_dapm_route lm4857_routes[] = {
 static int lm4857_probe(struct snd_soc_codec *codec)
 {
 	struct lm4857 *lm4857 = snd_soc_codec_get_drvdata(codec);
-	struct snd_soc_dapm_context *dapm = &codec->dapm;
-	int ret;
 
 	codec->control_data = lm4857->i2c;
 
-	ret = snd_soc_add_codec_controls(codec, lm4857_controls,
-			ARRAY_SIZE(lm4857_controls));
-	if (ret)
-		return ret;
-
-	ret = snd_soc_dapm_new_controls(dapm, lm4857_dapm_widgets,
-			ARRAY_SIZE(lm4857_dapm_widgets));
-	if (ret)
-		return ret;
-
-	ret = snd_soc_dapm_add_routes(dapm, lm4857_routes,
-			ARRAY_SIZE(lm4857_routes));
-	if (ret)
-		return ret;
-
-	snd_soc_dapm_new_widgets(dapm);
-
 	return 0;
 }
 
@@ -207,6 +188,13 @@ static struct snd_soc_codec_driver soc_codec_dev_lm4857 = {
 	.reg_word_size = sizeof(uint8_t),
 	.reg_cache_default = lm4857_default_regs,
 	.set_bias_level = lm4857_set_bias_level,
+
+	.controls = lm4857_controls,
+	.num_controls = ARRAY_SIZE(lm4857_controls),
+	.dapm_widgets = lm4857_dapm_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(lm4857_dapm_widgets),
+	.dapm_routes = lm4857_routes,
+	.num_dapm_routes = ARRAY_SIZE(lm4857_routes),
 };
 
 static int lm4857_i2c_probe(struct i2c_client *i2c,
-- 
1.8.0
