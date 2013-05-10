From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH v5 1/2] ASoC: sgtl5000: Read SGTL5000_CHIP_ID
	in i2c_probe()
Date: Thu,  9 May 2013 21:15:46 -0300
Message-ID: <1368144947-23775-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gh0-f172.google.com (mail-gh0-f172.google.com
 [209.85.160.172])
 by alsa0.perex.cz (Postfix) with ESMTP id A5B5126089A
 for <alsa-devel@alsa-project.org>; Fri, 10 May 2013 02:16:52 +0200 (CEST)
Received: by mail-gh0-f172.google.com with SMTP id r18so800195ghr.17
 for <alsa-devel@alsa-project.org>; Thu, 09 May 2013 17:16:51 -0700 (PDT)
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, lars@metafoo.de, matt@genesi-usa.com, eric.nelson@boundarydevices.com, troy.kisky@boundarydevices.com
List-Id: alsa-devel@alsa-project.org

From: Fabio Estevam <fabio.estevam@freescale.com>

The usual place for reading chip ID is inside i2c_probe, so move it there and 
also convert it to regmap.

sgtl5000_enable_regulators() needs to read the chip revision, so keep the
revision check there.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Changes since v4:
- Just introduced in this version.

 sound/soc/codecs/sgtl5000.c |   39 ++++++++++++++++++++++++---------------
 1 file changed, 24 insertions(+), 15 deletions(-)

diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
index 327b443..af0c8aa 100644
--- a/sound/soc/codecs/sgtl5000.c
+++ b/sound/soc/codecs/sgtl5000.c
@@ -1275,7 +1275,7 @@ static int sgtl5000_replace_vddd_with_ldo(struct snd_soc_codec *codec)
 
 static int sgtl5000_enable_regulators(struct snd_soc_codec *codec)
 {
-	u16 reg;
+	int reg;
 	int ret;
 	int rev;
 	int i;
@@ -1303,23 +1303,17 @@ static int sgtl5000_enable_regulators(struct snd_soc_codec *codec)
 	/* wait for all power rails bring up */
 	udelay(10);
 
-	/* read chip information */
-	reg = snd_soc_read(codec, SGTL5000_CHIP_ID);
-	if (((reg & SGTL5000_PARTID_MASK) >> SGTL5000_PARTID_SHIFT) !=
-	    SGTL5000_PARTID_PART_ID) {
-		dev_err(codec->dev,
-			"Device with ID register %x is not a sgtl5000\n", reg);
-		ret = -ENODEV;
-		goto err_regulator_disable;
-	}
-
-	rev = (reg & SGTL5000_REVID_MASK) >> SGTL5000_REVID_SHIFT;
-	dev_info(codec->dev, "sgtl5000 revision 0x%x\n", rev);
-
 	/*
 	 * workaround for revision 0x11 and later,
 	 * roll back to use internal LDO
 	 */
+
+	ret = regmap_read(sgtl5000->regmap, SGTL5000_CHIP_ID, &reg);
+	if (ret)
+		goto err_regulator_disable;
+
+	rev = (reg & SGTL5000_REVID_MASK) >> SGTL5000_REVID_SHIFT;
+
 	if (external_vddd && rev >= 0x11) {
 		/* disable all regulator first */
 		regulator_bulk_disable(ARRAY_SIZE(sgtl5000->supplies),
@@ -1478,7 +1472,7 @@ static int sgtl5000_i2c_probe(struct i2c_client *client,
 			      const struct i2c_device_id *id)
 {
 	struct sgtl5000_priv *sgtl5000;
-	int ret;
+	int ret, reg, rev;
 
 	sgtl5000 = devm_kzalloc(&client->dev, sizeof(struct sgtl5000_priv),
 								GFP_KERNEL);
@@ -1492,6 +1486,21 @@ static int sgtl5000_i2c_probe(struct i2c_client *client,
 		return ret;
 	}
 
+	/* read chip information */
+	ret = regmap_read(sgtl5000->regmap, SGTL5000_CHIP_ID, &reg);
+	if (ret)
+		return ret;
+
+	if (((reg & SGTL5000_PARTID_MASK) >> SGTL5000_PARTID_SHIFT) !=
+	    SGTL5000_PARTID_PART_ID) {
+		dev_err(&client->dev,
+			"Device with ID register %x is not a sgtl5000\n", reg);
+		return -ENODEV;
+	}
+
+	rev = (reg & SGTL5000_REVID_MASK) >> SGTL5000_REVID_SHIFT;
+	dev_info(&client->dev, "sgtl5000 revision 0x%x\n", rev);
+
 	i2c_set_clientdata(client, sgtl5000);
 
 	ret = snd_soc_register_codec(&client->dev,
-- 
1.7.9.5
