From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000904]: PCM volume sliders are Left-Right switched for all 3 analog outputs on Audigy2 Platinum Pro ZS
Date: Sat, 12 Feb 2005 20:26:36 +0100
Message-ID: <906f17087110b4f843cff9650b670875@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id E43F4202
	for <alsa-devel@alsa-project.org>; Sat, 12 Feb 2005 20:26:36 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=904> 
======================================================================
Reported By:                riwright
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   904
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               Fedora Core 3
Kernel Version:             &nbsp;2.6.10-1.741
======================================================================
Date Submitted:             02-12-2005 20:26 CET
Last Modified:              02-12-2005 20:26 CET
======================================================================
Summary:                    PCM volume sliders are Left-Right switched for all 3
analog outputs on Audigy2 Platinum Pro ZS
Description: 
Using either the stereo PCM device (hw:0,0) or Lee Revell's multichannel
patch PCM device (hw:0,3), the volume control sliders
(gnome-volume-control) incorrectly control the L & R channels of the
soundcard's analog outputs (i.e. they are backward).

For example for the multichannel case (think 5.1 speaker setup), the PCM
Front LEFT slider controls the Stereo Output
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1 RIGHT channel and vice
versa.  The PCM Surround LEFT slider controls the Stereo Output
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2 RIGHT
channel and vice versa.  Finally, the PCM Center slider controls the
Stereo Output https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3 RIGHT
channel and the PCM LFE slider controls the Stereo
Output https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3 LEFT
channel....this is backwards too, the Center should be Left
and LFE Right.

Using the 2 channel stereo PCM (hw:0,0) the Front Left slider controls the
Stereo Output https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1 RIGHT
channel and vice versa.  The card's Stereo Output's
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2 &
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3 are not available.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-12-05 20:26 riwright       New Issue                                    
02-12-05 20:26 riwright       Distribution              => Fedora Core 3   
02-12-05 20:26 riwright       Kernel Version            =>  2.6.10-1.741   
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
