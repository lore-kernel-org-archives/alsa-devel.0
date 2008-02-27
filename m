From: Armando Di Cianno <armando@goodship.net>
Subject: HDMI v. ICH8 on Dell XPS M1330
Date: Wed, 27 Feb 2008 17:41:10 -0500
Message-ID: <1204152070.12914.18.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from squid9.laughingsquid.net (squid9.laughingsquid.net
	[72.32.92.32]) by alsa0.perex.cz (Postfix) with ESMTP id C7CBF2447F
	for <alsa-devel@alsa-project.org>; Wed, 27 Feb 2008 23:42:16 +0100 (CET)
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

I figured this was more appropriate for devel, and not user.  Sorry, if
that's wrong.

First, I'm using the 1.0.16 release tarballs.  They work better than the
in-kernel drivers, as they survive both suspend and hibernate, whereas
the kernel drivers do not.

I'm eager to see audio over HDMI working on my Dell XPS M1330.  I'm
pretty sure that this is /not supported/ at the moment -- if this isn't
the case, please stop reading, and let me know the particulars.  HDMI
seems to be supported noted, but mainly for the ATI chips.

I'm pretty sure the m1330 has a STAC9228 setup.  None of the suggested
model= module parameters succeeded in getting audio over HDMI, beyond
what is autodetected without any parameter specified.  model=5stack
seems to show a digital SPDIF device added.

If there is anyway I can help the core developers get HDMI audio
working, I would be glad to help.  I will post all the relevant
information I can think of following; please let me know if other
information would be helpful.  I will gladly turn on any excessive
debugging options needed.  I am an ALSA n00b, but I will happily do any
required work that I can do from this end.

Thanks!

-- 
Armando Di Cianno
http://dicianno.org/blog
armando@dicianno.org
armando@goodship.net

w/o model= parameter
# aplay -l 
**** List of PLAYBACK Hardware Devices ****
card 0: Intel [HDA Intel], device 0: STAC92xx Analog [STAC92xx Analog]
  Subdevices: 1/1

w/ model=5stack
# aplay -l 
**** List of PLAYBACK Hardware Devices ****
card 0: Intel [HDA Intel], device 0: STAC92xx Analog [STAC92xx Analog]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: Intel [HDA Intel], device 1: STAC92xx Digital [STAC92xx Digital]
  Subdevices: 1/1
  Subdevice #0: subdevice #0

# lspci -nvvvv -d 8086:284b
00:1b.0 0403: 8086:284b (rev 02)
	Subsystem: 1028:0209
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 21
	Region 0: Memory at febfc000 (64-bit, non-prefetchable) [size=16K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA PME(D0+,D1-,D2-,D3hot
+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [60] Message Signalled Interrupts: Mask- 64bit+ Queue=0/0
Enable-
		Address: 0000000000000000  Data: 0000
	Capabilities: [70] Express (v1) Root Complex Integrated Endpoint, MSI
00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s unlimited, L1
unlimited
			ExtTag- RBE- FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
		LnkCap:	Port #0, Speed unknown, Width x0, ASPM unknown, Latency L0
<64ns, L1 <1us
			ClockPM- Suprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed unknown, Width x0, TrErr- Train- SlotClk- DLActive-
BWMgmt- ABWMgmt-
	Capabilities: [100] Virtual Channel <?>
	Capabilities: [130] Root Complex Link <?>
	Kernel driver in use: HDA Intel
	Kernel modules: snd-hda-intel
