From: Paul Davis <pbd@op.net>
Subject: minor hdsp patch
Date: Mon, 13 May 2002 21:52:39 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200205140152.g4E1qd200616@op.net>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from newmx1.fast.net (newmx1.fast.net [209.92.1.31])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id DAA17800
	for <alsa-devel@alsa-project.org>; Tue, 14 May 2002 03:51:31 +0200
Received: from unknown (HELO op.net) ([209.92.100.30]) (envelope-sender <pbd@op.net>)
          by newmx1.fast.net (qmail-ldap-1.03) with SMTP
          for <alsa-devel@alsa-project.org>; 14 May 2002 01:51:28 -0000
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This corrects the inclusion of a standard include file and a printf
format directive.

Index: hdsp.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/rme9652/hdsp.c,v
retrieving revision 1.1
diff -u -u -r1.1 hdsp.c
--- hdsp.c      13 May 2002 09:28:33 -0000      1.1
+++ hdsp.c      14 May 2002 01:50:27 -0000
@@ -21,7 +21,7 @@
 
 #include <sound/driver.h>
 #include <asm/io.h>
-#include <byteswap.h>
+#include <asm/byteorder.h>
 #include <linux/delay.h>
 #include <linux/init.h>
 #include <linux/slab.h>
@@ -549,7 +549,7 @@
        case HDSP_spdifFrequency88_2KHz: return 88200;
        case HDSP_spdifFrequency96KHz: return 96000;
        default:
-               snd_printk ("unknown frequency status; bits = 0x%d, status = 0x%x", rate_bits, status);
+               snd_printk ("unknown frequency status; bits = 0x%x, status = 0x%x", rate_bits, status);
                return 0;
        }
 }

_______________________________________________________________

Have big pipes? SourceForge.net is looking for download mirrors. We supply
the hardware. You get the recognition. Email Us: bandwidth@sourceforge.net
