From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 14/24] ALSA: ctl: change prototype of local
	function for ELEM_READ ioctl
Date: Sat, 25 Nov 2017 18:19:56 +0900
Message-ID: <20171125092006.24408-15-o-takashi@sakamocchi.jp>
References: <20171125092006.24408-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id 1FF70267403
 for <alsa-devel@alsa-project.org>; Sat, 25 Nov 2017 10:20:16 +0100 (CET)
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
are called by the layer. A 'snd_ctl_elem_read()' is such a function,
while it's prototype is not similar to the others. This will bring a
future inconvenience in integration of the layer.

This commit changes its prototype to get a first argument for data of
'struct snd_ctl_file' type.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/core/control.c        | 16 ++++++++--------
 sound/core/control_compat.c | 21 ++++++++++-----------
 2 files changed, 18 insertions(+), 19 deletions(-)

diff --git a/sound/core/control.c b/sound/core/control.c
index c7b43f3f069b..268771ed2939 100644
--- a/sound/core/control.c
+++ b/sound/core/control.c
@@ -894,7 +894,7 @@ static int snd_ctl_elem_info_user(struct snd_ctl_file *ctl, void __user *arg)
 	return err;
 }
 
-static int snd_ctl_elem_read(struct snd_card *card,
+static int snd_ctl_elem_read(struct snd_ctl_file *ctl_file,
 			     struct snd_ctl_elem_value *control)
 {
 	struct snd_kcontrol *kctl;
@@ -902,13 +902,13 @@ static int snd_ctl_elem_read(struct snd_card *card,
 	unsigned int index_offset;
 	int err;
 
-	err = snd_power_wait(card, SNDRV_CTL_POWER_D0);
+	err = snd_power_wait(ctl_file->card, SNDRV_CTL_POWER_D0);
 	if (err < 0)
 		return err;
 
-	down_read(&card->controls_rwsem);
+	down_read(&ctl_file->card->controls_rwsem);
 
-	kctl = snd_ctl_find_id(card, &control->id);
+	kctl = snd_ctl_find_id(ctl_file->card, &control->id);
 	if (kctl == NULL) {
 		err = -ENOENT;
 		goto end;
@@ -924,11 +924,11 @@ static int snd_ctl_elem_read(struct snd_card *card,
 	snd_ctl_build_ioff(&control->id, kctl, index_offset);
 	err = kctl->get(kctl, control);
 end:
-	up_read(&card->controls_rwsem);
+	up_read(&ctl_file->card->controls_rwsem);
 	return err;
 }
 
-static int snd_ctl_elem_read_user(struct snd_card *card,
+static int snd_ctl_elem_read_user(struct snd_ctl_file *ctl_file,
 				  struct snd_ctl_elem_value __user *_control)
 {
 	struct snd_ctl_elem_value *control;
@@ -938,7 +938,7 @@ static int snd_ctl_elem_read_user(struct snd_card *card,
 	if (IS_ERR(control))
 		return PTR_ERR(control);
 
-	result = snd_ctl_elem_read(card, control);
+	result = snd_ctl_elem_read(ctl_file, control);
 	if (result < 0)
 		goto error;
 
@@ -1581,7 +1581,7 @@ static long snd_ctl_ioctl(struct file *file, unsigned int cmd, unsigned long arg
 	case SNDRV_CTL_IOCTL_ELEM_INFO:
 		return snd_ctl_elem_info_user(ctl, argp);
 	case SNDRV_CTL_IOCTL_ELEM_READ:
-		return snd_ctl_elem_read_user(card, argp);
+		return snd_ctl_elem_read_user(ctl, argp);
 	case SNDRV_CTL_IOCTL_ELEM_WRITE:
 		return snd_ctl_elem_write_user(ctl, argp);
 	case SNDRV_CTL_IOCTL_ELEM_LOCK:
diff --git a/sound/core/control_compat.c b/sound/core/control_compat.c
index 11e0966f86bb..d6d1a2bf9542 100644
--- a/sound/core/control_compat.c
+++ b/sound/core/control_compat.c
@@ -673,7 +673,7 @@ static int copy_ctl_value_to_user(void __user *userdata,
 	return 0;
 }
 
-static int ctl_elem_read_user(struct snd_card *card,
+static int ctl_elem_read_user(struct snd_ctl_file *ctl_file,
 			      void __user *userdata, void __user *valuep)
 {
 	struct snd_ctl_elem_value *data;
@@ -683,12 +683,12 @@ static int ctl_elem_read_user(struct snd_card *card,
 	if (data == NULL)
 		return -ENOMEM;
 
-	err = copy_ctl_value_from_user(card, data, userdata, valuep,
+	err = copy_ctl_value_from_user(ctl_file->card, data, userdata, valuep,
 				       &type, &count);
 	if (err < 0)
 		goto error;
 
-	err = snd_ctl_elem_read(card, data);
+	err = snd_ctl_elem_read(ctl_file, data);
 	if (err < 0)
 		goto error;
 	err = copy_ctl_value_to_user(userdata, valuep, data, type, count);
@@ -701,14 +701,13 @@ static int ctl_elem_write_user(struct snd_ctl_file *ctl_file,
 			       void __user *userdata, void __user *valuep)
 {
 	struct snd_ctl_elem_value *data;
-	struct snd_card *card = ctl_file->card;
 	int err, type, count;
 
 	data = kzalloc(sizeof(*data), GFP_KERNEL);
 	if (data == NULL)
 		return -ENOMEM;
 
-	err = copy_ctl_value_from_user(card, data, userdata, valuep,
+	err = copy_ctl_value_from_user(ctl_file->card, data, userdata, valuep,
 				       &type, &count);
 	if (err < 0)
 		goto error;
@@ -722,10 +721,10 @@ static int ctl_elem_write_user(struct snd_ctl_file *ctl_file,
 	return err;
 }
 
-static int snd_ctl_elem_read_user_compat(struct snd_card *card,
+static int snd_ctl_elem_read_user_compat(struct snd_ctl_file *ctl_file,
 					 struct snd_ctl_elem_value32 __user *data32)
 {
-	return ctl_elem_read_user(card, data32, &data32->value);
+	return ctl_elem_read_user(ctl_file, data32, &data32->value);
 }
 
 static int snd_ctl_elem_write_user_compat(struct snd_ctl_file *file,
@@ -735,10 +734,10 @@ static int snd_ctl_elem_write_user_compat(struct snd_ctl_file *file,
 }
 
 #ifdef CONFIG_X86_X32
-static int snd_ctl_elem_read_user_x32(struct snd_card *card,
+static int snd_ctl_elem_read_user_x32(struct snd_ctl_file *ctl_file,
 				      struct snd_ctl_elem_value_x32 __user *data32)
 {
-	return ctl_elem_read_user(card, data32, &data32->value);
+	return ctl_elem_read_user(ctl_file, data32, &data32->value);
 }
 
 static int snd_ctl_elem_write_user_x32(struct snd_ctl_file *file,
@@ -843,7 +842,7 @@ static long snd_ctl_ioctl_compat(struct file *file, unsigned int cmd,
 	case SNDRV_CTL_IOCTL_ELEM_INFO32:
 		return snd_ctl_elem_info_compat(ctl, argp);
 	case SNDRV_CTL_IOCTL_ELEM_READ32:
-		return snd_ctl_elem_read_user_compat(ctl->card, argp);
+		return snd_ctl_elem_read_user_compat(ctl, argp);
 	case SNDRV_CTL_IOCTL_ELEM_WRITE32:
 		return snd_ctl_elem_write_user_compat(ctl, argp);
 	case SNDRV_CTL_IOCTL_ELEM_ADD32:
@@ -852,7 +851,7 @@ static long snd_ctl_ioctl_compat(struct file *file, unsigned int cmd,
 		return snd_ctl_elem_add_compat(ctl, argp, 1);
 #ifdef CONFIG_X86_X32
 	case SNDRV_CTL_IOCTL_ELEM_READ_X32:
-		return snd_ctl_elem_read_user_x32(ctl->card, argp);
+		return snd_ctl_elem_read_user_x32(ctl, argp);
 	case SNDRV_CTL_IOCTL_ELEM_WRITE_X32:
 		return snd_ctl_elem_write_user_x32(ctl, argp);
 #endif /* CONFIG_X86_X32 */
-- 
2.14.1
