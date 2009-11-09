From: James Pearson <james-p@moving-picture.com>
Subject: hda-intel: no codecs initialized with Teradici sound
 card and ALSA 1.0.17
Date: Mon, 09 Nov 2009 17:22:54 +0000
Message-ID: <4AF84FEE.6000206@moving-picture.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from moving-picture.com (mpc-26.sohonet.co.uk [193.203.82.251])
	by alsa0.perex.cz (Postfix) with ESMTP id 582E6103863
	for <alsa-devel@alsa-project.org>; Mon,  9 Nov 2009 18:22:56 +0100 (CET)
Received: from cassini.mpc.local ([172.16.15.37] helo=moving-picture.com)
	by moving-picture.com with esmtp (Exim 4.43) id 1N7Xx8-0008Vn-PU
	for alsa-devel@alsa-project.org; Mon, 09 Nov 2009 17:22:54 +0000
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

I'm using CentOS 5.3 (which uses ALSA 1.0.17) and a Teradici KVM over IP 
extender - which has an hda_intel type sound chipset

However, when the snd_hda_intel module is loaded, dmesg reports:

PCI: Enabling device 0000:04:00.1 (0000 -> 0002)
ACPI: PCI Interrupt 0000:04:00.1[A] -> GSI 16 (level, low) -> IRQ 177
PCI: Setting latency timer of device 0000:04:00.1 to 64
hda-intel: no codecs initialized
ACPI: PCI interrupt for device 0000:04:00.1 disabled

... and /proc/asound/cards reports:

--- no soundcards ---

I've tried loading the snd-hda-intel module with various 'model=' 
options (including basic and auto), but it makes no difference

However, we also have CentOS 4.7 on machines with same Teradici card 
using ALSA 1.0.15 (that replaces the ALSA version that ships with CentOS 
4) patched to support the Teradici card - using a patch based on the one 
that went into ALSA 1.0.17 to support the Teradici card. In this case 
the audio works - dmesg reports:

ACPI: PCI Interrupt 0000:82:00.1[A] -> GSI 47 (level, high) -> IRQ 233
PCI: Setting latency timer of device 0000:82:00.1 to 64
hda_codec: Unknown model for ALC883, trying auto-probe from BIOS...

And in this case, /proc/asound/cards reports:

  0 [Teradici       ]: HDA-Intel - HDA Teradici
                       HDA Teradici at 0xd0100000 irq 233

and playback works fine.

Any idea why ALSA 1.0.17 doesn't work with the Teradici card?

I don't really want to replace the the ALSA kernel code with a more up 
to date version if at all possible ... is there a way of 'forcing' the 
1.0.17 code 'to work' ?

lspci -vv for this card reports

04:00.1 Audio device: Teradici Corp. Unknown device 1200
         Subsystem: Unknown device e49c:040b
         Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Interrupt: pin A routed to IRQ 177
         Region 0: Memory at fbbf8000 (64-bit, non-prefetchable) 
[disabled] [size=16K]
         Capabilities: [40] Power Management version 3
                 Flags: PMEClk- DSI- D1- D2+ AuxCurrent=375mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
         Capabilities: [50] Message Signalled Interrupts: 64bit+ 
Queue=0/0 Enable-
                 Address: 0000000000000000  Data: 0000
         Capabilities: [70] Express Endpoint IRQ 0
                 Device: Supported: MaxPayload 128 bytes, PhantFunc 0, 
ExtTag-
                 Device: Latency L0s <2us, L1 <8us
                 Device: AtnBtn- AtnInd- PwrInd-
                 Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
                 Device: RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop-
                 Device: MaxPayload 128 bytes, MaxReadReq 512 bytes
                 Link: Supported Speed 2.5Gb/s, Width x1, ASPM L0s L1, 
Port 0
                 Link: Latency L0s <64ns, L1 <16us
                 Link: ASPM Disabled RCB 64 bytes CommClk- ExtSynch-
                 Link: Speed 2.5Gb/s, Width x1

aplay -l (using ALSA 1.0.15 on CentOS 4) reports

**** List of PLAYBACK Hardware Devices ****
card 0: Teradici [HDA Teradici], device 0: ALC883 Analog [ALC883 Analog]
   Subdevices: 1/1
   Subdevice #0: subdevice #0


Thanks

James Pearson
