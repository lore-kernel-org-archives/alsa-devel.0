From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000014]: No sound from external speakers (laptop)
Date: Fri, 24 Jun 2005 08:54:49 +0200
Message-ID: <c64dce5055b2496640a2b70fe8b2df3a@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id DBDDE231
	for <alsa-devel@alsa-project.org>; Fri, 24 Jun 2005 08:54:49 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=14> 
======================================================================
Reported By:                user74
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   14
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               Debian Sid updated
Kernel Version:             2.4.24-ck1
======================================================================
Date Submitted:             01-29-2004 20:15 CET
Last Modified:              06-24-2005 08:54 CEST
======================================================================
Summary:                    No sound from external speakers (laptop)
Description: 
On my laptop (acer272xv) I can't use external output with my Creative 2.1,
because I can't hear anything.
I've tryied with other external speaker and with other releases of
alsa-driver, but there's no difference.


======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
has duplicate       0000664 ac97_quirk with SIS 7012 [ALC202] don't...
======================================================================

----------------------------------------------------------------------
 dale - 06-22-05 19:50 
----------------------------------------------------------------------
Hi wenton, do you have any more information on your configuration?
I only have /dev/dsp, not /dev/dsp0 /dev/dsp1 etc.  I am using UDEV if it
helps.

So are you saying you have actually managed to get the headphone port to
work with this configuration?

Many Thanks,

Dale

----------------------------------------------------------------------
 wenton - 06-24-05 08:54 
----------------------------------------------------------------------
Hi Dale,

Well, first off, if I understand correctly, (someone else please
verify/correct me), UDEV only manages hotplug devices, but I did find an
excerpt from 'man udev' that might be useful:

   # sound card with PCI bus id 00:0b.0 to be called dsp
   BUS="pci", ID="00:0b.0", NAME="dsp"

but I have to admit, I don't know enough about udev to know how to use
that information.  There were a few other things in that man page that
suggested that various device files are managed by udev, so that might be
why your /dev/dsp[0-3] could be missing.  (I don't want to polute things
by posting it into here.)

As for my own configuration, on a Compaq M2010, I am using Slackware 10.0
which comes with ALSA1.0.5a.  I simply allowed alsaconf to detect and
configure everything on it's own.  When I do 'ls -l /proc/asound' I find:

   I82801DBICH4 -> card1
   Modem -> card0
   (and other stuff)

So at least I can verify what I thought earlier, about ALSA detecting the
modem as card0 and the audio ports as card1.  Also, looking at
/proc/asound/cards tells me about the same thing.

Another thought, and again I'm looking for someone to verify/correct me, I
believe the /dev/dsp? files are OSS-related, and if you have OSS
compatibility turned off, that might explain why those files aren't on
your system.

My laptop only has a mic input and lineout/headphone out, but it does seem
to be working just fine.  I think ALSA only wants to set mixer settings
specifically for /dev/dsp0 (somewhere in rc.alsa?) so I have to manually
set my mixer settings every reboot, so I added that to my rc.local, but at
least it does work.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-29-04 20:15 user74         New Issue                                    
01-29-04 20:15 user74         File Added: details.txt                      
01-30-04 12:44 tiwai          Note Added: 0000049                          
01-30-04 17:56 sparkyva       Note Added: 0000063                          
01-30-04 17:56 sparkyva       Issue Monitored: sparkyva                    
01-30-04 20:41 sparkyva       Note Added: 0000070                          
01-30-04 22:01 jorge2         Note Added: 0000071                          
02-02-04 19:37 jorge2         Note Added: 0000119                          
02-04-04 20:00 tiwai          Note Added: 0000165                          
02-04-04 20:01 tiwai          Note Added: 0000166                          
02-04-04 20:52 jorge2         Note Added: 0000169                          
02-04-04 20:52 jorge2         Note Added: 0000170                          
02-04-04 20:53 jorge2         Note Deleted: 0000169                        
02-05-04 13:52 matsgora       Note Added: 0000181                          
02-05-04 14:05 dale           Note Added: 0000182                          
02-26-04 13:07 rocco          Note Added: 0000347                          
02-26-04 18:16 matsgora       Note Added: 0000358                          
02-26-04 18:20 tiwai          Note Added: 0000359                          
03-01-04 10:31 dale           Note Added: 0000401                          
03-05-04 19:49 tiwai          Note Added: 0000513                          
03-05-04 20:37 jorge2         Note Added: 0000515                          
03-06-04 18:20 matsgora       Note Added: 0000520                          
03-07-04 16:30 dale           Note Added: 0000524                          
03-09-04 15:15 tiwai          Note Added: 0000547                          
03-09-04 18:12 matsgora       Note Added: 0000551                          
06-08-04 20:25 jorge2         Note Added: 0001296                          
06-15-04 15:00 mcbridematt    Note Added: 0001308                          
11-22-04 18:48 tiwai          Relationship added       has duplicate 0000664
02-02-05 14:25 dale           Note Added: 0003488                          
02-04-05 13:18 tiwai          Note Added: 0003504                          
02-04-05 13:19 tiwai          File Added: ac97-alc-fix.diff                    
02-04-05 18:03 jorge2         Note Added: 0003512                          
02-05-05 13:27 jorge2         Issue Monitored: jorge2                      
02-21-05 09:16 dale           Note Added: 0003678                          
02-23-05 09:54 dale           Issue Monitored: dale                        
06-14-05 21:20 graf_eichbaum  Issue Monitored: graf_eichbaum                    
06-20-05 06:48 wenton         Note Added: 0005093                          
06-22-05 19:50 dale           Note Added: 0005145                          
06-24-05 08:54 wenton         Note Added: 0005204                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
