From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 06/10] ALSA: hwdep: Use standard printk helpers
Date: Wed, 12 Feb 2014 12:33:08 +0100
Message-ID: <1392204792-12655-7-git-send-email-tiwai@suse.de>
References: <1392204792-12655-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 7CEC726528F
 for <alsa-devel@alsa-project.org>; Wed, 12 Feb 2014 12:33:18 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id E9474AC6E
 for <alsa-devel@alsa-project.org>; Wed, 12 Feb 2014 11:33:17 +0000 (UTC)
In-Reply-To: <1392204792-12655-1-git-send-email-tiwai@suse.de>
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

Use dev_err() & co as much as possible.  If not available (no device
assigned at the calling point), use pr_xxx() helpers instead.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/hwdep.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/sound/core/hwdep.c b/sound/core/hwdep.c
index 0f73f6951110..8c778659fa03 100644
--- a/sound/core/hwdep.c
+++ b/sound/core/hwdep.c
@@ -375,7 +375,7 @@ int snd_hwdep_new(struct snd_card *card, char *id, int device,
 		*rhwdep = NULL;
 	hwdep = kzalloc(sizeof(*hwdep), GFP_KERNEL);
 	if (hwdep == NULL) {
-		snd_printk(KERN_ERR "hwdep: cannot allocate\n");
+		dev_err(card->dev, "hwdep: cannot allocate\n");
 		return -ENOMEM;
 	}
 	hwdep->card = card;
@@ -415,11 +415,12 @@ static int snd_hwdep_dev_free(struct snd_device *device)
 static int snd_hwdep_dev_register(struct snd_device *device)
 {
 	struct snd_hwdep *hwdep = device->device_data;
+	struct snd_card *card = hwdep->card;
 	int err;
 	char name[32];
 
 	mutex_lock(&register_mutex);
-	if (snd_hwdep_search(hwdep->card, hwdep->device)) {
+	if (snd_hwdep_search(card, hwdep->device)) {
 		mutex_unlock(&register_mutex);
 		return -EBUSY;
 	}
@@ -428,8 +429,9 @@ static int snd_hwdep_dev_register(struct snd_device *device)
 	if ((err = snd_register_device(SNDRV_DEVICE_TYPE_HWDEP,
 				       hwdep->card, hwdep->device,
 				       &snd_hwdep_f_ops, hwdep, name)) < 0) {
-		snd_printk(KERN_ERR "unable to register hardware dependent device %i:%i\n",
-			   hwdep->card->number, hwdep->device);
+		dev_err(card->dev,
+			"unable to register hardware dependent device %i:%i\n",
+			card->number, hwdep->device);
 		list_del(&hwdep->list);
 		mutex_unlock(&register_mutex);
 		return err;
@@ -438,13 +440,15 @@ static int snd_hwdep_dev_register(struct snd_device *device)
 	hwdep->ossreg = 0;
 	if (hwdep->oss_type >= 0) {
 		if ((hwdep->oss_type == SNDRV_OSS_DEVICE_TYPE_DMFM) && (hwdep->device != 0)) {
-			snd_printk (KERN_WARNING "only hwdep device 0 can be registered as OSS direct FM device!\n");
+			dev_warn(card->dev,
+				 "only hwdep device 0 can be registered as OSS direct FM device!\n");
 		} else {
 			if (snd_register_oss_device(hwdep->oss_type,
-						    hwdep->card, hwdep->device,
+						    card, hwdep->device,
 						    &snd_hwdep_f_ops, hwdep) < 0) {
-				snd_printk(KERN_ERR "unable to register OSS compatibility device %i:%i\n",
-					   hwdep->card->number, hwdep->device);
+				dev_err(card->dev,
+					"unable to register OSS compatibility device %i:%i\n",
+					card->number, hwdep->device);
 			} else
 				hwdep->ossreg = 1;
 		}
-- 
1.8.5.2
