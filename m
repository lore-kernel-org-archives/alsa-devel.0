From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: usb-audio: Simplify PCM open/close
	callbacks
Date: Sun, 27 May 2018 14:17:24 +0200
Message-ID: <20180527121724.12035-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id D92612676AC
 for <alsa-devel@alsa-project.org>; Mon, 28 May 2018 17:54:06 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id AC518AC2E
 for <alsa-devel@alsa-project.org>; Mon, 28 May 2018 15:54:05 +0000 (UTC)
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

The stream direction in open and close callbacks can be retrieved from
substream->direction, hence we don't have to stick with the unique PCM
ops hard-coded for each direction.  Rewrite the common open/close
callback functions.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/pcm.c | 34 ++++++++--------------------------
 1 file changed, 8 insertions(+), 26 deletions(-)

diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
index 20bed1c7a312..d5b9c30d3bb1 100644
--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -1227,8 +1227,9 @@ static int setup_hw_info(struct snd_pcm_runtime *runtime, struct snd_usb_substre
 	return err;
 }
 
-static int snd_usb_pcm_open(struct snd_pcm_substream *substream, int direction)
+static int snd_usb_pcm_open(struct snd_pcm_substream *substream)
 {
+	int direction = substream->stream;
 	struct snd_usb_stream *as = snd_pcm_substream_chip(substream);
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct snd_usb_substream *subs = &as->substream[direction];
@@ -1248,8 +1249,9 @@ static int snd_usb_pcm_open(struct snd_pcm_substream *substream, int direction)
 	return setup_hw_info(runtime, subs);
 }
 
-static int snd_usb_pcm_close(struct snd_pcm_substream *substream, int direction)
+static int snd_usb_pcm_close(struct snd_pcm_substream *substream)
 {
+	int direction = substream->stream;
 	struct snd_usb_stream *as = snd_pcm_substream_chip(substream);
 	struct snd_usb_substream *subs = &as->substream[direction];
 
@@ -1611,26 +1613,6 @@ static void retire_playback_urb(struct snd_usb_substream *subs,
 	spin_unlock_irqrestore(&subs->lock, flags);
 }
 
-static int snd_usb_playback_open(struct snd_pcm_substream *substream)
-{
-	return snd_usb_pcm_open(substream, SNDRV_PCM_STREAM_PLAYBACK);
-}
-
-static int snd_usb_playback_close(struct snd_pcm_substream *substream)
-{
-	return snd_usb_pcm_close(substream, SNDRV_PCM_STREAM_PLAYBACK);
-}
-
-static int snd_usb_capture_open(struct snd_pcm_substream *substream)
-{
-	return snd_usb_pcm_open(substream, SNDRV_PCM_STREAM_CAPTURE);
-}
-
-static int snd_usb_capture_close(struct snd_pcm_substream *substream)
-{
-	return snd_usb_pcm_close(substream, SNDRV_PCM_STREAM_CAPTURE);
-}
-
 static int snd_usb_substream_playback_trigger(struct snd_pcm_substream *substream,
 					      int cmd)
 {
@@ -1692,8 +1674,8 @@ static int snd_usb_substream_capture_trigger(struct snd_pcm_substream *substream
 }
 
 static const struct snd_pcm_ops snd_usb_playback_ops = {
-	.open =		snd_usb_playback_open,
-	.close =	snd_usb_playback_close,
+	.open =		snd_usb_pcm_open,
+	.close =	snd_usb_pcm_close,
 	.ioctl =	snd_pcm_lib_ioctl,
 	.hw_params =	snd_usb_hw_params,
 	.hw_free =	snd_usb_hw_free,
@@ -1705,8 +1687,8 @@ static const struct snd_pcm_ops snd_usb_playback_ops = {
 };
 
 static const struct snd_pcm_ops snd_usb_capture_ops = {
-	.open =		snd_usb_capture_open,
-	.close =	snd_usb_capture_close,
+	.open =		snd_usb_pcm_open,
+	.close =	snd_usb_pcm_close,
 	.ioctl =	snd_pcm_lib_ioctl,
 	.hw_params =	snd_usb_hw_params,
 	.hw_free =	snd_usb_hw_free,
-- 
2.16.3
