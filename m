From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v3 4/7] ASoC: intel - add Skylake HDA platform
	driver
Date: Wed, 29 Apr 2015 01:24:27 +0530
Message-ID: <1430250870-3169-5-git-send-email-vinod.koul@intel.com>
References: <1430250870-3169-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id A81E4260427
 for <alsa-devel@alsa-project.org>; Tue, 28 Apr 2015 21:57:36 +0200 (CEST)
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
Cc: tiwai@suse.de, liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, Jeeja KP <jeeja.kp@intel.com>, Vinod Koul <vinod.koul@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Jeeja KP <jeeja.kp@intel.com>

This patch starts to add the Skylake HDA platform driver by defining SoC cpu
dais, DMA driver ops and implements ALSA operations

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/skylake/hda-skl-pcm.c |  584 +++++++++++++++++++++++++++++++++
 1 file changed, 584 insertions(+)
 create mode 100644 sound/soc/intel/skylake/hda-skl-pcm.c

diff --git a/sound/soc/intel/skylake/hda-skl-pcm.c b/sound/soc/intel/skylake/hda-skl-pcm.c
new file mode 100644
index 000000000000..e4d1650b49f5
--- /dev/null
+++ b/sound/soc/intel/skylake/hda-skl-pcm.c
@@ -0,0 +1,584 @@
+/*
+ *  hda-skl-pcm.c -ASoC HDA Platform driver file implementing PCM functionality
+ *
+ *  Copyright (C) 2014-2015 Intel Corp
+ *  Author:  Jeeja KP <jeeja.kp@intel.com>
+ *
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
+ *
+ */
+#include <linux/pci.h>
+#include <linux/pm_runtime.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include "hda-skl.h"
+
+#define HDA_MONO 1
+#define HDA_STEREO 2
+
+static struct snd_pcm_hardware azx_pcm_hw = {
+	.info =			(SNDRV_PCM_INFO_MMAP |
+				 SNDRV_PCM_INFO_INTERLEAVED |
+				 SNDRV_PCM_INFO_BLOCK_TRANSFER |
+				 SNDRV_PCM_INFO_MMAP_VALID |
+				 /* No full-resume yet implemented */
+				 /* SNDRV_PCM_INFO_RESUME |*/
+				 SNDRV_PCM_INFO_PAUSE |
+				 SNDRV_PCM_INFO_SYNC_START |
+				 SNDRV_PCM_INFO_HAS_WALL_CLOCK | /* legacy */
+				 SNDRV_PCM_INFO_HAS_LINK_ATIME |
+				 SNDRV_PCM_INFO_NO_PERIOD_WAKEUP),
+	.formats =		SNDRV_PCM_FMTBIT_S16_LE,
+	.rates =		SNDRV_PCM_RATE_48000,
+	.rate_min =		48000,
+	.rate_max =		48000,
+	.channels_min =		2,
+	.channels_max =		2,
+	.buffer_bytes_max =	AZX_MAX_BUF_SIZE,
+	.period_bytes_min =	128,
+	.period_bytes_max =	AZX_MAX_BUF_SIZE / 2,
+	.periods_min =		2,
+	.periods_max =		AZX_MAX_FRAG,
+	.fifo_size =		0,
+};
+
+static inline
+struct soc_hdac_stream *get_hdac_stream(struct snd_pcm_substream *substream)
+{
+	return substream->runtime->private_data;
+}
+
+static struct soc_hdac_bus *get_bus_ctx(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = snd_pcm_substream_chip(substream);
+	struct device *dev = rtd->cpu_dai->dev;
+	struct soc_hdac_bus *sbus = dev_get_drvdata(dev);
+
+	return sbus;
+}
+
+static int substream_alloc_pages(struct soc_hdac_bus *sbus,
+				 struct snd_pcm_substream *substream,
+				 size_t size)
+{
+	struct soc_hdac_stream *stream = get_hdac_stream(substream);
+	int ret;
+
+	hdac_stream(stream)->bufsize = 0;
+	hdac_stream(stream)->period_bytes = 0;
+	hdac_stream(stream)->format_val = 0;
+	ret = snd_pcm_lib_malloc_pages(substream, size);
+	if (ret < 0)
+		return ret;
+	return 0;
+}
+
+static int substream_free_pages(struct hdac_bus *bus,
+				struct snd_pcm_substream *substream)
+{
+	return snd_pcm_lib_free_pages(substream);
+}
+
+static void soc_hda_set_pcm_constrains(struct soc_hdac_bus *sbus,
+				 struct snd_pcm_runtime *runtime)
+{
+	snd_pcm_hw_constraint_integer(runtime, SNDRV_PCM_HW_PARAM_PERIODS);
+
+	/* avoid wrap-around with wall-clock */
+	snd_pcm_hw_constraint_minmax(runtime, SNDRV_PCM_HW_PARAM_BUFFER_TIME,
+				     20, 178000000);
+}
+
+static int soc_hda_pcm_open(struct snd_pcm_substream *substream,
+		struct snd_soc_dai *dai)
+{
+	struct soc_hdac_bus *sbus = dev_get_drvdata(dai->dev);
+	struct soc_hdac_stream *stream;
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct soc_hda_dma_params *dma_params;
+
+	dev_dbg(dai->dev, "%s: %s\n", __func__, dai->name);
+	pm_runtime_get_sync(dai->dev);
+
+	stream = snd_soc_hdac_stream_assign(sbus, substream,
+					HDAC_STREAM_TYPE_COUPLED);
+	if (stream == NULL)
+		return -EBUSY;
+
+	soc_hda_set_pcm_constrains(sbus, runtime);
+
+	/*
+	 * disable WALLCLOCK timestamps for capture streams
+	 * until we figure out how to handle digital inputs
+	 */
+	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE) {
+		runtime->hw.info &= ~SNDRV_PCM_INFO_HAS_WALL_CLOCK; /* legacy */
+		runtime->hw.info &= ~SNDRV_PCM_INFO_HAS_LINK_ATIME;
+	}
+
+	runtime->private_data = stream;
+
+	dma_params = kzalloc(sizeof(*dma_params), GFP_KERNEL);
+	if (!dma_params)
+		return -ENOMEM;
+
+	dma_params->stream_tag = hdac_stream(stream)->stream_tag;
+	snd_soc_dai_set_dma_data(dai, substream, (void *)dma_params);
+
+	dev_dbg(dai->dev, "stream tag set in dma params=%d\n",
+				 dma_params->stream_tag);
+	snd_pcm_set_sync(substream);
+
+	return 0;
+}
+
+static int hda_get_format(struct snd_pcm_substream *substream,
+		struct snd_soc_dai *dai)
+{
+	struct snd_soc_pcm_runtime *rtd = snd_pcm_substream_chip(substream);
+	struct soc_hda_dma_params *dma_params;
+	int format_val = 0;
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+
+	dma_params  = (struct soc_hda_dma_params *)
+			snd_soc_dai_get_dma_data(codec_dai, substream);
+
+	if (!dma_params)
+		format_val = dma_params->format;
+
+	return format_val;
+}
+
+static int soc_hda_pcm_prepare(struct snd_pcm_substream *substream,
+		struct snd_soc_dai *dai)
+{
+	struct soc_hdac_stream *stream = get_hdac_stream(substream);
+	unsigned int format_val;
+	int err;
+
+	dev_dbg(dai->dev, "%s: %s\n", __func__, dai->name);
+	if (hdac_stream(stream)->prepared) {
+		dev_dbg(dai->dev, "already stream is prepared - returning\n");
+		return 0;
+	}
+
+	format_val = hda_get_format(substream, dai);
+	dev_dbg(dai->dev, "stream_tag=%d formatvalue=%d\n",
+				hdac_stream(stream)->stream_tag, format_val);
+	snd_hdac_stream_reset(hdac_stream(stream));
+
+	err = snd_hdac_stream_set_params(hdac_stream(stream), format_val);
+
+	if (err < 0)
+		return err;
+
+	snd_hdac_stream_setup(hdac_stream(stream));
+	hdac_stream(stream)->prepared = 1;
+	return err;
+}
+
+static int soc_hda_pcm_hw_params(struct snd_pcm_substream *substream,
+				struct snd_pcm_hw_params *params,
+				struct snd_soc_dai *dai)
+{
+	struct soc_hdac_bus *sbus = dev_get_drvdata(dai->dev);
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	int ret = 0;
+
+	dev_dbg(dai->dev, "%s: %s\n", __func__, dai->name);
+	ret = substream_alloc_pages(sbus, substream,
+					  params_buffer_bytes(params));
+
+	if (ret < 0)
+		return ret;
+
+	if (substream->runtime->dma_area)
+		memset(substream->runtime->dma_area, 0,
+				params_buffer_bytes(params));
+
+	dev_dbg(dai->dev, "format_val, rate=%d, ch=%d, format=%d\n",
+			runtime->rate, runtime->channels, runtime->format);
+
+	return ret;
+}
+
+static void soc_hda_pcm_close(struct snd_pcm_substream *substream,
+		struct snd_soc_dai *dai)
+{
+	struct soc_hdac_stream *stream = get_hdac_stream(substream);
+	struct soc_hda_dma_params *dma_params = NULL;
+
+	dev_dbg(dai->dev, "%s: %s\n", __func__, dai->name);
+	snd_soc_hdac_stream_release(stream, HDAC_STREAM_TYPE_COUPLED);
+
+	dma_params  = (struct soc_hda_dma_params *)
+			snd_soc_dai_get_dma_data(dai, substream);
+	pm_runtime_mark_last_busy(dai->dev);
+	pm_runtime_put_autosuspend(dai->dev);
+	kfree(dma_params);
+}
+
+static int soc_hda_pcm_hw_free(struct snd_pcm_substream *substream,
+		struct snd_soc_dai *dai)
+{
+	struct soc_hdac_bus *sbus = dev_get_drvdata(dai->dev);
+	struct soc_hdac_stream *stream = get_hdac_stream(substream);
+
+	dev_dbg(dai->dev, "%s: %s\n", __func__, dai->name);
+
+	snd_hdac_stream_cleanup(hdac_stream(stream));
+	hdac_stream(stream)->prepared = 0;
+
+	return substream_free_pages(hdac_bus(sbus), substream);
+}
+
+static struct snd_soc_dai_ops hda_pcm_dai_ops = {
+	.startup = soc_hda_pcm_open,
+	.shutdown = soc_hda_pcm_close,
+	.prepare = soc_hda_pcm_prepare,
+	.hw_params = soc_hda_pcm_hw_params,
+	.hw_free = soc_hda_pcm_hw_free,
+};
+
+static struct snd_soc_dai_driver soc_hda_platform_dai[] = {
+{
+	.name = "System Pin",
+	.ops = &hda_pcm_dai_ops,
+	.playback = {
+		.stream_name = "System Playback",
+		.channels_min = HDA_MONO,
+		.channels_max = HDA_STEREO,
+		.rates = SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_16000 | SNDRV_PCM_RATE_8000,
+		.formats = SNDRV_PCM_FMTBIT_S16_LE,
+	},
+	.capture = {
+		.stream_name = "System Capture",
+		.channels_min = HDA_MONO,
+		.channels_max = HDA_STEREO,
+		.rates = SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_16000,
+		.formats = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S24_LE,
+	},
+},
+{
+	.name = "Deepbuffer Pin",
+	.ops = &hda_pcm_dai_ops,
+	.playback = {
+		.stream_name = "Deepbuffer Playback",
+		.channels_min = HDA_STEREO,
+		.channels_max = HDA_STEREO,
+		.rates = SNDRV_PCM_RATE_48000,
+		.formats = SNDRV_PCM_FMTBIT_S16_LE,
+	},
+},
+{
+	.name = "LowLatency Pin",
+	.ops = &hda_pcm_dai_ops,
+	.playback = {
+		.stream_name = "Low Latency Playback",
+		.channels_min = HDA_STEREO,
+		.channels_max = HDA_STEREO,
+		.rates = SNDRV_PCM_RATE_48000,
+		.formats = SNDRV_PCM_FMTBIT_S16_LE,
+	},
+},
+};
+
+static int soc_hda_platform_open(struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_runtime *runtime;
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai_link *dai_link = rtd->dai_link;
+
+	dev_dbg(rtd->cpu_dai->dev, "In %s:%s\n", __func__,
+					dai_link->cpu_dai_name);
+
+	runtime = substream->runtime;
+	snd_soc_set_runtime_hwparams(substream, &azx_pcm_hw);
+	return 0;
+}
+
+static int soc_hda_platform_pcm_trigger(struct snd_pcm_substream *substream,
+					int cmd)
+{
+	struct soc_hdac_bus *sbus = get_bus_ctx(substream);
+	struct hdac_bus *bus = hdac_bus(sbus);
+	struct soc_hdac_stream *stream;
+	struct snd_pcm_substream *s;
+	bool start;
+	int sbits = 0;
+	unsigned long cookie;
+	struct hdac_stream *hstr;
+
+	stream = get_hdac_stream(substream);
+	hstr = hdac_stream(stream);
+
+	dev_dbg(bus->dev, "In %s cmd=%d\n", __func__, cmd);
+
+	if (!hstr->prepared)
+		return -EPIPE;
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+	case SNDRV_PCM_TRIGGER_RESUME:
+		start = true;
+		break;
+
+	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+	case SNDRV_PCM_TRIGGER_STOP:
+		start = false;
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	snd_pcm_group_for_each_entry(s, substream) {
+		if (s->pcm->card != substream->pcm->card)
+			continue;
+		stream = get_hdac_stream(s);
+		sbits |= 1 << hdac_stream(stream)->index;
+		snd_pcm_trigger_done(s, substream);
+	}
+
+	spin_lock_irqsave(&bus->reg_lock, cookie);
+
+	/* first, set SYNC bits of corresponding streams */
+	snd_hdac_stream_sync_trigger(hstr, true, sbits, AZX_REG_SSYNC);
+
+	snd_pcm_group_for_each_entry(s, substream) {
+		if (s->pcm->card != substream->pcm->card)
+			continue;
+		stream = get_hdac_stream(s);
+		if (start)
+			snd_hdac_stream_start(hdac_stream(stream), true);
+		else
+			snd_hdac_stream_stop(hdac_stream(stream));
+	}
+	spin_unlock_irqrestore(&bus->reg_lock, cookie);
+
+	snd_hdac_stream_sync(hstr, start, sbits);
+
+	spin_lock_irqsave(&bus->reg_lock, cookie);
+
+	/* reset SYNC bits */
+	snd_hdac_stream_sync_trigger(hstr, false, sbits, AZX_REG_SSYNC);
+	if (start)
+		snd_hdac_stream_timecounter_init(hstr, sbits);
+	spin_unlock_irqrestore(&bus->reg_lock, cookie);
+	return 0;
+}
+
+/* calculate runtime delay from LPIB */
+static int hda_get_delay_from_lpib(struct soc_hdac_bus *sbus,
+				struct soc_hdac_stream *sstream,
+				unsigned int pos)
+{
+	struct hdac_bus *bus = hdac_bus(sbus);
+	struct hdac_stream *hstream = hdac_stream(sstream);
+	struct snd_pcm_substream *substream = hstream->substream;
+	int stream = substream->stream;
+	unsigned int lpib_pos = snd_hdac_stream_get_pos_lpib(hstream);
+	int delay;
+
+	if (stream == SNDRV_PCM_STREAM_PLAYBACK)
+		delay = pos - lpib_pos;
+	else
+		delay = lpib_pos - pos;
+	if (delay < 0) {
+		if (delay >= hstream->delay_negative_threshold)
+			delay = 0;
+		else
+			delay += hstream->bufsize;
+	}
+
+	if (delay >= hstream->period_bytes) {
+		dev_info(bus->dev,
+			 "Unstable LPIB (%d >= %d); disabling LPIB delay counting\n",
+			 delay, hstream->period_bytes);
+		delay = 0;
+	}
+
+	return bytes_to_frames(substream->runtime, delay);
+}
+
+static unsigned int hda_get_position(struct soc_hdac_stream *hstream,
+					int codec_delay)
+{
+	struct hdac_stream *hstr = hdac_stream(hstream);
+	struct snd_pcm_substream *substream = hstr->substream;
+	struct soc_hdac_bus *sbus = get_bus_ctx(substream);
+	unsigned int pos;
+	int delay = 0;
+
+	/* use the position buffer as default */
+	pos = snd_hdac_stream_get_pos_posbuf(hdac_stream(hstream));
+
+	if (pos >= hdac_stream(hstream)->bufsize)
+		pos = 0;
+
+	if (substream->runtime) {
+		delay = hda_get_delay_from_lpib(sbus, hstream, pos)
+						 + codec_delay;
+		substream->runtime->delay += delay;
+	}
+
+	return pos;
+}
+
+static snd_pcm_uframes_t soc_hda_platform_pcm_pointer
+			(struct snd_pcm_substream *substream)
+{
+	struct soc_hdac_stream *hstream = get_hdac_stream(substream);
+
+	return bytes_to_frames(substream->runtime,
+			       hda_get_position(hstream, 0));
+}
+
+static u64 soc_azx_adjust_codec_delay(struct snd_pcm_substream *substream,
+				u64 nsec)
+{
+	struct snd_soc_pcm_runtime *rtd = snd_pcm_substream_chip(substream);
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+	u64 codec_frames, codec_nsecs;
+
+	if (!codec_dai->driver->ops->delay)
+		return nsec;
+
+	codec_frames = codec_dai->driver->ops->delay(substream, codec_dai);
+	codec_nsecs = div_u64(codec_frames * 1000000000LL,
+			      substream->runtime->rate);
+
+	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE)
+		return nsec + codec_nsecs;
+
+	return (nsec > codec_nsecs) ? nsec - codec_nsecs : 0;
+}
+
+static int soc_hda_get_time_info(struct snd_pcm_substream *substream,
+			struct timespec *system_ts, struct timespec *audio_ts,
+			struct snd_pcm_audio_tstamp_config *audio_tstamp_config,
+			struct snd_pcm_audio_tstamp_report *audio_tstamp_report)
+{
+	struct soc_hdac_stream *sstream = get_hdac_stream(substream);
+	struct hdac_stream *hstr = hdac_stream(sstream);
+	u64 nsec;
+
+	if ((substream->runtime->hw.info & SNDRV_PCM_INFO_HAS_LINK_ATIME) &&
+		(audio_tstamp_config->type_requested == SNDRV_PCM_AUDIO_TSTAMP_TYPE_LINK)) {
+
+		snd_pcm_gettime(substream->runtime, system_ts);
+
+		nsec = timecounter_read(&hstr->tc);
+		nsec = div_u64(nsec, 3); /* can be optimized */
+		if (audio_tstamp_config->report_delay)
+			nsec = soc_azx_adjust_codec_delay(substream, nsec);
+
+		*audio_ts = ns_to_timespec(nsec);
+
+		audio_tstamp_report->actual_type = SNDRV_PCM_AUDIO_TSTAMP_TYPE_LINK;
+		audio_tstamp_report->accuracy_report = 1; /* rest of struct is valid */
+		audio_tstamp_report->accuracy = 42; /* 24MHzWallClk == 42ns resolution */
+
+	} else
+		audio_tstamp_report->actual_type = SNDRV_PCM_AUDIO_TSTAMP_TYPE_DEFAULT;
+
+	return 0;
+}
+
+static struct snd_pcm_ops soc_hda_platform_ops = {
+	.open = soc_hda_platform_open,
+	.ioctl = snd_pcm_lib_ioctl,
+	.trigger = soc_hda_platform_pcm_trigger,
+	.pointer = soc_hda_platform_pcm_pointer,
+	.get_time_info =  soc_hda_get_time_info,
+	.mmap = snd_pcm_lib_default_mmap,
+	.page = snd_pcm_sgbuf_ops_page,
+};
+
+static void soc_hda_pcm_free(struct snd_pcm *pcm)
+{
+	snd_pcm_lib_preallocate_free_for_all(pcm);
+}
+
+#define MAX_PREALLOC_SIZE	(32 * 1024 * 1024)
+
+static int soc_hda_pcm_new(struct snd_soc_pcm_runtime *rtd)
+{
+	struct snd_soc_dai *dai = rtd->cpu_dai;
+	struct soc_hdac_bus *sbus = dev_get_drvdata(dai->dev);
+	struct snd_pcm *pcm = rtd->pcm;
+	unsigned int size;
+	int retval = 0;
+	struct hda_skl *hda = to_hda_skl(sbus);
+
+	dev_dbg(dai->dev, "In %s\n", __func__);
+	if (dai->driver->playback.channels_min ||
+		dai->driver->capture.channels_min) {
+		/* buffer pre-allocation */
+		size = CONFIG_SND_SOC_HDA_PREALLOC_SIZE * 1024;
+		if (size > MAX_PREALLOC_SIZE)
+			size = MAX_PREALLOC_SIZE;
+		retval = snd_pcm_lib_preallocate_pages_for_all(pcm,
+						SNDRV_DMA_TYPE_DEV_SG,
+						snd_dma_pci_data(hda->pci),
+						size, MAX_PREALLOC_SIZE);
+		if (retval) {
+			dev_err(dai->dev, "dma buffer allocationf fail\n");
+			return retval;
+		}
+	}
+	return retval;
+}
+
+static struct snd_soc_platform_driver soc_hda_platform_drv  = {
+	.ops		= &soc_hda_platform_ops,
+	.pcm_new	= soc_hda_pcm_new,
+	.pcm_free	= soc_hda_pcm_free,
+};
+
+static const struct snd_soc_component_driver soc_hda_component = {
+	.name           = "pcm",
+};
+
+int soc_hda_platform_register(struct device *dev)
+{
+	int ret = 0;
+
+	ret = snd_soc_register_platform(dev, &soc_hda_platform_drv);
+	if (ret) {
+		dev_err(dev, "soc platform registration failed %d\n", ret);
+		return ret;
+	}
+	ret = snd_soc_register_component(dev, &soc_hda_component,
+				soc_hda_platform_dai,
+				ARRAY_SIZE(soc_hda_platform_dai));
+	if (ret) {
+		dev_err(dev, "soc component registration failed %d\n", ret);
+		snd_soc_unregister_platform(dev);
+	}
+
+	return ret;
+
+}
+
+int soc_hda_platform_unregister(struct device *dev)
+{
+	snd_soc_unregister_component(dev);
+	snd_soc_unregister_platform(dev);
+	return 0;
+}
-- 
1.7.9.5
