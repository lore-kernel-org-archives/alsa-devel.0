From: Wu Fengguang <fengguang.wu@intel.com>
Subject: [PATCH] hda: remember last command for each codec
Date: Sat, 1 Aug 2009 19:17:14 +0800
Message-ID: <20090801111714.GA7323@localhost>
References: <20090801104516.GA3741@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by alsa0.perex.cz (Postfix) with ESMTP id 5365724930
	for <alsa-devel@alsa-project.org>;
	Sat,  1 Aug 2009 13:17:24 +0200 (CEST)
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

Signed-off-by: Wu Fengguang <fengguang.wu@intel.com>
---
 sound/pci/hda/hda_intel.c |   11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

--- sound-2.6.orig/sound/pci/hda/hda_intel.c
+++ sound-2.6/sound/pci/hda/hda_intel.c
@@ -425,7 +425,7 @@ struct azx {
 	unsigned int probing :1; /* codec probing phase */
 
 	/* for debugging */
-	unsigned int last_cmd;	/* last issued command (to sync) */
+	unsigned int last_cmd[AZX_MAX_CODECS];
 
 	/* for pending irqs */
 	struct work_struct irq_pending_work;
@@ -675,7 +675,8 @@ static unsigned int azx_rirb_get_respons
 
 	if (chip->msi) {
 		snd_printk(KERN_WARNING SFX "No response from codec, "
-			   "disabling MSI: last cmd=0x%08x\n", chip->last_cmd);
+			   "disabling MSI: last cmd=0x%08x\n",
+			   chip->last_cmd[addr]);
 		free_irq(chip->irq, chip);
 		chip->irq = -1;
 		pci_disable_msi(chip->pci);
@@ -690,7 +691,7 @@ static unsigned int azx_rirb_get_respons
 	if (!chip->polling_mode) {
 		snd_printk(KERN_WARNING SFX "azx_get_response timeout, "
 			   "switching to polling mode: last cmd=0x%08x\n",
-			   chip->last_cmd);
+			   chip->last_cmd[addr]);
 		chip->polling_mode = 1;
 		goto again;
 	}
@@ -714,7 +715,7 @@ static unsigned int azx_rirb_get_respons
 
 	snd_printk(KERN_ERR "hda_intel: azx_get_response timeout, "
 		   "switching to single_cmd mode: last cmd=0x%08x\n",
-		   chip->last_cmd);
+		   chip->last_cmd[addr]);
 	chip->single_cmd = 1;
 	bus->response_reset = 0;
 	/* re-initialize CORB/RIRB */
@@ -801,7 +802,7 @@ static int azx_send_cmd(struct hda_bus *
 {
 	struct azx *chip = bus->private_data;
 
-	chip->last_cmd = val;
+	chip->last_cmd[azx_command_addr(val)] = val;
 	if (chip->single_cmd)
 		return azx_single_send_cmd(bus, val);
 	else
