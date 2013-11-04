From: Mark Brown <broonie@kernel.org>
Subject: More ASoC updates for v3.13
Date: Sun, 3 Nov 2013 22:10:45 -0800
Message-ID: <20131104061045.GH2493@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5137933085654536746=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id E29392617B8
 for <alsa-devel@alsa-project.org>; Mon,  4 Nov 2013 07:11:33 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============5137933085654536746==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MKyq+TZLpK62LzFe"
Content-Disposition: inline


--MKyq+TZLpK62LzFe
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The following changes since commit 9645083ca5ef365b7b750cf219bb20b61bb925f8:

  Merge remote-tracking branch 'asoc/topic/wm8962' into asoc-next (2013-10-=
24 11:24:18 +0100)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc=
-v3.13-2

for you to fetch changes up to 71d0c3a876e007f68fc2ed433119dd4f4dc408a7:

  Merge remote-tracking branch 'asoc/topic/wm8996' into asoc-next (2013-11-=
03 22:04:22 -0800)

----------------------------------------------------------------

ASoC: Final updates for v3.13

A few final updates for v3.13, all driver updates apart from some DPCM
and Coverity fixes which should have minor impact on practical systems.

----------------------------------------------------------------
Aaron Lu (1):
      [SCSI] sd: call blk_pm_runtime_init before add_disk

AceLan Kao (2):
      HID: usbhid: quirk for Synaptics Large Touchccreen
      HID: usbhid: quirk for SiS Touchscreen

Al Viro (1):
      nfsd regression since delayed fput()

Alan Ott (5):
      6lowpan: Only make 6lowpan links to IEEE802154 devices
      6lowpan: Sync default hardware address of lowpan links to their wpan
      mrf24j40: Move INIT_COMPLETION() to before packet transmission
      mrf24j40: Use threaded IRQ handler
      mrf24j40: Use level-triggered interrupts

Alex Deucher (6):
      drm/radeon/atom: workaround vbios bug in transmitter table on rs780
      drm/radeon: make missing smc ucode non-fatal (r7xx-SI)
      drm/radeon: make missing smc ucode non-fatal (CI)
      drm/radeon/audio: don't set speaker allocation on DCE3.2
      drm/radeon: rework audio option
      drm/radeon/audio: don't set speaker allocation on DCE4+

Alexander Bondar (1):
      iwlwifi: mvm: Disable uAPSD for D3 image

Alexandre Belloni (1):
      mac802154: correct a typo in ieee802154_alloc_device() prototype

Alexei Starovoitov (1):
      net: fix unsafe set_memory_rw from softirq

Amir Vadai (2):
      net/mlx4_en: Rename name of mlx4_en_rx_alloc members
      net/mlx4_en: Fix pages never dma unmapped on rx

Amitkumar Karwar (1):
      mwifiex: fix SDIO interrupt lost issue

Andi Kleen (2):
      igb: Avoid uninitialized advertised variable in eee_set_cur
      tcp: Always set options to 0 before calling tcp_established_options

Andreas Matthies (1):
      [media] tda10071: change firmware download condition

Andy Gospodarek (1):
      bonding: update MAINTAINERS

Anjana V Kumar (1):
      cgroup: fix to break the while loop in cgroup_attach_task() correctly

Antti Palosaari (3):
      [media] e4000: fix PLL calc bug on 32-bit arch
      [media] msi3101: Kconfig select VIDEOBUF2_VMALLOC
      [media] msi3101: correct max videobuf2 alloc

Ariel Elior (3):
      bnx2x: Unlock VF-PF channel on MAC/VLAN config error
      bnx2x: Fix config when SR-IOV and iSCSI are enabled
      bnx2x: Lock DMAE when used by statistic flow

Arnaldo Carvalho de Melo (1):
      perf scripting perl: Fix build error on Fedora 12

Avinash Patil (2):
      mwifiex: inform cfg80211 about disconnect if device is removed
      mwifiex: inform cfg80211 about disconnect for P2P client interface

Ben Hutchings (1):
      sfc: Only bind to EF10 functions with the LinkCtrl and Trusted flags

Ben Widawsky (2):
      drm/i915: Make PTE valid encoding optional
      drm/i915: Disable GGTT PTEs on GEN6+ suspend

Bian Yu (1):
      md: avoid deadlock when md_set_badblocks.

Brennan Shacklett (1):
      intel_pstate: Improve accuracy by not truncating until final result

Brian Austin (4):
      ASoC: cs42l52: Add platform data for reset gpio
      ASoC: cs42l52: convert pdata config to regmap_update_bits
      ASoC: cs42l52: Add chip rev id message
      ASoC: cs42l52: increase MAX_REGISTER for regmap_register_patch

Bruno Randolf (1):
      cfg80211: fix warning when using WEXT for IBSS

Chad Dupuis (1):
      [SCSI] qla2xxx: Fix request queue null dereference.

Charles Keepax (1):
      ASoC: wm5110: Add missing routes for AEC Loopback

Chris Wilson (2):
      drm: Prevent overwriting from userspace underallocating core ioctl st=
ructs
      drm: Pad drm_mode_get_connector to 64-bit boundary

Christian K=F6nig (2):
      drm/radeon: stop the leaks in cik_ib_test
      drm/radeon/uvd: revert lower msg&fb buffer requirements on UVD3

Christophe Gouault (1):
      vti: get rid of nf mark rule in prerouting

Chun-Yeow Yeoh (1):
      mac80211: fix the setting of extended supported rate IE

Claudiu Manoil (3):
      gianfar: Enable eTSEC-A002 erratum w/a for all parts
      gianfar: Use mpc85xx support for errata detection
      gianfar: Enable eTSEC-20 erratum w/a for P2020 Rev1

Colin Ian King (1):
      eCryptfs: fix 32 bit corruption issue

Dan Carpenter (5):
      [media] sh_vou: almost forever loop in sh_vou_try_fmt_vid_out()
      [media] mx3-camera: locking cleanup in mx3_videobuf_queue()
      net: heap overflow in __audit_sockaddr()
      yam: integer underflow in yam_ioctl()
      yam: remove a no-op in yam_ioctl()

Daniel Borkmann (1):
      net: unix: inherit SOCK_PASS{CRED, SEC} flags from socket to fix race

Dave Airlie (2):
      Merge tag 'drm-intel-fixes-2013-10-21' of git://people.freedesktop.or=
g/~danvet/drm-intel into drm-fixes
      Merge branch 'drm-fixes-3.12' of git://people.freedesktop.org/~agd5f/=
linux into drm-fixes

Dave Jiang (1):
      MAINTAINERS: add to ioatdma maintainer list

Dave Kleikamp (1):
      jfs: fix error path in ialloc

David Herrmann (1):
      HID: wiimote: add LEGO-wiimote VID

David S. Miller (20):
      Merge branch 'connector'
      Merge branch 'calxedaxgmac'
      Merge branch 'mv643xx'
      Merge tag 'batman-adv-fix-for-davem' of git://git.open-mesh.org/linux=
-merge
      Merge branch 'for-davem' of git://git.kernel.org/.../linville/wireless
      Merge branch '6lowpan'
      Merge branch 'mrf24j40'
      l2tp: Fix build warning with ipv6 disabled.
      Merge branch 'mlx4'
      Merge branch 'sfc-3.12' of git://git.kernel.org/.../bwh/sfc
      Merge branch 'master' of git://git.kernel.org/.../klassert/ipsec
      Merge branch 'gianfar'
      Merge branch 'for-davem' of git://git.kernel.org/.../linville/wireless
      Merge branch 'dm9000'
      Merge branch 'sctp_csum'
      Merge branch 'for-davem' of git://git.kernel.org/.../linville/wireless
      Merge branch 'bridge_pvid'
      Merge branch 'ufo_fixes'
      Merge branch 'bnx2x'
      Merge branch 'rt6i_gateway'

David Vrabel (1):
      xen-netback: transition to CLOSED when removing a VIF

David Woodhouse (1):
      mtd: gpmi: fix ECC regression

Denis Carikli (1):
      ASoC: eukrea-tlv320: Use dev_err instead of pr_err.

Dimitris Papastamos (5):
      ASoC: wm_adsp: Print error when regmap reads/writes fail
      ASoC: wm_adsp: Release firmware on memory allocation failure
      ASoC: wm_adsp: Add debug info on get()/put() transfers
      ASoC: wm_adsp: Remove and free algorithm regions for ADSP1
      ASoC: wm_adsp: Print out the firmware version

Dirk Brandewie (1):
      intel_pstate: Correct calculation of min pstate value

Dmitry Kravkov (2):
      bnx2x: Fix Coalescing configuration
      bnx2x: Don't pretend during register dump

Eduardo Valentin (1):
      drivers: thermal: allow ti-soc-thermal run without pcb zone

Edward Cree (3):
      sfc: Fix internal indices of ethtool stats for EF10
      sfc: Refactor EF10 stat mask code to allow for more conditional stats
      sfc: Add PM and RXDP drop counters to ethtool stats

Emmanuel Grumbach (6):
      iwlwifi: pcie: don't reset the TX queue counter
      iwlwifi: don't WARN on host commands sent when firmware is dead
      iwlwifi: pcie: add SKUs for 6000, 6005 and 6235 series
      iwlwifi: mvm: call ieee80211_scan_completed when needed
      mac80211: correctly close cancelled scans
      cfg80211: don't add p2p device while in RFKILL

Enrico Mioso (1):
      net: qmi_wwan: Olivetti Olicard 200 support

Eric Dumazet (8):
      net: do not call sock_put() on TIMEWAIT sockets
      tcp: do not forget FIN in tcp_shifted_skb()
      pkt_sched: fq: fix typo for initial_quantum
      pkt_sched: fq: fix non TCP flows pacing
      l2tp: must disable bh before calling l2tp_xmit_skb()
      bnx2x: record rx queue for LRO packets
      tcp: must unclone packets before mangling them
      tcp: remove the sk_can_gso() check from tcp_set_skb_tso_segs()

Eric W. Biederman (1):
      net: Update the sysctl permissions handler to test effective uid/gid

Ezequiel Garcia (1):
      mtd: nand: pxa3xx: Fix registered MTD name

Fabio Estevam (1):
      net: secure_seq: Fix warning when CONFIG_IPV6 and CONFIG_INET are not=
 selected

Fan Du (2):
      xfrm: Guard IPsec anti replay window against replay bitmap
      sctp: Use software crc32 checksum when xfrm transform will happen.

Felix Fietkau (5):
      mac80211: drop spoofed packets in ad-hoc mode
      mac80211: use sta_info_get_bss() for nl80211 tx and client probing
      mac80211: update sta->last_rx on acked tx frames
      ath9k: fix powersave response handling for BA session packets
      ath9k: fix tx queue scheduling after channel changes

Fengguang Wu (1):
      [media] msi3101: msi3101_ioctl_ops can be static

Fran=E7ois Cachereul (1):
      l2tp: fix kernel panic when using IPv4-mapped IPv6 addresses

Freddy Xin (2):
      ax88179_178a: Correct the RX error definition in RX header
      ax88179_178a: Add VID:DID for Samsung USB Ethernet Adapter

Geyslan G. Bem (1):
      ecryptfs: Fix memory leakage in keystore.c

Gianluca Gennari (4):
      [media] adv7842: fix compilation with GCC < 4.4.6
      [media] adv7511: fix compilation with GCC < 4.4.6
      [media] ad9389b: fix compilation with GCC < 4.4.6
      [media] ths8200: fix compilation with GCC < 4.4.6

Gregor Jasny (1):
      [media] Add HCL T12Rg-H to STK webcam upside-down table

Gu Zheng (1):
      seq_file: always update file->f_pos in seq_lseek()

Gwendal Grignou (1):
      libata: make ata_eh_qc_retry() bump scmd->allowed on bogus failures

Hannes Frederic Sowa (1):
      ipv6: probe routes asynchronous in rt6_probe

Heiko Carstens (2):
      s390/compat,signal: fix return value of copy_siginfo_(to|from)_user32=
()
      s390/vmlogrdr: fix array access in vmlogrdr_open()

Heiko Stuebner (1):
      MAINTAINERS: Add maintainers entry for Rockchip SoCs

Helge Deller (3):
      Revert "parisc: Export flush_cache_page() (needed by lustre)"
      parisc: enable DEVTMPFS, DEVTMPFS_MOUNT and BLK_DEV_INITRD in defconf=
igs
      parisc: Do not crash 64bit SMP kernels on machines with >=3D 4GB RAM

Himanshu Madhani (1):
      qlcnic: Validate Tx queue only for 82xx adapters.

Ingo Molnar (1):
      Merge tag 'perf-urgent-for-mingo' of git://git.kernel.org/.../acme/li=
nux into perf/urgent

Jacek Anaszewski (1):
      [media] s5p-jpeg: Initialize vfd_decoder->vfl_dir field

Jason Cooper (1):
      MAINTAINERS: ARM: mvebu: add Sebastian Hesselbarth

Jason Wang (2):
      virtio-net: don't respond to cpu hotplug notifier if we're not ready
      virtio-net: refill only when device is up during setting queues

Jean-Francois Moine (1):
      ASoC: kirkwood: Fix compile error due to patch 'add S/PDIF support'

Jesse Barnes (1):
      drm/i915: disable LVDS clock gating on CPT v2

Jingoo Han (2):
      ahci: use dev_info() instead of printk()
      ahci_platform: use dev_info() instead of printk()

Jiri Benc (1):
      ipv4: fix ineffective source address selection

Jiri Pirko (3):
      udp6: respect IPV6_DONTFRAG sockopt in case there are pending frames
      ip6_output: do skb ufo init for peeked non ufo skb as well
      ip_output: do skb ufo init for peeked non ufo skb as well

Johannes Berg (4):
      cfg80211: fix sysfs registration race
      iwlwifi: pcie: fix merge damage
      wireless: radiotap: fix parsing buffer overrun
      mac80211: fix crash if bitrate calculation goes wrong

John W. Linville (7):
      Merge branch 'for-john' of git://git.kernel.org/.../jberg/mac80211
      Merge branch 'master' of git://git.kernel.org/.../linville/wireless i=
nto for-davem
      Merge branch 'for-john' of git://git.kernel.org/.../iwlwifi/iwlwifi-f=
ixes
      Merge branch 'master' of git://git.kernel.org/.../linville/wireless i=
nto for-davem
      Merge branch 'for-john' of git://git.kernel.org/.../jberg/mac80211
      Merge branch 'for-john' of git://git.kernel.org/.../jberg/mac80211
      Merge branch 'master' of git://git.kernel.org/.../linville/wireless i=
nto for-davem

Jon Cooper (1):
      sfc: Add rmb() between reading stats and generation count to ensure c=
onsistency

Joseph Salisbury (1):
      [media] uvcvideo: quirk PROBE_DEF for Dell SP2008WFP monitor

Jouni Malinen (1):
      mac80211: Run deferred scan if last roc_list item is not started

Julian Anastasov (3):
      ipv6: always prefer rt6i_gateway if present
      ipv6: fill rt6i_gateway with nexthop address
      netfilter: nf_conntrack: fix rt6i_gateway checks for H.323 helper

Kent Overstreet (1):
      bcache: Fixed incorrect order of arguments to bio_alloc_bioset()

Khalid Aziz (1):
      [SCSI] BusLogic: Fix an oops when intializing multimaster adapter

Kuninori Morimoto (1):
      ASoC: rcar: remove original filter from rsnd_dma_init()

Laurent Pinchart (1):
      [media] uvcvideo: quirk PROBE_DEF for Microsoft Lifecam NX-3000

Linus L=FCssing (1):
      Revert "bridge: only expire the mdb entry when query is received"

Linus Torvalds (26):
      Merge branch 'parisc-3.12' of git://git.kernel.org/.../deller/parisc-=
linux
      Merge branch 'for-3.12-fixes' of git://git.kernel.org/.../tj/cgroup
      Merge branch 'for-3.12-fixes' of git://git.kernel.org/.../tj/libata
      Merge branch 'for-linus' of git://git.kernel.org/.../jikos/hid
      Merge branch 'drm-fixes' of git://people.freedesktop.org/~airlied/lin=
ux
      Merge tag 'jfs-3.12' of git://github.com/kleikamp/linux-shaggy
      Merge tag 'sound-3.12' of git://git.kernel.org/.../tiwai/sound
      Merge git://git.kernel.org/.../davem/net
      Merge tag 'rdma-for-linus' of git://git.kernel.org/.../roland/infinib=
and
      Merge branch 'v4l_for_linus' of git://git.kernel.org/.../mchehab/linu=
x-media
      Merge branch 'for-rc' of git://git.kernel.org/.../rzhang/linux
      Merge branch 'for-linus' of git://git.kernel.org/.../s390/linux
      Merge tag 'scsi-fixes' of git://git.kernel.org/.../jejb/scsi
      Merge tag 'md/3.12-fixes' of git://neil.brown.name/md
      Merge tag 'ecryptfs-3.12-rc7-fixes' of git://git.kernel.org/.../tyhic=
ks/ecryptfs
      Merge tag 'fixes-for-linus' of git://git.kernel.org/.../arm/arm-soc
      Merge branch 'for-linus' of git://git.kernel.org/.../viro/vfs
      Merge tag 'for-linus-20131025' of git://git.infradead.org/linux-mtd
      Merge tag 'pm+acpi-3.12-rc7' of git://git.kernel.org/.../rafael/linux=
-pm
      Merge branch 'fixes' of git://git.infradead.org/users/vkoul/slave-dma
      Merge git://git.kernel.org/.../nab/target-pending
      Merge branch 'core-urgent-for-linus' of git://git.kernel.org/.../tip/=
tip
      Merge branch 'perf-urgent-for-linus' of git://git.kernel.org/.../tip/=
tip
      Merge branch 'timers-urgent-for-linus' of git://git.kernel.org/.../ti=
p/tip
      Merge branch 'parisc-3.12' of git://git.kernel.org/.../deller/parisc-=
linux
      Linux 3.12-rc7

Linus Walleij (1):
      ARM: integrator: deactivate timer0 on the Integrator/CP

Luciano Coelho (1):
      cfg80211: use the correct macro to check for active monitor support

Lukasz Dorau (2):
      libahci: fix turning on LEDs in ahci_start_port()
      md: Fix skipping recovery for read-only arrays.

Lukasz Majewski (3):
      thermal: exynos: Remove check for thermal device pointer at exynos_re=
port_trigger()
      thermal: exynos: Provide separate TMU data for Exynos4412
      thermal: exynos: Provide initial setting for TMU's test MUX address a=
t Exynos4412

Marc Kleine-Budde (5):
      can: dev: fix nlmsg size calculation in can_get_size()
      net: vlan: fix nlmsg size calculation in vlan_get_size()
      can: flexcan: flexcan_chip_start: fix regression, mark one MB for TX =
and abort pending TX
      can: flexcan: fix mx28 detection by rearanging OF match table
      can: at91-can: fix device to driver data mapping for platform devices

Marek Szyprowski (1):
      [media] videobuf2-dc: Fix support for mappings without struct page in=
 userptr mode

Mariusz Ceier (1):
      davinci_emac.c: Fix IFF_ALLMULTI setup

Mark Brown (26):
      Merge remote-tracking branch 'asoc/fix/fsl' into asoc-linus
      Merge remote-tracking branch 'asoc/fix/omap' into asoc-linus
      Merge remote-tracking branch 'asoc/fix/pcm1681' into asoc-linus
      Merge remote-tracking branch 'asoc/fix/pcm1792a' into asoc-linus
      Merge remote-tracking branch 'asoc/fix/rcar' into asoc-linus
      Merge remote-tracking branch 'asoc/fix/tlv320aic3x' into asoc-linus
      ALSA: Add MAINTAINERS entry for dmaengine helpers
      ASoC: pcm: Check for ops before deferencing them
      Merge remote-tracking branch 'asoc/fix/ak4642' into asoc-linus
      Merge remote-tracking branch 'asoc/fix/dapm' into asoc-linus
      Merge remote-tracking branch 'asoc/fix/wm8994' into asoc-linus
      Merge remote-tracking branch 'asoc/topic/ab8500' into asoc-next
      Merge remote-tracking branch 'asoc/topic/adsp' into asoc-next
      Merge remote-tracking branch 'asoc/topic/arizona' into asoc-next
      Merge remote-tracking branch 'asoc/topic/core' into asoc-next
      Merge remote-tracking branch 'asoc/topic/cs42l52' into asoc-next
      Merge remote-tracking branch 'asoc/topic/dma' into asoc-next
      Merge remote-tracking branch 'asoc/topic/fsl' into asoc-next
      Merge remote-tracking branch 'asoc/topic/kirkwood' into asoc-next
      Merge remote-tracking branch 'asoc/topic/ml26124' into asoc-next
      Merge remote-tracking branch 'asoc/topic/rcar' into asoc-next
      Merge remote-tracking branch 'asoc/topic/rt5640' into asoc-next
      Merge remote-tracking branch 'asoc/topic/samsung' into asoc-next
      Merge remote-tracking branch 'asoc/topic/wm0010' into asoc-next
      Merge remote-tracking branch 'asoc/topic/wm8962' into asoc-next
      Merge remote-tracking branch 'asoc/topic/wm8996' into asoc-next

Mark Cave-Ayland (1):
      rtlwifi: rtl8192cu: Fix error in pointer arithmetic

Markus Pargmann (3):
      net: ethernet: cpsw: Search childs for slave nodes
      net/ethernet: cpsw: DT read bool dual_emac
      net/ethernet: cpsw: Bugfix interrupts before enabling napi

Martin Schwidefsky (2):
      s390/mm,kvm: fix software dirty bits vs. kvm for old machines
      s390/time: correct use of store clock fast

Masami Hiramatsu (1):
      perf probe: Fix to initialize fname always before use it

Mathias Krause (5):
      proc connector: fix info leaks
      connector: use nlmsg_len() to check message length
      connector: use 'size' everywhere in cn_netlink_send()
      connector - documentation: simplify netlink message length assignment
      unix_diag: fix info leak

Matthew Slattery (1):
      sfc: Add definitions for new stats counters and capability flag

Matthias Schiffer (1):
      batman-adv: set up network coding packet handlers during module init

Matti Gottlieb (1):
      iwlwifi: pcie: add new SKUs for 7000 & 3160 NIC series

Mattia Dongili (1):
      sony-laptop: don't change keyboard backlight settings

Merav Sicron (1):
      bnx2x: Set NETIF_F_HIGHDMA unconditionally

Michael Abbott (1):
      dm9000: Implement full reset of DM9000 network device

Michael S. Tsirkin (2):
      netif_set_xps_queue: make cpu mask const
      tun: don't look at current when non-blocking

Mugunthan V N (1):
      drivers: net: cpsw: fix kernel warn during iperf test with interrupt =
pacing

Neal Cardwell (1):
      tcp: initialize passive-side sk_pacing_rate after 3WHS

Nguyen Hong Ky (1):
      net: sh_eth: Fix RX packets errors on R8A7740

Nicholas Bellinger (7):
      target: Make target_do_xcopy failures return INVALID_PARAMETER_LIST
      target: Allow non zero ListID in EXTENDED_COPY parameter list
      target: Reject EXTENDED_COPY when emulate_3pc is disabled
      target: Add missing XCOPY I/O operation sense_buffer
      target: Generate failure for XCOPY I/O with non-zero scsi_status
      target: Fail XCOPY for non matching source + destination block_size
      vhost/scsi: Fix incorrect usage of get_user_pages_fast write parameter

Nicolin Chen (1):
      ASoC: wm8962: Fix null pointer pdata access in I2C probe()

Nikita Kiryanov (3):
      dm9000: during init reset phy only for dm9000b
      dm9000: take phy out of reset during init
      dm9000: report the correct LPA

Nikolai Kondrashov (1):
      HID: Fix unit exponent parsing again

Ondrej Zary (1):
      pata_isapnp: Don't use invalid I/O ports

Oussama Ghorbel (3):
      ipv6: Allow the MTU of ipip6 tunnel to be set below 1280
      ipv6: Fix the upper MTU limit in GRE tunnel
      ipv6: Initialize ip6_tnl.hlen in gre tunnel even if no route is found

Phil Edworthy (1):
      ASoC: ak4642: prevent un-necessary changes to SG_SL1

Rafael J. Wysocki (1):
      acpi-cpufreq: Fail initialization if driver cannot be registered

Randy Dunlap (3):
      fs/namei.c: fix new kernel-doc warning
      vfs: fix new kernel-doc warnings
      platform/x86: fix asus-wmi build error

Richard Fitzgerald (2):
      ASoC: wm8962: Add ALC coefficient support
      ASoC: wm8962: Add EQ coefficient support

Rob Herring (3):
      net: calxedaxgmac: fix clearing of old filter addresses
      net: calxedaxgmac: add uc and mc filter addresses in promiscuous mode
      net: calxedaxgmac: determine number of address filters at runtime

Roland Dreier (2):
      target: Fix assignment of LUN in tracepoints
      target: Return an error for WRITE SAME with ANCHOR=3D=3D1

Russ Dill (1):
      PM / hibernate: Move software_resume to late_initcall_sync

Russell King - ARM Linux (1):
      ASoC: dpcm: improve robustness

Salva Peir=F3 (2):
      farsync: fix info leak in ioctl
      wanxl: fix info leak in ioctl

Sebastian Hesselbarth (3):
      net: mv643xx_eth: update statistics timer from timer context only
      net: mv643xx_eth: fix orphaned statistics timer crash
      net: mv643xx_eth: fix missing device_node for port devices

Seif Mazareeb (1):
      net: fix cipso packet validation when !NETLABEL

Shaohua Li (2):
      raid5: set bio bi_vcnt 0 for discard request
      raid5: avoid finding "discard" stripe

Simon Farnsworth (1):
      [media] saa7134: Fix crash when device is closed before streamoff

Simon Horman (1):
      net: sh_eth: Correct fix for RX packet errors on R8A7740

Solomon Peachy (1):
      wireless: cw1200: acquire hwbus lock around cw1200_irq_handler() call.

Srinivas Pandruvada (1):
      Thermal: x86_pkg_temp: change spin lock

Stanislaw Gruszka (1):
      Revert "rt2x00pci: Use PCI MSIs whenever possible"

Stefan Haberland (1):
      s390/dasd: check for availability of prefix command during format

Steffen Klassert (5):
      xfrm: Fix replay size checking on async events
      xfrm: Decode sessions with output interface.
      ipsec: Don't update the pmtu on ICMPV6_DEST_UNREACH
      xfrm: Add refcount handling to queued policies
      xfrm: check for a vaild skb in xfrm_policy_queue_process

Stephane Eranian (1):
      perf: Disable PERF_RECORD_MMAP2 support

Stephen Warren (1):
      MAINTAINERS: Tegra updates, and driver ownership

Sylwester Nawrocki (1):
      [media] vb2: Allow queuing OUTPUT buffers with zeroed 'bytesused'

Takashi Iwai (12):
      Merge tag 'asoc-v3.12-rc5' of git://git.kernel.org/.../broonie/sound =
into for-linus
      ASoC: dmaengine: Use SNDRV_PCM_STREAM_LAST for array size
      ASoC: dapm: Fix source list debugfs outputs
      ASoC: dapm: Return -ENOMEM in snd_soc_dapm_new_dai_widgets()
      ASoC: ab8500: Add missing of NULL check of devm_kzalloc()
      ASoC: ab8500: Fix invalid cast to long pointer
      ASoC: wm_hubs: Add missing break in hp_supply_event()
      ASoC: wm0010: Fix possible out-of-bounds array read
      ASoC: wm8996: Fix negative array index read
      ASoC: rt5640: Fix ignored error checks
      ASoC: ml26124: Fix negative array index read
      ASoC: Use strlcpy() for copying in snd_soc_info_enum_double()

Tejun Heo (1):
      cgroup: fix cgroup post-order descendant walk of empty subtree

Tetsuo Handa (1):
      mutex: Avoid gcc version dependent __builtin_constant_p() usage

Thomas Egerer (1):
      xfrm: Fix aevent generation for each received packet

Thomas Gleixner (1):
      clockevents: Sanitize ticks to nsec conversion

Thomas Hellstrom (2):
      drm/vmwgfx: Don't put resources with invalid id's on lru list
      drm/vmwgfx: Don't kill clients on VT switch

Toshiaki Makita (4):
      bridge: Don't use VID 0 and 4095 in vlan filtering
      bridge: Apply the PVID to priority-tagged frames
      bridge: Fix the way the PVID is referenced
      bridge: Fix updating FDB entries when the PVID is applied

Valentin Ilie (1):
      dma: edma: Fix memory leak

Vasundhara Volam (1):
      be2net: pass if_id for v1 and V2 versions of TX_CREATE cmd

Vinod Koul (2):
      MAINTAINERS: add the new dmaengine mailing list
      dmaengine: edma: fix another memory leak

Vlad Yasevich (4):
      bridge: update mdb expiration timer upon reports.
      net: dst: provide accessor function to dst->xfrm
      sctp: Perform software checksum if packet has to be fragmented.
      bridge: Correctly clamp MAX forward_delay when enabling STP

Vu Pham (1):
      iser-target: check device before dereferencing its variable

Wei Yongjun (7):
      moxa: fix the error handling in moxart_mac_probe()
      qlcnic: add missing destroy_workqueue() on error path in qlcnic_probe=
()
      [media] adv7511: fix error return code in adv7511_probe()
      usbnet: fix error return code in usbnet_probe()
      ASoC: samsung: fix return value check in i2s_alloc_dai()
      target/pscsi: fix return value check
      ASoC: fsl_spdif: fix return value check in fsl_spdif_probe()

Will Deacon (1):
      net: smc91x: dont't use SMC_outw for fixing up halfword-aligned data

Yann Droneaud (1):
      IB/core: Temporarily disable create_flow/destroy_flow uverbs

Yuchung Cheng (1):
      tcp: fix incorrect ca_state in tail loss probe

Yuval Mintz (3):
      bnx2x: Fix Maximum CoS estimation for VFs
      bnx2x: Prevent an illegal pointer dereference during panic
      bnx2x: Prevent null pointer dereference on error flow

Zhang Rui (2):
      Revert "drivers: thermal: parent virtual hwmon with thermal zone"
      Merge branch 'x86_pkg_temp' of .git into for-rc

stephen hemminger (3):
      tc: export tc_defact.h to userspace
      netem: update backlog after drop
      netem: free skb's in tree on reset

 Documentation/connector/ucon.c                     |   2 +-
 MAINTAINERS                                        |  86 ++++-
 Makefile                                           |   2 +-
 arch/arm/boot/dts/integratorcp.dts                 |   9 +-
 arch/arm/net/bpf_jit_32.c                          |   1 +
 arch/parisc/configs/712_defconfig                  |   2 +
 arch/parisc/configs/a500_defconfig                 |   2 +
 arch/parisc/configs/b180_defconfig                 |   3 +
 arch/parisc/configs/c3000_defconfig                |   3 +
 arch/parisc/configs/c8000_defconfig                |   2 +
 arch/parisc/configs/default_defconfig              |   2 +
 arch/parisc/kernel/cache.c                         |   1 -
 arch/parisc/kernel/head.S                          |   4 +
 arch/powerpc/net/bpf_jit_comp.c                    |   1 +
 arch/s390/include/asm/pgtable.h                    |   4 +-
 arch/s390/include/asm/timex.h                      |  28 +-
 arch/s390/kernel/compat_signal.c                   |   4 +-
 arch/s390/kernel/debug.c                           |   2 +-
 arch/s390/kvm/interrupt.c                          |   6 +-
 arch/s390/lib/delay.c                              |  14 +-
 arch/s390/net/bpf_jit_comp.c                       |   4 +-
 arch/sparc/net/bpf_jit_comp.c                      |   1 +
 arch/x86/net/bpf_jit_comp.c                        |  18 +-
 drivers/ata/ahci.c                                 |   2 +-
 drivers/ata/ahci_platform.c                        |   2 +-
 drivers/ata/libahci.c                              |  10 +-
 drivers/ata/libata-eh.c                            |   6 +-
 drivers/ata/pata_isapnp.c                          |   2 +-
 drivers/connector/cn_proc.c                        |  18 +
 drivers/connector/connector.c                      |   9 +-
 drivers/cpufreq/acpi-cpufreq.c                     |   8 +-
 drivers/cpufreq/intel_pstate.c                     |  38 +-
 drivers/dma/edma.c                                 |   2 +
 drivers/gpu/drm/drm_drv.c                          |   9 +-
 drivers/gpu/drm/i915/i915_drv.c                    |   5 +-
 drivers/gpu/drm/i915/i915_drv.h                    |   8 +-
 drivers/gpu/drm/i915/i915_gem_gtt.c                | 109 ++++--
 drivers/gpu/drm/i915/i915_reg.h                    |   6 +
 drivers/gpu/drm/i915/intel_pm.c                    |   4 +-
 drivers/gpu/drm/radeon/atombios_encoders.c         |  54 ++-
 drivers/gpu/drm/radeon/cik.c                       |   4 +
 drivers/gpu/drm/radeon/dce6_afmt.c                 |   3 +
 drivers/gpu/drm/radeon/evergreen_hdmi.c            |   3 +
 drivers/gpu/drm/radeon/ni.c                        |   1 +
 drivers/gpu/drm/radeon/r600.c                      |   1 +
 drivers/gpu/drm/radeon/r600_hdmi.c                 |   3 +
 drivers/gpu/drm/radeon/radeon_connectors.c         |  33 +-
 drivers/gpu/drm/radeon/radeon_cs.c                 |   3 +-
 drivers/gpu/drm/radeon/radeon_drv.c                |   4 +-
 drivers/gpu/drm/radeon/radeon_uvd.c                |   3 +-
 drivers/gpu/drm/radeon/si.c                        |   1 +
 drivers/gpu/drm/radeon/uvd_v1_0.c                  |   4 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.c                |  17 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_resource.c           |   2 +-
 drivers/hid/hid-core.c                             |  12 +-
 drivers/hid/hid-ids.h                              |   6 +
 drivers/hid/hid-input.c                            |  13 +-
 drivers/hid/hid-wiimote-core.c                     |   5 +-
 drivers/hid/usbhid/hid-quirks.c                    |   3 +
 drivers/infiniband/Kconfig                         |  11 +
 drivers/infiniband/core/uverbs.h                   |   2 +
 drivers/infiniband/core/uverbs_cmd.c               |   4 +
 drivers/infiniband/core/uverbs_main.c              |   6 +
 drivers/infiniband/hw/mlx4/main.c                  |   2 +
 drivers/infiniband/ulp/isert/ib_isert.c            |   2 +-
 drivers/md/bcache/request.c                        |   2 +-
 drivers/md/md.c                                    |   5 +-
 drivers/md/raid1.c                                 |   1 +
 drivers/md/raid10.c                                |   1 +
 drivers/md/raid5.c                                 |  20 ++
 drivers/media/dvb-frontends/tda10071.c             |   9 +-
 drivers/media/i2c/ad9389b.c                        |  15 +-
 drivers/media/i2c/adv7511.c                        |  18 +-
 drivers/media/i2c/adv7842.c                        |  30 +-
 drivers/media/i2c/ths8200.c                        |  12 +-
 drivers/media/pci/saa7134/saa7134-video.c          |   1 +
 drivers/media/platform/s5p-jpeg/jpeg-core.c        |   1 +
 drivers/media/platform/sh_vou.c                    |   2 +-
 drivers/media/platform/soc_camera/mx3_camera.c     |   5 +-
 drivers/media/tuners/e4000.c                       |   3 +-
 drivers/media/usb/stkwebcam/stk-webcam.c           |   7 +
 drivers/media/usb/uvc/uvc_driver.c                 |  18 +
 drivers/media/v4l2-core/videobuf2-core.c           |   4 +-
 drivers/media/v4l2-core/videobuf2-dma-contig.c     |  87 ++++-
 drivers/mtd/nand/gpmi-nand/gpmi-nand.c             |   2 +-
 drivers/mtd/nand/pxa3xx_nand.c                     |   7 +-
 drivers/net/can/at91_can.c                         |   4 +-
 drivers/net/can/dev.c                              |  10 +-
 drivers/net/can/flexcan.c                          |  14 +-
 drivers/net/ethernet/broadcom/bnx2x/bnx2x.h        |  15 +-
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c    |   1 +
 .../net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c    |  40 +--
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_init.h   |  38 +-
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c   | 388 +++++++++++------=
----
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_sriov.c  |  29 +-
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_stats.c  |   2 +-
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_vfpf.c   |   2 +-
 drivers/net/ethernet/calxeda/xgmac.c               |  23 +-
 drivers/net/ethernet/davicom/dm9000.c              |  56 ++-
 drivers/net/ethernet/emulex/benet/be_cmds.c        |   3 +-
 drivers/net/ethernet/freescale/gianfar.c           |  38 +-
 drivers/net/ethernet/intel/igb/igb_ethtool.c       |   2 +
 drivers/net/ethernet/marvell/mv643xx_eth.c         |   7 +-
 drivers/net/ethernet/mellanox/mlx4/en_rx.c         |  41 ++-
 drivers/net/ethernet/mellanox/mlx4/mlx4_en.h       |   4 +-
 drivers/net/ethernet/moxa/moxart_ether.c           |  22 +-
 .../net/ethernet/qlogic/qlcnic/qlcnic_ethtool.c    |   2 +-
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_main.c   |  13 +-
 drivers/net/ethernet/renesas/sh_eth.c              |   4 +
 drivers/net/ethernet/sfc/ef10.c                    |  87 +++--
 drivers/net/ethernet/sfc/mcdi.c                    |  18 +-
 drivers/net/ethernet/sfc/mcdi_pcol.h               |  56 ++-
 drivers/net/ethernet/sfc/nic.c                     |   9 +-
 drivers/net/ethernet/sfc/nic.h                     |  12 +
 drivers/net/ethernet/smsc/smc91x.h                 |   6 +-
 drivers/net/ethernet/ti/cpsw.c                     |  19 +-
 drivers/net/ethernet/ti/davinci_emac.c             |   3 +-
 drivers/net/hamradio/yam.c                         |   1 -
 drivers/net/ieee802154/mrf24j40.c                  |  31 +-
 drivers/net/tun.c                                  |   8 +-
 drivers/net/usb/ax88179_178a.c                     |  23 +-
 drivers/net/usb/qmi_wwan.c                         |   1 +
 drivers/net/usb/usbnet.c                           |   4 +-
 drivers/net/virtio_net.c                           |  14 +-
 drivers/net/wan/farsync.c                          |   1 +
 drivers/net/wan/wanxl.c                            |   1 +
 drivers/net/wireless/ath/ath9k/main.c              |  23 +-
 drivers/net/wireless/ath/ath9k/xmit.c              |   9 +-
 drivers/net/wireless/cw1200/cw1200_spi.c           |   2 +
 drivers/net/wireless/iwlwifi/iwl-6000.c            |   6 +
 drivers/net/wireless/iwlwifi/iwl-config.h          |   1 +
 drivers/net/wireless/iwlwifi/iwl-trans.h           |   6 +-
 drivers/net/wireless/iwlwifi/mvm/power.c           |   5 +-
 drivers/net/wireless/iwlwifi/mvm/scan.c            |  12 +-
 drivers/net/wireless/iwlwifi/pcie/drv.c            |  42 +++
 drivers/net/wireless/iwlwifi/pcie/trans.c          |   8 +-
 drivers/net/wireless/iwlwifi/pcie/tx.c             |   2 +
 drivers/net/wireless/mwifiex/join.c                |  10 +-
 drivers/net/wireless/mwifiex/main.c                |   6 +-
 drivers/net/wireless/mwifiex/sta_event.c           |   3 +-
 drivers/net/wireless/rt2x00/rt2x00pci.c            |   9 +-
 drivers/net/wireless/rtlwifi/rtl8192cu/trx.c       |   3 +-
 drivers/net/xen-netback/xenbus.c                   |   4 +
 drivers/platform/x86/Kconfig                       |   1 +
 drivers/platform/x86/sony-laptop.c                 |  26 +-
 drivers/s390/block/dasd_eckd.c                     |  98 ++++--
 drivers/s390/char/sclp.c                           |   4 +-
 drivers/s390/char/vmlogrdr.c                       |   2 +-
 drivers/s390/cio/cio.c                             |   4 +-
 drivers/s390/cio/qdio_main.c                       |  10 +-
 drivers/scsi/BusLogic.c                            |  16 +-
 drivers/scsi/qla2xxx/qla_dbg.c                     |   2 +-
 drivers/scsi/qla2xxx/qla_isr.c                     |   9 +
 drivers/scsi/sd.c                                  |   2 +-
 drivers/staging/media/msi3101/Kconfig              |   1 +
 drivers/staging/media/msi3101/sdr-msi3101.c        |  10 +-
 drivers/target/target_core_pscsi.c                 |   8 +-
 drivers/target/target_core_sbc.c                   |   5 +
 drivers/target/target_core_xcopy.c                 |  53 ++-
 drivers/thermal/samsung/exynos_thermal_common.c    |   2 -
 drivers/thermal/samsung/exynos_tmu.c               |  12 +-
 drivers/thermal/samsung/exynos_tmu.h               |   7 +-
 drivers/thermal/samsung/exynos_tmu_data.c          |  30 +-
 drivers/thermal/samsung/exynos_tmu_data.h          |  13 +-
 drivers/thermal/thermal_hwmon.c                    |   2 +-
 drivers/thermal/ti-soc-thermal/ti-thermal-common.c |   1 +
 drivers/thermal/x86_pkg_temp_thermal.c             |  14 +-
 drivers/vhost/scsi.c                               |   2 +-
 fs/dcache.c                                        |  15 +-
 fs/ecryptfs/crypto.c                               |   2 +-
 fs/ecryptfs/keystore.c                             |   3 +-
 fs/file_table.c                                    |   4 +-
 fs/jfs/jfs_inode.c                                 |   3 +-
 fs/namei.c                                         |   3 +-
 fs/seq_file.c                                      |   2 +
 include/linux/filter.h                             |  15 +-
 include/linux/netdevice.h                          |   5 +-
 include/linux/yam.h                                |   2 +-
 include/net/cipso_ipv4.h                           |   6 +-
 include/net/dst.h                                  |  12 +
 include/net/ip6_route.h                            |   6 +-
 include/net/mac802154.h                            |   2 +-
 include/net/sock.h                                 |   6 +-
 include/sound/cs42l52.h                            |   2 +
 include/trace/events/target.h                      |   4 +-
 include/uapi/drm/drm_mode.h                        |   2 +
 include/uapi/linux/tc_act/Kbuild                   |   1 +
 include/{ =3D> uapi}/linux/tc_act/tc_defact.h        |   2 +-
 include/uapi/rdma/ib_user_verbs.h                  |   6 +
 kernel/cgroup.c                                    |  14 +-
 kernel/events/core.c                               |   4 +
 kernel/mutex.c                                     |  32 +-
 kernel/power/hibernate.c                           |   2 +-
 kernel/time/clockevents.c                          |  65 +++-
 net/8021q/vlan_netlink.c                           |   2 +-
 net/batman-adv/main.c                              |   5 +-
 net/batman-adv/network-coding.c                    |  28 +-
 net/batman-adv/network-coding.h                    |  14 +-
 net/bridge/br_fdb.c                                |   4 +-
 net/bridge/br_mdb.c                                |   2 +-
 net/bridge/br_multicast.c                          |  38 +-
 net/bridge/br_netlink.c                            |   2 +-
 net/bridge/br_private.h                            |   5 +-
 net/bridge/br_stp_if.c                             |   2 +-
 net/bridge/br_vlan.c                               | 125 ++++---
 net/compat.c                                       |   2 +
 net/core/dev.c                                     |   3 +-
 net/core/filter.c                                  |   8 +-
 net/core/secure_seq.c                              |   2 +
 net/core/sock.c                                    |   1 +
 net/ieee802154/6lowpan.c                           |   5 +
 net/ipv4/inet_hashtables.c                         |   2 +-
 net/ipv4/ip_output.c                               |  13 +-
 net/ipv4/ip_vti.c                                  |  14 +-
 net/ipv4/route.c                                   |   2 +-
 net/ipv4/tcp_input.c                               |   9 +-
 net/ipv4/tcp_output.c                              |  14 +-
 net/ipv4/xfrm4_policy.c                            |   1 +
 net/ipv6/ah6.c                                     |   3 +-
 net/ipv6/esp6.c                                    |   3 +-
 net/ipv6/inet6_hashtables.c                        |   2 +-
 net/ipv6/ip6_gre.c                                 |   6 +-
 net/ipv6/ip6_output.c                              |  29 +-
 net/ipv6/ip6_tunnel.c                              |  12 +-
 net/ipv6/ipcomp6.c                                 |   3 +-
 net/ipv6/route.c                                   |  46 ++-
 net/ipv6/udp.c                                     |   5 +-
 net/ipv6/xfrm6_policy.c                            |   1 +
 net/key/af_key.c                                   |   3 +-
 net/l2tp/l2tp_core.c                               |  36 +-
 net/l2tp/l2tp_core.h                               |   3 +
 net/l2tp/l2tp_ppp.c                                |   4 +
 net/mac80211/cfg.c                                 |   2 +-
 net/mac80211/ieee80211_i.h                         |   3 +
 net/mac80211/offchannel.c                          |   2 +
 net/mac80211/rx.c                                  |   3 +
 net/mac80211/scan.c                                |  19 +
 net/mac80211/status.c                              |   3 +
 net/mac80211/tx.c                                  |   3 +-
 net/mac80211/util.c                                |   9 +-
 net/netfilter/nf_conntrack_h323_main.c             |   4 +-
 net/sched/sch_fq.c                                 |  22 +-
 net/sched/sch_netem.c                              |  17 +
 net/sctp/output.c                                  |   3 +-
 net/socket.c                                       |  24 +-
 net/unix/af_unix.c                                 |  10 +
 net/unix/diag.c                                    |   1 +
 net/wireless/core.c                                |  23 +-
 net/wireless/core.h                                |   3 +
 net/wireless/ibss.c                                |   3 +
 net/wireless/nl80211.c                             |   4 +-
 net/wireless/radiotap.c                            |   7 +-
 net/xfrm/xfrm_policy.c                             |  28 +-
 net/xfrm/xfrm_replay.c                             |  54 +--
 net/xfrm/xfrm_user.c                               |   5 +-
 sound/soc/codecs/ab8500-codec.c                    |  14 +-
 sound/soc/codecs/ak4642.c                          |   2 +-
 sound/soc/codecs/cs42l52.c                         |  93 ++---
 sound/soc/codecs/cs42l52.h                         |   2 +-
 sound/soc/codecs/ml26124.c                         |   2 +
 sound/soc/codecs/rt5640.c                          |   7 +-
 sound/soc/codecs/wm0010.c                          |   8 +-
 sound/soc/codecs/wm5110.c                          |  12 +
 sound/soc/codecs/wm8962.c                          |  22 +-
 sound/soc/codecs/wm8996.c                          |   2 +
 sound/soc/codecs/wm_adsp.c                         |  27 +-
 sound/soc/codecs/wm_hubs.c                         |   1 +
 sound/soc/fsl/eukrea-tlv320.c                      |  15 +-
 sound/soc/fsl/fsl_spdif.c                          |   4 +-
 sound/soc/kirkwood/kirkwood-i2s.c                  |   2 +-
 sound/soc/samsung/i2s.c                            |   2 +-
 sound/soc/sh/rcar/core.c                           |  31 +-
 sound/soc/soc-core.c                               |   5 +-
 sound/soc/soc-dapm.c                               |   4 +-
 sound/soc/soc-generic-dmaengine-pcm.c              |   2 +-
 sound/soc/soc-pcm.c                                |  52 +--
 tools/perf/util/event.c                            |  30 +-
 tools/perf/util/evsel.c                            |   1 -
 tools/perf/util/probe-finder.c                     |   2 +-
 .../perf/util/scripting-engines/trace-event-perl.c |   2 +-
 280 files changed, 2464 insertions(+), 1239 deletions(-)
 rename include/{ =3D> uapi}/linux/tc_act/tc_defact.h (75%)

--MKyq+TZLpK62LzFe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSdzpiAAoJELSic+t+oim90lEP/j7KCyA/qdm7qsJ9faOvBxCn
u+wF6yfq/hEqgoTZRzhtGKsJeCeV4BobV9SRDrUaV0DzCkXXD3sgNIJvEaFeH0x3
mDxCIMxZadOjISIQnvMk/TGpIigkTA+o8AcuUCUBwDnkUZmKB5hFCYPa8gI5JH75
Re13+nTfPOJa/9BpUXZsBcPUhx4OzOcyi9AWxXC5o1iae+zOgODte+xmTYsg7Ozc
gyjgomYfVTCMtqUvQG+wrl9WamjkzOcsb4dVup3BjhT1p+8LLUmXJ2oQbXWoj80W
G8CtMnAQN+xwJ8NFwkZ44hZTHE+7wPr69xD09ADpuyYJ0R7Nw51ypikCivrBohbL
yUf7hI9B6I1ZJXiHrFVww92vQHWxltl/q2vEsESwyxGCYZWHPv6ekJiLOhamecJX
5fNscoyHn+Fs/aAiOWB3TsB+fyKBG/Jal+0I+Q3pbY1SpRLRuEoZ1p/3Fj59TjQ+
veSBl5o/ipoOWtqC2+OczPCXfVMFuilWBfyRPv92eLJksUFQjC1aDwFwKMcNWzmG
WcaAlgGyVtmcbwmZKycgtgd7A6MqtyOtI6deTq5GYWpOkrtEjL2xjrZMpOkQ9cVB
cyaf/Ggs1KLiu/hzxeby6q3SVoomZbXU+M1crMdupcqNMQwAL7uUVBLu4HYX29Nc
lFkYYZZwyIfysQ3OH8BU
=QCRg
-----END PGP SIGNATURE-----

--MKyq+TZLpK62LzFe--

--===============5137933085654536746==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5137933085654536746==--
