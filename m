From: bugtrack@alsa-project.org
Subject: [ALSA - tools 0001343]: bitops not 64bit clean
Date: Fri, 26 Aug 2005 14:42:44 +0200
Message-ID: <ad23d0cdd86a56c2aa486fb59a4801ae@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 676C21E4
	for <alsa-devel@alsa-project.org>; Fri, 26 Aug 2005 14:42:44 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1343> 
======================================================================
Reported By:                jdthood
Assigned To:                tiwai
======================================================================
Project:                    ALSA - tools
Issue ID:                   1343
Category:                   ld10k1
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     resolved
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             08-16-2005 20:49 CEST
Last Modified:              08-26-2005 14:42 CEST
======================================================================
Summary:                    bitops not 64bit clean
Description: 
Quoting Debian bug report #323331:

Package: ld10k1
Version: 1.0.9-1

On all 64bit systems (the easiest example is amd64) ld10k1 crashes on
use by lo10k1, some debugging tracked down the problem fairly quickly.

The bitops functions (set_bit and associated) that ld10k1 use come from
the linux kernel, and assume that longs are 32bit only, causing a buffer
overflow of the bit buffer.

The attached patch fixes the bitops to be independent of the size of
longs, and is confirmed to fix the bug on my box.

Zephaniah E. Hull.

diff -ur alsa-tools-1.0.9/ld10k1/src/bitops.h
alsa-tools-1.0.9.mine/ld10k1/src/bitops.h
--- alsa-tools-1.0.9/ld10k1/src/bitops.h	2005-03-18 08:41:02.000000000
-0500
+++ alsa-tools-1.0.9.mine/ld10k1/src/bitops.h	2005-08-15
23:24:46.000000000 -0400
@@ -15,13 +15,17 @@
  * 
  * C language equivalents written by Theodore Ts'o, 9/26/92
  */
+/*
+ * Converted to be independent of the size of longs.
+ * Zephaniah E. Hull 2005-08-15.
+ */
 
 __inline__ int set_bit(int nr, unsigned long * addr)
 {
 	int	mask, retval;
 
-	addr += nr >> 5;
-	mask = 1 << (nr & 0x1f);
+	addr += nr >> (sizeof(long) + 1);
+	mask = 1 << (nr & (sizeof(long) * 8 - 1));
 	retval = (mask & *addr) != 0;
 	*addr |= mask;
 	return retval;
@@ -31,8 +35,8 @@
 {
 	int	mask, retval;
 
-	addr += nr >> 5;
-	mask = 1 << (nr & 0x1f);
+	addr += nr >> (sizeof(long) + 1);
+	mask = 1 << (nr & (sizeof(long) * 8 - 1));
 	retval = (mask & *addr) != 0;
 	*addr &= ~mask;
 	return retval;
@@ -42,8 +46,8 @@
 {
 	int	mask;
 
-	addr += nr >> 5;
-	mask = 1 << (nr & 0x1f);
+	addr += nr >> (sizeof(long) + 1);
+	mask = 1 << (nr & (sizeof(long) * 8 - 1));
 	return ((mask & *addr) != 0);
 }

======================================================================

----------------------------------------------------------------------
 tiwai - 08-17-05 12:23 
----------------------------------------------------------------------
Could you upload the patch file to be applicable to CVS?

----------------------------------------------------------------------
 tiwai - 08-26-05 14:42 
----------------------------------------------------------------------
Already on CVS.  Thanks.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-16-05 20:49 jdthood        New Issue                                    
08-16-05 20:52 rlrevell       Note Added: 0005832                          
08-16-05 21:13 pzad           Note Added: 0005833                          
08-17-05 12:23 tiwai          Note Added: 0005836                          
08-17-05 12:37 jdthood        File Added: ld10k1.diff                      
08-26-05 14:42 tiwai          Status                   new => resolved     
08-26-05 14:42 tiwai          Resolution               open => fixed       
08-26-05 14:42 tiwai          Assigned To               => tiwai           
08-26-05 14:42 tiwai          Note Added: 0005947                          
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
