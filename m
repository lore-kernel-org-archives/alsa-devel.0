From: Jaroslav Kysela <perex@perex.cz>
Subject: [PATCH] ALSA: hda: controller code - do not export
	static functions
Date: Tue, 24 Feb 2015 12:04:57 +0100
Message-ID: <1424775897-9627-1-git-send-email-perex@perex.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 by alsa0.perex.cz (Postfix) with ESMTP id 50586260417
 for <alsa-devel@alsa-project.org>; Tue, 24 Feb 2015 12:05:24 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: ALSA development <alsa-devel@alsa-project.org>
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

It is a bad idea to export static functions. GCC for some platforms
shows errors like:

  error: __ksymtab_azx_get_response causes a section type conflict

Signed-off-by: Jaroslav Kysela <perex@perex.cz>
---
 sound/pci/hda/hda_controller.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/sound/pci/hda/hda_controller.c b/sound/pci/hda/hda_controller.c
index ebb7a64..f63d2cb5 100644
--- a/sound/pci/hda/hda_controller.c
+++ b/sound/pci/hda/hda_controller.c
@@ -978,7 +978,6 @@ static int azx_alloc_cmd_io(struct azx *chip)
 		dev_err(chip->card->dev, "cannot allocate CORB/RIRB\n");
 	return err;
 }
-EXPORT_SYMBOL_GPL(azx_alloc_cmd_io);
 
 static void azx_init_cmd_io(struct azx *chip)
 {
@@ -1043,7 +1042,6 @@ static void azx_init_cmd_io(struct azx *chip)
 	azx_writeb(chip, RIRBCTL, AZX_RBCTL_DMA_EN | AZX_RBCTL_IRQ_EN);
 	spin_unlock_irq(&chip->reg_lock);
 }
-EXPORT_SYMBOL_GPL(azx_init_cmd_io);
 
 static void azx_free_cmd_io(struct azx *chip)
 {
@@ -1053,7 +1051,6 @@ static void azx_free_cmd_io(struct azx *chip)
 	azx_writeb(chip, CORBCTL, 0);
 	spin_unlock_irq(&chip->reg_lock);
 }
-EXPORT_SYMBOL_GPL(azx_free_cmd_io);
 
 static unsigned int azx_command_addr(u32 cmd)
 {
@@ -1333,7 +1330,6 @@ static int azx_send_cmd(struct hda_bus *bus, unsigned int val)
 	else
 		return azx_corb_send_cmd(bus, val);
 }
-EXPORT_SYMBOL_GPL(azx_send_cmd);
 
 /* get a response */
 static unsigned int azx_get_response(struct hda_bus *bus,
@@ -1347,7 +1343,6 @@ static unsigned int azx_get_response(struct hda_bus *bus,
 	else
 		return azx_rirb_get_response(bus, addr);
 }
-EXPORT_SYMBOL_GPL(azx_get_response);
 
 #ifdef CONFIG_SND_HDA_DSP_LOADER
 /*
-- 
1.9.3
