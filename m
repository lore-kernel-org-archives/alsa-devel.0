From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5651: Move 2 functions higher up in
	rt5651.c" to the asoc tree
Date: Thu, 01 Mar 2018 18:06:53 +0000
Message-ID: <E1erSbV-0005rA-NO@debutante>
References: <20180225104713.4745-4-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id BE3A6267B33
 for <alsa-devel@alsa-project.org>; Thu,  1 Mar 2018 19:07:04 +0100 (CET)
In-Reply-To: <20180225104713.4745-4-hdegoede@redhat.com>
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
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>, Carlo Caione <carlo@endlessm.com>, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5651: Move 2 functions higher up in rt5651.c

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

>From d8b8c878e86593ad8bd86676a2a4c2be58a8b889 Mon Sep 17 00:00:00 2001
From: Hans de Goede <hdegoede@redhat.com>
Date: Sun, 25 Feb 2018 11:46:44 +0100
Subject: [PATCH] ASoC: rt5651: Move 2 functions higher up in rt5651.c

Move 2 functions higher up in rt5651.c, this is a preparation patch
to avoid needing forward declarations when moving over from a codec
private function to the standard snd_soc_component_set_jack().

This commit purely moves these 2 functions up, not a single line is
changed.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5651.c | 154 +++++++++++++++++++++++-----------------------
 1 file changed, 77 insertions(+), 77 deletions(-)

diff --git a/sound/soc/codecs/rt5651.c b/sound/soc/codecs/rt5651.c
index 390cab134ba0..c9698229fc33 100644
--- a/sound/soc/codecs/rt5651.c
+++ b/sound/soc/codecs/rt5651.c
@@ -1583,6 +1583,83 @@ static int rt5651_set_bias_level(struct snd_soc_component *component,
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
@@ -1752,16 +1829,6 @@ static const struct dmi_system_id rt5651_quirk_table[] = {
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
@@ -1827,73 +1894,6 @@ static void rt5651_jack_detect_work(struct work_struct *work)
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
-	/* Select jack detect source */
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
-		dev_err(component->dev, "Currently only JD1_1 / JD1_2 / JD2 are supported\n");
-		return -EINVAL;
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
2.16.2
