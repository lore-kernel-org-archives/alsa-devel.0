From: libin.yang@intel.com
Subject: [PATCH] ASoC: Intel: Clean data after SST fw fetch
Date: Sun,  4 Jan 2015 09:25:20 +0800
Message-ID: <1420334720-8112-1-git-send-email-libin.yang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id B68C226058E
 for <alsa-devel@alsa-project.org>; Sun,  4 Jan 2015 02:30:15 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, alsa-devel@alsa-project.org
Cc: libin.yang@intel.com, liam.r.girdwood@linux.intel.com
List-Id: alsa-devel@alsa-project.org

From: Libin Yang <libin.yang@intel.com>

The BDW audio firmware DSP manages the DMA and the DMA cannot be
stopped exactly at the end of the playback stream. This means
stale samples may be played at PCM stop unless the driver copies
silence to the subsequent periods.

Signed-off-by: Libin Yang <libin.yang@intel.com>
Reviewed-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
---
 sound/soc/intel/sst-haswell-ipc.c | 29 ++++++++++++++++++
 sound/soc/intel/sst-haswell-ipc.h |  9 ++++++
 sound/soc/intel/sst-haswell-pcm.c | 64 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 102 insertions(+)

diff --git a/sound/soc/intel/sst-haswell-ipc.c b/sound/soc/intel/sst-haswell-ipc.c
index 3f8c482..57d6e89 100644
--- a/sound/soc/intel/sst-haswell-ipc.c
+++ b/sound/soc/intel/sst-haswell-ipc.c
@@ -31,6 +31,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/debugfs.h>
 #include <linux/pm_runtime.h>
+#include <sound/asound.h>
 
 #include "sst-haswell-ipc.h"
 #include "sst-dsp.h"
@@ -240,6 +241,10 @@ struct sst_hsw_stream {
 	u32 (*notify_position)(struct sst_hsw_stream *stream, void *data);
 	void *pdata;
 
+	/* record the fw read position when playback */
+	snd_pcm_uframes_t old_position;
+	bool play_silence;
+
 	struct list_head node;
 };
 
@@ -1476,6 +1481,30 @@ u32 sst_hsw_stream_get_vol_reg(struct sst_hsw *hsw,
 	return stream->reply.volume_register_address[channel];
 }
 
+snd_pcm_uframes_t sst_hsw_stream_get_old_position(struct sst_hsw *hsw,
+	struct sst_hsw_stream *stream)
+{
+	return stream->old_position;
+}
+
+void sst_hsw_stream_set_old_position(struct sst_hsw *hsw,
+	struct sst_hsw_stream *stream, snd_pcm_uframes_t val)
+{
+	stream->old_position = val;
+}
+
+bool sst_hsw_stream_get_silence_start(struct sst_hsw *hsw,
+	struct sst_hsw_stream *stream)
+{
+	return stream->play_silence;
+}
+
+void sst_hsw_stream_set_silence_start(struct sst_hsw *hsw,
+	struct sst_hsw_stream *stream, bool val)
+{
+	stream->play_silence = val;
+}
+
 int sst_hsw_mixer_get_info(struct sst_hsw *hsw)
 {
 	struct sst_hsw_ipc_stream_info_reply *reply;
diff --git a/sound/soc/intel/sst-haswell-ipc.h b/sound/soc/intel/sst-haswell-ipc.h
index 138e894..5c72e49 100644
--- a/sound/soc/intel/sst-haswell-ipc.h
+++ b/sound/soc/intel/sst-haswell-ipc.h
@@ -20,6 +20,7 @@
 #include <linux/types.h>
 #include <linux/kernel.h>
 #include <linux/platform_device.h>
+#include <sound/asound.h>
 
 #define SST_HSW_NO_CHANNELS		4
 #define SST_HSW_MAX_DX_REGIONS		14
@@ -452,6 +453,14 @@ u32 sst_hsw_stream_get_peak_reg(struct sst_hsw *hsw,
 	struct sst_hsw_stream *stream, u32 channel);
 u32 sst_hsw_stream_get_vol_reg(struct sst_hsw *hsw,
 	struct sst_hsw_stream *stream, u32 channel);
+snd_pcm_uframes_t sst_hsw_stream_get_old_position(struct sst_hsw *hsw,
+	struct sst_hsw_stream *stream);
+void sst_hsw_stream_set_old_position(struct sst_hsw *hsw,
+	struct sst_hsw_stream *stream, snd_pcm_uframes_t val);
+bool sst_hsw_stream_get_silence_start(struct sst_hsw *hsw,
+	struct sst_hsw_stream *stream);
+void sst_hsw_stream_set_silence_start(struct sst_hsw *hsw,
+	struct sst_hsw_stream *stream, bool val);
 int sst_hsw_mixer_get_info(struct sst_hsw *hsw);
 
 /* Stream ALSA trigger operations */
diff --git a/sound/soc/intel/sst-haswell-pcm.c b/sound/soc/intel/sst-haswell-pcm.c
index 6195252..4b70bdf 100644
--- a/sound/soc/intel/sst-haswell-pcm.c
+++ b/sound/soc/intel/sst-haswell-pcm.c
@@ -36,6 +36,11 @@
 #define HSW_PCM_COUNT		6
 #define HSW_VOLUME_MAX		0x7FFFFFFF	/* 0dB */
 
+#define SST_OLD_POSITION(d, r, o) ((d) +	\
+			frames_to_bytes(r, o))
+#define SST_SAMPLES(r, x) (bytes_to_samples(r,	\
+			frames_to_bytes(r, (x))))
+
 /* simple volume table */
 static const u32 volume_map[] = {
 	HSW_VOLUME_MAX >> 30,
@@ -553,19 +558,29 @@ static int hsw_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 	struct hsw_priv_data *pdata =
 		snd_soc_platform_get_drvdata(rtd->platform);
 	struct hsw_pcm_data *pcm_data = snd_soc_pcm_get_drvdata(rtd);
+	struct sst_hsw_stream *sst_stream = pcm_data->stream;
 	struct sst_hsw *hsw = pdata->hsw;
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	snd_pcm_uframes_t pos;
 
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
 	case SNDRV_PCM_TRIGGER_RESUME:
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+		sst_hsw_stream_set_silence_start(hsw, sst_stream, false);
 		sst_hsw_stream_resume(hsw, pcm_data->stream, 0);
 		break;
 	case SNDRV_PCM_TRIGGER_STOP:
 	case SNDRV_PCM_TRIGGER_SUSPEND:
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+		sst_hsw_stream_set_silence_start(hsw, sst_stream, false);
 		sst_hsw_stream_pause(hsw, pcm_data->stream, 0);
 		break;
+	case SNDRV_PCM_TRIGGER_DRAIN:
+		pos = runtime->control->appl_ptr % runtime->buffer_size;
+		sst_hsw_stream_set_old_position(hsw, pcm_data->stream, pos);
+		sst_hsw_stream_set_silence_start(hsw, sst_stream, true);
+		break;
 	default:
 		break;
 	}
@@ -579,13 +594,62 @@ static u32 hsw_notify_pointer(struct sst_hsw_stream *stream, void *data)
 	struct snd_pcm_substream *substream = pcm_data->substream;
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct hsw_priv_data *pdata =
+		snd_soc_platform_get_drvdata(rtd->platform);
+	struct sst_hsw *hsw = pdata->hsw;
 	u32 pos;
+	snd_pcm_uframes_t position = bytes_to_frames(runtime,
+		 sst_hsw_get_dsp_position(hsw, pcm_data->stream));
+	unsigned char *dma_area = runtime->dma_area;
+	snd_pcm_uframes_t dma_frames =
+		bytes_to_frames(runtime, runtime->dma_bytes);
+	snd_pcm_uframes_t old_position;
+	ssize_t samples;
 
 	pos = frames_to_bytes(runtime,
 		(runtime->control->appl_ptr % runtime->buffer_size));
 
 	dev_vdbg(rtd->dev, "PCM: App pointer %d bytes\n", pos);
 
+	/* SST fw don't know where to stop dma
+	 * So, SST driver need to clean the data which has been consumed
+	 */
+	if (dma_area == NULL || dma_frames <= 0
+		|| (substream->stream == SNDRV_PCM_STREAM_CAPTURE)
+		|| !sst_hsw_stream_get_silence_start(hsw, stream)) {
+		snd_pcm_period_elapsed(substream);
+		return pos;
+	}
+
+	old_position = sst_hsw_stream_get_old_position(hsw, stream);
+	if (position > old_position) {
+		if (position < dma_frames) {
+			samples = SST_SAMPLES(runtime, position - old_position);
+			snd_pcm_format_set_silence(runtime->format,
+				SST_OLD_POSITION(dma_area,
+					runtime, old_position),
+				samples);
+		} else
+			dev_err(rtd->dev, "PCM: position is wrong\n");
+	} else {
+		if (old_position < dma_frames) {
+			samples = SST_SAMPLES(runtime,
+				dma_frames - old_position);
+			snd_pcm_format_set_silence(runtime->format,
+				SST_OLD_POSITION(dma_area,
+					runtime, old_position),
+				samples);
+		} else
+			dev_err(rtd->dev, "PCM: dma_bytes is wrong\n");
+		if (position < dma_frames) {
+			samples = SST_SAMPLES(runtime, position);
+			snd_pcm_format_set_silence(runtime->format,
+				dma_area, samples);
+		} else
+			dev_err(rtd->dev, "PCM: position is wrong\n");
+	}
+	sst_hsw_stream_set_old_position(hsw, stream, position);
+
 	/* let alsa know we have play a period */
 	snd_pcm_period_elapsed(substream);
 	return pos;
-- 
1.9.1
