From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000713]: AC'97 codec issue: "AC'97 0 does not respond - RESET"
Date: Fri, 30 Dec 2005 04:45:12 +0100
Message-ID: <69b089d3330403fd9151de3c5a8b80db@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id F3DEB1A1
	for <alsa-devel@alsa-project.org>; Fri, 30 Dec 2005 04:45:12 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=713> 
======================================================================
Reported By:                jefke
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   713
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Debian sid
Kernel Version:             2.6.9
======================================================================
Date Submitted:             12-07-2004 19:43 CET
Last Modified:              12-30-2005 04:45 CET
======================================================================
Summary:                    AC'97 codec issue: "AC'97 0 does not respond -
RESET"
Description: 
Souncard is working fine with oss module i810_audio, but isn't using alsa
modules. Several tests have been done under 2.6.8, 2.6.9 and 2.6.10rc3
kernels, using alsa-drivers version 1.0.7, without success.

Looks like the AC97 codec can't get initialized, and is unable to read PCI
registries on the sound card (AC97_VENDOR_ID1, AC97_VENDOR_ID2).

Cf uploaded file for configuration details.
======================================================================

----------------------------------------------------------------------
 jdthood - 04-09-05 17:21 
----------------------------------------------------------------------
The contents of the included file:

--------------------------------------------------------------------------------
# uname -a
Linux titeuf 2.6.9-1-686 #1 Thu Nov 25 03:48:29 EST 2004 i686 GNU/Linux

--------------------------------------------------------------------------------
# lspci -v
0000:00:00.0 Host bridge: Silicon Integrated Systems [SiS] SiS645DX Host &
Memory & AGP Controller
	Flags: bus master, medium devsel, latency 64
	Memory at f0000000 (32-bit, non-prefetchable) [size=64M]
	Capabilities: <available only to root>

0000:00:01.0 PCI bridge: Silicon Integrated Systems [SiS] Virtual
PCI-to-PCI bridge (AGP) (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 64
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=68
	Memory behind bridge: f5000000-f5ffffff
	Prefetchable memory behind bridge: f8000000-fbffffff

0000:00:02.0 ISA bridge: Silicon Integrated Systems [SiS] SiS962 [MuTIOL
Media IO] (rev 04)
	Flags: bus master, medium devsel, latency 0

0000:00:02.1 SMBus: Silicon Integrated Systems [SiS]: Unknown device 0016
	Flags: medium devsel
	I/O ports at 8100 [size=32]

0000:00:02.5 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE]
(prog-if 80 [Master])
	Subsystem: Silicon Integrated Systems [SiS] SiS5513 EIDE Controller (A,B
step)
	Flags: bus master, medium devsel, latency 128, IRQ 11
	I/O ports at 2400 [size=16]

0000:00:02.6 Modem: Silicon Integrated Systems [SiS] AC'97 Modem
Controller (rev a0) (prog-if 00 [Generic])
	Subsystem: Unknown device 1631:3003
	Flags: medium devsel, IRQ 5
	I/O ports at 1400 [size=256]
	I/O ports at 1000 [size=128]
	Capabilities: <available only to root>

0000:00:02.7 Multimedia audio controller: Silicon Integrated Systems [SiS]
Sound Controller (rev a0)
	Subsystem: Unknown device 1734:1010
	Flags: bus master, medium devsel, latency 173, IRQ 5
	I/O ports at 1c00 [size=256]
	I/O ports at 1800 [size=128]
	Capabilities: <available only to root>

0000:00:03.0 USB Controller: Silicon Integrated Systems [SiS] USB 1.0
Controller (rev 0f) (prog-if 10 [OHCI])
	Subsystem: Silicon Integrated Systems [SiS] USB 1.0 Controller
	Flags: bus master, medium devsel, latency 64, IRQ 9
	Memory at f4000000 (32-bit, non-prefetchable) [size=4K]

0000:00:03.1 USB Controller: Silicon Integrated Systems [SiS] USB 1.0
Controller (rev 0f) (prog-if 10 [OHCI])
	Subsystem: Silicon Integrated Systems [SiS] USB 1.0 Controller
	Flags: bus master, medium devsel, latency 64, IRQ 11
	Memory at f4001000 (32-bit, non-prefetchable) [size=4K]

0000:00:03.2 USB Controller: Silicon Integrated Systems [SiS] USB 1.0
Controller (rev 0f) (prog-if 10 [OHCI])
	Subsystem: Silicon Integrated Systems [SiS] USB 1.0 Controller
	Flags: bus master, medium devsel, latency 64, IRQ 10
	Memory at f4002000 (32-bit, non-prefetchable) [size=4K]

0000:00:03.3 USB Controller: Silicon Integrated Systems [SiS] USB 2.0
Controller (prog-if 20 [EHCI])
	Subsystem: Silicon Integrated Systems [SiS] USB 2.0 Controller
	Flags: bus master, medium devsel, latency 64, IRQ 9
	Memory at f4003000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: <available only to root>

0000:00:06.0 Ethernet controller: Linksys NC100 Network Everywhere Fast
Ethernet 10/100 (rev 11)
	Subsystem: Unknown device 1734:100c
	Flags: bus master, medium devsel, latency 64, IRQ 9
	I/O ports at 2000 [size=256]
	Memory at f4004000 (32-bit, non-prefetchable) [size=1K]
	Capabilities: <available only to root>

0000:01:00.0 VGA compatible controller: nVidia Corporation NV18 [GeForce4
MX 440SE AGP 8x] (rev a2) (prog-if 00 [VGA])
	Subsystem: Micro-Star International Co., Ltd.: Unknown device 8900
	Flags: bus master, 66MHz, medium devsel, latency 248, IRQ 11
	Memory at f5000000 (32-bit, non-prefetchable) [size=16M]
	Memory at f8000000 (32-bit, prefetchable) [size=64M]
	Capabilities: <available only to root>

--------------------------------------------------------------------------------
# lspci -vvn
0000:00:00.0 0600: 1039:0646
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort+ >SERR- <PERR-
	Latency: 64
	Region 0: Memory at f0000000 (32-bit, non-prefetchable) [size=64M]
	Capabilities: <available only to root>

0000:00:01.0 0604: 1039:0001
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 64
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=68
	Memory behind bridge: f5000000-f5ffffff
	Prefetchable memory behind bridge: f8000000-fbffffff
	BridgeCtl: Parity- SERR+ NoISA+ VGA+ MAbort- >Reset- FastB2B-

0000:00:02.0 0601: 1039:0962 (rev 04)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 0

0000:00:02.1 0c05: 1039:0016
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Interrupt: pin B routed to IRQ 0
	Region 4: I/O ports at 8100 [size=32]

0000:00:02.5 0101: 1039:5513 (prog-if 80 [Master])
	Subsystem: 1039:5513
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 128
	Interrupt: pin ? routed to IRQ 11
	Region 4: I/O ports at 2400 [size=16]

0000:00:02.6 0703: 1039:7013 (rev a0)
	Subsystem: 1631:3003
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Interrupt: pin C routed to IRQ 5
	Region 0: I/O ports at 1400 [size=256]
	Region 1: I/O ports at 1000 [size=128]
	Capabilities: <available only to root>

0000:00:02.7 0401: 1039:7012 (rev a0)
	Subsystem: 1734:1010
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 173 (13000ns min, 2750ns max)
	Interrupt: pin C routed to IRQ 5
	Region 0: I/O ports at 1c00 [size=256]
	Region 1: I/O ports at 1800 [size=128]
	Capabilities: <available only to root>

0000:00:03.0 0c03: 1039:7001 (rev 0f) (prog-if 10)
	Subsystem: 1039:7001
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 64 (20000ns max)
	Interrupt: pin A routed to IRQ 9
	Region 0: Memory at f4000000 (32-bit, non-prefetchable) [size=4K]

0000:00:03.1 0c03: 1039:7001 (rev 0f) (prog-if 10)
	Subsystem: 1039:7001
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 64 (20000ns max)
	Interrupt: pin B routed to IRQ 11
	Region 0: Memory at f4001000 (32-bit, non-prefetchable) [size=4K]

0000:00:03.2 0c03: 1039:7001 (rev 0f) (prog-if 10)
	Subsystem: 1039:7001
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 64 (20000ns max)
	Interrupt: pin C routed to IRQ 10
	Region 0: Memory at f4002000 (32-bit, non-prefetchable) [size=4K]

0000:00:03.3 0c03: 1039:7002 (prog-if 20)
	Subsystem: 1039:7002
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 64 (20000ns max)
	Interrupt: pin D routed to IRQ 9
	Region 0: Memory at f4003000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: <available only to root>

0000:00:06.0 0200: 1317:0985 (rev 11)
	Subsystem: 1734:100c
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 64 (16000ns min, 32000ns max), Cache Line Size: 0x04 (16 bytes)
	Interrupt: pin A routed to IRQ 9
	Region 0: I/O ports at 2000 [size=256]
	Region 1: Memory at f4004000 (32-bit, non-prefetchable) [size=1K]
	Capabilities: <available only to root>

0000:01:00.0 0300: 10de:0182 (rev a2)
	Subsystem: 1462:8900
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 248 (1250ns min, 250ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at f5000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: Memory at f8000000 (32-bit, prefetchable) [size=64M]
	Capabilities: <available only to root>

--------------------------------------------------------------------------------
# lsmod
Module                  Size  Used by
snd_intel8x0           33820  0 
snd_ac97_codec         77472  1 snd_intel8x0
snd_pcm_oss            54056  0 
snd_mixer_oss          20032  1 snd_pcm_oss
snd_pcm                98344  3 snd_intel8x0,snd_ac97_codec,snd_pcm_oss
snd_timer              25764  1 snd_pcm
snd_page_alloc          9992  2 snd_intel8x0,snd_pcm
snd                    57828  6
snd_intel8x0,snd_ac97_codec,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_timer
soundcore              10176  1 snd
ipt_state               1760  4 
ipt_MASQUERADE          3680  1 
iptable_nat            26632  2 ipt_MASQUERADE
iptable_filter          2816  1 
ip_conntrack_ftp       72752  0 
ip_conntrack           47892  4
ipt_state,ipt_MASQUERADE,iptable_nat,ip_conntrack_ftp
ip_tables              18560  4
ipt_state,ipt_MASQUERADE,iptable_nat,iptable_filter
apm                    21132  1 
ppp_deflate             6208  0 
zlib_deflate           22584  1 ppp_deflate
bsd_comp                5984  0 
af_packet              22504  4 
ppp_async              11520  1 
crc_ccitt               1920  1 ppp_async
ppp_generic            30068  7 ppp_deflate,bsd_comp,ppp_async
slhc                    7808  1 ppp_generic
sd_mod                 17904  0 
scsi_mod              125676  1 sd_mod
ipv6                  264096  12 
lp                     11080  0 
ide_cd                 42592  0 
cdrom                  40956  1 ide_cd
ehci_hcd               32068  0 
joydev                  9856  0 
usbhid                 32576  0 
ohci_hcd               21412  0 
usbcore               119396  5 ehci_hcd,usbhid,ohci_hcd
pci_hotplug            34448  0 
sis_agp                 8100  1 
agpgart                34600  2 sis_agp
parport_pc             37188  1 
parport                41704  2 lp,parport_pc
floppy                 61072  0 
tsdev                   7648  0 
mousedev               11576  1 
psmouse                21960  0 
pcspkr                  3464  0 
evdev                   9504  0 
dm_mod                 60284  0 
capability              4392  0 
commoncap               7008  1 capability
nvidia               3470108  12 
tulip                  47040  0 
crc32                   4192  1 tulip
rtc                    12664  0 
ext3                  126184  4 
jbd                    64056  1 ext3
mbcache                 9220  1 ext3
ide_generic             1280  0 
sis5513                17064  1 
ide_disk               20480  6 
ide_core              143024  4 ide_cd,ide_generic,sis5513,ide_disk
unix                   28564  285 
fbcon                  40416  0 
font                    8128  1 fbcon
vesafb                  6656  0 
cfbcopyarea             3936  1 vesafb
cfbimgblt               2880  1 vesafb
cfbfillrect             3584  1 vesafb

--------------------------------------------------------------------------------
# cat /etc/modutils/sound
# ALSA portion
alias char-major-116 snd
alias snd-card-0 snd-intel8x0
# module options should go here

# OSS/Free portion
alias char-major-14 soundcore
alias sound-slot-0 snd-card-0

# card #1
alias sound-service-0-0 snd-mixer-oss
alias sound-service-0-1 snd-seq-oss
alias sound-service-0-3 snd-pcm-oss
alias sound-service-0-8 snd-seq-oss
alias sound-service-0-12 snd-pcm-oss

--------------------------------------------------------------------------------
# dmesg
[...]
PCI: Found IRQ 5 for device 0000:00:02.7
PCI: Sharing IRQ 5 with 0000:00:02.6
ALSA
/usr/src/modules/alsa-driver-1.0.7/alsa-kernel/pci/ac97/ac97_codec.c:1964:
AC'97 0 does not respond - RESET
ALSA
/usr/src/modules/alsa-driver-1.0.7/alsa-kernel/pci/ac97/ac97_codec.c:1972:
AC'97 0 access is not valid [0xffffffff], removing mixer.
ALSA /usr/src/modules/alsa-driver-1.0.7/pci/intel8x0.c:1972: Unable to
initialize codec #0
Intel ICH: probe of 0000:00:02.7 failed with error -5

--------------------------------------------------------------------------------
(info provided by the oss module, might be interesting)
# rmmod snd_intel8x0 snd_ac97_codec
# modprobe i810_audio
# dmesg
[...]
Intel 810 + AC97 Audio, version 1.01, 04:05:25 Nov 25 2004
PCI: Found IRQ 5 for device 0000:00:02.7
PCI: Sharing IRQ 5 with 0000:00:02.6
i810: SiS 7012 found at IO 0x1800 and 0x1c00, MEM 0x0000 and 0x0000, IRQ
5
i810_audio: Codec not ready.. wait.. no response.
i810_audio: Audio Controller supports 6 channels.
i810_audio: Defaulting to base 2 channel mode.
i810_audio: Resetting connection 0
i810_audio: Primary codec not ready.
ac97_codec: AC97 Audio codec, id: 0x8384:0x7650 (Unknown)
i810_audio: AC'97 codec 0 supports AMAP, total channels = 2

----------------------------------------------------------------------
 rlrevell - 12-30-05 04:45 
----------------------------------------------------------------------
Any improvement with later ALSA releases?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-07-04 19:43 jefke          New Issue                                    
12-07-04 19:43 jefke          File Added: alsa-bug                         
12-07-04 19:43 jefke          Distribution              => Debian sid      
12-07-04 19:43 jefke          Kernel Version            => 2.6.9           
04-09-05 17:21 jdthood        Note Added: 0004420                          
12-30-05 04:45 rlrevell       Note Added: 0007222                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
