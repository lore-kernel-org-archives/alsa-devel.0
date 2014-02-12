From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 15/24] ALSA: sh: Convert to snd_card_new() with
	a device pointer
Date: Wed, 12 Feb 2014 11:35:31 +0100
Message-ID: <1392201340-27113-16-git-send-email-tiwai@suse.de>
References: <1392201340-27113-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 03129265025
 for <alsa-devel@alsa-project.org>; Wed, 12 Feb 2014 11:35:51 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 88D10AC8A
 for <alsa-devel@alsa-project.org>; Wed, 12 Feb 2014 10:35:50 +0000 (UTC)
In-Reply-To: <1392201340-27113-1-git-send-email-tiwai@suse.de>
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

Also remove superfluous snd_card_set_dev() calls.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/sh/aica.c         | 5 ++---
 sound/sh/sh_dac_audio.c | 2 +-
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/sound/sh/aica.c b/sound/sh/aica.c
index 78a369785a9e..47849eaf266d 100644
--- a/sound/sh/aica.c
+++ b/sound/sh/aica.c
@@ -608,8 +608,8 @@ static int snd_aica_probe(struct platform_device *devptr)
 	dreamcastcard = kmalloc(sizeof(struct snd_card_aica), GFP_KERNEL);
 	if (unlikely(!dreamcastcard))
 		return -ENOMEM;
-	err = snd_card_create(index, SND_AICA_DRIVER, THIS_MODULE, 0,
-			      &dreamcastcard->card);
+	err = snd_card_new(&devptr->dev, index, SND_AICA_DRIVER,
+			   THIS_MODULE, 0, &dreamcastcard->card);
 	if (unlikely(err < 0)) {
 		kfree(dreamcastcard);
 		return err;
@@ -624,7 +624,6 @@ static int snd_aica_probe(struct platform_device *devptr)
 	err = snd_aicapcmchip(dreamcastcard, 0);
 	if (unlikely(err < 0))
 		goto freedreamcast;
-	snd_card_set_dev(dreamcastcard->card, &devptr->dev);
 	dreamcastcard->timer.data = 0;
 	dreamcastcard->channel = NULL;
 	/* Add basic controls */
diff --git a/sound/sh/sh_dac_audio.c b/sound/sh/sh_dac_audio.c
index 7c9422c4fc0f..d1fb74dabbd1 100644
--- a/sound/sh/sh_dac_audio.c
+++ b/sound/sh/sh_dac_audio.c
@@ -396,7 +396,7 @@ static int snd_sh_dac_probe(struct platform_device *devptr)
 	struct snd_card *card;
 	int err;
 
-	err = snd_card_create(index, id, THIS_MODULE, 0, &card);
+	err = snd_card_new(&devptr->dev, index, id, THIS_MODULE, 0, &card);
 	if (err < 0) {
 			snd_printk(KERN_ERR "cannot allocate the card\n");
 			return err;
-- 
1.8.5.2
