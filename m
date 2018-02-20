From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: max9759: Add Amplifier Driver" to the
	asoc tree
Date: Tue, 20 Feb 2018 12:08:48 +0000
Message-ID: <E1eo6j2-000353-5u@debutante>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 67CD1267505
 for <alsa-devel@alsa-project.org>; Tue, 20 Feb 2018 13:08:49 +0100 (CET)
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
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: max9759: Add Amplifier Driver

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

>From fa8d915172b8c10ec0734c4021e99e9705023b07 Mon Sep 17 00:00:00 2001
From: Neil Armstrong <narmstrong@baylibre.com>
Date: Mon, 19 Feb 2018 14:45:58 +0100
Subject: [PATCH] ASoC: max9759: Add Amplifier Driver

The max9759 is a gpio controlled amplifier.
Tested on a Variscite Dart MX6 SoM based custom board.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/Kconfig   |   5 ++
 sound/soc/codecs/Makefile  |   2 +
 sound/soc/codecs/max9759.c | 207 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 214 insertions(+)
 create mode 100644 sound/soc/codecs/max9759.c

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 2b331f7266ab..f9ea4603a903 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -98,6 +98,7 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_MAX98373 if I2C
 	select SND_SOC_MAX9850 if I2C
 	select SND_SOC_MAX9860 if I2C
+	select SND_SOC_MAX9759
 	select SND_SOC_MAX9768 if I2C
 	select SND_SOC_MAX9877 if I2C
 	select SND_SOC_MC13783 if MFD_MC13XXX
@@ -1187,6 +1188,10 @@ config SND_SOC_ZX_AUD96P22
 config SND_SOC_LM4857
 	tristate
 
+config SND_SOC_MAX9759
+	tristate "Maxim MAX9759 speaker Amplifier"
+	select GPIOLIB
+
 config SND_SOC_MAX9768
 	tristate
 
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index da1571336f1e..af4238d90c99 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -80,6 +80,7 @@ snd-soc-jz4740-codec-objs := jz4740.o
 snd-soc-l3-objs := l3.o
 snd-soc-lm4857-objs := lm4857.o
 snd-soc-lm49453-objs := lm49453.o
+snd-soc-max9759-objs := max9759.o
 snd-soc-max9768-objs := max9768.o
 snd-soc-max98088-objs := max98088.o
 snd-soc-max98090-objs := max98090.o
@@ -325,6 +326,7 @@ obj-$(CONFIG_SND_SOC_JZ4740_CODEC)	+= snd-soc-jz4740-codec.o
 obj-$(CONFIG_SND_SOC_L3)	+= snd-soc-l3.o
 obj-$(CONFIG_SND_SOC_LM4857)	+= snd-soc-lm4857.o
 obj-$(CONFIG_SND_SOC_LM49453)   += snd-soc-lm49453.o
+obj-$(CONFIG_SND_SOC_MAX9759)	+= snd-soc-max9759.o
 obj-$(CONFIG_SND_SOC_MAX9768)	+= snd-soc-max9768.o
 obj-$(CONFIG_SND_SOC_MAX98088)	+= snd-soc-max98088.o
 obj-$(CONFIG_SND_SOC_MAX98090)	+= snd-soc-max98090.o
diff --git a/sound/soc/codecs/max9759.c b/sound/soc/codecs/max9759.c
new file mode 100644
index 000000000000..ecfb4a80424b
--- /dev/null
+++ b/sound/soc/codecs/max9759.c
@@ -0,0 +1,207 @@
+// SPDX-Licence-Identifier: GPL-2.0
+/*
+ * MAX9759 Amplifier Driver
+ *
+ * Copyright (c) 2017 BayLibre, SAS.
+ * Author: Neil Armstrong <narmstrong@baylibre.com>
+ */
+
+#include <linux/gpio/consumer.h>
+#include <linux/module.h>
+#include <sound/soc.h>
+#include <sound/soc-dapm.h>
+#include <sound/tlv.h>
+
+#define DRV_NAME "max9759"
+
+struct max9759 {
+	struct gpio_desc *gpiod_shutdown;
+	struct gpio_desc *gpiod_mute;
+	struct gpio_descs *gpiod_gain;
+	bool is_mute;
+	unsigned int gain;
+};
+
+static int pga_event(struct snd_soc_dapm_widget *w,
+		     struct snd_kcontrol *control, int event)
+{
+	struct snd_soc_component *c = snd_soc_dapm_to_component(w->dapm);
+	struct max9759 *priv = snd_soc_component_get_drvdata(c);
+
+	if (SND_SOC_DAPM_EVENT_ON(event))
+		gpiod_set_value_cansleep(priv->gpiod_shutdown, 0);
+	else
+		gpiod_set_value_cansleep(priv->gpiod_shutdown, 1);
+
+	return 0;
+}
+
+/* From 6dB to 24dB in steps of 6dB */
+static const DECLARE_TLV_DB_SCALE(speaker_gain_tlv, 600, 600, 0);
+
+static int speaker_gain_control_get(struct snd_kcontrol *kcontrol,
+				    struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *c = snd_soc_kcontrol_component(kcontrol);
+	struct max9759 *priv = snd_soc_component_get_drvdata(c);
+
+	ucontrol->value.integer.value[0] = priv->gain;
+
+	return 0;
+}
+
+static const bool speaker_gain_table[4][2] = {
+	/* G1, G2 */
+	{true, true},	/* +6dB */
+	{false, true},	/* +12dB */
+	{true, false},	/* +18dB */
+	{false, false},	/* +24dB */
+};
+
+static int speaker_gain_control_put(struct snd_kcontrol *kcontrol,
+				    struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *c = snd_soc_kcontrol_component(kcontrol);
+	struct max9759 *priv = snd_soc_component_get_drvdata(c);
+
+	if (ucontrol->value.integer.value[0] > 3)
+		return -EINVAL;
+
+	priv->gain = ucontrol->value.integer.value[0];
+
+	/* G1 */
+	gpiod_set_value_cansleep(priv->gpiod_gain->desc[0],
+				 speaker_gain_table[priv->gain][0]);
+	/* G2 */
+	gpiod_set_value_cansleep(priv->gpiod_gain->desc[1],
+				 speaker_gain_table[priv->gain][1]);
+
+	return 1;
+}
+
+static int speaker_mute_get(struct snd_kcontrol *kcontrol,
+			    struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *c = snd_soc_kcontrol_component(kcontrol);
+	struct max9759 *priv = snd_soc_component_get_drvdata(c);
+
+	ucontrol->value.integer.value[0] = !priv->is_mute;
+
+	return 0;
+}
+
+static int speaker_mute_put(struct snd_kcontrol *kcontrol,
+			    struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *c = snd_soc_kcontrol_component(kcontrol);
+	struct max9759 *priv = snd_soc_component_get_drvdata(c);
+
+	priv->is_mute = !ucontrol->value.integer.value[0];
+
+	gpiod_set_value_cansleep(priv->gpiod_mute, priv->is_mute);
+
+	return 1;
+}
+
+static const struct snd_kcontrol_new max9759_dapm_controls[] = {
+	SOC_SINGLE_EXT_TLV("Speaker Gain Volume", 0, 0, 3, 0,
+			   speaker_gain_control_get, speaker_gain_control_put,
+			   speaker_gain_tlv),
+	SOC_SINGLE_BOOL_EXT("Playback Switch", 0,
+			    speaker_mute_get, speaker_mute_put),
+};
+
+static const struct snd_soc_dapm_widget max9759_dapm_widgets[] = {
+	SND_SOC_DAPM_INPUT("INL"),
+	SND_SOC_DAPM_INPUT("INR"),
+	SND_SOC_DAPM_PGA_E("PGA", SND_SOC_NOPM, 0, 0, NULL, 0, pga_event,
+			   (SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD)),
+	SND_SOC_DAPM_OUTPUT("OUTL"),
+	SND_SOC_DAPM_OUTPUT("OUTR"),
+};
+
+static const struct snd_soc_dapm_route max9759_dapm_routes[] = {
+	{ "PGA", NULL, "INL" },
+	{ "PGA", NULL, "INR" },
+	{ "OUTL", NULL, "PGA" },
+	{ "OUTR", NULL, "PGA" },
+};
+
+static const struct snd_soc_component_driver max9759_component_driver = {
+	.controls		= max9759_dapm_controls,
+	.num_controls		= ARRAY_SIZE(max9759_dapm_controls),
+	.dapm_widgets		= max9759_dapm_widgets,
+	.num_dapm_widgets	= ARRAY_SIZE(max9759_dapm_widgets),
+	.dapm_routes		= max9759_dapm_routes,
+	.num_dapm_routes	= ARRAY_SIZE(max9759_dapm_routes),
+};
+
+static int max9759_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct max9759 *priv;
+	int err;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, priv);
+
+	priv->gpiod_shutdown = devm_gpiod_get(dev, "shutdown", GPIOD_OUT_HIGH);
+	if (IS_ERR(priv->gpiod_shutdown)) {
+		err = PTR_ERR(priv->gpiod_shutdown);
+		if (err != -EPROBE_DEFER)
+			dev_err(dev, "Failed to get 'shutdown' gpio: %d", err);
+		return err;
+	}
+
+	priv->gpiod_mute = devm_gpiod_get(dev, "mute", GPIOD_OUT_HIGH);
+	if (IS_ERR(priv->gpiod_mute)) {
+		err = PTR_ERR(priv->gpiod_mute);
+		if (err != -EPROBE_DEFER)
+			dev_err(dev, "Failed to get 'mute' gpio: %d", err);
+		return err;
+	}
+	priv->is_mute = true;
+
+	priv->gpiod_gain = devm_gpiod_get_array(dev, "gain", GPIOD_OUT_HIGH);
+	if (IS_ERR(priv->gpiod_gain)) {
+		err = PTR_ERR(priv->gpiod_gain);
+		if (err != -EPROBE_DEFER)
+			dev_err(dev, "Failed to get 'gain' gpios: %d", err);
+		return err;
+	}
+	priv->gain = 0;
+
+	if (priv->gpiod_gain->ndescs != 2) {
+		dev_err(dev, "Invalid 'gain' gpios count: %d",
+			priv->gpiod_gain->ndescs);
+		return -EINVAL;
+	}
+
+	return devm_snd_soc_register_component(dev, &max9759_component_driver,
+					       NULL, 0);
+}
+
+#ifdef CONFIG_OF
+static const struct of_device_id max9759_ids[] = {
+	{ .compatible = "maxim,max9759", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, max9759_ids);
+#endif
+
+static struct platform_driver max9759_driver = {
+	.driver = {
+		.name = DRV_NAME,
+		.of_match_table = of_match_ptr(max9759_ids),
+	},
+	.probe = max9759_probe,
+};
+
+module_platform_driver(max9759_driver);
+
+MODULE_DESCRIPTION("ASoC MAX9759 amplifier driver");
+MODULE_AUTHOR("Neil Armstrong <narmstrong@baylibre.com>");
+MODULE_LICENSE("GPL");
-- 
2.16.1
