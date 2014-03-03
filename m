From: Dylan Reid <dgreid@chromium.org>
Subject: [PATCH 2/3] ALSA: hda - Rename reg access ops in
	hda_controller_ops
Date: Sun,  2 Mar 2014 20:44:00 -0800
Message-ID: <1393821841-4133-2-git-send-email-dgreid@chromium.org>
References: <1393821841-4133-1-git-send-email-dgreid@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f202.google.com (mail-pd0-f202.google.com
 [209.85.192.202])
 by alsa0.perex.cz (Postfix) with ESMTP id 6A034265536
 for <alsa-devel@alsa-project.org>; Mon,  3 Mar 2014 05:44:25 +0100 (CET)
Received: by mail-pd0-f202.google.com with SMTP id fp1so401532pdb.3
 for <alsa-devel@alsa-project.org>; Sun, 02 Mar 2014 20:44:24 -0800 (PST)
In-Reply-To: <1393821841-4133-1-git-send-email-dgreid@chromium.org>
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
Cc: tiwai@suse.de, Dylan Reid <dgreid@chromium.org>
List-Id: alsa-devel@alsa-project.org

Using readl, writel, etc. resulted in some architectures, such as
s390, expanding the member names into zpci_writel.  Obviously not the
intended result.

Fixes s390 build breakage introduced by "4083081 - ALSA: hda - Allow
different ops to read/write registers"

Signed-off-by: Dylan Reid <dgreid@chromium.org>
---
 sound/pci/hda/hda_intel.c | 12 ++++++------
 sound/pci/hda/hda_priv.h  | 36 ++++++++++++++++++------------------
 2 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index b26eff3..149c00b 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -1537,12 +1537,12 @@ static void pcm_mmap_prepare(struct snd_pcm_substream *substream,
 }
 
 static const struct hda_controller_ops pci_hda_ops = {
-	.writel = pci_azx_writel,
-	.readl = pci_azx_readl,
-	.writew = pci_azx_writew,
-	.readw = pci_azx_readw,
-	.writeb = pci_azx_writeb,
-	.readb = pci_azx_readb,
+	.reg_writel = pci_azx_writel,
+	.reg_readl = pci_azx_readl,
+	.reg_writew = pci_azx_writew,
+	.reg_readw = pci_azx_readw,
+	.reg_writeb = pci_azx_writeb,
+	.reg_readb = pci_azx_readb,
 	.disable_msi_reset_irq = disable_msi_reset_irq,
 	.dma_alloc_pages = dma_alloc_pages,
 	.dma_free_pages = dma_free_pages,
diff --git a/sound/pci/hda/hda_priv.h b/sound/pci/hda/hda_priv.h
index bf3cb33..198fa82 100644
--- a/sound/pci/hda/hda_priv.h
+++ b/sound/pci/hda/hda_priv.h
@@ -290,12 +290,12 @@ struct azx;
 /* Functions to read/write to hda registers. */
 struct hda_controller_ops {
 	/* Register Access */
-	void (*writel)(u32 value, u32 *addr);
-	u32 (*readl)(u32 *addr);
-	void (*writew)(u16 value, u16 *addr);
-	u16 (*readw)(u16 *addr);
-	void (*writeb)(u8 value, u8 *addr);
-	u8 (*readb)(u8 *addr);
+	void (*reg_writel)(u32 value, u32 *addr);
+	u32 (*reg_readl)(u32 *addr);
+	void (*reg_writew)(u16 value, u16 *addr);
+	u16 (*reg_readw)(u16 *addr);
+	void (*reg_writeb)(u8 value, u8 *addr);
+	u8 (*reg_readb)(u8 *addr);
 	/* Disable msi if supported, PCI only */
 	int (*disable_msi_reset_irq)(struct azx *);
 	/* Allocation ops */
@@ -435,29 +435,29 @@ struct azx {
  */
 
 #define azx_writel(chip, reg, value) \
-	((chip)->ops->writel(value, (chip)->remap_addr + ICH6_REG_##reg))
+	((chip)->ops->reg_writel(value, (chip)->remap_addr + ICH6_REG_##reg))
 #define azx_readl(chip, reg) \
-	((chip)->ops->readl((chip)->remap_addr + ICH6_REG_##reg))
+	((chip)->ops->reg_readl((chip)->remap_addr + ICH6_REG_##reg))
 #define azx_writew(chip, reg, value) \
-	((chip)->ops->writew(value, (chip)->remap_addr + ICH6_REG_##reg))
+	((chip)->ops->reg_writew(value, (chip)->remap_addr + ICH6_REG_##reg))
 #define azx_readw(chip, reg) \
-	((chip)->ops->readw((chip)->remap_addr + ICH6_REG_##reg))
+	((chip)->ops->reg_readw((chip)->remap_addr + ICH6_REG_##reg))
 #define azx_writeb(chip, reg, value) \
-	((chip)->ops->writeb(value, (chip)->remap_addr + ICH6_REG_##reg))
+	((chip)->ops->reg_writeb(value, (chip)->remap_addr + ICH6_REG_##reg))
 #define azx_readb(chip, reg) \
-	((chip)->ops->readb((chip)->remap_addr + ICH6_REG_##reg))
+	((chip)->ops->reg_readb((chip)->remap_addr + ICH6_REG_##reg))
 
 #define azx_sd_writel(chip, dev, reg, value) \
-	((chip)->ops->writel(value, (dev)->sd_addr + ICH6_REG_##reg))
+	((chip)->ops->reg_writel(value, (dev)->sd_addr + ICH6_REG_##reg))
 #define azx_sd_readl(chip, dev, reg) \
-	((chip)->ops->readl((dev)->sd_addr + ICH6_REG_##reg))
+	((chip)->ops->reg_readl((dev)->sd_addr + ICH6_REG_##reg))
 #define azx_sd_writew(chip, dev, reg, value) \
-	((chip)->ops->writew(value, (dev)->sd_addr + ICH6_REG_##reg))
+	((chip)->ops->reg_writew(value, (dev)->sd_addr + ICH6_REG_##reg))
 #define azx_sd_readw(chip, dev, reg) \
-	((chip)->ops->readw((dev)->sd_addr + ICH6_REG_##reg))
+	((chip)->ops->reg_readw((dev)->sd_addr + ICH6_REG_##reg))
 #define azx_sd_writeb(chip, dev, reg, value) \
-	((chip)->ops->writeb(value, (dev)->sd_addr + ICH6_REG_##reg))
+	((chip)->ops->reg_writeb(value, (dev)->sd_addr + ICH6_REG_##reg))
 #define azx_sd_readb(chip, dev, reg) \
-	((chip)->ops->readb((dev)->sd_addr + ICH6_REG_##reg))
+	((chip)->ops->reg_readb((dev)->sd_addr + ICH6_REG_##reg))
 
 #endif /* __SOUND_HDA_PRIV_H */
-- 
1.8.1.3.605.g02339dd
