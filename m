From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000437]: Problem with the spec file
Date: Wed, 29 Dec 2004 14:16:56 +0100
Message-ID: <aacac6ca1852cb5c814ea67e3a3e7c88@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id AF366239
	for <alsa-devel@alsa-project.org>; Wed, 29 Dec 2004 14:16:56 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=437> 
======================================================================
Reported By:                croiset
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   437
Category:                   OTHERS
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     resolved
Distribution:               
Kernel Version:             2.4.7-10
Resolution:                 not an issue
Fixed in Version:           
======================================================================
Date Submitted:             08-13-2004 09:56 CEST
Last Modified:              12-29-2004 14:16 CET
======================================================================
Summary:                    Problem with the spec file
Description: 
There is a problem the spec file generated with the configure.

you might replace this line in alsa-driver.spec.in :
/lib/modules/*/kernel/*
by :
/lib/modules/*/misc/*


======================================================================

----------------------------------------------------------------------
 croiset - 12-29-04 12:18 
----------------------------------------------------------------------
Ouups it was a problem due to a misconfiguration. The bug can be closed.
Test made with 1.0.8rc1

----------------------------------------------------------------------
 tiwai - 12-29-04 14:16 
----------------------------------------------------------------------
Ok, resolved.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-13-04 09:56 croiset        New Issue                                    
08-13-04 09:56 croiset        Kernel Version            => 2.4.7-10        
08-13-04 10:52 croiset        Note Added: 0001561                          
12-29-04 12:18 croiset        Note Added: 0002995                          
12-29-04 14:16 tiwai          Status                   new => resolved     
12-29-04 14:16 tiwai          Resolution               open => not an issue
12-29-04 14:16 tiwai          Assigned To               => tiwai           
12-29-04 14:16 tiwai          Note Added: 0002997                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
