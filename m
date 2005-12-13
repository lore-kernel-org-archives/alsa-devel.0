From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000933]: ALS4000 chipset dont sounds fine, the sound is too slow and dont play everything.
Date: Tue, 13 Dec 2005 12:51:46 +0100
Message-ID: <db22a50ae72a311fcc8137b65e5d9aa9@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 1AD2818A
	for <alsa-devel@alsa-project.org>; Tue, 13 Dec 2005 12:51:46 +0100 (MET)
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
Status:                     feedback
Distribution:               Kanotix - Debian/sid
Kernel Version:             2.6.10
======================================================================
Date Submitted:             02-22-2005 14:08 CET
Last Modified:              12-13-2005 12:51 CET
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
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
