From: Fabio Estevam <fabio.estevam@freescale.com>
Subject: [PATCH] ASoC: sgtl5000: Do not read registers prior to
	turning on the supplies
Date: Tue, 28 May 2013 11:04:18 -0300
Message-ID: <1369749858-21579-1-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe003.messaging.microsoft.com [216.32.181.183])
 by alsa0.perex.cz (Postfix) with ESMTP id 7E1902610BA
 for <alsa-devel@alsa-project.org>; Tue, 28 May 2013 16:04:34 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Commit b871f1ad (ASoC: sgtl5000: Read SGTL5000_CHIP_ID in i2c_probe()) placed
the code for reading the codec revision prior to turning on the power supplies.

Even though this works on some systems that always have the codec power supplies
enabled, this is not correct, so revert this commit.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 sound/soc/codecs/sgtl5000.c | 39 +++++++++++++++------------------------
 1 file changed, 15 insertions(+), 24 deletions(-)

diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
index 1c3b20f..788af6c 100644
--- a/sound/soc/codecs/sgtl5000.c
+++ b/sound/soc/codecs/sgtl5000.c
@@ -1275,7 +1275,7 @@ static int sgtl5000_replace_vddd_with_ldo(struct snd_soc_codec *codec)
 
 static int sgtl5000_enable_regulators(struct snd_soc_codec *codec)
 {
-	int reg;
+	u16 reg;
 	int ret;
 	int rev;
 	int i;
@@ -1303,17 +1303,23 @@ static int sgtl5000_enable_regulators(struct snd_soc_codec *codec)
 	/* wait for all power rails bring up */
 	udelay(10);
 
-	/*
-	 * workaround for revision 0x11 and later,
-	 * roll back to use internal LDO
-	 */
-
-	ret = regmap_read(sgtl5000->regmap, SGTL5000_CHIP_ID, &reg);
-	if (ret)
+	/* read chip information */
+	reg = snd_soc_read(codec, SGTL5000_CHIP_ID);
+	if (((reg & SGTL5000_PARTID_MASK) >> SGTL5000_PARTID_SHIFT) !=
+	    SGTL5000_PARTID_PART_ID) {
+		dev_err(codec->dev,
+			"Device with ID register %x is not a sgtl5000\n", reg);
+		ret = -ENODEV;
 		goto err_regulator_disable;
+	}
 
 	rev = (reg & SGTL5000_REVID_MASK) >> SGTL5000_REVID_SHIFT;
+	dev_info(codec->dev, "sgtl5000 revision 0x%x\n", rev);
 
+	/*
+	 * workaround for revision 0x11 and later,
+	 * roll back to use internal LDO
+	 */
 	if (external_vddd && rev >= 0x11) {
 		/* disable all regulator first */
 		regulator_bulk_disable(ARRAY_SIZE(sgtl5000->supplies),
@@ -1497,7 +1503,7 @@ static int sgtl5000_i2c_probe(struct i2c_client *client,
 			      const struct i2c_device_id *id)
 {
 	struct sgtl5000_priv *sgtl5000;
-	int ret, reg, rev;
+	int ret;
 
 	sgtl5000 = devm_kzalloc(&client->dev, sizeof(struct sgtl5000_priv),
 								GFP_KERNEL);
@@ -1511,21 +1517,6 @@ static int sgtl5000_i2c_probe(struct i2c_client *client,
 		return ret;
 	}
 
-	/* read chip information */
-	ret = regmap_read(sgtl5000->regmap, SGTL5000_CHIP_ID, &reg);
-	if (ret)
-		return ret;
-
-	if (((reg & SGTL5000_PARTID_MASK) >> SGTL5000_PARTID_SHIFT) !=
-	    SGTL5000_PARTID_PART_ID) {
-		dev_err(&client->dev,
-			"Device with ID register %x is not a sgtl5000\n", reg);
-		return -ENODEV;
-	}
-
-	rev = (reg & SGTL5000_REVID_MASK) >> SGTL5000_REVID_SHIFT;
-	dev_info(&client->dev, "sgtl5000 revision 0x%x\n", rev);
-
 	i2c_set_clientdata(client, sgtl5000);
 
 	/* Ensure sgtl5000 will start with sane register values */
-- 
1.8.1.2
