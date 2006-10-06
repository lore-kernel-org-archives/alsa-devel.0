From: Karsten Wiese <annabellesgarden@yahoo.de>
Subject: [PATCH] New virtual device snd_disconnected rc6
Date: Fri, 6 Oct 2006 15:50:26 +0200
Message-ID: <200610061550.26949.annabellesgarden@yahoo.de>
References: <200610051253.46779.annabellesgarden@yahoo.de>
	<200610061415.51120.annabellesgarden@yahoo.de>
	<s5h3ba1twyj.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5h3ba1twyj.wl%tiwai@suse.de>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: mingo@elte.hu, alsa-devel@lists.sourceforge.net, Jaroslav Kysela <perex@suse.cz>
List-Id: alsa-devel@alsa-project.org

Hi

Motivation for this came from oopses consistently happening
when my usb-soundcard disconnected running 2.6.18-rt4.
Takashi and me discussed various fixes and this patch
implements the result of our discussion.

Changes in rc3: kmalloc with GFP_KERNEL, use linux list

Changes in rc4: struct snd_disconnected_file merged into
	   	struct snd_monitor_file.
		Omit a separate kmalloc/free for disconnect
		at the cost of sizeof(3 pointers) more in
		each struct snd_monitor_file.
		Move the cleanup of the virtual device to
		snd_card_remove_file() so it wont be missed
		in case the release call is already underway,
		when disconnect starts.
		use DEFINE_SPINLOCK(shutdown_mutex);
		instead of DEFINE_MUTEX(mutex); 'cause code paths
		are small under that lock.
	   	Merged with init.c.

Changes in rc5: move fops_put(mfile->disconnected_f_op);
	   	out of the spin_lock.

Changes in rc6: rename shutdow_mutex to *_lock
	   	use list_for_each_entry()

If agreed upon, this should go to all stable.

      Karsten

--------------------------------------------------------------------------
Handle file operations during snd_card disconnects using static file->f_op


Alsa used to kmalloc one file->f_op per file per disconnecting snd_card.
This led to oopses sometimes when file->f_op was freed before __fput()
finished.
Patch adds a virtual device for disconnect: VDD.
VDD consists of:
	LIST_HEAD(shutdown_files)
	    protected by DEFINE_SPINLOCK(shutdown_lock)

	static struct file_operations snd_shutdown_f_ops
	    and functions assigned to it

	Additions to struct snd_monitor_file
	    to specify if instance is hidden by VDD or not.

A VDD's instance is
	created in snd_card_disconnect() under the card->files_lock.
	cleaned up in snd_card_file_remove() under the card->files_lock.


Signed-off-by: Karsten Wiese <fzu@wemgehoertderstaat.de>



--- alsa-kernel/include/core.h	2006-09-29 13:40:33.000000000 +0200
+++ alsa-kernel/include/core.h	2006-10-06 00:25:45.000000000 +0200
@@ -89,10 +89,10 @@
 struct snd_monitor_file {
 	struct file *file;
 	struct snd_monitor_file *next;
+	const struct file_operations *disconnected_f_op;
+	struct list_head shutdown_list;
 };
 
-struct snd_shutdown_f_ops;	/* define it later in init.c */
-
 /* main structure for soundcard */
 
 struct snd_card {
--- alsa-kernel/core/init.c	2006-09-29 13:40:32.000000000 +0200
+++ alsa-kernel/core/init.c	2006-10-06 00:25:44.000000000 +0200
@@ -33,10 +33,10 @@
 #include <sound/control.h>
 #include <sound/info.h>
 
-struct snd_shutdown_f_ops {
-	struct file_operations f_ops;
-	struct snd_shutdown_f_ops *next;
-};
+static DEFINE_SPINLOCK(shutdown_lock);
+static LIST_HEAD(shutdown_files);
+
+static struct file_operations snd_shutdown_f_ops;
 
 static unsigned int snd_cards_lock;	/* locked for registering/using */
 struct snd_card *snd_cards[SNDRV_CARDS];
@@ -198,6 +198,25 @@
 	return -ENODEV;
 }
 
+static int snd_disconnect_release(struct inode *inode, struct file *file)
+{
+	struct snd_monitor_file *df = NULL, *_df;
+
+	spin_lock(&shutdown_lock);
+	list_for_each_entry(_df, &shutdown_files, shutdown_list) {
+		if (_df->file == file) {
+			df = _df;
+			break;
+		}
+	}
+	spin_unlock(&shutdown_lock);
+
+	if (likely(df))
+		return df->disconnected_f_op->release(inode, file);
+
+	panic("%s(%p, %p) failed!", __FUNCTION__, inode, file);
+}
+
 static unsigned int snd_disconnect_poll(struct file * file, poll_table * wait)
 {
 	return POLLERR | POLLNVAL;
@@ -219,6 +238,22 @@
 	return -ENODEV;
 }
 
+static struct file_operations snd_shutdown_f_ops =
+{
+	.owner = 	THIS_MODULE,
+	.llseek =	snd_disconnect_llseek,
+	.read = 	snd_disconnect_read,
+	.write =	snd_disconnect_write,
+	.release =	snd_disconnect_release,
+	.poll =		snd_disconnect_poll,
+	.unlocked_ioctl = snd_disconnect_ioctl,
+#ifdef CONFIG_COMPAT
+	.compat_ioctl = snd_disconnect_ioctl,
+#endif
+	.mmap =		snd_disconnect_mmap,
+	.fasync =	snd_disconnect_fasync
+};
+
 /**
  *  snd_card_disconnect - disconnect all APIs from the file-operations (user space)
  *  @card: soundcard structure
@@ -234,9 +269,6 @@
 {
 	struct snd_monitor_file *mfile;
 	struct file *file;
-	struct snd_shutdown_f_ops *s_f_ops;
-	struct file_operations *f_ops;
-	const struct file_operations *old_f_ops;
 	int err;
 
 	spin_lock(&card->files_lock);
@@ -261,34 +293,14 @@
 
 		/* it's critical part, use endless loop */
 		/* we have no room to fail */
-		s_f_ops = kmalloc(sizeof(struct snd_shutdown_f_ops), GFP_ATOMIC);
-		if (s_f_ops == NULL)
-			panic("Atomic allocation failed for snd_shutdown_f_ops!");
-
-		f_ops = &s_f_ops->f_ops;
-
-		memset(f_ops, 0, sizeof(*f_ops));
-		f_ops->owner = file->f_op->owner;
-		f_ops->release = file->f_op->release;
-		f_ops->llseek = snd_disconnect_llseek;
-		f_ops->read = snd_disconnect_read;
-		f_ops->write = snd_disconnect_write;
-		f_ops->poll = snd_disconnect_poll;
-		f_ops->unlocked_ioctl = snd_disconnect_ioctl;
-#ifdef CONFIG_COMPAT
-		f_ops->compat_ioctl = snd_disconnect_ioctl;
-#endif
-		f_ops->mmap = snd_disconnect_mmap;
-		f_ops->fasync = snd_disconnect_fasync;
+		mfile->disconnected_f_op = mfile->file->f_op;
 
-		s_f_ops->next = card->s_f_ops;
-		card->s_f_ops = s_f_ops;
-		
-		f_ops = fops_get(f_ops);
+		spin_lock(&shutdown_lock);
+		list_add(&mfile->shutdown_list, &shutdown_files);
+		spin_unlock(&shutdown_lock);
 
-		old_f_ops = file->f_op;
-		file->f_op = f_ops;	/* must be atomic */
-		fops_put(old_f_ops);
+		fops_get(&snd_shutdown_f_ops);
+		mfile->file->f_op = &snd_shutdown_f_ops;
 		
 		mfile = mfile->next;
 	}
@@ -326,8 +338,6 @@
  */
 static int snd_card_do_free(struct snd_card *card)
 {
-	struct snd_shutdown_f_ops *s_f_ops;
-
 #if defined(CONFIG_SND_MIXER_OSS) || defined(CONFIG_SND_MIXER_OSS_MODULE)
 	if (snd_mixer_oss_notify_callback)
 		snd_mixer_oss_notify_callback(card, SND_MIXER_OSS_NOTIFY_FREE);
@@ -351,11 +361,6 @@
 		snd_printk(KERN_WARNING "unable to free card info\n");
 		/* Not fatal error */
 	}
-	while (card->s_f_ops) {
-		s_f_ops = card->s_f_ops;
-		card->s_f_ops = s_f_ops->next;
-		kfree(s_f_ops);
-	}
 	kfree(card);
 	return 0;
 }
@@ -670,6 +675,7 @@
 	if (mfile == NULL)
 		return -ENOMEM;
 	mfile->file = file;
+	mfile->disconnected_f_op = NULL;
 	mfile->next = NULL;
 	spin_lock(&card->files_lock);
 	if (card->shutdown) {
@@ -716,6 +722,12 @@
 		pfile = mfile;
 		mfile = mfile->next;
 	}
+	if (mfile && mfile->disconnected_f_op) {
+		fops_put(mfile->disconnected_f_op);
+		spin_lock(&shutdown_lock);
+		list_del(&mfile->shutdown_list);
+		spin_unlock(&shutdown_lock);
+	}
 	if (card->files == NULL)
 		last_close = 1;
 	spin_unlock(&card->files_lock);

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
