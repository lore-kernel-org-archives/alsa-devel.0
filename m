From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001595]: Audigy 4 (bulk, non-Pro) unsupported (patch included)
Date: Thu, 22 Dec 2005 13:29:44 +0100
Message-ID: <be1c7fb8cf789f0772d2c76b757e831a@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 9E28D17E
	for <alsa-devel@alsa-project.org>; Thu, 22 Dec 2005 13:29:44 +0100 (MET)
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
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1595
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Debian 3 testing/unstable hybrid
Kernel Version:             2.6.14.2-c0r3 (-ckX+swsusp2+bootsplash)
======================================================================
Date Submitted:             11-24-2005 03:35 CET
Last Modified:              12-22-2005 13:29 CET
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
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
