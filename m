From: Marco Felsch <m.felsch@pengutronix.de>
Subject: [PATCH v2] ASoC: ssm2305: Add amplifier driver
Date: Thu, 17 May 2018 15:00:47 +0200
Message-ID: <20180517130047.15565-1-m.felsch@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [85.220.165.71])
 by alsa0.perex.cz (Postfix) with ESMTP id B43AE26707F
 for <alsa-devel@alsa-project.org>; Thu, 17 May 2018 15:00:57 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: lars@metafoo.de, lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, kernel@pengutronix.de
List-Id: alsa-devel@alsa-project.org

The ssm2305 is a simple Class-D audio amplifier. A application can
turn on/off the device by a gpio. It's also possible to hardwire the
shutdown pin.

Tested on a i.MX6 based custom board.

Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
---

Notes (changelog):
    v2:
    - fix copyright information
    - rename shutdown gpio and add some more documentation
    - mark shutdown gpio as required
    - rm registration information

 .../devicetree/bindings/sound/adi,ssm2305.txt |  14 +++
 sound/soc/codecs/Kconfig                      |   7 ++
 sound/soc/codecs/Makefile                     |   2 +
 sound/soc/codecs/ssm2305.c                    | 105 ++++++++++++++++++
 4 files changed, 128 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/adi,ssm2305.txt
 create mode 100644 sound/soc/codecs/ssm2305.c

diff --git a/Documentation/devicetree/bindings/sound/adi,ssm2305.txt b/Documentation/devicetree/bindings/sound/adi,ssm2305.txt
new file mode 100644
index 000000000000..a9c9d83c8a30
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/adi,ssm2305.txt
@@ -0,0 +1,14 @@
+Analog Devices SSM2305 Speaker Amplifier
+========================================
+
+Required properties:
+  - compatible : "adi,ssm2305"
+  - shutdown-gpios : The gpio connected to the shutdown pin.
+                     The gpio signal is ACTIVE_LOW.
+
+Example:
+
+ssm2305: analog-amplifier {
+	compatible = "adi,ssm2305";
+	shutdown-gpios = <&gpio3 20 GPIO_ACTIVE_LOW>;
+};
diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 9548f63ca531..d81b0cb291a3 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -142,6 +142,7 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_SI476X if MFD_SI476X_CORE
 	select SND_SOC_SIRF_AUDIO_CODEC
 	select SND_SOC_SPDIF
+	select SND_SOC_SSM2305
 	select SND_SOC_SSM2518 if I2C
 	select SND_SOC_SSM2602_SPI if SPI_MASTER
 	select SND_SOC_SSM2602_I2C if I2C
@@ -883,6 +884,12 @@ config SND_SOC_SIRF_AUDIO_CODEC
 config SND_SOC_SPDIF
 	tristate "S/PDIF CODEC"
 
+config SND_SOC_SSM2305
+	tristate "Analog Devices SSM2305 Class-D Amplifier"
+	help
+	  Enable support for Analog Devices SSM2305 filterless
+	  high-efficiency mono Class-D audio power amplifiers.
+
 config SND_SOC_SSM2518
 	tristate
 
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index e849d1495308..7d75ac8f6716 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -153,6 +153,7 @@ snd-soc-si476x-objs := si476x.o
 snd-soc-sirf-audio-codec-objs := sirf-audio-codec.o
 snd-soc-spdif-tx-objs := spdif_transmitter.o
 snd-soc-spdif-rx-objs := spdif_receiver.o
+snd-soc-ssm2305-objs := ssm2305.o
 snd-soc-ssm2518-objs := ssm2518.o
 snd-soc-ssm2602-objs := ssm2602.o
 snd-soc-ssm2602-spi-objs := ssm2602-spi.o
@@ -404,6 +405,7 @@ obj-$(CONFIG_SND_SOC_SIGMADSP_REGMAP)	+= snd-soc-sigmadsp-regmap.o
 obj-$(CONFIG_SND_SOC_SI476X)	+= snd-soc-si476x.o
 obj-$(CONFIG_SND_SOC_SPDIF)	+= snd-soc-spdif-rx.o snd-soc-spdif-tx.o
 obj-$(CONFIG_SND_SOC_SIRF_AUDIO_CODEC) += sirf-audio-codec.o
+obj-$(CONFIG_SND_SOC_SSM2305)	+= snd-soc-ssm2305.o
 obj-$(CONFIG_SND_SOC_SSM2518)	+= snd-soc-ssm2518.o
 obj-$(CONFIG_SND_SOC_SSM2602)	+= snd-soc-ssm2602.o
 obj-$(CONFIG_SND_SOC_SSM2602_SPI)	+= snd-soc-ssm2602-spi.o
diff --git a/sound/soc/codecs/ssm2305.c b/sound/soc/codecs/ssm2305.c
new file mode 100644
index 000000000000..06ff649a1fd2
--- /dev/null
+++ b/sound/soc/codecs/ssm2305.c
@@ -0,0 +1,105 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Analog Devices SSM2305 Amplifier Driver
+ *
+ * Copyright (C) 2018 Pengutronix, Marco Felsch <kernel@pengutronix.de>
+ */
+
+#include <linux/gpio/consumer.h>
+#include <linux/module.h>
+#include <sound/soc.h>
+
+#define DRV_NAME "ssm2305"
+
+struct ssm2305 {
+	/* shutdown gpio  */
+	struct gpio_desc *gpiod_shutdown;
+};
+
+static int ssm2305_power_event(struct snd_soc_dapm_widget *w,
+			       struct snd_kcontrol *kctrl, int event)
+{
+	struct snd_soc_component *c = snd_soc_dapm_to_component(w->dapm);
+	struct ssm2305 *data = snd_soc_component_get_drvdata(c);
+
+	gpiod_set_value_cansleep(data->gpiod_shutdown,
+				 SND_SOC_DAPM_EVENT_ON(event));
+
+	return 0;
+}
+
+static const struct snd_soc_dapm_widget ssm2305_dapm_widgets[] = {
+	/* Stereo input/output */
+	SND_SOC_DAPM_INPUT("L_IN"),
+	SND_SOC_DAPM_INPUT("R_IN"),
+	SND_SOC_DAPM_OUTPUT("L_OUT"),
+	SND_SOC_DAPM_OUTPUT("R_OUT"),
+
+	SND_SOC_DAPM_SUPPLY("Power", SND_SOC_NOPM, 0, 0, ssm2305_power_event,
+			    SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
+};
+
+static const struct snd_soc_dapm_route ssm2305_dapm_routes[] = {
+	{ "L_OUT", NULL, "L_IN" },
+	{ "R_OUT", NULL, "R_IN" },
+	{ "L_IN", NULL, "Power" },
+	{ "R_IN", NULL, "Power" },
+};
+
+static const struct snd_soc_component_driver ssm2305_component_driver = {
+	.dapm_widgets		= ssm2305_dapm_widgets,
+	.num_dapm_widgets	= ARRAY_SIZE(ssm2305_dapm_widgets),
+	.dapm_routes		= ssm2305_dapm_routes,
+	.num_dapm_routes	= ARRAY_SIZE(ssm2305_dapm_routes),
+};
+
+static int ssm2305_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct ssm2305 *priv;
+	int err;
+
+	/* Allocate the private data */
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, priv);
+
+	/* Get shutdown gpio */
+	priv->gpiod_shutdown = devm_gpiod_get(dev, "shutdown",
+					      GPIOD_OUT_LOW);
+	if (IS_ERR(priv->gpiod_shutdown)) {
+		err = PTR_ERR(priv->gpiod_shutdown);
+		if (err != -EPROBE_DEFER) {
+			dev_err(dev, "Failed to get 'shutdown' gpio: %d\n",
+				err);
+			return err;
+		}
+	}
+
+	return devm_snd_soc_register_component(dev, &ssm2305_component_driver,
+					       NULL, 0);
+}
+
+#ifdef CONFIG_OF
+static const struct of_device_id ssm2305_of_match[] = {
+	{ .compatible = "adi,ssm2305", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, ssm2305_of_match);
+#endif
+
+static struct platform_driver ssm2305_driver = {
+	.driver = {
+		.name = DRV_NAME,
+		.of_match_table = of_match_ptr(ssm2305_of_match),
+	},
+	.probe = ssm2305_probe,
+};
+
+module_platform_driver(ssm2305_driver);
+
+MODULE_DESCRIPTION("ASoC SSM2305 amplifier driver");
+MODULE_AUTHOR("Marco Felsch <m.felsch@pengutronix.de>");
+MODULE_LICENSE("GPL v2");
-- 
2.17.0
