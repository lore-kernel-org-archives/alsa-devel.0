From: kreuzritter2000@gmx.de
Subject: EWS64XL: cs4232 alsa driver is no more  working with Alsa 0.9.0beta12 and Sam9407 driver , Alsa0.5.x worked fine
Date: Wed, 6 Mar 2002 15:21:48 +0100 (MET)
Message-ID: <7648.1015424508@www40.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Received: from mx0.gmx.net (mx0.gmx.net [213.165.64.100])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with SMTP id PAA16669
	for <alsa-devel@alsa-project.org>; Wed, 6 Mar 2002 15:22:26 +0100
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello,



I have a Terratec Audiosystem EWS64XL soundcard that has the sam9407 and
cs4232 soundchip.

In the past i used the sam9407 drivers from
http://www.anime.net/~goemon/linux-sam9407/
together with the snd-card-cs4232 driver from ALSA version 0.5.x.

This combination worked fine.
The sam9407 driver was started first to initialize the cs4232 (CoDec) chip
on my soundcard,
 so that the Alsa 0.5.x cs4232 driver could use it.



But yesterday i switched from Alsa 0.5.x to Alsa 0.9.x but the snd-cs4232
sounddriver from Alsa 0.9.x could not be loaded.

Alsa 0.9.x doesn't work.


Here are some logs, error messages and other infos that could be interesting
for you:



Beginning of listing

------------------
System: Athlon Classic 500 MHz, ASUS K7M, Terratec Audiosystem EWS64 XL
Distribution: Slackware 8.0
Kernel Version:  Linux-2.4.18
Soundrivers:  sam9407-1.0.0  and  alsa-driver-0.9.0beta12 +
alsa-oss-0.9.0beta11
Soundchips on Soundcard:   sam9407 and CS4232 (cs4232 is initialized via
sam9407
 driver)



--------------
$ ./configure --with-oss=yes --with-cards=cs4232,dummy,mpu401 
 --with-sequencer=no --with-isapnp=no --with-debug=full
and
$ ./configure --with-oss=yes --with-cards=cs4232,dummy,mpu401
 --with-sequencer=yes --with-isapnp=yes --with-debug=detect
With-isapnp yes or no, there is no diference. Driver doesn't load/work.





-------------------------------
 $ modprobe snd-cs4232
/lib/modules/2.4.18/kernel/sound/isa/cs423x/snd-cs4232.o: init_module: No
such
 device
/lib/modules/2.4.18/kernel/sound/isa/cs423x/snd-cs4232.o: Hint: insmod
errors
 can be caused by incorrect module parameters, including invalid IO or IRQ
 parameters
/lib/modules/2.4.18/kernel/sound/isa/cs423x/snd-cs4232.o: insmod
 /lib/modules/2.4.18/kernel/sound/isa/cs423x/snd-cs4232.o failed
/lib/modules/2.4.18/kernel/sound/isa/cs423x/snd-cs4232.o: insmod snd-cs4232
 failed
$




----------------------------
$  insmod snd-cs4232
Using /lib/modules/2.4.18/kernel/sound/isa/cs423x/snd-cs4232.o
/lib/modules/2.4.18/kernel/sound/isa/cs423x/snd-cs4232.o: unresolved symbol
 snd_cs4231_timer_Rd7b3a479
/lib/modules/2.4.18/kernel/sound/isa/cs423x/snd-cs4232.o: unresolved symbol
 snd_opl3_create_R7cfd1ec5
/lib/modules/2.4.18/kernel/sound/isa/cs423x/snd-cs4232.o: unresolved symbol
 snd_opl3_hwdep_new_R0cd48230
/lib/modules/2.4.18/kernel/sound/isa/cs423x/snd-cs4232.o: unresolved symbol
 snd_cs4231_mixer_Rb6145477
/lib/modules/2.4.18/kernel/sound/isa/cs423x/snd-cs4232.o: unresolved symbol
 snd_cs4231_pcm_R6e831eea
/lib/modules/2.4.18/kernel/sound/isa/cs423x/snd-cs4232.o: unresolved symbol
 snd_mpu401_uart_new_R606a10b8
/lib/modules/2.4.18/kernel/sound/isa/cs423x/snd-cs4232.o: unresolved symbol
 snd_cs4231_create_R1b369888
$




-------------------------
 $ cat  /var/log/syslog
Mar  6 00:52:54 blackbox kernel: CS4232 soundcard not found or device busy
Mar  6 00:56:41 blackbox kernel: CS4232 soundcard not found or device busy
Mar  6 00:56:53 blackbox modprobe: modprobe: Can't locate module
 char-major-10-134
Mar  6 00:56:54 blackbox modprobe: modprobe: Can't locate module
char-major-81-1
Mar  6 00:57:49 blackbox kernel: CS4232 soundcard not found or device busy
$




-------------------------
$  cat /proc/asound/sndstat
Sound Driver:3.8.1a-980706 (ALSA v0.9.0beta12 emulation code)
Kernel: Linux blackbox 2.4.18 #3 Tue Mar 5 22:14:43 CET 2002 i686
Config options: 0

Installed drivers:
Type 10: ALSA emulation

Card config:
--- no soundcards ---

Audio devices: NOT ENABLED IN CONFIG

Synth devices: NOT ENABLED IN CONFIG

Midi devices: NOT ENABLED IN CONFIG

Timers:
7: system timer

Mixers: NOT ENABLED IN CONFIG
$




---------------------
$  cat /dev/sam0_sndstat
driver:         sam9407-1.0.0
soundcard:      ews64xl
firmware:       ews64
have-audio:     yes
have-midi:      yes
have-mod:       yes
memory-total:   6144k
memory-free:    2315k
memory-sbank:   3691k
memory-mod:     0k
memory-audio:   0k
channels-play:  0/32
channels-rec:   0/1
$






-------------------------
$  cat /etc/modules.conf
alias char-major-145 sam9407
alias /dev/sam9407 sam9407
alias net-pf-4 off      # we won't use PF IPX
alias net-pf-5 off      # we won't use PF AppleTalk

# sam9407 is activated via /etc/rc.d/rc.modules
# modprobe sam9407

# Alsa portion
alias char-major-116 snd
options snd snd_major=116 snd_cards_limit=1

#
#     I M P O R T A N T  !!!!
#
#---sam9407 and alsa Version 0-5.x works fine with this options: !!!!!!!!! 
 (alsa 0.9.x does not)
#alias snd-card-0 snd-card-cs4232
#options snd-card-cs4232 snd_index=0 snd_id=card0 \
#        snd_port=0x534 snd_cport=0x538 snd_irq=5 snd_dma1=0 \
#        snd_dma2=1 snd_mpu_port=-1 snd_fm_port=0x388

#---alsa 0.9.x:  ("snd-card-cs4232" changed to "snd-cs4232")
alias snd-card-0 snd-cs4232
options snd-cs4232 snd_index=0 snd_id=card0 \
        snd_port=0x534 snd_cport=0x538  snd_irq=5 snd_dma1=0 \
        snd_dma2=1 snd_mpu_port=-1 snd_fm_port=0x388

# snd_isapnp=1 \
# snd_cport=0x538 snd_mpu_port=-1 snd_fm_port=0x388 \
# snd_irq=5 snd_dma1=0 snd_dma2=1 \
# snd_jport=-1


# OSS/Free portion
# alias char-major-14 soundcore
alias sound-slot-0 snd-card-0
alias sound-service-0-0 snd-mixer-oss
alias sound-service-0-1 snd-seq-oss
alias sound-service-0-3 snd-pcm-oss
alias sound-service-0-8 snd-seq-oss
alias sound-service-0-12 snd-pcm-oss

# post-install snd-mixer /usr/sbin/alsactl restore







-----------------------------
Small part of /etc/rc.d/rc.modules:

/sbin/sam9407 -s

# ALSA 0.5.x  (as said above 0.5.x works!)
#/sbin/modprobe snd-card-cs4232

# ALSA 0.9.x
/sbin/modprobe snd-cs4232

/sbin/modprobe snd-mixer-oss
/sbin/modprobe snd-pcm-oss
/sbin/modprobe snd-seq-oss
/usr/sbin/alsactl restore






-----------------------
$ cat /etc/isapnp.conf
# $Id: pnpdump.c,v 1.21 1999/12/09 22:28:33 fox Exp $
# Release isapnptools-1.21 (library isapnptools-1.21)
#
# This is free software, see the sources for details.
# This software has NO WARRANTY, use at your OWN RISK
#
# For details of the output file format, see isapnp.conf(5)
#
# For latest information and FAQ on isapnp and pnpdump see:
# http://www.roestock.demon.co.uk/isapnptools/
#
# Compiler flags:  -DREALTIME -DNEEDSETSCHEDULER -DABORT_ONRESERR
# (for   library:  -DREALTIME -DNEEDSETSCHEDULER -DABORT_ONRESERR)
#
# Trying port address 0273
# Board 1 has serial identifier 1d 97 b0 3c 58 36 a8 63 0e

# (DEBUG)
(READPORT 0x0273)
(ISOLATE PRESERVE)
(IDENTIFY *)
(VERBOSITY 2)
(CONFLICT (IO FATAL)(IRQ FATAL)(DMA FATAL)(MEM FATAL)) # or WARNING

# Card 1: (serial identifier 1d 97 b0 3c 58 36 a8 63 0e)
# Vendor Id CSCa836, Serial Number 2544909400, checksum 0x1D.
# Version 1.0, Vendor version 1.0
# ANSI string -->AudioSystem EWS64<--
#
# Logical device id CSCa800
#     Device supports vendor reserved register @ 0x38
#     Device supports vendor reserved register @ 0x3a
#     Device supports vendor reserved register @ 0x3d
#
# Edit the entries below to uncomment out the configuration required.
# Note that only the first value of any range is given, this may be changed
if
 required
# Don't forget to uncomment the activate (ACT Y) when happy

(CONFIGURE CSCa836/2544909400 (LD 0
#     ANSI string -->CoDec<--

# Multiple choice time, choose one only !

#     Start dependent functions: priority preferred
#       IRQ 5.
#             High true, edge sensitive interrupt (by default)
 (INT 0 (IRQ 5 (MODE +E)))
#       First DMA channel 1.
#             8 bit DMA only
#             Logical device is not a bus master
#             DMA may execute in count by byte mode
#             DMA may not execute in count by word mode
#             DMA channel speed type B
 (DMA 0 (CHANNEL 1))
#       Next DMA channel 0.
#             8 bit DMA only
#             Logical device is not a bus master
#             DMA may execute in count by byte mode
#             DMA may not execute in count by word mode
#             DMA channel speed type B
 (DMA 1 (CHANNEL 0))
#       Logical device decodes 16 bit IO address lines
#             Minimum IO base address 0x0534
#             Maximum IO base address 0x0534
#             IO base alignment 4 bytes
#             Number of IO addresses required: 4
 (IO 0 (SIZE 4) (BASE 0x0534))
#       Logical device decodes 16 bit IO address lines
#             Minimum IO base address 0x0388
#             Maximum IO base address 0x0388
#             IO base alignment 8 bytes
#             Number of IO addresses required: 4
 (IO 1 (SIZE 4) (BASE 0x0388))
#       Logical device decodes 16 bit IO address lines
#             Minimum IO base address 0x0220
#             Maximum IO base address 0x0220
#             IO base alignment 32 bytes
#             Number of IO addresses required: 16
 (IO 2 (SIZE 16) (BASE 0x0220))

#     End dependent functions
 (NAME "CSCa836/2544909400[0]{CoDec               }")
 (ACT Y)
))
#
# Logical device id CSCa801
#     Device supports vendor reserved register @ 0x3a
#     Device supports vendor reserved register @ 0x3b
#     Device supports vendor reserved register @ 0x3f
#
# Edit the entries below to uncomment out the configuration required.
# Note that only the first value of any range is given, this may be changed
if
 required
# Don't forget to uncomment the activate (ACT Y) when happy

(CONFIGURE CSCa836/2544909400 (LD 1
#     ANSI string -->Game Port<--

# Multiple choice time, choose one only !

#     Start dependent functions: priority preferred
#       Logical device decodes 16 bit IO address lines
#             Minimum IO base address 0x0201
#             Maximum IO base address 0x0201
#             IO base alignment 1 bytes
#             Number of IO addresses required: 1
 (IO 0 (SIZE 1) (BASE 0x0201))

#     End dependent functions
 (NAME "CSCa836/2544909400[1]{Game Port           }")
 (ACT Y)
))
#
# Logical device id CSCa810
#     Device supports vendor reserved register @ 0x38
#     Device supports vendor reserved register @ 0x3a
#     Device supports vendor reserved register @ 0x3b
#     Device supports vendor reserved register @ 0x3f
#
# Edit the entries below to uncomment out the configuration required.
# Note that only the first value of any range is given, this may be changed
if
 required
# Don't forget to uncomment the activate (ACT Y) when happy

(CONFIGURE CSCa836/2544909400 (LD 2
#     ANSI string -->CTRL<--

# Multiple choice time, choose one only !

#     Start dependent functions: priority preferred
#       Logical device decodes 16 bit IO address lines
#             Minimum IO base address 0x0538
#             Maximum IO base address 0x0538
#             IO base alignment 8 bytes
#             Number of IO addresses required: 8
 (IO 0 (SIZE 8) (BASE 0x0538))

#     End dependent functions
 (NAME "CSCa836/2544909400[2]{CTRL                }")
 (ACT Y)
))
#
# Logical device id CSCa8a3
#     Device supports vendor reserved register @ 0x38
#     Device supports vendor reserved register @ 0x3a
#     Device supports vendor reserved register @ 0x3b
#     Device supports vendor reserved register @ 0x3f
#
# Edit the entries below to uncomment out the configuration required.
# Note that only the first value of any range is given, this may be changed
if
 required
# Don't forget to uncomment the activate (ACT Y) when happy

(CONFIGURE CSCa836/2544909400 (LD 3
#     ANSI string -->Disabled [MIDI-2]<--
 (NAME "CSCa836/2544909400[3]{Disabled [MIDI-2]   }")
# (ACT Y)
))
#
# Logical device id CSC9407
#     Device supports vendor reserved register @ 0x3a
#     Device supports vendor reserved register @ 0x3b
#     Device supports vendor reserved register @ 0x3f
#
# Edit the entries below to uncomment out the configuration required.
# Note that only the first value of any range is given, this may be changed
if
 required
# Don't forget to uncomment the activate (ACT Y) when happy

(CONFIGURE CSCa836/2544909400 (LD 4
#     ANSI string -->Synth<--

# Multiple choice time, choose one only !

#     Start dependent functions: priority preferred
#       IRQ 9.
#             High true, edge sensitive interrupt (by default)
 (INT 0 (IRQ 9 (MODE +E)))
#       Logical device decodes 16 bit IO address lines
#             Minimum IO base address 0x0330
#             Maximum IO base address 0x0330
#             IO base alignment 8 bytes
#             Number of IO addresses required: 4
 (IO 0 (SIZE 4) (BASE 0x0330))

#     End dependent functions
 (NAME "CSCa836/2544909400[4]{Synth               }")
 (ACT Y)
))
#
# Logical device id CSCa805
#     Device supports vendor reserved register @ 0x39
#     Device supports vendor reserved register @ 0x3a
#     Device supports vendor reserved register @ 0x3b
#     Device supports vendor reserved register @ 0x3f
#
# Edit the entries below to uncomment out the configuration required.
# Note that only the first value of any range is given, this may be changed
if
 required
# Don't forget to uncomment the activate (ACT Y) when happy

(CONFIGURE CSCa836/2544909400 (LD 5
#     ANSI string -->Digital CTRL<--

# Multiple choice time, choose one only !

#     Start dependent functions: priority preferred
#       Logical device decodes 16 bit IO address lines
#             Minimum IO base address 0x0100
#             Maximum IO base address 0x03f8
#             IO base alignment 8 bytes
#             Number of IO addresses required: 1
 (IO 0 (SIZE 1) (BASE 0x0100))

#     End dependent functions
 (NAME "CSCa836/2544909400[5]{Digital CTRL        }")
 (ACT Y)
))
# End tag... Checksum 0x00 (OK)

# Returns all cards to the "Wait for Key" state
(WAITFORKEY)




-----------------------------------
 $ cat  /proc/devices
Character devices:
  1 mem
  2 pty
  3 ttyp
  4 vc/0
  5 ptmx
  6 lp
  7 vcs
 10 misc
 13 input
 14 sound
 21 sg
 81 video_capture
108 ppp
116 alsa
128 ptm
136 pts
145 sam9407
162 raw
180 usb
226 drm

Block devices:
  2 fd
  3 ide0
  7 loop
 11 sr
 22 ide1



------------------------
$ cat /proc/dma
 4: cascade



-------------------------------
$ cat /proc/interrupts
           CPU0
  0:     274324          XT-PIC  timer
  1:       9246          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  3:          2          XT-PIC  bttv, btaudio
  8:          1          XT-PIC  rtc
  9:       5319          XT-PIC  sam9407 (EWS64XL)
 10:          0          XT-PIC  usb-uhci, usb-uhci, eth0
 12:      83895          XT-PIC  PS/2 Mouse
 14:       8945          XT-PIC  ide0
 15:         16          XT-PIC  ide1
NMI:          0
LOC:          0
ERR:          0
MIS:          0

-> With alsa 0.5.x  cs4232 soundchip (also known as codec)  uses IRQ 5,
Sam9407
 uses allways IRQ 9.



-------------------------------
$ cat /proc/ioports
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0070-007f : rtc
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0100-0101 : sam9407 (EWS64XL Dig. Ctrl)
0170-0177 : ide1
01f0-01f7 : ide0
0213-0213 : isapnp read
0330-0333 : sam9407 (EWS64XL)
0376-0376 : ide1
0378-037a : parport0
03c0-03df : vga+
03f6-03f6 : ide0
0400-040f : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
0800-08ff : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
0a79-0a79 : isapnp write
0cf8-0cff : PCI conf1
a000-afff : PCI Bus #01
cc00-ccff : Realtek Semiconductor Co., Ltd. RTL-8139
  cc00-ccff : 8139too
d000-d01f : VIA Technologies, Inc. UHCI USB
  d000-d01f : usb-uhci
d400-d41f : VIA Technologies, Inc. UHCI USB (#2)
  d400-d41f : usb-uhci
d800-d803 : Advanced Micro Devices [AMD] AMD-751 [Irongate] System
Controller
dc00-dcff : 3Dfx Interactive, Inc. Voodoo 3
ffa0-ffaf : VIA Technologies, Inc. Bus Master IDE
  ffa0-ffa7 : ide0
  ffa8-ffaf : ide1




-----------------------------------
$ cat /proc/isapnp
Card 1 'CSCa836:AudioSystem EWS64' PnP version 1.0 Product version 1.0
  Logical device 0 'CSCa800:CoDec'
    Device is active
    Active port 0x534,0x388,0x220
    Active IRQ 5 [0x2]
    Active DMA 1,0
    Resources 0
      Priority preferred
      Port 0x534-0x534, align 0x3, size 0x4, 16-bit address decoding
      Port 0x388-0x388, align 0x7, size 0x4, 16-bit address decoding
      Port 0x220-0x220, align 0x1f, size 0x10, 16-bit address decoding
      IRQ 5 High-Edge
      DMA 1 8-bit master byte-count type-F
      DMA 0 8-bit master byte-count type-F
  Logical device 1 'CSCa801:Game Port'
    Device is active
    Active port 0x201
    Resources 0
      Priority preferred
      Port 0x201-0x201, align 0x0, size 0x1, 16-bit address decoding
  Logical device 2 'CSCa810:CTRL'
    Device is active
    Active port 0x538
    Resources 0
      Priority preferred
      Port 0x538-0x538, align 0x7, size 0x8, 16-bit address decoding
  Logical device 3 'CSCa8a3:Disabled [MIDI-2]'
    Device is not active
  Logical device 4 'CSC9407:Synth'
    Device is active
    Active port 0x330
    Active IRQ 9 [0x2]
    Resources 0
      Priority preferred
      Port 0x330-0x330, align 0x7, size 0x4, 16-bit address decoding
      IRQ 2/9 High-Edge
  Logical device 5 'CSCa805:Digital CTRL'
    Device is active
    Active port 0x100
    Resources 0
      Priority preferred
      Port 0x100-0x3f8, align 0x7, size 0x1, 16-bit address decoding

-> Remember, cs4232 is also called "CoDec" on the EWS64 XL soundcard.




-----------------------------------
$  cat /proc/modules
iptable_filter          1744   1 (autoclean)
snd-seq-oss            25280   0 (unused)
snd-seq-midi-event      2944   0 [snd-seq-oss]
snd-seq                44528   2 [snd-seq-oss snd-seq-midi-event]
snd-seq-device          4544   0 [snd-seq-oss snd-seq]
snd-pcm-oss            46816   0 (unused)
snd-pcm                62752   0 [snd-pcm-oss]
snd-timer              13040   0 [snd-seq snd-pcm]
snd-mixer-oss          11632   0 [snd-pcm-oss]
snd                    34800   0 [snd-seq-oss snd-seq-midi-event snd-seq
 snd-seq-device snd-pcm-oss snd-pcm snd-timer snd-mixer-oss]
sam9407               110720   0 (autoclean)
ppp_deflate            39952   0 (unused)
rtc                     5600   0 (autoclean)




-----------------------------------
$  cat /proc/pci
PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: Advanced Micro Devices [AMD] AMD-751 [Irongate] System
 Controller (rev 35).
      Master Capable.  Latency=64.
      Prefetchable 32 bit memory at 0xe4000000 [0xe7ffffff].
      Prefetchable 32 bit memory at 0xebdff000 [0xebdfffff].
      I/O at 0xd800 [0xd803].
  Bus  0, device   1, function  0:
    PCI bridge: Advanced Micro Devices [AMD] AMD-751 [Irongate] AGP Bridge
(rev
 1).
      Master Capable.  Latency=64.  Min Gnt=6.
  Bus  0, device   4, function  0:
    ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev
20).
  Bus  0, device   4, function  1:
    IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 6).
      Master Capable.  Latency=32.
      I/O at 0xffa0 [0xffaf].
  Bus  0, device   4, function  3:
    USB Controller: VIA Technologies, Inc. UHCI USB (#2) (rev 6).
      IRQ 10.
      Master Capable.  Latency=64.
      I/O at 0xd400 [0xd41f].
  Bus  0, device   4, function  2:
    USB Controller: VIA Technologies, Inc. UHCI USB (rev 6).
      IRQ 10.
      Master Capable.  Latency=64.
      I/O at 0xd000 [0xd01f].
  Bus  0, device   4, function  4:
    SMBus: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 16).
  Bus  0, device  13, function  0:
    VGA compatible controller: 3Dfx Interactive, Inc. Voodoo 3 (rev 1).
      IRQ 11.
      Non-prefetchable 32 bit memory at 0xee000000 [0xefffffff].
      Prefetchable 32 bit memory at 0xe8000000 [0xe9ffffff].
      I/O at 0xdc00 [0xdcff].
  Bus  0, device  15, function  0:
    Multimedia video controller: Brooktree Corporation Bt878 (rev 2).
      IRQ 3.
      Master Capable.  Latency=64.  Min Gnt=16.Max Lat=40.
      Prefetchable 32 bit memory at 0xebdfd000 [0xebdfdfff].
  Bus  0, device  15, function  1:
    Multimedia controller: Brooktree Corporation Bt878 (rev 2).
      IRQ 3.
      Master Capable.  Latency=64.  Min Gnt=4.Max Lat=255.
      Prefetchable 32 bit memory at 0xebdfe000 [0xebdfefff].
  Bus  0, device  16, function  0:
    Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 (rev 16).
      IRQ 10.
      Master Capable.  Latency=64.  Min Gnt=32.Max Lat=64.
      I/O at 0xcc00 [0xccff].
      Non-prefetchable 32 bit memory at 0xedfeff00 [0xedfeffff].




-----------------------------

End of listing.



Hope you can tell me what went wrong.


Best  Regards,
  Oliver C.


-- 
GMX - Die Kommunikationsplattform im Internet.
http://www.gmx.net


_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
