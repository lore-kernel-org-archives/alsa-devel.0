From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001595]: Audigy 4 (bulk, non-Pro) unsupported (patch included)
Date: Sun, 15 Jan 2006 20:34:11 +0100
Message-ID: <0682b0608487cf773f624e1c667f821a@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 5214F137
	for <alsa-devel@alsa-project.org>; Sun, 15 Jan 2006 20:34:11 +0100 (MET)
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
Last Modified:              01-15-2006 20:34 CET
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
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
