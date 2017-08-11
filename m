From: srinivas.kandagatla@linaro.org
Subject: [RFC PATCH 6/9] ASoC: qcom: qdsp6v2: Add support to q6
	HDMI dai driver
Date: Fri, 11 Aug 2017 15:29:49 +0200
Message-ID: <20170811132952.32572-7-srinivas.kandagatla@linaro.org>
References: <20170811132952.32572-1-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-it0-f44.google.com (mail-it0-f44.google.com
 [209.85.214.44])
 by alsa0.perex.cz (Postfix) with ESMTP id E63CE267665
 for <alsa-devel@alsa-project.org>; Fri, 11 Aug 2017 15:30:16 +0200 (CEST)
Received: by mail-it0-f44.google.com with SMTP id f16so1670917itb.0
 for <alsa-devel@alsa-project.org>; Fri, 11 Aug 2017 06:30:16 -0700 (PDT)
In-Reply-To: <20170811132952.32572-1-srinivas.kandagatla@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Banajit Goswami <bgoswami@codeaurora.org>, alsa-devel@alsa-project.org
Cc: kwestfie@codeaurora.org, linux-arm-msm@vger.kernel.org, Patrick Lai <plai@codeaurora.org>, sboyd@codeaurora.org, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, lkasam@qti.qualcomm.com
List-Id: alsa-devel@alsa-project.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

This patch adds support to HDMI backend dai driver.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 .../devicetree/bindings/sound/qcom,q6hdmi.txt      |  27 +++
 sound/soc/qcom/Kconfig                             |   4 +
 sound/soc/qcom/qdsp6v2/Makefile                    |   1 +
 sound/soc/qcom/qdsp6v2/q6hdmi.c                    | 258 +++++++++++++++++++++
 4 files changed, 290 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,q6hdmi.txt
 create mode 100644 sound/soc/qcom/qdsp6v2/q6hdmi.c

diff --git a/Documentation/devicetree/bindings/sound/qcom,q6hdmi.txt b/Documentation/devicetree/bindings/sound/qcom,q6hdmi.txt
new file mode 100644
index 0000000..a38f58a
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/qcom,q6hdmi.txt
@@ -0,0 +1,27 @@
+Qualcomm Q6 HDMI DAI binding
+
+This bindings describe the Qualcomm Q6 HDMI dai.
+
+- compatible:
+
+	Usage: required
+	Value type: <stringlist>
+	Definition: must be "qcom,q6hdmi-v<VERSION-NUMBER>"
+		    example: "qcom,q6hdmi-v2"
+- qcom,afe-port:
+	Usage: required
+	Value type: <prop-encoded-array>
+	Definition: handle to AFE port
+
+#sound-dai-cells:
+	Usage: required
+	Value type: <integer>
+	Definition: Must be equal to 0
+
+
+= EXAMPLE
+	q6hdmi {
+		compatible = "qcom,q6hdmi-v2";
+		qcom,afe-port = <&afe AFE_PORT_HDMI_RX>;
+		#sound-dai-cells = <0>;
+	};
diff --git a/sound/soc/qcom/Kconfig b/sound/soc/qcom/Kconfig
index 9a5b3f0..5035d37 100644
--- a/sound/soc/qcom/Kconfig
+++ b/sound/soc/qcom/Kconfig
@@ -60,6 +60,9 @@ config SND_SOC_QDSP6V2_ROUTING
 	tristate
 	default n
 
+config SND_SOC_QDSP6V2_HDMI
+	tristate
+	default n
 
 config SND_SOC_QDSP6V2
 	tristate "SoC ALSA audio driver for QDSP6V2"
@@ -67,6 +70,7 @@ config SND_SOC_QDSP6V2
 	select SND_SOC_QDSP6V2_ADM
 	select SND_SOC_QDSP6V2_ASM
 	select SND_SOC_QDSP6V2_ROUTING
+	select SND_SOC_QDSP6V2_HDMI
 	help
 	 To add support for MSM QDSP6V2 Soc Audio.
 	 This will enable sound soc platform specific
diff --git a/sound/soc/qcom/qdsp6v2/Makefile b/sound/soc/qcom/qdsp6v2/Makefile
index 81d2341..4cab915 100644
--- a/sound/soc/qcom/qdsp6v2/Makefile
+++ b/sound/soc/qcom/qdsp6v2/Makefile
@@ -2,3 +2,4 @@ obj-$(CONFIG_SND_SOC_QDSP6V2_AFE) += q6afe.o
 obj-$(CONFIG_SND_SOC_QDSP6V2_ADM) += q6adm.o
 obj-$(CONFIG_SND_SOC_QDSP6V2_ASM) += q6asm.o
 obj-$(CONFIG_SND_SOC_QDSP6V2_ROUTING) += q6routing.o
+obj-$(CONFIG_SND_SOC_QDSP6V2_HDMI) += q6hdmi.o
diff --git a/sound/soc/qcom/qdsp6v2/q6hdmi.c b/sound/soc/qcom/qdsp6v2/q6hdmi.c
new file mode 100644
index 0000000..020a377
--- /dev/null
+++ b/sound/soc/qcom/qdsp6v2/q6hdmi.c
@@ -0,0 +1,258 @@
+/* Copyright (c) 2012-2015, The Linux Foundation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 and
+ * only version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+#include <linux/err.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <sound/pcm.h>
+#include <sound/soc.h>
+#include <sound/pcm_params.h>
+#include <dt-bindings/sound/qcom,afe.h>
+#include "q6afe-v2.h"
+
+struct q6hdmi_dai_data {
+	struct q6afe_port *port;
+	struct q6afe_hdmi_cfg port_config;
+	bool is_port_started;
+};
+
+static int q6hdmi_format_put(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_value *ucontrol)
+{
+	struct q6hdmi_dai_data *dai_data = kcontrol->private_data;
+	int value = ucontrol->value.integer.value[0];
+
+	dai_data->port_config.datatype = value;
+
+	return 0;
+}
+
+static int q6hdmi_format_get(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_value *ucontrol)
+{
+
+	struct q6hdmi_dai_data *dai_data = kcontrol->private_data;
+
+	ucontrol->value.integer.value[0] =
+		dai_data->port_config.datatype;
+
+	return 0;
+}
+
+static const char * const hdmi_format[] = {
+	"LPCM",
+	"Compr"
+};
+
+static const struct soc_enum hdmi_config_enum[] = {
+	SOC_ENUM_SINGLE_EXT(2, hdmi_format),
+};
+
+static const struct snd_kcontrol_new hdmi_config_controls[] = {
+	SOC_ENUM_EXT("HDMI RX Format", hdmi_config_enum[0],
+				 q6hdmi_format_get,
+				 q6hdmi_format_put),
+};
+
+static int q6hdmi_hw_params(struct snd_pcm_substream *substream,
+				struct snd_pcm_hw_params *params,
+				struct snd_soc_dai *dai)
+{
+	struct q6hdmi_dai_data *dai_data = dev_get_drvdata(dai->dev);
+	int channels = params_channels(params);
+
+	dai_data->port_config.sample_rate = params_rate(params);
+	switch (params_format(params)) {
+	case SNDRV_PCM_FORMAT_S16_LE:
+		dai_data->port_config.bit_width = 16;
+		break;
+	case SNDRV_PCM_FORMAT_S24_LE:
+		dai_data->port_config.bit_width = 24;
+		break;
+	}
+
+	/*refer to HDMI spec CEA-861-E: Table 28 Audio InfoFrame Data Byte 4*/
+	switch (channels) {
+	case 2:
+		dai_data->port_config.channel_allocation = 0;
+		break;
+	case 3:
+		dai_data->port_config.channel_allocation = 0x02;
+		break;
+	case 4:
+		dai_data->port_config.channel_allocation = 0x06;
+		break;
+	case 5:
+		dai_data->port_config.channel_allocation = 0x0A;
+		break;
+	case 6:
+		dai_data->port_config.channel_allocation = 0x0B;
+		break;
+	case 7:
+		dai_data->port_config.channel_allocation = 0x12;
+		break;
+	case 8:
+		dai_data->port_config.channel_allocation = 0x13;
+		break;
+	default:
+		dev_err(dai->dev, "invalid Channels = %u\n", channels);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int q6hdmi_startup(struct snd_pcm_substream *substream,
+				struct snd_soc_dai *dai)
+{
+	struct q6hdmi_dai_data *dai_data = dev_get_drvdata(dai->dev);
+
+	dai_data->is_port_started = false;
+
+	return 0;
+}
+
+static void q6hdmi_shutdown(struct snd_pcm_substream *substream,
+				struct snd_soc_dai *dai)
+{
+	struct q6hdmi_dai_data *dai_data = dev_get_drvdata(dai->dev);
+	int rc;
+
+	rc = q6afe_port_stop(dai_data->port);
+	if (rc < 0)
+		dev_err(dai->dev, "fail to close AFE port\n");
+
+	dai_data->is_port_started = false;
+
+}
+
+static int q6hdmi_prepare(struct snd_pcm_substream *substream,
+		struct snd_soc_dai *dai)
+{
+	struct q6hdmi_dai_data *dai_data = dev_get_drvdata(dai->dev);
+	int rc;
+
+
+	if (dai_data->is_port_started) {
+		/* stop the port and restart with new port config */
+		rc = q6afe_port_stop(dai_data->port); /* can block */
+		if (rc < 0) {
+			dev_err(dai->dev, "fail to close AFE port\n");
+			return rc;
+		}
+	}
+
+	rc = q6afe_hdmi_port_start(dai_data->port, &dai_data->port_config);
+	if (rc < 0) {
+		dev_err(dai->dev, "fail to open AFE port %x\n",	dai->id);
+		return rc;
+	}
+
+	dai_data->is_port_started = true;
+
+	return 0;
+}
+
+static const struct snd_soc_dapm_route hdmi_dapm_routes[] = {
+	{"HDMI Playback", NULL, "HDMI"},
+};
+
+static struct snd_soc_dai_ops q6hdmi_ops = {
+	.prepare	= q6hdmi_prepare,
+	.hw_params	= q6hdmi_hw_params,
+	.shutdown	= q6hdmi_shutdown,
+	.startup	= q6hdmi_startup,
+};
+
+static struct snd_soc_dai_driver q6hdmi_hdmi_rx_dai = {
+	.playback = {
+		.stream_name = "HDMI Playback",
+		.rates = SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_96000 |
+		 SNDRV_PCM_RATE_192000,
+		.formats = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S24_LE,
+		.channels_min = 2,
+		.channels_max = 8,
+		.rate_max =     192000,
+		.rate_min =	48000,
+	},
+	.ops = &q6hdmi_ops,
+	.name = "HDMI",
+};
+
+static const struct snd_soc_dapm_widget hdmi_dapm_widgets[] = {
+	SND_SOC_DAPM_AIF_OUT("HDMI", "HDMI Playback", 0, 0, 0, 0),
+	SND_SOC_DAPM_OUTPUT("HDMI-RX"),
+};
+
+static const struct snd_soc_component_driver msm_dai_hdmi_q6_component = {
+	.name		= "msm-dai-q6-hdmi",
+	.dapm_widgets = hdmi_dapm_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(hdmi_dapm_widgets),
+	.controls = hdmi_config_controls,
+	.num_controls = ARRAY_SIZE(hdmi_config_controls),
+	.dapm_routes = hdmi_dapm_routes,
+	.num_dapm_routes = ARRAY_SIZE(hdmi_dapm_routes),
+};
+
+static int q6hdmi_dev_probe(struct platform_device *pdev)
+{
+	struct q6hdmi_dai_data *dai_data;
+	int rc = 0;
+	struct q6afe_port *port;
+
+	dai_data = devm_kzalloc(&pdev->dev, sizeof(*dai_data), GFP_KERNEL);
+	if (!dai_data)
+		rc = -ENOMEM;
+
+	port = q6afe_port_get(&pdev->dev, "qcom,afe-port");
+	if (IS_ERR(port)) {
+		dev_err(&pdev->dev, "Unable to get afe port\n");
+		return -EPROBE_DEFER;
+	}
+	dai_data->port = port;
+	q6hdmi_hdmi_rx_dai.id = q6afe_get_port_index(port);
+	dev_set_drvdata(&pdev->dev, dai_data);
+
+	return snd_soc_register_component(&pdev->dev,
+					  &msm_dai_hdmi_q6_component,
+					  &q6hdmi_hdmi_rx_dai, 1);
+}
+
+static int q6hdmi_dev_remove(struct platform_device *pdev)
+{
+	struct q6hdmi_dai_data *dai_data = dev_get_drvdata(&pdev->dev);
+
+	q6afe_port_put(dai_data->port);
+	snd_soc_unregister_component(&pdev->dev);
+
+	return 0;
+}
+
+static const struct of_device_id q6hdmi_dt_match[] = {
+	{.compatible = "qcom,q6hdmi-v2"},
+	{}
+};
+MODULE_DEVICE_TABLE(of, q6hdmi_dt_match);
+
+static struct platform_driver q6hdmi_driver = {
+	.probe  = q6hdmi_dev_probe,
+	.remove = q6hdmi_dev_remove,
+	.driver = {
+		.name = "q6-hdmi",
+		.owner = THIS_MODULE,
+		.of_match_table = q6hdmi_dt_match,
+	},
+};
+
+module_platform_driver(q6hdmi_driver);
-- 
2.9.3
