From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001194]: hda-intel driver fails to initialize codecs (realtek)
Date: Wed, 15 Jun 2005 16:53:51 +0200
Message-ID: <bd00b342c1059ba59085e40994280d08@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 4BBA91D9
	for <alsa-devel@alsa-project.org>; Wed, 15 Jun 2005 16:53:51 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1194> 
======================================================================
Reported By:                ericmoors
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1194
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               fedora core 3 smp kernel
Kernel Version:             2.6.11.something-smp
======================================================================
Date Submitted:             06-15-2005 16:47 CEST
Last Modified:              06-15-2005 16:53 CEST
======================================================================
Summary:                    hda-intel driver fails to initialize codecs
(realtek)
Description: 
the 1.0.9 version fails to recognize the realtek codec on my motherboard.
I traced the problem to the azx_get_response function. The version I
downloaded from the intel website (a 1.0.8 version) detected the codec
properly.
If I replace the azx_get_response function with the 1.0.8 version (It was
still named azx.c instead of hda-intel.c then) the codec is initialised
properly (although I do get a timeout) and everything appears to function
properly again.
(Well, at least I get sound)
======================================================================

----------------------------------------------------------------------
 tiwai - 06-15-05 16:53 
----------------------------------------------------------------------
It's likely a hardware or BIOS problem.  Try to tune pci and acpi boot
parameters.

The method on 1.0.8 is not a recommended way and it can't handle
unsolicited events, too.  The same style can be achieved by simply
undefining USE_CORB_RIRB in hda_intel.c.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-15-05 16:47 ericmoors      New Issue                                    
06-15-05 16:47 ericmoors      Distribution              => fedora core 3 smp
kernel
06-15-05 16:47 ericmoors      Kernel Version            => 2.6.11.something-smp
06-15-05 16:53 tiwai          Note Added: 0005036                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
