From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000543]: Noisy sound, broken mixer with via8235 (driver regression)
Date: Wed, 28 Dec 2005 14:55:19 +0100
Message-ID: <3264c5c58812382c95a9355ce341adf2@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 04153189
	for <alsa-devel@alsa-project.org>; Wed, 28 Dec 2005 14:55:19 +0100 (MET)
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
Last Modified:              12-28-2005 14:55 CET
======================================================================
Summary:                    Noisy sound, broken mixer with via8235 (driver
regression)
Description: 
Sound is "shimmery" or "staticky" - noticeably bad. Mixer "master volume"
has no effect. "PCM volume" cannot be adjusted. "DXS #1" volume has an
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
 jdthood - 04-09-05 16:14 
----------------------------------------------------------------------
Submitter: Have you made any progress in solving this problem?

----------------------------------------------------------------------
 zooko - 12-28-05 14:55 
----------------------------------------------------------------------
I have a similar problem.  There is a fuller report of my problem here:

https://launchpad.net/products/alsa-driver/+bug/6032

Other bugs on bugtrack.alsa-project.org that are possibly related are:

https://bugtrack.alsa-project.org/alsa-bug/view.php?id=257
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=651
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1603
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1667
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1622
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1667

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
12-28-05 14:55 zooko          Note Added: 0007176                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
