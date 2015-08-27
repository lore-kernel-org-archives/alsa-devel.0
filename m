From: Oder Chiou <oder_chiou@realtek.com>
Subject: [PATCH v2] ASoC: rt5645: Prevent the pop sound of the
	headphone while rebooting or shutdowning
Date: Thu, 27 Aug 2015 15:14:51 +0800
Message-ID: <1440659691-1835-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 6991926598F
 for <alsa-devel@alsa-project.org>; Thu, 27 Aug 2015 09:15:02 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, john.lin@realtek.com, woojoo.lee@samsung.com, bardliao@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

Add i2c shutdown function to prevent the pop sound of the headphone while
the system is rebooting or shutdowning. It de-initials the jack detection
function, and it cannot be turned off in _BIAS_OFF. If we don't de-initial
it, the pop sound will be heard in the situation of powering off. And
replace the related register settings from magic number to meaningful
defined name.

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
---
 sound/soc/codecs/rt5645.c | 35 ++++++++++++++++++++++++-----------
 sound/soc/codecs/rt5645.h |  1 +
 2 files changed, 25 insertions(+), 11 deletions(-)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index 50f797c..4972bf3 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -2806,13 +2806,13 @@ static int rt5645_jack_detect(struct snd_soc_codec *codec, int jack_insert)
 		}
 
 		regmap_write(rt5645->regmap, RT5645_JD_CTRL3, 0x00f0);
-		regmap_update_bits(rt5645->regmap,
-				   RT5645_IN1_CTRL2, 0x1000, 0x1000);
-		regmap_update_bits(rt5645->regmap, RT5645_IN1_CTRL1, 0x0004,
-			0x0004);
+		regmap_update_bits(rt5645->regmap, RT5645_IN1_CTRL2,
+			RT5645_CBJ_MN_JD, RT5645_CBJ_MN_JD);
+		regmap_update_bits(rt5645->regmap, RT5645_IN1_CTRL1,
+			RT5645_CBJ_BST1_EN, RT5645_CBJ_BST1_EN);
 		msleep(100);
-		regmap_update_bits(rt5645->regmap,
-				   RT5645_IN1_CTRL2, 0x1000, 0x0000);
+		regmap_update_bits(rt5645->regmap, RT5645_IN1_CTRL2,
+			RT5645_CBJ_MN_JD, 0);
 
 		msleep(600);
 		regmap_read(rt5645->regmap, RT5645_IN1_CTRL3, &val);
@@ -2836,10 +2836,10 @@ static int rt5645_jack_detect(struct snd_soc_codec *codec, int jack_insert)
 	} else { /* jack out */
 		rt5645->jack_type = 0;
 
-		regmap_update_bits(rt5645->regmap, RT5645_IN1_CTRL2, 0x1000,
-			0x1000);
-		regmap_update_bits(rt5645->regmap, RT5645_IN1_CTRL1, 0x0004,
-			0x0000);
+		regmap_update_bits(rt5645->regmap, RT5645_IN1_CTRL2,
+			RT5645_CBJ_MN_JD, RT5645_CBJ_MN_JD);
+		regmap_update_bits(rt5645->regmap, RT5645_IN1_CTRL1,
+			RT5645_CBJ_BST1_EN, 0);
 
 		if (rt5645->en_button_func)
 			rt5645_enable_push_button_irq(codec, false);
@@ -3458,13 +3458,26 @@ static int rt5645_i2c_remove(struct i2c_client *i2c)
 	return 0;
 }
 
+static void rt5645_i2c_shutdown(struct i2c_client *i2c)
+{
+	struct rt5645_priv *rt5645 = i2c_get_clientdata(i2c);
+
+	regmap_update_bits(rt5645->regmap, RT5645_GEN_CTRL3,
+		RT5645_RING2_SLEEVE_GND, RT5645_RING2_SLEEVE_GND);
+	regmap_update_bits(rt5645->regmap, RT5645_IN1_CTRL2, RT5645_CBJ_MN_JD,
+		RT5645_CBJ_MN_JD);
+	regmap_update_bits(rt5645->regmap, RT5645_IN1_CTRL1, RT5645_CBJ_BST1_EN,
+		0);
+}
+
 static struct i2c_driver rt5645_i2c_driver = {
 	.driver = {
 		.name = "rt5645",
 		.acpi_match_table = ACPI_PTR(rt5645_acpi_match),
 	},
 	.probe = rt5645_i2c_probe,
-	.remove   = rt5645_i2c_remove,
+	.remove = rt5645_i2c_remove,
+	.shutdown = rt5645_i2c_shutdown,
 	.id_table = rt5645_i2c_id,
 };
 module_i2c_driver(rt5645_i2c_driver);
diff --git a/sound/soc/codecs/rt5645.h b/sound/soc/codecs/rt5645.h
index dffdda2..0e4cfc6 100644
--- a/sound/soc/codecs/rt5645.h
+++ b/sound/soc/codecs/rt5645.h
@@ -2115,6 +2115,7 @@ enum {
 #define RT5645_JD_PSV_MODE			(0x1 << 12)
 #define RT5645_IRQ_CLK_GATE_CTRL		(0x1 << 11)
 #define RT5645_MICINDET_MANU			(0x1 << 7)
+#define RT5645_RING2_SLEEVE_GND			(0x1 << 5)
 
 /* Vendor ID (0xfd) */
 #define RT5645_VER_C				0x2
-- 
1.8.1.1.439.g50a6b54
