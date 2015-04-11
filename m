From: Michael Gernoth <michael@gernoth.net>
Subject: [PATCH] ALSA: emu10k1: handle dock disconnects
Date: Sat, 11 Apr 2015 14:34:44 +0200
Message-ID: <20150411123444.GA15194@zerfleddert.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eddie.zerfleddert.de (eddie.zerfleddert.de [188.246.9.226])
 by alsa0.perex.cz (Postfix) with ESMTP id 5B6FF2608AB
 for <alsa-devel@alsa-project.org>; Sat, 11 Apr 2015 14:34:45 +0200 (CEST)
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

When the dock on an E-mu 1010 card is disconnected, all outputs get
muted by the hardware. Add logic to detect a disconnect and unmute.

Signed-off-by: Michael Gernoth <michael@gernoth.net>
---
 sound/pci/emu10k1/emu10k1_main.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/sound/pci/emu10k1/emu10k1_main.c b/sound/pci/emu10k1/emu10k1_main.c
index b4458a6..ee50c1d 100644
--- a/sound/pci/emu10k1/emu10k1_main.c
+++ b/sound/pci/emu10k1/emu10k1_main.c
@@ -707,6 +707,7 @@ static int emu1010_firmware_thread(void *data)
 {
 	struct snd_emu10k1 *emu = data;
 	u32 tmp, tmp2, reg;
+	u32 last_reg = 0;
 	int err;
 
 	for (;;) {
@@ -782,7 +783,15 @@ static int emu1010_firmware_thread(void *data)
 			msleep(10);
 			/* Unmute all. Default is muted after a firmware load */
 			snd_emu1010_fpga_write(emu, EMU_HANA_UNMUTE, EMU_UNMUTE);
+		} else if (!reg && last_reg) {
+			/* Audio Dock removed */
+			dev_info(emu->card->dev,
+				 "emu1010: Audio Dock detached\n");
+			/* Unmute all */
+			snd_emu1010_fpga_write(emu, EMU_HANA_UNMUTE, EMU_UNMUTE);
 		}
+
+		last_reg = reg;
 	}
 	dev_info(emu->card->dev, "emu1010: firmware thread stopping\n");
 	return 0;
-- 
2.1.4
