From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001194]: hda-intel driver fails to initialize codecs (realtek)
Date: Thu, 16 Jun 2005 08:45:26 +0200
Message-ID: <bb475a7eb605c3e23e9c35360cbc2aca@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id C3B02204
	for <alsa-devel@alsa-project.org>; Thu, 16 Jun 2005 08:45:26 +0200 (MEST)
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
Last Modified:              06-16-2005 08:45 CEST
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

----------------------------------------------------------------------
 ericmoors - 06-16-05 08:45 
----------------------------------------------------------------------
Remarkably good conclusion.
I do indeed have problems with the BIOS.
I didn't expect this to be related, but this system won't even boot
without the pci=nobios option.
IIRC I had tried undefining USE_CORB_RIRB and that also failed, but I will
look
into this again.
Thanks for your time.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-15-05 16:47 ericmoors      New Issue                                    
06-15-05 16:47 ericmoors      Distribution              => fedora core 3 smp
kernel
06-15-05 16:47 ericmoors      Kernel Version            => 2.6.11.something-smp
06-15-05 16:53 tiwai          Note Added: 0005036                          
06-16-05 08:45 ericmoors      Note Added: 0005050                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
