From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [PATCH 03/12] ASoC: hdac: Add a generic hdac driver
	framework
Date: Mon, 29 Aug 2016 11:53:17 +0530
Message-ID: <1472451806-10605-4-git-send-email-subhransu.s.prusty@intel.com>
References: <1472451806-10605-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 239FC266E0D
 for <alsa-devel@alsa-project.org>; Mon, 29 Aug 2016 18:23:41 +0200 (CEST)
In-Reply-To: <1472451806-10605-1-git-send-email-subhransu.s.prusty@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, lgirdwood@gmail.com, patches.audio@intel.com, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

This patch adds support to register the hdac driver with the HDA
bus and enumerate the driver if a device is found.

It uses the hdac core helper APIs to parse the HDA widgets and
identifies the number of mapping dapm widgets to be created.
Based on the ADCs and DACs queries the codec dais are allocated
and registers with asoc.

The AFG node is power managed through set_bias_level callback and
hw_params, program_stream_tag callback support are added in the
dai_ops to program the stream parameters.

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/codecs/Kconfig        |   5 +
 sound/soc/codecs/Makefile       |   2 +
 sound/soc/codecs/hdac_generic.c | 439 ++++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/hdac_generic.h |  25 +++
 4 files changed, 471 insertions(+)
 create mode 100644 sound/soc/codecs/hdac_generic.c
 create mode 100644 sound/soc/codecs/hdac_generic.h

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 1cd6ab3..5e688ee 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -71,6 +71,7 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_ES8328_SPI if SPI_MASTER
 	select SND_SOC_ES8328_I2C if I2C
 	select SND_SOC_GTM601
+	select SND_SOC_HDAC_GENERIC
 	select SND_SOC_HDAC_HDMI
 	select SND_SOC_ICS43432
 	select SND_SOC_INNO_RK3036
@@ -523,6 +524,10 @@ config SND_SOC_ES8328_SPI
 config SND_SOC_GTM601
 	tristate 'GTM601 UMTS modem audio codec'
 
+config SND_SOC_HDAC_GENERIC
+	tristate
+	select SND_HDA_EXT_CORE
+
 config SND_SOC_HDAC_HDMI
 	tristate
 	select SND_HDA_EXT_CORE
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index 58036af..1d1001c 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -65,6 +65,7 @@ snd-soc-es8328-objs := es8328.o
 snd-soc-es8328-i2c-objs := es8328-i2c.o
 snd-soc-es8328-spi-objs := es8328-spi.o
 snd-soc-gtm601-objs := gtm601.o
+snd-soc-hdac-generic-objs := hdac_generic.o
 snd-soc-hdac-hdmi-objs := hdac_hdmi.o
 snd-soc-ics43432-objs := ics43432.o
 snd-soc-inno-rk3036-objs := inno_rk3036.o
@@ -287,6 +288,7 @@ obj-$(CONFIG_SND_SOC_ES8328)	+= snd-soc-es8328.o
 obj-$(CONFIG_SND_SOC_ES8328_I2C)+= snd-soc-es8328-i2c.o
 obj-$(CONFIG_SND_SOC_ES8328_SPI)+= snd-soc-es8328-spi.o
 obj-$(CONFIG_SND_SOC_GTM601)    += snd-soc-gtm601.o
+obj-$(CONFIG_SND_SOC_HDAC_GENERIC) += snd-soc-hdac-generic.o
 obj-$(CONFIG_SND_SOC_HDAC_HDMI) += snd-soc-hdac-hdmi.o
 obj-$(CONFIG_SND_SOC_ICS43432)	+= snd-soc-ics43432.o
 obj-$(CONFIG_SND_SOC_INNO_RK3036)	+= snd-soc-inno-rk3036.o
diff --git a/sound/soc/codecs/hdac_generic.c b/sound/soc/codecs/hdac_generic.c
new file mode 100644
index 0000000..99e624e
--- /dev/null
+++ b/sound/soc/codecs/hdac_generic.c
@@ -0,0 +1,439 @@
+/*
+ *  hdac_generic.c - ASoc HDA generic codec driver
+ *
+ *  Copyright (C) 2016 Intel Corp
+ *  Author: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
+ *  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; version 2 of the License.
+ *
+ *  This program is distributed in the hope that it will be useful, but
+ *  WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  General Public License for more details.
+ *
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ */
+
+#include <linux/init.h>
+#include <linux/delay.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <sound/soc.h>
+#include <sound/pcm_params.h>
+#include <sound/hdaudio_ext.h>
+#include <sound/hda_regmap.h>
+#include "../../hda/local.h"
+#include "../../hda/ext/hdac_codec.h"
+#include "hdac_generic.h"
+
+#define HDA_MAX_CVTS	10
+
+struct hdac_generic_dai_map {
+	struct hdac_codec_widget *cvt;
+};
+
+struct hdac_generic_priv {
+	struct hdac_generic_dai_map dai_map[HDA_MAX_CVTS];
+	unsigned int num_pins;
+	unsigned int num_adcs;
+	unsigned int num_dacs;
+	unsigned int num_dapm_widgets;
+};
+
+static void hdac_generic_set_power_state(struct hdac_ext_device *edev,
+			hda_nid_t nid, unsigned int pwr_state)
+{
+	/* TODO: check D0sup bit before setting this */
+	if (!snd_hdac_check_power_state(&edev->hdac, nid, pwr_state))
+		snd_hdac_codec_write(&edev->hdac, nid, 0,
+				AC_VERB_SET_POWER_STATE, pwr_state);
+}
+
+static void hdac_generic_calc_dapm_widgets(struct hdac_ext_device *edev)
+{
+	struct hdac_generic_priv *hdac_priv = edev->private_data;
+	struct hdac_codec_widget *wid;
+
+	if (list_empty(&edev->hdac.widget_list))
+		return;
+
+	/*
+	 * PIN widget with output capable are represented with an additional
+	 * virtual mux widgets.
+	 */
+	list_for_each_entry(wid, &edev->hdac.widget_list, head) {
+		switch (wid->type) {
+		case AC_WID_AUD_IN:
+			hdac_priv->num_dapm_widgets++;
+			hdac_priv->num_adcs++;
+			break;
+
+		case AC_WID_AUD_OUT:
+			hdac_priv->num_dapm_widgets++;
+			hdac_priv->num_dacs++;
+			break;
+
+		case AC_WID_PIN:
+			hdac_priv->num_pins++;
+			/*
+			 * PIN widgets are represented with dapm_pga and
+			 * dapm_output.
+			 */
+			hdac_priv->num_dapm_widgets += 2;
+
+			if (is_input_pin(&edev->hdac, wid->nid))
+				continue;
+
+			/*
+			 * PIN widget with output capable are represented
+			 * with an additional virtual mux widgets.
+			 */
+			if (wid->num_inputs > 1)
+				hdac_priv->num_dapm_widgets++;
+
+			break;
+
+		case AC_WID_AUD_MIX:
+			hdac_priv->num_dapm_widgets++;
+			break;
+
+		case AC_WID_AUD_SEL:
+			hdac_priv->num_dapm_widgets++;
+			break;
+
+		case AC_WID_POWER:
+			hdac_priv->num_dapm_widgets++;
+			break;
+
+		case AC_WID_BEEP:
+			/*
+			 * Beep widgets are represented with a siggen and
+			 * pga dapm widgets
+			 */
+			hdac_priv->num_dapm_widgets += 2;
+			break;
+
+		default:
+			dev_warn(&edev->hdac.dev, "no dapm widget for type: %d\n",
+						wid->type);
+			break;
+		}
+	}
+}
+
+static int hdac_generic_set_hw_params(struct snd_pcm_substream *substream,
+	struct snd_pcm_hw_params *hparams, struct snd_soc_dai *dai)
+{
+	struct hdac_ext_device *edev = snd_soc_dai_get_drvdata(dai);
+	struct hdac_generic_priv *hdac_priv = edev->private_data;
+	struct hdac_generic_dai_map *dai_map = &hdac_priv->dai_map[dai->id];
+	u32 format;
+
+	format = snd_hdac_calc_stream_format(params_rate(hparams),
+			params_channels(hparams), params_format(hparams),
+			32, 0);
+
+	snd_hdac_codec_write(&edev->hdac, dai_map->cvt->nid, 0,
+				AC_VERB_SET_STREAM_FORMAT, format);
+
+	return 0;
+}
+
+static int hdac_generic_set_tdm_slot(struct snd_soc_dai *dai,
+		unsigned int tx_mask, unsigned int rx_mask,
+		int slots, int slot_width)
+{
+	struct hdac_ext_device *edev = snd_soc_dai_get_drvdata(dai);
+	struct hdac_generic_priv *hdac_priv = edev->private_data;
+	struct hdac_generic_dai_map *dai_map = &hdac_priv->dai_map[dai->id];
+	int val;
+
+	dev_dbg(&edev->hdac.dev, "%s: strm_tag: %d\n", __func__, tx_mask);
+
+	val = snd_hdac_codec_read(&edev->hdac, dai_map->cvt->nid, 0,
+					AC_VERB_GET_CONV, 0);
+	snd_hdac_codec_write(&edev->hdac, dai_map->cvt->nid, 0,
+				AC_VERB_SET_CHANNEL_STREAMID,
+				(val & 0xf0) | (tx_mask << 4));
+
+	return 0;
+}
+
+static int hdac_codec_set_bias_level(struct snd_soc_codec *codec,
+			enum snd_soc_bias_level level)
+{
+	struct hdac_ext_device *edev = snd_soc_codec_get_drvdata(codec);
+	struct hdac_device *hdac = &edev->hdac;
+
+	dev_dbg(&edev->hdac.dev, "%s: level: %d\n", __func__, level);
+
+	switch (level) {
+	case SND_SOC_BIAS_PREPARE:
+		hdac_generic_set_power_state(edev, hdac->afg, AC_PWRST_D0);
+		break;
+
+	case SND_SOC_BIAS_OFF:
+		hdac_generic_set_power_state(edev, hdac->afg, AC_PWRST_D3);
+		break;
+
+	default:
+		dev_info(&edev->hdac.dev, "Bias level %d not handled\n", level);
+		break;
+	}
+
+	return 0;
+}
+
+static int hdac_codec_probe(struct snd_soc_codec *codec)
+{
+	struct hdac_ext_device *edev = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_dapm_context *dapm =
+		snd_soc_component_get_dapm(&codec->component);
+
+	edev->scodec = codec;
+
+	/* TODO: create widget, route and controls */
+	/* TODO: jack sense */
+
+	/* Imp: Store the card pointer in hda_codec */
+	edev->card = dapm->card->snd_card;
+
+	/* TODO: runtime PM */
+	return 0;
+}
+
+static struct snd_soc_codec_driver hdac_generic_codec = {
+	.probe		= hdac_codec_probe,
+	.set_bias_level = hdac_codec_set_bias_level,
+};
+
+static struct snd_soc_dai_ops hdac_generic_ops = {
+	.hw_params = hdac_generic_set_hw_params,
+	.set_tdm_slot = hdac_generic_set_tdm_slot,
+};
+
+static int fill_codec_dai_stream_info(struct hdac_device *hdac,
+			struct snd_soc_pcm_stream *strm,
+			struct hdac_codec_widget *widget)
+{
+	u32 rates, bps;
+	unsigned int rate_max = 192000, rate_min = 8000;
+	u64 formats;
+	int ret;
+
+	/* Set caps based on capability queried from the converter */
+	ret = snd_hdac_query_supported_pcm(hdac, widget->nid,
+			&rates,	&formats, &bps);
+	if (ret)
+		return ret;
+
+	strm->formats = formats;
+	strm->rates = rates;
+	strm->rate_max = rate_max;
+	strm->rate_min = rate_min;
+
+	/* Only stereo for now */
+	strm->channels_min = 2;
+	strm->channels_max = 2;
+
+	return 0;
+}
+
+static int fill_codec_dai_desc(struct hdac_device *hdac,
+		struct snd_soc_dai_driver *codec_dai,
+		struct hdac_codec_widget *widget)
+{
+	char dai_name[HDAC_GENERIC_NAME_SIZE];
+
+	sprintf(dai_name, "%x-aif%d", hdac->vendor_id, widget->nid);
+
+	codec_dai->name = devm_kstrdup(&hdac->dev, dai_name,
+						GFP_KERNEL);
+	if (!codec_dai->name)
+		return -ENOMEM;
+
+	codec_dai->ops = &hdac_generic_ops;
+	codec_dai->dobj.private = widget;
+
+	return 0;
+}
+
+/* Codec dai name: <vendor id>-aif<widget nid> */
+static int hdac_generic_create_dais(struct hdac_ext_device *edev,
+		struct snd_soc_dai_driver **dais, int num_dais)
+{
+	struct hdac_device *hdac = &edev->hdac;
+	struct hdac_generic_priv *hdac_priv = edev->private_data;
+	struct snd_soc_dai_driver *codec_dais;
+	char stream_name[HDAC_GENERIC_NAME_SIZE];
+	struct hdac_codec_widget *widget;
+	int i = 0;
+	int ret;
+
+	codec_dais = devm_kcalloc(&hdac->dev, num_dais,
+			sizeof(*codec_dais), GFP_KERNEL);
+	if (!codec_dais)
+		return -ENOMEM;
+
+	/* Iterate over the input adc and dac list to create DAIs */
+	list_for_each_entry(widget, &edev->hdac.widget_list, head) {
+		switch (widget->type) {
+		case AC_WID_AUD_IN:
+			ret = fill_codec_dai_desc(hdac, &codec_dais[i], widget);
+			if (ret < 0)
+				return ret;
+
+			hdac_priv->dai_map[i].cvt = widget;
+			snprintf(stream_name, sizeof(stream_name),
+					"Analog Capture-%d", widget->nid);
+			codec_dais[i].capture.stream_name =
+					devm_kstrdup(&hdac->dev, stream_name,
+								GFP_KERNEL);
+			if (!codec_dais[i].capture.stream_name)
+				return -ENOMEM;
+
+			ret = fill_codec_dai_stream_info(hdac,
+					&codec_dais[i].capture, widget);
+			if (ret < 0)
+				return ret;
+
+			i++;
+			break;
+
+		case AC_WID_AUD_OUT:
+			ret = fill_codec_dai_desc(hdac, &codec_dais[i], widget);
+			if (ret < 0)
+				return ret;
+			hdac_priv->dai_map[i].cvt = widget;
+			if (widget->caps & AC_WCAP_DIGITAL)
+				snprintf(stream_name, sizeof(stream_name),
+					"Digital Playback-%d", widget->nid);
+			else
+				snprintf(stream_name, sizeof(stream_name),
+					"Analog Playback-%d", widget->nid);
+
+			codec_dais[i].playback.stream_name =
+					devm_kstrdup(&hdac->dev, stream_name,
+								GFP_KERNEL);
+			if (!codec_dais[i].playback.stream_name)
+				return -ENOMEM;
+
+			ret = fill_codec_dai_stream_info(hdac,
+					&codec_dais[i].capture, widget);
+			if (ret < 0)
+				return ret;
+
+			i++;
+
+			break;
+		default:
+			dev_warn(&hdac->dev, "Invalid widget type: %d\n",
+						widget->type);
+			break;
+		}
+	}
+
+	*dais = codec_dais;
+
+	return 0;
+}
+
+static int hdac_generic_dev_probe(struct hdac_ext_device *edev)
+{
+	struct hdac_device *codec = &edev->hdac;
+	struct hdac_generic_priv *hdac_priv;
+	struct snd_soc_dai_driver *codec_dais = NULL;
+	int num_dais = 0;
+	int ret = 0;
+
+	hdac_priv = devm_kzalloc(&codec->dev, sizeof(*hdac_priv), GFP_KERNEL);
+	if (hdac_priv == NULL)
+		return -ENOMEM;
+
+	ret = snd_hdac_codec_init(codec);
+	if (ret < 0)
+		return ret;
+
+	edev->private_data = hdac_priv;
+	dev_set_drvdata(&codec->dev, edev);
+
+	ret = snd_hdac_parse_widgets(codec);
+	if (ret < 0) {
+		dev_err(&codec->dev, "Failed to parse widgets with err: %d\n",
+							ret);
+		return ret;
+	}
+
+	hdac_generic_calc_dapm_widgets(edev);
+
+	if (!hdac_priv->num_pins ||
+			((!hdac_priv->num_adcs) &&
+			(!hdac_priv->num_dacs))) {
+
+		dev_err(&codec->dev, "No port widgets or cvt widgets");
+		return -EIO;
+	}
+
+	num_dais = hdac_priv->num_adcs + hdac_priv->num_dacs;
+
+	ret = hdac_generic_create_dais(edev, &codec_dais, num_dais);
+	if (ret < 0) {
+		dev_err(&codec->dev, "Failed to create dais with err: %d\n",
+							ret);
+		return ret;
+	}
+
+	/* ASoC specific initialization */
+	return snd_soc_register_codec(&codec->dev, &hdac_generic_codec,
+						codec_dais, num_dais);
+}
+
+static int hdac_generic_dev_remove(struct hdac_ext_device *edev)
+{
+	snd_hdac_codec_cleanup(&edev->hdac);
+	return 0;
+}
+
+/*
+ * TODO:
+ * Driver_data will be used to perform any vendor specific init, register
+ * specific dai ops.
+ * Driver will implement it's own match function to retrieve driver data.
+ */
+static const struct hda_device_id codec_list[] = {
+	HDA_CODEC_EXT_ENTRY(0x10ec0286, 0x100002, "ALC286", 0),
+	{}
+};
+MODULE_DEVICE_TABLE(hdaudio, codec_list);
+
+static struct hdac_ext_driver hdac_codec_driver = {
+	. hdac = {
+		.driver = {
+			.name   = "HDA ASoC Codec",
+			/* Add PM */
+		},
+		.id_table       = codec_list,
+	},
+	.probe          = hdac_generic_dev_probe,
+	.remove         = hdac_generic_dev_remove,
+};
+
+static int __init hdac_generic_init(void)
+{
+	return snd_hda_ext_driver_register(&hdac_codec_driver);
+}
+
+static void __exit hdac_generic_exit(void)
+{
+	snd_hda_ext_driver_unregister(&hdac_codec_driver);
+}
+
+module_init(hdac_generic_init);
+module_exit(hdac_generic_exit);
+
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("HDA ASoC codec");
+MODULE_AUTHOR("Subhransu S. Prusty<subhransu.s.prusty@intel.com>");
diff --git a/sound/soc/codecs/hdac_generic.h b/sound/soc/codecs/hdac_generic.h
new file mode 100644
index 0000000..5ca713a
--- /dev/null
+++ b/sound/soc/codecs/hdac_generic.h
@@ -0,0 +1,25 @@
+/*
+ *  hdac_generic.h - ASoc HDA generic codec driver
+ *
+ *  Copyright (C) 2016 Intel Corp
+ *  Author: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
+ *  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; version 2 of the License.
+ *
+ *  This program is distributed in the hope that it will be useful, but
+ *  WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  General Public License for more details.
+ *
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ */
+
+#ifndef __HDAC_GENERIC_H__
+#define __HDAC_GENERIC_H__
+
+#define HDAC_GENERIC_NAME_SIZE	32
+
+#endif /* __HDAC_GENERIC_H__ */
-- 
1.9.1
