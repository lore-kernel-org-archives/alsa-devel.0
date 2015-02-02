From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 02/14] ALSA: control: Provide a helper to look
	for the preferred subdevice
Date: Mon,  2 Feb 2015 11:24:26 +0100
Message-ID: <1422872678-4815-3-git-send-email-tiwai@suse.de>
References: <1422872678-4815-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 126B32604E0
 for <alsa-devel@alsa-project.org>; Mon,  2 Feb 2015 11:24:41 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id AD24DAC78
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

Instead of open-coding the search over the control file loop, provide
a helper function for the preferred subdevice assigned to the current
process.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/sound/control.h | 11 +++++++++--
 sound/core/control.c    | 27 ++++++++++++++++++++++++---
 sound/core/pcm.c        | 15 +++------------
 sound/core/rawmidi.c    | 14 ++------------
 4 files changed, 38 insertions(+), 29 deletions(-)

diff --git a/include/sound/control.h b/include/sound/control.h
index 042613938a1d..75f3054023f7 100644
--- a/include/sound/control.h
+++ b/include/sound/control.h
@@ -93,12 +93,17 @@ struct snd_kctl_event {
 
 struct pid;
 
+enum {
+	SND_CTL_SUBDEV_PCM,
+	SND_CTL_SUBDEV_RAWMIDI,
+	SND_CTL_SUBDEV_ITEMS,
+};
+
 struct snd_ctl_file {
 	struct list_head list;		/* list of all control files */
 	struct snd_card *card;
 	struct pid *pid;
-	int prefer_pcm_subdevice;
-	int prefer_rawmidi_subdevice;
+	int preferred_subdevice[SND_CTL_SUBDEV_ITEMS];
 	wait_queue_head_t change_sleep;
 	spinlock_t read_lock;
 	struct fasync_struct *fasync;
@@ -138,6 +143,8 @@ int snd_ctl_unregister_ioctl_compat(snd_kctl_ioctl_func_t fcn);
 #define snd_ctl_unregister_ioctl_compat(fcn)
 #endif
 
+int snd_ctl_get_preferred_subdevice(struct snd_card *card, int type);
+
 static inline unsigned int snd_ctl_get_ioffnum(struct snd_kcontrol *kctl, struct snd_ctl_elem_id *id)
 {
 	return id->numid - kctl->id.numid;
diff --git a/sound/core/control.c b/sound/core/control.c
index bb96a467e88d..cd246a0bcd55 100644
--- a/sound/core/control.c
+++ b/sound/core/control.c
@@ -50,7 +50,7 @@ static int snd_ctl_open(struct inode *inode, struct file *file)
 	unsigned long flags;
 	struct snd_card *card;
 	struct snd_ctl_file *ctl;
-	int err;
+	int i, err;
 
 	err = nonseekable_open(inode, file);
 	if (err < 0)
@@ -79,8 +79,8 @@ static int snd_ctl_open(struct inode *inode, struct file *file)
 	init_waitqueue_head(&ctl->change_sleep);
 	spin_lock_init(&ctl->read_lock);
 	ctl->card = card;
-	ctl->prefer_pcm_subdevice = -1;
-	ctl->prefer_rawmidi_subdevice = -1;
+	for (i = 0; i < SND_CTL_SUBDEV_ITEMS; i++)
+		ctl->preferred_subdevice[i] = -1;
 	ctl->pid = get_pid(task_pid(current));
 	file->private_data = ctl;
 	write_lock_irqsave(&card->ctl_files_rwlock, flags);
@@ -1607,6 +1607,27 @@ static int snd_ctl_fasync(int fd, struct file * file, int on)
 	return fasync_helper(fd, file, on, &ctl->fasync);
 }
 
+/* return the preferred subdevice number if already assigned;
+ * otherwise return -1
+ */
+int snd_ctl_get_preferred_subdevice(struct snd_card *card, int type)
+{
+	struct snd_ctl_file *kctl;
+	int subdevice = -1;
+
+	read_lock(&card->ctl_files_rwlock);
+	list_for_each_entry(kctl, &card->ctl_files, list) {
+		if (kctl->pid == task_pid(current)) {
+			subdevice = kctl->preferred_subdevice[type];
+			if (subdevice != -1)
+				break;
+		}
+	}
+	read_unlock(&card->ctl_files_rwlock);
+	return subdevice;
+}
+EXPORT_SYMBOL_GPL(snd_ctl_get_preferred_subdevice);
+
 /*
  * ioctl32 compat
  */
diff --git a/sound/core/pcm.c b/sound/core/pcm.c
index dba5180e5b80..1b7c473720fa 100644
--- a/sound/core/pcm.c
+++ b/sound/core/pcm.c
@@ -161,7 +161,7 @@ static int snd_pcm_control_ioctl(struct snd_card *card,
 			
 			if (get_user(val, (int __user *)arg))
 				return -EFAULT;
-			control->prefer_pcm_subdevice = val;
+			control->preferred_subdevice[SND_CTL_SUBDEV_PCM] = val;
 			return 0;
 		}
 	}
@@ -901,9 +901,8 @@ int snd_pcm_attach_substream(struct snd_pcm *pcm, int stream,
 	struct snd_pcm_str * pstr;
 	struct snd_pcm_substream *substream;
 	struct snd_pcm_runtime *runtime;
-	struct snd_ctl_file *kctl;
 	struct snd_card *card;
-	int prefer_subdevice = -1;
+	int prefer_subdevice;
 	size_t size;
 
 	if (snd_BUG_ON(!pcm || !rsubstream))
@@ -914,15 +913,7 @@ int snd_pcm_attach_substream(struct snd_pcm *pcm, int stream,
 		return -ENODEV;
 
 	card = pcm->card;
-	read_lock(&card->ctl_files_rwlock);
-	list_for_each_entry(kctl, &card->ctl_files, list) {
-		if (kctl->pid == task_pid(current)) {
-			prefer_subdevice = kctl->prefer_pcm_subdevice;
-			if (prefer_subdevice != -1)
-				break;
-		}
-	}
-	read_unlock(&card->ctl_files_rwlock);
+	prefer_subdevice = snd_ctl_get_preferred_subdevice(card, SND_CTL_SUBDEV_PCM);
 
 	switch (stream) {
 	case SNDRV_PCM_STREAM_PLAYBACK:
diff --git a/sound/core/rawmidi.c b/sound/core/rawmidi.c
index 6fc71a4c8a51..be18162c380f 100644
--- a/sound/core/rawmidi.c
+++ b/sound/core/rawmidi.c
@@ -369,7 +369,6 @@ static int snd_rawmidi_open(struct inode *inode, struct file *file)
 	struct snd_rawmidi *rmidi;
 	struct snd_rawmidi_file *rawmidi_file = NULL;
 	wait_queue_t wait;
-	struct snd_ctl_file *kctl;
 
 	if ((file->f_flags & O_APPEND) && !(file->f_flags & O_NONBLOCK)) 
 		return -EINVAL;		/* invalid combination */
@@ -413,16 +412,7 @@ static int snd_rawmidi_open(struct inode *inode, struct file *file)
 	init_waitqueue_entry(&wait, current);
 	add_wait_queue(&rmidi->open_wait, &wait);
 	while (1) {
-		subdevice = -1;
-		read_lock(&card->ctl_files_rwlock);
-		list_for_each_entry(kctl, &card->ctl_files, list) {
-			if (kctl->pid == task_pid(current)) {
-				subdevice = kctl->prefer_rawmidi_subdevice;
-				if (subdevice != -1)
-					break;
-			}
-		}
-		read_unlock(&card->ctl_files_rwlock);
+		subdevice = snd_ctl_get_preferred_subdevice(card, SND_CTL_SUBDEV_RAWMIDI);
 		err = rawmidi_open_priv(rmidi, subdevice, fflags, rawmidi_file);
 		if (err >= 0)
 			break;
@@ -862,7 +852,7 @@ static int snd_rawmidi_control_ioctl(struct snd_card *card,
 		
 		if (get_user(val, (int __user *)argp))
 			return -EFAULT;
-		control->prefer_rawmidi_subdevice = val;
+		control->preferred_subdevice[SND_CTL_SUBDEV_RAWMIDI] = val;
 		return 0;
 	}
 	case SNDRV_CTL_IOCTL_RAWMIDI_INFO:
-- 
2.2.2
