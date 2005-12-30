From: Dennis Bijwaard <dennis@bijwaard.demon.nl>
Subject: OOPS problem with azt2320
Date: Fri, 30 Dec 2005 14:16:26 +0100
Message-ID: <20051230131625.GA6480@bijwaard.demon.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bijwaard.demon.nl (bijwaard.demon.nl [82.161.128.207])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id C2FF8184
	for <alsa-devel@alsa-project.org>; Fri, 30 Dec 2005 14:16:27 +0100 (MET)
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
To: alsa-devel@alsa-project.org
Cc: perex@suse.cz
List-Id: alsa-devel@alsa-project.org

Dear alsa developers,

I get an oops with azt2320 in kernel 2.6.14.3 (used to work in earlier
slackware 2.6 test kernels), I one of you can find the problem.=20
Details follow below:

[1.] One line summary of the problem:

Oops with azt2320

[2.] Full description of the problem/report:

As soon as alsa is started at bootup with /etc/rc.d/rc.alsa from
slackware, the module gives an oops

[3.] Keywords (i.e., modules, networking, kernel):

kernel modules alsa azt2320

[4.] Kernel version (from /proc/version):

Linux version 2.6.14.3 (root@tree) (gcc version 3.4.4) #1 Sun Dec 4
18:22:27 CST 2005

[5.] Most recent kernel version which did not have the bug:

I think this was 2.6.12

[6.] Output of Oops.. message (if applicable) with symbolic information
     resolved (see Documentation/oops-tracing.txt)

dennis@bambi:~$ dmesg|ksymoops
ksymoops 2.4.11 on i686 2.6.14.3.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.6.14.3/ (default)
     -m /usr/src/linux/System.map (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Error (regular_file): read_ksyms stat /proc/ksyms failed
ksymoops: No such file or directory
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
 [<c0199dd3>] kobject_cleanup+0x83/0x90
 [<c0199de0>] kobject_release+0x0/0x10
 [<c019a6b3>] kref_put+0x33/0x70
 [<c0199e06>] kobject_put+0x16/0x20
 [<c0199de0>] kobject_release+0x0/0x10
 [<c884930e>] init_i82365+0x17e/0x195 [i82365]
 [<c0130882>] sys_init_module+0x102/0x190
 [<c0102e59>] syscall_call+0x7/0xb
Unable to handle kernel NULL pointer dereference at virtual address
00000000
00000000
*pde =3D 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<00000000>]    Not tainted VLI
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010286   (2.6.14.3)
eax: c70d2e00   ebx: 00000000   ecx: c890ac34   edx: c890ac34
esi: c890ac34   edi: c70d2e08   ebp: c70d2e08   esp: c6e21e00
ds: 007b   es: 007b   ss: 0068
Stack: c8900011 c70d2e00 c01ff20a c70d2e08 00000000 c6e21e34 c01ff280
c01ff28f
       c890ac34 c70d2e08 c01fea08 c890ac34 c70d2e08 c034ce58 c034ce58
c890ac8c
       c6a59cc8 c70d2e08 c034cd60 c70d2e08 00000000 c01ff2f4 c034cd60
00000000
Call Trace:
 [<c8900011>] snd_platform_driver_probe+0x11/0x20 [snd]
 [<c01ff20a>] driver_probe_device+0x2a/0xa0
 [<c01ff280>] __device_attach+0x0/0x20
 [<c01ff28f>] __device_attach+0xf/0x20
 [<c01fea08>] bus_for_each_drv+0x58/0x80
 [<c01ff2f4>] device_attach+0x54/0x60
 [<c01ff280>] __device_attach+0x0/0x20
 [<c01feb43>] bus_add_device+0x23/0x90
 [<c01fdaee>] device_add+0xae/0x130
 [<c01fdb81>] device_register+0x11/0x20
 [<c02009e9>] platform_device_register+0x129/0x190
 [<c8914aa0>] snd_cs4231_pm_resume+0x0/0x30 [snd_cs4231_lib]
 [<c8914a70>] snd_cs4231_pm_suspend+0x0/0x30 [snd_cs4231_lib]
 [<c8901488>] snd_generic_device_register+0x58/0xa0 [snd]
 [<c8914aa0>] snd_cs4231_pm_resume+0x0/0x30 [snd_cs4231_lib]
 [<c890173a>] snd_card_set_generic_pm_callback+0x1a/0x50 [snd]
 [<c8914f49>] snd_cs4231_create+0x1b9/0x320 [snd_cs4231_lib]
 [<c8914a70>] snd_cs4231_pm_suspend+0x0/0x30 [snd_cs4231_lib]
 [<c8914aa0>] snd_cs4231_pm_resume+0x0/0x30 [snd_cs4231_lib]
 [<c88a0451>] snd_card_azt2320_probe+0xc1/0x260 [snd_azt2320]
 [<c88a0630>] snd_azt2320_pnp_detect+0x40/0x50 [snd_azt2320]
 [<c01d5364>] card_probe+0x44/0xa0
 [<c01d59bc>] pnp_register_card_driver+0x6c/0x90
 [<c880200a>] alsa_card_azt2320_init+0xa/0x49 [snd_azt2320]
 [<c0130882>] sys_init_module+0x102/0x190
 [<c0102e59>] syscall_call+0x7/0xb
Code:  Bad EIP value.


>>EIP; 00000000 Before first symbol

Trace; c8900011 <END_OF_CODE+85358ed/????>
Trace; c01ff20a <piix_tune_chipset+33a/340>
Trace; c01ff280 <piix_config_drive_for_dma+20/90>
Trace; c01ff28f <piix_config_drive_for_dma+2f/90>
Trace; c01fea08 <piix_get_info+488/630>
Trace; c01ff2f4 <piix_config_drive_xfer_rate+4/120>
Trace; c01ff280 <piix_config_drive_for_dma+20/90>
Trace; c01feb43 <piix_get_info+5c3/630>
Trace; c01fdaee <pdcnew_tune_chipset+31e/390>
Trace; c01fdb81 <pdcnew_new_tune_chipset+21/4d0>
Trace; c02009e9 <config_chipset_for_pio+149/180>
Trace; c8914aa0 <END_OF_CODE+854a37c/????>
Trace; c8914a70 <END_OF_CODE+854a34c/????>
Trace; c8901488 <END_OF_CODE+8536d64/????>
Trace; c8914aa0 <END_OF_CODE+854a37c/????>
Trace; c890173a <END_OF_CODE+8537016/????>
Trace; c8914f49 <END_OF_CODE+854a825/????>
Trace; c8914a70 <END_OF_CODE+854a34c/????>
Trace; c8914aa0 <END_OF_CODE+854a37c/????>
Trace; c88a0451 <END_OF_CODE+84d5d2d/????>
Trace; c88a0630 <END_OF_CODE+84d5f0c/????>
Trace; c01d5364 <vt_ioctl+fd4/1130>
Trace; c01d59bc <do_kdsk_ioctl+13c/2b0>
Trace; c880200a <END_OF_CODE+84378e6/????>
Trace; c0130882 <shrink_cache+342/3d0>
Trace; c0102e59 <pg0+e59/1000>


1 warning and 1 error issued.  Results may not be reliable.

[7.] A small shell script or example program which triggers the
     problem (if possible)
[8.] Environment
[8.1.] Software (add the output of the ver_linux script here)

If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux bambi 2.6.14.3 #1 Sun Dec 4 18:22:27 CST 2005 i686 unknown unknown
GNU/Linux

Gnu C                  3.3.6
Gnu make               3.80
binutils               2.15.92.0.2
util-linux             2.12p
mount                  2.12p
module-init-tools      3.1
e2fsprogs              1.38
jfsutils               1.1.8
reiserfsprogs          3.6.19
reiser4progs           line
xfsprogs               2.6.13
pcmcia-cs              3.2.8
quota-tools            3.12.
PPP                    2.4.4b1
nfs-utils              1.0.7
Linux C Library        2.3.5
Dynamic linker (ldd)   2.3.5
Linux C++ Library      5.0.7
Procps                 3.2.5
Net-tools              1.60
Kbd                    1.12
Sh-utils               5.2.1
udev                   064
Modules Loaded         nfs lockd sunrpc snd_seq snd_pcm_oss
snd_mixer_oss ohci_hcd ehci_hcd ns558 gameport snd_azt2320 snd_opl3_lib
snd_hwdep snd_cs4231_lib snd_pcm snd_timer snd_page_alloc
snd_mpu401_uart snd_rawmidi snd_seq_device snd soundcore intel_agp
uhci_hcd i2c_piix4 i2c_core pcmcia firmware_class yenta_socket
rsrc_nonstatic pcmcia_core ext3 jbd pcnet32 mii agpgart psmouse

[8.2.] Processor information (from /proc/cpuinfo):

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 5
model name      : Pentium II (Deschutes)
stepping        : 2
cpu MHz         : 348.554
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca
cmov pat pse36 mmx fxsr
bogomips        : 697.75

[8.3.] Module information (from /proc/modules):

nfs 192968 1 - Live 0xc89f3000
lockd 56968 2 nfs, Live 0xc8952000
sunrpc 122556 3 nfs,lockd, Live 0xc899c000
snd_seq 45200 0 - Live 0xc896e000
snd_pcm_oss 47520 0 - Live 0xc8961000
snd_mixer_oss 15744 1 snd_pcm_oss, Live 0xc894d000
ohci_hcd 18564 0 - Live 0xc8947000
ehci_hcd 30088 0 - Live 0xc893e000
ns558 4612 0 - Live 0xc891d000
gameport 10888 2 ns558, Live 0xc88fc000
snd_azt2320 9069 1 - Loading 0xc88a0000
snd_opl3_lib 8832 1 snd_azt2320, Live 0xc88f8000
snd_hwdep 6816 1 snd_opl3_lib, Live 0xc88f5000
snd_cs4231_lib 20864 1 snd_azt2320, Live 0xc8913000
snd_pcm 75272 2 snd_pcm_oss,snd_cs4231_lib, Live 0xc892a000
snd_timer 19844 4 snd_seq,snd_opl3_lib,snd_cs4231_lib,snd_pcm, Live
0xc890d000
snd_page_alloc 8200 2 snd_cs4231_lib,snd_pcm, Live 0xc88f1000
snd_mpu401_uart 5888 1 snd_azt2320, Live 0xc88b2000
snd_rawmidi 19232 1 snd_mpu401_uart, Live 0xc88da000
snd_seq_device 6796 3 snd_seq,snd_opl3_lib,snd_rawmidi, Live 0xc88a7000
snd 45668 12
snd_seq,snd_pcm_oss,snd_mixer_oss,snd_azt2320,snd_opl3_lib,snd_hwdep,snd_=
cs4231_lib,snd_pcm,snd_timer,snd_mpu401_uart,snd_rawmidi,snd_seq_device,
Live 0xc8900000
soundcore 7136 1 snd, Live 0xc88a4000
intel_agp 19484 1 - Live 0xc88d4000
uhci_hcd 28560 0 - Live 0xc88aa000
i2c_piix4 7568 0 - Live 0xc889d000
i2c_core 16912 1 i2c_piix4, Live 0xc884e000
pcmcia 30628 0 - Live 0xc8876000
firmware_class 7424 1 pcmcia, Live 0xc8848000
yenta_socket 23436 0 - Live 0xc887f000
rsrc_nonstatic 11008 1 yenta_socket, Live 0xc8866000
pcmcia_core 34064 3 pcmcia,yenta_socket,rsrc_nonstatic, Live 0xc8893000
ext3 118280 5 - Live 0xc88b6000
jbd 46484 1 ext3, Live 0xc8886000
pcnet32 23812 0 - Live 0xc886f000
mii 4608 1 pcnet32, Live 0xc884b000
agpgart 28488 1 intel_agp, Live 0xc885e000
psmouse 33284 0 - Live 0xc8854000

[8.4.] Loaded driver and hardware information (/proc/ioports,
/proc/iomem)

0000-001f : dma1
0020-0021 : pic1
0040-0043 : timer0
0050-0053 : timer1
0060-006f : keyboard
0070-0077 : rtc
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
0200-0207 : ns558-pnp
0213-0213 : ISAPnP
02f8-02ff : serial
0376-0376 : ide1
03c0-03df : vga+
03e0-03e1 : =E9e=FE=FF=FFt&
03f6-03f6 : ide0
03f8-03ff : serial
0534-0537 : CS4231
0a79-0a79 : isapnp write
0cf8-0cff : PCI conf1
8000-803f : 0000:00:07.3
  8000-803f : motherboard
    8000-8003 : PM1a_EVT_BLK
    8008-800b : PM_TMR
    800c-800f : GPE0_BLK
8408-8409 : PM1a_CNT_BLK
8800-881f : 0000:00:07.3
  8800-880f : motherboard
    8800-8807 : piix4-smbus
fca0-fcbf : 0000:00:12.0
  fca0-fcbf : pcnet32_probe_pci
fcd0-fcdf : 0000:00:07.1
  fcd0-fcd7 : ide0
  fcd8-fcdf : ide1
fce0-fcff : 0000:00:07.2
  fce0-fcff : uhci_hcd
root@bambi:~# cat /proc/iomem
00000000-0009f7ff : System RAM
0009f800-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000c8000-000d7fff : Adapter ROM
000f0000-000fffff : System ROM
00100000-07feffff : System RAM
  00100000-002ee985 : Kernel code
  002ee986-003876e3 : Kernel data
07ff0000-07fffbff : ACPI Tables
07fffc00-07ffffff : ACPI Non-volatile Storage
10000000-100fffff : 0000:00:12.0
f6000000-f6ffffff : PCI Bus #01
  f6000000-f6ffffff : 0000:01:00.0
f8000000-fbffffff : 0000:00:00.0
fe000000-fecfffff : PCI Bus #01
  fe000000-fe7fffff : 0000:01:00.0
  fe800000-fe80ffff : 0000:01:00.0
  fecf8000-fecfbfff : 0000:01:00.0
fedff800-fedff81f : 0000:00:12.0
ffff0800-ffffffff : reserved

[8.5.] PCI information ('lspci -vvv' as root)

00:00.0 Host bridge: Intel Corporation 440BX/ZX/DX - 82443BX/ZX/DX Host
bridge (rev 03)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort=
-
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 64
        Region 0: Memory at f8000000 (32-bit, prefetchable) [size=3D64M]
        Capabilities: [a0] AGP version 1.0
                Status: RQ=3D32 Iso- ArqSz=3D0 Cal=3D0 SBA+ ITACoh- GART6=
4-
HTrans- 64bit- FW- AGP3- Rate=3Dx1,x2
                Command: RQ=3D1 ArqSz=3D0 Cal=3D0 SBA- AGP- GART64- 64bit=
- FW-
Rate=3D<none>

00:01.0 PCI bridge: Intel Corporation 440BX/ZX/DX - 82443BX/ZX/DX AGP
bridge (rev 03) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV+ VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort=
-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 128
        Bus: primary=3D00, secondary=3D01, subordinate=3D01, sec-latency=3D=
64
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: fe000000-fecfffff
        Prefetchable memory behind bridge: f6000000-f6ffffff
        BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B+

00:07.0 ISA bridge: Intel Corporation 82371AB/EB/MB PIIX4 ISA (rev 02)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort=
-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:07.1 IDE interface: Intel Corporation 82371AB/EB/MB PIIX4 IDE (rev
01) (prog-if 80 [Master])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort=
-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Region 4: I/O ports at fcd0 [size=3D16]

00:07.2 USB Controller: Intel Corporation 82371AB/EB/MB PIIX4 USB (rev
01) (prog-if 00 [UHCI])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort=
-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Interrupt: pin D routed to IRQ 11
        Region 4: I/O ports at fce0 [size=3D32]

00:07.3 Bridge: Intel Corporation 82371AB/EB/MB PIIX4 ACPI (rev 02)
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort=
-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin ? routed to IRQ 9

00:12.0 Ethernet controller: Advanced Micro Devices [AMD] 79c970
[PCnet32 LANCE] (rev 25)
        Subsystem: Hewlett-Packard Company Ethernet with LAN remote
power Adapter
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort=
-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (1500ns min, 63750ns max)
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at fca0 [size=3D32]
        Region 1: Memory at fedff800 (32-bit, non-prefetchable)
[size=3D32]
        Expansion ROM at 10000000 [disabled] [size=3D1M]

01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G200 AGP
(rev 01) (prog-if 00 [VGA])
        Subsystem: Matrox Graphics, Inc. Millennium G200 AGP
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort=
-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 128 (4000ns min, 8000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 9
        Region 0: Memory at f6000000 (32-bit, prefetchable) [size=3D16M]
        Region 1: Memory at fecf8000 (32-bit, non-prefetchable)
[size=3D16K]
        Region 2: Memory at fe000000 (32-bit, non-prefetchable)
[size=3D8M]
        Expansion ROM at fe800000 [disabled] [size=3D64K]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=3D0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
        Capabilities: [f0] AGP version 1.0
                Status: RQ=3D32 Iso- ArqSz=3D0 Cal=3D0 SBA+ ITACoh- GART6=
4-
HTrans- 64bit- FW- AGP3- Rate=3Dx1,x2
                Command: RQ=3D1 ArqSz=3D0 Cal=3D0 SBA- AGP- GART64- 64bit=
- FW-
Rate=3D<none>

[8.6.] SCSI information (from /proc/scsi/scsi)

Attached devices:

[8.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):

cat /proc/asound/* /proc/asound/*/*
--- no soundcards ---
 1:       : sequencer
 33:       : timer
G0: system timer : 4000.000us (10000000 ticks)
Advanced Linux Sound Architecture Driver Version 1.0.10.
Compiled on Dec  4 2005 for kernel 2.6.14.3.

Sound Driver:3.8.1a-980706 (ALSA v1.0.10 emulation code)
Kernel: Linux bambi 2.6.14.3 #1 Sun Dec 4 18:22:27 CST 2005 i686
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
Client info
  cur  clients : 1
  peak clients : 1
  max  clients : 192

Client   0 : "System" [Kernel]
  Port   0 : "Timer" (Rwe-)
  Port   1 : "Announce" (R-e-)
Client  62 : "Midi Through" [Kernel]
  Port   0 : "Midi Through Port-0" (RWe-)

[X.] Other notes, patches, fixes, workarounds:

--=20
Groetjes,
         Dennis


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
