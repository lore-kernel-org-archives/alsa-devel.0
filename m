From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000661]: starting an applicaiton trying to access sound device locks device exclusive
Date: Mon, 22 Nov 2004 15:01:33 +0100
Message-ID: <7fc991e8e5359dd9f0c493f2b2de107c@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 1177625E
	for <alsa-devel@alsa-project.org>; Mon, 22 Nov 2004 15:01:33 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=661> 
======================================================================
Reported By:                soloturn99
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   661
Category:                   0_compilation problem_!!!
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     resolved
Distribution:               debian sid
Kernel Version:             2.6.9
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             11-21-2004 15:41 CET
Last Modified:              11-22-2004 15:01 CET
======================================================================
Summary:                    starting an applicaiton trying to access sound
device locks device exclusive
Description: 
an application should not be by default be allowed to take the sound device
exlusively. if you start more than one applications, it should be possible
to hear one of them or both, but the application must not block.
======================================================================

----------------------------------------------------------------------
 tiwai - 11-22-04 15:01 
----------------------------------------------------------------------
The default behavior of OSS emulation was already changed to non-blocking
mode on CVS.

But the ALSA native isn't not.  This behavior is explicitly written in the
API reference.  It's not a bug at all.  Just use non-blocking mode to
avoid it.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-21-04 15:41 soloturn99     New Issue                                    
11-21-04 15:41 soloturn99     Distribution              => debian sid      
11-21-04 15:41 soloturn99     Kernel Version            => 2.6.9           
11-22-04 15:01 tiwai          Status                   assigned => resolved
11-22-04 15:01 tiwai          Resolution               open => fixed       
11-22-04 15:01 tiwai          Note Added: 0002506                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
