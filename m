From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 7/7] ASoC: Push wm8978 reset down into the I2C
	probe
Date: Thu, 29 Dec 2011 11:49:15 +0000
Message-ID: <1325159355-31686-7-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1325159355-31686-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C4B3A103870
	for <alsa-devel@alsa-project.org>; Thu, 29 Dec 2011 12:49:26 +0100 (CET)
In-Reply-To: <1325159355-31686-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Ensures that we get control of the CODEC earlier and don't try to probe
the card at all if register I/O isn't working.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8978.c |   22 +++++++++++++++-------
 1 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/wm8978.c b/sound/soc/codecs/wm8978.c
index 5ff8734d..72d5fdc 100644
--- a/sound/soc/codecs/wm8978.c
+++ b/sound/soc/codecs/wm8978.c
@@ -1000,13 +1000,6 @@ static int wm8978_probe(struct snd_soc_codec *codec)
 	for (i = 0; i < ARRAY_SIZE(update_reg); i++)
 		snd_soc_update_bits(codec, update_reg[i], 0x100, 0x100);
 
-	/* Reset the codec */
-	ret = snd_soc_write(codec, WM8978_RESET, 0);
-	if (ret < 0) {
-		dev_err(codec->dev, "Failed to issue reset\n");
-		return ret;
-	}
-
 	wm8978_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
 
 	return 0;
@@ -1066,9 +1059,24 @@ static __devinit int wm8978_i2c_probe(struct i2c_client *i2c,
 
 	i2c_set_clientdata(i2c, wm8978);
 
+	/* Reset the codec */
+	ret = regmap_write(wm8978->regmap, WM8978_RESET, 0);
+	if (ret != 0) {
+		dev_err(&i2c->dev, "Failed to issue reset: %d\n", ret);
+		goto err;
+	}
+
 	ret = snd_soc_register_codec(&i2c->dev,
 			&soc_codec_dev_wm8978, &wm8978_dai, 1);
+	if (ret != 0) {
+		dev_err(&i2c->dev, "Failed to register CODEC: %d\n", ret);
+		goto err;
+	}
 
+	return 0;
+
+err:
+	regmap_exit(wm8978->regmap);
 	return ret;
 }
 
-- 
1.7.7.3
