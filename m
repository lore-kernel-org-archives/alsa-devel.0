From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: [PATCH] ASoC: Intel: Fix allow hw_params to be called
	more than once.
Date: Fri,  2 May 2014 16:56:32 +0100
Message-ID: <1399046194-5544-6-git-send-email-liam.r.girdwood@linux.intel.com>
References: <1399046194-5544-1-git-send-email-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id A7AAE261740
 for <alsa-devel@alsa-project.org>; Fri,  2 May 2014 17:56:57 +0200 (CEST)
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

hw_params() can be called multiple times. Make sure we release the DSP
stream that was allocated on previous hw_params() calls before allocating
a new DSP stream.

Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
---
 sound/soc/intel/sst-haswell-pcm.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/sound/soc/intel/sst-haswell-pcm.c b/sound/soc/intel/sst-haswell-pcm.c
index ba585a7..50fea07 100644
--- a/sound/soc/intel/sst-haswell-pcm.c
+++ b/sound/soc/intel/sst-haswell-pcm.c
@@ -99,6 +99,7 @@ struct hsw_pcm_data {
 	struct snd_compr_stream *cstream;
 	unsigned int wpos;
 	struct mutex mutex;
+	bool allocated;
 };
 
 /* private data for the driver */
@@ -113,6 +114,8 @@ struct hsw_priv_data {
 	struct hsw_pcm_data pcm[HSW_PCM_COUNT];
 };
 
+static u32 hsw_notify_pointer(struct sst_hsw_stream *stream, void *data);
+
 static inline u32 hsw_mixer_to_ipc(unsigned int value)
 {
 	if (value >= ARRAY_SIZE(volume_map))
@@ -322,6 +325,29 @@ static int hsw_pcm_hw_params(struct snd_pcm_substream *substream,
 	u8 channels;
 	int ret;
 
+	/* check if we are being called a subsequent time */
+	if (pcm_data->allocated) {
+		ret = sst_hsw_stream_reset(hsw, pcm_data->stream);
+		if (ret < 0)
+			dev_dbg(rtd->dev, "error: reset stream failed %d\n",
+				ret);
+
+		ret = sst_hsw_stream_free(hsw, pcm_data->stream);
+		if (ret < 0) {
+			dev_dbg(rtd->dev, "error: free stream failed %d\n",
+				ret);
+			return ret;
+		}
+		pcm_data->allocated = false;
+
+		pcm_data->stream = sst_hsw_stream_new(hsw, rtd->cpu_dai->id,
+			hsw_notify_pointer, pcm_data);
+		if (pcm_data->stream == NULL) {
+			dev_err(rtd->dev, "error: failed to create stream\n");
+			return -EINVAL;
+		}
+	}
+
 	/* stream direction */
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
 		path_id = SST_HSW_STREAM_PATH_SSP0_OUT;
@@ -475,6 +501,7 @@ static int hsw_pcm_hw_params(struct snd_pcm_substream *substream,
 		dev_err(rtd->dev, "error: failed to commit stream %d\n", ret);
 		return ret;
 	}
+	pcm_data->allocated = true;
 
 	ret = sst_hsw_stream_pause(hsw, pcm_data->stream, 1);
 	if (ret < 0)
@@ -607,6 +634,7 @@ static int hsw_pcm_close(struct snd_pcm_substream *substream)
 		dev_dbg(rtd->dev, "error: free stream failed %d\n", ret);
 		goto out;
 	}
+	pcm_data->allocated = 0;
 	pcm_data->stream = NULL;
 
 out:
-- 
1.9.1
