From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v3 7/7] ASoC: intel - adds support for
	decoupled mode in skl driver
Date: Wed, 29 Apr 2015 01:24:30 +0530
Message-ID: <1430250870-3169-8-git-send-email-vinod.koul@intel.com>
References: <1430250870-3169-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 9317E2657D8
 for <alsa-devel@alsa-project.org>; Tue, 28 Apr 2015 21:57:45 +0200 (CEST)
In-Reply-To: <1430250870-3169-1-git-send-email-vinod.koul@intel.com>
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

From: Jeeja KP <jeeja.kp@intel.com>

Decoupled mode is where audio link is broken to frontend HDA and backend
(hda/i2s/dmic/hdmi) links. This patch adds support for decoupled mode and
then adds dais, dai ops for be/fe cpu dais and interrupt handler change to
support decoupled mode

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/skylake/hda-skl-pcm.c |  365 ++++++++++++++++++++++++++++++++-
 sound/soc/intel/skylake/hda-skl.c     |   24 ++-
 sound/soc/intel/skylake/hda-skl.h     |    1 +
 3 files changed, 381 insertions(+), 9 deletions(-)

diff --git a/sound/soc/intel/skylake/hda-skl-pcm.c b/sound/soc/intel/skylake/hda-skl-pcm.c
index e4d1650b49f5..38d322615e16 100644
--- a/sound/soc/intel/skylake/hda-skl-pcm.c
+++ b/sound/soc/intel/skylake/hda-skl-pcm.c
@@ -102,6 +102,14 @@ static void soc_hda_set_pcm_constrains(struct soc_hdac_bus *sbus,
 				     20, 178000000);
 }
 
+static enum hdac_stream_type hda_get_host_stream_type(struct soc_hdac_bus *sbus)
+{
+	if (sbus->ppcap)
+		return HDAC_STREAM_TYPE_HOST;
+	else
+		return HDAC_STREAM_TYPE_COUPLED;
+}
+
 static int soc_hda_pcm_open(struct snd_pcm_substream *substream,
 		struct snd_soc_dai *dai)
 {
@@ -114,7 +122,7 @@ static int soc_hda_pcm_open(struct snd_pcm_substream *substream,
 	pm_runtime_get_sync(dai->dev);
 
 	stream = snd_soc_hdac_stream_assign(sbus, substream,
-					HDAC_STREAM_TYPE_COUPLED);
+					hda_get_host_stream_type(sbus));
 	if (stream == NULL)
 		return -EBUSY;
 
@@ -149,15 +157,27 @@ static int hda_get_format(struct snd_pcm_substream *substream,
 		struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = snd_pcm_substream_chip(substream);
+	struct soc_hdac_bus *sbus = dev_get_drvdata(dai->dev);
 	struct soc_hda_dma_params *dma_params;
 	int format_val = 0;
-	struct snd_soc_dai *codec_dai = rtd->codec_dai;
 
-	dma_params  = (struct soc_hda_dma_params *)
+	if (sbus->ppcap) {
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
+		dma_params  = (struct soc_hda_dma_params *)
 			snd_soc_dai_get_dma_data(codec_dai, substream);
 
-	if (!dma_params)
-		format_val = dma_params->format;
+		if (!dma_params)
+			format_val = dma_params->format;
+	}
 
 	return format_val;
 }
@@ -195,8 +215,9 @@ static int soc_hda_pcm_hw_params(struct snd_pcm_substream *substream,
 				struct snd_soc_dai *dai)
 {
 	struct soc_hdac_bus *sbus = dev_get_drvdata(dai->dev);
+	struct soc_hdac_stream *stream = get_hdac_stream(substream);
 	struct snd_pcm_runtime *runtime = substream->runtime;
-	int ret = 0;
+	int ret, dma_id;
 
 	dev_dbg(dai->dev, "%s: %s\n", __func__, dai->name);
 	ret = substream_alloc_pages(sbus, substream,
@@ -212,17 +233,22 @@ static int soc_hda_pcm_hw_params(struct snd_pcm_substream *substream,
 	dev_dbg(dai->dev, "format_val, rate=%d, ch=%d, format=%d\n",
 			runtime->rate, runtime->channels, runtime->format);
 
+	dma_id = hdac_stream(stream)->stream_tag;
+	dev_dbg(dai->dev, "dma_id=%d\n", dma_id);
+
 	return ret;
 }
 
 static void soc_hda_pcm_close(struct snd_pcm_substream *substream,
 		struct snd_soc_dai *dai)
 {
+	struct soc_hdac_bus *sbus = dev_get_drvdata(dai->dev);
 	struct soc_hdac_stream *stream = get_hdac_stream(substream);
 	struct soc_hda_dma_params *dma_params = NULL;
 
 	dev_dbg(dai->dev, "%s: %s\n", __func__, dai->name);
-	snd_soc_hdac_stream_release(stream, HDAC_STREAM_TYPE_COUPLED);
+
+	snd_soc_hdac_stream_release(stream, hda_get_host_stream_type(sbus));
 
 	dma_params  = (struct soc_hda_dma_params *)
 			snd_soc_dai_get_dma_data(dai, substream);
@@ -245,6 +271,167 @@ static int soc_hda_pcm_hw_free(struct snd_pcm_substream *substream,
 	return substream_free_pages(hdac_bus(sbus), substream);
 }
 
+static int hda_be_dmic_prepare(struct snd_pcm_substream *substream,
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
+static int soc_hda_be_link_hw_params(struct snd_pcm_substream *substream,
+				struct snd_pcm_hw_params *params,
+				struct snd_soc_dai *dai)
+{
+	struct soc_hdac_bus *sbus = dev_get_drvdata(dai->dev);
+	struct soc_hdac_stream *link_dev;
+	struct snd_soc_pcm_runtime *rtd = snd_pcm_substream_chip(substream);
+	struct soc_hda_dma_params *dma_params;
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+	int dma_id;
+
+	pr_debug("%s\n", __func__);
+	link_dev = snd_soc_hdac_stream_assign(sbus, substream,
+					HDAC_STREAM_TYPE_LINK);
+	if (!link_dev)
+		return -EBUSY;
+
+	snd_soc_dai_set_dma_data(dai, substream, (void *)link_dev);
+
+	/*set the stream tag in the codec dai dma params */
+	dma_params  = (struct soc_hda_dma_params *)
+			snd_soc_dai_get_dma_data(codec_dai, substream);
+	if (dma_params)
+		dma_params->stream_tag =  hdac_stream(link_dev)->stream_tag;
+	snd_soc_dai_set_dma_data(codec_dai, substream, (void *)dma_params);
+	dma_id = hdac_stream(link_dev)->stream_tag;
+
+	return 0;
+}
+
+static int soc_hda_be_link_pcm_prepare(struct snd_pcm_substream *substream,
+		struct snd_soc_dai *dai)
+{
+	struct snd_soc_pcm_runtime *rtd = snd_pcm_substream_chip(substream);
+	struct soc_hdac_bus *sbus = dev_get_drvdata(dai->dev);
+	struct soc_hdac_stream *link_dev =
+			snd_soc_dai_get_dma_data(dai, substream);
+	unsigned int format_val = 0;
+	int ret = 0;
+	struct soc_hda_dma_params *dma_params;
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+	struct snd_pcm_hw_params *params;
+	struct snd_interval *channels, *rate;
+	struct soc_hdac_link *link;
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
+	dma_params  = (struct soc_hda_dma_params *)
+			snd_soc_dai_get_dma_data(codec_dai, substream);
+	if (dma_params)
+		format_val = dma_params->format;
+	dev_dbg(dai->dev, "stream_tag=%d formatvalue=%d codec_dai_name=%s\n",
+			hdac_stream(link_dev)->stream_tag, format_val,
+			 codec_dai->name);
+	snd_soc_hdac_link_stream_reset(link_dev);
+
+	snd_soc_hdac_link_stream_setup(link_dev, format_val);
+
+	link = snd_soc_hdac_bus_get_link(sbus, rtd->codec->component.name);
+	if (!link)
+		return -EINVAL;
+	snd_soc_hdac_link_set_stream_id(link, hdac_stream(link_dev)->stream_tag);
+	link_dev->link_prepared = 1;
+	return ret;
+}
+
+static int soc_hda_be_link_pcm_trigger(struct snd_pcm_substream *substream,
+	int cmd, struct snd_soc_dai *dai)
+{
+	struct soc_hdac_stream *link_dev =
+				snd_soc_dai_get_dma_data(dai, substream);
+
+	dev_dbg(dai->dev, "In %s cmd=%d\n", __func__, cmd);
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+	case SNDRV_PCM_TRIGGER_RESUME:
+		snd_soc_hdac_link_stream_start(link_dev);
+		break;
+
+	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+	case SNDRV_PCM_TRIGGER_STOP:
+		snd_soc_hdac_link_stream_clear(link_dev);
+		break;
+
+	default:
+	return -EINVAL;
+	}
+	return 0;
+}
+
+static int soc_hda_be_link_hw_free(struct snd_pcm_substream *substream,
+		struct snd_soc_dai *dai)
+{
+	struct soc_hdac_bus *sbus = dev_get_drvdata(dai->dev);
+	struct snd_soc_pcm_runtime *rtd = snd_pcm_substream_chip(substream);
+	struct soc_hdac_stream *link_dev =
+				snd_soc_dai_get_dma_data(dai, substream);
+	struct soc_hdac_link *link;
+
+	dev_dbg(dai->dev, "%s: %s\n", __func__, dai->name);
+
+	link_dev->link_prepared = 0;
+
+	link = snd_soc_hdac_bus_get_link(sbus, rtd->codec->component.name);
+	if (!link)
+		return -EINVAL;
+	snd_soc_hdac_link_clear_stream_id(link, hdac_stream(link_dev)->stream_tag);
+	snd_soc_hdac_stream_release(link_dev, HDAC_STREAM_TYPE_LINK);
+	return 0;
+}
+
+static int soc_hda_be_startup(struct snd_pcm_substream *substream,
+		struct snd_soc_dai *dai)
+{
+	return pm_runtime_get_sync(dai->dev);
+}
+
+static void soc_hda_be_shutdown(struct snd_pcm_substream *substream,
+		struct snd_soc_dai *dai)
+{
+	pm_runtime_mark_last_busy(dai->dev);
+	pm_runtime_put_autosuspend(dai->dev);
+}
+
 static struct snd_soc_dai_ops hda_pcm_dai_ops = {
 	.startup = soc_hda_pcm_open,
 	.shutdown = soc_hda_pcm_close,
@@ -253,6 +440,21 @@ static struct snd_soc_dai_ops hda_pcm_dai_ops = {
 	.hw_free = soc_hda_pcm_hw_free,
 };
 
+static struct snd_soc_dai_ops hda_be_dmic_dai_ops = {
+	.startup = soc_hda_be_startup,
+	.prepare = hda_be_dmic_prepare,
+	.shutdown = soc_hda_be_shutdown,
+};
+
+static struct snd_soc_dai_ops hda_be_link_dai_ops = {
+	.startup = soc_hda_be_startup,
+	.prepare = soc_hda_be_link_pcm_prepare,
+	.hw_params = soc_hda_be_link_hw_params,
+	.hw_free = soc_hda_be_link_hw_free,
+	.trigger = soc_hda_be_link_pcm_trigger,
+	.shutdown = soc_hda_be_shutdown,
+};
+
 static struct snd_soc_dai_driver soc_hda_platform_dai[] = {
 {
 	.name = "System Pin",
@@ -273,6 +475,17 @@ static struct snd_soc_dai_driver soc_hda_platform_dai[] = {
 	},
 },
 {
+	.name = "Reference Pin",
+	.ops = &hda_pcm_dai_ops,
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
 	.ops = &hda_pcm_dai_ops,
 	.playback = {
@@ -294,6 +507,80 @@ static struct snd_soc_dai_driver soc_hda_platform_dai[] = {
 		.formats = SNDRV_PCM_FMTBIT_S16_LE,
 	},
 },
+/*BE CPU  Dais */
+{
+	.name = "iDisp Pin",
+	.ops = &hda_be_link_dai_ops,
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
+	.ops = &hda_be_dmic_dai_ops,
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
+	.ops = &hda_be_dmic_dai_ops,
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
+	.ops = &hda_be_link_dai_ops,
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
+	.ops = &hda_be_link_dai_ops,
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
+	.ops = &hda_be_link_dai_ops,
+	.capture = {
+		.stream_name = "HD-Codec-AMIC Rx",
+		.channels_min = HDA_STEREO,
+		.channels_max = HDA_STEREO,
+		.rates = SNDRV_PCM_RATE_48000,
+		.formats = SNDRV_PCM_FMTBIT_S16_LE,
+	},
+},
 };
 
 static int soc_hda_platform_open(struct snd_pcm_substream *substream)
@@ -310,7 +597,7 @@ static int soc_hda_platform_open(struct snd_pcm_substream *substream)
 	return 0;
 }
 
-static int soc_hda_platform_pcm_trigger(struct snd_pcm_substream *substream,
+static int soc_hda_pcm_trigger(struct snd_pcm_substream *substream,
 					int cmd)
 {
 	struct soc_hdac_bus *sbus = get_bus_ctx(substream);
@@ -383,6 +670,68 @@ static int soc_hda_platform_pcm_trigger(struct snd_pcm_substream *substream,
 	return 0;
 }
 
+static int soc_hda_dsp_trigger(struct snd_pcm_substream *substream,
+		int cmd)
+{
+	struct soc_hdac_bus *sbus = get_bus_ctx(substream);
+	struct hdac_bus *bus = hdac_bus(sbus);
+	struct snd_soc_pcm_runtime *rtd = snd_pcm_substream_chip(substream);
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
+	struct soc_hdac_stream *stream;
+	int start;
+	unsigned long cookie;
+	struct hdac_stream *hstr;
+
+	dev_dbg(bus->dev, "In %s cmd=%d streamname=%s\n", __func__, cmd, cpu_dai->name);
+
+	stream = get_hdac_stream(substream);
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
+	return -EINVAL;
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
+static int soc_hda_platform_pcm_trigger(struct snd_pcm_substream *substream,
+					int cmd)
+{
+	struct soc_hdac_bus *sbus = get_bus_ctx(substream);
+
+	if (sbus->ppcap)
+		return soc_hda_dsp_trigger(substream, cmd);
+	else
+		return soc_hda_pcm_trigger(substream, cmd);
+}
+
 /* calculate runtime delay from LPIB */
 static int hda_get_delay_from_lpib(struct soc_hdac_bus *sbus,
 				struct soc_hdac_stream *sstream,
diff --git a/sound/soc/intel/skylake/hda-skl.c b/sound/soc/intel/skylake/hda-skl.c
index 24502f8e796d..51aa07574dd3 100644
--- a/sound/soc/intel/skylake/hda-skl.c
+++ b/sound/soc/intel/skylake/hda-skl.c
@@ -205,10 +205,16 @@ static int azx_acquire_irq(struct soc_hdac_bus *sbus, int do_disconnect)
 	struct hda_skl *hda = to_hda_skl(sbus);
 	struct hdac_bus *bus = hdac_bus(sbus);
 	int ret = 0;
+	unsigned long flags = 0;
+
+	if (sbus->ppcap)
+		flags = IRQF_SHARED;
+	else
+		flags = hda->msi ? 0 : IRQF_SHARED;
 
 	ret = request_threaded_irq(hda->pci->irq, azx_interrupt,
 			azx_threaded_handler,
-			hda->msi ? 0 : IRQF_SHARED,
+			flags,
 			KBUILD_MODNAME, sbus);
 	if (ret) {
 		dev_err(bus->dev,
@@ -281,6 +287,7 @@ static int azx_runtime_suspend(struct device *dev)
 	struct pci_dev *pci = to_pci_dev(dev);
 	struct soc_hdac_bus *sbus = pci_get_drvdata(pci);
 	struct hdac_bus *bus = hdac_bus(sbus);
+	struct hda_skl *hda = to_hda_skl(sbus);
 
 	dev_dbg(bus->dev, "in %s\n", __func__);
 
@@ -420,6 +427,10 @@ static int probe_codec(struct soc_hdac_bus *sbus, int addr)
 	if (res == -1)
 		return -EIO;
 	dev_dbg(bus->dev, "codec #%d probed OK\n", addr);
+
+	if (sbus->mlcap)
+		snd_soc_hdac_bus_map_codec_to_link(sbus, addr);
+
 	return azx_add_codec_device(addr, bus);
 }
 
@@ -520,6 +531,8 @@ static int azx_first_init(struct soc_hdac_bus *sbus)
 		if (pci_enable_msi(pci) < 0)
 			hda->msi = 0;
 
+	snd_soc_hdac_bus_parse_capabilities(sbus);
+
 	if (azx_acquire_irq(sbus, 0) < 0)
 		return -EBUSY;
 
@@ -649,6 +662,15 @@ static int azx_probe(struct pci_dev *pci,
 	if (err < 0)
 		goto out_free;
 
+	/* check if dsp is there */
+	if (sbus->ppcap) {
+		/* TODO register with dsp lib */
+		dev_dbg(bus->dev, "Register dsp\n");
+	}
+
+	if (sbus->mlcap)
+		snd_soc_hdac_bus_get_ml_capablities(sbus);
+
 	/*create device for soc dmic*/
 	err = hda_dmic_device_register(hda);
 	if (err < 0)
diff --git a/sound/soc/intel/skylake/hda-skl.h b/sound/soc/intel/skylake/hda-skl.h
index ed6ccd31b198..7793111e42e5 100644
--- a/sound/soc/intel/skylake/hda-skl.h
+++ b/sound/soc/intel/skylake/hda-skl.h
@@ -23,6 +23,7 @@
 
 #include <sound/core.h>
 #include <sound/initval.h>
+#include <sound/soc.h>
 #include <sound/hda_register.h>
 #include <sound/hdaudio.h>
 #include <sound/soc-hdaudio.h>
-- 
1.7.9.5
