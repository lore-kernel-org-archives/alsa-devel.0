From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2 02/32] ASoC: rt5651: Move all jack-detect
	initialization to rt5651_set_jack_detect
Date: Sun, 25 Feb 2018 11:46:43 +0100
Message-ID: <20180225104713.4745-3-hdegoede@redhat.com>
References: <20180225104713.4745-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx3-rdu2.redhat.com [66.187.233.73])
 by alsa0.perex.cz (Postfix) with ESMTP id 573B8267253
 for <alsa-devel@alsa-project.org>; Sun, 25 Feb 2018 11:47:21 +0100 (CET)
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

Move all jack-detect initialization to rt5651_set_jack_detect. The main
reason to do this is so that platform code can setup jack-detect properties
after the device has been probed, which unfortunately is necessary on some
platforms.

This has 2 additional advantages:
1) Grouping all jack-detect init together makes it easier to follow what
is happening and results in a small reduction in the number of loc.
2) Before we would register the irq handler before rt5651->hp_jack was
assigned, leading to a potential NULL deref if the jack_detect work runs
before the machine driver has called set_jack.

Tested-by: Carlo Caione <carlo@endlessm.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 sound/soc/codecs/rt5651.c | 119 ++++++++++++++++++++++------------------------
 sound/soc/codecs/rt5651.h |   1 +
 2 files changed, 58 insertions(+), 62 deletions(-)

diff --git a/sound/soc/codecs/rt5651.c b/sound/soc/codecs/rt5651.c
index 2aa070554743..de3f071f8695 100644
--- a/sound/soc/codecs/rt5651.c
+++ b/sound/soc/codecs/rt5651.c
@@ -1586,7 +1586,6 @@ static int rt5651_set_bias_level(struct snd_soc_component *component,
 static int rt5651_probe(struct snd_soc_component *component)
 {
 	struct rt5651_priv *rt5651 = snd_soc_component_get_drvdata(component);
-	struct snd_soc_dapm_context *dapm = snd_soc_component_get_dapm(component);
 
 	rt5651->component = component;
 
@@ -1602,15 +1601,6 @@ static int rt5651_probe(struct snd_soc_component *component)
 
 	snd_soc_component_force_bias_level(component, SND_SOC_BIAS_OFF);
 
-	if (rt5651->jd_src) {
-		snd_soc_dapm_force_enable_pin(dapm, "JD Power");
-		snd_soc_dapm_force_enable_pin(dapm, "LDO");
-		snd_soc_dapm_sync(dapm);
-
-		regmap_update_bits(rt5651->regmap, RT5651_MICBIAS,
-				   0x38, 0x38);
-	}
-
 	return 0;
 }
 
@@ -1841,10 +1831,65 @@ static void rt5651_jack_detect_work(struct work_struct *work)
 int rt5651_set_jack_detect(struct snd_soc_component *component,
 			   struct snd_soc_jack *hp_jack)
 {
+	struct snd_soc_dapm_context *dapm = snd_soc_component_get_dapm(component);
 	struct rt5651_priv *rt5651 = snd_soc_component_get_drvdata(component);
+	int ret;
+
+	if (!rt5651->irq)
+		return -EINVAL;
+
+	/* IRQ output on GPIO1 */
+	snd_soc_component_update_bits(component, RT5651_GPIO_CTRL1,
+		RT5651_GP1_PIN_MASK, RT5651_GP1_PIN_IRQ);
+
+	/* Select jack detect source */
+	switch (rt5651->jd_src) {
+	case RT5651_JD1_1:
+		snd_soc_component_update_bits(component, RT5651_JD_CTRL2,
+			RT5651_JD_TRG_SEL_MASK, RT5651_JD_TRG_SEL_JD1_1);
+		snd_soc_component_update_bits(component, RT5651_IRQ_CTRL1,
+			RT5651_JD1_1_IRQ_EN, RT5651_JD1_1_IRQ_EN);
+		break;
+	case RT5651_JD1_2:
+		snd_soc_component_update_bits(component, RT5651_JD_CTRL2,
+			RT5651_JD_TRG_SEL_MASK, RT5651_JD_TRG_SEL_JD1_2);
+		snd_soc_component_update_bits(component, RT5651_IRQ_CTRL1,
+			RT5651_JD1_2_IRQ_EN, RT5651_JD1_2_IRQ_EN);
+		break;
+	case RT5651_JD2:
+		snd_soc_component_update_bits(component, RT5651_JD_CTRL2,
+			RT5651_JD_TRG_SEL_MASK, RT5651_JD_TRG_SEL_JD2);
+		snd_soc_component_update_bits(component, RT5651_IRQ_CTRL1,
+			RT5651_JD2_IRQ_EN, RT5651_JD2_IRQ_EN);
+		break;
+	case RT5651_JD_NULL:
+		return 0;
+	default:
+		dev_err(component->dev, "Currently only JD1_1 / JD1_2 / JD2 are supported\n");
+		return -EINVAL;
+	}
+
+	snd_soc_dapm_force_enable_pin(dapm, "JD Power");
+	snd_soc_dapm_force_enable_pin(dapm, "LDO");
+	snd_soc_dapm_sync(dapm);
+
+	snd_soc_component_update_bits(component, RT5651_MICBIAS, 0x38, 0x38);
 
 	rt5651->hp_jack = hp_jack;
-	rt5651_irq(0, rt5651);
+
+	ret = devm_request_threaded_irq(component->dev, rt5651->irq, NULL,
+					rt5651_irq,
+					IRQF_TRIGGER_RISING |
+					IRQF_TRIGGER_FALLING |
+					IRQF_ONESHOT, "rt5651", rt5651);
+	if (ret) {
+		dev_err(component->dev, "Failed to reguest IRQ: %d\n", ret);
+		return ret;
+	}
+
+	/* sync initial jack state */
+	queue_delayed_work(system_power_efficient_wq,
+			   &rt5651->jack_detect_work, 0);
 
 	return 0;
 }
@@ -1896,61 +1941,11 @@ static int rt5651_i2c_probe(struct i2c_client *i2c,
 		regmap_update_bits(rt5651->regmap, RT5651_GPIO_CTRL1,
 				RT5651_GP2_PIN_MASK, RT5651_GP2_PIN_DMIC1_SCL);
 
+	rt5651->irq = i2c->irq;
 	rt5651->hp_mute = 1;
 
-	if (rt5651->jd_src) {
-
-		/* IRQ output on GPIO1 */
-		regmap_update_bits(rt5651->regmap, RT5651_GPIO_CTRL1,
-				   RT5651_GP1_PIN_MASK, RT5651_GP1_PIN_IRQ);
-
-		switch (rt5651->jd_src) {
-		case RT5651_JD1_1:
-			regmap_update_bits(rt5651->regmap, RT5651_JD_CTRL2,
-					   RT5651_JD_TRG_SEL_MASK,
-					   RT5651_JD_TRG_SEL_JD1_1);
-			regmap_update_bits(rt5651->regmap, RT5651_IRQ_CTRL1,
-					   RT5651_JD1_1_IRQ_EN,
-					   RT5651_JD1_1_IRQ_EN);
-			break;
-		case RT5651_JD1_2:
-			regmap_update_bits(rt5651->regmap, RT5651_JD_CTRL2,
-					   RT5651_JD_TRG_SEL_MASK,
-					   RT5651_JD_TRG_SEL_JD1_2);
-			regmap_update_bits(rt5651->regmap, RT5651_IRQ_CTRL1,
-					   RT5651_JD1_2_IRQ_EN,
-					   RT5651_JD1_2_IRQ_EN);
-			break;
-		case RT5651_JD2:
-			regmap_update_bits(rt5651->regmap, RT5651_JD_CTRL2,
-					   RT5651_JD_TRG_SEL_MASK,
-					   RT5651_JD_TRG_SEL_JD2);
-			regmap_update_bits(rt5651->regmap, RT5651_IRQ_CTRL1,
-					   RT5651_JD2_IRQ_EN,
-					   RT5651_JD2_IRQ_EN);
-			break;
-		case RT5651_JD_NULL:
-			break;
-		default:
-			dev_warn(&i2c->dev, "Currently only JD1_1 / JD1_2 / JD2 are supported\n");
-			break;
-		}
-	}
-
 	INIT_DELAYED_WORK(&rt5651->jack_detect_work, rt5651_jack_detect_work);
 
-	if (i2c->irq) {
-		ret = devm_request_threaded_irq(&i2c->dev, i2c->irq, NULL,
-						rt5651_irq,
-						IRQF_TRIGGER_RISING |
-						IRQF_TRIGGER_FALLING |
-						IRQF_ONESHOT, "rt5651", rt5651);
-		if (ret) {
-			dev_err(&i2c->dev, "Failed to reguest IRQ: %d\n", ret);
-			return ret;
-		}
-	}
-
 	ret = devm_snd_soc_register_component(&i2c->dev,
 				&soc_component_dev_rt5651,
 				rt5651_dai, ARRAY_SIZE(rt5651_dai));
diff --git a/sound/soc/codecs/rt5651.h b/sound/soc/codecs/rt5651.h
index 148e139e6a26..8f128d057ff0 100644
--- a/sound/soc/codecs/rt5651.h
+++ b/sound/soc/codecs/rt5651.h
@@ -2065,6 +2065,7 @@ struct rt5651_priv {
 	struct delayed_work jack_detect_work;
 	enum rt5651_jd_src jd_src;
 
+	int irq;
 	int sysclk;
 	int sysclk_src;
 	int lrck[RT5651_AIFS];
-- 
2.14.3
