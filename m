From: Karsten Wiese <annabellesgarden@yahoo.de>
Subject: Re:
	=?iso-8859-1?q?=5BPATCH=5D_Reset_file-=3Ef=5Fop_in?=
	=?iso-8859-1?q?=09snd=5Fcard=5Ffile=5Fremove_=28=29=2E_Take_2?=
Date: Thu, 5 Oct 2006 16:12:07 +0200
Message-ID: <200610051612.07770.annabellesgarden@yahoo.de>
References: <200609282228.02611.annabellesgarden@yahoo.de>
	<s5hmz8boxeh.wl%tiwai@suse.de>
	<200610051333.12574.annabellesgarden@yahoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <200610051333.12574.annabellesgarden@yahoo.de>
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
To: Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org
Cc: mingo@elte.hu, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

here is rc3.

Anything to fix?

We've lots of things disconnectable...
Is this useful in the kernel global?

      Karsten

rc3:
---------------------------------------------------------------------------
snd_disconnected_file, virtual device

On response to "usb disconnect" an usb-soundcard manipulates
that snd_card's file's f_ops to only allow release
by calling this virtual device's 
   void snd_disconnect_file(struct file *file).
After release is actually called, the virtual device instance is freeed.

Signed-off-by: Karsten Wiese <fzu@wemgehoertderstaat.de>


--- alsa-kernel/core/_disconnected.c	2006-10-05 12:16:34.000000000 +0200
+++ alsa-kernel/core/disconnected.c	2006-10-05 15:15:06.000000000 +0200
@@ -0,0 +1,141 @@
+/* virtual device
+   hides a real device's f_ops,
+   except for release
+
+ *  Copyright (c) by Karsten Wiese <fzu@wemgehoertderstaat.de>
+ *
+ *
+ *   This program is free software; you can redistribute it and/or modify
+ *   it under the terms of the GNU General Public License as published by
+ *   the Free Software Foundation; either version 2 of the License, or
+ *   (at your option) any later version.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU General Public License for more details.
+ *
+ *   You should have received a copy of the GNU General Public License
+ *   along with this program; if not, write to the Free Software
+ *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
+ *
+ */
+
+
+#include <linux/fs.h>
+#include <linux/list.h>
+#include <linux/poll.h>
+#include <linux/module.h>
+
+static DEFINE_MUTEX(mutex);
+static LIST_HEAD(disconnected_files);
+
+struct snd_disconnected_file {
+	struct file *file;
+	const struct file_operations *f_op;
+	struct list_head list;
+};
+
+static struct file_operations snd_disconnect_f_ops;
+
+void snd_disconnect_file(struct file *file)
+{
+	struct snd_disconnected_file *df;
+	df = kmalloc(sizeof(struct snd_disconnected_file), GFP_KERNEL);
+	if (df == NULL)
+		panic("Atomic allocation failed for snd_disconnected_file!");
+
+	df->file = file;
+	df->f_op = file->f_op;
+
+	mutex_lock(&mutex);
+	list_add(&df->list, &disconnected_files);
+	mutex_unlock(&mutex);
+
+	fops_get(&snd_disconnect_f_ops);
+	file->f_op = &snd_disconnect_f_ops;
+	printk(KERN_INFO "%s rc3\n", __FUNCTION__);
+}
+
+
+static loff_t snd_disconnect_llseek(struct file *file, loff_t offset, int orig)
+{
+	return -ENODEV;
+}
+
+static ssize_t snd_disconnect_read(struct file *file, char __user *buf,
+				   size_t count, loff_t *offset)
+{
+	return -ENODEV;
+}
+
+static ssize_t snd_disconnect_write(struct file *file, const char __user *buf,
+				    size_t count, loff_t *offset)
+{
+	return -ENODEV;
+}
+
+static int snd_disconnect_release(struct inode *inode, struct file *file)
+{
+	struct snd_disconnected_file *df = NULL;
+	struct list_head *entry;
+
+	mutex_lock(&mutex);
+	list_for_each(entry, &disconnected_files) {
+		struct snd_disconnected_file *_df;
+		_df = list_entry(entry, struct snd_disconnected_file, list);
+		if (_df->file == file) {
+			list_del(entry);
+			df = _df;
+			break;
+		}
+	}
+	mutex_unlock(&mutex);
+
+	if (likely(df != NULL))	{
+		int err = df->f_op->release(inode, file);
+		fops_put(df->f_op);
+		kfree(df);
+		printk(KERN_INFO "%s rc3\n", __FUNCTION__);
+		return err;
+	}
+
+	panic("%s(%p, %p) failed!", __FUNCTION__, inode, file);
+}
+
+static unsigned int snd_disconnect_poll(struct file * file, poll_table * wait)
+{
+	return POLLERR | POLLNVAL;
+}
+
+static long snd_disconnect_ioctl(struct file *file,
+				 unsigned int cmd, unsigned long arg)
+{
+	return -ENODEV;
+}
+
+static int snd_disconnect_mmap(struct file *file, struct vm_area_struct *vma)
+{
+	return -ENODEV;
+}
+
+static int snd_disconnect_fasync(int fd, struct file *file, int on)
+{
+	return -ENODEV;
+}
+
+static struct file_operations snd_disconnect_f_ops =
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

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
