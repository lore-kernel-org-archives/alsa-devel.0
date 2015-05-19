From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda - Fix NULL dereference from CA0132
	DSP loader
Date: Tue, 19 May 2015 11:37:58 +0200
Message-ID: <1432028278-4403-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 5728A265347
 for <alsa-devel@alsa-project.org>; Tue, 19 May 2015 11:38:01 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 062E6AD08
 for <alsa-devel@alsa-project.org>; Tue, 19 May 2015 09:38:01 +0000 (UTC)
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
List-Id: alsa-devel@alsa-project.org

The CA0132 DSP loader leads to NULL deference since the recent
transition to HDA core code, as it unconditionally accesses
hdac_stream->substream->runtime.  For DSP loading, the substream
shouldn't be assigned.

This patch addresses the NULL dereference above in addition to assure
the substream is cleared while DSP loading.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=98151
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/hda/hdac_stream.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/sound/hda/hdac_stream.c b/sound/hda/hdac_stream.c
index 52a894fe478f..4c15d0accc9e 100644
--- a/sound/hda/hdac_stream.c
+++ b/sound/hda/hdac_stream.c
@@ -139,9 +139,13 @@ EXPORT_SYMBOL_GPL(snd_hdac_stream_reset);
 int snd_hdac_stream_setup(struct hdac_stream *azx_dev)
 {
 	struct hdac_bus *bus = azx_dev->bus;
-	struct snd_pcm_runtime *runtime = azx_dev->substream->runtime;
+	struct snd_pcm_runtime *runtime;
 	unsigned int val;
 
+	if (azx_dev->substream)
+		runtime = azx_dev->substream->runtime;
+	else
+		runtime = NULL;
 	/* make sure the run bit is zero for SD */
 	snd_hdac_stream_clear(azx_dev);
 	/* program the stream_tag */
@@ -189,14 +193,15 @@ int snd_hdac_stream_setup(struct hdac_stream *azx_dev)
 	 * we ignore it; currently set the threshold statically to
 	 * 64 frames
 	 */
-	if (runtime->period_size > 64)
+	if (runtime && runtime->period_size > 64)
 		azx_dev->delay_negative_threshold =
 			-frames_to_bytes(runtime, 64);
 	else
 		azx_dev->delay_negative_threshold = 0;
 
 	/* wallclk has 24Mhz clock source */
-	azx_dev->period_wallclk = (((runtime->period_size * 24000) /
+	if (runtime)
+		azx_dev->period_wallclk = (((runtime->period_size * 24000) /
 				    runtime->rate) * 1000);
 
 	return 0;
@@ -611,6 +616,7 @@ int snd_hdac_dsp_prepare(struct hdac_stream *azx_dev, unsigned int format,
 	if (err < 0)
 		goto err_alloc;
 
+	azx_dev->substream = NULL;
 	azx_dev->bufsize = byte_size;
 	azx_dev->period_bytes = byte_size;
 	azx_dev->format_val = format;
-- 
2.4.1
