From: Jun Nie <jun.nie@linaro.org>
Subject: [PATCH v3 6/6] ASoC: zx: add zx296702 hdmi codec
Date: Fri, 29 May 2015 21:31:21 +0800
Message-ID: <1432906281-27698-7-git-send-email-jun.nie@linaro.org>
References: <1432906281-27698-1-git-send-email-jun.nie@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f43.google.com (mail-pa0-f43.google.com
 [209.85.220.43])
 by alsa0.perex.cz (Postfix) with ESMTP id DBB4726683F
 for <alsa-devel@alsa-project.org>; Fri, 29 May 2015 15:32:24 +0200 (CEST)
Received: by pacrp13 with SMTP id rp13so13113576pac.2
 for <alsa-devel@alsa-project.org>; Fri, 29 May 2015 06:32:24 -0700 (PDT)
In-Reply-To: <1432906281-27698-1-git-send-email-jun.nie@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: alsa-devel@alsa-project.org, shawn.guo@linaro.org, wan.zhijun@zte.com.cn, Jun Nie <jun.nie@linaro.org>
List-Id: alsa-devel@alsa-project.org

Add zx296702 hdmi codec to enable SPDIF and I2S output
via HDMI. The SPDIF/I2S route is exclusive with current
software config and need specify which is valid in
defconfig.

Signed-off-by: Jun Nie <jun.nie@linaro.org>
---
 include/sound/zx_hdmi_audio.h    |   7 +++
 sound/soc/codecs/Kconfig         |   3 +
 sound/soc/codecs/Makefile        |   1 +
 sound/soc/codecs/zx296702_hdmi.c | 121 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 132 insertions(+)
 create mode 100644 include/sound/zx_hdmi_audio.h
 create mode 100644 sound/soc/codecs/zx296702_hdmi.c

diff --git a/include/sound/zx_hdmi_audio.h b/include/sound/zx_hdmi_audio.h
new file mode 100644
index 0000000..7eb0e81
--- /dev/null
+++ b/include/sound/zx_hdmi_audio.h
@@ -0,0 +1,7 @@
+#ifndef __ZX_HDMI_AUDIO_H__
+#define __ZX_HDMI_AUDIO_H__
+
+int zx_hdmi_audio_cfg(int audio_codec, int audio_way,
+		      u32 sample_rate, u32 sample_len);
+void zx_hdmi_audio_en(int on);
+#endif /* __ZX_HDMI_AUDIO_H__ */
diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 061c465..1ba34ca 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -844,6 +844,9 @@ config SND_SOC_WM9712
 config SND_SOC_WM9713
 	tristate
 
+config SND_SOC_ZX_HDMI
+	tristate
+
 # Amp
 config SND_SOC_LM4857
 	tristate
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index abe2d7e..b6c4630 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -357,6 +357,7 @@ obj-$(CONFIG_SND_SOC_WM9712)	+= snd-soc-wm9712.o
 obj-$(CONFIG_SND_SOC_WM9713)	+= snd-soc-wm9713.o
 obj-$(CONFIG_SND_SOC_WM_ADSP)	+= snd-soc-wm-adsp.o
 obj-$(CONFIG_SND_SOC_WM_HUBS)	+= snd-soc-wm-hubs.o
+obj-$(CONFIG_SND_SOC_ZX_HDMI)	+= zx296702_hdmi.o
 
 # Amp
 obj-$(CONFIG_SND_SOC_MAX9877)	+= snd-soc-max9877.o
diff --git a/sound/soc/codecs/zx296702_hdmi.c b/sound/soc/codecs/zx296702_hdmi.c
new file mode 100644
index 0000000..b256e54
--- /dev/null
+++ b/sound/soc/codecs/zx296702_hdmi.c
@@ -0,0 +1,121 @@
+/*
+ * ALSA SoC codec driver for HDMI audio codecs.
+ * Copyright (C) 2015 Linaro
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ *
+ */
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include <sound/zx_hdmi_audio.h>
+
+#define DRV_NAME "zx-hdmi-codec"
+
+static int zx_hw_params(struct snd_pcm_substream *substream,
+			struct snd_pcm_hw_params *params,
+			struct snd_soc_dai *dai)
+{
+#ifdef CONFIG_ZX_HDMI_SND_SPDIF
+	zx_hdmi_audio_cfg(1, 0, params_rate(params),
+#endif
+#ifdef CONFIG_ZX_HDMI_SND_I2S
+	zx_hdmi_audio_cfg(1, 1, params_rate(params),
+#endif
+			  params_physical_width(params));
+	return 0;
+}
+
+static int zx_trigger(struct snd_pcm_substream *substream, int cmd,
+		      struct snd_soc_dai *dai)
+{
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+	case SNDRV_PCM_TRIGGER_RESUME:
+	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+#ifdef CONFIG_ZX_HDMI_SND_SPDIF
+		zx_hdmi_audio_en(1);
+#endif
+		break;
+
+	case SNDRV_PCM_TRIGGER_STOP:
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+#ifdef CONFIG_ZX_HDMI_SND_SPDIF
+		/* Mute HDMI before disabling spdif */
+		zx_hdmi_audio_en(0);
+#endif
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static const struct snd_soc_dai_ops zx_dai_ops = {
+	.trigger	= zx_trigger,
+	.hw_params	= zx_hw_params,
+};
+
+static struct snd_soc_dai_driver zx_hdmi_codec_dai = {
+	.name = "zx-hdmi-hifi",
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
+	.ops = &zx_dai_ops,
+};
+
+#ifdef CONFIG_OF
+static const struct of_device_id zx_hdmi_audio_codec_ids[] = {
+	{ .compatible = "zte,hdmi-audio", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, zx_hdmi_audio_codec_ids);
+#endif
+
+static struct snd_soc_codec_driver zx_hdmi_codec = {
+};
+
+static int zx_hdmi_codec_probe(struct platform_device *pdev)
+{
+	return snd_soc_register_codec(&pdev->dev, &zx_hdmi_codec,
+			&zx_hdmi_codec_dai, 1);
+}
+
+static int zx_hdmi_codec_remove(struct platform_device *pdev)
+{
+	snd_soc_unregister_codec(&pdev->dev);
+	return 0;
+}
+
+static struct platform_driver zx_hdmi_codec_driver = {
+	.driver		= {
+		.name	= DRV_NAME,
+		.of_match_table = of_match_ptr(zx_hdmi_audio_codec_ids),
+	},
+
+	.probe		= zx_hdmi_codec_probe,
+	.remove		= zx_hdmi_codec_remove,
+};
+
+module_platform_driver(zx_hdmi_codec_driver);
+
+MODULE_AUTHOR("Jun Nie <jun.nie@linaro.org>");
+MODULE_DESCRIPTION("ZX296702 ASoC HDMI codec driver");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:" DRV_NAME);
-- 
1.9.1
