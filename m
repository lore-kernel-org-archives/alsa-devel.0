From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/5] ALSA: info - Check file position validity
	in common layer
Date: Wed, 14 Apr 2010 10:18:00 +0200
Message-ID: <1271233083-16310-3-git-send-email-tiwai@suse.de>
References: <1271233083-16310-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by alsa0.perex.cz (Postfix) with ESMTP id 832F32447A
	for <alsa-devel@alsa-project.org>;
	Wed, 14 Apr 2010 10:18:41 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.221.2])
	by mx2.suse.de (Postfix) with ESMTP id 6F26489471
	for <alsa-devel@alsa-project.org>;
	Wed, 14 Apr 2010 10:18:41 +0200 (CEST)
In-Reply-To: <1271233083-16310-1-git-send-email-tiwai@suse.de>
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

Check the validity of the file position in the common info layer before
calling read or write callbacks in assumption that entry->size is set up
properly to indicate the max file size.

Removed the redundant checks from the callbacks as well.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/info.c              |   14 +++++++++--
 sound/drivers/opl4/opl4_proc.c |   46 ++++++++++++++--------------------------
 sound/isa/gus/gus_mem_proc.c   |   14 +++--------
 sound/pci/cs4281.c             |   24 +++++---------------
 sound/pci/cs46xx/cs46xx_lib.c  |   12 ++-------
 sound/pci/emu10k1/emuproc.c    |   43 +++++++++++++++++--------------------
 sound/pci/mixart/mixart.c      |   12 ----------
 7 files changed, 60 insertions(+), 105 deletions(-)

diff --git a/sound/core/info.c b/sound/core/info.c
index ff968be..f90a6fd 100644
--- a/sound/core/info.c
+++ b/sound/core/info.c
@@ -232,10 +232,15 @@ static ssize_t snd_info_entry_read(struct file *file, char __user *buffer,
 			return -EFAULT;
 		break;
 	case SNDRV_INFO_CONTENT_DATA:
-		if (entry->c.ops->read)
+		if (pos >= entry->size)
+			return 0;
+		if (entry->c.ops->read) {
+			size = entry->size - pos;
+			size = min(count, size);
 			size = entry->c.ops->read(entry,
 						  data->file_private_data,
-						  file, buffer, count, pos);
+						  file, buffer, size, pos);
+		}
 		break;
 	}
 	if ((ssize_t) size > 0)
@@ -282,10 +287,13 @@ static ssize_t snd_info_entry_write(struct file *file, const char __user *buffer
 		size = count;
 		break;
 	case SNDRV_INFO_CONTENT_DATA:
-		if (entry->c.ops->write)
+		if (entry->c.ops->write && count > 0) {
+			size_t maxsize = entry->size - pos;
+			count = min(count, maxsize);
 			size = entry->c.ops->write(entry,
 						   data->file_private_data,
 						   file, buffer, count, pos);
+		}
 		break;
 	}
 	if ((ssize_t) size > 0)
diff --git a/sound/drivers/opl4/opl4_proc.c b/sound/drivers/opl4/opl4_proc.c
index eb72814..210b89d 100644
--- a/sound/drivers/opl4/opl4_proc.c
+++ b/sound/drivers/opl4/opl4_proc.c
@@ -55,25 +55,18 @@ static ssize_t snd_opl4_mem_proc_read(struct snd_info_entry *entry,
 				      size_t count, loff_t pos)
 {
 	struct snd_opl4 *opl4 = entry->private_data;
-	long size;
 	char* buf;
 
-	size = count;
-	if (pos + size > entry->size)
-		size = entry->size - pos;
-	if (size > 0) {
-		buf = vmalloc(size);
-		if (!buf)
-			return -ENOMEM;
-		snd_opl4_read_memory(opl4, buf, pos, size);
-		if (copy_to_user(_buf, buf, size)) {
-			vfree(buf);
-			return -EFAULT;
-		}
+	buf = vmalloc(count);
+	if (!buf)
+		return -ENOMEM;
+	snd_opl4_read_memory(opl4, buf, pos, count);
+	if (copy_to_user(_buf, buf, count)) {
 		vfree(buf);
-		return size;
+		return -EFAULT;
 	}
-	return 0;
+	vfree(buf);
+	return count;
 }
 
 static ssize_t snd_opl4_mem_proc_write(struct snd_info_entry *entry,
@@ -83,25 +76,18 @@ static ssize_t snd_opl4_mem_proc_write(struct snd_info_entry *entry,
 				       size_t count, size_t pos)
 {
 	struct snd_opl4 *opl4 = entry->private_data;
-	long size;
 	char *buf;
 
-	size = count;
-	if (pos + size > entry->size)
-		size = entry->size - pos;
-	if (size > 0) {
-		buf = vmalloc(size);
-		if (!buf)
-			return -ENOMEM;
-		if (copy_from_user(buf, _buf, size)) {
-			vfree(buf);
-			return -EFAULT;
-		}
-		snd_opl4_write_memory(opl4, buf, pos, size);
+	buf = vmalloc(count);
+	if (!buf)
+		return -ENOMEM;
+	if (copy_from_user(buf, _buf, count)) {
 		vfree(buf);
-		return size;
+		return -EFAULT;
 	}
-	return 0;
+	snd_opl4_write_memory(opl4, buf, pos, count);
+	vfree(buf);
+	return count;
 }
 
 static loff_t snd_opl4_mem_proc_llseek(struct snd_info_entry *entry,
diff --git a/sound/isa/gus/gus_mem_proc.c b/sound/isa/gus/gus_mem_proc.c
index b2d2dba..faa2bec 100644
--- a/sound/isa/gus/gus_mem_proc.c
+++ b/sound/isa/gus/gus_mem_proc.c
@@ -36,20 +36,14 @@ static ssize_t snd_gf1_mem_proc_dump(struct snd_info_entry *entry,
 				     struct file *file, char __user *buf,
 				     size_t count, loff_t pos)
 {
-	long size;
 	struct gus_proc_private *priv = entry->private_data;
 	struct snd_gus_card *gus = priv->gus;
 	int err;
 
-	size = count;
-	if (pos + size > priv->size)
-		size = (long)priv->size - pos;
-	if (size > 0) {
-		if ((err = snd_gus_dram_read(gus, buf, pos, size, priv->rom)) < 0)
-			return err;
-		return size;
-	}
-	return 0;
+	err = snd_gus_dram_read(gus, buf, pos, count, priv->rom);
+	if (err < 0)
+		return err;
+	return count;
 }			
 
 static loff_t snd_gf1_mem_proc_llseek(struct snd_info_entry *entry,
diff --git a/sound/pci/cs4281.c b/sound/pci/cs4281.c
index b0bba2e..6772070 100644
--- a/sound/pci/cs4281.c
+++ b/sound/pci/cs4281.c
@@ -1144,17 +1144,11 @@ static ssize_t snd_cs4281_BA0_read(struct snd_info_entry *entry,
 				   struct file *file, char __user *buf,
 				   size_t count, loff_t pos)
 {
-	long size;
 	struct cs4281 *chip = entry->private_data;
 	
-	size = count;
-	if (pos + size > CS4281_BA0_SIZE)
-		size = (long)CS4281_BA0_SIZE - pos;
-	if (size > 0) {
-		if (copy_to_user_fromio(buf, chip->ba0 + pos, size))
-			return -EFAULT;
-	}
-	return size;
+	if (copy_to_user_fromio(buf, chip->ba0 + pos, count))
+		return -EFAULT;
+	return count;
 }
 
 static ssize_t snd_cs4281_BA1_read(struct snd_info_entry *entry,
@@ -1162,17 +1156,11 @@ static ssize_t snd_cs4281_BA1_read(struct snd_info_entry *entry,
 				   struct file *file, char __user *buf,
 				   size_t count, loff_t pos)
 {
-	long size;
 	struct cs4281 *chip = entry->private_data;
 	
-	size = count;
-	if (pos + size > CS4281_BA1_SIZE)
-		size = (long)CS4281_BA1_SIZE - pos;
-	if (size > 0) {
-		if (copy_to_user_fromio(buf, chip->ba1 + pos, size))
-			return -EFAULT;
-	}
-	return size;
+	if (copy_to_user_fromio(buf, chip->ba1 + pos, count))
+		return -EFAULT;
+	return count;
 }
 
 static struct snd_info_entry_ops snd_cs4281_proc_ops_BA0 = {
diff --git a/sound/pci/cs46xx/cs46xx_lib.c b/sound/pci/cs46xx/cs46xx_lib.c
index 08117b1..aad3708 100644
--- a/sound/pci/cs46xx/cs46xx_lib.c
+++ b/sound/pci/cs46xx/cs46xx_lib.c
@@ -2662,17 +2662,11 @@ static ssize_t snd_cs46xx_io_read(struct snd_info_entry *entry,
 				  struct file *file, char __user *buf,
 				  size_t count, loff_t pos)
 {
-	long size;
 	struct snd_cs46xx_region *region = entry->private_data;
 	
-	size = count;
-	if (pos + (size_t)size > region->size)
-		size = region->size - pos;
-	if (size > 0) {
-		if (copy_to_user_fromio(buf, region->remap_addr + pos, size))
-			return -EFAULT;
-	}
-	return size;
+	if (copy_to_user_fromio(buf, region->remap_addr + pos, count))
+		return -EFAULT;
+	return count;
 }
 
 static struct snd_info_entry_ops snd_cs46xx_proc_io_ops = {
diff --git a/sound/pci/emu10k1/emuproc.c b/sound/pci/emu10k1/emuproc.c
index 347b241..bc38dd4 100644
--- a/sound/pci/emu10k1/emuproc.c
+++ b/sound/pci/emu10k1/emuproc.c
@@ -346,10 +346,12 @@ static ssize_t snd_emu10k1_fx8010_read(struct snd_info_entry *entry,
 				       struct file *file, char __user *buf,
 				       size_t count, loff_t pos)
 {
-	long size;
 	struct snd_emu10k1 *emu = entry->private_data;
 	unsigned int offset;
 	int tram_addr = 0;
+	unsigned int *tmp;
+	long res;
+	unsigned int idx;
 	
 	if (!strcmp(entry->name, "fx8010_tram_addr")) {
 		offset = TANKMEMADDRREGBASE;
@@ -361,30 +363,25 @@ static ssize_t snd_emu10k1_fx8010_read(struct snd_info_entry *entry,
 	} else {
 		offset = emu->audigy ? A_FXGPREGBASE : FXGPREGBASE;
 	}
-	size = count;
-	if (pos + size > entry->size)
-		size = (long)entry->size - pos;
-	if (size > 0) {
-		unsigned int *tmp;
-		long res;
-		unsigned int idx;
-		if ((tmp = kmalloc(size + 8, GFP_KERNEL)) == NULL)
-			return -ENOMEM;
-		for (idx = 0; idx < ((pos & 3) + size + 3) >> 2; idx++)
-			if (tram_addr && emu->audigy) {
-				tmp[idx] = snd_emu10k1_ptr_read(emu, offset + idx + (pos >> 2), 0) >> 11;
-				tmp[idx] |= snd_emu10k1_ptr_read(emu, 0x100 + idx + (pos >> 2), 0) << 20;
-			} else 
-				tmp[idx] = snd_emu10k1_ptr_read(emu, offset + idx + (pos >> 2), 0);
-		if (copy_to_user(buf, ((char *)tmp) + (pos & 3), size))
-			res = -EFAULT;
-		else {
-			res = size;
+
+	tmp = kmalloc(count + 8, GFP_KERNEL);
+	if (!tmp)
+		return -ENOMEM;
+	for (idx = 0; idx < ((pos & 3) + count + 3) >> 2; idx++) {
+		unsigned int val;
+		val = snd_emu10k1_ptr_read(emu, offset + idx + (pos >> 2), 0);
+		if (tram_addr && emu->audigy) {
+			val >>= 11;
+			val |= snd_emu10k1_ptr_read(emu, 0x100 + idx + (pos >> 2), 0) << 20;
 		}
-		kfree(tmp);
-		return res;
+		tmp[idx] = val;
 	}
-	return 0;
+	if (copy_to_user(buf, ((char *)tmp) + (pos & 3), count))
+		res = -EFAULT;
+	else
+		res = count;
+	kfree(tmp);
+	return res;
 }
 
 static void snd_emu10k1_proc_voices_read(struct snd_info_entry *entry, 
diff --git a/sound/pci/mixart/mixart.c b/sound/pci/mixart/mixart.c
index b5df78b..be95e00 100644
--- a/sound/pci/mixart/mixart.c
+++ b/sound/pci/mixart/mixart.c
@@ -1161,13 +1161,7 @@ static ssize_t snd_mixart_BA0_read(struct snd_info_entry *entry,
 				   size_t count, loff_t pos)
 {
 	struct mixart_mgr *mgr = entry->private_data;
-	unsigned long maxsize;
 
-	if (pos >= MIXART_BA0_SIZE)
-		return 0;
-	maxsize = MIXART_BA0_SIZE - pos;
-	if (count > maxsize)
-		count = maxsize;
 	count = count & ~3; /* make sure the read size is a multiple of 4 bytes */
 	if (copy_to_user_fromio(buf, MIXART_MEM(mgr, pos), count))
 		return -EFAULT;
@@ -1183,13 +1177,7 @@ static ssize_t snd_mixart_BA1_read(struct snd_info_entry *entry,
 				   size_t count, loff_t pos)
 {
 	struct mixart_mgr *mgr = entry->private_data;
-	unsigned long maxsize;
 
-	if (pos > MIXART_BA1_SIZE)
-		return 0;
-	maxsize = MIXART_BA1_SIZE - pos;
-	if (count > maxsize)
-		count = maxsize;
 	count = count & ~3; /* make sure the read size is a multiple of 4 bytes */
 	if (copy_to_user_fromio(buf, MIXART_REG(mgr, pos), count))
 		return -EFAULT;
-- 
1.7.0.4
