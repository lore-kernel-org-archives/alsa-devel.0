From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 03/10] ALSA: hwdep: Allow to assign the given
	parent
Date: Wed, 26 Feb 2014 07:47:25 +0100
Message-ID: <1393397252-11690-4-git-send-email-tiwai@suse.de>
References: <1393397252-11690-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 28DFD265512
 for <alsa-devel@alsa-project.org>; Wed, 26 Feb 2014 07:47:38 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id E753C75022
 for <alsa-devel@alsa-project.org>; Wed, 26 Feb 2014 06:47:37 +0000 (UTC)
In-Reply-To: <1393397252-11690-1-git-send-email-tiwai@suse.de>
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

Just like PCM, allow hwdep to be assigned to a different parent device
than the card.  It'll be used for the HD-audio codec device in the
later patches.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/sound/hwdep.h |  1 +
 sound/core/hwdep.c    | 19 ++++++++++++-------
 2 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/include/sound/hwdep.h b/include/sound/hwdep.h
index 193a3c57ed25..ae04a3ec9c77 100644
--- a/include/sound/hwdep.h
+++ b/include/sound/hwdep.h
@@ -68,6 +68,7 @@ struct snd_hwdep {
 	wait_queue_head_t open_wait;
 	void *private_data;
 	void (*private_free) (struct snd_hwdep *hwdep);
+	struct device *dev;
 	const struct attribute_group **groups;
 
 	struct mutex open_mutex;
diff --git a/sound/core/hwdep.c b/sound/core/hwdep.c
index 825cd2847940..d6eb3ef3e3c7 100644
--- a/sound/core/hwdep.c
+++ b/sound/core/hwdep.c
@@ -416,6 +416,7 @@ static int snd_hwdep_dev_register(struct snd_device *device)
 {
 	struct snd_hwdep *hwdep = device->device_data;
 	struct snd_card *card = hwdep->card;
+	struct device *dev;
 	int err;
 	char name[32];
 
@@ -426,10 +427,14 @@ static int snd_hwdep_dev_register(struct snd_device *device)
 	}
 	list_add_tail(&hwdep->list, &snd_hwdep_devices);
 	sprintf(name, "hwC%iD%i", hwdep->card->number, hwdep->device);
-	if ((err = snd_register_device(SNDRV_DEVICE_TYPE_HWDEP,
-				       hwdep->card, hwdep->device,
-				       &snd_hwdep_f_ops, hwdep, name)) < 0) {
-		dev_err(card->dev,
+	dev = hwdep->dev;
+	if (!dev)
+		dev = snd_card_get_device_link(hwdep->card);
+	err = snd_register_device_for_dev(SNDRV_DEVICE_TYPE_HWDEP,
+					  hwdep->card, hwdep->device,
+					  &snd_hwdep_f_ops, hwdep, name, dev);
+	if (err < 0) {
+		dev_err(dev,
 			"unable to register hardware dependent device %i:%i\n",
 			card->number, hwdep->device);
 		list_del(&hwdep->list);
@@ -445,7 +450,7 @@ static int snd_hwdep_dev_register(struct snd_device *device)
 				dev_set_drvdata(d, hwdep->private_data);
 			err = sysfs_create_groups(&d->kobj, hwdep->groups);
 			if (err < 0)
-				dev_warn(card->dev,
+				dev_warn(dev,
 					 "hwdep %d:%d: cannot create sysfs groups\n",
 					 card->number, hwdep->device);
 			put_device(d);
@@ -456,13 +461,13 @@ static int snd_hwdep_dev_register(struct snd_device *device)
 	hwdep->ossreg = 0;
 	if (hwdep->oss_type >= 0) {
 		if ((hwdep->oss_type == SNDRV_OSS_DEVICE_TYPE_DMFM) && (hwdep->device != 0)) {
-			dev_warn(card->dev,
+			dev_warn(dev,
 				 "only hwdep device 0 can be registered as OSS direct FM device!\n");
 		} else {
 			if (snd_register_oss_device(hwdep->oss_type,
 						    card, hwdep->device,
 						    &snd_hwdep_f_ops, hwdep) < 0) {
-				dev_err(card->dev,
+				dev_err(dev,
 					"unable to register OSS compatibility device %i:%i\n",
 					card->number, hwdep->device);
 			} else
-- 
1.9.0
