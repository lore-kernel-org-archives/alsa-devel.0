From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2 05/32] ASoC: rt5651: Add
	rt5651_apply_properties() helper function
Date: Sun, 25 Feb 2018 11:46:46 +0100
Message-ID: <20180225104713.4745-6-hdegoede@redhat.com>
References: <20180225104713.4745-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx3-rdu2.redhat.com [66.187.233.73])
 by alsa0.perex.cz (Postfix) with ESMTP id 5C40B26739D
 for <alsa-devel@alsa-project.org>; Sun, 25 Feb 2018 11:47:25 +0100 (CET)
In-Reply-To: <20180225104713.4745-1-hdegoede@redhat.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>, alsa-devel@alsa-project.org, Carlo Caione <carlo@endlessm.com>, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

Move the applying of the differential input and dmic properties to a new
rt5651_apply_properties() helper function. This new function can be called
by platform code which attaches properties after probe() has run to apply
these new properties.

Note this also moves the time when we apply these properties for DT
platforms from i2c-probe to snd-component-probe time, this should not
result in any functional difference.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 sound/soc/codecs/rt5651.c | 22 ++++++++++++++--------
 sound/soc/codecs/rt5651.h |  2 ++
 2 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/rt5651.c b/sound/soc/codecs/rt5651.c
index 3e507f53fc13..79a839c713ec 100644
--- a/sound/soc/codecs/rt5651.c
+++ b/sound/soc/codecs/rt5651.c
@@ -1659,6 +1659,18 @@ static int rt5651_set_jack(struct snd_soc_component *component,
 	return 0;
 }
 
+void rt5651_apply_properties(struct snd_soc_component *component)
+{
+	if (device_property_read_bool(component->dev, "realtek,in2-differential"))
+		snd_soc_component_update_bits(component, RT5651_IN1_IN2,
+				RT5651_IN_DF2, RT5651_IN_DF2);
+
+	if (device_property_read_bool(component->dev, "realtek,dmic-en"))
+		snd_soc_component_update_bits(component, RT5651_GPIO_CTRL1,
+				RT5651_GP2_PIN_MASK, RT5651_GP2_PIN_DMIC1_SCL);
+}
+EXPORT_SYMBOL_GPL(rt5651_apply_properties);
+
 static int rt5651_probe(struct snd_soc_component *component)
 {
 	struct rt5651_priv *rt5651 = snd_soc_component_get_drvdata(component);
@@ -1677,6 +1689,8 @@ static int rt5651_probe(struct snd_soc_component *component)
 
 	snd_soc_component_force_bias_level(component, SND_SOC_BIAS_OFF);
 
+	rt5651_apply_properties(component);
+
 	return 0;
 }
 
@@ -1933,14 +1947,6 @@ static int rt5651_i2c_probe(struct i2c_client *i2c,
 	if (ret != 0)
 		dev_warn(&i2c->dev, "Failed to apply regmap patch: %d\n", ret);
 
-	if (device_property_read_bool(&i2c->dev, "realtek,in2-differential"))
-		regmap_update_bits(rt5651->regmap, RT5651_IN1_IN2,
-					RT5651_IN_DF2, RT5651_IN_DF2);
-
-	if (device_property_read_bool(&i2c->dev, "realtek,dmic-en"))
-		regmap_update_bits(rt5651->regmap, RT5651_GPIO_CTRL1,
-				RT5651_GP2_PIN_MASK, RT5651_GP2_PIN_DMIC1_SCL);
-
 	rt5651->irq = i2c->irq;
 	rt5651->hp_mute = 1;
 
diff --git a/sound/soc/codecs/rt5651.h b/sound/soc/codecs/rt5651.h
index f3158488fc89..7d9d5fa09d6f 100644
--- a/sound/soc/codecs/rt5651.h
+++ b/sound/soc/codecs/rt5651.h
@@ -2080,4 +2080,6 @@ struct rt5651_priv {
 	bool hp_mute;
 };
 
+void rt5651_apply_properties(struct snd_soc_component *component);
+
 #endif /* __RT5651_H__ */
-- 
2.14.3
