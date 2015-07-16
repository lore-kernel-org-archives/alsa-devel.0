From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 4/4] ASoC: max9768: Convert to component
Date: Thu, 16 Jul 2015 21:22:52 +0200
Message-ID: <1437074572-3831-4-git-send-email-lars@metafoo.de>
References: <1437074572-3831-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-036.synserver.de (smtp-out-036.synserver.de
 [212.40.185.36])
 by alsa0.perex.cz (Postfix) with ESMTP id 80E6F2605C4
 for <alsa-devel@alsa-project.org>; Thu, 16 Jul 2015 21:22:59 +0200 (CEST)
In-Reply-To: <1437074572-3831-1-git-send-email-lars@metafoo.de>
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

The driver does not use any CODEC specific constructs anymore. Convert it
to snd_soc_component.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/max9768.c | 31 ++++++++++++-------------------
 1 file changed, 12 insertions(+), 19 deletions(-)

diff --git a/sound/soc/codecs/max9768.c b/sound/soc/codecs/max9768.c
index 381ff8a..bd41128 100644
--- a/sound/soc/codecs/max9768.c
+++ b/sound/soc/codecs/max9768.c
@@ -43,8 +43,8 @@ static const struct reg_default max9768_default_regs[] = {
 static int max9768_get_gpio(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
-	struct max9768 *max9768 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *c = snd_soc_kcontrol_component(kcontrol);
+	struct max9768 *max9768 = snd_soc_component_get_drvdata(c);
 	int val = gpio_get_value_cansleep(max9768->mute_gpio);
 
 	ucontrol->value.integer.value[0] = !val;
@@ -55,8 +55,8 @@ static int max9768_get_gpio(struct snd_kcontrol *kcontrol,
 static int max9768_set_gpio(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
-	struct max9768 *max9768 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *c = snd_soc_kcontrol_component(kcontrol);
+	struct max9768 *max9768 = snd_soc_component_get_drvdata(c);
 
 	gpio_set_value_cansleep(max9768->mute_gpio, !ucontrol->value.integer.value[0]);
 
@@ -130,19 +130,20 @@ static const struct snd_soc_dapm_route max9768_dapm_routes[] = {
 	{ "OUT-", NULL, "IN" },
 };
 
-static int max9768_probe(struct snd_soc_codec *codec)
+static int max9768_probe(struct snd_soc_component *component)
 {
-	struct max9768 *max9768 = snd_soc_codec_get_drvdata(codec);
+	struct max9768 *max9768 = snd_soc_component_get_drvdata(component);
 	int ret;
 
 	if (max9768->flags & MAX9768_FLAG_CLASSIC_PWM) {
-		ret = snd_soc_write(codec, MAX9768_CTRL, MAX9768_CTRL_PWM);
+		ret = regmap_write(max9768->regmap, MAX9768_CTRL,
+			MAX9768_CTRL_PWM);
 		if (ret)
 			return ret;
 	}
 
 	if (gpio_is_valid(max9768->mute_gpio)) {
-		ret = snd_soc_add_codec_controls(codec, max9768_mute,
+		ret = snd_soc_add_component_controls(component, max9768_mute,
 				ARRAY_SIZE(max9768_mute));
 		if (ret)
 			return ret;
@@ -151,7 +152,7 @@ static int max9768_probe(struct snd_soc_codec *codec)
 	return 0;
 }
 
-static struct snd_soc_codec_driver max9768_codec_driver = {
+static struct snd_soc_component_driver max9768_component_driver = {
 	.probe = max9768_probe,
 	.controls = max9768_volume,
 	.num_controls = ARRAY_SIZE(max9768_volume),
@@ -204,15 +205,8 @@ static int max9768_i2c_probe(struct i2c_client *client,
 	if (IS_ERR(max9768->regmap))
 		return PTR_ERR(max9768->regmap);
 
-	return snd_soc_register_codec(&client->dev, &max9768_codec_driver,
-		NULL, 0);
-}
-
-static int max9768_i2c_remove(struct i2c_client *client)
-{
-	snd_soc_unregister_codec(&client->dev);
-
-	return 0;
+	return devm_snd_soc_register_component(&client->dev,
+		&max9768_component_driver, NULL, 0);
 }
 
 static const struct i2c_device_id max9768_i2c_id[] = {
@@ -226,7 +220,6 @@ static struct i2c_driver max9768_i2c_driver = {
 		.name = "max9768",
 	},
 	.probe = max9768_i2c_probe,
-	.remove = max9768_i2c_remove,
 	.id_table = max9768_i2c_id,
 };
 module_i2c_driver(max9768_i2c_driver);
-- 
2.1.4
