From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] ASoC: tas2552: Use devm_gpiod_get_optional for
	enable-gpio
Date: Wed, 10 Jun 2015 22:46:05 +0800
Message-ID: <1433947565.19912.1.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f171.google.com (mail-pd0-f171.google.com
 [209.85.192.171])
 by alsa0.perex.cz (Postfix) with ESMTP id 26817265982
 for <alsa-devel@alsa-project.org>; Wed, 10 Jun 2015 16:46:11 +0200 (CEST)
Received: by pdjn11 with SMTP id n11so39421750pdj.0
 for <alsa-devel@alsa-project.org>; Wed, 10 Jun 2015 07:46:10 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Dan Murphy <dmurphy@ti.com>
List-Id: alsa-devel@alsa-project.org

commit ea178d1456dc ("ASoC: tas2552: Make the enable-gpio really optional")
makes enable-gpio optional. devm_gpiod_get_optional() is the better
function for optional gpio, so let's switch to use it.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 sound/soc/codecs/tas2552.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/tas2552.c b/sound/soc/codecs/tas2552.c
index 169a703..4f25a7d 100644
--- a/sound/soc/codecs/tas2552.c
+++ b/sound/soc/codecs/tas2552.c
@@ -703,13 +703,10 @@ static int tas2552_probe(struct i2c_client *client,
 	if (data == NULL)
 		return -ENOMEM;
 
-	data->enable_gpio = devm_gpiod_get(dev, "enable", GPIOD_OUT_LOW);
-	if (IS_ERR(data->enable_gpio)) {
-		if (PTR_ERR(data->enable_gpio) == -EPROBE_DEFER)
-			return -EPROBE_DEFER;
-
-		data->enable_gpio = NULL;
-	}
+	data->enable_gpio = devm_gpiod_get_optional(dev, "enable",
+						    GPIOD_OUT_LOW);
+	if (IS_ERR(data->enable_gpio))
+		return PTR_ERR(data->enable_gpio);
 
 	data->tas2552_client = client;
 	data->regmap = devm_regmap_init_i2c(client, &tas2552_regmap_config);
-- 
2.1.0
