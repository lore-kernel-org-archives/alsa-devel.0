From: Jeff Muizelaar <muizelaar@rogers.com>
Subject: [PATCH] snd_info_entry_read/write cleanup
Date: Sun, 24 Aug 2003 20:59:15 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3F495F63.8080402@rogers.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------040501050700020506000705"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------040501050700020506000705
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

The attached patch cleans up the usage of the size variable and removes 
size1.

-Jeff

--------------040501050700020506000705
Content-Type: text/plain;
 name="size-cleanup.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="size-cleanup.patch"

Index: core/info.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/core/info.c,v
retrieving revision 1.39
diff -u -r1.39 info.c
--- core/info.c	18 Jul 2003 16:07:35 -0000	1.39
+++ core/info.c	25 Aug 2003 00:37:49 -0000
@@ -180,7 +180,7 @@
 	snd_info_private_data_t *data;
 	struct snd_info_entry *entry;
 	snd_info_buffer_t *buf;
-	long size = 0, size1;
+	long size = 0;
 
 	data = snd_magic_cast(snd_info_private_data_t, file->private_data, return -ENXIO);
 	snd_assert(data != NULL, return -ENXIO);
@@ -192,10 +192,7 @@
 			return -EIO;
 		if (file->f_pos >= (long)buf->size)
 			return 0;
-		size = buf->size < count ? buf->size : count;
-		size1 = buf->size - file->f_pos;
-		if (size1 < size)
-			size = size1;
+		size = min(count, buf->size - file->f_pos);
 		if (copy_to_user(buffer, buf->buffer + file->f_pos, size))
 			return -EFAULT;
 		file->f_pos += size;
@@ -205,8 +202,6 @@
 			return entry->c.ops->read(entry,
 						  data->file_private_data,
 						  file, buffer, count);
-		if (size > 0)
-			file->f_pos += size;
 		break;
 	}
 	return size;
@@ -218,7 +213,7 @@
 	snd_info_private_data_t *data;
 	struct snd_info_entry *entry;
 	snd_info_buffer_t *buf;
-	long size = 0, size1;
+	long size = 0;
 
 	data = snd_magic_cast(snd_info_private_data_t, file->private_data, return -ENXIO);
 	snd_assert(data != NULL, return -ENXIO);
@@ -232,10 +227,7 @@
 			return -EINVAL;
 		if (file->f_pos >= (long)buf->len)
 			return -ENOMEM;
-		size = buf->len < count ? buf->len : count;
-		size1 = buf->len - file->f_pos;
-		if (size1 < size)
-			size = size1;
+		size = min(count, buf->len - file->f_pos);
 		if (copy_from_user(buf->buffer + file->f_pos, buffer, size))
 			return -EFAULT;
 		if ((long)buf->size < file->f_pos + size)
@@ -247,8 +239,6 @@
 			return entry->c.ops->write(entry,
 						   data->file_private_data,
 						   file, buffer, count);
-		if (size > 0)
-			file->f_pos += size;
 		break;
 	}
 	return size;

--------------040501050700020506000705--



-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines
at the same time. Free trial click here:http://www.vmware.com/wl/offer/358/0
