From: Robert Love <rml@tech9.net>
Subject: [PATCH] proper lseek locking in ALSA, take 3
Date: 20 Feb 2002 14:20:40 -0500
Message-ID: <1014232841.18361.37.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Received: from zero.tech9.net (zero.tech9.net [209.61.188.187])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id UAA23238
	for <alsa-devel@alsa-project.org>; Wed, 20 Feb 2002 20:20:50 +0100
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: torvalds@transmeta.com, davej@suse.de
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The attached patch implements proper locking in ALSA lseek methods. 
Note ALSA has 3 lseek implementations, but only:

	sound/core/info.c :: snd_info_entry_llseek()

requires locking.  I wrapped the function in the BKL.  According to
Jaroslav Kysela the gus_mem_proc method is only called from above.  The
third lseek, in hwdep.c, clearly doesn't need locking.  Without this
patch, the above lseek is not safe.

Patch is against 2.5.5, please apply.

	Robert Love	

diff -urN linux-2.5.5/sound/core/info.c linux/sound/core/info.c
--- linux-2.5.5/sound/core/info.c	Tue Feb 19 21:11:01 2002
+++ linux/sound/core/info.c	Tue Feb 19 21:50:18 2002
@@ -29,6 +29,7 @@
 #include <sound/info.h>
 #include <sound/version.h>
 #include <linux/proc_fs.h>
+#include <linux/smp_lock.h>
 #ifdef CONFIG_DEVFS_FS
 #include <linux/devfs_fs_kernel.h>
 #endif
@@ -162,31 +163,40 @@
 {
 	snd_info_private_data_t *data;
 	struct snd_info_entry *entry;
+	int ret = -EINVAL;
 
 	data = snd_magic_cast(snd_info_private_data_t, file->private_data, return -ENXIO);
 	entry = data->entry;
+	lock_kernel();
 	switch (entry->content) {
 	case SNDRV_INFO_CONTENT_TEXT:
 		switch (orig) {
 		case 0:	/* SEEK_SET */
 			file->f_pos = offset;
-			return file->f_pos;
+			ret = file->f_pos;
+			goto out;
 		case 1:	/* SEEK_CUR */
 			file->f_pos += offset;
-			return file->f_pos;
+			ret = file->f_pos;
+			goto out;
 		case 2:	/* SEEK_END */
 		default:
-			return -EINVAL;
+			goto out;
 		}
 		break;
 	case SNDRV_INFO_CONTENT_DATA:
-		if (entry->c.ops->llseek)
-			return entry->c.ops->llseek(entry,
+		if (entry->c.ops->llseek) {
+			ret = entry->c.ops->llseek(entry,
 						    data->file_private_data,
 						    file, offset, orig);
+			goto out;
+		}
 		break;
 	}
-	return -ENXIO;
+	ret = -ENXIO;
+out:
+	unlock_kernel();
+	return ret;
 }
 
 static ssize_t snd_info_entry_read(struct file *file, char *buffer,





_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
