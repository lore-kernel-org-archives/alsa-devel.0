From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 14/24] ALSA: ppc: Convert to snd_card_new()
	with a device pointer
Date: Wed, 12 Feb 2014 11:35:30 +0100
Message-ID: <1392201340-27113-15-git-send-email-tiwai@suse.de>
References: <1392201340-27113-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id E9083265013
 for <alsa-devel@alsa-project.org>; Wed, 12 Feb 2014 11:35:50 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 85CE6AC88
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
 sound/aoa/core/alsa.c | 5 ++---
 sound/ppc/powermac.c  | 4 +---
 sound/ppc/snd_ps3.c   | 4 ++--
 3 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/sound/aoa/core/alsa.c b/sound/aoa/core/alsa.c
index 0fa3855b4790..9913bf222073 100644
--- a/sound/aoa/core/alsa.c
+++ b/sound/aoa/core/alsa.c
@@ -23,13 +23,12 @@ int aoa_alsa_init(char *name, struct module *mod, struct device *dev)
 		/* cannot be EEXIST due to usage in aoa_fabric_register */
 		return -EBUSY;
 
-	err = snd_card_create(index, name, mod, sizeof(struct aoa_card),
-			      &alsa_card);
+	err = snd_card_new(dev, index, name, mod, sizeof(struct aoa_card),
+			   &alsa_card);
 	if (err < 0)
 		return err;
 	aoa_card = alsa_card->private_data;
 	aoa_card->alsa_card = alsa_card;
-	alsa_card->dev = dev;
 	strlcpy(alsa_card->driver, "AppleOnbdAudio", sizeof(alsa_card->driver));
 	strlcpy(alsa_card->shortname, name, sizeof(alsa_card->shortname));
 	strlcpy(alsa_card->longname, name, sizeof(alsa_card->longname));
diff --git a/sound/ppc/powermac.c b/sound/ppc/powermac.c
index 8abb521b4814..350a7c8f86dd 100644
--- a/sound/ppc/powermac.c
+++ b/sound/ppc/powermac.c
@@ -58,7 +58,7 @@ static int snd_pmac_probe(struct platform_device *devptr)
 	char *name_ext;
 	int err;
 
-	err = snd_card_create(index, id, THIS_MODULE, 0, &card);
+	err = snd_card_new(&devptr->dev, index, id, THIS_MODULE, 0, &card);
 	if (err < 0)
 		return err;
 
@@ -122,8 +122,6 @@ static int snd_pmac_probe(struct platform_device *devptr)
 	if (enable_beep)
 		snd_pmac_attach_beep(chip);
 
-	snd_card_set_dev(card, &devptr->dev);
-
 	if ((err = snd_card_register(card)) < 0)
 		goto __error;
 
diff --git a/sound/ppc/snd_ps3.c b/sound/ppc/snd_ps3.c
index ebb76f2d90d7..58f292a87f98 100644
--- a/sound/ppc/snd_ps3.c
+++ b/sound/ppc/snd_ps3.c
@@ -984,7 +984,8 @@ static int snd_ps3_driver_probe(struct ps3_system_bus_device *dev)
 	}
 
 	/* create card instance */
-	ret = snd_card_create(index, id, THIS_MODULE, 0, &the_card.card);
+	ret = snd_card_new(&dev->core, index, id, THIS_MODULE,
+			   0, &the_card.card);
 	if (ret < 0)
 		goto clean_irq;
 
@@ -1052,7 +1053,6 @@ static int snd_ps3_driver_probe(struct ps3_system_bus_device *dev)
 	snd_ps3_init_avsetting(&the_card);
 
 	/* register the card */
-	snd_card_set_dev(the_card.card, &dev->core);
 	ret = snd_card_register(the_card.card);
 	if (ret < 0)
 		goto clean_dma_map;
-- 
1.8.5.2
