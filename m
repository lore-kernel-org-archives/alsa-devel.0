From: Alex Fedora <alexander.fedora@gmail.com>
Subject: PROBLEM: [Lenovo ThinkPad X61s] Speaker volume mutes
 itself in random intervals after upgrading from 3.11 to 3.15.
Date: Sat, 31 May 2014 23:54:26 -0700
Message-ID: <538ACE22.9020306@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f46.google.com (mail-pa0-f46.google.com
 [209.85.220.46])
 by alsa0.perex.cz (Postfix) with ESMTP id 3381F2615B9
 for <alsa-devel@alsa-project.org>; Sun,  1 Jun 2014 08:54:36 +0200 (CEST)
Received: by mail-pa0-f46.google.com with SMTP id hz1so846297pad.5
 for <alsa-devel@alsa-project.org>; Sat, 31 May 2014 23:54:35 -0700 (PDT)
Received: from [192.168.1.4] (c-24-17-206-20.hsd1.wa.comcast.net.
 [24.17.206.20])
 by mx.google.com with ESMTPSA id oa3sm14271943pbb.15.2014.05.31.23.54.33
 for <alsa-devel@alsa-project.org>
 (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
 Sat, 31 May 2014 23:54:34 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

Please see problem description below. I've captured alsa info output for 
the latest kernel. Kernel just before the regression. And info from the 
kernel with the offending commit. But I had to calculate diff from first 
one to fit to 100K limit. If you want, I can send all 3 files as an 
attachments. Also the latest version of the kernel was took from 
http://kernel.ubuntu.com/~kernel-ppa/mainline/daily/current/linux-image-3.15.0-999-generic_3.15.0-999.201405310205_amd64.deb 
.

Thank you,
Alex

[1.] One line summary of the problem: [Lenovo ThinkPad X61s] Speaker 
volume mutes itself in random intervals after upgrade to latest kernel
[2.] Full description of the problem/report:

Speaker mutes itself in random intervals. Headphones are working fine at 
that moment. I can see what volume of the Speaker drops to 0% and then 
back to 100% using alsamixer. It seems like Internal Mic Boost also 
jumps from 100% to 0% and back. It is regression from 
5ccc618fee67f0f0b2122dd4b32a02fd2b6a1569 (ALSA: hda - Remove static 
quirks for AD1884/1984 & variants). I've tested previous commit 
aa95d61b43e0fcb0b2ce68e5efa37174fd9e5cd3 (ALSA: hda - Remove static 
quirks for AD1882) and audio works as expected.

New kernel shows two controls "Headphone Playback Volume" and "Speaker 
Playback Volume". But old one shows single control "PCM Playback 
Volume". "Speaker Playback Volume" is the one which gets muted randomly.

[3.] Keywords (i.e., modules, networking, kernel):
[4.] Kernel version (from /proc/version):
Linux version 3.15.0-999-generic (apw@gomeisa) (gcc version 4.6.3 
(Ubuntu/Linaro 4.6.3-1ubuntu5) ) #201405310205 SMP Sat May 31 06:06:08 
UTC 2014
[5.] Output of Oops.. message (if applicable) with symbolic information
      resolved (see Documentation/oops-tracing.txt)
[6.] A small shell script or example program which triggers the
      problem (if possible)

Tested manually.

[7.] Environment
Description:    Ubuntu 14.04 LTS
Release:        14.04
[7.1.] Software (add the output of the ver_linux script here)

If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux x61s 3.15.0-999-generic #201405310205 SMP Sat May 31 06:06:08 UTC 
2014 x86_64 x86_64 x86_64 GNU/Linux

Gnu C                  4.8
Gnu make               3.81
binutils               2.24
util-linux             2.20.1
mount                  support
module-init-tools      15
e2fsprogs              1.42.9
pcmciautils            018
Linux C Library        2.19
Dynamic linker (ldd)   2.19
Procps                 3.3.9
Net-tools              1.60
Kbd                    1.15.5
Sh-utils               8.21
wireless-tools         30
Modules Loaded         ctr ccm nls_iso8859_1 ipt_MASQUERADE iptable_nat 
nf_nat_ipv4 nf_nat nf_conntrack_ipv4 nf_defrag_ipv4 xt_conntrack 
nf_conntrack ipt_REJECT xt_CHECKSUM iptable_mangle xt_tcpudp bridge stp 
llc ip6table_filter ip6_tables iptable_filter ip_tables ebtable_nat 
ebtables x_tables rfcomm bnep bluetooth 6lowpan_iphc binfmt_misc 
snd_hda_codec_analog snd_hda_codec_generic snd_hda_intel 
snd_hda_controller snd_hda_codec snd_hwdep thinkpad_acpi dm_multipath 
coretemp snd_pcm nvram kvm_intel scsi_dh snd_seq_midi arc4 kvm 
snd_seq_midi_event iwl4965 iwlegacy mac80211 snd_rawmidi snd_seq 
cfg80211 snd_seq_device pcmcia snd_timer microcode snd serio_raw 
yenta_socket soundcore mac_hid pcmcia_rsrc ppdev lpc_ich pcmcia_core 
parport_pc lp parport xts gf128mul dm_crypt mmc_block ahci sdhci_pci 
psmouse libahci sdhci i915 video i2c_algo_bit e1000e drm_kms_helper drm 
ptp pps_core


[7.2.] Processor information (from /proc/cpuinfo):

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 15
model name      : Intel(R) Core(TM)2 Duo CPU     L7500  @ 1.60GHz
stepping        : 11
microcode       : 0xba
cpu MHz         : 800.000
cache size      : 4096 KB
physical id     : 0
siblings        : 2
core id         : 0
cpu cores       : 2
apicid          : 0
initial apicid  : 0
fpu             : yes
fpu_exception   : yes
cpuid level     : 10
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge 
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe 
syscall nx lm constant_tsc arch_perfmon pebs bts rep_good nopl 
aperfmperf pni dtes64 monitor ds_cpl vmx est tm2 ssse3 cx16 xtpr pdcm 
lahf_lm ida dtherm tpr_shadow vnmi flexpriority
bogomips        : 3191.89
clflush size    : 64
cache_alignment : 64
address sizes   : 36 bits physical, 48 bits virtual
power management:

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 6
model           : 15
model name      : Intel(R) Core(TM)2 Duo CPU     L7500  @ 1.60GHz
stepping        : 11
microcode       : 0xba
cpu MHz         : 800.000
cache size      : 4096 KB
physical id     : 0
siblings        : 2
core id         : 1
cpu cores       : 2
apicid          : 1
initial apicid  : 1
fpu             : yes
fpu_exception   : yes
cpuid level     : 10
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge 
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe 
syscall nx lm constant_tsc arch_perfmon pebs bts rep_good nopl 
aperfmperf pni dtes64 monitor ds_cpl vmx est tm2 ssse3 cx16 xtpr pdcm 
lahf_lm ida dtherm tpr_shadow vnmi flexpriority
bogomips        : 3191.89
clflush size    : 64
cache_alignment : 64
address sizes   : 36 bits physical, 48 bits virtual
power management:


[7.3.] Module information (from /proc/modules):

ctr 13193 2 - Live 0x0000000000000000
ccm 17856 2 - Live 0x0000000000000000
nls_iso8859_1 12713 1 - Live 0x0000000000000000
ipt_MASQUERADE 12880 3 - Live 0x0000000000000000
iptable_nat 13151 1 - Live 0x0000000000000000
nf_nat_ipv4 13316 1 iptable_nat, Live 0x0000000000000000
nf_nat 26147 3 ipt_MASQUERADE,iptable_nat,nf_nat_ipv4, Live 
0x0000000000000000
nf_conntrack_ipv4 14857 2 - Live 0x0000000000000000
nf_defrag_ipv4 12758 1 nf_conntrack_ipv4, Live 0x0000000000000000
xt_conntrack 12760 1 - Live 0x0000000000000000
nf_conntrack 105687 6 
ipt_MASQUERADE,iptable_nat,nf_nat_ipv4,nf_nat,nf_conntrack_ipv4,xt_conntrack, 
Live 0x0000000000000000
ipt_REJECT 12579 2 - Live 0x0000000000000000
xt_CHECKSUM 12549 1 - Live 0x0000000000000000
iptable_mangle 12734 1 - Live 0x0000000000000000
xt_tcpudp 12924 6 - Live 0x0000000000000000
bridge 116335 0 - Live 0x0000000000000000
stp 12976 1 bridge, Live 0x0000000000000000
llc 14441 2 bridge,stp, Live 0x0000000000000000
ip6table_filter 12815 0 - Live 0x0000000000000000
ip6_tables 27504 1 ip6table_filter, Live 0x0000000000000000
iptable_filter 12810 1 - Live 0x0000000000000000
ip_tables 27718 3 iptable_nat,iptable_mangle,iptable_filter, Live 
0x0000000000000000
ebtable_nat 12807 0 - Live 0x0000000000000000
ebtables 35305 1 ebtable_nat, Live 0x0000000000000000
x_tables 34194 11 
ipt_MASQUERADE,xt_conntrack,ipt_REJECT,xt_CHECKSUM,iptable_mangle,xt_tcpudp,ip6table_filter,ip6_tables,iptable_filter,ip_tables,ebtables, 
Live 0x0000000000000000
rfcomm 75078 0 - Live 0x0000000000000000
bnep 19884 2 - Live 0x0000000000000000
bluetooth 461775 10 rfcomm,bnep, Live 0x0000000000000000
6lowpan_iphc 18968 1 bluetooth, Live 0x0000000000000000
binfmt_misc 17508 1 - Live 0x0000000000000000
snd_hda_codec_analog 15049 1 - Live 0x0000000000000000
snd_hda_codec_generic 70087 1 snd_hda_codec_analog, Live 0x0000000000000000
snd_hda_intel 30608 6 - Live 0x0000000000000000
snd_hda_controller 35518 1 snd_hda_intel, Live 0x0000000000000000
snd_hda_codec 144671 4 
snd_hda_codec_analog,snd_hda_codec_generic,snd_hda_intel,snd_hda_controller, 
Live 0x0000000000000000
snd_hwdep 13613 1 snd_hda_codec, Live 0x0000000000000000
thinkpad_acpi 82198 0 - Live 0x0000000000000000
dm_multipath 23188 0 - Live 0x0000000000000000
coretemp 13638 0 - Live 0x0000000000000000
snd_pcm 113863 3 snd_hda_intel,snd_hda_controller,snd_hda_codec, Live 
0x0000000000000000
nvram 14462 1 thinkpad_acpi, Live 0x0000000000000000
kvm_intel 148919 0 - Live 0x0000000000000000
scsi_dh 14873 1 dm_multipath, Live 0x0000000000000000
snd_seq_midi 13564 0 - Live 0x0000000000000000
arc4 12573 2 - Live 0x0000000000000000
kvm 463855 1 kvm_intel, Live 0x0000000000000000
snd_seq_midi_event 14899 1 snd_seq_midi, Live 0x0000000000000000
iwl4965 118803 0 - Live 0x0000000000000000
iwlegacy 105101 1 iwl4965, Live 0x0000000000000000
mac80211 663883 2 iwl4965,iwlegacy, Live 0x0000000000000000
snd_rawmidi 30865 1 snd_seq_midi, Live 0x0000000000000000
snd_seq 67636 2 snd_seq_midi,snd_seq_midi_event, Live 0x0000000000000000
cfg80211 515506 3 iwl4965,iwlegacy,mac80211, Live 0x0000000000000000
snd_seq_device 14497 3 snd_seq_midi,snd_rawmidi,snd_seq, Live 
0x0000000000000000
pcmcia 62760 0 - Live 0x0000000000000000
snd_timer 30118 2 snd_pcm,snd_seq, Live 0x0000000000000000
microcode 24391 0 - Live 0x0000000000000000
snd 74195 23 
snd_hda_codec_analog,snd_hda_codec_generic,snd_hda_intel,snd_hda_codec,snd_hwdep,thinkpad_acpi,snd_pcm,snd_rawmidi,snd_seq,snd_seq_device,snd_timer, 
Live 0x0000000000000000
serio_raw 13483 0 - Live 0x0000000000000000
yenta_socket 45447 0 - Live 0x0000000000000000
soundcore 12680 2 snd_hda_codec,snd, Live 0x0000000000000000
mac_hid 13275 0 - Live 0x0000000000000000
pcmcia_rsrc 18591 1 yenta_socket, Live 0x0000000000000000
ppdev 17711 0 - Live 0x0000000000000000
lpc_ich 21176 0 - Live 0x0000000000000000
pcmcia_core 23715 3 pcmcia,yenta_socket,pcmcia_rsrc, Live 0x0000000000000000
parport_pc 32906 0 - Live 0x0000000000000000
lp 17799 0 - Live 0x0000000000000000
parport 42481 3 ppdev,parport_pc,lp, Live 0x0000000000000000
xts 12951 1 - Live 0x0000000000000000
gf128mul 14951 1 xts, Live 0x0000000000000000
dm_crypt 23456 1 - Live 0x0000000000000000
mmc_block 36596 2 - Live 0x0000000000000000
ahci 30167 3 - Live 0x0000000000000000
sdhci_pci 23347 0 - Live 0x0000000000000000
psmouse 113095 0 - Live 0x0000000000000000
libahci 32191 1 ahci, Live 0x0000000000000000
sdhci 43409 1 sdhci_pci, Live 0x0000000000000000
i915 873516 3 - Live 0x0000000000000000
video 19932 1 i915, Live 0x0000000000000000
i2c_algo_bit 13564 1 i915, Live 0x0000000000000000
e1000e 262482 0 - Live 0x0000000000000000
drm_kms_helper 59729 1 i915, Live 0x0000000000000000
drm 310655 5 i915,drm_kms_helper, Live 0x0000000000000000
ptp 19534 1 e1000e, Live 0x0000000000000000
pps_core 19381 1 ptp, Live 0x0000000000000000

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)

ioports:

0000-0cf7 : PCI Bus 0000:00
   0000-001f : dma1
   0020-0021 : pic1
   0040-0043 : timer0
   0050-0053 : timer1
   0060-0060 : keyboard
   0062-0062 : EC data
   0064-0064 : keyboard
   0066-0066 : EC cmd
   0070-0071 : rtc0
   0080-008f : dma page reg
   00a0-00a1 : pic2
   00c0-00df : dma2
   00f0-00ff : fpu
   03c0-03df : vesafb
   0800-080f : pnp 00:01
0cf8-0cff : PCI conf1
0d00-ffff : PCI Bus 0000:00
   1000-1003 : ACPI PM1a_EVT_BLK
   1004-1005 : ACPI PM1a_CNT_BLK
   1008-100b : ACPI PM_TMR
   1010-1015 : ACPI CPU throttle
   1020-1020 : ACPI PM2_CNT_BLK
   1028-102f : ACPI GPE0_BLK
   1030-1033 : iTCO_wdt
   1060-107f : iTCO_wdt
   1180-11bf : 0000:00:1f.0
     1180-11bf : pnp 00:01
   15e0-15ef : pnp 00:01
   164e-164f : pnp 00:01
   1800-1807 : 0000:00:02.0
   1838-183b : 0000:00:1f.2
     1838-183b : ahci
   183c-183f : 0000:00:1f.2
     183c-183f : ahci
   1840-185f : 0000:00:19.0
   1860-187f : 0000:00:1a.0
     1860-187f : uhci_hcd
   1880-189f : 0000:00:1a.1
     1880-189f : uhci_hcd
   18a0-18bf : 0000:00:1d.0
     18a0-18bf : uhci_hcd
   18c0-18df : 0000:00:1d.1
     18c0-18df : uhci_hcd
   18e0-18ff : 0000:00:1f.2
     18e0-18ff : ahci
   1c00-1c07 : 0000:00:1f.2
     1c00-1c07 : ahci
   1c08-1c0f : 0000:00:1f.2
     1c08-1c0f : ahci
   1c20-1c3f : 0000:00:1f.3
   2000-2fff : PCI Bus 0000:02
   3000-3fff : PCI Bus 0000:03
   4000-7fff : PCI Bus 0000:05
     4000-40ff : PCI CardBus 0000:06
     4400-44ff : PCI CardBus 0000:06

iomem:

00000000-00000fff : reserved
00001000-0009d7ff : System RAM
0009d800-0009ffff : reserved
000a0000-000bffff : PCI Bus 0000:00
000c0000-000c7fff : Video ROM
000c8000-000cbfff : pnp 00:00
000cc000-000cffff : pnp 00:00
000d0000-000d3fff : PCI Bus 0000:00
000d4000-000d7fff : PCI Bus 0000:00
000d8000-000dbfff : PCI Bus 0000:00
000dc000-000dffff : PCI Bus 0000:00
000e0000-000fffff : reserved
   000f0000-000fffff : System ROM
00100000-bf6affff : System RAM
   01000000-0177cf58 : Kernel code
   0177cf59-01d20f7f : Kernel data
   01e7d000-01fe2fff : Kernel bss
   2c000000-33ffffff : Crash kernel
bf6b0000-bf6cbfff : ACPI Tables
bf6cc000-bf6fffff : ACPI Non-volatile Storage
bf700000-bfffffff : reserved
   bf800000-bfffffff : Graphics Stolen Memory
c0000000-febfffff : PCI Bus 0000:00
   c0000000-c3ffffff : PCI CardBus 0000:06
   c4000000-c4000fff : Intel Flush Page
   d4000000-d7efffff : PCI Bus 0000:05
     d7efec00-d7efecff : 0000:05:00.2
       d7efec00-d7efecff : mmc0
     d7eff000-d7efffff : 0000:05:00.0
       d7eff000-d7efffff : yenta_socket
   d8000000-dbffffff : PCI Bus 0000:05
     d8000000-dbffffff : PCI CardBus 0000:06
   e0000000-efffffff : 0000:00:02.0
   f0000000-f3ffffff : PCI MMCONFIG 0000 [bus 00-3f]
     f0000000-f3ffffff : reserved
       f0000000-f3ffffff : pnp 00:01
   f4000000-f5ffffff : PCI Bus 0000:02
   f6000000-f7ffffff : PCI Bus 0000:03
     f7f00000-f7f01fff : 0000:03:00.0
       f7f00000-f7f01fff : iwl4965
   f8000000-f80fffff : 0000:00:02.0
   f8100000-f81fffff : 0000:00:02.1
   f8200000-f821ffff : 0000:00:19.0
     f8200000-f821ffff : e1000e
   f8220000-f8223fff : 0000:00:1b.0
     f8220000-f8223fff : ICH HD audio
   f8225000-f8225fff : 0000:00:19.0
     f8225000-f8225fff : e1000e
   f8426000-f84267ff : 0000:00:1f.2
     f8426000-f84267ff : ahci
   f8426c00-f8426fff : 0000:00:1a.7
     f8426c00-f8426fff : ehci_hcd
   f8427000-f84273ff : 0000:00:1d.7
     f8427000-f84273ff : ehci_hcd
   f8427400-f84274ff : 0000:00:1f.3
   f8500000-f85fffff : PCI Bus 0000:02
   f8600000-f86fffff : PCI Bus 0000:03
fec00000-fec0ffff : reserved
   fec00000-fec003ff : IOAPIC 0
fed00000-fed003ff : HPET 0
   fed00000-fed003ff : reserved
fed14000-fed19fff : reserved
   fed14000-fed17fff : pnp 00:01
   fed18000-fed18fff : pnp 00:01
   fed19000-fed19fff : pnp 00:01
fed1c000-fed8ffff : reserved
   fed1c000-fed1ffff : pnp 00:01
     fed1f410-fed1f414 : iTCO_wdt
   fed40000-fed4bfff : PCI Bus 0000:00
     fed45000-fed4bfff : pnp 00:01
fee00000-fee00fff : Local APIC
   fee00000-fee00fff : reserved
ff000000-ffffffff : reserved
100000000-13bffffff : System RAM


[7.5.] PCI information ('lspci -vvv' as root)

00:00.0 Host bridge: Intel Corporation Mobile PM965/GM965/GL960 Memory 
Controller Hub (rev 0c)
   Subsystem: Lenovo ThinkPad T61/R61
   Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B- DisINTx-
   Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR- INTx-
   Latency: 0
   Capabilities: [e0] Vendor Specific Information: Len=0a <?>
   Kernel driver in use: agpgart-intel

00:02.0 VGA compatible controller: Intel Corporation Mobile GM965/GL960 
Integrated Graphics Controller (primary) (rev 0c) (prog-if 00 [VGA 
controller])
   Subsystem: Lenovo ThinkPad T61/R61
   Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
   Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
   Latency: 0
   Interrupt: pin A routed to IRQ 43
   Region 0: Memory at f8000000 (64-bit, non-prefetchable) [size=1M]
   Region 2: Memory at e0000000 (64-bit, prefetchable) [size=256M]
   Region 4: I/O ports at 1800 [size=8]
   Expansion ROM at <unassigned> [disabled]
   Capabilities: [90] MSI: Enable+ Count=1/1 Maskable- 64bit-
     Address: fee0300c  Data: 41e1
   Capabilities: [d0] Power Management version 3
     Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
     Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
     Bridge: PM- B3+
   Kernel driver in use: i915

00:02.1 Display controller: Intel Corporation Mobile GM965/GL960 
Integrated Graphics Controller (secondary) (rev 0c)
   Subsystem: Lenovo ThinkPad T61/R61
   Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
   Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
   Latency: 0
   Region 0: Memory at f8100000 (64-bit, non-prefetchable) [size=1M]
   Capabilities: [d0] Power Management version 3
     Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
     Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
     Bridge: PM- B3+

00:19.0 Ethernet controller: Intel Corporation 82566MM Gigabit Network 
Connection (rev 03)
   Subsystem: Lenovo Device 20de
   Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B- DisINTx+
   Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
   Latency: 0
   Interrupt: pin A routed to IRQ 42
   Region 0: Memory at f8200000 (32-bit, non-prefetchable) [size=128K]
   Region 1: Memory at f8225000 (32-bit, non-prefetchable) [size=4K]
   Region 2: I/O ports at 1840 [size=32]
   Capabilities: [c8] Power Management version 2
     Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
     Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=1 PME-
   Capabilities: [d0] MSI: Enable+ Count=1/1 Maskable- 64bit+
     Address: 00000000fee0300c  Data: 4172
   Kernel driver in use: e1000e

00:1a.0 USB controller: Intel Corporation 82801H (ICH8 Family) USB UHCI 
Controller #4 (rev 03) (prog-if 00 [UHCI])
   Subsystem: Lenovo ThinkPad T61/R61
   Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
   Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
   Latency: 0
   Interrupt: pin A routed to IRQ 20
   Region 4: I/O ports at 1860 [size=32]
   Kernel driver in use: uhci_hcd

00:1a.1 USB controller: Intel Corporation 82801H (ICH8 Family) USB UHCI 
Controller #5 (rev 03) (prog-if 00 [UHCI])
   Subsystem: Lenovo Thinkpad T61/R61
   Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
   Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
   Latency: 0
   Interrupt: pin B routed to IRQ 21
   Region 4: I/O ports at 1880 [size=32]
   Kernel driver in use: uhci_hcd

00:1a.7 USB controller: Intel Corporation 82801H (ICH8 Family) USB2 EHCI 
Controller #2 (rev 03) (prog-if 20 [EHCI])
   Subsystem: Lenovo ThinkPad T61/R61
   Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B- DisINTx-
   Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
   Latency: 0
   Interrupt: pin C routed to IRQ 22
   Region 0: Memory at f8426c00 (32-bit, non-prefetchable) [size=1K]
   Capabilities: [50] Power Management version 2
     Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
     Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
   Kernel driver in use: ehci-pci

00:1b.0 Audio device: Intel Corporation 82801H (ICH8 Family) HD Audio 
Controller (rev 03)
   Subsystem: Lenovo ThinkPad T61/R61
   Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B- DisINTx+
   Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
   Latency: 0, Cache Line Size: 64 bytes
   Interrupt: pin B routed to IRQ 46
   Region 0: Memory at f8220000 (64-bit, non-prefetchable) [size=16K]
   Capabilities: [50] Power Management version 2
     Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
     Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
   Capabilities: [60] MSI: Enable+ Count=1/1 Maskable- 64bit+
     Address: 00000000fee0300c  Data: 4152
   Capabilities: [70] Express (v1) Root Complex Integrated Endpoint, MSI 00
     DevCap: MaxPayload 128 bytes, PhantFunc 0
       ExtTag- RBE-
     DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
       RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop+
       MaxPayload 128 bytes, MaxReadReq 128 bytes
     DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
   Capabilities: [100 v1] Virtual Channel
     Caps: LPEVC=0 RefClk=100ns PATEntryBits=1
     Arb:  Fixed- WRR32- WRR64- WRR128-
     Ctrl: ArbSelect=Fixed
     Status: InProgress-
     VC0:  Caps: PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
       Arb:  Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
       Ctrl: Enable+ ID=0 ArbSelect=Fixed TC/VC=01
       Status: NegoPending- InProgress-
     VC1:  Caps: PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
       Arb:  Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
       Ctrl: Enable+ ID=1 ArbSelect=Fixed TC/VC=80
       Status: NegoPending- InProgress-
   Capabilities: [130 v1] Root Complex Link
     Desc: PortNumber=0f ComponentID=02 EltType=Config
     Link0:  Desc: TargetPort=00 TargetComponent=02 AssocRCRB- 
LinkType=MemMapped LinkValid+
       Addr: 00000000fed1c000
   Kernel driver in use: snd_hda_intel

00:1c.0 PCI bridge: Intel Corporation 82801H (ICH8 Family) PCI Express 
Port 1 (rev 03) (prog-if 00 [Normal decode])
   Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B- DisINTx+
   Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
   Latency: 0, Cache Line Size: 64 bytes
   Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
   I/O behind bridge: 00002000-00002fff
   Memory behind bridge: f4000000-f5ffffff
   Prefetchable memory behind bridge: 00000000f8500000-00000000f85fffff
   Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort+ <SERR- <PERR-
   BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
     PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
   Capabilities: [40] Express (v1) Root Port (Slot+), MSI 00
     DevCap: MaxPayload 128 bytes, PhantFunc 0
       ExtTag- RBE+
     DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
       RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
       MaxPayload 128 bytes, MaxReadReq 128 bytes
     DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
     LnkCap: Port #1, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit Latency 
L0s <1us, L1 <4us
       ClockPM- Surprise- LLActRep+ BwNot-
     LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- CommClk-
       ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
     LnkSta: Speed 2.5GT/s, Width x0, TrErr- Train- SlotClk+ DLActive- 
BWMgmt- ABWMgmt-
     SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+
       Slot #2, PowerLimit 6.500W; Interlock- NoCompl-
     SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet+ CmdCplt+ HPIrq+ LinkChg+
       Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
     SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet- Interlock-
       Changed: MRL- PresDet- LinkState-
     RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna+ CRSVisible-
     RootCap: CRSVisible-
     RootSta: PME ReqID 0000, PMEStatus- PMEPending-
   Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
     Address: fee0300c  Data: 41a1
   Capabilities: [90] Subsystem: Lenovo ThinkPad T61/R61
   Capabilities: [a0] Power Management version 2
     Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
     Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
   Capabilities: [100 v1] Virtual Channel
     Caps: LPEVC=0 RefClk=100ns PATEntryBits=1
     Arb:  Fixed+ WRR32- WRR64- WRR128-
     Ctrl: ArbSelect=Fixed
     Status: InProgress-
     VC0:  Caps: PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
       Arb:  Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
       Ctrl: Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
       Status: NegoPending- InProgress-
   Capabilities: [180 v1] Root Complex Link
     Desc: PortNumber=01 ComponentID=02 EltType=Config
     Link0:  Desc: TargetPort=00 TargetComponent=02 AssocRCRB- 
LinkType=MemMapped LinkValid+
       Addr: 00000000fed1c001
   Kernel driver in use: pcieport

00:1c.1 PCI bridge: Intel Corporation 82801H (ICH8 Family) PCI Express 
Port 2 (rev 03) (prog-if 00 [Normal decode])
   Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B- DisINTx+
   Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
   Latency: 0, Cache Line Size: 64 bytes
   Bus: primary=00, secondary=03, subordinate=03, sec-latency=0
   I/O behind bridge: 00003000-00003fff
   Memory behind bridge: f6000000-f7ffffff
   Prefetchable memory behind bridge: 00000000f8600000-00000000f86fffff
   Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort+ <SERR+ <PERR-
   BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
     PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
   Capabilities: [40] Express (v1) Root Port (Slot+), MSI 00
     DevCap: MaxPayload 128 bytes, PhantFunc 0
       ExtTag- RBE+
     DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
       RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
       MaxPayload 128 bytes, MaxReadReq 128 bytes
     DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
     LnkCap: Port #2, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit Latency 
L0s <256ns, L1 <4us
       ClockPM- Surprise- LLActRep+ BwNot-
     LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- CommClk+
       ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
     LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive+ 
BWMgmt- ABWMgmt-
     SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+
       Slot #3, PowerLimit 6.500W; Interlock- NoCompl-
     SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet+ CmdCplt+ HPIrq+ LinkChg+
       Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
     SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
       Changed: MRL- PresDet- LinkState+
     RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna+ CRSVisible-
     RootCap: CRSVisible-
     RootSta: PME ReqID 0000, PMEStatus- PMEPending-
   Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
     Address: fee0300c  Data: 41b1
   Capabilities: [90] Subsystem: Lenovo ThinkPad T61/R61
   Capabilities: [a0] Power Management version 2
     Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
     Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
   Capabilities: [100 v1] Virtual Channel
     Caps: LPEVC=0 RefClk=100ns PATEntryBits=1
     Arb:  Fixed+ WRR32- WRR64- WRR128-
     Ctrl: ArbSelect=Fixed
     Status: InProgress-
     VC0:  Caps: PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
       Arb:  Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
       Ctrl: Enable+ ID=0 ArbSelect=Fixed TC/VC=01
       Status: NegoPending- InProgress-
   Capabilities: [180 v1] Root Complex Link
     Desc: PortNumber=02 ComponentID=02 EltType=Config
     Link0:  Desc: TargetPort=00 TargetComponent=02 AssocRCRB- 
LinkType=MemMapped LinkValid+
       Addr: 00000000fed1c001
   Kernel driver in use: pcieport

00:1d.0 USB controller: Intel Corporation 82801H (ICH8 Family) USB UHCI 
Controller #1 (rev 03) (prog-if 00 [UHCI])
   Subsystem: Lenovo ThinkPad T61/R61
   Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
   Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
   Latency: 0
   Interrupt: pin A routed to IRQ 16
   Region 4: I/O ports at 18a0 [size=32]
   Kernel driver in use: uhci_hcd

00:1d.1 USB controller: Intel Corporation 82801H (ICH8 Family) USB UHCI 
Controller #2 (rev 03) (prog-if 00 [UHCI])
   Subsystem: Lenovo ThinkPad T61/R61
   Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
   Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
   Latency: 0
   Interrupt: pin B routed to IRQ 17
   Region 4: I/O ports at 18c0 [size=32]
   Kernel driver in use: uhci_hcd

00:1d.7 USB controller: Intel Corporation 82801H (ICH8 Family) USB2 EHCI 
Controller #1 (rev 03) (prog-if 20 [EHCI])
   Subsystem: Lenovo ThinkPad T61/R61
   Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B- DisINTx-
   Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
   Latency: 0
   Interrupt: pin D routed to IRQ 19
   Region 0: Memory at f8427000 (32-bit, non-prefetchable) [size=1K]
   Capabilities: [50] Power Management version 2
     Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
     Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
   Capabilities: [58] Debug port: BAR=1 offset=00a0
   Kernel driver in use: ehci-pci

00:1e.0 PCI bridge: Intel Corporation 82801 Mobile PCI Bridge (rev f3) 
(prog-if 01 [Subtractive decode])
   Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
   Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
   Latency: 0
   Bus: primary=00, secondary=05, subordinate=08, sec-latency=32
   I/O behind bridge: 00004000-00007fff
   Memory behind bridge: d4000000-d7efffff
   Prefetchable memory behind bridge: 00000000d8000000-00000000dbffffff
   Secondary status: 66MHz- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ <SERR- <PERR-
   BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
     PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
   Capabilities: [50] Subsystem: Lenovo ThinkPad T61/R61

00:1f.0 ISA bridge: Intel Corporation 82801HEM (ICH8M-E) LPC Interface 
Controller (rev 03)
   Subsystem: Lenovo ThinkPad T61/R61
   Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
   Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
   Latency: 0
   Capabilities: [e0] Vendor Specific Information: Len=0c <?>
   Kernel driver in use: lpc_ich

00:1f.2 SATA controller: Intel Corporation 82801HM/HEM (ICH8M/ICH8M-E) 
SATA Controller [AHCI mode] (rev 03) (prog-if 01 [AHCI 1.0])
   Subsystem: Lenovo ThinkPad T61/R61
   Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
   Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
   Latency: 0
   Interrupt: pin B routed to IRQ 44
   Region 0: I/O ports at 1c08 [size=8]
   Region 1: I/O ports at 183c [size=4]
   Region 2: I/O ports at 1c00 [size=8]
   Region 3: I/O ports at 1838 [size=4]
   Region 4: I/O ports at 18e0 [size=32]
   Region 5: Memory at f8426000 (32-bit, non-prefetchable) [size=2K]
   Capabilities: [80] MSI: Enable+ Count=1/4 Maskable- 64bit-
     Address: fee0300c  Data: 4122
   Capabilities: [70] Power Management version 3
     Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot+,D3cold-)
     Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
   Capabilities: [a8] SATA HBA v1.0 BAR4 Offset=00000004
   Kernel driver in use: ahci

00:1f.3 SMBus: Intel Corporation 82801H (ICH8 Family) SMBus Controller 
(rev 03)
   Subsystem: Lenovo ThinkPad T61/R61
   Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B- DisINTx-
   Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
   Interrupt: pin A routed to IRQ 11
   Region 0: Memory at f8427400 (32-bit, non-prefetchable) [size=256]
   Region 4: I/O ports at 1c20 [size=32]

03:00.0 Network controller: Intel Corporation PRO/Wireless 4965 AG or 
AGN [Kedron] Network Connection (rev 61)
   Subsystem: Intel Corporation Lenovo ThinkPad T51
   Physical Slot: 3
   Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B- DisINTx-
   Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR+ <PERR- INTx-
   Latency: 0, Cache Line Size: 64 bytes
   Interrupt: pin A routed to IRQ 45
   Region 0: Memory at f7f00000 (64-bit, non-prefetchable) [size=8K]
   Capabilities: [c8] Power Management version 3
     Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
     Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
   Capabilities: [d0] MSI: Enable+ Count=1/1 Maskable- 64bit+
     Address: 00000000fee0300c  Data: 4142
   Capabilities: [e0] Express (v1) Endpoint, MSI 00
     DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s <512ns, L1 
unlimited
       ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
     DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
       RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
       MaxPayload 128 bytes, MaxReadReq 128 bytes
     DevSta: CorrErr+ UncorrErr+ FatalErr- UnsuppReq+ AuxPwr+ TransPend-
     LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit Latency 
L0s <128ns, L1 <64us
       ClockPM+ Surprise- LLActRep- BwNot-
     LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- CommClk+
       ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
     LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- 
BWMgmt- ABWMgmt-
   Capabilities: [100 v1] Advanced Error Reporting
     UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- 
MalfTLP- ECRC- UnsupReq+ ACSViol-
     UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- 
MalfTLP- ECRC- UnsupReq- ACSViol-
     UESvrt: DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ 
MalfTLP+ ECRC- UnsupReq- ACSViol-
     CESta:  RxErr+ BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
     CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
     AERCap: First Error Pointer: 14, GenCap- CGenEn- ChkCap- ChkEn-
   Capabilities: [140 v1] Device Serial Number 00-1d-e0-ff-ff-6b-9c-3f
   Kernel driver in use: iwl4965

05:00.0 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev ba)
   Subsystem: Lenovo ThinkPad R61
   Physical Slot: 1
   Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
   Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
   Latency: 168, Cache Line Size: 64 bytes
   Interrupt: pin A routed to IRQ 16
   Region 0: Memory at d7eff000 (32-bit, non-prefetchable) [size=4K]
   Bus: primary=05, secondary=06, subordinate=07, sec-latency=176
   Memory window 0: d8000000-dbffffff (prefetchable)
   Memory window 1: c0000000-c3ffffff
   I/O window 0: 00004000-000040ff
   I/O window 1: 00004400-000044ff
   BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt+ PostWrite+
   16-bit legacy interface ports at 0001
   Capabilities: [dc] Power Management version 2
     Flags: PMEClk+ DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
     Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=2 PME-
     Bridge: PM- B3+
   Kernel driver in use: yenta_cardbus

05:00.2 SD Host controller: Ricoh Co Ltd R5C822 SD/SDIO/MMC/MS/MSPro 
Host Adapter (rev 21)
   Subsystem: Lenovo ThinkPad W500
   Physical Slot: 1
   Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
   Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
   Latency: 64
   Interrupt: pin C routed to IRQ 18
   Region 0: Memory at d7efec00 (32-bit, non-prefetchable) [size=256]
   Capabilities: [80] Power Management version 2
     Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
     Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=2 PME-
   Kernel driver in use: sdhci-pci

[7.6.] SCSI information (from /proc/scsi/scsi)

Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
   Vendor: ATA      Model: ST9200420AS      Rev: 3.AA
   Type:   Direct-Access                    ANSI  SCSI revision: 05


[7.7.] Other information that might be relevant to the problem
        (please look in /proc and include all information that you
        think to be relevant):
[X.] Other notes, patches, fixes, workarounds:
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1324384

---- ALSA info for 5ccc618fee67f0f0b2122dd4b32a02fd2b6a1569 BEGIN ----
upload=true&script=true&cardinfo=
!!################################
!!ALSA Information Script v 0.4.60
!!################################

!!Script ran on: Sun Jun  1 02:56:49 UTC 2014


!!Linux Distribution


Ubuntu 14.04 LTS \n \l DISTRIB_ID=Ubuntu DISTRIB_DESCRIPTION="Ubuntu 
14.04 LTS" NAME="Ubuntu" ID=ubuntu ID_LIKE=debian PRETTY_NAME="Ubuntu 
14.04 LTS" HOME_URL="http://www.ubuntu.com/" 
SUPPORT_URL="http://help.ubuntu.com/" 
BUG_REPORT_URL="http://bugs.launchpad.net/ubuntu/"


!!DMI Information


Manufacturer:      LENOVO
Product Name:      76693JG
Product Version:   ThinkPad X61s


!!Kernel Information


Kernel release:    3.10-rc7-359-g5ccc618-generic
Operating System:  GNU/Linux
Architecture:      x86_64
Processor:         x86_64
SMP Enabled:       Yes


!!ALSA Version


Driver version:     k3.10-rc7-359-g5ccc618-generic
Library version:    1.0.27.2
Utilities version:  1.0.27.2


!!Loaded ALSA modules


snd_hda_intel
thinkpad_acpi


!!Sound Servers on this system


Pulseaudio:
       Installed - Yes (/usr/bin/pulseaudio)
       Running - Yes


!!Soundcards recognised by ALSA


  0 [Intel          ]: HDA-Intel - HDA Intel
                       HDA Intel at 0xf8220000 irq 46
  4 [ThinkPadEC     ]: ThinkPad EC - ThinkPad Console Audio Control
                       ThinkPad Console Audio Control at EC reg 0x30, fw 
7MHT25WW-1.03


!!PCI Soundcards installed in the system


00:1b.0 Audio device: Intel Corporation 82801H (ICH8 Family) HD Audio 
Controller (rev 03)


!!Advanced information - PCI Vendor/Device/Subsystem ID's


00:1b.0 0403: 8086:284b (rev 03)
   Subsystem: 17aa:20ac


!!Modprobe options (Sound related)


snd_atiixp_modem: index=-2
snd_intel8x0m: index=-2
snd_via82xx_modem: index=-2
snd_usb_audio: index=-2
snd_usb_caiaq: index=-2
snd_usb_ua101: index=-2
snd_usb_us122l: index=-2
snd_usb_usx2y: index=-2
snd_cmipci: mpu_port=0x330 fm_port=0x388
snd_pcsp: index=-2
snd_usb_audio: index=-2


!!Loaded sound module options


!!Module: snd_hda_intel
   align_buffer_size : -1
   bdl_pos_adj : 
1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
   beep_mode : 
N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N
   enable : Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y
   enable_msi : -1
   id : 
(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null)
   index : 
-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
   jackpoll_ms : 
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
   model : 
(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null)
   patch : 
(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null)
   position_fix : 
-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
   power_save : 1
   power_save_controller : Y
   probe_mask : 
-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
   probe_only : 
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
   single_cmd : N
   snoop : Y

!!Module: thinkpad_acpi
   brightness_enable : 2
   brightness_mode : 4
   dbg_bluetoothemul : 0
   dbg_uwbemul : 0
   dbg_wlswemul : 0
   dbg_wwanemul : 0
   enable : Y
   experimental : 0
   fan_control : N
   force_load : N
   hotkey_report_mode : 0
   id : ThinkPadEC
   index : -536870912
   volume_capabilities : 0
   volume_control : N
   volume_mode : 3


!!HDA-Intel Codec information

--startcollapse--

Codec: Analog Devices AD1984
Address: 0
AFG Function Id: 0x1 (unsol 0)
Vendor Id: 0x11d41984
Subsystem Id: 0x17aa20d6
Revision Id: 0x100400
No Modem Function Group found
Default PCM:
     rates [0x7ff]: 8000 11025 16000 22050 32000 44100 48000 88200 96000 
176400 192000
     bits [0xe]: 16 20 24
     formats [0x1]: PCM
Default Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
Default Amp-Out caps: ofs=0x27, nsteps=0x27, stepsize=0x05, mute=0
State of AFG node 0x01:
   Power states:  D0 D3
   Power: setting=D0, actual=D0
GPIO: io=3, o=0, i=0, unsolicited=1, wake=0
   IO[0]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
   IO[1]: enable=1, dir=0, wake=0, sticky=0, data=0, unsol=0
   IO[2]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
Node 0x02 [Audio Output] wcaps 0x30311: Stereo Digital
   Converter: stream=0, channel=0
   Digital:
   Digital category: 0x0
   IEC Coding Type: 0x0
   PCM:
     rates [0x7e0]: 44100 48000 88200 96000 176400 192000
     bits [0xe]: 16 20 24
     formats [0x5]: PCM AC3
   Delay: 3 samples
   Connection: 3
      0x01* 0x08 0x09
Node 0x03 [Audio Output] wcaps 0x405: Stereo Amp-Out
   Control: name="Headphone Playback Volume", index=0, device=0
     ControlAmp: chs=3, dir=Out, idx=0, ofs=0
   Device: name="AD1984 Analog", type="Audio", device=0
   Device: name="AD1984 Alt Analog", type="Audio", device=2
   Amp-Out caps: ofs=0x27, nsteps=0x27, stepsize=0x05, mute=0
   Amp-Out vals:  [0x27 0x27]
   Converter: stream=0, channel=0
   Power states:  D0 D3
   Power: setting=D0, actual=D0
Node 0x04 [Audio Output] wcaps 0x405: Stereo Amp-Out
   Control: name="Speaker Playback Volume", index=0, device=0
     ControlAmp: chs=3, dir=Out, idx=0, ofs=0
   Amp-Out caps: ofs=0x27, nsteps=0x27, stepsize=0x05, mute=0
   Amp-Out vals:  [0x00 0x00]
   Converter: stream=0, channel=0
   Power states:  D0 D3
   Power: setting=D0, actual=D0
Node 0x05 [Audio Input] wcaps 0x10050b: Stereo Amp-In
   Amp-In caps: ofs=0x27, nsteps=0x36, stepsize=0x05, mute=1
   Amp-In vals:  [0xa7 0xa7]
   Converter: stream=0, channel=0
   SDI-Select: 0
   Power states:  D0 D3
   Power: setting=D0, actual=D0
   Connection: 1
      0x17
Node 0x06 [Audio Input] wcaps 0x10050b: Stereo Amp-In
   Amp-In caps: ofs=0x27, nsteps=0x36, stepsize=0x05, mute=1
   Amp-In vals:  [0xa7 0xa7]
   Converter: stream=0, channel=0
   SDI-Select: 0
   Power states:  D0 D3
   Power: setting=D0, actual=D0
   Connection: 1
      0x18
Node 0x07 [Audio Mixer] wcaps 0x200103: Stereo Amp-In
   Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
   Amp-In vals:  [0x00 0x00] [0x80 0x80]
   Connection: 2
      0x22 0x21
Node 0x08 [Audio Input] wcaps 0x100501: Stereo
   Device: name="AD1984 Analog", type="Audio", device=0
   Converter: stream=0, channel=0
   SDI-Select: 0
   Power states:  D0 D3
   Power: setting=D0, actual=D0
   Connection: 1
      0x0c
Node 0x09 [Audio Input] wcaps 0x100501: Stereo
   Converter: stream=0, channel=0
   SDI-Select: 0
   Power states:  D0 D3
   Power: setting=D0, actual=D0
   Connection: 1
      0x0d
Node 0x0a [Audio Mixer] wcaps 0x200103: Stereo Amp-In
   Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
   Amp-In vals:  [0x00 0x00] [0x80 0x80]
   Connection: 2
      0x04 0x21
Node 0x0b [Audio Mixer] wcaps 0x200103: Stereo Amp-In
   Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
   Amp-In vals:  [0x80 0x80] [0x80 0x80]
   Connection: 2
      0x0f 0x21
Node 0x0c [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
   Control: name="Capture Volume", index=0, device=0
     ControlAmp: chs=3, dir=Out, idx=0, ofs=0
   Control: name="Capture Switch", index=0, device=0
     ControlAmp: chs=3, dir=Out, idx=0, ofs=0
   Amp-Out caps: ofs=0x27, nsteps=0x36, stepsize=0x05, mute=1
   Amp-Out vals:  [0x28 0x28]
   Connection: 5
      0x14 0x15* 0x16 0x20 0x25
Node 0x0d [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
   Amp-Out caps: ofs=0x27, nsteps=0x36, stepsize=0x05, mute=1
   Amp-Out vals:  [0xa7 0xa7]
   Connection: 5
      0x14* 0x15 0x16 0x20 0x25
Node 0x0e [Audio Selector] wcaps 0x300101: Stereo
   Connection: 2
      0x03* 0x04
Node 0x0f [Audio Selector] wcaps 0x300101: Stereo
   Connection: 2
      0x03* 0x04
Node 0x10 [Beep Generator Widget] wcaps 0x70000c: Mono Amp-Out
   Control: name="Beep Playback Volume", index=0, device=0
     ControlAmp: chs=1, dir=Out, idx=0, ofs=0
   Control: name="Beep Playback Switch", index=0, device=0
     ControlAmp: chs=1, dir=Out, idx=0, ofs=0
   Amp-Out caps: ofs=0x0f, nsteps=0x0f, stepsize=0x0b, mute=1
   Amp-Out vals:  [0x0f]
Node 0x11 [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
   Control: name="Headphone Playback Switch", index=0, device=0
     ControlAmp: chs=3, dir=Out, idx=0, ofs=0
   Control: name="Headphone Jack", index=0, device=0
   Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
   Amp-Out vals:  [0x00 0x00]
   Pincap 0x0000001f: OUT HP Detect Trigger ImpSense
   Pin Default 0x0421401f: [Jack] HP Out at Ext Right
     Conn = 1/8, Color = Green
     DefAssociation = 0x1, Sequence = 0xf
   Pin-ctls: 0xc0: OUT HP
   Unsolicited: tag=01, enabled=1
   Connection: 1
      0x07
Node 0x12 [Pin Complex] wcaps 0x40058d: Stereo Amp-Out
   Control: name="Speaker Playback Switch", index=0, device=0
     ControlAmp: chs=3, dir=Out, idx=0, ofs=0
   Control: name="Speaker Phantom Jack", index=0, device=0
   Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
   Amp-Out vals:  [0x80 0x80]
   Pincap 0x0001001f: OUT HP EAPD Detect Trigger ImpSense
   EAPD 0x0:
   Pin Default 0x90170110: [Fixed] Speaker at Int N/A
     Conn = Analog, Color = Unknown
     DefAssociation = 0x1, Sequence = 0x0
     Misc = NO_PRESENCE
   Pin-ctls: 0x40: OUT
   Unsolicited: tag=00, enabled=0
   Power states:  D0 D3
   Power: setting=D0, actual=D0
   Connection: 1
      0x0a
Node 0x13 [Pin Complex] wcaps 0x40050c: Mono Amp-Out
   Amp-Out caps: ofs=0x1f, nsteps=0x1f, stepsize=0x05, mute=1
   Amp-Out vals:  [0x9f]
   Pincap 0x00010010: OUT EAPD
   EAPD 0x0:
   Pin Default 0x511301f0: [N/A] Speaker at Int Rear
     Conn = ATAPI, Color = Unknown
     DefAssociation = 0xf, Sequence = 0x0
     Misc = NO_PRESENCE
   Pin-ctls: 0x40: OUT
   Power states:  D0 D3
   Power: setting=D0, actual=D0
   Connection: 1
      0x1f
Node 0x14 [Pin Complex] wcaps 0x40008b: Stereo Amp-In
   Control: name="Mic Boost Volume", index=0, device=0
     ControlAmp: chs=3, dir=In, idx=0, ofs=0
   Control: name="Mic Jack", index=0, device=0
   Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
   Amp-In vals:  [0x00 0x00]
   Pincap 0x00003727: IN Detect Trigger ImpSense
     Vref caps: HIZ 50 GRD 80 100
   Pin Default 0x04a15021: [Jack] Mic at Ext Right
     Conn = 1/8, Color = Red
     DefAssociation = 0x2, Sequence = 0x1
   Pin-ctls: 0x24: IN VREF_80
   Unsolicited: tag=03, enabled=1
Node 0x15 [Pin Complex] wcaps 0x40008b: Stereo Amp-In
   Control: name="Internal Mic Boost Volume", index=0, device=0
     ControlAmp: chs=3, dir=In, idx=0, ofs=0
   Control: name="Internal Mic Phantom Jack", index=0, device=0
   Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
   Amp-In vals:  [0x00 0x00]
   Pincap 0x00003727: IN Detect Trigger ImpSense
     Vref caps: HIZ 50 GRD 80 100
   Pin Default 0x90a7012e: [Fixed] Mic at Int N/A
     Conn = Analog, Color = Unknown
     DefAssociation = 0x2, Sequence = 0xe
     Misc = NO_PRESENCE
   Pin-ctls: 0x24: IN VREF_80
   Unsolicited: tag=00, enabled=0
Node 0x16 [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
   Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
   Amp-Out vals:  [0x80 0x80]
   Pincap 0x00000037: IN OUT Detect Trigger ImpSense
   Pin Default 0x593301f0: [N/A] CD at Int ATAPI
     Conn = ATAPI, Color = Unknown
     DefAssociation = 0xf, Sequence = 0x0
     Misc = NO_PRESENCE
   Pin-ctls: 0x00:
   Unsolicited: tag=00, enabled=0
   Connection: 1
      0x0b
Node 0x17 [Pin Complex] wcaps 0x400001: Stereo
   Pincap 0x00000020: IN
   Pin Default 0x55a601f0: [N/A] Mic at Int Top
     Conn = Digital, Color = Unknown
     DefAssociation = 0xf, Sequence = 0x0
     Misc = NO_PRESENCE
   Pin-ctls: 0x24: IN
Node 0x18 [Pin Complex] wcaps 0x400001: Stereo
   Pincap 0x00000020: IN
   Pin Default 0x55a601f0: [N/A] Mic at Int Top
     Conn = Digital, Color = Unknown
     DefAssociation = 0xf, Sequence = 0x0
     Misc = NO_PRESENCE
   Pin-ctls: 0x00:
Node 0x19 [Power Widget] wcaps 0x500500: Mono
   Power states:  D0 D3
   Power: setting=D0, actual=D0
   Connection: 2
      0x20 0x21
Node 0x1a [Pin Complex] wcaps 0x400000: Mono
   Pincap 0x00000020: IN
   Pin Default 0x91f311f0: [Fixed] Other at Int Rear
     Conn = ATAPI, Color = Black
     DefAssociation = 0xf, Sequence = 0x0
     Misc = NO_PRESENCE
   Pin-ctls: 0x20: IN
Node 0x1b [Pin Complex] wcaps 0x40030d: Stereo Digital Amp-Out
   Amp-Out caps: ofs=0x27, nsteps=0x27, stepsize=0x05, mute=1
   Amp-Out vals:  [0xa7 0xa7]
   Pincap 0x00000010: OUT
   Pin Default 0x614411f0: [N/A] SPDIF Out at Sep Rear
     Conn = RCA, Color = Black
     DefAssociation = 0xf, Sequence = 0x0
     Misc = NO_PRESENCE
   Pin-ctls: 0x40: OUT
   Connection: 1
      0x02
Node 0x1c [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
   Control: name="Dock Mic Jack", index=0, device=0
   Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
   Amp-Out vals:  [0x80 0x80]
   Pincap 0x00003737: IN OUT Detect Trigger ImpSense
     Vref caps: HIZ 50 GRD 80 100
   Pin Default 0x21a15020: [Jack] Mic at Sep Rear
     Conn = 1/8, Color = Red
     DefAssociation = 0x2, Sequence = 0x0
   Pin-ctls: 0x24: IN VREF_80
   Unsolicited: tag=02, enabled=1
   Connection: 1
      0x24
Node 0x1d [Vendor Defined Widget] wcaps 0xf00100: Mono
   Connection: 25
      0x07* 0x19 0x0a 0x0b 0x0c 0x0d 0x0e 0x0f 0x1a 0x1c 0x11 0x12 0x13 
0x14 0x15 0x16 0x1e 0x1f 0x20 0x21 0x22 0x23 0x24 0x25 0x26
Node 0x1e [Audio Mixer] wcaps 0x200103: Stereo Amp-In
   Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
   Amp-In vals:  [0x80 0x80] [0x80 0x80]
   Connection: 2
      0x0e 0x21
Node 0x1f [Audio Mixer] wcaps 0x200100: Mono
   Connection: 1
      0x1e
Node 0x20 [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
   Control: name="Internal Mic Playback Volume", index=0, device=0
     ControlAmp: chs=3, dir=In, idx=1, ofs=0
   Control: name="Internal Mic Playback Switch", index=0, device=0
     ControlAmp: chs=3, dir=In, idx=1, ofs=0
   Control: name="Dock Mic Playback Volume", index=0, device=0
     ControlAmp: chs=3, dir=In, idx=4, ofs=0
   Control: name="Dock Mic Playback Switch", index=0, device=0
     ControlAmp: chs=3, dir=In, idx=4, ofs=0
   Control: name="Mic Playback Volume", index=0, device=0
     ControlAmp: chs=3, dir=In, idx=0, ofs=0
   Control: name="Mic Playback Switch", index=0, device=0
     ControlAmp: chs=3, dir=In, idx=0, ofs=0
   Amp-In caps: ofs=0x17, nsteps=0x1f, stepsize=0x05, mute=1
   Amp-In vals:  [0x80 0x80] [0x9f 0x9f] [0x80 0x80] [0x80 0x80] [0x80 0x80]
   Connection: 5
      0x14 0x15 0x16 0x1a 0x25
Node 0x21 [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
   Amp-Out caps: ofs=0x1f, nsteps=0x1f, stepsize=0x05, mute=1
   Amp-Out vals:  [0x9f 0x9f]
   Connection: 1
      0x20
Node 0x22 [Audio Selector] wcaps 0x300101: Stereo
   Connection: 2
      0x03* 0x04
Node 0x23 [Audio Selector] wcaps 0x300101: Stereo
   Connection: 2
      0x03* 0x04
Node 0x24 [Audio Mixer] wcaps 0x200103: Stereo Amp-In
   Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
   Amp-In vals:  [0x80 0x80] [0x80 0x80]
   Connection: 2
      0x23 0x21
Node 0x25 [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
   Control: name="Dock Mic Boost Volume", index=0, device=0
     ControlAmp: chs=3, dir=Out, idx=0, ofs=0
   Amp-Out caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
   Amp-Out vals:  [0x00 0x00]
   Connection: 1
      0x1c
Node 0x26 [Vendor Defined Widget] wcaps 0xf00100: Mono
   Connection: 3
      0x14* 0x15 0x1c
--endcollapse--


!!ALSA Device nodes


crw-rw----+ 1 root audio 116,  7 May 31 18:02 /dev/snd/controlC0
crw-rw----+ 1 root audio 116,  2 May 31 18:02 /dev/snd/controlC4
crw-rw----+ 1 root audio 116,  6 May 31 18:02 /dev/snd/hwC0D0
crw-rw----+ 1 root audio 116,  5 May 31 18:07 /dev/snd/pcmC0D0c
crw-rw----+ 1 root audio 116,  4 May 31 19:13 /dev/snd/pcmC0D0p
crw-rw----+ 1 root audio 116,  3 May 31 18:02 /dev/snd/pcmC0D2p
crw-rw----+ 1 root audio 116,  1 May 31 18:02 /dev/snd/seq
crw-rw----+ 1 root audio 116, 33 May 31 18:02 /dev/snd/timer

/dev/snd/by-path:
total 0
drwxr-xr-x 2 root root  80 May 31 18:02 .
drwxr-xr-x 3 root root 220 May 31 18:02 ..
lrwxrwxrwx 1 root root  12 May 31 18:02 pci-0000:00:1b.0 -> ../controlC0
lrwxrwxrwx 1 root root  12 May 31 18:02 platform-thinkpad_acpi -> 
../controlC4


!!Aplay/Arecord output


APLAY

**** List of PLAYBACK Hardware Devices ****
card 0: Intel [HDA Intel], device 0: AD1984 Analog [AD1984 Analog]
   Subdevices: 1/1
   Subdevice #0: subdevice #0
card 0: Intel [HDA Intel], device 2: AD1984 Alt Analog [AD1984 Alt Analog]
   Subdevices: 1/1
   Subdevice #0: subdevice #0

ARECORD

**** List of CAPTURE Hardware Devices ****
card 0: Intel [HDA Intel], device 0: AD1984 Analog [AD1984 Analog]
   Subdevices: 1/1
   Subdevice #0: subdevice #0

!!Amixer output


!!-------Mixer controls for card 0 [Intel]

Card hw:0 'Intel'/'HDA Intel at 0xf8220000 irq 46'
   Mixer name  : 'Analog Devices AD1984'
   Components  : 'HDA:11d41984,17aa20d6,00100400'
   Controls      : 31
   Simple ctrls  : 15
Simple mixer control 'Master',0
   Capabilities: pvolume pvolume-joined pswitch pswitch-joined
   Playback channels: Mono
   Limits: Playback 0 - 39
   Mono: Playback 39 [100%] [0.00dB] [on]
Simple mixer control 'Headphone',0
   Capabilities: pvolume pswitch
   Playback channels: Front Left - Front Right
   Limits: Playback 0 - 39
   Mono:
   Front Left: Playback 39 [100%] [0.00dB] [on]
   Front Right: Playback 39 [100%] [0.00dB] [on]
Simple mixer control 'Speaker',0
   Capabilities: pvolume pswitch
   Playback channels: Front Left - Front Right
   Limits: Playback 0 - 39
   Mono:
   Front Left: Playback 0 [0%] [-58.50dB] [off]
   Front Right: Playback 0 [0%] [-58.50dB] [off]
Simple mixer control 'PCM',0
   Capabilities: pvolume
   Playback channels: Front Left - Front Right
   Limits: Playback 0 - 255
   Mono:
   Front Left: Playback 255 [100%] [0.00dB]
   Front Right: Playback 255 [100%] [0.00dB]
Simple mixer control 'Mic',0
   Capabilities: pvolume pswitch
   Playback channels: Front Left - Front Right
   Limits: Playback 0 - 31
   Mono:
   Front Left: Playback 0 [0%] [-34.50dB] [off]
   Front Right: Playback 0 [0%] [-34.50dB] [off]
Simple mixer control 'Mic Boost',0
   Capabilities: volume
   Playback channels: Front Left - Front Right
   Capture channels: Front Left - Front Right
   Limits: 0 - 3
   Front Left: 0 [0%] [0.00dB]
   Front Right: 0 [0%] [0.00dB]
Simple mixer control 'Beep',0
   Capabilities: pvolume pvolume-joined pswitch pswitch-joined
   Playback channels: Mono
   Limits: Playback 0 - 15
   Mono: Playback 15 [100%] [0.00dB] [on]
Simple mixer control 'Capture',0
   Capabilities: cvolume cswitch
   Capture channels: Front Left - Front Right
   Limits: Capture 0 - 54
   Front Left: Capture 40 [74%] [1.50dB] [on]
   Front Right: Capture 40 [74%] [1.50dB] [on]
Simple mixer control 'Auto-Mute Mode',0
   Capabilities: enum
   Items: 'Disabled' 'Enabled'
   Item0: 'Enabled'
Simple mixer control 'Digital',0
   Capabilities: cvolume
   Capture channels: Front Left - Front Right
   Limits: Capture 0 - 120
   Front Left: Capture 60 [50%] [0.00dB]
   Front Right: Capture 60 [50%] [0.00dB]
Simple mixer control 'Dock Mic',0
   Capabilities: pvolume pswitch
   Playback channels: Front Left - Front Right
   Limits: Playback 0 - 31
   Mono:
   Front Left: Playback 0 [0%] [-34.50dB] [off]
   Front Right: Playback 0 [0%] [-34.50dB] [off]
Simple mixer control 'Dock Mic Boost',0
   Capabilities: volume
   Playback channels: Front Left - Front Right
   Capture channels: Front Left - Front Right
   Limits: 0 - 3
   Front Left: 0 [0%] [0.00dB]
   Front Right: 0 [0%] [0.00dB]
Simple mixer control 'Independent HP',0
   Capabilities: enum
   Items: 'Disabled' 'Enabled'
   Item0: 'Disabled'
Simple mixer control 'Internal Mic',0
   Capabilities: pvolume pswitch
   Playback channels: Front Left - Front Right
   Limits: Playback 0 - 31
   Mono:
   Front Left: Playback 31 [100%] [12.00dB] [off]
   Front Right: Playback 31 [100%] [12.00dB] [off]
Simple mixer control 'Internal Mic Boost',0
   Capabilities: volume
   Playback channels: Front Left - Front Right
   Capture channels: Front Left - Front Right
   Limits: 0 - 3
   Front Left: 0 [0%] [0.00dB]
   Front Right: 0 [0%] [0.00dB]

!!-------Mixer controls for card 4 [ThinkPadEC]

Card hw:4 'ThinkPadEC'/'ThinkPad Console Audio Control at EC reg 0x30, 
fw 7MHT25WW-1.03'
   Mixer name  : 'ThinkPad EC 7MHT25WW-1.03'
   Components  : ''
   Controls      : 1
   Simple ctrls  : 1
Simple mixer control 'Console',0
   Capabilities: pswitch pswitch-joined
   Playback channels: Mono
   Mono: Playback [on]


!!Alsactl output


--startcollapse--
state.Intel {
   control.1 {
     iface MIXER
     name 'Headphone Playback Volume'
     value.0 39
     value.1 39
     comment {
       access 'read write'
       type INTEGER
       count 2
       range '0 - 39'
       dbmin -5850
       dbmax 0
       dbvalue.0 0
       dbvalue.1 0
     }
   }
   control.2 {
     iface MIXER
     name 'Headphone Playback Switch'
     value.0 true
     value.1 true
     comment {
       access 'read write'
       type BOOLEAN
       count 2
     }
   }
   control.3 {
     iface MIXER
     name 'Speaker Playback Volume'
     value.0 0
     value.1 0
     comment {
       access 'read write'
       type INTEGER
       count 2
       range '0 - 39'
       dbmin -5850
       dbmax 0
       dbvalue.0 -5850
       dbvalue.1 -5850
     }
   }
   control.4 {
     iface MIXER
     name 'Speaker Playback Switch'
     value.0 false
     value.1 false
     comment {
       access 'read write'
       type BOOLEAN
       count 2
     }
   }
   control.5 {
     iface MIXER
     name 'Independent HP'
     value Disabled
     comment {
       access 'read write'
       type ENUMERATED
       count 1
       item.0 Disabled
       item.1 Enabled
     }
   }
   control.6 {
     iface MIXER
     name 'Internal Mic Playback Volume'
     value.0 31
     value.1 31
     comment {
       access 'read write'
       type INTEGER
       count 2
       range '0 - 31'
       dbmin -3450
       dbmax 1200
       dbvalue.0 1200
       dbvalue.1 1200
     }
   }
   control.7 {
     iface MIXER
     name 'Internal Mic Playback Switch'
     value.0 false
     value.1 false
     comment {
       access 'read write'
       type BOOLEAN
       count 2
     }
   }
   control.8 {
     iface MIXER
     name 'Dock Mic Playback Volume'
     value.0 0
     value.1 0
     comment {
       access 'read write'
       type INTEGER
       count 2
       range '0 - 31'
       dbmin -3450
       dbmax 1200
       dbvalue.0 -3450
       dbvalue.1 -3450
     }
   }
   control.9 {
     iface MIXER
     name 'Dock Mic Playback Switch'
     value.0 false
     value.1 false
     comment {
       access 'read write'
       type BOOLEAN
       count 2
     }
   }
   control.10 {
     iface MIXER
     name 'Mic Playback Volume'
     value.0 0
     value.1 0
     comment {
       access 'read write'
       type INTEGER
       count 2
       range '0 - 31'
       dbmin -3450
       dbmax 1200
       dbvalue.0 -3450
       dbvalue.1 -3450
     }
   }
   control.11 {
     iface MIXER
     name 'Mic Playback Switch'
     value.0 false
     value.1 false
     comment {
       access 'read write'
       type BOOLEAN
       count 2
     }
   }
   control.12 {
     iface MIXER
     name 'Auto-Mute Mode'
     value Enabled
     comment {
       access 'read write'
       type ENUMERATED
       count 1
       item.0 Disabled
       item.1 Enabled
     }
   }
   control.13 {
     iface MIXER
     name 'Capture Volume'
     value.0 40
     value.1 40
     comment {
       access 'read write'
       type INTEGER
       count 2
       range '0 - 54'
       dbmin -5850
       dbmax 2250
       dbvalue.0 150
       dbvalue.1 150
     }
   }
   control.14 {
     iface MIXER
     name 'Capture Switch'
     value.0 true
     value.1 true
     comment {
       access 'read write'
       type BOOLEAN
       count 2
     }
   }
   control.15 {
     iface MIXER
     name 'Internal Mic Boost Volume'
     value.0 0
     value.1 0
     comment {
       access 'read write'
       type INTEGER
       count 2
       range '0 - 3'
       dbmin 0
       dbmax 3000
       dbvalue.0 0
       dbvalue.1 0
     }
   }
   control.16 {
     iface MIXER
     name 'Dock Mic Boost Volume'
     value.0 0
     value.1 0
     comment {
       access 'read write'
       type INTEGER
       count 2
       range '0 - 3'
       dbmin 0
       dbmax 3000
       dbvalue.0 0
       dbvalue.1 0
     }
   }
   control.17 {
     iface MIXER
     name 'Mic Boost Volume'
     value.0 0
     value.1 0
     comment {
       access 'read write'
       type INTEGER
       count 2
       range '0 - 3'
       dbmin 0
       dbmax 3000
       dbvalue.0 0
       dbvalue.1 0
     }
   }
   control.18 {
     iface MIXER
     name 'Master Playback Volume'
     value 39
     comment {
       access 'read write'
       type INTEGER
       count 1
       range '0 - 39'
       dbmin -5850
       dbmax 0
       dbvalue.0 0
     }
   }
   control.19 {
     iface MIXER
     name 'Master Playback Switch'
     value true
     comment {
       access 'read write'
       type BOOLEAN
       count 1
     }
   }
   control.20 {
     iface CARD
     name 'Internal Mic Phantom Jack'
     value true
     comment {
       access read
       type BOOLEAN
       count 1
     }
   }
   control.21 {
     iface CARD
     name 'Dock Mic Jack'
     value false
     comment {
       access read
       type BOOLEAN
       count 1
     }
   }
   control.22 {
     iface CARD
     name 'Mic Jack'
     value false
     comment {
       access read
       type BOOLEAN
       count 1
     }
   }
   control.23 {
     iface CARD
     name 'Headphone Jack'
     value true
     comment {
       access read
       type BOOLEAN
       count 1
     }
   }
   control.24 {
     iface CARD
     name 'Speaker Phantom Jack'
     value true
     comment {
       access read
       type BOOLEAN
       count 1
     }
   }
   control.25 {
     iface MIXER
     name 'Beep Playback Volume'
     value 15
     comment {
       access 'read write'
       type INTEGER
       count 1
       range '0 - 15'
       dbmin -4500
       dbmax 0
       dbvalue.0 0
     }
   }
   control.26 {
     iface MIXER
     name 'Beep Playback Switch'
     value true
     comment {
       access 'read write'
       type BOOLEAN
       count 1
     }
   }
   control.27 {
     iface PCM
     name 'Playback Channel Map'
     value.0 0
     value.1 0
     comment {
       access read
       type INTEGER
       count 2
       range '0 - 36'
     }
   }
   control.28 {
     iface PCM
     name 'Capture Channel Map'
     value.0 0
     value.1 0
     comment {
       access read
       type INTEGER
       count 2
       range '0 - 36'
     }
   }
   control.29 {
     iface PCM
     device 2
     name 'Playback Channel Map'
     value.0 0
     value.1 0
     comment {
       access read
       type INTEGER
       count 2
       range '0 - 36'
     }
   }
   control.30 {
     iface MIXER
     name 'Digital Capture Volume'
     value.0 60
     value.1 60
     comment {
       access 'read write user'
       type INTEGER
       count 2
       range '0 - 120'
       tlv '0000000100000008fffff44800000032'
       dbmin -3000
       dbmax 3000
       dbvalue.0 0
       dbvalue.1 0
     }
   }
   control.31 {
     iface MIXER
     name 'PCM Playback Volume'
     value.0 255
     value.1 255
     comment {
       access 'read write user'
       type INTEGER
       count 2
       range '0 - 255'
       tlv '0000000100000008ffffec1400000014'
       dbmin -5100
       dbmax 0
       dbvalue.0 0
       dbvalue.1 0
     }
   }
}
state.ThinkPadEC {
   control.1 {
     iface MIXER
     name 'Console Playback Switch'
     value true
     comment {
       access read
       type BOOLEAN
       count 1
     }
   }
}
--endcollapse--


!!All Loaded Modules


Module
btrfs
raid6_pq
zlib_deflate
xor
ufs
qnx4
hfsplus
hfs
minix
ntfs
msdos
jfs
xfs
libcrc32c
nls_iso8859_1
ipt_MASQUERADE
iptable_nat
nf_nat_ipv4
nf_nat
nf_conntrack_ipv4
nf_defrag_ipv4
xt_conntrack
nf_conntrack
ipt_REJECT
xt_CHECKSUM
iptable_mangle
xt_tcpudp
bridge
stp
llc
ip6table_filter
ip6_tables
iptable_filter
ip_tables
ebtable_nat
ebtables
x_tables
bnep
rfcomm
bluetooth
binfmt_misc
snd_hda_codec_analog
dm_multipath
snd_hda_intel
arc4
snd_hda_codec
scsi_dh
snd_hwdep
snd_pcm
iwl4965
thinkpad_acpi
iwlegacy
mac80211
nvram
snd_page_alloc
snd_seq_midi
snd_seq_midi_event
cfg80211
coretemp
snd_rawmidi
kvm_intel
snd_seq
snd_seq_device
pcmcia
kvm
snd_timer
serio_raw
snd
parport_pc
soundcore
ppdev
yenta_socket
pcmcia_rsrc
pcmcia_core
lpc_ich
lp
mac_hid
parport
xts
gf128mul
dm_crypt
mmc_block
psmouse
sdhci_pci
sdhci
ahci
libahci
i915
i2c_algo_bit
drm_kms_helper
drm
e1000e
video
ptp
pps_core


!!Sysfs Files


/sys/class/sound/hwC0D0/init_pin_configs:
0x11 0x0421401f
0x12 0x90170110
0x13 0x511301f0
0x14 0x04a15021
0x15 0x90a7012e
0x16 0x593301f0
0x17 0x55a601f0
0x18 0x55a601f0
0x1a 0x91f311f0
0x1b 0x614411f0
0x1c 0x21a15020

/sys/class/sound/hwC0D0/driver_pin_configs:

/sys/class/sound/hwC0D0/user_pin_configs:

/sys/class/sound/hwC0D0/init_verbs:


!!ALSA/HDA dmesg


[   35.045988] ieee80211 phy0: Selected rate control algorithm 'iwl-4965-rs'
[   35.076727] hda_intel: probe_mask set to 0x1 for device 17aa:20ac
[   35.076782] snd_hda_intel 0000:00:1b.0: irq 46 for MSI/MSI-X
[   35.084674] device-mapper: multipath: version 1.5.1 loaded
--
[   35.496579]      Mic=0x14
[   35.504968] input: HDA Intel Headphone as 
/devices/pci0000:00/0000:00:1b.0/sound/card0/input7
[   35.505383] input: HDA Intel Mic as 
/devices/pci0000:00/0000:00:1b.0/sound/card0/input8
[   35.506228] input: HDA Intel Dock Mic as 
/devices/pci0000:00/0000:00:1b.0/sound/card0/input9
[   35.569962] pcmcia_socket pcmcia_socket0: cs: memory probe 
0x0c0000-0x0fffff:

---- ALSA info for 5ccc618fee67f0f0b2122dd4b32a02fd2b6a1569 END ----

I had do do diff between 5ccc618f and aa95d61b4 to fit 100k email limit.

---- ALSA info for aa95d61b43e0fcb0b2ce68e5efa37174fd9e5cd3 BEGIN ----
6c6
< !!Script ran on: Sun Jun  1 02:56:49 UTC 2014
---
 > !!Script ran on: Sun Jun  1 05:51:12 UTC 2014
26c26
< Kernel release:    3.10-rc7-359-g5ccc618-generic
---
 > Kernel release:    3.10-rc7-358-gaa95d61-generic
36c36
< Driver version:     k3.10-rc7-359-g5ccc618-generic
---
 > Driver version:     k3.10-rc7-358-gaa95d61-generic
60c60
<                       HDA Intel at 0xf8220000 irq 46
---
 >                       HDA Intel at 0xf8220000 irq 45
156c156
<   IO[0]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
---
 >   IO[0]: enable=0, dir=0, wake=0, sticky=0, data=1, unsol=0
160c160,167
<   Converter: stream=0, channel=0
---
 >   Control: name="IEC958 Playback Con Mask", index=0, device=0
 >   Control: name="IEC958 Playback Pro Mask", index=0, device=0
 >   Control: name="IEC958 Playback Default", index=0, device=0
 >   Control: name="IEC958 Playback Switch", index=0, device=0
 >   Control: name="IEC958 Default PCM Playback Switch", index=0, device=0
 >   Control: name="IEC958 Playback Source", index=0, device=0
 >   Device: name="AD198x Digital", type="SPDIF", device=1
 >   Converter: stream=8, channel=0
172,175d178
<   Control: name="Headphone Playback Volume", index=0, device=0
<     ControlAmp: chs=3, dir=Out, idx=0, ofs=0
<   Device: name="AD1984 Analog", type="Audio", device=0
<   Device: name="AD1984 Alt Analog", type="Audio", device=2
177c180
<   Amp-Out vals:  [0x27 0x27]
---
 >   Amp-Out vals:  [0x00 0x00]
182c185
<   Control: name="Speaker Playback Volume", index=0, device=0
---
 >   Control: name="PCM Playback Volume", index=0, device=0
183a187
 >   Device: name="AD198x Analog", type="Audio", device=0
185,186c189,190
<   Amp-Out vals:  [0x00 0x00]
<   Converter: stream=0, channel=0
---
 >   Amp-Out vals:  [0x27 0x27]
 >   Converter: stream=8, channel=0
209c213
<   Amp-In vals:  [0x00 0x00] [0x80 0x80]
---
 >   Amp-In vals:  [0x00 0x00] [0x00 0x00]
213c217
<   Device: name="AD1984 Analog", type="Audio", device=0
---
 >   Device: name="AD198x Analog", type="Audio", device=0
229c233
<   Amp-In vals:  [0x00 0x00] [0x80 0x80]
---
 >   Amp-In vals:  [0x00 0x00] [0x00 0x00]
241a246
 >   Control: name="Input Source", index=0, device=0
246a252,256
 >   Control: name="Capture Volume", index=1, device=0
 >     ControlAmp: chs=3, dir=Out, idx=0, ofs=0
 >   Control: name="Capture Switch", index=1, device=0
 >     ControlAmp: chs=3, dir=Out, idx=0, ofs=0
 >   Control: name="Input Source", index=1, device=0
253c263
<      0x03* 0x04
---
 >      0x03 0x04*
258c268
<   Control: name="Beep Playback Volume", index=0, device=0
---
 >   Control: name="Digital Beep Playback Volume", index=0, device=0
260c270
<   Control: name="Beep Playback Switch", index=0, device=0
---
 >   Control: name="Digital Beep Playback Switch", index=0, device=0
263c273
<   Amp-Out vals:  [0x0f]
---
 >   Amp-Out vals:  [0x8f]
267d276
<   Control: name="Headphone Jack", index=0, device=0
275c284
<   Unsolicited: tag=01, enabled=1
---
 >   Unsolicited: tag=00, enabled=0
281d289
<   Control: name="Speaker Phantom Jack", index=0, device=0
283c291
<   Amp-Out vals:  [0x80 0x80]
---
 >   Amp-Out vals:  [0x00 0x00]
285c293
<   EAPD 0x0:
---
 >   EAPD 0x2: EAPD
290c298
<   Pin-ctls: 0x40: OUT
---
 >   Pin-ctls: 0xc0: OUT HP
298c306
<   Amp-Out vals:  [0x9f]
---
 >   Amp-Out vals:  [0x80]
313d320
<   Control: name="Mic Jack", index=0, device=0
322c329
<   Unsolicited: tag=03, enabled=1
---
 >   Unsolicited: tag=00, enabled=0
326d332
<   Control: name="Internal Mic Phantom Jack", index=0, device=0
375a382,383
 >   Control: name="IEC958 Playback Volume", index=0, device=0
 >     ControlAmp: chs=3, dir=Out, idx=0, ofs=0
377c385
<   Amp-Out vals:  [0xa7 0xa7]
---
 >   Amp-Out vals:  [0x27 0x27]
387d394
<   Control: name="Dock Mic Jack", index=0, device=0
396c403
<   Unsolicited: tag=02, enabled=1
---
 >   Unsolicited: tag=00, enabled=0
404c411
<   Amp-In vals:  [0x80 0x80] [0x80 0x80]
---
 >   Amp-In vals:  [0x00 0x00] [0x00 0x00]
410a418,421
 >   Control: name="Mic Playback Volume", index=0, device=0
 >     ControlAmp: chs=3, dir=In, idx=0, ofs=0
 >   Control: name="Mic Playback Switch", index=0, device=0
 >     ControlAmp: chs=3, dir=In, idx=0, ofs=0
414a426,429
 >   Control: name="Beep Playback Volume", index=0, device=0
 >     ControlAmp: chs=3, dir=In, idx=3, ofs=0
 >   Control: name="Beep Playback Switch", index=0, device=0
 >     ControlAmp: chs=3, dir=In, idx=3, ofs=0
419,422d433
<   Control: name="Mic Playback Volume", index=0, device=0
<     ControlAmp: chs=3, dir=In, idx=0, ofs=0
<   Control: name="Mic Playback Switch", index=0, device=0
<     ControlAmp: chs=3, dir=In, idx=0, ofs=0
424c435
<   Amp-In vals:  [0x80 0x80] [0x9f 0x9f] [0x80 0x80] [0x80 0x80] [0x80 
0x80]
---
 >   Amp-In vals:  [0x80 0x80] [0x9f 0x9f] [0x80 0x80] [0x17 0x17] [0x80 
0x80]
429c440
<   Amp-Out vals:  [0x9f 0x9f]
---
 >   Amp-Out vals:  [0x1f 0x1f]
434c445
<      0x03* 0x04
---
 >      0x03 0x04*
459,466c470,477
< crw-rw----+ 1 root audio 116,  7 May 31 18:02 /dev/snd/controlC0
< crw-rw----+ 1 root audio 116,  2 May 31 18:02 /dev/snd/controlC4
< crw-rw----+ 1 root audio 116,  6 May 31 18:02 /dev/snd/hwC0D0
< crw-rw----+ 1 root audio 116,  5 May 31 18:07 /dev/snd/pcmC0D0c
< crw-rw----+ 1 root audio 116,  4 May 31 19:13 /dev/snd/pcmC0D0p
< crw-rw----+ 1 root audio 116,  3 May 31 18:02 /dev/snd/pcmC0D2p
< crw-rw----+ 1 root audio 116,  1 May 31 18:02 /dev/snd/seq
< crw-rw----+ 1 root audio 116, 33 May 31 18:02 /dev/snd/timer
---
 > crw-rw----+ 1 root audio 116,  7 May 31 22:39 /dev/snd/controlC0
 > crw-rw----+ 1 root audio 116,  2 May 31 22:39 /dev/snd/controlC4
 > crw-rw----+ 1 root audio 116,  6 May 31 22:39 /dev/snd/hwC0D0
 > crw-rw----+ 1 root audio 116,  5 May 31 22:44 /dev/snd/pcmC0D0c
 > crw-rw----+ 1 root audio 116,  4 May 31 22:44 /dev/snd/pcmC0D0p
 > crw-rw----+ 1 root audio 116,  3 May 31 22:44 /dev/snd/pcmC0D1p
 > crw-rw----+ 1 root audio 116,  1 May 31 22:39 /dev/snd/seq
 > crw-rw----+ 1 root audio 116, 33 May 31 22:39 /dev/snd/timer
470,473c481,484
< drwxr-xr-x 2 root root  80 May 31 18:02 .
< drwxr-xr-x 3 root root 220 May 31 18:02 ..
< lrwxrwxrwx 1 root root  12 May 31 18:02 pci-0000:00:1b.0 -> ../controlC0
< lrwxrwxrwx 1 root root  12 May 31 18:02 platform-thinkpad_acpi -> 
../controlC4
---
 > drwxr-xr-x 2 root root  80 May 31 22:39 .
 > drwxr-xr-x 3 root root 220 May 31 22:39 ..
 > lrwxrwxrwx 1 root root  12 May 31 22:39 pci-0000:00:1b.0 -> ../controlC0
 > lrwxrwxrwx 1 root root  12 May 31 22:39 platform-thinkpad_acpi -> 
../controlC4
482,483c493,494
< card 0: Intel [HDA Intel], device 0: AD1984 Analog [AD1984 Analog]
<   Subdevices: 1/1
---
 > card 0: Intel [HDA Intel], device 0: AD198x Analog [AD198x Analog]
 >   Subdevices: 0/1
485c496
< card 0: Intel [HDA Intel], device 2: AD1984 Alt Analog [AD1984 Alt Analog]
---
 > card 0: Intel [HDA Intel], device 1: AD198x Digital [AD198x Digital]
492,493c503,504
< card 0: Intel [HDA Intel], device 0: AD1984 Analog [AD1984 Analog]
<   Subdevices: 1/1
---
 > card 0: Intel [HDA Intel], device 0: AD198x Analog [AD198x Analog]
 >   Subdevices: 2/2
494a506
 >   Subdevice #1: subdevice #1
501c513
< Card hw:0 'Intel'/'HDA Intel at 0xf8220000 irq 46'
---
 > Card hw:0 'Intel'/'HDA Intel at 0xf8220000 irq 45'
504,505c516,517
<   Controls      : 31
<   Simple ctrls  : 15
---
 >   Controls      : 36
 >   Simple ctrls  : 20
512c524
<   Capabilities: pvolume pswitch
---
 >   Capabilities: pswitch
514d525
<   Limits: Playback 0 - 39
516,517c527,528
<   Front Left: Playback 39 [100%] [0.00dB] [on]
<   Front Right: Playback 39 [100%] [0.00dB] [on]
---
 >   Front Left: Playback [on]
 >   Front Right: Playback [on]
519c530
<   Capabilities: pvolume pswitch
---
 >   Capabilities: pswitch
521d531
<   Limits: Playback 0 - 39
523,524c533,534
<   Front Left: Playback 0 [0%] [-58.50dB] [off]
<   Front Right: Playback 0 [0%] [-58.50dB] [off]
---
 >   Front Left: Playback [on]
 >   Front Right: Playback [on]
528c538
<   Limits: Playback 0 - 255
---
 >   Limits: Playback 0 - 39
530,531c540,541
<   Front Left: Playback 255 [100%] [0.00dB]
<   Front Right: Playback 255 [100%] [0.00dB]
---
 >   Front Left: Playback 39 [100%] [0.00dB]
 >   Front Right: Playback 39 [100%] [0.00dB]
546,547c556,564
< Simple mixer control 'Beep',0
<   Capabilities: pvolume pvolume-joined pswitch pswitch-joined
---
 > Simple mixer control 'IEC958',0
 >   Capabilities: pvolume pswitch pswitch-joined
 >   Playback channels: Front Left - Front Right
 >   Limits: Playback 0 - 39
 >   Mono:
 >   Front Left: Playback 39 [100%] [0.00dB] [off]
 >   Front Right: Playback 39 [100%] [0.00dB] [off]
 > Simple mixer control 'IEC958 Default PCM',0
 >   Capabilities: pswitch pswitch-joined
549,550c566,577
<   Limits: Playback 0 - 15
<   Mono: Playback 15 [100%] [0.00dB] [on]
---
 >   Mono: Playback [on]
 > Simple mixer control 'IEC958 Playback Source',0
 >   Capabilities: enum
 >   Items: 'PCM' 'ADC'
 >   Item0: 'PCM'
 > Simple mixer control 'Beep',0
 >   Capabilities: pvolume pswitch
 >   Playback channels: Front Left - Front Right
 >   Limits: Playback 0 - 31
 >   Mono:
 >   Front Left: Playback 23 [74%] [0.00dB] [on]
 >   Front Right: Playback 23 [74%] [0.00dB] [on]
557,560c584,589
< Simple mixer control 'Auto-Mute Mode',0
<   Capabilities: enum
<   Items: 'Disabled' 'Enabled'
<   Item0: 'Enabled'
---
 > Simple mixer control 'Capture',1
 >   Capabilities: cvolume cswitch
 >   Capture channels: Front Left - Front Right
 >   Limits: Capture 0 - 54
 >   Front Left: Capture 39 [72%] [0.00dB] [off]
 >   Front Right: Capture 39 [72%] [0.00dB] [off]
566a596,600
 > Simple mixer control 'Digital Beep',0
 >   Capabilities: pvolume pvolume-joined pswitch pswitch-joined
 >   Playback channels: Mono
 >   Limits: Playback 0 - 15
 >   Mono: Playback 15 [100%] [0.00dB] [off]
581,584c615,622
< Simple mixer control 'Independent HP',0
<   Capabilities: enum
<   Items: 'Disabled' 'Enabled'
<   Item0: 'Disabled'
---
 > Simple mixer control 'Input Source',0
 >   Capabilities: cenum
 >   Items: 'Mic' 'Internal Mic' 'Mix' 'Dock Mic'
 >   Item0: 'Internal Mic'
 > Simple mixer control 'Input Source',1
 >   Capabilities: cenum
 >   Items: 'Mic' 'Internal Mic' 'Mix' 'Dock Mic'
 >   Item0: 'Mic'
620c658
<     name 'Headphone Playback Volume'
---
 >     name 'PCM Playback Volume'
647,649c685,687
<     name 'Speaker Playback Volume'
<     value.0 0
<     value.1 0
---
 >     name 'Speaker Playback Switch'
 >     value.0 true
 >     value.1 true
652c690
<       type INTEGER
---
 >       type BOOLEAN
654,658d691
<       range '0 - 39'
<       dbmin -5850
<       dbmax 0
<       dbvalue.0 -5850
<       dbvalue.1 -5850
663,665c696,698
<     name 'Speaker Playback Switch'
<     value.0 false
<     value.1 false
---
 >     name 'Mic Playback Volume'
 >     value.0 0
 >     value.1 0
668c701
<       type BOOLEAN
---
 >       type INTEGER
669a703,707
 >       range '0 - 31'
 >       dbmin -3450
 >       dbmax 1200
 >       dbvalue.0 -3450
 >       dbvalue.1 -3450
674,675c712,714
<     name 'Independent HP'
<     value Disabled
---
 >     name 'Mic Playback Switch'
 >     value.0 false
 >     value.1 false
678,681c717,718
<       type ENUMERATED
<       count 1
<       item.0 Disabled
<       item.1 Enabled
---
 >       type BOOLEAN
 >       count 2
713,715c750,752
<     name 'Dock Mic Playback Volume'
<     value.0 0
<     value.1 0
---
 >     name 'Beep Playback Volume'
 >     value.0 23
 >     value.1 23
723,724c760,761
<       dbvalue.0 -3450
<       dbvalue.1 -3450
---
 >       dbvalue.0 0
 >       dbvalue.1 0
729,731c766,768
<     name 'Dock Mic Playback Switch'
<     value.0 false
<     value.1 false
---
 >     name 'Beep Playback Switch'
 >     value.0 true
 >     value.1 true
740c777
<     name 'Mic Playback Volume'
---
 >     name 'Dock Mic Playback Volume'
756c793
<     name 'Mic Playback Switch'
---
 >     name 'Dock Mic Playback Switch'
767,768c804,806
<     name 'Auto-Mute Mode'
<     value Enabled
---
 >     name 'Mic Boost Volume'
 >     value.0 0
 >     value.1 0
771,774c809,815
<       type ENUMERATED
<       count 1
<       item.0 Disabled
<       item.1 Enabled
---
 >       type INTEGER
 >       count 2
 >       range '0 - 3'
 >       dbmin 0
 >       dbmax 3000
 >       dbvalue.0 0
 >       dbvalue.1 0
778a820,851
 >     name 'Internal Mic Boost Volume'
 >     value.0 0
 >     value.1 0
 >     comment {
 >       access 'read write'
 >       type INTEGER
 >       count 2
 >       range '0 - 3'
 >       dbmin 0
 >       dbmax 3000
 >       dbvalue.0 0
 >       dbvalue.1 0
 >     }
 >   }
 >   control.14 {
 >     iface MIXER
 >     name 'Dock Mic Boost Volume'
 >     value.0 0
 >     value.1 0
 >     comment {
 >       access 'read write'
 >       type INTEGER
 >       count 2
 >       range '0 - 3'
 >       dbmin 0
 >       dbmax 3000
 >       dbvalue.0 0
 >       dbvalue.1 0
 >     }
 >   }
 >   control.15 {
 >     iface MIXER
793c866
<   control.14 {
---
 >   control.16 {
804c877
<   control.15 {
---
 >   control.17 {
806,808c879,882
<     name 'Internal Mic Boost Volume'
<     value.0 0
<     value.1 0
---
 >     name 'Capture Volume'
 >     index 1
 >     value.0 39
 >     value.1 39
813,815c887,889
<       range '0 - 3'
<       dbmin 0
<       dbmax 3000
---
 >       range '0 - 54'
 >       dbmin -5850
 >       dbmax 2250
820c894
<   control.16 {
---
 >   control.18 {
822,824c896,899
<     name 'Dock Mic Boost Volume'
<     value.0 0
<     value.1 0
---
 >     name 'Capture Switch'
 >     index 1
 >     value.0 false
 >     value.1 false
827c902
<       type INTEGER
---
 >       type BOOLEAN
829,833d903
<       range '0 - 3'
<       dbmin 0
<       dbmax 3000
<       dbvalue.0 0
<       dbvalue.1 0
836c906
<   control.17 {
---
 >   control.19 {
838,840c908,909
<     name 'Mic Boost Volume'
<     value.0 0
<     value.1 0
---
 >     name 'Input Source'
 >     value 'Internal Mic'
843,849c912,917
<       type INTEGER
<       count 2
<       range '0 - 3'
<       dbmin 0
<       dbmax 3000
<       dbvalue.0 0
<       dbvalue.1 0
---
 >       type ENUMERATED
 >       count 1
 >       item.0 Mic
 >       item.1 'Internal Mic'
 >       item.2 Mix
 >       item.3 'Dock Mic'
852c920
<   control.18 {
---
 >   control.20 {
854,855c922,924
<     name 'Master Playback Volume'
<     value 39
---
 >     name 'Input Source'
 >     index 1
 >     value Mic
858c927
<       type INTEGER
---
 >       type ENUMERATED
859a929,943
 >       item.0 Mic
 >       item.1 'Internal Mic'
 >       item.2 Mix
 >       item.3 'Dock Mic'
 >     }
 >   }
 >   control.21 {
 >     iface MIXER
 >     name 'IEC958 Playback Volume'
 >     value.0 39
 >     value.1 39
 >     comment {
 >       access 'read write'
 >       type INTEGER
 >       count 2
863a948
 >       dbvalue.1 0
866c951
<   control.19 {
---
 >   control.22 {
868,869c953,954
<     name 'Master Playback Switch'
<     value true
---
 >     name 'IEC958 Playback Source'
 >     value PCM
872c957
<       type BOOLEAN
---
 >       type ENUMERATED
873a959,960
 >       item.0 PCM
 >       item.1 ADC
876,879c963,966
<   control.20 {
<     iface CARD
<     name 'Internal Mic Phantom Jack'
<     value true
---
 >   control.23 {
 >     iface MIXER
 >     name 'IEC958 Playback Con Mask'
 >     value 
'0fff000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
882c969
<       type BOOLEAN
---
 >       type IEC958
886,889c973,976
<   control.21 {
<     iface CARD
<     name 'Dock Mic Jack'
<     value false
---
 >   control.24 {
 >     iface MIXER
 >     name 'IEC958 Playback Pro Mask'
 >     value 
'0f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
892c979
<       type BOOLEAN
---
 >       type IEC958
896,899c983,986
<   control.22 {
<     iface CARD
<     name 'Mic Jack'
<     value false
---
 >   control.25 {
 >     iface MIXER
 >     name 'IEC958 Playback Default'
 >     value 
'0400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
901,902c988,989
<       access read
<       type BOOLEAN
---
 >       access 'read write'
 >       type IEC958
906,909c993,996
<   control.23 {
<     iface CARD
<     name 'Headphone Jack'
<     value true
---
 >   control.26 {
 >     iface MIXER
 >     name 'IEC958 Playback Switch'
 >     value false
911c998
<       access read
---
 >       access 'read write'
916,918c1003,1005
<   control.24 {
<     iface CARD
<     name 'Speaker Phantom Jack'
---
 >   control.27 {
 >     iface MIXER
 >     name 'IEC958 Default PCM Playback Switch'
921c1008
<       access read
---
 >       access 'read write'
926c1013
<   control.25 {
---
 >   control.28 {
928c1015
<     name 'Beep Playback Volume'
---
 >     name 'Digital Beep Playback Volume'
940c1027
<   control.26 {
---
 >   control.29 {
942c1029,1053
<     name 'Beep Playback Switch'
---
 >     name 'Digital Beep Playback Switch'
 >     value false
 >     comment {
 >       access 'read write'
 >       type BOOLEAN
 >       count 1
 >     }
 >   }
 >   control.30 {
 >     iface MIXER
 >     name 'Master Playback Volume'
 >     value 39
 >     comment {
 >       access 'read write'
 >       type INTEGER
 >       count 1
 >       range '0 - 39'
 >       dbmin -5850
 >       dbmax 0
 >       dbvalue.0 0
 >     }
 >   }
 >   control.31 {
 >     iface MIXER
 >     name 'Master Playback Switch'
950c1061
<   control.27 {
---
 >   control.32 {
952a1064,1075
 >     value.0 3
 >     value.1 4
 >     comment {
 >       access read
 >       type INTEGER
 >       count 2
 >       range '0 - 36'
 >     }
 >   }
 >   control.33 {
 >     iface PCM
 >     name 'Capture Channel Map'
962c1085
<   control.28 {
---
 >   control.34 {
964a1088
 >     index 1
974c1098
<   control.29 {
---
 >   control.35 {
976c1100
<     device 2
---
 >     device 1
987c1111
<   control.30 {
---
 >   control.36 {
1004,1020d1127
<   control.31 {
<     iface MIXER
<     name 'PCM Playback Volume'
<     value.0 255
<     value.1 255
<     comment {
<       access 'read write user'
<       type INTEGER
<       count 2
<       range '0 - 255'
<       tlv '0000000100000008ffffec1400000014'
<       dbmin -5100
<       dbmax 0
<       dbvalue.0 0
<       dbvalue.1 0
<     }
<   }
1041,1054d1147
< btrfs
< raid6_pq
< zlib_deflate
< xor
< ufs
< qnx4
< hfsplus
< hfs
< minix
< ntfs
< msdos
< jfs
< xfs
< libcrc32c
1078d1170
< bnep
1079a1172
 > bnep
1082c1175
< snd_hda_codec_analog
---
 > arc4
1083a1177,1182
 > snd_hda_codec_analog
 > iwl4965
 > scsi_dh
 > iwlegacy
 > mac80211
 > coretemp
1085c1184
< arc4
---
 > cfg80211
1087c1186,1187
< scsi_dh
---
 > kvm_intel
 > kvm
1089,1090d1188
< snd_pcm
< iwl4965
1092,1094c1190
< iwlegacy
< mac80211
< nvram
---
 > snd_pcm
1095a1192,1193
 > nvram
 > pcmcia
1098,1099d1195
< cfg80211
< coretemp
1101c1197
< kvm_intel
---
 > serio_raw
1102a1199
 > yenta_socket
1104,1105c1201
< pcmcia
< kvm
---
 > pcmcia_rsrc
1107c1203,1204
< serio_raw
---
 > lpc_ich
 > pcmcia_core
1109d1205
< parport_pc
1110a1207,1208
 > parport_pc
 > mac_hid
1112,1115d1209
< yenta_socket
< pcmcia_rsrc
< pcmcia_core
< lpc_ich
1117d1210
< mac_hid
1123,1127d1215
< psmouse
< sdhci_pci
< sdhci
< ahci
< libahci
1128a1217,1219
 > e1000e
 > ahci
 > psmouse
1130a1222
 > libahci
1132,1133c1224,1225
< e1000e
< video
---
 > sdhci_pci
 > sdhci
1135a1228
 > video
1164,1173c1257,1260
< [   35.045988] ieee80211 phy0: Selected rate control algorithm 
'iwl-4965-rs'
< [   35.076727] hda_intel: probe_mask set to 0x1 for device 17aa:20ac
< [   35.076782] snd_hda_intel 0000:00:1b.0: irq 46 for MSI/MSI-X
< [   35.084674] device-mapper: multipath: version 1.5.1 loaded
< --
< [   35.496579]      Mic=0x14
< [   35.504968] input: HDA Intel Headphone as 
/devices/pci0000:00/0000:00:1b.0/sound/card0/input7
< [   35.505383] input: HDA Intel Mic as 
/devices/pci0000:00/0000:00:1b.0/sound/card0/input8
< [   35.506228] input: HDA Intel Dock Mic as 
/devices/pci0000:00/0000:00:1b.0/sound/card0/input9
< [   35.569962] pcmcia_socket pcmcia_socket0: cs: memory probe 
0x0c0000-0x0fffff:
---
 > [   38.133419] cfg80211: Calling CRDA to update world regulatory domain
 > [   38.179214] hda_intel: probe_mask set to 0x1 for device 17aa:20ac
 > [   38.179301] snd_hda_intel 0000:00:1b.0: irq 45 for MSI/MSI-X
 > [   38.531005] EXT4-fs (sda3): mounted filesystem with ordered data 
mode. Opts: (null)

---- ALSA info for aa95d61b43e0fcb0b2ce68e5efa37174fd9e5cd3 END ----

---- ALSA info for latest daily upstream BEGIN ----
6c6
< !!Script ran on: Sun Jun  1 02:56:49 UTC 2014
---
 > !!Script ran on: Sun Jun  1 06:36:37 UTC 2014
26c26
< Kernel release:    3.10-rc7-359-g5ccc618-generic
---
 > Kernel release:    3.15.0-999-generic
36c36
< Driver version:     k3.10-rc7-359-g5ccc618-generic
---
 > Driver version:     k3.15.0-999-generic
61c61
<  4 [ThinkPadEC     ]: ThinkPad EC - ThinkPad Console Audio Control
---
 > 29 [ThinkPadEC     ]: ThinkPad EC - ThinkPad Console Audio Control
109c109
<     power_save : 1
---
 >     power_save : 0
127d126
<     hotkey_report_mode : 0
156c155
<   IO[0]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
---
 >   IO[0]: enable=0, dir=0, wake=0, sticky=0, data=1, unsol=0
185c184
<   Amp-Out vals:  [0x00 0x00]
---
 >   Amp-Out vals:  [0x27 0x27]
209c208
<   Amp-In vals:  [0x00 0x00] [0x80 0x80]
---
 >   Amp-In vals:  [0x00 0x00] [0x00 0x00]
229c228
<   Amp-In vals:  [0x00 0x00] [0x80 0x80]
---
 >   Amp-In vals:  [0x00 0x00] [0x00 0x00]
245c244
<      0x14 0x15* 0x16 0x20 0x25
---
 >      0x14* 0x15 0x16 0x20 0x25
258,261d256
<   Control: name="Beep Playback Volume", index=0, device=0
<     ControlAmp: chs=1, dir=Out, idx=0, ofs=0
<   Control: name="Beep Playback Switch", index=0, device=0
<     ControlAmp: chs=1, dir=Out, idx=0, ofs=0
263c258
<   Amp-Out vals:  [0x0f]
---
 >   Amp-Out vals:  [0x8f]
283c278
<   Amp-Out vals:  [0x80 0x80]
---
 >   Amp-Out vals:  [0x00 0x00]
285c280
<   EAPD 0x0:
---
 >   EAPD 0x2: EAPD
422a418,421
 >   Control: name="Beep Playback Volume", index=0, device=0
 >     ControlAmp: chs=3, dir=In, idx=3, ofs=0
 >   Control: name="Beep Playback Switch", index=0, device=0
 >     ControlAmp: chs=3, dir=In, idx=3, ofs=0
424c423
<   Amp-In vals:  [0x80 0x80] [0x9f 0x9f] [0x80 0x80] [0x80 0x80] [0x80 
0x80]
---
 >   Amp-In vals:  [0x80 0x80] [0x9f 0x9f] [0x80 0x80] [0x17 0x17] [0x80 
0x80]
429c428
<   Amp-Out vals:  [0x9f 0x9f]
---
 >   Amp-Out vals:  [0x1f 0x1f]
459,466c458,465
< crw-rw----+ 1 root audio 116,  7 May 31 18:02 /dev/snd/controlC0
< crw-rw----+ 1 root audio 116,  2 May 31 18:02 /dev/snd/controlC4
< crw-rw----+ 1 root audio 116,  6 May 31 18:02 /dev/snd/hwC0D0
< crw-rw----+ 1 root audio 116,  5 May 31 18:07 /dev/snd/pcmC0D0c
< crw-rw----+ 1 root audio 116,  4 May 31 19:13 /dev/snd/pcmC0D0p
< crw-rw----+ 1 root audio 116,  3 May 31 18:02 /dev/snd/pcmC0D2p
< crw-rw----+ 1 root audio 116,  1 May 31 18:02 /dev/snd/seq
< crw-rw----+ 1 root audio 116, 33 May 31 18:02 /dev/snd/timer
---
 > crw-rw----+ 1 root audio 116,  3 May 31 23:24 /dev/snd/controlC0
 > crw-rw----+ 1 root audio 116,  2 May 31 23:24 /dev/snd/controlC29
 > crw-rw----+ 1 root audio 116,  7 May 31 23:24 /dev/snd/hwC0D0
 > crw-rw----+ 1 root audio 116,  5 May 31 23:32 /dev/snd/pcmC0D0c
 > crw-rw----+ 1 root audio 116,  4 May 31 23:31 /dev/snd/pcmC0D0p
 > crw-rw----+ 1 root audio 116,  6 May 31 23:24 /dev/snd/pcmC0D2p
 > crw-rw----+ 1 root audio 116,  1 May 31 23:24 /dev/snd/seq
 > crw-rw----+ 1 root audio 116, 33 May 31 23:24 /dev/snd/timer
470,473c469,472
< drwxr-xr-x 2 root root  80 May 31 18:02 .
< drwxr-xr-x 3 root root 220 May 31 18:02 ..
< lrwxrwxrwx 1 root root  12 May 31 18:02 pci-0000:00:1b.0 -> ../controlC0
< lrwxrwxrwx 1 root root  12 May 31 18:02 platform-thinkpad_acpi -> 
../controlC4
---
 > drwxr-xr-x 2 root root  80 May 31 23:24 .
 > drwxr-xr-x 3 root root 220 May 31 23:24 ..
 > lrwxrwxrwx 1 root root  12 May 31 23:24 pci-0000:00:1b.0 -> ../controlC0
 > lrwxrwxrwx 1 root root  13 May 31 23:24 platform-thinkpad_acpi -> 
../controlC29
523,524c522,523
<   Front Left: Playback 0 [0%] [-58.50dB] [off]
<   Front Right: Playback 0 [0%] [-58.50dB] [off]
---
 >   Front Left: Playback 39 [100%] [0.00dB] [on]
 >   Front Right: Playback 39 [100%] [0.00dB] [on]
547,550c546,551
<   Capabilities: pvolume pvolume-joined pswitch pswitch-joined
<   Playback channels: Mono
<   Limits: Playback 0 - 15
<   Mono: Playback 15 [100%] [0.00dB] [on]
---
 >   Capabilities: pvolume pswitch
 >   Playback channels: Front Left - Front Right
 >   Limits: Playback 0 - 31
 >   Mono:
 >   Front Left: Playback 23 [74%] [0.00dB] [on]
 >   Front Right: Playback 23 [74%] [0.00dB] [on]
600c601
< !!-------Mixer controls for card 4 [ThinkPadEC]
---
 > !!-------Mixer controls for card 29 [ThinkPadEC]
602c603
< Card hw:4 'ThinkPadEC'/'ThinkPad Console Audio Control at EC reg 0x30, 
fw 7MHT25WW-1.03'
---
 > Card hw:29 'ThinkPadEC'/'ThinkPad Console Audio Control at EC reg 
0x30, fw 7MHT25WW-1.03'
648,649c649,650
<         value.0 0
<         value.1 0
---
 >         value.0 39
 >         value.1 39
657,658c658,659
<             dbvalue.0 -5850
<             dbvalue.1 -5850
---
 >             dbvalue.0 0
 >             dbvalue.1 0
664,665c665,666
<         value.0 false
<         value.1 false
---
 >         value.0 true
 >         value.1 true
899c900
<         value false
---
 >         value true
909c910
<         value true
---
 >         value false
929c930,931
<         value 15
---
 >         value.0 23
 >         value.1 23
933,936c935,938
<             count 1
<             range '0 - 15'
<             dbmin -4500
<             dbmax 0
---
 >             count 2
 >             range '0 - 31'
 >             dbmin -3450
 >             dbmax 1200
937a940
 >             dbvalue.1 0
943c946,947
<         value true
---
 >         value.0 true
 >         value.1 true
947c951
<             count 1
---
 >             count 2
1041,1054c1045,1046
< btrfs
< raid6_pq
< zlib_deflate
< xor
< ufs
< qnx4
< hfsplus
< hfs
< minix
< ntfs
< msdos
< jfs
< xfs
< libcrc32c
---
 > ctr
 > ccm
1078d1069
< bnep
1079a1071
 > bnep
1080a1073
 > 6lowpan_iphc
1083c1076
< dm_multipath
---
 > snd_hda_codec_generic
1085c1078
< arc4
---
 > snd_hda_controller
1087d1079
< scsi_dh
1089,1090d1080
< snd_pcm
< iwl4965
1092,1093c1082,1084
< iwlegacy
< mac80211
---
 > dm_multipath
 > coretemp
 > snd_pcm
1095c1086,1087
< snd_page_alloc
---
 > kvm_intel
 > scsi_dh
1096a1089,1090
 > arc4
 > kvm
1098,1099c1092,1094
< cfg80211
< coretemp
---
 > iwl4965
 > iwlegacy
 > mac80211
1101d1095
< kvm_intel
1102a1097
 > cfg80211
1105d1099
< kvm
1107c1101
< serio_raw
---
 > microcode
1109,1111c1103
< parport_pc
< soundcore
< ppdev
---
 > serio_raw
1112a1105,1106
 > soundcore
 > mac_hid
1114c1108
< pcmcia_core
---
 > ppdev
1115a1110,1111
 > pcmcia_core
 > parport_pc
1117d1112
< mac_hid
1123,1125d1117
< psmouse
< sdhci_pci
< sdhci
1126a1119,1120
 > sdhci_pci
 > psmouse
1127a1122
 > sdhci
1128a1124
 > video
1129a1126
 > e1000e
1132,1133d1128
< e1000e
< video
1164,1167c1159,1162
< [   35.045988] ieee80211 phy0: Selected rate control algorithm 
'iwl-4965-rs'
< [   35.076727] hda_intel: probe_mask set to 0x1 for device 17aa:20ac
< [   35.076782] snd_hda_intel 0000:00:1b.0: irq 46 for MSI/MSI-X
< [   35.084674] device-mapper: multipath: version 1.5.1 loaded
---
 > [   43.432228] input: ThinkPad Extra Buttons as 
/devices/platform/thinkpad_acpi/input/input7
 > [   43.624371] snd_hda_intel 0000:00:1b.0: probe_mask set to 0x1 for 
device 17aa:20ac
 > [   43.624479] snd_hda_intel 0000:00:1b.0: irq 46 for MSI/MSI-X
 > [   43.800655] systemd-udevd[578]: renamed network interface wlan0 to 
wlan2
1169,1173c1164,1176
< [   35.496579]      Mic=0x14
< [   35.504968] input: HDA Intel Headphone as 
/devices/pci0000:00/0000:00:1b.0/sound/card0/input7
< [   35.505383] input: HDA Intel Mic as 
/devices/pci0000:00/0000:00:1b.0/sound/card0/input8
< [   35.506228] input: HDA Intel Dock Mic as 
/devices/pci0000:00/0000:00:1b.0/sound/card0/input9
< [   35.569962] pcmcia_socket pcmcia_socket0: cs: memory probe 
0x0c0000-0x0fffff:
---
 > [   44.022500] cfg80211:   (5735000 KHz - 5835000 KHz @ 40000 KHz), 
(300 mBi, 2000 mBm), (N/A)
 > [   44.101116] sound hdaudioC0D0: autoconfig: line_outs=1 
(0x12/0x0/0x0/0x0/0x0) type:speaker
 > [   44.101123] sound hdaudioC0D0:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
 > [   44.101127] sound hdaudioC0D0:    hp_outs=1 (0x11/0x0/0x0/0x0/0x0)
 > [   44.101130] sound hdaudioC0D0:    mono: mono_out=0x0
 > [   44.101133] sound hdaudioC0D0:    inputs:
 > [   44.101137] sound hdaudioC0D0:      Internal Mic=0x15
 > [   44.101140] sound hdaudioC0D0:      Dock Mic=0x1c
 > [   44.101144] sound hdaudioC0D0:      Mic=0x14
 > [   44.112515] input: HDA Intel Dock Mic as 
/devices/pci0000:00/0000:00:1b.0/sound/card0/input8
 > [   44.112657] input: HDA Intel Mic as 
/devices/pci0000:00/0000:00:1b.0/sound/card0/input9
 > [   44.112794] input: HDA Intel Headphone as 
/devices/pci0000:00/0000:00:1b.0/sound/card0/input10
 > [   45.815258] init: failsafe main process (883) killed by TERM signal

---- ALSA info for latest daily upstream END ----
