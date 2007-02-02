From: Liam Girdwood <liam.girdwood@wolfsonmicro.com>
Subject: [PATCH 10/19] ASoC 0.13 AT91xxxx DMA
Date: Fri, 02 Feb 2007 14:45:03 +0000
Message-ID: <1170427503.18082.140.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-iVbI6FXuJCXc/C2lUdK1"
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
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

--=-iVbI6FXuJCXc/C2lUdK1
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This patch updates the AT91xxxx audio DMA driver to the new API in ASoC
0.13.

Changes:-

o Updated to use new 0.13 data structures.

o Suspend and Resume now conditionally compiled.

o #include guard around at91-pcm.h header.

Signed-off-by: Frank Mandarino <fmandarino@endrelia.com>
Signed-off-by: Liam Girdwood <lg@opensource.wolfsonmicro.com>

Privacy & Confidentiality Notice
-------------------------------------------------
This message and any attachments contain privileged and confidential information that is intended solely for the person(s) to whom it is addressed. If you are not an intended recipient you must not: read; copy; distribute; discuss; take any action in or make any reliance upon the contents of this message; nor open or read any attachment. If you have received this message in error, please notify us as soon as possible on the following telephone number and destroy this message including any attachments. Thank you.
-------------------------------------------------
Wolfson Microelectronics plc
Tel: +44 (0)131 272 7000
Fax: +44 (0)131 272 7001
Web: www.wolfsonmicro.com

Registered in Scotland

Company number SC089839

Registered office: 

Westfield House, 26 Westfield Road, Edinburgh, EH11 2QB, UK


--=-iVbI6FXuJCXc/C2lUdK1
Content-Disposition: attachment; filename="asoc13-at91-pcm.patch"
Content-Type: text/x-patch; name="asoc13-at91-pcm.patch"; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -r fc216dd0eb92 soc/at91/at91-pcm.c
--- a/soc/at91/at91-pcm.c	Thu Feb 01 16:52:06 2007 +0100
+++ b/soc/at91/at91-pcm.c	Wed Jan 31 16:43:17 2007 +0000
@@ -125,7 +125,7 @@ static int at91_pcm_hw_params(struct snd
 	snd_pcm_set_runtime_buffer(substream, &substream->dma_buffer);
 	runtime->dma_bytes = params_buffer_bytes(params);
 
-	prtd->params = rtd->cpu_dai->dma_data;
+	prtd->params = rtd->dai->cpu_dai->dma_data;
 	prtd->params->dma_intr_handler = at91_pcm_dma_irq;
 
 	prtd->dma_buffer = runtime->dma_addr;
@@ -363,6 +363,7 @@ static void at91_pcm_free_dma_buffers(st
 	}
 }
 
+#ifdef CONFIG_PM
 static int at91_pcm_suspend(struct platform_device *pdev,
 	struct snd_soc_cpu_dai *dai)
 {
@@ -410,6 +411,10 @@ static int at91_pcm_resume(struct platfo
 	at91_ssc_write(params->ssc_base + AT91_PDC_PTCR, params->mask->pdc_enable);
 	return 0;
 }
+#else
+#define at91_pcm_suspend	NULL
+#define at91_pcm_resume		NULL
+#endif
 
 struct snd_soc_platform at91_soc_platform = {
 	.name		= "at91-audio",
diff -r fc216dd0eb92 soc/at91/at91-pcm.h
--- a/soc/at91/at91-pcm.h	Thu Feb 01 16:52:06 2007 +0100
+++ b/soc/at91/at91-pcm.h	Wed Jan 31 16:43:17 2007 +0000
@@ -16,13 +16,15 @@
  * published by the Free Software Foundation.
  */
 
+#ifndef _AT91_PCM_H
+#define _AT91_PCM_H
+
 #include <asm/arch/hardware.h>
 
 struct at91_ssc_periph {
 	void __iomem	*base;
 	u32		pid;
 };
-
 
 /*
  * Registers and status bits that are required by the PCM driver.
@@ -44,7 +46,6 @@ struct at91_ssc_mask {
 	u32	pdc_disable;		/* PDC recv/trans disable */
 };
 
-
 /*
  * This structure, shared between the PCM driver and the interface,
  * contains all information required by the PCM driver to perform the
@@ -63,9 +64,9 @@ struct at91_pcm_dma_params {
 	void (*dma_intr_handler)(u32, struct snd_pcm_substream *);
 };
 
-extern struct snd_soc_cpu_dai at91_i2s_dai[3];
 extern struct snd_soc_platform at91_soc_platform;
-
 
 #define at91_ssc_read(a)	((unsigned long) __raw_readl(a))
 #define at91_ssc_write(a,v)	__raw_writel((v),(a))
+
+#endif /* _AT91_PCM_H */

--=-iVbI6FXuJCXc/C2lUdK1
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--=-iVbI6FXuJCXc/C2lUdK1
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--=-iVbI6FXuJCXc/C2lUdK1--
