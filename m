From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000622]: snd-ens1371 hisses and garbled sound
Date: Thu, 11 Nov 2004 13:19:09 +0100
Message-ID: <d217378fea5252c008afa5cc13374508@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id A0F4B26F
	for <alsa-devel@alsa-project.org>; Thu, 11 Nov 2004 13:19:09 +0100 (MET)
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
Last Modified:              11-11-2004 13:19 CET
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
 tiwai - 11-09-04 18:55 
----------------------------------------------------------------------
To be sure, please show the contents of /proc/asound/card0/codec97#0/*
files.  The problematic codec as far as I know is ALC65x.

----------------------------------------------------------------------
 jdthood - 11-11-04 13:19 
----------------------------------------------------------------------
> To be sure, please show the contents of /proc/asound/card0/codec97#0/*
files. 

The submitter provided the following information
------------------------------------------------

$ cat /proc/asound/card0/codec97#0/*
0-0/0: SigmaTel STAC9721/23

Capabilities     :
DAC resolution   : 18-bit
ADC resolution   : 18-bit
3D enhancement   : SigmaTel 3D Enhancement

Current setup
Mic gain         : +20dB [+20dB]
POP path         : pre 3D
Sim. stereo      : off
3D enhancement   : on
Loudness         : off
Mono output      : MIX
Mic select       : Mic1
ADC/DAC loopback : off
Extended ID      : codec=0 rev=0 AMAP DSA=0
Extended status  : SDAC
0:00 = 6940
0:02 = 1010
0:04 = 8000
0:06 = 001f
0:08 = 0000
0:0a = 001e
0:0c = 001f
0:0e = 005f
0:10 = 1f1f
0:12 = 1f1f
0:14 = 1f1f
0:16 = 1f1f
0:18 = 1f1f
0:1a = 0606
0:1c = 0000
0:1e = 0000
0:20 = 2000
0:22 = 0000
0:24 = 0000
0:26 = 000f
0:28 = 0200
0:2a = 0080
0:2c = 0000
0:2e = 0000
0:30 = 0000
0:32 = 0000
0:34 = 0000
0:36 = 0000
0:38 = 0000
0:3a = 0000
0:3c = 0000
0:3e = 0000
0:40 = 0000
0:42 = 0000
0:44 = 0000
0:46 = 0000
0:48 = 0000
0:4a = 0000
0:4c = 0000
0:4e = 0000
0:50 = 0000
0:52 = 0000
0:54 = 0000
0:56 = 0000
0:58 = 0000
0:5a = 0000
0:5c = 0000
0:5e = 0000
0:60 = 0000
0:62 = 0000
0:64 = 0000
0:66 = 0000
0:68 = 0000
0:6a = 0000
0:6c = 00c3
0:6e = 000c
0:70 = 0000
0:72 = 0000


0:74 = 0380
0:76 = 0000
0:78 = 8380
0:7a = 0000
0:7c = 8384
0:7e = 7609

Consider that the problem is currently solved, so I don't know if there 
is anything to see. BTW: I had to shutoff IEC958 for all users, that 
might show that, in deed, it's a KDE problem!?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-01-04 11:29 jdthood        New Issue                                    
11-02-04 21:27 jdthood        Note Added: 0002299                          
11-09-04 18:54 tiwai          Note Added: 0002335                          
11-09-04 18:55 tiwai          Note Added: 0002336                          
11-11-04 13:19 jdthood        Note Added: 0002383                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
