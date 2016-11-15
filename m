From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/3] ALSA: emu10k1: Fix emu1010 dock attach
	check
Date: Tue, 15 Nov 2016 08:24:07 +0100
Message-ID: <20161115072409.29531-2-tiwai@suse.de>
References: <20161115072409.29531-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 4CB01266FA0
 for <alsa-devel@alsa-project.org>; Tue, 15 Nov 2016 08:24:19 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id B1E93ACDE
 for <alsa-devel@alsa-project.org>; Tue, 15 Nov 2016 07:24:19 +0000 (UTC)
In-Reply-To: <20161115072409.29531-1-tiwai@suse.de>
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

The emu1010_firmware_thread() checks the previous dock status, but a
wrong register is recorded as the last status when the dock is plugged
in.  Usually this isn't a big issue since this value gets overwritten
by the next loop after one second.  But when a dock is unplugged
immediately after plugging, it means essentially missing undock
handling.

This patch addresses it by remembering the correct register value.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/emu10k1/emu10k1_main.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/pci/emu10k1/emu10k1_main.c b/sound/pci/emu10k1/emu10k1_main.c
index 891453451543..c1b603a8922c 100644
--- a/sound/pci/emu10k1/emu10k1_main.c
+++ b/sound/pci/emu10k1/emu10k1_main.c
@@ -762,19 +762,19 @@ static int emu1010_firmware_thread(void *data)
 			}
 
 			snd_emu1010_fpga_write(emu, EMU_HANA_FPGA_CONFIG, 0);
-			snd_emu1010_fpga_read(emu, EMU_HANA_IRQ_STATUS, &reg);
+			snd_emu1010_fpga_read(emu, EMU_HANA_IRQ_STATUS, &tmp);
 			dev_info(emu->card->dev,
 				 "emu1010: EMU_HANA+DOCK_IRQ_STATUS = 0x%x\n",
-				 reg);
+				 tmp);
 			/* ID, should read & 0x7f = 0x55 when FPGA programmed. */
-			snd_emu1010_fpga_read(emu, EMU_HANA_ID, &reg);
+			snd_emu1010_fpga_read(emu, EMU_HANA_ID, &tmp);
 			dev_info(emu->card->dev,
-				 "emu1010: EMU_HANA+DOCK_ID = 0x%x\n", reg);
-			if ((reg & 0x1f) != 0x15) {
+				 "emu1010: EMU_HANA+DOCK_ID = 0x%x\n", tmp);
+			if ((tmp & 0x1f) != 0x15) {
 				/* FPGA failed to be programmed */
 				dev_info(emu->card->dev,
 					 "emu1010: Loading Audio Dock Firmware file failed, reg = 0x%x\n",
-					 reg);
+					 tmp);
 				continue;
 			}
 			dev_info(emu->card->dev,
-- 
2.10.2
