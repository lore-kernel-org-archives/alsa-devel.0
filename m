From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001347]: unable to configure sound card
Date: Mon, 20 Mar 2006 01:26:03 +0100
Message-ID: <94d08c184d211cf09446ba6322d6f4be@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 51D551D5
	for <alsa-devel@alsa-project.org>; Mon, 20 Mar 2006 01:26:03 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1347> 
======================================================================
Reported By:                CptS
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1347
Category:                   PCI - nm256
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Knoppix 4.0
Kernel Version:             2.6.11
======================================================================
Date Submitted:             08-17-2005 11:05 CEST
Last Modified:              03-20-2006 01:26 CET
======================================================================
Summary:                    unable to configure sound card
Description: 
I'm having problems configuring my sound card with alsa, here are the
details:
the sound card is NeoMagic 256AV (NM2200) located onboard a Compaq
Presario 1920.
I'm currently running Knoppix 4.0 hdd installed (kernel 2.6)

here's lspci -vv outputs on the cards:
0000:01:00.1 Multimedia audio controller: Neomagic Corporation NM2200
[MagicMedia 256AV Audio] (rev 20)
        Subsystem: Compaq Computer Corporation MagicMedia 256AV Audio
Device on Durango
        Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B+
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin B routed to IRQ 10
        Region 0: Memory at f4800000 (32-bit, prefetchable) [size=4M]
        Region 1: Memory at f4200000 (32-bit, non-prefetchable) [size=1M]
        Capabilities: <available only to root>

I wouldn't have addressed you unless I've already tried everything:
I've tried the solution of the same problem regarding HP Omni 4150 with
the same card.

I used alsaconf and it tried to load snd-nm256, after loading it crashed,
dmesg suggested loading it with force_ac97=1 switch but once i did it the
system crashed (on 3 differet linux installations)

I did a legacy scan using alsaconf for all legacy drivers.

I 'modprobe'ed for hours on every imaginable option (ad1848, sb, cs423x,
etc..)

I've edited the modules.conf and manually defined the dma and irq

I removed alsa completly and re-install it.

I had debian with 2.4 kernel installed and i've upgraded to 2.6

I changed the distro from debian to Knoppix (kinda same thing but...)

anyway, you get the point..

can you please assist??I'm having problems configuring my sound card with
alsa, here are the details:
the sound card is NeoMagic 256AV (NM2200) located onboard a Compaq
Presario 1920.
I'm currently running Knoppix 4.0 hdd installed (kernel 2.6)

here's lspci -vv outputs on the cards:
0000:01:00.1 Multimedia audio controller: Neomagic Corporation NM2200
[MagicMedia 256AV Audio] (rev 20)
        Subsystem: Compaq Computer Corporation MagicMedia 256AV Audio
Device on Durango
        Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B+
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin B routed to IRQ 10
        Region 0: Memory at f4800000 (32-bit, prefetchable) [size=4M]
        Region 1: Memory at f4200000 (32-bit, non-prefetchable) [size=1M]
        Capabilities: <available only to root>

I wouldn't have addressed you unless I've already tried everything:
I've tried the solution of the same problem regarding HP Omni 4150 with
the same card.

I used alsaconf and it tried to load snd-nm256, after loading it crashed,
dmesg suggested loading it with force_ac97=1 switch but once i did it the
system crashed (on 3 differet linux installations)

I did a legacy scan using alsaconf for all legacy drivers.

I 'modprobe'ed for hours on every imaginable option (ad1848, sb, cs423x,
etc..)

I've edited the modules.conf and manually defined the dma and irq

I removed alsa completly and re-install it.

I had debian with 2.4 kernel installed and i've upgraded to 2.6

I changed the distro from debian to Knoppix (kinda same thing but...)

anyway, you get the point..

can you please assist??I'm having problems configuring my sound card with
alsa, here are the details:
the sound card is NeoMagic 256AV (NM2200) located onboard a Compaq
Presario 1920.
I'm currently running Knoppix 4.0 hdd installed (kernel 2.6)

here's lspci -vv outputs on the cards:
0000:01:00.1 Multimedia audio controller: Neomagic Corporation NM2200
[MagicMedia 256AV Audio] (rev 20)
        Subsystem: Compaq Computer Corporation MagicMedia 256AV Audio
Device on Durango
        Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B+
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin B routed to IRQ 10
        Region 0: Memory at f4800000 (32-bit, prefetchable) [size=4M]
        Region 1: Memory at f4200000 (32-bit, non-prefetchable) [size=1M]
        Capabilities: <available only to root>

I wouldn't have addressed you unless I've already tried everything:
I've tried the solution of the same problem regarding HP Omni 4150 with
the same card.

I used alsaconf and it tried to load snd-nm256, after loading it crashed,
dmesg suggested loading it with force_ac97=1 switch but once i did it the
system crashed (on 3 differet linux installations)

I did a legacy scan using alsaconf for all legacy drivers.

I 'modprobe'ed for hours on every imaginable option (ad1848, sb, cs423x,
etc..)

I've edited the modules.conf and manually defined the dma and irq

I removed alsa completly and re-install it.

I had debian with 2.4 kernel installed and i've upgraded to 2.6

I changed the distro from debian to Knoppix (kinda same thing but...)

anyway, you get the point..

can you please assist??
======================================================================

----------------------------------------------------------------------
 CptS - 03-19-06 23:42 
----------------------------------------------------------------------
No improvements with later alsa, but oss made it work using sb16 module and
the kind help of people from #ubuntu. i suggets you ditch alsa on this
hardware and use oss.

----------------------------------------------------------------------
 rlrevell - 03-20-06 01:26 
----------------------------------------------------------------------
That's not possible, OSS will eventually be removed from the kernel.

If it works with the OSS sb16 model it should work with the ALSA snd-sb16
driver.  

Maybe you can try again with ALSA CVS and the snd-nm256 driver - the bug
causing it to lock up the system was recently fixed.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-17-05 11:05 CptS           New Issue                                    
08-17-05 11:05 CptS           Distribution              => Knoppix 4.0     
08-17-05 11:05 CptS           Kernel Version            => 2.6.11          
08-17-05 11:24 CptS           Note Added: 0005835                          
08-20-05 19:48 CptS           Issue Monitored: CptS                        
08-20-05 19:50 CptS           Note Added: 0005883                          
08-20-05 20:32 rlrevell       Note Added: 0005884                          
08-20-05 20:37 rlrevell       Note Added: 0005885                          
08-22-05 22:00 CptS           Note Added: 0005901                          
08-23-05 16:40 tiwai          Note Added: 0005908                          
09-07-05 21:33 dcooppan       Note Added: 0006066                          
03-16-06 08:01 rlrevell       Note Added: 0008588                          
03-19-06 23:42 CptS           Note Added: 0008699                          
03-20-06 01:26 rlrevell       Note Added: 0008701                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
