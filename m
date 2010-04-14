From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 3/5] ALSA: info - Implement common llseek for
	binary mode
Date: Wed, 14 Apr 2010 10:18:01 +0200
Message-ID: <1271233083-16310-4-git-send-email-tiwai@suse.de>
References: <1271233083-16310-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (cantor.suse.de [195.135.220.2])
	by alsa0.perex.cz (Postfix) with ESMTP id A9D7A24483
	for <alsa-devel@alsa-project.org>;
	Wed, 14 Apr 2010 10:18:41 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.221.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id 86A7390847
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

The llseek implementation is identical for existing driver implementations,
so let's merge to the common layer.  The same code for the text proc file
can be used even for the binary proc file.

The driver can provide its own llseek method if needed.  Then the common
code will be skipped.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/info.c              |   54 +++++++++++++++++++++------------------
 sound/drivers/opl4/opl4_proc.c |   24 -----------------
 sound/isa/gus/gus_mem_proc.c   |   26 -------------------
 sound/pci/mixart/mixart.c      |   51 -------------------------------------
 4 files changed, 29 insertions(+), 126 deletions(-)

diff --git a/sound/core/info.c b/sound/core/info.c
index f90a6fd..b70564e 100644
--- a/sound/core/info.c
+++ b/sound/core/info.c
@@ -164,39 +164,43 @@ static loff_t snd_info_entry_llseek(struct file *file, loff_t offset, int orig)
 {
 	struct snd_info_private_data *data;
 	struct snd_info_entry *entry;
-	loff_t ret;
+	loff_t ret = -EINVAL, size;
 
 	data = file->private_data;
 	entry = data->entry;
 	mutex_lock(&entry->access);
-	switch (entry->content) {
-	case SNDRV_INFO_CONTENT_TEXT:
-		switch (orig) {
-		case SEEK_SET:
-			file->f_pos = offset;
-			ret = file->f_pos;
-			goto out;
-		case SEEK_CUR:
-			file->f_pos += offset;
-			ret = file->f_pos;
-			goto out;
-		case SEEK_END:
-		default:
-			ret = -EINVAL;
-			goto out;
-		}
+	if (entry->content == SNDRV_INFO_CONTENT_DATA &&
+	    entry->c.ops->llseek) {
+		offset = entry->c.ops->llseek(entry,
+					      data->file_private_data,
+					      file, offset, orig);
+		goto out;
+	}
+	if (entry->content == SNDRV_INFO_CONTENT_DATA)
+		size = entry->size;
+	else
+		size = 0;
+	switch (orig) {
+	case SEEK_SET:
 		break;
-	case SNDRV_INFO_CONTENT_DATA:
-		if (entry->c.ops->llseek) {
-			ret = entry->c.ops->llseek(entry,
-						    data->file_private_data,
-						    file, offset, orig);
+	case SEEK_CUR:
+		offset += file->f_pos;
+		break;
+	case SEEK_END:
+		if (!size)
 			goto out;
-		}
+		offset += size;
 		break;
-	}
-	ret = -ENXIO;
-out:
+	default:
+		goto out;
+	}
+	if (offset < 0)
+		goto out;
+	if (size && offset > size)
+		offset = size;
+	file->f_pos = offset;
+	ret = offset;
+ out:
 	mutex_unlock(&entry->access);
 	return ret;
 }
diff --git a/sound/drivers/opl4/opl4_proc.c b/sound/drivers/opl4/opl4_proc.c
index 210b89d..c5c13c4 100644
--- a/sound/drivers/opl4/opl4_proc.c
+++ b/sound/drivers/opl4/opl4_proc.c
@@ -90,35 +90,11 @@ static ssize_t snd_opl4_mem_proc_write(struct snd_info_entry *entry,
 	return count;
 }
 
-static loff_t snd_opl4_mem_proc_llseek(struct snd_info_entry *entry,
-				       void *file_private_data,
-				       struct file *file,
-				       loff_t offset, int orig)
-{
-	switch (orig) {
-	case SEEK_SET:
-		file->f_pos = offset;
-		break;
-	case SEEK_CUR:
-		file->f_pos += offset;
-		break;
-	case SEEK_END: /* offset is negative */
-		file->f_pos = entry->size + offset;
-		break;
-	default:
-		return -EINVAL;
-	}
-	if (file->f_pos > entry->size)
-		file->f_pos = entry->size;
-	return file->f_pos;
-}
-
 static struct snd_info_entry_ops snd_opl4_mem_proc_ops = {
 	.open = snd_opl4_mem_proc_open,
 	.release = snd_opl4_mem_proc_release,
 	.read = snd_opl4_mem_proc_read,
 	.write = snd_opl4_mem_proc_write,
-	.llseek = snd_opl4_mem_proc_llseek,
 };
 
 int snd_opl4_create_proc(struct snd_opl4 *opl4)
diff --git a/sound/isa/gus/gus_mem_proc.c b/sound/isa/gus/gus_mem_proc.c
index faa2bec..2ccb3fa 100644
--- a/sound/isa/gus/gus_mem_proc.c
+++ b/sound/isa/gus/gus_mem_proc.c
@@ -46,31 +46,6 @@ static ssize_t snd_gf1_mem_proc_dump(struct snd_info_entry *entry,
 	return count;
 }			
 
-static loff_t snd_gf1_mem_proc_llseek(struct snd_info_entry *entry,
-				      void *private_file_data,
-				      struct file *file,
-				      loff_t offset, int orig)
-{
-	struct gus_proc_private *priv = entry->private_data;
-
-	switch (orig) {
-	case SEEK_SET:
-		file->f_pos = offset;
-		break;
-	case SEEK_CUR:
-		file->f_pos += offset;
-		break;
-	case SEEK_END: /* offset is negative */
-		file->f_pos = priv->size + offset;
-		break;
-	default:
-		return -EINVAL;
-	}
-	if (file->f_pos > priv->size)
-		file->f_pos = priv->size;
-	return file->f_pos;
-}
-
 static void snd_gf1_mem_proc_free(struct snd_info_entry *entry)
 {
 	struct gus_proc_private *priv = entry->private_data;
@@ -79,7 +54,6 @@ static void snd_gf1_mem_proc_free(struct snd_info_entry *entry)
 
 static struct snd_info_entry_ops snd_gf1_mem_proc_ops = {
 	.read = snd_gf1_mem_proc_dump,
-	.llseek = snd_gf1_mem_proc_llseek,
 };
 
 int snd_gf1_mem_proc_init(struct snd_gus_card * gus)
diff --git a/sound/pci/mixart/mixart.c b/sound/pci/mixart/mixart.c
index be95e00..6c3fd4d 100644
--- a/sound/pci/mixart/mixart.c
+++ b/sound/pci/mixart/mixart.c
@@ -1102,55 +1102,6 @@ static int snd_mixart_free(struct mixart_mgr *mgr)
 /*
  * proc interface
  */
-static loff_t snd_mixart_BA0_llseek(struct snd_info_entry *entry,
-				    void *private_file_data,
-				    struct file *file,
-				    loff_t offset, int orig)
-{
-	offset = offset & ~3; /* 4 bytes aligned */
-
-	switch(orig) {
-	case SEEK_SET:
-		file->f_pos = offset;
-		break;
-	case SEEK_CUR:
-		file->f_pos += offset;
-		break;
-	case SEEK_END: /* offset is negative */
-		file->f_pos = MIXART_BA0_SIZE + offset;
-		break;
-	default:
-		return -EINVAL;
-	}
-	if(file->f_pos > MIXART_BA0_SIZE)
-		file->f_pos = MIXART_BA0_SIZE;
-	return file->f_pos;
-}
-
-static loff_t snd_mixart_BA1_llseek(struct snd_info_entry *entry,
-				    void *private_file_data,
-				    struct file *file,
-				    loff_t offset, int orig)
-{
-	offset = offset & ~3; /* 4 bytes aligned */
-
-	switch(orig) {
-	case SEEK_SET:
-		file->f_pos = offset;
-		break;
-	case SEEK_CUR:
-		file->f_pos += offset;
-		break;
-	case SEEK_END: /* offset is negative */
-		file->f_pos = MIXART_BA1_SIZE + offset;
-		break;
-	default:
-		return -EINVAL;
-	}
-	if(file->f_pos > MIXART_BA1_SIZE)
-		file->f_pos = MIXART_BA1_SIZE;
-	return file->f_pos;
-}
 
 /*
   mixart_BA0 proc interface for BAR 0 - read callback
@@ -1186,12 +1137,10 @@ static ssize_t snd_mixart_BA1_read(struct snd_info_entry *entry,
 
 static struct snd_info_entry_ops snd_mixart_proc_ops_BA0 = {
 	.read   = snd_mixart_BA0_read,
-	.llseek = snd_mixart_BA0_llseek
 };
 
 static struct snd_info_entry_ops snd_mixart_proc_ops_BA1 = {
 	.read   = snd_mixart_BA1_read,
-	.llseek = snd_mixart_BA1_llseek
 };
 
 
-- 
1.7.0.4
