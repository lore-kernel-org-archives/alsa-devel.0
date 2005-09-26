From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001380]: Scratchy Intel HDA
Date: Mon, 26 Sep 2005 09:33:57 +0200
Message-ID: <285c7e2d508873e3e09e859308a32e1a@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 36C4716F
	for <alsa-devel@alsa-project.org>; Mon, 26 Sep 2005 09:33:58 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1380> 
======================================================================
Reported By:                Varanger
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1380
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Ubuntu 5.04 "Hoary Hedgehog"
Kernel Version:             Linux 2.6.11-1-686-smp
======================================================================
Date Submitted:             08-30-2005 20:07 CEST
Last Modified:              09-26-2005 09:33 CEST
======================================================================
Summary:                    Scratchy Intel HDA
Description: 
Hello.

I am getting very scratchy audio in my Intel HDA card besides the sound is
very low.

lspci output is:  

0000:00:1b.0 0403: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 Family)
High Definition Audio Controller (rev 03)

Reading every article I could have found on the net regarding this
card, I discovered that i needed snd-azx (ALSA 1.0.8 ) or
snd-hda-intel modules (ALSA 1.0.9rc* or later).

I have downloaded every sources from 1.0.8 up to 1.0.10rc1 (including
1.0.9 release candidates) from http://www.alsa-project.org, then built and
installed them.

In all those versions, I have followed this steps:
alsa-driver : ./configure --with-oss=yes --with-cards=hda-intel && make &&
make install
library / oss-lib / utils : ./configure && make && make install

I've looked every on the net and found that I could use position_fix=1
or position_fix=2 to help me  but no good either.

I've tried in Ubuntu, Kubuntu, Debian, even Mandriva 2005 LE and
Fedora Core 4 (using the modules from the kernel) and it's the same
problem in all of them.

The card came with the mainboard Intel 915G (D915GEV or 915GEV)  

more info about my soundcard:

Running: "lspci -v" 

0000:00:1b.0 0403: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 Family)
High Definition Audio Controller (rev 03)
        Subsystem: Intel Corp.: Unknown device e200
        Flags: bus master, fast devsel, latency 0, IRQ 16
        Memory at ff43c000 (64-bit, non-prefetchable) [size=16K]
        Capabilities: [50] Power Management version 2
        Capabilities: [60] Message Signalled Interrupts: 64bit+
Queue=0/0 Enable-
        Capabilities: [70] #10 [0091]

/proc/sound/version
Advanced Linux Sound Architecture Driver Version 1.0.9b.
Compiled on Jul  7 2005 for kernel 2.6.10-5-686-smp (SMP).

/proc/asound/devices
 16: [0- 0]: digital audio playback
 24: [0- 0]: digital audio capture
  0: [0- 0]: ctl
 33:       : timer

aplay -l
**** List of PLAYBACK Hardware Devices ****
card 0: Intel [HDA Intel], device 0: ALC880 Analog [ALC880 Analog]
  Subdevices: 1/1
  Subdevice #0: subdevice #0

Thanks for the help,
Varanger
======================================================================

----------------------------------------------------------------------
 jdthood - 09-25-05 12:05 
----------------------------------------------------------------------
Do try loading snd-hda-codec.  Others have reported that this fixes the
crackling problem.

----------------------------------------------------------------------
 chrome - 09-26-05 09:33 
----------------------------------------------------------------------
The codec was loaded.

rlrevell: Do you have any ideas? I guess you don't as you would have asked
me to try them by now.

How can I help you find the problem? Would it help if I found a card with
the same chip/problem in akihabara and sent it to you? Might be different
if it's not in a Sony laptop, but maybe its an idea.

Only thing I can't do is send you the Laptop, as it is not mine. I would
if it was :)

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-30-05 20:07 Varanger       New Issue                                    
08-30-05 20:07 Varanger       Distribution              => Ubuntu 5.04 "Hoary
Hedgehog"
08-30-05 20:07 Varanger       Kernel Version            => Linux
2.6.11-1-686-smp
09-08-05 09:27 cventers       Note Added: 0006070                          
09-12-05 19:02 mico           Note Added: 0006149                          
09-12-05 19:04 mico           Note Edited: 0006149                         
09-13-05 18:26 tiwai          Note Added: 0006154                          
09-15-05 19:19 Varanger       Note Added: 0006218                          
09-16-05 03:35 chrome         Note Added: 0006236                          
09-16-05 04:03 rlrevell       Note Added: 0006237                          
09-16-05 04:49 chrome         Note Added: 0006238                          
09-16-05 05:06 rlrevell       Note Added: 0006239                          
09-16-05 05:14 chrome         Note Added: 0006240                          
09-20-05 04:20 chrome         Note Added: 0006309                          
09-24-05 20:59 crimsunkg      Note Added: 0006378                          
09-24-05 21:44 rlrevell       Note Added: 0006379                          
09-25-05 12:05 jdthood        Note Added: 0006384                          
09-26-05 09:33 chrome         Note Added: 0006389                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
