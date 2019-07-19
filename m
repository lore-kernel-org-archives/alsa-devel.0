From: <shumingf@realtek.com>
Subject: [PATCH 1/3] ASoC: rt1308: simplify the EFUSE read
	function
Date: Fri, 19 Jul 2019 14:32:35 +0800
Message-ID: <20190719063235.18757-1-shumingf@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9A633F8015B
 for <alsa-devel@alsa-project.org>; Fri, 19 Jul 2019 08:32:52 +0200 (CEST)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, derek.fang@realtek.com, Shuming Fan <shumingf@realtek.com>, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

From: Shuming Fan <shumingf@realtek.com>

The rt1308_efuse function contains many redundant settings.
We remove the redundant settings and the function still works.

Signed-off-by: Shuming Fan <shumingf@realtek.com>
---
 sound/soc/codecs/rt1308.c | 22 ----------------------
 1 file changed, 22 deletions(-)

diff --git a/sound/soc/codecs/rt1308.c b/sound/soc/codecs/rt1308.c
index d673506c7c39..19d255e01827 100644
--- a/sound/soc/codecs/rt1308.c
+++ b/sound/soc/codecs/rt1308.c
@@ -808,33 +808,11 @@ static void rt1308_efuse(struct rt1308_priv *rt1308)
 {
 	regmap_write(rt1308->regmap, RT1308_RESET, 0);
 
-	regmap_write(rt1308->regmap, RT1308_POWER, 0xff371600);
-	regmap_write(rt1308->regmap, RT1308_CLK_1, 0x52100000);
-	regmap_write(rt1308->regmap, RT1308_I2C_I2S_SDW_SET, 0x01014005);
-	regmap_write(rt1308->regmap, RT1308_CLASS_D_SET_2, 0x227f5501);
-	regmap_write(rt1308->regmap, RT1308_PADS_1, 0x50150505);
-	regmap_write(rt1308->regmap, RT1308_VREF, 0x18100000);
-	regmap_write(rt1308->regmap, RT1308_IV_SENSE, 0x87010000);
-	regmap_write(rt1308->regmap, RT1308_DUMMY_REG, 0x00000200);
-	regmap_write(rt1308->regmap, RT1308_SIL_DET, 0x61c30000);
-	regmap_write(rt1308->regmap, RT1308_CLK_DET, 0x03700000);
-	regmap_write(rt1308->regmap, RT1308_SINE_TONE_GEN_1, 0x50022f00);
 	regmap_write(rt1308->regmap, RT1308_POWER_STATUS, 0x01800000);
-	regmap_write(rt1308->regmap, RT1308_DC_CAL_2, 0x00ffff00);
-	regmap_write(rt1308->regmap, RT1308_CLASS_D_SET_2, 0x607e5501);
-
-	regmap_write(rt1308->regmap, RT1308_CLK_2, 0x0060e000);
-	regmap_write(rt1308->regmap, RT1308_EFUSE_1, 0x04fe0f00);
 	msleep(100);
 	regmap_write(rt1308->regmap, RT1308_EFUSE_1, 0x44fe0f00);
 	msleep(20);
 	regmap_write(rt1308->regmap, RT1308_PVDD_OFFSET_CTL, 0x10000000);
-
-	regmap_write(rt1308->regmap, RT1308_POWER_STATUS, 0x00800000);
-	regmap_write(rt1308->regmap, RT1308_POWER, 0x0);
-	regmap_write(rt1308->regmap, RT1308_CLK_1, 0x52000000);
-	regmap_write(rt1308->regmap, RT1308_CLASS_D_SET_2, 0x227f5501);
-	regmap_write(rt1308->regmap, RT1308_SINE_TONE_GEN_1, 0x10022f00);
 }
 
 static int rt1308_i2c_probe(struct i2c_client *i2c,
-- 
2.22.0
