From: noreply@alsa-project.org
Subject: [ALSA - driver 0000356]: sound/pci/via82xx.c:737: invalid via82xx_cur_ptr, using last valid pointer
Date: Fri, 16 Jul 2004 12:18:35 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040716101835.99BC926008@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id E1CC325B
	for <alsa-devel@alsa-project.org>; Fri, 16 Jul 2004 12:18:35 +0200 (MEST)
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


The following bug has been RESOLVED.
======================================================================
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000356
======================================================================
Reported By:                coderock
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Bug ID:                     356
Category:                   PCI - via82xx
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     resolved
Distribution:               
Kernel Version:             2.6.7
Resolution:                 not a bug
======================================================================
Date Submitted:             06-30-2004 21:21 CEST
Last Modified:              07-16-2004 12:18 CEST
======================================================================
Summary:                    sound/pci/via82xx.c:737: invalid via82xx_cur_ptr, using last valid pointer
Description: 
I'm getting flooded by these (sound works fine):
Jun 30 20:45:30 nd47 kernel: fail: idx = 46/64, lastpos = 0xbb00, bufsize2
= 0x8000, offsize = 0xb800, size = 0x400, count = 0x120
Jun 30 20:45:30 nd47 kernel: ALSA sound/pci/via82xx.c:737: invalid
via82xx_cur_ptr, using last valid pointer
======================================================================

----------------------------------------------------------------------
 tiwai - 07-16-2004 12:18 CEST 
----------------------------------------------------------------------
It's just a warning message that the hardware reports an invalid
DMA pointer.  Appears only when you compile with the debug option.

Usually harmless.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
06-30-04 21:21 coderock       New Bug                                      
06-30-04 21:21 coderock       Kernel Version            => 2.6.7           
07-16-04 12:18 tiwai          Bugnote Added: 0001449                       
07-16-04 12:18 tiwai          Assigned To               => tiwai           
07-16-04 12:18 tiwai          Resolution               open => not a bug   
07-16-04 12:18 tiwai          Status                   new => resolved     
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
