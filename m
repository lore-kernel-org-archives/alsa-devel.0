From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000684]: unresolver symbols for gus interwave
Date: Wed, 29 Dec 2004 14:29:35 +0100
Message-ID: <a5b940f6de12483bfbc2ee9da9b26455@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 838AC26D
	for <alsa-devel@alsa-project.org>; Wed, 29 Dec 2004 14:29:35 +0100 (MET)
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


The following issue has been CLOSED
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=684> 
======================================================================
Reported By:                led
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   684
Category:                   ISA - GUS (classic, max, extreme, interwave)
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     closed
Distribution:               redhat
Kernel Version:             self compiled 2.4.27 and 2.4.28
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             11-28-2004 14:54 CET
Last Modified:              12-29-2004 14:29 CET
======================================================================
Summary:                    unresolver symbols for gus interwave
Description: 
Since alsa driver 1.0.6 there are unresolved symbols for gus interwave
driver. I include console report from restarting the driver showing the
problem. In 1.0.7 version is the same. 1.0.5 works fine.
======================================================================

----------------------------------------------------------------------
 tiwai - 11-29-04 15:35 
----------------------------------------------------------------------
It's the missing dependency in Makefile.
Fixed on CVS now.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-28-04 14:54 led            New Issue                                    
11-28-04 14:54 led            File Added: alsa_unresolved_symbols.ascii         
          
11-28-04 14:54 led            Distribution              => redhat          
11-28-04 14:54 led            Kernel Version            => self compiled 2.4.27
and 2.4.28
11-28-04 16:31 led            Issue Monitored: led                         
11-29-04 15:35 tiwai          Status                   assigned => resolved
11-29-04 15:35 tiwai          Resolution               open => fixed       
11-29-04 15:35 tiwai          Note Added: 0002640                          
12-29-04 14:29 tiwai          Status                   resolved => closed  
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
