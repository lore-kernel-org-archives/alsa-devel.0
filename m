From: bugtrack@alsa-project.org
Subject: [ALSA - tools 0000681]: alsamixer, rmedigicontrol and rme96 kernel driver
Date: Sun, 28 Nov 2004 18:01:00 +0100
Message-ID: <67abad2396a79aa713cf15ce3e767dc9@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id F14CD24C
	for <alsa-devel@alsa-project.org>; Sun, 28 Nov 2004 18:01:00 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=681> 
======================================================================
Reported By:                d637e16c5433737884c13889afdeaf34
Assigned To:                martin
======================================================================
Project:                    ALSA - tools
Issue ID:                   681
Category:                   rmedigicontrol
Reproducibility:            always
Severity:                   trivial
Priority:                   normal
Status:                     assigned
======================================================================
Date Submitted:             11-27-2004 00:59 CET
Last Modified:              11-28-2004 18:01 CET
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

PS: Added patch for rmedigicontrol
======================================================================

----------------------------------------------------------------------
 martin - 11-28-04 18:01 
----------------------------------------------------------------------
I've added a patch for rme32, because your patch will also break rme32
support.
Don't forget to attach a summary and a signed-off-by line for your patch.


Summary: 

The patch will change SNDRV_CTL_ELEM_IFACE_PCM to
SNDRV_CTL_ELEM_IFACE_MIXER for some mixer elements of rme32.

Signed-off-by: Martin Langer <martin-langer@gmx.de>

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-27-04 00:59 d637e16c5433737884c13889afdeaf34New Issue                        
           
11-27-04 00:59 d637e16c5433737884c13889afdeaf34File Added: rmedigicontrol.patch 
                  
11-28-04 17:53 martin         File Added: rme32-iface.patch                    
11-28-04 18:01 martin         Note Added: 0002625                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
