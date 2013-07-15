From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 03/10] ALSA: 6fire: Fix unlocked snd_pcm_stop()
	call
Date: Mon, 15 Jul 2013 15:06:15 +0200
Message-ID: <1373893582-17116-4-git-send-email-tiwai@suse.de>
References: <1373893582-17116-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id B2F5C2610D6
 for <alsa-devel@alsa-project.org>; Mon, 15 Jul 2013 15:06:03 +0200 (CEST)
Received: from relay1.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 8CD10A52C6
 for <alsa-devel@alsa-project.org>; Mon, 15 Jul 2013 15:06:03 +0200 (CEST)
In-Reply-To: <1373893582-17116-1-git-send-email-tiwai@suse.de>
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

snd_pcm_stop() must be called in the PCM substream lock context.

Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/6fire/pcm.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/sound/usb/6fire/pcm.c b/sound/usb/6fire/pcm.c
index c5b9cac..2aa4e13 100644
--- a/sound/usb/6fire/pcm.c
+++ b/sound/usb/6fire/pcm.c
@@ -639,17 +639,25 @@ int usb6fire_pcm_init(struct sfire_chip *chip)
 void usb6fire_pcm_abort(struct sfire_chip *chip)
 {
 	struct pcm_runtime *rt = chip->pcm;
+	unsigned long flags;
 	int i;
 
 	if (rt) {
 		rt->panic = true;
 
-		if (rt->playback.instance)
+		if (rt->playback.instance) {
+			snd_pcm_stream_lock_irqsave(rt->playback.instance, flags);
 			snd_pcm_stop(rt->playback.instance,
 					SNDRV_PCM_STATE_XRUN);
-		if (rt->capture.instance)
+			snd_pcm_stream_unlock_irqrestore(rt->playback.instance, flags);
+		}
+
+		if (rt->capture.instance) {
+			snd_pcm_stream_lock_irqsave(rt->capture.instance, flags);
 			snd_pcm_stop(rt->capture.instance,
 					SNDRV_PCM_STATE_XRUN);
+			snd_pcm_stream_unlock_irqrestore(rt->capture.instance, flags);
+		}
 
 		for (i = 0; i < PCM_N_URBS; i++) {
 			usb_poison_urb(&rt->in_urbs[i].instance);
-- 
1.8.3.1
