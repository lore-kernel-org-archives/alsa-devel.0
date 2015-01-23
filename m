From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 08/16] ALSA: line6: Drop superfluous spinlock
	for trigger
Date: Fri, 23 Jan 2015 18:13:15 +0100
Message-ID: <1422033203-23254-9-git-send-email-tiwai@suse.de>
References: <1422033203-23254-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id A1A3A265522
 for <alsa-devel@alsa-project.org>; Fri, 23 Jan 2015 18:13:42 +0100 (CET)
In-Reply-To: <1422033203-23254-1-git-send-email-tiwai@suse.de>
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

The trigger callback is already spinlocked, so we need no more lock
here (even for the linked substreams).  Let's drop it.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/line6/pcm.c | 23 ++++++-----------------
 sound/usb/line6/pcm.h |  5 -----
 2 files changed, 6 insertions(+), 22 deletions(-)

diff --git a/sound/usb/line6/pcm.c b/sound/usb/line6/pcm.c
index 9a2a15f4c4e4..adbcac46b785 100644
--- a/sound/usb/line6/pcm.c
+++ b/sound/usb/line6/pcm.c
@@ -226,9 +226,8 @@ int snd_line6_trigger(struct snd_pcm_substream *substream, int cmd)
 {
 	struct snd_line6_pcm *line6pcm = snd_pcm_substream_chip(substream);
 	struct snd_pcm_substream *s;
-	int err;
+	int err = 0;
 
-	spin_lock(&line6pcm->lock_trigger);
 	clear_bit(LINE6_INDEX_PREPARED, &line6pcm->flags);
 
 	snd_pcm_group_for_each_entry(s, substream) {
@@ -237,32 +236,23 @@ int snd_line6_trigger(struct snd_pcm_substream *substream, int cmd)
 		switch (s->stream) {
 		case SNDRV_PCM_STREAM_PLAYBACK:
 			err = snd_line6_playback_trigger(line6pcm, cmd);
-
-			if (err < 0) {
-				spin_unlock(&line6pcm->lock_trigger);
-				return err;
-			}
-
 			break;
 
 		case SNDRV_PCM_STREAM_CAPTURE:
 			err = snd_line6_capture_trigger(line6pcm, cmd);
-
-			if (err < 0) {
-				spin_unlock(&line6pcm->lock_trigger);
-				return err;
-			}
-
 			break;
 
 		default:
 			dev_err(line6pcm->line6->ifcdev,
 				"Unknown stream direction %d\n", s->stream);
+			err = -EINVAL;
+			break;
 		}
+		if (err < 0)
+			break;
 	}
 
-	spin_unlock(&line6pcm->lock_trigger);
-	return 0;
+	return err;
 }
 
 /* control info callback */
@@ -427,7 +417,6 @@ int line6_init_pcm(struct usb_line6 *line6,
 
 	spin_lock_init(&line6pcm->lock_audio_out);
 	spin_lock_init(&line6pcm->lock_audio_in);
-	spin_lock_init(&line6pcm->lock_trigger);
 	line6pcm->impulse_period = LINE6_IMPULSE_DEFAULT_PERIOD;
 
 	line6->line6pcm = line6pcm;
diff --git a/sound/usb/line6/pcm.h b/sound/usb/line6/pcm.h
index c742b33666eb..a84753ee0fa2 100644
--- a/sound/usb/line6/pcm.h
+++ b/sound/usb/line6/pcm.h
@@ -308,11 +308,6 @@ struct snd_line6_pcm {
 	spinlock_t lock_audio_in;
 
 	/**
-		 Spin lock to protect trigger.
-	*/
-	spinlock_t lock_trigger;
-
-	/**
 		 PCM playback volume (left and right).
 	*/
 	int volume_playback[2];
-- 
2.2.2
