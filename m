From: noreply@alsa-project.org
Subject: [ALSA - driver 0000191]: make clean removes kernel header
Date: Fri, 16 Jul 2004 13:06:40 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040716110640.01F0926009@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 44FF3255
	for <alsa-devel@alsa-project.org>; Fri, 16 Jul 2004 13:06:40 +0200 (MEST)
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
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000191
======================================================================
Reported By:                Sean
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Bug ID:                     191
Category:                   OTHERS
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     closed
Distribution:               
Kernel Version:             2.6.5
======================================================================
Date Submitted:             04-06-2004 02:01 CEST
Last Modified:              07-16-2004 13:06 CEST
======================================================================
Summary:                    make clean removes kernel header
Description: 
make clean in alsa-driver removes /usr/src/linux/include/linux/version.h
requiring make modules to be run again to recreate it before another build
======================================================================

----------------------------------------------------------------------
 tiwai - 04-20-2004 12:52 CEST 
----------------------------------------------------------------------
it's silly but a feature of kbuild...
possibly we can write our own clean-up script in fugure.

----------------------------------------------------------------------
 tiwai - 07-16-2004 13:06 CEST 
----------------------------------------------------------------------
fixed now.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
04-06-04 02:01 Sean           New Bug                                      
04-06-04 02:01 Sean           Kernel Version            => 2.6.5           
04-07-04 20:07 perex          Assigned To               => perex           
04-07-04 20:07 perex          Status                   new => assigned     
04-20-04 12:52 tiwai          Bugnote Added: 0000876                       
04-20-04 12:52 tiwai          Assigned To              perex => tiwai      
04-20-04 12:52 tiwai          Resolution               open => suspended   
04-20-04 12:52 tiwai          Status                   assigned => resolved
07-16-04 13:06 tiwai          Bugnote Added: 0001451                       
07-16-04 13:06 tiwai          Status                   resolved => closed  
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
