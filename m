From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] ASoC: cs42l52: Report correct chip id and
	revision
Date: Fri, 04 Apr 2014 21:08:09 +0800
Message-ID: <1396616889.13903.2.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f43.google.com (mail-pa0-f43.google.com
 [209.85.220.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 566462657D4
 for <alsa-devel@alsa-project.org>; Fri,  4 Apr 2014 15:08:16 +0200 (CEST)
Received: by mail-pa0-f43.google.com with SMTP id bj1so3429699pad.2
 for <alsa-devel@alsa-project.org>; Fri, 04 Apr 2014 06:08:14 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Brian Austin <brian.austin@cirrus.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>
List-Id: alsa-devel@alsa-project.org

According to the datasheet:

Chip I.D and Revision Register (Address 01h)
BIT[0:2] REVID
BIT[3:7] CHIPID (CS42L52: 11100)

REVID takes 3 bits, so CS42L52_CHIP_REV_MASK should be 0x07.
While at it, also adds define for CS42L52_CHIP_REV_B1.
The CHIPID takes BIT[3:7], so this patch updates the defines and the code to
show correct chip id for this chip.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 sound/soc/codecs/cs42l52.c | 4 ++--
 sound/soc/codecs/cs42l52.h | 7 ++++---
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/cs42l52.c b/sound/soc/codecs/cs42l52.c
index f0ca6be..277df17 100644
--- a/sound/soc/codecs/cs42l52.c
+++ b/sound/soc/codecs/cs42l52.c
@@ -1249,7 +1249,7 @@ static int cs42l52_i2c_probe(struct i2c_client *i2c_client,
 			 ret);
 
 	ret = regmap_read(cs42l52->regmap, CS42L52_CHIP, &reg);
-	devid = reg & CS42L52_CHIP_ID_MASK;
+	devid = (reg & CS42L52_CHIP_ID_MASK) >> 3;
 	if (devid != CS42L52_CHIP_ID) {
 		ret = -ENODEV;
 		dev_err(&i2c_client->dev,
@@ -1259,7 +1259,7 @@ static int cs42l52_i2c_probe(struct i2c_client *i2c_client,
 	}
 
 	dev_info(&i2c_client->dev, "Cirrus Logic CS42L52, Revision: %02X\n",
-			reg & 0xFF);
+			reg & CS42L52_CHIP_REV_MASK);
 
 	/* Set Platform Data */
 	if (cs42l52->pdata.mica_diff_cfg)
diff --git a/sound/soc/codecs/cs42l52.h b/sound/soc/codecs/cs42l52.h
index 6fb8f00..ce7ce5a 100644
--- a/sound/soc/codecs/cs42l52.h
+++ b/sound/soc/codecs/cs42l52.h
@@ -32,12 +32,13 @@
 
 #define CS42L52_FIX_BITS_CTL			0x00
 #define CS42L52_CHIP				0x01
-#define CS42L52_CHIP_ID				0xE0
-#define CS42L52_CHIP_ID_MASK			0xF8
+#define CS42L52_CHIP_ID				0x1C
+#define CS42L52_CHIP_ID_MASK			(0x1F << 3)
 #define CS42L52_CHIP_REV_A0			0x00
 #define CS42L52_CHIP_REV_A1			0x01
 #define CS42L52_CHIP_REV_B0			0x02
-#define CS42L52_CHIP_REV_MASK			0x03
+#define CS42L52_CHIP_REV_B1			0x03
+#define CS42L52_CHIP_REV_MASK			0x07
 
 #define CS42L52_PWRCTL1				0x02
 #define CS42L52_PWRCTL1_PDN_ALL			0x9F
-- 
1.8.3.2
