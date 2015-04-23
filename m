From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/8] ALSA: core: Use seq_file for text proc
	file reads
Date: Thu, 23 Apr 2015 16:49:23 +0200
Message-ID: <1429800570-10153-2-git-send-email-tiwai@suse.de>
References: <1429800570-10153-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 57DBB261B14
 for <alsa-devel@alsa-project.org>; Thu, 23 Apr 2015 16:49:38 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 12703AD25
 for <alsa-devel@alsa-project.org>; Thu, 23 Apr 2015 14:49:38 +0000 (UTC)
In-Reply-To: <1429800570-10153-1-git-send-email-tiwai@suse.de>
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

seq_file is _the_ standard interface for simple text proc files.
Though, we still need to support the binary proc files and the text
file write, and also we need to manage the device disconnection
gracefully.  Thus this patch just replaces the text file read code
with seq_file while keeping the rest intact.

snd_iprintf() helper function is now a macro to expand itself to
seq_printf() to be compatible with the existing code.  The seq_file
object is stored to the unused entry->rbuffer->buffer pointer.

When the output size is expected to be large (greater than PAGE_SIZE),
the driver should set entry->size field beforehand.  Then the given
size will be preallocated and the multiple show calls can be avoided.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/sound/info.h |  16 +-
 sound/core/info.c    | 569 ++++++++++++++++++++++-----------------------------
 2 files changed, 261 insertions(+), 324 deletions(-)

diff --git a/include/sound/info.h b/include/sound/info.h
index 9ca1a493d370..ff8962ebece5 100644
--- a/include/sound/info.h
+++ b/include/sound/info.h
@@ -23,6 +23,7 @@
  */
 
 #include <linux/poll.h>
+#include <linux/seq_file.h>
 
 /* buffer for information */
 struct snd_info_buffer {
@@ -110,8 +111,18 @@ void snd_card_info_read_oss(struct snd_info_buffer *buffer);
 static inline void snd_card_info_read_oss(struct snd_info_buffer *buffer) {}
 #endif
 
-__printf(2, 3)
-int snd_iprintf(struct snd_info_buffer *buffer, const char *fmt, ...);
+/**
+ * snd_iprintf - printf on the procfs buffer
+ * @buf: the procfs buffer
+ * @fmt: the printf format
+ *
+ * Outputs the string on the procfs buffer just like printf().
+ *
+ * Return: zero for success, or a negative error code.
+ */
+#define snd_iprintf(buf, fmt, args...) \
+	seq_printf((struct seq_file *)(buf)->buffer, fmt, ##args)
+
 int snd_info_init(void);
 int snd_info_done(void);
 
@@ -175,7 +186,6 @@ static inline int snd_card_proc_new(struct snd_card *card, const char *name,
 static inline void snd_info_set_text_ops(struct snd_info_entry *entry __attribute__((unused)),
 					 void *private_data,
 					 void (*read)(struct snd_info_entry *, struct snd_info_buffer *)) {}
-
 static inline int snd_info_check_reserved_words(const char *str) { return 1; }
 
 #endif
diff --git a/sound/core/info.c b/sound/core/info.c
index 9f404e965ea2..8c1275f0fcbd 100644
--- a/sound/core/info.c
+++ b/sound/core/info.c
@@ -81,66 +81,6 @@ static int snd_info_version_init(void);
 static int snd_info_version_done(void);
 static void snd_info_disconnect(struct snd_info_entry *entry);
 
-
-/* resize the proc r/w buffer */
-static int resize_info_buffer(struct snd_info_buffer *buffer,
-			      unsigned int nsize)
-{
-	char *nbuf;
-
-	nsize = PAGE_ALIGN(nsize);
-	nbuf = krealloc(buffer->buffer, nsize, GFP_KERNEL | __GFP_ZERO);
-	if (! nbuf)
-		return -ENOMEM;
-
-	buffer->buffer = nbuf;
-	buffer->len = nsize;
-	return 0;
-}
-
-/**
- * snd_iprintf - printf on the procfs buffer
- * @buffer: the procfs buffer
- * @fmt: the printf format
- *
- * Outputs the string on the procfs buffer just like printf().
- *
- * Return: The size of output string, or a negative error code.
- */
-int snd_iprintf(struct snd_info_buffer *buffer, const char *fmt, ...)
-{
-	va_list args;
-	int len, res;
-	int err = 0;
-
-	might_sleep();
-	if (buffer->stop || buffer->error)
-		return 0;
-	len = buffer->len - buffer->size;
-	va_start(args, fmt);
-	for (;;) {
-		va_list ap;
-		va_copy(ap, args);
-		res = vsnprintf(buffer->buffer + buffer->curr, len, fmt, ap);
-		va_end(ap);
-		if (res < len)
-			break;
-		err = resize_info_buffer(buffer, buffer->len + PAGE_SIZE);
-		if (err < 0)
-			break;
-		len = buffer->len - buffer->size;
-	}
-	va_end(args);
-
-	if (err < 0)
-		return err;
-	buffer->curr += res;
-	buffer->size += res;
-	return res;
-}
-
-EXPORT_SYMBOL(snd_iprintf);
-
 /*
 
  */
@@ -153,6 +93,37 @@ EXPORT_SYMBOL(snd_seq_root);
 struct snd_info_entry *snd_oss_root;
 #endif
 
+static int alloc_info_private(struct snd_info_entry *entry,
+			      struct snd_info_private_data **ret)
+{
+	struct snd_info_private_data *data;
+
+	if (!entry || !entry->p)
+		return -ENODEV;
+	if (!try_module_get(entry->module))
+		return -EFAULT;
+	data = kzalloc(sizeof(*data), GFP_KERNEL);
+	if (!data) {
+		module_put(entry->module);
+		return -ENOMEM;
+	}
+	data->entry = entry;
+	*ret = data;
+	return 0;
+}
+
+static bool valid_pos(loff_t pos, size_t count)
+{
+	if (pos < 0 || (long) pos != pos || (ssize_t) count < 0)
+		return false;
+	if ((unsigned long) pos + (unsigned long) count < (unsigned long) pos)
+		return false;
+	return true;
+}
+
+/*
+ * file ops for binary proc files
+ */
 static loff_t snd_info_entry_llseek(struct file *file, loff_t offset, int orig)
 {
 	struct snd_info_private_data *data;
@@ -162,17 +133,14 @@ static loff_t snd_info_entry_llseek(struct file *file, loff_t offset, int orig)
 	data = file->private_data;
 	entry = data->entry;
 	mutex_lock(&entry->access);
-	if (entry->content == SNDRV_INFO_CONTENT_DATA &&
-	    entry->c.ops->llseek) {
+	if (entry->c.ops->llseek) {
 		offset = entry->c.ops->llseek(entry,
 					      data->file_private_data,
 					      file, offset, orig);
 		goto out;
 	}
-	if (entry->content == SNDRV_INFO_CONTENT_DATA)
-		size = entry->size;
-	else
-		size = 0;
+
+	size = entry->size;
 	switch (orig) {
 	case SEEK_SET:
 		break;
@@ -201,45 +169,20 @@ static loff_t snd_info_entry_llseek(struct file *file, loff_t offset, int orig)
 static ssize_t snd_info_entry_read(struct file *file, char __user *buffer,
 				   size_t count, loff_t * offset)
 {
-	struct snd_info_private_data *data;
-	struct snd_info_entry *entry;
-	struct snd_info_buffer *buf;
-	size_t size = 0;
+	struct snd_info_private_data *data = file->private_data;
+	struct snd_info_entry *entry = data->entry;
+	size_t size;
 	loff_t pos;
 
-	data = file->private_data;
-	if (snd_BUG_ON(!data))
-		return -ENXIO;
 	pos = *offset;
-	if (pos < 0 || (long) pos != pos || (ssize_t) count < 0)
-		return -EIO;
-	if ((unsigned long) pos + (unsigned long) count < (unsigned long) pos)
+	if (!valid_pos(pos, count))
 		return -EIO;
-	entry = data->entry;
-	switch (entry->content) {
-	case SNDRV_INFO_CONTENT_TEXT:
-		buf = data->rbuffer;
-		if (buf == NULL)
-			return -EIO;
-		if (pos >= buf->size)
-			return 0;
-		size = buf->size - pos;
-		size = min(count, size);
-		if (copy_to_user(buffer, buf->buffer + pos, size))
-			return -EFAULT;
-		break;
-	case SNDRV_INFO_CONTENT_DATA:
-		if (pos >= entry->size)
-			return 0;
-		if (entry->c.ops->read) {
-			size = entry->size - pos;
-			size = min(count, size);
-			size = entry->c.ops->read(entry,
-						  data->file_private_data,
-						  file, buffer, size, pos);
-		}
-		break;
-	}
+	if (pos >= entry->size)
+		return 0;
+	size = entry->size - pos;
+	size = min(count, size);
+	size = entry->c.ops->read(entry, data->file_private_data,
+				  file, buffer, size, pos);
 	if ((ssize_t) size > 0)
 		*offset = pos + size;
 	return size;
@@ -248,280 +191,259 @@ static ssize_t snd_info_entry_read(struct file *file, char __user *buffer,
 static ssize_t snd_info_entry_write(struct file *file, const char __user *buffer,
 				    size_t count, loff_t * offset)
 {
-	struct snd_info_private_data *data;
-	struct snd_info_entry *entry;
-	struct snd_info_buffer *buf;
+	struct snd_info_private_data *data = file->private_data;
+	struct snd_info_entry *entry = data->entry;
 	ssize_t size = 0;
 	loff_t pos;
 
-	data = file->private_data;
-	if (snd_BUG_ON(!data))
-		return -ENXIO;
-	entry = data->entry;
 	pos = *offset;
-	if (pos < 0 || (long) pos != pos || (ssize_t) count < 0)
+	if (!valid_pos(pos, count))
 		return -EIO;
-	if ((unsigned long) pos + (unsigned long) count < (unsigned long) pos)
-		return -EIO;
-	switch (entry->content) {
-	case SNDRV_INFO_CONTENT_TEXT:
-		buf = data->wbuffer;
-		if (buf == NULL)
-			return -EIO;
-		mutex_lock(&entry->access);
-		if (pos + count >= buf->len) {
-			if (resize_info_buffer(buf, pos + count)) {
-				mutex_unlock(&entry->access);
-				return -ENOMEM;
-			}
-		}
-		if (copy_from_user(buf->buffer + pos, buffer, count)) {
-			mutex_unlock(&entry->access);
-			return -EFAULT;
-		}
-		buf->size = pos + count;
-		mutex_unlock(&entry->access);
-		size = count;
-		break;
-	case SNDRV_INFO_CONTENT_DATA:
-		if (entry->c.ops->write && count > 0) {
-			size_t maxsize = entry->size - pos;
-			count = min(count, maxsize);
-			size = entry->c.ops->write(entry,
-						   data->file_private_data,
-						   file, buffer, count, pos);
-		}
-		break;
+	if (count > 0) {
+		size_t maxsize = entry->size - pos;
+		count = min(count, maxsize);
+		size = entry->c.ops->write(entry, data->file_private_data,
+					   file, buffer, count, pos);
 	}
-	if ((ssize_t) size > 0)
+	if (size > 0)
 		*offset = pos + size;
 	return size;
 }
 
-static int snd_info_entry_open(struct inode *inode, struct file *file)
+static unsigned int snd_info_entry_poll(struct file *file, poll_table *wait)
+{
+	struct snd_info_private_data *data = file->private_data;
+	struct snd_info_entry *entry = data->entry;
+	unsigned int mask = 0;
+
+	if (entry->c.ops->poll)
+		return entry->c.ops->poll(entry,
+					  data->file_private_data,
+					  file, wait);
+	if (entry->c.ops->read)
+		mask |= POLLIN | POLLRDNORM;
+	if (entry->c.ops->write)
+		mask |= POLLOUT | POLLWRNORM;
+	return mask;
+}
+
+static long snd_info_entry_ioctl(struct file *file, unsigned int cmd,
+				unsigned long arg)
+{
+	struct snd_info_private_data *data = file->private_data;
+	struct snd_info_entry *entry = data->entry;
+
+	if (!entry->c.ops->ioctl)
+		return -ENOTTY;
+	return entry->c.ops->ioctl(entry, data->file_private_data,
+				   file, cmd, arg);
+}
+
+static int snd_info_entry_mmap(struct file *file, struct vm_area_struct *vma)
 {
+	struct inode *inode = file_inode(file);
+	struct snd_info_private_data *data;
 	struct snd_info_entry *entry;
+
+	data = file->private_data;
+	if (data == NULL)
+		return 0;
+	entry = data->entry;
+	if (!entry->c.ops->mmap)
+		return -ENXIO;
+	return entry->c.ops->mmap(entry, data->file_private_data,
+				  inode, file, vma);
+}
+
+static int snd_info_entry_open(struct inode *inode, struct file *file)
+{
+	struct snd_info_entry *entry = PDE_DATA(inode);
 	struct snd_info_private_data *data;
-	struct snd_info_buffer *buffer;
 	int mode, err;
 
 	mutex_lock(&info_mutex);
-	entry = PDE_DATA(inode);
-	if (entry == NULL || ! entry->p) {
-		mutex_unlock(&info_mutex);
-		return -ENODEV;
-	}
-	if (!try_module_get(entry->module)) {
-		err = -EFAULT;
-		goto __error1;
-	}
+	err = alloc_info_private(entry, &data);
+	if (err < 0)
+		goto unlock;
+
 	mode = file->f_flags & O_ACCMODE;
-	if (mode == O_RDONLY || mode == O_RDWR) {
-		if ((entry->content == SNDRV_INFO_CONTENT_DATA &&
-		     entry->c.ops->read == NULL)) {
-		    	err = -ENODEV;
-		    	goto __error;
-		}
-	}
-	if (mode == O_WRONLY || mode == O_RDWR) {
-		if ((entry->content == SNDRV_INFO_CONTENT_DATA &&
-		     entry->c.ops->write == NULL)) {
-		    	err = -ENODEV;
-		    	goto __error;
-		}
+	if (((mode == O_RDONLY || mode == O_RDWR) && !entry->c.ops->read) ||
+	    ((mode == O_WRONLY || mode == O_RDWR) && !entry->c.ops->write)) {
+		err = -ENODEV;
+		goto error;
 	}
-	data = kzalloc(sizeof(*data), GFP_KERNEL);
-	if (data == NULL) {
-		err = -ENOMEM;
-		goto __error;
-	}
-	data->entry = entry;
-	switch (entry->content) {
-	case SNDRV_INFO_CONTENT_TEXT:
-		if (mode == O_RDONLY || mode == O_RDWR) {
-			buffer = kzalloc(sizeof(*buffer), GFP_KERNEL);
-			if (buffer == NULL)
-				goto __nomem;
-			data->rbuffer = buffer;
-			buffer->len = PAGE_SIZE;
-			buffer->buffer = kzalloc(buffer->len, GFP_KERNEL);
-			if (buffer->buffer == NULL)
-				goto __nomem;
-		}
-		if (mode == O_WRONLY || mode == O_RDWR) {
-			buffer = kzalloc(sizeof(*buffer), GFP_KERNEL);
-			if (buffer == NULL)
-				goto __nomem;
-			data->wbuffer = buffer;
-			buffer->len = PAGE_SIZE;
-			buffer->buffer = kmalloc(buffer->len, GFP_KERNEL);
-			if (buffer->buffer == NULL)
-				goto __nomem;
-		}
-		break;
-	case SNDRV_INFO_CONTENT_DATA:	/* data */
-		if (entry->c.ops->open) {
-			if ((err = entry->c.ops->open(entry, mode,
-						      &data->file_private_data)) < 0) {
-				kfree(data);
-				goto __error;
-			}
-		}
-		break;
+
+	if (entry->c.ops->open) {
+		err = entry->c.ops->open(entry, mode, &data->file_private_data);
+		if (err < 0)
+			goto error;
 	}
+
 	file->private_data = data;
 	mutex_unlock(&info_mutex);
-	if (entry->content == SNDRV_INFO_CONTENT_TEXT &&
-	    (mode == O_RDONLY || mode == O_RDWR)) {
-		if (entry->c.text.read) {
-			mutex_lock(&entry->access);
-			entry->c.text.read(entry, data->rbuffer);
-			mutex_unlock(&entry->access);
-		}
-	}
 	return 0;
 
- __nomem:
-	if (data->rbuffer) {
-		kfree(data->rbuffer->buffer);
-		kfree(data->rbuffer);
-	}
-	if (data->wbuffer) {
-		kfree(data->wbuffer->buffer);
-		kfree(data->wbuffer);
-	}
+ error:
 	kfree(data);
-	err = -ENOMEM;
-      __error:
 	module_put(entry->module);
-      __error1:
+ unlock:
 	mutex_unlock(&info_mutex);
 	return err;
 }
 
 static int snd_info_entry_release(struct inode *inode, struct file *file)
 {
-	struct snd_info_entry *entry;
-	struct snd_info_private_data *data;
-	int mode;
+	struct snd_info_private_data *data = file->private_data;
+	struct snd_info_entry *entry = data->entry;
 
-	mode = file->f_flags & O_ACCMODE;
-	data = file->private_data;
-	entry = data->entry;
-	switch (entry->content) {
-	case SNDRV_INFO_CONTENT_TEXT:
-		if (data->rbuffer) {
-			kfree(data->rbuffer->buffer);
-			kfree(data->rbuffer);
-		}
-		if (data->wbuffer) {
-			if (entry->c.text.write) {
-				entry->c.text.write(entry, data->wbuffer);
-				if (data->wbuffer->error) {
-					if (entry->card)
-						dev_warn(entry->card->dev, "info: data write error to %s (%i)\n",
-							 entry->name,
-							 data->wbuffer->error);
-					else
-						pr_warn("ALSA: info: data write error to %s (%i)\n",
-							entry->name,
-							data->wbuffer->error);
-				}
-			}
-			kfree(data->wbuffer->buffer);
-			kfree(data->wbuffer);
-		}
-		break;
-	case SNDRV_INFO_CONTENT_DATA:
-		if (entry->c.ops->release)
-			entry->c.ops->release(entry, mode,
-					      data->file_private_data);
-		break;
-	}
+	if (entry->c.ops->release)
+		entry->c.ops->release(entry, file->f_flags & O_ACCMODE,
+				      data->file_private_data);
 	module_put(entry->module);
 	kfree(data);
 	return 0;
 }
 
-static unsigned int snd_info_entry_poll(struct file *file, poll_table * wait)
+static const struct file_operations snd_info_entry_operations =
 {
-	struct snd_info_private_data *data;
-	struct snd_info_entry *entry;
-	unsigned int mask;
+	.owner =		THIS_MODULE,
+	.llseek =		snd_info_entry_llseek,
+	.read =			snd_info_entry_read,
+	.write =		snd_info_entry_write,
+	.poll =			snd_info_entry_poll,
+	.unlocked_ioctl =	snd_info_entry_ioctl,
+	.mmap =			snd_info_entry_mmap,
+	.open =			snd_info_entry_open,
+	.release =		snd_info_entry_release,
+};
 
-	data = file->private_data;
-	if (data == NULL)
-		return 0;
-	entry = data->entry;
-	mask = 0;
-	switch (entry->content) {
-	case SNDRV_INFO_CONTENT_DATA:
-		if (entry->c.ops->poll)
-			return entry->c.ops->poll(entry,
-						  data->file_private_data,
-						  file, wait);
-		if (entry->c.ops->read)
-			mask |= POLLIN | POLLRDNORM;
-		if (entry->c.ops->write)
-			mask |= POLLOUT | POLLWRNORM;
-		break;
+/*
+ * file ops for text proc files
+ */
+static ssize_t snd_info_text_entry_write(struct file *file,
+					 const char __user *buffer,
+					 size_t count, loff_t *offset)
+{
+	struct seq_file *m = file->private_data;
+	struct snd_info_private_data *data = m->private;
+	struct snd_info_entry *entry = data->entry;
+	struct snd_info_buffer *buf;
+	loff_t pos;
+	size_t next;
+	int err = 0;
+
+	pos = *offset;
+	if (!valid_pos(pos, count))
+		return -EIO;
+	next = pos + count;
+	mutex_lock(&entry->access);
+	buf = data->wbuffer;
+	if (!buf) {
+		data->wbuffer = buf = kzalloc(sizeof(*buf), GFP_KERNEL);
+		if (!buf) {
+			err = -ENOMEM;
+			goto error;
+		}
 	}
-	return mask;
+	if (next > buf->len) {
+		char *nbuf = krealloc(buf->buffer, PAGE_ALIGN(next),
+				      GFP_KERNEL | __GFP_ZERO);
+		if (!nbuf) {
+			err = -ENOMEM;
+			goto error;
+		}
+		buf->buffer = nbuf;
+		buf->len = PAGE_ALIGN(next);
+	}
+	if (copy_from_user(buf->buffer + pos, buffer, count)) {
+		err = -EFAULT;
+		goto error;
+	}
+	buf->size = next;
+ error:
+	mutex_unlock(&entry->access);
+	if (err < 0)
+		return err;
+	*offset = next;
+	return count;
 }
 
-static long snd_info_entry_ioctl(struct file *file, unsigned int cmd,
-				unsigned long arg)
+static int snd_info_seq_show(struct seq_file *seq, void *p)
 {
-	struct snd_info_private_data *data;
-	struct snd_info_entry *entry;
+	struct snd_info_private_data *data = seq->private;
+	struct snd_info_entry *entry = data->entry;
 
-	data = file->private_data;
-	if (data == NULL)
-		return 0;
-	entry = data->entry;
-	switch (entry->content) {
-	case SNDRV_INFO_CONTENT_DATA:
-		if (entry->c.ops->ioctl)
-			return entry->c.ops->ioctl(entry,
-						   data->file_private_data,
-						   file, cmd, arg);
-		break;
+	if (entry->c.text.read) {
+		data->rbuffer->buffer = (char *)seq; /* XXX hack! */
+		entry->c.text.read(entry, data->rbuffer);
 	}
-	return -ENOTTY;
+	return 0;
 }
 
-static int snd_info_entry_mmap(struct file *file, struct vm_area_struct *vma)
+static int snd_info_text_entry_open(struct inode *inode, struct file *file)
 {
-	struct inode *inode = file_inode(file);
+	struct snd_info_entry *entry = PDE_DATA(inode);
 	struct snd_info_private_data *data;
-	struct snd_info_entry *entry;
+	int err;
 
-	data = file->private_data;
-	if (data == NULL)
-		return 0;
-	entry = data->entry;
-	switch (entry->content) {
-	case SNDRV_INFO_CONTENT_DATA:
-		if (entry->c.ops->mmap)
-			return entry->c.ops->mmap(entry,
-						  data->file_private_data,
-						  inode, file, vma);
-		break;
+	mutex_lock(&info_mutex);
+	err = alloc_info_private(entry, &data);
+	if (err < 0)
+		goto unlock;
+
+	data->rbuffer = kzalloc(sizeof(*data->rbuffer), GFP_KERNEL);
+	if (!data->rbuffer) {
+		err = -ENOMEM;
+		goto error;
+	}
+	if (entry->size)
+		err = single_open_size(file, snd_info_seq_show, data,
+				       entry->size);
+	else
+		err = single_open(file, snd_info_seq_show, data);
+	if (err < 0)
+		goto error;
+	mutex_unlock(&info_mutex);
+	return 0;
+
+ error:
+	kfree(data->rbuffer);
+	kfree(data);
+	module_put(entry->module);
+ unlock:
+	mutex_unlock(&info_mutex);
+	return err;
+}
+
+static int snd_info_text_entry_release(struct inode *inode, struct file *file)
+{
+	struct seq_file *m = file->private_data;
+	struct snd_info_private_data *data = m->private;
+	struct snd_info_entry *entry = data->entry;
+
+	if (data->wbuffer && entry->c.text.write)
+		entry->c.text.write(entry, data->wbuffer);
+
+	single_release(inode, file);
+	kfree(data->rbuffer);
+	if (data->wbuffer) {
+		kfree(data->wbuffer->buffer);
+		kfree(data->wbuffer);
 	}
-	return -ENXIO;
+
+	module_put(entry->module);
+	kfree(data);
+	return 0;
 }
 
-static const struct file_operations snd_info_entry_operations =
+static const struct file_operations snd_info_text_entry_ops =
 {
 	.owner =		THIS_MODULE,
-	.llseek =		snd_info_entry_llseek,
-	.read =			snd_info_entry_read,
-	.write =		snd_info_entry_write,
-	.poll =			snd_info_entry_poll,
-	.unlocked_ioctl =	snd_info_entry_ioctl,
-	.mmap =			snd_info_entry_mmap,
-	.open =			snd_info_entry_open,
-	.release =		snd_info_entry_release,
+	.open =			snd_info_text_entry_open,
+	.release =		snd_info_text_entry_release,
+	.write =		snd_info_text_entry_write,
+	.llseek =		seq_lseek,
+	.read =			seq_read,
 };
 
 int __init snd_info_init(void)
@@ -955,8 +877,13 @@ int snd_info_register(struct snd_info_entry * entry)
 			return -ENOMEM;
 		}
 	} else {
+		const struct file_operations *ops;
+		if (entry->content == SNDRV_INFO_CONTENT_DATA)
+			ops = &snd_info_entry_operations;
+		else
+			ops = &snd_info_text_entry_ops;
 		p = proc_create_data(entry->name, entry->mode, root,
-					&snd_info_entry_operations, entry);
+				     ops, entry);
 		if (!p) {
 			mutex_unlock(&info_mutex);
 			return -ENOMEM;
-- 
2.3.5
