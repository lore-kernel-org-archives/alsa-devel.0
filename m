From: Rakesh Ughreja <rakesh.a.ughreja@intel.com>
Subject: [RFC v5 8/9] ASoC: hdac_hda: add asoc extension for
	legacy HDA codec drivers
Date: Wed,  3 Jan 2018 10:26:21 +0530
Message-ID: <1514955382-742-9-git-send-email-rakesh.a.ughreja@intel.com>
References: <1514955382-742-1-git-send-email-rakesh.a.ughreja@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 0409E26760A
 for <alsa-devel@alsa-project.org>; Wed,  3 Jan 2018 05:53:30 +0100 (CET)
In-Reply-To: <1514955382-742-1-git-send-email-rakesh.a.ughreja@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, broonie@kernel.org, tiwai@suse.de, liam.r.girdwood@linux.intel.com
Cc: vinod.koul@intel.com, patches.audio@intel.com, Rakesh Ughreja <rakesh.a.ughreja@intel.com>, pierre-louis.bossart@linux.intel.com
List-Id: alsa-devel@alsa-project.org

This patch adds a kernel module which is used by the legacy HDA
codec drivers as library. This implements hdac_ext_bus_ops to enable
the reuse of legacy HDA codec drivers with ASoC platform drivers.

Signed-off-by: Rakesh Ughreja <rakesh.a.ughreja@intel.com>
---
 sound/pci/hda/hda_bind.c    |  15 ++
 sound/soc/codecs/Kconfig    |   5 +
 sound/soc/codecs/Makefile   |   2 +
 sound/soc/codecs/hdac_hda.c | 517 ++++++++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/hdac_hda.h |  20 ++
 5 files changed, 559 insertions(+)
 create mode 100644 sound/soc/codecs/hdac_hda.c
 create mode 100644 sound/soc/codecs/hdac_hda.h

diff --git a/sound/pci/hda/hda_bind.c b/sound/pci/hda/hda_bind.c
index d361bb7..2b60ceb 100644
--- a/sound/pci/hda/hda_bind.c
+++ b/sound/pci/hda/hda_bind.c
@@ -81,6 +81,14 @@ static int hda_codec_driver_probe(struct device *dev)
 	hda_codec_patch_t patch;
 	int err;
 
+#if IS_ENABLED(CONFIG_SND_SOC_HDAC_HDA)
+	if (snd_hdac_get_bus_type(&codec->bus->core) == HDA_BUS_EXT) {
+		if (codec->bus->core.ext_ops->probe)
+			return codec->bus->core.ext_ops->probe(&codec->core);
+		return 0;
+	}
+#endif
+
 	if (WARN_ON(!codec->preset))
 		return -EINVAL;
 
@@ -134,6 +142,13 @@ static int hda_codec_driver_remove(struct device *dev)
 {
 	struct hda_codec *codec = dev_to_hda_codec(dev);
 
+#if IS_ENABLED(CONFIG_SND_SOC_HDAC_HDA)
+	if (snd_hdac_get_bus_type(&codec->bus->core) == HDA_BUS_EXT) {
+		if (codec->bus->core.ext_ops->remove)
+			return codec->bus->core.ext_ops->remove(&codec->core);
+		return 0;
+	}
+#endif
 	if (codec->patch_ops.free)
 		codec->patch_ops.free(codec);
 	snd_hda_codec_cleanup_for_unbind(codec);
diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 8b02bc8..fb1ac81 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -79,6 +79,7 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_ES7134
 	select SND_SOC_GTM601
 	select SND_SOC_HDAC_HDMI
+	select SND_SOC_HDAC_HDA
 	select SND_SOC_ICS43432
 	select SND_SOC_INNO_RK3036
 	select SND_SOC_ISABELLE if I2C
@@ -581,6 +582,10 @@ config SND_SOC_HDAC_HDMI
 	select SND_PCM_ELD
 	select HDMI
 
+config SND_SOC_HDAC_HDA
+	tristate
+	select SND_HDA
+
 config SND_SOC_ICS43432
 	tristate
 
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index 0977349..dd5f90f 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -73,6 +73,7 @@ snd-soc-es8328-i2c-objs := es8328-i2c.o
 snd-soc-es8328-spi-objs := es8328-spi.o
 snd-soc-gtm601-objs := gtm601.o
 snd-soc-hdac-hdmi-objs := hdac_hdmi.o
+snd-soc-hdac-hda-objs := hdac_hda.o
 snd-soc-ics43432-objs := ics43432.o
 snd-soc-inno-rk3036-objs := inno_rk3036.o
 snd-soc-isabelle-objs := isabelle.o
@@ -317,6 +318,7 @@ obj-$(CONFIG_SND_SOC_ES8328_I2C)+= snd-soc-es8328-i2c.o
 obj-$(CONFIG_SND_SOC_ES8328_SPI)+= snd-soc-es8328-spi.o
 obj-$(CONFIG_SND_SOC_GTM601)    += snd-soc-gtm601.o
 obj-$(CONFIG_SND_SOC_HDAC_HDMI) += snd-soc-hdac-hdmi.o
+obj-$(CONFIG_SND_SOC_HDAC_HDA) += snd-soc-hdac-hda.o
 obj-$(CONFIG_SND_SOC_ICS43432)	+= snd-soc-ics43432.o
 obj-$(CONFIG_SND_SOC_INNO_RK3036)	+= snd-soc-inno-rk3036.o
 obj-$(CONFIG_SND_SOC_ISABELLE)	+= snd-soc-isabelle.o
diff --git a/sound/soc/codecs/hdac_hda.c b/sound/soc/codecs/hdac_hda.c
new file mode 100644
index 0000000..df9596e
--- /dev/null
+++ b/sound/soc/codecs/hdac_hda.c
@@ -0,0 +1,517 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright(c) 2015-17 Intel Corporation.
+
+/*
+ * hdac_hda.c - ASoc exntensions to reuse the legacy HDA codec drivers
+ * with ASoC platform drivers. These APIs are called by the legacy HDA
+ * codec drivers using hdac_ext_bus_ops ops.
+ */
+
+#include <linux/init.h>
+#include <linux/delay.h>
+#include <linux/module.h>
+#include <linux/pm_runtime.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include <sound/hdaudio_ext.h>
+#include <sound/hda_register.h>
+#include "../../hda/local.h"
+#include "../../pci/hda/hda_codec.h"
+#include "hdac_hda.h"
+
+#define STUB_FORMATS	(SNDRV_PCM_FMTBIT_S8 | \
+			SNDRV_PCM_FMTBIT_U8 | \
+			SNDRV_PCM_FMTBIT_S16_LE | \
+			SNDRV_PCM_FMTBIT_U16_LE | \
+			SNDRV_PCM_FMTBIT_S24_LE | \
+			SNDRV_PCM_FMTBIT_U24_LE | \
+			SNDRV_PCM_FMTBIT_S32_LE | \
+			SNDRV_PCM_FMTBIT_U32_LE | \
+			SNDRV_PCM_FMTBIT_IEC958_SUBFRAME_LE)
+
+static int hdac_hda_dai_open(struct snd_pcm_substream *substream,
+			struct snd_soc_dai *dai);
+static void hdac_hda_dai_close(struct snd_pcm_substream *substream,
+		struct snd_soc_dai *dai);
+static int hdac_hda_dai_prepare(struct snd_pcm_substream *substream,
+				struct snd_soc_dai *dai);
+static int hdac_hda_dai_hw_params(struct snd_pcm_substream *substream,
+	struct snd_pcm_hw_params *hparams, struct snd_soc_dai *dai);
+static int hdac_hda_dai_hw_free(struct snd_pcm_substream *substream,
+				struct snd_soc_dai *dai);
+static int hdac_hda_dai_set_tdm_slot(struct snd_soc_dai *dai,
+		unsigned int tx_mask, unsigned int rx_mask,
+		int slots, int slot_width);
+static struct hda_pcm *snd_soc_find_pcm_from_dai(struct hdac_hda_priv *hda_pvt,
+						struct snd_soc_dai *dai);
+
+static struct snd_soc_dai_ops hdac_hda_dai_ops = {
+	.startup = hdac_hda_dai_open,
+	.shutdown = hdac_hda_dai_close,
+	.prepare = hdac_hda_dai_prepare,
+	.hw_params = hdac_hda_dai_hw_params,
+	.hw_free = hdac_hda_dai_hw_free,
+	.set_tdm_slot = hdac_hda_dai_set_tdm_slot,
+};
+
+static struct snd_soc_dai_driver hdac_hda_dais[] = {
+{
+	.name = "Analog Codec DAI",
+	.ops = &hdac_hda_dai_ops,
+	.playback = {
+		.stream_name	= "Analog Codec Playback",
+		.channels_min	= 1,
+		.channels_max	= 16,
+		.rates		= SNDRV_PCM_RATE_8000_192000,
+		.formats	= STUB_FORMATS,
+		.sig_bits	= 24,
+	},
+	.capture = {
+		.stream_name    = "Analog Codec Capture",
+		.channels_min   = 1,
+		.channels_max   = 16,
+		.rates = SNDRV_PCM_RATE_8000_192000,
+		.formats = STUB_FORMATS,
+		.sig_bits = 24,
+	},
+},
+{
+	.name = "Digital Codec DAI",
+	.ops = &hdac_hda_dai_ops,
+	.playback = {
+		.stream_name    = "Digital Codec Playback",
+		.channels_min   = 1,
+		.channels_max   = 16,
+		.rates          = SNDRV_PCM_RATE_8000_192000,
+		.formats        = STUB_FORMATS,
+		.sig_bits = 24,
+	},
+	.capture = {
+		.stream_name    = "Digital Codec Capture",
+		.channels_min   = 1,
+		.channels_max   = 16,
+		.rates = SNDRV_PCM_RATE_8000_192000,
+		.formats = STUB_FORMATS,
+		.sig_bits = 24,
+	},
+}
+};
+
+static int hdac_hda_dai_set_tdm_slot(struct snd_soc_dai *dai,
+		unsigned int tx_mask, unsigned int rx_mask,
+		int slots, int slot_width)
+{
+	struct hdac_hda_priv *hda_pvt = snd_soc_dai_get_drvdata(dai);
+	struct hdac_device *hdev = &hda_pvt->codec.core;
+
+	hda_pvt->stream_tag = tx_mask;
+	dev_dbg(&hdev->dev, "%s: strm_tag: %d\n", __func__,
+						hda_pvt->stream_tag);
+	return 0;
+}
+
+static int hdac_hda_dai_hw_params(struct snd_pcm_substream *substream,
+	struct snd_pcm_hw_params *hparams, struct snd_soc_dai *dai)
+{
+	struct hdac_hda_priv *hda_pvt = snd_soc_dai_get_drvdata(dai);
+	struct hdac_device *hdev = &hda_pvt->codec.core;
+
+	dev_dbg(&hdev->dev, "%s: entry\n", __func__);
+
+	/*
+	 * TODO:
+	 * verify if the parameters are supported by the codec
+	 */
+	return 0;
+}
+
+static int hdac_hda_dai_hw_free(struct snd_pcm_substream *substream,
+				struct snd_soc_dai *dai)
+{
+	struct hdac_hda_priv *hda_pvt = snd_soc_dai_get_drvdata(dai);
+	struct hdac_device *hdev = &hda_pvt->codec.core;
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct hda_pcm_stream *hda_stream;
+	struct hda_pcm *pcm;
+
+	dev_dbg(&hdev->dev, "%s: entry\n", __func__);
+
+	pcm = snd_soc_find_pcm_from_dai(hda_pvt, dai);
+	if (pcm == NULL)
+		return -EINVAL;
+
+	dev_dbg(&hdev->dev, "pcm = %s: rate=%d ch=%d fmt=%d\n", pcm->name,
+		runtime->rate, runtime->channels, runtime->format);
+
+	hda_stream = &pcm->stream[substream->stream];
+
+	snd_hda_codec_cleanup(&hda_pvt->codec, hda_stream, substream);
+
+	return 0;
+}
+
+static int hdac_hda_dai_prepare(struct snd_pcm_substream *substream,
+				struct snd_soc_dai *dai)
+{
+	int ret = 0;
+	struct hdac_hda_priv *hda_pvt = snd_soc_dai_get_drvdata(dai);
+	struct hdac_device *hdev = &hda_pvt->codec.core;
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct hda_pcm_stream *hda_stream;
+	unsigned int format_val;
+	struct hda_pcm *pcm;
+
+	dev_dbg(&hdev->dev, "%s: entry\n", __func__);
+
+	pcm = snd_soc_find_pcm_from_dai(hda_pvt, dai);
+	if (pcm == NULL)
+		return -EINVAL;
+
+	dev_dbg(&hdev->dev, "pcm = %s: rate=%d ch=%d fmt=%d\n", pcm->name,
+		runtime->rate, runtime->channels, runtime->format);
+
+	hda_stream = &pcm->stream[substream->stream];
+
+	dev_dbg(&hdev->dev, "fmt=0x%llx rate=0x%x maxbps=%d\n",
+		hda_stream->formats, hda_stream->rates, hda_stream->maxbps);
+
+	format_val = snd_hdac_calc_stream_format(runtime->rate,
+						runtime->channels,
+						runtime->format,
+						hda_stream->maxbps,
+						0);
+	if (!format_val) {
+		dev_err(&hdev->dev,
+			"invalid format_val, rate=%d, ch=%d, format=%d\n",
+			runtime->rate, runtime->channels, runtime->format);
+		return -EINVAL;
+	}
+
+	ret = snd_hda_codec_prepare(&hda_pvt->codec, hda_stream,
+			hda_pvt->stream_tag, format_val, substream);
+	if (ret < 0) {
+		dev_err(&hdev->dev, "codec prepare failed %d\n", ret);
+		return ret;
+	}
+
+	dev_dbg(&hdev->dev, "%s: exit\n", __func__);
+	return ret;
+}
+
+static int hdac_hda_dai_open(struct snd_pcm_substream *substream,
+			struct snd_soc_dai *dai)
+{
+	struct hdac_hda_priv *hda_pvt = snd_soc_dai_get_drvdata(dai);
+	struct hdac_device *hdev = &hda_pvt->codec.core;
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct hda_pcm *pcm;
+	struct hda_pcm_stream *hda_stream;
+	int ret = 0;
+
+	dev_dbg(&hdev->dev, "%s: entry\n", __func__);
+
+	pcm = snd_soc_find_pcm_from_dai(hda_pvt, dai);
+	if (pcm == NULL)
+		return -EINVAL;
+
+	dev_dbg(&hdev->dev, "pcm = %s: rate=%d ch=%d fmt=%d\n", pcm->name,
+		runtime->rate, runtime->channels, runtime->format);
+
+	hda_stream = &pcm->stream[substream->stream];
+
+	snd_hda_codec_pcm_get(pcm);
+
+	if (hda_stream->ops.open)
+		ret = hda_stream->ops.open(hda_stream, &hda_pvt->codec,
+								substream);
+	else
+		ret = -ENODEV;
+
+	dev_dbg(&hdev->dev, "%s: exit=%d\n", __func__, ret);
+
+	return 0;
+}
+
+static void hdac_hda_dai_close(struct snd_pcm_substream *substream,
+		struct snd_soc_dai *dai)
+{
+	struct hdac_hda_priv *hda_pvt = snd_soc_dai_get_drvdata(dai);
+	struct hdac_device *hdev = &hda_pvt->codec.core;
+	struct hda_pcm *pcm;
+	struct hda_pcm_stream *hda_stream;
+
+	dev_dbg(&hdev->dev, "%s: entry\n", __func__);
+
+	pcm = snd_soc_find_pcm_from_dai(hda_pvt, dai);
+	if (pcm == NULL)
+		return;
+
+	hda_stream = &pcm->stream[substream->stream];
+
+	if (hda_stream->ops.open)
+		hda_stream->ops.close(hda_stream, &hda_pvt->codec, substream);
+
+	snd_hda_codec_pcm_put(pcm);
+}
+
+static struct hda_pcm *snd_soc_find_pcm_from_dai(struct hdac_hda_priv *hda_pvt,
+						struct snd_soc_dai *dai)
+{
+
+	struct hda_pcm *cpcm;
+	struct hda_codec *hcodec = &hda_pvt->codec;
+	const char *pcm_name;
+
+	if (strpbrk(dai->name, "Analog"))
+		pcm_name = "Analog";
+	else
+		pcm_name = "Digital";
+
+	dev_dbg(&hcodec->core.dev, "DAI %s\n", pcm_name);
+
+	list_for_each_entry(cpcm, &hcodec->pcm_list_head, list) {
+		dev_dbg(&hcodec->core.dev, "PCM %s\n", cpcm->name);
+		if (strpbrk(cpcm->name, pcm_name))
+			return cpcm;
+	}
+
+	dev_err(&hcodec->core.dev, "didn't find PCM for DAI %s\n", dai->name);
+	return NULL;
+}
+
+static int hdac_hda_codec_probe(struct snd_soc_codec *codec)
+{
+	struct hdac_hda_priv *hda_pvt = snd_soc_codec_get_drvdata(codec);
+	struct hdac_device *hdev = &hda_pvt->codec.core;
+	struct hdac_ext_link *hlink = NULL;
+	struct hda_codec *hcodec = &hda_pvt->codec;
+	struct snd_soc_dapm_context *dapm =
+			snd_soc_component_get_dapm(&codec->component);
+	int ret, i = 0;
+	u16 codec_mask;
+	hda_codec_patch_t patch;
+
+	dev_dbg(&hdev->dev, "%s: Entry in_pm=%d pm_usage=%d\n", __func__,
+			hdev->in_pm.counter,
+			hdev->dev.power.usage_count.counter);
+
+	hda_pvt->scodec = codec;
+	hlink = snd_hdac_ext_bus_get_link(hdev->bus,
+					dev_name(&hdev->dev));
+	if (!hlink) {
+		dev_err(&hdev->dev, "hdac link not found\n");
+		return -EIO;
+	}
+
+	ret = snd_hdac_ext_bus_link_get(hdev->bus, hlink);
+
+	udelay(1000);
+	do {
+		codec_mask = snd_hdac_chip_readw(hdev->bus, STATESTS);
+		if (codec_mask)
+			break;
+			i++;
+		udelay(100);
+	} while (i < 100);
+
+	if (!codec_mask) {
+		dev_err(&hdev->dev, "No codecs found after link reset\n");
+		return -EIO;
+	}
+
+	snd_hdac_chip_writew(hdev->bus, STATESTS, STATESTS_INT_MASK);
+
+	dev_dbg(&hdev->dev, "before card created in_pm=%d pm_usage=%d\n",
+			hdev->in_pm.counter,
+			hdev->dev.power.usage_count.counter);
+
+	ret = snd_hda_codec_device_new(hcodec->bus,
+			codec->component.card->snd_card, hdev->addr, hcodec);
+	if (ret < 0) {
+		dev_err(codec->dev, "%s: failed to create hda codec %d\n",
+					__func__, ret);
+		return ret;
+	}
+
+	/*
+	 * snd_hda_codec_new1 decrements the usage count and so get the pm
+	 * count else the device will be powered off
+	 */
+	pm_runtime_get_noresume(&hdev->dev);
+
+	hcodec->bus->card = dapm->card->snd_card;
+
+	dev_dbg(&hdev->dev, "after card created in_pm=%d pm_usage=%d\n",
+			hdev->in_pm.counter,
+			hdev->dev.power.usage_count.counter);
+
+	patch = (hda_codec_patch_t)hcodec->preset->driver_data;
+	if (patch) {
+		ret = patch(hcodec);
+		if (ret < 0) {
+			dev_err(codec->dev, "no match found for the codec\n");
+			return ret;
+		}
+	} else {
+		dev_dbg(&hdev->dev, "no patch file found\n");
+	}
+
+	ret = snd_hda_codec_set_name(hcodec, hcodec->preset->name);
+	if (ret < 0) {
+		dev_err(codec->dev, "unable to set name %s\n",
+				hcodec->preset->name);
+		return ret;
+	}
+
+	ret = snd_hdac_regmap_init(&hcodec->core);
+	if (ret < 0) {
+		dev_err(codec->dev, "regmap init failed\n");
+		return ret;
+	}
+
+	ret = snd_hda_codec_parse_pcms(hcodec);
+	if (ret < 0) {
+		dev_err(&hdev->dev, "unable to map pcms to dai %d\n", ret);
+		return ret;
+	}
+
+	ret = snd_hda_codec_build_controls(hcodec);
+	if (ret < 0) {
+		dev_err(&hdev->dev, "unable to create controls %d\n", ret);
+		return ret;
+	}
+
+	hcodec->core.lazy_cache = true;
+
+	/*
+	 * hdac_device core already sets the state to active and calls
+	 * get_noresume. So enable runtime and set the device to suspend.
+	 * pm_runtime_enable is also called during codec registeration
+	 */
+	pm_runtime_put(&hdev->dev);
+	pm_runtime_suspend(&hdev->dev);
+
+	dev_dbg(&hdev->dev, "%s: exit\n", __func__);
+
+	return 0;
+}
+
+static int hdac_hda_codec_remove(struct snd_soc_codec *codec)
+{
+	struct hdac_hda_priv *hda_pvt = snd_soc_codec_get_drvdata(codec);
+	struct hdac_device *hdev = &hda_pvt->codec.core;
+	struct hdac_ext_link *hlink = NULL;
+
+	dev_dbg(&hdev->dev, "%s: entry\n", __func__);
+
+	hlink = snd_hdac_ext_bus_get_link(hdev->bus, dev_name(&hdev->dev));
+	if (!hlink) {
+		dev_err(&hdev->dev, "hdac link not found\n");
+		return -EIO;
+	}
+
+	snd_hdac_ext_bus_link_put(hdev->bus, hlink);
+
+	pm_runtime_disable(&hdev->dev);
+
+	return 0;
+}
+
+
+static const struct snd_soc_dapm_route hdac_hda_dapm_routes[] = {
+	{"AIF1TX", NULL, "Codec Input Pin1"},
+	{"AIF2TX", NULL, "Codec Input Pin2"},
+
+	{"Codec Output Pin1", NULL, "AIF1RX"},
+	{"Codec Output Pin2", NULL, "AIF2RX"},
+};
+
+static const struct snd_soc_dapm_widget hdac_hda_dapm_widgets[] = {
+
+	/* Audio Interface */
+	SND_SOC_DAPM_AIF_IN("AIF1RX", "Analog Codec Playback", 0,
+							SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_IN("AIF2RX", "Digital Codec Playback", 0,
+							SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_OUT("AIF1TX", "Analog Codec Capture", 0,
+							SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_OUT("AIF2TX", "Digital Codec Capture", 0,
+							SND_SOC_NOPM, 0, 0),
+
+	/* Input Pins */
+	SND_SOC_DAPM_INPUT("Codec Input Pin1"),
+	SND_SOC_DAPM_INPUT("Codec Input Pin2"),
+
+	/* Output Pins */
+	SND_SOC_DAPM_OUTPUT("Codec Output Pin1"),
+	SND_SOC_DAPM_OUTPUT("Codec Output Pin2"),
+};
+
+
+static struct snd_soc_codec_driver hdac_hda_codec = {
+	.probe		= hdac_hda_codec_probe,
+	.remove		= hdac_hda_codec_remove,
+	.idle_bias_off = true,
+	.component_driver = {
+		.dapm_widgets           = hdac_hda_dapm_widgets,
+		.num_dapm_widgets       = ARRAY_SIZE(hdac_hda_dapm_widgets),
+		.dapm_routes            = hdac_hda_dapm_routes,
+		.num_dapm_routes        = ARRAY_SIZE(hdac_hda_dapm_routes),
+	},
+};
+
+static int hdac_hda_dev_probe(struct hdac_device *hdev)
+{
+	struct hdac_ext_link *hlink = NULL;
+	struct hdac_hda_priv *hda_pvt;
+	int ret;
+
+	dev_dbg(&hdev->dev, "%s: entry\n", __func__);
+
+	/* hold the ref while we probe */
+	hlink = snd_hdac_ext_bus_get_link(hdev->bus, dev_name(&hdev->dev));
+	if (!hlink) {
+		dev_err(&hdev->dev, "hdac link not found\n");
+		return -EIO;
+	}
+	snd_hdac_ext_bus_link_get(hdev->bus, hlink);
+
+	hda_pvt = hdac_to_hda_priv(hdev);
+	if (hda_pvt == NULL)
+		return -ENOMEM;
+
+	/* ASoC specific initialization */
+	ret = snd_soc_register_codec(&hdev->dev, &hdac_hda_codec, hdac_hda_dais,
+					 ARRAY_SIZE(hdac_hda_dais));
+	if (ret < 0) {
+		dev_err(&hdev->dev, "failed to register HDA codec %d\n", ret);
+		return ret;
+	}
+
+	dev_set_drvdata(&hdev->dev, hda_pvt);
+	snd_hdac_ext_bus_link_put(hdev->bus, hlink);
+
+	return ret;
+}
+
+static int hdac_hda_dev_remove(struct hdac_device *hdev)
+{
+	dev_dbg(&hdev->dev, "%s: entry\n", __func__);
+	snd_soc_unregister_codec(&hdev->dev);
+	return 0;
+}
+
+static struct hdac_ext_bus_ops hdac_ops = {
+	.probe          = hdac_hda_dev_probe,
+	.remove         = hdac_hda_dev_remove,
+};
+
+struct hdac_ext_bus_ops *snd_soc_hdac_hda_get_ops(void)
+{
+	return &hdac_ops;
+}
+EXPORT_SYMBOL_GPL(snd_soc_hdac_hda_get_ops);
+
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("ASoC Extensions for legacy HDA Drivers");
+MODULE_AUTHOR("Rakesh Ughreja<rakesh.a.ughreja@intel.com>");
diff --git a/sound/soc/codecs/hdac_hda.h b/sound/soc/codecs/hdac_hda.h
new file mode 100644
index 0000000..8476c52
--- /dev/null
+++ b/sound/soc/codecs/hdac_hda.h
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright(c) 2015-17 Intel Corporation.
+
+#ifndef __HDAC_HDA_H__
+#define __HDAC_HDA_H__
+
+struct hdac_hda_priv {
+	struct hda_codec codec;
+	int stream_tag;
+
+	struct snd_soc_codec *scodec;
+};
+
+#define hdac_to_hda_priv(_hdac) \
+			container_of(_hdac, struct hdac_hda_priv, codec.core)
+#define hdac_to_hda_codec(_hdac) container_of(_hdac, struct hda_codec, core)
+
+struct hdac_ext_bus_ops *snd_soc_hdac_hda_get_ops(void);
+
+#endif /* __HDAC_HDA_H__ */
-- 
2.7.4
