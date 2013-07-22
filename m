From: Eldad Zack <eldad@fogrefinery.com>
Subject: [PATCH] ALSA: usb-audio: hiface: return correct XRUN
	indication
Date: Mon, 22 Jul 2013 19:38:24 +0200
Message-ID: <1374514704-4211-1-git-send-email-eldad@fogrefinery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ea0-f169.google.com (mail-ea0-f169.google.com
 [209.85.215.169])
 by alsa0.perex.cz (Postfix) with ESMTP id 499E9261A56
 for <alsa-devel@alsa-project.org>; Mon, 22 Jul 2013 19:38:30 +0200 (CEST)
Received: by mail-ea0-f169.google.com with SMTP id h15so4010438eak.0
 for <alsa-devel@alsa-project.org>; Mon, 22 Jul 2013 10:38:30 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Eldad Zack <eldad@fogrefinery.com>
List-Id: alsa-devel@alsa-project.org

Return SNDRV_PCM_POS_XRUN (snd_pcm_uframes_t) instead of
SNDRV_PCM_STATE_XRUN (snd_pcm_state_t) from the pointer
function of 6fire, as expected by snd_pcm_update_hw_ptr0().

Caught by sparse.

Signed-off-by: Eldad Zack <eldad@fogrefinery.com>
---
 sound/usb/hiface/pcm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/usb/hiface/pcm.c b/sound/usb/hiface/pcm.c
index 6430ed2..c21a3df 100644
--- a/sound/usb/hiface/pcm.c
+++ b/sound/usb/hiface/pcm.c
@@ -503,7 +503,7 @@ static snd_pcm_uframes_t hiface_pcm_pointer(struct snd_pcm_substream *alsa_sub)
 	snd_pcm_uframes_t dma_offset;
 
 	if (rt->panic || !sub)
-		return SNDRV_PCM_STATE_XRUN;
+		return SNDRV_PCM_POS_XRUN;
 
 	spin_lock_irqsave(&sub->lock, flags);
 	dma_offset = sub->dma_off;
-- 
1.8.1.5
