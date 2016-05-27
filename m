From: Chris Zhong <zyw@rock-chips.com>
Subject: [RESEND PATCH 5/6] ASoC: cdn-dp: Add cdn DP codec driver
Date: Fri, 27 May 2016 18:45:41 +0800
Message-ID: <1464345942-4795-6-git-send-email-zyw@rock-chips.com>
References: <1464345942-4795-1-git-send-email-zyw@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1464345942-4795-1-git-send-email-zyw@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: dianders@chromium.org, tfiga@chromium.org, heiko@sntech.de, yzq@rock-chips.com
Cc: linux-rockchip@lists.infradead.org, Chris Zhong <zyw@rock-chips.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Michael Trimarchi <michael@amarulasolutions.com>, Bard Liao <bardliao@realtek.com>, Vinod Koul <vinod.koul@intel.com>, Adam Thomson <Adam.Thomson.Opensource@diasemi.com>, anish kumar <yesanishhere@gmail.com>, Jacob Siverskog <jacob@teenage.engineering>, Richard Fitzgerald <rf@opensource.wolfsonmicro.com>, "Damien.Horsley" <Damien.Horsley@imgtec.com>, Oder Chiou <oder_chiou@realtek.com>, Jyri Sarha <jsarha@ti.com>, Caesar Wang <wxt@rock-chips.com>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

codec driver get some interfaces from cdn-dp driver, than using those
to set DP audio formats, corresponding to alsa formats.

Signed-off-by: Chris Zhong <zyw@rock-chips.com>
---

 sound/soc/codecs/Kconfig        |   3 +
 sound/soc/codecs/Makefile       |   2 +
 sound/soc/codecs/cdn-dp-audio.c | 246 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 251 insertions(+)
 create mode 100644 sound/soc/codecs/cdn-dp-audio.c

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 7ef3a0c..7ddae65 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -365,6 +365,9 @@ config SND_SOC_ALC5623
 config SND_SOC_ALC5632
 	tristate
 
+config SND_SOC_CDN_DP_AUDIO
+	tristate
+
 config SND_SOC_CQ0093VC
 	tristate
 
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index 185a712..7a703a7 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -32,6 +32,7 @@ snd-soc-ak4642-objs := ak4642.o
 snd-soc-ak4671-objs := ak4671.o
 snd-soc-ak5386-objs := ak5386.o
 snd-soc-arizona-objs := arizona.o
+snd-soc-cdn-dp-audio-objs := cdn-dp-audio.o
 snd-soc-cq93vc-objs := cq93vc.o
 snd-soc-cs35l32-objs := cs35l32.o
 snd-soc-cs42l51-objs := cs42l51.o
@@ -241,6 +242,7 @@ obj-$(CONFIG_SND_SOC_AK5386)	+= snd-soc-ak5386.o
 obj-$(CONFIG_SND_SOC_ALC5623)    += snd-soc-alc5623.o
 obj-$(CONFIG_SND_SOC_ALC5632)	+= snd-soc-alc5632.o
 obj-$(CONFIG_SND_SOC_ARIZONA)	+= snd-soc-arizona.o
+obj-$(CONFIG_SND_SOC_CDN_DP_AUDIO) += snd-soc-cdn-dp-audio.o
 obj-$(CONFIG_SND_SOC_CQ0093VC) += snd-soc-cq93vc.o
 obj-$(CONFIG_SND_SOC_CS35L32)	+= snd-soc-cs35l32.o
 obj-$(CONFIG_SND_SOC_CS42L51)	+= snd-soc-cs42l51.o
diff --git a/sound/soc/codecs/cdn-dp-audio.c b/sound/soc/codecs/cdn-dp-audio.c
new file mode 100644
index 0000000..a68570f
--- /dev/null
+++ b/sound/soc/codecs/cdn-dp-audio.c
@@ -0,0 +1,246 @@
+/*
+ * cdn dp audio support library
+ *
+ * Copyright (C) 2016 Chris Zhong <zyw@rock-chips.com>
+ * Copyright (C) 2016 ROCKCHIP, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/moduleparam.h>
+
+#include <sound/pcm.h>
+#include <sound/soc.h>
+#include <sound/core.h>
+#include <sound/initval.h>
+#include <sound/pcm_params.h>
+
+#include <sound/cdn-dp-audio.h>
+
+#define DRV_NAME "cdn-dp-audio"
+
+struct snd_cdn_dp_audio {
+	struct device *dev;
+	const struct cdn_dp_audio_ops *ops;
+	void *data;
+	bool is_playback_status;
+};
+
+static int snd_cdn_dp_audio_dai_startup(struct snd_pcm_substream *substream,
+					struct snd_soc_dai *codec_dai)
+{
+	struct snd_cdn_dp_audio *ad = snd_soc_dai_get_drvdata(codec_dai);
+	struct audio_info audio;
+
+	ad->is_playback_status = true;
+	ad->ops->audio_startup(ad->data, &audio);
+
+	return 0;
+}
+
+static int snd_cdn_dp_audio_dai_hw_params(struct snd_pcm_substream *substream,
+					  struct snd_pcm_hw_params *params,
+					  struct snd_soc_dai *codec_dai)
+{
+	struct snd_cdn_dp_audio *ad = snd_soc_dai_get_drvdata(codec_dai);
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct audio_info audio;
+	unsigned int fmt, rate, chan, width;
+
+	fmt = rtd->dai_link->dai_fmt & SND_SOC_DAIFMT_FORMAT_MASK;
+	if (fmt == SND_SOC_DAIFMT_I2S) {
+		audio.type = AUDIO_TYPE_I2S;
+	} else {
+		dev_err(codec_dai->dev, "DAI format unsupported");
+		return -EINVAL;
+	}
+
+	width = params_width(params);
+	if ((width == 16) || (width == 24)) {
+		audio.word_length = width;
+	} else {
+		dev_err(codec_dai->dev, "width[%d] not support!\n", width);
+		return -EINVAL;
+	}
+
+	chan = params_channels(params);
+	switch (chan) {
+	case 2:
+	case 4:
+	case 6:
+	case 8:
+		audio.channels = chan;
+		break;
+	default:
+		dev_err(codec_dai->dev, "channel[%d] not support!\n", chan);
+		return -EINVAL;
+	}
+
+	rate = params_rate(params);
+	switch (rate) {
+	case 32000:
+	case 44100:
+	case 48000:
+	case 88200:
+	case 96000:
+	case 176400:
+	case 192000:
+		audio.freq = rate;
+		break;
+	default:
+		dev_err(codec_dai->dev, "rate[%d] not support!\n", rate);
+		return -EINVAL;
+	}
+
+	ad->ops->audio_config(ad->data, &audio);
+
+	return 0;
+}
+
+static int snd_cdn_dp_audio_dai_trigger(struct snd_pcm_substream *substream,
+					int cmd, struct snd_soc_dai *codec_dai)
+{
+	struct snd_cdn_dp_audio *ad = snd_soc_dai_get_drvdata(codec_dai);
+	struct audio_info audio;
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+	case SNDRV_PCM_TRIGGER_RESUME:
+	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+		ad->ops->audio_start(ad->data, &audio);
+		break;
+	case SNDRV_PCM_TRIGGER_STOP:
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+		ad->ops->audio_stop(ad->data, &audio);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static void snd_cdn_dp_audio_dai_shutdown(struct snd_pcm_substream *substream,
+					  struct snd_soc_dai *codec_dai)
+{
+	struct snd_cdn_dp_audio *ad = snd_soc_dai_get_drvdata(codec_dai);
+	struct audio_info audio;
+
+	ad->is_playback_status = false;
+	ad->ops->audio_shutdown(ad->data, &audio);
+}
+
+static const struct snd_soc_dapm_widget snd_cdn_dp_audio_widgets[] = {
+	SND_SOC_DAPM_OUTPUT("TX"),
+};
+
+static const struct snd_soc_dapm_route snd_cdn_dp_audio_routes[] = {
+	{ "TX", NULL, "Playback" },
+};
+
+static const struct snd_soc_dai_ops cdn_dp_audio_dai_ops = {
+	.startup = snd_cdn_dp_audio_dai_startup,
+	.hw_params = snd_cdn_dp_audio_dai_hw_params,
+	.trigger = snd_cdn_dp_audio_dai_trigger,
+	.shutdown = snd_cdn_dp_audio_dai_shutdown,
+};
+
+static struct snd_soc_dai_driver cdn_dp_audio_dai = {
+	.name = "cdn-dp-hifi",
+	.playback = {
+		.stream_name = "Playback",
+		.channels_min = 2,
+		.channels_max = 8,
+		.rates = SNDRV_PCM_RATE_32000 |
+			 SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000 |
+			 SNDRV_PCM_RATE_88200 | SNDRV_PCM_RATE_96000 |
+			 SNDRV_PCM_RATE_176400 | SNDRV_PCM_RATE_192000,
+		.formats = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S24_LE,
+	},
+	.capture = {
+		.stream_name = "Capture",
+		.channels_min = 2,
+		.channels_max = 8,
+		.rates = SNDRV_PCM_RATE_32000 |
+			 SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000 |
+			 SNDRV_PCM_RATE_88200 | SNDRV_PCM_RATE_96000 |
+			 SNDRV_PCM_RATE_176400 | SNDRV_PCM_RATE_192000,
+		.formats = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S24_LE,
+	},
+
+	.ops = &cdn_dp_audio_dai_ops,
+};
+
+static const struct snd_soc_codec_driver cdn_dp_audio = {
+	.dapm_widgets = snd_cdn_dp_audio_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(snd_cdn_dp_audio_widgets),
+	.dapm_routes = snd_cdn_dp_audio_routes,
+	.num_dapm_routes = ARRAY_SIZE(snd_cdn_dp_audio_routes),
+};
+
+static int cdn_dp_audio_probe(struct platform_device *pdev)
+{
+	struct cdn_dp_audio_pdata *pdata = pdev->dev.platform_data;
+	struct snd_cdn_dp_audio *ad;
+	int ret;
+
+	ad = devm_kzalloc(&pdev->dev, sizeof(*ad), GFP_KERNEL);
+	if (!ad)
+		return -ENOMEM;
+
+	ad->dev = pdata->dev;
+	ad->ops = pdata->ops;
+	ad->data = pdata->data;
+
+	platform_set_drvdata(pdev, ad);
+
+	ret = snd_soc_register_codec(&pdev->dev, &cdn_dp_audio,
+				     &cdn_dp_audio_dai, 1);
+	if (ret) {
+		dev_err(&pdev->dev, "register codec failed (%d)\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int cdn_dp_audio_remove(struct platform_device *pdev)
+{
+	snd_soc_unregister_codec(&pdev->dev);
+
+	return 0;
+}
+
+static const struct of_device_id cdn_dp_audio_ids[] = {
+	{ .compatible = "cdn-dp-audio", },
+	{ }
+};
+
+static struct platform_driver cdn_dp_audio_driver = {
+	.driver = {
+		.name = "cdn-dp-audio",
+		.owner = THIS_MODULE,
+		.of_match_table = of_match_ptr(cdn_dp_audio_ids),
+	},
+	.probe = cdn_dp_audio_probe,
+	.remove = cdn_dp_audio_remove,
+};
+module_platform_driver(cdn_dp_audio_driver);
+
+MODULE_AUTHOR("Chris Zhong <zyw@rock-chips.com>");
+MODULE_DESCRIPTION("CDN DP Audio ASoC Interface");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform: cdn-dp-audio");
+MODULE_DEVICE_TABLE(of, cdn_dp_audio_ids);
-- 
2.6.3
