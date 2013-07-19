From: Eldad Zack <eldad@fogrefinery.com>
Subject: [PATCH] ALSA: usb-audio: 6fire: return correct XRUN
	indication
Date: Fri, 19 Jul 2013 18:26:53 +0200
Message-ID: <1374251213-2671-1-git-send-email-eldad@fogrefinery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ea0-f171.google.com (mail-ea0-f171.google.com
 [209.85.215.171])
 by alsa0.perex.cz (Postfix) with ESMTP id 22DBE265749
 for <alsa-devel@alsa-project.org>; Fri, 19 Jul 2013 18:27:08 +0200 (CEST)
Received: by mail-ea0-f171.google.com with SMTP id m14so2520496eaj.30
 for <alsa-devel@alsa-project.org>; Fri, 19 Jul 2013 09:27:08 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Torsten Schenk <torsten.schenk@zoho.com>
Cc: alsa-devel@alsa-project.org, Eldad Zack <eldad@fogrefinery.com>
List-Id: alsa-devel@alsa-project.org

Return SNDRV_PCM_POS_XRUN (snd_pcm_uframes_t) instead of
SNDRV_PCM_STATE_XRUN (snd_pcm_state_t) from the pointer
function of 6fire, as expected by snd_pcm_update_hw_ptr0().

Caught by sparse.

Signed-off-by: Eldad Zack <eldad@fogrefinery.com>
---
 sound/usb/6fire/pcm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/usb/6fire/pcm.c b/sound/usb/6fire/pcm.c
index c5b9cac..60ac8fb 100644
--- a/sound/usb/6fire/pcm.c
+++ b/sound/usb/6fire/pcm.c
@@ -543,7 +543,7 @@ static snd_pcm_uframes_t usb6fire_pcm_pointer(
 	snd_pcm_uframes_t ret;
 
 	if (rt->panic || !sub)
-		return SNDRV_PCM_STATE_XRUN;
+		return SNDRV_PCM_POS_XRUN;
 
 	spin_lock_irqsave(&sub->lock, flags);
 	ret = sub->dma_off;
-- 
1.8.1.5
