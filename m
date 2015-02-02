From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 14/14] ALSA: Drop snd_get_device() helper
Date: Mon,  2 Feb 2015 11:24:38 +0100
Message-ID: <1422872678-4815-15-git-send-email-tiwai@suse.de>
References: <1422872678-4815-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 94037260522
 for <alsa-devel@alsa-project.org>; Mon,  2 Feb 2015 11:24:41 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 235B2AD89
 for <alsa-devel@alsa-project.org>; Mon,  2 Feb 2015 10:24:40 +0000 (UTC)
In-Reply-To: <1422872678-4815-1-git-send-email-tiwai@suse.de>
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

Since the device is no longer hidden but embedded into each component,
we no longer need snd_get_device().  Let's drop it and relevant codes.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/sound/core.h |  1 -
 sound/core/sound.c   | 43 -------------------------------------------
 2 files changed, 44 deletions(-)

diff --git a/include/sound/core.h b/include/sound/core.h
index 67ac309bb218..58882bfacdd7 100644
--- a/include/sound/core.h
+++ b/include/sound/core.h
@@ -214,7 +214,6 @@ int snd_register_device(int type, struct snd_card *card, int dev,
 			void *private_data, struct device *device);
 int snd_unregister_device(struct device *dev);
 void *snd_lookup_minor_data(unsigned int minor, int type);
-struct device *snd_get_device(int type, struct snd_card *card, int dev);
 
 #ifdef CONFIG_SND_OSSEMUL
 int snd_register_oss_device(int type, struct snd_card *card, int dev,
diff --git a/sound/core/sound.c b/sound/core/sound.c
index 515e62506541..6f8ea40a7a8e 100644
--- a/sound/core/sound.c
+++ b/sound/core/sound.c
@@ -303,24 +303,6 @@ int snd_register_device(int type, struct snd_card *card, int dev,
 }
 EXPORT_SYMBOL(snd_register_device);
 
-/* find the matching minor record
- * return the index of snd_minor, or -1 if not found
- */
-static int find_snd_minor(int type, struct snd_card *card, int dev)
-{
-	int cardnum, minor;
-	struct snd_minor *mptr;
-
-	cardnum = card ? card->number : -1;
-	for (minor = 0; minor < ARRAY_SIZE(snd_minors); ++minor)
-		if ((mptr = snd_minors[minor]) != NULL &&
-		    mptr->type == type &&
-		    mptr->card == cardnum &&
-		    mptr->device == dev)
-			return minor;
-	return -1;
-}
-
 /**
  * snd_unregister_device - unregister the device on the given card
  * @type: the device type, SNDRV_DEVICE_TYPE_XXX
@@ -354,31 +336,6 @@ int snd_unregister_device(struct device *dev)
 }
 EXPORT_SYMBOL(snd_unregister_device);
 
-/**
- * snd_get_device - get the assigned device to the given type and device number
- * @type: the device type, SNDRV_DEVICE_TYPE_XXX
- * @card:the card instance
- * @dev: the device index
- *
- * The caller needs to release it via put_device() after using it.
- */
-struct device *snd_get_device(int type, struct snd_card *card, int dev)
-{
-	int minor;
-	struct device *d = NULL;
-
-	mutex_lock(&sound_mutex);
-	minor = find_snd_minor(type, card, dev);
-	if (minor >= 0) {
-		d = snd_minors[minor]->dev;
-		if (d)
-			get_device(d);
-	}
-	mutex_unlock(&sound_mutex);
-	return d;
-}
-EXPORT_SYMBOL(snd_get_device);
-
 #ifdef CONFIG_PROC_FS
 /*
  *  INFO PART
-- 
2.2.2
