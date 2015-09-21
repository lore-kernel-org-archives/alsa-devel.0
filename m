From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Subject: [RFC 3/5] ASoC: codec:  hdmi drm codec driver
Date: Mon, 21 Sep 2015 15:19:54 +0200
Message-ID: <1442841596-1323-4-git-send-email-arnaud.pouliquen@st.com>
References: <1442841596-1323-1-git-send-email-arnaud.pouliquen@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 03C192612D1
 for <alsa-devel@alsa-project.org>; Mon, 21 Sep 2015 15:21:17 +0200 (CEST)
In-Reply-To: <1442841596-1323-1-git-send-email-arnaud.pouliquen@st.com>
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
Cc: moinejf@free.fr, linux@arm.linux.org.uk, Takashi Iwai <tiwai@suse.de>, tomi.valkeinen@ti.com, arnaud.pouliquen@st.com, lgirdwood@gmail.com, Jyri Sarha <jsarha@ti.com>, peter.ujfalusi@ti.com, airlied@linux.ie, tony@atomide.com, broonie@kernel.org, bcousson@baylibre.com
List-Id: alsa-devel@alsa-project.org

Add a generic codec to interface audio with DRM drivers

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
---
 include/sound/hdmi_drm.h    |  16 ++++++
 sound/soc/codecs/Kconfig    |   4 ++
 sound/soc/codecs/Makefile   |   2 +
 sound/soc/codecs/hdmi_drm.c | 125 ++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 147 insertions(+)
 create mode 100644 include/sound/hdmi_drm.h
 create mode 100644 sound/soc/codecs/hdmi_drm.c

diff --git a/include/sound/hdmi_drm.h b/include/sound/hdmi_drm.h
new file mode 100644
index 0000000..0146b88
--- /dev/null
+++ b/include/sound/hdmi_drm.h
@@ -0,0 +1,16 @@
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
+int hdmi_drm_codec_register(struct device *dev);
+void hdmi_drm_codec_unregister(struct device *dev);
+
+#endif
diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 0c9733e..922af30 100644
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
@@ -445,6 +446,9 @@ config SND_SOC_DMIC
 config SND_SOC_HDMI_CODEC
        tristate "HDMI stub CODEC"
 
+config SND_SOC_HDMI_DRM_CODEC
+       tristate "HDMI DRM CODEC"
+
 config SND_SOC_ES8328
 	tristate "Everest Semi ES8328 CODEC"
 
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index 4a32077..c92aaf7 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -73,6 +73,7 @@ snd-soc-max9850-objs := max9850.o
 snd-soc-mc13783-objs := mc13783.o
 snd-soc-ml26124-objs := ml26124.o
 snd-soc-hdmi-codec-objs := hdmi.o
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
index 0000000..2df9a8f
--- /dev/null
+++ b/sound/soc/codecs/hdmi_drm.c
@@ -0,0 +1,125 @@
+/*
+ * ALSA SoC codec driver for DRM HDMI device.
+ * Copyright (C) STMicroelectronics SA 2015
+ * Authors: Arnaud Pouliquen <arnaud.pouliquen@st.com>
+ *          for STMicroelectronics.
+ * License terms:  GNU General Public License (GPL), version 2
+ */
+
+#include <linux/module.h>
+#include <sound/soc.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+
+#include <drm/drm_crtc_helper.h>
+
+struct hdmi_drm_dai_data {
+	struct drm_bridge *bridge;
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
+int hdmi_drm_dai_prepare(struct snd_pcm_substream *substream,
+			 struct snd_soc_dai *dai)
+{
+	struct hdmi_drm_dai_data *priv = snd_soc_dai_get_drvdata(dai);
+
+	dev_err(dai->dev, "%s: enter for bridge %p\n", __func__, priv->bridge);
+	drm_audio_bridge_pre_enable(priv->bridge);
+	return 0;
+}
+
+int hdmi_drm_dai_trigger(struct snd_pcm_substream *substream, int cmd,
+			 struct snd_soc_dai *dai)
+{
+	struct hdmi_drm_dai_data *priv = snd_soc_dai_get_drvdata(dai);
+
+	dev_err(dai->dev, "%s: enter\n", __func__);
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+	case SNDRV_PCM_TRIGGER_RESUME:
+		drm_audio_bridge_enable(priv->bridge);
+		break;
+
+	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+	case SNDRV_PCM_TRIGGER_STOP:
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+		drm_audio_bridge_disable(priv->bridge);
+		break;
+	}
+
+	return 0;
+}
+
+static int st_hdmi_dai_probe(struct snd_soc_dai *dai)
+{
+	struct hdmi_drm_dai_data *priv;
+
+	dev_err(dai->dev, "%s: enter\n", __func__);
+	priv = devm_kzalloc(dai->dev, sizeof(*priv), GFP_KERNEL);
+
+	priv->bridge = of_drm_find_bridge(dai->dev->of_node);
+
+	dev_err(dai->dev, "%s: bridge %p\n", __func__, priv->bridge);
+
+	snd_soc_dai_set_drvdata(dai, priv);
+
+	return 0;
+}
+
+static const struct snd_soc_dai_ops hdmi_drm_codec_ops = {
+		.prepare =  hdmi_drm_dai_prepare,
+		.trigger = hdmi_drm_dai_trigger,
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
+			SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S32_LE,
+		.sig_bits = 24,
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
+	.ignore_pmdown_time = true,
+};
+
+int hdmi_drm_codec_register(struct device *dev)
+{
+	dev_err(dev, "%s: enter", __func__);
+	return snd_soc_register_codec(dev, &hdmi_drm_codec,
+				      &hdmi_drm_codec_dai, 1);
+}
+EXPORT_SYMBOL_GPL(hdmi_drm_codec_register);
+
+void hdmi_drm_codec_unregister(struct device *dev)
+{
+	dev_err(dev, "%s: enter", __func__);
+	snd_soc_unregister_codec(dev);
+}
+EXPORT_SYMBOL_GPL(hdmi_drm_codec_unregister);
+
+MODULE_AUTHOR("Arnaud.pouliquen@st.com");
+MODULE_DESCRIPTION("ASoC HDMI codec driver");
+MODULE_LICENSE("GPL");
-- 
1.9.1
