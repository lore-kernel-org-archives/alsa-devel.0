From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 09/20] ALSA: mips: Use SNDRV_DEV_CARD for card
	objects
Date: Wed, 12 Feb 2014 11:52:16 +0100
Message-ID: <1392202347-11774-10-git-send-email-tiwai@suse.de>
References: <1392202347-11774-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 0A5B22651C0
 for <alsa-devel@alsa-project.org>; Wed, 12 Feb 2014 11:52:48 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id CF912AC7B
 for <alsa-devel@alsa-project.org>; Wed, 12 Feb 2014 10:52:47 +0000 (UTC)
In-Reply-To: <1392202347-11774-1-git-send-email-tiwai@suse.de>
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

... instead of SNDRV_DEV_LOWLEVEL.
No functional change at this point.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/mips/hal2.c       | 2 +-
 sound/mips/sgio2audio.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/mips/hal2.c b/sound/mips/hal2.c
index 23441b9e6148..beb08fc00d9e 100644
--- a/sound/mips/hal2.c
+++ b/sound/mips/hal2.c
@@ -864,7 +864,7 @@ static int hal2_create(struct snd_card *card, struct snd_hal2 **rchip)
 	hpc3->pbus_dmacfg[hal2->dac.pbus.pbusnr][0] = 0x8208844;
 	hpc3->pbus_dmacfg[hal2->adc.pbus.pbusnr][0] = 0x8208844;
 
-	err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, hal2, &hal2_ops);
+	err = snd_device_new(card, SNDRV_DEV_CARD, hal2, &hal2_ops);
 	if (err < 0) {
 		free_irq(SGI_HPCDMA_IRQ, hal2);
 		kfree(hal2);
diff --git a/sound/mips/sgio2audio.c b/sound/mips/sgio2audio.c
index 04bb06c03ec8..c87d2b7e61ca 100644
--- a/sound/mips/sgio2audio.c
+++ b/sound/mips/sgio2audio.c
@@ -905,7 +905,7 @@ static int snd_sgio2audio_create(struct snd_card *card,
 		return err;
 	}
 
-	err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, chip, &ops);
+	err = snd_device_new(card, SNDRV_DEV_CARD, chip, &ops);
 	if (err < 0) {
 		snd_sgio2audio_free(chip);
 		return err;
-- 
1.8.5.2
