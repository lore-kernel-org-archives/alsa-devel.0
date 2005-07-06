From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001237]: Audigy ES not recognised
Date: Wed, 6 Jul 2005 23:16:44 +0200
Message-ID: <900f12ca9d208972c261650abcbe948b@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 3820B19D
	for <alsa-devel@alsa-project.org>; Wed,  6 Jul 2005 23:16:44 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1237> 
======================================================================
Reported By:                jakubpol
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1237
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     resolved
Distribution:               
Kernel Version:             
Resolution:                 open
Fixed in Version:           
======================================================================
Date Submitted:             07-06-2005 21:16 CEST
Last Modified:              07-06-2005 23:16 CEST
======================================================================
Summary:                    Audigy ES not recognised
Description: 
I have noticed the following problem: my Audigy ES card (it's an Audigy 1)
is not properly recognised under alsa-driver 1.0.9b.

Here's the output of 'cat /proc/asound/cards':

0 [Audigy         ]: Audigy - Audigy 1 [Unknown]
                     Audigy 1 [Unknown] (rev.3, serial:0x521102) at
0xc800, irq 3

Here's the output of 'lspci':

0000:00:0f.0 Multimedia audio controller: Creative Labs SB Audigy (rev
03)
        Subsystem: Creative Labs: Unknown device 0052
        Flags: bus master, medium devsel, latency 32, IRQ 3
        I/O ports at c800 [size=32]
        Capabilities: [dc] Power Management version 2

In the changelog for the 1.0.9 driver it says that the problem with
recognising the Audugy ES should be fixed. Obviously it is not.


Thanks.
======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
duplicate of        0001216 Microphone does not work
======================================================================

----------------------------------------------------------------------
 rlrevell - 07-06-05 23:16 
----------------------------------------------------------------------
Fixed in CVS.  Should also be fixed in the next stable kernel release.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-06-05 21:16 jakubpol       New Issue                                    
07-06-05 22:10 rlrevell       Relationship added       duplicate of 0001216
07-06-05 23:16 rlrevell       Note Added: 0005396                          
07-06-05 23:16 rlrevell       Status                   new => resolved     
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
