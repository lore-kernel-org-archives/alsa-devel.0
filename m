From: Robert Love <rml@tech9.net>
Subject: [PATCH] ALSA not using updated lseek locking
Date: 18 Feb 2002 14:21:37 -0500
Message-ID: <1014060111.935.2766.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Received: from zero.tech9.net (zero.tech9.net [209.61.188.187])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id UAA06950
	for <alsa-devel@alsa-project.org>; Mon, 18 Feb 2002 20:21:40 +0100
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@alsa-project.org, perex@suse.cz
Cc: torvalds@transmeta.com, manfred@colorfullife.com
List-Id: alsa-devel@alsa-project.org

Manfred Spraul just pointed out to me that ALSA contains three lseek
implementations, none of which use the new lseek locking rules.  While
it is possible the ALSA people intended for there to be no locking (as
in it not being needed), I suspect the recent change was overlooked.

The lseek implementations are:

	sound/core/hwdep.c :: snd_hwdep_llseek
	sound/core/info.c :: snd_info_entry_llseek
	sound/isa/gus/gus_mem_proc.c :: snd_gf1_mem_proc_llseek

snd_hwdep_llseek in hwdep.c clearly does not need locking.  I suspect
the other two functions do.  The BKL seems the only available option.

Please apply.

	Robert Love

diff -urN linux-2.5.5-pre1/sound/core/info.c linux/sound/core/info.c
--- linux-2.5.5-pre1/sound/core/info.c	Wed Feb 13 18:18:59 2002
+++ linux/sound/core/info.c	Sat Feb 16 18:17:39 2002
@@ -160,31 +160,41 @@
 {
 	snd_info_private_data_t *data;
 	struct snd_info_entry *entry;
+	int ret;
 
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
+			ret = -EINVAL;
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
diff -urN linux-2.5.5-pre1/sound/isa/gus/gus_mem_proc.c linux/sound/isa/gus/gus_mem_proc.c
--- linux-2.5.5-pre1/sound/isa/gus/gus_mem_proc.c	Wed Feb 13 18:18:59 2002
+++ linux/sound/isa/gus/gus_mem_proc.c	Sat Feb 16 18:03:19 2002
@@ -60,6 +60,7 @@
 {
 	gus_proc_private_t *priv = snd_magic_cast(gus_proc_private_t, entry->private_data, return -ENXIO);
 
+	lock_kernel();
 	switch (orig) {
 	case 0:	/* SEEK_SET */
 		file->f_pos = offset;
@@ -71,10 +72,12 @@
 		file->f_pos = priv->size - offset;
 		break;
 	default:
+		unlock_kernel();
 		return -EINVAL;
 	}
 	if (file->f_pos > priv->size)
 		file->f_pos = priv->size;
+	unlock_kernel();
 	return file->f_pos;
 }
 




_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
