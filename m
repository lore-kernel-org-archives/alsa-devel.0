From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000356]: sound/pci/via82xx.c:737: invalid via82xx_cur_ptr, using last valid pointer
Date: Fri, 24 Sep 2004 13:32:44 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040924113244.5932B101DB@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 501B41B4
	for <alsa-devel@alsa-project.org>; Fri, 24 Sep 2004 13:33:36 +0200 (MEST)
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


The following bug has been CLOSED
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
Status:                     closed
Distribution:               
Kernel Version:             2.6.7
======================================================================
Date Submitted:             06-30-2004 21:21 CEST
Last Modified:              09-24-2004 13:32 CEST
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
09-24-04 13:32 tiwai          Status                   resolved => closed  
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
