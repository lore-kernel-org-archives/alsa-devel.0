From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 3/3] ALSA: Remove BKL from open multiplexer
Date: Wed, 14 Apr 2010 10:14:22 +0200
Message-ID: <1271232862-16183-4-git-send-email-tiwai@suse.de>
References: <1271232862-16183-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (cantor.suse.de [195.135.220.2])
	by alsa0.perex.cz (Postfix) with ESMTP id 6A28C24472
	for <alsa-devel@alsa-project.org>;
	Wed, 14 Apr 2010 10:14:44 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.221.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id 0F70074609
	for <alsa-devel@alsa-project.org>;
	Wed, 14 Apr 2010 10:14:44 +0200 (CEST)
In-Reply-To: <1271232862-16183-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Use a local mutex instead of BKL.  This should suffice since each device
type has also its open_mutex.
Also, a bit of clean-up of the legacy device auto-loading code.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/sound.c |   73 +++++++++++++++++++++++++++-------------------------
 1 files changed, 38 insertions(+), 35 deletions(-)

diff --git a/sound/core/sound.c b/sound/core/sound.c
index 563d196..ac42af4 100644
--- a/sound/core/sound.c
+++ b/sound/core/sound.c
@@ -120,7 +120,29 @@ void *snd_lookup_minor_data(unsigned int minor, int type)
 
 EXPORT_SYMBOL(snd_lookup_minor_data);
 
-static int __snd_open(struct inode *inode, struct file *file)
+#ifdef CONFIG_MODULES
+static struct snd_minor *autoload_device(unsigned int minor)
+{
+	int dev;
+	mutex_unlock(&sound_mutex); /* release lock temporarily */
+	dev = SNDRV_MINOR_DEVICE(minor);
+	if (dev == SNDRV_MINOR_CONTROL) {
+		/* /dev/aloadC? */
+		int card = SNDRV_MINOR_CARD(minor);
+		if (snd_cards[card] == NULL)
+			snd_request_card(card);
+	} else if (dev == SNDRV_MINOR_GLOBAL) {
+		/* /dev/aloadSEQ */
+		snd_request_other(minor);
+	}
+	mutex_lock(&sound_mutex); /* reacuire lock */
+	return snd_minors[minor];
+}
+#else /* !CONFIG_MODULES */
+#define autoload_device(minor)	NULL
+#endif /* CONFIG_MODULES */
+
+static int snd_open(struct inode *inode, struct file *file)
 {
 	unsigned int minor = iminor(inode);
 	struct snd_minor *mptr = NULL;
@@ -129,55 +151,36 @@ static int __snd_open(struct inode *inode, struct file *file)
 
 	if (minor >= ARRAY_SIZE(snd_minors))
 		return -ENODEV;
+	mutex_lock(&sound_mutex);
 	mptr = snd_minors[minor];
 	if (mptr == NULL) {
-#ifdef CONFIG_MODULES
-		int dev = SNDRV_MINOR_DEVICE(minor);
-		if (dev == SNDRV_MINOR_CONTROL) {
-			/* /dev/aloadC? */
-			int card = SNDRV_MINOR_CARD(minor);
-			if (snd_cards[card] == NULL)
-				snd_request_card(card);
-		} else if (dev == SNDRV_MINOR_GLOBAL) {
-			/* /dev/aloadSEQ */
-			snd_request_other(minor);
-		}
-#ifndef CONFIG_SND_DYNAMIC_MINORS
-		/* /dev/snd/{controlC?,seq} */
-		mptr = snd_minors[minor];
-		if (mptr == NULL)
-#endif
-#endif
+		mptr = autoload_device(minor);
+		if (!mptr) {
+			mutex_unlock(&sound_mutex);
 			return -ENODEV;
+		}
 	}
 	old_fops = file->f_op;
 	file->f_op = fops_get(mptr->f_ops);
 	if (file->f_op == NULL) {
 		file->f_op = old_fops;
-		return -ENODEV;
+		err = -ENODEV;
 	}
-	if (file->f_op->open)
+	mutex_unlock(&sound_mutex);
+	if (err < 0)
+		return err;
+
+	if (file->f_op->open) {
 		err = file->f_op->open(inode, file);
-	if (err) {
-		fops_put(file->f_op);
-		file->f_op = fops_get(old_fops);
+		if (err) {
+			fops_put(file->f_op);
+			file->f_op = fops_get(old_fops);
+		}
 	}
 	fops_put(old_fops);
 	return err;
 }
 
-
-/* BKL pushdown: nasty #ifdef avoidance wrapper */
-static int snd_open(struct inode *inode, struct file *file)
-{
-	int ret;
-
-	lock_kernel();
-	ret = __snd_open(inode, file);
-	unlock_kernel();
-	return ret;
-}
-
 static const struct file_operations snd_fops =
 {
 	.owner =	THIS_MODULE,
-- 
1.7.0.4
