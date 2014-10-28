From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/3] ALSA: ctxfi: Kill the rest snd_print*()
Date: Tue, 28 Oct 2014 17:45:13 +0100
Message-ID: <1414514715-569-2-git-send-email-tiwai@suse.de>
References: <1414514715-569-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id C8FAD261AA5
 for <alsa-devel@alsa-project.org>; Tue, 28 Oct 2014 17:45:17 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 4CCD9ACCE
 for <alsa-devel@alsa-project.org>; Tue, 28 Oct 2014 16:45:17 +0000 (UTC)
In-Reply-To: <1414514715-569-1-git-send-email-tiwai@suse.de>
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

Use the standard dev_*() instead.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/ctxfi/ctatc.c   | 6 ++++--
 sound/pci/ctxfi/cttimer.c | 4 ++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/sound/pci/ctxfi/ctatc.c b/sound/pci/ctxfi/ctatc.c
index 632e843fa95e..977a59855fa6 100644
--- a/sound/pci/ctxfi/ctatc.c
+++ b/sound/pci/ctxfi/ctatc.c
@@ -438,7 +438,9 @@ atc_pcm_playback_position(struct ct_atc *atc, struct ct_atc_pcm *apcm)
 	position = src->ops->get_ca(src);
 
 	if (position < apcm->vm_block->addr) {
-		snd_printdd("ctxfi: bad ca - ca=0x%08x, vba=0x%08x, vbs=0x%08x\n", position, apcm->vm_block->addr, apcm->vm_block->size);
+		dev_dbg(atc->card->dev,
+			"bad ca - ca=0x%08x, vba=0x%08x, vbs=0x%08x\n",
+			position, apcm->vm_block->addr, apcm->vm_block->size);
 		position = apcm->vm_block->addr;
 	}
 
@@ -1295,7 +1297,7 @@ static int atc_identify_card(struct ct_atc *atc, unsigned int ssid)
 			atc->model = CT20K2_UNKNOWN;
 	}
 	atc->model_name = ct_subsys_name[atc->model];
-	snd_printd("ctxfi: chip %s model %s (%04x:%04x) is found\n",
+	dev_info(atc->card->dev, "chip %s model %s (%04x:%04x) is found\n",
 		   atc->chip_name, atc->model_name,
 		   vendor_id, device_id);
 	return 0;
diff --git a/sound/pci/ctxfi/cttimer.c b/sound/pci/ctxfi/cttimer.c
index 03fb909085af..a5d460453d7b 100644
--- a/sound/pci/ctxfi/cttimer.c
+++ b/sound/pci/ctxfi/cttimer.c
@@ -421,12 +421,12 @@ struct ct_timer *ct_timer_new(struct ct_atc *atc)
 	atimer->atc = atc;
 	hw = atc->hw;
 	if (!use_system_timer && hw->set_timer_irq) {
-		snd_printd(KERN_INFO "ctxfi: Use xfi-native timer\n");
+		dev_info(atc->card->dev, "Use xfi-native timer\n");
 		atimer->ops = &ct_xfitimer_ops;
 		hw->irq_callback_data = atimer;
 		hw->irq_callback = ct_timer_interrupt;
 	} else {
-		snd_printd(KERN_INFO "ctxfi: Use system timer\n");
+		dev_info(atc->card->dev, "Use system timer\n");
 		atimer->ops = &ct_systimer_ops;
 	}
 	return atimer;
-- 
2.1.2
