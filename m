From: Frank Mandarino <fmandarino@endrelia.com>
Subject: [PATCH] Change AT91 PDC register defines for 2.6.20
	kernel
Date: Fri, 09 Feb 2007 13:56:10 -0500
Message-ID: <45CCC3CA.1070908@endrelia.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------040102090703020109050201"
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------040102090703020109050201
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

This patch updates the PDC register names to match the new names defined
in Linux 2.6.20.

Regards,
../fam
-- 
Frank Mandarino                                fmandarino(a)endrelia.com
Endrelia Technologies Inc.
Toronto, Ontario, Canada


--------------040102090703020109050201
Content-Type: text/x-patch;
 name="asoc-at91-pdc-rename.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="asoc-at91-pdc-rename.patch"

# HG changeset patch
# User fam@procyon
# Date 1171046347 18000
# Node ID e140689f3d0697b6f0079a9e254b206dc738df01
# Parent  fe5e7971121276ab2680b46e3904e88ca4eae046
Use the new PDC register name defines that were updated
in Linux 2.6.20.

Signed-off-by: Frank Mandarino <fmandarino@endrelia.com>
Signed-off-by: Liam Girdwood <lg@opensource.wolfsonmicro.com>

diff -r fe5e79711212 -r e140689f3d06 soc/at91/at91-i2s.c
--- a/soc/at91/at91-i2s.c	Fri Feb 09 12:54:44 2007 +0100
+++ b/soc/at91/at91-i2s.c	Fri Feb 09 13:39:07 2007 -0500
@@ -20,6 +20,8 @@
 #include <linux/device.h>
 #include <linux/delay.h>
 #include <linux/clk.h>
+#include <linux/atmel_pdc.h>
+
 #include <sound/driver.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
@@ -29,7 +31,6 @@
 #include <asm/arch/hardware.h>
 #include <asm/arch/at91_pmc.h>
 #include <asm/arch/at91_ssc.h>
-#include <asm/arch/at91_pdc.h>
 
 #include "at91-pcm.h"
 #include "at91-i2s.h"
@@ -51,17 +52,17 @@
  * SSC PDC registers required by the PCM DMA engine.
  */
 static struct at91_pdc_regs pdc_tx_reg = {
-	.xpr		= AT91_PDC_TPR,
-	.xcr		= AT91_PDC_TCR,
-	.xnpr		= AT91_PDC_TNPR,
-	.xncr		= AT91_PDC_TNCR,
+	.xpr		= ATMEL_PDC_TPR,
+	.xcr		= ATMEL_PDC_TCR,
+	.xnpr		= ATMEL_PDC_TNPR,
+	.xncr		= ATMEL_PDC_TNCR,
 };
 
 static struct at91_pdc_regs pdc_rx_reg = {
-	.xpr		= AT91_PDC_RPR,
-	.xcr		= AT91_PDC_RCR,
-	.xnpr		= AT91_PDC_RNPR,
-	.xncr		= AT91_PDC_RNCR,
+	.xpr		= ATMEL_PDC_RPR,
+	.xcr		= ATMEL_PDC_RCR,
+	.xnpr		= ATMEL_PDC_RNPR,
+	.xncr		= ATMEL_PDC_RNCR,
 };
 
 /*
@@ -72,8 +73,8 @@ static struct at91_ssc_mask ssc_tx_mask 
 	.ssc_disable	= AT91_SSC_TXDIS,
 	.ssc_endx	= AT91_SSC_ENDTX,
 	.ssc_endbuf	= AT91_SSC_TXBUFE,
-	.pdc_enable	= AT91_PDC_TXTEN,
-	.pdc_disable	= AT91_PDC_TXTDIS,
+	.pdc_enable	= ATMEL_PDC_TXTEN,
+	.pdc_disable	= ATMEL_PDC_TXTDIS,
 };
 
 static struct at91_ssc_mask ssc_rx_mask = {
@@ -81,8 +82,8 @@ static struct at91_ssc_mask ssc_rx_mask 
 	.ssc_disable	= AT91_SSC_RXDIS,
 	.ssc_endx	= AT91_SSC_ENDRX,
 	.ssc_endbuf	= AT91_SSC_RXBUFF,
-	.pdc_enable	= AT91_PDC_RXTEN,
-	.pdc_disable	= AT91_PDC_RXTDIS,
+	.pdc_enable	= ATMEL_PDC_RXTEN,
+	.pdc_disable	= ATMEL_PDC_RXTDIS,
 };
 
 
@@ -508,14 +509,14 @@ static int at91_i2s_hw_params(struct snd
 		/* Reset the SSC and its PDC registers */
 		at91_ssc_write(ssc_p->ssc.base + AT91_SSC_CR, AT91_SSC_SWRST);
 
-		at91_ssc_write(ssc_p->ssc.base + AT91_PDC_RPR, 0);
-		at91_ssc_write(ssc_p->ssc.base + AT91_PDC_RCR, 0);
-		at91_ssc_write(ssc_p->ssc.base + AT91_PDC_RNPR, 0);
-		at91_ssc_write(ssc_p->ssc.base + AT91_PDC_RNCR, 0);
-		at91_ssc_write(ssc_p->ssc.base + AT91_PDC_TPR, 0);
-		at91_ssc_write(ssc_p->ssc.base + AT91_PDC_TCR, 0);
-		at91_ssc_write(ssc_p->ssc.base + AT91_PDC_TNPR, 0);
-		at91_ssc_write(ssc_p->ssc.base + AT91_PDC_TNCR, 0);
+		at91_ssc_write(ssc_p->ssc.base + ATMEL_PDC_RPR, 0);
+		at91_ssc_write(ssc_p->ssc.base + ATMEL_PDC_RCR, 0);
+		at91_ssc_write(ssc_p->ssc.base + ATMEL_PDC_RNPR, 0);
+		at91_ssc_write(ssc_p->ssc.base + ATMEL_PDC_RNCR, 0);
+		at91_ssc_write(ssc_p->ssc.base + ATMEL_PDC_TPR, 0);
+		at91_ssc_write(ssc_p->ssc.base + ATMEL_PDC_TCR, 0);
+		at91_ssc_write(ssc_p->ssc.base + ATMEL_PDC_TNPR, 0);
+		at91_ssc_write(ssc_p->ssc.base + ATMEL_PDC_TNCR, 0);
 
 		if ((ret = request_irq(ssc_p->ssc.pid, at91_i2s_interrupt,
 					0, ssc_p->name, ssc_p)) < 0) {
diff -r fe5e79711212 -r e140689f3d06 soc/at91/at91-pcm.c
--- a/soc/at91/at91-pcm.c	Fri Feb 09 12:54:44 2007 +0100
+++ b/soc/at91/at91-pcm.c	Fri Feb 09 13:39:07 2007 -0500
@@ -21,6 +21,7 @@
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/dma-mapping.h>
+#include <linux/atmel_pdc.h>
 
 #include <sound/driver.h>
 #include <sound/core.h>
@@ -30,7 +31,6 @@
 
 #include <asm/arch/hardware.h>
 #include <asm/arch/at91_ssc.h>
-#include <asm/arch/at91_pdc.h>
 
 #include "at91-pcm.h"
 
@@ -83,7 +83,7 @@ static void at91_pcm_dma_irq(u32 ssc_sr,
 			params->name, ssc_sr, count);
 
 		/* re-start the PDC */
-		at91_ssc_write(params->ssc_base + AT91_PDC_PTCR, params->mask->pdc_disable);
+		at91_ssc_write(params->ssc_base + ATMEL_PDC_PTCR, params->mask->pdc_disable);
 
 		prtd->period_ptr += prtd->period_size;
 		if (prtd->period_ptr >= prtd->dma_buffer_end) {
@@ -94,7 +94,7 @@ static void at91_pcm_dma_irq(u32 ssc_sr,
 		at91_ssc_write(params->ssc_base + params->pdc->xcr,
 				prtd->period_size / params->pdc_xfer_size);
 
-		at91_ssc_write(params->ssc_base + AT91_PDC_PTCR, params->mask->pdc_enable);
+		at91_ssc_write(params->ssc_base + ATMEL_PDC_PTCR, params->mask->pdc_enable);
 	}
 
 	if (ssc_sr & params->mask->ssc_endx) {
@@ -143,7 +143,7 @@ static int at91_pcm_hw_free(struct snd_p
 	struct at91_pcm_dma_params *params = prtd->params;
 
 	if (params != NULL) {
-		at91_ssc_write(params->ssc_base + AT91_PDC_PTCR, params->mask->pdc_disable);
+		at91_ssc_write(params->ssc_base + ATMEL_PDC_PTCR, params->mask->pdc_disable);
 		prtd->params->dma_intr_handler = NULL;
 	}
 
@@ -158,7 +158,7 @@ static int at91_pcm_prepare(struct snd_p
 	at91_ssc_write(params->ssc_base + AT91_SSC_IDR,
 			params->mask->ssc_endx | params->mask->ssc_endbuf);
 
-	at91_ssc_write(params->ssc_base + AT91_PDC_PTCR, params->mask->pdc_disable);
+	at91_ssc_write(params->ssc_base + ATMEL_PDC_PTCR, params->mask->pdc_disable);
 	return 0;
 }
 
@@ -192,7 +192,7 @@ static int at91_pcm_trigger(struct snd_p
 		at91_ssc_write(params->ssc_base + AT91_SSC_IER,
 			params->mask->ssc_endx | params->mask->ssc_endbuf);
 
-		at91_ssc_write(params->ssc_base + AT91_PDC_PTCR, params->mask->pdc_enable);
+		at91_ssc_write(params->ssc_base + ATMEL_PDC_PTCR, params->mask->pdc_enable);
 
 		DBG("sr=%lx imr=%lx\n", at91_ssc_read(params->ssc_base + AT91_SSC_SR),
 					at91_ssc_read(params->ssc_base + AT91_SSC_IER));
@@ -201,12 +201,12 @@ static int at91_pcm_trigger(struct snd_p
 	case SNDRV_PCM_TRIGGER_STOP:
 	case SNDRV_PCM_TRIGGER_SUSPEND:
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
-		at91_ssc_write(params->ssc_base + AT91_PDC_PTCR, params->mask->pdc_disable);
+		at91_ssc_write(params->ssc_base + ATMEL_PDC_PTCR, params->mask->pdc_disable);
 		break;
 
 	case SNDRV_PCM_TRIGGER_RESUME:
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
-		at91_ssc_write(params->ssc_base + AT91_PDC_PTCR, params->mask->pdc_enable);
+		at91_ssc_write(params->ssc_base + ATMEL_PDC_PTCR, params->mask->pdc_enable);
 		break;
 
 	default:
@@ -379,7 +379,7 @@ static int at91_pcm_suspend(struct platf
 
 	/* disable the PDC and save the PDC registers */
 
-	at91_ssc_write(params->ssc_base + AT91_PDC_PTCR, params->mask->pdc_disable);
+	at91_ssc_write(params->ssc_base + ATMEL_PDC_PTCR, params->mask->pdc_disable);
 
 	prtd->pdc_xpr_save  = at91_ssc_read(params->ssc_base + params->pdc->xpr);
 	prtd->pdc_xcr_save  = at91_ssc_read(params->ssc_base + params->pdc->xcr);
@@ -408,7 +408,7 @@ static int at91_pcm_resume(struct platfo
 	at91_ssc_write(params->ssc_base + params->pdc->xnpr, prtd->pdc_xnpr_save);
 	at91_ssc_write(params->ssc_base + params->pdc->xncr, prtd->pdc_xncr_save);
 
-	at91_ssc_write(params->ssc_base + AT91_PDC_PTCR, params->mask->pdc_enable);
+	at91_ssc_write(params->ssc_base + ATMEL_PDC_PTCR, params->mask->pdc_enable);
 	return 0;
 }
 #else


--------------040102090703020109050201
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--------------040102090703020109050201
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--------------040102090703020109050201--
