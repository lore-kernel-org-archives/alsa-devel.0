From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001271]: Changes in ALSA driver between 2.6.11.10 and 2.6.12.3 mean echo-cancelling mics fail
Date: Thu, 21 Jul 2005 18:50:40 +0200
Message-ID: <894e3b64d116799f42d92b28b6d3f3d0@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 270121BC
	for <alsa-devel@alsa-project.org>; Thu, 21 Jul 2005 18:50:41 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1271> 
======================================================================
Reported By:                dcpiper
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1271
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Debian Sarge
Kernel Version:             2.6.12.3
======================================================================
Date Submitted:             07-21-2005 18:50 CEST
Last Modified:              07-21-2005 18:50 CEST
======================================================================
Summary:                    Changes in ALSA driver between 2.6.11.10 and
2.6.12.3 mean echo-cancelling mics fail
Description: 
Under 2.6.12.3, terrible feedback happens when the echo-cancelling
microphone (A ClearOne AccuMic II) is enabled. No matter if the microphone
is set to mute or not through alsamixer or gnome-volume-control there is
persistent feedback that howls increasingly louder until the microphone's
own enable button is turned off again.

Rebooting solved nothing, as did resetting the power on the microphone.
Reboot to 2.6.11.10 and the problem is gone again. Something changed in
ALSA somewhere between those kernel versions.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-21-05 18:50 dcpiper        New Issue                                    
07-21-05 18:50 dcpiper        Distribution              => Debian Sarge    
07-21-05 18:50 dcpiper        Kernel Version            => 2.6.12.3        
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
