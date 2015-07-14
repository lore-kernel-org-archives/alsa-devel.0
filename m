From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: line6: Fix -EBUSY error during active
	monitoring
Date: Tue, 14 Jul 2015 15:22:42 +0200
Message-ID: <1436880162-2935-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 493CC26071F
 for <alsa-devel@alsa-project.org>; Tue, 14 Jul 2015 15:22:44 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id A8D21AAF2
 for <alsa-devel@alsa-project.org>; Tue, 14 Jul 2015 13:22:43 +0000 (UTC)
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

When a monitor stream is active, the next PCM stream access results in
EBUSY error because of the check in line6_stream_start().  Fix this by
just skipping the submission of pending URBs when the stream is
already running instead.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=101431
Cc: <stable@vger.kernel.org> # v4.0+
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/line6/pcm.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/sound/usb/line6/pcm.c b/sound/usb/line6/pcm.c
index 8461d6bf992f..204cc074adb9 100644
--- a/sound/usb/line6/pcm.c
+++ b/sound/usb/line6/pcm.c
@@ -186,12 +186,8 @@ static int line6_stream_start(struct snd_line6_pcm *line6pcm, int direction,
 	int ret = 0;
 
 	spin_lock_irqsave(&pstr->lock, flags);
-	if (!test_and_set_bit(type, &pstr->running)) {
-		if (pstr->active_urbs || pstr->unlink_urbs) {
-			ret = -EBUSY;
-			goto error;
-		}
-
+	if (!test_and_set_bit(type, &pstr->running) &&
+	    !(pstr->active_urbs || pstr->unlink_urbs)) {
 		pstr->count = 0;
 		/* Submit all currently available URBs */
 		if (direction == SNDRV_PCM_STREAM_PLAYBACK)
@@ -199,7 +195,6 @@ static int line6_stream_start(struct snd_line6_pcm *line6pcm, int direction,
 		else
 			ret = line6_submit_audio_in_all_urbs(line6pcm);
 	}
- error:
 	if (ret < 0)
 		clear_bit(type, &pstr->running);
 	spin_unlock_irqrestore(&pstr->lock, flags);
-- 
2.4.5
