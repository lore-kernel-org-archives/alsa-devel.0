From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Subject: [PATCH RFC V2 3/5] ASoC: codec: hdmi drm codec driver
Date: Thu, 1 Oct 2015 18:50:19 +0200
Message-ID: <1443718221-5120-4-git-send-email-arnaud.pouliquen@st.com>
References: <1443718221-5120-1-git-send-email-arnaud.pouliquen@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [62.209.51.94]) by alsa0.perex.cz (Postfix) with ESMTP id 616D02667E6
 for <alsa-devel@alsa-project.org>; Thu,  1 Oct 2015 18:51:03 +0200 (CEST)
In-Reply-To: <1443718221-5120-1-git-send-email-arnaud.pouliquen@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, dri-devel@lists.freedesktop.org
Cc: moinejf@free.fr, linux@arm.linux.org.uk, bcousson@baylibre.com, David Airlie <airlied@linux.ie>, tomi.valkeinen@ti.com, arnaud.pouliquen@st.com, lgirdwood@gmail.com, Jyri Sarha <jsarha@ti.com>, peter.ujfalusi@ti.com, Takashi Iwai <tiwai@suse.de>, tony@atomide.com, broonie@kernel.org, Benjamin Gaignard <benjamin.gaignard@linaro.org>
List-Id: alsa-devel@alsa-project.org

Add a generic codec to interface audio with DRM drivers

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
---
 include/sound/hdmi_drm.h    |  15 ++
 sound/soc/codecs/Kconfig    |   8 +-
 sound/soc/codecs/Makefile   |   2 +
 sound/soc/codecs/hdmi_drm.c | 358 ++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 380 insertions(+), 3 deletions(-)
 create mode 100644 include/sound/hdmi_drm.h
 create mode 100644 sound/soc/codecs/hdmi_drm.c

diff --git a/include/sound/hdmi_drm.h b/include/sound/hdmi_drm.h
new file mode 100644
index 0000000..411acee
--- /dev/null
+++ b/include/sound/hdmi_drm.h
@@ -0,0 +1,15 @@
+/*
+ * Interface for HDMI DRM  codec
+ *
+ * Author: Arnaud Pouliquen <arnaud.pouliquen@st.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#ifndef __HDMI_DRM__H__
+#define __HDMI_DRM__H__
+
+#define HDMI_DRM_CODEC_DRV_NAME "hdmi-drm-audio-codec"
+
+#endif
diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 395ef5d..fe5b0c8 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -80,6 +80,7 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_MC13783 if MFD_MC13XXX
 	select SND_SOC_ML26124 if I2C
 	select SND_SOC_HDMI_CODEC
+	select SND_SOC_HDMI_DRM_CODEC
 	select SND_SOC_PCM1681 if I2C
 	select SND_SOC_PCM1792A if SPI_MASTER
 	select SND_SOC_PCM3008
@@ -445,9 +446,10 @@ config SND_SOC_DMIC
 config SND_SOC_HDMI_CODEC
        tristate "HDMI stub CODEC"
 
-       tristate
-       select SND_PCM_ELD
-       select SND_PCM_IEC958
+config SND_SOC_HDMI_DRM_CODEC
+	tristate "HDMI DRM CODEC"
+	select SND_PCM_ELD
+	select SND_PCM_IEC958
 
 config SND_SOC_ES8328
 	tristate "Everest Semi ES8328 CODEC"
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index f683b33..41b2dcb 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -73,6 +73,7 @@ snd-soc-max9850-objs := max9850.o
 snd-soc-mc13783-objs := mc13783.o
 snd-soc-ml26124-objs := ml26124.o
 snd-soc-hdmi-codec-objs := hdmi-codec.o
+snd-soc-hdmi-drm-codec-objs := hdmi_drm.o
 snd-soc-pcm1681-objs := pcm1681.o
 snd-soc-pcm1792a-codec-objs := pcm1792a.o
 snd-soc-pcm3008-objs := pcm3008.o
@@ -265,6 +266,7 @@ obj-$(CONFIG_SND_SOC_MAX9850)	+= snd-soc-max9850.o
 obj-$(CONFIG_SND_SOC_MC13783)	+= snd-soc-mc13783.o
 obj-$(CONFIG_SND_SOC_ML26124)	+= snd-soc-ml26124.o
 obj-$(CONFIG_SND_SOC_HDMI_CODEC) += snd-soc-hdmi-codec.o
+obj-$(CONFIG_SND_SOC_HDMI_DRM_CODEC) += snd-soc-hdmi-drm-codec.o
 obj-$(CONFIG_SND_SOC_PCM1681)	+= snd-soc-pcm1681.o
 obj-$(CONFIG_SND_SOC_PCM1792A)	+= snd-soc-pcm1792a-codec.o
 obj-$(CONFIG_SND_SOC_PCM3008)	+= snd-soc-pcm3008.o
diff --git a/sound/soc/codecs/hdmi_drm.c b/sound/soc/codecs/hdmi_drm.c
new file mode 100644
index 0000000..1176d3b
--- /dev/null
+++ b/sound/soc/codecs/hdmi_drm.c
@@ -0,0 +1,358 @@
+/*
+ * ALSA SoC codec driver for DRM HDMI device.
+ * Copyright (C) STMicroelectronics SA 2015
+ * Authors: Arnaud Pouliquen <arnaud.pouliquen@st.com>
+ *          for STMicroelectronics.
+ * Inspirate from hdmi-codec (Jyri Sarha <jsarha at ti.com>)
+
+ * License terms:  GNU General Public License (GPL), version 2
+ */
+
+#include <linux/module.h>
+#include <sound/soc.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+
+#include <sound/asoundef.h>
+#include <sound/hdmi_drm.h>
+#include <sound/pcm_params.h>
+#include <sound/pcm_drm_eld.h>
+#include <sound/pcm_iec958.h>
+
+#include <drm/drm_crtc_helper.h>
+
+struct hdmi_drm_dai_data {
+	struct drm_bridge *bridge;
+	struct hdmi_audio_mode mode;
+	struct drm_audio_bridge_cfg cfg;
+	enum {
+		HDMI_DRM_I2S,
+		HDMI_DRM_SPDIF
+	} hai;
+};
+
+static const struct snd_soc_dapm_widget hdmi_drm_widgets[] = {
+	SND_SOC_DAPM_OUTPUT("TX"),
+};
+
+static const struct snd_soc_dapm_route hdmi_drm_routes[] = {
+	{ "TX", NULL, "Playback" },
+};
+
+int hdmi_drm_dai_startup(struct snd_pcm_substream *substream,
+			 struct snd_soc_dai *dai)
+{
+	struct hdmi_drm_dai_data *priv = snd_soc_dai_get_drvdata(dai);
+	uint8_t *eld;
+
+	dev_dbg(dai->dev, "%s: enter for bridge %p\n", __func__, priv->bridge);
+
+	eld = drm_audio_bridge_mode_get(priv->bridge);
+	if (!eld)
+		return 0;
+
+	return snd_pcm_hw_constraint_eld(substream->runtime, eld);
+}
+
+static void hdmi_drm_dai_shutdown(struct snd_pcm_substream *substream,
+			   struct snd_soc_dai *dai)
+{
+	struct hdmi_drm_dai_data *priv = snd_soc_dai_get_drvdata(dai);
+
+	drm_audio_bridge_post_disable(priv->bridge);
+}
+
+static int hdmi_drm_dai_hw_params(struct snd_pcm_substream *substream,
+				  struct snd_pcm_hw_params *params,
+				  struct snd_soc_dai *dai)
+{
+	struct hdmi_drm_dai_data *priv = snd_soc_dai_get_drvdata(dai);
+	struct hdmi_audio_infoframe *iframe = &priv->mode.infoframe;
+	unsigned char *iec = priv->mode.iec_status;
+	struct drm_audio_bridge_cfg *cfg = &priv->cfg;
+	int ret;
+
+	dev_dbg(dai->dev, "%s: enter for bridge %p\n", __func__, priv->bridge);
+
+	/* create iec959 if hadmi audio interface is no SPDIF
+	 * otherwise IEC status should managed by CPU-dai
+	 */
+	if (priv->hai != HDMI_DRM_SPDIF) {
+		ret = snd_pcm_create_iec958_consumer_hw_params(params, iec,
+							       sizeof(iec));
+		if (ret < 0) {
+			dev_err(dai->dev, "create iec status failed (%d)\n",
+				ret);
+			return ret;
+		}
+	}
+
+	hdmi_audio_infoframe_init(iframe);
+
+	iframe->channels = params_channels(params);
+	cfg->channels = iframe->channels;
+
+	switch (params_width(params)) {
+	case 16:
+		iframe->sample_size = HDMI_AUDIO_SAMPLE_SIZE_16;
+		break;
+	case 18:
+		iframe->sample_size = HDMI_AUDIO_SAMPLE_SIZE_20;
+		break;
+	case 20:
+		iframe->sample_size = HDMI_AUDIO_SAMPLE_SIZE_20;
+		break;
+	case 24:
+	case 32:
+		iframe->sample_size = HDMI_AUDIO_SAMPLE_SIZE_24;
+		break;
+	default:
+		dev_err(dai->dev, "sample width not supported! %d\n",
+			params_width(params));
+		return -EINVAL;
+	}
+	cfg->sample_width = params_width(params);
+
+	switch (params_rate(params)) {
+	case 32000:
+		iframe->sample_frequency = HDMI_AUDIO_SAMPLE_FREQUENCY_32000;
+		break;
+	case 44100:
+		iframe->sample_frequency = HDMI_AUDIO_SAMPLE_FREQUENCY_44100;
+		break;
+	case 48000:
+		iframe->sample_frequency = HDMI_AUDIO_SAMPLE_FREQUENCY_48000;
+		break;
+	case 88200:
+		iframe->sample_frequency = HDMI_AUDIO_SAMPLE_FREQUENCY_88200;
+		break;
+	case 96000:
+		iframe->sample_frequency = HDMI_AUDIO_SAMPLE_FREQUENCY_96000;
+		break;
+	case 176400:
+		iframe->sample_frequency = HDMI_AUDIO_SAMPLE_FREQUENCY_176400;
+		break;
+	case 192000:
+		iframe->sample_frequency = HDMI_AUDIO_SAMPLE_FREQUENCY_192000;
+		break;
+	default:
+		dev_err(dai->dev, "rate not supported : %d!\n",
+			params_rate(params));
+		return -EINVAL;
+	}
+	cfg->sample_rate = params_rate(params);
+
+	ret = drm_audio_bridge_mode_set(priv->bridge, &priv->mode);
+	if (ret < 0)
+		return ret;
+
+	return drm_audio_bridge_pre_enable(priv->bridge, &priv->cfg);
+}
+
+static int hdmi_drm_dai_set_fmt(struct snd_soc_dai *dai,
+				unsigned int fmt)
+{
+	struct hdmi_drm_dai_data *priv = snd_soc_dai_get_drvdata(dai);
+	struct drm_audio_bridge_cfg *cfg = &priv->cfg;
+	int ret = 0;
+
+	dev_dbg(dai->dev, "%s: enter for bridge %p\n", __func__, priv->bridge);
+
+	if (priv->hai == HDMI_DRM_SPDIF) {
+		cfg->fmt = HDMI_SPDIF;
+	} else {
+		switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
+		case SND_SOC_DAIFMT_CBM_CFM:
+			cfg->bit_clk_master = 1;
+			cfg->frame_clk_master = 1;
+			break;
+		case SND_SOC_DAIFMT_CBS_CFM:
+			cfg->frame_clk_master = 1;
+			break;
+		case SND_SOC_DAIFMT_CBM_CFS:
+			cfg->bit_clk_master = 1;
+			break;
+		case SND_SOC_DAIFMT_CBS_CFS:
+			break;
+		default:
+			return -EINVAL;
+		}
+
+		switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
+		case SND_SOC_DAIFMT_NB_NF:
+			break;
+		case SND_SOC_DAIFMT_NB_IF:
+			cfg->frame_clk_inv = 1;
+			break;
+		case SND_SOC_DAIFMT_IB_NF:
+			cfg->bit_clk_inv = 1;
+			break;
+		case SND_SOC_DAIFMT_IB_IF:
+			cfg->frame_clk_inv = 1;
+			cfg->bit_clk_inv = 1;
+			break;
+		}
+
+		switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
+		case SND_SOC_DAIFMT_I2S:
+			cfg->fmt = HDMI_I2S;
+			break;
+		case SND_SOC_DAIFMT_DSP_A:
+			cfg->fmt = HDMI_DSP_A;
+			break;
+		case SND_SOC_DAIFMT_DSP_B:
+			cfg->fmt = HDMI_DSP_B;
+			break;
+		case SND_SOC_DAIFMT_RIGHT_J:
+			cfg->fmt = HDMI_RIGHT_J;
+			break;
+		case SND_SOC_DAIFMT_LEFT_J:
+			cfg->fmt = HDMI_LEFT_J;
+			break;
+		case SND_SOC_DAIFMT_AC97:
+			cfg->fmt = HDMI_AC97;
+			break;
+		default:
+			dev_err(dai->dev, "Invalid DAI interface format\n");
+			return -EINVAL;
+		}
+	}
+
+	return ret;
+}
+
+int hdmi_drm_dai_trigger(struct snd_pcm_substream *substream, int cmd,
+			 struct snd_soc_dai *dai)
+{
+	struct hdmi_drm_dai_data *priv = snd_soc_dai_get_drvdata(dai);
+
+	dev_dbg(dai->dev, "%s: enter for bridge %p\n", __func__, priv->bridge);
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+	case SNDRV_PCM_TRIGGER_RESUME:
+		return drm_audio_bridge_enable(priv->bridge);
+
+	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+	case SNDRV_PCM_TRIGGER_STOP:
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+		return drm_audio_bridge_disable(priv->bridge);
+	}
+
+	return 0;
+}
+
+static int st_hdmi_dai_probe(struct snd_soc_dai *dai)
+{
+	struct hdmi_drm_dai_data *priv = snd_soc_dai_get_drvdata(dai);
+
+	priv->bridge = of_drm_find_bridge(dai->dev->parent->of_node);
+
+	if (!priv->bridge) {
+		dev_err(dai->dev, "HDMI audio bridge not found for node %s\n",
+			dai->dev->parent->of_node->name);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static const struct snd_soc_dai_ops hdmi_drm_codec_ops = {
+		.startup	= hdmi_drm_dai_startup,
+		.shutdown	= hdmi_drm_dai_shutdown,
+		.hw_params	= hdmi_drm_dai_hw_params,
+		.trigger	= hdmi_drm_dai_trigger,
+		.set_fmt	= hdmi_drm_dai_set_fmt,
+};
+
+static struct snd_soc_dai_driver hdmi_drm_codec_dai = {
+	.name = "hdmi-hifi",
+	.playback = {
+		.stream_name = "Playback",
+		.channels_min = 2,
+		.channels_max = 8,
+		.rates = SNDRV_PCM_RATE_32000 |
+			SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000 |
+			SNDRV_PCM_RATE_88200 | SNDRV_PCM_RATE_96000 |
+			SNDRV_PCM_RATE_176400 | SNDRV_PCM_RATE_192000,
+		.formats = SNDRV_PCM_FMTBIT_S16_LE |
+			   SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S32_LE,
+	},
+	.probe = st_hdmi_dai_probe,
+	.ops = &hdmi_drm_codec_ops,
+};
+
+static struct snd_soc_codec_driver hdmi_drm_codec = {
+	.dapm_widgets = hdmi_drm_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(hdmi_drm_widgets),
+	.dapm_routes = hdmi_drm_routes,
+	.num_dapm_routes = ARRAY_SIZE(hdmi_drm_routes),
+};
+
+static int hdmi_drm_codec_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct hdmi_drm_dai_data *priv;
+	struct device_node *np = dev->parent->of_node;
+	struct device_node *np_child;
+	const char *format;
+	int ret;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	np_child = of_get_child_by_name(np, "sound-dai");
+	if (!np_child) {
+		dev_err(dev, "DT not compatible\n");
+		return -ENXIO;
+	}
+
+	ret = of_property_read_string(np_child, "format", &format);
+	if (ret < 0) {
+		dev_err(dev, "missing format\n");
+		goto error;
+	}
+	if (strcmp(format, "i2s") == 0) {
+		priv->hai = HDMI_DRM_I2S;
+	} else if (strcmp(format, "spdif") == 0) {
+		priv->hai = HDMI_DRM_SPDIF;
+	} else {
+		dev_err(dev, "not expected format %s\n", format);
+		goto error;
+	}
+
+	dev_set_drvdata(dev, priv);
+
+	dev_info(dev, "bound audio drm codec\n");
+
+	return snd_soc_register_codec(dev, &hdmi_drm_codec,
+				      &hdmi_drm_codec_dai, 1);
+
+error:
+	dev_err(dev, "DT bus format missing\n");
+
+	return -EINVAL;
+}
+
+static int hdmi_drm_codec_remove(struct platform_device *pdev)
+{
+	snd_soc_unregister_codec(&pdev->dev);
+
+	return 0;
+}
+
+static struct platform_driver hdmi_codec_driver = {
+	.driver = {
+		.name = HDMI_DRM_CODEC_DRV_NAME,
+	},
+	.probe = hdmi_drm_codec_probe,
+	.remove = hdmi_drm_codec_remove,
+};
+
+module_platform_driver(hdmi_codec_driver);
+MODULE_AUTHOR("Arnaud Pouliquen <Arnaud.pouliquen@st.com>");
+MODULE_DESCRIPTION("ASoC HDMI codec driver");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:" HDMI_DRM_CODEC_DRV_NAME);
-- 
1.9.1
