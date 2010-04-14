From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/5] ALSA: info - Use standard types for info
	callbacks
Date: Wed, 14 Apr 2010 10:17:59 +0200
Message-ID: <1271233083-16310-2-git-send-email-tiwai@suse.de>
References: <1271233083-16310-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by alsa0.perex.cz (Postfix) with ESMTP id 86B712447F
	for <alsa-devel@alsa-project.org>;
	Wed, 14 Apr 2010 10:18:41 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.221.2])
	by mx2.suse.de (Postfix) with ESMTP id 6E0BE86A2E
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

Use loff_t, size_t and ssize_t for arguments of info callbacks
to follow the standard procfs.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/sound/info.h           |   24 ++++++++++++------------
 sound/drivers/opl4/opl4_proc.c |   21 +++++++++++++--------
 sound/isa/gus/gus_mem_proc.c   |   16 ++++++++--------
 sound/pci/cs4281.c             |   16 ++++++++--------
 sound/pci/cs46xx/cs46xx_lib.c  |    7 ++++---
 sound/pci/emu10k1/emuproc.c    |    8 ++++----
 sound/pci/mixart/mixart.c      |   32 ++++++++++++++++----------------
 7 files changed, 65 insertions(+), 59 deletions(-)

diff --git a/include/sound/info.h b/include/sound/info.h
index 112e894..4e94cf1 100644
--- a/include/sound/info.h
+++ b/include/sound/info.h
@@ -51,18 +51,18 @@ struct snd_info_entry_ops {
 		    unsigned short mode, void **file_private_data);
 	int (*release)(struct snd_info_entry *entry,
 		       unsigned short mode, void *file_private_data);
-	long (*read)(struct snd_info_entry *entry, void *file_private_data,
-		     struct file *file, char __user *buf,
-		     unsigned long count, unsigned long pos);
-	long (*write)(struct snd_info_entry *entry, void *file_private_data,
-		      struct file *file, const char __user *buf,
-		      unsigned long count, unsigned long pos);
-	long long (*llseek)(struct snd_info_entry *entry,
-			    void *file_private_data, struct file *file,
-			    long long offset, int orig);
-	unsigned int(*poll)(struct snd_info_entry *entry,
-			    void *file_private_data, struct file *file,
-			    poll_table *wait);
+	ssize_t (*read)(struct snd_info_entry *entry, void *file_private_data,
+			struct file *file, char __user *buf,
+			size_t count, loff_t pos);
+	ssize_t (*write)(struct snd_info_entry *entry, void *file_private_data,
+			 struct file *file, const char __user *buf,
+			 size_t count, loff_t pos);
+	loff_t (*llseek)(struct snd_info_entry *entry,
+			 void *file_private_data, struct file *file,
+			 loff_t offset, int orig);
+	unsigned int (*poll)(struct snd_info_entry *entry,
+			     void *file_private_data, struct file *file,
+			     poll_table *wait);
 	int (*ioctl)(struct snd_info_entry *entry, void *file_private_data,
 		     struct file *file, unsigned int cmd, unsigned long arg);
 	int (*mmap)(struct snd_info_entry *entry, void *file_private_data,
diff --git a/sound/drivers/opl4/opl4_proc.c b/sound/drivers/opl4/opl4_proc.c
index 1679300..eb72814 100644
--- a/sound/drivers/opl4/opl4_proc.c
+++ b/sound/drivers/opl4/opl4_proc.c
@@ -49,9 +49,10 @@ static int snd_opl4_mem_proc_release(struct snd_info_entry *entry,
 	return 0;
 }
 
-static long snd_opl4_mem_proc_read(struct snd_info_entry *entry, void *file_private_data,
-				   struct file *file, char __user *_buf,
-				   unsigned long count, unsigned long pos)
+static ssize_t snd_opl4_mem_proc_read(struct snd_info_entry *entry,
+				      void *file_private_data,
+				      struct file *file, char __user *_buf,
+				      size_t count, loff_t pos)
 {
 	struct snd_opl4 *opl4 = entry->private_data;
 	long size;
@@ -75,9 +76,11 @@ static long snd_opl4_mem_proc_read(struct snd_info_entry *entry, void *file_priv
 	return 0;
 }
 
-static long snd_opl4_mem_proc_write(struct snd_info_entry *entry, void *file_private_data,
-				    struct file *file, const char __user *_buf,
-				    unsigned long count, unsigned long pos)
+static ssize_t snd_opl4_mem_proc_write(struct snd_info_entry *entry,
+				       void *file_private_data,
+				       struct file *file,
+				       const char __user *_buf,
+				       size_t count, size_t pos)
 {
 	struct snd_opl4 *opl4 = entry->private_data;
 	long size;
@@ -101,8 +104,10 @@ static long snd_opl4_mem_proc_write(struct snd_info_entry *entry, void *file_pri
 	return 0;
 }
 
-static long long snd_opl4_mem_proc_llseek(struct snd_info_entry *entry, void *file_private_data,
-					  struct file *file, long long offset, int orig)
+static loff_t snd_opl4_mem_proc_llseek(struct snd_info_entry *entry,
+				       void *file_private_data,
+				       struct file *file,
+				       loff_t offset, int orig)
 {
 	switch (orig) {
 	case SEEK_SET:
diff --git a/sound/isa/gus/gus_mem_proc.c b/sound/isa/gus/gus_mem_proc.c
index 2803e22..b2d2dba 100644
--- a/sound/isa/gus/gus_mem_proc.c
+++ b/sound/isa/gus/gus_mem_proc.c
@@ -31,9 +31,10 @@ struct gus_proc_private {
 	struct snd_gus_card * gus;
 };
 
-static long snd_gf1_mem_proc_dump(struct snd_info_entry *entry, void *file_private_data,
-			          struct file *file, char __user *buf,
-			          unsigned long count, unsigned long pos)
+static ssize_t snd_gf1_mem_proc_dump(struct snd_info_entry *entry,
+				     void *file_private_data,
+				     struct file *file, char __user *buf,
+				     size_t count, loff_t pos)
 {
 	long size;
 	struct gus_proc_private *priv = entry->private_data;
@@ -51,11 +52,10 @@ static long snd_gf1_mem_proc_dump(struct snd_info_entry *entry, void *file_priva
 	return 0;
 }			
 
-static long long snd_gf1_mem_proc_llseek(struct snd_info_entry *entry,
-					void *private_file_data,
-					struct file *file,
-					long long offset,
-					int orig)
+static loff_t snd_gf1_mem_proc_llseek(struct snd_info_entry *entry,
+				      void *private_file_data,
+				      struct file *file,
+				      loff_t offset, int orig)
 {
 	struct gus_proc_private *priv = entry->private_data;
 
diff --git a/sound/pci/cs4281.c b/sound/pci/cs4281.c
index 9edc650..b0bba2e 100644
--- a/sound/pci/cs4281.c
+++ b/sound/pci/cs4281.c
@@ -1139,10 +1139,10 @@ static void snd_cs4281_proc_read(struct snd_info_entry *entry,
 	snd_iprintf(buffer, "Spurious end IRQs    : %u\n", chip->spurious_dtc_irq);
 }
 
-static long snd_cs4281_BA0_read(struct snd_info_entry *entry,
-				void *file_private_data,
-				struct file *file, char __user *buf,
-				unsigned long count, unsigned long pos)
+static ssize_t snd_cs4281_BA0_read(struct snd_info_entry *entry,
+				   void *file_private_data,
+				   struct file *file, char __user *buf,
+				   size_t count, loff_t pos)
 {
 	long size;
 	struct cs4281 *chip = entry->private_data;
@@ -1157,10 +1157,10 @@ static long snd_cs4281_BA0_read(struct snd_info_entry *entry,
 	return size;
 }
 
-static long snd_cs4281_BA1_read(struct snd_info_entry *entry,
-				void *file_private_data,
-				struct file *file, char __user *buf,
-				unsigned long count, unsigned long pos)
+static ssize_t snd_cs4281_BA1_read(struct snd_info_entry *entry,
+				   void *file_private_data,
+				   struct file *file, char __user *buf,
+				   size_t count, loff_t pos)
 {
 	long size;
 	struct cs4281 *chip = entry->private_data;
diff --git a/sound/pci/cs46xx/cs46xx_lib.c b/sound/pci/cs46xx/cs46xx_lib.c
index 3f99a5e..08117b1 100644
--- a/sound/pci/cs46xx/cs46xx_lib.c
+++ b/sound/pci/cs46xx/cs46xx_lib.c
@@ -2657,9 +2657,10 @@ static inline void snd_cs46xx_remove_gameport(struct snd_cs46xx *chip) { }
  *  proc interface
  */
 
-static long snd_cs46xx_io_read(struct snd_info_entry *entry, void *file_private_data,
-			       struct file *file, char __user *buf,
-			       unsigned long count, unsigned long pos)
+static ssize_t snd_cs46xx_io_read(struct snd_info_entry *entry,
+				  void *file_private_data,
+				  struct file *file, char __user *buf,
+				  size_t count, loff_t pos)
 {
 	long size;
 	struct snd_cs46xx_region *region = entry->private_data;
diff --git a/sound/pci/emu10k1/emuproc.c b/sound/pci/emu10k1/emuproc.c
index baa7cd5..347b241 100644
--- a/sound/pci/emu10k1/emuproc.c
+++ b/sound/pci/emu10k1/emuproc.c
@@ -341,10 +341,10 @@ static void snd_emu10k1_proc_acode_read(struct snd_info_entry *entry,
 #define TOTAL_SIZE_CODE		(0x200*8)
 #define A_TOTAL_SIZE_CODE	(0x400*8)
 
-static long snd_emu10k1_fx8010_read(struct snd_info_entry *entry,
-				    void *file_private_data,
-				    struct file *file, char __user *buf,
-				    unsigned long count, unsigned long pos)
+static ssize_t snd_emu10k1_fx8010_read(struct snd_info_entry *entry,
+				       void *file_private_data,
+				       struct file *file, char __user *buf,
+				       size_t count, loff_t pos)
 {
 	long size;
 	struct snd_emu10k1 *emu = entry->private_data;
diff --git a/sound/pci/mixart/mixart.c b/sound/pci/mixart/mixart.c
index 3be8f97..b5df78b 100644
--- a/sound/pci/mixart/mixart.c
+++ b/sound/pci/mixart/mixart.c
@@ -1102,11 +1102,10 @@ static int snd_mixart_free(struct mixart_mgr *mgr)
 /*
  * proc interface
  */
-static long long snd_mixart_BA0_llseek(struct snd_info_entry *entry,
-				       void *private_file_data,
-				       struct file *file,
-				       long long offset,
-				       int orig)
+static loff_t snd_mixart_BA0_llseek(struct snd_info_entry *entry,
+				    void *private_file_data,
+				    struct file *file,
+				    loff_t offset, int orig)
 {
 	offset = offset & ~3; /* 4 bytes aligned */
 
@@ -1128,11 +1127,10 @@ static long long snd_mixart_BA0_llseek(struct snd_info_entry *entry,
 	return file->f_pos;
 }
 
-static long long snd_mixart_BA1_llseek(struct snd_info_entry *entry,
-				       void *private_file_data,
-				       struct file *file,
-				       long long offset,
-				       int orig)
+static loff_t snd_mixart_BA1_llseek(struct snd_info_entry *entry,
+				    void *private_file_data,
+				    struct file *file,
+				    loff_t offset, int orig)
 {
 	offset = offset & ~3; /* 4 bytes aligned */
 
@@ -1157,9 +1155,10 @@ static long long snd_mixart_BA1_llseek(struct snd_info_entry *entry,
 /*
   mixart_BA0 proc interface for BAR 0 - read callback
  */
-static long snd_mixart_BA0_read(struct snd_info_entry *entry, void *file_private_data,
-				struct file *file, char __user *buf,
-				unsigned long count, unsigned long pos)
+static ssize_t snd_mixart_BA0_read(struct snd_info_entry *entry,
+				   void *file_private_data,
+				   struct file *file, char __user *buf,
+				   size_t count, loff_t pos)
 {
 	struct mixart_mgr *mgr = entry->private_data;
 	unsigned long maxsize;
@@ -1178,9 +1177,10 @@ static long snd_mixart_BA0_read(struct snd_info_entry *entry, void *file_private
 /*
   mixart_BA1 proc interface for BAR 1 - read callback
  */
-static long snd_mixart_BA1_read(struct snd_info_entry *entry, void *file_private_data,
-				struct file *file, char __user *buf,
-				unsigned long count, unsigned long pos)
+static ssize_t snd_mixart_BA1_read(struct snd_info_entry *entry,
+				   void *file_private_data,
+				   struct file *file, char __user *buf,
+				   size_t count, loff_t pos)
 {
 	struct mixart_mgr *mgr = entry->private_data;
 	unsigned long maxsize;
-- 
1.7.0.4
