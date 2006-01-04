From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001253]: My kernel doesn't find my sound cards anymore !!!
Date: Wed, 4 Jan 2006 15:38:14 +0100
Message-ID: <00291864bc4bf3570a930512903505e2@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 578F9184
	for <alsa-devel@alsa-project.org>; Wed,  4 Jan 2006 15:38:14 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1253> 
======================================================================
Reported By:                fabien
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1253
Category:                   PCI - ens1370
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Debian Sarge
Kernel Version:             2.6.12
======================================================================
Date Submitted:             07-12-2005 14:04 CEST
Last Modified:              01-04-2006 15:38 CET
======================================================================
Summary:                    My kernel doesn't find my sound cards anymore !!!
Description: 
My kernel stop working with my soundcards !!!
It use to work in 2.6.8 (not in 2.6.10, 2.6.11 & 2.6.12)


My sound cards :
- ENS1370
- SIS 7012

Motherboard :
- K7S5A

Linux Box :
- Debian on x86 AMD
======================================================================

----------------------------------------------------------------------
 fabien - 01-03-06 10:11 
----------------------------------------------------------------------
Unfortunatly no. I'm in 2.6.14.4 kernel release.
I will try 2.6.15 this week.



----------------------------------------------------------------------
 fabien - 01-04-06 15:38 
----------------------------------------------------------------------
I can't have it work either in 2.6.15

xxx@matou:~$ dmesg | grep -iE "ALSA|sound|ens13|intel8|ac97|si7012|#"
Linux version 2.6.15 (root@matou) (gcc version 4.0.3 20051201 (prerelease)
(Debian 4.0.2-5)) #1 PREEMPT Tue Jan 3 20:14:39 CET 2006
Advanced Linux Sound Architecture Driver Version 1.0.10rc3 (Mon Nov 07
13:30:21 2005 UTC).
ALSA sound/pci/ens1370.c:669: codec read timeout (final) at 0xd414, reg =
0x7c [0xf00000]
ALSA sound/pci/ens1370.c:669: codec read timeout (final) at 0xd414, reg =
0x7e [0xf00000] 
ALSA sound/pci/ens1370.c:669: codec read timeout (final) at 0xd414, reg =
0x0 [0x800000]
ALSA sound/pci/ens1370.c:669: codec read timeout (final) at 0xd414, reg =
0x7c [0xf00000]
ALSA sound/pci/ens1370.c:669: codec read timeout (final) at 0xd414, reg =
0x7e [0xf00000] 
ALSA sound/pci/ens1370.c:669: codec read timeout (final) at 0xd414, reg =
0x7c [0xf00000]
ALSA sound/pci/ens1370.c:669: codec read timeout (final) at 0xd414, reg =
0x7e [0xf00000]
ALSA sound/pci/ac97/ac97_codec.c:1938: AC'97 0 access is not valid [0x0],
removing mixer. 
ENS1371: probe of 0000:00:0b.0 failed with error -5
intel8x0_measure_ac97_clock: measured 50652 usecs
intel8x0: clocking to 48000
ALSA device list:
  #0: Dummy 1
  #1: MPU-401 UART at 0x300, irq 10
  #2: SiS SI7012 with ALC100,100P at 0xdc00, irq 11 
  #3: Camera at usb-0000:00:02.2-1, full speed


xxx@matou:~$ lspci
0000:00:00.0 Host bridge: Silicon Integrated Systems [SiS] 735 Host (rev
01)
0000:00:01.0 PCI bridge: Silicon Integrated Systems [SiS] Virtual
PCI-to-PCI bridge (AGP) 
0000:00:02.0 ISA bridge: Silicon Integrated Systems [SiS] SiS85C503/5513
(LPC Bridge)
0000:00:02.1 SMBus: Silicon Integrated Systems [SiS] SiS961/2 SMBus
Controller
0000:00:02.2 USB Controller: Silicon Integrated Systems [SiS] USB 1.0
Controller (rev 07)
0000:00:02.3 USB Controller: Silicon Integrated Systems [SiS] USB 1.0
Controller (rev 07)
0000:00:02.5 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE]
(rev d0)
0000:00:02.7 Multimedia audio controller: Silicon Integrated Systems [SiS]
Sound Controller (rev a0) 
0000:00:0b.0 Multimedia audio controller: Ensoniq ES1371 [AudioPCI-97]
(rev 08)

xxx@matou:/proc/asound$ ls -l
total 4
lrwxrwxrwx 1 root root 5 2006-01-03 23:58 Camera -> card3
dr-xr-xr-x 4 root root 0 2006-01-03 23:58 card0 
dr-xr-xr-x 2 root root 0 2006-01-03 23:58 card1
dr-xr-xr-x 6 root root 0 2006-01-03 23:58 card2
dr-xr-xr-x 3 root root 0 2006-01-03 23:58 card3
-r--r--r-- 1 root root 0 2006-01-03 23:58 cards
-r--r--r-- 1 root root 0 2006-01-03 23:58 devices 
lrwxrwxrwx 1 root root 5 2006-01-03 23:58 Dummy -> card0
-r--r--r-- 1 root root 0 2006-01-03 23:58 hwdep
dr-xr-xr-x 2 root root 0 2006-01-03 23:58 oss
-r--r--r-- 1 root root 0 2006-01-03 23:58 pcm
dr-xr-xr-x 2 root root 0 2006-01-03 23:58 seq 
lrwxrwxrwx 1 root root 5 2006-01-03 23:58 SI7012 -> card2
-r--r--r-- 1 root root 0 2006-01-03 23:58 timers
lrwxrwxrwx 1 root root 5 2006-01-03 23:58 UART -> card1
-r--r--r-- 1 root root 0 2006-01-03 23:58 version

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-12-05 14:04 fabien         New Issue                                    
07-12-05 14:04 fabien         Distribution              => Debian Sarge    
07-12-05 14:04 fabien         Kernel Version            => 2.6.12          
10-24-05 21:20 fabien         Note Added: 0006523                          
12-31-05 00:11 rlrevell       Note Added: 0007310                          
01-02-06 12:36 fabien         Note Added: 0007371                          
01-03-06 10:10 fabien         Note Edited: 0007371                         
01-03-06 10:11 fabien         Note Edited: 0007371                         
01-04-06 15:38 fabien         Note Added: 0007423                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
