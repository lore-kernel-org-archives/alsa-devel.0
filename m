From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0001231]: Sharing soundcard via dmix does not work when mixing 32bit and 64bit applications.
Date: Mon, 4 Jul 2005 16:30:39 +0200
Message-ID: <5f388bd37b09dcecb3a2023204fd864e@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 7B863199
	for <alsa-devel@alsa-project.org>; Mon,  4 Jul 2005 16:30:39 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1231> 
======================================================================
Reported By:                Tobias Diedrich
Assigned To:                
======================================================================
Project:                    ALSA - lib
Issue ID:                   1231
Category:                   0_general
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             07-04-2005 16:30 CEST
Last Modified:              07-04-2005 16:30 CEST
======================================================================
Summary:                    Sharing soundcard via dmix does not work when mixing
32bit and 64bit applications.
Description: 
I have configured a friends AMD64-System to use dmix by default.
I also made the same configuration for the 32bit-chroot and made sure
that
/tmp is a bind-mount, so the dmix-Socket is shared between 32bit and 64bit
applications.
However while sharing between one type of applications (either all 32bit
or all 64bit) works fine, mixed sharing doesn't work.  A strace shows that
the socket is opened by apparently communication fails.
I suspect that the structures passed by dmix have problems with differntly
sized fields between 32bit and 64bit.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-04-05 16:30 Tobias DiedrichNew Issue                                    
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
