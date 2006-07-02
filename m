From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002252]: alsa-base: MIDI playback on
	SB Live! 5.1 0220 combine with heavy disk activity = lockup
Date: Sun, 2 Jul 2006 20:10:29 +0200
Message-ID: <10b5dae366111ccf9410c79bb8c4812b@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id D1CC01A8
	for <alsa-devel@alsa-project.org>;
	Sun,  2 Jul 2006 20:10:29 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2252> 
======================================================================
Reported By:                riesebie
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   2252
Category:                   CORE - rawmidi
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             07-02-2006 18:58 CEST
Last Modified:              07-02-2006 20:10 CEST
======================================================================
Summary:                    alsa-base: MIDI playback on SB Live! 5.1 0220
combine with heavy disk activity = lockup
Description: 
This is a brief Description of Debian bug #376382:
Package: alsa-base
Version: 1.0.11-2
Severity: important


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
Desired=Unknown/In--- Begin /proc/asound/version ---
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
Locale: LANG=en_AU.UTF-8, LC_CTYPE=en_AU.UTF-8
(charmap=UTF-8)stallVersions of packages alsa-base depends on:
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
  alsa-base/alsactl_store_on_shutdown: always autosave/Remove/Purge/Hold
| Status=Not/Installed/Config-files/Unpacked/Failed-config/Half-installed
|/ Err?=(none)/Hold/Reinst-required/X=both-problems (Status,Err:
uppercase=bad)
||/ Name           Version        Description
+++-==============-==============-============================================
ii  libasound2     1.0.11-7       ALSA library
--- End additional package status ---
--- Begin /proc/asound/version ---

======================================================================

----------------------------------------------------------------------
 rlrevell - 07-02-06 19:32 
----------------------------------------------------------------------
Why did you submit a new bug?  You already posted the same information to
bug #952

----------------------------------------------------------------------
 riesebie - 07-02-06 20:10 
----------------------------------------------------------------------
Sorry, I didn't noticed that the Debian bug submitter added a note to #952.
So please feeel free to close or merge 2252.

My appologies ;)

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-02-06 18:58 riesebie       New Issue                                    
07-02-06 19:32 rlrevell       Note Added: 0010793                          
07-02-06 20:10 riesebie       Note Added: 0010794                          
======================================================================



Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
