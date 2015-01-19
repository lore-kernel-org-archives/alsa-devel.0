From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 15/17] ALSA: line6: Sync PCM stop at disconnect
Date: Mon, 19 Jan 2015 16:54:49 +0100
Message-ID: <1421682891-11594-16-git-send-email-tiwai@suse.de>
References: <1421682891-11594-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 4BBFB26145B
 for <alsa-devel@alsa-project.org>; Mon, 19 Jan 2015 16:55:03 +0100 (CET)
In-Reply-To: <1421682891-11594-1-git-send-email-tiwai@suse.de>
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

Call line6_pcm_disconnect() at disconnect to make sure that all URBs
are cleared.  Also reduce the superfluous snd_pcm_stop() calls from
the function (and remove the unused function) since the streams are
guaranteed to be stopped at this point via snd_card_disconnect().

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/line6/driver.c |  2 ++
 sound/usb/line6/pcm.c    | 19 +------------------
 2 files changed, 3 insertions(+), 18 deletions(-)

diff --git a/sound/usb/line6/driver.c b/sound/usb/line6/driver.c
index f222d9ffeca5..1193d16396a0 100644
--- a/sound/usb/line6/driver.c
+++ b/sound/usb/line6/driver.c
@@ -670,6 +670,8 @@ void line6_disconnect(struct usb_interface *interface)
 		dev_err(line6->ifcdev, "driver bug: inconsistent usb device\n");
 
 	snd_card_disconnect(line6->card);
+	if (line6->line6pcm)
+		line6_pcm_disconnect(line6->line6pcm);
 	if (line6->disconnect)
 		line6->disconnect(interface);
 
diff --git a/sound/usb/line6/pcm.c b/sound/usb/line6/pcm.c
index 39034c7681da..08fa9753a680 100644
--- a/sound/usb/line6/pcm.c
+++ b/sound/usb/line6/pcm.c
@@ -379,30 +379,13 @@ static int snd_line6_new_pcm(struct usb_line6 *line6, struct snd_pcm **pcm_ret)
 }
 
 /*
-	Stop substream if still running.
-*/
-static void pcm_disconnect_substream(struct snd_pcm_substream *substream)
-{
-	if (substream->runtime && snd_pcm_running(substream)) {
-		snd_pcm_stream_lock_irq(substream);
-		snd_pcm_stop(substream, SNDRV_PCM_STATE_DISCONNECTED);
-		snd_pcm_stream_unlock_irq(substream);
-	}
-}
-
-/*
-	Stop PCM stream.
+	Sync with PCM stream stops.
 */
 void line6_pcm_disconnect(struct snd_line6_pcm *line6pcm)
 {
-	pcm_disconnect_substream(get_substream
-				 (line6pcm, SNDRV_PCM_STREAM_CAPTURE));
-	pcm_disconnect_substream(get_substream
-				 (line6pcm, SNDRV_PCM_STREAM_PLAYBACK));
 	line6_unlink_wait_clear_audio_out_urbs(line6pcm);
 	line6_unlink_wait_clear_audio_in_urbs(line6pcm);
 }
-EXPORT_SYMBOL_GPL(line6_pcm_disconnect);
 
 /*
 	Create and register the PCM device and mixer entries.
-- 
2.2.1
