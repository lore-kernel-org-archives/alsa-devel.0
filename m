From: Hans de Goede <hdegoede@redhat.com>
Subject: [RFC 3/7] ASoC: rt5651: Move 2 functions higher up in
	rt5651.c
Date: Thu, 22 Feb 2018 18:07:34 +0100
Message-ID: <20180222170738.8508-4-hdegoede@redhat.com>
References: <20180222170738.8508-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx3-rdu2.redhat.com [66.187.233.73])
 by alsa0.perex.cz (Postfix) with ESMTP id 855DA2677A3
 for <alsa-devel@alsa-project.org>; Thu, 22 Feb 2018 18:07:45 +0100 (CET)
In-Reply-To: <20180222170738.8508-1-hdegoede@redhat.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>
Cc: Hans de Goede <hdegoede@redhat.com>, alsa-devel@alsa-project.org, Carlo Caione <carlo@endlessm.com>, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

Move 2 functions higher up in rt5651.c, this is a preparation patch
to avoid needing forward declarations when moving over from a codec
private function to the standard snd_soc_component_set_jack().

This commit purely moves these 2 functions up, not a single line is
changed.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 sound/soc/codecs/rt5651.c | 152 +++++++++++++++++++++++-----------------------
 1 file changed, 76 insertions(+), 76 deletions(-)

diff --git a/sound/soc/codecs/rt5651.c b/sound/soc/codecs/rt5651.c
index 5704482341e8..ae9fa14aa652 100644
--- a/sound/soc/codecs/rt5651.c
+++ b/sound/soc/codecs/rt5651.c
@@ -1583,6 +1583,82 @@ static int rt5651_set_bias_level(struct snd_soc_component *component,
 	return 0;
 }
 
+static irqreturn_t rt5651_irq(int irq, void *data)
+{
+	struct rt5651_priv *rt5651 = data;
+
+	queue_delayed_work(system_power_efficient_wq,
+			   &rt5651->jack_detect_work, msecs_to_jiffies(250));
+
+	return IRQ_HANDLED;
+}
+
+int rt5651_set_jack_detect(struct snd_soc_component *component,
+			   struct snd_soc_jack *hp_jack)
+{
+	struct snd_soc_dapm_context *dapm = snd_soc_component_get_dapm(component);
+	struct rt5651_priv *rt5651 = snd_soc_component_get_drvdata(component);
+	int ret;
+
+	if (!rt5651->irq)
+		return -EINVAL;
+
+	/* IRQ output on GPIO1 */
+	snd_soc_component_update_bits(component, RT5651_GPIO_CTRL1,
+		RT5651_GP1_PIN_MASK, RT5651_GP1_PIN_IRQ);
+
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
+		dev_warn(component->dev, "Currently only JD1_1 / JD1_2 / JD2 are supported\n");
+		return 0;
+	}
+
+	snd_soc_dapm_force_enable_pin(dapm, "JD Power");
+	snd_soc_dapm_force_enable_pin(dapm, "LDO");
+	snd_soc_dapm_sync(dapm);
+
+	snd_soc_component_update_bits(component, RT5651_MICBIAS, 0x38, 0x38);
+
+	rt5651->hp_jack = hp_jack;
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
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(rt5651_set_jack_detect);
+
 static int rt5651_probe(struct snd_soc_component *component)
 {
 	struct rt5651_priv *rt5651 = snd_soc_component_get_drvdata(component);
@@ -1753,16 +1829,6 @@ static const struct dmi_system_id rt5651_quirk_table[] = {
 	{}
 };
 
-static irqreturn_t rt5651_irq(int irq, void *data)
-{
-	struct rt5651_priv *rt5651 = data;
-
-	queue_delayed_work(system_power_efficient_wq,
-			   &rt5651->jack_detect_work, msecs_to_jiffies(250));
-
-	return IRQ_HANDLED;
-}
-
 static int rt5651_jack_detect(struct snd_soc_component *component, int jack_insert)
 {
 	struct snd_soc_dapm_context *dapm = snd_soc_component_get_dapm(component);
@@ -1828,72 +1894,6 @@ static void rt5651_jack_detect_work(struct work_struct *work)
 	snd_soc_jack_report(rt5651->hp_jack, report, SND_JACK_HEADSET);
 }
 
-int rt5651_set_jack_detect(struct snd_soc_component *component,
-			   struct snd_soc_jack *hp_jack)
-{
-	struct snd_soc_dapm_context *dapm = snd_soc_component_get_dapm(component);
-	struct rt5651_priv *rt5651 = snd_soc_component_get_drvdata(component);
-	int ret;
-
-	if (!rt5651->irq)
-		return -EINVAL;
-
-	/* IRQ output on GPIO1 */
-	snd_soc_component_update_bits(component, RT5651_GPIO_CTRL1,
-		RT5651_GP1_PIN_MASK, RT5651_GP1_PIN_IRQ);
-
-	switch (rt5651->jd_src) {
-	case RT5651_JD1_1:
-		snd_soc_component_update_bits(component, RT5651_JD_CTRL2,
-			RT5651_JD_TRG_SEL_MASK, RT5651_JD_TRG_SEL_JD1_1);
-		snd_soc_component_update_bits(component, RT5651_IRQ_CTRL1,
-			RT5651_JD1_1_IRQ_EN, RT5651_JD1_1_IRQ_EN);
-		break;
-	case RT5651_JD1_2:
-		snd_soc_component_update_bits(component, RT5651_JD_CTRL2,
-			RT5651_JD_TRG_SEL_MASK, RT5651_JD_TRG_SEL_JD1_2);
-		snd_soc_component_update_bits(component, RT5651_IRQ_CTRL1,
-			RT5651_JD1_2_IRQ_EN, RT5651_JD1_2_IRQ_EN);
-		break;
-	case RT5651_JD2:
-		snd_soc_component_update_bits(component, RT5651_JD_CTRL2,
-			RT5651_JD_TRG_SEL_MASK, RT5651_JD_TRG_SEL_JD2);
-		snd_soc_component_update_bits(component, RT5651_IRQ_CTRL1,
-			RT5651_JD2_IRQ_EN, RT5651_JD2_IRQ_EN);
-		break;
-	case RT5651_JD_NULL:
-		return 0;
-	default:
-		dev_warn(component->dev, "Currently only JD1_1 / JD1_2 / JD2 are supported\n");
-		return 0;
-	}
-
-	snd_soc_dapm_force_enable_pin(dapm, "JD Power");
-	snd_soc_dapm_force_enable_pin(dapm, "LDO");
-	snd_soc_dapm_sync(dapm);
-
-	snd_soc_component_update_bits(component, RT5651_MICBIAS, 0x38, 0x38);
-
-	rt5651->hp_jack = hp_jack;
-
-	ret = devm_request_threaded_irq(component->dev, rt5651->irq, NULL,
-					rt5651_irq,
-					IRQF_TRIGGER_RISING |
-					IRQF_TRIGGER_FALLING |
-					IRQF_ONESHOT, "rt5651", rt5651);
-	if (ret) {
-		dev_err(component->dev, "Failed to reguest IRQ: %d\n", ret);
-		return ret;
-	}
-
-	/* sync initial jack state */
-	queue_delayed_work(system_power_efficient_wq,
-			   &rt5651->jack_detect_work, 0);
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(rt5651_set_jack_detect);
-
 static int rt5651_i2c_probe(struct i2c_client *i2c,
 		    const struct i2c_device_id *id)
 {
-- 
2.14.3
