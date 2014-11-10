From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/4] ALSA: vx: Fix missing kenreldoc parameter
	descriptions
Date: Mon, 10 Nov 2014 17:32:32 +0100
Message-ID: <1415637155-20918-2-git-send-email-tiwai@suse.de>
References: <1415637155-20918-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 3B977261B02
 for <alsa-devel@alsa-project.org>; Mon, 10 Nov 2014 17:32:40 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 13496ABE7
 for <alsa-devel@alsa-project.org>; Mon, 10 Nov 2014 16:32:40 +0000 (UTC)
In-Reply-To: <1415637155-20918-1-git-send-email-tiwai@suse.de>
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

The file isn't processed, but it's not bad to fix beforehand.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/drivers/vx/vx_core.c  | 10 ++++++++++
 sound/pci/vx222/vx222_ops.c |  5 +++++
 sound/pcmcia/vx/vxpocket.c  |  1 +
 3 files changed, 16 insertions(+)

diff --git a/sound/drivers/vx/vx_core.c b/sound/drivers/vx/vx_core.c
index e8cc16993903..fc05a37fd017 100644
--- a/sound/drivers/vx/vx_core.c
+++ b/sound/drivers/vx/vx_core.c
@@ -416,6 +416,7 @@ int vx_send_rih(struct vx_core *chip, int cmd)
 
 /**
  * snd_vx_boot_xilinx - boot up the xilinx interface
+ * @chip: VX core instance
  * @boot: the boot record to load
  */
 int snd_vx_load_boot_image(struct vx_core *chip, const struct firmware *boot)
@@ -538,6 +539,8 @@ EXPORT_SYMBOL(snd_vx_threaded_irq_handler);
 
 /**
  * snd_vx_irq_handler - interrupt handler
+ * @irq: irq number
+ * @dev: VX core instance
  */
 irqreturn_t snd_vx_irq_handler(int irq, void *dev)
 {
@@ -649,6 +652,8 @@ static void vx_proc_init(struct vx_core *chip)
 
 /**
  * snd_vx_dsp_boot - load the DSP boot
+ * @chip: VX core instance
+ * @boot: firmware data
  */
 int snd_vx_dsp_boot(struct vx_core *chip, const struct firmware *boot)
 {
@@ -669,6 +674,8 @@ EXPORT_SYMBOL(snd_vx_dsp_boot);
 
 /**
  * snd_vx_dsp_load - load the DSP image
+ * @chip: VX core instance
+ * @dsp: firmware data
  */
 int snd_vx_dsp_load(struct vx_core *chip, const struct firmware *dsp)
 {
@@ -768,7 +775,10 @@ EXPORT_SYMBOL(snd_vx_resume);
 
 /**
  * snd_vx_create - constructor for struct vx_core
+ * @card: card instance
  * @hw: hardware specific record
+ * @ops: VX ops pointer
+ * @extra_size: extra byte size to allocate appending to chip
  *
  * this function allocates the instance and prepare for the hardware
  * initialization.
diff --git a/sound/pci/vx222/vx222_ops.c b/sound/pci/vx222/vx222_ops.c
index 2d1570273e99..52c1a8d5b88a 100644
--- a/sound/pci/vx222/vx222_ops.c
+++ b/sound/pci/vx222/vx222_ops.c
@@ -92,6 +92,7 @@ static inline unsigned long vx2_reg_addr(struct vx_core *_chip, int reg)
 
 /**
  * snd_vx_inb - read a byte from the register
+ * @chip: VX core instance
  * @offset: register enum
  */
 static unsigned char vx2_inb(struct vx_core *chip, int offset)
@@ -101,6 +102,7 @@ static unsigned char vx2_inb(struct vx_core *chip, int offset)
 
 /**
  * snd_vx_outb - write a byte on the register
+ * @chip: VX core instance
  * @offset: the register offset
  * @val: the value to write
  */
@@ -114,6 +116,7 @@ static void vx2_outb(struct vx_core *chip, int offset, unsigned char val)
 
 /**
  * snd_vx_inl - read a 32bit word from the register
+ * @chip: VX core instance
  * @offset: register enum
  */
 static unsigned int vx2_inl(struct vx_core *chip, int offset)
@@ -123,6 +126,7 @@ static unsigned int vx2_inl(struct vx_core *chip, int offset)
 
 /**
  * snd_vx_outl - write a 32bit word on the register
+ * @chip: VX core instance
  * @offset: the register enum
  * @val: the value to write
  */
@@ -223,6 +227,7 @@ static int vx2_test_xilinx(struct vx_core *_chip)
 
 /**
  * vx_setup_pseudo_dma - set up the pseudo dma read/write mode.
+ * @chip: VX core instance
  * @do_write: 0 = read, 1 = set up for DMA write
  */
 static void vx2_setup_pseudo_dma(struct vx_core *chip, int do_write)
diff --git a/sound/pcmcia/vx/vxpocket.c b/sound/pcmcia/vx/vxpocket.c
index 92ec11456e3a..b16f42deed67 100644
--- a/sound/pcmcia/vx/vxpocket.c
+++ b/sound/pcmcia/vx/vxpocket.c
@@ -174,6 +174,7 @@ static int snd_vxpocket_new(struct snd_card *card, int ibl,
 
 /**
  * snd_vxpocket_assign_resources - initialize the hardware and card instance.
+ * @chip: VX core instance
  * @port: i/o port for the card
  * @irq: irq number for the card
  *
-- 
2.1.3
