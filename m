From: Philipp Matthias Hahn <pmhahn@titan.lahn.de>
Subject: Re: [Openvortex-dev] Re: Re: au88x0 modem
Date: Thu, 15 Sep 2005 09:25:17 +0200
Message-ID: <20050915072517.GA5920@titan.lahn.de>
References: <20050911124530.GA16795@titan.lahn.de> <4325AEA3.1090602@netvigator.com> <20050913000909.GB19713@tecr> <20050913085552.GA2655@titan.lahn.de> <20050913173529.GD31269@sashak.softier1.local> <20050913174930.GA5816@titan.lahn.de> <20050913214413.GA9475@sashak.softier1.local> <20050914070210.GA9168@titan.lahn.de> <42322.62.59.249.250.1126691266.squirrel@62.59.249.250> <20050914210303.GE14657@sashak.softier1.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20050914210303.GE14657@sashak.softier1.local>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Maarten Vanraes <maarten.vanraes@telenet.be>, alsa-devel@lists.sourceforge.net, openvortex-dev@nongnu.org, Raymond <rayau@netvigator.com>
List-Id: alsa-devel@alsa-project.org

Hello!

On Thu, Sep 15, 2005 at 12:03:03AM +0300, Sasha Khapyorsky wrote:
> On 11:47 Wed 14 Sep     , Maarten Vanraes wrote:
> > >
> > > 0000:00:06.0 Multimedia audio controller: Aureal Semiconductor AU8810 Vortex Digital Audio Processor (rev 03)
> > > 	Subsystem: ASUSTeK Computer Inc.: Unknown device 1043
...
> > 00:0c.0 Multimedia audio controller: Aureal Semiconductor AU8810 Vortex Digital Audio Processor (rev 02)
> >         Subsystem: Aureal Semiconductor AU8810 Vortex Digital Audio Processor
...
> Could you send us full lspci output - there is approach that modem uses
> separate from audio PCI entry. In such way it is done with most AC97
> audio/modem controllers and possibly with some au8810 too.

Sorry, just a single PCI device:

0000:00:06.0 0401: 12eb:0003 (rev 03)
	Subsystem: 1043:1043
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (500ns min, 20750ns max), Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin A routed to IRQ 255
	Region 0: Memory at fedc0000 (32-bit, non-prefetchable) [size=256K]
	Region 1: I/O ports at fce0 [size=8]
	Region 2: I/O ports at fce8 [size=8]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2+ AuxCurrent=55mA PME(D0-,D1-,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: eb 12 03 00 07 00 90 02 03 00 01 04 08 20 00 00
10: 00 00 dc fe e1 fc 00 00 e9 fc 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 43 10
30: 00 00 00 00 dc 00 00 00 00 00 00 00 ff 01 02 53
40: 80 00 00 00 43 10 43 10 01 fc 3f 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 01 00 62 e4
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

BYtE
Philipp
-- 
  / /  (_)__  __ ____  __ Philipp Hahn
 / /__/ / _ \/ // /\ \/ /
/____/_/_//_/\_,_/ /_/\_\ pmhahn@titan.lahn.de


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
