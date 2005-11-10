From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001401]: No Brooktree Bt878 in /proc/asound/cards
Date: Thu, 10 Nov 2005 15:04:50 +0100
Message-ID: <3c34adf54f8ec5ed49ce80a61f52cba3@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id ABB8B1E1
	for <alsa-devel@alsa-project.org>; Thu, 10 Nov 2005 15:04:50 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1401> 
======================================================================
Reported By:                ojec
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1401
Category:                   1_OTHERS
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               Gnetoo
Kernel Version:             2.6.13
======================================================================
Date Submitted:             09-07-2005 21:04 CEST
Last Modified:              11-10-2005 15:04 CET
======================================================================
Summary:                    No Brooktree Bt878 in /proc/asound/cards
Description: 
In alsa version 1.0.6 (included in kernel 2.6.10) a have record in
/proc/asound/cards that says:

2 [Bt878          ]: Bt87x - Brooktree Bt878
                     Brooktree Bt878 at 0xe3002000, irq 11

In alsa 1.0.9b (kernel 2.6.13) there is no record about bt87x.

# lspci

0000:00:00.0 Host bridge: VIA Technologies, Inc. VT8377 [KT400/KT600 AGP]
Host Bridge
0000:00:01.0 PCI bridge: VIA Technologies, Inc. VT8235 PCI Bridge
0000:00:09.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL-8139/8139C/8139C+ (rev 10)
0000:00:0a.0 Multimedia video controller: Brooktree Corporation Bt878
Video Capture (rev 11)
0000:00:0a.1 Multimedia controller: Brooktree Corporation Bt878 Audio
Capture (rev 11)
0000:00:0c.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1
(rev 07)
0000:00:0c.1 Input device controller: Creative Labs SB Live! MIDI/Game
Port (rev 07)
0000:00:0d.0 FireWire (IEEE 1394): Agere Systems FW323 (rev 61)
0000:00:10.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
Controller (rev 80)
0000:00:10.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
Controller (rev 80)
0000:00:10.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
Controller (rev 80)
0000:00:10.3 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 82)
0000:00:11.0 ISA bridge: VIA Technologies, Inc. VT8235 ISA Bridge
0000:00:11.1 IDE interface: VIA Technologies, Inc.
VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06)
0000:00:11.5 Multimedia audio controller: VIA Technologies, Inc.
VT8233/A/8235/8237 AC97 Audio Controller (rev 50)
0000:00:13.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL-8139/8139C/8139C+ (rev 10)
0000:01:00.0 VGA compatible controller: nVidia Corporation NV18 [GeForce4
MX 4000 AGP 8x] (rev c1)

# lsmod

snd_seq_midi            8672  0
snd_emu10k1_synth       7872  0
snd_emux_synth         38336  1 snd_emu10k1_synth
snd_seq_virmidi         7552  1 snd_emux_synth
snd_seq_midi_emul       7872  1 snd_emux_synth
raid1                  17664  1
nvidia               3467228  32
parport_pc             28164  1
lp                     10920  0
parport                37128  2 parport_pc,lp
tun                     8896  2
usb_storage            32192  0
8250                   23524  0
serial_core            23168  1 8250
tuner                  22052  0
msp3400                27112  0
bttv                  154128  2
video_buf              22148  1 bttv
firmware_class         10304  1 bttv
i2c_algo_bit            9928  1 bttv
v4l2_common             5760  1 bttv
btcx_risc               4808  1 bttv
i2c_core               22736  4 tuner,msp3400,bttv,i2c_algo_bit
videodev                9664  3 bttv
snd_rtctimer            3152  0
rtc                    12552  1 snd_rtctimer
snd_bt87x              13444  1
snd_via82xx            27456  0
snd_mpu401_uart         7872  1 snd_via82xx
snd_emu10k1            99396  4 snd_emu10k1_synth
snd_rawmidi            25120  4
snd_seq_midi,snd_seq_virmidi,snd_mpu401_uart,snd_emu10k1
snd_ac97_codec         75936  2 snd_via82xx,snd_emu10k1
snd_util_mem            4480  2 snd_emux_synth,snd_emu10k1
snd_hwdep               9540  2 snd_emux_synth,snd_emu10k1
usbhid                 32384  0
ehci_hcd               30916  0
uhci_hcd               33552  0

======================================================================

----------------------------------------------------------------------
 chenz - 11-10-05 15:04 
----------------------------------------------------------------------
I can confirm this problem with kernel 2.6.12 and 2.6.14.1 (alsa 1.0.10rc3
built seperately).

The module (snd-bt87x) loads successfully, but it seems to do nothing. It
does
not show up in /proc/asound/cards. Also, no log messages at all.

It all worked fine on kernel 2.6.8. Here log messages where generated:

/var/log/syslog.0:Nov  4 17:57:55 localhost kernel: bt878: AUDIO driver
version 0.0.0 loaded
/var/log/syslog.0:Nov  4 17:57:55 localhost kernel: bt878: Bt878 AUDIO
function found (0).
/var/log/syslog.0:Nov  4 17:57:55 localhost kernel: bt878(0): Bt878 (rev
17) at 00:14.1, irq: 137, latency: 64, memory: 0xfc9ff000


This is on an SMP machine by the way.

"lspci -v" output

0000:00:00.0 Host bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX Host
bridge (rev 03)
        Flags: bus master, medium devsel, latency 64
        Memory at f8000000 (32-bit, prefetchable) [size=64M]
        Capabilities: [a0] AGP version 1.0

0000:00:01.0 PCI bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX AGP
bridge (rev 03) (prog-if 00 [Normal decode])
        Flags: bus master, 66MHz, medium devsel, latency 64
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
        I/O behind bridge: 0000d000-0000dfff
        Memory behind bridge: fca00000-feafffff
        Prefetchable memory behind bridge: f0800000-f48fffff

0000:00:07.0 ISA bridge: Intel Corp. 82371AB/EB/MB PIIX4 ISA (rev 02)
        Flags: bus master, medium devsel, latency 0

0000:00:07.1 IDE interface: Intel Corp. 82371AB/EB/MB PIIX4 IDE (rev 01)
(prog-if 80 [Master])
        Flags: bus master, medium devsel, latency 64
        I/O ports at ffa0 [size=16]

0000:00:07.2 USB Controller: Intel Corp. 82371AB/EB/MB PIIX4 USB (rev 01)
(prog-if 00 [UHCI])
        Flags: bus master, medium devsel, latency 64, IRQ 185
        I/O ports at ef80 [size=32]

0000:00:07.3 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ACPI (rev 02)
        Flags: medium devsel, IRQ 9

0000:00:11.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX
[Cyclone] (rev 30)
        Subsystem: 3Com Corporation 3C905B Fast Etherlink XL 10/100
        Flags: bus master, medium devsel, latency 64, IRQ 177
        I/O ports at ec00 [size=128]
        Memory at febfff80 (32-bit, non-prefetchable) [size=128]
        Expansion ROM at febc0000 [disabled] [size=128K]
        Capabilities: [dc] Power Management version 1

0000:00:12.0 Multimedia audio controller: ESS Technology ES1969 Solo-1
Audiodrive (rev 01)
        Subsystem: LABWAY Corporation: Unknown device 4465
        Flags: bus master, medium devsel, latency 64, IRQ 193
        I/O ports at ef00 [size=64]
        I/O ports at efa0 [size=16]
        I/O ports at ef60 [size=16]
        I/O ports at eff4 [size=4]
        I/O ports at eff0 [size=4]
        Capabilities: [c0] Power Management version 1

0000:00:14.0 Multimedia video controller: Brooktree Corporation Bt878
Video Capture (rev 11)
        Subsystem: Pinnacle Systems Inc. PCTV pro (TV + FM stereo
receiver)
        Flags: bus master, medium devsel, latency 64, IRQ 201
        Memory at fc9fe000 (32-bit, prefetchable) [size=4K]
        Capabilities: [44] Vital Product Data
        Capabilities: [4c] Power Management version 2

0000:00:14.1 Multimedia controller: Brooktree Corporation Bt878 Audio
Capture (rev 11)
        Subsystem: Pinnacle Systems Inc. PCTV pro (TV + FM stereo
receiver, audio section)
        Flags: bus master, medium devsel, latency 64, IRQ 10
        Memory at fc9ff000 (32-bit, prefetchable) [size=4K]
        Capabilities: [44] Vital Product Data
        Capabilities: [4c] Power Management version 2

0000:01:00.0 VGA compatible controller: nVidia Corporation NV5M64 [RIVA
TNT2 Model 64/Model 64 Pro] (rev 15) (prog-if 00 [VGA])
        Subsystem: Siemens Nixdorf AG: Unknown device 006b
        Flags: bus master, 66MHz, medium devsel, latency 64, IRQ 10
        Memory at fd000000 (32-bit, non-prefetchable) [size=16M]
        Memory at f2000000 (32-bit, prefetchable) [size=32M]
        Expansion ROM at feaf0000 [disabled] [size=64K]
        Capabilities: [60] Power Management version 1
        Capabilities: [44] AGP version 2.0

"lsmod" ouput:

Module                  Size  Used by
snd_bt87x              15816  0
ipv6                  273920  10
floppy                 64196  0
pcspkr                  3876  0
rtc                    13784  0
tuner                  40584  0
msp3400                27264  0
bttv                  166960  0
video_buf              22724  1 bttv
firmware_class         10656  1 bttv
i2c_algo_bit           10024  1 bttv
v4l2_common             5952  1 bttv
btcx_risc               5128  1 bttv
tveeprom               14000  1 bttv
videodev                9600  1 bttv
snd_es1938             23716  0
gameport               16488  2 snd_es1938
snd_pcm_oss            53600  0
snd_mixer_oss          19584  1 snd_pcm_oss
snd_pcm                94372  3 snd_bt87x,snd_es1938,snd_pcm_oss
snd_page_alloc         11176  2 snd_bt87x,snd_pcm
snd_opl3_lib           11904  1 snd_es1938
snd_timer              26180  2 snd_pcm,snd_opl3_lib
snd_hwdep               9664  1 snd_opl3_lib
snd_mpu401_uart         8544  1 snd_es1938
snd_rawmidi            26304  1 snd_mpu401_uart
snd_seq_device          9196  2 snd_opl3_lib,snd_rawmidi
snd                    59652  11
snd_bt87x,snd_es1938,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_opl3_lib,snd_timer,snd_hwdep,snd_mpu401_uart,snd_rawmidi,snd_seq_device
soundcore              10304  1 snd
i2c_piix4               9168  0
i2c_core               22400  6
tuner,msp3400,bttv,i2c_algo_bit,tveeprom,i2c_piix4
shpchp                102724  0
pci_hotplug            30140  1 shpchp
intel_agp              23740  1
uhci_hcd               34864  0
usbcore               127200  2 uhci_hcd
3c59x                  44008  0
mii                     5664  1 3c59x
agpgart                36588  1 intel_agp
tsdev                   7776  0
mousedev               12068  1
psmouse                39716  0
ide_cd                 44228  0
cdrom                  41856  1 ide_cd
ext3                  148328  2
jbd                    63828  1 ext3
mbcache                10404  1 ext3
ide_disk               19488  4
ide_generic             1408  0 [permanent]
via82cxxx              14172  0 [permanent]
trm290                  4580  0 [permanent]
triflex                 4032  0 [permanent]
slc90e66                6368  0 [permanent]
sis5513                16840  0 [permanent]
siimage                12832  0 [permanent]
serverworks             9800  0 [permanent]
sc1200                  7744  0 [permanent]
rz1000                  2816  0 [permanent]
piix                   10980  0 [permanent]
pdc202xx_old           11616  0 [permanent]
opti621                 5092  0 [permanent]
ns87415                 4616  0 [permanent]
hpt366                 20416  0 [permanent]
hpt34x                  5568  0 [permanent]
generic                 4740  0 [permanent]
cy82c693                5028  0 [permanent]
cs5530                  5888  0 [permanent]
cs5520                  4960  0 [permanent]
cmd64x                 12444  0 [permanent]
atiixp                  6480  0 [permanent]
amd74xx                15004  0 [permanent]
alim15x3               12492  0 [permanent]
aec62xx                 7840  0 [permanent]
pdc202xx_new            9344  0 [permanent]
ide_core              132432  28
ide_cd,ide_disk,ide_generic,via82cxxx,trm290,triflex,slc90e66,sis5513,siimage,serverworks,sc1200,rz1000,piix,pdc202xx_old,opti621,ns87415,hpt366,hpt34x,generic,cy82c693,cs5530,cs5520,cmd64x,atiixp,amd74xx,alim15x3,aec62xx,pdc202xx_new
unix                   29648  244

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-07-05 21:04 ojec           New Issue                                    
09-07-05 21:04 ojec           Distribution              => Gnetoo          
09-07-05 21:04 ojec           Kernel Version            => 2.6.13          
11-09-05 20:22 chenz          Issue Monitored: chenz                       
11-10-05 15:04 chenz          Note Added: 0006663                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
