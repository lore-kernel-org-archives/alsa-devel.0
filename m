From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 06/20] ALSA: pcmcia: Use SNDRV_DEV_CARD for
	card objects
Date: Wed, 12 Feb 2014 11:52:13 +0100
Message-ID: <1392202347-11774-7-git-send-email-tiwai@suse.de>
References: <1392202347-11774-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 01CB62651B2
 for <alsa-devel@alsa-project.org>; Wed, 12 Feb 2014 11:52:48 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id C57FAAC03
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
 sound/pcmcia/pdaudiocf/pdaudiocf.c | 2 +-
 sound/pcmcia/vx/vxpocket.c         | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/pcmcia/pdaudiocf/pdaudiocf.c b/sound/pcmcia/pdaudiocf/pdaudiocf.c
index 56bda124cd4a..07e365de5c3c 100644
--- a/sound/pcmcia/pdaudiocf/pdaudiocf.c
+++ b/sound/pcmcia/pdaudiocf/pdaudiocf.c
@@ -125,7 +125,7 @@ static int snd_pdacf_probe(struct pcmcia_device *link)
 		return -ENOMEM;
 	}
 
-	err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, pdacf, &ops);
+	err = snd_device_new(card, SNDRV_DEV_CARD, pdacf, &ops);
 	if (err < 0) {
 		kfree(pdacf);
 		snd_card_free(card);
diff --git a/sound/pcmcia/vx/vxpocket.c b/sound/pcmcia/vx/vxpocket.c
index 786e7e139c9e..e2db031deb2c 100644
--- a/sound/pcmcia/vx/vxpocket.c
+++ b/sound/pcmcia/vx/vxpocket.c
@@ -147,7 +147,7 @@ static int snd_vxpocket_new(struct snd_card *card, int ibl,
 	if (!chip)
 		return -ENOMEM;
 
-	err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, chip, &ops);
+	err = snd_device_new(card, SNDRV_DEV_CARD, chip, &ops);
 	if (err < 0) {
 		kfree(chip);
 		return err;
-- 
1.8.5.2
