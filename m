From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: [PATCH] ASoC: Intel: Fix stream position pointer.
Date: Fri,  2 May 2014 16:56:33 +0100
Message-ID: <1399046194-5544-7-git-send-email-liam.r.girdwood@linux.intel.com>
References: <1399046194-5544-1-git-send-email-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id ABB17261718
 for <alsa-devel@alsa-project.org>; Fri,  2 May 2014 17:56:58 +0200 (CEST)
In-Reply-To: <1399046194-5544-1-git-send-email-liam.r.girdwood@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Read the stream offset and presentation position from DSP memory rather
than using the old estimated position. This fixes timing issues with
pulseaudio.

Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
---
 sound/soc/intel/sst-haswell-ipc.c | 22 ++++++++++++++++++++--
 sound/soc/intel/sst-haswell-ipc.h |  4 +++-
 sound/soc/intel/sst-haswell-pcm.c | 10 ++++++----
 3 files changed, 29 insertions(+), 7 deletions(-)

diff --git a/sound/soc/intel/sst-haswell-ipc.c b/sound/soc/intel/sst-haswell-ipc.c
index 5bcf596..e7996b3 100644
--- a/sound/soc/intel/sst-haswell-ipc.c
+++ b/sound/soc/intel/sst-haswell-ipc.c
@@ -1547,10 +1547,28 @@ int sst_hsw_stream_reset(struct sst_hsw *hsw, struct sst_hsw_stream *stream)
 }
 
 /* Stream pointer positions */
-int sst_hsw_get_dsp_position(struct sst_hsw *hsw,
+u32 sst_hsw_get_dsp_position(struct sst_hsw *hsw,
 	struct sst_hsw_stream *stream)
 {
-	return stream->rpos.position;
+	u32 rpos;
+
+	sst_dsp_read(hsw->dsp, &rpos,
+		stream->reply.read_position_register_address, sizeof(rpos));
+
+	return rpos;
+}
+
+/* Stream presentation (monotonic) positions */
+u64 sst_hsw_get_dsp_presentation_position(struct sst_hsw *hsw,
+	struct sst_hsw_stream *stream)
+{
+	u64 ppos;
+
+	sst_dsp_read(hsw->dsp, &ppos,
+		stream->reply.presentation_position_register_address,
+		sizeof(ppos));
+
+	return ppos;
 }
 
 int sst_hsw_stream_set_write_position(struct sst_hsw *hsw,
diff --git a/sound/soc/intel/sst-haswell-ipc.h b/sound/soc/intel/sst-haswell-ipc.h
index d517929..2ac194a 100644
--- a/sound/soc/intel/sst-haswell-ipc.h
+++ b/sound/soc/intel/sst-haswell-ipc.h
@@ -464,7 +464,9 @@ int sst_hsw_stream_get_write_pos(struct sst_hsw *hsw,
 	struct sst_hsw_stream *stream, u32 *position);
 int sst_hsw_stream_set_write_position(struct sst_hsw *hsw,
 	struct sst_hsw_stream *stream, u32 stage_id, u32 position);
-int sst_hsw_get_dsp_position(struct sst_hsw *hsw,
+u32 sst_hsw_get_dsp_position(struct sst_hsw *hsw,
+	struct sst_hsw_stream *stream);
+u64 sst_hsw_get_dsp_presentation_position(struct sst_hsw *hsw,
 	struct sst_hsw_stream *stream);
 
 /* HW port config */
diff --git a/sound/soc/intel/sst-haswell-pcm.c b/sound/soc/intel/sst-haswell-pcm.c
index 50fea07..8c6bd33 100644
--- a/sound/soc/intel/sst-haswell-pcm.c
+++ b/sound/soc/intel/sst-haswell-pcm.c
@@ -569,12 +569,14 @@ static snd_pcm_uframes_t hsw_pcm_pointer(struct snd_pcm_substream *substream)
 	struct hsw_pcm_data *pcm_data = snd_soc_pcm_get_drvdata(rtd);
 	struct sst_hsw *hsw = pdata->hsw;
 	snd_pcm_uframes_t offset;
+	uint64_t ppos;
+	u32 position = sst_hsw_get_dsp_position(hsw, pcm_data->stream);
 
-	offset = bytes_to_frames(runtime,
-		sst_hsw_get_dsp_position(hsw, pcm_data->stream));
+	offset = bytes_to_frames(runtime, position);
+	ppos = sst_hsw_get_dsp_presentation_position(hsw, pcm_data->stream);
 
-	dev_dbg(rtd->dev, "PCM: DMA pointer %zu bytes\n",
-		frames_to_bytes(runtime, (u32)offset));
+	dev_dbg(rtd->dev, "PCM: DMA pointer %du bytes, pos %llu\n",
+		position, ppos);
 	return offset;
 }
 
-- 
1.9.1
