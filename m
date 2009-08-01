From: Wu Fengguang <fengguang.wu@intel.com>
Subject: [PATCH] hda: read CORBWP inside reg_lock
Date: Sat, 1 Aug 2009 18:48:12 +0800
Message-ID: <20090801104812.GB4012@localhost>
References: <20090801104516.GA3741@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by alsa0.perex.cz (Postfix) with ESMTP id 149F7243AA
	for <alsa-devel@alsa-project.org>;
	Sat,  1 Aug 2009 12:48:20 +0200 (CEST)
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

This converts the last CORBWP access outside of reg_lock.

Signed-off-by: Wu Fengguang <fengguang.wu@intel.com>
---
 sound/pci/hda/hda_intel.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- sound-2.6.orig/sound/pci/hda/hda_intel.c
+++ sound-2.6/sound/pci/hda/hda_intel.c
@@ -595,15 +595,17 @@ static int azx_corb_send_cmd(struct hda_
 	unsigned int addr = azx_command_addr(val);
 	unsigned int wp;
 
+	spin_lock_irq(&chip->reg_lock);
+
 	/* add command to corb */
 	wp = azx_readb(chip, CORBWP);
 	wp++;
 	wp %= ICH6_MAX_CORB_ENTRIES;
 
-	spin_lock_irq(&chip->reg_lock);
 	chip->rirb.cmds[addr]++;
 	chip->corb.buf[wp] = cpu_to_le32(val);
 	azx_writel(chip, CORBWP, wp);
+
 	spin_unlock_irq(&chip->reg_lock);
 
 	return 0;
