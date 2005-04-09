From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000543]: Noisy sound, broken mixer with via8235 (driver regression)
Date: Sat, 9 Apr 2005 16:14:19 +0200
Message-ID: <acd5517dbe36a299d6709ecd428b1dfe@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 1A13524F
	for <alsa-devel@alsa-project.org>; Sat,  9 Apr 2005 16:14:20 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=543> 
======================================================================
Reported By:                obsidian
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   543
Category:                   PCI - via82xx
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Debian Sarge
Kernel Version:             2.6.8-1-k7
======================================================================
Date Submitted:             09-25-2004 23:15 CEST
Last Modified:              04-09-2005 16:14 CEST
======================================================================
Summary:                    Noisy sound, broken mixer with via8235 (driver
regression)
Description: 
Sound is "shimmery" or "staticky" - noticeably bad. Mixer "master volume"
has no effect. "PCM volume" cannot be adjusted. "DXS
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1" volume has an
effect but not "correct" - i.e. zero != silent. I do get the message (at
boot): 

via82xx: Assuming DXS channels with 48k fixed sample rate.
         Please try dxs_support=1 or dxs_support=4 option
         and report if it works on your machine.

This is a big prob. on this particular machine, which is supposed to
connect to the stereo and play mp3s, among other things.

Sound works normally outside Linux, and in Linux 2.4 with some Alsa 0.9.*.
But with Linux 2.6 and alsa 1.0.5/6, bleah.

I have been googling and troubleshooting all day. Here's what I've already
tried:

dxs_support=1, 2, 3 and 4 

This makes zero difference, so I thought I might be doing it wrong; I
tried it in modprobe.conf, modprobe.d/sound, and manually as an argument
to modprobe, i.e. "modprobe snd-via82xx dxs_support=1", also with both
rmmod'ing all alsa-related modules and rebooting altogether. 

Is there any way to tell if a dxs_support or other argument has been acted
on? It really felt like they were all ignored. I could never get that
original message to happen anytime but at boot, not matter what I did.
modprobe -v did show an "insmod" line with the parameter(s) on it,
though.

ac97_quirk=0,1,2,3,4

No effect.

Various kernel boot parameters, both alone and in combination with the
above:

noapic, nolapic, acpi=off, and pci=noacpi.

No effect. (BTW, I am currently running with all 4.) 

Frustrating, because it seemed from searching a great many people have the
exact same problem I do, but none of the many, varying "worked for me"
answers have helped me.

I'm a developer, somewhat kernel-savvy, and at your disposal. What do we
try first?
======================================================================

----------------------------------------------------------------------
 tiwai - 10-13-04 10:48 
----------------------------------------------------------------------
As another FAQ, if you have 'IEC958 Input Monitor' is on, turn it off.

----------------------------------------------------------------------
 jdthood - 04-09-05 16:14 
----------------------------------------------------------------------
Submitter: Have you made any progress in solving this problem?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-25-04 23:15 obsidian       New Issue                                    
09-25-04 23:15 obsidian       Distribution              => Debian Sarge    
09-25-04 23:15 obsidian       Kernel Version            => 2.6.8-1-k7      
09-26-04 01:09 obsidian       Note Added: 0001913                          
09-26-04 01:24 obsidian       Note Added: 0001914                          
09-26-04 02:27 obsidian       Note Added: 0001915                          
10-11-04 15:13 SirPreme       Note Added: 0002078                          
10-11-04 15:56 tiwai          Note Added: 0002080                          
10-12-04 02:06 obsidian       Note Added: 0002086                          
10-12-04 13:06 tiwai          Note Added: 0002090                          
10-13-04 04:49 obsidian       Note Added: 0002109                          
10-13-04 10:48 tiwai          Note Added: 0002116                          
04-09-05 16:14 jdthood        Note Added: 0004408                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
