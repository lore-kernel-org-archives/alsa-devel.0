From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000752]: ALSA > 1.0.5a does not load, failed with error -16
Date: Fri, 1 Apr 2005 05:57:41 +0200
Message-ID: <0adc73fb2c1fbbc46d0cd6d1743b1b31@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 7CF6021D
	for <alsa-devel@alsa-project.org>; Fri,  1 Apr 2005 05:57:41 +0200 (MEST)
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


The following issue has been CLOSED
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
Status:                     closed
Distribution:               Gentoo
Kernel Version:             2.6.9-gentoo-r9
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             12-28-2004 05:12 CET
Last Modified:              04-01-2005 05:57 CEST
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
 Q3Man - 04-01-05 04:47 
----------------------------------------------------------------------
Well, looks like you did it!

I've confirmed that 1.0.9-rc2 works flawlessly. Gentoo installs alsa
kernel modules in a different location than 'make install' does, leading
to two copies of the modules in /lib/modules/x.x.x.kernel/ and the older
ones were loading. I removed the older modules and updated the module
cache and everything works perfectly. 

Looks like this can finally be closed as fixed.

----------------------------------------------------------------------
 fmoraes - 04-01-05 05:56 
----------------------------------------------------------------------
Fixed in ALSA 1.09rc2

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
03-17-05 01:45 fmoraes        Note Added: 0003976                          
03-17-05 03:20 Q3Man          Note Added: 0003977                          
03-18-05 02:07 fmoraes        Note Added: 0003988                          
03-18-05 02:43 Q3Man          Note Added: 0003989                          
03-18-05 03:41 Q3Man          Note Added: 0003990                          
03-18-05 21:17 fmoraes        Note Added: 0004005                          
03-18-05 23:48 Q3Man          Note Added: 0004007                          
03-19-05 21:00 fmoraes        Note Added: 0004069                          
03-20-05 08:00 Q3Man          Note Added: 0004073                          
03-20-05 08:17 Q3Man          Note Added: 0004074                          
03-20-05 15:26 fmoraes        Note Added: 0004091                          
03-20-05 19:19 Q3Man          Note Added: 0004097                          
03-21-05 00:12 fmoraes        Note Added: 0004107                          
03-21-05 01:16 Q3Man          Note Added: 0004108                          
03-21-05 01:36 Q3Man          Note Added: 0004109                          
03-21-05 01:40 Q3Man          Note Added: 0004110                          
03-22-05 13:42 fmoraes        Note Added: 0004124                          
03-25-05 23:10 fmoraes        Note Added: 0004213                          
03-26-05 03:38 Q3Man          Note Added: 0004217                          
03-30-05 00:35 Q3Man          Note Added: 0004260                          
03-30-05 00:47 Q3Man          Note Added: 0004261                          
03-31-05 18:40 fmoraes        Note Added: 0004283                          
04-01-05 00:19 jbedwani       Note Added: 0004288                          
04-01-05 04:47 Q3Man          Note Added: 0004289                          
04-01-05 05:56 fmoraes        Status                   assigned => resolved
04-01-05 05:56 fmoraes        Resolution               open => fixed       
04-01-05 05:56 fmoraes        Note Added: 0004290                          
04-01-05 05:57 fmoraes        Status                   resolved => closed  
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by Demarc:
A global provider of Threat Management Solutions.
Download our HomeAdmin security software for free today!
http://www.demarc.com/Info/Sentarus/hamr30
