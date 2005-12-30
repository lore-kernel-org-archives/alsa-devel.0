From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001106]: capture through OSS emulation works only with two programs with M-Audion Revolution 7.1
Date: Fri, 30 Dec 2005 04:07:13 +0100
Message-ID: <22b1fed48c1aeafd7702e2d51e6c3ae3@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 70E6B19E
	for <alsa-devel@alsa-project.org>; Fri, 30 Dec 2005 04:07:14 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1106> 
======================================================================
Reported By:                sst4
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1106
Category:                   PCI - ice1724
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     new
Distribution:               Mandriva 10.2
Kernel Version:             2.6.11-6mdk-i586-up-1GB
======================================================================
Date Submitted:             05-14-2005 02:11 CEST
Last Modified:              12-30-2005 04:07 CET
======================================================================
Summary:                    capture through OSS emulation works only with two
programs with M-Audion Revolution 7.1
Description: 
This is in a sense continuation of

https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1096 ,
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1095 .

The card, M-Audio Revolution 7.1, sometimes is apparently able to perform
capture through OSS emulation layer.

The behavior was incidentally discovered - 'xawtv' was up and then 'vlc'
was invoked.

In the 'vlc' I chose

File -> "Open Capture Device"

Capture devices string in 'vlc' was:

v4l:// :v4l-vdev="/dev/video" :v4l-adev="/dev/dsp"
.

With the two programs, 'xawtv' and 'vlc' the card performs capture from
its line input, though capture is not stable.

If only 'xawtv' or only 'vlc' is capture does not happen.

Sooner rather than later 'vlc' crashes with a messages like this:

*** glibc detected *** double free or corruption (!prev): 0x08899d50 ***
.

Please see full 'vlc' log file below.

Please see detailed information ALSA setup, the system, etc. below.

There is no ~/.asoundrc and no /etc/asound.conf file.

I'm giving the issue "block" severity because the card was
bought specifically to perform high quality siund capture.

I'm not usre whether this is only the driver issue or/and
tools/OSS emulation issue.

Thanks in advance,
  Sergei.


[root@athlon ~]# uname -a
Linux athlon.home.net 2.6.11-6mdk-i586-up-1GB #1 Tue Mar 22 15:46:07 CET
2005 i686 AMD Athlon(tm) XP 1900+ unknown GNU/Linux
[root@athlon ~]# ls -lt /proc/asound/
total 1
dr-xr-xr-x  6 root root 0 May 14 01:24 card0/
-r--r--r--  1 root root 0 May 14 01:24 cards
-r--r--r--  1 root root 0 May 14 01:24 devices
-r--r--r--  1 root root 0 May 14 01:24 modules
dr-xr-xr-x  2 root root 0 May 14 01:24 oss/
-r--r--r--  1 root root 0 May 14 01:24 pcm
dr-xr-xr-x  2 root root 0 May 14 01:24 seq/
-r--r--r--  1 root root 0 May 14 01:24 timers
-r--r--r--  1 root root 0 May 14 01:24 version
lrwxrwxrwx  1 root root 5 May 14 01:24 Revolution71 -> card0/
[root@athlon ~]# cat /proc/asound/version
Advanced Linux Sound Architecture Driver Version 1.0.8.[root@athlon ~]#
cat /proc/asound/cards
0 [Revolution71   ]: ICE1724 - M Audio Revolution-7.1
                     M Audio Revolution-7.1 at 0xe400, irq 5
[root@athlon ~]# cat /proc/asound/devices
 18: [0- 2]: digital audio playback
 17: [0- 1]: digital audio playback
 16: [0- 0]: digital audio playback
 24: [0- 0]: digital audio capture
  0: [0- 0]: ctl
  1:       : sequencer
 33:       : timer
[root@athlon ~]# cat /proc/asound/modules
0 snd-ice1724
[root@athlon ~]# cat /proc/asound/pcm
00-00: ICE1724 : ICE1724 : playback 1 : capture 1
00-01: IEC1724 IEC958 : IEC1724 IEC958 : playback 1
00-02: ICE1724 Surrounds : ICE1724 Surround PCM : playback 3
[root@athlon ~]# ls -lt /proc/asound/card0/
total 0
-r--r--r--  1 root root 0 May 14 01:57 ice1724
-r--r--r--  1 root root 0 May 14 01:57 id
-rw-r--r--  1 root root 0 May 14 01:57 oss_mixer
dr-xr-xr-x  3 root root 0 May 14 01:57 pcm0c/
dr-xr-xr-x  3 root root 0 May 14 01:57 pcm0p/
dr-xr-xr-x  3 root root 0 May 14 01:57 pcm1p/
dr-xr-xr-x  5 root root 0 May 14 01:57 pcm2p/
[root@athlon ~]# cat /proc/asound/card0/ice1724
M Audio Revolution-7.1 at 0xe400, irq 5

EEPROM:
  Subvendor        : 0x12143036
  Size             : 19 bytes
  Version          : 2
  System Config    : 0x43
  ACLink           : 0x80
  I2S              : 0xf8
  S/PDIF           : 0xc1
  GPIO direction   : 0x4000fa
  GPIO mask        : 0xbfff85
  GPIO state       : 0x72
  Extra #18        : 0x0

Registers:
  PSDOUT03 : 0x00000002
  CCS00    : 0x00
  CCS01    : 0xa0
  CCS02    : 0x00
  CCS03    : 0x00
  CCS04    : 0x43
  CCS05    : 0x80
  CCS06    : 0xf8
  CCS07    : 0xc1
  CCS08    : 0x00
  CCS09    : 0x00
  CCS0a    : 0x00
  CCS0b    : 0x00
  CCS0c    : 0x00
  CCS0d    : 0x0a
  CCS0e    : 0x00
  CCS0f    : 0x00
  CCS10    : 0x00
  CCS11    : 0x00
  CCS12    : 0x12
  CCS13    : 0x80
  CCS14    : 0x7e
  CCS15    : 0xff
  CCS16    : 0x85
  CCS17    : 0xff
  CCS18    : 0xfa
  CCS19    : 0x00
  CCS1a    : 0x40
  CCS1b    : 0x00
  CCS1c    : 0x00
  CCS1d    : 0x00
  CCS1e    : 0x7f
  CCS1f    : 0xbf
  MT00     : 0x00
  MT01     : 0x08
  MT02     : 0x00
  MT03     : 0x08
  MT04     : 0x00
  MT05     : 0x08
  MT06     : 0x00
  MT07     : 0x00
  MT08     : 0x00
  MT09     : 0x00
  MT0a     : 0x00
  MT0b     : 0x00
  MT0c     : 0x00
  MT0d     : 0x00
  MT0e     : 0x00
  MT0f     : 0x00
  MT10     : 0x40
  MT11     : 0x06
  MT12     : 0xac
  MT13     : 0x35
  MT14     : 0x6f
  MT15     : 0xfe
  MT16     : 0x00
  MT17     : 0x00
  MT18     : 0x01
  MT19     : 0x03
  MT1a     : 0x00
  MT1b     : 0x00
  MT1c     : 0xff
  MT1d     : 0x1f
  MT1e     : 0x00
  MT1f     : 0x00
  MT20     : 0x20
  MT21     : 0xab
  MT22     : 0xb1
  MT23     : 0x35
  MT24     : 0x37
  MT25     : 0x95
  MT26     : 0xff
  MT27     : 0x0f
  MT28     : 0x00
  MT29     : 0x00
  MT2a     : 0x00
  MT2b     : 0x00
  MT2c     : 0x02
  MT2d     : 0x00
  MT2e     : 0x00
  MT2f     : 0x00
[root@athlon ~]# cat /proc/asound/card0/id
Revolution71
[root@athlon ~]# cat /proc/asound/card0/oss_mixer
VOLUME "" 0
BASS "" 0
TREBLE "" 0
SYNTH "" 0
PCM "" 0
SPEAKER "" 0
LINE "" 0
MIC "" 0
CD "" 0
IMIX "" 0
ALTPCM "" 0
RECLEV "" 0
IGAIN "" 0
OGAIN "" 0
LINE1 "" 0
LINE2 "" 0
LINE3 "" 0
DIGITAL1 "IEC958" 0
DIGITAL2 "" 0
DIGITAL3 "" 0
PHONEIN "" 0
PHONEOUT "" 0
VIDEO "" 0
RADIO "" 0
MONITOR "" 0
[root@athlon ~]# cat /proc/asound/card0/pcm0c/info
card: 0
device: 0
subdevice: 0
stream: CAPTURE
id: ICE1724
name: ICE1724
subname: subdevice #0
class: 0
subclass: 0
subdevices_count: 1
subdevices_avail: 1
[root@athlon ~]# la -lt /proc/asound/card0/pcm0c/oss
-rw-r--r--  1 root root 0 May 14 02:04 /proc/asound/card0/pcm0c/oss
ls -lt /proc/asound/card0/pcm0c/sub0/
total 0
-r--r--r--  1 root root 0 May 14 02:06 hw_params
-r--r--r--  1 root root 0 May 14 02:06 info
-r--r--r--  1 root root 0 May 14 02:06 prealloc
-r--r--r--  1 root root 0 May 14 02:06 status
-r--r--r--  1 root root 0 May 14 02:06 sw_params
[root@athlon ~]# cat /proc/asound/card0/pcm0c/sub0/hw_params
closed
[root@athlon ~]# cat /proc/asound/card0/pcm0c/sub0/sw_params
closed
[root@athlon ~]# cat /proc/asound/card0/pcm0c/sub0/info
card: 0
device: 0
subdevice: 0
stream: CAPTURE
id: ICE1724
name: ICE1724
subname: subdevice #0
class: 0
subclass: 0
subdevices_count: 1
subdevices_avail: 1
[root@athlon ~]# cat /proc/asound/card0/pcm0c/sub0/prealloc
256
[root@athlon ~]# cat /proc/asound/card0/pcm0c/sub0/status
closed
[root@athlon ~]# ls -lt /proc/asound/oss/
total 0
-r--r--r--  1 root root 0 May 14 01:26 devices
-r--r--r--  1 root root 0 May 14 01:26 sndstat
[root@athlon ~]#

[root@athlon ~]# cat /proc/asound/oss/devices
  0: [0- 0]: mixer
  3: [0- 3]: digital audio
 12: [0-12]: digital audio
  1:       : sequencer
  8:       : sequencer
[root@athlon ~]# cat /proc/asound/oss/sndstat
Sound Driver:3.8.1a-980706 (ALSA v1.0.8 emulation code)
Kernel: Linux athlon.home.net 2.6.11-6mdk-i586-up-1GB #1 Tue Mar 22
15:46:07 CET 2005 i686
Config options: 0

Installed drivers:
Type 10: ALSA emulation

Card config:
M Audio Revolution-7.1 at 0xe400, irq 5

Audio devices:
0: ICE1724 (DUPLEX)

Synth devices: NOT ENABLED IN CONFIG

Midi devices: NOT ENABLED IN CONFIG

Timers:
7: system timer

Mixers:
0: ICE1724 - multitrack
[root@athlon ~]#
-----------------------------------------------------------------------------
[root@athlon ~]# cat /etc/modprobe.conf
# This file is autogenerated from /etc/modules.conf using
generate-modprobe.conf command

alias eth0 8139too
install usb-interface /sbin/modprobe uhci-hcd; /sbin/modprobe ohci-hcd;
/sbin/modprobe ehci-hcd; /bin/true
alias eth1 eepro100
options bttv radio=0 gbuffers=4
install snd-ice1724 /sbin/modprobe --first-time --ignore-install
snd-ice1724 && { /sbin/modprobe snd-pcm-oss; /bin/true; }

alias snd-0 snd-ice1724
# --- BEGIN: Generated by ALSACONF, do not edit. ---
# --- ALSACONF verion 1.0.8 ---
options snd  device_mode=0666
alias sound-slot-0 snd-ice1724
# --- END: Generated by ALSACONF, do not edit. ---

options snd-ice1724 model=revo71
[root@athlon ~]#           
=============================================================================

-----------------------------------------------------------------------------
[root@athlon ~]# lspci -vv
00:00.0 Host bridge: Advanced Micro Devices [AMD] AMD-760 [IGD4-1P] System
Controller (rev 14)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 32
        Region 0: Memory at e0000000 (32-bit, prefetchable) [size=64M]
        Region 1: Memory at eb100000 (32-bit, prefetchable) [size=4K]
        Region 2: I/O ports at d000 [disabled] [size=4]
        Capabilities: [a0] AGP version 2.0
                Status: RQ=16 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64-
HTrans- 64bit- FW- AGP3- Rate=x1,x2
                Command: RQ=1 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit- FW-
Rate=x1

00:01.0 PCI bridge: Advanced Micro Devices [AMD] AMD-760 [IGD4-1P] AGP
Bridge (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
        I/O behind bridge: 0000c000-0000cfff
        Memory behind bridge: e8000000-e9ffffff
        Prefetchable memory behind bridge: e4000000-e7ffffff
        BridgeCtl: Parity- SERR+ NoISA+ VGA+ MAbort- >Reset- FastB2B-

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South]
(rev 40)
        Subsystem: VIA Technologies, Inc. VT82C686/A PCI to ISA Bridge
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.1 IDE interface: VIA Technologies, Inc.
VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06) (prog-if
8a [Master SecP PriP])
        Subsystem: VIA Technologies, Inc.
VT82C586/B/VT82C686/A/B/VT8233/A/C/VT8235 PIPC Bus Master IDE
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Region 4: I/O ports at d400 [size=16]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
Controller (rev 1a) (prog-if 00 [UHCI])
        Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin D routed to IRQ 10
        Region 4: I/O ports at d800 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.3 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
Controller (rev 1a) (prog-if 00 [UHCI])
        Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin D routed to IRQ 10
        Region 4: I/O ports at dc00 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.4 SMBus: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev
40)
        Subsystem: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin ? routed to IRQ 9
        Capabilities: [68] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:09.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL-8139/8139C/8139C+ (rev 10)
        Subsystem: Realtek Semiconductor Co., Ltd. RT8139
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (8000ns min, 16000ns max)
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at e000 [size=256]
        Region 1: Memory at eb104000 (32-bit, non-prefetchable)
[size=256]
        Expansion ROM at <unassigned> [disabled] [size=64K]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1+,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0a.0 Multimedia video controller: Brooktree Corporation Bt878 Video
Capture (rev 11)
        Subsystem: Pinnacle Systems Inc. PCTV pro (TV + FM stereo
receiver)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (4000ns min, 10000ns max)
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at eb101000 (32-bit, prefetchable) [size=4K]
        Capabilities: [44] Vital Product Data
        Capabilities: [4c] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0a.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture
(rev 11)
        Subsystem: Pinnacle Systems Inc. PCTV pro (TV + FM stereo
receiver, audio section)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (1000ns min, 63750ns max)
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at eb102000 (32-bit, prefetchable) [size=4K]
        Capabilities: [44] Vital Product Data
        Capabilities: [4c] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0c.0 Multimedia audio controller: VIA Technologies Inc. VT1720/24
[Envy24PT/HT] PCI Multi-Channel Audio Controller (rev 01)
        Subsystem: VIA Technologies Inc. M-Audio Revolution 7.1
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Interrupt: pin A routed to IRQ 5
        Region 0: I/O ports at e400 [size=32]
        Region 1: I/O ports at e800 [size=128]
        Capabilities: [80] Power Management version 1
                Flags: PMEClk- DSI- D1- D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0f.0 Ethernet controller: Intel Corporation 82557/8/9 [Ethernet Pro
100] (rev 02)
        Subsystem: Intel Corporation EtherExpress PRO/100B (TX)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR+
        Latency: 32 (2000ns min, 14000ns max)
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at eb103000 (32-bit, prefetchable) [size=4K]
        Region 1: I/O ports at ec00 [size=32]
        Region 2: Memory at eb000000 (32-bit, non-prefetchable) [size=1M]
        Expansion ROM at <unassigned> [disabled] [size=1M]

00:11.0 USB Controller: NEC Corporation USB (rev 41) (prog-if 10 [OHCI])
        Subsystem: NEC Corporation USB
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR+
        Latency: 32 (250ns min, 10500ns max), cache line size 08
        Interrupt: pin A routed to IRQ 5
        Region 0: Memory at eb105000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.1 USB Controller: NEC Corporation USB (rev 41) (prog-if 10 [OHCI])
        Subsystem: NEC Corporation USB
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR+
        Latency: 32 (250ns min, 10500ns max), cache line size 08
        Interrupt: pin B routed to IRQ 11
        Region 0: Memory at eb106000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.2 USB Controller: NEC Corporation USB 2.0 (rev 02) (prog-if 20
[EHCI])
        Subsystem: Giga-byte Technology: Unknown device 5004
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR+
        Latency: 32 (4000ns min, 8500ns max), cache line size 10
        Interrupt: pin C routed to IRQ 11
        Region 0: Memory at eb107000 (32-bit, non-prefetchable)
[size=256]
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:05.0 VGA compatible controller: ATI Technologies Inc Rage 128 RF/SG AGP
(prog-if 00 [VGA])
        Subsystem: ATI Technologies Inc Rage 128 AIW AGP
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (2000ns min), cache line size 08
        Interrupt: pin A routed to IRQ 5
        Region 0: Memory at e4000000 (32-bit, prefetchable) [size=64M]
        Region 1: I/O ports at c000 [size=256]
        Region 2: Memory at e9000000 (32-bit, non-prefetchable)
[size=16K]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [50] AGP version 2.0
                Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64-
HTrans- 64bit- FW- AGP3- Rate=x1,x2
                Command: RQ=16 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit- FW-
Rate=x1
        Capabilities: [5c] Power Management version 1
                Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

[root@athlon ~]# 
=============================================================================


-----------------------------------------------------------------------------
'vlc' log:


VLC media player 0.8.1 Janus
libhal.c 767 : org.freedesktop.DBus.Error.ServiceDoesNotExist raised
"Service "org.freedesktop.Hal" does not exist"

[00000000] main root debug: VLC media player - version 0.8.1 Janus - (c)
1996-2004 VideoLAN
[00000000] main root debug: libvlc was configured with ./configure
--build=i586-mandrake-linux-gnu --prefix=/usr --exec-prefix=/usr
--bindir=/usr/bin --sbindir=/usr/sbin --sysconfdir=/etc
--datadir=/usr/share --includedir=/usr/include --libdir=/usr/lib
--libexecdir=/usr/lib --localstatedir=/var/lib --sharedstatedir=/usr/com
--mandir=/usr/share/man --infodir=/usr/share/info --enable-release
--enable-dvd --without-dvdcss --disable-dvdplay --enable-mozilla
--disable-gtk --disable-gnome --enable-ncurses --enable-lirc
--enable-wxwindows --enable-x11 --enable-xvideo --enable-fb --disable-mga
--enable-aa --enable-sdl --enable-ggi --enable-xosd --enable-mad
--enable-pp --enable-ffmpeg --with-ffmpeg-tree=ffmpeg-20041113
--with-x264-tree=x264-20041029 --enable-vorbis --enable-ogg
--enable-theora --enable-speex --enable-flac --enable-mkv --disable-dv
--enable-dvbpsi --enable-dvb --enable-esd --enable-alsa --enable-arts
--enable-libmpeg2 --disable-dts --enable-livedotcom
--with-livedotcom-tree=/usr/lib/live --enable-v4l --enable-gnutls
--disable-rpath
[00000001] main vlc debug: translation test: code is "C"
[00000001] main vlc debug: opening config file
/ibm/home/sergei/.vlc/vlcrc
[00000001] main vlc debug: checking builtin modules
[00000001] main vlc debug: checking plugin modules
[00000001] main vlc debug: loading plugins cache file
/ibm/home/sergei/.vlc/cache/plugins-04041e.dat
[00000001] main vlc debug: recursively browsing `modules'
[00000001] main vlc debug: recursively browsing `/usr/lib/vlc'
[00000001] main vlc debug: recursively browsing `plugins'
[00000001] main vlc debug: module bank initialized, found 170 modules
[00000001] main vlc debug: opening config file
/ibm/home/sergei/.vlc/vlcrc
[00000001] main vlc debug: CPU has capabilities 486 586 MMX 3DNow! MMXEXT
SSE FPU 
[00000001] main vlc debug: looking for memcpy module
[00000001] main vlc debug: probing 4 candidates
[00000010] main module debug: using memcpy module "memcpymmxext"
[00000218] main playlist debug: creating group Normal with id 1 at
position 0
[00000218] main playlist debug: waiting for thread completion
[00000218] main playlist debug: thread -1214280784 (playlist) created at
priority 0 (src/playlist/playlist.c:107)
[00000219] main interface debug: looking for interface module
[00000219] main interface debug: probing 1 candidate
[00000106] main module debug: using interface module "hotkeys"
[00000219] main interface debug: interface initialized
[00000219] main interface debug: thread -1222693968 (interface) created at
priority 0 (src/interface/interface.c:209)
[00000221] main interface debug: looking for interface module
[00000221] main interface debug: probing 2 candidates
[00000144] main module debug: using interface module "wxwindows"
[00000221] main interface debug: interface initialized
[00000221] main interface debug: thread -1244120144 (manager) created at
priority 0 (src/interface/interface.c:194)
[00000221] wxwindows interface debug: accelerator table loaded
[00000221] main interface error: option dvdnav-caching does not exist
[00000221] main interface error: option dvdnav-caching does not exist
[00000218] main playlist debug: adding playlist item `v4l://' ( v4l:// )
[00000218] main playlist debug: creating new input thread
[00000224] main input debug: set input option: v4l-vdev to /dev/video
[00000224] main input debug: set input option: v4l-adev to /dev/dsp
[00000224] main input debug: waiting for thread completion
[00000224] main input debug: thread -1253622864 (input) created at
priority 0 (src/input/input.c:228)
[00000224] main input debug: `v4l://' gives access `v4l' demux `' path `'
[00000224] main input debug: demux2_New: access='v4l' demux='' path=''
[00000225] main demuxer debug: looking for access_demux module
[00000225] main demuxer debug: probing 1 candidate
[00000225] v4l demuxer debug: V4L device BT878 video (Pinnacle PCTV Stud 3
channels 1 audios 48 < w < 924 32 < h < 576
[00000225] v4l demuxer debug: invalid width 0
[00000225] v4l demuxer debug: invalid height 0
[00000225] v4l demuxer debug: setting channel Television(0) 1 tuners
flags=0x3 type=0x1 norm=0x0
[00000225] v4l demuxer debug: will use 704x528
[00000225] v4l demuxer debug: v4l device uses brightness: 32768
[00000225] v4l demuxer debug: v4l device uses colour: 32768
[00000225] v4l demuxer debug: v4l device uses hue: 32768
[00000225] v4l demuxer debug: v4l device uses contrast: 32768
[00000225] v4l demuxer debug: v4l device uses frame size: 1486848
[00000225] v4l demuxer debug: v4l device uses chroma: RV32
[00000225] v4l demuxer warning: RV32 refused
[00000225] v4l demuxer error: chroma selection failed
[00000225] v4l demuxer debug: openened adev=`/dev/dsp' stereo 44100Hz
[00000225] v4l demuxer debug: v4l grabbing started
[00000225] v4l demuxer debug: new audio es 2 channels 44100Hz
[00000224] main input debug: Selecting program id=0
[00000067] main module debug: using access_demux module "v4l"
[00000227] main decoder debug: looking for decoder module
[00000227] main decoder debug: probing 17 candidates
[00000227] araw decoder debug: samplerate:44100Hz channels:2
bits/sample:16
[00000083] main module debug: using decoder module "araw"
[00000227] main decoder debug: thread -1270764624 (decoder) created at
priority 0 (src/input/decoder.c:157)
[00000224] main input debug: `v4l://' sucessfully opened
[00000227] main decoder debug: no aout present, spawning one
[00000234] main audio output debug: looking for audio output module
[00000234] main audio output debug: probing 3 candidates
[00000234] alsa audio output debug: opening ALSA device `default'
[00000234] main audio output debug: thread -1279427664 (aout) created at
priority 0 (alsa.c:603)
[00000217] main module debug: using audio output module "alsa"
[00000234] main audio output debug: output 'fl32' 44100 Hz Stereo frame=1
samples/8 bytes
[00000234] main audio output debug: mixer 'fl32' 44100 Hz Stereo frame=1
samples/8 bytes
[00000234] main audio output debug: no need for any filter
[00000234] main audio output debug: looking for audio mixer module
[00000234] main audio output debug: probing 3 candidates
[00000073] main module debug: using audio mixer module "float32_mixer"
[00000234] main audio output debug: input 's16l' 44100 Hz Stereo frame=1
samples/4 bytes
[00000234] main audio output debug: filter(s) 's16l'->'fl32' 44100
Hz->44100 Hz Stereo->Stereo
[00000236] main private debug: looking for audio filter module
[00000236] main private debug: probing 22 candidates
[00000044] main module debug: using audio filter module "s16tofloat32"
[00000234] main audio output debug: found a filter for the whole
conversion
[00000234] main audio output debug: filter(s) 'fl32'->'fl32' 48510
Hz->44100 Hz Stereo->Stereo
[00000255] main private debug: looking for audio filter module
[00000255] main private debug: probing 22 candidates
[00000026] main module debug: using audio filter module
"bandlimited_resampler"
[00000234] main audio output debug: found a filter for the whole
conversion
[00000234] main audio output warning: buffer is 40018 in advance,
triggering downsampling
[00000234] main audio output warning: timing screwed, stopping resampling
[00000234] main audio output warning: buffer is 64711 in advance,
triggering downsampling
[00000234] main audio output warning: timing screwed, stopping resampling
[00000234] main audio output warning: buffer is 100571 in advance,
triggering downsampling



*** glibc detected *** double free or corruption (!prev): 0x08899d50 ***

=============================================================================

======================================================================

----------------------------------------------------------------------
 sst4 - 05-24-05 21:52 
----------------------------------------------------------------------
I am not sure how to answer your question about kernel or aoss emulation.

I didn't perform any specific manual OSS configuration - I simply used
configuration produced by
Mandriva Linux tools.

Contents of what files and/or output of what commands can give a more
precise answer to
your question ?

----------------------------------------------------------------------
 rlrevell - 12-30-05 04:07 
----------------------------------------------------------------------
Any improvement with later releases?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-14-05 02:11 sst4           New Issue                                    
05-14-05 02:11 sst4           Distribution              => Mandriva 10.2   
05-14-05 02:11 sst4           Kernel Version            =>
2.6.11-6mdk-i586-up-1GB
05-24-05 12:11 tiwai          Note Added: 0004714                          
05-24-05 21:52 sst4           Note Added: 0004731                          
12-30-05 04:07 rlrevell       Note Added: 0007200                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
