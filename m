From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [PATCH 4/4] ASoC: tlv320aic3x: Let the codec hit
	SND_SOC_BIAS_OFF when idle
Date: Fri, 10 Sep 2010 14:23:32 +0300
Message-ID: <1284117812-8618-4-git-send-email-jhnikula@gmail.com>
References: <1284117812-8618-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 65031103982
	for <alsa-devel@alsa-project.org>;
	Fri, 10 Sep 2010 13:22:53 +0200 (CEST)
Received: by mail-ey0-f179.google.com with SMTP id 27so543647eye.38
	for <alsa-devel@alsa-project.org>; Fri, 10 Sep 2010 04:22:53 -0700 (PDT)
In-Reply-To: <1284117812-8618-1-git-send-email-jhnikula@gmail.com>
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

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
---
 sound/soc/codecs/tlv320aic3x.c |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index d269ccf..291111d 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -1359,9 +1359,6 @@ static int aic3x_init(struct snd_soc_codec *codec)
 		aic3x_write(codec, CLASSD_CTRL, 0);
 	}
 
-	/* off, with power on */
-	aic3x_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
-
 	return 0;
 }
 
@@ -1383,6 +1380,9 @@ static int aic3x_probe(struct snd_soc_codec *codec)
 			    (aic3x->setup->gpio_func[1] & 0xf) << 4);
 	}
 
+	codec->idle_bias_off = 1;
+	aic3x_set_bias_level(codec, SND_SOC_BIAS_OFF);
+
 	snd_soc_add_controls(codec, aic3x_snd_controls,
 			     ARRAY_SIZE(aic3x_snd_controls));
 	if (aic3x->model == AIC3X_MODEL_3007)
@@ -1530,7 +1530,9 @@ static int aic3x_i2c_remove(struct i2c_client *client)
 		gpio_set_value(aic3x->gpio_reset, 0);
 		gpio_free(aic3x->gpio_reset);
 	}
-	regulator_bulk_disable(ARRAY_SIZE(aic3x->supplies), aic3x->supplies);
+	if (aic3x->power)
+		regulator_bulk_disable(ARRAY_SIZE(aic3x->supplies),
+				       aic3x->supplies);
 	for (i = 0; i < ARRAY_SIZE(aic3x->supplies); i++)
 		regulator_unregister_notifier(aic3x->supplies[i].consumer,
 					      &aic3x->disable_nb[i].nb);
-- 
1.7.1
