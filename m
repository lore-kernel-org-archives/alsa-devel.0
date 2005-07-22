From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001273]: snd_intel8x0 and kexec() don't work together
Date: Fri, 22 Jul 2005 10:23:22 +0200
Message-ID: <3dd7cd3c96b2ac48eb44d3867a282105@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id D30F71A7
	for <alsa-devel@alsa-project.org>; Fri, 22 Jul 2005 10:23:22 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1273> 
======================================================================
Reported By:                hildeb
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1273
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               Debian/unstable
Kernel Version:             2.6.13-rc3-git4
======================================================================
Date Submitted:             07-22-2005 10:23 CEST
Last Modified:              07-22-2005 10:23 CEST
======================================================================
Summary:                    snd_intel8x0 and kexec() don't work together
Description: 
Whenever I use kexec() to reboot into a new kernel, sound doesn't work
properly. KDE doesn't display a mixer.

All modules seem to be loaded, though - and after a reboot using
"reboot" instead of "kexec", sound works flawlessly with the same setup.

/etc/init.d/alsa restart doesn't change things, either.

If I unload the sounddriver:

# rmmod snd_intel8x0

and the reload it:

# modprobe snd_intel8x0

I get:

ACPI: PCI Interrupt 0000:00:06.0[A] -> Link [LACI] -> GSI 22 (level, low)
-> IRQ 19
PCI: Setting latency timer of device 0000:00:06.0 to 64
AC'97 warm reset still in progress? [0xffffffff]
Intel ICH: probe of 0000:00:06.0 failed with error -5

======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-22-05 10:23 hildeb         New Issue                                    
07-22-05 10:23 hildeb         Distribution              => Debian/unstable 
07-22-05 10:23 hildeb         Kernel Version            => 2.6.13-rc3-git4 
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
