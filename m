From: "Patrik Sevallius" <patrik.sevallius@enea.com>
Subject: [PATCH] soc at91 minor bug fixes
Date: Thu, 8 May 2008 08:22:48 +0200
Message-ID: <DC6F86A94046A64094043D44A3A708F7A8DFE1@sestoex02.enea.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx-1.enea.se (mx-1.enea.se [192.36.1.70])
	by alsa0.perex.cz (Postfix) with ESMTP id B8A622469C
	for <alsa-devel@alsa-project.org>;
	Thu,  8 May 2008 08:24:40 +0200 (CEST)
Content-class: urn:content-classes:message
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Frank Mandarino <fmandarino@endrelia.com>
List-Id: alsa-devel@alsa-project.org


Found these two bugs while browsing through the code.
The first one is a cut-n-paste bug, instead of disabling the clock when request_irq()
fails, it enabled it once more.
The second one fixes a debug printout, AT91_SSC_IER is write only, AT91_SSC_IMR is 
readable (the printed string actually says imr).

Frank Mandarino was busy so he asked me to send these to this list.

/Patrik


Signed-off-by: Patrik Sevallius <patrik.sevallius@enea.com>
Signed-off-by: Frank Mandarino <fmandarino@endrelia.com>

================================================================================
--- sound/soc/at91/at91-ssc.c.orig	2008-05-07 09:33:49.000000000 +0200
+++ sound/soc/at91/at91-ssc.c	2008-05-07 09:34:18.000000000 +0200
@@ -590,7 +590,7 @@
 			printk(KERN_WARNING "at91-ssc: request_irq failure\n");
 
 			DBG("Stopping pid %d clock\n", ssc_p->ssc.pid);
-			at91_sys_write(AT91_PMC_PCER, 1<<ssc_p->ssc.pid);
+			at91_sys_write(AT91_PMC_PCDR, 1<<ssc_p->ssc.pid);
 			return ret;
 		}
 

--- sound/soc/at91/at91-pcm.c.orig	2008-05-07 13:23:12.000000000 +0200
+++ sound/soc/at91/at91-pcm.c	2008-05-07 13:26:40.000000000 +0200
@@ -194,7 +194,7 @@
 		at91_ssc_write(params->ssc_base + ATMEL_PDC_PTCR, params->mask->pdc_enable);
 
 		DBG("sr=%lx imr=%lx\n", at91_ssc_read(params->ssc_base + AT91_SSC_SR),
-					at91_ssc_read(params->ssc_base + AT91_SSC_IER));
+					at91_ssc_read(params->ssc_base + AT91_SSC_IMR));
 		break;
 
 	case SNDRV_PCM_TRIGGER_STOP:
