From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/3] ASoC: cs4270: Move regulator acquisition
	to I2C probe()
Date: Mon, 10 Sep 2012 12:58:44 +0800
Message-ID: <1347253125-8250-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1347253125-8250-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 884CC264F19
 for <alsa-devel@alsa-project.org>; Mon, 10 Sep 2012 07:01:17 +0200 (CEST)
In-Reply-To: <1347253125-8250-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>, Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

This is better style since it has us obtaining all resources before we
try the ASoC probe. This change also fixes a potential issue where we
don't enable the regulators before trying to confirm the device ID which
could cause a failure during probe in some system configurations.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/cs4270.c |   46 +++++++++++++++++++--------------------------
 1 file changed, 19 insertions(+), 27 deletions(-)

diff --git a/sound/soc/codecs/cs4270.c b/sound/soc/codecs/cs4270.c
index c6e5a73..64c29b8 100644
--- a/sound/soc/codecs/cs4270.c
+++ b/sound/soc/codecs/cs4270.c
@@ -487,7 +487,7 @@ static struct snd_soc_dai_driver cs4270_dai = {
 static int cs4270_probe(struct snd_soc_codec *codec)
 {
 	struct cs4270_private *cs4270 = snd_soc_codec_get_drvdata(codec);
-	int i, ret;
+	int ret;
 
 	/* Tell ASoC what kind of I/O to use to read the registers.  ASoC will
 	 * then do the I2C transactions itself.
@@ -521,25 +521,8 @@ static int cs4270_probe(struct snd_soc_codec *codec)
 		return ret;
 	}
 
-	/* get the power supply regulators */
-	for (i = 0; i < ARRAY_SIZE(supply_names); i++)
-		cs4270->supplies[i].supply = supply_names[i];
-
-	ret = regulator_bulk_get(codec->dev, ARRAY_SIZE(cs4270->supplies),
-				 cs4270->supplies);
-	if (ret < 0)
-		return ret;
-
 	ret = regulator_bulk_enable(ARRAY_SIZE(cs4270->supplies),
 				    cs4270->supplies);
-	if (ret < 0)
-		goto error_free_regulators;
-
-	return 0;
-
-error_free_regulators:
-	regulator_bulk_free(ARRAY_SIZE(cs4270->supplies),
-			    cs4270->supplies);
 
 	return ret;
 }
@@ -555,7 +538,6 @@ static int cs4270_remove(struct snd_soc_codec *codec)
 	struct cs4270_private *cs4270 = snd_soc_codec_get_drvdata(codec);
 
 	regulator_bulk_disable(ARRAY_SIZE(cs4270->supplies), cs4270->supplies);
-	regulator_bulk_free(ARRAY_SIZE(cs4270->supplies), cs4270->supplies);
 
 	return 0;
 };
@@ -658,7 +640,24 @@ static int cs4270_i2c_probe(struct i2c_client *i2c_client,
 {
 	struct device_node *np = i2c_client->dev.of_node;
 	struct cs4270_private *cs4270;
-	int ret;
+	int ret, i;
+
+	cs4270 = devm_kzalloc(&i2c_client->dev, sizeof(struct cs4270_private),
+			      GFP_KERNEL);
+	if (!cs4270) {
+		dev_err(&i2c_client->dev, "could not allocate codec\n");
+		return -ENOMEM;
+	}
+
+	/* get the power supply regulators */
+	for (i = 0; i < ARRAY_SIZE(supply_names); i++)
+		cs4270->supplies[i].supply = supply_names[i];
+
+	ret = devm_regulator_bulk_get(&i2c_client->dev,
+				      ARRAY_SIZE(cs4270->supplies),
+				      cs4270->supplies);
+	if (ret < 0)
+		return ret;
 
 	/* See if we have a way to bring the codec out of reset */
 	if (np) {
@@ -694,13 +693,6 @@ static int cs4270_i2c_probe(struct i2c_client *i2c_client,
 		i2c_client->addr);
 	dev_info(&i2c_client->dev, "hardware revision %X\n", ret & 0xF);
 
-	cs4270 = devm_kzalloc(&i2c_client->dev, sizeof(struct cs4270_private),
-			      GFP_KERNEL);
-	if (!cs4270) {
-		dev_err(&i2c_client->dev, "could not allocate codec\n");
-		return -ENOMEM;
-	}
-
 	i2c_set_clientdata(i2c_client, cs4270);
 	cs4270->control_type = SND_SOC_I2C;
 
-- 
1.7.10.4
