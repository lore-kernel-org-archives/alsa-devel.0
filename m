From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000434]: System hang after playing
Date: Fri, 24 Sep 2004 13:45:11 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040924114511.45DB1101DB@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 9B354288
	for <alsa-devel@alsa-project.org>; Fri, 24 Sep 2004 13:45:11 +0200 (MEST)
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
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000434
======================================================================
Reported By:                crsw
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Bug ID:                     434
Category:                   PCI - atiixp
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     closed
Distribution:               Fedora core 2
Kernel Version:             2.6.7-1.494.2.2custom
======================================================================
Date Submitted:             08-11-2004 10:56 CEST
Last Modified:              09-24-2004 13:45 CEST
======================================================================
Summary:                    System hang after playing
Description: 
After playing a sound file the system hang whitout any message. It hang
even if you send a kill -1 signal to the process reproducing the sound
file
======================================================================

----------------------------------------------------------------------
 tiwai - 08-19-2004 19:19 CEST 
----------------------------------------------------------------------
Can you get a trace via magic sysrq?

----------------------------------------------------------------------
 crsw - 08-19-2004 22:01 CEST 
----------------------------------------------------------------------
I'v just installed alsa-lib 1.0.6.rc1.
The problem is solved now.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
08-11-04 10:56 crsw           New Bug                                      
08-11-04 10:56 crsw           Distribution              => Fedora core 2   
08-11-04 10:56 crsw           Kernel Version            => 2.6.7-1.494.2.2custom
08-11-04 10:56 crsw           Bug Monitored: crsw                          
08-11-04 10:56 crsw           Bug End Monitor: crsw                        
08-19-04 19:19 tiwai          Bugnote Added: 0001594                       
08-19-04 22:01 crsw           Bugnote Added: 0001596                       
08-20-04 12:38 tiwai          Resolution               open => fixed       
08-20-04 12:38 tiwai          Status                   assigned => resolved
09-24-04 13:45 tiwai          Status                   resolved => closed  
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
