From: bugtrack@alsa-project.org
Subject: [ALSA - tools 0000681]: alsamixer, rmedigicontrol and rme96 kernel driver
Date: Wed, 29 Dec 2004 14:30:48 +0100
Message-ID: <d1762f760baceb5d7e9e8a88c6700432@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 14B1D26D
	for <alsa-devel@alsa-project.org>; Wed, 29 Dec 2004 14:30:49 +0100 (MET)
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
Status:                     closed
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             11-27-2004 00:59 CET
Last Modified:              12-29-2004 14:30 CET
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
Relationships       ID      Summary
----------------------------------------------------------------------
related to          0000570 Sparse mixer for RME96
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

----------------------------------------------------------------------
 tiwai - 11-29-04 16:10 
----------------------------------------------------------------------
OK, now changed as proposed on CVS.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-27-04 00:59 d637e16c5433737884c13889afdeaf34New Issue                        
           
11-27-04 00:59 d637e16c5433737884c13889afdeaf34File Added: rmedigicontrol.patch 
                  
11-28-04 17:53 martin         File Added: rme32-iface.patch                    
11-28-04 18:01 martin         Note Added: 0002625                          
11-29-04 16:01 tiwai          Relationship added       related to 0000570  
11-29-04 16:10 tiwai          Status                   assigned => resolved
11-29-04 16:10 tiwai          Resolution               open => fixed       
11-29-04 16:10 tiwai          Note Added: 0002647                          
12-29-04 14:30 tiwai          Status                   resolved => closed  
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
