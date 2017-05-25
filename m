From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 10/14] ALSA: pcm: Simplify
	snd_pcm_playback_silence()
Date: Thu, 25 May 2017 21:17:31 +0200
Message-ID: <20170525191735.13787-11-tiwai@suse.de>
References: <20170525191735.13787-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 9FDD7266D71
 for <alsa-devel@alsa-project.org>; Thu, 25 May 2017 21:17:41 +0200 (CEST)
In-Reply-To: <20170525191735.13787-1-tiwai@suse.de>
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
Cc: Takashi Sakamoto <o-takashi@sakamocchi.jp>
List-Id: alsa-devel@alsa-project.org

Use the existing silence helper codes for simplification.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/pcm_lib.c | 40 +++++++++++++---------------------------
 1 file changed, 13 insertions(+), 27 deletions(-)

diff --git a/sound/core/pcm_lib.c b/sound/core/pcm_lib.c
index c24a78e39b88..094447ae8486 100644
--- a/sound/core/pcm_lib.c
+++ b/sound/core/pcm_lib.c
@@ -42,6 +42,9 @@
 #define trace_hw_ptr_error(substream, reason)
 #endif
 
+static int fill_silence(struct snd_pcm_substream *substream, int channel,
+			unsigned long hwoff, void *buf, unsigned long bytes);
+
 /*
  * fill ring buffer with silence
  * runtime->silence_start: starting pointer to silence area
@@ -55,8 +58,7 @@ void snd_pcm_playback_silence(struct snd_pcm_substream *substream, snd_pcm_ufram
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	snd_pcm_uframes_t frames, ofs, transfer;
-	char *hwbuf;
-	int err;
+	int c;
 
 	if (runtime->silence_size < runtime->boundary) {
 		snd_pcm_sframes_t noise_dist, n;
@@ -111,33 +113,17 @@ void snd_pcm_playback_silence(struct snd_pcm_substream *substream, snd_pcm_ufram
 		transfer = ofs + frames > runtime->buffer_size ? runtime->buffer_size - ofs : frames;
 		if (runtime->access == SNDRV_PCM_ACCESS_RW_INTERLEAVED ||
 		    runtime->access == SNDRV_PCM_ACCESS_MMAP_INTERLEAVED) {
-			if (substream->ops->fill_silence) {
-				err = substream->ops->fill_silence(substream, 0,
-								   frames_to_bytes(runtime, ofs),
-								   frames_to_bytes(runtime, transfer));
-				snd_BUG_ON(err < 0);
-			} else {
-				hwbuf = runtime->dma_area + frames_to_bytes(runtime, ofs);
-				snd_pcm_format_set_silence(runtime->format, hwbuf, transfer * runtime->channels);
-			}
+			fill_silence(substream, 0,
+				     frames_to_bytes(runtime, ofs), NULL,
+				     frames_to_bytes(runtime, transfer));
 		} else {
-			unsigned int c;
-			unsigned int channels = runtime->channels;
-			if (substream->ops->fill_silence) {
-				for (c = 0; c < channels; ++c) {
-					err = substream->ops->fill_silence(substream, c,
-									   samples_to_bytes(runtime, ofs),
-									   samples_to_bytes(runtime, transfer));
-					snd_BUG_ON(err < 0);
-				}
-			} else {
-				size_t dma_csize = runtime->dma_bytes / channels;
-				for (c = 0; c < channels; ++c) {
-					hwbuf = runtime->dma_area + (c * dma_csize) + samples_to_bytes(runtime, ofs);
-					snd_pcm_format_set_silence(runtime->format, hwbuf, transfer);
-				}
-			}
+			int byte_ofs = samples_to_bytes(runtime, ofs);
+			int byte_xfer = samples_to_bytes(runtime, transfer);
+			for (c = 0; c < runtime->channels; ++c)
+				fill_silence(substream, c, byte_ofs, NULL,
+					     byte_xfer);
 		}
+
 		runtime->silence_filled += transfer;
 		frames -= transfer;
 		ofs = 0;
-- 
2.13.0
