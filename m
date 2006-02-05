From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001765]: Issue 001595 does not fix Audigy 4
Date: Sun, 5 Feb 2006 13:25:09 +0100
Message-ID: <f77468aa7851c22d1f0599873f135214@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 6E3C01B7
	for <alsa-devel@alsa-project.org>; Sun,  5 Feb 2006 13:25:09 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1765> 
======================================================================
Reported By:                alexholkner
Assigned To:                jcdutton
======================================================================
Project:                    ALSA - driver
Issue ID:                   1765
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     feedback
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             01-21-2006 01:49 CET
Last Modified:              02-05-2006 13:25 CET
======================================================================
Summary:                    Issue 001595 does not fix Audigy 4
Description: 
I have an Audigy 4 with the same device/subsystem as khampf from issue
1595.  I applied his patch, but it does NOT work unless I change
.ca0102_chip = 1 to .ca0108_chip = 1.

I did experience the same confusion where loading one driver with ca0108
will make any subsequent driver work (e.g., ca0102) until the next reboot.
======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
related to          0001595 Audigy 4 (bulk, non-Pro) unsupported (p...
======================================================================

----------------------------------------------------------------------
 jcdutton - 01-22-06 00:19 
----------------------------------------------------------------------
Please note that some settings on the sound card can survive a warm
reboot.
When testing, please cold reboot. I.e. Power off the PC.
So, happily do modprobe/rmmod to test the patches, but then do a final
cold reboot to double check it BEFORE posting anything more to this bug
report.

By default, without any patches, the following will be applied:
        {.vendor = 0x1102, .device = 0x0008,
         .driver = "Audigy2", .name = "Audigy 2 Value [Unknown]", 
         .id = "Audigy2",
         .emu10k2_chip = 1,
         .ca0108_chip = 1,
         .ac97_chip = 1} ,

So, if for "fix" is exactly the same as that, it is not a fix at all. :-)

If you do find another options that works reliably after a cold reboot,
please post the entire record, not just one line of it.

Do not try the options:
         .ca_cardbus_chip = 1,
         .spi_dac = 1,
Something that might be worth trying could be adding:
         .spk71 = 1,

Also, if one does post a new record for the card, please also include the
output of:
cat /proc/asound/version
cat /proc/asound/cards

Thank you


----------------------------------------------------------------------
 jprk - 02-05-06 13:25 
----------------------------------------------------------------------
As 0001595 has been closed, I would just like to confirm, that Audigy 4
_partially_ works with entry

{.vendor = 0x1102, .device = 0x0008,
 .driver = "Audigy2", .name = "Audigy 2 Value [Unknown]", 
 .id = "Audigy2",
 .emu10k2_chip = 1,
 .ca0108_chip = 1,
 .ac97_chip = 1}

I have a 5.1 speaker set and I do not get sound from front left and front
right speakers. I tried to set up reasonable levels on every output with
alsamixer, but without success. I tried patching the Audigy 2 entry in
emu10k1_main.c to specify .spk71 = 1 - it did not have any influence.
Replugging front left/right minijack from its corresponding socket (L1)
into the center/subwoofer socket (L3) as reported by 'kjes' in discussion
for 0001595 is not a solution as then I loose subwoover and central
speaker.  

I am now running unpathced 2.6.15.2 on AMD-64 (64-bit kernel) with Audigy
4 being the first of two soundcards (the second one is an integrated AC97
clone on the motherboard). 

-----
cat /proc/asound/version:
Advanced Linux Sound Architecture Driver Version 1.0.10rc3 (Mon Nov 07
13:30:21 2005 UTC).

(I had exactly the same experience with 1.0.11rc2 and kernel 2.6.12)

-----
cat /proc/asound/cards:
0 [Audigy2        ]: Audigy2 - Audigy 2 Value [Unknown]
                     Audigy 2 Value [Unknown] (rev.0, serial:0x10211102)
at 0xdf00, irq 217
1 [CK804          ]: NFORCE - NVidia CK804
                     NVidia CK804 with ALC850 at 0xfebfd000, irq 233

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-21-06 01:49 alexholkner    New Issue                                    
01-22-06 00:06 jcdutton       Status                   new => assigned     
01-22-06 00:06 jcdutton       Assigned To               => jcdutton        
01-22-06 00:06 jcdutton       Relationship added       related to 0001595  
01-22-06 00:19 jcdutton       Note Added: 0007741                          
01-22-06 00:19 jcdutton       Status                   assigned => feedback
02-05-06 13:25 jprk           Note Added: 0007933                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
