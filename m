From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000739]: Invalid "AutoSync Reference" value reported using controlers
Date: Tue, 21 Dec 2004 18:46:56 +0100
Message-ID: <37cf2914d1a0a02378f09ab51840ff44@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 3F795245
	for <alsa-devel@alsa-project.org>; Tue, 21 Dec 2004 18:46:56 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=739> 
======================================================================
Reported By:                remy
Assigned To:                charbonnel
======================================================================
Project:                    ALSA - driver
Issue ID:                   739
Category:                   PCI - RME HDSP
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             12-21-2004 18:41 CET
Last Modified:              12-21-2004 18:46 CET
======================================================================
Summary:                    Invalid "AutoSync Reference" value reported using
controlers
Description: 
The value returned by controllers for control number 14 ("AutoSync
Reference") is incorrect and different from that reported by doing a cat
/proc/asound/card0/hdsp.
The value reported is not "AutoSync Reference" but "Preferred Sync
Reference" instead.
======================================================================

----------------------------------------------------------------------
 tiwai - 12-21-04 18:46 
----------------------------------------------------------------------
Thanks for the patch.
Could you provide signed-off-by line (as described in News)?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-21-04 18:41 remy           New Issue                                    
12-21-04 18:41 remy           File Added: hdsp.c.diff                      
12-21-04 18:46 tiwai          Note Added: 0002902                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
