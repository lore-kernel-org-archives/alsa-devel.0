From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000622]: snd-ens1371 hisses and garbled sound
Date: Tue, 9 Nov 2004 18:55:31 +0100
Message-ID: <a627effa1be2e3fc952cadd760e959e8@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 5850C62
	for <alsa-devel@alsa-project.org>; Tue,  9 Nov 2004 18:55:31 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=622> 
======================================================================
Reported By:                jdthood
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   622
Category:                   PCI - ens1371
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             11-01-2004 11:29 CET
Last Modified:              11-09-2004 18:55 CET
======================================================================
Summary:                    snd-ens1371 hisses and garbled sound
Description: 
Please see Debian bug
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=239575:

    http://bugs.debian.org/239575

The submitter writes in part:

------------------------------------------------------
Before installing [Debian] sarge I happily used the ALSA sound system on a
2.4.20 [kernel] with my SB PCI 128 soundcard. With the 2.4.24 kernel [...]
the following problems occur:
After initilization of the snd-ens1371 module a loud hiss comes out of the
speakers. The artsd fails and displays a message that it will use the null
output device. All ALSA or arts enabled apps either crash, remain in a
infinite loop  initializing or start with sound disabled.
------------------------------------------------------

Another person adds:

------------------------------------------------------
Sound system is working rather properly but I get continual hisses out of
my soundcard, some sound is coming out as well but is completely garbled.
------------------------------------------------------

Any idea what might be wrong?
======================================================================

----------------------------------------------------------------------
 tiwai - 11-09-04 18:54 
----------------------------------------------------------------------
This might be a KDE problem, which automatically turned on
this volume switch, although the driver default is OFF...

Maybe it's better to remove this one to avoid these reports.

----------------------------------------------------------------------
 tiwai - 11-09-04 18:55 
----------------------------------------------------------------------
To be sure, please show the contents of /proc/asound/card0/codec97#0/*
files.  The problematic codec as far as I know is ALC65x.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-01-04 11:29 jdthood        New Issue                                    
11-02-04 21:27 jdthood        Note Added: 0002299                          
11-09-04 18:54 tiwai          Note Added: 0002335                          
11-09-04 18:55 tiwai          Note Added: 0002336                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
