From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000933]: ALS4000 chipset dont sounds fine, the sound is too slow and dont play everything.
Date: Tue, 1 Mar 2005 03:07:39 +0100
Message-ID: <a50808efcf2f8512cd2a63d6cde68159@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 68868201
	for <alsa-devel@alsa-project.org>; Tue,  1 Mar 2005 03:07:39 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=933> 
======================================================================
Reported By:                segnini75
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   933
Category:                   PCI - als4000
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Kanotix - Debian/sid
Kernel Version:             2.6.10
======================================================================
Date Submitted:             02-22-2005 14:08 CET
Last Modified:              03-01-2005 03:07 CET
======================================================================
Summary:                    ALS4000 chipset dont sounds fine, the sound is too
slow and dont play everything.
Description: 
The modconf info about snd-als4000 retuns:

Jevus@box:~$ modinfo snd-als4000
filename:      
/lib/modules/2.6.10-kanotix-8/kernel/sound/pci/snd-als4000.ko
author:         Bart Hartgers <bart@etpmod.phys.tue.nl>
description:    Avance Logic ALS4000
license:        GPL
vermagic:       2.6.10-kanotix-8 preempt 586 gcc-3.3
depends:       
snd-sb-common,gameport,snd-pcm,snd-opl3-lib,snd-mpu401-uart,snd
alias:          pci:v00004005d00004000sv*sd*bc*sc*i*
parm:           joystick_port:Joystick port address for ALS4000 soundcard.
(0 = disabled)
parm:           enable:Enable ALS4000 soundcard.
parm:           id:ID string for ALS4000 soundcard.
parm:           index:Index value for ALS4000 soundcard.
--------------------------------------------------------------------
NOTE: This card works fine in windows

Plase solve that problems (Note. Is not working on any version of ALSA
drivers actually, all have same problem.

Thanks!- Jesus Segnini
======================================================================

----------------------------------------------------------------------
 segnini75 - 02-24-05 23:29 
----------------------------------------------------------------------
Turning ACPI off dont works :( another idea? thanks!.

----------------------------------------------------------------------
 segnini75 - 03-01-05 03:07 
----------------------------------------------------------------------
Is working fine now :) with last update :D thanks ALSA team!.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-22-05 14:08 segnini75      New Issue                                    
02-22-05 14:08 segnini75      Distribution              => Kanotix - Debian/sid
02-22-05 14:08 segnini75      Kernel Version            => 2.6.10          
02-22-05 17:15 segnini75      Note Added: 0003705                          
02-22-05 17:16 segnini75      Note Edited: 0003705                         
02-22-05 18:26 segnini75      Issue Monitored: segnini75                    
02-24-05 22:06 tiwai          Note Added: 0003728                          
02-24-05 23:29 segnini75      Note Added: 0003731                          
03-01-05 03:07 segnini75      Note Added: 0003753                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
