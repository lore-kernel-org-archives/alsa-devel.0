From: Mark Brown <broonie@kernel.org>
Subject: ASoC updates for v3.10
Date: Wed, 29 May 2013 11:45:19 +0100
Message-ID: <20130529104519.GQ3660@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1029421393593754837=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 5A3C52619F9
 for <alsa-devel@alsa-project.org>; Wed, 29 May 2013 12:45:44 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============1029421393593754837==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="b5sSX5qSQrSInIHt"
Content-Disposition: inline


--b5sSX5qSQrSInIHt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The following changes since commit e6135fe960bba1d1a3a6b6818839e6d8d3f21293:

  ALSA: usb-audio: proc: use found syncmaxsize to determine feedback format=
 (2013-05-17 08:05:34 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc=
-v3.10-rc3

for you to fetch changes up to 1ab9ecc24819a8cf8ee982aaf6fb83298f094b0d:

  Merge remote-tracking branch 'asoc/fix/wm8994' into asoc-linus (2013-05-2=
8 15:41:37 +0100)

The diffstat and so on being rather obscured by the fact that I've got a
newer -rc merged in here than you do in your branch, sorry.

----------------------------------------------------------------

ASoC: Updates for v3.10

A series of driver specific updates, none particularly critical, plus
one fix to the compressed API code to handle capture streams properly
which is very safe for mainline as there's no current users.

----------------------------------------------------------------
Alan Stern (6):
      USB: xHCI: override bogus bulk wMaxPacketSize values
      USB: fix Kconfig logic for USB_UHCI_HCD
      USB: UHCI: fix for suspend of virtual HP controller
      USB: fix latency in uhci-hcd and ohci-hcd
      USB: OHCI: fix logic for scheduling isochronous URBs
      USB: remove remaining instances of USB_SUSPEND

Alasdair G Kergon (1):
      dm thin: fix metadata dev resize detection

Albert Pool (1):
      rtlwifi: rtl8192cu: Add new USB ID

Alex Deucher (10):
      drm/radeon/dce2: use 10khz units for audio dto calculation
      drm/radeon: add chip family for Hainan
      drm/radeon: fill in GPU init for Hainan (v2)
      drm/radeon: don't touch DCE or VGA regs on Hainan (v3)
      drm/radeon: fill in ucode loading support for Hainan
      drm/radeon: radeon-asic updates for Hainan
      drm/radeon: track which asics have UVD
      drm/radeon: sun/hainan chips do not have UVD (v2)
      drm/radeon: add golden register settings for Hainan (v2)
      drm/radeon: add Hainan pci ids

Alex Elder (33):
      rbd: fix leak of format 2 snapshot context
      rbd: revalidate only for mapping size changes
      rbd: update capacity in rbd_dev_refresh()
      rbd: kill rbd_update_mapping_size()
      rbd: don't print warning if not mapping a parent
      rbd: don't look up snapshot id in rbd_dev_mapping_set()
      rbd: kill rbd_dev_clear_mapping()
      rbd: always set read-only flag in rbd_add()
      rbd: set the mapping size and features later
      rbd: zero format 1 header structure earlier
      rbd: refactor rbd_header_from_disk()
      rbd: update in-core header directly
      rbd: simplify rbd_dev_v1_probe()
      rbd: get rid of trivial v1 header wrappers
      rbd: define rbd_dev_v2_header_info()
      rbd: fix an incorrect assertion condition
      rbd: support reading parent page data
      rbd: set mapping read-only flag in rbd_add()
      rbd: only set up watch for mapped images
      rbd: kill rbd_img_request_get()
      libceph: init sent and completed when starting
      rbd: fix parent request size assumption
      rbd: support reading parent page data for writes
      rbd: ignore zero-overlap parent
      rbd: get parent info on refresh
      rbd: don't release write request until necessary
      rbd: define rbd_dev_unparent()
      rbd: define parent image request routines
      rbd: reference count parent requests
      rbd: detect when clone image is flattened
      rbd: re-submit read request for flattened clone
      rbd: re-submit write request for flattened clone
      rbd: re-submit flattened write request (part 2)

Alex Hung (1):
      ACPI video: ignore BIOS initial backlight value for HP 1000

Alexander Bondar (1):
      iwlwifi: mvm: Prevent setting assoc flag in MAC_CONTEXT_CMD

Alexander Gordeev (1):
      powerpc: Fix irq_set_affinity() return values

Alexander Shiyan (2):
      s390: remove non existent reference to GENERIC_KERNEL_THREAD
      cpufreq: Fix incorrect dependecies for ARM SA11xx drivers

Alexander Sverdlin (1):
      i2c: suppress lockdep warning on delete_device

Alexandre Bounine (4):
      rapidio: make enumeration/discovery configurable
      rapidio: add enumeration/discovery start from user space
      rapidio: documentation update for enumeration changes
      rapidio/tsi721: fix bug in MSI interrupt handling

Alexandre Courbot (1):
      ARM: tegra: defconfig fixes

Alexandre Oliva (1):
      btrfs: do away with non-whole_page extent I/O

Alexandru Gheorghiu (1):
      drivers: char: ipmi: Replaced kmalloc and strcpy with kstrdup

Alistair Popple (1):
      powerpc: Add an in memory udbg console

Amerigo Wang (2):
      virtio_net: use default napi weight by default
      ipv6,gre: do not leak info to user-space

Amitkumar Karwar (1):
      mwifiex: fix memory leak issue when driver unload

Andreas Larsson (2):
      spi: Initialize cs_gpio and cs_gpios with -ENOENT
      spi: Return error from of_spi_register_master on bad "cs-gpios" prope=
rty

Andreas Philipp (1):
      Correct allowed raid levels on balance.

Andrew Bresticker (1):
      ASoC: max98090: request IRQF_ONESHOT interrupt

Andrew Lunn (2):
      ARM: Orion: Remove redundant init_dma_coherent_pool_size()
      mv643xx_eth: fix NAPI weight being > 64

Andrew Morton (1):
      revert "selftest: add simple test for soft-dirty bit"

Andy Adamson (1):
      NFSv4.1 Fix a pNFS session draining deadlock

Andy Grover (3):
      target: Remove unused struct members in se_dev_entry
      target: Use FD_MAX_SECTORS/FD_BLOCKSIZE for blockdevs using fileio
      target: Have dev/enable show if TCM device is configured

Andy Shevchenko (1):
      dma: acpi-dma: parse CSRT to extract additional resources

Aneesh Kumar K.V (3):
      powerpc/mm: Use the correct mask value when looking at pgtable address
      powerpc: Fix build errors STRICT_MM_TYPECHECKS
      mm/THP: use pmd_populate() to update the pmd with pgtable_t pointer

Anton Blanchard (1):
      powerpc/kexec: Fix kexec when using VMX optimised memcpy

Antonio Quartulli (2):
      batman-adv: make DAT drop ARP requests targeting local clients
      batman-adv: reorder clean up routine in order to avoid race conditions

Ard Biesheuvel (1):
      ARM: 7723/1: crypto: sha1-armv4-large.S: fix SP handling

Arend van Spriel (1):
      brcmfmac: announce P2P_DEVICE support in wiphy structure

Arnd Bergmann (4):
      staging/drm: imx: add missing dependencies
      staging/solo6x10: depend on CONFIG_FONTS
      mfd: ab8500: Debugfs code depends on gpadc
      USB: EHCI: remove bogus #error

Aron Xu (1):
      MIPS: N64: Wire getdents64(2)

Axel Lin (7):
      wm831x_backup: Fix wrong kfree call for devdata->backup.name
      pm2301_charger: Fix module alias prefix
      hwmon: (iio_hwmon) Fix missing iio_channel_release_all call if devm_k=
zalloc fail
      hwmon: (iio_hwmon) Fix null pointer dereference
      gpio: mcp23s08: Fix build error when CONFIG_SPI_MASTER=3Dy && CONFIG_=
I2C=3Dm
      gpio: Don't override the error code in probe error handling
      iio: dac: Fix build error when CONFIG_SPI_MASTER=3Dy && CONFIG_I2C=3Dm

Bastian Triller (1):
      ACPI / video: Add "Asus UL30A" to ACPI video detect blacklist

Ben Hutchings (7):
      sfc: Delete EFX_PAGE_IP_ALIGN, equivalent to NET_IP_ALIGN
      sfc: Reduce RX scatter buffer size, and reduce alignment if appropria=
te
      perf: net_dropmonitor: Fix trace parameter order
      perf: net_dropmonitor: Fix symbol-relative addresses
      perf: net_dropmonitor: Do not assume ordering of dictionaries
      perf: net_dropmonitor: Use bisection in symbol lookup
      perf: net_dropmonitor: Remove progress indicator

Ben Skeggs (9):
      drm/nouveau/bios: fix thinko in ZM_MASK_ADD opcode
      drm/nvc0/ce: disable ce1 on a number of chipsets
      drm/nvc0/ltcg: fix handling of disabled partitions
      drm/nve0/ltcg: poke the partition count into yet another register
      drm/nve0/fifo: prevent races between clients updating playlists
      drm/nvc0/fifo: prevent races between clients updating playlists
      drm/nvc0/fifo: prevent CHAN_TABLE_ERROR:CHANNEL_PENDING on fifo fini
      drm/nv50/fifo: prevent races between clients updating playlists
      drm/nouveau: ensure channels are stopped before saving fences for sus=
pend

Ben Widawsky (1):
      Revert "drm/i915: Calculate correct stolen size for GEN7+"

Benjamin Herrenschmidt (10):
      powerpc/powernv: Properly drop characters if console is closed
      powerpc/powernv: Improve kexec reliability
      powerpc/powernv: Detect OPAL v3 API version
      powerpc/powernv: Fix starting of secondary CPUs on OPALv2 and v3
      powerpc: Set show_unhandled_signals to 1 by default
      powerpc: Fix TLB cleanup at boot on POWER8
      powerpc/pci: Fix bogus message at boot about empty memory resources
      powerpc/powernv: Fix condition for when to invalidate the TCE cache
      powerpc: Make radeon 32-bit MSI quirk work on powernv
      powerpc/powernv: Build a zImage.epapr

Benjamin LaHaise (2):
      ipmi: ipmi_devintf: compat_ioctl method fails to take ipmi_mutex
      aio: fix kioctx not being freed after cancellation at exit time

Bing Zhao (1):
      mwifiex: clear is_suspended flag when interrupt is received early

Bjorn Helgaas (1):
      Revert "x86/pci/mrst: Use configuration mechanism 1 for 00:00.0, 00:0=
2.0, 00:03.0"

Bob Peterson (2):
      GFS2: two minor quota fixups
      GFS2: Use single-block reservations for directories

Boris BREZILLON (1):
      ARM: at91/dt: fix macb pinctrl_macb_rmii_mii_alt definition

Borislav Petkov (3):
      cpufreq, ondemand: Remove leftover debug line
      PM / hibernate: Correct documentation
      amd64_edac: Fix bogus sysfs file permissions

Brian Behlendorf (1):
      drivers/block/brd.c: fix brd_lookup_page() race

Brian King (1):
      powerpc/pseries: Make 32-bit MSI quirk work on systems lacking firmwa=
re support

Catalin Marinas (3):
      arm64: Invoke the of_platform_populate() at arch_initcall() level
      arm64: Do not source kernel/time/Kconfig explicitly
      ACPI / scan: Fix memory leak on acpi_scan_init_hotplug() error path

Charles Keepax (2):
      ASoC: soc-compress: Send correct stream event for capture start
      ASoC: wm5110: Correct DSP4R Mixer control name

Chen Gang (3):
      arm64: Fix duplicate definition of early_console
      drivers/char/ipmi: memcpy, need additional 2 bytes to avoid memory ov=
erflow
      net: irda: using kzalloc() instead of kmalloc() to avoid strncpy() is=
sue.

Chris Cummins (1):
      drm: Use names of ioctls in debug traces

Chris Mason (2):
      Btrfs: use a btrfs bioset instead of abusing bio internals
      Merge branch 'for-chris' of git://git.kernel.org/.../josef/btrfs-next

Chris Wilson (1):
      drm/i915: Always normalize return timeout for wait_timeout_ioctl

Christian Borntraeger (4):
      s390: disable pfmf for clear page instruction
      s390: fix gmap_ipte_notifier vs. software dirty pages
      s390/xpram: mark xpram as non-rotational
      s390/pgtable: fix ipte notify bit

Christian Gmeiner (1):
      drivers/leds/leds-ot200.c: fix error caused by shifted mask

Christian Ruppert (1):
      ARC: [TB10x] Remove redundant abilis,simple-pinctrl mechanism

Christopher Harvey (4):
      drm/mgag200: Don't change unrelated registers during modeset
      drm/mgag200: Fix writes into MGA1064_PIX_CLK_CTL register
      drm/mgag200: Convert counter delays to jiffies
      drm/mgag200: Fix framebuffer base address programming

Chuck Lever (1):
      NFS: Fix SETCLIENTID fallback if GSS is not available

Cliff Wickman (1):
      mm/pagewalk.c: walk_page_range should avoid VM_PFNMAP areas

Cong Wang (1):
      xfrm6: release dev before returning error

Corey Minyard (1):
      ipmi: Improve error messages on failed irq enable

Damien Lespiau (2):
      drm: Add missing break in the command line mode parsing code
      drm: Don't prune modes loudly when a connector is disconnected

Dan Carpenter (6):
      xen/privcmd: fix condition in privcmd_close()
      ntb: off by one sanity checks
      NTB: fix pointer math issues
      ipg: fix an unsigned widening cast of '~' truncation issue
      USB: cxacru: potential underflow in cxacru_cm_get_array()
      isdn/kcapi: fix a small underflow

Dan Magenheimer (1):
      staging: ramster: add how-to document

Dan Williams (1):
      USB: option: add device IDs for Dell 5804 (Novatel E371) WWAN card

Daniel Drake (1):
      mwifiex: fix setting of multicast filter

Daniel Mack (1):
      ASoC: davinci: fix sample rotation

Daniel Tang (1):
      ARM: 7712/1: Remove trailing whitespace in arch/arm/Makefile

Daniel Vetter (3):
      drm/mm: fix dump table BUG
      drm: don't check modeset locks in panic handler
      Revert "drm/i915: revert eDP bpp clamping code changes"

Darrick J. Wong (1):
      ttyprintk: Fix NULL pointer deref by setting tty_port ops after initi=
alizing port

Dave Airlie (11):
      Merge branch 'for-linux-next' of git://people.freedesktop.org/~danvet=
/drm-intel into drm-next
      drm: remove unused wrapper macros
      drm/qxl: fix ioport interactions for kernel submitted commands.
      qxl: drop unused variable.
      drm/qxl: drop active_user_framebuffer as its unneeded
      qxl: fix bug with object eviction and update area
      drm/radeon: restore nomodeset operation (v2)
      drm/nouveau: fix build with nv50->nvc0
      Merge branch 'drm-nouveau-fixes-3.10' of git://anongit.freedesktop.or=
g/git/nouveau/linux-2.6 into drm-next
      Merge branch 'drm-fixes-3.10' of git://people.freedesktop.org/~agd5f/=
linux into drm-next
      Merge branch 'drm-fixes-3.10-sun' of git://people.freedesktop.org/~ag=
d5f/linux into drm-next

Dave Chinner (7):
      xfs: fix sub-page blocksize data integrity writes
      xfs: fix rounding in xfs_free_file_space
      xfs: Don't reference the EFI after it is freed
      xfs: fix missing KM_NOFS tags to keep lockdep happy
      xfs: xfs_da3_node_read_verify() doesn't handle XFS_ATTR3_LEAF_MAGIC
      xfs: xfs_attr_shortform_allfit() does not handle attr3 format.
      xfs: remote attribute lookups require the value length

Dave Jones (1):
      Add missing module license tag to vring helpers.

David Cohen (1):
      gpio-langwell: fix irq conflicts when DT is not used

David Daney (3):
      Revert "MIPS: microMIPS: Support dynamic ASID sizing."
      Revert "MIPS: Allow ASID size to be determined at boot time."
      MIPS: Make virt_to_phys() work for all unmapped addresses.

David Rientjes (2):
      mfd: tps65912: Select MFD_CORE
      usb, chipidea: fix link error when USB_EHCI_HCD is a module

David S. Miller (9):
      Merge branch 'wireless'
      Merge branch 'qlcnic'
      Merge tag 'batman-adv-fix-for-davem' of git://git.open-mesh.org/linux=
-merge
      Merge branch 'master' of git://git.kernel.org/.../pablo/nf
      Merge tag 'batman-adv-fix-for-davem' of git://git.open-mesh.org/linux=
-merge
      Merge branch 'for-davem' of git://git.kernel.org/.../linville/wireless
      Merge branch 'perf_net_dropmonitor'
      Merge tag 'batman-adv-fix-for-davem' of git://git.open-mesh.org/linux=
-merge
      net: Revert unused variable changes.

David Sterba (1):
      btrfs: annotate quota tree for lockdep

David Woodhouse (1):
      powerpc: Provide __bswapdi2

Denis CIOCCA (1):
      iio:common:st: added disable function after read info raw data

Denis Efremov (4):
      ipv4: ip_output: remove inline marking of EXPORT_SYMBOL functions
      staging: nvec: remove inline marking of EXPORT_SYMBOL functions
      iwlegacy: remove inline marking of EXPORT_SYMBOL functions
      MIPS: MSP71xx: remove inline marking of EXPORT_SYMBOL functions

Dirk Behme (1):
      ARM i.MX6: correct MLB clock configuration

Dirk Brandewie (6):
      cpufreq / intel_pstate: remove idle time and duration from sample and=
 calculations
      cpufreq / intel_pstate: use lowest requested max performance
      cpufreq / intel_pstate: fix ffmpeg regression
      cpufreq / intel_pstate: Remove idle mode PID
      cpufreq / intel_pstate: remove #ifdef MODULE compile fence
      cpufreq / intel_pstate: Add additional supported CPU ID

Emilio L=C3=B3pez (4):
      ARM: ux500: select REGULATOR
      net: ethernet: apple: drop unused variable
      net: ethernet: korina: drop unused variable
      net: ethernet: sun: drop unused variable

Emmanuel Grumbach (2):
      iwlwifi: mvm: tell firmware to let multicast frames in
      iwlwifi: mvm: fix aggregation drain flow

Eric Dumazet (8):
      ipv6: do not clear pinet6 field
      tcp: fix tcp_md5_hash_skb_data()
      net/802/mrp: fix lockdep splat
      tcp: gso: do not generate out of order packets
      bonding: allow TSO being set on bonding master
      ipv6: fix possible crashes in ip6_cork_release()
      ip_gre: fix a possible crash in ipgre_err()
      tcp: xps: fix reordering issues

EunBong Song (1):
      MIPS: Fix build error for crash_dump.c in 3.10-rc1

Ezequiel Garcia (3):
      ARM: mvebu: Add a ranges entry to translate devbus childs
      ARM: mvebu: Fix ranges entry on XP GP board
      serial: 8250_dw: Add valid clk pointer check

Fabio Baltieri (5):
      mfd: abx500-core: Fix sparse warning
      mfd: ab8500-sysctrl: Fix sparse warning
      mfd: ab8500-sysctrl: Set sysctrl_dev during probe
      mfd: ab8500-sysctrl: Always enable pm_power_off handler
      mfd: ab8500-sysctrl: Let sysctrl driver work without pdata

Fabio Estevam (3):
      fec: Fix inconsistent lock state
      fec: Invert the order of function calls in fec_restart()
      staging: imx-drm: imx-tve: Check the return value of 'regulator_enabl=
e()'

Felix Fietkau (5):
      ath9k: fix key allocation error handling for powersave keys
      mac80211: fix spurious RCU warning and update documentation
      ath9k: fix aggregation stop/flush handling
      ath9k: fix rate handling/reporting
      ath9k: fix draining aggregation tid buffers

Florian Fainelli (1):
      broadcom: add include guards to include/linux/brcmphy.h

Gabriel de Perthuis (1):
      btrfs: don't stop searching after encountering the wrong item

Geert Uytterhoeven (14):
      iscsi-target: Make buf param of iscsit_do_crypto_hash_buf() const voi=
d *
      net/ethernet: NET_CALXEDA_XGMAC should depend on HAS_DMA
      net/ethernet: STMMAC_ETH should depend on HAS_DMA
      net/wireless: ATH9K should depend on HAS_DMA
      net/ethernet: ARM_AT91_ETHER should depend on HAS_DMA
      net/ethernet: MACB should depend on HAS_DMA
      caif: CAIF_VIRTIO should depend on HAS_DMA
      mfd: si476x: Do not use binary constants
      mfd: cros_ec_spi: Use %z to format pointer differences
      mfd: si476x: Use get_unaligned_be16() for unaligned be16 loads
      staging: zcache: Fix incorrect module_param_array types
      net/wireless: ATH9K should depend on HAS_DMA
      uio: UIO_DMEM_GENIRQ should depend on HAS_DMA
      fbdev: FB_GOLDFISH should depend on HAS_DMA

Gernot Vormayr (1):
      drivers/block/xsysace.c: fix id with missing port-number

Gomella, Andrew (NIH/NHLBI) [F] (1):
      USB: ftdi_sio: Add support for Newport CONEX motor drivers

Grant Likely (1):
      Merge branch 'for-next' of git://sources.calxeda.com/kernel/linux int=
o HEAD

Greg Kroah-Hartman (3):
      Merge tag 'fixes-for-v3.10-rc2' of git://git.kernel.org/.../balbi/usb=
 into usb-linus
      driver core: export subsys_virtual_register
      Merge tag 'iio-fixes-for-3.10a' of git://git.kernel.org/.../jic23/iio=
 into staging-linus

Gregory CLEMENT (3):
      ARM: mvebu: select ARCH_REQUIRE_GPIOLIB for mvebu platform
      ARM: plat-orion: Fix num_resources and id for ge10 and ge11
      ARM: dts: mvebu: Fix wrong the address reg value for the L2-cache node

Guenter Roeck (2):
      hwmon: (nct6775) Do not create non-existing attributes
      MAINTAINERS: Add myself as maintainer for LM95234 and TMP401 drivers

H Hartley Sweeten (1):
      staging: comedi: ni_labpc: fix build when VIRT_TO_BUS is not defined

Haiyang Zhang (1):
      MAINTAINERS: update Hyper-V file list

Hans Schillstrom (1):
      netfilter: log: netns NULL ptr bug when calling from conntrack

Hans-Christian Egtvedt (2):
      avr32: move NODES_SHIFT into Kconfig and delete numnodes.h
      avr32: fix relocation check for signed 18-bit offset

Hans-Christoph Schemmel (1):
      qmi_wwan: Added support for Cinterion's PLxx WWAN Interface

Heikki Krogerus (1):
      serial: 8250_dw: add ACPI ID for Intel BayTrail

Heiko Abraham (1):
      Input: egalax_ts - ABS_MT_POSITION_Y not reported well

Heiko Carstens (2):
      s390/disassembler: prevent endless loop in print_fn_code()
      s390/ftrace: fix mcount adjustment

Helge Deller (8):
      parisc: implement irq stacks - part 2 (v2)
      parisc: make default cross compiler search more robust (v3)
      MPILIB: disable usage of floating point registers on parisc
      parisc: add rp5470 entry to machine database
      parisc: use PAGE_SHIFT instead of hardcoded value 12 in pacache.S
      parisc: add additional parisc git tree to MAINTAINERS file
      parisc: show number of FPE and unaligned access handler calls in /pro=
c/interrupts
      parisc: fix irq stack on UP and SMP

Hema Prathaban (1):
      staging: vt6656: use free_netdev instead of kfree

Himanshu Madhani (2):
      qlcnic: Fix missing bracket in module parameter.
      qlcnic: Fix ethtool supported port status for 83xx

Ian Abbott (4):
      staging: comedi: allow buffer resize if previous resize failed
      staging: comedi: work without HAS_DMA
      staging: comedi: ni_mio_common: only do counter commands for ni_pcimio
      staging: comedi: complain if dma buffer allocation not supported

Ilan Peer (2):
      nl80211: Add wdev identifier to some nl80211 notifications
      iwlwifi: mvm: Always use SCAN_TYPE_FORCED

Imre Deak (2):
      drm/i915: hsw: fix link training for eDP on port-A
      wait: fix false timeouts when using wait_event_timeout()

Ingo Molnar (1):
      Merge branch 'rcu/doc' of git://git.kernel.org/.../paulmck/linux-rcu =
into core/urgent

Jaccon Bastiaansen (1):
      ARM: 7720/1: ARM v6/v7 cmpxchg64 shouldn't clear upper 32 bits of the=
 old/new value

Jan Kara (1):
      jbd,jbd2: fix oops in jbd2_journal_put_journal_head()

Jan-Simon M=C3=B6ller (1):
      ACPI: Fix section to __init. Align with usage in acpixf.h

Jani Nikula (1):
      drm/i915: clear the stolen fb before resuming

Jarod Wilson (1):
      drivers/char/random.c: fix priming of last_data

Jason Wang (1):
      virtio_net: enable napi for all possible queues during open

Jean Delvare (3):
      staging: Swap zram and zsmalloc in Kconfig
      i2c: i801: Document feature bits in modinfo
      hwmon: (tmp401) Drop redundant safety on cache lifetime

Jean-Christophe PLAGNIOL-VILLARD (3):
      ARM: at91/trivial: fix model name for SAM9X25-EK
      ARM: at91: rm9200 fix time support
      ARM: at91: at91sam9n12: move external irq declatation to DT

Jeff Layton (1):
      cifs: only set ops for inodes in I_NEW state

Jeff Mahoney (1):
      hfs: avoid crash in hfs_bnode_create

Jeff Moyer (1):
      aio: fix io_getevents documentation

Jiang Liu (1):
      avr32: fix building warnings caused by redefinitions of HZ

Jingoo Han (1):
      usb: gadget: s3c-hsotg: pass 'struct usb_request *' to usb_gadget_unm=
ap_request()

Jiri Kosina (1):
      random: fix accounting race condition with lockless irq entropy_count=
 update

Jiri Olsa (2):
      perf: Fix EXIT event notification
      perf: Factor out auxiliary events notification

Jiri Pirko (1):
      macvlan: fix passthru mode race between dev removal and rx path

Jiri Slaby (1):
      TTY: rocket, fix more no-PCI warnings

Joachim Eastwood (1):
      spi/atmel: fix speed_hz check in atmel_spi_transfer()

Joern Engel (2):
      target: removed unused transport_state flag
      target: close target_put_sess_cmd() vs. core_tmr_abort_task() race

Johan Hovold (7):
      USB: serial: add wait_until_sent operation
      USB: serial: add generic wait_until_sent implementation
      USB: ftdi_sio: clean up get_modem_status
      USB: ftdi_sio: fix chars_in_buffer overhead
      USB: io_ti: fix chars_in_buffer overhead
      USB: ti_usb_3410_5052: fix chars_in_buffer overhead
      USB: serial: clean up chars_in_buffer

Johannes Berg (9):
      cfg80211: fix wiphy_register error path
      cfg80211: fix WoWLAN wakeup tracing
      mac80211: fix IEEE80211_SDATA_DISCONNECT_RESUME
      mac80211: fix HT beacon-based channel switch handling
      mac80211: use just spin_lock() in ieee80211_get_tkip_p2k()
      mac80211: fix AP-mode frame matching
      cfg80211: fix interface down/disconnect state handling
      mac80211: report deauth to cfg80211 for local state change
      cfg80211: fix sending WoWLAN TCP wakeup settings

Johannes Weiner (1):
      mm: memcg: remove incorrect VM_BUG_ON for swap cache pages in uncharge

John David Anglin (2):
      parisc: fix SMP races when updating PTE and TLB entries in entry.S
      parisc: make interrupt and interruption stack allocation reentrant

John Stultz (1):
      time: Revert ALWAYS_USE_PERSISTENT_CLOCK compile time optimizaitons

John W. Linville (3):
      Merge branch 'master' of git://git.kernel.org/.../linville/wireless i=
nto for-davem
      Merge branch 'for-john' of git://git.kernel.org/.../iwlwifi/iwlwifi-f=
ixes
      Merge branch 'master' of git://git.kernel.org/.../linville/wireless i=
nto for-davem

Jon Hunter (1):
      gpio/omap: ensure gpio context is initialised

Jon Mason (8):
      NTB: variable dereferenced before check
      NTB: Handle 64bit BAR sizes
      NTB: Link toggle memory leak
      NTB: reset tx_index on link toggle
      NTB: Correctly handle receive buffers of the minimal size
      NTB: memcpy lockup workaround
      ntb_netdev: remove from list on exit
      NTB: Multiple NTB client fix

Jonathan Corbet (1):
      dummy-irq: require the user to specify an IRQ number

Joonsoo Kim (1):
      workqueue: correct handling of the pool spin_lock

Josef Ahmad (1):
      i2c: designware: fix RX FIFO overrun

Josef Bacik (4):
      Btrfs: don't null pointer deref on abort
      Btrfs: remove warn on in free space cache writeout
      Btrfs: handle running extent ops with skinny metadata
      Btrfs: make sure roots are assigned before freeing their nodes

Joseph Qi (2):
      ocfs2: unlock rw lock if inode lock failed
      ocfs2: goto out_unlock if ocfs2_get_clusters_nocache() failed in ocfs=
2_fiemap()

Josh Wu (1):
      ARM: at91/sama5: fix incorrect PMC pcr div definition

K. Y. Srinivasan (1):
      Drivers: hv: Fix a bug in get_vp_index()

Kees Cook (2):
      drm: refactor call to request_module
      drm/radeon: check incoming cliprects pointer

Kent Yoder (1):
      drivers/crypto/nx: Fixes for multiple races and issues

Kevin Hilman (1):
      idle: Fix hlt/nohlt command-line handling in new generic idle

Konrad Rzeszutek Wilk (11):
      x86/microcode: Add local mutex to fix physical CPU hot-add deadlock
      Merge tag 'v3.10-rc1' into stable/for-linus-3.10
      xen/tmem: Cleanup. Remove the parts that say temporary.
      xen/tmem: Move all of the boot and module parameters to the top of th=
e file.
      xen/tmem: Split out the different module/boot options.
      xen/tmem: Fix compile warning.
      xen/tmem: s/disable_// and change the logic.
      xen/tmem: Remove the boot options and fold them in the tmem.X paramet=
ers.
      xen/tmem: Remove the usage of 'noselfshrink' and use 'tmem.selfshrink=
' bool instead.
      xen/tmem: Remove the usage of '[no|]selfballoon' and use 'tmem.selfba=
llooning' bool instead.
      xen/tmem: Don't use self[ballooning|shrinking] if frontswap is off.

Kyle McMartin (1):
      score: remove redundant kcore_list entries

Lachlan McIlroy (1):
      ext4: limit group search loop for non-extent files

Lan Tianyu (2):
      ACPI / EC: Restart transaction even when the IBF flag set
      ACPI / AC: Add sleep quirk for Thinkpad e530

Larry Finger (1):
      rtlwifi: rtl8188ee: Fix warning when building on big-endian systems

Lars-Peter Clausen (2):
      tty: nwpserial: Pass correct pointer to free_irq()
      drivers/rtc/rtc-pl031.c: pass correct pointer to free_irq()

Laurent Pinchart (2):
      pinctrl: generic: Fix typos and clarify comments
      pinctrl/lantiq: Free mapping configs for both pin and groups

Lee Jones (12):
      ARM: 7714/1: mmc: mmci: Ensure return value of regulator_enable() is =
checked
      ARM: ux500: Remove duplicated assignment of ab8500_platdata
      ARM: ux500: Fix incorrect DEBUG UART virtual addresses
      ARM: ux500: Provide device enumeration number suffix for SMSC911x
      pinctrl: abx500: Specify failed sub-driver by ID instead of driver_da=
ta
      pinctrl: abx500: Rejiggle platform data and DT initialisation
      staging: ste_rmi4: Suppress 'ignoring return value of =E2=80=98regula=
tor_enable()' warning
      mfd: ab8500-gpadc: Suppress 'ignoring regulator_enable() return value=
' warning
      mfd: ab8500-core: Use the correct driver name when enabling gpio/pinc=
trl
      mfd: db8500-prcmu: Supply the pdata_size attribute for db8500-thermal
      mfd: ab8500-core: Pass GPADC compatible string to MFD core
      serial: pl011: protect attribute read from NULL platform data struct

Leonid Yegoshin (1):
      mm compaction: fix of improper cache flush in migration code

Lespiau, Damien (2):
      drm: Make the HPD status updates debug logs more readable
      drm: Only print a debug message when the polled connector has changed

Li Zhong (6):
      powerpc: Fix MAX_STACK_TRACE_ENTRIES too low warning again
      powerpc: Syscall hooks for context tracking subsystem
      powerpc: Exception hooks for context tracking subsystem
      powerpc: Exit user context on notify resume
      powerpc: Use the new schedule_user API on userspace preemption
      powerpc: select HAVE_CONTEXT_TRACKING for pSeries

Libo Chen (4):
      usb: ehci-s5p: fix memleak when fallback to pdata
      usb: isp1760-if: fix memleak when platform_get_resource fail
      usb: ohci: fix goto wrong tag in err case
      MIPS: Xway: Fix clk leak

Linus L=C3=BCssing (1):
      batman-adv: Fix rcu_barrier() miss due to double call_rcu() in TT code

Linus Torvalds (72):
      Merge tag 'fixes-for-linus' of git://git.kernel.org/.../rusty/linux
      Merge branch 'drm-next' of git://people.freedesktop.org/~airlied/linux
      Merge tag 'spi-v3.10-rc1' of git://git.kernel.org/.../broonie/spi
      Merge git://git.kernel.org/.../davem/net
      Merge branch 'parisc-for-3.10' of git://git.kernel.org/.../deller/par=
isc-linux
      Merge tag 'fixes-for-3.10-rc2-tag' of git://git.kernel.org/.../sstabe=
llini/xen
      Merge branch 'merge' of git://git.kernel.org/.../benh/powerpc
      Merge branch 'for-3.10-fixes' of git://git.kernel.org/.../tj/wq
      Merge tag 'ext4_for_linus_stable' of git://git.kernel.org/.../tytso/e=
xt4
      Merge branch 'for-linus' of git://git.kernel.org/.../sage/ceph-client
      Merge branch 'fixes' of git://git.linaro.org/people/rmk/linux-arm
      Merge branch 'core-urgent-for-linus' of git://git.kernel.org/.../tip/=
tip
      Merge branch 'timers-urgent-for-linus' of git://git.kernel.org/.../ti=
p/tip
      Merge branch 'perf-urgent-for-linus' of git://git.kernel.org/.../tip/=
tip
      Merge branch 'x86-urgent-for-linus' of git://git.kernel.org/.../tip/t=
ip
      Merge tag 'trace-fixes-v3.10-rc1' of git://git.kernel.org/.../rostedt=
/linux-trace
      Merge branch 'queue' of git://git.kernel.org/.../nab/target-pending
      Merge branch 'rcu/urgent' of git://git.kernel.org/.../paulmck/linux-r=
cu
      Merge branch 'for-3.10-fixes' of git://git.kernel.org/.../tj/wq
      Merge branch 'ipmi' (minor ipmi fixes from Corey)
      Merge tag 'ntb-bugfixes-3.10' of git://github.com/jonmason/ntb
      Merge tag 'pm+acpi-3.10-rc2' of git://git.kernel.org/.../rafael/linux=
-pm
      Merge branch 'drm-next' of git://people.freedesktop.org/~airlied/linux
      Merge tag 'sound-3.10' of git://git.kernel.org/.../tiwai/sound
      Merge tag 'arm64-fixes' of git://git.kernel.org/.../cmarinas/linux-aa=
rch64
      Merge tag 'kmemleak-fixes' of git://git.kernel.org/.../cmarinas/linux=
-aarch64
      Merge branch 'upstream' of git://git.linux-mips.org/pub/scm/ralf/upst=
ream-linus
      Merge tag 'devicetree-for-linus' of git://git.secretlab.ca/git/linux
      Merge branch 'devm_no_resource_check' of git://git.kernel.org/.../wsa=
/linux
      Merge branch 'for-linus' of git://git.kernel.org/.../mason/linux-btrfs
      Merge tag 'dm-3.10-fixes' of git://git.kernel.org/.../agk/linux-dm
      Merge branch 'rc-fixes' of git://git.kernel.org/.../mmarek/kbuild
      Merge tag 'pinctrl-fixes-v3.10-2' of git://git.kernel.org/.../linusw/=
linux-pinctrl
      x86: Fix bit corruption at CPU resume time
      Merge tag 'hwmon-for-linus' of git://git.kernel.org/.../groeck/linux-=
staging
      Merge tag 'stable/for-linus-3.10-rc1-tag' of git://git.kernel.org/...=
/konrad/xen
      Linux 3.10-rc2
      Merge branch 'drm-fixes' of git://people.freedesktop.org/~airlied/lin=
ux
      Merge branch 'drm-radeon-sun-hainan' of git://people.freedesktop.org/=
~airlied/linux
      Merge branch 'for-linus' of git://git.kernel.org/.../s390/linux
      Merge branch 'i2c/for-current' of git://git.kernel.org/.../wsa/linux
      Merge branch 'leds-fixes-3.10' of git://git.kernel.org/.../cooloney/l=
inux-leds
      Merge tag 'fixes-for-linus' of git://git.kernel.org/.../rusty/linux
      Merge tag 'mfd-fixes-3.10-1' of git://git.kernel.org/.../sameo/mfd-fi=
xes
      Merge branch 'upstream' of git://git.linux-mips.org/pub/scm/ralf/upst=
ream-linus
      Merge branch 'for-linus' of git://git.kernel.org/.../egtvedt/linux-av=
r32
      Merge git://git.kernel.org/pub/scm/virt/kvm/kvm
      Merge tag 'usb-3.10-rc2' of git://git.kernel.org/.../gregkh/usb
      Merge tag 'char-misc-3.10-rc2' of git://git.kernel.org/.../gregkh/cha=
r-misc
      Merge tag 'driver-core-3.10-rc2' of git://git.kernel.org/.../gregkh/d=
river-core
      Merge tag 'staging-3.10-rc2' of git://git.kernel.org/.../gregkh/stagi=
ng
      Merge tag 'tty-3.10-rc2' of git://git.kernel.org/.../gregkh/tty
      Merge branch 'for-linus' of git://git.kernel.org/.../dtor/input
      Merge tag 'pci-v3.10-fixes-2' of git://git.kernel.org/.../helgaas/pci
      Merge tag 'gpio-fixes-v3.10-1' of git://git.kernel.org/.../linusw/lin=
ux-gpio
      Merge git://git.kernel.org/.../davem/net
      Merge branch 'merge' of git://git.kernel.org/.../benh/powerpc
      Merge git://git.kernel.org/.../steve/gfs2-3.0-fixes
      Merge branch 'for-next' of git://git.samba.org/sfrench/cifs-2.6
      Merge tag 'trace-fixes-v3.10-rc2' of git://git.kernel.org/.../rostedt=
/linux-trace
      Merge tag 'fixes-for-linus' of git://git.kernel.org/.../arm/arm-soc
      Merge branch 'akpm' (incoming from Andrew Morton)
      Merge branch 'fixes' of git://git.linaro.org/people/rmk/linux-arm
      Merge tag 'arc-v3.10-fixes' of git://git.kernel.org/.../vgupta/arc
      Merge branch 'fixes' of git://git.infradead.org/users/vkoul/slave-dma
      Merge tag 'pm+acpi-3.10-rc3' of git://git.kernel.org/.../rafael/linux=
-pm
      Merge tag 'for-v3.10-fixes' of git://git.infradead.org/battery-2.6
      Merge tag 'for-linus-v3.10-rc3' of git://oss.sgi.com/xfs/xfs
      Merge branch 'parisc-for-3.10' of git://git.kernel.org/.../deller/par=
isc-linux
      Merge tag 'edac_fixes_for_3.10' of git://git.kernel.org/.../bp/bp
      Merge tag 'nfs-for-3.10-3' of git://git.linux-nfs.org/projects/trondm=
y/linux-nfs
      Linux 3.10-rc3

Linus Walleij (2):
      mfd: ab8500: Pass AB8500 IRQ to debugfs code by resource
      ARM: nomadik: fix IRQ assignment for SMC ethernet

Lisa Nguyen (3):
      xen/xenbus: Fixed indentation error in switch case
      xen/xenbus: Fixed over 80 character limit issue
      xen: Fixed assignment error in if statement

Liu Bo (2):
      Btrfs: fix off-by-one in fiemap
      Btrfs: return errno if possible when we fail to allocate memory

Lucas Stach (2):
      clk: tegra: remove USB from clk init table
      clk: tegra: add ac97 controller clock

Ludovic Desroches (1):
      ARM: at91: dts: request only spi cs-gpios used on sama5d3x cpu module

Luiz Capitulino (1):
      package: Makefile: unbreak binrpm-pkg target

Malcolm Priestley (1):
      staging: vt6656: [bug] Fix missing spin lock in iwctl_siwpower.

Manfred Spraul (1):
      ipc/sem.c: Fix missing wakeups in do_smart_update_queue()

Manish Chopra (2):
      qlcnic: Fix setting MAC address
      qlcnic: Fix bug in diagnostics test reset recovery path

Manjunathappa, Prakash (1):
      spi/davinci: fix module build error

Marc Dietrich (3):
      staging: nvec: add missing module aliases
      staging: nvec: implement unregistering of notifiers
      staging: nvec: cleanup childs on remove

Marc Dionne (1):
      workqueue: Make schedule_work() available again to non GPL modules

Marek Lindner (2):
      batman-adv: check proto length before accessing proto string buffer
      batman-adv: check return value of pskb_trim_rcsum()

Marek Vasut (1):
      staging: video: imx: Select VIDEOMODE_HELPERS for parallel display

Mark Brown (11):
      Merge branch 'spi/merge' of git://git.secretlab.ca/git/linux into spi=
-fix-grant
      Merge remote-tracking branch 'spi/fix/atmel' into spi-linus
      Merge remote-tracking branch 'spi/fix/grant' into spi-linus
      ASoC: wm5110: Add missing speaker initialisation
      ASoC: wm8994: Fix reporting of accessory removal on WM8958
      Merge remote-tracking branch 'asoc/fix/arizona' into asoc-linus
      Merge remote-tracking branch 'asoc/fix/compress' into asoc-linus
      Merge remote-tracking branch 'asoc/fix/cs42l52' into asoc-linus
      Merge remote-tracking branch 'asoc/fix/davinci' into asoc-linus
      Merge remote-tracking branch 'asoc/fix/max98090' into asoc-linus
      Merge remote-tracking branch 'asoc/fix/wm8994' into asoc-linus

Martin Hundeb=C3=B8ll (1):
      batman-adv: Avoid double freeing of bat_counters

Martin Michlmayr (1):
      Kirkwood: Enable PCIe port 1 on QNAP TS-11x/TS-21x

Martin Schwidefsky (1):
      s390/smp: fix cpu re-scan vs. cpu state

Masami Hiramatsu (5):
      tracing/kprobes: Use rcu_dereference_raw for tp->files
      tracing/kprobes: Fix a sparse warning for incorrect type in assignment
      tracing/kprobes: Make print_*probe_event static
      tracing: Return -EBUSY when event_enable_func() fails to get module
      kprobes/mips: Fix to check double free of insn slot

Matthijs Kooijman (2):
      MIPS: ralink: use the dwc2 driver for the rt305x USB controller
      staging: dwc2: Fix dma-enabled platform devices using a default dma_m=
ask

Matwey V. Kornilov (2):
      tty: mxser: fix usage of opmode_ioaddr
      tty: mxser: Fix build warning introduced by dfc7b837c7f9 (Re: linux-n=
ext: build warning after merge of the tty.current tree)

Maxime Ripard (3):
      ARM: sunxi: Fix Mini X-plus device tree build
      ARM: sunxi: select ARCH_REQUIRE_GPIOLIB
      gpio: mxs: Use set and clear capabilities of the gpio controller

Miao Xie (10):
      Btrfs: don't abort the current transaction if there is no enough spac=
e for inode cache
      Btrfs: don't use global block reservation for inode cache truncation
      Btrfs: optimize the error handle of use_block_rsv()
      Btrfs: don't steal the reserved space from the global reserve if thei=
r space type is different
      Btrfs: update the global reserve if it is empty
      Btrfs: fix accessing a freed tree root
      Btrfs: fix unprotected root node of the subvolume's inode rb-tree
      Btrfs: pause the space balance when remounting to R/O
      Btrfs: remove BUG_ON() in btrfs_read_fs_tree_no_radix()
      Btrfs: don't invoke btrfs_invalidate_inodes() in the spin lock context

Michael Chan (1):
      tg3: Fix data corruption on 5725 with TSO

Michael Ellerman (2):
      powerpc: Make CONFIG_RTAS_PROC depend on CONFIG_PROC_FS
      powerpc: Context switch more PMU related SPRs

Michael Grzeschik (1):
      usb: otg: mxs-phy: add missing type to usb_phy

Michael Neuling (3):
      powerpc/perf: Move BHRB code into CONFIG_PPC64 region
      powerpc/pmu: Fix order of interpreting BHRB target entries
      powerpc/perf: Fix setting of "to" addresses for BHRB

Michael S. Tsirkin (1):
      virtio_console: fix uapi header

Micha=C5=82 Miros=C5=82aw (1):
      staging/iio/mxs-lradc: fix preenable for multiple buffers

Mika Westerberg (2):
      i2c: designware: always clear interrupts before enabling them
      i2c: designware: add Intel BayTrail ACPI ID

Nandita Dukkipati (1):
      tcp: bug fix in proportional rate reduction.

Naveen Krishna Chatradhi (1):
      iio: exynos_adc: fix wrong structure extration in suspend and resume

Nicholas Bellinger (5):
      iscsi-target: Fix NULL pointer dereference in iscsit_send_reject
      target/rd: Add ramdisk bit for NULLIO operation
      iscsi-target: Fix typos in RDMAEXTENSIONS macro usage
      MAINTAINERS: Update target git tree URL
      target/iblock: Fix WCE=3D1 + DPOFUA=3D1 backend WRITE regression

Nicolas Ferre (2):
      ARM: at91/trivial: typo in GEM compatible string
      net/macb: fix ISR clear-on-write behavior only for some SoC

Nicolas Pitre (1):
      ARM: 7715/1: MCPM: adapt to GIC changes after upstream merge

Nicolas Schichan (4):
      ASoC: cs42l52: microphone bias is controlled by IFACE_CTL2 register.
      ASoC: cs42l52: fix bogus shifts in "Speaker Volume" and "PCM Mixer Vo=
lume" controls.
      ASoC: cs42l52: fix master playback mute mask.
      ASoC: cs42l52: fix default value for MASTERA_VOL.

Niels Ole Salscheider (2):
      drm/radeon: Remove superfluous variable
      drm/radeon: Fix VRAM size calculation for VRAM >=3D 4GB

Nishanth Menon (1):
      cpufreq: cpufreq-cpu0: defer probe when regulator is not ready

Nithin Sujir (3):
      tg3: Skip powering down function 0 on certain serdes devices
      tg3: Ensure boot code has completed initialization before accessing h=
ardware
      tg3: Update version to 3.132

OGAWA Hirofumi (1):
      fat: fix possible overflow for fat_clusters

Oleg Nesterov (1):
      usermodehelper: check subprocess_info->path !=3D NULL

Oliver Neukum (1):
      USB: reset resume quirk needed by a hub

Olof Johansson (10):
      Merge tag 'fixes-3.10-1' of git://git.infradead.org/users/jcooper/lin=
ux into fixes
      Merge tag 'at91-fixes' of git://github.com/at91linux/linux-at91 into =
fixes
      Merge tag 'omap-for-v3.10-rc1/fixes' of git://git.kernel.org/.../tmli=
nd/linux-omap into fixes
      Merge tag 'fixes-3.10-2' of git://git.infradead.org/users/jcooper/lin=
ux into fixes
      Merge tag 'imx-fixes-3.10' of git://git.linaro.org/people/shawnguo/li=
nux-2.6 into fixes
      Merge tag 'ux500-arm-soc-v3.10-fixes' of git://git.kernel.org/.../lin=
usw/linux-stericsson into fixes
      Merge tag 'omap-fixes-a-for-3.10-rc' of git://git.kernel.org/.../pjw/=
omap-pending into fixes
      Merge tag 'renesas-boards-marzen-fixes-for-v3.10' of git://git.kernel=
=2Eorg/.../horms/renesas into fixes
      Merge tag 'at91-fixes' of git://github.com/at91linux/linux-at91 into =
fixes
      Merge tag 'sunxi-fixes-for-3.10' of git://github.com/mripard/linux in=
to fixes

Or Gerlitz (1):
      net/mlx4_core: Add missing report on VST and spoof-checking dev caps

Pablo Neira Ayuso (3):
      netfilter: nf_{log,queue}: fix compilation without CONFIG_PROC_FS
      netfilter: update MAINTAINERS file
      netfilter: xt_TCPOPTSTRIP: fix possible mangling beyond packet bounda=
ry

Paolo Bonzini (1):
      KVM: take over co-maintainership from Marcelo, fix MAINTAINERS entry

Paul Bolle (1):
      usb: phy: remove CONFIG_USB_OTG_UTILS once more

Paul E. McKenney (2):
      kthread: Document ways of reducing OS jitter due to per-CPU kthreads
      rcu: Fix comparison sense in rcu_needs_cpu()

Paul Moore (1):
      netlabel: improve domain mapping validation

Paul Walmsley (1):
      ARM: OMAP2+: Add missing CONFIG_ARCH_MULTI_V6=3Dy to omap2plus_defcon=
fig

Paul Zimmerman (1):
      staging: dwc2: remove compile warning for USB_DWC2_TRACK_MISSED_SOFS

Peter Huewe (1):
      parisc/superio: Use module_pci_driver to register driver

Peter Hurley (1):
      tty/vt: Fix vc_deallocate() lock order

Peter Oberparleiter (1):
      s390/cio: add channel ID sysfs attribute

Petko Manolov (1):
      drivers: net: usb: rtl8150: concurrent URB bugfix

Petri Gynther (1):
      emac: Fix EMAC soft reset on 460EX/GT

Philipp Zabel (1):
      ARM i.MX6q: Fix periph_clk2_sel and periph2_clk2_sel clocks

Ping Cheng (3):
      Input: wacom - add three new display tablets
      Input: wacom - add a few new styli for Cintiq series
      Input: wacom - add an eraser to DTH2242/DTK2241

Rafael J. Wysocki (10):
      ACPI / PM: Move processor suspend/resume to syscore_ops
      ACPI / LPSS: register clock device for Lynxpoint DMA properly
      Merge branch 'pm-cpufreq'
      Merge branch 'acpi-fixes'
      Merge branch 'pm-fixes'
      Merge branch 'pm-cpufreq'
      Merge branch 'acpi-fixes'
      ACPI / PM: Allow device power states to be used for CONFIG_PM unset
      Merge branch 'acpi-fixes'
      Merge branch 'pm-cpufreq'

Rafa=C5=82 Bilski (1):
      cpufreq / e_powersaver: Fix linker error when ACPI processor is a mod=
ule

Rafa=C5=82 Mi=C5=82ecki (1):
      bcma: add more core IDs

Rahul Sharma (1):
      of/documentation: move video device bindings to a common place

Rajendra Nayak (2):
      ARM: OMAP2+: hwmod: Fix sidle programming in _enable_sysc()/_idle_sys=
c()
      ARM: OMAP2+: hwmod: Add a new flag to handle SIDLE in SWSUP only in a=
ctive

Rajesh Borundia (2):
      qlcnic: Fix mailbox response handling.
      qlcnic: Fix validation of link event command.

Ralf Baechle (13):
      MIPS: Rewrite pfn_valid to work in modules, too.
      Add include dependencies to <linux/printk.h>.
      MIPS: clock.h: Remove declaration of cpu_wait.
      MIPS: Consolidate idle loop / WAIT instruction support in a single fi=
le.
      MIPS: Idle: cleaup SMTC idle hook as per Linux coding style.
      MIPS: Idle: Consistently reformat inline assembler.
      MIPS: Idle: Make call of function pointer readable.
      MIPS: Idle: Re-enable irqs at the end of r3081, au1k and loongson2 cp=
u_wait.
      MIPS: Idle: Don't call local_irq_disable() in cpu_wait() implementati=
ons.
      MIPS: Idle: Consolidate all declarations in <asm/idle.h>.
      MIPS: Idle: Do address fiddlery in helper functions.
      MIPS: Idle: Break r4k_wait into two functions and fix it.
      mm: Fix virt_to_page() warning

Randy Dunlap (7):
      lp8788-charger: Fix kconfig dependency
      staging: sep: fix driver build and kconfig
      lib: make iovec obj instead of lib
      GFS2: fix DLM depends to fix build errors
      linux/kernel.h: fix kernel-doc warning
      auditfilter.c: fix kernel-doc warnings
      mm/memory_hotplug.c: fix printk format warnings

Richard Genoud (1):
      spi/spi-atmel: BUG: fix doesn' support 16 bits transfers using PIO

Rob Herring (1):
      Merge tag 'tegra-for-3.10-dtc-cpp-chroot-std-headers' of git://git.ke=
rnel.org/.../swarren/linux-tegra into for-next

Robert Jarzmik (1):
      usb: phy: Fix NULL pointer exception during usb_get_phy

Robert Jennings (1):
      powerpc: Bring all threads online prior to migration/hibernation

Robert P. J. Day (2):
      Correct typo "supperspeed" to "superspeed".
      Add a couple kernel-doc lines to prevent warnings.

Rony Efraim (1):
      net/mlx4: Strengthen VLAN tags/priorities enforcement in VST mode

Russell King (3):
      ARM: finally enable IRQ time accounting config
      NET: mv643xx_eth: avoid lockdep dump on interface down
      i2c: mv64xxx: work around signals causing I2C transactions to be abor=
ted

Rusty Russell (2):
      lguest: clear cached last cpu when guest_set_pgd() called.
      Hoist memcpy_fromiovec/memcpy_toiovec into lib/

Ryusuke Konishi (1):
      nilfs2: fix issue of nilfs_set_page_dirty() for page at EOF boundary

Sachin Kamat (12):
      usb: gadget: atmel_usba_udc: Remove redundant platform_set_drvdata()
      usb: gadget: bcm63xx_udc: Remove redundant platform_set_drvdata()
      usb: gadget: dummy_hcd: Remove redundant platform_set_drvdata()
      usb: gadget: f_uac2: Remove redundant platform_set_drvdata()
      usb: gadget: imx_udc: Remove redundant platform_set_drvdata()
      usb: gadget: pxa25x_udc: Remove redundant platform_set_drvdata()
      usb: gadget: s3c2410_udc: Remove redundant platform_set_drvdata()
      usb: phy: ab8500-usb: Remove redundant platform_set_drvdata()
      usb: phy: gpio-vbus-usb: Remove redundant platform_set_drvdata()
      usb: phy: mv-usb: Remove redundant platform_set_drvdata()
      usb: phy: mxs-usb: Remove redundant platform_set_drvdata()
      usb: phy: nop: Remove redundant platform_set_drvdata()

Samuel Ortiz (1):
      mei: bus: Reset event_cb when disabling a device

Sanjay Lal (2):
      KVM/MIPS32: Move include/asm/kvm.h =3D> include/uapi/asm/kvm.h since =
it is a user visible API.
      KVM/MIPS32: Wrap calls to gfn_to_pfn() with srcu_read_lock/unlock()

Santosh Shilimkar (4):
      ARM: OMAP2+: hwmod-data: UART IP needs software control to manage sid=
le modes
      ARM: OMAP2+: serial: Remove the un-used slave idle hooks
      SERIAL: OMAP: Remove the slave idle handling from the driver
      ARM: OMAP2+: hwmod: Remove sysc slave idle and auto idle apis

Sarveshwar Bandi (1):
      be2net: Avoid double insertion of vlan tags.

Sasha Levin (2):
      rcu: Don't allocate bootmem from rcu_init()
      mac80211_hwsim: correctly register the platform driver

Schemmel Hans-Christoph (1):
      USB: Blacklisted Cinterion's PLxx WWAN Interface

Scott Wood (2):
      powerpc: hard_irq_disable(): Call trace_hardirqs_off after disabling
      powerpc/booke64: Fix kernel hangs at kernel_dbg_exc

Sebastian Hesselbarth (2):
      ARM: 7711/1: dove: fix Dove cpu type from V7 to PJ4
      ARM: plat-orion: add missing ehci include to common.h

Sergei Shtylyov (2):
      <linux/of_platform.h>: fix compilation warnings with DT disabled
      3c59x: fix PCI resource management

Shahed Shaikh (2):
      qlcnic: Fix ethtool strings
      qlcnic: Fix updating netdev->features

Shawn Guo (4):
      net: fec: enable hardware checksum only on imx6q-fec
      ARM: imx: replicate the diagnostic register of boot cpu into secondar=
y cores
      ARM: imx: fix typo in gpu3d_shader_sels
      net: fec: use a more proper compatible string for MVF type device

Shlomo Pongratz (1):
      iscsi-target: Fix processing of OOO commands

Shuah Khan (1):
      PM: Avoid calling kfree() under spinlock in dev_pm_put_subsys_data()

Simon Horman (1):
      ARM: shmobile: marzen: Use error values in usb_power_*

Sony Chacko (3):
      qlcnic: Fix reset recovery after transmit timeout
      qlcnic: Return proper error codes from probe failure paths
      qlcnic: remove netdev->trans_start updates within the driver

Sridhar Samudrala (1):
      vxlan: Update vxlan fdb 'used' field after each usage

Srinivas Kandagatla (1):
      ARM: vt8500: Add missing NULL terminator in dt_compat

Srivatsa S. Bhat (2):
      rcu/idle: Wrap cpu-idle poll mode within rcu_idle_enter/exit
      cpufreq: Preserve sysfs files across suspend/resume

Stanislaw Gruszka (2):
      ath5k: do not reschedule tx_complete_work on stop
      iwl4965: workaround connection regression on passive channel

Stefan Behrens (3):
      Btrfs: don't allow device replace on RAID5/RAID6
      Btrfs: fix possible memory leak in replace_path()
      Btrfs: explicitly use global_block_rsv for quota_tree

Stefano Stabellini (3):
      xen/arm: initialize pm functions later
      xen/arm: do not handle VCPUOP_register_vcpu_info failures
      xen/arm: rename xen_secondary_init and run it on every online cpu

Stephen Boyd (1):
      ARM: smp: Drop RCU_NONIDLE usage in cpu_die()

Stephen Warren (2):
      USB: set device dma_mask without reference to global data
      drivers/video: implement a simple framebuffer driver

Steven Capper (1):
      ARM: 7727/1: remove the .vm_mm value from gate_vma

Steven Rostedt (2):
      kmemleak: Scan all allocated, writeable and not executable module sec=
tions
      kmemleak: No need for scanning specific module sections

Steven Rostedt (Red Hat) (1):
      tracing: Fix leaks of filter preds

Steven Whitehouse (1):
      GFS2: Fix typo in gfs2_log_end_write loop

Sujith Manoharan (4):
      ath9k: Fix beacon reconfiguration
      ath9k: Update initvals for AR9565
      ath9k: Fix crash on module unload
      ath9k_hw: Enable manual peak calibration for AR9485

Sukanto Ghosh (1):
      arm64: mm: Fix operands of clz in __flush_dcache_all

Tang Yuantian (1):
      of/base: release the node correctly in of_parse_phandle_with_args()

Tejun Heo (2):
      workqueue: workqueue_congested() shouldn't translate WORK_CPU_UNBOUND=
 into node number
      workqueue: don't perform NUMA-aware allocations on offline nodes in w=
q_numa_init()

Teppo Kotilainen (1):
      usb: option: Add Telewell TW-LTE 4G

Thadeu Lima de Souza Cascardo (1):
      qlge: fix dma map leak when the last chunk is not allocated

Theodore Ts'o (1):
      ext4: revert "ext4: use io_end for multiple bios"

Thomas Gleixner (5):
      Merge branch 'linus' into core/urgent
      tick: Use zalloc_cpumask_var for allocating offstack cpumasks
      x86: Fix idle consolidation fallout
      tick: Cleanup NOHZ per cpu data on cpu down
      tick: Don't invoke tick_nohz_stop_sched_tick() if the cpu is offline

Thomas Petazzoni (2):
      ARM: mvebu: do not duplicate the mpic alias
      arm: mvebu: fix the 'ranges' property to handle PCIe

Thommy Jakobsson (1):
      B43: Handle DMA RX descriptor underrun

Timo Ter=C3=A4s (2):
      leds: leds-gpio: reserve gpio before using it
      xfrm: properly handle invalid states as an error

Tirupathi Reddy (1):
      timer: Don't reinitialize the cpu base lock during CPU_UP_PREPARE

Tomas Winkler (1):
      mei: fix out of array access to me clients array

Tomasz Figa (1):
      drivers/rtc/rtc-max8998.c: check for pdata presence before dereferenc=
ing

Tony Lindgren (1):
      ARM: dts: Fix musb interrupt for device tree booting

Tony Prisk (1):
      pinctrl: vt8500: Fix incorrect data in WM8750 pinctrl table

Tony Wu (2):
      MIPS: Fix sibling call handling in get_frame_info
      MIPS: Extract schedule_mfi info from __schedule

Trond Myklebust (4):
      SUNRPC: Fix a bug in gss_create_upcall
      SUNRPC: Faster detection if gssd is actually running
      SUNRPC: Convert auth_gss pipe detection to work in namespaces
      SUNRPC: Prevent an rpc_task wakeup race

Ulf Hansson (1):
      mfd: db8500-prcmu: Update stored DSI PLL divider value

Uwe Kleine-K=C3=B6nig (1):
      Documentation/devicetree: make semantic of initrd-end more explicit

Vaibhav Hiremath (1):
      ARM: AM33XX: Add missing .clkdm_name to clkdiv32k_ick clock

Vasant Hegde (1):
      powerpc/rtas_flash: Fix validate_flash buffer overflow issue

Ville Syrj=C3=A4l=C3=A4 (3):
      drm/i915: Fix pipe enabled mask for pipe C in WM calculations
      drm: Add kernel-doc for drm_fb_helper_funcs->initial_config
      drm: Remove pointless '-' characters from drm_fb_helper documentation

Vineet Gupta (5):
      ARC: [mm] Prevent stray dcache lines after__sync_icache_dcach()
      ARC: copy_(to|from)_user() to honor usermode-access permissions
      ARC: Brown paper bag bug in macro for checking cache color
      ARC: Use enough bits for determining page's cache color
      ARC: lazy dcache flush broke gdb in non-aliasing configs

Vinod Koul (2):
      ASoC: wm8994: use the correct pointer to get the control value
      ASoC: wm8994: check for array index returned

Viresh Kumar (12):
      cpufreq: ARM big LITTLE: Select PM_OPP
      cpufreq: ARM big LITTLE DT: Return correct transition latency
      cpufreq: ARM big LITTLE DT: Return CPUFREQ_ETERNAL if clock-latency i=
sn't found
      cpufreq: ARM big LITTLE: Move cpu_to_cluster() to arm_big_little.h
      cpufreq: ARM big LITTLE: Improve print message
      cpufreq: governors: Fix CPUFREQ_GOV_POLICY_{INIT|EXIT} notifiers
      cpufreq: Issue CPUFREQ_GOV_POLICY_EXIT notifier before dropping polic=
y refcount
      cpufreq: cpufreq-cpu0: Free parent node for error cases
      cpufreq: ARM big LITTLE: Fix Kconfig entries
      cpufreq: Drop rwsem lock around CPUFREQ_GOV_POLICY_EXIT
      cpufreq: arm_big_little_dt: Register driver only if DT has valid data
      cpufreq: arm_big_little_dt: Instantiate as platform_driver

Vivek Gautam (1):
      usb: dwc3: Fix compilation break when building with USB_DWC3_DUAL_ROL=
E=3Dy

Wang Shilong (1):
      Btrfs: fix possible memory leak in the find_parent_nodes()

Wang YanQing (1):
      TTY: Fix tty miss restart after we turn off flow-control

Wei WANG (1):
      USB: usb-stor: realtek_cr: Fix compile error

Wei Yang (1):
      be2net: bug fix on returning an invalid nic descriptor

Wei Yongjun (20):
      hwmon: fix error return code in abituguru_probe()
      bna: add missing iounmap() on error in bnad_init()
      cpufreq / intel_pstate: use vzalloc() instead of vmalloc()/memset(0)
      pinctrl: single: fix error return code in pcs_parse_one_pinctrl_entry=
()
      usb: gadget: zero: fix error return code in zero_bind()
      usb: musb: omap2430: add missing platform_device_put() on error in om=
ap2430_probe()
      usb: musb: dsps: fix error return code in dsps_create_musb_pdev()
      usb: gadget: s3c2410_udc: fix error return code in s3c2410_udc_probe()
      usb: gadget: r8a66597-udc: fix error return code in r8a66597_probe()
      usb: gadget: m66592-udc: fix error return code in m66592_probe()
      usb: gadget: fusb300_udc: fix error return code in fusb300_probe()
      usb: gadget: dummy_hcd: fix error return code in init()
      usb: gadget: fix error return code in configfs_composite_bind()
      ARM: OMAP: fix error return code in omap1_system_dma_init()
      gianfar: add missing iounmap() on error in gianfar_ptp_probe()
      serial: samsung: add missing platform_driver_unregister() when module=
 exit
      tty: serial: mpc5xxx: fix error handing in mpc52xx_uart_init()
      serial: mcf: missing uart_unregister_driver() on error in mcf_init()
      TTY: ehv_bytechan: add missing platform_driver_unregister() when modu=
le exit
      staging:iio:light:tsl2x7x: fix the error handling in tsl2x7x_probe()

Will Deacon (3):
      arm64: debug: clear mdscr_el1 instead of taking the OS lock
      arm64: debug: fix mdscr.ss check when enabling debug exceptions
      ARM: 7729/1: vfp: ensure VFP_arch is non-zero when VFP is not support=
ed

Wolfram Sang (36):
      cpufreq / kirkwood: don't check resource with devm_ioremap_resource
      drivers/ata: don't check resource with devm_ioremap_resource
      drivers/char/hw_random: don't check resource with devm_ioremap_resour=
ce
      usb: gadget: don't check resource with devm_ioremap_resource
      usb: phy: don't check resource with devm_ioremap_resource
      drivers/cpufreq: don't check resource with devm_ioremap_resource
      drivers/dma: don't check resource with devm_ioremap_resource
      drivers/gpio: don't check resource with devm_ioremap_resource
      drivers/gpu/drm/exynos: don't check resource with devm_ioremap_resour=
ce
      drivers/gpu/host1x/drm: don't check resource with devm_ioremap_resour=
ce
      drivers/i2c/busses: don't check resource with devm_ioremap_resource
      drivers/memory: don't check resource with devm_ioremap_resource
      drivers/mfd: don't check resource with devm_ioremap_resource
      drivers/misc: don't check resource with devm_ioremap_resource
      drivers/mtd/nand: don't check resource with devm_ioremap_resource
      drivers/net/ethernet/renesas: don't check resource with devm_ioremap_=
resource
      drivers/pinctrl: don't check resource with devm_ioremap_resource
      drivers/pwm: don't check resource with devm_ioremap_resource
      drivers/rtc: don't check resource with devm_ioremap_resource
      drivers/spi: don't check resource with devm_ioremap_resource
      drivers/staging/dwc2: don't check resource with devm_ioremap_resource
      drivers/staging/nvec: don't check resource with devm_ioremap_resource
      drivers/thermal: don't check resource with devm_ioremap_resource
      drivers/usb/chipidea: don't check resource with devm_ioremap_resource
      drivers/usb/gadget: don't check resource with devm_ioremap_resource
      drivers/usb/host: don't check resource with devm_ioremap_resource
      drivers/usb/phy: don't check resource with devm_ioremap_resource
      drivers/video/omap2: don't check resource with devm_ioremap_resource
      drivers/video/omap2/dss: don't check resource with devm_ioremap_resou=
rce
      drivers/w1/masters: don't check resource with devm_ioremap_resource
      drivers/watchdog: don't check resource with devm_ioremap_resource
      arch/arm/mach-tegra: don't check resource with devm_ioremap_resource
      arch/arm/plat-samsung: don't check resource with devm_ioremap_resource
      arch/mips/lantiq/xway: don't check resource with devm_ioremap_resource
      sound/soc/fsl: don't check resource with devm_ioremap_resource
      sound/soc/kirkwood: don't check resource with devm_ioremap_resource

Xiao Guangrong (1):
      mm: mmu_notifier: re-fix freed page still mapped in secondary MMU

Xiong Zhou (2):
      bq27x00: Fix I2C dependency in KConfig
      staging: android: logger: use kuid_t instead of uid_t

Yan, Zheng (1):
      ext4: fix fio regression

Yinghai Lu (1):
      PCI: acpiphp: Re-enumerate devices when host bridge receives Bus Check

Yuval Mintz (1):
      bnx2x: Fix GSO for 57710/57711 chips

Zhang Rui (2):
      PM: Documentation update for freeze state
      PM / Documentation: remove inaccurate suspend/hibernate transition la=
ntency statement

Zhang Yanfei (1):
      x86/mm: Add missing comments for initial kernel direct mapping

dyoung@redhat.com (1):
      driver core: print sysfs attribute name when warning about bogus perm=
issions

fran=C3=A7ois romieu (1):
      r8169: fix offloaded tx checksum for small packets.

jean-philippe francois (1):
      ARM: OMAP: fix __init section mismatch for _enable_preprogram

nikolay@redhat.com (4):
      bonding: fix set mode race conditions
      bonding: replace %x with %pI4 for IPv4 addresses
      bonding: arp_ip_count and arp_targets can be wrong
      bonding: fix multiple 3ad mode sysfs race conditions

salina@us.ibm.com (1):
      Char: lp, protect LPGETSTATUS with port_mutex

stephen hemminger (1):
      8139cp: reset BQL when ring tx ring cleared

wang, biao (1):
      klist: del waiter from klist_remove_waiters before wakeup waitting pr=
ocess

 Documentation/devicetree/bindings/net/macb.txt     |    2 +-
 .../{drm/exynos/hdmi.txt =3D> video/exynos_hdmi.txt} |    0
 .../hdmiddc.txt =3D> video/exynos_hdmiddc.txt}       |    0
 .../hdmiphy.txt =3D> video/exynos_hdmiphy.txt}       |    0
 .../exynos/mixer.txt =3D> video/exynos_mixer.txt}    |    0
 .../bindings/video/simple-framebuffer.txt          |   25 +
 Documentation/devicetree/usage-model.txt           |    8 +-
 Documentation/kernel-parameters.txt                |   21 +
 Documentation/kernel-per-CPU-kthreads.txt          |  202 +++++
 Documentation/power/devices.txt                    |   15 +-
 Documentation/power/interface.txt                  |    4 +-
 Documentation/power/notifiers.txt                  |    6 +-
 Documentation/power/states.txt                     |   30 +-
 Documentation/rapidio/rapidio.txt                  |  128 ++-
 Documentation/rapidio/sysfs.txt                    |   17 +
 MAINTAINERS                                        |   43 +-
 Makefile                                           |    2 +-
 arch/Kconfig                                       |    3 +
 arch/arc/boot/dts/abilis_tb100_dvk.dts             |    2 +-
 arch/arc/boot/dts/abilis_tb101_dvk.dts             |    2 +-
 arch/arc/boot/dts/abilis_tb10x.dtsi                |    6 +-
 arch/arc/include/asm/cacheflush.h                  |    6 +-
 arch/arc/include/asm/page.h                        |    9 -
 arch/arc/include/asm/pgtable.h                     |   26 +-
 arch/arc/include/asm/tlb.h                         |    2 +-
 arch/arc/mm/cache_arc700.c                         |   23 +-
 arch/arc/mm/tlb.c                                  |    3 +-
 arch/arc/mm/tlbex.S                                |    6 +-
 arch/arc/plat-tb10x/tb10x.c                        |   26 -
 arch/arm/Kconfig                                   |    3 +-
 arch/arm/Makefile                                  |    2 +-
 arch/arm/boot/dts/Makefile                         |    4 +-
 arch/arm/boot/dts/armada-370-xp.dtsi               |    3 +-
 arch/arm/boot/dts/armada-370.dtsi                  |    7 +-
 arch/arm/boot/dts/armada-xp-gp.dts                 |    3 +
 arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts   |    3 +
 arch/arm/boot/dts/armada-xp.dtsi                   |    2 +-
 arch/arm/boot/dts/at91sam9260.dtsi                 |    2 +-
 arch/arm/boot/dts/at91sam9n12.dtsi                 |    1 +
 arch/arm/boot/dts/at91sam9x25ek.dts                |    2 +-
 arch/arm/boot/dts/omap3.dtsi                       |    2 +-
 arch/arm/boot/dts/sama5d3.dtsi                     |   12 +-
 arch/arm/boot/dts/sama5d3xcm.dtsi                  |    4 +
 arch/arm/boot/dts/ste-nomadik-s8815.dts            |   12 +-
 arch/arm/boot/dts/sun4i-a10-mini-xplus.dts         |    4 +-
 arch/arm/common/mcpm_platsmp.c                     |    3 -
 arch/arm/configs/omap1_defconfig                   |    1 -
 arch/arm/configs/omap2plus_defconfig               |    2 +-
 arch/arm/configs/tegra_defconfig                   |    3 +-
 arch/arm/crypto/sha1-armv4-large.S                 |    2 +-
 arch/arm/include/asm/cmpxchg.h                     |    8 +-
 arch/arm/include/debug/ux500.S                     |    6 +-
 arch/arm/kernel/process.c                          |    1 -
 arch/arm/kernel/smp.c                              |    2 +-
 arch/arm/mach-at91/at91rm9200_time.c               |    7 +-
 arch/arm/mach-at91/at91sam9n12.c                   |    6 -
 arch/arm/mach-at91/include/mach/at91_pmc.h         |    6 +-
 arch/arm/mach-imx/clk-imx6q.c                      |   11 +-
 arch/arm/mach-imx/headsmp.S                        |   12 +
 arch/arm/mach-imx/platsmp.c                        |   14 +
 arch/arm/mach-kirkwood/common.c                    |    6 -
 arch/arm/mach-kirkwood/ts219-setup.c               |    2 +-
 arch/arm/mach-mvebu/Kconfig                        |    1 +
 arch/arm/mach-mvebu/armada-370-xp.c                |    7 -
 arch/arm/mach-omap1/dma.c                          |    1 +
 arch/arm/mach-omap2/cclock33xx_data.c              |   26 +-
 arch/arm/mach-omap2/omap_hwmod.c                   |  113 +--
 arch/arm/mach-omap2/omap_hwmod.h                   |    7 +-
 arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c |    3 +
 arch/arm/mach-omap2/omap_hwmod_33xx_data.c         |    6 +
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         |    4 +
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c         |    6 +-
 arch/arm/mach-omap2/serial.c                       |   31 -
 arch/arm/mach-orion5x/common.c                     |    7 -
 arch/arm/mach-shmobile/board-marzen.c              |    6 +-
 arch/arm/mach-sunxi/Kconfig                        |    1 +
 arch/arm/mach-tegra/tegra2_emc.c                   |    5 -
 arch/arm/mach-ux500/Kconfig                        |    1 +
 arch/arm/mach-ux500/board-mop500.c                 |    6 +-
 arch/arm/mach-ux500/cpu-db8500.c                   |    6 +-
 arch/arm/mach-ux500/setup.h                        |    2 +-
 arch/arm/mach-vt8500/vt8500.c                      |    1 +
 arch/arm/plat-orion/common.c                       |   12 +-
 arch/arm/plat-orion/include/plat/common.h          |    1 +
 arch/arm/plat-samsung/adc.c                        |    5 -
 arch/arm/vfp/entry.S                               |    2 +-
 arch/arm/xen/enlighten.c                           |   33 +-
 arch/arm64/Kconfig                                 |    2 -
 arch/arm64/include/asm/assembler.h                 |    2 +-
 arch/arm64/kernel/debug-monitors.c                 |    2 -
 arch/arm64/kernel/early_printk.c                   |    5 +-
 arch/arm64/kernel/setup.c                          |   12 +-
 arch/arm64/mm/cache.S                              |    2 +-
 arch/arm64/mm/proc.S                               |    3 +-
 arch/avr32/Kconfig                                 |    5 +
 arch/avr32/include/asm/Kbuild                      |    1 +
 arch/avr32/include/asm/numnodes.h                  |    7 -
 arch/avr32/include/asm/param.h                     |    9 -
 arch/avr32/include/uapi/asm/Kbuild                 |    1 +
 arch/avr32/include/uapi/asm/param.h                |   18 -
 arch/avr32/kernel/module.c                         |    2 +-
 arch/mips/alchemy/board-gpr.c                      |    1 +
 arch/mips/alchemy/common/time.c                    |    1 +
 arch/mips/ath79/setup.c                            |    1 +
 arch/mips/cobalt/reset.c                           |    1 +
 arch/mips/configs/db1000_defconfig                 |    1 -
 arch/mips/configs/db1235_defconfig                 |    1 -
 arch/mips/configs/lemote2f_defconfig               |    1 -
 arch/mips/include/asm/clock.h                      |    2 -
 arch/mips/include/asm/idle.h                       |   23 +
 arch/mips/include/asm/io.h                         |    2 +-
 arch/mips/include/asm/kvm_host.h                   |    2 +-
 arch/mips/include/asm/mmu_context.h                |   95 +-
 arch/mips/include/asm/page.h                       |   17 +-
 arch/mips/include/asm/processor.h                  |    1 -
 arch/mips/include/{ =3D> uapi}/asm/kvm.h             |    0
 arch/mips/include/uapi/asm/unistd.h                |    5 +-
 arch/mips/kernel/Makefile                          |    2 +-
 arch/mips/kernel/cpu-probe.c                       |  198 -----
 arch/mips/kernel/crash_dump.c                      |    1 +
 arch/mips/kernel/genex.S                           |    8 +-
 arch/mips/kernel/idle.c                            |  244 +++++
 arch/mips/kernel/kprobes.c                         |    5 +-
 arch/mips/kernel/proc.c                            |    1 +
 arch/mips/kernel/process.c                         |   53 +-
 arch/mips/kernel/scall64-64.S                      |    1 +
 arch/mips/kernel/smp.c                             |    1 +
 arch/mips/kernel/smtc.c                            |   15 +-
 arch/mips/kernel/traps.c                           |   15 +-
 arch/mips/kvm/kvm_mips_emul.c                      |   29 +-
 arch/mips/kvm/kvm_tlb.c                            |   61 +-
 arch/mips/lantiq/xway/gptu.c                       |    6 +-
 arch/mips/lib/dump_tlb.c                           |    5 +-
 arch/mips/lib/r3k_dump_tlb.c                       |    7 +-
 arch/mips/loongson/common/reset.c                  |    1 +
 arch/mips/loongson1/common/reset.c                 |    1 +
 arch/mips/mm/tlb-r3k.c                             |   20 +-
 arch/mips/mm/tlb-r4k.c                             |    2 +-
 arch/mips/mm/tlb-r8k.c                             |    2 +-
 arch/mips/mm/tlbex.c                               |   79 --
 arch/mips/netlogic/xlp/setup.c                     |    1 +
 arch/mips/netlogic/xlr/setup.c                     |    1 +
 arch/mips/pmcs-msp71xx/msp_prom.c                  |    2 +-
 arch/mips/pmcs-msp71xx/msp_setup.c                 |    1 +
 arch/mips/ralink/dts/rt3050.dtsi                   |   10 +
 arch/mips/ralink/dts/rt3052_eval.dts               |    4 +
 arch/mips/txx9/generic/setup.c                     |    1 +
 arch/mips/vr41xx/common/pmu.c                      |    1 +
 arch/mips/wrppmc/reset.c                           |    1 +
 arch/parisc/Kconfig                                |    2 +-
 arch/parisc/Makefile                               |   21 +-
 arch/parisc/include/asm/assembly.h                 |    1 -
 arch/parisc/include/asm/hardirq.h                  |   10 +-
 arch/parisc/include/asm/processor.h                |   18 -
 arch/parisc/kernel/entry.S                         |  174 ++--
 arch/parisc/kernel/hardware.c                      |    1 +
 arch/parisc/kernel/irq.c                           |  122 ++-
 arch/parisc/kernel/pacache.S                       |   12 +-
 arch/parisc/kernel/traps.c                         |    1 +
 arch/parisc/kernel/unaligned.c                     |    3 +
 arch/parisc/mm/init.c                              |    4 +-
 arch/powerpc/Kconfig.debug                         |   23 +
 arch/powerpc/configs/ps3_defconfig                 |    1 -
 arch/powerpc/include/asm/context_tracking.h        |   10 +
 arch/powerpc/include/asm/firmware.h                |    4 +-
 arch/powerpc/include/asm/hw_irq.h                  |    5 +-
 arch/powerpc/include/asm/opal.h                    |    5 +-
 arch/powerpc/include/asm/pci-bridge.h              |    2 +
 arch/powerpc/include/asm/pgalloc-64.h              |    2 +-
 arch/powerpc/include/asm/processor.h               |    6 +
 arch/powerpc/include/asm/pte-hash64-64k.h          |    2 +-
 arch/powerpc/include/asm/rtas.h                    |    2 +
 arch/powerpc/include/asm/thread_info.h             |    7 +-
 arch/powerpc/include/asm/udbg.h                    |    1 +
 arch/powerpc/kernel/asm-offsets.c                  |    6 +
 arch/powerpc/kernel/cpu_setup_power.S              |    8 +-
 arch/powerpc/kernel/entry_32.S                     |    2 -
 arch/powerpc/kernel/entry_64.S                     |   33 +-
 arch/powerpc/kernel/exceptions-64e.S               |    8 +-
 arch/powerpc/kernel/machine_kexec_64.c             |    4 +
 arch/powerpc/kernel/misc_32.S                      |   11 +
 arch/powerpc/kernel/misc_64.S                      |   11 +
 arch/powerpc/kernel/pci-common.c                   |   12 +-
 arch/powerpc/kernel/pci_64.c                       |   10 +
 arch/powerpc/kernel/pci_dn.c                       |    8 +
 arch/powerpc/kernel/ppc_ksyms.c                    |    3 +-
 arch/powerpc/kernel/process.c                      |    8 +
 arch/powerpc/kernel/ptrace.c                       |    5 +
 arch/powerpc/kernel/rtas.c                         |  113 +++
 arch/powerpc/kernel/rtas_flash.c                   |   10 +-
 arch/powerpc/kernel/signal.c                       |    7 +-
 arch/powerpc/kernel/traps.c                        |   80 +-
 arch/powerpc/kernel/udbg.c                         |    3 +
 arch/powerpc/mm/fault.c                            |   41 +-
 arch/powerpc/mm/hash_utils_64.c                    |   36 +-
 arch/powerpc/mm/init_64.c                          |    3 +-
 arch/powerpc/perf/core-book3s.c                    |  280 +++---
 arch/powerpc/platforms/Kconfig                     |    2 +-
 arch/powerpc/platforms/powernv/Kconfig             |    1 +
 arch/powerpc/platforms/powernv/opal.c              |   30 +-
 arch/powerpc/platforms/powernv/pci-ioda.c          |   36 +-
 arch/powerpc/platforms/powernv/pci.c               |   18 +-
 arch/powerpc/platforms/powernv/pci.h               |    2 +
 arch/powerpc/platforms/powernv/powernv.h           |    2 +
 arch/powerpc/platforms/powernv/setup.c             |   16 +-
 arch/powerpc/platforms/powernv/smp.c               |   62 +-
 arch/powerpc/platforms/pseries/Kconfig             |    1 +
 arch/powerpc/platforms/pseries/msi.c               |   75 +-
 arch/powerpc/platforms/pseries/suspend.c           |   22 +
 arch/powerpc/platforms/wsp/ics.c                   |    2 +-
 arch/powerpc/sysdev/Makefile                       |    2 +
 arch/powerpc/sysdev/ehv_pic.c                      |    2 +-
 arch/powerpc/sysdev/mpic.c                         |    2 +-
 arch/powerpc/sysdev/udbg_memcons.c                 |  105 +++
 arch/powerpc/sysdev/xics/ics-opal.c                |    2 +-
 arch/s390/Kconfig                                  |    1 -
 arch/s390/include/asm/ftrace.h                     |   12 +-
 arch/s390/include/asm/page.h                       |   20 +-
 arch/s390/include/asm/pgtable.h                    |    4 +-
 arch/s390/kernel/dis.c                             |    2 +
 arch/s390/kernel/ftrace.c                          |    9 +-
 arch/s390/kernel/mcount.S                          |    2 +
 arch/s390/kernel/mcount64.S                        |    2 +
 arch/s390/kernel/smp.c                             |    2 +-
 arch/s390/mm/pgtable.c                             |    3 +-
 arch/score/mm/init.c                               |    2 -
 arch/x86/Kconfig                                   |    1 -
 arch/x86/kernel/head64.c                           |    2 +-
 arch/x86/kernel/microcode_intel_early.c            |    5 +-
 arch/x86/kernel/process.c                          |    5 +-
 arch/x86/mm/init.c                                 |   19 +-
 arch/x86/pci/mrst.c                                |   10 +-
 drivers/acpi/Makefile                              |    3 +-
 drivers/acpi/ac.c                                  |   33 +
 drivers/acpi/acpi_lpss.c                           |   26 +-
 drivers/acpi/csrt.c                                |  159 ----
 drivers/acpi/device_pm.c                           |  126 +--
 drivers/acpi/ec.c                                  |    4 +-
 drivers/acpi/internal.h                            |    1 -
 drivers/acpi/pci_root.c                            |    4 +-
 drivers/acpi/processor_driver.c                    |    8 +-
 drivers/acpi/processor_idle.c                      |   29 +-
 drivers/acpi/scan.c                                |    4 +-
 drivers/acpi/video.c                               |    8 +
 drivers/acpi/video_detect.c                        |    8 +
 drivers/ata/pata_ep93xx.c                          |    5 -
 drivers/base/bus.c                                 |    1 +
 drivers/base/core.c                                |    6 +-
 drivers/base/power/common.c                        |   12 +-
 drivers/bcma/scan.c                                |    2 +
 drivers/block/brd.c                                |    4 +-
 drivers/block/rbd.c                                |  935 ++++++++++++----=
----
 drivers/block/xsysace.c                            |    3 +-
 drivers/char/hw_random/mxc-rnga.c                  |    6 -
 drivers/char/hw_random/omap-rng.c                  |    5 -
 drivers/char/ipmi/ipmi_bt_sm.c                     |    4 +-
 drivers/char/ipmi/ipmi_devintf.c                   |   14 +-
 drivers/char/ipmi/ipmi_msghandler.c                |    3 +-
 drivers/char/ipmi/ipmi_si_intf.c                   |   16 +-
 drivers/char/lp.c                                  |    3 +
 drivers/char/random.c                              |   54 +-
 drivers/char/ttyprintk.c                           |    2 +-
 drivers/clk/tegra/clk-tegra20.c                    |   11 +-
 drivers/clk/x86/clk-lpt.c                          |   15 +-
 drivers/cpufreq/Kconfig                            |    2 +-
 drivers/cpufreq/Kconfig.arm                        |   15 +-
 drivers/cpufreq/Kconfig.x86                        |    2 +-
 drivers/cpufreq/arm_big_little.c                   |    7 +-
 drivers/cpufreq/arm_big_little.h                   |    5 +
 drivers/cpufreq/arm_big_little_dt.c                |   94 +-
 drivers/cpufreq/cpufreq-cpu0.c                     |   27 +-
 drivers/cpufreq/cpufreq.c                          |   19 +-
 drivers/cpufreq/cpufreq_governor.c                 |   11 +-
 drivers/cpufreq/cpufreq_governor.h                 |    1 +
 drivers/cpufreq/cpufreq_ondemand.c                 |    1 -
 drivers/cpufreq/cpufreq_stats.c                    |    7 +-
 drivers/cpufreq/intel_pstate.c                     |  123 +--
 drivers/cpufreq/kirkwood-cpufreq.c                 |    4 -
 drivers/cpufreq/loongson2_cpufreq.c                |    2 +
 drivers/crypto/nx/nx-aes-cbc.c                     |    1 +
 drivers/crypto/nx/nx-aes-ecb.c                     |    1 +
 drivers/crypto/nx/nx-aes-gcm.c                     |    2 +-
 drivers/crypto/nx/nx-sha256.c                      |    8 +-
 drivers/crypto/nx/nx-sha512.c                      |    7 +-
 drivers/crypto/nx/nx.c                             |   38 +-
 drivers/dma/acpi-dma.c                             |  172 +++-
 drivers/dma/tegra20-apb-dma.c                      |    5 -
 drivers/edac/amd64_edac_inj.c                      |    4 +-
 drivers/gpio/Kconfig                               |    2 +-
 drivers/gpio/gpio-langwell.c                       |   17 +-
 drivers/gpio/gpio-ml-ioh.c                         |    3 +-
 drivers/gpio/gpio-mvebu.c                          |    5 -
 drivers/gpio/gpio-mxs.c                            |    3 +-
 drivers/gpio/gpio-omap.c                           |   48 +-
 drivers/gpio/gpio-pch.c                            |    3 +-
 drivers/gpio/gpio-sch.c                            |    6 +-
 drivers/gpio/gpio-tegra.c                          |    5 -
 drivers/gpio/gpio-viperboard.c                     |    3 +-
 drivers/gpu/drm/drm_crtc.c                         |    5 +
 drivers/gpu/drm/drm_crtc_helper.c                  |   27 +-
 drivers/gpu/drm/drm_drv.c                          |   20 +-
 drivers/gpu/drm/drm_encoder_slave.c                |    6 +-
 drivers/gpu/drm/drm_mm.c                           |   34 +-
 drivers/gpu/drm/drm_modes.c                        |    1 +
 drivers/gpu/drm/exynos/exynos_hdmi.c               |    5 -
 drivers/gpu/drm/i915/i915_gem.c                    |    8 +-
 drivers/gpu/drm/i915/i915_gem_gtt.c                |   15 +-
 drivers/gpu/drm/i915/i915_reg.h                    |    2 -
 drivers/gpu/drm/i915/intel_ddi.c                   |    5 +
 drivers/gpu/drm/i915/intel_dp.c                    |   77 +-
 drivers/gpu/drm/i915/intel_drv.h                   |    1 +
 drivers/gpu/drm/i915/intel_fb.c                    |   16 +-
 drivers/gpu/drm/i915/intel_pm.c                    |   44 +-
 drivers/gpu/drm/mgag200/mgag200_mode.c             |   90 +-
 drivers/gpu/drm/nouveau/core/engine/device/nvc0.c  |    2 -
 drivers/gpu/drm/nouveau/core/engine/fifo/nv50.c    |    2 +
 drivers/gpu/drm/nouveau/core/engine/fifo/nvc0.c    |   10 +
 drivers/gpu/drm/nouveau/core/engine/fifo/nve0.c    |    3 +
 drivers/gpu/drm/nouveau/core/subdev/bios/init.c    |    4 +-
 drivers/gpu/drm/nouveau/core/subdev/ltcg/nvc0.c    |   17 +-
 drivers/gpu/drm/nouveau/nouveau_drm.c              |   25 +-
 drivers/gpu/drm/qxl/qxl_cmd.c                      |   29 +-
 drivers/gpu/drm/qxl/qxl_display.c                  |   17 +-
 drivers/gpu/drm/qxl/qxl_drv.h                      |    7 -
 drivers/gpu/drm/qxl/qxl_ioctl.c                    |    1 +
 drivers/gpu/drm/radeon/atombios_crtc.c             |    6 -
 drivers/gpu/drm/radeon/evergreen.c                 |   31 +-
 drivers/gpu/drm/radeon/evergreen_hdmi.c            |    7 +-
 drivers/gpu/drm/radeon/r300_cmdbuf.c               |    2 +-
 drivers/gpu/drm/radeon/r600_hdmi.c                 |    9 +-
 drivers/gpu/drm/radeon/radeon.h                    |    2 +
 drivers/gpu/drm/radeon/radeon_asic.c               |   22 +-
 drivers/gpu/drm/radeon/radeon_bios.c               |   28 +-
 drivers/gpu/drm/radeon/radeon_device.c             |    1 +
 drivers/gpu/drm/radeon/radeon_drv.c                |   12 +-
 drivers/gpu/drm/radeon/radeon_family.h             |    1 +
 drivers/gpu/drm/radeon/radeon_legacy_crtc.c        |    4 -
 drivers/gpu/drm/radeon/radeon_mode.h               |    1 -
 drivers/gpu/drm/radeon/radeon_ttm.c                |    2 +-
 drivers/gpu/drm/radeon/si.c                        |  370 ++++++--
 drivers/gpu/drm/radeon/sid.h                       |    1 +
 drivers/gpu/host1x/drm/dc.c                        |    5 -
 drivers/hv/channel_mgmt.c                          |    2 +-
 drivers/hwmon/abituguru.c                          |   16 +-
 drivers/hwmon/iio_hwmon.c                          |    8 +-
 drivers/hwmon/nct6775.c                            |    6 +-
 drivers/hwmon/tmp401.c                             |    2 +-
 drivers/i2c/busses/i2c-designware-core.c           |   14 +-
 drivers/i2c/busses/i2c-designware-core.h           |    2 +
 drivers/i2c/busses/i2c-designware-platdrv.c        |    1 +
 drivers/i2c/busses/i2c-i801.c                      |    6 +-
 drivers/i2c/busses/i2c-mv64xxx.c                   |    8 +-
 drivers/i2c/busses/i2c-s3c2410.c                   |    5 -
 drivers/i2c/busses/i2c-sirf.c                      |    6 -
 drivers/i2c/busses/i2c-tegra.c                     |    5 -
 drivers/i2c/i2c-core.c                             |    3 +-
 drivers/iio/adc/exynos_adc.c                       |    8 +-
 drivers/iio/common/st_sensors/st_sensors_core.c    |    2 +
 drivers/iio/dac/Kconfig                            |    6 +-
 drivers/input/tablet/wacom_wac.c                   |   89 +-
 drivers/input/tablet/wacom_wac.h                   |    1 +
 drivers/input/touchscreen/egalax_ts.c              |    2 +-
 drivers/isdn/capi/kcapi.c                          |    6 +-
 drivers/leds/leds-gpio.c                           |    9 +-
 drivers/leds/leds-ot200.c                          |   14 +-
 drivers/lguest/page_tables.c                       |    1 +
 drivers/md/dm-thin.c                               |    4 +-
 drivers/memory/emif.c                              |    6 -
 drivers/mfd/Kconfig                                |    3 +-
 drivers/mfd/ab8500-core.c                          |   24 +-
 drivers/mfd/ab8500-debugfs.c                       |   16 +-
 drivers/mfd/ab8500-gpadc.c                         |    7 +-
 drivers/mfd/ab8500-sysctrl.c                       |   15 +-
 drivers/mfd/abx500-core.c                          |    2 +-
 drivers/mfd/cros_ec_spi.c                          |    6 +-
 drivers/mfd/db8500-prcmu.c                         |    3 +
 drivers/mfd/intel_msic.c                           |    5 -
 drivers/mfd/si476x-cmd.c                           |  152 ++--
 drivers/misc/atmel-ssc.c                           |    5 -
 drivers/misc/dummy-irq.c                           |    6 +-
 drivers/misc/mei/bus.c                             |    2 +
 drivers/misc/mei/main.c                            |   17 +-
 drivers/misc/vmw_vmci/Kconfig                      |    2 +-
 drivers/misc/vmw_vmci/vmci_queue_pair.c            |    2 +-
 drivers/mmc/host/mmci.c                            |    9 +-
 drivers/mtd/nand/lpc32xx_mlc.c                     |    5 -
 drivers/net/bonding/bond_3ad.c                     |   21 +-
 drivers/net/bonding/bond_3ad.h                     |    2 +
 drivers/net/bonding/bond_main.c                    |   26 +-
 drivers/net/bonding/bond_procfs.c                  |    2 +-
 drivers/net/bonding/bond_sysfs.c                   |   13 +-
 drivers/net/caif/Kconfig                           |    2 +-
 drivers/net/ethernet/3com/3c59x.c                  |   25 +-
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c    |    9 +-
 drivers/net/ethernet/broadcom/tg3.c                |   61 +-
 drivers/net/ethernet/brocade/bna/bnad.c            |    5 +-
 drivers/net/ethernet/cadence/Kconfig               |    3 +-
 drivers/net/ethernet/cadence/macb.c                |   18 +-
 drivers/net/ethernet/cadence/macb.h                |    7 +
 drivers/net/ethernet/calxeda/Kconfig               |    2 +-
 drivers/net/ethernet/emulex/benet/be_cmds.c        |   13 +-
 drivers/net/ethernet/emulex/benet/be_main.c        |   18 +-
 drivers/net/ethernet/freescale/fec_main.c          |   34 +-
 drivers/net/ethernet/freescale/gianfar_ptp.c       |    1 +
 drivers/net/ethernet/ibm/emac/core.c               |   36 +-
 drivers/net/ethernet/icplus/ipg.h                  |   86 +-
 drivers/net/ethernet/marvell/mv643xx_eth.c         |    6 +-
 drivers/net/ethernet/mellanox/mlx4/en_resources.c  |    2 +-
 drivers/net/ethernet/mellanox/mlx4/fw.c            |    4 +-
 .../net/ethernet/mellanox/mlx4/resource_tracker.c  |   29 +-
 drivers/net/ethernet/qlogic/qlcnic/qlcnic.h        |    8 +
 .../net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.c    |   95 +-
 .../net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.h    |    4 +-
 .../net/ethernet/qlogic/qlcnic/qlcnic_83xx_init.c  |   24 +-
 .../net/ethernet/qlogic/qlcnic/qlcnic_ethtool.c    |   54 +-
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_hw.c     |   49 +-
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_hw.h     |    2 +-
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_main.c   |  111 ++-
 .../ethernet/qlogic/qlcnic/qlcnic_sriov_common.c   |    9 +-
 .../net/ethernet/qlogic/qlcnic/qlcnic_sriov_pf.c   |    3 -
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_sysfs.c  |    3 +
 drivers/net/ethernet/qlogic/qlge/qlge_main.c       |    7 +
 drivers/net/ethernet/realtek/8139cp.c              |    1 +
 drivers/net/ethernet/realtek/r8169.c               |   41 +-
 drivers/net/ethernet/renesas/sh_eth.c              |    5 -
 drivers/net/ethernet/sfc/efx.c                     |    8 +-
 drivers/net/ethernet/sfc/net_driver.h              |   31 +-
 drivers/net/ethernet/sfc/rx.c                      |    8 +-
 drivers/net/ethernet/stmicro/stmmac/Kconfig        |    2 +-
 drivers/net/macvlan.c                              |    7 +-
 drivers/net/ntb_netdev.c                           |    2 +
 drivers/net/usb/qmi_wwan.c                         |    1 +
 drivers/net/usb/rtl8150.c                          |  100 +--
 drivers/net/usb/usbnet.c                           |    2 +-
 drivers/net/virtio_net.c                           |   11 +-
 drivers/net/vxlan.c                                |   17 +-
 drivers/net/wireless/ath/ath5k/base.c              |    5 +
 drivers/net/wireless/ath/ath9k/Kconfig             |    2 +-
 drivers/net/wireless/ath/ath9k/ar9003_calib.c      |    2 +-
 drivers/net/wireless/ath/ath9k/ar9485_initvals.h   |    2 +-
 .../net/wireless/ath/ath9k/ar9565_1p0_initvals.h   |  138 +--
 drivers/net/wireless/ath/ath9k/ath9k.h             |    4 +-
 drivers/net/wireless/ath/ath9k/debug.c             |    8 +
 drivers/net/wireless/ath/ath9k/debug.h             |    5 +
 drivers/net/wireless/ath/ath9k/init.c              |   10 +-
 drivers/net/wireless/ath/ath9k/main.c              |   18 +-
 drivers/net/wireless/ath/ath9k/xmit.c              |   74 +-
 drivers/net/wireless/b43/dma.c                     |   19 +
 drivers/net/wireless/b43/dma.h                     |    4 +-
 drivers/net/wireless/b43/main.c                    |   43 +-
 .../net/wireless/brcm80211/brcmfmac/wl_cfg80211.c  |    7 +-
 drivers/net/wireless/iwlegacy/4965-mac.c           |    3 +-
 drivers/net/wireless/iwlegacy/common.c             |    2 +-
 drivers/net/wireless/iwlwifi/mvm/fw-api.h          |   27 +
 drivers/net/wireless/iwlwifi/mvm/mac-ctxt.c        |   12 +-
 drivers/net/wireless/iwlwifi/mvm/mac80211.c        |   17 +-
 drivers/net/wireless/iwlwifi/mvm/mvm.h             |    1 +
 drivers/net/wireless/iwlwifi/mvm/ops.c             |    1 +
 drivers/net/wireless/iwlwifi/mvm/scan.c            |    6 +
 drivers/net/wireless/iwlwifi/mvm/sta.c             |   13 +-
 drivers/net/wireless/iwlwifi/mvm/sta.h             |    2 -
 drivers/net/wireless/iwlwifi/mvm/tx.c              |   48 +-
 drivers/net/wireless/mac80211_hwsim.c              |   18 +-
 drivers/net/wireless/mwifiex/cfg80211.c            |    3 -
 drivers/net/wireless/mwifiex/cmdevt.c              |    1 +
 drivers/net/wireless/mwifiex/main.c                |    1 +
 drivers/net/wireless/mwifiex/sta_ioctl.c           |   21 +-
 drivers/net/wireless/rtlwifi/rtl8188ee/trx.h       |    4 +-
 drivers/net/wireless/rtlwifi/rtl8192cu/sw.c        |    1 +
 drivers/ntb/ntb_hw.c                               |   10 +-
 drivers/ntb/ntb_transport.c                        |  175 ++--
 drivers/of/base.c                                  |    4 +-
 drivers/parisc/superio.c                           |   13 +-
 drivers/pci/hotplug/acpiphp_glue.c                 |   14 +
 drivers/pinctrl/pinctrl-abx500.c                   |   30 +-
 drivers/pinctrl/pinctrl-coh901.c                   |    5 -
 drivers/pinctrl/pinctrl-exynos5440.c               |    5 -
 drivers/pinctrl/pinctrl-lantiq.c                   |    3 +-
 drivers/pinctrl/pinctrl-samsung.c                  |    5 -
 drivers/pinctrl/pinctrl-single.c                   |    3 +-
 drivers/pinctrl/pinctrl-xway.c                     |    4 -
 drivers/pinctrl/vt8500/pinctrl-wm8750.c            |    2 +-
 drivers/power/Kconfig                              |    2 +
 drivers/power/pm2301_charger.c                     |    2 +-
 drivers/power/wm831x_backup.c                      |    1 -
 drivers/pwm/pwm-imx.c                              |    5 -
 drivers/pwm/pwm-puv3.c                             |    5 -
 drivers/pwm/pwm-pxa.c                              |    5 -
 drivers/pwm/pwm-tegra.c                            |    5 -
 drivers/pwm/pwm-tiecap.c                           |    5 -
 drivers/pwm/pwm-tiehrpwm.c                         |    5 -
 drivers/pwm/pwm-tipwmss.c                          |    5 -
 drivers/pwm/pwm-vt8500.c                           |    5 -
 drivers/rapidio/Kconfig                            |   20 +
 drivers/rapidio/Makefile                           |    3 +-
 drivers/rapidio/devices/tsi721.c                   |   12 +
 drivers/rapidio/rio-driver.c                       |    8 +
 drivers/rapidio/rio-scan.c                         |  190 ++--
 drivers/rapidio/rio-sysfs.c                        |   45 +
 drivers/rapidio/rio.c                              |  246 ++++-
 drivers/rapidio/rio.h                              |   13 +-
 drivers/rtc/Kconfig                                |    2 -
 drivers/rtc/rtc-max8998.c                          |    2 +-
 drivers/rtc/rtc-nuc900.c                           |    5 -
 drivers/rtc/rtc-omap.c                             |    5 -
 drivers/rtc/rtc-pl031.c                            |    2 +-
 drivers/rtc/rtc-s3c.c                              |    5 -
 drivers/rtc/rtc-tegra.c                            |    6 -
 drivers/s390/block/xpram.c                         |    1 +
 drivers/s390/cio/chp.c                             |   36 +
 drivers/s390/cio/chsc.h                            |    4 +-
 drivers/spi/spi-atmel.c                            |   51 +-
 drivers/spi/spi-davinci.c                          |    2 +-
 drivers/spi/spi-tegra20-sflash.c                   |    5 -
 drivers/spi/spi.c                                  |    9 +-
 drivers/staging/Kconfig                            |    4 +-
 drivers/staging/android/logger.c                   |    4 +-
 drivers/staging/android/logger.h                   |    2 +-
 drivers/staging/comedi/Kconfig                     |    9 +
 drivers/staging/comedi/comedi_buf.c                |   12 +
 drivers/staging/comedi/comedi_fops.c               |    3 -
 drivers/staging/comedi/drivers/ni_labpc.c          |    8 +-
 drivers/staging/comedi/drivers/ni_labpc.h          |    1 +
 drivers/staging/comedi/drivers/ni_mio_common.c     |   20 +-
 drivers/staging/dwc2/Kconfig                       |    2 +-
 drivers/staging/dwc2/hcd_intr.c                    |    2 -
 drivers/staging/dwc2/platform.c                    |   13 +-
 drivers/staging/gdm72xx/Kconfig                    |    2 +-
 drivers/staging/iio/adc/mxs-lradc.c                |    5 +-
 drivers/staging/iio/light/tsl2x7x_core.c           |    9 +-
 drivers/staging/imx-drm/Kconfig                    |    5 +
 drivers/staging/imx-drm/imx-tve.c                  |    4 +-
 drivers/staging/media/solo6x10/Kconfig             |    1 +
 drivers/staging/nvec/nvec.c                        |   26 +-
 drivers/staging/nvec/nvec.h                        |    5 +-
 drivers/staging/nvec/nvec_kbd.c                    |   10 +-
 drivers/staging/nvec/nvec_power.c                  |    1 +
 drivers/staging/nvec/nvec_ps2.c                    |    8 +-
 drivers/staging/sep/Kconfig                        |    2 +-
 drivers/staging/ste_rmi4/synaptics_i2c_rmi4.c      |    6 +-
 drivers/staging/vt6656/hostap.c                    |    2 +-
 drivers/staging/vt6656/iwctl.c                     |    6 +
 drivers/staging/zcache/ramster/ramster-howto.txt   |  366 ++++++++
 drivers/staging/zcache/zcache-main.c               |    8 +-
 drivers/target/iscsi/iscsi_target.c                |   63 +-
 drivers/target/iscsi/iscsi_target_erl1.c           |    7 +-
 drivers/target/iscsi/iscsi_target_parameters.c     |    8 +-
 drivers/target/iscsi/iscsi_target_parameters.h     |    4 +-
 drivers/target/target_core_configfs.c              |   11 +-
 drivers/target/target_core_device.c                |   14 -
 drivers/target/target_core_file.c                  |    9 +-
 drivers/target/target_core_iblock.c                |    2 +
 drivers/target/target_core_internal.h              |    1 -
 drivers/target/target_core_rd.c                    |   21 +-
 drivers/target/target_core_rd.h                    |    1 +
 drivers/target/target_core_transport.c             |   13 +-
 drivers/thermal/armada_thermal.c                   |   10 -
 drivers/thermal/dove_thermal.c                     |    4 -
 drivers/thermal/exynos_thermal.c                   |    5 -
 drivers/tty/ehv_bytechan.c                         |    1 +
 drivers/tty/mxser.c                                |   11 +-
 drivers/tty/n_tty.c                                |    8 +
 drivers/tty/rocket.c                               |  288 +++---
 drivers/tty/serial/8250/8250_dw.c                  |    7 +-
 drivers/tty/serial/amba-pl011.c                    |    2 +-
 drivers/tty/serial/mcf.c                           |    4 +-
 drivers/tty/serial/mpc52xx_uart.c                  |   11 +-
 drivers/tty/serial/nwpserial.c                     |    2 +-
 drivers/tty/serial/omap-serial.c                   |   23 -
 drivers/tty/serial/samsung.c                       |    1 +
 drivers/tty/vt/vt.c                                |   14 +-
 drivers/tty/vt/vt_ioctl.c                          |   67 +-
 drivers/uio/Kconfig                                |    1 +
 drivers/usb/atm/cxacru.c                           |    3 +-
 drivers/usb/chipidea/Kconfig                       |    2 +-
 drivers/usb/chipidea/ci13xxx_imx.c                 |   15 +-
 drivers/usb/chipidea/core.c                        |    5 -
 drivers/usb/core/Kconfig                           |    2 +-
 drivers/usb/core/quirks.c                          |    3 +
 drivers/usb/dwc3/Kconfig                           |    6 +-
 drivers/usb/dwc3/dwc3-exynos.c                     |    6 +-
 drivers/usb/gadget/Kconfig                         |    1 -
 drivers/usb/gadget/atmel_usba_udc.c                |    2 -
 drivers/usb/gadget/bcm63xx_udc.c                   |   11 -
 drivers/usb/gadget/configfs.c                      |    8 +-
 drivers/usb/gadget/dummy_hcd.c                     |    5 +-
 drivers/usb/gadget/f_ecm.c                         |    1 +
 drivers/usb/gadget/f_subset.c                      |    1 +
 drivers/usb/gadget/f_uac2.c                        |    2 -
 drivers/usb/gadget/fusb300_udc.c                   |    4 +-
 drivers/usb/gadget/imx_udc.c                       |    2 -
 drivers/usb/gadget/m66592-udc.c                    |    4 +-
 drivers/usb/gadget/pxa25x_udc.c                    |    1 -
 drivers/usb/gadget/r8a66597-udc.c                  |    4 +-
 drivers/usb/gadget/s3c-hsotg.c                     |    2 +-
 drivers/usb/gadget/s3c2410_udc.c                   |    3 +-
 drivers/usb/gadget/zero.c                          |    8 +-
 drivers/usb/host/Kconfig                           |   17 +-
 drivers/usb/host/ehci-atmel.c                      |    6 +-
 drivers/usb/host/ehci-hcd.c                        |   17 -
 drivers/usb/host/ehci-omap.c                       |    8 +-
 drivers/usb/host/ehci-orion.c                      |    6 +-
 drivers/usb/host/ehci-s5p.c                        |    5 +-
 drivers/usb/host/ehci-spear.c                      |    6 +-
 drivers/usb/host/ehci-tegra.c                      |    6 +-
 drivers/usb/host/isp1760-hcd.c                     |    2 +-
 drivers/usb/host/isp1760-if.c                      |    4 +-
 drivers/usb/host/ohci-at91.c                       |    6 +-
 drivers/usb/host/ohci-exynos.c                     |    4 +-
 drivers/usb/host/ohci-hcd.c                        |   34 +-
 drivers/usb/host/ohci-nxp.c                        |   50 +-
 drivers/usb/host/ohci-omap3.c                      |    8 +-
 drivers/usb/host/ohci-pxa27x.c                     |    6 +-
 drivers/usb/host/ohci-spear.c                      |    6 +-
 drivers/usb/host/oxu210hp-hcd.c                    |    2 +-
 drivers/usb/host/sl811-hcd.c                       |    2 +-
 drivers/usb/host/uhci-hub.c                        |    3 +-
 drivers/usb/host/uhci-platform.c                   |    6 +-
 drivers/usb/host/uhci-q.c                          |    2 +-
 drivers/usb/host/xhci-mem.c                        |   17 +-
 drivers/usb/musb/musb_dsps.c                       |    1 +
 drivers/usb/musb/omap2430.c                        |    3 +-
 drivers/usb/phy/Kconfig                            |    5 +-
 drivers/usb/phy/phy-ab8500-usb.c                   |    2 -
 drivers/usb/phy/phy-fsl-usb.c                      |    1 +
 drivers/usb/phy/phy-gpio-vbus-usb.c                |    3 +-
 drivers/usb/phy/phy-isp1301.c                      |    1 +
 drivers/usb/phy/phy-mv-u3d-usb.c                   |    5 -
 drivers/usb/phy/phy-mv-usb.c                       |    3 -
 drivers/usb/phy/phy-mxs-usb.c                      |    8 +-
 drivers/usb/phy/phy-nop.c                          |    2 -
 drivers/usb/phy/phy-samsung-usb2.c                 |    5 -
 drivers/usb/phy/phy-samsung-usb3.c                 |    5 -
 drivers/usb/serial/ftdi_sio.c                      |   30 +-
 drivers/usb/serial/ftdi_sio_ids.h                  |    2 +
 drivers/usb/serial/generic.c                       |   31 +
 drivers/usb/serial/io_ti.c                         |   22 +-
 drivers/usb/serial/option.c                        |   13 +-
 drivers/usb/serial/ti_usb_3410_5052.c              |   23 +-
 drivers/usb/serial/usb-serial.c                    |   30 +-
 drivers/usb/storage/realtek_cr.c                   |    8 +-
 drivers/vhost/vringh.c                             |    3 +
 drivers/video/Kconfig                              |   19 +-
 drivers/video/Makefile                             |    1 +
 drivers/video/console/Makefile                     |    2 +
 drivers/video/omap2/dss/hdmi.c                     |    4 -
 drivers/video/omap2/vrfb.c                         |    5 -
 drivers/video/simplefb.c                           |  234 +++++
 drivers/w1/masters/omap_hdq.c                      |    5 -
 drivers/watchdog/ath79_wdt.c                       |    5 -
 drivers/watchdog/davinci_wdt.c                     |    5 -
 drivers/watchdog/imx2_wdt.c                        |    5 -
 drivers/xen/Kconfig                                |    7 +-
 drivers/xen/balloon.c                              |    3 +-
 drivers/xen/privcmd.c                              |    2 +-
 drivers/xen/tmem.c                                 |   87 +-
 drivers/xen/xen-selfballoon.c                      |   47 +-
 drivers/xen/xenbus/xenbus_dev_backend.c            |   21 +-
 fs/aio.c                                           |    7 +-
 fs/btrfs/backref.c                                 |    3 +-
 fs/btrfs/check-integrity.c                         |    2 +-
 fs/btrfs/ctree.c                                   |    4 +-
 fs/btrfs/ctree.h                                   |    8 +-
 fs/btrfs/delayed-ref.h                             |    1 +
 fs/btrfs/dev-replace.c                             |    5 +
 fs/btrfs/disk-io.c                                 |   52 +-
 fs/btrfs/extent-tree.c                             |   94 +-
 fs/btrfs/extent_io.c                               |  138 +--
 fs/btrfs/extent_io.h                               |    2 +
 fs/btrfs/free-space-cache.c                        |   43 +-
 fs/btrfs/free-space-cache.h                        |    2 +
 fs/btrfs/inode-map.c                               |    8 +-
 fs/btrfs/inode.c                                   |   81 +-
 fs/btrfs/ioctl.c                                   |   10 +-
 fs/btrfs/raid56.c                                  |    2 +-
 fs/btrfs/relocation.c                              |    7 +-
 fs/btrfs/scrub.c                                   |   10 +-
 fs/btrfs/super.c                                   |    1 +
 fs/btrfs/volumes.c                                 |   54 +-
 fs/btrfs/volumes.h                                 |   20 +
 fs/cifs/inode.c                                    |    3 +-
 fs/ext4/ext4.h                                     |    8 +-
 fs/ext4/extents.c                                  |    9 +-
 fs/ext4/extents_status.c                           |   17 +-
 fs/ext4/extents_status.h                           |    3 +-
 fs/ext4/file.c                                     |    4 +-
 fs/ext4/inode.c                                    |   85 +-
 fs/ext4/mballoc.c                                  |    6 +-
 fs/ext4/page-io.c                                  |  121 +--
 fs/fat/inode.c                                     |   15 +-
 fs/gfs2/Kconfig                                    |    2 +-
 fs/gfs2/lops.c                                     |    2 +-
 fs/gfs2/quota.c                                    |    4 +-
 fs/gfs2/rgrp.c                                     |    9 +-
 fs/hfs/bnode.c                                     |    6 +-
 fs/nfs/callback_proc.c                             |    2 +-
 fs/nfs/callback_xdr.c                              |    2 +-
 fs/nfs/nfs4client.c                                |    2 +-
 fs/nfs/nfs4proc.c                                  |    2 +-
 fs/nfs/nfs4session.c                               |    4 +-
 fs/nfs/nfs4session.h                               |   13 +-
 fs/nfs/nfs4state.c                                 |   15 +-
 fs/nilfs2/inode.c                                  |   27 +-
 fs/ocfs2/extent_map.c                              |    2 +-
 fs/ocfs2/file.c                                    |    2 +-
 fs/xfs/xfs_aops.c                                  |   19 +
 fs/xfs/xfs_attr_leaf.c                             |   27 +-
 fs/xfs/xfs_buf.c                                   |    2 +-
 fs/xfs/xfs_da_btree.c                              |    7 +-
 fs/xfs/xfs_dir2_leaf.c                             |    2 +-
 fs/xfs/xfs_extfree_item.c                          |    5 +-
 fs/xfs/xfs_log_cil.c                               |    2 +-
 fs/xfs/xfs_vnodeops.c                              |    4 +-
 include/acpi/acpi_bus.h                            |   40 +-
 include/acpi/acpiosxf.h                            |    2 +-
 include/acpi/processor.h                           |   10 +-
 include/drm/drmP.h                                 |    3 +-
 include/drm/drm_fb_helper.h                        |   15 +-
 include/drm/drm_os_linux.h                         |    9 -
 include/drm/drm_pciids.h                           |    6 +
 include/linux/acpi_dma.h                           |    4 +
 include/linux/bcma/bcma.h                          |    5 +-
 include/linux/brcmphy.h                            |    5 +
 include/linux/journal-head.h                       |    8 +-
 include/linux/kernel.h                             |    5 +-
 include/linux/kref.h                               |   33 +
 include/linux/mfd/abx500/ab8500.h                  |    2 -
 include/linux/mlx4/qp.h                            |   29 +-
 include/linux/netdevice.h                          |   11 +
 include/linux/of_platform.h                        |    5 +-
 include/linux/pci-acpi.h                           |    2 +
 include/linux/pinctrl/pinconf-generic.h            |   12 +-
 include/linux/platform_data/clk-lpss.h             |    5 +
 include/linux/platform_data/serial-omap.h          |    2 -
 include/linux/printk.h                             |    1 +
 include/linux/rio.h                                |   18 +-
 include/linux/rio_drv.h                            |    1 +
 include/linux/socket.h                             |    2 -
 include/linux/spi/spi.h                            |    4 +-
 include/linux/time.h                               |    4 -
 include/linux/uio.h                                |    3 +
 include/linux/usb/gadget.h                         |    5 +-
 include/linux/usb/serial.h                         |    4 +
 include/linux/vt_kern.h                            |    2 +-
 include/linux/wait.h                               |   16 +-
 include/net/mac80211.h                             |   12 +-
 include/net/netfilter/nf_log.h                     |    3 +-
 include/net/netfilter/nfnetlink_log.h              |    3 +-
 include/net/sock.h                                 |   12 +
 include/target/target_core_base.h                  |    5 -
 include/trace/events/ext4.h                        |    4 +-
 include/uapi/linux/virtio_console.h                |    2 +-
 ipc/sem.c                                          |   27 +-
 kernel/auditfilter.c                               |    3 -
 kernel/cpu/idle.c                                  |    2 +
 kernel/events/core.c                               |  240 ++---
 kernel/kmod.c                                      |    5 +
 kernel/module.c                                    |   21 +-
 kernel/rcutree_plugin.h                            |    4 +-
 kernel/time/Kconfig                                |    5 -
 kernel/time/tick-broadcast.c                       |   10 +-
 kernel/time/tick-sched.c                           |    3 +-
 kernel/timer.c                                     |    2 +-
 kernel/trace/trace_events.c                        |    4 +-
 kernel/trace/trace_events_filter.c                 |    4 +
 kernel/trace/trace_kprobe.c                        |   53 +-
 kernel/workqueue.c                                 |   19 +-
 lib/Makefile                                       |    2 +-
 lib/iovec.c                                        |   53 ++
 lib/klist.c                                        |    2 +-
 lib/mpi/longlong.h                                 |    5 +-
 mm/huge_memory.c                                   |    7 +-
 mm/memcontrol.c                                    |   14 +-
 mm/memory_hotplug.c                                |    9 +-
 mm/migrate.c                                       |    2 +-
 mm/mmu_notifier.c                                  |   79 +-
 mm/page_alloc.c                                    |    2 +-
 mm/pagewalk.c                                      |   70 +-
 net/802/mrp.c                                      |    4 +-
 net/batman-adv/distributed-arp-table.c             |   13 +
 net/batman-adv/main.c                              |   19 +-
 net/batman-adv/network-coding.c                    |    8 +-
 net/batman-adv/originator.c                        |   16 +
 net/batman-adv/originator.h                        |    1 +
 net/batman-adv/soft-interface.c                    |    1 +
 net/batman-adv/translation-table.c                 |    7 +-
 net/bridge/netfilter/ebt_log.c                     |   11 +-
 net/bridge/netfilter/ebt_ulog.c                    |   18 +-
 net/ceph/osd_client.c                              |    5 +-
 net/core/iovec.c                                   |   50 --
 net/core/sock.c                                    |   12 -
 net/ipv4/ip_gre.c                                  |    3 +-
 net/ipv4/ip_output.c                               |    2 +-
 net/ipv4/netfilter/ipt_ULOG.c                      |   13 +-
 net/ipv4/tcp.c                                     |   29 +-
 net/ipv4/tcp_input.c                               |   23 +-
 net/ipv4/tcp_output.c                              |   10 +-
 net/ipv6/ip6_gre.c                                 |    2 +
 net/ipv6/ip6_output.c                              |    2 +-
 net/ipv6/tcp_ipv6.c                                |   12 +
 net/ipv6/udp.c                                     |   13 +-
 net/ipv6/udp_impl.h                                |    2 +
 net/ipv6/udplite.c                                 |    2 +-
 net/ipv6/xfrm6_policy.c                            |    4 +-
 net/irda/irlap_frame.c                             |    2 +-
 net/mac80211/ieee80211_i.h                         |    1 +
 net/mac80211/mlme.c                                |   61 +-
 net/mac80211/rate.c                                |    9 +-
 net/mac80211/rx.c                                  |    3 +
 net/mac80211/tkip.c                                |    4 +-
 net/mac80211/util.c                                |    7 +
 net/netfilter/nf_log.c                             |    7 +-
 net/netfilter/nfnetlink_log.c                      |    6 +-
 net/netfilter/nfnetlink_queue_core.c               |    2 +
 net/netfilter/xt_LOG.c                             |   13 +-
 net/netfilter/xt_NFLOG.c                           |    3 +-
 net/netfilter/xt_TCPOPTSTRIP.c                     |   17 +-
 net/netlabel/netlabel_domainhash.c                 |   69 ++
 net/sunrpc/auth_gss/auth_gss.c                     |   62 +-
 net/sunrpc/netns.h                                 |    4 +
 net/sunrpc/rpc_pipe.c                              |    5 +
 net/sunrpc/sched.c                                 |    8 +-
 net/wireless/core.c                                |   17 +-
 net/wireless/nl80211.c                             |    4 +
 net/wireless/sme.c                                 |    3 +-
 net/wireless/trace.h                               |   23 +-
 net/xfrm/xfrm_output.c                             |    1 +
 scripts/package/Makefile                           |    2 +-
 sound/soc/codecs/cs42l52.c                         |    8 +-
 sound/soc/codecs/cs42l52.h                         |    2 +-
 sound/soc/codecs/max98090.c                        |    2 +-
 sound/soc/codecs/wm5110.c                          |    4 +-
 sound/soc/codecs/wm8994.c                          |   12 +-
 sound/soc/davinci/davinci-mcasp.c                  |    7 +-
 sound/soc/fsl/imx-ssi.c                            |    6 -
 sound/soc/kirkwood/kirkwood-i2s.c                  |    5 -
 sound/soc/soc-compress.c                           |    8 +-
 tools/perf/scripts/python/net_dropmonitor.py       |   39 +-
 tools/testing/selftests/Makefile                   |    1 -
 tools/testing/selftests/soft-dirty/Makefile        |   10 -
 tools/testing/selftests/soft-dirty/soft-dirty.c    |  114 ---
 841 files changed, 9100 insertions(+), 5717 deletions(-)
 rename Documentation/devicetree/bindings/{drm/exynos/hdmi.txt =3D> video/e=
xynos_hdmi.txt} (100%)
 rename Documentation/devicetree/bindings/{drm/exynos/hdmiddc.txt =3D> vide=
o/exynos_hdmiddc.txt} (100%)
 rename Documentation/devicetree/bindings/{drm/exynos/hdmiphy.txt =3D> vide=
o/exynos_hdmiphy.txt} (100%)
 rename Documentation/devicetree/bindings/{drm/exynos/mixer.txt =3D> video/=
exynos_mixer.txt} (100%)
 create mode 100644 Documentation/devicetree/bindings/video/simple-framebuf=
fer.txt
 create mode 100644 Documentation/kernel-per-CPU-kthreads.txt
 delete mode 100644 arch/avr32/include/asm/numnodes.h
 delete mode 100644 arch/avr32/include/asm/param.h
 delete mode 100644 arch/avr32/include/uapi/asm/param.h
 create mode 100644 arch/mips/include/asm/idle.h
 rename arch/mips/include/{ =3D> uapi}/asm/kvm.h (100%)
 create mode 100644 arch/mips/kernel/idle.c
 create mode 100644 arch/powerpc/include/asm/context_tracking.h
 create mode 100644 arch/powerpc/sysdev/udbg_memcons.c
 delete mode 100644 drivers/acpi/csrt.c
 create mode 100644 drivers/staging/zcache/ramster/ramster-howto.txt
 create mode 100644 drivers/video/simplefb.c
 create mode 100644 lib/iovec.c
 delete mode 100644 tools/testing/selftests/soft-dirty/Makefile
 delete mode 100644 tools/testing/selftests/soft-dirty/soft-dirty.c

--b5sSX5qSQrSInIHt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRpdw3AAoJELSic+t+oim9YskP/0IAxQKG0u7k0yI6Z1vdYLD8
fIvq1yF1Lz29a+xqgsihaA0jNsvFc3TFb1EMW66F2G+ghYxCxFB+hBW2Q3SSAgot
KxVdRPYS3/8gbar5Gdk+ckPlzdQLydL3kT8XBG4ktANza12lnrHPcVAEv+1t5NlR
zF1n5kXXI4YFnFpQYBtp9M3J5y0cnFFKXMUs/yU9N5kCLzfv3Re3s2/Dd1fijHmr
5CPaHpg+lKvxnZl9kXtRuicIBXSrNZuZbHW9lUxyaLXAFCKWNEQjYf6i5fjONcQC
F1ellskU85xKfTYPPmKIRne1ntf2hgie0OWBVLUcuDDkIFZO2q8040iOGhNFWj2K
ju1MzQPL7AllEgaGeHtOI3eSEb59F86kxOqbYsjcEu/8w4XWAd0vpEUvmYvwcSNL
gB0KXqPZg/FmUTu1OodJF9jTdaRq6+e9BG/BDiZFpbMvzNgeehZaWYnCA27xgLSg
VjKVWVuygdBm7Eimzf/oPSyL8kehOCNLcMHcaZ2XRzQRbXt/XZz09P6jP9RwlSo0
28eq2lmvcBG93jPHlpwIPsImvAQAwaQN4laSSw+LeSRmFrUKAxPvEzT94cQ9Ydug
VfVjSRYxMQVcaykF1njr/wi7Z+55JDBBu9nreDkZmcLuQ/LvFxY51eEDVYh2mT0T
3C6QO568cuzKSus1MRy0
=a0cs
-----END PGP SIGNATURE-----

--b5sSX5qSQrSInIHt--

--===============1029421393593754837==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1029421393593754837==--
