From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001590]: Not able to record with c46xx on IBM T20
Date: Tue, 22 Nov 2005 21:02:16 +0100
Message-ID: <b6ed84ea9a119ced3927d5afe0715957@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id ECBD61AF
	for <alsa-devel@alsa-project.org>; Tue, 22 Nov 2005 21:02:16 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1590> 
======================================================================
Reported By:                mayouan
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1590
Category:                   PCI - cs46xx
Reproducibility:            N/A
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               Debian
Kernel Version:             2.6.14-3
======================================================================
Date Submitted:             11-22-2005 20:35 CET
Last Modified:              11-22-2005 21:02 CET
======================================================================
Summary:                    Not able to record with c46xx on IBM T20
Description: 
Hi.

I am not able to record with my T20 and alsa cs46xx
driver. Playback works fine, the alsa mixer works as
expected and i can hear the sound from the mic in the
speakers.

But when i try to record does the recording program
outputs an empty file (exept for a tiny wave-header).
Most programs does not give any error message.

Ecasound gives me a message when stoping the recording:
Warning: DBC_ENSURE failed - "is_running() == false",
eca-control-base.cpp, 276.-

Accordinng to Kai Vehmanen does this mean that alsa
does not release the lock on the soundcard when user is
aborting. That is likely the case.

Trying to record with Ardour leavs the computer not
responding at all.

I can not find anything in my error-logs telling that
alsa have loaded correctly nor does alsaconf give me
any error messages.
======================================================================

----------------------------------------------------------------------
 mayouan - 11-22-05 21:02 
----------------------------------------------------------------------
lsmod:
Module                  Size  Used by
snd_cs46xx             88584  0 
gameport               14984  2 snd_cs46xx
snd_rawmidi            24832  1 snd_cs46xx
snd_seq_device          8684  1 snd_rawmidi
snd_ac97_codec         98556  1 snd_cs46xx
snd_ac97_bus            2080  1 snd_ac97_codec
snd_pcm_oss            55040  0 
snd_mixer_oss          19744  1 snd_pcm_oss
snd_pcm                92200  3 snd_cs46xx,snd_ac97_codec,snd_pcm_oss
snd_timer              24644  1 snd_pcm
snd                    55620  8
snd_cs46xx,snd_rawmidi,snd_seq_device,snd_ac97_codec,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_timer
snd_page_alloc         10888  2 snd_cs46xx,snd_pcm
soundcore               9696  1 snd
ipv6                  266400  17 
apm                    20748  1 
af_packet              22504  2 
pcmcia                 40604  4 
firmware_class         10464  1 pcmcia
nls_iso8859_1           3904  1 
nls_cp437               5568  1 
vfat                   13856  1 
fat                    54140  1 vfat
md_mod                 67024  0 
8139cp                 21824  0 
8139too                27968  0 
i2c_piix4               8752  0 
mii                     5504  2 8139cp,8139too
i2c_core               22096  1 i2c_piix4
pci_hotplug            28468  0 
uhci_hcd               33296  0 
usbcore               124544  2 uhci_hcd
intel_agp              24124  1 
agpgart                35592  1 intel_agp
floppy                 62564  0 
yenta_socket           28268  5 
rsrc_nonstatic         14144  1 yenta_socket
pcmcia_core            42960  3 pcmcia,yenta_socket,rsrc_nonstatic
irtty_sir               8640  0 
sir_dev                18796  1 irtty_sir
irda                  199996  2 irtty_sir,sir_dev
crc_ccitt               1920  1 irda
parport_pc             36804  0 
parport                37064  1 parport_pc
pcspkr                  3360  0 
joydev                  9856  0 
ide_cd                 43556  0 
cdrom                  40896  1 ide_cd
unix                   27856  444 
ext2                   71272  2 
mbcache                 9252  1 ext2
ide_disk               18720  5 
ide_generic             1152  0 [permanent]
generic                 4292  0 [permanent]
piix                   10404  0 [permanent]
ide_core              131452  5 ide_cd,ide_disk,ide_generic,generic,piix
evdev                   9536  0 
mousedev               11520  2 
psmouse                39492  0 
fbcon                  41696  0 
tileblit                2240  1 fbcon
font                    7968  1 fbcon
bitblit                 5728  1 fbcon


lspci:
0000:00:00.0 Host bridge: Intel Corporation 440BX/ZX/DX - 82443BX/ZX/DX
Host bridge (rev 03)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort+ >SERR- <PERR-
	Latency: 64
	Region 0: Memory at f8000000 (32-bit, prefetchable) [size=64M]
	Capabilities: <available only to root>

0000:00:01.0 PCI bridge: Intel Corporation 440BX/ZX/DX - 82443BX/ZX/DX AGP
bridge (rev 03) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV+ VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 128
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: f0000000-f7ffffff
	Prefetchable memory behind bridge: 18000000-180fffff
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B+

0000:00:02.0 CardBus bridge: Texas Instruments PCI1450 (rev 03)
	Subsystem: IBM Thinkpad T20
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 168, Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at 50000000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=02, subordinate=05, sec-latency=176
	Memory window 0: 10000000-11fff000 (prefetchable)
	Memory window 1: 12000000-13fff000
	I/O window 0: 00001400-000014ff
	I/O window 1: 00002000-000020ff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt- PostWrite+
	16-bit legacy interface ports at 0001

0000:00:02.1 CardBus bridge: Texas Instruments PCI1450 (rev 03)
	Subsystem: IBM Thinkpad T20
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 168, Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin B routed to IRQ 11
	Region 0: Memory at 50100000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=06, subordinate=09, sec-latency=176
	Memory window 0: 14000000-15fff000 (prefetchable)
	Memory window 1: 16000000-17fff000
	I/O window 0: 00002400-000024ff
	I/O window 1: 00002800-000028ff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001

0000:00:03.0 Communication controller: Agere Systems WinModem 56k (rev
01)
	Subsystem: AMBIT Microsystem Corp. Lucent Win Modem
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at e8101000 (32-bit, non-prefetchable) [size=256]
	Region 1: I/O ports at 1c00 [size=8]
	Region 2: I/O ports at 1800 [size=256]
	Capabilities: <available only to root>

0000:00:05.0 Multimedia audio controller: Cirrus Logic CS 4614/22/24
[CrystalClear SoundFusion Audio Accelerator] (rev 01)
	Subsystem: IBM: Unknown device 0153
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 64 (1000ns min, 6000ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at e8100000 (32-bit, non-prefetchable) [size=4K]
	Region 1: Memory at e8000000 (32-bit, non-prefetchable) [size=1M]
	Capabilities: <available only to root>

0000:00:07.0 Bridge: Intel Corporation 82371AB/EB/MB PIIX4 ISA (rev 02)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 0

0000:00:07.1 IDE interface: Intel Corporation 82371AB/EB/MB PIIX4 IDE (rev
01) (prog-if 80 [Master])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 64
	Region 4: I/O ports at 1c10 [size=16]

0000:00:07.2 USB Controller: Intel Corporation 82371AB/EB/MB PIIX4 USB
(rev 01) (prog-if 00 [UHCI])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 64
	Interrupt: pin D routed to IRQ 11
	Region 4: I/O ports at 1c20 [size=32]

0000:00:07.3 Bridge: Intel Corporation 82371AB/EB/MB PIIX4 ACPI (rev 03)
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Interrupt: pin ? routed to IRQ 9

0000:01:00.0 VGA compatible controller: S3 Inc. 86C270-294 Savage/IX-MV
(rev 11) (prog-if 00 [VGA])
	Subsystem: IBM ThinkPad T20
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 64 (1000ns min, 63750ns max), Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at f0000000 (32-bit, non-prefetchable) [size=128M]
	Expansion ROM at 18000000 [disabled] [size=64K]
	Capabilities: <available only to root>

0000:02:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL-8139/8139C/8139C+ (rev 10)
	Subsystem: Realtek Semiconductor Co., Ltd. RT8139
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 64 (8000ns min, 16000ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at 1400 [size=256]
	Region 1: Memory at 12000000 (32-bit, non-prefetchable) [size=512]
	Capabilities: <available only to root>

johan@huozi:~$ cat /proc/asound/version
Advanced Linux Sound Architecture Driver Version 1.0.10rc1 (Mon Sep 12
08:13:09 2005 UTC).

johan@huozi:~$ cat /proc/asound/cards
0 [CS46xx         ]: CS46xx - Sound Fusion CS46xx
                     Sound Fusion CS46xx at 0xe8100000/0xe8000000, irq 11

johan@huozi:~$ cat /proc/asound/card0/codec97#0/ac97#0-0
0-0/0: Cirrus Logic CS4297A rev 4

Capabilities     : -headphone out-
DAC resolution   : 20-bit
ADC resolution   : 18-bit
3D enhancement   : Crystal Semi 3D Stereo Enhancement

Current setup
Mic gain         : +20dB [+20dB]
POP path         : pre 3D
Sim. stereo      : off
3D enhancement   : on
Loudness         : off
Mono output      : MIX
Mic select       : Mic1
ADC/DAC loopback : off
Extended ID      : codec=0 rev=0 AMAP DSA=0
Extended status  :
SPDIF Control    : Consumer PCM Category=0x2 Generation=1 Rate=48kHz
Enabled

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-22-05 20:35 mayouan        New Issue                                    
11-22-05 20:35 mayouan        Distribution              => Debian          
11-22-05 20:35 mayouan        Kernel Version            => 2.6.14-3        
11-22-05 21:02 mayouan        Note Added: 0006797                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
