From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000752]: ALSA > 1.0.5a does not load, failed with error -16
Date: Tue, 28 Dec 2004 05:12:11 +0100
Message-ID: <e16ceff147ca5c2b862e246a23bfb1a2@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 8C99F268
	for <alsa-devel@alsa-project.org>; Tue, 28 Dec 2004 05:12:11 +0100 (MET)
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


The following issue has been SUBMITTED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=752> 
======================================================================
Reported By:                Q3Man
Assigned To:                fmoraes
======================================================================
Project:                    ALSA - driver
Issue ID:                   752
Category:                   PCI - emu10k1x
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Gentoo
Kernel Version:             2.6.9-gentoo-r9
======================================================================
Date Submitted:             12-28-2004 05:12 CET
Last Modified:              12-28-2004 05:12 CET
======================================================================
Summary:                    ALSA > 1.0.5a does not load, failed with error -16
Description: 
I'm having some problems with alsa since 1.0.6a. Previously I just had the
later versions masked, but now various kde packages require the latest
alsa, so I'm having to tackle it now. ALSA seems to start normally,
however I get this error in dmesg: 
EMU10K1X: probe of 0000:00:09.0 failed with error -16. 

I also get this error when running alsamixer: 
alsamixer: function snd_ctl_open failed for default: No such device 

And similar ones in other alsa programs. 

Again, 1.0.5a runs fine, 1.0.6a and above do not. I've taken a look at the
code and it seems that the error is vaguely interrupt related, but I could
not find the code that produces error -16. I've swapped interrupts around
and disabled non-essential devices (usb, serial, parallel ports, removed
network cards and sound cards - although that last one proved slightly
less than helpful :) I've changed from having my bios manage irq's to
having the OS handle them with zero success. 

I've looked around for that error code in google for the last few weeks -
since the release of 1.0.6a with limited success. Nothing relevant to my
situation. 

Important configs and error messages:
$ lspci -v |grep audio -A4
0000:00:09.0 Multimedia audio controller: Creative Labs [SB Live! Value]
EMU10k1X
        Subsystem: Creative Labs: Unknown device 1003
        Flags: bus master, medium devsel, latency 32, IRQ 12
        I/O ports at d000
        Capabilities: [dc] Power Management version 2
(It is an actual EMU10k1X and not the Dell bastardized version)

$ /etc/init.d/alsasound start; dmesg |tail -n1
 * Loading ALSA drivers...
 * Using ALSA OSS emulation
 * Loading: snd-mixer-oss
 * Loading: snd-pcm-oss
 * Loading: snd-seq-oss
 * Running card-dependent scripts
 * Restoring Mixer Levels                                                
[ ok ]
EMU10K1X: probe of 0000:00:09.0 failed with error -16

$ uname -a
Linux tobin1 2.6.9-gentoo-r9
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1 Mon Dec 27 16:06:33 PST
2004 i686 AMD
Athlon(tm) XP 2500+ AuthenticAMD GNU/Linux

If anyone needs any other config information, please let me know. Again,
it works perfectly fine in 1.0.5a, the problems only appear in later
versions.

======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-28-04 05:12 Q3Man          New Issue                                    
12-28-04 05:12 Q3Man          File Added: einfo                            
12-28-04 05:12 Q3Man          Distribution              => Gentoo          
12-28-04 05:12 Q3Man          Kernel Version            => 2.6.9-gentoo-r9 
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
