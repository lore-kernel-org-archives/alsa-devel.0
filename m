From: "Andrew F. Davis" <afd@ti.com>
Subject: [PATCH v3 03/10] ASoC: tlv320aic31xx: Remove platform
	data
Date: Thu, 7 Dec 2017 09:38:53 -0600
Message-ID: <20171207153900.9831-4-afd@ti.com>
References: <20171207153900.9831-1-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lelnx193.ext.ti.com (lelnx193.ext.ti.com [198.47.27.77])
 by alsa0.perex.cz (Postfix) with ESMTP id 03AF7266B67
 for <alsa-devel@alsa-project.org>; Thu,  7 Dec 2017 16:39:02 +0100 (CET)
In-Reply-To: <20171207153900.9831-1-afd@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, "Andrew F .
 Davis" <afd@ti.com>
List-Id: alsa-devel@alsa-project.org

Platform data is not used by anyone (at least in upstream) so
drop this data.

Signed-off-by: Andrew F. Davis <afd@ti.com>
---
 sound/soc/codecs/tlv320aic31xx.c | 7 -------
 sound/soc/codecs/tlv320aic31xx.h | 6 ------
 2 files changed, 13 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic31xx.c b/sound/soc/codecs/tlv320aic31xx.c
index 655c99db2426..266141d841e7 100644
--- a/sound/soc/codecs/tlv320aic31xx.c
+++ b/sound/soc/codecs/tlv320aic31xx.c
@@ -160,7 +160,6 @@ struct aic31xx_priv {
 	enum aic31xx_type codec_type;
 	struct gpio_desc *gpio_reset;
 	int micbias_vg;
-	struct aic31xx_pdata pdata;
 	struct regulator_bulk_data supplies[AIC31XX_NUM_SUPPLIES];
 	struct aic31xx_disable_nb disable_nb[AIC31XX_NUM_SUPPLIES];
 	unsigned int sysclk;
@@ -1332,12 +1331,6 @@ static int aic31xx_i2c_probe(struct i2c_client *i2c,
 		aic31xx->micbias_vg = MICBIAS_2_0V;
 	}
 
-	if (dev_get_platdata(aic31xx->dev)) {
-		memcpy(&aic31xx->pdata, dev_get_platdata(aic31xx->dev), sizeof(aic31xx->pdata));
-		aic31xx->codec_type = aic31xx->pdata.codec_type;
-		aic31xx->micbias_vg = aic31xx->pdata.micbias_vg;
-	}
-
 	aic31xx->gpio_reset = devm_gpiod_get_optional(aic31xx->dev, "reset",
 						      GPIOD_OUT_LOW);
 	if (IS_ERR(aic31xx->gpio_reset)) {
diff --git a/sound/soc/codecs/tlv320aic31xx.h b/sound/soc/codecs/tlv320aic31xx.h
index 15ac7cba86fe..ab94e6a0c742 100644
--- a/sound/soc/codecs/tlv320aic31xx.h
+++ b/sound/soc/codecs/tlv320aic31xx.h
@@ -29,12 +29,6 @@ enum aic31xx_type {
 	DAC3101 = DAC31XX_BIT | AIC31XX_STEREO_CLASS_D_BIT,
 };
 
-struct aic31xx_pdata {
-	enum aic31xx_type codec_type;
-	unsigned int gpio_reset;
-	int micbias_vg;
-};
-
 #define AIC31XX_REG(page, reg)	((page * 128) + reg)
 
 #define AIC31XX_PAGECTL		AIC31XX_REG(0, 0) /* Page Control Register */
-- 
2.15.0
