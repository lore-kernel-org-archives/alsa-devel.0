From: Dylan Reid <dgreid@chromium.org>
Subject: [RFCv2 10/22] ALSA: hda - Add pcm_mmap_prepare op.
Date: Fri, 28 Feb 2014 15:41:21 -0800
Message-ID: <1393630893-29010-11-git-send-email-dgreid@chromium.org>
References: <1393630893-29010-1-git-send-email-dgreid@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qa0-f73.google.com (mail-qa0-f73.google.com
 [209.85.216.73])
 by alsa0.perex.cz (Postfix) with ESMTP id 9AD2B2659B4
 for <alsa-devel@alsa-project.org>; Sat,  1 Mar 2014 00:42:52 +0100 (CET)
Received: by mail-qa0-f73.google.com with SMTP id f11so228198qae.2
 for <alsa-devel@alsa-project.org>; Fri, 28 Feb 2014 15:42:51 -0800 (PST)
In-Reply-To: <1393630893-29010-1-git-send-email-dgreid@chromium.org>
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
Cc: tiwai@suse.de, Dylan Reid <dgreid@chromium.org>, swarren@wwwdotorg.org
List-Id: alsa-devel@alsa-project.org

Adding this op allows the X86 specific mmap operation to help in
hda_intel without needing a CONFIG_X86 in future non-PCI hda drivers.

Signed-off-by: Dylan Reid <dgreid@chromium.org>
---
 sound/pci/hda/hda_intel.c | 20 ++++++++++++++------
 sound/pci/hda/hda_priv.h  |  2 ++
 2 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index fa3a04c..aa8b765 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -2190,19 +2190,15 @@ static void azx_clear_irq_pending(struct azx *chip)
 	spin_unlock_irq(&chip->reg_lock);
 }
 
-#ifdef CONFIG_X86
 static int azx_pcm_mmap(struct snd_pcm_substream *substream,
 			struct vm_area_struct *area)
 {
 	struct azx_pcm *apcm = snd_pcm_substream_chip(substream);
 	struct azx *chip = apcm->chip;
-	if (!azx_snoop(chip))
-		area->vm_page_prot = pgprot_writecombine(area->vm_page_prot);
+	if (chip->ops->pcm_mmap_prepare)
+		chip->ops->pcm_mmap_prepare(substream, area);
 	return snd_pcm_lib_default_mmap(substream, area);
 }
-#else
-#define azx_pcm_mmap	NULL
-#endif
 
 static struct snd_pcm_ops azx_pcm_ops = {
 	.open = azx_pcm_open,
@@ -3508,6 +3504,17 @@ static int substream_free_pages(struct azx *chip,
 	return snd_pcm_lib_free_pages(substream);
 }
 
+static void pcm_mmap_prepare(struct snd_pcm_substream *substream,
+			     struct vm_area_struct *area)
+{
+#ifdef CONFIG_X86
+	struct azx_pcm *apcm = snd_pcm_substream_chip(substream);
+	struct azx *chip = apcm->chip;
+	if (!azx_snoop(chip))
+		area->vm_page_prot = pgprot_writecombine(area->vm_page_prot);
+#endif
+}
+
 static const struct hda_controller_ops pci_hda_ops = {
 	.writel = pci_azx_writel,
 	.readl = pci_azx_readl,
@@ -3520,6 +3527,7 @@ static const struct hda_controller_ops pci_hda_ops = {
 	.dma_free_pages = dma_free_pages,
 	.substream_alloc_pages = substream_alloc_pages,
 	.substream_free_pages = substream_free_pages,
+	.pcm_mmap_prepare = pcm_mmap_prepare,
 };
 
 static int azx_probe(struct pci_dev *pci,
diff --git a/sound/pci/hda/hda_priv.h b/sound/pci/hda/hda_priv.h
index 10bcec1..edbe2eb 100644
--- a/sound/pci/hda/hda_priv.h
+++ b/sound/pci/hda/hda_priv.h
@@ -309,6 +309,8 @@ struct hda_controller_ops {
 				     size_t size);
 	int (*substream_free_pages)(struct azx *chip,
 				    struct snd_pcm_substream *substream);
+	void (*pcm_mmap_prepare)(struct snd_pcm_substream *substream,
+				 struct vm_area_struct *area);
 };
 
 struct azx_pcm {
-- 
1.8.1.3.605.g02339dd
