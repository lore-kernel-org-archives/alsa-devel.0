From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 2/2] ALSA: core: reduce stack usage related to
	snd_ctl_new()
Date: Tue, 10 Mar 2015 22:13:31 +0900
Message-ID: <1425993211-2370-3-git-send-email-o-takashi@sakamocchi.jp>
References: <1425570206-21026-1-git-send-email-o-takashi@sakamocchi.jp>
 <1425993211-2370-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp301.phy.lolipop.jp (smtp301.phy.lolipop.jp [210.157.22.84])
 by alsa0.perex.cz (Postfix) with ESMTP id A9E242615C0
 for <alsa-devel@alsa-project.org>; Tue, 10 Mar 2015 14:13:35 +0100 (CET)
In-Reply-To: <1425993211-2370-1-git-send-email-o-takashi@sakamocchi.jp>
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

The callers of snd_ctl_new() need to have 'struct snd_kcontrol' data,
and pass the data as template. Then, the function allocates the structure
data again and copy from the template. This is a waste of resources.
Especially, the callers use large stack for the template.

This commit removes a need of template for the function, thus, changes
the prototype of snd_ctl_new(). Furthermore, this commit changes
the code of callers, snd_ctl_new1() and snd_ctl_elem_add() for better
shape.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/core/control.c | 213 +++++++++++++++++++++++++++++++--------------------
 1 file changed, 130 insertions(+), 83 deletions(-)

diff --git a/sound/core/control.c b/sound/core/control.c
index 0b85cbc..e2d0ece 100644
--- a/sound/core/control.c
+++ b/sound/core/control.c
@@ -192,36 +192,43 @@ void snd_ctl_notify(struct snd_card *card, unsigned int mask,
 EXPORT_SYMBOL(snd_ctl_notify);
 
 /**
- * snd_ctl_new - create a control instance from the template
- * @control: the control template
- * @access: the default control access
+ * snd_ctl_new - create a new control instance with some elements
+ * @kctl: the pointer to store new control instance
+ * @count: the number of elements in this control
+ * @access: the default access flags for elements in this control
+ * @file: given when locking these elements
  *
- * Allocates a new struct snd_kcontrol instance and copies the given template 
- * to the new instance. It does not copy volatile data (access).
+ * Allocates a memory object for a new control instance. The instance has
+ * elements as many as the given number (@count). Each element has given
+ * access permissions (@access). Each element is locked when @file is given.
  *
- * Return: The pointer of the new instance, or %NULL on failure.
+ * Return: 0 on success, error code on failure
  */
-static struct snd_kcontrol *snd_ctl_new(struct snd_kcontrol *control,
-					unsigned int access)
+static int snd_ctl_new(struct snd_kcontrol **kctl, unsigned int count,
+		       unsigned int access, struct snd_ctl_file *file)
 {
-	struct snd_kcontrol *kctl;
+	unsigned int size;
 	unsigned int idx;
 	
-	if (snd_BUG_ON(!control || !control->count))
-		return NULL;
+	if ((count == 0) || (count > MAX_CONTROL_COUNT))
+		return -EINVAL;
 
-	if (control->count > MAX_CONTROL_COUNT)
-		return NULL;
+	size  = sizeof(struct snd_kcontrol);
+	size += sizeof(struct snd_kcontrol_volatile) * count;
 
-	kctl = kzalloc(sizeof(*kctl) + sizeof(struct snd_kcontrol_volatile) * control->count, GFP_KERNEL);
-	if (kctl == NULL) {
+	*kctl = kzalloc(size, GFP_KERNEL);
+	if (*kctl == NULL) {
 		pr_err("ALSA: Cannot allocate control instance\n");
-		return NULL;
+		return -ENOMEM;
 	}
-	*kctl = *control;
-	for (idx = 0; idx < kctl->count; idx++)
-		kctl->vd[idx].access = access;
-	return kctl;
+
+	for (idx = 0; idx < count; idx++) {
+		(*kctl)->vd[idx].access = access;
+		(*kctl)->vd[idx].owner = file;
+	}
+	(*kctl)->count = count;
+
+	return 0;
 }
 
 /**
@@ -238,37 +245,53 @@ static struct snd_kcontrol *snd_ctl_new(struct snd_kcontrol *control,
 struct snd_kcontrol *snd_ctl_new1(const struct snd_kcontrol_new *ncontrol,
 				  void *private_data)
 {
-	struct snd_kcontrol kctl;
+	struct snd_kcontrol *kctl;
+	unsigned int count;
 	unsigned int access;
+	int err;
 	
 	if (snd_BUG_ON(!ncontrol || !ncontrol->info))
 		return NULL;
-	memset(&kctl, 0, sizeof(kctl));
-	kctl.id.iface = ncontrol->iface;
-	kctl.id.device = ncontrol->device;
-	kctl.id.subdevice = ncontrol->subdevice;
+
+	count = ncontrol->count;
+	if (count == 0)
+		count = 1;
+
+	access = ncontrol->access;
+	if (access == 0)
+		access = SNDRV_CTL_ELEM_ACCESS_READWRITE;
+	access &= (SNDRV_CTL_ELEM_ACCESS_READWRITE |
+		   SNDRV_CTL_ELEM_ACCESS_VOLATILE |
+		   SNDRV_CTL_ELEM_ACCESS_INACTIVE |
+		   SNDRV_CTL_ELEM_ACCESS_TLV_READWRITE |
+		   SNDRV_CTL_ELEM_ACCESS_TLV_COMMAND |
+		   SNDRV_CTL_ELEM_ACCESS_TLV_CALLBACK);
+
+	err = snd_ctl_new(&kctl, count, access, NULL);
+	if (err < 0)
+		return NULL;
+
+	/* The 'numid' member is decided when calling snd_ctl_add(). */
+	kctl->id.iface = ncontrol->iface;
+	kctl->id.device = ncontrol->device;
+	kctl->id.subdevice = ncontrol->subdevice;
 	if (ncontrol->name) {
-		strlcpy(kctl.id.name, ncontrol->name, sizeof(kctl.id.name));
-		if (strcmp(ncontrol->name, kctl.id.name) != 0)
+		strlcpy(kctl->id.name, ncontrol->name, sizeof(kctl->id.name));
+		if (strcmp(ncontrol->name, kctl->id.name) != 0)
 			pr_warn("ALSA: Control name '%s' truncated to '%s'\n",
-				ncontrol->name, kctl.id.name);
+				ncontrol->name, kctl->id.name);
 	}
-	kctl.id.index = ncontrol->index;
-	kctl.count = ncontrol->count ? ncontrol->count : 1;
-	access = ncontrol->access == 0 ? SNDRV_CTL_ELEM_ACCESS_READWRITE :
-		 (ncontrol->access & (SNDRV_CTL_ELEM_ACCESS_READWRITE|
-				      SNDRV_CTL_ELEM_ACCESS_VOLATILE|
-				      SNDRV_CTL_ELEM_ACCESS_INACTIVE|
-				      SNDRV_CTL_ELEM_ACCESS_TLV_READWRITE|
-				      SNDRV_CTL_ELEM_ACCESS_TLV_COMMAND|
-				      SNDRV_CTL_ELEM_ACCESS_TLV_CALLBACK));
-	kctl.info = ncontrol->info;
-	kctl.get = ncontrol->get;
-	kctl.put = ncontrol->put;
-	kctl.tlv.p = ncontrol->tlv.p;
-	kctl.private_value = ncontrol->private_value;
-	kctl.private_data = private_data;
-	return snd_ctl_new(&kctl, access);
+	kctl->id.index = ncontrol->index;
+
+	kctl->info = ncontrol->info;
+	kctl->get = ncontrol->get;
+	kctl->put = ncontrol->put;
+	kctl->tlv.p = ncontrol->tlv.p;
+
+	kctl->private_value = ncontrol->private_value;
+	kctl->private_data = private_data;
+
+	return kctl;
 }
 EXPORT_SYMBOL(snd_ctl_new1);
 
@@ -1179,44 +1202,48 @@ static int snd_ctl_elem_add(struct snd_ctl_file *file,
 		[SNDRV_CTL_ELEM_TYPE_INTEGER64] = 64,
 	};
 	struct snd_card *card = file->card;
-	struct snd_kcontrol kctl, *_kctl;
+	struct snd_kcontrol *kctl;
+	unsigned int count;
 	unsigned int access;
 	long private_size;
 	struct user_element *ue;
-	int idx, err;
-
-	access = info->access == 0 ? SNDRV_CTL_ELEM_ACCESS_READWRITE :
-		(info->access & (SNDRV_CTL_ELEM_ACCESS_READWRITE|
-				 SNDRV_CTL_ELEM_ACCESS_INACTIVE|
-				 SNDRV_CTL_ELEM_ACCESS_TLV_READWRITE));
-	info->id.numid = 0;
-	memset(&kctl, 0, sizeof(kctl));
+	int err;
 
+	/* Delete a control to replace them if needed. */
 	if (replace) {
+		info->id.numid = 0;
 		err = snd_ctl_remove_user_ctl(file, &info->id);
 		if (err)
 			return err;
 	}
 
-	if (card->user_ctl_count >= MAX_USER_CONTROLS)
+	/*
+	 * The number of userspace controls are counted control by control,
+	 * not element by element.
+	 */
+	if (card->user_ctl_count + 1 > MAX_USER_CONTROLS)
 		return -ENOMEM;
 
-	memcpy(&kctl.id, &info->id, sizeof(info->id));
-	kctl.count = info->owner ? info->owner : 1;
-	access |= SNDRV_CTL_ELEM_ACCESS_USER;
-	if (info->type == SNDRV_CTL_ELEM_TYPE_ENUMERATED)
-		kctl.info = snd_ctl_elem_user_enum_info;
-	else
-		kctl.info = snd_ctl_elem_user_info;
-	if (access & SNDRV_CTL_ELEM_ACCESS_READ)
-		kctl.get = snd_ctl_elem_user_get;
-	if (access & SNDRV_CTL_ELEM_ACCESS_WRITE)
-		kctl.put = snd_ctl_elem_user_put;
-	if (access & SNDRV_CTL_ELEM_ACCESS_TLV_READWRITE) {
-		kctl.tlv.c = snd_ctl_elem_user_tlv;
+	/* Check the number of elements for this userspace control. */
+	count = info->owner;
+	if (count == 0)
+		count = 1;
+
+	/* Arrange access permissions if needed. */
+	access = info->access;
+	if (access == 0)
+		access = SNDRV_CTL_ELEM_ACCESS_READWRITE;
+	access &= (SNDRV_CTL_ELEM_ACCESS_READWRITE |
+		   SNDRV_CTL_ELEM_ACCESS_INACTIVE |
+		   SNDRV_CTL_ELEM_ACCESS_TLV_READWRITE);
+	if (access & SNDRV_CTL_ELEM_ACCESS_TLV_READWRITE)
 		access |= SNDRV_CTL_ELEM_ACCESS_TLV_CALLBACK;
-	}
+	access |= SNDRV_CTL_ELEM_ACCESS_USER;
 
+	/*
+	 * Check information and calculate the size of data specific to
+	 * this userspace control.
+	 */
 	if (info->type < SNDRV_CTL_ELEM_TYPE_BOOLEAN ||
 	    info->type > SNDRV_CTL_ELEM_TYPE_INTEGER64)
 		return -EINVAL;
@@ -1226,11 +1253,27 @@ static int snd_ctl_elem_add(struct snd_ctl_file *file,
 	if (info->count < 1 ||
 	    info->count > max_value_counts[info->type])
 		return -EINVAL;
-
 	private_size = value_sizes[info->type] * info->count;
-	ue = kzalloc(sizeof(struct user_element) + private_size, GFP_KERNEL);
-	if (ue == NULL)
+
+	/*
+	 * Keep memory object for this userspace control. After passing this
+	 * code block, the instance should be freed by snd_ctl_free_one().
+	 *
+	 * Note that these elements in this control are locked.
+	 */
+	err = snd_ctl_new(&kctl, count, access, file);
+	if (err < 0)
+		return err;
+	kctl->private_data = kzalloc(sizeof(struct user_element) + private_size,
+				     GFP_KERNEL);
+	if (kctl->private_data == NULL) {
+		kfree(kctl);
 		return -ENOMEM;
+	}
+	kctl->private_free = snd_ctl_elem_user_free;
+
+	/* Set private data for this userspace control. */
+	ue = (struct user_element *)kctl->private_data;
 	ue->card = card;
 	ue->info = *info;
 	ue->info.access = 0;
@@ -1239,21 +1282,25 @@ static int snd_ctl_elem_add(struct snd_ctl_file *file,
 	if (ue->info.type == SNDRV_CTL_ELEM_TYPE_ENUMERATED) {
 		err = snd_ctl_elem_init_enum_names(ue);
 		if (err < 0) {
-			kfree(ue);
+			snd_ctl_free_one(kctl);
 			return err;
 		}
 	}
-	kctl.private_free = snd_ctl_elem_user_free;
-	_kctl = snd_ctl_new(&kctl, access);
-	if (_kctl == NULL) {
-		kfree(ue->priv_data);
-		kfree(ue);
-		return -ENOMEM;
-	}
-	_kctl->private_data = ue;
-	for (idx = 0; idx < _kctl->count; idx++)
-		_kctl->vd[idx].owner = file;
-	err = snd_ctl_add(card, _kctl);
+
+	/* Set callback functions. */
+	if (info->type == SNDRV_CTL_ELEM_TYPE_ENUMERATED)
+		kctl->info = snd_ctl_elem_user_enum_info;
+	else
+		kctl->info = snd_ctl_elem_user_info;
+	if (access & SNDRV_CTL_ELEM_ACCESS_READ)
+		kctl->get = snd_ctl_elem_user_get;
+	if (access & SNDRV_CTL_ELEM_ACCESS_WRITE)
+		kctl->put = snd_ctl_elem_user_put;
+	if (access & SNDRV_CTL_ELEM_ACCESS_TLV_READWRITE)
+		kctl->tlv.c = snd_ctl_elem_user_tlv;
+
+	/* This function manage to free the instance on failure. */
+	err = snd_ctl_add(card, kctl);
 	if (err < 0)
 		return err;
 
-- 
2.1.0
