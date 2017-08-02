From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5663: Seprate the DC offset between
	headphone and headset" to the asoc tree
Date: Wed, 02 Aug 2017 18:30:23 +0100
Message-ID: <E1dcxTT-0003qU-6l@debutante>
References: <1501660887-22393-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id D6FA72673C8
 for <alsa-devel@alsa-project.org>; Wed,  2 Aug 2017 19:30:32 +0200 (CEST)
In-Reply-To: <1501660887-22393-1-git-send-email-oder_chiou@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: Oder Chiou <oder_chiou@realtek.com>, jack.yu@realtek.com, alsa-devel@alsa-project.org, hychao@google.com, lgirdwood@gmail.com, broonie@kernel.org, shumingf@realtek.com, bardliao@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5663: Seprate the DC offset between headphone and headset

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

>From 278982b50b28d654ff8cca0efb1ff6e835c6cc4c Mon Sep 17 00:00:00 2001
From: "oder_chiou@realtek.com" <oder_chiou@realtek.com>
Date: Wed, 2 Aug 2017 16:01:27 +0800
Subject: [PATCH] ASoC: rt5663: Seprate the DC offset between headphone and
 headset

The patch seprates the DC offset between headphone and headset.

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/sound/rt5663.txt |  5 ++-
 include/sound/rt5663.h                             |  2 +
 sound/soc/codecs/rt5663.c                          | 52 ++++++++++++++++------
 3 files changed, 44 insertions(+), 15 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/rt5663.txt b/Documentation/devicetree/bindings/sound/rt5663.txt
index f7c7cc513ee8..ff381718c517 100644
--- a/Documentation/devicetree/bindings/sound/rt5663.txt
+++ b/Documentation/devicetree/bindings/sound/rt5663.txt
@@ -14,8 +14,11 @@ Optional properties:
 
 - "realtek,dc_offset_l_manual"
 - "realtek,dc_offset_r_manual"
+- "realtek,dc_offset_l_manual_mic"
+- "realtek,dc_offset_r_manual_mic"
   Based on the different PCB layout, add the manual offset value to
-  compensate the DC offset for each L and R channel.
+  compensate the DC offset for each L and R channel, and they are different
+  between headphone and headset.
 
 Pins on the device (for linking into audio routes) for RT5663:
 
diff --git a/include/sound/rt5663.h b/include/sound/rt5663.h
index be6f1b2d8fbd..7d00e5849706 100644
--- a/include/sound/rt5663.h
+++ b/include/sound/rt5663.h
@@ -14,6 +14,8 @@
 struct rt5663_platform_data {
 	unsigned int dc_offset_l_manual;
 	unsigned int dc_offset_r_manual;
+	unsigned int dc_offset_l_manual_mic;
+	unsigned int dc_offset_r_manual_mic;
 };
 
 #endif
diff --git a/sound/soc/codecs/rt5663.c b/sound/soc/codecs/rt5663.c
index c1f0a72c0133..be93231b0f58 100644
--- a/sound/soc/codecs/rt5663.c
+++ b/sound/soc/codecs/rt5663.c
@@ -1570,9 +1570,43 @@ static int rt5663_jack_detect(struct snd_soc_codec *codec, int jack_insert)
 		case 2:
 			rt5663->jack_type = SND_JACK_HEADSET;
 			rt5663_enable_push_button_irq(codec, true);
+
+			if (rt5663->pdata.dc_offset_l_manual_mic) {
+				regmap_write(rt5663->regmap, RT5663_MIC_DECRO_2,
+					rt5663->pdata.dc_offset_l_manual_mic >>
+					16);
+				regmap_write(rt5663->regmap, RT5663_MIC_DECRO_3,
+					rt5663->pdata.dc_offset_l_manual_mic &
+					0xffff);
+			}
+
+			if (rt5663->pdata.dc_offset_r_manual_mic) {
+				regmap_write(rt5663->regmap, RT5663_MIC_DECRO_5,
+					rt5663->pdata.dc_offset_r_manual_mic >>
+					16);
+				regmap_write(rt5663->regmap, RT5663_MIC_DECRO_6,
+					rt5663->pdata.dc_offset_r_manual_mic &
+					0xffff);
+			}
 			break;
 		default:
 			rt5663->jack_type = SND_JACK_HEADPHONE;
+
+			if (rt5663->pdata.dc_offset_l_manual) {
+				regmap_write(rt5663->regmap, RT5663_MIC_DECRO_2,
+					rt5663->pdata.dc_offset_l_manual >> 16);
+				regmap_write(rt5663->regmap, RT5663_MIC_DECRO_3,
+					rt5663->pdata.dc_offset_l_manual &
+					0xffff);
+			}
+
+			if (rt5663->pdata.dc_offset_r_manual) {
+				regmap_write(rt5663->regmap, RT5663_MIC_DECRO_5,
+					rt5663->pdata.dc_offset_r_manual >> 16);
+				regmap_write(rt5663->regmap, RT5663_MIC_DECRO_6,
+					rt5663->pdata.dc_offset_r_manual &
+					0xffff);
+			}
 			break;
 		}
 	} else {
@@ -3133,6 +3167,10 @@ static int rt5663_parse_dp(struct rt5663_priv *rt5663, struct device *dev)
 		&rt5663->pdata.dc_offset_l_manual);
 	device_property_read_u32(dev, "realtek,dc_offset_r_manual",
 		&rt5663->pdata.dc_offset_r_manual);
+	device_property_read_u32(dev, "realtek,dc_offset_l_manual_mic",
+		&rt5663->pdata.dc_offset_l_manual_mic);
+	device_property_read_u32(dev, "realtek,dc_offset_r_manual_mic",
+		&rt5663->pdata.dc_offset_r_manual_mic);
 
 	return 0;
 }
@@ -3221,20 +3259,6 @@ static int rt5663_i2c_probe(struct i2c_client *i2c,
 		dev_err(&i2c->dev, "%s:Unknown codec type\n", __func__);
 	}
 
-	if (rt5663->pdata.dc_offset_l_manual) {
-		regmap_write(rt5663->regmap, RT5663_MIC_DECRO_2,
-			rt5663->pdata.dc_offset_l_manual >> 16);
-		regmap_write(rt5663->regmap, RT5663_MIC_DECRO_3,
-			rt5663->pdata.dc_offset_l_manual & 0xffff);
-	}
-
-	if (rt5663->pdata.dc_offset_r_manual) {
-		regmap_write(rt5663->regmap, RT5663_MIC_DECRO_5,
-			rt5663->pdata.dc_offset_r_manual >> 16);
-		regmap_write(rt5663->regmap, RT5663_MIC_DECRO_6,
-			rt5663->pdata.dc_offset_r_manual & 0xffff);
-	}
-
 	/* GPIO1 as IRQ */
 	regmap_update_bits(rt5663->regmap, RT5663_GPIO_1, RT5663_GP1_PIN_MASK,
 		RT5663_GP1_PIN_IRQ);
-- 
2.13.2
