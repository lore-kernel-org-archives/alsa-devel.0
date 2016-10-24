From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 2/6] ASoC: cs42l73: Make ID registers volatile
	and remove cache bypass
Date: Mon, 24 Oct 2016 10:55:45 +0100
Message-ID: <1477302949-28049-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1477302949-28049-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 99BB9266B76
 for <alsa-devel@alsa-project.org>; Mon, 24 Oct 2016 11:55:45 +0200 (CEST)
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
simply mark them as volatile. The old code worked this is simply the
more standard way to implement this.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/cs42l73.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/cs42l73.c b/sound/soc/codecs/cs42l73.c
index 71ba560..0f9378f 100644
--- a/sound/soc/codecs/cs42l73.c
+++ b/sound/soc/codecs/cs42l73.c
@@ -142,6 +142,10 @@ static const struct reg_default cs42l73_reg_defaults[] = {
 static bool cs42l73_volatile_register(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
+	case CS42L73_DEVID_AB:
+	case CS42L73_DEVID_CD:
+	case CS42L73_DEVID_E:
+	case CS42L73_REVID:
 	case CS42L73_IS1:
 	case CS42L73_IS2:
 		return true;
@@ -1337,8 +1341,6 @@ static int cs42l73_i2c_probe(struct i2c_client *i2c_client,
 		gpio_set_value_cansleep(cs42l73->pdata.reset_gpio, 1);
 	}
 
-	regcache_cache_bypass(cs42l73->regmap, true);
-
 	/* initialize codec */
 	ret = regmap_read(cs42l73->regmap, CS42L73_DEVID_AB, &reg);
 	devid = (reg & 0xFF) << 12;
@@ -1366,8 +1368,6 @@ static int cs42l73_i2c_probe(struct i2c_client *i2c_client,
 	dev_info(&i2c_client->dev,
 		 "Cirrus Logic CS42L73, Revision: %02X\n", reg & 0xFF);
 
-	regcache_cache_bypass(cs42l73->regmap, false);
-
 	ret =  snd_soc_register_codec(&i2c_client->dev,
 			&soc_codec_dev_cs42l73, cs42l73_dai,
 			ARRAY_SIZE(cs42l73_dai));
-- 
2.1.4
