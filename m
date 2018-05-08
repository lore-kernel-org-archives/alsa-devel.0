From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 04/19] ASoC: rt5640: Move checking of
	device-properties to component probe callback
Date: Tue,  8 May 2018 17:35:49 +0200
Message-ID: <20180508153604.23711-5-hdegoede@redhat.com>
References: <20180508153604.23711-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx3-rdu2.redhat.com [66.187.233.73])
 by alsa0.perex.cz (Postfix) with ESMTP id A52E92676CC
 for <alsa-devel@alsa-project.org>; Tue,  8 May 2018 17:36:14 +0200 (CEST)
In-Reply-To: <20180508153604.23711-1-hdegoede@redhat.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

On some platforms the platform code may need to add device-properties,
rather then relying only on properties set by the firmware.

This commit moves the parsing of the device-properties from the i2c-driver
probe() function, which may be called at any time, to the component-driver
probe() function, which gets called after the platform code calls
snd_soc_register_card().

This allows the platform code to attach extra device-properties before
the device-properties are parsed.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
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
