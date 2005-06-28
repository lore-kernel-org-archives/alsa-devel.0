From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001217]: SB Audigy2 NX won't work when plugged into a separate hub
Date: Tue, 28 Jun 2005 09:52:13 +0200
Message-ID: <8a193c255bff8a2d1afc15223a8658f7@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id B58971CB
	for <alsa-devel@alsa-project.org>; Tue, 28 Jun 2005 09:52:13 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1217> 
======================================================================
Reported By:                bluebottle
Assigned To:                Clemens Ladisch
======================================================================
Project:                    ALSA - driver
Issue ID:                   1217
Category:                   USB - usb-audio
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     resolved
Distribution:               Ubuntu Hoary
Kernel Version:             2.6.10
Resolution:                 not an issue
Fixed in Version:           
======================================================================
Date Submitted:             06-28-2005 09:19 CEST
Last Modified:              06-28-2005 09:52 CEST
======================================================================
Summary:                    SB Audigy2 NX won't work when plugged into a
separate hub
Description: 
Hi,

I've got a SB Audigy2 NX that works well now with the 1.0.9 ALSA driver on
a 2.6.10 kernel. It only works however if plugged directly into the
motherboard USB. Plugged into a DLink DUB-H4 USB2 hub, it produces 0.5
seconds of audio, a squelch and click, then nothing further until reboot,
when the problem repeats. dmesg says:

ALSA /usr/src/alsa-1.0.9/alsa-driver-1.0.9b/usb/usbaudio.c:779: cannot
submit syncpipe for urb 0, err = -12

The external hub works perfectly with other products including mice,
joysticks, disks and memory card readers.
======================================================================

----------------------------------------------------------------------
 bluebottle - 06-28-05 09:27 
----------------------------------------------------------------------
Today I updated the firmware with the 04 Feb 2005 driver version; no
improvement.

----------------------------------------------------------------------
 Clemens Ladisch - 06-28-05 09:52 
----------------------------------------------------------------------
The kernel USB code to send audio data through a hub is buggy.

Try the 2.6.12 kernel which is said to be better in this regard.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-28-05 09:19 bluebottle     New Issue                                    
06-28-05 09:19 bluebottle     Distribution              => Ubuntu Hoary    
06-28-05 09:19 bluebottle     Kernel Version            => 2.6.10          
06-28-05 09:27 bluebottle     Note Added: 0005292                          
06-28-05 09:27 bluebottle     Issue Monitored: bluebottle                    
06-28-05 09:52 Clemens LadischStatus                   assigned => resolved
06-28-05 09:52 Clemens LadischResolution               open => not an issue
06-28-05 09:52 Clemens LadischNote Added: 0005293                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
