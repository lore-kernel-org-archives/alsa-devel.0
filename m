From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: max9877: Convert to component" to the
	asoc tree
Date: Thu, 16 Jul 2015 22:01:35 +0100
Message-ID: <E1ZFqHf-0001ky-3m@finisterre>
References: <1437074572-3831-2-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 3EFB2266705
 for <alsa-devel@alsa-project.org>; Thu, 16 Jul 2015 23:01:42 +0200 (CEST)
In-Reply-To: <1437074572-3831-2-git-send-email-lars@metafoo.de>
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

   ASoC: max9877: Convert to component

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

>From 623436af42ef2b37fee8f6058a85f4664bd32c74 Mon Sep 17 00:00:00 2001
From: Lars-Peter Clausen <lars@metafoo.de>
Date: Thu, 16 Jul 2015 21:22:50 +0200
Subject: [PATCH] ASoC: max9877: Convert to component

The driver does not use any CODEC specific constructs anymore. Convert it
to snd_soc_component.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/max9877.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/sound/soc/codecs/max9877.c b/sound/soc/codecs/max9877.c
index b469e1c8..fb448dd 100644
--- a/sound/soc/codecs/max9877.c
+++ b/sound/soc/codecs/max9877.c
@@ -121,7 +121,7 @@ static const struct snd_soc_dapm_route max9877_dapm_routes[] = {
 	{ "HPR", NULL, "SHDN" },
 };
 
-static const struct snd_soc_codec_driver max9877_codec = {
+static const struct snd_soc_component_driver max9877_component_driver = {
 	.controls = max9877_controls,
 	.num_controls = ARRAY_SIZE(max9877_controls),
 
@@ -154,14 +154,8 @@ static int max9877_i2c_probe(struct i2c_client *client,
 	for (i = 0; i < ARRAY_SIZE(max9877_regs); i++)
 		regmap_write(regmap, max9877_regs[i].reg, max9877_regs[i].def);
 
-	return snd_soc_register_codec(&client->dev, &max9877_codec, NULL, 0);
-}
-
-static int max9877_i2c_remove(struct i2c_client *client)
-{
-	snd_soc_unregister_codec(&client->dev);
-
-	return 0;
+	return devm_snd_soc_register_component(&client->dev,
+			&max9877_component_driver, NULL, 0);
 }
 
 static const struct i2c_device_id max9877_i2c_id[] = {
@@ -175,7 +169,6 @@ static struct i2c_driver max9877_i2c_driver = {
 		.name = "max9877",
 	},
 	.probe = max9877_i2c_probe,
-	.remove = max9877_i2c_remove,
 	.id_table = max9877_i2c_id,
 };
 
-- 
2.1.4
