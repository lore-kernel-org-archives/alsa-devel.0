From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: hdac_hda: add asoc extension for legacy
	HDA codec drivers" to the asoc tree
Date: Tue, 28 Aug 2018 21:30:21 +0100 (BST)
Message-ID: <20180828203021.68F84440078@finisterre.ee.mobilebroadband>
References: <20180822202503.16609-8-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 4DA3026779D
 for <alsa-devel@alsa-project.org>; Tue, 28 Aug 2018 22:30:27 +0200 (CEST)
In-Reply-To: <20180822202503.16609-8-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Rakesh Ughreja <rakesh.a.ughreja@intel.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: hdac_hda: add asoc extension for legacy HDA codec drivers

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 6bae5ea9498926440ffc883f3dbceb0adc65e492 Mon Sep 17 00:00:00 2001
From: Rakesh Ughreja <rakesh.a.ughreja@intel.com>
Date: Wed, 22 Aug 2018 15:25:03 -0500
Subject: [PATCH] ASoC: hdac_hda: add asoc extension for legacy HDA codec
 drivers

This patch adds a kernel module which is used by the legacy HDA
codec drivers as library. This implements hdac_ext_bus_ops to enable
the reuse of legacy HDA codec drivers with ASoC platform drivers.

Signed-off-by: Rakesh Ughreja <rakesh.a.ughreja@intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/pci/hda/hda_bind.c                     |  12 +
 sound/soc/codecs/Kconfig                     |   5 +
 sound/soc/codecs/Makefile                    |   2 +
 sound/soc/codecs/hdac_hda.c                  | 484 +++++++++++++++++++
 sound/soc/codecs/hdac_hda.h                  |  24 +
 sound/soc/intel/boards/Kconfig               |   1 +
 sound/soc/intel/boards/skl_hda_dsp_common.c  |  24 +
 sound/soc/intel/boards/skl_hda_dsp_common.h  |   2 +-
 sound/soc/intel/boards/skl_hda_dsp_generic.c |  38 ++
 sound/soc/intel/skylake/skl.c                |  47 +-
 10 files changed, 634 insertions(+), 5 deletions(-)
 create mode 100644 sound/soc/codecs/hdac_hda.c
 create mode 100644 sound/soc/codecs/hdac_hda.h

diff --git a/sound/pci/hda/hda_bind.c b/sound/pci/hda/hda_bind.c
index 2222b47d4ec4..9174f1b3a987 100644
--- a/sound/pci/hda/hda_bind.c
+++ b/sound/pci/hda/hda_bind.c
@@ -81,6 +81,12 @@ static int hda_codec_driver_probe(struct device *dev)
 	hda_codec_patch_t patch;
 	int err;
 
+	if (codec->bus->core.ext_ops) {
+		if (WARN_ON(!codec->bus->core.ext_ops->hdev_attach))
+			return -EINVAL;
+		return codec->bus->core.ext_ops->hdev_attach(&codec->core);
+	}
+
 	if (WARN_ON(!codec->preset))
 		return -EINVAL;
 
@@ -134,6 +140,12 @@ static int hda_codec_driver_remove(struct device *dev)
 {
 	struct hda_codec *codec = dev_to_hda_codec(dev);
 
+	if (codec->bus->core.ext_ops) {
+		if (WARN_ON(!codec->bus->core.ext_ops->hdev_detach))
+			return -EINVAL;
+		return codec->bus->core.ext_ops->hdev_detach(&codec->core);
+	}
+
 	if (codec->patch_ops.free)
 		codec->patch_ops.free(codec);
 	snd_hda_codec_cleanup_for_unbind(codec);
diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index efb095dbcd71..bf0b949eb7e8 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -82,6 +82,7 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_ES7241
 	select SND_SOC_GTM601
 	select SND_SOC_HDAC_HDMI
+	select SND_SOC_HDAC_HDA
 	select SND_SOC_ICS43432
 	select SND_SOC_INNO_RK3036
 	select SND_SOC_ISABELLE if I2C
@@ -615,6 +616,10 @@ config SND_SOC_HDAC_HDMI
 	select SND_PCM_ELD
 	select HDMI
 
+config SND_SOC_HDAC_HDA
+	tristate
+	select SND_HDA
+
 config SND_SOC_ICS43432
 	tristate
 
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index 7ae7c85e8219..3046b33ca9d3 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -78,6 +78,7 @@ snd-soc-es8328-i2c-objs := es8328-i2c.o
 snd-soc-es8328-spi-objs := es8328-spi.o
 snd-soc-gtm601-objs := gtm601.o
 snd-soc-hdac-hdmi-objs := hdac_hdmi.o
+snd-soc-hdac-hda-objs := hdac_hda.o
 snd-soc-ics43432-objs := ics43432.o
 snd-soc-inno-rk3036-objs := inno_rk3036.o
 snd-soc-isabelle-objs := isabelle.o
@@ -338,6 +339,7 @@ obj-$(CONFIG_SND_SOC_ES8328_I2C)+= snd-soc-es8328-i2c.o
 obj-$(CONFIG_SND_SOC_ES8328_SPI)+= snd-soc-es8328-spi.o
 obj-$(CONFIG_SND_SOC_GTM601)    += snd-soc-gtm601.o
 obj-$(CONFIG_SND_SOC_HDAC_HDMI) += snd-soc-hdac-hdmi.o
+obj-$(CONFIG_SND_SOC_HDAC_HDA) += snd-soc-hdac-hda.o
 obj-$(CONFIG_SND_SOC_ICS43432)	+= snd-soc-ics43432.o
 obj-$(CONFIG_SND_SOC_INNO_RK3036)	+= snd-soc-inno-rk3036.o
 obj-$(CONFIG_SND_SOC_ISABELLE)	+= snd-soc-isabelle.o
diff --git a/sound/soc/codecs/hdac_hda.c b/sound/soc/codecs/hdac_hda.c
new file mode 100644
index 000000000000..8c25a1332fa7
--- /dev/null
+++ b/sound/soc/codecs/hdac_hda.c
@@ -0,0 +1,484 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright(c) 2015-18 Intel Corporation.
+
+/*
+ * hdac_hda.c - ASoC extensions to reuse the legacy HDA codec drivers
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
+#include <sound/hda_codec.h>
+#include <sound/hda_register.h>
+#include "hdac_hda.h"
+
+#define HDAC_ANALOG_DAI_ID		0
+#define HDAC_DIGITAL_DAI_ID		1
+#define HDAC_ALT_ANALOG_DAI_ID		2
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
+			     struct snd_soc_dai *dai);
+static void hdac_hda_dai_close(struct snd_pcm_substream *substream,
+			       struct snd_soc_dai *dai);
+static int hdac_hda_dai_prepare(struct snd_pcm_substream *substream,
+				struct snd_soc_dai *dai);
+static int hdac_hda_dai_hw_free(struct snd_pcm_substream *substream,
+				struct snd_soc_dai *dai);
+static int hdac_hda_dai_set_tdm_slot(struct snd_soc_dai *dai,
+				     unsigned int tx_mask, unsigned int rx_mask,
+				     int slots, int slot_width);
+static struct hda_pcm *snd_soc_find_pcm_from_dai(struct hdac_hda_priv *hda_pvt,
+						 struct snd_soc_dai *dai);
+
+static struct snd_soc_dai_ops hdac_hda_dai_ops = {
+	.startup = hdac_hda_dai_open,
+	.shutdown = hdac_hda_dai_close,
+	.prepare = hdac_hda_dai_prepare,
+	.hw_free = hdac_hda_dai_hw_free,
+	.set_tdm_slot = hdac_hda_dai_set_tdm_slot,
+};
+
+static struct snd_soc_dai_driver hdac_hda_dais[] = {
+{
+	.id = HDAC_ANALOG_DAI_ID,
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
+	.id = HDAC_DIGITAL_DAI_ID,
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
+},
+{
+	.id = HDAC_ALT_ANALOG_DAI_ID,
+	.name = "Alt Analog Codec DAI",
+	.ops = &hdac_hda_dai_ops,
+	.playback = {
+		.stream_name	= "Alt Analog Codec Playback",
+		.channels_min	= 1,
+		.channels_max	= 16,
+		.rates		= SNDRV_PCM_RATE_8000_192000,
+		.formats	= STUB_FORMATS,
+		.sig_bits	= 24,
+	},
+	.capture = {
+		.stream_name    = "Alt Analog Codec Capture",
+		.channels_min   = 1,
+		.channels_max   = 16,
+		.rates = SNDRV_PCM_RATE_8000_192000,
+		.formats = STUB_FORMATS,
+		.sig_bits = 24,
+	},
+}
+
+};
+
+static int hdac_hda_dai_set_tdm_slot(struct snd_soc_dai *dai,
+				     unsigned int tx_mask, unsigned int rx_mask,
+				     int slots, int slot_width)
+{
+	struct snd_soc_component *component = dai->component;
+	struct hdac_hda_priv *hda_pvt;
+	struct hdac_hda_pcm *pcm;
+
+	hda_pvt = snd_soc_component_get_drvdata(component);
+	pcm = &hda_pvt->pcm[dai->id];
+	if (tx_mask)
+		pcm[dai->id].stream_tag[SNDRV_PCM_STREAM_PLAYBACK] = tx_mask;
+	else
+		pcm[dai->id].stream_tag[SNDRV_PCM_STREAM_CAPTURE] = rx_mask;
+
+	return 0;
+}
+
+static int hdac_hda_dai_hw_free(struct snd_pcm_substream *substream,
+				struct snd_soc_dai *dai)
+{
+	struct snd_soc_component *component = dai->component;
+	struct hdac_hda_priv *hda_pvt;
+	struct hda_pcm_stream *hda_stream;
+	struct hda_pcm *pcm;
+
+	hda_pvt = snd_soc_component_get_drvdata(component);
+	pcm = snd_soc_find_pcm_from_dai(hda_pvt, dai);
+	if (!pcm)
+		return -EINVAL;
+
+	hda_stream = &pcm->stream[substream->stream];
+	snd_hda_codec_cleanup(&hda_pvt->codec, hda_stream, substream);
+
+	return 0;
+}
+
+static int hdac_hda_dai_prepare(struct snd_pcm_substream *substream,
+				struct snd_soc_dai *dai)
+{
+	struct snd_soc_component *component = dai->component;
+	struct hdac_hda_priv *hda_pvt;
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct hdac_device *hdev;
+	struct hda_pcm_stream *hda_stream;
+	unsigned int format_val;
+	struct hda_pcm *pcm;
+	unsigned int stream;
+	int ret = 0;
+
+	hda_pvt = snd_soc_component_get_drvdata(component);
+	hdev = &hda_pvt->codec.core;
+	pcm = snd_soc_find_pcm_from_dai(hda_pvt, dai);
+	if (!pcm)
+		return -EINVAL;
+
+	hda_stream = &pcm->stream[substream->stream];
+
+	format_val = snd_hdac_calc_stream_format(runtime->rate,
+						 runtime->channels,
+						 runtime->format,
+						 hda_stream->maxbps,
+						 0);
+	if (!format_val) {
+		dev_err(&hdev->dev,
+			"invalid format_val, rate=%d, ch=%d, format=%d\n",
+			runtime->rate, runtime->channels, runtime->format);
+		return -EINVAL;
+	}
+
+	stream = hda_pvt->pcm[dai->id].stream_tag[substream->stream];
+
+	ret = snd_hda_codec_prepare(&hda_pvt->codec, hda_stream,
+				    stream, format_val, substream);
+	if (ret < 0)
+		dev_err(&hdev->dev, "codec prepare failed %d\n", ret);
+
+	return ret;
+}
+
+static int hdac_hda_dai_open(struct snd_pcm_substream *substream,
+			     struct snd_soc_dai *dai)
+{
+	struct snd_soc_component *component = dai->component;
+	struct hdac_hda_priv *hda_pvt;
+	struct hda_pcm_stream *hda_stream;
+	struct hda_pcm *pcm;
+	int ret;
+
+	hda_pvt = snd_soc_component_get_drvdata(component);
+	pcm = snd_soc_find_pcm_from_dai(hda_pvt, dai);
+	if (!pcm)
+		return -EINVAL;
+
+	snd_hda_codec_pcm_get(pcm);
+
+	hda_stream = &pcm->stream[substream->stream];
+
+	ret = hda_stream->ops.open(hda_stream, &hda_pvt->codec, substream);
+	if (ret < 0)
+		snd_hda_codec_pcm_put(pcm);
+
+	return ret;
+}
+
+static void hdac_hda_dai_close(struct snd_pcm_substream *substream,
+			       struct snd_soc_dai *dai)
+{
+	struct snd_soc_component *component = dai->component;
+	struct hdac_hda_priv *hda_pvt;
+	struct hda_pcm_stream *hda_stream;
+	struct hda_pcm *pcm;
+
+	hda_pvt = snd_soc_component_get_drvdata(component);
+	pcm = snd_soc_find_pcm_from_dai(hda_pvt, dai);
+	if (!pcm)
+		return;
+
+	hda_stream = &pcm->stream[substream->stream];
+
+	hda_stream->ops.close(hda_stream, &hda_pvt->codec, substream);
+
+	snd_hda_codec_pcm_put(pcm);
+}
+
+static struct hda_pcm *snd_soc_find_pcm_from_dai(struct hdac_hda_priv *hda_pvt,
+						 struct snd_soc_dai *dai)
+{
+	struct hda_codec *hcodec = &hda_pvt->codec;
+	struct hda_pcm *cpcm;
+	const char *pcm_name;
+
+	switch (dai->id) {
+	case HDAC_ANALOG_DAI_ID:
+		pcm_name = "Analog";
+		break;
+	case HDAC_DIGITAL_DAI_ID:
+		pcm_name = "Digital";
+		break;
+	case HDAC_ALT_ANALOG_DAI_ID:
+		pcm_name = "Alt Analog";
+		break;
+	default:
+		dev_err(&hcodec->core.dev, "invalid dai id %d\n", dai->id);
+		return NULL;
+	}
+
+	list_for_each_entry(cpcm, &hcodec->pcm_list_head, list) {
+		if (strpbrk(cpcm->name, pcm_name))
+			return cpcm;
+	}
+
+	dev_err(&hcodec->core.dev, "didn't find PCM for DAI %s\n", dai->name);
+	return NULL;
+}
+
+static int hdac_hda_codec_probe(struct snd_soc_component *component)
+{
+	struct hdac_hda_priv *hda_pvt =
+			snd_soc_component_get_drvdata(component);
+	struct snd_soc_dapm_context *dapm =
+			snd_soc_component_get_dapm(component);
+	struct hdac_device *hdev = &hda_pvt->codec.core;
+	struct hda_codec *hcodec = &hda_pvt->codec;
+	struct hdac_ext_link *hlink;
+	hda_codec_patch_t patch;
+	int ret;
+
+	hlink = snd_hdac_ext_bus_get_link(hdev->bus, dev_name(&hdev->dev));
+	if (!hlink) {
+		dev_err(&hdev->dev, "hdac link not found\n");
+		return -EIO;
+	}
+
+	snd_hdac_ext_bus_link_get(hdev->bus, hlink);
+
+	ret = snd_hda_codec_device_new(hcodec->bus, component->card->snd_card,
+				       hdev->addr, hcodec);
+	if (ret < 0) {
+		dev_err(&hdev->dev, "failed to create hda codec %d\n", ret);
+		goto error_no_pm;
+	}
+
+	/*
+	 * snd_hda_codec_device_new decrements the usage count so call get pm
+	 * else the device will be powered off
+	 */
+	pm_runtime_get_noresume(&hdev->dev);
+
+	hcodec->bus->card = dapm->card->snd_card;
+
+	ret = snd_hda_codec_set_name(hcodec, hcodec->preset->name);
+	if (ret < 0) {
+		dev_err(&hdev->dev, "name failed %s\n", hcodec->preset->name);
+		goto error;
+	}
+
+	ret = snd_hdac_regmap_init(&hcodec->core);
+	if (ret < 0) {
+		dev_err(&hdev->dev, "regmap init failed\n");
+		goto error;
+	}
+
+	patch = (hda_codec_patch_t)hcodec->preset->driver_data;
+	if (patch) {
+		ret = patch(hcodec);
+		if (ret < 0) {
+			dev_err(&hdev->dev, "patch failed %d\n", ret);
+			goto error;
+		}
+	} else {
+		dev_dbg(&hdev->dev, "no patch file found\n");
+	}
+
+	ret = snd_hda_codec_parse_pcms(hcodec);
+	if (ret < 0) {
+		dev_err(&hdev->dev, "unable to map pcms to dai %d\n", ret);
+		goto error;
+	}
+
+	ret = snd_hda_codec_build_controls(hcodec);
+	if (ret < 0) {
+		dev_err(&hdev->dev, "unable to create controls %d\n", ret);
+		goto error;
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
+	return 0;
+
+error:
+	pm_runtime_put(&hdev->dev);
+error_no_pm:
+	snd_hdac_ext_bus_link_put(hdev->bus, hlink);
+	return ret;
+}
+
+static void hdac_hda_codec_remove(struct snd_soc_component *component)
+{
+	struct hdac_hda_priv *hda_pvt =
+		      snd_soc_component_get_drvdata(component);
+	struct hdac_device *hdev = &hda_pvt->codec.core;
+	struct hdac_ext_link *hlink = NULL;
+
+	hlink = snd_hdac_ext_bus_get_link(hdev->bus, dev_name(&hdev->dev));
+	if (!hlink) {
+		dev_err(&hdev->dev, "hdac link not found\n");
+		return;
+	}
+
+	snd_hdac_ext_bus_link_put(hdev->bus, hlink);
+	pm_runtime_disable(&hdev->dev);
+}
+
+static const struct snd_soc_dapm_route hdac_hda_dapm_routes[] = {
+	{"AIF1TX", NULL, "Codec Input Pin1"},
+	{"AIF2TX", NULL, "Codec Input Pin2"},
+	{"AIF3TX", NULL, "Codec Input Pin3"},
+
+	{"Codec Output Pin1", NULL, "AIF1RX"},
+	{"Codec Output Pin2", NULL, "AIF2RX"},
+	{"Codec Output Pin3", NULL, "AIF3RX"},
+};
+
+static const struct snd_soc_dapm_widget hdac_hda_dapm_widgets[] = {
+	/* Audio Interface */
+	SND_SOC_DAPM_AIF_IN("AIF1RX", "Analog Codec Playback", 0,
+			    SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_IN("AIF2RX", "Digital Codec Playback", 0,
+			    SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_IN("AIF3RX", "Alt Analog Codec Playback", 0,
+			    SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_OUT("AIF1TX", "Analog Codec Capture", 0,
+			     SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_OUT("AIF2TX", "Digital Codec Capture", 0,
+			     SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_OUT("AIF3TX", "Alt Analog Codec Capture", 0,
+			     SND_SOC_NOPM, 0, 0),
+
+	/* Input Pins */
+	SND_SOC_DAPM_INPUT("Codec Input Pin1"),
+	SND_SOC_DAPM_INPUT("Codec Input Pin2"),
+	SND_SOC_DAPM_INPUT("Codec Input Pin3"),
+
+	/* Output Pins */
+	SND_SOC_DAPM_OUTPUT("Codec Output Pin1"),
+	SND_SOC_DAPM_OUTPUT("Codec Output Pin2"),
+	SND_SOC_DAPM_OUTPUT("Codec Output Pin3"),
+};
+
+static const struct snd_soc_component_driver hdac_hda_codec = {
+	.probe		= hdac_hda_codec_probe,
+	.remove		= hdac_hda_codec_remove,
+	.idle_bias_on	= false,
+	.dapm_widgets           = hdac_hda_dapm_widgets,
+	.num_dapm_widgets       = ARRAY_SIZE(hdac_hda_dapm_widgets),
+	.dapm_routes            = hdac_hda_dapm_routes,
+	.num_dapm_routes        = ARRAY_SIZE(hdac_hda_dapm_routes),
+};
+
+static int hdac_hda_dev_probe(struct hdac_device *hdev)
+{
+	struct hdac_ext_link *hlink;
+	struct hdac_hda_priv *hda_pvt;
+	int ret;
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
+	if (!hda_pvt)
+		return -ENOMEM;
+
+	/* ASoC specific initialization */
+	ret = snd_soc_register_component(&hdev->dev,
+					 &hdac_hda_codec, hdac_hda_dais,
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
+	snd_soc_unregister_component(&hdev->dev);
+	return 0;
+}
+
+static struct hdac_ext_bus_ops hdac_ops = {
+	.hdev_attach = hdac_hda_dev_probe,
+	.hdev_detach = hdac_hda_dev_remove,
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
index 000000000000..e444ef593360
--- /dev/null
+++ b/sound/soc/codecs/hdac_hda.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright(c) 2015-18 Intel Corporation.
+ */
+
+#ifndef __HDAC_HDA_H__
+#define __HDAC_HDA_H__
+
+struct hdac_hda_pcm {
+	int stream_tag[2];
+};
+
+struct hdac_hda_priv {
+	struct hda_codec codec;
+	struct hdac_hda_pcm pcm[2];
+};
+
+#define hdac_to_hda_priv(_hdac) \
+			container_of(_hdac, struct hdac_hda_priv, codec.core)
+#define hdac_to_hda_codec(_hdac) container_of(_hdac, struct hda_codec, core)
+
+struct hdac_ext_bus_ops *snd_soc_hdac_hda_get_ops(void);
+
+#endif /* __HDAC_HDA_H__ */
diff --git a/sound/soc/intel/boards/Kconfig b/sound/soc/intel/boards/Kconfig
index 0f0d57859555..88e4b4284738 100644
--- a/sound/soc/intel/boards/Kconfig
+++ b/sound/soc/intel/boards/Kconfig
@@ -283,6 +283,7 @@ config SND_SOC_INTEL_KBL_DA7219_MAX98357A_MACH
 config SND_SOC_INTEL_SKL_HDA_DSP_GENERIC_MACH
 	tristate "SKL/KBL/BXT/APL with HDA Codecs"
 	select SND_SOC_HDAC_HDMI
+	select SND_SOC_HDAC_HDA
 	help
 	  This adds support for ASoC machine driver for Intel platforms
 	  SKL/KBL/BXT/APL with iDisp, HDA audio codecs.
diff --git a/sound/soc/intel/boards/skl_hda_dsp_common.c b/sound/soc/intel/boards/skl_hda_dsp_common.c
index f9917e0f2ba8..3fdbf239da74 100644
--- a/sound/soc/intel/boards/skl_hda_dsp_common.c
+++ b/sound/soc/intel/boards/skl_hda_dsp_common.c
@@ -69,6 +69,30 @@ struct snd_soc_dai_link skl_hda_be_dai_links[HDA_DSP_MAX_BE_DAI_LINKS] = {
 		.dpcm_playback = 1,
 		.no_pcm = 1,
 	},
+	{
+		.name = "Analog Playback and Capture",
+		.id = 4,
+		.cpu_dai_name = "Analog CPU DAI",
+		.codec_name = "ehdaudio0D0",
+		.codec_dai_name = "Analog Codec DAI",
+		.platform_name = "0000:00:1f.3",
+		.dpcm_playback = 1,
+		.dpcm_capture = 1,
+		.init = NULL,
+		.no_pcm = 1,
+	},
+	{
+		.name = "Digital Playback and Capture",
+		.id = 5,
+		.cpu_dai_name = "Digital CPU DAI",
+		.codec_name = "ehdaudio0D0",
+		.codec_dai_name = "Digital Codec DAI",
+		.platform_name = "0000:00:1f.3",
+		.dpcm_playback = 1,
+		.dpcm_capture = 1,
+		.init = NULL,
+		.no_pcm = 1,
+	},
 };
 
 int skl_hda_hdmi_jack_init(struct snd_soc_card *card)
diff --git a/sound/soc/intel/boards/skl_hda_dsp_common.h b/sound/soc/intel/boards/skl_hda_dsp_common.h
index b6c79696bfba..87c50aff56cd 100644
--- a/sound/soc/intel/boards/skl_hda_dsp_common.h
+++ b/sound/soc/intel/boards/skl_hda_dsp_common.h
@@ -15,7 +15,7 @@
 #include <sound/core.h>
 #include <sound/jack.h>
 
-#define HDA_DSP_MAX_BE_DAI_LINKS 3
+#define HDA_DSP_MAX_BE_DAI_LINKS 5
 
 struct skl_hda_hdmi_pcm {
 	struct list_head head;
diff --git a/sound/soc/intel/boards/skl_hda_dsp_generic.c b/sound/soc/intel/boards/skl_hda_dsp_generic.c
index 920bc2ce22aa..b213e9b47505 100644
--- a/sound/soc/intel/boards/skl_hda_dsp_generic.c
+++ b/sound/soc/intel/boards/skl_hda_dsp_generic.c
@@ -16,6 +16,15 @@
 #include "../skylake/skl.h"
 #include "skl_hda_dsp_common.h"
 
+static const struct snd_soc_dapm_widget skl_hda_widgets[] = {
+	SND_SOC_DAPM_HP("Analog Out", NULL),
+	SND_SOC_DAPM_MIC("Analog In", NULL),
+	SND_SOC_DAPM_HP("Alt Analog Out", NULL),
+	SND_SOC_DAPM_MIC("Alt Analog In", NULL),
+	SND_SOC_DAPM_SPK("Digital Out", NULL),
+	SND_SOC_DAPM_MIC("Digital In", NULL),
+};
+
 static const struct snd_soc_dapm_route skl_hda_map[] = {
 	{ "hifi3", NULL, "iDisp3 Tx"},
 	{ "iDisp3 Tx", NULL, "iDisp3_out"},
@@ -23,6 +32,29 @@ static const struct snd_soc_dapm_route skl_hda_map[] = {
 	{ "iDisp2 Tx", NULL, "iDisp2_out"},
 	{ "hifi1", NULL, "iDisp1 Tx"},
 	{ "iDisp1 Tx", NULL, "iDisp1_out"},
+
+	{ "Analog Out", NULL, "Codec Output Pin1" },
+	{ "Digital Out", NULL, "Codec Output Pin2" },
+	{ "Alt Analog Out", NULL, "Codec Output Pin3" },
+
+	{ "Codec Input Pin1", NULL, "Analog In" },
+	{ "Codec Input Pin2", NULL, "Digital In" },
+	{ "Codec Input Pin3", NULL, "Alt Analog In" },
+
+	/* CODEC BE connections */
+	{ "Analog Codec Playback", NULL, "Analog CPU Playback" },
+	{ "Analog CPU Playback", NULL, "codec0_out" },
+	{ "Digital Codec Playback", NULL, "Digital CPU Playback" },
+	{ "Digital CPU Playback", NULL, "codec1_out" },
+	{ "Alt Analog Codec Playback", NULL, "Alt Analog CPU Playback" },
+	{ "Alt Analog CPU Playback", NULL, "codec2_out" },
+
+	{ "codec0_in", NULL, "Analog CPU Capture" },
+	{ "Analog CPU Capture", NULL, "Analog Codec Capture" },
+	{ "codec1_in", NULL, "Digital CPU Capture" },
+	{ "Digital CPU Capture", NULL, "Digital Codec Capture" },
+	{ "codec2_in", NULL, "Alt Analog CPU Capture" },
+	{ "Alt Analog CPU Capture", NULL, "Alt Analog Codec Capture" },
 };
 
 static int skl_hda_card_late_probe(struct snd_soc_card *card)
@@ -57,6 +89,7 @@ static struct snd_soc_card hda_soc_card = {
 	.name = "skl_hda_card",
 	.owner = THIS_MODULE,
 	.dai_link = skl_hda_be_dai_links,
+	.dapm_widgets = skl_hda_widgets,
 	.dapm_routes = skl_hda_map,
 	.add_dai_link = skl_hda_add_dai_link,
 	.fully_routed = true,
@@ -80,6 +113,11 @@ static int skl_hda_fill_card_info(struct skl_machine_pdata *pdata)
 	if (codec_count == 1 && pdata->codec_mask & IDISP_CODEC_MASK) {
 		num_links = IDISP_DAI_COUNT;
 		num_route = IDISP_ROUTE_COUNT;
+	} else if (codec_count == 2 && codec_mask & IDISP_CODEC_MASK) {
+		num_links = ARRAY_SIZE(skl_hda_be_dai_links);
+		num_route = ARRAY_SIZE(skl_hda_map),
+		card->dapm_widgets = skl_hda_widgets;
+		card->num_dapm_widgets = ARRAY_SIZE(skl_hda_widgets);
 	} else {
 		return -EINVAL;
 	}
diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index 5f281d443a53..e7fd14daeb4f 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -37,6 +37,7 @@
 #include "skl.h"
 #include "skl-sst-dsp.h"
 #include "skl-sst-ipc.h"
+#include "../../../soc/codecs/hdac_hda.h"
 
 /*
  * initialize the PCI registers
@@ -657,6 +658,24 @@ static void skl_clock_device_unregister(struct skl *skl)
 		platform_device_unregister(skl->clk_dev);
 }
 
+#define IDISP_INTEL_VENDOR_ID	0x80860000
+
+/*
+ * load the legacy codec driver
+ */
+static void load_codec_module(struct hda_codec *codec)
+{
+#ifdef MODULE
+	char modalias[MODULE_NAME_LEN];
+	const char *mod = NULL;
+
+	snd_hdac_codec_modalias(&codec->core, modalias, sizeof(modalias));
+	mod = modalias;
+	dev_dbg(&codec->core.dev, "loading %s codec module\n", mod);
+	request_module(mod);
+#endif
+}
+
 /*
  * Probe the given codec address
  */
@@ -666,7 +685,9 @@ static int probe_codec(struct hdac_bus *bus, int addr)
 		(AC_VERB_PARAMETERS << 8) | AC_PAR_VENDOR_ID;
 	unsigned int res = -1;
 	struct skl *skl = bus_to_skl(bus);
+	struct hdac_hda_priv *hda_codec;
 	struct hdac_device *hdev;
+	int err;
 
 	mutex_lock(&bus->cmd_mutex);
 	snd_hdac_bus_send_cmd(bus, cmd);
@@ -676,11 +697,24 @@ static int probe_codec(struct hdac_bus *bus, int addr)
 		return -EIO;
 	dev_dbg(bus->dev, "codec #%d probed OK: %x\n", addr, res);
 
-	hdev = devm_kzalloc(&skl->pci->dev, sizeof(*hdev), GFP_KERNEL);
-	if (!hdev)
+	hda_codec = devm_kzalloc(&skl->pci->dev, sizeof(*hda_codec),
+				 GFP_KERNEL);
+	if (!hda_codec)
 		return -ENOMEM;
 
-	return snd_hdac_ext_bus_device_init(bus, addr, hdev);
+	hda_codec->codec.bus = skl_to_hbus(skl);
+	hdev = &hda_codec->codec.core;
+
+	err = snd_hdac_ext_bus_device_init(bus, addr, hdev);
+	if (err < 0)
+		return err;
+
+	/* use legacy bus only for HDA codecs, idisp uses ext bus */
+	if ((res & 0xFFFF0000) != IDISP_INTEL_VENDOR_ID) {
+		hdev->type = HDA_DEV_LEGACY;
+		load_codec_module(&hda_codec->codec);
+	}
+	return 0;
 }
 
 /* Codec initialization */
@@ -815,6 +849,7 @@ static int skl_create(struct pci_dev *pci,
 		      const struct hdac_io_ops *io_ops,
 		      struct skl **rskl)
 {
+	struct hdac_ext_bus_ops *ext_ops = NULL;
 	struct skl *skl;
 	struct hdac_bus *bus;
 	struct hda_bus *hbus;
@@ -834,7 +869,11 @@ static int skl_create(struct pci_dev *pci,
 
 	hbus = skl_to_hbus(skl);
 	bus = skl_to_bus(skl);
-	snd_hdac_ext_bus_init(bus, &pci->dev, &bus_core_ops, io_ops, NULL);
+
+#if IS_ENABLED(CONFIG_SND_SOC_HDAC_HDA)
+	ext_ops = snd_soc_hdac_hda_get_ops();
+#endif
+	snd_hdac_ext_bus_init(bus, &pci->dev, &bus_core_ops, io_ops, ext_ops);
 	bus->use_posbuf = 1;
 	skl->pci = pci;
 	INIT_WORK(&skl->probe_work, skl_probe_work);
-- 
2.18.0
