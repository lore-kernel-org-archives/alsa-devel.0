From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 4/4] ASoC: lm4857: Convert to component
Date: Fri,  1 May 2015 18:02:45 +0200
Message-ID: <1430496165-13917-4-git-send-email-lars@metafoo.de>
References: <1430496165-13917-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-014.synserver.de (smtp-out-017.synserver.de
 [212.40.185.17])
 by alsa0.perex.cz (Postfix) with ESMTP id B3B1D2605E5
 for <alsa-devel@alsa-project.org>; Fri,  1 May 2015 19:15:52 +0200 (CEST)
In-Reply-To: <1430496165-13917-1-git-send-email-lars@metafoo.de>
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
Cc: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Lars-Peter Clausen <lars@metafoo.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The driver does not use any CODEC specific constructs anymore. Convert it
to snd_soc_component.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/lm4857.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/sound/soc/codecs/lm4857.c b/sound/soc/codecs/lm4857.c
index dac9165..99ffc49 100644
--- a/sound/soc/codecs/lm4857.c
+++ b/sound/soc/codecs/lm4857.c
@@ -100,7 +100,7 @@ static const struct snd_soc_dapm_route lm4857_routes[] = {
 	{ "EP", "Earpiece", "Mode" },
 };
 
-static struct snd_soc_codec_driver soc_codec_dev_lm4857 = {
+static struct snd_soc_component_driver lm4857_component_driver = {
 	.controls = lm4857_controls,
 	.num_controls = ARRAY_SIZE(lm4857_controls),
 	.dapm_widgets = lm4857_dapm_widgets,
@@ -129,13 +129,8 @@ static int lm4857_i2c_probe(struct i2c_client *i2c,
 	if (IS_ERR(regmap))
 		return PTR_ERR(regmap);
 
-	return snd_soc_register_codec(&i2c->dev, &soc_codec_dev_lm4857, NULL, 0);
-}
-
-static int lm4857_i2c_remove(struct i2c_client *i2c)
-{
-	snd_soc_unregister_codec(&i2c->dev);
-	return 0;
+	return devm_snd_soc_register_component(&i2c->dev,
+		&lm4857_component_driver, NULL, 0);
 }
 
 static const struct i2c_device_id lm4857_i2c_id[] = {
@@ -150,7 +145,6 @@ static struct i2c_driver lm4857_i2c_driver = {
 		.owner = THIS_MODULE,
 	},
 	.probe = lm4857_i2c_probe,
-	.remove = lm4857_i2c_remove,
 	.id_table = lm4857_i2c_id,
 };
 
-- 
1.8.0
