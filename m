From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000752]: ALSA > 1.0.5a does not load, failed with error -16
Date: Wed, 16 Mar 2005 05:19:20 +0100
Message-ID: <fbe9a7fd83c39e8888ebe46e6396ce40@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id C77CF227
	for <alsa-devel@alsa-project.org>; Wed, 16 Mar 2005 05:19:20 +0100 (MET)
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
Last Modified:              03-16-2005 05:19 CET
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

----------------------------------------------------------------------
 Q3Man - 03-16-05 04:53 
----------------------------------------------------------------------
I went through and commented those lines out, recompiled and reinstalled.
There was no change. 

I then went through and put printf("something succeeded"); after every
loading block above the midi, but I never got any output when I load the
module. To be sure I was actually loading the recompiled module, I changed
some of the modinfo text defined in the top, and modinfo did pick up on it
so I am properly loading the recompiled module. 

I'm afraid I'm not too familiar with kernel modules, so what I put in for
the printf may not have been appropriate. I noticed some printk's earlier,
so I tried those with no success. I also checked all my system logs and
there was no new output related to the changes I made. I was going to try
the snd_printk() function, but the proper syntax wasn't immediately
apparent. 

So either its dying before it gets to those calls, or I have added them
inappropriately. In any event, the commented out midi code doesn't appear
to be the point of failure.

----------------------------------------------------------------------
 Q3Man - 03-16-05 05:19 
----------------------------------------------------------------------
Well, I have some more good news :)

Just booted under knoppix 3.8. Aside from it detecting the card
incorrectly and loading it with EMU10k1 (which didn't work anyway), when I
modprobe'd snd-emu10k1x, it dies with the exact same error. 

For a while I thought I had some weird setting in a config somewhere that
was causing it to fail. I feel a bit more relieved that knoppix fails in
the same way... although that still doesn't help me much :)

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-28-04 05:12 Q3Man          New Issue                                    
12-28-04 05:12 Q3Man          File Added: einfo                            
12-28-04 05:12 Q3Man          Distribution              => Gentoo          
12-28-04 05:12 Q3Man          Kernel Version            => 2.6.9-gentoo-r9 
12-28-04 05:22 Q3Man          Issue Monitored: Q3Man                       
01-03-05 12:10 tiwai          Note Added: 0003054                          
01-03-05 12:39 eradicator     Issue Monitored: eradicator                    
01-03-05 17:30 Q3Man          Note Added: 0003071                          
01-16-05 14:54 fmoraes        Note Added: 0003216                          
01-18-05 00:44 Q3Man          Note Added: 0003240                          
01-20-05 02:23 Q3Man          Note Added: 0003322                          
01-20-05 19:12 tiwai          Note Added: 0003332                          
01-21-05 05:11 Q3Man          Note Added: 0003337                          
01-21-05 11:14 tiwai          Note Added: 0003341                          
01-22-05 23:24 fmoraes        Note Added: 0003382                          
03-09-05 02:57 fmoraes        Note Added: 0003821                          
03-15-05 17:34 Q3Man          Note Added: 0003916                          
03-15-05 22:32 Q3Man          Note Added: 0003918                          
03-16-05 02:09 fmoraes        Note Added: 0003927                          
03-16-05 03:32 Q3Man          Note Added: 0003930                          
03-16-05 04:06 fmoraes        Note Added: 0003931                          
03-16-05 04:53 Q3Man          Note Added: 0003932                          
03-16-05 05:19 Q3Man          Note Added: 0003933                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
