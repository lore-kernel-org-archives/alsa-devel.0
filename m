From: Ian Campbell <icampbell@arcom.com>
Subject: [PXA2XX] make pxa2xx audio driver sparse clean
Date: Wed, 26 Oct 2005 15:00:27 +0100
Message-ID: <1130335228.5700.13.camel@icampbell-debian>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from webapps.arcom.com (webapps.arcom.com [194.200.159.168])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 08101165
	for <alsa-devel@alsa-project.org>; Wed, 26 Oct 2005 16:00:36 +0200 (MEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Nicolas Pitre <nico@cam.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

Sparse complains because the PXA255 registers are defined as volatile
unsigned long * (through the __REGS macro in
include/asm-arm/arch-pxa/hardware.h) and the variable being assigned to
a u32 (and hence an unsigned int).

Perhaps sparse is being over-zealous but it is simple enough to put
right.

Killed a tiny bit of trailing whitespace too.

Signed-off-by: Ian Campbell <icampbell@arcom.com>

Index: 2.6/sound/arm/pxa2xx-ac97.c
===================================================================
--- 2.6.orig/sound/arm/pxa2xx-ac97.c	2005-10-26 13:57:42.000000000 +0100
+++ 2.6/sound/arm/pxa2xx-ac97.c	2005-10-26 13:57:44.000000000 +0100
@@ -43,7 +43,7 @@
 static unsigned short pxa2xx_ac97_read(ac97_t *ac97, unsigned short reg)
 {
 	unsigned short val = -1;
-	volatile u32 *reg_addr;
+	volatile unsigned long *reg_addr;
 
 	down(&car_mutex);
 	if (CAR & CAR_CAIP) {
@@ -70,7 +70,7 @@
 
 	/* valid data now */
 	gsr_bits = 0;
-	val = *reg_addr;			
+	val = *reg_addr;
 	/* but we've just started another cycle... */
 	wait_event_timeout(gsr_wq, gsr_bits & GSR_SDONE, 1);
 
@@ -80,7 +80,7 @@
 
 static void pxa2xx_ac97_write(ac97_t *ac97, unsigned short reg, unsigned short val)
 {
-	volatile u32 *reg_addr;
+	volatile unsigned long *reg_addr;
 
 	down(&car_mutex);
 
Index: 2.6/sound/arm/pxa2xx-pcm.h
===================================================================
--- 2.6.orig/sound/arm/pxa2xx-pcm.h	2005-10-26 13:57:42.000000000 +0100
+++ 2.6/sound/arm/pxa2xx-pcm.h	2005-10-26 13:57:44.000000000 +0100
@@ -13,10 +13,10 @@
 typedef struct {
 	char *name;			/* stream identifier */
 	u32 dcmd;			/* DMA descriptor dcmd field */
-	volatile u32 *drcmr;		/* the DMA request channel to use */
+	volatile unsigned long *drcmr;	/* the DMA request channel to use */
 	u32 dev_addr;			/* device physical address for DMA */
 } pxa2xx_pcm_dma_params_t;
-	
+
 typedef struct {
 	pxa2xx_pcm_dma_params_t *playback_params;
 	pxa2xx_pcm_dma_params_t *capture_params;

-- 
Ian Campbell, Senior Design Engineer
                                        Web: http://www.arcom.com
Arcom, Clifton Road, 			Direct: +44 (0)1223 403 465
Cambridge CB1 7EA, United Kingdom	Phone:  +44 (0)1223 411 200



-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
