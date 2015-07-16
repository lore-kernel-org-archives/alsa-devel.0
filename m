From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 2/4] ASoC: max9877: Convert to component
Date: Thu, 16 Jul 2015 21:22:50 +0200
Message-ID: <1437074572-3831-2-git-send-email-lars@metafoo.de>
References: <1437074572-3831-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-036.synserver.de (smtp-out-036.synserver.de
 [212.40.185.36])
 by alsa0.perex.cz (Postfix) with ESMTP id 86B912605B8
 for <alsa-devel@alsa-project.org>; Thu, 16 Jul 2015 21:22:58 +0200 (CEST)
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
 sound/soc/codecs/max9877.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/sound/soc/codecs/max9877.c b/sound/soc/codecs/max9877.c
index b469e1c..fb448dd 100644
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
