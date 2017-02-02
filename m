From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 28/53] ALSA: x86: Remove indirect call of
	snd_pcm_period_elapsed()
Date: Thu,  2 Feb 2017 18:02:42 +0100
Message-ID: <20170202170307.24484-30-tiwai@suse.de>
References: <20170202170307.24484-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id B44C6266912
 for <alsa-devel@alsa-project.org>; Thu,  2 Feb 2017 18:03:16 +0100 (CET)
In-Reply-To: <20170202170307.24484-1-tiwai@suse.de>
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
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Jerome Anand <jerome.anand@intel.com>
List-Id: alsa-devel@alsa-project.org

Again another indirect call...  Let's straighten it up.
Also define the had_stream field with a proper type instead of a void
pointer.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/x86/intel_hdmi_audio.c | 15 ++++++---------
 sound/x86/intel_hdmi_audio.h |  3 +--
 2 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/sound/x86/intel_hdmi_audio.c b/sound/x86/intel_hdmi_audio.c
index fbfbf5e2b5ad..8b25687601ac 100644
--- a/sound/x86/intel_hdmi_audio.c
+++ b/sound/x86/intel_hdmi_audio.c
@@ -1028,14 +1028,12 @@ static int snd_intelhad_open(struct snd_pcm_substream *substream)
 	return retval;
 }
 
-/**
+/*
  * had_period_elapsed - updates the hardware pointer status
- * @had_substream:substream for which the stream function is called
- *
+ * @had_substream: substream for which the stream function is called
  */
-static void had_period_elapsed(void *had_substream)
+static void had_period_elapsed(struct snd_pcm_substream *substream)
 {
-	struct snd_pcm_substream *substream = had_substream;
 	struct had_stream_pvt *stream;
 
 	if (!substream || !substream->runtime)
@@ -1058,7 +1056,6 @@ static int snd_intelhad_init_stream(struct snd_pcm_substream *substream)
 {
 	struct snd_intelhad *intelhaddata = snd_pcm_substream_chip(substream);
 
-	intelhaddata->stream_info.period_elapsed = had_period_elapsed;
 	intelhaddata->stream_info.had_substream = substream;
 	intelhaddata->stream_info.buffer_ptr = 0;
 	intelhaddata->stream_info.buffer_rendered = 0;
@@ -1648,11 +1645,11 @@ static int had_process_buffer_done(struct snd_intelhad *intelhaddata)
 	/* In case of actual data,
 	 * report buffer_done to above ALSA layer
 	 */
-	buf_size =  intelhaddata->buf_info[buf_id].buf_size;
+	buf_size = intelhaddata->buf_info[buf_id].buf_size;
 	if (stream_type >= HAD_RUNNING_STREAM) {
 		intelhaddata->stream_info.buffer_rendered +=
 			(intr_count * buf_size);
-		stream->period_elapsed(stream->had_substream);
+		had_period_elapsed(stream->had_substream);
 	}
 
 	return 0;
@@ -1694,7 +1691,7 @@ static int had_process_buffer_underrun(struct snd_intelhad *intelhaddata)
 	if (stream_type == HAD_RUNNING_STREAM) {
 		/* Report UNDERRUN error to above layers */
 		intelhaddata->flag_underrun = 1;
-		stream->period_elapsed(stream->had_substream);
+		had_period_elapsed(stream->had_substream);
 	}
 
 	return 0;
diff --git a/sound/x86/intel_hdmi_audio.h b/sound/x86/intel_hdmi_audio.h
index d301c3021375..bcbb4b262fff 100644
--- a/sound/x86/intel_hdmi_audio.h
+++ b/sound/x86/intel_hdmi_audio.h
@@ -75,8 +75,7 @@ struct platform_device;
 
 struct pcm_stream_info {
 	int		str_id;
-	void	*had_substream;
-	void	(*period_elapsed)(void *had_substream);
+	struct snd_pcm_substream	*had_substream;
 	u32		buffer_ptr;
 	u64		buffer_rendered;
 	u32		ring_buf_size;
-- 
2.11.0
