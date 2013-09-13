From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 1/1] ALSA: au88x0: Remove redundant break
Date: Fri, 13 Sep 2013 16:03:15 +0530
Message-ID: <1379068395-9298-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f173.google.com (mail-pd0-f173.google.com
 [209.85.192.173])
 by alsa0.perex.cz (Postfix) with ESMTP id F343F2610D2
 for <alsa-devel@alsa-project.org>; Fri, 13 Sep 2013 12:51:26 +0200 (CEST)
Received: by mail-pd0-f173.google.com with SMTP id p10so1095885pdj.4
 for <alsa-devel@alsa-project.org>; Fri, 13 Sep 2013 03:51:26 -0700 (PDT)
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
Cc: tiwai@suse.de, sachin.kamat@linaro.org, nickolai@csail.mit.edu
List-Id: alsa-devel@alsa-project.org

'break' after a return statement is redundant. Remove it.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 sound/pci/au88x0/au88x0_synth.c |   29 ++++++++++-------------------
 1 file changed, 10 insertions(+), 19 deletions(-)

diff --git a/sound/pci/au88x0/au88x0_synth.c b/sound/pci/au88x0/au88x0_synth.c
index 8bef473..922a84b 100644
--- a/sound/pci/au88x0/au88x0_synth.c
+++ b/sound/pci/au88x0/au88x0_synth.c
@@ -219,7 +219,6 @@ vortex_wt_SetReg(vortex_t * vortex, unsigned char reg, int wt,
 		*/
 		hwwrite(vortex->mmio, WT_RUN(wt), val);
 		return 0xc;
-		break;
 	case 1:		/* param 0 */
 		/*
 		printk(KERN_DEBUG "vortex: WT SetReg(0x%x) = 0x%08x\n",
@@ -227,7 +226,6 @@ vortex_wt_SetReg(vortex_t * vortex, unsigned char reg, int wt,
 		*/
 		hwwrite(vortex->mmio, WT_PARM(wt, 0), val);
 		return 0xc;
-		break;
 	case 2:		/* param 1 */
 		/*
 		printk(KERN_DEBUG "vortex: WT SetReg(0x%x) = 0x%08x\n",
@@ -235,7 +233,6 @@ vortex_wt_SetReg(vortex_t * vortex, unsigned char reg, int wt,
 		*/
 		hwwrite(vortex->mmio, WT_PARM(wt, 1), val);
 		return 0xc;
-		break;
 	case 3:		/* param 2 */
 		/*
 		printk(KERN_DEBUG "vortex: WT SetReg(0x%x) = 0x%08x\n",
@@ -243,7 +240,6 @@ vortex_wt_SetReg(vortex_t * vortex, unsigned char reg, int wt,
 		*/
 		hwwrite(vortex->mmio, WT_PARM(wt, 2), val);
 		return 0xc;
-		break;
 	case 4:		/* param 3 */
 		/*
 		printk(KERN_DEBUG "vortex: WT SetReg(0x%x) = 0x%08x\n",
@@ -251,7 +247,6 @@ vortex_wt_SetReg(vortex_t * vortex, unsigned char reg, int wt,
 		*/
 		hwwrite(vortex->mmio, WT_PARM(wt, 3), val);
 		return 0xc;
-		break;
 	case 6:		/* mute */
 		/*
 		printk(KERN_DEBUG "vortex: WT SetReg(0x%x) = 0x%08x\n",
@@ -259,20 +254,17 @@ vortex_wt_SetReg(vortex_t * vortex, unsigned char reg, int wt,
 		*/
 		hwwrite(vortex->mmio, WT_MUTE(wt), val);
 		return 0xc;
-		break;
 	case 0xb:
-		{		/* delay */
-			/*
-			printk(KERN_DEBUG "vortex: WT SetReg(0x%x) = 0x%08x\n",
-			       WT_DELAY(wt,0), (int)val);
-			*/
-			hwwrite(vortex->mmio, WT_DELAY(wt, 3), val);
-			hwwrite(vortex->mmio, WT_DELAY(wt, 2), val);
-			hwwrite(vortex->mmio, WT_DELAY(wt, 1), val);
-			hwwrite(vortex->mmio, WT_DELAY(wt, 0), val);
-			return 0xc;
-		}
-		break;
+			/* delay */
+		/*
+		printk(KERN_DEBUG "vortex: WT SetReg(0x%x) = 0x%08x\n",
+		       WT_DELAY(wt,0), (int)val);
+		*/
+		hwwrite(vortex->mmio, WT_DELAY(wt, 3), val);
+		hwwrite(vortex->mmio, WT_DELAY(wt, 2), val);
+		hwwrite(vortex->mmio, WT_DELAY(wt, 1), val);
+		hwwrite(vortex->mmio, WT_DELAY(wt, 0), val);
+		return 0xc;
 		/* Global WT block parameters */
 	case 5:		/* sramp */
 		ecx = WT_SRAMP(wt);
@@ -291,7 +283,6 @@ vortex_wt_SetReg(vortex_t * vortex, unsigned char reg, int wt,
 		break;
 	default:
 		return 0;
-		break;
 	}
 	/*
 	printk(KERN_DEBUG "vortex: WT SetReg(0x%x) = 0x%08x\n", ecx, (int)val);
-- 
1.7.9.5
