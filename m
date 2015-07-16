From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: max9768: Convert to component" to the
	asoc tree
Date: Thu, 16 Jul 2015 22:01:31 +0100
Message-ID: <E1ZFqHb-0001k2-PE@finisterre>
References: <1437074572-3831-4-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 0BB9D2666FF
 for <alsa-devel@alsa-project.org>; Thu, 16 Jul 2015 23:01:41 +0200 (CEST)
In-Reply-To: <1437074572-3831-4-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: max9768: Convert to component

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 04b5cbd80af899c6a4d51835b069b96ae8864e5a Mon Sep 17 00:00:00 2001
From: Lars-Peter Clausen <lars@metafoo.de>
Date: Thu, 16 Jul 2015 21:22:52 +0200
Subject: [PATCH] ASoC: max9768: Convert to component

The driver does not use any CODEC specific constructs anymore. Convert it
to snd_soc_component.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/max9768.c | 31 ++++++++++++-------------------
 1 file changed, 12 insertions(+), 19 deletions(-)

diff --git a/sound/soc/codecs/max9768.c b/sound/soc/codecs/max9768.c
index d70a820..4c300f3 100644
--- a/sound/soc/codecs/max9768.c
+++ b/sound/soc/codecs/max9768.c
@@ -43,8 +43,8 @@ static struct reg_default max9768_default_regs[] = {
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
