From: RongJun Ying <rjying@gmail.com>
Subject: [PATCH v4 3/7] ASoC: sirf: Add SiRF audio card
Date: Wed, 26 Feb 2014 14:04:51 +0800
Message-ID: <1393394695-29735-4-git-send-email-rongjun.ying@csr.com>
References: <1393394695-29735-1-git-send-email-rongjun.ying@csr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f179.google.com (mail-pd0-f179.google.com
 [209.85.192.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 544E4261A1B
 for <alsa-devel@alsa-project.org>; Wed, 26 Feb 2014 07:07:15 +0100 (CET)
Received: by mail-pd0-f179.google.com with SMTP id w10so497813pde.24
 for <alsa-devel@alsa-project.org>; Tue, 25 Feb 2014 22:07:14 -0800 (PST)
In-Reply-To: <1393394695-29735-1-git-send-email-rongjun.ying@csr.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, rjying@gmail.com
Cc: Takashi Iwai <tiwai@suse.de>, Rongjun Ying <rongjun.ying@csr.com>, alsa-devel@alsa-project.org, workgroup.linux@csr.com
List-Id: alsa-devel@alsa-project.org

From: Rongjun Ying <rongjun.ying@csr.com>

The SiRF audio card driver link SiRF internal audio codec with
SiRF audio port.

Signed-off-by: Rongjun Ying <rongjun.ying@csr.com>
---
 .../devicetree/bindings/sound/sirf-audio.txt       |   41 +++++
 sound/soc/sirf/Kconfig                             |    5 +
 sound/soc/sirf/Makefile                            |    2 +
 sound/soc/sirf/sirf-audio.c                        |  156 ++++++++++++++++++++
 4 files changed, 204 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/sirf-audio.txt
 create mode 100644 sound/soc/sirf/sirf-audio.c

diff --git a/Documentation/devicetree/bindings/sound/sirf-audio.txt b/Documentation/devicetree/bindings/sound/sirf-audio.txt
new file mode 100644
index 0000000..c88882c
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/sirf-audio.txt
@@ -0,0 +1,41 @@
+* SiRF atlas6 and prima2 internal audio codec and port based audio setups
+
+Required properties:
+- compatible: "sirf,sirf-audio-card"
+- sirf,audio-platform: phandle for the platform node
+- sirf,audio-codec: phandle for the SiRF internal codec node
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
+SiRF internal audio codec pins:
+ * HPOUTL
+ * HPOUTR
+ * SPKOUT
+ * Ext Mic
+ * Mic Bias
+
+Example:
+
+sound {
+		compatible = "sirf,sirf-audio-card";
+		sirf,audio-codec = <&audiocodec>;
+		sirf,audio-platform = <&audioport>;
+		hp-pa-gpios = <&gpio 44 0>;
+		spk-pa-gpios = <&gpio 46 0>;
+		hp-switch-gpios = <&gpio 45 0>;
+};
+
diff --git a/sound/soc/sirf/Kconfig b/sound/soc/sirf/Kconfig
index 5b5407f..a8e083b 100644
--- a/sound/soc/sirf/Kconfig
+++ b/sound/soc/sirf/Kconfig
@@ -7,3 +7,8 @@ config SND_SOC_SIRF_AUDIO_PORT
 	select REGMAP_MMIO
 	tristate
 
+config SND_SOC_SIRF_AUDIO
+	tristate "SoC Audio support for SiRF internal audio codec"
+	depends on SND_SOC_SIRF
+	select SND_SOC_SIRF_AUDIO_CODEC
+	select SND_SOC_SIRF_AUDIO_PORT
diff --git a/sound/soc/sirf/Makefile b/sound/soc/sirf/Makefile
index fb012c8..4eea904 100644
--- a/sound/soc/sirf/Makefile
+++ b/sound/soc/sirf/Makefile
@@ -1,3 +1,5 @@
 snd-soc-sirf-audio-port-objs := sirf-audio-port.o
+snd-soc-sirf-audio-objs := sirf-audio.o
 
 obj-$(CONFIG_SND_SOC_SIRF_AUDIO_PORT) += snd-soc-sirf-audio-port.o
+obj-$(CONFIG_SND_SOC_SIRF_AUDIO) += snd-soc-sirf-audio.o
diff --git a/sound/soc/sirf/sirf-audio.c b/sound/soc/sirf/sirf-audio.c
new file mode 100644
index 0000000..ecef510
--- /dev/null
+++ b/sound/soc/sirf/sirf-audio.c
@@ -0,0 +1,156 @@
+/*
+ * SiRF audio card driver
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
+struct sirf_audio_card {
+	unsigned int            gpio_hp_pa;
+	unsigned int            gpio_spk_pa;
+};
+
+static int sirf_audio_hp_event(struct snd_soc_dapm_widget *w,
+				struct snd_kcontrol *ctrl, int event)
+{
+	struct snd_soc_dapm_context *dapm = w->dapm;
+	struct snd_soc_card *card = dapm->card;
+	struct sirf_audio_card *sirf_audio_card = snd_soc_card_get_drvdata(card);
+	int on = !SND_SOC_DAPM_EVENT_OFF(event);
+	if (gpio_is_valid(sirf_audio_card->gpio_hp_pa))
+		gpio_set_value(sirf_audio_card->gpio_hp_pa, on);
+	return 0;
+}
+
+static int sirf_audio_spk_event(struct snd_soc_dapm_widget *w,
+				struct snd_kcontrol *ctrl, int event)
+{
+	struct snd_soc_dapm_context *dapm = w->dapm;
+	struct snd_soc_card *card = dapm->card;
+	struct sirf_audio_card *sirf_audio_card = snd_soc_card_get_drvdata(card);
+	int on = !SND_SOC_DAPM_EVENT_OFF(event);
+
+	if (gpio_is_valid(sirf_audio_card->gpio_spk_pa))
+		gpio_set_value(sirf_audio_card->gpio_spk_pa, on);
+
+	return 0;
+}
+static const struct snd_soc_dapm_widget sirf_audio_dapm_widgets[] = {
+	SND_SOC_DAPM_HP("Hp", sirf_audio_hp_event),
+	SND_SOC_DAPM_SPK("Ext Spk", sirf_audio_spk_event),
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
+static struct snd_soc_dai_link sirf_audio_dai_link[] = {
+	{
+		.name = "SiRF audio card",
+		.stream_name = "SiRF audio HiFi",
+		.codec_dai_name = "sirf-audio-codec",
+	},
+};
+
+/* Audio machine driver */
+static struct snd_soc_card snd_soc_sirf_audio_card = {
+	.name = "SiRF audio card",
+	.owner = THIS_MODULE,
+	.dai_link = sirf_audio_dai_link,
+	.num_links = ARRAY_SIZE(sirf_audio_dai_link),
+	.dapm_widgets = sirf_audio_dapm_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(sirf_audio_dapm_widgets),
+	.dapm_routes = intercon,
+	.num_dapm_routes = ARRAY_SIZE(intercon),
+};
+
+static int sirf_audio_probe(struct platform_device *pdev)
+{
+	struct snd_soc_card *card = &snd_soc_sirf_audio_card;
+	struct sirf_audio_card *sirf_audio_card;
+	int ret;
+
+	sirf_audio_card = devm_kzalloc(&pdev->dev, sizeof(struct sirf_audio_card),
+			GFP_KERNEL);
+	if (sirf_audio_card == NULL)
+		return -ENOMEM;
+
+	sirf_audio_dai_link[0].cpu_of_node =
+		of_parse_phandle(pdev->dev.of_node, "sirf,audio-platform", 0);
+	sirf_audio_dai_link[0].platform_of_node =
+		of_parse_phandle(pdev->dev.of_node, "sirf,audio-platform", 0);
+	sirf_audio_dai_link[0].codec_of_node =
+		of_parse_phandle(pdev->dev.of_node, "sirf,audio-codec", 0);
+	sirf_audio_card->gpio_spk_pa = of_get_named_gpio(pdev->dev.of_node,
+			"spk-pa-gpios", 0);
+	sirf_audio_card->gpio_hp_pa =  of_get_named_gpio(pdev->dev.of_node,
+			"hp-pa-gpios", 0);
+	if (gpio_is_valid(sirf_audio_card->gpio_spk_pa)) {
+		ret = devm_gpio_request_one(&pdev->dev,
+				sirf_audio_card->gpio_spk_pa,
+				GPIOF_OUT_INIT_LOW, "SPA_PA_SD");
+		if (ret) {
+			dev_err(&pdev->dev,
+				"Failed to request GPIO_%d for reset: %d\n",
+				sirf_audio_card->gpio_spk_pa, ret);
+			return ret;
+		}
+	}
+	if (gpio_is_valid(sirf_audio_card->gpio_hp_pa)) {
+		ret = devm_gpio_request_one(&pdev->dev,
+				sirf_audio_card->gpio_hp_pa,
+				GPIOF_OUT_INIT_LOW, "HP_PA_SD");
+		if (ret) {
+			dev_err(&pdev->dev,
+				"Failed to request GPIO_%d for reset: %d\n",
+				sirf_audio_card->gpio_hp_pa, ret);
+			return ret;
+		}
+	}
+
+	card->dev = &pdev->dev;
+	snd_soc_card_set_drvdata(card, sirf_audio_card);
+
+	ret = devm_snd_soc_register_card(&pdev->dev, card);
+	if (ret)
+		dev_err(&pdev->dev, "snd_soc_register_card() failed:%d\n", ret);
+
+	return ret;
+}
+
+static const struct of_device_id sirf_audio_of_match[] = {
+	{.compatible = "sirf,sirf-audio-card", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, sirf_audio_of_match);
+
+static struct platform_driver sirf_audio_driver = {
+	.driver = {
+		.name = "sirf-audio-card",
+		.owner = THIS_MODULE,
+		.pm = &snd_soc_pm_ops,
+		.of_match_table = sirf_audio_of_match,
+	},
+	.probe = sirf_audio_probe,
+};
+module_platform_driver(sirf_audio_driver);
+
+MODULE_AUTHOR("RongJun Ying <RongJun.Ying@csr.com>");
+MODULE_DESCRIPTION("ALSA SoC SIRF audio card driver");
+MODULE_LICENSE("GPL v2");
-- 
1.7.5.4
