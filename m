From: noreply@alsa-project.org
Subject: [ALSA - driver 0000122]: ticks, mmap problems, and lost interrupts
Date: Fri, 16 Jul 2004 14:28:32 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040716122832.0C4B32C005@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 77F43244
	for <alsa-devel@alsa-project.org>; Fri, 16 Jul 2004 14:28:32 +0200 (MEST)
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
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000122
======================================================================
Reported By:                tcfelker
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Bug ID:                     122
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     closed
Distribution:               Gentoo
Kernel Version:             2.6.3
======================================================================
Date Submitted:             03-07-2004 21:08 CET
Last Modified:              07-16-2004 14:28 CEST
======================================================================
Summary:                    ticks, mmap problems, and lost interrupts
Description: 
My on-board Intel 82801DB sound card worked fine under Linux 2.6.0 (ALSA
0.9.7), but upgrading to Linux 2.6.3 (ALSA 1.02c) causes problems.

Enemy Territory has no sound and complains that it can't mmap /dev/dsp. 
Unreal Tournament 2003 has sound, but it is too fast and has regular ticks
(at least 10 per second).  XMMS 1.2.9 with the ALSA output plugin also has
regular ticks whose period corresponds to the buffer time setting.  There
are no problems in XMMS if I uncheck "mmap mode" or use the OSS output
plugin.
======================================================================

----------------------------------------------------------------------
 tcfelker - 03-07-2004 22:12 CET 
----------------------------------------------------------------------
Never mind:  I just upgraded to 2.6.4-rc1 and grafted ALSA 1.03, and my
problems are gone.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
03-07-04 21:08 tcfelker       New Bug                                      
03-07-04 22:12 tcfelker       Bugnote Added: 0000525                       
03-08-04 11:49 tiwai          Assigned To               => tiwai           
03-08-04 11:49 tiwai          Resolution               open => fixed       
03-08-04 11:49 tiwai          Status                   new => resolved     
07-16-04 14:28 tiwai          Status                   resolved => closed  
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
