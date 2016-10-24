From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 3/6] ASoC: cs42l56: Make ID registers volatile
	and remove cache bypass
Date: Mon, 24 Oct 2016 10:55:46 +0100
Message-ID: <1477302949-28049-3-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1477302949-28049-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 23BD7266B76
 for <alsa-devel@alsa-project.org>; Mon, 24 Oct 2016 11:55:38 +0200 (CEST)
In-Reply-To: <1477302949-28049-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
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
simply mark them as volatile, also remove the default values since
defaults for volatile registers don't make sense. The old code worked
this is simply the more standard way to implement this.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/cs42l56.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/cs42l56.c b/sound/soc/codecs/cs42l56.c
index 54c1768..9bfca5d 100644
--- a/sound/soc/codecs/cs42l56.c
+++ b/sound/soc/codecs/cs42l56.c
@@ -64,8 +64,6 @@ struct  cs42l56_private {
 };
 
 static const struct reg_default cs42l56_reg_defaults[] = {
-	{ 1, 0x56 },	/* r01	- ID 1 */
-	{ 2, 0x04 },	/* r02	- ID 2 */
 	{ 3, 0x7f },	/* r03	- Power Ctl 1 */
 	{ 4, 0xff },	/* r04	- Power Ctl 2 */
 	{ 5, 0x00 },	/* ro5	- Clocking Ctl 1 */
@@ -125,6 +123,8 @@ static bool cs42l56_readable_register(struct device *dev, unsigned int reg)
 static bool cs42l56_volatile_register(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
+	case CS42L56_CHIP_ID_1:
+	case CS42L56_CHIP_ID_2:
 	case CS42L56_INT_STATUS:
 		return true;
 	default:
@@ -1262,8 +1262,6 @@ static int cs42l56_i2c_probe(struct i2c_client *i2c_client,
 		return ret;
 	}
 
-	regcache_cache_bypass(cs42l56->regmap, true);
-
 	ret = regmap_read(cs42l56->regmap, CS42L56_CHIP_ID_1, &reg);
 	devid = reg & CS42L56_CHIP_ID_MASK;
 	if (devid != CS42L56_DEVID) {
@@ -1279,8 +1277,6 @@ static int cs42l56_i2c_probe(struct i2c_client *i2c_client,
 	dev_info(&i2c_client->dev, "Alpha Rev %X Metal Rev %X\n",
 		 alpha_rev, metal_rev);
 
-	regcache_cache_bypass(cs42l56->regmap, false);
-
 	if (cs42l56->pdata.ain1a_ref_cfg)
 		regmap_update_bits(cs42l56->regmap, CS42L56_AIN_REFCFG_ADC_MUX,
 				   CS42L56_AIN1A_REF_MASK, 1);
-- 
2.1.4
