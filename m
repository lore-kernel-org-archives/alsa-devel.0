From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4/5] ALSA: line6: Make common PCM pointer
	callback
Date: Tue, 27 Jan 2015 17:13:16 +0100
Message-ID: <1422375197-17293-5-git-send-email-tiwai@suse.de>
References: <1422375197-17293-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 39B282608EA
 for <alsa-devel@alsa-project.org>; Tue, 27 Jan 2015 17:13:19 +0100 (CET)
In-Reply-To: <1422375197-17293-1-git-send-email-tiwai@suse.de>
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
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Chris Rorvick <chris@rorvick.com>
List-Id: alsa-devel@alsa-project.org

Both playback and capture callbacks are identical, so let's merge
them.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/line6/capture.c  | 11 +----------
 sound/usb/line6/pcm.c      |  9 +++++++++
 sound/usb/line6/pcm.h      |  1 +
 sound/usb/line6/playback.c | 11 +----------
 4 files changed, 12 insertions(+), 20 deletions(-)

diff --git a/sound/usb/line6/capture.c b/sound/usb/line6/capture.c
index 1184876f4e00..5b0963b5f318 100644
--- a/sound/usb/line6/capture.c
+++ b/sound/usb/line6/capture.c
@@ -231,15 +231,6 @@ static int snd_line6_capture_close(struct snd_pcm_substream *substream)
 	return 0;
 }
 
-/* capture pointer callback */
-static snd_pcm_uframes_t
-snd_line6_capture_pointer(struct snd_pcm_substream *substream)
-{
-	struct snd_line6_pcm *line6pcm = snd_pcm_substream_chip(substream);
-
-	return line6pcm->in.pos_done;
-}
-
 /* capture operators */
 struct snd_pcm_ops snd_line6_capture_ops = {
 	.open = snd_line6_capture_open,
@@ -249,7 +240,7 @@ struct snd_pcm_ops snd_line6_capture_ops = {
 	.hw_free = snd_line6_hw_free,
 	.prepare = snd_line6_prepare,
 	.trigger = snd_line6_trigger,
-	.pointer = snd_line6_capture_pointer,
+	.pointer = snd_line6_pointer,
 };
 
 int line6_create_audio_in_urbs(struct snd_line6_pcm *line6pcm)
diff --git a/sound/usb/line6/pcm.c b/sound/usb/line6/pcm.c
index 470fc1049d54..73c87467d2e0 100644
--- a/sound/usb/line6/pcm.c
+++ b/sound/usb/line6/pcm.c
@@ -266,6 +266,15 @@ int snd_line6_trigger(struct snd_pcm_substream *substream, int cmd)
 	return 0;
 }
 
+/* common PCM pointer callback */
+snd_pcm_uframes_t snd_line6_pointer(struct snd_pcm_substream *substream)
+{
+	struct snd_line6_pcm *line6pcm = snd_pcm_substream_chip(substream);
+	struct line6_pcm_stream *pstr = get_stream(line6pcm, substream->stream);
+
+	return pstr->pos_done;
+}
+
 /* Acquire and start duplex streams:
  * type is either LINE6_STREAM_IMPULSE or LINE6_STREAM_MONITOR
  */
diff --git a/sound/usb/line6/pcm.h b/sound/usb/line6/pcm.h
index 66f603dfa34e..42d3e6fc2c61 100644
--- a/sound/usb/line6/pcm.h
+++ b/sound/usb/line6/pcm.h
@@ -214,6 +214,7 @@ extern int snd_line6_prepare(struct snd_pcm_substream *substream);
 extern int snd_line6_hw_params(struct snd_pcm_substream *substream,
 			       struct snd_pcm_hw_params *hw_params);
 extern int snd_line6_hw_free(struct snd_pcm_substream *substream);
+extern snd_pcm_uframes_t snd_line6_pointer(struct snd_pcm_substream *substream);
 extern void line6_pcm_disconnect(struct snd_line6_pcm *line6pcm);
 extern int line6_pcm_acquire(struct snd_line6_pcm *line6pcm, int type);
 extern void line6_pcm_release(struct snd_line6_pcm *line6pcm, int type);
diff --git a/sound/usb/line6/playback.c b/sound/usb/line6/playback.c
index f8b04e2d36b3..1708c05f14db 100644
--- a/sound/usb/line6/playback.c
+++ b/sound/usb/line6/playback.c
@@ -380,15 +380,6 @@ static int snd_line6_playback_close(struct snd_pcm_substream *substream)
 	return 0;
 }
 
-/* playback pointer callback */
-static snd_pcm_uframes_t
-snd_line6_playback_pointer(struct snd_pcm_substream *substream)
-{
-	struct snd_line6_pcm *line6pcm = snd_pcm_substream_chip(substream);
-
-	return line6pcm->out.pos_done;
-}
-
 /* playback operators */
 struct snd_pcm_ops snd_line6_playback_ops = {
 	.open = snd_line6_playback_open,
@@ -398,7 +389,7 @@ struct snd_pcm_ops snd_line6_playback_ops = {
 	.hw_free = snd_line6_hw_free,
 	.prepare = snd_line6_prepare,
 	.trigger = snd_line6_trigger,
-	.pointer = snd_line6_playback_pointer,
+	.pointer = snd_line6_pointer,
 };
 
 int line6_create_audio_out_urbs(struct snd_line6_pcm *line6pcm)
-- 
2.2.2
