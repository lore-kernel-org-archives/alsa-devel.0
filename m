From: Michael Gernoth <michael@gernoth.net>
Subject: [PATCH] ALSA: emu10k1: don't deadlock in proc-functions
Date: Thu, 9 Apr 2015 23:42:15 +0200
Message-ID: <20150409214215.GA27140@zerfleddert.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eddie.zerfleddert.de (eddie.zerfleddert.de [188.246.9.226])
 by alsa0.perex.cz (Postfix) with ESMTP id 08E5C2605AB
 for <alsa-devel@alsa-project.org>; Thu,  9 Apr 2015 23:42:15 +0200 (CEST)
Content-Disposition: inline
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

The functions snd_emu10k1_proc_spdif_read and snd_emu1010_fpga_read
acquire the emu_lock before accessing the FPGA. The function used
to access the FPGA (snd_emu1010_fpga_read) also tries to take
the emu_lock which causes a deadlock.
Remove the outer locking in the proc-functions (guarding only the
already safe fpga read) to prevent this deadlock.

Signed-off-by: Michael Gernoth <michael@gernoth.net>
---
 sound/pci/emu10k1/emuproc.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/sound/pci/emu10k1/emuproc.c b/sound/pci/emu10k1/emuproc.c
index 2ca9f2e..415d23c 100644
--- a/sound/pci/emu10k1/emuproc.c
+++ b/sound/pci/emu10k1/emuproc.c
@@ -245,27 +245,19 @@ static void snd_emu10k1_proc_spdif_read(struct snd_info_entry *entry,
 	u32 rate;
 
 	if (emu->card_capabilities->emu_model) {
-		spin_lock_irqsave(&emu->emu_lock, flags);
 		snd_emu1010_fpga_read(emu, 0x38, &value);
-		spin_unlock_irqrestore(&emu->emu_lock, flags);
 		if ((value & 0x1) == 0) {
-			spin_lock_irqsave(&emu->emu_lock, flags);
 			snd_emu1010_fpga_read(emu, 0x2a, &value);
 			snd_emu1010_fpga_read(emu, 0x2b, &value2);
-			spin_unlock_irqrestore(&emu->emu_lock, flags);
 			rate = 0x1770000 / (((value << 5) | value2)+1);	
 			snd_iprintf(buffer, "ADAT Locked : %u\n", rate);
 		} else {
 			snd_iprintf(buffer, "ADAT Unlocked\n");
 		}
-		spin_lock_irqsave(&emu->emu_lock, flags);
 		snd_emu1010_fpga_read(emu, 0x20, &value);
-		spin_unlock_irqrestore(&emu->emu_lock, flags);
 		if ((value & 0x4) == 0) {
-			spin_lock_irqsave(&emu->emu_lock, flags);
 			snd_emu1010_fpga_read(emu, 0x28, &value);
 			snd_emu1010_fpga_read(emu, 0x29, &value2);
-			spin_unlock_irqrestore(&emu->emu_lock, flags);
 			rate = 0x1770000 / (((value << 5) | value2)+1);	
 			snd_iprintf(buffer, "SPDIF Locked : %d\n", rate);
 		} else {
@@ -415,9 +407,7 @@ static void snd_emu_proc_emu1010_reg_read(struct snd_info_entry *entry,
 	snd_iprintf(buffer, "EMU1010 Registers:\n\n");
 
 	for(i = 0; i < 0x40; i+=1) {
-		spin_lock_irqsave(&emu->emu_lock, flags);
 		snd_emu1010_fpga_read(emu, i, &value);
-		spin_unlock_irqrestore(&emu->emu_lock, flags);
 		snd_iprintf(buffer, "%02X: %08X, %02X\n", i, value, (value >> 8) & 0x7f);
 	}
 }
-- 
2.1.4
