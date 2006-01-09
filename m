From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001595]: Audigy 4 (bulk, non-Pro) unsupported (patch included)
Date: Mon, 9 Jan 2006 22:28:12 +0100
Message-ID: <9b979da038be96d5ff500d6bf6ce521c@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id E3289144
	for <alsa-devel@alsa-project.org>; Mon,  9 Jan 2006 22:28:12 +0100 (MET)
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


The following issue has been ASSIGNED.
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
Status:                     assigned
Distribution:               Debian 3 testing/unstable hybrid
Kernel Version:             2.6.14.2-c0r3 (-ckX+swsusp2+bootsplash)
======================================================================
Date Submitted:             11-24-2005 03:35 CET
Last Modified:              01-09-2006 22:28 CET
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
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
