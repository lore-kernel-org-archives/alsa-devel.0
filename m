From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000460]: Oops on loading the es18xx module
Date: Wed,  1 Sep 2004 23:05:52 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040901210552.2714AE001@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 852672A5
	for <alsa-devel@alsa-project.org>; Wed,  1 Sep 2004 23:05:52 +0200 (MEST)
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


A BUGNOTE has been added to this bug.
======================================================================
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000460
======================================================================
Reported By:                twhitehead
Assigned To:                
======================================================================
Project:                    ALSA - driver
Bug ID:                     460
Category:                   ISA - es18xx
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     new
Distribution:               Debian SID
Kernel Version:             2.6.8.1 (from kernel.org)
======================================================================
Date Submitted:             08-21-2004 21:48 CEST
Last Modified:              09-01-2004 23:05 CEST
======================================================================
Summary:                    Oops on loading the es18xx module
Description: 
Loading the es18xx module immediately (and always) results in an "Unable to
handle kernel paging request at virtual address 00000000000000b0" message.
 The usage count then sticks at one and applications are not able to open
the device files.
======================================================================

----------------------------------------------------------------------
 tiwai - 09-01-2004 23:05 CEST 
----------------------------------------------------------------------
Tried 1.0.6a?  How about compiling with CONFIG_SND_DEBUG?

Bug History
Date Modified  Username       Field                    Change              
======================================================================
08-21-04 21:48 twhitehead     New Bug                                      
08-21-04 21:48 twhitehead     Distribution              => Debian SID      
08-21-04 21:48 twhitehead     Kernel Version            => 2.6.8.1 (from kernel.org)
08-21-04 21:51 twhitehead     Bug Monitored: twhitehead                    
09-01-04 23:05 tiwai          Bugnote Added: 0001679                       
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
