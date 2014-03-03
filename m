From: Dylan Reid <dgreid@chromium.org>
Subject: [PATCH 3/3] ALSA: hda - Mark reg op args as iomem
Date: Sun,  2 Mar 2014 20:44:01 -0800
Message-ID: <1393821841-4133-3-git-send-email-dgreid@chromium.org>
References: <1393821841-4133-1-git-send-email-dgreid@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oa0-f74.google.com (mail-oa0-f74.google.com
 [209.85.219.74])
 by alsa0.perex.cz (Postfix) with ESMTP id EAE3426553C
 for <alsa-devel@alsa-project.org>; Mon,  3 Mar 2014 05:44:27 +0100 (CET)
Received: by mail-oa0-f74.google.com with SMTP id i7so222716oag.5
 for <alsa-devel@alsa-project.org>; Sun, 02 Mar 2014 20:44:27 -0800 (PST)
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

The ops to read and write registers should take pointers labeled as
__iomem.  Thanks to the sparse bot for catching this.

Signed-off-by: Dylan Reid <dgreid@chromium.org>
---
 sound/pci/hda/hda_intel.c | 12 ++++++------
 sound/pci/hda/hda_priv.h  | 12 ++++++------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 149c00b..77ca894 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -1431,32 +1431,32 @@ static void azx_firmware_cb(const struct firmware *fw, void *context)
  */
 
 /* PCI register access. */
-static void pci_azx_writel(u32 value, u32 *addr)
+static void pci_azx_writel(u32 value, u32 __iomem *addr)
 {
 	writel(value, addr);
 }
 
-static u32 pci_azx_readl(u32 *addr)
+static u32 pci_azx_readl(u32 __iomem *addr)
 {
 	return readl(addr);
 }
 
-static void pci_azx_writew(u16 value, u16 *addr)
+static void pci_azx_writew(u16 value, u16 __iomem *addr)
 {
 	writew(value, addr);
 }
 
-static u16 pci_azx_readw(u16 *addr)
+static u16 pci_azx_readw(u16 __iomem *addr)
 {
 	return readw(addr);
 }
 
-static void pci_azx_writeb(u8 value, u8 *addr)
+static void pci_azx_writeb(u8 value, u8 __iomem *addr)
 {
 	writeb(value, addr);
 }
 
-static u8 pci_azx_readb(u8 *addr)
+static u8 pci_azx_readb(u8 __iomem *addr)
 {
 	return readb(addr);
 }
diff --git a/sound/pci/hda/hda_priv.h b/sound/pci/hda/hda_priv.h
index 198fa82..ba38b81 100644
--- a/sound/pci/hda/hda_priv.h
+++ b/sound/pci/hda/hda_priv.h
@@ -290,12 +290,12 @@ struct azx;
 /* Functions to read/write to hda registers. */
 struct hda_controller_ops {
 	/* Register Access */
-	void (*reg_writel)(u32 value, u32 *addr);
-	u32 (*reg_readl)(u32 *addr);
-	void (*reg_writew)(u16 value, u16 *addr);
-	u16 (*reg_readw)(u16 *addr);
-	void (*reg_writeb)(u8 value, u8 *addr);
-	u8 (*reg_readb)(u8 *addr);
+	void (*reg_writel)(u32 value, u32 __iomem *addr);
+	u32 (*reg_readl)(u32 __iomem *addr);
+	void (*reg_writew)(u16 value, u16 __iomem *addr);
+	u16 (*reg_readw)(u16 __iomem *addr);
+	void (*reg_writeb)(u8 value, u8 __iomem *addr);
+	u8 (*reg_readb)(u8 __iomem *addr);
 	/* Disable msi if supported, PCI only */
 	int (*disable_msi_reset_irq)(struct azx *);
 	/* Allocation ops */
-- 
1.8.1.3.605.g02339dd
