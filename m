From: Robert Love <rml@tech9.net>
Subject: Re: [PATCH] ALSA not using updated lseek locking
Date: 18 Feb 2002 15:29:15 -0500
Message-ID: <1014064157.851.2789.camel@phantasy>
References: <Pine.LNX.4.31.0202182108080.509-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Received: from zero.tech9.net (zero.tech9.net [209.61.188.187])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id VAA08402
	for <alsa-devel@alsa-project.org>; Mon, 18 Feb 2002 21:29:11 +0100
In-Reply-To: <Pine.LNX.4.31.0202182108080.509-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "torvalds@transmeta.com" <torvalds@transmeta.com>, "manfred@colorfullife.com" <manfred@colorfullife.com>
List-Id: alsa-devel@alsa-project.org

On Mon, 2002-02-18 at 15:12, Jaroslav Kysela wrote:

> Sorry to reply too late, but I've not received this email before. It seems
> that LKML has some trouble. Only the part of patch for sound/core/info.c
> is valid, because llseek in gus_mem_proc.c is called from snd_info_entry_llseek(),
> thus the function is already protected.

Ah, the lseek in sound/isa/gus/gus_mem_proc.c :: snd_gf1_mem_proc_llseek
is _only_ called from info.c's lseek?  Then, indeed, we can remove it.

Attached patch below only adds the BKL to info.c's lseek.  Thanks,

	Robert Love

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


_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
