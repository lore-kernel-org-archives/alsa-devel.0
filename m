From: Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCH 2/3] ASoC: dio2125: add dio2125 amp driver
Date: Mon,  6 Mar 2017 18:44:50 +0100
Message-ID: <20170306174451.24406-3-jbrunet@baylibre.com>
References: <20170306174451.24406-1-jbrunet@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f49.google.com (mail-wm0-f49.google.com [74.125.82.49])
 by alsa0.perex.cz (Postfix) with ESMTP id 8493C266DD4
 for <alsa-devel@alsa-project.org>; Mon,  6 Mar 2017 18:45:05 +0100 (CET)
Received: by mail-wm0-f49.google.com with SMTP id v186so70308914wmd.0
 for <alsa-devel@alsa-project.org>; Mon, 06 Mar 2017 09:45:05 -0800 (PST)
In-Reply-To: <20170306174451.24406-1-jbrunet@baylibre.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Kevin Hilman <khilman@baylibre.com>, alsa-devel@alsa-project.org, Neil Armstrong <narmstrong@baylibre.com>, linux-kernel@vger.kernel.org, Jerome Brunet <jbrunet@baylibre.com>
List-Id: alsa-devel@alsa-project.org

The dio2125 is a stereo output driver with adjustable gain.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 sound/soc/codecs/Kconfig   |   5 ++
 sound/soc/codecs/Makefile  |   2 +
 sound/soc/codecs/dio2125.c | 120 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 127 insertions(+)
 create mode 100644 sound/soc/codecs/dio2125.c

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 7c7c2e96b836..09c187504e7c 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -69,6 +69,7 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_DA7219 if I2C
 	select SND_SOC_DA732X if I2C
 	select SND_SOC_DA9055 if I2C
+	select SND_SOC_DIO2125
 	select SND_SOC_DMIC
 	select SND_SOC_ES8328_SPI if SPI_MASTER
 	select SND_SOC_ES8328_I2C if I2C
@@ -517,6 +518,10 @@ config SND_SOC_DA732X
 config SND_SOC_DA9055
 	tristate
 
+config SND_SOC_DIO2125
+	tristate "Dioo DIO2125 Amplifier"
+	select GPIOLIB
+
 config SND_SOC_DMIC
 	tristate
 
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index b65868c963c9..0db0ffc1e552 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -222,6 +222,7 @@ snd-soc-wm9712-objs := wm9712.o
 snd-soc-wm9713-objs := wm9713.o
 snd-soc-wm-hubs-objs := wm_hubs.o
 # Amp
+snd-soc-dio2125-objs := dio2125.o
 snd-soc-max9877-objs := max9877.o
 snd-soc-max98504-objs := max98504.o
 snd-soc-tpa6130a2-objs := tpa6130a2.o
@@ -450,6 +451,7 @@ obj-$(CONFIG_SND_SOC_WM_ADSP)	+= snd-soc-wm-adsp.o
 obj-$(CONFIG_SND_SOC_WM_HUBS)	+= snd-soc-wm-hubs.o
 
 # Amp
+obj-$(CONFIG_SND_SOC_DIO2125)	+= snd-soc-dio2125.o
 obj-$(CONFIG_SND_SOC_MAX9877)	+= snd-soc-max9877.o
 obj-$(CONFIG_SND_SOC_MAX98504)	+= snd-soc-max98504.o
 obj-$(CONFIG_SND_SOC_TPA6130A2)	+= snd-soc-tpa6130a2.o
diff --git a/sound/soc/codecs/dio2125.c b/sound/soc/codecs/dio2125.c
new file mode 100644
index 000000000000..015e310556d3
--- /dev/null
+++ b/sound/soc/codecs/dio2125.c
@@ -0,0 +1,120 @@
+/*
+ * Copyright (c) 2017 BayLibre, SAS.
+ * Author: Jerome Brunet <jbrunet@baylibre.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of version 2 of the GNU General Public License as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ * The full GNU General Public License is included in this distribution
+ * in the file called COPYING.
+ */
+
+#include <linux/gpio/consumer.h>
+#include <linux/module.h>
+#include <sound/soc.h>
+
+#define DRV_NAME "dio2125"
+
+struct dio2125 {
+	struct gpio_desc *gpiod_enable;
+};
+
+static int drv_event(struct snd_soc_dapm_widget *w,
+		     struct snd_kcontrol *control, int event)
+{
+	struct snd_soc_component *c = snd_soc_dapm_to_component(w->dapm);
+	struct dio2125 *priv = snd_soc_component_get_drvdata(c);
+	int val;
+
+	switch (event) {
+	case SND_SOC_DAPM_POST_PMU:
+		val = 1;
+		break;
+	case SND_SOC_DAPM_PRE_PMD:
+		val = 0;
+		break;
+	default:
+		WARN(1, "Unexpected event");
+		return -EINVAL;
+	}
+
+	gpiod_set_value(priv->gpiod_enable, val);
+
+	return 0;
+}
+
+static const struct snd_soc_dapm_widget dio2125_dapm_widgets[] = {
+	SND_SOC_DAPM_INPUT("INL"),
+	SND_SOC_DAPM_INPUT("INR"),
+	SND_SOC_DAPM_OUT_DRV_E("DRV", SND_SOC_NOPM, 0, 0, NULL, 0, drv_event,
+			       (SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD)),
+	SND_SOC_DAPM_OUTPUT("OUTL"),
+	SND_SOC_DAPM_OUTPUT("OUTR"),
+};
+
+static const struct snd_soc_dapm_route dio2125_dapm_routes[] = {
+	{ "DRV", NULL, "INL" },
+	{ "DRV", NULL, "INR" },
+	{ "OUTL", NULL, "DRV" },
+	{ "OUTR", NULL, "DRV" },
+};
+
+static const struct snd_soc_component_driver dio2125_component_driver = {
+	.dapm_widgets		= dio2125_dapm_widgets,
+	.num_dapm_widgets	= ARRAY_SIZE(dio2125_dapm_widgets),
+	.dapm_routes		= dio2125_dapm_routes,
+	.num_dapm_routes	= ARRAY_SIZE(dio2125_dapm_routes),
+};
+
+static int dio2125_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct dio2125 *priv;
+	int err;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (priv == NULL)
+		return -ENOMEM;
+	platform_set_drvdata(pdev, priv);
+
+	priv->gpiod_enable = devm_gpiod_get(dev, "enable", GPIOD_OUT_LOW);
+	if (IS_ERR(priv->gpiod_enable)) {
+		err = PTR_ERR(priv->gpiod_enable);
+		if (err != -EPROBE_DEFER)
+			dev_err(dev, "Failed to get 'enable' gpio: %d", err);
+		return err;
+	}
+
+	return devm_snd_soc_register_component(dev, &dio2125_component_driver,
+					       NULL, 0);
+}
+
+#ifdef CONFIG_OF
+static const struct of_device_id dio2125_ids[] = {
+	{ .compatible = "dioo,dio2125", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, dio2125_ids);
+#endif
+
+static struct platform_driver dio2125_driver = {
+	.driver = {
+		.name = DRV_NAME,
+		.of_match_table = of_match_ptr(dio2125_ids),
+	},
+	.probe = dio2125_probe,
+};
+
+module_platform_driver(dio2125_driver);
+
+MODULE_DESCRIPTION("ASoC DIO2125 output driver");
+MODULE_AUTHOR("Jerome Brunet <jbrunet@baylibre.com>");
+MODULE_LICENSE("GPL");
-- 
2.9.3
