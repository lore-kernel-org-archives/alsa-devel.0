From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] ASoC: cs42xx8: Check return value of
 regmap_read and report correct chipid value
Date: Thu, 03 Apr 2014 15:53:36 +0800
Message-ID: <1396511616.30532.2.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f42.google.com (mail-pa0-f42.google.com
 [209.85.220.42])
 by alsa0.perex.cz (Postfix) with ESMTP id 9C1F8265549
 for <alsa-devel@alsa-project.org>; Thu,  3 Apr 2014 09:53:43 +0200 (CEST)
Received: by mail-pa0-f42.google.com with SMTP id fb1so1462660pad.29
 for <alsa-devel@alsa-project.org>; Thu, 03 Apr 2014 00:53:42 -0700 (PDT)
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
Cc: Brian Austin <brian.austin@cirrus.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>, Nicolin Chen <Guangyu.Chen@freescale.com>
List-Id: alsa-devel@alsa-project.org

Fix checking return value of regmap_read().
Also fix reporting the chip_id value. CS42XX8_CHIPID_CHIP_ID_MASK is 0xF0,
so the chip_id value is (val & CS42XX8_CHIPID_CHIP_ID_MASK) >> 4).

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 sound/soc/codecs/cs42xx8.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/cs42xx8.c b/sound/soc/codecs/cs42xx8.c
index 082299a..b1606cf 100644
--- a/sound/soc/codecs/cs42xx8.c
+++ b/sound/soc/codecs/cs42xx8.c
@@ -495,17 +495,16 @@ int cs42xx8_probe(struct device *dev, struct regmap *regmap)
 	regcache_cache_bypass(cs42xx8->regmap, true);
 
 	/* Validate the chip ID */
-	regmap_read(cs42xx8->regmap, CS42XX8_CHIPID, &val);
-	if (val < 0) {
+	ret = regmap_read(cs42xx8->regmap, CS42XX8_CHIPID, &val);
+	if (ret < 0) {
 		dev_err(dev, "failed to get device ID: %x", val);
-		ret = -EINVAL;
 		goto err_enable;
 	}
 
 	/* The top four bits of the chip ID should be 0000 */
-	if ((val & CS42XX8_CHIPID_CHIP_ID_MASK) != 0x00) {
+	if (((val & CS42XX8_CHIPID_CHIP_ID_MASK) >> 4) != 0x00) {
 		dev_err(dev, "unmatched chip ID: %d\n",
-				val & CS42XX8_CHIPID_CHIP_ID_MASK);
+			(val & CS42XX8_CHIPID_CHIP_ID_MASK) >> 4);
 		ret = -EINVAL;
 		goto err_enable;
 	}
-- 
1.8.3.2
