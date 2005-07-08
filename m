From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001220]: Surround and Centre/LFE mixer elements need swapping.
Date: Fri, 8 Jul 2005 14:44:10 +0200
Message-ID: <ea8f2c7adccee6ee5efd276025731101@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 67CAF17C
	for <alsa-devel@alsa-project.org>; Fri,  8 Jul 2005 14:44:10 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1220> 
======================================================================
Reported By:                jcdutton
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1220
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             06-29-2005 23:25 CEST
Last Modified:              07-08-2005 14:44 CEST
======================================================================
Summary:                    Surround and Centre/LFE mixer elements need
swapping.
Description: 
On my snd-intel8x0, I have a ALC650 codec and ICH5 motherboard.
speaker-test -c6 -Dsurround51 produces the correct output on every
speaker.
But, when I change the alsamixer volume "Surround" is adjusts the
Center/LFE sound. When I change the alsamixer volume "Centre" and "LFE" is
adjusts the "Surround" volume.
What will be the best way to add a quirk for my MB to handle this.
The macros in alsa-driver cannot just swap Surround <-> Centre/LFE
alsamixer controls.

The "Swap Surround Slot" control does not help, as it actually swaps the
sound output, and not the mixer controls.

======================================================================

----------------------------------------------------------------------
 tiwai - 07-08-05 14:44 
----------------------------------------------------------------------
Are you sure that the CLFE jack is really CLFE?  I suspect the output is
rather swapped.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-29-05 23:25 jcdutton       New Issue                                    
07-08-05 14:44 tiwai          Note Added: 0005426                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP, 
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
