From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001595]: Audigy 4 (bulk, non-Pro) unsupported (patch included)
Date: Sun, 22 Jan 2006 00:06:37 +0100
Message-ID: <b4567a4db7e728c035d66b5a3dc0bd24@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 7DAEE198
	for <alsa-devel@alsa-project.org>; Sun, 22 Jan 2006 00:06:37 +0100 (MET)
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


The following issue has been set as RELATED TO issue 0001765.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1595> 
======================================================================
Reported By:                khampf
Assigned To:                jcdutton
======================================================================
Project:                    ALSA - driver
Issue ID:                   1595
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     closed
Distribution:               Debian 3 testing/unstable hybrid
Kernel Version:             2.6.14.2-c0r3 (-ckX+swsusp2+bootsplash)
Resolution:                 open
Fixed in Version:           
======================================================================
Date Submitted:             11-24-2005 03:35 CET
Last Modified:              01-15-2006 23:05 CET
======================================================================
Summary:                    Audigy 4 (bulk, non-Pro) unsupported (patch
included)
Description: 
I recently bought me a Creative Audigy 4 and was surprised it didn't work
at all ... I noticed it wasn't detected and made it detectable and copied
the settings from Audigy 4 Pro. I have to click the "Audigy Analog/Digital
Output switch" switch to make it work. Front/Center, Mic works, however I
have no idea about wether SPDIF is ok or not (I have no devices). It might
be that a lot of functionality is missing still but it's a start.

First, output of "$ lspci -vn | grep -1 0401"
0000:02:09.0 0401: 1102:0008
        Subsystem: 1102:1021

Then, using "modprobe emu10k1 sumsystem=xxxxxx" does not work at all for
me, doesn't get the interrupt up and errors about probe failing.

So I added did this to my kernel sound/pci/emu10k1/emu10k1_main.c:

	{.vendor = 0x1102, .device = 0x0008, .subsystem = 0x10211102,
	 .driver = "Audigy2", .name = "Audigy 4 [A400?]", 
	 .id = "Audigy2",
	 .emu10k2_chip = 1,
	 .ca0102_chip = 1,
	 /*.ca0151_chip = 1, */
	 /*.spk71 = 1,	*/
	 /*.spdif_bug = 1,*/
	 .ac97_chip = 1} ,

I left those commented out as I've tried the options and noticed no
difference in operation. Also, I don't know the SB0xxx model (can't remove
the card and look at it at the moment either).
======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
related to          0001765 Issue 001595 does not fix Audigy 4
======================================================================

----------------------------------------------------------------------
 khampf - 11-24-05 03:41 
----------------------------------------------------------------------
One thing I didn't mention. With the standard driver this card got detected
as "Audigy 2 Value [Unknown]" and the mixers looked ok ... but it was
impossible to get sound out of it even if it looked allright.

----------------------------------------------------------------------
 jcdutton - 11-24-05 21:54 
----------------------------------------------------------------------
In your above patch, if you change
.ca0102_chip = 1,
to
.ca0108_chip = 1,


Does it still work?

----------------------------------------------------------------------
 khampf - 11-26-05 22:33 
----------------------------------------------------------------------
I can't seem to access this bugtracker at times ... the route seems to go
down often (nothing wrong on my side).

Ok I posted a bit prematurely, there seems to be more to it than just
ca0102_chip ... because ca0108_chip had been on in a previously loaded
module, it worked with just 102. However on a cold restart it did not. It
needs something from both 102 and 108?!?! I started testing by re-enabling
things. This loads perfectly:

	 .driver = "Audigy2", .name = "Audigy 4 [A400?]", 
	 .id = "Audigy2",
	 .emu10k2_chip = 1,
	 .ca0102_chip = 1,
	 .ca0108_chip = 1,
	 .ca0151_chip = 1,
	 .spk71 = 1,
	 /* .spdif_bug = 1, */
	 .ac97_chip = 1} ,

However, if the different chip ca's, 102 and 108 are actual chips this
seems like a bad idea, chanses are that it uses ca108 but needs something
from 102 to route the sound correctly ... but this way everyhting works
correctly from first load of the module so it's another step in the right
direction.

----------------------------------------------------------------------
 BerndBuechs - 11-29-05 22:56 
----------------------------------------------------------------------
I think I have the same card, on mine you can read
Sound Blaster Audigy 4
Model: SB0610

----------------------------------------------------------------------
 jcdutton - 12-22-05 13:28 
----------------------------------------------------------------------
Can you please provide me with more information regarding the card.
You will have to remove the card to find this information.
What is written on the following chips:
1) The main big one. It will have something like CA0108 or something
similar.
2) DAC. It will have a number starting CS or WM.
3) ADC. It will have a number starting CS or WM.
4) AC97 chip. This should appear in alsamixer next to "Chip:"

I assume the card has written on is SB0610.

----------------------------------------------------------------------
 jcdutton - 12-22-05 13:29 
----------------------------------------------------------------------
Also, is the a chip with "CA0151" marked on it?

----------------------------------------------------------------------
 khampf - 12-22-05 15:07 
----------------------------------------------------------------------
I will remove the card and take a look at it when I get back from holidays
(early January). I'll document the different chips and also take some
photos of it and put online. I would have done this earlier but have had
no means of removing the card before.

Right now my driver seems to contain only:

{.vendor = 0x1102, .device = 0x0008, .subsystem = 0x10211102,
         .driver = "Audigy2", .name = "Audigy 4 [SB0610]", 
         .id = "Audigy2",
         .emu10k2_chip = 1,
         .ca0102_chip = 1, 
         /* .ca0108_chip = 1, */
         /* .ca0151_chip = 1, */
         /* .spk71 = 1, */
         /* .spdif_bug = 1, UNTESTED, might be needed */
         .ac97_chip = 1} ,

And this seems to work ... this is of course irrelevant until one knows
exactly what IC's there are on the card. I'll get the info for you, until
then, Happy Holidays

----------------------------------------------------------------------
 jcdutton - 12-22-05 20:22 
----------------------------------------------------------------------
I think I have found a picture. Is this your card:
http://images.europe.creative.com/iss/images/artwork/A5_RGB/audigy_4_c.jpg
Note that the picture shows:
DSP: CA10300-IAT  (The bigest chip)
ADC: Philips 1361T (Small chip above the DSP)
DAC: Cirrus Logic CS4382-KQZ (small chip to the left of the DSP.
AC97: Sigmatel Stac ???? (Unreadable number)  (Chip above the ADC)

Can you please confirm these details?

----------------------------------------------------------------------
 BerndBuechs - 12-23-05 11:02 
----------------------------------------------------------------------
I could not speak for khampf but it seems to be my card :-)

I can confirm: SB0610
DSP: CA10300-IAT (The bigest chip)
ADC: Philips 1361T (Small chip above the DSP)
DAC: Cirrus Logic CS4382-KQZ (small chip to the left of the DSP.

and

AC97: Sigmatel STAC9750 (Chip above the ADC)

----------------------------------------------------------------------
 kjes - 01-06-06 00:49 
----------------------------------------------------------------------
I've got this card, and it's working. Using alsa-driver 1.0.11-rc2 and
emu10k. Any questions are welcome. Mail me. :-) quick note; to get all
four of my speakers to work i had to but the green plug in the orange port
on the soundcard, and the black in the black. (kjes (a) zappa.halden.net)

----------------------------------------------------------------------
 khampf - 01-15-06 20:34 
----------------------------------------------------------------------
Ok guys, back home from holidays, took a while longer than expected. My
card has developed problems, distortions on the front right channel
(verified on another computer with other speakers). But while the card was
pulled out I tried to take som pictures of it and read what was printed on
the chips.

First of all, I do _not_ have the same card as on the picture earlier in
this thread. That picture has a CA0103 while I have a CA0108 as "the big
one". This is the DSP, right?

This is what I could find out:

SOUND BLASTER AUDIGY 4
MODEL: SB0610

The big one (DSP?):
	Creative
	CA0108-IAT LF
	@CREATIVE TECH '03
	55AC6LW

DAC or ADC:
	Cirrus Logic
	CS4382-KQZ
	WAEXAX0510
	TAIWAN

AC97:
	Sigmatel
	STAC9750
	(the rest hard to make out)

I was not able to find both a DAC and an ADC .. you can look at the
pictures and see for yourself (at least some parts are readable).

http://www.c0r3.org/audigy4/

Now my question is ... how does this card work with the CA102 part of the
driver and the CA0108 part disabled? Is there some init in CA0102 that is
bringing it online? And why does the card posted earlier sport a CA10300
and mine CA0108?

The PCB is exactly the same as far as I can see, all other components than
"the big one" seems to be identical too.

But I did recompile my kernel before I took the card out and this worked
perfectly (at least 5.1 sound) with my Audigy 4 an kernel 2.6.15 (in
emu10k1_main.c):

{.vendor = 0x1102, .device = 0x0004, .subsystem = 0x10211102,
	 .driver = "Audigy2", .name = "Audigy 4 [SB0610]", 
	 .id = "Audigy2",
	 .emu10k2_chip = 1,
	 .ca0102_chip = 1
	 /* .ca0151_chip = 1, */
	 /* .spk71 = 1, */
	 /* .spdif_bug = 1, */
	 /* .ac97_chip = 1 */ } ,

Untested: digital out, 7.1 surround
Working: stereo sound (2.1), 5.1 surround, AC97 mixer

I can however not test the card more before I get a replacement, and I've
got an Audigy 2 with firewire now instead (works perfectly) so I'm not too
sure I'll use the Audigy 4 in my workstation even after a warranty
replacement.

----------------------------------------------------------------------
 jprk - 01-15-06 21:48 
----------------------------------------------------------------------
Just before Christmas I bought what seems to be a bulk version of Audigy 4
(named "SB Audigy 4 OEM" at www.czechcomputer.cz). The DSP is CA0108-IATLF
(and not CA10300-IAT as reported by BerndBuechs and as jcdutton found on
the Creative website), but the rest is the same: DAC is Phillips 1361T,
ADC is CirrusLogic CS4382-KQZ ADC and AC97 is SigmaTel STAC9750.

Photographs of the card (2-4MB files, beware) can be found at
 
http://euler.fd.cvut.cz/audigy4/SB_Audigy_4_OEM_cropped.jpg
http://euler.fd.cvut.cz/audigy4/SB_Audigy_4_OEM.jpg
http://euler.fd.cvut.cz/audigy4/SB_Audigy_4_OEM_detail.jpg

I am running Ubuntu 5.10 with an almost vanilla 2.6.12 kernel (V4L
subsystem taken from V4L CVS, ALSA is unpatched, version 1.0.9). I have
on-board AC97 and this Audigy, audigy being indexed as the first one and
connected to a 5.1 analog sound system. This combinaction works nice under
Win XP. Under Linux, the only thing that I can make my Audigy to do is to
click - by switching the digital/analog output. The on-board AC97 seems to
work. The Audigy is being detected as "Audigy 2 Value [Unknown]", exactly
as khampf mentions in the post from 24th November.

I am now going to get the last version of ALSA, try to replace the kernel
modules with the newer ones without crippling everything and report if the
card works or not.

----------------------------------------------------------------------
 jcdutton - 01-15-06 23:04 
----------------------------------------------------------------------
Closed. Seems to be working fine for everyone now.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-24-05 03:35 khampf         New Issue                                    
11-24-05 03:35 khampf         Distribution              => Debian 3
testing/unstable hybrid
11-24-05 03:35 khampf         Kernel Version            => 2.6.14.2-c0r3
(-ckX+swsusp2+bootsplash)
11-24-05 03:39 khampf         Issue Monitored: khampf                      
11-24-05 03:41 khampf         Note Added: 0006837                          
11-24-05 21:54 jcdutton       Note Added: 0006845                          
11-26-05 22:33 khampf         Note Added: 0006850                          
11-29-05 22:55 BerndBuechs    Issue Monitored: BerndBuechs                    
11-29-05 22:56 BerndBuechs    Note Added: 0006874                          
12-22-05 13:28 jcdutton       Note Added: 0007124                          
12-22-05 13:29 jcdutton       Note Added: 0007125                          
12-22-05 15:07 khampf         Note Added: 0007126                          
12-22-05 20:22 jcdutton       Note Added: 0007129                          
12-23-05 11:02 BerndBuechs    Note Added: 0007132                          
12-28-05 13:40 vsu            Issue Monitored: vsu                         
01-06-06 00:49 kjes           Note Added: 0007485                          
01-09-06 22:28 jcdutton       Status                   new => assigned     
01-09-06 22:28 jcdutton       Assigned To               => jcdutton        
01-15-06 20:34 khampf         Note Added: 0007670                          
01-15-06 21:48 jprk           Note Added: 0007672                          
01-15-06 23:04 jcdutton       Status                   assigned => closed  
01-15-06 23:04 jcdutton       Note Added: 0007680                          
01-22-06 00:06 jcdutton       Relationship added       related to 0001765  
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
