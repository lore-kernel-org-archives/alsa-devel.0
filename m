From: Raymond <rayau@netvigator.com>
Subject: Re: [Openvortex-dev] Re: Re: au88x0 modem
Date: Wed, 14 Sep 2005 20:47:57 +0800
Message-ID: <43281BFD.8060101@netvigator.com>
References: <431E3771.8090303@netvigator.com>    <20050907064449.GA8391@titan.lahn.de> <4321B5A4.5090803@netvigator.com>    <20050911124530.GA16795@titan.lahn.de>    <4325AEA3.1090602@netvigator.com> <20050913000909.GB19713@tecr>    <20050913085552.GA2655@titan.lahn.de>    <20050913173529.GD31269@sashak.softier1.local>    <20050913174930.GA5816@titan.lahn.de>    <20050913214413.GA9475@sashak.softier1.local>    <20050914070210.GA9168@titan.lahn.de> <42322.62.59.249.250.1126691266.squirrel@62.59.249.250>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <42322.62.59.249.250.1126691266.squirrel@62.59.249.250>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Maarten Vanraes wrote:

 >> Hello!
 >>
 >
 > if it helps: mine is:
 >
 > 00:0c.0 Multimedia audio controller: Aureal Semiconductor AU8810 Vortex
 > Digital Audio Processor (rev 02)
 >         Subsystem: Aureal Semiconductor AU8810 Vortex Digital Audio 
Processor
 >         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
 > ParErr- Stepping- SERR+ FastB2B-
 >         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
 > <TAbort- <MAbort- >SERR- <PERR-
 >         Latency: 64 (500ns min, 20750ns max), cache line size 40
 >         Interrupt: pin A routed to IRQ 169
 >         Region 0: Memory at 00000000fdc00000 (32-bit, non-prefetchable)
 > [size=256K]
 >         Region 1: I/O ports at dc00 [size=8]
 >         Region 2: I/O ports at cc00 [size=8]
 >         Capabilities: [dc] Power Management version 2
 >                 Flags: PMEClk- DSI+ D1- D2+ AuxCurrent=0mA
 > PME(D0-,D1-,D2+,D3hot+,D3cold-)
 >                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 >
 >
 >


http://pci-ids.ucw.cz/iii/?i=12eb0003

It would help if you can tell us the exact model of your au8810

lspci -vvn

cat /proc/asound/au8810/codec97#0/ac97#0-0+regs


and send the subsystem vendor id, subsystem device id and the model name 
of your au88x0 to the pci ids database maintainer to update

/usr/src/linux/drivers/pci/pci.ids

Your au8810 with Subsystem: 12eb:xxxx may be one of the following

1) Aureal SQ1500
2) Aureal Advantage
3) Aureal SoundCom Audio/Modem Combo






-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
