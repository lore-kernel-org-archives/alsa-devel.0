From: "Jorge Peixoto de Morais Neto" <please.no.spam.here@gmail.com>
Subject: Mute sound
Date: Mon, 16 Jun 2008 18:35:22 -0300
Message-ID: <38af3d670806161435v1c36903an1e8da7d713f6207e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.180])
	by alsa0.perex.cz (Postfix) with ESMTP id 9A7C524458
	for <alsa-devel@alsa-project.org>;
	Mon, 16 Jun 2008 23:35:29 +0200 (CEST)
Received: by wa-out-1112.google.com with SMTP id m28so3832533wag.8
	for <alsa-devel@alsa-project.org>; Mon, 16 Jun 2008 14:35:28 -0700 (PDT)
Content-Disposition: inline
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

Hi. Under kernel 2.6.23, I could get sound from the alsa device
created by the module snd_bt87x.
In kernel 2.6.24, there is no sound.
Also, in kernel 2.6.23 the device would only appear if I modprobed the
module with the option load_all=1.
In kernel 2.6.24, the option load_all=1 is unnecessary for the device
to appear. This is probably because I have in 2007 sent an email to
this list with information about my board (it was responded by
Takashi).

If you need any addition other than what I provide below, ask at any time.

jorge@jorge ~ $ uname -a
Linux jorge 2.6.24-gentoo-r8d #4 Mon Jun 16 17:58:17 BRT 2008 i686 AMD
Athlon(tm) XP 2600+ AuthenticAMD GNU/Linux

jorge@jorge ~ $ sudo lspci -v
00:00.0 Host bridge: VIA Technologies, Inc. VT8377 [KT400/KT600 AGP] Host Bridge
        Subsystem: VIA Technologies, Inc. Unknown device 0000
        Flags: bus master, 66MHz, medium devsel, latency 8
        Memory at e0000000 (32-bit, prefetchable) [size=128M]
        Capabilities: [a0] AGP version 2.0
        Capabilities: [c0] Power Management version 2

00:01.0 PCI bridge: VIA Technologies, Inc. VT8235 PCI Bridge (prog-if
00 [Normal decode])
        Flags: bus master, 66MHz, medium devsel, latency 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        Memory behind bridge: dde00000-dfefffff
        Prefetchable memory behind bridge: cdc00000-ddcfffff
        Capabilities: [80] Power Management version 2

00:07.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL-8139/8139C/8139C+ (rev 10)
        Subsystem: Realtek Semiconductor Co., Ltd. RT8139
        Flags: bus master, medium devsel, latency 32, IRQ 10
        I/O ports at ec00 [size=256]
        Memory at dfffff00 (32-bit, non-prefetchable) [size=256]
        Capabilities: [50] Power Management version 2
        Kernel driver in use: 8139too

00:0b.0 Multimedia video controller: Brooktree Corporation Bt878 Video
Capture (rev 11)
        Subsystem: PROLINK Microsystems Corp Unknown device 4011
        Flags: bus master, medium devsel, latency 32, IRQ 5
        Memory at dddfe000 (32-bit, prefetchable) [size=4K]
        Capabilities: [44] Vital Product Data <?>
        Capabilities: [4c] Power Management version 2
        Kernel driver in use: bttv
        Kernel modules: bttv

00:0b.1 Multimedia controller: Brooktree Corporation Bt878 Audio
Capture (rev 11)
        Subsystem: PROLINK Microsystems Corp Unknown device 4011
        Flags: bus master, medium devsel, latency 32, IRQ 5
        Memory at dddff000 (32-bit, prefetchable) [size=4K]
        Capabilities: [44] Vital Product Data <?>
        Capabilities: [4c] Power Management version 2
        Kernel driver in use: Bt87x
        Kernel modules: snd-bt87x

00:0c.0 Multimedia audio controller: C-Media Electronics Inc CM8738 (rev 10)
        Subsystem: Micro-Star International Co., Ltd. Unknown device 5900
        Flags: bus master, medium devsel, latency 32, IRQ 11
        I/O ports at e800 [size=256]
        Capabilities: [c0] Power Management version 2
        Kernel driver in use: C-Media PCI
        Kernel modules: snd-cmipci

00:10.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
Controller (rev 80) (prog-if 00 [UHCI])
        Subsystem: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller
        Flags: bus master, medium devsel, latency 32, IRQ 11
        I/O ports at dc00 [size=32]
        Capabilities: [80] Power Management version 2
        Kernel driver in use: uhci_hcd

00:10.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
Controller (rev 80) (prog-if 00 [UHCI])
        Subsystem: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller
        Flags: bus master, medium devsel, latency 32, IRQ 11
        I/O ports at e000 [size=32]
        Capabilities: [80] Power Management version 2
        Kernel driver in use: uhci_hcd

00:10.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
Controller (rev 80) (prog-if 00 [UHCI])
        Subsystem: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller
        Flags: bus master, medium devsel, latency 32, IRQ 5
        I/O ports at e400 [size=32]
        Capabilities: [80] Power Management version 2
        Kernel driver in use: uhci_hcd

00:10.3 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 82)
(prog-if 20 [EHCI])
        Subsystem: VIA Technologies, Inc. USB 2.0
        Flags: bus master, medium devsel, latency 32, IRQ 10
        Memory at dffffe00 (32-bit, non-prefetchable) [size=256]
        Capabilities: [80] Power Management version 2
        Kernel driver in use: ehci_hcd

00:11.0 ISA bridge: VIA Technologies, Inc. VT8235 ISA Bridge
        Subsystem: VIA Technologies, Inc. Unknown device 0000
        Flags: bus master, stepping, medium devsel, latency 0
        Capabilities: [c0] Power Management version 2

00:11.1 IDE interface: VIA Technologies, Inc.
VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06)
(prog-if 8a [Master SecP PriP])
        Subsystem: VIA Technologies, Inc.
VT82C586/B/VT82C686/A/B/VT8233/A/C/VT8235 PIPC Bus Master IDE
        Flags: bus master, medium devsel, latency 32, IRQ 255
        [virtual] Memory at 000001f0 (32-bit, non-prefetchable) [size=8]
        [virtual] Memory at 000003f0 (type 3, non-prefetchable) [size=1]
        [virtual] Memory at 00000170 (32-bit, non-prefetchable) [size=8]
        [virtual] Memory at 00000370 (type 3, non-prefetchable) [size=1]
        I/O ports at fc00 [size=16]
        Capabilities: [c0] Power Management version 2

01:00.0 VGA compatible controller: nVidia Corporation NV17 [GeForce4
MX 440] (rev a3) (prog-if 00 [VGA controller])
        Flags: bus master, 66MHz, medium devsel, latency 32, IRQ 11
        Memory at de000000 (32-bit, non-prefetchable) [size=16M]
        Memory at d0000000 (32-bit, prefetchable) [size=128M]
        Memory at ddc80000 (32-bit, prefetchable) [size=512K]
        Expansion ROM at dfee0000 [disabled] [size=128K]
        Capabilities: [60] Power Management version 2
        Capabilities: [44] AGP version 2.0

jorge@jorge ~ $ cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 8
model name      : AMD Athlon(tm) XP 2600+
stepping        : 1
cpu MHz         : 2133.528
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow ts
bogomips        : 4271.41
clflush size    : 32

jorge@jorge /proc/asound $ ls
Bt878  card0  card1  cards  CMI8738  devices  hwdep  oss  pcm  timers  version
jorge@jorge /proc/asound $ cat cards
 0 [CMI8738        ]: CMI8738-MC6 - C-Media CMI8738
                      C-Media CMI8738 (model 55) at 0xe800, irq 11
 1 [Bt878          ]: Bt87x - Brooktree Bt878
                      Brooktree Bt878 at 0xdddff000, irq 5
jorge@jorge /proc/asound $ cat devices
  0: [ 0]   : control
  4: [ 0- 0]: hardware dependent
  8: [ 0- 0]: raw midi
 16: [ 0- 0]: digital audio playback
 17: [ 0- 1]: digital audio playback
 18: [ 0- 2]: digital audio playback
 24: [ 0- 0]: digital audio capture
 26: [ 0- 2]: digital audio capture
 32: [ 1]   : control
 33:        : timer
 56: [ 1- 0]: digital audio capture
 57: [ 1- 1]: digital audio capture
jorge@jorge /proc/asound $ cat hwdep
00-00: OPL3 FM
jorge@jorge /proc/asound $ cat pcm
00-02: CMI8738-MC6 : C-Media PCI IEC958 : playback 1 : capture 1
00-01: CMI8738-MC6 : C-Media PCI 2nd DAC : playback 1
00-00: CMI8738-MC6 : C-Media PCI DAC/ADC : playback 1 : capture 1
01-01: Bt87x Analog : Bt87x Analog : capture 1
01-00: Bt87x Digital : Bt87x Digital : capture 1
jorge@jorge /proc/asound $ cat version
Advanced Linux Sound Architecture Driver Version 1.0.15 (Tue Nov 20
19:16:42 2007 UTC).

-- 
Software is like sex: it is better when it is free - Linus Torvalds
