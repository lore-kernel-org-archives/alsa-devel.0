From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001726]: Front and Rear channels swap after first play when playing Surround40 on au8830
Date: Thu, 16 Feb 2006 05:37:20 +0100
Message-ID: <a26a39af88f16452ee91e3f28b2e641b@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 06E4D170
	for <alsa-devel@alsa-project.org>; Thu, 16 Feb 2006 05:37:20 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1726> 
======================================================================
Reported By:                Raymond
Assigned To:                mjander
======================================================================
Project:                    ALSA - driver
Issue ID:                   1726
Category:                   PCI - au88x0
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Fedora Core 1
Kernel Version:             2.4.22-1.2199.nptl
======================================================================
Date Submitted:             01-08-2006 17:41 CET
Last Modified:              02-16-2006 05:37 CET
======================================================================
Summary:                    Front and Rear channels swap after first play when
playing Surround40 on au8830
Description: 
The front and rear channels are correct for playing Surround40 only at the
first time after the driver is loaded. 

The front and rear channels (Surround40) always swapped afterward using
speaker-test or xine. 

Playing stereo sound is OK.


 speaker-test -c4 -D hw:0,0
 
speaker-test 1.0.11rc2
 
Playback device is hw:0,0
Stream parameters are 48000Hz, S16_LE, 4 channels
Using 16 octaves of pink noise
Rate set to 48000Hz (requested 48000Hz)
Buffer size range from 2 to 8192
Period size range from 1 to 512
Periods = 4
Buffer time size 2525
To choose buffer_size = 8192
To choose period_size = 2048
was set period_size = 512
was set buffer_size = 8192
 0 - Front Left
 1 - Front Right
 3 - Rear Right
 2 - Rear Left
Time per period = 11.856821
 0 - Front Left
 1 - Front Right
 3 - Rear Right
 2 - Rear Left

======================================================================

----------------------------------------------------------------------
 Raymond - 02-12-06 07:48 
----------------------------------------------------------------------
Just use alsa-1.0.11rc3 to test whether the swapping of front/rear occur is
due to bug in driver instead of different hardware revision as your au8830
chip is B0AAAA.
			
#ifdef CHIP_AU8830
    .channels_max = 4,
#else

speaker-test -t wav -D hw:0,0 -c 4

Do your hear the female voice "front left" and "front right" after the
driver is loaded ?

You will need to quit the speaker-test and run it again.

Do you hear the the female voice "rear left" and "rear right" ?



----------------------------------------------------------------------
 ponchick - 02-16-06 05:37 
----------------------------------------------------------------------
I test this patch with 1.0.11rc3 on my Monster Sound 2. Without patch
channels swaps after first use. Patch fix this issue but there is another
one. When run speaker-test several times in a row it swaps channels in
that order:
Front Left become Front Right
Front Right become Rear Left
Rear Right become Front Left
Rear Left become Rear Right
For reproduce this I just run "speaker-test -t wav -c4 -D hw:0,0" for 3 to
17 times in a row. On next run it restores channel order. 

P.S. lspci -vvn of this card:
02:0a.0 0401: 12eb:0002 (rev fe)
        Subsystem: 1092:3003
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (1000ns min, 3000ns max), Cache Line Size 04
        Interrupt: pin A routed to IRQ 16
        Region 0: Memory at fea80000 (32-bit, non-prefetchable)
[size=256K]
        Region 1: I/O ports at dff0 [size=8]
        Region 2: I/O ports at dfe0 [size=8]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI+ D1- D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-08-06 17:41 Raymond        New Issue                                    
01-08-06 17:41 Raymond        Distribution              => Fedora Core 1   
01-08-06 17:41 Raymond        Kernel Version            => 2.4.22-1.2199.nptl
01-27-06 16:45 Raymond        File Added: au88x0_surround40.patch               
    
02-04-06 06:26 Raymond        Note Added: 0007912                          
02-10-06 05:36 ponchick       Note Added: 0007987                          
02-10-06 06:32 Raymond        Note Added: 0007991                          
02-10-06 10:50 ponchick       Note Added: 0007998                          
02-10-06 11:25 Raymond        Note Added: 0008000                          
02-10-06 13:49 Raymond        Note Added: 0008003                          
02-10-06 13:56 Raymond        Note Edited: 0008003                         
02-12-06 07:48 Raymond        Note Edited: 0008003                         
02-12-06 10:12 Raymond        Note Edited: 0008000                         
02-16-06 05:37 ponchick       Note Added: 0008085                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
