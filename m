From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH 1/7] ASoC: Intel: Sample Baytrail DSP DMA
	pointer only after each period
Date: Thu,  8 May 2014 16:07:21 +0300
Message-ID: <1399554447-16297-2-git-send-email-jarkko.nikula@linux.intel.com>
References: <1399554447-16297-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 2FCA326167E
 for <alsa-devel@alsa-project.org>; Thu,  8 May 2014 15:08:24 +0200 (CEST)
In-Reply-To: <1399554447-16297-1-git-send-email-jarkko.nikula@linux.intel.com>
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
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

This is for preparing suspend/resume support but can give also more
safeguard against concurrent timestamp structure access between DSP firmware
and host.

Now DSP DMA pointer is sampled in each pcm pointer callback in
sst_byt_pcm_pointer() but that is unneeded since DSP updates the timestamp
period basis and can potentially be racy if sst_byt_pcm_pointer() is called
when DSP is updating the timestamp.

By taking DSP DMA pointer only after period elapsed IPC messages in
byt_notify_pointer() and returning stored hw pointer in
sst_byt_pcm_pointer() there is less risk for concurrent access.

The same stored hw pointer can be also used in suspend/resume code for
restarting the stream at the same position.

Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
 sound/soc/intel/sst-baytrail-pcm.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/sound/soc/intel/sst-baytrail-pcm.c b/sound/soc/intel/sst-baytrail-pcm.c
index 6d101f3813b4..b8a89e9f753d 100644
--- a/sound/soc/intel/sst-baytrail-pcm.c
+++ b/sound/soc/intel/sst-baytrail-pcm.c
@@ -45,6 +45,9 @@ struct sst_byt_pcm_data {
 	struct sst_byt_stream *stream;
 	struct snd_pcm_substream *substream;
 	struct mutex mutex;
+
+	/* latest DSP DMA hw pointer */
+	u32 hw_ptr;
 };
 
 /* private data for the driver */
@@ -168,13 +171,19 @@ static u32 byt_notify_pointer(struct sst_byt_stream *stream, void *data)
 	struct snd_pcm_substream *substream = pcm_data->substream;
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	u32 pos;
+	struct sst_byt_priv_data *pdata =
+		snd_soc_platform_get_drvdata(rtd->platform);
+	struct sst_byt *byt = pdata->byt;
+	u32 pos, hw_pos;
 
+	hw_pos = sst_byt_get_dsp_position(byt, pcm_data->stream,
+					  snd_pcm_lib_buffer_bytes(substream));
+	pcm_data->hw_ptr = hw_pos;
 	pos = frames_to_bytes(runtime,
 			      (runtime->control->appl_ptr %
 			       runtime->buffer_size));
 
-	dev_dbg(rtd->dev, "PCM: App pointer %d bytes\n", pos);
+	dev_dbg(rtd->dev, "PCM: App/DMA pointer %u/%u bytes\n", pos, hw_pos);
 
 	snd_pcm_period_elapsed(substream);
 	return pos;
@@ -184,20 +193,11 @@ static snd_pcm_uframes_t sst_byt_pcm_pointer(struct snd_pcm_substream *substream
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_pcm_runtime *runtime = substream->runtime;
-	struct sst_byt_priv_data *pdata =
-		snd_soc_platform_get_drvdata(rtd->platform);
 	struct sst_byt_pcm_data *pcm_data = snd_soc_pcm_get_drvdata(rtd);
-	struct sst_byt *byt = pdata->byt;
-	snd_pcm_uframes_t offset;
-	int pos;
 
-	pos = sst_byt_get_dsp_position(byt, pcm_data->stream,
-				       snd_pcm_lib_buffer_bytes(substream));
-	offset = bytes_to_frames(runtime, pos);
+	dev_dbg(rtd->dev, "PCM: DMA pointer %u bytes\n", pcm_data->hw_ptr);
 
-	dev_dbg(rtd->dev, "PCM: DMA pointer %zu bytes\n",
-		frames_to_bytes(runtime, (u32)offset));
-	return offset;
+	return bytes_to_frames(runtime, pcm_data->hw_ptr);
 }
 
 static int sst_byt_pcm_open(struct snd_pcm_substream *substream)
-- 
2.0.0.rc0
