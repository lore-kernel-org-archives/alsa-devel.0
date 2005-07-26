From: Daniel James <daniel@64studio.com>
Subject: Hard lock-ups with MIDI on envy24 control, x86_64 machine
Date: Tue, 26 Jul 2005 17:39:12 +0100
Message-ID: <200507261739.13000.daniel@64studio.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: Free Ekanayaka <free@64studio.com>
List-Id: alsa-devel@alsa-project.org

Hello!

I discovered this reliably repeatable hard lock-up while attempting to 
use MIDI with 64 Studio, the Debian-based x86_64 distribution we are 
working on. The kernel is 2.6.12 (non-SMP, as I only have one CPU in 
this machine at the moment) with Ingo Molnar's realtime premption 
patches and ALSA base package 1.0.9b-2. The lockup happens when 
applications connect to the MIDI input of the soundcard - then the 
system bombs. The reset switch is all that will work. 

Using strace with seq24, the last two lines in the terminal are:

read (3, "#\n# ALSA library configuration "..., 4096) = 4096
read (3,

However, the lock-up is also repeatable with the 32-bit version of 
Mandrake 10.1 on the same hardware, which uses a fairly stock 2.6.8 
kernel.

Motherboard: Tyan Tiger K8W dual Opteron, 1GB RAM
CPU: Single Opteron 240
Card: M Audio Audiophile PCI

What can I do to help track this bug down? The hardware is otherwise 
rock-solid stable. Below I have included the output of lsmod and 
lspci when running 64 Studio.

Cheers

Daniel



daniel@64studio:~$ lsmod
Module                  Size  Used by
mga                    60160  1
drm                    71296  2 mga
ipv6                  272488  8
thermal                15184  0
fan                     5192  0
button                  7776  0
processor              24136  1 thermal
ac                      5576  0
battery                10568  0
realtime                6536  0
commoncap               8576  1 realtime
ehci_hcd               35592  0
uhci_hcd               34016  0
usbcore               130872  3 ehci_hcd,uhci_hcd
8139too                28544  0
8139cp                 23488  0
mii                     6336  2 8139too,8139cp
snd_ice1712            68896  2
snd_ice17xx_ak4xxx      4800  1 snd_ice1712
snd_ak4xxx_adda         7424  2 snd_ice1712,snd_ice17xx_ak4xxx
snd_cs8427             10176  1 snd_ice1712
snd_ac97_codec         88912  1 snd_ice1712
snd_pcm_oss            55648  0
snd_mixer_oss          19072  3 snd_pcm_oss
snd_pcm               100200  3 snd_ice1712,snd_ac97_codec,snd_pcm_oss
snd_page_alloc         10952  1 snd_pcm
snd_i2c                 6720  2 snd_ice1712,snd_cs8427
snd_mpu401_uart         9216  1 snd_ice1712
i2c_amd756              7684  0
hw_random               6048  0
i2c_amd8111             7040  0
i2c_core               25368  2 i2c_amd756,i2c_amd8111
amd64_agp              13164  1
agpgart                37132  2 drm,amd64_agp
pcspkr                  4368  0
tsdev                   9280  0
mousedev               13796  1
evdev                  11136  0
psmouse                29764  0
ide_cd                 43616  0
cdrom                  39656  1 ide_cd
snd_seq_dummy           4356  0
snd_seq_oss            36032  0
snd_seq_midi            9856  0
snd_rawmidi            28640  2 snd_mpu401_uart,snd_seq_midi
snd_seq_midi_event      9856  2 snd_seq_oss,snd_seq_midi
snd_seq                58880  9 
snd_seq_dummy,snd_seq_oss,snd_seq_midi,snd_seq_m idi_event
snd_timer              26784  2 snd_pcm,snd_seq
snd_seq_device          9680  5 
snd_seq_dummy,snd_seq_oss,snd_seq_midi,snd_rawmi di,snd_seq
snd                    59624  15 
snd_ice1712,snd_ak4xxx_adda,snd_cs8427,snd_ac97 
_codec,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_i2c,snd_mpu401_uart,snd_seq_oss,snd 
_rawmidi,snd_seq,snd_timer,snd_seq_device
soundcore              12000  3 snd
genrtc                 11380  0
ext3                  129744  1
jbd                    65920  1 ext3
mbcache                11784  1 ext3
ide_disk               18368  3
ide_generic             1536  0 [permanent]
via82cxxx              12336  0 [permanent]
trm290                  5252  0 [permanent]
triflex                 4544  0 [permanent]
slc90e66                6528  0 [permanent]
sis5513                14928  0 [permanent]
siimage                12928  0 [permanent]
serverworks             9360  0 [permanent]
sc1200                  8192  0 [permanent]
rz1000                  3264  0 [permanent]
piix                   12164  0 [permanent]
pdc202xx_old           12160  0 [permanent]
opti621                 5316  0 [permanent]
ns87415                 4780  0 [permanent]
hpt366                 20672  0 [permanent]
hpt34x                  6208  0 [permanent]
generic                 5376  0 [permanent]
cy82c693                5184  0 [permanent]
cs5530                  5952  0 [permanent]
cs5520                  5568  0 [permanent]
cmd64x                 12492  0 [permanent]
atiixp                  6736  0 [permanent]
amd74xx                14064  0 [permanent]
alim15x3               11352  0 [permanent]
aec62xx                 8640  0 [permanent]
pdc202xx_new           10112  0 [permanent]
ide_core              144772  28 
ide_cd,ide_disk,ide_generic,via82cxxx,trm290,tr 
iflex,slc90e66,sis5513,siimage,serverworks,sc1200,rz1000,piix,pdc202xx_old,opti6 
21,ns87415,hpt366,hpt34x,generic,cy82c693,cs5530,cs5520,cmd64x,atiixp,amd74xx,al 
im15x3,aec62xx,pdc202xx_new
unix                   32248  352

daniel@64studio:~$ lspci
0000:00:00.0 Host bridge: Advanced Micro Devices [AMD] AMD-8151 System 
Controller (rev 14)
0000:00:01.0 PCI bridge: Advanced Micro Devices [AMD] AMD-8151 AGP 
Bridge (rev 14)
0000:00:06.0 PCI bridge: Advanced Micro Devices [AMD] AMD-8111 PCI 
(rev 07)
0000:00:07.0 ISA bridge: Advanced Micro Devices [AMD] AMD-8111 LPC 
(rev 05)
0000:00:07.1 IDE interface: Advanced Micro Devices [AMD] AMD-8111 IDE 
(rev 03)
0000:00:07.2 SMBus: Advanced Micro Devices [AMD] AMD-8111 SMBus 2.0 
(rev 02)
0000:00:07.3 Bridge: Advanced Micro Devices [AMD] AMD-8111 ACPI (rev 
05)
0000:00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
0000:00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
0000:00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
0000:00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
0000:01:04.0 Multimedia audio controller: VIA Technologies Inc. 
ICE1712 [Envy24] PCI Multi-Channel I/O Controller (rev 02)
0000:01:08.0 Ethernet controller: Realtek Semiconductor Co., Ltd. 
RTL-8139/8139C/8139C+ (rev 10)
0000:01:0b.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 
1.1 Controller (rev 61)
0000:01:0b.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 
1.1 Controller (rev 61)
0000:01:0b.2 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 63)
0000:02:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G550 
AGP (rev 01)


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
