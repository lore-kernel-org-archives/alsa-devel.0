From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000682]: alsamixer, rmedigicontrol and rme96 kernel driver
Date: Sat, 27 Nov 2004 00:59:44 +0100
Message-ID: <e585ac515a03c8a5e8239dda4ff91179@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id B4866242
	for <alsa-devel@alsa-project.org>; Sat, 27 Nov 2004 00:59:44 +0100 (MET)
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


The following issue has been SUBMITTED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=682> 
======================================================================
Reported By:                d637e16c5433737884c13889afdeaf34
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   682
Category:                   PCI - RME 96
Reproducibility:            always
Severity:                   trivial
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             11-27-2004 00:59 CET
Last Modified:              11-27-2004 00:59 CET
======================================================================
Summary:                    alsamixer, rmedigicontrol and rme96 kernel driver
Description: 
As it's impossible to use the alsamixer with the rme96 driver here's a
small patch for it to make it work. (it's not from me, it's from undog
#alsa on irc.freenode.org)

This patch will break rmedigicontrol, so i made a small patch for
rmedigicontrol that'll fix this, too.

Adding is trivial, it's just editing 8 lines of source.


Regards,
Matthias

PS: Added patch for rme96.c
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-27-04 00:59 d637e16c5433737884c13889afdeaf34New Issue                        
           
11-27-04 00:59 d637e16c5433737884c13889afdeaf34File Added: rme96.c.patch        
           
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
