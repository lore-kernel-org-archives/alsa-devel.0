From: Rakesh Ughreja <rakesh.a.ughreja@intel.com>
Subject: [RFC v3 08/11] ASoC: hdac_hda: add DAI,
	widgets and related ops
Date: Fri, 15 Dec 2017 17:00:45 +0530
Message-ID: <1513337448-31685-9-git-send-email-rakesh.a.ughreja@intel.com>
References: <1513337448-31685-1-git-send-email-rakesh.a.ughreja@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id B1C1D267BA8
 for <alsa-devel@alsa-project.org>; Fri, 15 Dec 2017 12:26:34 +0100 (CET)
In-Reply-To: <1513337448-31685-1-git-send-email-rakesh.a.ughreja@intel.com>
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

Add support for widgets, routes, DAI and related handlers.

Signed-off-by: Rakesh Ughreja <rakesh.a.ughreja@intel.com>
---
 sound/soc/codecs/hdac_hda.c | 486 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 486 insertions(+)

diff --git a/sound/soc/codecs/hdac_hda.c b/sound/soc/codecs/hdac_hda.c
index 387b00f..4b4d80c 100644
--- a/sound/soc/codecs/hdac_hda.c
+++ b/sound/soc/codecs/hdac_hda.c
@@ -28,6 +28,483 @@
 #include "../../pci/hda/hda_codec.h"
 #include "hdac_hda.h"
 
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
+static int hdac_codec_match(struct hdac_device *hdev, struct hdac_driver *drv)
+{
+	struct hda_codec *codec = hdac_to_hda_codec(hdev);
+	const struct hda_device_id *list;
+	u32 id, rev_id;
+
+	if (!codec) {
+		dev_err(&hdev->dev, "%p\n", codec);
+		return 0;
+	}
+
+	/* check probe_id instead of vendor_id if set */
+	id = codec->probe_id ? codec->probe_id : codec->core.vendor_id;
+	rev_id = codec->core.revision_id;
+
+	dev_dbg(&hdev->dev, "%s: probe_id=0x%x and vendor_id=0x%x\n",
+			__func__, codec->probe_id, codec->core.vendor_id);
+
+	for (list = drv->id_table; list->vendor_id; list++) {
+		if (list->vendor_id == id &&
+			(!list->rev_id || list->rev_id == rev_id)) {
+			codec->preset = list;
+			dev_dbg(&hdev->dev, "found patch file %x\n", id);
+			return 1;
+		}
+	}
+	return 0;
+}
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
+	struct hdac_driver *hdrv = drv_to_hdac_driver(hdev->dev.driver);
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
+	ret = snd_hda_codec_device_new(hda_pvt->hbus,
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
+	hda_pvt->hbus->card = dapm->card->snd_card;
+
+	dev_dbg(&hdev->dev, "after card created in_pm=%d pm_usage=%d\n",
+			hdev->in_pm.counter,
+			hdev->dev.power.usage_count.counter);
+
+	ret = hdac_codec_match(hdev, hdrv);
+	if (ret < 1) {
+		dev_err(codec->dev, "no match found for the codec\n");
+		return ret;
+	}
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
 static int hdac_hda_dev_probe(struct hdac_device *hdev)
 {
 	struct hdac_ext_link *hlink = NULL;
@@ -48,6 +525,14 @@ static int hdac_hda_dev_probe(struct hdac_device *hdev)
 	if (hda_pvt == NULL)
 		return -ENOMEM;
 
+	/* ASoC specific initialization */
+	ret = snd_soc_register_codec(&hdev->dev, &hdac_hda_codec, hdac_hda_dais,
+					 ARRAY_SIZE(hdac_hda_dais));
+	if (ret < 0) {
+		dev_err(&hdev->dev, "failed to register HDA codec %d\n", ret);
+		return ret;
+	}
+
 	dev_set_drvdata(&hdev->dev, hda_pvt);
 	snd_hdac_ext_bus_link_put(hdev->bus, hlink);
 
@@ -57,6 +542,7 @@ static int hdac_hda_dev_probe(struct hdac_device *hdev)
 static int hdac_hda_dev_remove(struct hdac_device *hdev)
 {
 	dev_dbg(&hdev->dev, "%s: entry\n", __func__);
+	snd_soc_unregister_codec(&hdev->dev);
 	return 0;
 }
 
-- 
2.7.4
