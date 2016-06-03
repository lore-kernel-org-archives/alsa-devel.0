From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [RFC PATCH] drm: msm: Add ASoC generic hdmi audio codec support.
Date: Fri,  3 Jun 2016 14:56:01 +0100
Message-ID: <1464962161-17337-1-git-send-email-srinivas.kandagatla@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Clark <robdclark@gmail.com>, dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, alsa-devel@alsa-project.org
Cc: David Airlie <airlied@linux.ie>, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, broonie@kernel.org, jsarha@ti.com, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

This patch adds support to generic audio codec via
ASoC hdmi-codec infrastucture which is merged recently.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/gpu/drm/msm/Kconfig     |   1 +
 drivers/gpu/drm/msm/hdmi/hdmi.c | 120 +++++++++++++++++++++++++++++++++++++++-
 drivers/gpu/drm/msm/hdmi/hdmi.h |  14 +++++
 3 files changed, 134 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/Kconfig b/drivers/gpu/drm/msm/Kconfig
index 167a497..7c7a031 100644
--- a/drivers/gpu/drm/msm/Kconfig
+++ b/drivers/gpu/drm/msm/Kconfig
@@ -10,6 +10,7 @@ config DRM_MSM
 	select SHMEM
 	select TMPFS
 	select QCOM_SCM
+	select SND_SOC_HDMI_CODEC if SND_SOC
 	default y
 	help
 	  DRM/KMS driver for MSM/snapdragon.
diff --git a/drivers/gpu/drm/msm/hdmi/hdmi.c b/drivers/gpu/drm/msm/hdmi/hdmi.c
index 51b9ea5..3281496 100644
--- a/drivers/gpu/drm/msm/hdmi/hdmi.c
+++ b/drivers/gpu/drm/msm/hdmi/hdmi.c
@@ -19,6 +19,7 @@
 #include <linux/of_irq.h>
 #include <linux/of_gpio.h>
 
+#include <sound/hdmi-codec.h>
 #include "hdmi.h"
 
 void msm_hdmi_set_mode(struct hdmi *hdmi, bool power_on)
@@ -434,6 +435,114 @@ static int msm_hdmi_get_gpio(struct device_node *of_node, const char *name)
 	return gpio;
 }
 
+/*
+ * HDMI audio codec callbacks
+ */
+static int msm_hdmi_audio_hw_params(struct device *dev,
+				    struct hdmi_codec_daifmt *daifmt,
+				    struct hdmi_codec_params *params)
+{
+	struct hdmi *hdmi = dev_get_drvdata(dev);
+	unsigned int chan;
+	unsigned int channel_allocation = 0;
+	unsigned int rate;
+	unsigned int level_shift  = 0; /* 0dB */
+	bool down_mix = false;
+
+	dev_dbg(dev, "%u Hz, %d bit, %d channels\n", params->sample_rate,
+		 params->sample_width, params->cea.channels);
+
+	switch (params->cea.channels) {
+	case 2:
+		/* FR and FL speakers */
+		channel_allocation  = 0;
+		chan = MSM_HDMI_AUDIO_CHANNEL_2;
+		break;
+	case 4:
+		/* FC, LFE, FR and FL speakers */
+		channel_allocation  = 0x3;
+		chan = MSM_HDMI_AUDIO_CHANNEL_4;
+		break;
+	case 6:
+		/* RR, RL, FC, LFE, FR and FL speakers */
+		channel_allocation  = 0x0B;
+		chan = MSM_HDMI_AUDIO_CHANNEL_6;
+		break;
+	case 8:
+		/* FRC, FLC, RR, RL, FC, LFE, FR and FL speakers */
+		channel_allocation  = 0x1F;
+		chan = MSM_HDMI_AUDIO_CHANNEL_8;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	switch (params->sample_rate) {
+	case 32000:
+		rate = HDMI_SAMPLE_RATE_32KHZ;
+		break;
+	case 44100:
+		rate = HDMI_SAMPLE_RATE_48KHZ;
+		break;
+	case 48000:
+		rate = HDMI_SAMPLE_RATE_48KHZ;
+		break;
+	case 88200:
+		rate = HDMI_SAMPLE_RATE_88_2KHZ;
+		break;
+	case 96000:
+		rate = HDMI_SAMPLE_RATE_96KHZ;
+		break;
+	case 176400:
+		rate = HDMI_SAMPLE_RATE_176_4KHZ;
+		break;
+	case 192000:
+		rate = HDMI_SAMPLE_RATE_192KHZ;
+		break;
+	default:
+		dev_err(dev, "rate[%d] not supported!\n",
+			params->sample_rate);
+		return -EINVAL;
+	}
+
+	msm_hdmi_audio_set_sample_rate(hdmi, rate);
+	msm_hdmi_audio_info_setup(hdmi, 1, chan, channel_allocation,
+			      level_shift, down_mix);
+
+	return 0;
+}
+
+static void msm_hdmi_audio_shutdown(struct device *dev)
+{
+	struct hdmi *hdmi = dev_get_drvdata(dev);
+
+	msm_hdmi_audio_info_setup(hdmi, 0, 0, 0, 0, 0);
+}
+
+static const struct hdmi_codec_ops msm_hdmi_audio_codec_ops = {
+	.hw_params = msm_hdmi_audio_hw_params,
+	.audio_shutdown = msm_hdmi_audio_shutdown,
+};
+
+static struct hdmi_codec_pdata codec_data = {
+	.ops = &msm_hdmi_audio_codec_ops,
+	.max_i2s_channels = 8,
+	.i2s = 1,
+};
+
+static int msm_hdmi_register_audio_driver(struct hdmi *hdmi, struct device *dev)
+{
+	hdmi->audio_pdev = platform_device_register_data(dev,
+							 HDMI_CODEC_DRV_NAME,
+							 PLATFORM_DEVID_AUTO,
+							 &codec_data,
+							 sizeof(codec_data));
+	if (IS_ERR(hdmi->audio_pdev))
+		return PTR_ERR(hdmi->audio_pdev);
+
+	return 0;
+}
+
 static int msm_hdmi_bind(struct device *dev, struct device *master, void *data)
 {
 	struct drm_device *drm = dev_get_drvdata(master);
@@ -441,7 +550,7 @@ static int msm_hdmi_bind(struct device *dev, struct device *master, void *data)
 	static struct hdmi_platform_config *hdmi_cfg;
 	struct hdmi *hdmi;
 	struct device_node *of_node = dev->of_node;
-	int i;
+	int i, err;
 
 	hdmi_cfg = (struct hdmi_platform_config *)
 			of_device_get_match_data(dev);
@@ -468,6 +577,12 @@ static int msm_hdmi_bind(struct device *dev, struct device *master, void *data)
 		return PTR_ERR(hdmi);
 	priv->hdmi = hdmi;
 
+	err = msm_hdmi_register_audio_driver(hdmi, dev);
+	if (err) {
+		DRM_ERROR("Failed to attach an audio codec %d\n", err);
+		hdmi->audio_pdev = NULL;
+	}
+
 	return 0;
 }
 
@@ -477,6 +592,9 @@ static void msm_hdmi_unbind(struct device *dev, struct device *master,
 	struct drm_device *drm = dev_get_drvdata(master);
 	struct msm_drm_private *priv = drm->dev_private;
 	if (priv->hdmi) {
+		if (priv->hdmi->audio_pdev)
+			platform_device_unregister(priv->hdmi->audio_pdev);
+
 		msm_hdmi_destroy(priv->hdmi);
 		priv->hdmi = NULL;
 	}
diff --git a/drivers/gpu/drm/msm/hdmi/hdmi.h b/drivers/gpu/drm/msm/hdmi/hdmi.h
index bc7ba0b..accc9a6 100644
--- a/drivers/gpu/drm/msm/hdmi/hdmi.h
+++ b/drivers/gpu/drm/msm/hdmi/hdmi.h
@@ -50,6 +50,7 @@ struct hdmi_hdcp_ctrl;
 struct hdmi {
 	struct drm_device *dev;
 	struct platform_device *pdev;
+	struct platform_device *audio_pdev;
 
 	const struct hdmi_platform_config *config;
 
@@ -210,6 +211,19 @@ static inline int msm_hdmi_pll_8996_init(struct platform_device *pdev)
 /*
  * audio:
  */
+/* Supported HDMI Audio channels and rates */
+#define	MSM_HDMI_AUDIO_CHANNEL_2	0
+#define	MSM_HDMI_AUDIO_CHANNEL_4	1
+#define	MSM_HDMI_AUDIO_CHANNEL_6	2
+#define	MSM_HDMI_AUDIO_CHANNEL_8	3
+
+#define	HDMI_SAMPLE_RATE_32KHZ		0
+#define	HDMI_SAMPLE_RATE_44_1KHZ	1
+#define	HDMI_SAMPLE_RATE_48KHZ		2
+#define	HDMI_SAMPLE_RATE_88_2KHZ	3
+#define	HDMI_SAMPLE_RATE_96KHZ		4
+#define	HDMI_SAMPLE_RATE_176_4KHZ	5
+#define	HDMI_SAMPLE_RATE_192KHZ		6
 
 int msm_hdmi_audio_update(struct hdmi *hdmi);
 int msm_hdmi_audio_info_setup(struct hdmi *hdmi, bool enabled,
-- 
2.8.2
