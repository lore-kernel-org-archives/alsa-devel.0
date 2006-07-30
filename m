From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000933]: ALS4000 chipset dont sounds
	fine, the sound is too slow and dont play everything.
Date: Sun, 30 Jul 2006 11:30:43 +0200
Message-ID: <0f1389ac848fe12296e6743aa7cee7a7@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 7346318D
	for <alsa-devel@alsa-project.org>;
	Sun, 30 Jul 2006 11:30:43 +0200 (MEST)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


The following issue has been CLOSED
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
Status:                     closed
Distribution:               Kanotix - Debian/sid
Kernel Version:             2.6.10
Resolution:                 unable to duplicate
Fixed in Version:           
======================================================================
Date Submitted:             02-22-2005 14:08 CET
Last Modified:              07-30-2006 11:30 CEST
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
 segnini75 - 03-23-05 03:51 
----------------------------------------------------------------------
The problem is back :S until one actualization the problem persist... what
can i do? Thanks u!

----------------------------------------------------------------------
 jdthood - 12-13-05 12:51 
----------------------------------------------------------------------
segnini75: Can you please list which ALSA versions work and which ones
don't?  That will help with bug hunting.

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
03-01-05 03:07 segnini75      Issue End Monitor: segnini75                    
03-09-05 18:39 tiwai          Status                   new => resolved     
03-09-05 18:39 tiwai          Resolution               open => fixed       
03-09-05 18:39 tiwai          Assigned To               => tiwai           
03-09-05 18:39 tiwai          Note Added: 0003832                          
03-09-05 18:39 tiwai          Assigned To              tiwai =>            
03-23-05 03:51 segnini75      Status                   resolved => feedback
03-23-05 03:51 segnini75      Resolution               fixed => reopened   
03-23-05 03:51 segnini75      Note Added: 0004150                          
12-13-05 12:51 jdthood        Note Added: 0007005                          
07-30-06 11:30 Adrian Bunk    Status                   feedback => closed  
07-30-06 11:30 Adrian Bunk    Resolution               reopened => unable to
duplicate
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
