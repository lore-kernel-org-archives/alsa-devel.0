From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [PATCHv2 4/4] ASoC: tlv320aic3x: Let the codec hit
	SND_SOC_BIAS_OFF when idle
Date: Mon, 20 Sep 2010 10:39:14 +0300
Message-ID: <1284968354-12536-5-git-send-email-jhnikula@gmail.com>
References: <1284968354-12536-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51])
	by alsa0.perex.cz (Postfix) with ESMTP id B4CDE103818
	for <alsa-devel@alsa-project.org>;
	Mon, 20 Sep 2010 09:39:31 +0200 (CEST)
Received: by mail-ew0-f51.google.com with SMTP id 21so1641974ewy.38
	for <alsa-devel@alsa-project.org>; Mon, 20 Sep 2010 00:39:31 -0700 (PDT)
In-Reply-To: <1284968354-12536-1-git-send-email-jhnikula@gmail.com>
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

Now codec hits the SND_SOC_BIAS_OFF also when it is idle. This is also
the default state after probing and codec is left unconfigured and
unpowered by default. Initialization will happen when the bias state changes
and aic3x_set_power does power-up and cache sync.

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
---
 sound/soc/codecs/tlv320aic3x.c |   20 ++------------------
 1 files changed, 2 insertions(+), 18 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index 5356946..fc68779 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -1341,9 +1341,6 @@ static int aic3x_init(struct snd_soc_codec *codec)
 		snd_soc_write(codec, CLASSD_CTRL, 0);
 	}
 
-	/* off, with power on */
-	aic3x_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
-
 	return 0;
 }
 
@@ -1354,6 +1351,7 @@ static int aic3x_probe(struct snd_soc_codec *codec)
 
 	codec->control_data = aic3x->control_data;
 	aic3x->codec = codec;
+	codec->idle_bias_off = 1;
 
 	ret = snd_soc_codec_set_cache_io(codec, 8, 8, aic3x->control_type);
 	if (ret != 0) {
@@ -1390,19 +1388,7 @@ static int aic3x_probe(struct snd_soc_codec *codec)
 		}
 	}
 
-	ret = regulator_bulk_enable(ARRAY_SIZE(aic3x->supplies),
-				    aic3x->supplies);
-	if (ret != 0) {
-		dev_err(codec->dev, "Failed to enable supplies: %d\n", ret);
-		goto err_enable;
-	}
-	aic3x->power = 1;
-
-	if (aic3x->gpio_reset >= 0) {
-		udelay(1);
-		gpio_set_value(aic3x->gpio_reset, 1);
-	}
-
+	codec->cache_only = 1;
 	aic3x_init(codec);
 
 	if (aic3x->setup) {
@@ -1422,7 +1408,6 @@ static int aic3x_probe(struct snd_soc_codec *codec)
 
 	return 0;
 
-err_enable:
 err_notif:
 	while (i--)
 		regulator_unregister_notifier(aic3x->supplies[i].consumer,
@@ -1446,7 +1431,6 @@ static int aic3x_remove(struct snd_soc_codec *codec)
 		gpio_set_value(aic3x->gpio_reset, 0);
 		gpio_free(aic3x->gpio_reset);
 	}
-	regulator_bulk_disable(ARRAY_SIZE(aic3x->supplies), aic3x->supplies);
 	for (i = 0; i < ARRAY_SIZE(aic3x->supplies); i++)
 		regulator_unregister_notifier(aic3x->supplies[i].consumer,
 					      &aic3x->disable_nb[i].nb);
-- 
1.7.1
