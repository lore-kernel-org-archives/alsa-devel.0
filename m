From: srinivas.kandagatla@linaro.org
Subject: [RFC PATCH 5/9] ASoC: qcom: qdsp6v2: Add support to q6
	routing driver
Date: Fri, 11 Aug 2017 15:29:48 +0200
Message-ID: <20170811132952.32572-6-srinivas.kandagatla@linaro.org>
References: <20170811132952.32572-1-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-it0-f49.google.com (mail-it0-f49.google.com
 [209.85.214.49])
 by alsa0.perex.cz (Postfix) with ESMTP id 35E62267664
 for <alsa-devel@alsa-project.org>; Fri, 11 Aug 2017 15:30:14 +0200 (CEST)
Received: by mail-it0-f49.google.com with SMTP id 76so27733566ith.0
 for <alsa-devel@alsa-project.org>; Fri, 11 Aug 2017 06:30:14 -0700 (PDT)
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

This patch adds support to q6 routing driver which configures route
between ASM and AFE module using ADM apis.

This driver uses dapm widgets to setup the matrix between AFE ports and
ASM streams.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 .../bindings/sound/qcom,q6pcm-routing.txt          |  21 ++
 sound/soc/qcom/Kconfig                             |   5 +
 sound/soc/qcom/qdsp6v2/Makefile                    |   1 +
 sound/soc/qcom/qdsp6v2/q6routing-v2.h              |   8 +
 sound/soc/qcom/qdsp6v2/q6routing.c                 | 403 +++++++++++++++++++++
 5 files changed, 438 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,q6pcm-routing.txt
 create mode 100644 sound/soc/qcom/qdsp6v2/q6routing-v2.h
 create mode 100644 sound/soc/qcom/qdsp6v2/q6routing.c

diff --git a/Documentation/devicetree/bindings/sound/qcom,q6pcm-routing.txt b/Documentation/devicetree/bindings/sound/qcom,q6pcm-routing.txt
new file mode 100644
index 0000000..e3de107
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/qcom,q6pcm-routing.txt
@@ -0,0 +1,21 @@
+Qualcomm Q6 PCM Routing binding
+
+This bindings describe the Qualcomm Q6 PCM routing module
+
+- compatible:
+
+	Usage: required
+	Value type: <stringlist>
+	Definition: must be "qcom,q6pcm-routing-v<VERSION-NUMBER>"
+		    example "qcom,q6pcm-routing-v2"
+#sound-dai-cells:
+	Usage: required
+	Value type: <integer>
+	Definition: Must be equal to 0
+
+
+= EXAMPLE
+	q6pcm_routing {
+		compatible = "qcom,q6pcm-routing-v2";
+		#sound-dai-cells = <0>;
+	};
diff --git a/sound/soc/qcom/Kconfig b/sound/soc/qcom/Kconfig
index bd49813..9a5b3f0 100644
--- a/sound/soc/qcom/Kconfig
+++ b/sound/soc/qcom/Kconfig
@@ -56,12 +56,17 @@ config SND_SOC_QDSP6V2_ASM
 	tristate
 	default n
 
+config SND_SOC_QDSP6V2_ROUTING
+	tristate
+	default n
+
 
 config SND_SOC_QDSP6V2
 	tristate "SoC ALSA audio driver for QDSP6V2"
 	select SND_SOC_QDSP6V2_AFE
 	select SND_SOC_QDSP6V2_ADM
 	select SND_SOC_QDSP6V2_ASM
+	select SND_SOC_QDSP6V2_ROUTING
 	help
 	 To add support for MSM QDSP6V2 Soc Audio.
 	 This will enable sound soc platform specific
diff --git a/sound/soc/qcom/qdsp6v2/Makefile b/sound/soc/qcom/qdsp6v2/Makefile
index 00b0549..81d2341 100644
--- a/sound/soc/qcom/qdsp6v2/Makefile
+++ b/sound/soc/qcom/qdsp6v2/Makefile
@@ -1,3 +1,4 @@
 obj-$(CONFIG_SND_SOC_QDSP6V2_AFE) += q6afe.o
 obj-$(CONFIG_SND_SOC_QDSP6V2_ADM) += q6adm.o
 obj-$(CONFIG_SND_SOC_QDSP6V2_ASM) += q6asm.o
+obj-$(CONFIG_SND_SOC_QDSP6V2_ROUTING) += q6routing.o
diff --git a/sound/soc/qcom/qdsp6v2/q6routing-v2.h b/sound/soc/qcom/qdsp6v2/q6routing-v2.h
new file mode 100644
index 0000000..2cbf572
--- /dev/null
+++ b/sound/soc/qcom/qdsp6v2/q6routing-v2.h
@@ -0,0 +1,8 @@
+#ifndef _MSM_PCM_ROUTING_H
+#define _MSM_PCM_ROUTING_H
+
+int routing_reg_phy_stream(int fedai_id, int perf_mode,
+			   int stream_id, int stream_type);
+void routing_dereg_phy_stream(int fedai_id, int stream_type);
+
+#endif /*_MSM_PCM_ROUTING_H */
diff --git a/sound/soc/qcom/qdsp6v2/q6routing.c b/sound/soc/qcom/qdsp6v2/q6routing.c
new file mode 100644
index 0000000..a741ab3
--- /dev/null
+++ b/sound/soc/qcom/qdsp6v2/q6routing.c
@@ -0,0 +1,403 @@
+/* Copyright (c) 2012-2017, The Linux Foundation. All rights reserved.
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
+
+#include <linux/init.h>
+#include <linux/err.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/bitops.h>
+#include <linux/mutex.h>
+#include <linux/of_device.h>
+#include <linux/slab.h>
+#include <sound/core.h>
+#include <sound/soc.h>
+#include <sound/soc-dapm.h>
+#include <sound/pcm.h>
+#include <sound/control.h>
+#include <sound/asound.h>
+#include <sound/pcm_params.h>
+#include <dt-bindings/sound/qcom,afe.h>
+#include <dt-bindings/sound/qcom,asm.h>
+#include "q6afe-v2.h"
+#include "q6asm-v2.h"
+#include "q6adm-v2.h"
+#include "q6routing-v2.h"
+
+struct session_data {
+	int state;
+	int port_id;
+	int path_type;
+	int app_type;
+	int acdb_id;
+	int sample_rate;
+	int bits_per_sample;
+	int channels;
+	int format;
+	int perf_mode;
+	int numcopps;
+	int fedai_id;
+	unsigned long copp_map;
+
+};
+
+struct msm_routing_data {
+	struct session_data sessions[MAX_SESSIONS];
+	struct q6adm *adm;
+	struct mutex lock;
+};
+
+static struct msm_routing_data *routing_data;
+
+int routing_reg_phy_stream(int fedai_id, int perf_mode,
+			   int stream_id, int stream_type)
+{
+	int j, topology, num_copps = 0;
+	struct route_payload payload;
+	int copp_idx;
+	struct session_data *session;
+
+	if (!routing_data) {
+		pr_err("Routing driver not yet ready\n");
+		return -EINVAL;
+	}
+
+	session = &routing_data->sessions[stream_id - 1];
+	mutex_lock(&routing_data->lock);
+	session->fedai_id = fedai_id;
+	payload.num_copps = 0; /* only RX needs to use payload */
+	topology = NULL_COPP_TOPOLOGY;
+	copp_idx = q6adm_open(routing_data->adm, session->port_id,
+			      session->path_type, session->sample_rate,
+			      session->channels, topology, perf_mode,
+			      session->bits_per_sample, 0, 0);
+	if ((copp_idx < 0) || (copp_idx >= MAX_COPPS_PER_PORT)) {
+		pr_err("%s: adm open failed copp_idx:%d\n", __func__, copp_idx);
+		mutex_unlock(&routing_data->lock);
+		return -EINVAL;
+	}
+
+	set_bit(copp_idx, &session->copp_map);
+	for (j = 0; j < MAX_COPPS_PER_PORT; j++) {
+		unsigned long copp = session->copp_map;
+
+		if (test_bit(j, &copp)) {
+			payload.port_id[num_copps] = session->port_id;
+			payload.copp_idx[num_copps] = j;
+			num_copps++;
+		}
+	}
+
+	if (num_copps) {
+		payload.num_copps = num_copps;
+		payload.session_id = stream_id;
+		payload.app_type = 0;
+		payload.acdb_dev_id = 0;
+		payload.sample_rate = session->sample_rate;
+		q6adm_matrix_map(session->path_type, payload, perf_mode);
+	}
+	mutex_unlock(&routing_data->lock);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(routing_reg_phy_stream);
+
+static struct session_data *routing_get_session(struct msm_routing_data *data,
+						int port_id, int port_type)
+{
+	int i;
+
+	for (i = 0; i < MAX_SESSIONS; i++)
+		if (port_id == data->sessions[i].port_id)
+			return &data->sessions[i];
+
+	return NULL;
+}
+
+static struct session_data *get_session_from_id(struct msm_routing_data *data,
+						int fedai_id)
+{
+	int i;
+
+	for (i = 0; i < MAX_SESSIONS; i++) {
+		if (fedai_id == data->sessions[i].fedai_id)
+			return &data->sessions[i];
+	}
+
+	return NULL;
+}
+
+void routing_dereg_phy_stream(int fedai_id, int stream_type)
+{
+	struct session_data *session;
+	int idx;
+
+	session = get_session_from_id(routing_data, fedai_id);
+	if (!session)
+		return;
+
+	for_each_set_bit(idx, &session->copp_map, MAX_COPPS_PER_PORT)
+		q6adm_close(session->port_id, session->perf_mode, idx);
+
+	session->fedai_id = -1;
+	session->copp_map = 0;
+}
+EXPORT_SYMBOL_GPL(routing_dereg_phy_stream);
+
+static int msm_routing_get_audio_mixer(struct snd_kcontrol *kcontrol,
+				       struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_dapm_context *dapm =
+	    snd_soc_dapm_kcontrol_dapm(kcontrol);
+	struct soc_mixer_control *mc =
+	    (struct soc_mixer_control *)kcontrol->private_value;
+	int session_id = mc->shift;
+	struct snd_soc_platform *platform = snd_soc_dapm_to_platform(dapm);
+	struct msm_routing_data *priv = snd_soc_platform_get_drvdata(platform);
+	struct session_data *session = &priv->sessions[session_id];
+
+	if (session->port_id != -1)
+		ucontrol->value.integer.value[0] = 1;
+	else
+		ucontrol->value.integer.value[0] = 0;
+
+	pr_debug("%s: reg %x shift %x val %ld\n", __func__, mc->reg, mc->shift,
+		 ucontrol->value.integer.value[0]);
+
+	return 0;
+}
+
+static int msm_routing_put_audio_mixer(struct snd_kcontrol *kcontrol,
+				       struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_dapm_context *dapm =
+				    snd_soc_dapm_kcontrol_dapm(kcontrol);
+	struct snd_soc_platform *platform = snd_soc_dapm_to_platform(dapm);
+	struct msm_routing_data *data = snd_soc_platform_get_drvdata(platform);
+	struct soc_mixer_control *mc =
+		    (struct soc_mixer_control *)kcontrol->private_value;
+	struct snd_soc_dapm_update *update = NULL;
+	int be_id = mc->reg;
+	int session_id = mc->shift;
+	struct session_data *session = &data->sessions[session_id];
+
+	if (ucontrol->value.integer.value[0]) {
+		session->port_id = be_id;
+		snd_soc_dapm_mixer_update_power(dapm, kcontrol, 1, update);
+	} else {
+		session->port_id = -1;
+		snd_soc_dapm_mixer_update_power(dapm, kcontrol, 0, update);
+	}
+
+	return 1;
+}
+
+static const struct snd_kcontrol_new hdmi_mixer_controls[] = {
+	SOC_SINGLE_EXT("MultiMedia1", AFE_PORT_HDMI_RX,
+		       MSM_FRONTEND_DAI_MULTIMEDIA1, 1, 0,
+		       msm_routing_get_audio_mixer,
+		       msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("MultiMedia2", AFE_PORT_HDMI_RX,
+		       MSM_FRONTEND_DAI_MULTIMEDIA2, 1, 0,
+		       msm_routing_get_audio_mixer,
+		       msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("MultiMedia3", AFE_PORT_HDMI_RX,
+		       MSM_FRONTEND_DAI_MULTIMEDIA3, 1, 0,
+		       msm_routing_get_audio_mixer,
+		       msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("MultiMedia4", AFE_PORT_HDMI_RX,
+		       MSM_FRONTEND_DAI_MULTIMEDIA4, 1, 0,
+		       msm_routing_get_audio_mixer,
+		       msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("MultiMedia5", AFE_PORT_HDMI_RX,
+		       MSM_FRONTEND_DAI_MULTIMEDIA5, 1, 0,
+		       msm_routing_get_audio_mixer,
+		       msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("MultiMedia6", AFE_PORT_HDMI_RX,
+		       MSM_FRONTEND_DAI_MULTIMEDIA6, 1, 0,
+		       msm_routing_get_audio_mixer,
+		       msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("MultiMedia7", AFE_PORT_HDMI_RX,
+		       MSM_FRONTEND_DAI_MULTIMEDIA7, 1, 0,
+		       msm_routing_get_audio_mixer,
+		       msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("MultiMedia8", AFE_PORT_HDMI_RX,
+		       MSM_FRONTEND_DAI_MULTIMEDIA8, 1, 0,
+		       msm_routing_get_audio_mixer,
+		       msm_routing_put_audio_mixer),
+};
+
+static const struct snd_soc_dapm_widget msm_qdsp6_widgets[] = {
+	/* Frontend AIF */
+	/* Widget name equals to Front-End DAI name<Need confirmation>,
+	 * Stream name must contains substring of front-end dai name
+	 */
+	SND_SOC_DAPM_AIF_IN("MM_DL1", "MultiMedia1 Playback", 0, 0, 0, 0),
+	SND_SOC_DAPM_AIF_IN("MM_DL2", "MultiMedia2 Playback", 0, 0, 0, 0),
+	SND_SOC_DAPM_AIF_IN("MM_DL3", "MultiMedia3 Playback", 0, 0, 0, 0),
+	SND_SOC_DAPM_AIF_IN("MM_DL4", "MultiMedia4 Playback", 0, 0, 0, 0),
+	SND_SOC_DAPM_AIF_IN("MM_DL5", "MultiMedia5 Playback", 0, 0, 0, 0),
+	SND_SOC_DAPM_AIF_IN("MM_DL6", "MultiMedia6 Playback", 0, 0, 0, 0),
+	SND_SOC_DAPM_AIF_IN("MM_DL7", "MultiMedia7 Playback", 0, 0, 0, 0),
+	SND_SOC_DAPM_AIF_IN("MM_DL8", "MultiMedia8 Playback", 0, 0, 0, 0),
+
+	/* Mixer definitions */
+	SND_SOC_DAPM_MIXER("HDMI Mixer", SND_SOC_NOPM, 0, 0,
+			   hdmi_mixer_controls,
+			   ARRAY_SIZE(hdmi_mixer_controls)),
+};
+
+static const struct snd_soc_dapm_route intercon[] = {
+	{"HDMI Mixer", "MultiMedia1", "MM_DL1"},
+	{"HDMI Mixer", "MultiMedia2", "MM_DL2"},
+	{"HDMI Mixer", "MultiMedia3", "MM_DL3"},
+	{"HDMI Mixer", "MultiMedia4", "MM_DL4"},
+	{"HDMI Mixer", "MultiMedia5", "MM_DL5"},
+	{"HDMI Mixer", "MultiMedia6", "MM_DL6"},
+	{"HDMI Mixer", "MultiMedia7", "MM_DL7"},
+	{"HDMI Mixer", "MultiMedia8", "MM_DL8"},
+	{"HDMI", NULL, "HDMI Mixer"},
+	{"HDMI-RX", NULL, "HDMI"},
+};
+
+static int routing_hw_params(struct snd_pcm_substream *substream,
+				     struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	unsigned int be_id = rtd->cpu_dai->id;
+	struct snd_soc_platform *platform = rtd->platform;
+	struct msm_routing_data *data = snd_soc_platform_get_drvdata(platform);
+	struct session_data *session;
+	int port_id, port_type, path_type, bits_per_sample;
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		path_type = ADM_PATH_PLAYBACK;
+		port_type = MSM_AFE_PORT_TYPE_RX;
+	}
+
+	port_id = be_id;
+
+	session = routing_get_session(data, port_id, port_type);
+
+	if (!session) {
+		pr_err("No session matrix setup yet..\n");
+		return -EINVAL;
+	}
+
+	mutex_lock(&data->lock);
+
+	session->path_type = path_type;
+	session->sample_rate = params_rate(params);
+	session->channels = params_channels(params);
+	session->format = params_format(params);
+
+	if (session->format == SNDRV_PCM_FORMAT_S16_LE)
+		session->bits_per_sample = 16;
+	else if (session->format == SNDRV_PCM_FORMAT_S24_LE)
+		bits_per_sample = 24;
+
+	mutex_unlock(&data->lock);
+	return 0;
+}
+
+static int routing_close(struct snd_pcm_substream *substream)
+{
+	return 0;
+}
+
+static int routing_prepare(struct snd_pcm_substream *substream)
+{
+	return 0;
+}
+
+static struct snd_pcm_ops q6pcm_routing_ops = {
+	.hw_params = routing_hw_params,
+	.close = routing_close,
+	.prepare = routing_prepare,
+};
+
+/* Not used but frame seems to require it */
+static int msm_routing_probe(struct snd_soc_platform *platform)
+{
+	int i;
+
+	for (i = 0; i < MAX_SESSIONS; i++)
+		routing_data->sessions[i].port_id = -1;
+
+	snd_soc_platform_set_drvdata(platform, routing_data);
+
+	return 0;
+}
+
+static struct snd_soc_platform_driver msm_soc_routing_platform = {
+	.ops = &q6pcm_routing_ops,
+	.probe = msm_routing_probe,
+	.component_driver = {
+			     .dapm_widgets = msm_qdsp6_widgets,
+			     .num_dapm_widgets = ARRAY_SIZE(msm_qdsp6_widgets),
+			     .dapm_routes = intercon,
+			     .num_dapm_routes = ARRAY_SIZE(intercon),
+			     },
+};
+
+static int q6pcm_routing_probe(struct platform_device *pdev)
+{
+
+	struct q6adm *adm = q6adm_get(&pdev->dev);
+
+	if (IS_ERR(adm)) {
+		dev_err(&pdev->dev, "unable to get instance of adm\n");
+		return PTR_ERR(adm);
+	}
+
+	routing_data = devm_kzalloc(&pdev->dev,
+				    sizeof(*routing_data), GFP_KERNEL);
+	if (!routing_data)
+		return -ENOMEM;
+
+	routing_data->adm = adm;
+	mutex_init(&routing_data->lock);
+	dev_set_drvdata(&pdev->dev, routing_data);
+
+	return snd_soc_register_platform(&pdev->dev, &msm_soc_routing_platform);
+}
+
+static int q6pcm_routing_remove(struct platform_device *pdev)
+{
+	struct msm_routing_data *data = dev_get_drvdata(&pdev->dev);
+
+	q6adm_put(data->adm);
+
+	snd_soc_unregister_platform(&pdev->dev);
+	return 0;
+}
+
+static const struct of_device_id routing_dt_match[] = {
+	{.compatible = "qcom,q6pcm-routing-v2"},
+	{}
+};
+
+MODULE_DEVICE_TABLE(of, routing_dt_match);
+
+static struct platform_driver q6pcm_routing_driver = {
+	.driver = {
+		   .name = "q6pcm-routing",
+		   .owner = THIS_MODULE,
+		   .of_match_table = routing_dt_match,
+		   },
+	.probe = q6pcm_routing_probe,
+	.remove = q6pcm_routing_remove,
+};
+
+module_platform_driver(q6pcm_routing_driver);
+
+MODULE_DESCRIPTION("MSM routing platform driver");
+MODULE_LICENSE("GPL v2");
-- 
2.9.3
