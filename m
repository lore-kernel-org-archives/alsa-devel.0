From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001050]: Sound Blaster Audigy2 NX does not support 44,1kHz
Date: Mon, 25 Apr 2005 10:47:45 +0200
Message-ID: <82f0b265b6151e905959126275a1e337@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 9F0251ED
	for <alsa-devel@alsa-project.org>; Mon, 25 Apr 2005 10:47:45 +0200 (MEST)
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


The following issue has been ACKNOWLEDGED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1050> 
======================================================================
Reported By:                gears
Assigned To:                Clemens Ladisch
======================================================================
Project:                    ALSA - driver
Issue ID:                   1050
Category:                   USB - usb-audio
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     acknowledged
Distribution:               Ubuntu 5.04
Kernel Version:             2.6.10
======================================================================
Date Submitted:             04-13-2005 17:22 CEST
Last Modified:              04-25-2005 10:47 CEST
======================================================================
Summary:                    Sound Blaster Audigy2 NX does not support 44,1kHz
Description: 
For my hardware (Sound Blaster Audigy2 NX) the system also needs to set up
automatic sound conversion to 48000 instead of default 44100 or the sound
gets
badly distorted (at least it does so when using the spdif output). It also
needs
its speaker output unmuted.

the sound distortion is because ALSA claims it supports 44,1 kHz (hw:X),
although it really doesn't
======================================================================

----------------------------------------------------------------------
 Clemens Ladisch - 04-25-05 10:47 
----------------------------------------------------------------------
The hardware does support 44.1 kHz, but the driver and the device cannot
agree on how to synchronize to each other.

I'm working on this.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-13-05 17:22 gears          New Issue                                    
04-13-05 17:22 gears          Distribution              => Ubuntu 5.04     
04-13-05 17:22 gears          Kernel Version            => 2.6.10          
04-25-05 10:47 Clemens LadischNote Added: 0004571                          
04-25-05 10:47 Clemens LadischStatus                   assigned => acknowledged
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
