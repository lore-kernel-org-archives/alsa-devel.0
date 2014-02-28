From: Dylan Reid <dgreid@chromium.org>
Subject: [RFC 09/19] ALSA: hda - Relocate RIRB/CORB interface
	to hda_shared
Date: Thu, 27 Feb 2014 22:35:52 -0800
Message-ID: <1393569362-27285-10-git-send-email-dgreid@chromium.org>
References: <1393569362-27285-1-git-send-email-dgreid@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f201.google.com (mail-pd0-f201.google.com
 [209.85.192.201])
 by alsa0.perex.cz (Postfix) with ESMTP id 1D8F92650D3
 for <alsa-devel@alsa-project.org>; Fri, 28 Feb 2014 07:37:13 +0100 (CET)
Received: by mail-pd0-f201.google.com with SMTP id x10so34306pdj.2
 for <alsa-devel@alsa-project.org>; Thu, 27 Feb 2014 22:37:12 -0800 (PST)
In-Reply-To: <1393569362-27285-1-git-send-email-dgreid@chromium.org>
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

This is done to allow an HDA platform driver to reuse the code.  It
also eliminates the last user of the makr_*_wc funcitons so they can
be private to hda_shared.

A few of the interfaces added to hda_shared will disappear in
following commits as their users are also moved to hda_shared.

Signed-off-by: Dylan Reid <dgreid@chromium.org>
---
 sound/pci/hda/hda_intel.c  | 364 --------------------------------------------
 sound/pci/hda/hda_shared.c | 367 ++++++++++++++++++++++++++++++++++++++++++++-
 sound/pci/hda/hda_shared.h |  21 +--
 3 files changed, 376 insertions(+), 376 deletions(-)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index eaf8c78..2b00e88 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -315,370 +315,6 @@ static const struct azx_reg_ops pci_reg_ops = {
 };
 
 static int azx_acquire_irq(struct azx *chip, int do_disconnect);
-static int azx_send_cmd(struct hda_bus *bus, unsigned int val);
-/*
- * Interface for HD codec
- */
-
-/*
- * CORB / RIRB interface
- */
-static int azx_alloc_cmd_io(struct azx *chip)
-{
-	int err;
-
-	/* single page (at least 4096 bytes) must suffice for both ringbuffes */
-	err = snd_dma_alloc_pages(SNDRV_DMA_TYPE_DEV,
-				  chip->card->dev,
-				  PAGE_SIZE, &chip->rb);
-	if (err < 0) {
-		dev_err(chip->card->dev, "cannot allocate CORB/RIRB\n");
-		return err;
-	}
-	mark_pages_wc(chip, &chip->rb, true);
-	return 0;
-}
-
-static void azx_init_cmd_io(struct azx *chip)
-{
-	spin_lock_irq(&chip->reg_lock);
-	/* CORB set up */
-	chip->corb.addr = chip->rb.addr;
-	chip->corb.buf = (u32 *)chip->rb.area;
-	azx_writel(chip, CORBLBASE, (u32)chip->corb.addr);
-	azx_writel(chip, CORBUBASE, upper_32_bits(chip->corb.addr));
-
-	/* set the corb size to 256 entries (ULI requires explicitly) */
-	azx_writeb(chip, CORBSIZE, 0x02);
-	/* set the corb write pointer to 0 */
-	azx_writew(chip, CORBWP, 0);
-	/* reset the corb hw read pointer */
-	azx_writew(chip, CORBRP, ICH6_CORBRP_RST);
-	/* enable corb dma */
-	azx_writeb(chip, CORBCTL, ICH6_CORBCTL_RUN);
-
-	/* RIRB set up */
-	chip->rirb.addr = chip->rb.addr + 2048;
-	chip->rirb.buf = (u32 *)(chip->rb.area + 2048);
-	chip->rirb.wp = chip->rirb.rp = 0;
-	memset(chip->rirb.cmds, 0, sizeof(chip->rirb.cmds));
-	azx_writel(chip, RIRBLBASE, (u32)chip->rirb.addr);
-	azx_writel(chip, RIRBUBASE, upper_32_bits(chip->rirb.addr));
-
-	/* set the rirb size to 256 entries (ULI requires explicitly) */
-	azx_writeb(chip, RIRBSIZE, 0x02);
-	/* reset the rirb hw write pointer */
-	azx_writew(chip, RIRBWP, ICH6_RIRBWP_RST);
-	/* set N=1, get RIRB response interrupt for new entry */
-	if (chip->driver_caps & AZX_DCAPS_CTX_WORKAROUND)
-		azx_writew(chip, RINTCNT, 0xc0);
-	else
-		azx_writew(chip, RINTCNT, 1);
-	/* enable rirb dma and response irq */
-	azx_writeb(chip, RIRBCTL, ICH6_RBCTL_DMA_EN | ICH6_RBCTL_IRQ_EN);
-	spin_unlock_irq(&chip->reg_lock);
-}
-
-static void azx_free_cmd_io(struct azx *chip)
-{
-	spin_lock_irq(&chip->reg_lock);
-	/* disable ringbuffer DMAs */
-	azx_writeb(chip, RIRBCTL, 0);
-	azx_writeb(chip, CORBCTL, 0);
-	spin_unlock_irq(&chip->reg_lock);
-}
-
-static unsigned int azx_command_addr(u32 cmd)
-{
-	unsigned int addr = cmd >> 28;
-
-	if (addr >= AZX_MAX_CODECS) {
-		snd_BUG();
-		addr = 0;
-	}
-
-	return addr;
-}
-
-/* send a command */
-static int azx_corb_send_cmd(struct hda_bus *bus, u32 val)
-{
-	struct azx *chip = bus->private_data;
-	unsigned int addr = azx_command_addr(val);
-	unsigned int wp, rp;
-
-	spin_lock_irq(&chip->reg_lock);
-
-	/* add command to corb */
-	wp = azx_readw(chip, CORBWP);
-	if (wp == 0xffff) {
-		/* something wrong, controller likely turned to D3 */
-		spin_unlock_irq(&chip->reg_lock);
-		return -EIO;
-	}
-	wp++;
-	wp %= ICH6_MAX_CORB_ENTRIES;
-
-	rp = azx_readw(chip, CORBRP);
-	if (wp == rp) {
-		/* oops, it's full */
-		spin_unlock_irq(&chip->reg_lock);
-		return -EAGAIN;
-	}
-
-	chip->rirb.cmds[addr]++;
-	chip->corb.buf[wp] = cpu_to_le32(val);
-	azx_writel(chip, CORBWP, wp);
-
-	spin_unlock_irq(&chip->reg_lock);
-
-	return 0;
-}
-
-#define ICH6_RIRB_EX_UNSOL_EV	(1<<4)
-
-/* retrieve RIRB entry - called from interrupt handler */
-static void azx_update_rirb(struct azx *chip)
-{
-	unsigned int rp, wp;
-	unsigned int addr;
-	u32 res, res_ex;
-
-	wp = azx_readw(chip, RIRBWP);
-	if (wp == 0xffff) {
-		/* something wrong, controller likely turned to D3 */
-		return;
-	}
-
-	if (wp == chip->rirb.wp)
-		return;
-	chip->rirb.wp = wp;
-
-	while (chip->rirb.rp != wp) {
-		chip->rirb.rp++;
-		chip->rirb.rp %= ICH6_MAX_RIRB_ENTRIES;
-
-		rp = chip->rirb.rp << 1; /* an RIRB entry is 8-bytes */
-		res_ex = le32_to_cpu(chip->rirb.buf[rp + 1]);
-		res = le32_to_cpu(chip->rirb.buf[rp]);
-		addr = res_ex & 0xf;
-		if ((addr >= AZX_MAX_CODECS) || !(chip->codec_mask & (1 << addr))) {
-			dev_err(chip->card->dev, "spurious response %#x:%#x, rp = %d, wp = %d",
-				res, res_ex,
-				chip->rirb.rp, wp);
-			snd_BUG();
-		}
-		else if (res_ex & ICH6_RIRB_EX_UNSOL_EV)
-			snd_hda_queue_unsol_event(chip->bus, res, res_ex);
-		else if (chip->rirb.cmds[addr]) {
-			chip->rirb.res[addr] = res;
-			smp_wmb();
-			chip->rirb.cmds[addr]--;
-		} else if (printk_ratelimit()) {
-			dev_err(chip->card->dev, "spurious response %#x:%#x, last cmd=%#08x\n",
-				res, res_ex,
-				chip->last_cmd[addr]);
-		}
-	}
-}
-
-/* receive a response */
-static unsigned int azx_rirb_get_response(struct hda_bus *bus,
-					  unsigned int addr)
-{
-	struct azx *chip = bus->private_data;
-	unsigned long timeout;
-	unsigned long loopcounter;
-	int do_poll = 0;
-
- again:
-	timeout = jiffies + msecs_to_jiffies(1000);
-
-	for (loopcounter = 0;; loopcounter++) {
-		if (chip->polling_mode || do_poll) {
-			spin_lock_irq(&chip->reg_lock);
-			azx_update_rirb(chip);
-			spin_unlock_irq(&chip->reg_lock);
-		}
-		if (!chip->rirb.cmds[addr]) {
-			smp_rmb();
-			bus->rirb_error = 0;
-
-			if (!do_poll)
-				chip->poll_count = 0;
-			return chip->rirb.res[addr]; /* the last value */
-		}
-		if (time_after(jiffies, timeout))
-			break;
-		if (bus->needs_damn_long_delay || loopcounter > 3000)
-			msleep(2); /* temporary workaround */
-		else {
-			udelay(10);
-			cond_resched();
-		}
-	}
-
-	if (!bus->no_response_fallback)
-		return -1;
-
-	if (!chip->polling_mode && chip->poll_count < 2) {
-		dev_dbg(chip->card->dev,
-			"azx_get_response timeout, polling the codec once: last cmd=0x%08x\n",
-			chip->last_cmd[addr]);
-		do_poll = 1;
-		chip->poll_count++;
-		goto again;
-	}
-
-
-	if (!chip->polling_mode) {
-		dev_warn(chip->card->dev,
-			 "azx_get_response timeout, switching to polling mode: last cmd=0x%08x\n",
-			 chip->last_cmd[addr]);
-		chip->polling_mode = 1;
-		goto again;
-	}
-
-	if (chip->msi) {
-		dev_warn(chip->card->dev,
-			 "No response from codec, disabling MSI: last cmd=0x%08x\n",
-			 chip->last_cmd[addr]);
-		if (chip->disable_msi_reset_irq(chip) < 0) {
-			bus->rirb_error = 1;
-			return -1;
-		}
-		goto again;
-	}
-
-	if (chip->probing) {
-		/* If this critical timeout happens during the codec probing
-		 * phase, this is likely an access to a non-existing codec
-		 * slot.  Better to return an error and reset the system.
-		 */
-		return -1;
-	}
-
-	/* a fatal communication error; need either to reset or to fallback
-	 * to the single_cmd mode
-	 */
-	bus->rirb_error = 1;
-	if (bus->allow_bus_reset && !bus->response_reset && !bus->in_reset) {
-		bus->response_reset = 1;
-		return -1; /* give a chance to retry */
-	}
-
-	dev_err(chip->card->dev,
-		"azx_get_response timeout, switching to single_cmd mode: last cmd=0x%08x\n",
-		chip->last_cmd[addr]);
-	chip->single_cmd = 1;
-	bus->response_reset = 0;
-	/* release CORB/RIRB */
-	azx_free_cmd_io(chip);
-	/* disable unsolicited responses */
-	azx_writel(chip, GCTL, azx_readl(chip, GCTL) & ~ICH6_GCTL_UNSOL);
-	return -1;
-}
-
-/*
- * Use the single immediate command instead of CORB/RIRB for simplicity
- *
- * Note: according to Intel, this is not preferred use.  The command was
- *       intended for the BIOS only, and may get confused with unsolicited
- *       responses.  So, we shouldn't use it for normal operation from the
- *       driver.
- *       I left the codes, however, for debugging/testing purposes.
- */
-
-/* receive a response */
-static int azx_single_wait_for_response(struct azx *chip, unsigned int addr)
-{
-	int timeout = 50;
-
-	while (timeout--) {
-		/* check IRV busy bit */
-		if (azx_readw(chip, IRS) & ICH6_IRS_VALID) {
-			/* reuse rirb.res as the response return value */
-			chip->rirb.res[addr] = azx_readl(chip, IR);
-			return 0;
-		}
-		udelay(1);
-	}
-	if (printk_ratelimit())
-		dev_dbg(chip->card->dev, "get_response timeout: IRS=0x%x\n",
-			azx_readw(chip, IRS));
-	chip->rirb.res[addr] = -1;
-	return -EIO;
-}
-
-/* send a command */
-static int azx_single_send_cmd(struct hda_bus *bus, u32 val)
-{
-	struct azx *chip = bus->private_data;
-	unsigned int addr = azx_command_addr(val);
-	int timeout = 50;
-
-	bus->rirb_error = 0;
-	while (timeout--) {
-		/* check ICB busy bit */
-		if (!((azx_readw(chip, IRS) & ICH6_IRS_BUSY))) {
-			/* Clear IRV valid bit */
-			azx_writew(chip, IRS, azx_readw(chip, IRS) |
-				   ICH6_IRS_VALID);
-			azx_writel(chip, IC, val);
-			azx_writew(chip, IRS, azx_readw(chip, IRS) |
-				   ICH6_IRS_BUSY);
-			return azx_single_wait_for_response(chip, addr);
-		}
-		udelay(1);
-	}
-	if (printk_ratelimit())
-		dev_dbg(chip->card->dev,
-			"send_cmd timeout: IRS=0x%x, val=0x%x\n",
-			azx_readw(chip, IRS), val);
-	return -EIO;
-}
-
-/* receive a response */
-static unsigned int azx_single_get_response(struct hda_bus *bus,
-					    unsigned int addr)
-{
-	struct azx *chip = bus->private_data;
-	return chip->rirb.res[addr];
-}
-
-/*
- * The below are the main callbacks from hda_codec.
- *
- * They are just the skeleton to call sub-callbacks according to the
- * current setting of chip->single_cmd.
- */
-
-/* send a command */
-static int azx_send_cmd(struct hda_bus *bus, unsigned int val)
-{
-	struct azx *chip = bus->private_data;
-
-	if (chip->disabled)
-		return 0;
-	chip->last_cmd[azx_command_addr(val)] = val;
-	if (chip->single_cmd)
-		return azx_single_send_cmd(bus, val);
-	else
-		return azx_corb_send_cmd(bus, val);
-}
-
-/* get a response */
-static unsigned int azx_get_response(struct hda_bus *bus,
-				     unsigned int addr)
-{
-	struct azx *chip = bus->private_data;
-	if (chip->disabled)
-		return 0;
-	if (chip->single_cmd)
-		return azx_single_get_response(bus, addr);
-	else
-		return azx_rirb_get_response(bus, addr);
-}
 
 #ifdef CONFIG_PM
 static void azx_power_notify(struct hda_bus *bus, bool power_up);
diff --git a/sound/pci/hda/hda_shared.c b/sound/pci/hda/hda_shared.c
index 27377ca..0b2115e 100644
--- a/sound/pci/hda/hda_shared.c
+++ b/sound/pci/hda/hda_shared.c
@@ -79,11 +79,10 @@ void __mark_pages_wc(struct azx *chip, struct snd_dma_buffer *dmab, bool on)
 		set_memory_wb((unsigned long)dmab->area, pages);
 }
 
-void mark_pages_wc(struct azx *chip, struct snd_dma_buffer *buf, bool on)
+static void mark_pages_wc(struct azx *chip, struct snd_dma_buffer *buf, bool on)
 {
 	__mark_pages_wc(chip, buf, on);
 }
-EXPORT_SYMBOL_GPL(mark_pages_wc);
 
 static void mark_runtime_wc(struct azx *chip, struct azx_dev *azx_dev,
 			    struct snd_pcm_substream *substream, bool on)
@@ -94,6 +93,10 @@ static void mark_runtime_wc(struct azx *chip, struct azx_dev *azx_dev,
 	}
 }
 #else
+static inline void mark_pages_wc(struct azx *chip, struct snd_dma_buffer *buf,
+				 bool on)
+{
+}
 static inline void mark_runtime_wc(struct azx *chip, struct azx_dev *azx_dev,
 				   struct snd_pcm_substream *substream, bool on)
 {
@@ -1114,6 +1117,366 @@ int azx_position_ok(struct azx *chip, struct azx_dev *azx_dev)
 	return 1; /* OK, it's fine */
 }
 
+/*
+ * CORB / RIRB interface
+ */
+int azx_alloc_cmd_io(struct azx *chip)
+{
+	int err;
+
+	/* single page (at least 4096 bytes) must suffice for both ringbuffes */
+	err = snd_dma_alloc_pages(SNDRV_DMA_TYPE_DEV,
+				  chip->card->dev,
+				  PAGE_SIZE, &chip->rb);
+	if (err < 0) {
+		dev_err(chip->card->dev, "cannot allocate CORB/RIRB\n");
+		return err;
+	}
+	mark_pages_wc(chip, &chip->rb, true);
+	return 0;
+}
+
+void azx_init_cmd_io(struct azx *chip)
+{
+	spin_lock_irq(&chip->reg_lock);
+	/* CORB set up */
+	chip->corb.addr = chip->rb.addr;
+	chip->corb.buf = (u32 *)chip->rb.area;
+	azx_writel(chip, CORBLBASE, (u32)chip->corb.addr);
+	azx_writel(chip, CORBUBASE, upper_32_bits(chip->corb.addr));
+
+	/* set the corb size to 256 entries (ULI requires explicitly) */
+	azx_writeb(chip, CORBSIZE, 0x02);
+	/* set the corb write pointer to 0 */
+	azx_writew(chip, CORBWP, 0);
+	/* reset the corb hw read pointer */
+	azx_writew(chip, CORBRP, ICH6_CORBRP_RST);
+	/* enable corb dma */
+	azx_writeb(chip, CORBCTL, ICH6_CORBCTL_RUN);
+
+	/* RIRB set up */
+	chip->rirb.addr = chip->rb.addr + 2048;
+	chip->rirb.buf = (u32 *)(chip->rb.area + 2048);
+	chip->rirb.wp = chip->rirb.rp = 0;
+	memset(chip->rirb.cmds, 0, sizeof(chip->rirb.cmds));
+	azx_writel(chip, RIRBLBASE, (u32)chip->rirb.addr);
+	azx_writel(chip, RIRBUBASE, upper_32_bits(chip->rirb.addr));
+
+	/* set the rirb size to 256 entries (ULI requires explicitly) */
+	azx_writeb(chip, RIRBSIZE, 0x02);
+	/* reset the rirb hw write pointer */
+	azx_writew(chip, RIRBWP, ICH6_RIRBWP_RST);
+	/* set N=1, get RIRB response interrupt for new entry */
+	if (chip->driver_caps & AZX_DCAPS_CTX_WORKAROUND)
+		azx_writew(chip, RINTCNT, 0xc0);
+	else
+		azx_writew(chip, RINTCNT, 1);
+	/* enable rirb dma and response irq */
+	azx_writeb(chip, RIRBCTL, ICH6_RBCTL_DMA_EN | ICH6_RBCTL_IRQ_EN);
+	spin_unlock_irq(&chip->reg_lock);
+}
+
+void azx_free_cmd_io(struct azx *chip)
+{
+	spin_lock_irq(&chip->reg_lock);
+	/* disable ringbuffer DMAs */
+	azx_writeb(chip, RIRBCTL, 0);
+	azx_writeb(chip, CORBCTL, 0);
+	spin_unlock_irq(&chip->reg_lock);
+}
+
+static unsigned int azx_command_addr(u32 cmd)
+{
+	unsigned int addr = cmd >> 28;
+
+	if (addr >= AZX_MAX_CODECS) {
+		snd_BUG();
+		addr = 0;
+	}
+
+	return addr;
+}
+
+/* send a command */
+static int azx_corb_send_cmd(struct hda_bus *bus, u32 val)
+{
+	struct azx *chip = bus->private_data;
+	unsigned int addr = azx_command_addr(val);
+	unsigned int wp, rp;
+
+	spin_lock_irq(&chip->reg_lock);
+
+	/* add command to corb */
+	wp = azx_readw(chip, CORBWP);
+	if (wp == 0xffff) {
+		/* something wrong, controller likely turned to D3 */
+		spin_unlock_irq(&chip->reg_lock);
+		return -EIO;
+	}
+	wp++;
+	wp %= ICH6_MAX_CORB_ENTRIES;
+
+	rp = azx_readw(chip, CORBRP);
+	if (wp == rp) {
+		/* oops, it's full */
+		spin_unlock_irq(&chip->reg_lock);
+		return -EAGAIN;
+	}
+
+	chip->rirb.cmds[addr]++;
+	chip->corb.buf[wp] = cpu_to_le32(val);
+	azx_writel(chip, CORBWP, wp);
+
+	spin_unlock_irq(&chip->reg_lock);
+
+	return 0;
+}
+
+#define ICH6_RIRB_EX_UNSOL_EV	(1<<4)
+
+/* retrieve RIRB entry - called from interrupt handler */
+void azx_update_rirb(struct azx *chip)
+{
+	unsigned int rp, wp;
+	unsigned int addr;
+	u32 res, res_ex;
+
+	wp = azx_readw(chip, RIRBWP);
+	if (wp == 0xffff) {
+		/* something wrong, controller likely turned to D3 */
+		return;
+	}
+
+	if (wp == chip->rirb.wp)
+		return;
+	chip->rirb.wp = wp;
+
+	while (chip->rirb.rp != wp) {
+		chip->rirb.rp++;
+		chip->rirb.rp %= ICH6_MAX_RIRB_ENTRIES;
+
+		rp = chip->rirb.rp << 1; /* an RIRB entry is 8-bytes */
+		res_ex = le32_to_cpu(chip->rirb.buf[rp + 1]);
+		res = le32_to_cpu(chip->rirb.buf[rp]);
+		addr = res_ex & 0xf;
+		if ((addr >= AZX_MAX_CODECS) || !(chip->codec_mask & (1 << addr))) {
+			dev_err(chip->card->dev, "spurious response %#x:%#x, rp = %d, wp = %d",
+				res, res_ex,
+				chip->rirb.rp, wp);
+			snd_BUG();
+		}
+		else if (res_ex & ICH6_RIRB_EX_UNSOL_EV)
+			snd_hda_queue_unsol_event(chip->bus, res, res_ex);
+		else if (chip->rirb.cmds[addr]) {
+			chip->rirb.res[addr] = res;
+			smp_wmb();
+			chip->rirb.cmds[addr]--;
+		} else if (printk_ratelimit()) {
+			dev_err(chip->card->dev, "spurious response %#x:%#x, last cmd=%#08x\n",
+				res, res_ex,
+				chip->last_cmd[addr]);
+		}
+	}
+}
+
+/* receive a response */
+static unsigned int azx_rirb_get_response(struct hda_bus *bus,
+					  unsigned int addr)
+{
+	struct azx *chip = bus->private_data;
+	unsigned long timeout;
+	unsigned long loopcounter;
+	int do_poll = 0;
+
+ again:
+	timeout = jiffies + msecs_to_jiffies(1000);
+
+	for (loopcounter = 0;; loopcounter++) {
+		if (chip->polling_mode || do_poll) {
+			spin_lock_irq(&chip->reg_lock);
+			azx_update_rirb(chip);
+			spin_unlock_irq(&chip->reg_lock);
+		}
+		if (!chip->rirb.cmds[addr]) {
+			smp_rmb();
+			bus->rirb_error = 0;
+
+			if (!do_poll)
+				chip->poll_count = 0;
+			return chip->rirb.res[addr]; /* the last value */
+		}
+		if (time_after(jiffies, timeout))
+			break;
+		if (bus->needs_damn_long_delay || loopcounter > 3000)
+			msleep(2); /* temporary workaround */
+		else {
+			udelay(10);
+			cond_resched();
+		}
+	}
+
+	if (!bus->no_response_fallback)
+		return -1;
+
+	if (!chip->polling_mode && chip->poll_count < 2) {
+		dev_dbg(chip->card->dev,
+			"azx_get_response timeout, polling the codec once: last cmd=0x%08x\n",
+			chip->last_cmd[addr]);
+		do_poll = 1;
+		chip->poll_count++;
+		goto again;
+	}
+
+
+	if (!chip->polling_mode) {
+		dev_warn(chip->card->dev,
+			 "azx_get_response timeout, switching to polling mode: last cmd=0x%08x\n",
+			 chip->last_cmd[addr]);
+		chip->polling_mode = 1;
+		goto again;
+	}
+
+	if (chip->msi) {
+		dev_warn(chip->card->dev,
+			 "No response from codec, disabling MSI: last cmd=0x%08x\n",
+			 chip->last_cmd[addr]);
+		if (chip->disable_msi_reset_irq(chip) < 0) {
+			bus->rirb_error = 1;
+			return -1;
+		}
+		goto again;
+	}
+
+	if (chip->probing) {
+		/* If this critical timeout happens during the codec probing
+		 * phase, this is likely an access to a non-existing codec
+		 * slot.  Better to return an error and reset the system.
+		 */
+		return -1;
+	}
+
+	/* a fatal communication error; need either to reset or to fallback
+	 * to the single_cmd mode
+	 */
+	bus->rirb_error = 1;
+	if (bus->allow_bus_reset && !bus->response_reset && !bus->in_reset) {
+		bus->response_reset = 1;
+		return -1; /* give a chance to retry */
+	}
+
+	dev_err(chip->card->dev,
+		"azx_get_response timeout, switching to single_cmd mode: last cmd=0x%08x\n",
+		chip->last_cmd[addr]);
+	chip->single_cmd = 1;
+	bus->response_reset = 0;
+	/* release CORB/RIRB */
+	azx_free_cmd_io(chip);
+	/* disable unsolicited responses */
+	azx_writel(chip, GCTL, azx_readl(chip, GCTL) & ~ICH6_GCTL_UNSOL);
+	return -1;
+}
+
+/*
+ * Use the single immediate command instead of CORB/RIRB for simplicity
+ *
+ * Note: according to Intel, this is not preferred use.  The command was
+ *       intended for the BIOS only, and may get confused with unsolicited
+ *       responses.  So, we shouldn't use it for normal operation from the
+ *       driver.
+ *       I left the codes, however, for debugging/testing purposes.
+ */
+
+/* receive a response */
+static int azx_single_wait_for_response(struct azx *chip, unsigned int addr)
+{
+	int timeout = 50;
+
+	while (timeout--) {
+		/* check IRV busy bit */
+		if (azx_readw(chip, IRS) & ICH6_IRS_VALID) {
+			/* reuse rirb.res as the response return value */
+			chip->rirb.res[addr] = azx_readl(chip, IR);
+			return 0;
+		}
+		udelay(1);
+	}
+	if (printk_ratelimit())
+		dev_dbg(chip->card->dev, "get_response timeout: IRS=0x%x\n",
+			azx_readw(chip, IRS));
+	chip->rirb.res[addr] = -1;
+	return -EIO;
+}
+
+/* send a command */
+static int azx_single_send_cmd(struct hda_bus *bus, u32 val)
+{
+	struct azx *chip = bus->private_data;
+	unsigned int addr = azx_command_addr(val);
+	int timeout = 50;
+
+	bus->rirb_error = 0;
+	while (timeout--) {
+		/* check ICB busy bit */
+		if (!((azx_readw(chip, IRS) & ICH6_IRS_BUSY))) {
+			/* Clear IRV valid bit */
+			azx_writew(chip, IRS, azx_readw(chip, IRS) |
+				   ICH6_IRS_VALID);
+			azx_writel(chip, IC, val);
+			azx_writew(chip, IRS, azx_readw(chip, IRS) |
+				   ICH6_IRS_BUSY);
+			return azx_single_wait_for_response(chip, addr);
+		}
+		udelay(1);
+	}
+	if (printk_ratelimit())
+		dev_dbg(chip->card->dev,
+			"send_cmd timeout: IRS=0x%x, val=0x%x\n",
+			azx_readw(chip, IRS), val);
+	return -EIO;
+}
+
+/* receive a response */
+static unsigned int azx_single_get_response(struct hda_bus *bus,
+					    unsigned int addr)
+{
+	struct azx *chip = bus->private_data;
+	return chip->rirb.res[addr];
+}
+
+/*
+ * The below are the main callbacks from hda_codec.
+ *
+ * They are just the skeleton to call sub-callbacks according to the
+ * current setting of chip->single_cmd.
+ */
+
+/* send a command */
+int azx_send_cmd(struct hda_bus *bus, unsigned int val)
+{
+	struct azx *chip = bus->private_data;
+
+	if (chip->disabled)
+		return 0;
+	chip->last_cmd[azx_command_addr(val)] = val;
+	if (chip->single_cmd)
+		return azx_single_send_cmd(bus, val);
+	else
+		return azx_corb_send_cmd(bus, val);
+}
+
+/* get a response */
+unsigned int azx_get_response(struct hda_bus *bus,
+			      unsigned int addr)
+{
+	struct azx *chip = bus->private_data;
+	if (chip->disabled)
+		return 0;
+	if (chip->single_cmd)
+		return azx_single_get_response(bus, addr);
+	else
+		return azx_rirb_get_response(bus, addr);
+}
+
 #ifdef CONFIG_SND_HDA_DSP_LOADER
 /*
  * DSP loading code (e.g. for CA0132)
diff --git a/sound/pci/hda/hda_shared.h b/sound/pci/hda/hda_shared.h
index 0c0ba24..e0f8e3d 100644
--- a/sound/pci/hda/hda_shared.h
+++ b/sound/pci/hda/hda_shared.h
@@ -20,16 +20,6 @@
 #include "hda_codec.h"
 #include "hda_priv.h"
 
-#ifdef CONFIG_X86
-void mark_pages_wc(struct azx *chip, struct snd_dma_buffer *buf, bool on);
-#else
-/* NOP for other archs */
-static inline void mark_pages_wc(struct azx *chip, struct snd_dma_buffer *buf,
-				 bool on)
-{
-}
-#endif
-
 /* PCM setup */
 int azx_attach_pcm_stream(struct hda_bus *bus, struct hda_codec *codec,
 			  struct hda_pcm *cpcm);
@@ -55,4 +45,15 @@ void azx_load_dsp_cleanup(struct hda_bus *bus,
 int azx_alloc_stream_pages(struct azx *chip);
 void azx_free_stream_pages(struct azx *chip);
 
+/*
+ * CORB / RIRB interface
+ */
+int azx_send_cmd(struct hda_bus *bus, unsigned int val);
+unsigned int azx_get_response(struct hda_bus *bus,
+			      unsigned int addr);
+void azx_init_cmd_io(struct azx *chip);
+void azx_free_cmd_io(struct azx *chip);
+void azx_update_rirb(struct azx *chip);
+int azx_alloc_cmd_io(struct azx *chip);
+
 #endif /* __SOUND_HDA_SHARED_H */
-- 
1.8.1.3.605.g02339dd
