From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000702]: Crash when pushing hardware volume button
Date: Fri, 3 Dec 2004 14:22:03 +0100
Message-ID: <cff77507bb5de43f8839d215ac0e96fe@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 67BA31F8
	for <alsa-devel@alsa-project.org>; Fri,  3 Dec 2004 14:22:03 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=702> 
======================================================================
Reported By:                jjoosse
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   702
Category:                   PCI - es1968
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     resolved
Distribution:               
Kernel Version:             
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             12-02-2004 21:35 CET
Last Modified:              12-03-2004 14:22 CET
======================================================================
Summary:                    Crash when pushing hardware volume button
Description: 
When I use the hardware vulume buttons on my Dell Inspiron 5000 the system
locks up. 

I capured the oops via serial console. See additional information.

Commenting out the msleep(1)'s in snd_es1968_ac97_write and just to be
sure also in snd_es1968_ac97_read, fixes it for me. Removal of the delay
has no side effects on my system.
======================================================================

----------------------------------------------------------------------
 tiwai - 12-03-04 14:02 
----------------------------------------------------------------------
My bad.  The attached patch should fix this problem.

----------------------------------------------------------------------
 tiwai - 12-03-04 14:22 
----------------------------------------------------------------------
The patch was applied to CVS.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-02-04 21:35 jjoosse        New Issue                                    
12-03-04 14:02 tiwai          Note Added: 0002709                          
12-03-04 14:03 tiwai          File Added: es1968-hwvol-fix.dif                  
 
12-03-04 14:22 tiwai          Status                   assigned => resolved
12-03-04 14:22 tiwai          Resolution               open => fixed       
12-03-04 14:22 tiwai          Note Added: 0002712                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
