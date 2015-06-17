From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v6 4/4] ASoC: intel - adds support for
	decoupled mode in skl driver
Date: Wed, 17 Jun 2015 18:30:55 +0530
Message-ID: <1434546055-28866-5-git-send-email-vinod.koul@intel.com>
References: <1434546055-28866-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 1D87C265DC7
 for <alsa-devel@alsa-project.org>; Wed, 17 Jun 2015 14:59:54 +0200 (CEST)
In-Reply-To: <1434546055-28866-1-git-send-email-vinod.koul@intel.com>
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
Cc: tiwai@suse.de, patches.audio@intel.com, liam.r.girdwood@linux.intel.com, Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org

Decoupled mode is where audio link is broken to frontend HDA and backend
(hda/i2s/dmic/hdmi) links. This patch adds support for decoupled mode and
then adds dais, dai ops for be/fe cpu dais and interrupt handler change to
support decoupled mode

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/skylake/skl-pcm.c | 367 +++++++++++++++++++++++++++++++++++++-
 sound/soc/intel/skylake/skl.c     |  11 ++
 2 files changed, 370 insertions(+), 8 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-pcm.c b/sound/soc/intel/skylake/skl-pcm.c
index 4848696f749c..c8adaabdef12 100644
--- a/sound/soc/intel/skylake/skl-pcm.c
+++ b/sound/soc/intel/skylake/skl-pcm.c
@@ -96,6 +96,14 @@ static void skl_set_pcm_constrains(struct hdac_ext_bus *ebus,
 				     20, 178000000);
 }
 
+static enum hdac_ext_stream_type skl_get_host_stream_type(struct hdac_ext_bus *ebus)
+{
+	if (ebus->ppcap)
+		return HDAC_EXT_STREAM_TYPE_HOST;
+	else
+		return HDAC_EXT_STREAM_TYPE_COUPLED;
+}
+
 static int skl_pcm_open(struct snd_pcm_substream *substream,
 		struct snd_soc_dai *dai)
 {
@@ -108,7 +116,7 @@ static int skl_pcm_open(struct snd_pcm_substream *substream,
 	pm_runtime_get_sync(dai->dev);
 
 	stream = snd_hdac_ext_stream_assign(ebus, substream,
-					HDAC_EXT_STREAM_TYPE_COUPLED);
+					skl_get_host_stream_type(ebus));
 	if (stream == NULL)
 		return -EBUSY;
 
@@ -144,14 +152,26 @@ static int skl_get_format(struct snd_pcm_substream *substream,
 {
 	struct snd_soc_pcm_runtime *rtd = snd_pcm_substream_chip(substream);
 	struct skl_dma_params *dma_params;
+	struct hdac_ext_bus *ebus = dev_get_drvdata(dai->dev);
 	int format_val = 0;
-	struct snd_soc_dai *codec_dai = rtd->codec_dai;
 
-	dma_params  = (struct skl_dma_params *)
+	if (ebus->ppcap) {
+		struct snd_pcm_runtime *runtime = substream->runtime;
+
+		format_val = snd_hdac_calc_stream_format(runtime->rate,
+						runtime->channels,
+						runtime->format,
+						32, 0);
+
+	} else {
+		struct snd_soc_dai *codec_dai = rtd->codec_dai;
+
+		dma_params  = (struct skl_dma_params *)
 			snd_soc_dai_get_dma_data(codec_dai, substream);
 
-	if (dma_params)
-		format_val = dma_params->format;
+		if (dma_params)
+			format_val = dma_params->format;
+	}
 
 	return format_val;
 }
@@ -192,8 +212,9 @@ static int skl_pcm_hw_params(struct snd_pcm_substream *substream,
 				struct snd_soc_dai *dai)
 {
 	struct hdac_ext_bus *ebus = dev_get_drvdata(dai->dev);
+	struct hdac_ext_stream *stream = get_hdac_ext_stream(substream);
 	struct snd_pcm_runtime *runtime = substream->runtime;
-	int ret;
+	int ret, dma_id;
 
 	dev_dbg(dai->dev, "%s: %s\n", __func__, dai->name);
 	ret = skl_substream_alloc_pages(ebus, substream,
@@ -208,6 +229,9 @@ static int skl_pcm_hw_params(struct snd_pcm_substream *substream,
 	dev_dbg(dai->dev, "format_val, rate=%d, ch=%d, format=%d\n",
 			runtime->rate, runtime->channels, runtime->format);
 
+	dma_id = hdac_stream(stream)->stream_tag - 1;
+	dev_dbg(dai->dev, "dma_id=%d\n", dma_id);
+
 	return 0;
 }
 
@@ -215,10 +239,12 @@ static void skl_pcm_close(struct snd_pcm_substream *substream,
 		struct snd_soc_dai *dai)
 {
 	struct hdac_ext_stream *stream = get_hdac_ext_stream(substream);
+	struct hdac_ext_bus *ebus = dev_get_drvdata(dai->dev);
 	struct skl_dma_params *dma_params = NULL;
 
 	dev_dbg(dai->dev, "%s: %s\n", __func__, dai->name);
-	snd_hdac_ext_stream_release(stream, HDAC_EXT_STREAM_TYPE_COUPLED);
+
+	snd_hdac_ext_stream_release(stream, skl_get_host_stream_type(ebus));
 
 	dma_params  = (struct skl_dma_params *)
 			snd_soc_dai_get_dma_data(dai, substream);
@@ -242,6 +268,169 @@ static int skl_pcm_hw_free(struct snd_pcm_substream *substream,
 	return skl_substream_free_pages(ebus_to_hbus(ebus), substream);
 }
 
+static int skl_dmic_prepare(struct snd_pcm_substream *substream,
+				struct snd_soc_dai *dai)
+{
+	struct snd_pcm_hw_params params = {0};
+	struct snd_interval *channels, *rate;
+
+	dev_dbg(dai->dev, "%s: %s\n", __func__, dai->name);
+
+	channels = hw_param_interval(&params, SNDRV_PCM_HW_PARAM_CHANNELS);
+	channels->min = channels->max = substream->runtime->channels;
+	rate = hw_param_interval(&params, SNDRV_PCM_HW_PARAM_RATE);
+	rate->min = rate->max = substream->runtime->rate;
+	snd_mask_set(&params.masks[SNDRV_PCM_HW_PARAM_FORMAT -
+					SNDRV_PCM_HW_PARAM_FIRST_MASK],
+					substream->runtime->format);
+
+	return 0;
+}
+
+static int skl_link_hw_params(struct snd_pcm_substream *substream,
+				struct snd_pcm_hw_params *params,
+				struct snd_soc_dai *dai)
+{
+	struct hdac_ext_bus *ebus = dev_get_drvdata(dai->dev);
+	struct hdac_ext_stream *link_dev;
+	struct snd_soc_pcm_runtime *rtd = snd_pcm_substream_chip(substream);
+	struct skl_dma_params *dma_params;
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+	int dma_id;
+
+	pr_debug("%s\n", __func__);
+	link_dev = snd_hdac_ext_stream_assign(ebus, substream,
+					HDAC_EXT_STREAM_TYPE_LINK);
+	if (!link_dev)
+		return -EBUSY;
+
+	snd_soc_dai_set_dma_data(dai, substream, (void *)link_dev);
+
+	/* set the stream tag in the codec dai dma params  */
+	dma_params = (struct skl_dma_params *)
+			snd_soc_dai_get_dma_data(codec_dai, substream);
+	if (dma_params)
+		dma_params->stream_tag =  hdac_stream(link_dev)->stream_tag;
+	snd_soc_dai_set_dma_data(codec_dai, substream, (void *)dma_params);
+	dma_id = hdac_stream(link_dev)->stream_tag - 1;
+
+	return 0;
+}
+
+static int skl_link_pcm_prepare(struct snd_pcm_substream *substream,
+		struct snd_soc_dai *dai)
+{
+	struct snd_soc_pcm_runtime *rtd = snd_pcm_substream_chip(substream);
+	struct hdac_ext_bus *ebus = dev_get_drvdata(dai->dev);
+	struct hdac_ext_stream *link_dev =
+			snd_soc_dai_get_dma_data(dai, substream);
+	unsigned int format_val = 0;
+	struct skl_dma_params *dma_params;
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+	struct snd_pcm_hw_params *params;
+	struct snd_interval *channels, *rate;
+	struct hdac_ext_link *link;
+
+	dev_dbg(dai->dev, "%s: %s\n", __func__, dai->name);
+	if (link_dev->link_prepared) {
+		dev_dbg(dai->dev, "already stream is prepared - returning\n");
+		return 0;
+	}
+	params  = devm_kzalloc(dai->dev, sizeof(*params), GFP_KERNEL);
+	if (params == NULL)
+		return -ENOMEM;
+
+	channels = hw_param_interval(params, SNDRV_PCM_HW_PARAM_CHANNELS);
+	channels->min = channels->max = substream->runtime->channels;
+	rate = hw_param_interval(params, SNDRV_PCM_HW_PARAM_RATE);
+	rate->min = rate->max = substream->runtime->rate;
+	snd_mask_set(&params->masks[SNDRV_PCM_HW_PARAM_FORMAT -
+					SNDRV_PCM_HW_PARAM_FIRST_MASK],
+					substream->runtime->format);
+
+
+	dma_params  = (struct skl_dma_params *)
+			snd_soc_dai_get_dma_data(codec_dai, substream);
+	if (dma_params)
+		format_val = dma_params->format;
+	dev_dbg(dai->dev, "stream_tag=%d formatvalue=%d codec_dai_name=%s\n",
+			hdac_stream(link_dev)->stream_tag, format_val, codec_dai->name);
+
+	snd_hdac_ext_link_stream_reset(link_dev);
+
+	snd_hdac_ext_link_stream_setup(link_dev, format_val);
+
+	link = snd_hdac_ext_bus_get_link(ebus, rtd->codec->component.name);
+	if (!link)
+		return -EINVAL;
+
+	snd_hdac_ext_link_set_stream_id(link, hdac_stream(link_dev)->stream_tag);
+	link_dev->link_prepared = 1;
+
+	return 0;
+}
+
+static int skl_link_pcm_trigger(struct snd_pcm_substream *substream,
+	int cmd, struct snd_soc_dai *dai)
+{
+	struct hdac_ext_stream *link_dev =
+				snd_soc_dai_get_dma_data(dai, substream);
+
+	dev_dbg(dai->dev, "In %s cmd=%d\n", __func__, cmd);
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+	case SNDRV_PCM_TRIGGER_RESUME:
+		snd_hdac_ext_link_stream_start(link_dev);
+		break;
+
+	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+	case SNDRV_PCM_TRIGGER_STOP:
+		snd_hdac_ext_link_stream_clear(link_dev);
+		break;
+
+	default:
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static int skl_link_hw_free(struct snd_pcm_substream *substream,
+		struct snd_soc_dai *dai)
+{
+	struct hdac_ext_bus *ebus = dev_get_drvdata(dai->dev);
+	struct snd_soc_pcm_runtime *rtd = snd_pcm_substream_chip(substream);
+	struct hdac_ext_stream *link_dev =
+				snd_soc_dai_get_dma_data(dai, substream);
+	struct hdac_ext_link *link;
+
+	dev_dbg(dai->dev, "%s: %s\n", __func__, dai->name);
+
+	link_dev->link_prepared = 0;
+
+	link = snd_hdac_ext_bus_get_link(ebus, rtd->codec->component.name);
+	if (!link)
+		return -EINVAL;
+
+	snd_hdac_ext_link_clear_stream_id(link, hdac_stream(link_dev)->stream_tag);
+	snd_hdac_ext_stream_release(link_dev, HDAC_EXT_STREAM_TYPE_LINK);
+	return 0;
+}
+
+static int skl_hda_be_startup(struct snd_pcm_substream *substream,
+		struct snd_soc_dai *dai)
+{
+	return pm_runtime_get_sync(dai->dev);
+}
+
+static void skl_hda_be_shutdown(struct snd_pcm_substream *substream,
+		struct snd_soc_dai *dai)
+{
+	pm_runtime_mark_last_busy(dai->dev);
+	pm_runtime_put_autosuspend(dai->dev);
+}
+
 static struct snd_soc_dai_ops skl_pcm_dai_ops = {
 	.startup = skl_pcm_open,
 	.shutdown = skl_pcm_close,
@@ -250,6 +439,21 @@ static struct snd_soc_dai_ops skl_pcm_dai_ops = {
 	.hw_free = skl_pcm_hw_free,
 };
 
+static struct snd_soc_dai_ops skl_dmic_dai_ops = {
+	.startup = skl_hda_be_startup,
+	.prepare = skl_dmic_prepare,
+	.shutdown = skl_hda_be_shutdown,
+};
+
+static struct snd_soc_dai_ops skl_link_dai_ops = {
+	.startup = skl_hda_be_startup,
+	.prepare = skl_link_pcm_prepare,
+	.hw_params = skl_link_hw_params,
+	.hw_free = skl_link_hw_free,
+	.trigger = skl_link_pcm_trigger,
+	.shutdown = skl_hda_be_shutdown,
+};
+
 static struct snd_soc_dai_driver skl_platform_dai[] = {
 {
 	.name = "System Pin",
@@ -270,6 +474,17 @@ static struct snd_soc_dai_driver skl_platform_dai[] = {
 	},
 },
 {
+	.name = "Reference Pin",
+	.ops = &skl_pcm_dai_ops,
+	.capture = {
+		.stream_name = "Reference Capture",
+		.channels_min = HDA_MONO,
+		.channels_max = HDA_STEREO,
+		.rates = SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_16000,
+		.formats = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S24_LE,
+	},
+},
+{
 	.name = "Deepbuffer Pin",
 	.ops = &skl_pcm_dai_ops,
 	.playback = {
@@ -291,6 +506,80 @@ static struct snd_soc_dai_driver skl_platform_dai[] = {
 		.formats = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S24_LE,
 	},
 },
+/* BE CPU  Dais */
+{
+	.name = "iDisp Pin",
+	.ops = &skl_link_dai_ops,
+	.playback = {
+		.stream_name = "iDisp Tx",
+		.channels_min = HDA_STEREO,
+		.channels_max = HDA_STEREO,
+		.rates = SNDRV_PCM_RATE_8000|SNDRV_PCM_RATE_16000|SNDRV_PCM_RATE_48000,
+		.formats = SNDRV_PCM_FMTBIT_S16_LE,
+	},
+},
+{
+	.name = "DMIC01 Pin",
+	.ops = &skl_dmic_dai_ops,
+	.capture = {
+		.stream_name = "DMIC01 Rx",
+		.channels_min = HDA_STEREO,
+		.channels_max = HDA_STEREO,
+		.rates = SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_16000,
+		.formats = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S24_LE,
+	},
+},
+{
+	.name = "DMIC23 Pin",
+	.ops = &skl_dmic_dai_ops,
+	.capture = {
+		.stream_name = "DMIC23 Rx",
+		.channels_min = HDA_STEREO,
+		.channels_max = HDA_STEREO,
+		.rates = SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_16000,
+		.formats = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S24_LE,
+	},
+},
+{
+	.name = "HD-Codec Pin",
+	.ops = &skl_link_dai_ops,
+	.playback = {
+		.stream_name = "HD-Codec Tx",
+		.channels_min = HDA_STEREO,
+		.channels_max = HDA_STEREO,
+		.rates = SNDRV_PCM_RATE_48000,
+		.formats = SNDRV_PCM_FMTBIT_S16_LE,
+	},
+	.capture = {
+		.stream_name = "HD-Codec Rx",
+		.channels_min = HDA_STEREO,
+		.channels_max = HDA_STEREO,
+		.rates = SNDRV_PCM_RATE_48000,
+		.formats = SNDRV_PCM_FMTBIT_S16_LE,
+	},
+},
+{
+	.name = "HD-Codec-SPK Pin",
+	.ops = &skl_link_dai_ops,
+	.playback = {
+		.stream_name = "HD-Codec-SPK Tx",
+		.channels_min = HDA_STEREO,
+		.channels_max = HDA_STEREO,
+		.rates = SNDRV_PCM_RATE_48000,
+		.formats = SNDRV_PCM_FMTBIT_S16_LE,
+	},
+},
+{
+	.name = "HD-Codec-AMIC Pin",
+	.ops = &skl_link_dai_ops,
+	.capture = {
+		.stream_name = "HD-Codec-AMIC Rx",
+		.channels_min = HDA_STEREO,
+		.channels_max = HDA_STEREO,
+		.rates = SNDRV_PCM_RATE_48000,
+		.formats = SNDRV_PCM_FMTBIT_S16_LE,
+	},
+},
 };
 
 static int skl_platform_open(struct snd_pcm_substream *substream)
@@ -308,7 +597,7 @@ static int skl_platform_open(struct snd_pcm_substream *substream)
 	return 0;
 }
 
-static int skl_platform_pcm_trigger(struct snd_pcm_substream *substream,
+static int skl_pcm_trigger(struct snd_pcm_substream *substream,
 					int cmd)
 {
 	struct hdac_ext_bus *ebus = get_bus_ctx(substream);
@@ -382,6 +671,68 @@ static int skl_platform_pcm_trigger(struct snd_pcm_substream *substream,
 	return 0;
 }
 
+static int skl_dsp_trigger(struct snd_pcm_substream *substream,
+		int cmd)
+{
+	struct hdac_ext_bus *ebus = get_bus_ctx(substream);
+	struct hdac_bus *bus = ebus_to_hbus(ebus);
+	struct snd_soc_pcm_runtime *rtd = snd_pcm_substream_chip(substream);
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
+	struct hdac_ext_stream *stream;
+	int start;
+	unsigned long cookie;
+	struct hdac_stream *hstr;
+
+	dev_dbg(bus->dev, "In %s cmd=%d streamname=%s\n", __func__, cmd, cpu_dai->name);
+
+	stream = get_hdac_ext_stream(substream);
+	hstr = hdac_stream(stream);
+
+	if (!hstr->prepared)
+		return -EPIPE;
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+	case SNDRV_PCM_TRIGGER_RESUME:
+		start = 1;
+		break;
+
+	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+	case SNDRV_PCM_TRIGGER_STOP:
+		start = 0;
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	spin_lock_irqsave(&bus->reg_lock, cookie);
+
+	if (start)
+		snd_hdac_stream_start(hdac_stream(stream), true);
+	else
+		snd_hdac_stream_stop(hdac_stream(stream));
+
+	if (start)
+		snd_hdac_stream_timecounter_init(hstr, 0);
+
+	spin_unlock_irqrestore(&bus->reg_lock, cookie);
+
+	return 0;
+}
+static int skl_platform_pcm_trigger(struct snd_pcm_substream *substream,
+					int cmd)
+{
+	struct hdac_ext_bus *ebus = get_bus_ctx(substream);
+
+	if (ebus->ppcap)
+		return skl_dsp_trigger(substream, cmd);
+	else
+		return skl_pcm_trigger(substream, cmd);
+}
+
 /* calculate runtime delay from LPIB */
 static int skl_get_delay_from_lpib(struct hdac_ext_bus *ebus,
 				struct hdac_ext_stream *sstream,
diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index 149426727ada..0ab02af0325a 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -382,6 +382,8 @@ static int skl_first_init(struct hdac_ext_bus *ebus)
 		return -ENXIO;
 	}
 
+	snd_hdac_ext_bus_parse_capabilities(ebus);
+
 	if (skl_acquire_irq(ebus, 0) < 0)
 		return -EBUSY;
 
@@ -455,6 +457,15 @@ static int skl_probe(struct pci_dev *pci,
 
 	pci_set_drvdata(skl->pci, ebus);
 
+	/* check if dsp is there */
+	if (ebus->ppcap) {
+		/* TODO register with dsp IPC */
+		dev_dbg(bus->dev, "Register dsp\n");
+	}
+
+	if (ebus->mlcap)
+		snd_hdac_ext_bus_get_ml_capabilities(ebus);
+
 	/* create device for soc dmic */
 	err = skl_dmic_device_register(skl);
 	if (err < 0)
-- 
1.9.1
