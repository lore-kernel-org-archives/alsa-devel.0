From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000543]: Noisy sound, broken mixer with via8235 (driver regression)
Date: Sat, 25 Sep 2004 23:15:06 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040925211506.17BB425017@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 705B22BF
	for <alsa-devel@alsa-project.org>; Sat, 25 Sep 2004 23:15:06 +0200 (MEST)
Received: from server.perex-int.cz (server.perex-int.cz [192.168.100.2])
	by gate.perex-int.cz (Perex's E-mail Delivery System) with ESMTP id 2F03025F67
	for <alsa-devel@alsa-project.org>; Sat, 25 Sep 2004 23:15:06 +0200 (MEST)
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


The following bug has been SUBMITTED.
======================================================================
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000543
======================================================================
Reported By:                obsidian
Assigned To:                
======================================================================
Project:                    ALSA - driver
Bug ID:                     543
Category:                   PCI - via82xx
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Debian Sarge
Kernel Version:             2.6.8-1-k7
======================================================================
Date Submitted:             09-25-2004 23:15 CEST
Last Modified:              09-25-2004 23:15 CEST
======================================================================
Summary:                    Noisy sound, broken mixer with via8235 (driver regression)
Description: 
Sound is "shimmery" or "staticky" - noticeably bad. Mixer "master volume"
has no effect. "PCM volume" cannot be adjusted. "DXS https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000001" volume has an
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

Bug History
Date Modified  Username       Field                    Change              
======================================================================
09-25-04 23:15 obsidian       New Bug                                      
09-25-04 23:15 obsidian       Distribution              => Debian Sarge    
09-25-04 23:15 obsidian       Kernel Version            => 2.6.8-1-k7      
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
