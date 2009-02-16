From: Brendan Minish <bminish@minish.org>
Subject: Possible bug with ICE1712 driver
Date: Mon, 16 Feb 2009 15:16:16 +0000
Message-ID: <1234797376.4179.14.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-qjAPSvwQtcJ/b+2OwAIy"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ns1.westnet.ie (ns1.westnet.ie [88.81.100.2])
	by alsa0.perex.cz (Postfix) with ESMTP id 9CBCD1037EA
	for <alsa-devel@alsa-project.org>; Mon, 16 Feb 2009 16:16:26 +0100 (CET)
Received: from brenbox.westnet.ie (brenbox.westnet.ie [88.81.100.130])
	by ns1.westnet.ie (8.13.8/8.13.8) with ESMTP id n1GFGNBB015133
	for <alsa-devel@alsa-project.org>; Mon, 16 Feb 2009 15:16:25 GMT
Received: from [192.168.0.10] (redbox [192.168.0.10])
	by brenbox.westnet.ie (8.13.8/8.13.8) with ESMTP id n1GFGHKu030876
	for <alsa-devel@alsa-project.org>; Mon, 16 Feb 2009 15:16:23 GMT
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


--=-qjAPSvwQtcJ/b+2OwAIy
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hello 
the driver for my M-Audio Delta66, snd_ice1712 fails when my machine
resumes from suspend. I get no audio out and software accessing the the
audio device appears to either hang or work normally (but with no
output) 

I can always get sound working again by removing and reinserting the
kernel module snd_ice1712 after the machine resumes
if the ice1712 driver is compiled into the kernel then sound fails after
resume and there appears to be no way to get it working again  

Platform Linux Intel x86_64  (core 2 E6700 )
Distro Fedora 
Custom kernel ver 2.6.27.12 
issue also observed on distro kernel -2.6.27.12-170.2.5.fc10.x86_64
  

Attached dmesg output for suspend, resume and reprobing of snd_ice1712
Attached lspci output 
Attached lsmod output 
Anything else I should capture to help debug this ? 
Is this the right place to file this ?

thanks for the help
regards
Brendan Minish 

--=-qjAPSvwQtcJ/b+2OwAIy
Content-Disposition: attachment; filename="dmesg1.txt"
Content-Type: text/plain; name="dmesg1.txt"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

CPU0 attaching NULL sched-domain.
CPU1 attaching NULL sched-domain.
CPU0 attaching sched-domain:
 domain 0: span 0-1 level MC
  groups: 0 1
  domain 1: span 0-1 level NODE
   groups: 0-1
CPU1 attaching sched-domain:
 domain 0: span 0-1 level MC
  groups: 1 0
  domain 1: span 0-1 level NODE
   groups: 0-1
PM: Syncing filesystems ... done.
PM: Preparing system for mem sleep
Freezing user space processes ... (elapsed 0.00 seconds) done.
Freezing remaining freezable tasks ... (elapsed 0.00 seconds) done.
PM: Entering mem sleep
Suspending console(s) (use no_console_suspend to debug)
sd 3:0:0:0: [sdd] Synchronizing SCSI cache
sd 3:0:0:0: [sdd] Stopping disk
sd 2:0:0:0: [sdc] Synchronizing SCSI cache
sd 2:0:0:0: [sdc] Stopping disk
sd 1:0:0:0: [sdb] Synchronizing SCSI cache
sd 1:0:0:0: [sdb] Stopping disk
sd 0:0:0:0: [sda] Synchronizing SCSI cache
sd 0:0:0:0: [sda] Stopping disk
serial 00:0a: disabled
parport_pc 00:08: disabled
ACPI handle has no context!
e1000e 0000:03:00.0: PME# enabled
e1000e 0000:03:00.0: PME# enabled
e1000e 0000:03:00.0: PCI INT A disabled
ACPI handle has no context!
ACPI handle has no context!
NVRM: RmPowerManagement: 4
ahci 0000:00:1f.2: PCI INT B disabled
ata6: port disabled. ignoring.
ata_piix 0000:00:1f.1: PCI INT A disabled
ehci_hcd 0000:00:1d.7: PCI INT A disabled
uhci_hcd 0000:00:1d.3: PCI INT D disabled
uhci_hcd 0000:00:1d.2: PCI INT C disabled
uhci_hcd 0000:00:1d.1: PCI INT B disabled
uhci_hcd 0000:00:1d.0: PCI INT A disabled
ACPI: Preparing to enter system sleep state S3
Disabling non-boot CPUs ...
CPU 1 is now offline
SMP alternatives: switching to UP code
CPU0 attaching NULL sched-domain.
CPU1 attaching NULL sched-domain.
CPU0 attaching NULL sched-domain.
CPU1 is down
x86 PAT enabled: cpu 0, old 0x7040600070406, new 0x7010600070106
Back to C!
pcieport-driver 0000:00:01.0: restoring config space at offset 0xf (was 0x100, writing 0x1801ff)
pcieport-driver 0000:00:01.0: restoring config space at offset 0xa (was 0xf, writing 0x0)
pcieport-driver 0000:00:01.0: restoring config space at offset 0x9 (was 0x1fff1, writing 0xdff1d001)
pcieport-driver 0000:00:01.0: restoring config space at offset 0x8 (was 0xfff0, writing 0xe1f0e000)
pcieport-driver 0000:00:01.0: restoring config space at offset 0x7 (was 0xf0, writing 0x20003030)
pcieport-driver 0000:00:01.0: restoring config space at offset 0x6 (was 0x100, writing 0x10100)
pcieport-driver 0000:00:01.0: restoring config space at offset 0x3 (was 0x10000, writing 0x10010)
pcieport-driver 0000:00:01.0: restoring config space at offset 0x1 (was 0x100000, writing 0x100007)
pcieport-driver 0000:00:1c.0: restoring config space at offset 0xf (was 0x100, writing 0x401ff)
pcieport-driver 0000:00:1c.0: restoring config space at offset 0x9 (was 0x10001, writing 0x1fff1)
pcieport-driver 0000:00:1c.0: restoring config space at offset 0x8 (was 0x0, writing 0xfff0)
pcieport-driver 0000:00:1c.0: restoring config space at offset 0x7 (was 0x0, writing 0xf0)
pcieport-driver 0000:00:1c.0: restoring config space at offset 0x6 (was 0x200, writing 0x20200)
pcieport-driver 0000:00:1c.0: restoring config space at offset 0x3 (was 0x810000, writing 0x810010)
pcieport-driver 0000:00:1c.0: restoring config space at offset 0x1 (was 0x100000, writing 0x100007)
pcieport-driver 0000:00:1c.5: restoring config space at offset 0xf (was 0x200, writing 0x402ff)
pcieport-driver 0000:00:1c.5: restoring config space at offset 0x9 (was 0x10001, writing 0x1fff1)
pcieport-driver 0000:00:1c.5: restoring config space at offset 0x8 (was 0x0, writing 0xe210e210)
pcieport-driver 0000:00:1c.5: restoring config space at offset 0x7 (was 0x0, writing 0x2020)
pcieport-driver 0000:00:1c.5: restoring config space at offset 0x6 (was 0x300, writing 0x30300)
pcieport-driver 0000:00:1c.5: restoring config space at offset 0x3 (was 0x810000, writing 0x810010)
pcieport-driver 0000:00:1c.5: restoring config space at offset 0x1 (was 0x100000, writing 0x100007)
pci 0000:00:1e.0: restoring config space at offset 0xf (was 0x0, writing 0x400ff)
pci 0000:00:1e.0: restoring config space at offset 0x9 (was 0x10001, writing 0x1fff1)
pci 0000:00:1e.0: restoring config space at offset 0x8 (was 0x0, writing 0xe200e200)
pci 0000:00:1e.0: restoring config space at offset 0x7 (was 0x228000f0, writing 0x22801010)
pci 0000:00:1e.0: restoring config space at offset 0x1 (was 0x100107, writing 0x100007)
pci 0000:00:1f.0: restoring config space at offset 0x1 (was 0x2100107, writing 0x2100007)
ICE1712 0000:04:02.0: restoring config space at offset 0xf (was 0x1ff, writing 0x109)
ICE1712 0000:04:02.0: restoring config space at offset 0x7 (was 0x1, writing 0x1001)
ICE1712 0000:04:02.0: restoring config space at offset 0x6 (was 0x1, writing 0x1061)
ICE1712 0000:04:02.0: restoring config space at offset 0x5 (was 0x1, writing 0x1071)
ICE1712 0000:04:02.0: restoring config space at offset 0x4 (was 0x1, writing 0x1041)
ICE1712 0000:04:02.0: restoring config space at offset 0x3 (was 0x0, writing 0x2000)
ICE1712 0000:04:02.0: restoring config space at offset 0x1 (was 0x2100000, writing 0x2100005)
Enabling non-boot CPUs ...
SMP alternatives: switching to SMP code
Booting processor 1/1 ip 6000
Initializing CPU#1
Calibrating delay using timer specific routine.. 5333.50 BogoMIPS (lpj=2666753)
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 4096K
CPU 1/1 -> Node 0
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 1
x86 PAT enabled: cpu 1, old 0x7040600070406, new 0x7010600070106
CPU1: Intel(R) Core(TM)2 CPU          6700  @ 2.66GHz stepping 06
checking TSC synchronization [CPU#0 -> CPU#1]: passed.
CPU0 attaching NULL sched-domain.
Switched to high resolution mode on CPU 1
CPU0 attaching sched-domain:
 domain 0: span 0-1 level MC
  groups: 0 1
  domain 1: span 0-1 level NODE
   groups: 0-1
CPU1 attaching sched-domain:
 domain 0: span 0-1 level MC
  groups: 1 0
  domain 1: span 0-1 level NODE
   groups: 0-1
CPU1 is up
ACPI: Waking up from system sleep state S3
pcieport-driver 0000:00:01.0: setting latency timer to 64
pcieport-driver 0000:00:1c.0: setting latency timer to 64
pcieport-driver 0000:00:1c.5: setting latency timer to 64
uhci_hcd 0000:00:1d.0: enabling device (0000 -> 0001)
uhci_hcd 0000:00:1d.0: PCI INT A -> GSI 23 (level, low) -> IRQ 23
uhci_hcd 0000:00:1d.0: setting latency timer to 64
uhci_hcd 0000:00:1d.0: restoring config space at offset 0xf (was 0x100, writing 0x10a)
uhci_hcd 0000:00:1d.0: restoring config space at offset 0x8 (was 0x1, writing 0x4081)
usb usb2: root hub lost power or was reset
uhci_hcd 0000:00:1d.1: enabling device (0000 -> 0001)
uhci_hcd 0000:00:1d.1: PCI INT B -> GSI 19 (level, low) -> IRQ 19
uhci_hcd 0000:00:1d.1: setting latency timer to 64
uhci_hcd 0000:00:1d.1: restoring config space at offset 0xf (was 0x200, writing 0x20b)
uhci_hcd 0000:00:1d.1: restoring config space at offset 0x8 (was 0x1, writing 0x4061)
usb usb3: root hub lost power or was reset
uhci_hcd 0000:00:1d.2: enabling device (0000 -> 0001)
uhci_hcd 0000:00:1d.2: PCI INT C -> GSI 18 (level, low) -> IRQ 18
uhci_hcd 0000:00:1d.2: setting latency timer to 64
uhci_hcd 0000:00:1d.2: restoring config space at offset 0xf (was 0x300, writing 0x309)
uhci_hcd 0000:00:1d.2: restoring config space at offset 0x8 (was 0x1, writing 0x4041)
usb usb4: root hub lost power or was reset
uhci_hcd 0000:00:1d.3: enabling device (0000 -> 0001)
uhci_hcd 0000:00:1d.3: PCI INT D -> GSI 16 (level, low) -> IRQ 16
uhci_hcd 0000:00:1d.3: setting latency timer to 64
uhci_hcd 0000:00:1d.3: restoring config space at offset 0xf (was 0x400, writing 0x40b)
uhci_hcd 0000:00:1d.3: restoring config space at offset 0x8 (was 0x1, writing 0x4021)
usb usb5: root hub lost power or was reset
ehci_hcd 0000:00:1d.7: PCI INT A -> GSI 23 (level, low) -> IRQ 23
ehci_hcd 0000:00:1d.7: setting latency timer to 64
pci 0000:00:1e.0: setting latency timer to 64
ata_piix 0000:00:1f.1: restoring config space at offset 0xf (was 0x100, writing 0x109)
ata_piix 0000:00:1f.1: restoring config space at offset 0x8 (was 0xffa1, writing 0x40b1)
ata_piix 0000:00:1f.1: restoring config space at offset 0x1 (was 0x2800005, writing 0x2880005)
ata_piix 0000:00:1f.1: PCI INT A -> GSI 18 (level, low) -> IRQ 18
ata_piix 0000:00:1f.1: setting latency timer to 64
ata6: port disabled. ignoring.
ahci 0000:00:1f.2: restoring config space at offset 0xf (was 0x200, writing 0x20b)
ahci 0000:00:1f.2: restoring config space at offset 0x8 (was 0x1, writing 0x40a1)
ahci 0000:00:1f.2: restoring config space at offset 0x7 (was 0x1, writing 0x40e1)
ahci 0000:00:1f.2: restoring config space at offset 0x6 (was 0x1, writing 0x40c1)
ahci 0000:00:1f.2: restoring config space at offset 0x5 (was 0x1, writing 0x40e5)
ahci 0000:00:1f.2: restoring config space at offset 0x4 (was 0x1, writing 0x40c9)
ahci 0000:00:1f.2: restoring config space at offset 0x1 (was 0x2b00000, writing 0x2b00007)
ahci 0000:00:1f.2: PCI INT B -> GSI 19 (level, low) -> IRQ 19
ahci 0000:00:1f.2: setting latency timer to 64
i801_smbus 0000:00:1f.3: restoring config space at offset 0xf (was 0x200, writing 0x20b)
i801_smbus 0000:00:1f.3: restoring config space at offset 0x8 (was 0xefa1, writing 0x4001)
NVRM: RmPowerManagement: 5
ata5.00: ACPI cmd ef/03:0c:00:00:00:a0 filtered out
ata5.00: ACPI cmd ef/03:42:00:00:00:a0 filtered out
ata5.00: ACPI cmd f5/00:00:00:00:00:a0 filtered out
ata5.00: configured for UDMA/33
e1000e 0000:03:00.0: restoring config space at offset 0xf (was 0x100, writing 0x109)
e1000e 0000:03:00.0: restoring config space at offset 0x6 (was 0x1, writing 0x2001)
e1000e 0000:03:00.0: restoring config space at offset 0x4 (was 0x0, writing 0xe2100000)
e1000e 0000:03:00.0: restoring config space at offset 0x1 (was 0x100000, writing 0x100007)
e1000e 0000:03:00.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
e1000e 0000:03:00.0: setting latency timer to 64
e1000e 0000:03:00.0: PME# disabled
e1000e 0000:03:00.0: PME# disabled
ICE1712 0000:04:02.0: PCI INT A -> GSI 18 (level, low) -> IRQ 18
firewire_ohci 0000:04:04.0: restoring config space at offset 0xf (was 0x4020100, writing 0x4020109)
firewire_ohci 0000:04:04.0: restoring config space at offset 0x5 (was 0x0, writing 0xe2000000)
firewire_ohci 0000:04:04.0: restoring config space at offset 0x3 (was 0x0, writing 0x2010)
firewire_ohci 0000:04:04.0: restoring config space at offset 0x1 (was 0x2100000, writing 0x2100016)
firewire_core: skipped bus generations, destroying all nodes
parport_pc 00:08: activated
serial 00:0a: activated
sd 0:0:0:0: [sda] Starting disk
firewire_core: created device fw0: GUID 0090270001c17edf, S400
0000:03:00.0: eth0: Link is Up 1000 Mbps Full Duplex, Flow Control: RX/TX
ata4: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata4.00: configured for UDMA/133
sd 3:0:0:0: [sdd] 1465149168 512-byte hardware sectors (750156 MB)
sd 3:0:0:0: [sdd] Write Protect is off
sd 3:0:0:0: [sdd] Mode Sense: 00 3a 00 00
sd 3:0:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
ata2.00: configured for UDMA/133
sd 1:0:0:0: [sdb] 1465149168 512-byte hardware sectors (750156 MB)
sd 1:0:0:0: [sdb] Write Protect is off
sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1: link is slow to respond, please be patient (ready=0)
ata3.00: configured for UDMA/133
sd 2:0:0:0: [sdc] 1465149168 512-byte hardware sectors (750156 MB)
sd 2:0:0:0: [sdc] Write Protect is off
sd 2:0:0:0: [sdc] Mode Sense: 00 3a 00 00
sd 2:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.00: configured for UDMA/133
sd 0:0:0:0: [sda] 1465149168 512-byte hardware sectors (750156 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 1:0:0:0: [sdb] Starting disk
sd 2:0:0:0: [sdc] Starting disk
sd 3:0:0:0: [sdd] Starting disk
usb 2-2: reset full speed USB device using uhci_hcd and address 2
PM: Finishing wakeup.
Restarting tasks ... done.
CPU0 attaching NULL sched-domain.
CPU1 attaching NULL sched-domain.
CPU0 attaching sched-domain:
 domain 0: span 0-1 level MC
  groups: 0 1
  domain 1: span 0-1 level NODE
   groups: 0-1
CPU1 attaching sched-domain:
 domain 0: span 0-1 level MC
  groups: 1 0
  domain 1: span 0-1 level NODE
   groups: 0-1
ICE1712 0000:04:02.0: PCI INT A disabled
ICE1712 0000:04:02.0: PCI INT A -> GSI 18 (level, low) -> IRQ 18
ice1712: Using board model M Audio Delta 66
ALSA sound/core/pcm_lib.c:154: BUG: stream = 1, pos = 0x1138, buffer size = 0x1138, period size = 0x44e

--=-qjAPSvwQtcJ/b+2OwAIy
Content-Disposition: attachment; filename="lspci.txt"
Content-Type: text/plain; name="lspci.txt"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

00:00.0 Host bridge: Intel Corporation 82975X Memory Controller Hub
00:01.0 PCI bridge: Intel Corporation 82975X PCI Express Root Port
00:1c.0 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express Port 1 (rev 01)
00:1c.5 PCI bridge: Intel Corporation 82801GR/GH/GHM (ICH7 Family) PCI Express Port 6 (rev 01)
00:1d.0 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI Controller #1 (rev 01)
00:1d.1 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI Controller #2 (rev 01)
00:1d.2 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI Controller #3 (rev 01)
00:1d.3 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI Controller #4 (rev 01)
00:1d.7 USB Controller: Intel Corporation 82801G (ICH7 Family) USB2 EHCI Controller (rev 01)
00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev e1)
00:1f.0 ISA bridge: Intel Corporation 82801GH (ICH7DH) LPC Interface Bridge (rev 01)
00:1f.1 IDE interface: Intel Corporation 82801G (ICH7 Family) IDE Controller (rev 01)
00:1f.2 SATA controller: Intel Corporation 82801GR/GH (ICH7 Family) SATA AHCI Controller (rev 01)
00:1f.3 SMBus: Intel Corporation 82801G (ICH7 Family) SMBus Controller (rev 01)
01:00.0 VGA compatible controller: nVidia Corporation G70 [GeForce 7600 GS] (rev a1)
03:00.0 Ethernet controller: Intel Corporation 82573L Gigabit Ethernet Controller
04:02.0 Multimedia audio controller: VIA Technologies Inc. ICE1712 [Envy24] PCI Multi-Channel I/O Controller (rev 02)
04:04.0 FireWire (IEEE 1394): Texas Instruments TSB43AB23 IEEE-1394a-2000 Controller (PHY/Link)

--=-qjAPSvwQtcJ/b+2OwAIy
Content-Disposition: attachment; filename="lsmod.txt"
Content-Type: text/plain; name="lsmod.txt"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Module                  Size  Used by
snd_ice1712            62292  0 
nfs                   250848  1 
lockd                  64416  1 nfs
nfs_acl                 3520  1 nfs
fuse                   52032  2 
autofs4                20488  3 
coretemp                7168  0 
hwmon                   3256  1 coretemp
sunrpc                182248  11 nfs,lockd,nfs_acl
ip6t_REJECT             4544  2 
nf_conntrack_ipv6      15176  2 
ip6table_filter         3520  1 
ip6_tables             18512  1 ip6table_filter
ipv6                  278952  50 ip6t_REJECT,nf_conntrack_ipv6
cpufreq_ondemand        7824  2 
acpi_cpufreq            9552  0 
freq_table              5248  2 cpufreq_ondemand,acpi_cpufreq
dm_multipath           16088  0 
raid1                  22400  1 
uinput                  8384  0 
nvidia               8101600  26 
snd_ice17xx_ak4xxx      4160  1 snd_ice1712
snd_ak4xxx_adda         8832  2 snd_ice1712,snd_ice17xx_ak4xxx
snd_cs8427              8704  1 snd_ice1712
snd_ac97_codec        113160  1 snd_ice1712
snd_seq_dummy           3716  0 
snd_seq_oss            31424  0 
snd_seq_midi_event      7232  1 snd_seq_oss
snd_seq                54160  5 snd_seq_dummy,snd_seq_oss,snd_seq_midi_event
snd_pcm_oss            44288  0 
snd_mixer_oss          15552  1 snd_pcm_oss
snd_pcm                77320  3 snd_ice1712,snd_ac97_codec,snd_pcm_oss
snd_timer              22032  2 snd_seq,snd_pcm
snd_page_alloc          8976  1 snd_pcm
ac97_bus                2432  1 snd_ac97_codec
snd_i2c                 5824  2 snd_ice1712,snd_cs8427
snd_mpu401_uart         8256  1 snd_ice1712
ppdev                   8072  0 
snd_rawmidi            22592  1 snd_mpu401_uart
snd_seq_device          7700  4 snd_seq_dummy,snd_seq_oss,snd_seq,snd_rawmidi
pcspkr                  3328  0 
snd                    60984  16 snd_ice1712,snd_ice17xx_ak4xxx,snd_ak4xxx_adda,snd_cs8427,snd_ac97_codec,snd_seq_dummy,snd_seq_oss,snd_seq,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_timer,snd_i2c,snd_mpu401_uart,snd_rawmidi,snd_seq_device
usb_storage           100960  0 
soundcore               7184  1 snd
firewire_ohci          22788  0 
parport_pc             26392  0 
e1000e                111984  0 
i2c_i801               10012  0 
i2c_core               21536  2 nvidia,i2c_i801
firewire_core          37888  1 firewire_ohci
i82975x_edac            5384  0 
edac_core              40704  1 i82975x_edac
parport                34656  2 ppdev,parport_pc
floppy                 58408  0 
crc_itu_t               2624  1 firewire_core
raid456               123432  1 
async_xor               4032  1 raid456
async_memcpy            2816  1 raid456
async_tx                7596  3 raid456,async_xor,async_memcpy
xor                     5776  2 raid456,async_xor
ext4                  210800  6 
jbd2                   63752  1 ext4
crc16                   2496  1 ext4

--=-qjAPSvwQtcJ/b+2OwAIy
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--=-qjAPSvwQtcJ/b+2OwAIy--
