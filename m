From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 05/14] ALSA: mixart: Proper endian notations
Date: Wed, 25 Jul 2018 23:24:05 +0200
Message-ID: <20180725212414.19795-6-tiwai@suse.de>
References: <20180725212414.19795-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 90DC9267795
 for <alsa-devel@alsa-project.org>; Wed, 25 Jul 2018 23:24:17 +0200 (CEST)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 47343ADE2
 for <alsa-devel@alsa-project.org>; Wed, 25 Jul 2018 21:24:16 +0000 (UTC)
In-Reply-To: <20180725212414.19795-1-tiwai@suse.de>
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

The miXart driver deals with big-endian values as raw data, while it
declares most of variables as u32.  This leads to sparse warnings like
  sound/pci/mixart/mixart.c:1203:23: warning: cast to restricted __be32

Fix them by properly defining the structs and add the explicit cast to
macros.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/mixart/mixart_core.c  |  4 ++--
 sound/pci/mixart/mixart_hwdep.c | 42 ++++++++++++++++-----------------
 sound/pci/mixart/mixart_hwdep.h |  8 +++----
 3 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/sound/pci/mixart/mixart_core.c b/sound/pci/mixart/mixart_core.c
index 8bf2ce32d4a8..46c292b52fd6 100644
--- a/sound/pci/mixart/mixart_core.c
+++ b/sound/pci/mixart/mixart_core.c
@@ -107,7 +107,7 @@ static int get_msg(struct mixart_mgr *mgr, struct mixart_msg *resp,
 #ifndef __BIG_ENDIAN
 	size /= 4; /* u32 size */
 	for(i=0; i < size; i++) {
-		((u32*)resp->data)[i] = be32_to_cpu(((u32*)resp->data)[i]);
+		((u32*)resp->data)[i] = be32_to_cpu(((__be32*)resp->data)[i]);
 	}
 #endif
 
@@ -519,7 +519,7 @@ irqreturn_t snd_mixart_threaded_irq(int irq, void *dev_id)
 					/* Traces are text: the swapped msg_data has to be swapped back ! */
 					int i;
 					for(i=0; i<(resp.size/4); i++) {
-						(mixart_msg_data)[i] = cpu_to_be32((mixart_msg_data)[i]);
+						((__be32*)mixart_msg_data)[i] = cpu_to_be32((mixart_msg_data)[i]);
 					}
 #endif
 					((char*)mixart_msg_data)[resp.size - 1] = 0;
diff --git a/sound/pci/mixart/mixart_hwdep.c b/sound/pci/mixart/mixart_hwdep.c
index 5bfd3ac80db5..bc92758de82c 100644
--- a/sound/pci/mixart/mixart_hwdep.c
+++ b/sound/pci/mixart/mixart_hwdep.c
@@ -73,30 +73,30 @@ static int mixart_wait_nice_for_register_value(struct mixart_mgr *mgr,
  */
 struct snd_mixart_elf32_ehdr {
 	u8      e_ident[16];
-	u16     e_type;
-	u16     e_machine;
-	u32     e_version;
-	u32     e_entry;
-	u32     e_phoff;
-	u32     e_shoff;
-	u32     e_flags;
-	u16     e_ehsize;
-	u16     e_phentsize;
-	u16     e_phnum;
-	u16     e_shentsize;
-	u16     e_shnum;
-	u16     e_shstrndx;
+	__be16  e_type;
+	__be16  e_machine;
+	__be32  e_version;
+	__be32  e_entry;
+	__be32  e_phoff;
+	__be32  e_shoff;
+	__be32  e_flags;
+	__be16  e_ehsize;
+	__be16  e_phentsize;
+	__be16  e_phnum;
+	__be16  e_shentsize;
+	__be16  e_shnum;
+	__be16  e_shstrndx;
 };
 
 struct snd_mixart_elf32_phdr {
-	u32     p_type;
-	u32     p_offset;
-	u32     p_vaddr;
-	u32     p_paddr;
-	u32     p_filesz;
-	u32     p_memsz;
-	u32     p_flags;
-	u32     p_align;
+	__be32  p_type;
+	__be32  p_offset;
+	__be32  p_vaddr;
+	__be32  p_paddr;
+	__be32  p_filesz;
+	__be32  p_memsz;
+	__be32  p_flags;
+	__be32  p_align;
 };
 
 static int mixart_load_elf(struct mixart_mgr *mgr, const struct firmware *dsp )
diff --git a/sound/pci/mixart/mixart_hwdep.h b/sound/pci/mixart/mixart_hwdep.h
index 812e288ef2e7..2794cd385b8e 100644
--- a/sound/pci/mixart/mixart_hwdep.h
+++ b/sound/pci/mixart/mixart_hwdep.h
@@ -26,19 +26,19 @@
 #include <sound/hwdep.h>
 
 #ifndef readl_be
-#define readl_be(x) be32_to_cpu(__raw_readl(x))
+#define readl_be(x) be32_to_cpu((__force __be32)__raw_readl(x))
 #endif
 
 #ifndef writel_be
-#define writel_be(data,addr) __raw_writel(cpu_to_be32(data),addr)
+#define writel_be(data,addr) __raw_writel((__force u32)cpu_to_be32(data),addr)
 #endif
 
 #ifndef readl_le
-#define readl_le(x) le32_to_cpu(__raw_readl(x))
+#define readl_le(x) le32_to_cpu((__force __le32)__raw_readl(x))
 #endif
 
 #ifndef writel_le
-#define writel_le(data,addr) __raw_writel(cpu_to_le32(data),addr)
+#define writel_le(data,addr) __raw_writel((__force u32)cpu_to_le32(data),addr)
 #endif
 
 #define MIXART_MEM(mgr,x)	((mgr)->mem[0].virt + (x))
-- 
2.18.0
