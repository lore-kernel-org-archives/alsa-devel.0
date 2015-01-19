From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 09/17] ALSA: line6: Drop superfluous
	irqsave/irqrestore in PCM trigger callback
Date: Mon, 19 Jan 2015 16:54:43 +0100
Message-ID: <1421682891-11594-10-git-send-email-tiwai@suse.de>
References: <1421682891-11594-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 47EC22612D1
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

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/line6/pcm.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/sound/usb/line6/pcm.c b/sound/usb/line6/pcm.c
index 932cc7e194e2..edab3cd7c048 100644
--- a/sound/usb/line6/pcm.c
+++ b/sound/usb/line6/pcm.c
@@ -227,9 +227,8 @@ int snd_line6_trigger(struct snd_pcm_substream *substream, int cmd)
 	struct snd_line6_pcm *line6pcm = snd_pcm_substream_chip(substream);
 	struct snd_pcm_substream *s;
 	int err;
-	unsigned long flags;
 
-	spin_lock_irqsave(&line6pcm->lock_trigger, flags);
+	spin_lock(&line6pcm->lock_trigger);
 	clear_bit(LINE6_INDEX_PREPARED, &line6pcm->flags);
 
 	snd_pcm_group_for_each_entry(s, substream) {
@@ -240,8 +239,7 @@ int snd_line6_trigger(struct snd_pcm_substream *substream, int cmd)
 			err = snd_line6_playback_trigger(line6pcm, cmd);
 
 			if (err < 0) {
-				spin_unlock_irqrestore(&line6pcm->lock_trigger,
-						       flags);
+				spin_unlock(&line6pcm->lock_trigger);
 				return err;
 			}
 
@@ -251,8 +249,7 @@ int snd_line6_trigger(struct snd_pcm_substream *substream, int cmd)
 			err = snd_line6_capture_trigger(line6pcm, cmd);
 
 			if (err < 0) {
-				spin_unlock_irqrestore(&line6pcm->lock_trigger,
-						       flags);
+				spin_unlock(&line6pcm->lock_trigger);
 				return err;
 			}
 
@@ -264,7 +261,7 @@ int snd_line6_trigger(struct snd_pcm_substream *substream, int cmd)
 		}
 	}
 
-	spin_unlock_irqrestore(&line6pcm->lock_trigger, flags);
+	spin_unlock(&line6pcm->lock_trigger);
 	return 0;
 }
 
-- 
2.2.1
