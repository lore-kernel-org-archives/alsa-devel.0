From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5640: Move checking of
	device-properties to component probe callback" to the asoc tree
Date: Fri, 11 May 2018 03:51:44 +0100 (BST)
Message-ID: <20180511025144.3EEC044007A@finisterre.ee.mobilebroadband>
References: <20180508153604.23711-5-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id BD4412677A5
 for <alsa-devel@alsa-project.org>; Fri, 11 May 2018 05:01:21 +0200 (CEST)
In-Reply-To: <20180508153604.23711-5-hdegoede@redhat.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5640: Move checking of device-properties to component probe callback

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 988a5e0162ce75a4440c9181ad6d900473e428ae Mon Sep 17 00:00:00 2001
From: Hans de Goede <hdegoede@redhat.com>
Date: Tue, 8 May 2018 17:35:49 +0200
Subject: [PATCH] ASoC: rt5640: Move checking of device-properties to component
 probe callback

On some platforms the platform code may need to add device-properties,
rather then relying only on properties set by the firmware.

This commit moves the parsing of the device-properties from the i2c-driver
probe() function, which may be called at any time, to the component-driver
probe() function, which gets called after the platform code calls
snd_soc_register_card().

This allows the platform code to attach extra device-properties before
the device-properties are parsed.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5640.c | 31 +++++++++++++++++++------------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/sound/soc/codecs/rt5640.c b/sound/soc/codecs/rt5640.c
index 616f0a69b850..265a0786851d 100644
--- a/sound/soc/codecs/rt5640.c
+++ b/sound/soc/codecs/rt5640.c
@@ -2138,6 +2138,25 @@ static int rt5640_probe(struct snd_soc_component *component)
 		return -ENODEV;
 	}
 
+	/*
+	 * Note on some platforms the platform code may need to add device-props
+	 * rather then relying only on properties set by the firmware.
+	 * Therefor the property parsing MUST be done here, rather then from
+	 * rt5640_i2c_probe(), so that the platform-code can attach extra
+	 * properties before calling snd_soc_register_card().
+	 */
+	if (device_property_read_bool(component->dev, "realtek,in1-differential"))
+		snd_soc_component_update_bits(component, RT5640_IN1_IN2,
+					      RT5640_IN_DF1, RT5640_IN_DF1);
+
+	if (device_property_read_bool(component->dev, "realtek,in2-differential"))
+		snd_soc_component_update_bits(component, RT5640_IN3_IN4,
+					      RT5640_IN_DF2, RT5640_IN_DF2);
+
+	if (device_property_read_bool(component->dev, "realtek,in3-differential"))
+		snd_soc_component_update_bits(component, RT5640_IN1_IN2,
+					      RT5640_IN_DF2, RT5640_IN_DF2);
+
 	return 0;
 }
 
@@ -2370,18 +2389,6 @@ static int rt5640_i2c_probe(struct i2c_client *i2c,
 	regmap_update_bits(rt5640->regmap, RT5640_DUMMY1,
 				RT5640_MCLK_DET, RT5640_MCLK_DET);
 
-	if (device_property_read_bool(&i2c->dev, "realtek,in1-differential"))
-		regmap_update_bits(rt5640->regmap, RT5640_IN1_IN2,
-					RT5640_IN_DF1, RT5640_IN_DF1);
-
-	if (device_property_read_bool(&i2c->dev, "realtek,in2-differential"))
-		regmap_update_bits(rt5640->regmap, RT5640_IN3_IN4,
-					RT5640_IN_DF2, RT5640_IN_DF2);
-
-	if (device_property_read_bool(&i2c->dev, "realtek,in3-differential"))
-		regmap_update_bits(rt5640->regmap, RT5640_IN1_IN2,
-					RT5640_IN_DF2, RT5640_IN_DF2);
-
 	rt5640->hp_mute = 1;
 
 	return devm_snd_soc_register_component(&i2c->dev,
-- 
2.17.0
