From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 13/24] ALSA: ctl: change prototype of local
	function for ELEM_WRITE ioctl
Date: Sat, 25 Nov 2017 18:19:55 +0900
Message-ID: <20171125092006.24408-14-o-takashi@sakamocchi.jp>
References: <20171125092006.24408-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id 1EE212673DF
 for <alsa-devel@alsa-project.org>; Sat, 25 Nov 2017 10:20:15 +0100 (CET)
In-Reply-To: <20171125092006.24408-1-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, perex@perex.cz
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

When investigating compatibility layer, several functions for native ABI
are called by the layer. A 'snd_ctl_elem_write()' is such a function,
while it's prototype is not similar to the others. This will bring a
future inconvenience in integration of the layer.

This commit changes its prototype to get a first argument for data of
'struct snd_ctl_file' type.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/core/control.c        | 19 +++++++++----------
 sound/core/control_compat.c |  6 +++---
 2 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/sound/core/control.c b/sound/core/control.c
index 4cb950e310bf..c7b43f3f069b 100644
--- a/sound/core/control.c
+++ b/sound/core/control.c
@@ -949,7 +949,7 @@ static int snd_ctl_elem_read_user(struct snd_card *card,
 	return result;
 }
 
-static int snd_ctl_elem_write(struct snd_card *card, struct snd_ctl_file *file,
+static int snd_ctl_elem_write(struct snd_ctl_file *ctl_file,
 			      struct snd_ctl_elem_value *control)
 {
 	struct snd_kcontrol *kctl;
@@ -957,12 +957,12 @@ static int snd_ctl_elem_write(struct snd_card *card, struct snd_ctl_file *file,
 	unsigned int index_offset;
 	int result;
 
-	result = snd_power_wait(file->card, SNDRV_CTL_POWER_D0);
+	result = snd_power_wait(ctl_file->card, SNDRV_CTL_POWER_D0);
 	if (result < 0)
 		return result;
 
-	down_write(&file->card->controls_rwsem);
-	kctl = snd_ctl_find_id(file->card, &control->id);
+	down_write(&ctl_file->card->controls_rwsem);
+	kctl = snd_ctl_find_id(ctl_file->card, &control->id);
 	if (kctl == NULL) {
 		result = -ENOENT;
 		goto end;
@@ -971,7 +971,7 @@ static int snd_ctl_elem_write(struct snd_card *card, struct snd_ctl_file *file,
 	index_offset = snd_ctl_get_ioff(kctl, &control->id);
 	vd = &kctl->vd[index_offset];
 	if (!(vd->access & SNDRV_CTL_ELEM_ACCESS_WRITE) || kctl->put == NULL ||
-	    (file && vd->owner && vd->owner != file)) {
+	    (ctl_file && vd->owner && vd->owner != ctl_file)) {
 		result = -EPERM;
 		goto end;
 	}
@@ -980,25 +980,24 @@ static int snd_ctl_elem_write(struct snd_card *card, struct snd_ctl_file *file,
 	result = kctl->put(kctl, control);
 	if (result > 0) {
 		struct snd_ctl_elem_id id = control->id;
-		snd_ctl_notify(file->card, SNDRV_CTL_EVENT_MASK_VALUE, &id);
+		snd_ctl_notify(ctl_file->card, SNDRV_CTL_EVENT_MASK_VALUE, &id);
 	}
 end:
-	up_write(&file->card->controls_rwsem);
+	up_write(&ctl_file->card->controls_rwsem);
 	return 0;
 }
 
-static int snd_ctl_elem_write_user(struct snd_ctl_file *file,
+static int snd_ctl_elem_write_user(struct snd_ctl_file *ctl_file,
 				   struct snd_ctl_elem_value __user *_control)
 {
 	struct snd_ctl_elem_value *control;
-	struct snd_card *card;
 	int result;
 
 	control = memdup_user(_control, sizeof(*control));
 	if (IS_ERR(control))
 		return PTR_ERR(control);
 
-	result = snd_ctl_elem_write(card, file, control);
+	result = snd_ctl_elem_write(ctl_file, control);
 	if (result < 0)
 		goto error;
 
diff --git a/sound/core/control_compat.c b/sound/core/control_compat.c
index b3f0be74ba0f..11e0966f86bb 100644
--- a/sound/core/control_compat.c
+++ b/sound/core/control_compat.c
@@ -697,11 +697,11 @@ static int ctl_elem_read_user(struct snd_card *card,
 	return err;
 }
 
-static int ctl_elem_write_user(struct snd_ctl_file *file,
+static int ctl_elem_write_user(struct snd_ctl_file *ctl_file,
 			       void __user *userdata, void __user *valuep)
 {
 	struct snd_ctl_elem_value *data;
-	struct snd_card *card = file->card;
+	struct snd_card *card = ctl_file->card;
 	int err, type, count;
 
 	data = kzalloc(sizeof(*data), GFP_KERNEL);
@@ -713,7 +713,7 @@ static int ctl_elem_write_user(struct snd_ctl_file *file,
 	if (err < 0)
 		goto error;
 
-	err = snd_ctl_elem_write(card, file, data);
+	err = snd_ctl_elem_write(ctl_file, data);
 	if (err < 0)
 		goto error;
 	err = copy_ctl_value_to_user(userdata, valuep, data, type, count);
-- 
2.14.1
