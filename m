From: Wu Fengguang <fengguang.wu@intel.com>
Subject: [PATCH] hda: take reg_lock in
	azx_init_cmd_io/azx_free_cmd_io
Date: Sat, 1 Aug 2009 18:47:41 +0800
Message-ID: <20090801104741.GA4012@localhost>
References: <20090801104516.GA3741@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by alsa0.perex.cz (Postfix) with ESMTP id 5B176243AA
	for <alsa-devel@alsa-project.org>;
	Sat,  1 Aug 2009 12:47:54 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20090801104516.GA3741@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Jaroslav Kysela <jkysela@redhat.com>
List-Id: alsa-devel@alsa-project.org

Just for safety.  azx_init_cmd_io() and azx_free_cmd_io() may be
called when switching to single command mode.

Signed-off-by: Wu Fengguang <fengguang.wu@intel.com>
---
 sound/pci/hda/hda_intel.c |    4 ++++
 1 file changed, 4 insertions(+)

--- sound-2.6.orig/sound/pci/hda/hda_intel.c
+++ sound-2.6/sound/pci/hda/hda_intel.c
@@ -520,6 +520,7 @@ static int azx_alloc_cmd_io(struct azx *
 
 static void azx_init_cmd_io(struct azx *chip)
 {
+	spin_lock_irq(&chip->reg_lock);
 	/* CORB set up */
 	chip->corb.addr = chip->rb.addr;
 	chip->corb.buf = (u32 *)chip->rb.area;
@@ -551,13 +552,16 @@ static void azx_init_cmd_io(struct azx *
 	azx_writew(chip, RINTCNT, 1);
 	/* enable rirb dma and response irq */
 	azx_writeb(chip, RIRBCTL, ICH6_RBCTL_DMA_EN | ICH6_RBCTL_IRQ_EN);
+	spin_unlock_irq(&chip->reg_lock);
 }
 
 static void azx_free_cmd_io(struct azx *chip)
 {
+	spin_lock_irq(&chip->reg_lock);
 	/* disable ringbuffer DMAs */
 	azx_writeb(chip, RIRBCTL, 0);
 	azx_writeb(chip, CORBCTL, 0);
+	spin_unlock_irq(&chip->reg_lock);
 }
 
 static unsigned int azx_command_addr(u32 cmd)
