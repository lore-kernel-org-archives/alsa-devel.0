From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001595]: Audigy 4 (bulk, non-Pro) unsupported (patch included)
Date: Sun, 15 Jan 2006 23:04:59 +0100
Message-ID: <307b1b2b31bfe32ad33ccda45e0cb4f6@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 7DA64128
	for <alsa-devel@alsa-project.org>; Sun, 15 Jan 2006 23:04:59 +0100 (MET)
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


The following issue has been CLOSED
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
Last Modified:              01-15-2006 23:04 CET
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
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
