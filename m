From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002046]: Driver build fails due to bug in kernel include/asm/dma-mapping.h file.
Date: Mon, 24 Apr 2006 11:14:02 +0200
Message-ID: <1f834d4d9b2c5049639b61e99c4ffe39@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id D74EE197
	for <alsa-devel@alsa-project.org>; Mon, 24 Apr 2006 11:14:02 +0200 (MEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


The following issue has been RESOLVED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2046> 
======================================================================
Reported By:                GrueMaster
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   2046
Category:                   0_compilation problem_!!!
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     resolved
Distribution:               Novell Linux Desktop 9 Service pack 3
Kernel Version:             2.6.5-7.244 & 2.6.5 stock kernels
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             04-20-2006 23:53 CEST
Last Modified:              04-24-2006 11:14 CEST
======================================================================
Summary:                    Driver build fails due to bug in kernel
include/asm/dma-mapping.h file.
Description: 
Compile fails at acore/sgbuf.c.  Multiple define errors in
include/asm/dma-mapping.h file.  This has also been reproduced againast a
clean 2.6.5 kernel from kernel.org.


======================================================================

----------------------------------------------------------------------
 GrueMaster - 04-21-06 22:57 
----------------------------------------------------------------------
I modified your patch to add include/linux/mm.h (needed by both Novell &
stock kernels) and DMA_32BIT_MASK (needed for stock kernel to build
pci/ad1889.c).  Here's my version of your patch:

--- alsa-driver-1.0.11.orig/include/adriver.h   2006-04-18
23:24:30.000000000 -0700
+++ alsa-driver-1.0.11/include/adriver.h        2006-04-21
10:37:53.559693432 -0700
@@ -750,7 +750,15 @@
 #endif

 #if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 17)
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 6)
+#include <asm/io.h>
+#include <asm/scatterlist.h>
+#include <linux/mm.h>
+#endif
 #include <linux/dma-mapping.h>
+#ifndef DMA_32BIT_MASK
+#define DMA_32BIT_MASK  0x00000000ffffffffULL
+#endif
 #ifndef DMA_31BIT_MASK
 #define DMA_31BIT_MASK 0x000000007fffffffULL
 #endif
@@ -1175,3 +1183,4 @@
 #define OPL3_HW_OPL3_PC98      0x0305  /* PC9800 */

 #endif /* __SOUND_LOCAL_DRIVER_H */
+

This has been tested on Novell Linux Desktop 9 with Service Pack 3 kernel
& the stock 2.6.5 kernel from kernel.org.



----------------------------------------------------------------------
 tiwai - 04-24-06 11:14 
----------------------------------------------------------------------
Already fixed.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-20-06 23:53 GrueMaster     New Issue                                    
04-20-06 23:53 GrueMaster     Distribution              => Novell Linux Desktop
9 Service pack 3
04-21-06 12:42 tiwai          Status                   assigned => resolved
04-21-06 12:42 tiwai          Resolution               open => fixed       
04-21-06 12:42 tiwai          Note Added: 0009409                          
04-21-06 22:47 GrueMaster     Kernel Version            => 2.6.5-7.244 & 2.6.5
stock kernels
04-21-06 22:47 GrueMaster     Status                   resolved => feedback
04-21-06 22:47 GrueMaster     Resolution               fixed => reopened   
04-21-06 22:47 GrueMaster     Note Added: 0009431                          
04-21-06 22:47 GrueMaster     Issue Monitored: GrueMaster                    
04-21-06 22:57 GrueMaster     Note Edited: 0009431                         
04-24-06 11:14 tiwai          Status                   feedback => resolved
04-24-06 11:14 tiwai          Resolution               reopened => fixed   
04-24-06 11:14 tiwai          Note Added: 0009449                          
======================================================================




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
