From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH] ALSA: ASoC: cs4271: free allocated GPIO
Date: Wed,  7 Nov 2012 14:15:55 +0100
Message-ID: <1352294155-6733-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
 by alsa0.perex.cz (Postfix) with ESMTP id 8990F265015
 for <alsa-devel@alsa-project.org>; Wed,  7 Nov 2012 14:16:04 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: broonie@opensource.wolfsonmicro.com, Alexander Sverdlin <subaparts@yandex.ru>, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

In case of probe deferral, the allocated GPIO line is not freed, which
prevents it from being claimed and properly asserted in later attempts.

Fix this by freeing the GPIO in case of errors.

Signed-off-by: Daniel Mack <zonque@gmail.com>
Reported-by: Michael Hirsch <hirsch@teufel.de>
Cc: Alexander Sverdlin <subaparts@yandex.ru>
---
 sound/soc/codecs/cs4271.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/cs4271.c b/sound/soc/codecs/cs4271.c
index e5a7ea4..ea57014 100644
--- a/sound/soc/codecs/cs4271.c
+++ b/sound/soc/codecs/cs4271.c
@@ -505,7 +505,7 @@ static int cs4271_probe(struct snd_soc_codec *codec)
 		ret = regulator_enable(cs4271->vd_supply);
 		if (ret < 0) {
 			dev_err(codec->dev, "unable to enable regulator\n");
-			return ret;
+			goto err;
 		}
 	}
 
@@ -548,22 +548,31 @@ static int cs4271_probe(struct snd_soc_codec *codec)
 			cs4271->bus_type);
 	if (ret) {
 		dev_err(codec->dev, "Failed to set cache I/O: %d\n", ret);
-		return ret;
+		goto err_free_gpio;
 	}
 
 	ret = snd_soc_update_bits(codec, CS4271_MODE2,
 				  CS4271_MODE2_PDN | CS4271_MODE2_CPEN,
 				  CS4271_MODE2_PDN | CS4271_MODE2_CPEN);
 	if (ret < 0)
-		return ret;
+		goto err_free_gpio;
 	ret = snd_soc_update_bits(codec, CS4271_MODE2, CS4271_MODE2_PDN, 0);
 	if (ret < 0)
-		return ret;
+		goto err_free_gpio;
 	/* Power-up sequence requires 85 uS */
 	udelay(85);
 
 	return snd_soc_add_codec_controls(codec, cs4271_snd_controls,
 		ARRAY_SIZE(cs4271_snd_controls));
+
+err_free_gpio:
+	if (gpio_is_valid(cs4271->gpio_nreset))
+		gpio_free(cs4271->gpio_nreset);
+
+	cs4271->gpio_nreset = -EINVAL;
+
+err:
+	return ret;
 }
 
 static int cs4271_remove(struct snd_soc_codec *codec)
-- 
1.7.11.7
