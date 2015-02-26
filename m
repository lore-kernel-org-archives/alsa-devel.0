From: Eric Nelson <eric.nelson@boundarydevices.com>
Subject: [RFC PATCH 4/6] ASoC: sgtl5000: check return values
Date: Thu, 26 Feb 2015 15:54:31 -0700
Message-ID: <1424991273-10081-5-git-send-email-eric.nelson@boundarydevices.com>
References: <1424991273-10081-1-git-send-email-eric.nelson@boundarydevices.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f42.google.com (mail-pa0-f42.google.com
 [209.85.220.42])
 by alsa0.perex.cz (Postfix) with ESMTP id 5D0652606A6
 for <alsa-devel@alsa-project.org>; Thu, 26 Feb 2015 23:54:49 +0100 (CET)
Received: by pabrd3 with SMTP id rd3so17563353pab.4
 for <alsa-devel@alsa-project.org>; Thu, 26 Feb 2015 14:54:48 -0800 (PST)
In-Reply-To: <1424991273-10081-1-git-send-email-eric.nelson@boundarydevices.com>
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
Cc: fabio.estevam@freescale.com, lars@metafoo.de, tiwai@suse.de, Eric Nelson <eric.nelson@boundarydevices.com>, lgirdwood@gmail.com, broonie@kernel.org, rmk+kernel@arm.linux.org.uk, jean-michel.hautbois@vodalys.com, troy.kisky@boundarydevices.com
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Eric Nelson <eric.nelson@boundarydevices.com>
---
 sound/soc/codecs/sgtl5000.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
index 0a7b96d7..c373991 100644
--- a/sound/soc/codecs/sgtl5000.c
+++ b/sound/soc/codecs/sgtl5000.c
@@ -1252,12 +1252,17 @@ static int sgtl5000_i2c_probe(struct i2c_client *client,
 	ana_pwr = SGTL5000_ANA_POWER_DEFAULT;
 	if (sgtl5000->num_supplies <= VDDD) {
 		/* internal VDDD at 1.2V */
-		regmap_update_bits(sgtl5000->regmap,
-				   SGTL5000_CHIP_LINREG_CTRL,
-				   SGTL5000_LINREG_VDDD_MASK,
-				   LINREG_VDDD);
+		ret = regmap_update_bits(sgtl5000->regmap,
+					 SGTL5000_CHIP_LINREG_CTRL,
+					 SGTL5000_LINREG_VDDD_MASK,
+					 LINREG_VDDD);
+		if (ret)
+			dev_err(&client->dev,
+				"error %d setting LINREG_VDDD\n", ret);
+
 		ana_pwr |= SGTL5000_LINEREG_D_POWERUP;
-		dev_info(&client->dev, "Using internal LDO instead of VDDD: check ER1\n");
+		dev_info(&client->dev,
+			 "Using internal LDO instead of VDDD: check ER1\n");
 	} else {
 		/* using external LDO for VDDD
 		 * Clear startup powerup and simple powerup
@@ -1267,7 +1272,11 @@ static int sgtl5000_i2c_probe(struct i2c_client *client,
 			     | SGTL5000_LINREG_SIMPLE_POWERUP);
 		dev_dbg(&client->dev, "Using external VDDD\n");
 	}
-	regmap_write(sgtl5000->regmap, SGTL5000_CHIP_ANA_POWER, ana_pwr);
+	ret = regmap_write(sgtl5000->regmap, SGTL5000_CHIP_ANA_POWER, ana_pwr);
+	if (ret)
+		dev_err(&client->dev,
+			"error %d setting CHIP_ANA_POWER to %04x\n",
+			ret, ana_pwr);
 
 	if (np) {
 		if (!of_property_read_u32(np,
-- 
1.9.1
