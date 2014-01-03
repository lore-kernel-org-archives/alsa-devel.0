From: RongJun Ying <rjying@gmail.com>
Subject: [PATCH v3 5/5] ASoC: sirf-inner: add mach driver for
	SiRFSoC internal codec
Date: Fri,  3 Jan 2014 14:05:04 +0800
Message-ID: <1388729104-28643-6-git-send-email-rongjun.ying@csr.com>
References: <1388729104-28643-1-git-send-email-rongjun.ying@csr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f171.google.com (mail-pd0-f171.google.com
 [209.85.192.171])
 by alsa0.perex.cz (Postfix) with ESMTP id 07EC42619D9
 for <alsa-devel@alsa-project.org>; Fri,  3 Jan 2014 07:08:00 +0100 (CET)
Received: by mail-pd0-f171.google.com with SMTP id z10so14957563pdj.30
 for <alsa-devel@alsa-project.org>; Thu, 02 Jan 2014 22:08:00 -0800 (PST)
In-Reply-To: <1388729104-28643-1-git-send-email-rongjun.ying@csr.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>, Rongjun Ying <Rongjun.Ying@csr.com>, alsa-devel@alsa-project.org, Workgroup.linux@csr.com
List-Id: alsa-devel@alsa-project.org

From: Rongjun Ying <Rongjun.Ying@csr.com>

This connects DMA, CPU DAI and Codec DAI together and works
as a mach driver.

Signed-off-by: Rongjun Ying <Rongjun.Ying@csr.com>
---
 -v3:
 Use devm_gpio_request_one instead of gpio_request.
 Remove the extcon stuff code.
 Add binding document
 Use the devm_snd_soc_register_card instead of soc-audio device register

 .../bindings/sound/sirf,inner-audio-codec.txt      |   41 +++++
 sound/soc/sirf/Kconfig                             |    5 +
 sound/soc/sirf/Makefile                            |    2 +
 sound/soc/sirf/sirf-inner.c                        |  155 ++++++++++++++++++++
 4 files changed, 203 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/sirf,inner-audio-codec.txt
 create mode 100644 sound/soc/sirf/sirf-inner.c

diff --git a/Documentation/devicetree/bindings/sound/sirf,inner-audio-codec.txt b/Documentation/devicetree/bindings/sound/sirf,inner-audio-codec.txt
new file mode 100644
index 0000000..67393e3
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/sirf,inner-audio-codec.txt
@@ -0,0 +1,41 @@
+* SiRF atlas6 and prima2 inner audio codec based audio setups
+
+Required properties:
+- compatible: "sirf,sirf-inner"
+- sirf,inner-platform: phandle for the platform node
+- sirf,inner-codec: phandle for the SiRF inner codec node
+
+Optional properties:
+- hp-pa-gpios: Need to be present if the board need control external
+  headphone amplifier.
+- spk-pa-gpios: Need to be present if the board need control external
+  speaker amplifier.
+- hp-switch-gpios: Need to be present if the board capable to detect jack
+  insertion, removal.
+
+Available audio endpoints for the audio-routing table:
+
+Board connectors:
+ * Headset Stereophone
+ * Ext Spk
+ * Line In
+ * Mic
+
+SiRF inner codec pins:
+ * HPOUTL
+ * HPOUTR
+ * SPKOUT
+ * Ext Mic
+ * Mic Bias
+
+Example:
+
+sound {
+		compatible = "sirf,sirf-inner";
+		sirf,inner-codec = <&audio>;
+		sirf,inner-platform = <&audio>;
+		hp-pa-gpios = <&gpio 44 0>;
+		spk-pa-gpios = <&gpio 46 0>;
+		hp-switch-gpios = <&gpio 45 0>;
+};
+
diff --git a/sound/soc/sirf/Kconfig b/sound/soc/sirf/Kconfig
index afa3952..564b0ec 100644
--- a/sound/soc/sirf/Kconfig
+++ b/sound/soc/sirf/Kconfig
@@ -11,3 +11,8 @@ config SND_SIRF_SOC_INNER
 
 config SND_SOC_SIRF_USP
 	tristate
+
+config SND_SIRF_INNER
+	tristate "SoC Audio support for SiRF inner codec of SiRF EVB"
+	depends on SND_SIRF_SOC
+	select SND_SIRF_SOC_INNER
diff --git a/sound/soc/sirf/Makefile b/sound/soc/sirf/Makefile
index 8517c67..80abdf6 100644
--- a/sound/soc/sirf/Makefile
+++ b/sound/soc/sirf/Makefile
@@ -1,9 +1,11 @@
 snd-soc-sirf-objs := sirf-pcm.o
+snd-soc-sirf-inner-objs := sirf-inner.o
 snd-soc-sirf-soc-inner-objs := sirf-soc-inner.o
 snd-soc-sirf-i2s-objs := sirf-i2s.o
 snd-soc-sirf-usp-objs := sirf-usp.o
 
 obj-$(CONFIG_SND_SIRF_SOC) += snd-soc-sirf.o
+obj-$(CONFIG_SND_SIRF_INNER) += snd-soc-sirf-inner.o
 obj-$(CONFIG_SND_SIRF_SOC_INNER) += snd-soc-sirf-soc-inner.o
 obj-$(CONFIG_SND_SOC_SIRF_I2S) += snd-soc-sirf-i2s.o
 obj-$(CONFIG_SND_SOC_SIRF_USP) += snd-soc-sirf-usp.o
diff --git a/sound/soc/sirf/sirf-inner.c b/sound/soc/sirf/sirf-inner.c
new file mode 100644
index 0000000..1a10c55
--- /dev/null
+++ b/sound/soc/sirf/sirf-inner.c
@@ -0,0 +1,155 @@
+/*
+ * SiRF inner audio device driver
+ *
+ * Copyright (c) 2011 Cambridge Silicon Radio Limited, a CSR plc group company.
+ *
+ * Licensed under GPLv2 or later.
+ */
+
+#include <linux/platform_device.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/gpio.h>
+#include <linux/of_gpio.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/soc.h>
+
+struct sirf_inner_card {
+	unsigned int            gpio_hp_pa;
+	unsigned int            gpio_spk_pa;
+};
+
+static int sirf_inner_hp_event(struct snd_soc_dapm_widget *w,
+				struct snd_kcontrol *ctrl, int event)
+{
+	struct snd_soc_dapm_context *dapm = w->dapm;
+	struct snd_soc_card *card = dapm->card;
+	struct sirf_inner_card *sinner_card = snd_soc_card_get_drvdata(card);
+	int on = !SND_SOC_DAPM_EVENT_OFF(event);
+	if (gpio_is_valid(sinner_card->gpio_hp_pa))
+		gpio_set_value(sinner_card->gpio_hp_pa, on);
+	return 0;
+}
+
+static int sirf_inner_spk_event(struct snd_soc_dapm_widget *w,
+				struct snd_kcontrol *ctrl, int event)
+{
+	struct snd_soc_dapm_context *dapm = w->dapm;
+	struct snd_soc_card *card = dapm->card;
+	struct sirf_inner_card *sinner_card = snd_soc_card_get_drvdata(card);
+	int on = !SND_SOC_DAPM_EVENT_OFF(event);
+
+	if (gpio_is_valid(sinner_card->gpio_spk_pa))
+		gpio_set_value(sinner_card->gpio_spk_pa, on);
+
+	return 0;
+}
+static const struct snd_soc_dapm_widget sirf_inner_dapm_widgets[] = {
+	SND_SOC_DAPM_HP("Hp", sirf_inner_hp_event),
+	SND_SOC_DAPM_SPK("Ext Spk", sirf_inner_spk_event),
+	SND_SOC_DAPM_MIC("Ext Mic", NULL),
+};
+
+static const struct snd_soc_dapm_route intercon[] = {
+	{"Hp", NULL, "HPOUTL"},
+	{"Hp", NULL, "HPOUTR"},
+	{"Ext Spk", NULL, "SPKOUT"},
+	{"MICIN1", NULL, "Mic Bias"},
+	{"Mic Bias", NULL, "Ext Mic"},
+};
+
+/* Digital audio interface glue - connects codec <--> CPU */
+static struct snd_soc_dai_link sirf_inner_dai_links[] = {
+	{
+		.name = "SiRF inner",
+		.stream_name = "SiRF inner",
+		.codec_dai_name = "sirf-soc-inner",
+		.platform_name = "sirf-pcm-audio.1",
+	},
+};
+
+/* Audio machine driver */
+static struct snd_soc_card snd_soc_sirf_inner_card = {
+	.name = "SiRF inner",
+	.owner = THIS_MODULE,
+	.dai_link = sirf_inner_dai_links,
+	.num_links = ARRAY_SIZE(sirf_inner_dai_links),
+	.dapm_widgets = sirf_inner_dapm_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(sirf_inner_dapm_widgets),
+	.dapm_routes = intercon,
+	.num_dapm_routes = ARRAY_SIZE(intercon),
+};
+
+static int sirf_inner_probe(struct platform_device *pdev)
+{
+	struct snd_soc_card *card = &snd_soc_sirf_inner_card;
+	struct sirf_inner_card *sinner_card;
+	int ret;
+
+	sinner_card = devm_kzalloc(&pdev->dev, sizeof(struct sirf_inner_card),
+			GFP_KERNEL);
+	if (sinner_card == NULL)
+		return -ENOMEM;
+
+	sirf_inner_dai_links[0].cpu_of_node =
+		of_parse_phandle(pdev->dev.of_node, "sirf,inner-platform", 0);
+	sirf_inner_dai_links[0].codec_of_node =
+		of_parse_phandle(pdev->dev.of_node, "sirf,inner-codec", 0);
+	sinner_card->gpio_spk_pa = of_get_named_gpio(pdev->dev.of_node,
+			"spk-pa-gpios", 0);
+	sinner_card->gpio_hp_pa =  of_get_named_gpio(pdev->dev.of_node,
+			"hp-pa-gpios", 0);
+	if (gpio_is_valid(sinner_card->gpio_spk_pa)) {
+		ret = devm_gpio_request_one(&pdev->dev,
+				sinner_card->gpio_spk_pa,
+				GPIOF_OUT_INIT_LOW, "SPA_PA_SD");
+		if (ret) {
+			dev_err(&pdev->dev,
+				"Failed to request GPIO_%d for reset: %d\n",
+				sinner_card->gpio_spk_pa, ret);
+			return ret;
+		}
+	}
+	if (gpio_is_valid(sinner_card->gpio_hp_pa)) {
+		ret = devm_gpio_request_one(&pdev->dev,
+				sinner_card->gpio_hp_pa,
+				GPIOF_OUT_INIT_LOW, "HP_PA_SD");
+		if (ret) {
+			dev_err(&pdev->dev,
+				"Failed to request GPIO_%d for reset: %d\n",
+				sinner_card->gpio_hp_pa, ret);
+			return ret;
+		}
+	}
+
+	card->dev = &pdev->dev;
+	snd_soc_card_set_drvdata(card, sinner_card);
+
+	ret = devm_snd_soc_register_card(&pdev->dev, card);
+	if (ret)
+		dev_err(&pdev->dev, "snd_soc_register_card() failed:%d\n", ret);
+
+	return ret;
+}
+
+static const struct of_device_id sirf_inner_of_match[] = {
+	{.compatible = "sirf,sirf-inner", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, sirf_inner_of_match);
+
+static struct platform_driver sirf_inner_driver = {
+	.driver = {
+		.name = "sirf-inner",
+		.owner = THIS_MODULE,
+		.pm = &snd_soc_pm_ops,
+		.of_match_table = sirf_inner_of_match,
+	},
+	.probe = sirf_inner_probe,
+};
+module_platform_driver(sirf_inner_driver);
+
+MODULE_AUTHOR("RongJun Ying <RongJun.Ying@csr.com>");
+MODULE_DESCRIPTION("ALSA SoC SIRF inner AUDIO driver");
+MODULE_LICENSE("GPL v2");
-- 
1.7.5.4
