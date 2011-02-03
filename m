From: Alexander Sverdlin <subaparts@yandex.ru>
Subject: [PATCH] ASoC: CS4271: Move Chip Select control out of
 the CODEC code.
Date: Thu, 03 Feb 2011 03:11:45 +0300
Message-ID: <1296691905.1504.47.camel@r60e>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from forward4.mail.yandex.net (forward4.mail.yandex.net [77.88.46.9])
	by alsa0.perex.cz (Postfix) with ESMTP id 4C9CE24465
	for <alsa-devel@alsa-project.org>; Thu,  3 Feb 2011 01:11:56 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Dimitris Papastamos <dp@opens>
Cc: H Hartley Sweeten <hsweeten@visionengravers.com>, Lennert Buytenhek <buytenh@wantstofly.org>
List-Id: alsa-devel@alsa-project.org

From: Alexander Sverdlin <subaparts@yandex.ru>

Move Chip Select control out of the CODEC code for CS4271.
        
Signed-off-by: Alexander Sverdlin <subaparts@yandex.ru>
---
 include/sound/cs4271.h    |    1 -
 sound/soc/codecs/cs4271.c |   22 +++-------------------
 2 files changed, 3 insertions(+), 20 deletions(-)

diff --git a/include/sound/cs4271.h b/include/sound/cs4271.h
index 16f8d32..50a059e 100644
--- a/include/sound/cs4271.h
+++ b/include/sound/cs4271.h
@@ -19,7 +19,6 @@
 
 struct cs4271_platform_data {
 	int gpio_nreset;	/* GPIO driving Reset pin, if any */
-	int gpio_disable;	/* GPIO that disable serial bus, if any */
 };
 
 #endif /* __CS4271_H */
diff --git a/sound/soc/codecs/cs4271.c b/sound/soc/codecs/cs4271.c
index 9c5b7db..1791796 100644
--- a/sound/soc/codecs/cs4271.c
+++ b/sound/soc/codecs/cs4271.c
@@ -441,22 +441,11 @@ static int cs4271_probe(struct snd_soc_codec *codec)
 	struct cs4271_platform_data *cs4271plat = codec->dev->platform_data;
 	int ret;
 	int gpio_nreset = -EINVAL;
-	int gpio_disable = -EINVAL;
 
 	codec->control_data = cs4271->control_data;
 
-	if (cs4271plat) {
-		if (gpio_is_valid(cs4271plat->gpio_nreset))
-			gpio_nreset = cs4271plat->gpio_nreset;
-		if (gpio_is_valid(cs4271plat->gpio_disable))
-			gpio_disable = cs4271plat->gpio_disable;
-	}
-
-	if (gpio_disable >= 0)
-		if (gpio_request(gpio_disable, "CS4271 Disable"))
-			gpio_disable = -EINVAL;
-	if (gpio_disable >= 0)
-		gpio_direction_output(gpio_disable, 0);
+	if (cs4271plat && gpio_is_valid(cs4271plat->gpio_nreset))
+		gpio_nreset = cs4271plat->gpio_nreset;
 
 	if (gpio_nreset >= 0)
 		if (gpio_request(gpio_nreset, "CS4271 Reset"))
@@ -471,7 +460,6 @@ static int cs4271_probe(struct snd_soc_codec *codec)
 	}
 
 	cs4271->gpio_nreset = gpio_nreset;
-	cs4271->gpio_disable = gpio_disable;
 
 	/*
 	 * In case of I2C, chip address specified in board data.
@@ -509,10 +497,9 @@ static int cs4271_probe(struct snd_soc_codec *codec)
 static int cs4271_remove(struct snd_soc_codec *codec)
 {
 	struct cs4271_private *cs4271 = snd_soc_codec_get_drvdata(codec);
-	int gpio_nreset, gpio_disable;
+	int gpio_nreset;
 
 	gpio_nreset = cs4271->gpio_nreset;
-	gpio_disable = cs4271->gpio_disable;
 
 	if (gpio_is_valid(gpio_nreset)) {
 		/* Set codec to the reset state */
@@ -520,9 +507,6 @@ static int cs4271_remove(struct snd_soc_codec *codec)
 		gpio_free(gpio_nreset);
 	}
 
-	if (gpio_is_valid(gpio_disable))
-		gpio_free(gpio_disable);
-
 	return 0;
 };
