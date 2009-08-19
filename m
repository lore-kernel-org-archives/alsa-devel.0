From: Shane W <shane-alsa@csy.ca>
Subject: Nvidia MSI Geforce 9500
Date: Wed, 19 Aug 2009 14:29:03 -0700
Message-ID: <20090819212902.GA5748@csy.ca>
References: <20090819200036.GA12401@csy.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from viper.wapvi.bc.ca (viper.wapvi.bc.ca [209.52.235.240])
	by alsa0.perex.cz (Postfix) with ESMTP id E5FA4103809
	for <alsa-devel@alsa-project.org>;
	Wed, 19 Aug 2009 23:51:39 +0200 (CEST)
Received: from continuum.csy.ca (S0106001a4d4d4a63.vs.shawcable.net
	[70.71.65.71]) (authenticated bits=0)
	by viper.wapvi.bc.ca (8.14.2/8.14.2/Debian-2build1) with ESMTP id
	n7JLpZr0018065
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NOT)
	for <alsa-devel@alsa-project.org>; Wed, 19 Aug 2009 14:51:37 -0700
Received: from shane by continuum.csy.ca with local (Exim 4.69)
	(envelope-from <shane-alsa@csy.ca>) id 1MdsiN-0001aV-28
	for alsa-devel@alsa-project.org; Wed, 19 Aug 2009 14:29:03 -0700
Content-Disposition: inline
In-Reply-To: <20090819200036.GA12401@csy.ca>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

think this might belong on the devel list. After some
searching, looks like my Geforce 9500 card is not
recognized by the hda_intel driver. I tried adding:
{ PCI_DEVICE(0x10de, 0x0640), .driver_data = AZX_DRIVER_NVIDIA },

to hda_intel.c but I get:
HDA Intel 0000:01:00.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
HDA Intel 0000:01:00.0: setting latency timer to 64
hda-intel: no codecs found!
HDA Intel 0000:01:00.0: PCI INT A disabled

So looks like it isn't that simple. Anyone encountered this card as yet? Anywhere elese I should be looking?

On Wed, Aug 19, 2009 at 01:00:36PM -0700, Shane W wrote:
> Hey all,
> 
> So just installed a Geforce 9500 video card with an HDMI
> port but udev isn't probing an alsa driver for it. I'm
> wondering what I need to load. I tried snd_codec_nvhdmi and
> snd_codec_intel but proc/asound/cards still says "no cards
> installed". Linux 2.6.30 (Debian) with Alsa 1.0.20 is being
> used.  Any help greatly appreciated.
> 
> Shane
> 
> lspci -vvv:
> 01:00.0 VGA compatible controller: nVidia Corporation G96 [GeForce 9500 GT] (rev
>  a1) (prog-if 00 [VGA controller])
>         Subsystem: Micro-Star International Co., Ltd. Device 1575
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Step
> ping- SERR- FastB2B- DisINTx-
>         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
> <MAbort- >SERR- <PERR- INTx-
>         Latency: 0
>         Interrupt: pin A routed to IRQ 16
>         Region 0: Memory at f6000000 (32-bit, non-prefetchable) [size=16M]
>         Region 1: Memory at e0000000 (64-bit, prefetchable) [size=256M]
>         Region 3: Memory at f4000000 (64-bit, non-prefetchable) [size=32M]
>         Region 5: I/O ports at a000 [size=128]
>         [virtual] Expansion ROM at f7000000 [disabled] [size=512K]
>         Capabilities: [60] Power Management version 3
>                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot
> -,D3cold-)
>                 Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
>         Capabilities: [68] MSI: Enable- Count=1/1 Maskable- 64bit+
>                 Address: 0000000000000000  Data: 0000
>         Capabilities: [78] Express (v1) Endpoint, MSI 00
>                 DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s <512ns, L
> 1 <4us
>                         ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
>                 DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupporte
> d-
>                         RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
>                         MaxPayload 128 bytes, MaxReadReq 512 bytes
>                 DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPe
> nd-
>                 LnkCap: Port #0, Speed 2.5GT/s, Width x16, ASPM L0s L1, Latency
> L0 <512ns, L1 <1us
>                         ClockPM- Surprise- LLActRep- BwNot-
>                 LnkCtl: ASPM Disabled; RCB 128 bytes Disabled- Retrain- CommClk+
>                         ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>                 LnkSta: Speed 2.5GT/s, Width x16, TrErr- Train- SlotClk+ DLActiv
> e- BWMgmt- ABWMgmt-
>         Capabilities: [b4] Vendor Specific Information <?>
>         Capabilities: [100] Virtual Channel <?>
>         Capabilities: [128] Power Budgeting <?>
>         Capabilities: [600] Vendor Specific Information <?>
>         Kernel driver in use: nvidia
> 
> ------------------------------------------------------------------------------
> Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
> trial. Simplify your report design, integration and deployment - and focus on 
> what you do best, core application coding. Discover what's new with 
> Crystal Reports now.  http://p.sf.net/sfu/bobj-july
> _______________________________________________
> Alsa-user mailing list
> Alsa-user@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-user
