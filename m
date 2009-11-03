From: Troy Kisky <troy.kisky@boundarydevices.com>
Subject: [PATCH] ALSA: hda_intel: disable corb rirb when
	single_cmd active
Date: Tue,  3 Nov 2009 12:22:37 -0700
Message-ID: <1257276157-7164-1-git-send-email-troy.kisky@boundarydevices.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mpls-qmqp-01.inet.qwest.net (mpls-qmqp-01.inet.qwest.net
	[63.231.195.112])
	by alsa0.perex.cz (Postfix) with ESMTP id 93EAA103816
	for <alsa-devel@alsa-project.org>; Tue,  3 Nov 2009 20:22:58 +0100 (CET)
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
Cc: tiwai@suse.de, Troy Kisky <troy.kisky@boundarydevices.com>
List-Id: alsa-devel@alsa-project.org

Poulsbo(US15W) cannot have any corb registers initialized
when using single_cmd mode.
When send_cmd timeout occur, note error.

Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>
---
 sound/pci/hda/hda_intel.c |   16 +++++++++++-----
 1 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index c9ad182..c2ff585 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -524,6 +524,16 @@ static void azx_init_cmd_io(struct azx *chip)
 	/* CORB set up */
 	chip->corb.addr = chip->rb.addr;
 	chip->corb.buf = (u32 *)chip->rb.area;
+
+	/* RIRB set up */
+	chip->rirb.addr = chip->rb.addr + 2048;
+	chip->rirb.buf = (u32 *)(chip->rb.area + 2048);
+	chip->rirb.wp = chip->rirb.rp = 0;
+	memset(chip->rirb.cmds, 0, sizeof(chip->rirb.cmds));
+	if (chip->single_cmd) {
+		spin_unlock_irq(&chip->reg_lock);
+		return;
+	}
 	azx_writel(chip, CORBLBASE, (u32)chip->corb.addr);
 	azx_writel(chip, CORBUBASE, upper_32_bits(chip->corb.addr));
 
@@ -536,11 +546,6 @@ static void azx_init_cmd_io(struct azx *chip)
 	/* enable corb dma */
 	azx_writeb(chip, CORBCTL, ICH6_CORBCTL_RUN);
 
-	/* RIRB set up */
-	chip->rirb.addr = chip->rb.addr + 2048;
-	chip->rirb.buf = (u32 *)(chip->rb.area + 2048);
-	chip->rirb.wp = chip->rirb.rp = 0;
-	memset(chip->rirb.cmds, 0, sizeof(chip->rirb.cmds));
 	azx_writel(chip, RIRBLBASE, (u32)chip->rirb.addr);
 	azx_writel(chip, RIRBUBASE, upper_32_bits(chip->rirb.addr));
 
@@ -783,6 +788,7 @@ static int azx_single_send_cmd(struct hda_bus *bus, u32 val)
 	if (printk_ratelimit())
 		snd_printd(SFX "send_cmd timeout: IRS=0x%x, val=0x%x\n",
 			   azx_readw(chip, IRS), val);
+	chip->rirb.res[addr] = -1;
 	return -EIO;
 }
 
-- 
1.5.6.3
