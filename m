From: Paul Bolle <pebolle@tiscali.nl>
Subject: [PATCH] sound: remove checks for CONFIG_BCM_CS4297A_CSWARM
Date: Thu, 29 May 2014 18:51:44 +0200
Message-ID: <1401382304.25908.5.camel@x220>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Checks for CONFIG_BCM_CS4297A_CSWARM were added in v2.6.11. The related
Kconfig symbol was never added so these checks always evaluated to true.
Remove them.

Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
---
Untested.

 sound/oss/swarm_cs4297a.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/sound/oss/swarm_cs4297a.c b/sound/oss/swarm_cs4297a.c
index f851fd0e199c..a33e8ce8085b 100644
--- a/sound/oss/swarm_cs4297a.c
+++ b/sound/oss/swarm_cs4297a.c
@@ -2625,15 +2625,12 @@ static int __init cs4297a_init(void)
 	u32 pwr, id;
 	mm_segment_t fs;
 	int rval;
-#ifndef CONFIG_BCM_CS4297A_CSWARM
 	u64 cfg;
 	int mdio_val;
-#endif
 
 	CS_DBGOUT(CS_INIT | CS_FUNCTION, 2, printk(KERN_INFO 
 		"cs4297a: cs4297a_init_module()+ \n"));
 
-#ifndef CONFIG_BCM_CS4297A_CSWARM
         mdio_val = __raw_readq(KSEG1 + A_MAC_REGISTER(2, R_MAC_MDIO)) &
                 (M_MAC_MDIO_DIR|M_MAC_MDIO_OUT);
 
@@ -2659,7 +2656,6 @@ static int __init cs4297a_init(void)
         __raw_writeq(mdio_val | M_MAC_GENC, KSEG1+A_MAC_REGISTER(2, R_MAC_MDIO));
         /* Give the codec some time to finish resetting (start the bit clock) */
         udelay(100);
-#endif
 
 	if (!(s = kzalloc(sizeof(struct cs4297a_state), GFP_KERNEL))) {
 		CS_DBGOUT(CS_ERROR, 1, printk(KERN_ERR
-- 
1.9.3
