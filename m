From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 05/10] ALSA: usx2y: Fix unlocked snd_pcm_stop()
	call
Date: Mon, 15 Jul 2013 15:06:17 +0200
Message-ID: <1373893582-17116-6-git-send-email-tiwai@suse.de>
References: <1373893582-17116-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id F3AB526157F
 for <alsa-devel@alsa-project.org>; Mon, 15 Jul 2013 15:06:03 +0200 (CEST)
Received: from relay1.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id CC722A51FE
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
 sound/usb/usx2y/usbusx2yaudio.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/usb/usx2y/usbusx2yaudio.c b/sound/usb/usx2y/usbusx2yaudio.c
index 4967fe9..63fb521 100644
--- a/sound/usb/usx2y/usbusx2yaudio.c
+++ b/sound/usb/usx2y/usbusx2yaudio.c
@@ -273,7 +273,11 @@ static void usX2Y_clients_stop(struct usX2Ydev *usX2Y)
 		struct snd_usX2Y_substream *subs = usX2Y->subs[s];
 		if (subs) {
 			if (atomic_read(&subs->state) >= state_PRERUNNING) {
+				unsigned long flags;
+
+				snd_pcm_stream_lock_irqsave(subs->pcm_substream, flags);
 				snd_pcm_stop(subs->pcm_substream, SNDRV_PCM_STATE_XRUN);
+				snd_pcm_stream_unlock_irqrestore(subs->pcm_substream, flags);
 			}
 			for (u = 0; u < NRURBS; u++) {
 				struct urb *urb = subs->urb[u];
-- 
1.8.3.1
