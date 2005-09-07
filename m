From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001347]: unable to configure sound card
Date: Wed, 7 Sep 2005 21:33:34 +0200
Message-ID: <7481742cb8c609d254f67cb1780a20b9@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id B03D11A4
	for <alsa-devel@alsa-project.org>; Wed,  7 Sep 2005 21:33:38 +0200 (MEST)
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
Last Modified:              09-07-2005 21:33 CEST
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
 tiwai - 08-23-05 16:40 
----------------------------------------------------------------------
I guess this laptop has no nm256 ac97 but it's connected to cs4236 codec
internally.  Check your BIOS setting and try snd-cs4236 driver.

----------------------------------------------------------------------
 dcooppan - 09-07-05 21:33 
----------------------------------------------------------------------
I have the exact same problem: ALSA from FC4:2.6.11-1.1369_FC4 kernel
Hardware is Compaq 1920 laptop with NeoMagic sound card
>From dmesg one sees:
>>>>>>>>>>>>>>>>>>>>>>>>
PCI: Found IRQ 10 for device 0000:01:00.1
PCI: Sharing IRQ 10 with 0000:00:07.2
nm256: no ac97 is found!
  force the driver to load by passing in the module parameter
    force_ac97=1
  or try sb16 or cs423x drivers instead.
NeoMagic 256: probe of 0000:01:00.1 failed with error -6
pnp: Device 00:01.01 activated.
>>>>>>>>>>>>>>>>>>>>>>>>

Can some check out what error -6 means. I confirm that if you use option 
force_ac97=1 then the system will HANG! Only option is power-off.

I am very interested to get this working so please copy me at
dcooppan@comcast.net

BTW: I also tried 2.4 with OSS, nada, nothing, same problem, even tried
loading
snd_cs4236 driver and get:
>>>>>>>>>>>>>> 
[root@dellcpx dcooppan]# modprobe snd-cs4236
FATAL: Error inserting snd_cs4236
(/lib/modules/2.6.11-1.1369_FC4/kernel/sound/isa/cs423x/snd-cs4236.ko): No
such device
>>>>>>>>>>>>>>>>>>>

thanks much

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
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
