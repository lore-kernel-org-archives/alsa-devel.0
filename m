From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001199]: oops with pdaudiocf after data stream abort
Date: Sun, 19 Jun 2005 09:58:02 +0200
Message-ID: <203f13c56318e1c8d6c52efce51278b3@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id A268A199
	for <alsa-devel@alsa-project.org>; Sun, 19 Jun 2005 09:58:03 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1199> 
======================================================================
Reported By:                zwelch
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   1199
Category:                   PCMCIA - pdaudiocf
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     assigned
Distribution:               Gentoo
Kernel Version:             2.6.11.12
======================================================================
Date Submitted:             06-17-2005 02:50 CEST
Last Modified:              06-19-2005 09:58 CEST
======================================================================
Summary:                    oops with pdaudiocf after data stream abort
Description: 
The following oops report was generated while using `arecord | aplay` from
the 1.0.9 alsa-utils release.  It was triggered by unplugging the pre-amp
while recording, thus causing the optical signal to disappear
unexpectedly.

As it is, I need both the pdaudiocf and powermac drivers working, or I
would be using the out-of-kernel alsa-driver package.  The powermac driver
in 1.0.9a can't find the symbol 'macio_find', which I have reported
separately (bug https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1198). 
Once that bug is fixed, I can retest this issue
with the most current release, but I hope patches might be applied to
2.6.11.12 to fix this problem.

I can provide additional information about the kernel configuration,
installed package versions, run further tests, or try possible patches.

======================================================================

----------------------------------------------------------------------
 zwelch - 06-19-05 09:58 
----------------------------------------------------------------------
I have verified that this problem still exists in both the 2.6.12 in-kernel
and 1.0.9b alsa-driver package.

To underscore the "real-world" nature of this bug, my pre-amp (a Core
Sound Mic2496) is nominally powered by a battery, and Murphy's Law ensures
it will invariably run out in the middle of recording.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-17-05 02:50 zwelch         New Issue                                    
06-17-05 02:50 zwelch         Distribution              => Gentoo          
06-17-05 02:50 zwelch         Kernel Version            => 2.6.11.12       
06-19-05 09:58 zwelch         Note Added: 0005086                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
