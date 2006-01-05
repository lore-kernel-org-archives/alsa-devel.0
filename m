From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001253]: My kernel doesn't find my sound cards anymore !!!
Date: Thu, 5 Jan 2006 23:38:12 +0100
Message-ID: <33ae7d1a65099f1bd38e8c5a0db1858d@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 31F2C17B
	for <alsa-devel@alsa-project.org>; Thu,  5 Jan 2006 23:38:12 +0100 (MET)
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
Last Modified:              01-05-2006 23:38 CET
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
 fabien - 01-05-06 21:18 
----------------------------------------------------------------------
I compile every sound drivers in modules, I remove the dummy and MPU-401
UART drivers. I disable my SIS 7012 sound card in the bios. I unplugged my
web cam.

=> It's working with the ENS1371 card !!!

matou:/etc# lsmod
Module                  Size  Used by
snd_seq_midi            8608  0
snd_ens1371            23264  4
snd_rawmidi            23712  2 snd_seq_midi,snd_ens1371
snd_ac97_codec         83104  1 snd_ens1371
snd_ac97_bus            2304  1 snd_ac97_codec
pcspkr                  2052  0

matou:/etc# cat /proc/asound/cards
0 [AudioPCI       ]: ENS1371 - Ensoniq AudioPCI
                     Ensoniq AudioPCI ENS1371 at 0xdc00, irq 5

But no information in dmesg :

matou:/etc# dmesg | grep -iE "ALSA|sound|#|ens13|ac97|sis"
Linux version 2.6.15 (root@matou) (gcc version 4.0.3 20051201 (prerelease)
(Debian 4.0.2-5)) #1 PREEMPT Wed Jan 4 21:03:14 CET 2006
Advanced Linux Sound Architecture Driver Version 1.0.10rc3 (Mon Nov 07
13:30:21 2005 UTC).
ALSA device list:
  No soundcards found.

----------------------------------------------------------------------
 fabien - 01-05-06 23:38 
----------------------------------------------------------------------
Wow !
When I enable my SIS 7012 sound card in the bios :

OnBoard AC'97 Sound         Enable
OnBoard AC'97 MODEM         Enable

nothing works !!!

matou:~# dmesg | grep -iE "ALSA|sound|#|ens13|ac97|sis"
Linux version 2.6.15 (root@matou) (gcc version 4.0.3 20051201 (prerelease)
(Debian 4.0.2-5)) #1 PREEMPT Wed Jan 4 21:03:14 CET 2006
Advanced Linux Sound Architecture Driver Version 1.0.10rc3 (Mon Nov 07
13:30:21 2005 UTC).
ALSA device list:
  No soundcards found.
intel8x0_measure_ac97_clock: measured 50628 usecs
ALSA sound/core/init.c:105: cannot find the slot for index 0 (range 0-0)
ENS1371: probe of 0000:00:0b.0 failed with error -12


matou:~# ls -l /proc/asound/
total 1
dr-xr-xr-x 6 root root 0 2006-01-05 23:37 card0
-r--r--r-- 1 root root 0 2006-01-05 23:37 cards
-r--r--r-- 1 root root 0 2006-01-05 23:37 devices
dr-xr-xr-x 2 root root 0 2006-01-05 23:37 oss
-r--r--r-- 1 root root 0 2006-01-05 23:37 pcm
dr-xr-xr-x 2 root root 0 2006-01-05 23:37 seq
lrwxrwxrwx 1 root root 5 2006-01-05 23:37 SI7012 -> card0
-r--r--r-- 1 root root 0 2006-01-05 23:37 timers
-r--r--r-- 1 root root 0 2006-01-05 23:37 version

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
01-04-06 16:41 tiwai          Note Added: 0007425                          
01-05-06 21:18 fabien         Note Added: 0007478                          
01-05-06 23:38 fabien         Note Added: 0007484                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
