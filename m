From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH] ALSA: ASoC: cs4271: free allocated GPIO
Date: Sat, 10 Nov 2012 19:52:50 +0100
Message-ID: <1352573570-23671-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
 by alsa0.perex.cz (Postfix) with ESMTP id 833A3261604
 for <alsa-devel@alsa-project.org>; Sat, 10 Nov 2012 19:52:57 +0100 (CET)
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

Fix this by using devm_gpio_request().

Signed-off-by: Daniel Mack <zonque@gmail.com>
Reported-by: Michael Hirsch <hirsch@teufel.de>
Cc: Alexander Sverdlin <subaparts@yandex.ru>
---
 sound/soc/codecs/cs4271.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/cs4271.c b/sound/soc/codecs/cs4271.c
index f994af3..e3f0a7f 100644
--- a/sound/soc/codecs/cs4271.c
+++ b/sound/soc/codecs/cs4271.c
@@ -485,7 +485,7 @@ static int cs4271_probe(struct snd_soc_codec *codec)
 		gpio_nreset = cs4271plat->gpio_nreset;
 
 	if (gpio_nreset >= 0)
-		if (gpio_request(gpio_nreset, "CS4271 Reset"))
+		if (devm_gpio_request(codec->dev, gpio_nreset, "CS4271 Reset"))
 			gpio_nreset = -EINVAL;
 	if (gpio_nreset >= 0) {
 		/* Reset codec */
@@ -535,15 +535,10 @@ static int cs4271_probe(struct snd_soc_codec *codec)
 static int cs4271_remove(struct snd_soc_codec *codec)
 {
 	struct cs4271_private *cs4271 = snd_soc_codec_get_drvdata(codec);
-	int gpio_nreset;
 
-	gpio_nreset = cs4271->gpio_nreset;
-
-	if (gpio_is_valid(gpio_nreset)) {
+	if (gpio_is_valid(cs4271->gpio_nreset))
 		/* Set codec to the reset state */
-		gpio_set_value(gpio_nreset, 0);
-		gpio_free(gpio_nreset);
-	}
+		gpio_set_value(cs4271->gpio_nreset, 0);
 
 	return 0;
 };
-- 
1.7.11.7
