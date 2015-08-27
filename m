From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5645: Prevent the pop sound of the
	headphone while rebooting or shutdowning" to the asoc tree
Date: Thu, 27 Aug 2015 20:18:16 +0100
Message-ID: <E1ZV2gi-0003K0-K1@debutante>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 1712B26060A
 for <alsa-devel@alsa-project.org>; Thu, 27 Aug 2015 21:18:26 +0200 (CEST)
In-Reply-To: 
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Oder Chiou <oder_chiou@realtek.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5645: Prevent the pop sound of the headphone while rebooting or shutdowning

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From f2988afedf2c19880a3c65d79dfc7939e1b53d8a Mon Sep 17 00:00:00 2001
From: Oder Chiou <oder_chiou@realtek.com>
Date: Thu, 27 Aug 2015 15:14:51 +0800
Subject: [PATCH] ASoC: rt5645: Prevent the pop sound of the headphone while
 rebooting or shutdowning

Add i2c shutdown function to prevent the pop sound of the headphone while
the system is rebooting or shutdowning. It de-initials the jack detection
function, and it cannot be turned off in _BIAS_OFF. If we don't de-initial
it, the pop sound will be heard in the situation of powering off. And
replace the related register settings from magic number to meaningful
defined name.

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5645.c | 35 ++++++++++++++++++++++++-----------
 sound/soc/codecs/rt5645.h |  1 +
 2 files changed, 25 insertions(+), 11 deletions(-)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index 0a4cb6bc3433..db50b035b00b 100644
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
@@ -3449,6 +3449,18 @@ static int rt5645_i2c_remove(struct i2c_client *i2c)
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
@@ -3456,7 +3468,8 @@ static struct i2c_driver rt5645_i2c_driver = {
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
index 199b22fe1bf3..1987eb825e41 100644
--- a/sound/soc/codecs/rt5645.h
+++ b/sound/soc/codecs/rt5645.h
@@ -2111,6 +2111,7 @@ enum {
 #define RT5645_JD_PSV_MODE			(0x1 << 12)
 #define RT5645_IRQ_CLK_GATE_CTRL		(0x1 << 11)
 #define RT5645_MICINDET_MANU			(0x1 << 7)
+#define RT5645_RING2_SLEEVE_GND			(0x1 << 5)
 
 /* Vendor ID (0xfd) */
 #define RT5645_VER_C				0x2
-- 
2.5.0
