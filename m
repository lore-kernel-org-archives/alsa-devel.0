From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000543]: Noisy sound, broken mixer with via8235 (driver regression)
Date: Mon, 11 Oct 2004 15:13:27 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20041011131327.0F15BD00D@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 7B0D12C6
	for <alsa-devel@alsa-project.org>; Mon, 11 Oct 2004 15:13:27 +0200 (MEST)
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


A BUGNOTE has been added to this bug.
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
Last Modified:              10-11-2004 15:13 CEST
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

----------------------------------------------------------------------
 obsidian - 09-26-2004 01:09 CEST 
----------------------------------------------------------------------
Still no solution, but there are new details.

By loading snd-via82xx from /etc/modules, and putting the driver options
on the line in that file, I was finally able to get them to take effect
(i.e. items available in the mixer would change, 48k message wouldn't
display, etc). I ran through the tests again (rebooting every time) with
different values of dxs_settings and ac97_quirk. 

ac97_quirk seemed to have no effect anyway.

By varying dxs_settings I observed dxs volume controls disappearing from
alsamixer with some values. Otherwise everything was the same ("shimmery"
sound, master volume ignored, etc) and so this only had the effect of
making it impossible to influence the volume altogether.

----------------------------------------------------------------------
 obsidian - 09-26-2004 01:24 CEST 
----------------------------------------------------------------------
One more thing: I observed this in alsamixer. Surprised it hasn't popped up
in too many other places, but I noticed that the chip (CM9739) correlates
exactly with the same mixer issues I'm having:

Card: VIA 8235
Chip: C-Media Electronics CMI9739

See:
http://www.mail-archive.com/alsa-user@lists.sourceforge.net/msg10120.html

This doesn't overlap with sound quality issues, however.

----------------------------------------------------------------------
 obsidian - 09-26-2004 02:27 CEST 
----------------------------------------------------------------------
I upgraded to the current BIOS. No effect.

----------------------------------------------------------------------
 SirPreme - 10-11-2004 15:13 CEST 
----------------------------------------------------------------------
I have the same problem and I couldn't find a way to solve this. I'm using
a via82xx, too.

This is what makes it working on 2.4, I think:
If you compile OSS together with your soundcard into the kernel (or as a
module), it works fine, but then you donnot use real ALSA.. :/

Please, fix this bug..

Bug History
Date Modified  Username       Field                    Change              
======================================================================
09-25-04 23:15 obsidian       New Bug                                      
09-25-04 23:15 obsidian       Distribution              => Debian Sarge    
09-25-04 23:15 obsidian       Kernel Version            => 2.6.8-1-k7      
09-26-04 01:09 obsidian       Bugnote Added: 0001913                       
09-26-04 01:24 obsidian       Bugnote Added: 0001914                       
09-26-04 02:27 obsidian       Bugnote Added: 0001915                       
10-11-04 15:13 SirPreme       Bugnote Added: 0002078                       
======================================================================


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
