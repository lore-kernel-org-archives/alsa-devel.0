From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/5] ALSA: pcm - define
	snd_pcm_default_page_ops()
Date: Thu, 26 Nov 2009 16:13:05 +0100
Message-ID: <1259248388-20095-3-git-send-email-tiwai@suse.de>
References: <1259248388-20095-1-git-send-email-tiwai@suse.de>
	<1259248388-20095-2-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (cantor.suse.de [195.135.220.2])
	by alsa0.perex.cz (Postfix) with ESMTP id 3C137103884
	for <alsa-devel@alsa-project.org>; Thu, 26 Nov 2009 16:13:44 +0100 (CET)
In-Reply-To: <1259248388-20095-2-git-send-email-tiwai@suse.de>
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
Cc: linux-mips@linux-mips.org, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Becky Bruce <beckyb@kernel.crashing.org>, Wu Zhangjin <wuzhangjin@gmail.com>, Takashi Iwai <tiwai@suse.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Ralf Baechle <ralf@linux-mips.org>, Kumar Gala <galak@gate.crashing.org>
List-Id: alsa-devel@alsa-project.org

Add a helper (inline) function as the default page ops.  Any hacks wrt
the page address conversion will be applied in this function.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/pcm_native.c |   20 ++++++++++++--------
 1 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index f067c5b..c906be2 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -3062,6 +3062,13 @@ static int snd_pcm_mmap_control(struct snd_pcm_substream *substream, struct file
 }
 #endif /* coherent mmap */
 
+static inline struct page *
+snd_pcm_default_page_ops(struct snd_pcm_substream *substream, unsigned long ofs)
+{
+	void *vaddr = substream->runtime->dma_area + ofs;
+	return virt_to_page(vaddr);
+}
+
 /*
  * fault callback for mmapping a RAM page
  */
@@ -3072,7 +3079,6 @@ static int snd_pcm_mmap_data_fault(struct vm_area_struct *area,
 	struct snd_pcm_runtime *runtime;
 	unsigned long offset;
 	struct page * page;
-	void *vaddr;
 	size_t dma_bytes;
 	
 	if (substream == NULL)
@@ -3082,14 +3088,12 @@ static int snd_pcm_mmap_data_fault(struct vm_area_struct *area,
 	dma_bytes = PAGE_ALIGN(runtime->dma_bytes);
 	if (offset > dma_bytes - PAGE_SIZE)
 		return VM_FAULT_SIGBUS;
-	if (substream->ops->page) {
+	if (substream->ops->page)
 		page = substream->ops->page(substream, offset);
-		if (!page)
-			return VM_FAULT_SIGBUS;
-	} else {
-		vaddr = runtime->dma_area + offset;
-		page = virt_to_page(vaddr);
-	}
+	else
+		page = snd_pcm_default_page_ops(substream, offset);
+	if (!page)
+		return VM_FAULT_SIGBUS;
 	get_page(page);
 	vmf->page = page;
 	return 0;
-- 
1.6.5.3
