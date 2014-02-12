From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 13/24] ALSA: pcmcia: Convert to snd_card_new()
	with a device pointer
Date: Wed, 12 Feb 2014 11:35:29 +0100
Message-ID: <1392201340-27113-14-git-send-email-tiwai@suse.de>
References: <1392201340-27113-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id E5635265012
 for <alsa-devel@alsa-project.org>; Wed, 12 Feb 2014 11:35:50 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 82E8CAC86
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
 sound/pcmcia/pdaudiocf/pdaudiocf.c | 5 ++---
 sound/pcmcia/vx/vxpocket.c         | 4 ++--
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/sound/pcmcia/pdaudiocf/pdaudiocf.c b/sound/pcmcia/pdaudiocf/pdaudiocf.c
index 8f489de5c4c6..56bda124cd4a 100644
--- a/sound/pcmcia/pdaudiocf/pdaudiocf.c
+++ b/sound/pcmcia/pdaudiocf/pdaudiocf.c
@@ -112,7 +112,8 @@ static int snd_pdacf_probe(struct pcmcia_device *link)
 		return -ENODEV; /* disabled explicitly */
 
 	/* ok, create a card instance */
-	err = snd_card_create(index[i], id[i], THIS_MODULE, 0, &card);
+	err = snd_card_new(&link->dev, index[i], id[i], THIS_MODULE,
+			   0, &card);
 	if (err < 0) {
 		snd_printk(KERN_ERR "pdacf: cannot create a card instance\n");
 		return err;
@@ -131,8 +132,6 @@ static int snd_pdacf_probe(struct pcmcia_device *link)
 		return err;
 	}
 
-	snd_card_set_dev(card, &link->dev);
-
 	pdacf->index = i;
 	card_list[i] = card;
 
diff --git a/sound/pcmcia/vx/vxpocket.c b/sound/pcmcia/vx/vxpocket.c
index d4db7ecaa6bf..786e7e139c9e 100644
--- a/sound/pcmcia/vx/vxpocket.c
+++ b/sound/pcmcia/vx/vxpocket.c
@@ -238,7 +238,6 @@ static int vxpocket_config(struct pcmcia_device *link)
 		goto failed;
 
 	chip->dev = &link->dev;
-	snd_card_set_dev(chip->card, chip->dev);
 
 	if (snd_vxpocket_assign_resources(chip, link->resource[0]->start,
 						link->irq) < 0)
@@ -307,7 +306,8 @@ static int vxpocket_probe(struct pcmcia_device *p_dev)
 		return -ENODEV; /* disabled explicitly */
 
 	/* ok, create a card instance */
-	err = snd_card_create(index[i], id[i], THIS_MODULE, 0, &card);
+	err = snd_card_new(&p_dev->dev, index[i], id[i], THIS_MODULE,
+			   0, &card);
 	if (err < 0) {
 		snd_printk(KERN_ERR "vxpocket: cannot create a card instance\n");
 		return err;
-- 
1.8.5.2
