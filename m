From: "Matti J. Aaltonen" <matti.j.aaltonen@nokia.com>
Subject: [PATCH v7 1/1] ASoC: TI WL1273 FM Radio Codec.
Date: Thu, 19 Aug 2010 17:00:21 +0300
Message-ID: <1282226421-23202-2-git-send-email-matti.j.aaltonen@nokia.com>
References: <1282226421-23202-1-git-send-email-matti.j.aaltonen@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id D74CB243EF
	for <alsa-devel@alsa-project.org>;
	Thu, 19 Aug 2010 16:01:31 +0200 (CEST)
In-Reply-To: <1282226421-23202-1-git-send-email-matti.j.aaltonen@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk, peter.ujfalusi@nokia.com
Cc: "Matti J. Aaltonen" <matti.j.aaltonen@nokia.com>
List-Id: alsa-devel@alsa-project.org

This is an ALSA codec for the Texas Instruments WL1273 FM Radio.

Signed-off-by: Matti J. Aaltonen <matti.j.aaltonen@nokia.com>
---
 sound/soc/codecs/wl1273.c |  533 +++++++++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/wl1273.h |  101 +++++++++
 2 files changed, 634 insertions(+), 0 deletions(-)
 create mode 100644 sound/soc/codecs/wl1273.c
 create mode 100644 sound/soc/codecs/wl1273.h

diff --git a/sound/soc/codecs/wl1273.c b/sound/soc/codecs/wl1273.c
new file mode 100644
index 0000000..a179303
--- /dev/null
+++ b/sound/soc/codecs/wl1273.c
@@ -0,0 +1,533 @@
+/*
+ * ALSA SoC WL1273 codec driver
+ *
+ * Author:      Matti Aaltonen, <matti.j.aaltonen@nokia.com>
+ *
+ * Copyright:   (C) 2010 Nokia Corporation
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
+ * 02110-1301 USA
+ *
+ */
+
+#include <linux/mfd/wl1273-core.h>
+#include <linux/slab.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc-dai.h>
+#include <sound/soc-dapm.h>
+#include <sound/initval.h>
+
+#include "wl1273.h"
+
+enum wl1273_mode { WL1273_MODE_BT, WL1273_MODE_FM_RX, WL1273_MODE_FM_TX };
+
+/* codec private data */
+struct wl1273_priv {
+	enum wl1273_mode mode;
+	struct wl1273_core *core;
+	unsigned int channels;
+};
+
+static int snd_wl1273_fm_set_i2s_mode(struct wl1273_core *core,
+				      int rate, int width)
+{
+	struct device *dev = &core->i2c_dev->dev;
+	int r = 0;
+	u16 mode;
+
+	dev_dbg(dev, "rate: %d\n", rate);
+	dev_dbg(dev, "width: %d\n", width);
+
+	mutex_lock(&core->lock);
+
+	mode = core->i2s_mode & ~WL1273_IS2_WIDTH & ~WL1273_IS2_RATE;
+
+	switch (rate) {
+	case 48000:
+		mode |= WL1273_IS2_RATE_48K;
+		break;
+	case 44100:
+		mode |= WL1273_IS2_RATE_44_1K;
+		break;
+	case 32000:
+		mode |= WL1273_IS2_RATE_32K;
+		break;
+	case 22050:
+		mode |= WL1273_IS2_RATE_22_05K;
+		break;
+	case 16000:
+		mode |= WL1273_IS2_RATE_16K;
+		break;
+	case 12000:
+		mode |= WL1273_IS2_RATE_12K;
+		break;
+	case 11025:
+		mode |= WL1273_IS2_RATE_11_025;
+		break;
+	case 8000:
+		mode |= WL1273_IS2_RATE_8K;
+		break;
+	default:
+		dev_err(dev, "Sampling rate: %d not supported\n", rate);
+		r = -EINVAL;
+		goto out;
+	}
+
+	switch (width) {
+	case 16:
+		mode |= WL1273_IS2_WIDTH_32;
+		break;
+	case 20:
+		mode |= WL1273_IS2_WIDTH_40;
+		break;
+	case 24:
+		mode |= WL1273_IS2_WIDTH_48;
+		break;
+	case 25:
+		mode |= WL1273_IS2_WIDTH_50;
+		break;
+	case 30:
+		mode |= WL1273_IS2_WIDTH_60;
+		break;
+	case 32:
+		mode |= WL1273_IS2_WIDTH_64;
+		break;
+	case 40:
+		mode |= WL1273_IS2_WIDTH_80;
+		break;
+	case 48:
+		mode |= WL1273_IS2_WIDTH_96;
+		break;
+	case 64:
+		mode |= WL1273_IS2_WIDTH_128;
+		break;
+	default:
+		dev_err(dev, "Data width: %d not supported\n", width);
+		r = -EINVAL;
+		goto out;
+	}
+
+	dev_dbg(dev, "WL1273_I2S_DEF_MODE: 0x%04x\n",  WL1273_I2S_DEF_MODE);
+	dev_dbg(dev, "core->i2s_mode: 0x%04x\n", core->i2s_mode);
+	dev_dbg(dev, "mode: 0x%04x\n", mode);
+
+	if (core->i2s_mode != mode) {
+		r = wl1273_fm_write_cmd(core, WL1273_I2S_MODE_CONFIG_SET, mode);
+		if (r)
+			goto out;
+
+		core->i2s_mode = mode;
+		r = wl1273_fm_write_cmd(core, WL1273_AUDIO_ENABLE,
+					WL1273_AUDIO_ENABLE_I2S);
+		if (r)
+			goto out;
+	}
+out:
+	mutex_unlock(&core->lock);
+
+	return r;
+}
+
+static int snd_wl1273_fm_set_channel_number(struct wl1273_core *core,
+					    int channel_number)
+{
+	struct i2c_client *client = core->i2c_dev;
+	struct device *dev = &client->dev;
+	int r = 0;
+
+	dev_dbg(dev, "%s\n", __func__);
+
+	mutex_lock(&core->lock);
+
+	if (core->channel_number == channel_number)
+		goto out;
+
+	if (channel_number == 1 && core->mode == WL1273_MODE_RX)
+		r = wl1273_fm_write_cmd(core, WL1273_MOST_MODE_SET,
+					WL1273_RX_MONO);
+	else if (channel_number == 1 && core->mode == WL1273_MODE_TX)
+		r = wl1273_fm_write_cmd(core, WL1273_MONO_SET,
+					WL1273_TX_MONO);
+	else if (channel_number == 2 && core->mode == WL1273_MODE_RX)
+		r = wl1273_fm_write_cmd(core, WL1273_MOST_MODE_SET,
+					WL1273_RX_STEREO);
+	else if (channel_number == 2 && core->mode == WL1273_MODE_TX)
+		r = wl1273_fm_write_cmd(core, WL1273_MONO_SET,
+					WL1273_TX_STEREO);
+	else
+		r = -EINVAL;
+out:
+	mutex_unlock(&core->lock);
+
+	return r;
+}
+
+static int snd_wl1273_get_audio_route(struct snd_kcontrol *kcontrol,
+				      struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct wl1273_priv *wl1273 = snd_soc_codec_get_drvdata(codec);
+
+	ucontrol->value.integer.value[0] = wl1273->mode;
+
+	return 0;
+}
+
+static const char *wl1273_audio_route[] = { "Bt", "FmRx", "FmTx" };
+
+static int snd_wl1273_set_audio_route(struct snd_kcontrol *kcontrol,
+				      struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct wl1273_priv *wl1273 = snd_soc_codec_get_drvdata(codec);
+
+	/* Do not allow changes while stream is running */
+	if (codec->active)
+		return -EPERM;
+
+	if (ucontrol->value.integer.value[0] < 0 ||
+	    ucontrol->value.integer.value[0] >=  ARRAY_SIZE(wl1273_audio_route))
+		return -EINVAL;
+
+	wl1273->mode = ucontrol->value.integer.value[0];
+
+	return 1;
+}
+
+static const struct soc_enum wl1273_enum =
+	SOC_ENUM_SINGLE_EXT(ARRAY_SIZE(wl1273_audio_route), wl1273_audio_route);
+
+static int snd_wl1273_fm_audio_get(struct snd_kcontrol *kcontrol,
+				   struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct wl1273_priv *wl1273 = snd_soc_codec_get_drvdata(codec);
+
+	dev_dbg(codec->dev, "%s: enter.\n", __func__);
+
+	ucontrol->value.integer.value[0] = wl1273->core->audio_mode;
+
+	return 0;
+}
+
+static int snd_wl1273_fm_audio_put(struct snd_kcontrol *kcontrol,
+				   struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct wl1273_priv *wl1273 = snd_soc_codec_get_drvdata(codec);
+	int val, r = 0;
+
+	dev_dbg(codec->dev, "%s: enter.\n", __func__);
+
+	val = ucontrol->value.integer.value[0];
+	if (wl1273->core->audio_mode == val)
+		return 0;
+
+	r = wl1273_fm_set_audio(wl1273->core, val);
+	if (r < 0)
+		return r;
+
+	return 1;
+}
+
+static const char *wl1273_audio_strings[] = { "Digital", "Analog" };
+
+static const struct soc_enum wl1273_audio_enum =
+	SOC_ENUM_SINGLE_EXT(ARRAY_SIZE(wl1273_audio_strings),
+			    wl1273_audio_strings);
+
+static int snd_wl1273_fm_volume_get(struct snd_kcontrol *kcontrol,
+				    struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct wl1273_priv *wl1273 = snd_soc_codec_get_drvdata(codec);
+
+	dev_dbg(codec->dev, "%s: enter.\n", __func__);
+
+	ucontrol->value.integer.value[0] = wl1273->core->volume;
+
+	return 0;
+}
+
+static int snd_wl1273_fm_volume_put(struct snd_kcontrol *kcontrol,
+				    struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct wl1273_priv *wl1273 = snd_soc_codec_get_drvdata(codec);
+	int r;
+
+	dev_dbg(codec->dev, "%s: enter.\n", __func__);
+
+	r = wl1273_fm_set_volume(wl1273->core,
+				 ucontrol->value.integer.value[0]);
+	if (r)
+		return r;
+
+	return 1;
+}
+
+static const struct snd_kcontrol_new wl1273_controls[] = {
+	SOC_ENUM_EXT("Codec Mode", wl1273_enum,
+		     snd_wl1273_get_audio_route, snd_wl1273_set_audio_route),
+	SOC_ENUM_EXT("Audio Switch", wl1273_audio_enum,
+		     snd_wl1273_fm_audio_get,  snd_wl1273_fm_audio_put),
+	SOC_SINGLE_EXT("Volume", 0, 0, WL1273_MAX_VOLUME, 0,
+		       snd_wl1273_fm_volume_get, snd_wl1273_fm_volume_put),
+};
+
+static int wl1273_startup(struct snd_pcm_substream *substream,
+			  struct snd_soc_dai *dai)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_codec *codec = rtd->codec;
+	struct wl1273_priv *wl1273 = snd_soc_codec_get_drvdata(codec);
+
+	switch (wl1273->mode) {
+	case WL1273_MODE_BT:
+		snd_pcm_hw_constraint_minmax(substream->runtime,
+					     SNDRV_PCM_HW_PARAM_RATE,
+					     8000, 8000);
+		snd_pcm_hw_constraint_minmax(substream->runtime,
+					     SNDRV_PCM_HW_PARAM_CHANNELS, 1, 1);
+		break;
+	case WL1273_MODE_FM_RX:
+		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+			pr_err("Cannot play in RX mode.\n");
+			return -EINVAL;
+		}
+		break;
+	case WL1273_MODE_FM_TX:
+		if (substream->stream == SNDRV_PCM_STREAM_CAPTURE) {
+			pr_err("Cannot capture in TX mode.\n");
+			return -EINVAL;
+		}
+		break;
+	default:
+		return -EINVAL;
+		break;
+	}
+
+	return 0;
+}
+
+static int wl1273_hw_params(struct snd_pcm_substream *substream,
+			    struct snd_pcm_hw_params *params,
+			    struct snd_soc_dai *dai)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct wl1273_priv *wl1273 = snd_soc_codec_get_drvdata(rtd->codec);
+	struct wl1273_core *core = wl1273->core;
+	unsigned int rate, width, r;
+
+	if (params_format(params) != SNDRV_PCM_FORMAT_S16_LE) {
+		pr_err("Only SNDRV_PCM_FORMAT_S16_LE supported.\n");
+		return -EINVAL;
+	}
+
+	rate = params_rate(params);
+	width =  hw_param_interval(params, SNDRV_PCM_HW_PARAM_SAMPLE_BITS)->min;
+
+	if (wl1273->mode == WL1273_MODE_BT) {
+		if (rate != 8000) {
+			pr_err("Rate %d not supported.\n", params_rate(params));
+			return -EINVAL;
+		}
+
+		if (params_channels(params) != 1) {
+			pr_err("Only mono supported.\n");
+			return -EINVAL;
+		}
+
+		return 0;
+	}
+
+	if (wl1273->mode == WL1273_MODE_FM_TX &&
+	    substream->stream == SNDRV_PCM_STREAM_CAPTURE) {
+		pr_err("Only playback supported with TX.\n");
+		return -EINVAL;
+	}
+
+	if (wl1273->mode == WL1273_MODE_FM_RX  &&
+	    substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		pr_err("Only capture supported with RX.\n");
+		return -EINVAL;
+	}
+
+	if (wl1273->mode != WL1273_MODE_FM_RX  &&
+	    wl1273->mode != WL1273_MODE_FM_TX) {
+		pr_err("Unexpected mode: %d.\n", wl1273->mode);
+		return -EINVAL;
+	}
+
+	r = snd_wl1273_fm_set_i2s_mode(core, rate, width);
+	if (r)
+		return r;
+
+	wl1273->channels = params_channels(params);
+	r = snd_wl1273_fm_set_channel_number(core, wl1273->channels);
+	if (r)
+		return r;
+
+	return 0;
+}
+
+static struct snd_soc_dai_ops wl1273_dai_ops = {
+	.startup	= wl1273_startup,
+	.hw_params	= wl1273_hw_params,
+};
+
+static struct snd_soc_dai_driver wl1273_dai = {
+	.name = "wl1273-fm",
+	.playback = {
+		.stream_name = "Playback",
+		.channels_min = 1,
+		.channels_max = 2,
+		.rates = SNDRV_PCM_RATE_8000_48000,
+		.formats = SNDRV_PCM_FMTBIT_S16_LE},
+	.capture = {
+		.stream_name = "Capture",
+		.channels_min = 1,
+		.channels_max = 2,
+		.rates = SNDRV_PCM_RATE_8000_48000,
+		.formats = SNDRV_PCM_FMTBIT_S16_LE},
+	.ops = &wl1273_dai_ops,
+};
+
+/* Audio interface format for the soc_card driver */
+int wl1273_get_format(struct snd_soc_codec *codec, unsigned int *fmt)
+{
+	struct wl1273_priv *wl1273;
+
+	if (codec == NULL || fmt == NULL)
+		return -EINVAL;
+
+	wl1273 = snd_soc_codec_get_drvdata(codec);
+
+	switch (wl1273->mode) {
+	case WL1273_MODE_FM_RX:
+	case WL1273_MODE_FM_TX:
+		*fmt =	SND_SOC_DAIFMT_I2S |
+			SND_SOC_DAIFMT_NB_NF |
+			SND_SOC_DAIFMT_CBM_CFM;
+
+		break;
+	case WL1273_MODE_BT:
+		*fmt =	SND_SOC_DAIFMT_DSP_A |
+			SND_SOC_DAIFMT_IB_NF |
+			SND_SOC_DAIFMT_CBM_CFM;
+
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(wl1273_get_format);
+
+static int wl1273_probe(struct snd_soc_codec *codec)
+{
+	struct wl1273_core **core = codec->dev->platform_data;
+	struct wl1273_priv *wl1273;
+	int r;
+
+	dev_dbg(codec->dev, "%s.\n", __func__);
+
+	if (!core) {
+		dev_err(codec->dev, "Platform data is missing.\n");
+		return -EINVAL;
+	}
+
+	wl1273 = kzalloc(sizeof(struct wl1273_priv), GFP_KERNEL);
+	if (wl1273 == NULL) {
+		dev_err(codec->dev, "Cannot allocate memory.\n");
+		return -ENOMEM;
+	}
+
+	wl1273->mode = WL1273_MODE_BT;
+	wl1273->core = *core;
+
+	snd_soc_codec_set_drvdata(codec, wl1273);
+
+	mutex_init(&codec->mutex);
+	INIT_LIST_HEAD(&codec->dapm_widgets);
+	INIT_LIST_HEAD(&codec->dapm_paths);
+
+	codec->name = "wl1273";
+	codec->num_dai = 1;
+	codec->bias_level = SND_SOC_BIAS_OFF;
+	codec->control_data = wl1273->core;
+
+	r = snd_soc_add_controls(codec, wl1273_controls,
+				 ARRAY_SIZE(wl1273_controls));
+	if (r)
+		kfree(wl1273);
+
+	return r;
+}
+
+static int wl1273_remove(struct snd_soc_codec *codec)
+{
+	struct wl1273_priv *wl1273 = snd_soc_codec_get_drvdata(codec);
+
+	dev_dbg(codec->dev, "%s\n", __func__);
+	kfree(wl1273);
+
+	return 0;
+}
+
+static struct snd_soc_codec_driver soc_codec_dev_wl1273 = {
+	.probe = wl1273_probe,
+	.remove = wl1273_remove,
+};
+
+static int __devinit wl1273_platform_probe(struct platform_device *pdev)
+{
+	return snd_soc_register_codec(&pdev->dev, &soc_codec_dev_wl1273,
+				      &wl1273_dai, 1);
+}
+
+static int __devexit wl1273_platform_remove(struct platform_device *pdev)
+{
+	snd_soc_unregister_codec(&pdev->dev);
+	return 0;
+}
+
+MODULE_ALIAS("platform:wl1273-codec");
+
+static struct platform_driver wl1273_platform_driver = {
+	.driver		= {
+		.name	= "wl1273-codec",
+		.owner	= THIS_MODULE,
+	},
+	.probe		= wl1273_platform_probe,
+	.remove		= __devexit_p(wl1273_platform_remove),
+};
+
+static int __init wl1273_init(void)
+{
+	return platform_driver_register(&wl1273_platform_driver);
+}
+module_init(wl1273_init);
+
+static void __exit wl1273_exit(void)
+{
+	platform_driver_unregister(&wl1273_platform_driver);
+}
+module_exit(wl1273_exit);
+
+MODULE_AUTHOR("Matti Aaltonen <matti.j.aaltonen@nokia.com>");
+MODULE_DESCRIPTION("ASoC WL1273 codec driver");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/codecs/wl1273.h b/sound/soc/codecs/wl1273.h
new file mode 100644
index 0000000..14ed027
--- /dev/null
+++ b/sound/soc/codecs/wl1273.h
@@ -0,0 +1,101 @@
+/*
+ * sound/soc/codec/wl1273.h
+ *
+ * ALSA SoC WL1273 codec driver
+ *
+ * Copyright (C) Nokia Corporation
+ * Author: Matti Aaltonen <matti.j.aaltonen@nokia.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
+ * 02110-1301 USA
+ *
+ */
+
+#ifndef __WL1273_CODEC_H__
+#define __WL1273_CODEC_H__
+
+/* I2S protocol, left channel first, data width 16 bits */
+#define WL1273_PCM_DEF_MODE		0x00
+
+/* Rx */
+#define WL1273_AUDIO_ENABLE_I2S		(1 << 0)
+#define WL1273_AUDIO_ENABLE_ANALOG	(1 << 1)
+
+/* Tx */
+#define WL1273_AUDIO_IO_SET_ANALOG	0
+#define WL1273_AUDIO_IO_SET_I2S		1
+
+#define WL1273_POWER_SET_OFF		0
+#define WL1273_POWER_SET_FM		(1 << 0)
+#define WL1273_POWER_SET_RDS		(1 << 1)
+#define WL1273_POWER_SET_RETENTION	(1 << 4)
+
+#define WL1273_PUPD_SET_OFF		0x00
+#define WL1273_PUPD_SET_ON		0x01
+#define WL1273_PUPD_SET_RETENTION	0x10
+
+/* I2S mode */
+#define WL1273_IS2_WIDTH_32	0x0
+#define WL1273_IS2_WIDTH_40	0x1
+#define WL1273_IS2_WIDTH_22_23	0x2
+#define WL1273_IS2_WIDTH_23_22	0x3
+#define WL1273_IS2_WIDTH_48	0x4
+#define WL1273_IS2_WIDTH_50	0x5
+#define WL1273_IS2_WIDTH_60	0x6
+#define WL1273_IS2_WIDTH_64	0x7
+#define WL1273_IS2_WIDTH_80	0x8
+#define WL1273_IS2_WIDTH_96	0x9
+#define WL1273_IS2_WIDTH_128	0xa
+#define WL1273_IS2_WIDTH	0xf
+
+#define WL1273_IS2_FORMAT_STD	(0x0 << 4)
+#define WL1273_IS2_FORMAT_LEFT	(0x1 << 4)
+#define WL1273_IS2_FORMAT_RIGHT	(0x2 << 4)
+#define WL1273_IS2_FORMAT_USER	(0x3 << 4)
+
+#define WL1273_IS2_MASTER	(0x0 << 6)
+#define WL1273_IS2_SLAVEW	(0x1 << 6)
+
+#define WL1273_IS2_TRI_AFTER_SENDING	(0x0 << 7)
+#define WL1273_IS2_TRI_ALWAYS_ACTIVE	(0x1 << 7)
+
+#define WL1273_IS2_SDOWS_RR	(0x0 << 8)
+#define WL1273_IS2_SDOWS_RF	(0x1 << 8)
+#define WL1273_IS2_SDOWS_FR	(0x2 << 8)
+#define WL1273_IS2_SDOWS_FF	(0x3 << 8)
+
+#define WL1273_IS2_TRI_OPT	(0x0 << 10)
+#define WL1273_IS2_TRI_ALWAYS	(0x1 << 10)
+
+#define WL1273_IS2_RATE_48K	(0x0 << 12)
+#define WL1273_IS2_RATE_44_1K	(0x1 << 12)
+#define WL1273_IS2_RATE_32K	(0x2 << 12)
+#define WL1273_IS2_RATE_22_05K	(0x4 << 12)
+#define WL1273_IS2_RATE_16K	(0x5 << 12)
+#define WL1273_IS2_RATE_12K	(0x8 << 12)
+#define WL1273_IS2_RATE_11_025	(0x9 << 12)
+#define WL1273_IS2_RATE_8K	(0xa << 12)
+#define WL1273_IS2_RATE		(0xf << 12)
+
+#define WL1273_I2S_DEF_MODE	(WL1273_IS2_WIDTH_32 | \
+				 WL1273_IS2_FORMAT_STD | \
+				 WL1273_IS2_MASTER | \
+				 WL1273_IS2_TRI_AFTER_SENDING | \
+				 WL1273_IS2_SDOWS_RR | \
+				 WL1273_IS2_TRI_OPT | \
+				 WL1273_IS2_RATE_48K)
+
+int wl1273_get_format(struct snd_soc_codec *codec, unsigned int *fmt);
+
+#endif	/* End of __WL1273_CODEC_H__ */
-- 
1.6.1.3
