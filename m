From: bugtrack@alsa-project.org
Subject: [ALSA - tools 0000708]: Fix CVS envy24control crash on midi 00 control
Date: Sun, 5 Dec 2004 13:58:06 +0100
Message-ID: <119aaf5dbf28f9484252b4b3eaba0b32@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id B7C19315
	for <alsa-devel@alsa-project.org>; Sun,  5 Dec 2004 13:58:06 +0100 (MET)
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


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=708> 
======================================================================
Reported By:                shadow
Assigned To:                
======================================================================
Project:                    ALSA - tools
Issue ID:                   708
Category:                   envy24control
Reproducibility:            sometimes
Severity:                   crash
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             12-05-2004 12:36 CET
Last Modified:              12-05-2004 13:58 CET
======================================================================
Summary:                    Fix CVS envy24control crash on midi 00 control
Description: 
envy24control adds midi support, but if it receives data from a controller
with ID '0' it will crash.
======================================================================

----------------------------------------------------------------------
 shadow - 12-05-04 13:58 
----------------------------------------------------------------------
this fix doesn't really work all the time. the root of the problem is the
insane system of memory address computations based on midi controller
numbers, yuck.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-05-04 12:36 shadow         New Issue                                    
12-05-04 12:36 shadow         File Added:
cvs_alsa_20041205-envy24control.midi00crash.patch                    
12-05-04 13:58 shadow         Note Added: 0002721                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
