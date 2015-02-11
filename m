From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 6/8] ALSA: control: fix over 80 characters lines
Date: Wed, 11 Feb 2015 19:37:30 +0900
Message-ID: <1423651052-19593-7-git-send-email-o-takashi@sakamocchi.jp>
References: <1423651052-19593-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp303.phy.lolipop.jp (smtp303.phy.lolipop.jp [210.157.22.87])
 by alsa0.perex.cz (Postfix) with ESMTP id 387072605FF
 for <alsa-devel@alsa-project.org>; Wed, 11 Feb 2015 11:37:42 +0100 (CET)
In-Reply-To: <1423651052-19593-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, tiwai@suse.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This commit arranges lines over 80 characters, just related to this
patchset.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/core/control.c | 58 ++++++++++++++++++++++++++++++----------------------
 1 file changed, 34 insertions(+), 24 deletions(-)

diff --git a/sound/core/control.c b/sound/core/control.c
index 15af804..c18ac04 100644
--- a/sound/core/control.c
+++ b/sound/core/control.c
@@ -205,6 +205,7 @@ static struct snd_kcontrol *snd_ctl_new(struct snd_kcontrol *control,
 					unsigned int access)
 {
 	struct snd_kcontrol *kctl;
+	unsigned int size;
 	unsigned int i;
 	
 	if (snd_BUG_ON(!control || !control->count))
@@ -213,7 +214,9 @@ static struct snd_kcontrol *snd_ctl_new(struct snd_kcontrol *control,
 	if (control->count > MAX_CONTROL_COUNT)
 		return NULL;
 
-	kctl = kzalloc(sizeof(*kctl) + sizeof(struct snd_kcontrol_volatile) * control->count, GFP_KERNEL);
+	size  = sizeof(*kctl);
+	size += sizeof(struct snd_kcontrol_volatile) * control->count;
+	kctl = kzalloc(size, GFP_KERNEL);
 	if (kctl == NULL) {
 		pr_err("ALSA: Cannot allocate control instance\n");
 		return NULL;
@@ -314,11 +317,12 @@ static int snd_ctl_find_hole(struct snd_card *card, unsigned int count)
 	unsigned int iter = 100000;
 
 	while (snd_ctl_remove_numid_conflict(card, count)) {
-		if (--iter == 0) {
-			/* this situation is very unlikely */
-			dev_err(card->dev, "unable to allocate new control numid\n");
-			return -ENOMEM;
-		}
+		if (--iter != 0)
+			continue;
+
+		/* this situation is very unlikely */
+		dev_err(card->dev, "unable to allocate new control numid\n");
+		return -ENOMEM;
 	}
 	return 0;
 }
@@ -355,12 +359,9 @@ int snd_ctl_add(struct snd_card *card, struct snd_kcontrol *kcontrol)
 	down_write(&card->controls_rwsem);
 	if (snd_ctl_find_id(card, &id)) {
 		up_write(&card->controls_rwsem);
-		dev_err(card->dev, "control %i:%i:%i:%s:%i is already present\n",
-					id.iface,
-					id.device,
-					id.subdevice,
-					id.name,
-					id.index);
+		dev_err(card->dev,
+			"control %i:%i:%i:%s:%i is already present\n",
+			id.iface, id.device, id.subdevice, id.name, id.index);
 		err = -EBUSY;
 		goto error;
 	}
@@ -638,14 +639,16 @@ EXPORT_SYMBOL(snd_ctl_rename_id);
  * Return: The pointer of the instance if found, or %NULL if not.
  *
  */
-struct snd_kcontrol *snd_ctl_find_numid(struct snd_card *card, unsigned int numid)
+struct snd_kcontrol *snd_ctl_find_numid(struct snd_card *card,
+					unsigned int numid)
 {
 	struct snd_kcontrol *kctl;
 
 	if (snd_BUG_ON(!card || !numid))
 		return NULL;
 	list_for_each_entry(kctl, &card->controls, list) {
-		if (kctl->id.numid <= numid && kctl->id.numid + kctl->count > numid)
+		if (kctl->id.numid <= numid &&
+		    kctl->id.numid + kctl->count > numid)
 			return kctl;
 	}
 	return NULL;
@@ -1010,7 +1013,8 @@ struct user_element {
 	unsigned int elem_data_size;	/* size of element data in bytes */
 	void *tlv_data;			/* TLV data */
 	unsigned long tlv_data_size;	/* TLV data size */
-	void *priv_data;		/* private data (like strings for enumerated type) */
+	/* private data (like strings for enumerated type) */
+	void *priv_data;
 };
 
 static int snd_ctl_elem_user_info(struct snd_kcontrol *kcontrol,
@@ -1062,7 +1066,7 @@ static int snd_ctl_elem_user_put(struct snd_kcontrol *kcontrol,
 	struct user_element *ue = kcontrol->private_data;
 
 	mutex_lock(&ue->card->user_ctl_lock);
-	change = memcmp(&ucontrol->value, ue->elem_data, ue->elem_data_size) != 0;
+	change = !!memcmp(&ucontrol->value, ue->elem_data, ue->elem_data_size);
 	if (change)
 		memcpy(ue->elem_data, &ucontrol->value, ue->elem_data_size);
 	mutex_unlock(&ue->card->user_ctl_lock);
@@ -1272,7 +1276,8 @@ static int snd_ctl_elem_add(struct snd_ctl_file *file,
 }
 
 static int snd_ctl_elem_add_user(struct snd_ctl_file *file,
-				 struct snd_ctl_elem_info __user *_info, int replace)
+				 struct snd_ctl_elem_info __user *_info,
+				 int replace)
 {
 	struct snd_ctl_elem_info info;
 	if (copy_from_user(&info, _info, sizeof(info)))
@@ -1373,7 +1378,8 @@ static int snd_ctl_tlv_ioctl(struct snd_ctl_file *file,
 	return err;
 }
 
-static long snd_ctl_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
+static long snd_ctl_ioctl(struct file *file, unsigned int cmd,
+			  unsigned long arg)
 {
 	struct snd_ctl_file *ctl;
 	struct snd_card *card;
@@ -1518,7 +1524,8 @@ static unsigned int snd_ctl_poll(struct file *file, poll_table * wait)
  * register the device-specific control-ioctls.
  * called from each device manager like pcm.c, hwdep.c, etc.
  */
-static int _snd_ctl_register_ioctl(snd_kctl_ioctl_func_t fcn, struct list_head *lists)
+static int _snd_ctl_register_ioctl(snd_kctl_ioctl_func_t fcn,
+				   struct list_head *lists)
 {
 	struct snd_kctl_ioctl *pn;
 
@@ -1793,6 +1800,8 @@ EXPORT_SYMBOL(snd_ctl_boolean_stereo_info);
 int snd_ctl_enum_info(struct snd_ctl_elem_info *info, unsigned int channels,
 		      unsigned int items, const char *const names[])
 {
+	const char *name;
+
 	info->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
 	info->count = channels;
 	info->value.enumerated.items = items;
@@ -1800,11 +1809,12 @@ int snd_ctl_enum_info(struct snd_ctl_elem_info *info, unsigned int channels,
 		return 0;
 	if (info->value.enumerated.item >= items)
 		info->value.enumerated.item = items - 1;
-	WARN(strlen(names[info->value.enumerated.item]) >= sizeof(info->value.enumerated.name),
-	     "ALSA: too long item name '%s'\n",
-	     names[info->value.enumerated.item]);
-	strlcpy(info->value.enumerated.name,
-		names[info->value.enumerated.item],
+
+	name = names[info->value.enumerated.item];
+	WARN(strlen(name) >= sizeof(info->value.enumerated.name),
+	     "ALSA: too long item name '%s'\n", name);
+
+	strlcpy(info->value.enumerated.name, name,
 		sizeof(info->value.enumerated.name));
 	return 0;
 }
-- 
2.1.0
