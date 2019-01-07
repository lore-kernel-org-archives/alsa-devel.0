From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5651: Add support for jack detect
	using an external GPIO" to the asoc tree
Date: Mon,  7 Jan 2019 19:24:40 +0000 (GMT)
Message-ID: <20190107192440.F2AC41127491@debutante.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id C8F622670F0
 for <alsa-devel@alsa-project.org>; Mon,  7 Jan 2019 20:24:41 +0100 (CET)
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
To: Hans de Goede <hdegoede@redhat.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5651: Add support for jack detect using an external GPIO

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

>From c2ec9d957d2bf49d69afb1b872cb2363c6cb5862 Mon Sep 17 00:00:00 2001
From: Hans de Goede <hdegoede@redhat.com>
Date: Sun, 30 Dec 2018 00:00:21 +0100
Subject: [PATCH] ASoC: rt5651: Add support for jack detect using an external
 GPIO

Some board designs hook the jack-detect up to an external GPIO,
rather then to one of the codec pins, add support for this.

Figuring out which GPIO to use is pretty much board specific so I've
chosen to let the machine driver pass the gpio_desc as data argument to
snd_soc_component_set_jack() rather then add support for getting the
GPIO to the codec driver. This keeps the codec code nice and clean.

Note that using an external GPIO for this conflicts with button-press
support, so this commit disables button-press support when an
external GPIO is used.

Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5651.c | 54 +++++++++++++++++++++++++++------------
 sound/soc/codecs/rt5651.h |  1 +
 2 files changed, 39 insertions(+), 16 deletions(-)

diff --git a/sound/soc/codecs/rt5651.c b/sound/soc/codecs/rt5651.c
index 9a007c162631..75994297c896 100644
--- a/sound/soc/codecs/rt5651.c
+++ b/sound/soc/codecs/rt5651.c
@@ -13,6 +13,7 @@
 #include <linux/init.h>
 #include <linux/delay.h>
 #include <linux/pm.h>
+#include <linux/gpio/consumer.h>
 #include <linux/i2c.h>
 #include <linux/regmap.h>
 #include <linux/platform_device.h>
@@ -1621,6 +1622,12 @@ static bool rt5651_jack_inserted(struct snd_soc_component *component)
 	struct rt5651_priv *rt5651 = snd_soc_component_get_drvdata(component);
 	int val;
 
+	if (rt5651->gpiod_hp_det) {
+		val = gpiod_get_value_cansleep(rt5651->gpiod_hp_det);
+		dev_dbg(component->dev, "jack-detect gpio %d\n", val);
+		return val;
+	}
+
 	val = snd_soc_component_read32(component, RT5651_INT_IRQ_ST);
 	dev_dbg(component->dev, "irq status %#04x\n", val);
 
@@ -1761,6 +1768,13 @@ static int rt5651_detect_headset(struct snd_soc_component *component)
 	return SND_JACK_HEADPHONE;
 }
 
+static bool rt5651_support_button_press(struct rt5651_priv *rt5651)
+{
+	/* Button press support only works with internal jack-detection */
+	return (rt5651->hp_jack->status & SND_JACK_MICROPHONE) &&
+		rt5651->gpiod_hp_det == NULL;
+}
+
 static void rt5651_jack_detect_work(struct work_struct *work)
 {
 	struct rt5651_priv *rt5651 =
@@ -1785,15 +1799,15 @@ static void rt5651_jack_detect_work(struct work_struct *work)
 		WARN_ON(rt5651->ovcd_irq_enabled);
 		rt5651_enable_micbias1_for_ovcd(component);
 		report = rt5651_detect_headset(component);
-		if (report == SND_JACK_HEADSET) {
+		dev_dbg(component->dev, "detect report %#02x\n", report);
+		snd_soc_jack_report(rt5651->hp_jack, report, SND_JACK_HEADSET);
+		if (rt5651_support_button_press(rt5651)) {
 			/* Enable ovcd IRQ for button press detect. */
 			rt5651_enable_micbias1_ovcd_irq(component);
 		} else {
 			/* No more need for overcurrent detect. */
 			rt5651_disable_micbias1_for_ovcd(component);
 		}
-		dev_dbg(component->dev, "detect report %#02x\n", report);
-		snd_soc_jack_report(rt5651->hp_jack, report, SND_JACK_HEADSET);
 	} else if (rt5651->ovcd_irq_enabled && rt5651_micbias1_ovcd(component)) {
 		dev_dbg(component->dev, "OVCD IRQ\n");
 
@@ -1837,16 +1851,20 @@ static void rt5651_cancel_work(void *data)
 }
 
 static void rt5651_enable_jack_detect(struct snd_soc_component *component,
-				      struct snd_soc_jack *hp_jack)
+				      struct snd_soc_jack *hp_jack,
+				      struct gpio_desc *gpiod_hp_det)
 {
 	struct rt5651_priv *rt5651 = snd_soc_component_get_drvdata(component);
-
-	/* IRQ output on GPIO1 */
-	snd_soc_component_update_bits(component, RT5651_GPIO_CTRL1,
-		RT5651_GP1_PIN_MASK, RT5651_GP1_PIN_IRQ);
+	bool using_internal_jack_detect = true;
 
 	/* Select jack detect source */
 	switch (rt5651->jd_src) {
+	case RT5651_JD_NULL:
+		rt5651->gpiod_hp_det = gpiod_hp_det;
+		if (!rt5651->gpiod_hp_det)
+			return; /* No jack detect */
+		using_internal_jack_detect = false;
+		break;
 	case RT5651_JD1_1:
 		snd_soc_component_update_bits(component, RT5651_JD_CTRL2,
 			RT5651_JD_TRG_SEL_MASK, RT5651_JD_TRG_SEL_JD1_1);
@@ -1865,16 +1883,20 @@ static void rt5651_enable_jack_detect(struct snd_soc_component *component,
 		snd_soc_component_update_bits(component, RT5651_IRQ_CTRL1,
 			RT5651_JD2_IRQ_EN, RT5651_JD2_IRQ_EN);
 		break;
-	case RT5651_JD_NULL:
-		return;
 	default:
 		dev_err(component->dev, "Currently only JD1_1 / JD1_2 / JD2 are supported\n");
 		return;
 	}
 
-	/* Enable jack detect power */
-	snd_soc_component_update_bits(component, RT5651_PWR_ANLG2,
-		RT5651_PWR_JD_M, RT5651_PWR_JD_M);
+	if (using_internal_jack_detect) {
+		/* IRQ output on GPIO1 */
+		snd_soc_component_update_bits(component, RT5651_GPIO_CTRL1,
+			RT5651_GP1_PIN_MASK, RT5651_GP1_PIN_IRQ);
+
+		/* Enable jack detect power */
+		snd_soc_component_update_bits(component, RT5651_PWR_ANLG2,
+			RT5651_PWR_JD_M, RT5651_PWR_JD_M);
+	}
 
 	/* Set OVCD threshold current and scale-factor */
 	snd_soc_component_write(component, RT5651_PR_BASE + RT5651_BIAS_CUR4,
@@ -1903,7 +1925,7 @@ static void rt5651_enable_jack_detect(struct snd_soc_component *component,
 		RT5651_MB1_OC_STKY_MASK, RT5651_MB1_OC_STKY_EN);
 
 	rt5651->hp_jack = hp_jack;
-	if (rt5651->hp_jack->status & SND_JACK_MICROPHONE) {
+	if (rt5651_support_button_press(rt5651)) {
 		rt5651_enable_micbias1_for_ovcd(component);
 		rt5651_enable_micbias1_ovcd_irq(component);
 	}
@@ -1920,7 +1942,7 @@ static void rt5651_disable_jack_detect(struct snd_soc_component *component)
 	disable_irq(rt5651->irq);
 	rt5651_cancel_work(rt5651);
 
-	if (rt5651->hp_jack->status & SND_JACK_MICROPHONE) {
+	if (rt5651_support_button_press(rt5651)) {
 		rt5651_disable_micbias1_ovcd_irq(component);
 		rt5651_disable_micbias1_for_ovcd(component);
 		snd_soc_jack_report(rt5651->hp_jack, 0, SND_JACK_BTN_0);
@@ -1933,7 +1955,7 @@ static int rt5651_set_jack(struct snd_soc_component *component,
 			   struct snd_soc_jack *jack, void *data)
 {
 	if (jack)
-		rt5651_enable_jack_detect(component, jack);
+		rt5651_enable_jack_detect(component, jack, data);
 	else
 		rt5651_disable_jack_detect(component);
 
diff --git a/sound/soc/codecs/rt5651.h b/sound/soc/codecs/rt5651.h
index ac6de6fb5414..41fcb8b5eb40 100644
--- a/sound/soc/codecs/rt5651.h
+++ b/sound/soc/codecs/rt5651.h
@@ -2073,6 +2073,7 @@ struct rt5651_priv {
 	struct regmap *regmap;
 	/* Jack and button detect data */
 	struct snd_soc_jack *hp_jack;
+	struct gpio_desc *gpiod_hp_det;
 	struct work_struct jack_detect_work;
 	struct delayed_work bp_work;
 	bool ovcd_irq_enabled;
-- 
2.20.1
