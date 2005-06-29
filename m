From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001220]: Surround and Centre/LFE mixer elements need swapping.
Date: Wed, 29 Jun 2005 23:25:04 +0200
Message-ID: <1bd78cfe2acbb0507815b5543fa9e6c7@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id E4B2D18F
	for <alsa-devel@alsa-project.org>; Wed, 29 Jun 2005 23:25:04 +0200 (MEST)
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
Last Modified:              06-29-2005 23:25 CEST
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

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-29-05 23:25 jcdutton       New Issue                                    
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
