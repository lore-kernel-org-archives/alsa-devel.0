From: Wolfram Sang <w.sang@pengutronix.de>
Subject: [PATCH 1/3] ASoC: sgtl5000: refactor registering
	internal ldo
Date: Mon, 18 Jul 2011 17:53:03 +0200
Message-ID: <1311004385-14554-2-git-send-email-w.sang@pengutronix.de>
References: <1311004385-14554-1-git-send-email-w.sang@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 3025124679
	for <alsa-devel@alsa-project.org>;
	Mon, 18 Jul 2011 17:53:15 +0200 (CEST)
In-Reply-To: <1311004385-14554-1-git-send-email-w.sang@pengutronix.de>
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Dong Aisheng <b29396@freescale.com>, Zeng Zhaoming <b32542@freescale.com>, Wolfram Sang <w.sang@pengutronix.de>
List-Id: alsa-devel@alsa-project.org

The code for registering the internal ldo was present twice. Turn it
into a function instead. Also, inform the user if LDO is used now.

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
Cc: Dong Aisheng <b29396@freescale.com>
Cc: Zeng Zhaoming <b32542@freescale.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/sgtl5000.c |   69 +++++++++++++++++++-----------------------
 1 files changed, 31 insertions(+), 38 deletions(-)

diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
index ff29380..17af336 100644
--- a/sound/soc/codecs/sgtl5000.c
+++ b/sound/soc/codecs/sgtl5000.c
@@ -1218,6 +1218,34 @@ static int sgtl5000_set_power_regs(struct snd_soc_codec *codec)
 	return 0;
 }
 
+static int sgtl5000_replace_vddd_with_ldo(struct snd_soc_codec *codec)
+{
+	struct sgtl5000_priv *sgtl5000 = snd_soc_codec_get_drvdata(codec);
+	int ret;
+
+	/* set internal ldo to 1.2v */
+	ret = ldo_regulator_register(codec, &ldo_init_data, LDO_VOLTAGE);
+	if (ret) {
+		dev_err(codec->dev,
+			"Failed to register vddd internal supplies: %d\n", ret);
+		return ret;
+	}
+
+	sgtl5000->supplies[VDDD].supply = LDO_CONSUMER_NAME;
+
+	ret = regulator_bulk_get(codec->dev, ARRAY_SIZE(sgtl5000->supplies),
+			sgtl5000->supplies);
+
+	if (ret) {
+		ldo_regulator_remove(codec);
+		dev_err(codec->dev, "Failed to request supplies: %d\n", ret);
+		return ret;
+	}
+
+	dev_info(codec->dev, "Using internal LDO instead of VDDD\n");
+	return 0;
+}
+
 static int sgtl5000_enable_regulators(struct snd_soc_codec *codec)
 {
 	u16 reg;
@@ -1235,30 +1263,9 @@ static int sgtl5000_enable_regulators(struct snd_soc_codec *codec)
 	if (!ret)
 		external_vddd = 1;
 	else {
-		/* set internal ldo to 1.2v */
-		int voltage = LDO_VOLTAGE;
-
-		ret = ldo_regulator_register(codec, &ldo_init_data, voltage);
-		if (ret) {
-			dev_err(codec->dev,
-			"Failed to register vddd internal supplies: %d\n",
-				ret);
-			return ret;
-		}
-
-		sgtl5000->supplies[VDDD].supply = LDO_CONSUMER_NAME;
-
-		ret = regulator_bulk_get(codec->dev,
-				ARRAY_SIZE(sgtl5000->supplies),
-				sgtl5000->supplies);
-
-		if (ret) {
-			ldo_regulator_remove(codec);
-			dev_err(codec->dev,
-				"Failed to request supplies: %d\n", ret);
-
+		ret = sgtl5000_replace_vddd_with_ldo(codec);
+		if (ret)
 			return ret;
-		}
 	}
 
 	ret = regulator_bulk_enable(ARRAY_SIZE(sgtl5000->supplies),
@@ -1287,7 +1294,6 @@ static int sgtl5000_enable_regulators(struct snd_soc_codec *codec)
 	 * roll back to use internal LDO
 	 */
 	if (external_vddd && rev >= 0x11) {
-		int voltage = LDO_VOLTAGE;
 		/* disable all regulator first */
 		regulator_bulk_disable(ARRAY_SIZE(sgtl5000->supplies),
 					sgtl5000->supplies);
@@ -1295,23 +1301,10 @@ static int sgtl5000_enable_regulators(struct snd_soc_codec *codec)
 		regulator_bulk_free(ARRAY_SIZE(sgtl5000->supplies),
 					sgtl5000->supplies);
 
-		ret = ldo_regulator_register(codec, &ldo_init_data, voltage);
+		ret = sgtl5000_replace_vddd_with_ldo(codec);
 		if (ret)
 			return ret;
 
-		sgtl5000->supplies[VDDD].supply = LDO_CONSUMER_NAME;
-
-		ret = regulator_bulk_get(codec->dev,
-				ARRAY_SIZE(sgtl5000->supplies),
-				sgtl5000->supplies);
-		if (ret) {
-			ldo_regulator_remove(codec);
-			dev_err(codec->dev,
-				"Failed to request supplies: %d\n", ret);
-
-			return ret;
-		}
-
 		ret = regulator_bulk_enable(ARRAY_SIZE(sgtl5000->supplies),
 						sgtl5000->supplies);
 		if (ret)
-- 
1.7.5.4
