From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0001082]: 1.0.9rc2: no sound/segfault on ICH4, ICH5
Date: Tue, 24 May 2005 12:33:42 +0200
Message-ID: <9d0f10a81b69ceb1a0239b850d606957@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id CE16C1DF
	for <alsa-devel@alsa-project.org>; Tue, 24 May 2005 12:33:42 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1082> 
======================================================================
Reported By:                mandreiana
Assigned To:                tiwai
======================================================================
Project:                    ALSA - lib
Issue ID:                   1082
Category:                   general
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     resolved
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             04-29-2005 09:12 CEST
Last Modified:              05-24-2005 12:33 CEST
======================================================================
Summary:                    1.0.9rc2: no sound/segfault on ICH4, ICH5
Description: 
Hardware:
00:1f.5 Multimedia audio controller: Intel Corporation 82801EB/ER
(ICH5/ICH5R) AC'97 Audio Controller (rev 02)
        Subsystem: Giga-byte Technology GA-8IPE1000/8KNXP motherboard
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin B routed to IRQ 6
        Region 0: I/O ports at dc00 [size=256]
        Region 1: I/O ports at e000 [size=64]
        Region 2: Memory at e8281000 (32-bit, non-prefetchable)
[size=512]
        Region 3: Memory at e8282000 (32-bit, non-prefetchable)
[size=256]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-


cat /proc/asound/cards
0 [ICH5           ]: ICH4 - Intel ICH5
                     Intel ICH5 with ALC655 at 0xe8281000, irq 6

Applications with alsa output hang or crash, e.g.
aplay /usr/lib/openoffice.org1.9.89/share/gallery/sounds/applause.wav
Segmentation fault

strace:
bind(3, {sa_family=AF_FILE, path="/tmp/alsa-dmix-7840-1114758683-555557"},
39) = 0
chmod("/tmp/alsa-dmix-7840-1114758683-555557", 0600) = 0
listen(3, 4)                            = 0
clone(child_stack=0,
flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD,
child_tidptr=0xb7f90708) = 7841
--- SIGCHLD (Child exited) @ 0 (0) ---
waitpid(7841, NULL, 0)                  = 7841
shmget(221140559, 131072, IPC_CREAT|0600) = 720898
shmat(720898, 0, 0)                     = 0xb7f60000
mlock(0xb7f60000, 131072)               = -1 ENOMEM (Cannot allocate
memory)
ioctl(5, AGPIOC_ACQUIRE or APM_IOC_STANDBY, 0xbffa1fd0) = 0
stat64("/etc/alsa/alsa.conf", {st_mode=S_IFREG|0644, st_size=7467, ...}) =
0
open("/dev/snd/controlC0", O_RDONLY)    = 7
close(7)                                = 0
open("/dev/snd/timer", O_RDONLY|O_NONBLOCK) = 7
ioctl(7, 0x80045400, 0xbffa1d18)        = 0
ioctl(7, SNDCTL_TMR_START or TCSETS, 0xbffa1d14) = 0
ioctl(7, TIOCSPGRP, 0xbffa1ce0)         = 0
ioctl(7, TIOCSTI <unfinished ...>
+++ killed by SIGSEGV +++

======================================================================

----------------------------------------------------------------------
 rlrevell - 04-29-05 19:44 
----------------------------------------------------------------------
This bug has been fixed.  Try 1.0.9-rc3.

----------------------------------------------------------------------
 mandreiana - 05-04-05 07:30 
----------------------------------------------------------------------
Yes, 1.0.9-rc3 works for me, thanks!

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-29-05 09:12 mandreiana     New Issue                                    
04-29-05 19:44 rlrevell       Note Added: 0004580                          
05-04-05 07:30 mandreiana     Note Added: 0004587                          
05-24-05 12:33 tiwai          Status                   new => resolved     
05-24-05 12:33 tiwai          Resolution               open => fixed       
05-24-05 12:33 tiwai          Assigned To               => tiwai           
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7412&alloc_id=16344&op=click
