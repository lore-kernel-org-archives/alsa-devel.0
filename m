From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 04/14] ALSA: control: Embed struct device
Date: Mon,  2 Feb 2015 11:24:28 +0100
Message-ID: <1422872678-4815-5-git-send-email-tiwai@suse.de>
References: <1422872678-4815-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 0BE592604BB
 for <alsa-devel@alsa-project.org>; Mon,  2 Feb 2015 11:24:41 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id AD70BACBE
 for <alsa-devel@alsa-project.org>; Mon,  2 Feb 2015 10:24:39 +0000 (UTC)
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

This patch embeds a struct device for the control device into the card
object and avoid the device creation at registration time.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/sound/core.h |  1 +
 sound/core/control.c | 40 ++++++++++++++++------------------------
 2 files changed, 17 insertions(+), 24 deletions(-)

diff --git a/include/sound/core.h b/include/sound/core.h
index de7a878217d7..4b7e04e85e16 100644
--- a/include/sound/core.h
+++ b/include/sound/core.h
@@ -109,6 +109,7 @@ struct snd_card {
 								private data */
 	struct list_head devices;	/* devices */
 
+	struct device ctl_dev;		/* control device */
 	unsigned int last_numid;	/* last used numeric ID */
 	struct rw_semaphore controls_rwsem;	/* controls list lock */
 	rwlock_t ctl_files_rwlock;	/* ctl_files list lock */
diff --git a/sound/core/control.c b/sound/core/control.c
index cd246a0bcd55..e214fabbc671 100644
--- a/sound/core/control.c
+++ b/sound/core/control.c
@@ -1660,19 +1660,10 @@ static const struct file_operations snd_ctl_f_ops =
 static int snd_ctl_dev_register(struct snd_device *device)
 {
 	struct snd_card *card = device->device_data;
-	int err, cardnum;
-	char name[16];
 
-	if (snd_BUG_ON(!card))
-		return -ENXIO;
-	cardnum = card->number;
-	if (snd_BUG_ON(cardnum < 0 || cardnum >= SNDRV_CARDS))
-		return -ENXIO;
-	sprintf(name, "controlC%i", cardnum);
-	if ((err = snd_register_device(SNDRV_DEVICE_TYPE_CONTROL, card, -1,
-				       &snd_ctl_f_ops, card, name)) < 0)
-		return err;
-	return 0;
+	return snd_register_device_for_dev(SNDRV_DEVICE_TYPE_CONTROL, card,
+					   -1, &snd_ctl_f_ops, card,
+					   &card->ctl_dev, NULL, NULL);
 }
 
 /*
@@ -1682,13 +1673,6 @@ static int snd_ctl_dev_disconnect(struct snd_device *device)
 {
 	struct snd_card *card = device->device_data;
 	struct snd_ctl_file *ctl;
-	int err, cardnum;
-
-	if (snd_BUG_ON(!card))
-		return -ENXIO;
-	cardnum = card->number;
-	if (snd_BUG_ON(cardnum < 0 || cardnum >= SNDRV_CARDS))
-		return -ENXIO;
 
 	read_lock(&card->ctl_files_rwlock);
 	list_for_each_entry(ctl, &card->ctl_files, list) {
@@ -1697,10 +1681,7 @@ static int snd_ctl_dev_disconnect(struct snd_device *device)
 	}
 	read_unlock(&card->ctl_files_rwlock);
 
-	if ((err = snd_unregister_device(SNDRV_DEVICE_TYPE_CONTROL,
-					 card, -1)) < 0)
-		return err;
-	return 0;
+	return snd_unregister_device(SNDRV_DEVICE_TYPE_CONTROL, card, -1);
 }
 
 /*
@@ -1717,6 +1698,7 @@ static int snd_ctl_dev_free(struct snd_device *device)
 		snd_ctl_remove(card, control);
 	}
 	up_write(&card->controls_rwsem);
+	put_device(&card->ctl_dev);
 	return 0;
 }
 
@@ -1731,10 +1713,20 @@ int snd_ctl_create(struct snd_card *card)
 		.dev_register =	snd_ctl_dev_register,
 		.dev_disconnect = snd_ctl_dev_disconnect,
 	};
+	int err;
 
 	if (snd_BUG_ON(!card))
 		return -ENXIO;
-	return snd_device_new(card, SNDRV_DEV_CONTROL, card, &ops);
+	if (snd_BUG_ON(card->number < 0 || card->number >= SNDRV_CARDS))
+		return -ENXIO;
+
+	snd_device_initialize(&card->ctl_dev, card);
+	dev_set_name(&card->ctl_dev, "controlC%d", card->number);
+
+	err = snd_device_new(card, SNDRV_DEV_CONTROL, card, &ops);
+	if (err < 0)
+		put_device(&card->ctl_dev);
+	return err;
 }
 
 /*
-- 
2.2.2
