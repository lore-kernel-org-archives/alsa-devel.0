From: Peter Zubaj <pzubaj@gaya.sk>
Subject: Re: PROBLEM: Probable kernel bug in VT8233 drivers
Date: Thu, 04 Jan 2007 19:52:11 +0100
Message-ID: <1167936731.4321.2.camel@localhost.localdomain>
References: <200701041332.46215.abrahams@acm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from arkady.gaya.sk (arkady.gaya.sk [62.168.75.2])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 6B02F240
	for <alsa-devel@alsa-project.org>; Thu,  4 Jan 2007 19:49:59 +0100 (MET)
In-Reply-To: <200701041332.46215.abrahams@acm.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: abrahams@acm.org
Cc: alsa-devel@alsa-project.org, perex@suse.cz
List-Id: alsa-devel@alsa-project.org

Hi,

Try to modprobe driver manually and then use dmesg - it will tell you
what is wrong.

Also check /proc/asound/cards file if there is listed your card -
sometimes is modem first card.

>From list of loaded modules looks, like snd_via82xx is already loaded.

Peter Zubaj

On Thu, 2007-01-04 at 13:32 -0500, Paul Abrahams wrote:
> 1.Probable kernel bug in most recent VT8233 drivers
> 
> 2. Until my most recent kernel update, sound was working on my system.  I'm 
> running Opensuse 10.2.  Now when I reboot I get a message that no sound 
> drivers are available.  When I attempt to reinstall the sound card via Yast,
> I get the message:
> 
> K7VT2 mobo
> The kernel module snd-via82xx for sound support could not be loaded.  This can 
> be caused by incorrect module parameters, including invalid IO or IRQ 
> parameters.
> 
> 3. Keywords: ALSA, Via82xx, sound, kernel
> 
> 4. Kernel version:
> Linux version 2.6.18.2-34-default (geeko@buildhost) (gcc version 4.1.2 
> 20061115 (prerelease) (SUSE Linux)) #1 SMP Mon Nov 27 11:46:27 UTC 2006
> 
> 5. Version prior to Nov. 27, I believe.
> 
> 6. N/A
> 
> 7. N/A
> 
> 8.1 Version info:
> 
> pwa@suillus:/usr/src/linux> /usr/src/linux-2.6.18.2-34/scripts/ver_linux
> If some fields are empty or look unusual you may have an old version.
> Compare to the current minimal requirements in Documentation/Changes.
> 
> Linux suillus 2.6.18.2-34-default #1 SMP Mon Nov 27 11:46:27 UTC 2006 i686 
> athlon i386 GNU/Linux
> 
> Gnu C                  4.1.2
> Gnu make               3.81
> binutils               2.17.50.0.5
> util-linux             2.12r
> mount                  2.12r
> module-init-tools      3.2.2
> e2fsprogs              1.39
> jfsutils               1.1.11
> reiserfsprogs          3.6.19
> xfsprogs               2.8.11
> PPP                    2.4.4
> Linux C Library        > libc.2.5
> Dynamic linker (ldd)   2.5
> Procps                 3.2.7
> Net-tools              1.60
> Kbd                    1.12
> Sh-utils               6.4
> udev                   103
> Modules Loaded         xt_pkttype ipt_LOG xt_limit nfsd exportfs lockd nfs_acl 
> sunrpc it87 hwmon_vid hwmon eeprom i2c_isa snd_pcm_oss snd_mixer_oss 
> snd_seq_midi snd_seq_midi_event snd_seq af_packet button battery ac 
> ip6t_REJECT xt_tcpudp ipt_REJECT xt_state iptable_mangle iptable_nat ip_nat 
> iptable_filter ip6table_mangle ip_conntrack nfnetlink ip_tables 
> ip6table_filter ip6_tables x_tables ipv6 reiserfs nls_cp437 vfat fat 
> nls_iso8859_1 ntfs loop dm_mod ns558 snd_mpu401 via_rhine mii snd_via82xx 
> gameport snd_ac97_codec snd_ac97_bus snd_pcm snd_timer snd_page_alloc 
> snd_mpu401_uart snd_rawmidi snd_seq_device snd soundcore i2c_viapro i2c_core 
> ehci_hcd ide_cd cdrom via_ircc shpchp pci_hotplug irda uhci_hcd via_agp 
> usbcore agpgart crc_ccitt parport_pc lp parport ext3 mbcache jbd edd fan 
> via82cxxx sg sym53c8xx scsi_transport_spi pdc202xx_old thermal processor 
> sd_mod scsi_mod ide_disk ide_core
> 
> 8.2 Processor: 
> 
> pwa@suillus:/usr/src/linux> /usr/src/linux-2.6.18.2-34/scripts/ver_linux
> If some fields are empty or look unusual you may have an old version.
> Compare to the current minimal requirements in Documentation/Changes.
> 
> Linux suillus 2.6.18.2-34-default #1 SMP Mon Nov 27 11:46:27 UTC 2006 i686 
> athlon i386 GNU/Linux
> 
> Gnu C                  4.1.2
> Gnu make               3.81
> binutils               2.17.50.0.5
> util-linux             2.12r
> mount                  2.12r
> module-init-tools      3.2.2
> e2fsprogs              1.39
> jfsutils               1.1.11
> reiserfsprogs          3.6.19
> xfsprogs               2.8.11
> PPP                    2.4.4
> Linux C Library        > libc.2.5
> Dynamic linker (ldd)   2.5
> Procps                 3.2.7
> Net-tools              1.60
> Kbd                    1.12
> Sh-utils               6.4
> udev                   103
> Modules Loaded         xt_pkttype ipt_LOG xt_limit nfsd exportfs lockd nfs_acl 
> sunrpc it87 hwmon_vid hwmon eeprom i2c_isa snd_pcm_oss snd_mixer_oss 
> snd_seq_midi snd_seq_midi_event snd_seq af_packet button battery ac 
> ip6t_REJECT xt_tcpudp ipt_REJECT xt_state iptable_mangle iptable_nat ip_nat 
> iptable_filter ip6table_mangle ip_conntrack nfnetlink ip_tables 
> ip6table_filter ip6_tables x_tables ipv6 reiserfs nls_cp437 vfat fat 
> nls_iso8859_1 ntfs loop dm_mod ns558 snd_mpu401 via_rhine mii snd_via82xx 
> gameport snd_ac97_codec snd_ac97_bus snd_pcm snd_timer snd_page_alloc 
> snd_mpu401_uart snd_rawmidi snd_seq_device snd soundcore i2c_viapro i2c_core 
> ehci_hcd ide_cd cdrom via_ircc shpchp pci_hotplug irda uhci_hcd via_agp 
> usbcore agpgart crc_ccitt parport_pc lp parport ext3 mbcache jbd edd fan 
> via82cxxx sg sym53c8xx scsi_transport_spi pdc202xx_old thermal processor 
> sd_mod scsi_mod ide_disk ide_core
> 
> 8.3 Module info:
> 
> t_pkttype 6016 4 - Live 0xe1468000
> ipt_LOG 10624 10 - Live 0xe1448000
> xt_limit 6912 10 - Live 0xe144c000
> nfsd 220976 9 - Live 0xe14f1000
> exportfs 9856 1 nfsd, Live 0xe1444000
> lockd 73064 2 nfsd, Live 0xe147c000
> nfs_acl 7808 1 nfsd, Live 0xe1441000
> sunrpc 156604 9 nfsd,lockd,nfs_acl, Live 0xe1491000
> it87 24228 0 - Live 0xe145e000
> hwmon_vid 6784 1 it87, Live 0xe143e000
> hwmon 7428 1 it87, Live 0xe13e8000
> eeprom 11152 0 - Live 0xe13d5000
> i2c_isa 9344 1 it87, Live 0xe13d9000
> snd_pcm_oss 53376 0 - Live 0xe144f000
> snd_mixer_oss 21248 1 snd_pcm_oss, Live 0xe13dd000
> snd_seq_midi 13824 0 - Live 0xe13c2000
> snd_seq_midi_event 11520 1 snd_seq_midi, Live 0xe13c7000
> snd_seq 60272 2 snd_seq_midi,snd_seq_midi_event, Live 0xe142e000
> af_packet 29320 0 - Live 0xe13cc000
> button 10896 0 - Live 0xe13a8000
> battery 14340 0 - Live 0xe13bd000
> ac 9476 0 - Live 0xe13b3000
> ip6t_REJECT 9344 3 - Live 0xe13af000
> xt_tcpudp 7296 6 - Live 0xe13ac000
> ipt_REJECT 9472 3 - Live 0xe13a4000
> xt_state 6272 14 - Live 0xe13a1000
> iptable_mangle 7040 0 - Live 0xe139e000
> iptable_nat 11524 0 - Live 0xe11bb000
> ip_nat 21804 1 iptable_nat, Live 0xe123a000
> iptable_filter 7168 1 - Live 0xe121b000
> ip6table_mangle 6528 0 - Live 0xe11bf000
> ip_conntrack 52960 3 xt_state,iptable_nat,ip_nat, Live 0xe122c000
> nfnetlink 11032 2 ip_nat,ip_conntrack, Live 0xe118b000
> ip_tables 17604 3 iptable_mangle,iptable_nat,iptable_filter, Live 0xe1215000
> ip6table_filter 7040 1 - Live 0xe1195000
> ip6_tables 18756 2 ip6table_mangle,ip6table_filter, Live 0xe120f000
> x_tables 18180 10 
> xt_pkttype,ipt_LOG,xt_limit,ip6t_REJECT,xt_tcpudp,ipt_REJECT,xt_state,iptable_nat,ip_tables,ip6_tables, 
> Live 0xe11c2000
> ipv6 263584 36 ip6t_REJECT, Live 0xe13ec000
> reiserfs 237312 2 - Live 0xe1241000
> nls_cp437 9984 2 - Live 0xe116a000
> vfat 16640 2 - Live 0xe118f000
> fat 55324 1 vfat, Live 0xe119a000
> nls_iso8859_1 8320 3 - Live 0xe1166000
> ntfs 210580 0 - Live 0xe11c8000
> loop 20488 0 - Live 0xe116e000
> dm_mod 60184 0 - Live 0xe1179000
> ns558 8960 0 - Live 0xe0f16000
> snd_mpu401 12712 0 - Live 0xe1062000
> via_rhine 28680 0 - Live 0xe1067000
> mii 9600 1 via_rhine, Live 0xe1059000
> snd_via82xx 32920 0 - Live 0xe100f000
> gameport 19464 3 ns558,snd_via82xx, Live 0xe1053000
> snd_ac97_codec 95648 1 snd_via82xx, Live 0xe1021000
> snd_ac97_bus 6400 1 snd_ac97_codec, Live 0xe0ff0000
> snd_pcm 86916 3 snd_pcm_oss,snd_via82xx,snd_ac97_codec, Live 0xe103c000
> snd_timer 27908 2 snd_seq,snd_pcm, Live 0xe1019000
> snd_page_alloc 14472 2 snd_via82xx,snd_pcm, Live 0xe0f9e000
> snd_mpu401_uart 13056 2 snd_mpu401,snd_via82xx, Live 0xe0feb000
> snd_rawmidi 29824 2 snd_seq_midi,snd_mpu401_uart, Live 0xe0ff5000
> snd_seq_device 12812 3 snd_seq_midi,snd_seq,snd_rawmidi, Live 0xe0fa3000
> snd 61188 12 
> snd_pcm_oss,snd_mixer_oss,snd_seq_midi,snd_seq,snd_mpu401,snd_via82xx,snd_ac97_codec,snd_pcm,snd_timer,snd_mpu401_uart,snd_rawmidi,snd_seq_device, 
> Live 0xe0fff000
> soundcore 13792 1 snd, Live 0xe0f02000
> i2c_viapro 12308 0 - Live 0xe0f11000
> i2c_core 25216 4 it87,eeprom,i2c_isa,i2c_viapro, Live 0xe0f96000
> ehci_hcd 34696 0 - Live 0xe0fe1000
> ide_cd 42272 0 - Live 0xe0fd5000
> cdrom 38432 1 ide_cd, Live 0xe0fca000
> via_ircc 24980 0 - Live 0xe0f59000
> shpchp 40224 0 - Live 0xe0f7f000
> pci_hotplug 35136 1 shpchp, Live 0xe0f8c000
> irda 132152 1 via_ircc, Live 0xe0fa8000
> uhci_hcd 26892 0 - Live 0xe0f51000
> via_agp 14080 1 - Live 0xe0efb000
> usbcore 114896 2 ehci_hcd,uhci_hcd, Live 0xe0f61000
> agpgart 35528 1 via_agp, Live 0xe0f07000
> crc_ccitt 6272 1 irda, Live 0xe0e9d000
> parport_pc 42084 1 - Live 0xe0ecf000
> lp 15652 0 - Live 0xe0eca000
> parport 39752 2 parport_pc,lp, Live 0xe0ef0000
> ext3 141192 4 - Live 0xe0f1a000
> mbcache 12804 1 ext3, Live 0xe0ec5000
> jbd 70324 1 ext3, Live 0xe0edd000
> edd 13892 0 - Live 0xe0e87000
> fan 8964 0 - Live 0xe0e99000
> via82cxxx 12804 0 [permanent], Live 0xe0e8c000
> sg 38044 0 - Live 0xe0ea6000
> sym53c8xx 75540 1 - Live 0xe0eb1000
> scsi_transport_spi 28672 1 sym53c8xx, Live 0xe0e91000
> pdc202xx_old 14208 0 [permanent], Live 0xe082c000
> thermal 18568 0 - Live 0xe0e81000
> processor 34664 1 thermal, Live 0xe0832000
> sd_mod 24576 1 - Live 0xe0819000
> scsi_mod 136712 4 sg,sym53c8xx,scsi_transport_spi,sd_mod, Live 0xe085d000
> ide_disk 20480 10 - Live 0xe0820000
> ide_core 129992 4 ide_cd,via82cxxx,pdc202xx_old,ide_disk, Live 0xe083c000
> 
> 8.4 Driver/hardware:
> 
> 0000-001f : dma1
> 0020-0021 : pic1
> 0040-0043 : timer0
> 0050-0053 : timer1
> 0060-006f : keyboard
> 0070-0077 : rtc
> 0080-008f : dma page reg
> 00a0-00a1 : pic2
> 00c0-00df : dma2
> 00f0-00ff : fpu
> 0170-0177 : ide3
> 01f0-01f7 : ide2
> 0201-0201 : ns558-pnp
> 0290-0297 : it87-isa
> 02f8-02ff : serial
> 0330-0331 : MPU401 UART
> 0376-0376 : ide3
> 0378-037a : parport0
> 037b-037f : parport0
> 03c0-03df : vesafb
> 03f2-03f5 : floppy
> 03f6-03f6 : ide2
> 03f7-03f7 : floppy DIR
> 03f8-03ff : serial
> 0cf8-0cff : PCI conf1
> 4000-407f : 0000:00:11.0
>   4000-407f : motherboard
>     4000-4003 : ACPI PM1a_EVT_BLK
>     4008-400b : ACPI PM_TMR
>     4010-4015 : ACPI CPU throttle
>     4020-4023 : ACPI GPE0_BLK
> 40f0-40f1 : ACPI PM1a_CNT_BLK
> 5000-500f : 0000:00:11.0
>   5000-500f : motherboard
>     5000-500f : pnp 00:02
>       5000-5007 : vt596_smbus
> a000-afff : PCI Bus #01
>   a000-a0ff : 0000:01:00.0
> b000-b007 : 0000:00:08.0
>   b000-b007 : ide0
> b400-b403 : 0000:00:08.0
>   b402-b402 : ide0
> b800-b807 : 0000:00:08.0
> bc00-bc03 : 0000:00:08.0
> c000-c03f : 0000:00:08.0
>   c000-c007 : ide0
>   c008-c00f : ide1
>   c010-c03f : PDC20267
> c400-c4ff : 0000:00:09.0
>   c400-c4ff : sym53c8xx
> c800-c83f : 0000:00:0b.0
> cc00-cc1f : 0000:00:10.0
>   cc00-cc1f : uhci_hcd
> d000-d01f : 0000:00:10.1
>   d000-d01f : uhci_hcd
> d400-d41f : 0000:00:10.2
>   d400-d41f : uhci_hcd
> d800-d80f : 0000:00:11.1
>   d800-d807 : ide2
>   d808-d80f : ide3
> dc00-dcff : 0000:00:11.5
>   dc00-dcff : VIA8233
> e000-e0ff : 0000:00:12.0
>   e000-e0ff : via-rhine
> 00000000-0009e7ff : System RAM
>   00000000-00000000 : Crash kernel
> 0009e800-0009ffff : reserved
> 000a0000-000bffff : Video RAM area
> 000c0000-000cbfff : Video ROM
> 000cc000-000ce7ff : Adapter ROM
> 000cf000-000cf1ff : Adapter ROM
> 000f0000-000fffff : System ROM
> 00100000-1ffeffff : System RAM
>   00100000-002a8585 : Kernel code
>   002a8586-0039a7b7 : Kernel data
> 1fff0000-1fff2fff : ACPI Non-volatile Storage
> 1fff3000-1fffffff : ACPI Tables
> 30000000-3000ffff : 0000:00:08.0
> 30010000-3001ffff : 0000:00:09.0
> e0000000-e7ffffff : PCI Bus #01
>   e0000000-e7ffffff : 0000:01:00.0
>     e0000000-e3ffffff : vesafb
> e8000000-ebffffff : 0000:00:00.0
> ec000000-edffffff : PCI Bus #01
>   ec000000-ec01ffff : 0000:01:00.0
>   ed000000-ed00ffff : 0000:01:00.0
> ef000000-ef01ffff : 0000:00:08.0
> ef020000-ef0200ff : 0000:00:09.0
>   ef020000-ef0200ff : sym53c8xx
> ef021000-ef021fff : 0000:00:09.0
>   ef021000-ef021fff : sym53c8xx
> ef022000-ef0220ff : 0000:00:10.3
>   ef022000-ef0220ff : ehci_hcd
> ef023000-ef0230ff : 0000:00:12.0
>   ef023000-ef0230ff : via-rhine
> fec00000-fec00fff : reserved
> fee00000-fee00fff : reserved
> ffff0000-ffffffff : reserved
> 
> 8.5 PCI info:
> 
> 00:00.0 Host bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo KT266/A/333]
>         Subsystem: VIA Technologies, Inc. VT8366/A/7 [Apollo KT266/A/333]
>         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
> Stepping- SERR- FastB2B-
>         Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
> <TAbort- <MAbort+ >SERR- <PERR-
>         Latency: 0
>         Region 0: Memory at e8000000 (32-bit, prefetchable) [size=64M]
>         Capabilities: [a0] AGP version 2.0
>                 Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 
> 64bit- FW- AGP3- Rate=x1,x2,x4
>                 Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- 
> Rate=<none>
>         Capabilities: [c0] Power Management version 2
>                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> 
> 00:01.0 PCI bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo KT266/A/333 AGP] 
> (prog-if 00 [Normal decode])
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
> Stepping- SERR- FastB2B-
>         Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
> <TAbort- <MAbort+ >SERR- <PERR-
>         Latency: 0
>         Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
>         I/O behind bridge: 0000a000-0000afff
>         Memory behind bridge: ec000000-edffffff
>         Prefetchable memory behind bridge: e0000000-e7ffffff
>         Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- 
> <TAbort- <MAbort- <SERR- <PERR-
>         BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
>         Capabilities: [80] Power Management version 2
>                 Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA 
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> 
> 00:08.0 Mass storage controller: Promise Technology, Inc. PDC20267 
> (FastTrak100/Ultra100) (rev 02)
>         Subsystem: Promise Technology, Inc. Ultra100
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
> Stepping- SERR- FastB2B-
>         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
> <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 32
>         Interrupt: pin A routed to IRQ 177
>         Region 0: I/O ports at b000 [size=8]
>         Region 1: I/O ports at b400 [size=4]
>         Region 2: I/O ports at b800 [size=8]
>         Region 3: I/O ports at bc00 [size=4]
>         Region 4: I/O ports at c000 [size=64]
>         Region 5: Memory at ef000000 (32-bit, non-prefetchable) [size=128K]
>         Expansion ROM at 30000000 [size=64K]
>         Capabilities: [58] Power Management version 1
>                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> 
> 00:09.0 SCSI storage controller: LSI Logic / Symbios Logic 53c875 (rev 26)
>         Subsystem: Tekram Technology Co.,Ltd. DC390F/U Ultra Wide SCSI Adapter
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- 
> Stepping- SERR- FastB2B-
>         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
> <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 32 (4250ns min, 16000ns max), Cache Line Size: 64 bytes
>         Interrupt: pin A routed to IRQ 185
>         Region 0: I/O ports at c400 [size=256]
>         Region 1: Memory at ef020000 (32-bit, non-prefetchable) [size=256]
>         Region 2: Memory at ef021000 (32-bit, non-prefetchable) [size=4K]
>         [virtual] Expansion ROM at 30010000 [disabled] [size=64K]
>         Capabilities: [40] Power Management version 1
>                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> 
> 00:0b.0 Modem: PCTel Inc HSP MicroModem 56 (rev 02) (prog-if 04 [Hayes/16750])
>         Subsystem: PCTel Inc PCT789 adapter
>         Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
> Stepping- SERR- FastB2B-
>         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
> <TAbort- <MAbort- >SERR- <PERR-
>         Interrupt: pin A routed to IRQ 169
>         Region 0: I/O ports at c800 [size=64]
>         Capabilities: [40] Power Management version 2
>                 Flags: PMEClk- DSI+ D1- D2+ AuxCurrent=55mA 
> PME(D0+,D1-,D2+,D3hot+,D3cold+)
>                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> 
> 00:10.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 
> Controller (rev 80) (prog-if 00 [UHCI])
>         Subsystem: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
> Stepping- SERR- FastB2B-
>         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
> <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 32, Cache Line Size: 32 bytes
>         Interrupt: pin A routed to IRQ 201
>         Region 4: I/O ports at cc00 [size=32]
>         Capabilities: [80] Power Management version 2
>                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA 
> PME(D0+,D1+,D2+,D3hot+,D3cold+)
>                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> 
> 00:10.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 
> Controller (rev 80) (prog-if 00 [UHCI])
>         Subsystem: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
> Stepping- SERR- FastB2B-
>         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
> <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 32, Cache Line Size: 32 bytes
>         Interrupt: pin B routed to IRQ 201
>         Region 4: I/O ports at d000 [size=32]
>         Capabilities: [80] Power Management version 2
>                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA 
> PME(D0+,D1+,D2+,D3hot+,D3cold+)
>                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> 
> 00:10.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 
> Controller (rev 80) (prog-if 00 [UHCI])
>         Subsystem: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
> Stepping- SERR- FastB2B-
>         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
> <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 32, Cache Line Size: 32 bytes
>         Interrupt: pin C routed to IRQ 201
>         Region 4: I/O ports at d400 [size=32]
>         Capabilities: [80] Power Management version 2
>                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA 
> PME(D0+,D1+,D2+,D3hot+,D3cold+)
>                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> 
> 00:10.3 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 82) (prog-if 20 
> [EHCI])
>         Subsystem: VIA Technologies, Inc. USB 2.0
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- 
> Stepping- SERR- FastB2B-
>         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
> <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 32, Cache Line Size: 64 bytes
>         Interrupt: pin D routed to IRQ 201
>         Region 0: Memory at ef022000 (32-bit, non-prefetchable) [size=256]
>         Capabilities: [80] Power Management version 2
>                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA 
> PME(D0+,D1+,D2+,D3hot+,D3cold+)
>                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> 
> 00:11.0 ISA bridge: VIA Technologies, Inc. VT8235 ISA Bridge
>         Subsystem: VIA Technologies, Inc. VT8235 ISA Bridge
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
> Stepping+ SERR- FastB2B-
>         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
> <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 0
>         Capabilities: [c0] Power Management version 2
>                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> 
> 00:11.1 IDE interface: VIA Technologies, Inc. 
> VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06) (prog-if 8a 
> [Master SecP PriP])
>         Subsystem: VIA Technologies, Inc. 
> VT82C586/B/VT82C686/A/B/VT8233/A/C/VT8235 PIPC Bus Master IDE
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
> Stepping- SERR- FastB2B-
>         Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
> <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 32
>         Interrupt: pin A routed to IRQ 193
>         Region 4: I/O ports at d800 [size=16]
>         Capabilities: [c0] Power Management version 2
>                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> 
> 00:11.5 Multimedia audio controller: VIA Technologies, Inc. VT8233/A/8235/8237 
> AC97 Audio Controller (rev 50)
>         Subsystem: VIA Technologies, Inc. K7VT2 motherboard
>         Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
> Stepping- SERR- FastB2B-
>         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
> <TAbort- <MAbort- >SERR- <PERR-
>         Interrupt: pin C routed to IRQ 209
>         Region 0: I/O ports at dc00 [size=256]
>         Capabilities: [c0] Power Management version 2
>                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> 
> 00:12.0 Ethernet controller: VIA Technologies, Inc. VT6102 [Rhine-II] (rev 74)
>         Subsystem: Biostar Microtech Int'l Corp Unknown device 2200
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
> Stepping- SERR- FastB2B-
>         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
> <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 32 (750ns min, 2000ns max), Cache Line Size: 32 bytes
>         Interrupt: pin A routed to IRQ 217
>         Region 0: I/O ports at e000 [size=256]
>         Region 1: Memory at ef023000 (32-bit, non-prefetchable) [size=256]
>         Capabilities: [40] Power Management version 2
>                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
> PME(D0+,D1+,D2+,D3hot+,D3cold+)
>                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> 
> 01:00.0 VGA compatible controller: ATI Technologies Inc Radeon RV100 QY 
> [Radeon 7000/VE] (prog-if 00 [VGA])
>         Subsystem: PC Partner Limited Sapphire Radeon VE 7000 DDR
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
> Stepping+ SERR- FastB2B-
>         Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
> <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 32 (2000ns min), Cache Line Size: 32 bytes
>         Interrupt: pin A routed to IRQ 5
>         Region 0: Memory at e0000000 (32-bit, prefetchable) [size=128M]
>         Region 1: I/O ports at a000 [size=256]
>         Region 2: Memory at ed000000 (32-bit, non-prefetchable) [size=64K]
>         [virtual] Expansion ROM at ec000000 [disabled] [size=128K]
>         Capabilities: [58] AGP version 2.0
>                 Status: RQ=48 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 
> 64bit- FW- AGP3- Rate=x1,x2,x4
>                 Command: RQ=1 ArqSz=0 Cal=0 SBA+ AGP- GART64- 64bit- FW- 
> Rate=<none>
>         Capabilities: [50] Power Management version 2
>                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> 
> 8.6 SCSI   N/A
> 
> 
> Paul Abrahams
> abrahams@acm.org
> 
> 
> 
> -------------------------------------------------------------------------
> Take Surveys. Earn Cash. Influence the Future of IT
> Join SourceForge.net's Techsay panel and you'll get the chance to share your
> opinions on IT & business topics through brief surveys - and earn cash
> http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel
> 


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
