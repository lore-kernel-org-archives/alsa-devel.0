From: Philipp Matthias Hahn <pmhahn@titan.lahn.de>
Subject: Re: Re: au88x0 modem
Date: Wed, 14 Sep 2005 09:02:10 +0200
Message-ID: <20050914070210.GA9168@titan.lahn.de>
References: <431E3771.8090303@netvigator.com> <20050907064449.GA8391@titan.lahn.de> <4321B5A4.5090803@netvigator.com> <20050911124530.GA16795@titan.lahn.de> <4325AEA3.1090602@netvigator.com> <20050913000909.GB19713@tecr> <20050913085552.GA2655@titan.lahn.de> <20050913173529.GD31269@sashak.softier1.local> <20050913174930.GA5816@titan.lahn.de> <20050913214413.GA9475@sashak.softier1.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20050913214413.GA9475@sashak.softier1.local>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net, openvortex-dev@nongnu.org, Raymond <rayau@netvigator.com>
List-Id: alsa-devel@alsa-project.org

Hello!

On Wed, Sep 14, 2005 at 12:44:13AM +0300, Sasha Khapyorsky wrote:
> On 19:49 Tue 13 Sep     , Philipp Matthias Hahn wrote:
> > ACPI: PCI Interrupt 0000:00:06.0[A] -> Link [LNKC] -> GSI 10 (level, low) -> IRQ 10
> > Vortex: init.... <6>done.
> > vortex: ac97 address never arrived
> > AC'97 1 does not respond - RESET
>
> Understood. Could you send full 'lspci -vv' please.

0000:00:06.0 Multimedia audio controller: Aureal Semiconductor AU8810 Vortex Digital Audio Processor (rev 03)
	Subsystem: ASUSTeK Computer Inc.: Unknown device 1043
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at fedc0000 (32-bit, non-prefetchable) [size=256K]
	Region 1: I/O ports at fce0 [size=8]
	Region 2: I/O ports at fce8 [size=8]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2+ AuxCurrent=55mA PME(D0-,D1-,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

BYtE
Philipp <icq://33677863>
-- 
  / /  (_)__  __ ____  __ Philipp Hahn
 / /__/ / _ \/ // /\ \/ /
/____/_/_//_/\_,_/ /_/\_\ pmhahn@titan.lahn.de


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
