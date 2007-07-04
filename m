From: Steffen Schulz <pepe_ml@gmx.net>
Subject: hda-intel on macbook: unknown model for ACL882
Date: Wed, 4 Jul 2007 18:50:22 +0200
Message-ID: <20070704165022.GA8783@cbg.dyndns.org>
References: <20070701132728.GA5827@cbg.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.rz.ruhr-uni-bochum.de (mx2.rz.ruhr-uni-bochum.de
	[134.147.64.30]) by alsa0.perex.cz (Postfix) with SMTP id E03631038C4
	for <alsa-devel@alsa-project.org>;
	Wed,  4 Jul 2007 18:50:22 +0200 (CEST)
Received: from cbg.dyndns.org (knox_zi408.hm.ruhr-uni-bochum.de [10.0.52.70])
	by mulch.hm.ruhr-uni-bochum.de (Postfix) with ESMTP id 4BD1DF55F
	for <alsa-devel@alsa-project.org>;
	Wed,  4 Jul 2007 18:50:26 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20070701132728.GA5827@cbg.dyndns.org>
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

Hi all,


Since I didn't get much feedback on alsa-users, I figured I'd place
a pointer here, too.


The revision 3 macbook pro(santa-rosa) ships with a ALC882.

Loading hda_intel with auto-detection results in very VERY quiet sound
out of the headphones if 'front' is set to 100%, mic input seems to
work too, but also very quiet.


Providing an option 'model=w2jc' to modprobe however results in
working(loud) front and mic. But this model does not seem to provide
headphones output, so they don't work.


This sounds to me like it may be easy to fix, so I hope you find this
information useful. Would be great to have the sound working.


Regards,
Steffen (subscribed for the moment..)


> The snd-hda-module loads with the following message:
> | kernel: hda_codec: Unknown model for ALC882, trying auto-probe from BIOS...
> | kernel: ALSA /usr/src/alsa/alsa-driver/pci/hda/hda_codec.c:2339: autoconfig: line_outs=1 (0x14/0x0/0x0/0x0/0x0)
> | kernel: ALSA /usr/src/alsa/alsa-driver/pci/hda/hda_codec.c:2343:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
> | kernel: ALSA /usr/src/alsa/alsa-driver/pci/hda/hda_codec.c:2347:    hp_outs=1 (0x15/0x0/0x0/0x0/0x0)
> | kernel: ALSA /usr/src/alsa/alsa-driver/pci/hda/hda_codec.c:2355:    inputs: mic=0x18, fmic=0x0, line=0x1a, fline=0x0, cd=0x0, aux=0x0
> 
> aplay -l says:
> 
> | **** List of PLAYBACK Hardware Devices ****
> | card 0: Intel [HDA Intel], device 0: ALC882 Analog [ALC882 Analog]
> |   Subdevices: 1/1
> |   Subdevice #0: subdevice #0
> | card 0: Intel [HDA Intel], device 1: ALC882 Digital [ALC882 Digital]
> |   Subdevices: 1/1
> |   Subdevice #0: subdevice #0
> 
> lspci -vv -nn says:
> 
> | 00:1b.0 Audio device [0403]: Intel Corporation 82801H (ICH8 Family) HD Audio Controller [8086:284b] (rev 03)
> | 	Subsystem: Apple Computer Inc. Unknown device [106b:00a0]
> | 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
> | 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> | 	Latency: 0, Cache Line Size: 256 bytes
> | 	Interrupt: pin A routed to IRQ 20
> | 	Region 0: Memory at 9b500000 (64-bit, non-prefetchable) [size=16K]
> | 	Capabilities: [50] Power Management version 2
> | 		Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
> | 		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> | 	Capabilities: [60] Message Signalled Interrupts: Mask- 64bit+ Queue=0/0 Enable-
> | 		Address: 0000000000000000  Data: 0000
> | 	Capabilities: [70] Express Unknown type IRQ 0
> | 		Device: Supported: MaxPayload 128 bytes, PhantFunc 0, ExtTag-
> | 		Device: Latency L0s <64ns, L1 <1us
> | 		Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
> | 		Device: RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop+
> | 		Device: MaxPayload 128 bytes, MaxReadReq 128 bytes
> | 		Link: Supported Speed unknown, Width x0, ASPM unknown, Port 0
> | 		Link: Latency L0s <64ns, L1 <1us
> | 		Link: ASPM Disabled CommClk- ExtSynch-
> | 		Link: Speed unknown, Width x0
> | 	Capabilities: [100] Virtual Channel
> | 	Capabilities: [130] Unknown (5)
