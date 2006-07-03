From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000952]: System freeze at end of MIDI
	playback
Date: Mon, 3 Jul 2006 02:57:54 +0200
Message-ID: <c82cad32c6b9121c07e10e2e55e34ae6@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id A1B2D21E
	for <alsa-devel@alsa-project.org>;
	Mon,  3 Jul 2006 02:57:54 +0200 (MEST)
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


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=952> 
======================================================================
Reported By:                skunk
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   952
Category:                   PCI - emu10k1
Reproducibility:            random
Severity:                   crash
Priority:                   normal
Status:                     new
Distribution:               Debian testing
Kernel Version:             2.6.8-2-k7
======================================================================
Date Submitted:             03-01-2005 06:28 CET
Last Modified:              07-03-2006 02:57 CEST
======================================================================
Summary:                    System freeze at end of MIDI playback
Description: 
Hardware: Sound Blaster Live! Value
Software: sfxload (for patch loading) and drvmidi (playback)

I often play a list of MIDI files. On a number of occasions---either at
the end of a MIDI song, or when I hit STOP---the computer has frozen hard.
The recurrence is rare enough to make this more an annoyance than a
showstopper, but then, I haven't been too keen on ferreting out this bug.

I am reporting this against ALSA from the 2.6.8 kernel, as that is what
I'm using now (Debian official package) but the same problem arose with
alsa-driver 1.0.8 (as compiled by me) on 2.4.29.

I could probably rig up something to start/stop MIDI playback repeatedly,
with a debug-compiled driver, but is there any way to get useful debugging
output when the bug takes the whole system down?
======================================================================

----------------------------------------------------------------------
 amarsh04 - 07-02-06 15:37 
----------------------------------------------------------------------
I'm having the same kind of problem, apparently related to a combination of
MIDI file playback and heavy disk activity:

I initially thought I had a problem with denemo, but was able to 
reproduce a complete system lockup when playing MIDI files, given 
sufficient hard disk activity using:

aplaymidi -p17:0
playmidi -a
kmid

The first 2 were tried under twm, all 3 methods were tried under KDE.

Any suggestions on further debugging steps welcome.

-- Package-specific info:
--- Begin additional package status ---
Desired=Unknown/Install/Remove/Purge/Hold
| Status=Not/Installed/Config-files/Unpacked/Failed-config/Half-installed
|/ Err?=(none)/Hold/Reinst-required/X=both-problems (Status,Err:
uppercase=bad)
||/ Name           Version        Description
+++-==============-==============-============================================
ii  libasound2     1.0.11-7       ALSA library
--- End additional package status ---
--- Begin /proc/asound/version ---
Advanced Linux Sound Architecture Driver Version 1.0.11rc4 (Wed Mar 22
10:27:24 2006 UTC).
--- End /proc/asound/version ---
--- Begin /proc/asound/cards ---
 0 [Live           ]: EMU10K1 - SB Live 5.1 [SB0220]
                      SB Live 5.1 [SB0220] (rev.10, serial:0x80651102) at
0xe400, irq 11
--- End /proc/asound/cards ---
--- Begin /dev/snd/ listing ---
total 0
crw-rw---- 1 root audio 116,  0 2006-07-03 07:51 controlC0
crw-rw---- 1 root audio 116,  4 2006-07-03 07:51 hwC0D0
crw-rw---- 1 root audio 116,  6 2006-07-03 07:51 hwC0D2
crw-rw---- 1 root audio 116,  8 2006-07-03 07:51 midiC0D0
crw-rw---- 1 root audio 116,  9 2006-07-03 07:51 midiC0D1
crw-rw---- 1 root audio 116, 10 2006-07-03 07:51 midiC0D2
crw-rw---- 1 root audio 116, 24 2006-07-03 07:51 pcmC0D0c
crw-rw---- 1 root audio 116, 16 2006-07-03 07:51 pcmC0D0p
crw-rw---- 1 root audio 116, 25 2006-07-03 07:51 pcmC0D1c
crw-rw---- 1 root audio 116, 26 2006-07-03 07:51 pcmC0D2c
crw-rw---- 1 root audio 116, 18 2006-07-03 07:51 pcmC0D2p
crw-rw---- 1 root audio 116, 19 2006-07-03 07:51 pcmC0D3p
crw-rw---- 1 root audio 116,  1 2006-07-03 07:51 seq
crw-rw---- 1 root audio 116, 33 2006-07-03 07:51 timer
--- End /dev/snd/ listing ---

-- System Information:
Debian Release: testing/unstable
  APT prefers unstable
  APT policy: (500, 'unstable'), (500, 'testing'), (500, 'stable')
Architecture: i386 (i686)
Shell:  /bin/sh linked to /bin/bash
Kernel: Linux 2.6.17-1-686
Locale: LANG=en_AU.UTF-8, LC_CTYPE=en_AU.UTF-8 (charmap=UTF-8)

Versions of packages alsa-base depends on:
ii  linux-sound-base           1.0.11-2      base package for ALSA and OSS
soun
ii  lsof                       4.77.dfsg.1-3 List open files
ii  module-init-tools          3.2.2-3       tools for managing Linux
kernel mo
ii  modutils                   2.4.27.0-6    Linux module utilities

Versions of packages alsa-base recommends:
ii  alsa-utils                    1.0.11-4   ALSA utilities

Versions of packages libasound2 depends on:
ii  libc6                         2.3.6-15   GNU C Library: Shared
libraries

-- debconf information:
  alsa-base/alsactl_store_on_shutdown: always autosave

----------------------------------------------------------------------
 amarsh04 - 07-03-06 02:57 
----------------------------------------------------------------------
I also reproduced the bug from text consoles, running "playmidi -a
somefile.mid" in one vt and "aptitude -u" in another.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-01-05 06:28 skunk          New Issue                                    
03-01-05 06:28 skunk          Distribution              => Debian testing  
03-01-05 06:28 skunk          Kernel Version            => 2.6.8-2-k7      
09-19-05 10:10 jdthood        Note Added: 0006287                          
09-19-05 10:19 skunk          Note Added: 0006290                          
04-23-06 07:57 skunk          Note Added: 0009441                          
06-07-06 18:09 pen            Note Added: 0010085                          
06-07-06 18:09 pen            Issue Monitored: pen                         
06-07-06 18:23 rlrevell       Note Added: 0010086                          
06-07-06 19:45 pen            Note Added: 0010087                          
06-07-06 19:50 rlrevell       Note Added: 0010088                          
06-08-06 09:28 skunk          Note Added: 0010109                          
06-27-06 23:35 phorn          File Added: kernel_spinlock-2.6.17.1-nosmp.txt    
               
06-27-06 23:43 phorn          Note Added: 0010602                          
06-28-06 00:03 rlrevell       Note Added: 0010603                          
06-28-06 03:50 phorn          Note Added: 0010605                          
07-02-06 15:33 amarsh04       Issue Monitored: amarsh04                    
07-02-06 15:37 amarsh04       Note Added: 0010791                          
07-02-06 20:07 riesebie       Issue Monitored: riesebie                    
07-03-06 02:57 amarsh04       Note Added: 0010796                          
======================================================================



Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
