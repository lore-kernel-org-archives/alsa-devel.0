From: Eldad Zack <eldad@fogrefinery.com>
Subject: [PATCHv2] ALSA: usb-audio: hiface: return correct XRUN
	indication
Date: Tue, 23 Jul 2013 11:15:06 +0200
Message-ID: <1374570906-1075-1-git-send-email-eldad@fogrefinery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f45.google.com (mail-bk0-f45.google.com
 [209.85.214.45])
 by alsa0.perex.cz (Postfix) with ESMTP id F3EB5261B1E
 for <alsa-devel@alsa-project.org>; Tue, 23 Jul 2013 11:15:11 +0200 (CEST)
Received: by mail-bk0-f45.google.com with SMTP id je9so2871299bkc.18
 for <alsa-devel@alsa-project.org>; Tue, 23 Jul 2013 02:15:11 -0700 (PDT)
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
Cc: Antonio Ospite <ospite@studenti.unina.it>, alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>, Eldad Zack <eldad@fogrefinery.com>
List-Id: alsa-devel@alsa-project.org

Return SNDRV_PCM_POS_XRUN (snd_pcm_uframes_t) instead of
SNDRV_PCM_STATE_XRUN (snd_pcm_state_t) from the pointer
function of hiface, as expected by snd_pcm_update_hw_ptr0().

Caught by sparse.

Cc: Antonio Ospite <ospite@studenti.unina.it>
Signed-off-by: Eldad Zack <eldad@fogrefinery.com>
---
* Corrected commit message

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
