From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000932]: locked at module probe
Date: Tue, 22 Feb 2005 14:19:31 +0100
Message-ID: <4d489addf04a28823ddd493e5870e115@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id D7007179
	for <alsa-devel@alsa-project.org>; Tue, 22 Feb 2005 14:19:31 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=932> 
======================================================================
Reported By:                jeanseb
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   932
Category:                   0_compilation problem_!!!
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     assigned
Distribution:               debian
Kernel Version:             2.6
======================================================================
Date Submitted:             02-22-2005 11:03 CET
Last Modified:              02-22-2005 14:19 CET
======================================================================
Summary:                    locked at module probe
Description: 
oprobing with fast spinlock an prempt anable smp kernel hang.
This is a spin lock problem and I've fixed it in the isisalsa version.


======================================================================

----------------------------------------------------------------------
 tiwai - 02-22-05 14:18 
----------------------------------------------------------------------
A patch is appreciated.

----------------------------------------------------------------------
 tiwai - 02-22-05 14:19 
----------------------------------------------------------------------
I mean pasting the patch here or pointing the URL...

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-22-05 11:03 jeanseb        New Issue                                    
02-22-05 11:03 jeanseb        Distribution              => debian          
02-22-05 11:03 jeanseb        Kernel Version            => 2.6             
02-22-05 14:18 tiwai          Note Added: 0003697                          
02-22-05 14:19 tiwai          Note Added: 0003698                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
