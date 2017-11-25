From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 06/24] ALSA: ctl: change prototype of local
	function for ELEM_LIST ioctl
Date: Sat, 25 Nov 2017 18:19:48 +0900
Message-ID: <20171125092006.24408-7-o-takashi@sakamocchi.jp>
References: <20171125092006.24408-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id E354D266F72
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
are called by the layer. A 'snd_ctl_elem_list()' is such a function,
while it's prototype is not similar to the others. This will bring a
future inconvenience in integration of the layer.

This commit changes its prototype to get a first argument for data of
'struct snd_ctl_file' type.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/core/control.c        | 12 ++++++------
 sound/core/control_compat.c |  6 +++---
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/sound/core/control.c b/sound/core/control.c
index 56b3e2d49c82..8baee922a400 100644
--- a/sound/core/control.c
+++ b/sound/core/control.c
@@ -744,7 +744,7 @@ static int snd_ctl_card_info(struct snd_card *card, struct snd_ctl_file * ctl,
 	return 0;
 }
 
-static int snd_ctl_elem_list(struct snd_card *card,
+static int snd_ctl_elem_list(struct snd_ctl_file *ctl_file,
 			     struct snd_ctl_elem_list __user *_list)
 {
 	struct snd_ctl_elem_list list;
@@ -758,11 +758,11 @@ static int snd_ctl_elem_list(struct snd_card *card,
 	offset = list.offset;
 	space = list.space;
 
-	down_read(&card->controls_rwsem);
-	list.count = card->controls_count;
+	down_read(&ctl_file->card->controls_rwsem);
+	list.count = ctl_file->card->controls_count;
 	list.used = 0;
 	if (space > 0) {
-		list_for_each_entry(kctl, &card->controls, list) {
+		list_for_each_entry(kctl, &ctl_file->card->controls, list) {
 			if (offset >= kctl->count) {
 				offset -= kctl->count;
 				continue;
@@ -782,7 +782,7 @@ static int snd_ctl_elem_list(struct snd_card *card,
 		}
 	}
  out:
-	up_read(&card->controls_rwsem);
+	up_read(&ctl_file->card->controls_rwsem);
 	if (!err && copy_to_user(_list, &list, sizeof(list)))
 		err = -EFAULT;
 	return err;
@@ -1552,7 +1552,7 @@ static long snd_ctl_ioctl(struct file *file, unsigned int cmd, unsigned long arg
 	case SNDRV_CTL_IOCTL_CARD_INFO:
 		return snd_ctl_card_info(card, ctl, cmd, argp);
 	case SNDRV_CTL_IOCTL_ELEM_LIST:
-		return snd_ctl_elem_list(card, argp);
+		return snd_ctl_elem_list(ctl, argp);
 	case SNDRV_CTL_IOCTL_ELEM_INFO:
 		return snd_ctl_elem_info_user(ctl, argp);
 	case SNDRV_CTL_IOCTL_ELEM_READ:
diff --git a/sound/core/control_compat.c b/sound/core/control_compat.c
index 5dfb31a22470..3594bd41750e 100644
--- a/sound/core/control_compat.c
+++ b/sound/core/control_compat.c
@@ -406,7 +406,7 @@ struct snd_ctl_elem_list32 {
 	unsigned char reserved[50];
 } /* don't set packed attribute here */;
 
-static int snd_ctl_elem_list_compat(struct snd_card *card,
+static int snd_ctl_elem_list_compat(struct snd_ctl_file *ctl_file,
 				    struct snd_ctl_elem_list32 __user *data32)
 {
 	struct snd_ctl_elem_list __user *data;
@@ -422,7 +422,7 @@ static int snd_ctl_elem_list_compat(struct snd_card *card,
 	if (get_user(ptr, &data32->pids) ||
 	    put_user(compat_ptr(ptr), &data->pids))
 		return -EFAULT;
-	err = snd_ctl_elem_list(card, data);
+	err = snd_ctl_elem_list(ctl_file, data);
 	if (err < 0)
 		return err;
 	/* copy the result */
@@ -844,7 +844,7 @@ static long snd_ctl_ioctl_compat(struct file *file, unsigned int cmd,
 
 	switch (cmd) {
 	case SNDRV_CTL_IOCTL_ELEM_LIST32:
-		return snd_ctl_elem_list_compat(ctl->card, argp);
+		return snd_ctl_elem_list_compat(ctl, argp);
 	case SNDRV_CTL_IOCTL_ELEM_INFO32:
 		return snd_ctl_elem_info_compat(ctl, argp);
 	case SNDRV_CTL_IOCTL_ELEM_READ32:
-- 
2.14.1
