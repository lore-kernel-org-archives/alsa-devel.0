From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 1/2] ALSA: control: limit life time of
	user-defined element set
Date: Sun,  4 Sep 2016 19:06:55 +0900
Message-ID: <1472983616-16254-2-git-send-email-o-takashi@sakamocchi.jp>
References: <1472983616-16254-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id E2A8C265B46
 for <alsa-devel@alsa-project.org>; Sun,  4 Sep 2016 12:07:04 +0200 (CEST)
In-Reply-To: <1472983616-16254-1-git-send-email-o-takashi@sakamocchi.jp>
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
Cc: jimmy@spalge.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

ALSA control core allows applications to add arbitrary element sets to
an instance of control device. This is performed by ioctl(2) with
SNDRV_CTL_IOCTL_ELEM_ADD request. Elements in added element set can be
handled by the same way as the one added by kernel drivers. The elements
can be removed by ioctl(2) with SNDRV_CTL_IOCTL_ELEM_REMOVE for an
including element set. As of 2016, the main user of this feature is PCM
softvol plugin in alsa-lib.

There's an issue of removal. If a process adds any element sets and never
does removal, the element set still remain in the control device; e.g.
aborted by some reasons. Although the other processes can perform it,
this is unlikely because the process which is the most interested in the
element set is a process to add them.

This commit attempts to limit life time of the element set. When a process
adds some element sets, they're basically removed corresponding to closing
a file descriptor used for the addition. This is convenient because
operating system promises to close the file descriptor when the process
aborts. If the file descriptor is duplicated for several processes, the
removal is done when one of the processes finally closes the descriptor.

There's an exception; lock operation. ALSA control core allows applications
to lock favorite elements by ioctl(2) via SNDRV_CTL_IOCTL_ELEM_LOCK
request. In this case, the process becomes 'owner' of the element and
disallow the other processes to read/write any data or TLV information to
it. When the removal of an element set is executed corresponding to a file
descriptor of a process, during some elements in the element set are locked
via the other processes, it's logically wrong.

For this situation, this commit counts locked elements in an element set,
then judge to remove or not.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/core/control.c | 101 +++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 86 insertions(+), 15 deletions(-)

diff --git a/sound/core/control.c b/sound/core/control.c
index fb096cb..24fca5d 100644
--- a/sound/core/control.c
+++ b/sound/core/control.c
@@ -34,6 +34,27 @@
 #define MAX_USER_CONTROLS	32
 #define MAX_CONTROL_COUNT	1028
 
+struct user_element {
+	/*
+	 * This member is corresponding to a file descriptor to add this
+	 * element set. This is used to maintain a life time of the element set.
+	 */
+	struct snd_ctl_file *originator;
+
+	struct snd_ctl_elem_info info;
+	struct snd_card *card;
+	/* element data */
+	char *elem_data;
+	/* size of element data in bytes */
+	unsigned long elem_data_size;
+	/* TLV data */
+	void *tlv_data;
+	/* TLV data size */
+	unsigned long tlv_data_size;
+	/* private data (like strings for enumerated type) */
+	void *priv_data;
+};
+
 struct snd_kctl_ioctl {
 	struct list_head list;		/* list of all ioctls */
 	snd_kctl_ioctl_func_t fioctl;
@@ -118,20 +139,79 @@ static int snd_ctl_release(struct inode *inode, struct file *file)
 	unsigned long flags;
 	struct snd_card *card;
 	struct snd_ctl_file *ctl;
-	struct snd_kcontrol *control;
+	struct snd_kcontrol *control, *tmp;
 	unsigned int idx;
+	struct snd_kcontrol_volatile *vd;
+	struct user_element *ue;
+	unsigned int count;
 
 	ctl = file->private_data;
 	file->private_data = NULL;
 	card = ctl->card;
+
 	write_lock_irqsave(&card->ctl_files_rwlock, flags);
 	list_del(&ctl->list);
 	write_unlock_irqrestore(&card->ctl_files_rwlock, flags);
+
 	down_write(&card->controls_rwsem);
-	list_for_each_entry(control, &card->controls, list)
-		for (idx = 0; idx < control->count; idx++)
-			if (control->vd[idx].owner == ctl)
-				control->vd[idx].owner = NULL;
+	list_for_each_entry_safe(control, tmp, &card->controls, list) {
+		vd = control->vd;
+
+		/*
+		 * All of elements in an user-defined element set has the same
+		 * access information in their volatile data, therefore it's
+		 * enough to check the first one.
+		 */
+		if (vd[0].access & SNDRV_CTL_ELEM_ACCESS_USER) {
+			ue = control->private_data;
+
+			/*
+			 * Lock the element temporarily for future removal if
+			 * still unlocked.
+			 */
+			if (ue->originator == ctl) {
+				for (idx = 0; idx < control->count; ++idx) {
+					if (vd[idx].owner == NULL)
+						vd[idx].owner = ctl;
+				}
+
+				ue->originator = NULL;
+			}
+		}
+
+		/*
+		 * Unlock each of elements in the element set if it was locked
+		 * via this file descriptor. Then count unlocked elements.
+		 */
+		count = 0;
+		for (idx = 0; idx < control->count; idx++) {
+			if (vd[idx].owner == ctl)
+				vd[idx].owner = NULL;
+			if (vd[idx].owner == NULL)
+				count++;
+		}
+
+		/*
+		 * None of elements in the element set are locked via any file
+		 * descriptors. As long as it's an user-defined element set and
+		 * originator of it is going to be closed or was already closed,
+		 * let's remove it from this control instance.
+		 */
+		if ((vd[0].access & SNDRV_CTL_ELEM_ACCESS_USER) &&
+		    count == control->count) {
+			ue = control->private_data;
+
+			/*
+			 * Originator was already closed or is going to be
+			 * closed.
+			 */
+			if (ue->originator == NULL) {
+				/* No worry of failure. */
+				snd_ctl_remove(card, control);
+				card->user_ctl_count--;
+			}
+		}
+	}
 	up_write(&card->controls_rwsem);
 	snd_ctl_empty_read_queue(ctl);
 	put_pid(ctl->pid);
@@ -1058,16 +1138,6 @@ static int snd_ctl_elem_unlock(struct snd_ctl_file *file,
 	return result;
 }
 
-struct user_element {
-	struct snd_ctl_elem_info info;
-	struct snd_card *card;
-	char *elem_data;		/* element data */
-	unsigned long elem_data_size;	/* size of element data in bytes */
-	void *tlv_data;			/* TLV data */
-	unsigned long tlv_data_size;	/* TLV data size */
-	void *priv_data;		/* private data (like strings for enumerated type) */
-};
-
 static int snd_ctl_elem_user_info(struct snd_kcontrol *kcontrol,
 				  struct snd_ctl_elem_info *uinfo)
 {
@@ -1329,6 +1399,7 @@ static int snd_ctl_elem_add(struct snd_ctl_file *file,
 	/* Set private data for this userspace control. */
 	ue = (struct user_element *)kctl->private_data;
 	ue->card = card;
+	ue->originator = file;
 	ue->info = *info;
 	ue->info.access = 0;
 	ue->elem_data = (char *)ue + sizeof(*ue);
-- 
2.7.4
