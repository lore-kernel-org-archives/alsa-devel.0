From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 1/6] ASoC: cs42xx8: Mark chip ID as volatile
	and remove cache bypass
Date: Mon, 24 Oct 2016 10:55:44 +0100
Message-ID: <1477302949-28049-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 5697D266B9F
 for <alsa-devel@alsa-project.org>; Mon, 24 Oct 2016 11:55:46 +0200 (CEST)
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
Cc: brian.austin@cirrus.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com, Paul.Handrigan@cirrus.com, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

Rather than manually enabling cache bypass when reading the ID registers
simply mark them as volatile. The old code worked this is simply the
more standard way to implement this. There is a comment included in the
code that claims the chip ID register also contains the right input
volume, however this is clearly not the case from the rest of the
driver. Further investigation reveals exactly the same comment in the
wm8962 driver, where this is the case, so this is almost certainly a
copy and paste error from when the driver was created.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/cs42xx8.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/sound/soc/codecs/cs42xx8.c b/sound/soc/codecs/cs42xx8.c
index b4d8737..1d50748 100644
--- a/sound/soc/codecs/cs42xx8.c
+++ b/sound/soc/codecs/cs42xx8.c
@@ -321,7 +321,6 @@ static struct snd_soc_dai_driver cs42xx8_dai = {
 };
 
 static const struct reg_default cs42xx8_reg[] = {
-	{ 0x01, 0x01 },   /* Chip I.D. and Revision Register */
 	{ 0x02, 0x00 },   /* Power Control */
 	{ 0x03, 0xF0 },   /* Functional Mode */
 	{ 0x04, 0x46 },   /* Interface Formats */
@@ -352,6 +351,7 @@ static const struct reg_default cs42xx8_reg[] = {
 static bool cs42xx8_volatile_register(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
+	case CS42XX8_CHIPID:
 	case CS42XX8_STATUS:
 		return true;
 	default:
@@ -498,13 +498,6 @@ int cs42xx8_probe(struct device *dev, struct regmap *regmap)
 	/* Make sure hardware reset done */
 	msleep(5);
 
-	/*
-	 * We haven't marked the chip revision as volatile due to
-	 * sharing a register with the right input volume; explicitly
-	 * bypass the cache to read it.
-	 */
-	regcache_cache_bypass(cs42xx8->regmap, true);
-
 	/* Validate the chip ID */
 	ret = regmap_read(cs42xx8->regmap, CS42XX8_CHIPID, &val);
 	if (ret < 0) {
@@ -523,8 +516,6 @@ int cs42xx8_probe(struct device *dev, struct regmap *regmap)
 	dev_info(dev, "found device, revision %X\n",
 			val & CS42XX8_CHIPID_REV_ID_MASK);
 
-	regcache_cache_bypass(cs42xx8->regmap, false);
-
 	cs42xx8_dai.name = cs42xx8->drvdata->name;
 
 	/* Each adc supports stereo input */
-- 
2.1.4
