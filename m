From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001881]: Mixer controls not working for S/PDIF
Date: Mon, 27 Feb 2006 11:16:19 +0100
Message-ID: <6960161cbde66ab2fad5d9fcc5069672@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 70AD0187
	for <alsa-devel@alsa-project.org>; Mon, 27 Feb 2006 11:16:19 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1881> 
======================================================================
Reported By:                lotan_rm
Assigned To:                sashak
======================================================================
Project:                    ALSA - driver
Issue ID:                   1881
Category:                   PCI - intel8x0m
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Gentoo
Kernel Version:             2.6.13.4
======================================================================
Date Submitted:             02-26-2006 10:45 CET
Last Modified:              02-27-2006 11:16 CET
======================================================================
Summary:                    Mixer controls not working for S/PDIF
Description: 
My mainboard is the

   Shuttle AN35N NForce2 Ultra 400

$ cat /proc/asound/cards
 0 [nForce2        ]: NFORCE - NVidia nForce2
                      NVidia nForce2 with ALC650F at 0xe7001000, irq 16

$ cat /proc/asound/devices 
  0: [ 0]   : control
  1:        : sequencer
 16: [ 0- 0]: digital audio playback
 18: [ 0- 2]: digital audio playback
 24: [ 0- 0]: digital audio capture
 25: [ 0- 1]: digital audio capture
 33:        : timer

I'm luckier than most people in the way that S/PDIF worked right away on
hw:0,2.
But I can't get the mixer controls to work.

Most people on the web seeming to have similar problems adjusted the

   IEC958 Playback AC-97-SPSA

to 0% (PCM output), but that didn't help in my case.  In fact, any kind of
adjustment in the mixer didn't show any result.

I tried various .asoundrc configurations without any real success.  I
don't even know, if it's really a driver issue.

One thing I can say though: The onboard sound has a mixer device that can
be controlled as on Windows, the native nVidia driver was working without
a problem.
======================================================================

----------------------------------------------------------------------
 lotan_rm - 02-27-06 11:16 
----------------------------------------------------------------------
I've spotted a mistake I must have made:

the driver is

   intel8x0

and not

   intel8x0m

I hope this makes no big difference.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-26-06 10:45 lotan_rm       New Issue                                    
02-26-06 10:45 lotan_rm       Distribution              => Gentoo          
02-26-06 10:45 lotan_rm       Kernel Version            => 2.6.13.4        
02-27-06 11:16 lotan_rm       Note Added: 0008221                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
