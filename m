From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH] sc6000: enable joystick port
Date: Sun, 3 May 2009 10:39:19 +0200
Message-ID: <20090503103919.218e179e.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp239.poczta.interia.pl (smtp239.poczta.interia.pl
	[217.74.64.239]) by alsa0.perex.cz (Postfix) with ESMTP id 9C1E42469B
	for <alsa-devel@alsa-project.org>;
	Sun,  3 May 2009 10:34:45 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alsa-devel <alsa-devel@alsa-project.org>
Cc: Rene Herman <rene.herman@gmail.com>
List-Id: alsa-devel@alsa-project.org

From: Krzysztof Helt <krzysztof.h1@wp.pl>

Add module parameter to enable or disable
joystick port (gameport) on the SC6600 and
later cards.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
---

The second version of the patch with fixed
the bug spotted Takashi.


 Documentation/sound/alsa/ALSA-Configuration.txt |    4 +++-
 sound/isa/sc6000.c                              |    9 +++++++--
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/Documentation/sound/alsa/ALSA-Configuration.txt b/Documentation/sound/alsa/ALSA-Configuration.txt
index 012858d..11a80a9 100644
--- a/Documentation/sound/alsa/ALSA-Configuration.txt
+++ b/Documentation/sound/alsa/ALSA-Configuration.txt
@@ -1543,13 +1543,15 @@ Prior to version 0.9.0rc4 options had a 'snd_' prefix. This was removed.
   Module snd-sc6000
   -----------------
 
-    Module for Gallant SC-6000 soundcard.
+    Module for Gallant SC-6000 soundcard and later models: SC-6600
+    and SC-7000.
 
     port	- Port # (0x220 or 0x240)
     mss_port	- MSS Port # (0x530 or 0xe80)
     irq		- IRQ # (5,7,9,10,11)
     mpu_irq	- MPU-401 IRQ # (5,7,9,10) ,0 - no MPU-401 irq
     dma		- DMA # (1,3,0)
+    joystick	- Enable gameport - 0 = disable (default), 1 = enable
 
     This module supports multiple cards.
 
diff --git a/sound/isa/sc6000.c b/sound/isa/sc6000.c
index c803b2e..9a8bbf6 100644
--- a/sound/isa/sc6000.c
+++ b/sound/isa/sc6000.c
@@ -56,6 +56,7 @@ static long mpu_port[SNDRV_CARDS] = SNDRV_DEFAULT_PORT;
 						/* 0x300, 0x310, 0x320, 0x330 */
 static int mpu_irq[SNDRV_CARDS] = SNDRV_DEFAULT_IRQ;	/* 5, 7, 9, 10, 0 */
 static int dma[SNDRV_CARDS] = SNDRV_DEFAULT_DMA;	/* 0, 1, 3 */
+static bool joystick[SNDRV_CARDS] = { [0 ... (SNDRV_CARDS-1)] = false };
 
 module_param_array(index, int, NULL, 0444);
 MODULE_PARM_DESC(index, "Index value for sc-6000 based soundcard.");
@@ -75,6 +76,8 @@ module_param_array(mpu_irq, int, NULL, 0444);
 MODULE_PARM_DESC(mpu_irq, "MPU-401 IRQ # for sc-6000 driver.");
 module_param_array(dma, int, NULL, 0444);
 MODULE_PARM_DESC(dma, "DMA # for sc-6000 driver.");
+module_param_array(joystick, bool, NULL, 0444);
+MODULE_PARM_DESC(joystick, "Enable gameport.");
 
 /*
  * Commands of SC6000's DSP (SBPRO+special).
@@ -363,7 +366,7 @@ static int __devinit sc6000_init_mss(char __iomem *vport, int config,
 
 static void __devinit sc6000_hw_cfg_encode(char __iomem *vport, int *cfg,
 					   long xport, long xmpu,
-					   long xmss_port)
+					   long xmss_port, int joystick)
 {
 	cfg[0] = 0;
 	cfg[1] = 0;
@@ -376,6 +379,8 @@ static void __devinit sc6000_hw_cfg_encode(char __iomem *vport, int *cfg,
 	if (xmss_port == 0xe80)
 		cfg[0] |= 0x10;
 	cfg[0] |= 0x40;		/* always set */
+	if (!joystick)
+		cfg[0] |= 0x02;
 	cfg[1] |= 0x80;		/* enable WSS system */
 	cfg[1] &= ~0x40;	/* disable IDE */
 	snd_printd("hw cfg %x, %x\n", cfg[0], cfg[1]);
@@ -427,7 +432,7 @@ static int __devinit sc6000_init_board(char __iomem *vport,
 	if (!old) {
 		int cfg[2];
 		sc6000_hw_cfg_encode(vport, &cfg[0], port[dev], mpu_port[dev],
-				     mss_port[dev]);
+				     mss_port[dev], joystick[dev]);
 		if (sc6000_hw_cfg_write(vport, cfg) < 0) {
 			snd_printk(KERN_ERR "sc6000_hw_cfg_write: failed!\n");
 			return -EIO;
-- 
1.6.0.3


----------------------------------------------------------------------
Wygraj 3000 zl, wycieczke lub lot balonem!
Sprawdz >> http://link.interia.pl/f2154
