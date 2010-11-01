From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [PATCH 1/2] ASoC: tlv320aic3x: Use gpio_is_valid in
	checking for valid gpio_reset
Date: Mon,  1 Nov 2010 14:03:55 +0200
Message-ID: <1288613036-13169-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id F2EB31037FB
	for <alsa-devel@alsa-project.org>; Mon,  1 Nov 2010 13:04:00 +0100 (CET)
Received: by eyg24 with SMTP id 24so2819914eyg.38
	for <alsa-devel@alsa-project.org>; Mon, 01 Nov 2010 05:04:00 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

I promised to convert this at some point.

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
---
 sound/soc/codecs/tlv320aic3x.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index fc68779..157b534 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -1075,7 +1075,7 @@ static int aic3x_regulator_event(struct notifier_block *nb,
 		 * Put codec to reset and require cache sync as at least one
 		 * of the supplies was disabled
 		 */
-		if (aic3x->gpio_reset >= 0)
+		if (gpio_is_valid(aic3x->gpio_reset))
 			gpio_set_value(aic3x->gpio_reset, 0);
 		aic3x->codec->cache_sync = 1;
 	}
@@ -1102,7 +1102,7 @@ static int aic3x_set_power(struct snd_soc_codec *codec, int power)
 		if (!codec->cache_sync)
 			goto out;
 
-		if (aic3x->gpio_reset >= 0) {
+		if (gpio_is_valid(aic3x->gpio_reset)) {
 			udelay(1);
 			gpio_set_value(aic3x->gpio_reset, 1);
 		}
@@ -1359,7 +1359,7 @@ static int aic3x_probe(struct snd_soc_codec *codec)
 		return ret;
 	}
 
-	if (aic3x->gpio_reset >= 0) {
+	if (gpio_is_valid(aic3x->gpio_reset)) {
 		ret = gpio_request(aic3x->gpio_reset, "tlv320aic3x reset");
 		if (ret != 0)
 			goto err_gpio;
@@ -1414,7 +1414,7 @@ err_notif:
 					      &aic3x->disable_nb[i].nb);
 	regulator_bulk_free(ARRAY_SIZE(aic3x->supplies), aic3x->supplies);
 err_get:
-	if (aic3x->gpio_reset >= 0)
+	if (gpio_is_valid(aic3x->gpio_reset))
 		gpio_free(aic3x->gpio_reset);
 err_gpio:
 	kfree(aic3x);
@@ -1427,7 +1427,7 @@ static int aic3x_remove(struct snd_soc_codec *codec)
 	int i;
 
 	aic3x_set_bias_level(codec, SND_SOC_BIAS_OFF);
-	if (aic3x->gpio_reset >= 0) {
+	if (gpio_is_valid(aic3x->gpio_reset)) {
 		gpio_set_value(aic3x->gpio_reset, 0);
 		gpio_free(aic3x->gpio_reset);
 	}
-- 
1.7.2.3
