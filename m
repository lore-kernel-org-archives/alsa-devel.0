From: Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] ASoC updates for v5.1
Date: Thu, 28 Feb 2019 12:25:23 +0000
Message-ID: <20190228122523.GB6802@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1770474234393986745=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5946EF89691
 for <alsa-devel@alsa-project.org>; Thu, 28 Feb 2019 13:25:25 +0100 (CET)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============1770474234393986745==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Y7xTucakfITjPcLV"
Content-Disposition: inline


--Y7xTucakfITjPcLV
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The following changes since commit 00a399cad1a063e7665f06b6497a807db20441fd:

  ALSA: pcm: Revert capture stream behavior change in blocking mode (2019-0=
2-08 16:54:31 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/as=
oc-v5.1-2

for you to fetch changes up to 3146089d235b304e665dc551472ae9cb9ab58572:

  Merge branch 'asoc-5.1' into asoc-next (2019-02-26 16:22:47 +0000)

----------------------------------------------------------------
ASoC: More changes for v5.1

Another batch of changes for ASoC, no big core changes - it's mainly
small fixes and improvements for individual drivers.

 - A big refresh and cleanup of the Samsung drivers, fixing a number of
   issues which allow the driver to be used with a wider range of
   userspaces.
 - Fixes for the Intel drivers to make them more standard so less likely
   to get bitten by core issues.
 - New driver for Cirrus Logic CS35L26.

----------------------------------------------------------------
Aaro Koskinen (3):
      ARM: OMAP: dts: N950/N9: fix onenand timings
      MIPS: OCTEON: don't set octeon_dma_bar_type if PCI is disabled
      staging: octeon: fix broken phylib usage

Abel Vesa (1):
      clk: imx: Fix fractional clock set rate computation

Adam Thomson (2):
      ASoC: da7219: Add support for master mode BCLK rate adjustment
      ASoC: da7219: Update TDM usage to be more flexible

Aditya Swarup (1):
      drm/i915/cnl: Fix CNL macros for Voltage Swing programming

Al Viro (2):
      btrfs: fix potential oops in device_list_add
      missing barriers in some of unix_sock ->addr and ->path accesses

Alban Crequy (1):
      bpf, lpm: fix lookup bug in map_delete_elem

Alex Deucher (4):
      drm/amdgpu: Add missing power attribute to APU check
      drm/radeon: check if device is root before getting pci speed caps
      drm/amdgpu/psp11: TA firmware is optional (v3)
      drm/amdgpu: Set DPM_FLAG_NEVER_SKIP when enabling PM-runtime

Alexander Duyck (2):
      mm: Use fixed constant in page_frag_alloc instead of size + 1
      net: Do not allocate page fragments that are not skb aligned

Alexander Shiyan (1):
      gpu: ipu-v3: Fix i.MX51 CSI control registers offset

Alexander Usyskin (1):
      mei: free read cb on ctrl_wr list flush

Alexandre Belloni (2):
      clk: at91: fix at91sam9x5 peripheral clock number
      clk: at91: fix masterck name

Alexandre Ghiti (1):
      riscv: Adjust mmap base address at a third of task size

Alexandre Torgue (1):
      net: stmmac: handle endianness in dwmac4_get_timestamp

Alexei Naberezhnov (1):
      md/raid5: fix 'out of memory' during raid cache recovery

Alexei Starovoitov (5):
      Merge branch 'typedef-func_proto'
      bpf: run bpf programs with preemption disabled
      bpf: fix lockdep false positive in percpu_freelist
      bpf: fix potential deadlock in bpf_prog_register
      bpf: fix lockdep false positive in stackmap

Alexey Brodkin (1):
      ARC: define ARCH_SLAB_MINALIGN =3D 8

Alexey Dobriyan (1):
      proc: fix /proc/net/* after setns(2)

Alexey Kardashevskiy (1):
      powerpc/powernv/sriov: Register IOMMU groups for VFs

Alexey Khoroshilov (3):
      net: stmmac: dwmac-rk: fix error handling in rk_gmac_powerup()
      usb: dwc3: exynos: Fix error handling of clk_prepare_enable
      net: mv643xx_eth: disable clk on error path in mv643xx_eth_shared_pro=
be()

Alistair Francis (1):
      RISC-V: defconfig: Enable Generic PCIE by default

Amit Kucheria (2):
      thermal: of-thermal: Print name of device node with error
      thermal: cpu_cooling: Clarify error message

Anders Roxell (3):
      netfilter: ipt_CLUSTERIP: fix warning unused variable cn
      usb: phy: fix link errors
      kasan: mark file common so ftrace doesn't trace it

Andi Kleen (1):
      perf script: Fix crash with printing mixed trace point and other even=
ts

Andre Przywara (1):
      clk: sunxi: A31: Fix wrong AHB gate number

Andrea Arcangeli (1):
      mm/hugetlb.c: teach follow_hugetlb_page() to handle FOLL_NOWAIT

Andrea Claudi (2):
      ipvs: fix dependency on nf_defrag_ipv6
      ipvs: fix warning on unused variable

Andreas Gruenbacher (1):
      gfs2: Revert "Fix loop in gfs2_rbm_find"

Andreas Schwab (2):
      RISC-V: fix bad use of of_node_put
      tty/serial: use uart_console_write in the RISC-V SBL early console

Andreas Ziegler (3):
      tracing: uprobes: Fix typo in pr_fmt string
      tracing/uprobes: Fix output for multiple string arguments
      tracing: probeevent: Correctly update remaining space in dynamic area

Andrei Vagin (1):
      kernel/exit.c: release ptraced tasks before zap_pid_ns_processes

Andrew Ford (1):
      ASoC: wm_adsp: Allow compressed buffers in any memory region

Andrew Lunn (4):
      net: dsa: mv88e6xxx: Fix serdes irq setup going recursive
      gpio: vf610: Mask all GPIO interrupts
      net: dsa: mv88e6xxx: Fix counting of ATU violations
      MAINTAINERS: Update the ocores i2c bus driver maintainer, etc

Andrew Morton (1):
      revert "initramfs: cleanup incomplete rootfs"

Andrey Konovalov (11):
      kasan: fix assigning tags twice
      kasan, kmemleak: pass tagged pointers to kmemleak
      kmemleak: account for tagged pointers when calculating pointer range
      kasan, slub: move kasan_poison_slab hook before page_address
      kasan, slub: fix conflicts with CONFIG_SLAB_FREELIST_HARDENED
      kasan, slub: fix more conflicts with CONFIG_SLAB_FREELIST_HARDENED
      kasan: fix random seed generation for tag-based mode
      kasan: prevent tracing of tags.c
      kasan, slab: fix conflicts with CONFIG_HARDENED_USERCOPY
      kasan, slab: make freelist stored without tags
      kasan, slab: remove redundant kasan_slab_alloc hooks

Andy Shevchenko (3):
      serial: 8250_pci: Make PCI class test non fatal
      dmaengine: dmatest: Abort test in case of mapping error
      gpiolib: acpi: Introduce ACPI_GPIO_QUIRK_ONLY_GPIOIO

Aneesh Kumar K.V (3):
      powerpc/radix: Fix kernel crash with mremap()
      mtd: Use mtd->name when registering nvmem device
      mtd: powernv_flash: Fix device registration error

Anoob Soman (1):
      scsi: libiscsi: Fix race between iscsi_xmit_task and iscsi_complete_t=
ask

Anson Huang (1):
      ARM: dts: imx6sx: correct backward compatible of gpt

Antony Pavlov (2):
      RISC-V: asm/page.h: fix spelling mistake "CONFIG_64BITS" -> "CONFIG_6=
4BIT"
      RISC-V: Kconfig: fix spelling mistake "traget" -> "target"

Ard Biesheuvel (3):
      arm64: kaslr: ensure randomized quantities are clean also when kaslr =
is off
      arm64, mm, efi: Account for GICv3 LPI tables in static memblock reser=
ve table
      efi/arm: Revert "Defer persistent reservations until after paging_ini=
t()"

Arnaldo Carvalho de Melo (5):
      perf python: Remove -fstack-clash-protection when building with some =
clang versions
      perf clang: Do not use 'return std::move(something)'
      tools headers uapi: Sync linux/in.h copy from the kernel sources
      perf symbols: Add fallback definitions for GELF_ST_VISIBILITY()
      perf trace: Support multiple "vfs_getname" probes

Arnd Bergmann (20):
      Merge tag 'imx-fixes-5.0' of git://git.kernel.org/.../shawnguo/linux =
into arm/fixes
      Merge tag 'soc-fsl-fix-v5.0' of git://git.kernel.org/.../leo/linux in=
to arm/fixes
      Merge tag 'imx-fixes-5.0-2' of git://git.kernel.org/.../shawnguo/linu=
x into arm/fixes
      Merge tag 'pxa-fixes-5.0' of https://github.com/rjarzmik/linux into a=
rm/fixes
      Merge tag 'renesas-fixes2-for-v5.0' of git://git.kernel.org/.../horms=
/renesas into arm/fixes
      Merge tag 'qcom-fixes-for-5.0-rc3' of git://git.kernel.org/.../agross=
/linux into arm/fixes
      Merge tag 'davinci-fixes-for-v5.0-part2' of git://git.kernel.org/.../=
nsekhar/linux-davinci into arm/fixes
      Merge tag 'omap-for-v5.0/fixes-rc3' of git://git.kernel.org/.../tmlin=
d/linux-omap into arm/fixes
      Merge tag 'amlogic-fixes-2.1' of git://git.kernel.org/.../khilman/lin=
ux-amlogic into arm/fixes
      Merge tag 'sunxi-fixes-for-5.0' of git://git.kernel.org/.../sunxi/lin=
ux into arm/fixes
      Merge tag 'renesas-fixes3-for-v5.0' of git://git.kernel.org/.../horms=
/renesas into arm/fixes
      Merge tag 'omap-for-v5.0/fixes-rc4' of git://git.kernel.org/.../tmlin=
d/linux-omap into fixes
      Merge tag 'v5.0-rockchip-dts32fixes-1' of git://git.kernel.org/.../mm=
ind/linux-rockchip into arm/fixes
      Merge tag 'v5.0-rockchip-dts64fixes-1' of git://git.kernel.org/.../mm=
ind/linux-rockchip into arm/fixes
      Merge tag 'imx-fixes-5.0-3' of git://git.kernel.org/.../shawnguo/linu=
x into arm/fixes
      Merge tag 'omap-for-v5.0/fixes-rc5' of git://git.kernel.org/.../tmlin=
d/linux-omap into arm/fixes
      Documentation: change linux-4.x references to 5.x
      phonet: fix building with clang
      Merge tag 'omap-for-v5.0/fixes-rc7-signed' of git://git.kernel.org/..=
=2E/tmlind/linux-omap into arm/fixes
      Merge tag 'mvebu-fixes-5.0-2' of git://git.infradead.org/linux-mvebu =
into arm/fixes

Artemy Kovalyov (1):
      RDMA/umem: Add missing initialization of owning_mm

Arthur Demchenkov (1):
      ARM: dts: n900: fix mmc1 card detect gpio polarity

Arthur Kiyanovski (2):
      net: ena: fix race between link up and device initalization
      net: ena: update driver version from 2.0.2 to 2.0.3

Arun Parameswaran (1):
      net: dsa: b53: Fix for failure when irq is not defined in dt

Aurelien Aptel (1):
      CIFS: fix use-after-free of the lease keys

Aviya Erenfeld (1):
      nl80211: Fix FTM per burst maximum value

Axel Lin (1):
      gpio: altera-a10sr: Set proper output level for direction_output

Aya Levin (1):
      net/mlx5e: Allow MAC invalidation while spoofchk is ON

Bard liao (1):
      ASoC: topology: free created components in tplg load error

Bart Van Assche (2):
      lib/test_rhashtable: Make test_insert_dup() allocate its hash table d=
ynamically
      RDMA/srp: Rework SCSI device reset handling

Bartosz Golaszewski (2):
      ARM: dts: da850: fix interrupt numbers for clocksource
      gpiolib: fix line event timestamps for nested irqs

Baruch Siach (2):
      Revert "PCI: armada8k: Add support for gpio controlled reset signal"
      arm64: dts: clearfog-gt-8k: fix SGMII PHY reset signal

Benedict Wong (1):
      xfrm: Make set-mark default behavior backward compatible

Beniamino Galvani (1):
      qmi_wwan: apply SET_DTR quirk to Sierra WP7607

Benjamin Coddington (1):
      NFS: Don't use page_file_mapping after removing the page

Bernard Pidoux (1):
      net/rose: fix NULL ax25_cb kernel panic

Bert Kenward (1):
      sfc: initialise found bitmap in efx_ef10_mtd_probe

Bhawanpreet Lakha (2):
      drm/amd/display: fix optimize_bandwidth func pointer for dce80
      drm/amd/display: set clocks to 0 on suspend on dce80

Biju Das (1):
      ARM: dts: r8a7743: Convert to new LVDS DT bindings

Bill Kuzeja (1):
      scsi: qla2xxx: Fix panic from use after free in qla2x00_async_tm_cmd

Bin Liu (1):
      usb: phy: am335x: fix race condition in _probe

Bjorn Andersson (1):
      pinctrl: qcom: qcs404: Correct SDC tile

Bjorn Helgaas (1):
      net: Don't default Cavium PTP driver to 'y'

Bj=C3=B6rn T=C3=B6pel (3):
      xsk: do not remove umem from netdevice on fall-back to copy-mode
      Revert "xsk: simplify AF_XDP socket teardown"
      i40e: fix XDP_REDIRECT/XDP xmit ring cleanup race

Bob Peterson (1):
      Revert "gfs2: read journal in large chunks to locate the head"

Bob Tracy (1):
      tools uapi: fix Alpha support

Bodong Wang (1):
      Revert "net/mlx5e: E-Switch, Initialize eswitch only if eswitch manag=
er"

Bogdan Togorean (3):
      ASoC: adau1977: Fix reset-gpios typo
      ASoC: adau1977: Add MICBIAS example in DT bindings
      ASoC: adau1977: Add support for setting MICBIAS via DT

Boris Brezillon (4):
      mtd: spinand: Handle the case where PROGRAM LOAD does not reset the c=
ache
      mtd: spinand: Fix the error/cleanup path in spinand_init()
      mtd: Remove a debug trace in mtdpart.c
      mtd: Make sure mtd->erasesize is valid even if the partition is of si=
ze 0

Borislav Petkov (2):
      MAINTAINERS: Add Andy and Darren as arch/x86/platform/ reviewers
      x86/a.out: Clear the dump structure initially

Brian Foster (2):
      xfs: eof trim writeback mapping as soon as it is cached
      xfs: end sync buffer I/O properly on shutdown error

Brian Norris (1):
      ath10k: correct bus type for WCN3990

Brian Welty (1):
      IB/{hfi1, qib}: Fix WC.byte_len calculation for UD_SEND_WITH_IMM

Carlo Caione (2):
      arm: dts: meson: Fix IRQ trigger type for macirq
      arm64: dts: imx8mq: Fix boot from eMMC

Catalin Marinas (1):
      arm64: Do not issue IPIs for user executable ptes

Changbin Du (1):
      kprobe: Do not use uaccess functions to access kernel memory that can=
 fault

Chaotian Jing (1):
      mmc: mediatek: fix incorrect register setting of hs400_cmd_int_delay

Charles Keepax (4):
      ASoC: wm_adsp: Factor out stripping padding from ADSP data
      ASoC: wm_adsp: Reorder some functions for improved clarity
      ASoC: wm_adsp: Refactor compress stream initialisation
      ASoC: wm_adsp: Improve logging messages

Chen-Yu Tsai (7):
      ARM: dts: sun6i: Add clock-output-names to osc24M clock
      pinctrl: sunxi: Fix and simplify pin bank regulator handling
      pinctrl: sunxi: Consider pin_base when calculating regulator array in=
dex
      pinctrl: sunxi: Correct number of IRQ banks on H6 main pin controller
      mmc: sunxi: Disable HS-DDR mode for H5 eMMC controller by default
      mmc: sunxi: Filter out unsupported modes declared in the device tree
      ASoC: sunxi: sun50i-codec-analog: Rename hpvcc regulator supply to cp=
vdd

Cheng-Yi Chiang (2):
      ASoC: qcom: Kconfig: select dmic for sdm845
      ASoC: qcom: Kconfig: fix dependency for sdm845

Chengguang Xu (1):
      m68k: set proper major_num when specifying module param major_num

Chris Brandt (1):
      serial: sh-sci: Do not free irqs that have already been freed

Chris Wilson (2):
      drm/amdgpu: Transfer fences to dmabuf importer
      drm/i915/fbdev: Actually configure untiled displays

Christian Brauner (4):
      selftests: add binderfs selftests
      binder: fix CONFIG_ANDROID_BINDER_DEVICES
      binderfs: respect limit on binder control creation
      binderfs: remove separate device_initcall()

Christian K=C3=B6nig (1):
      drm/amdgpu: disable bulk moves for now

Christoffer Dall (2):
      KVM: arm/arm64: Reset the VCPU without preemption and vcpu state load=
ed
      KVM: arm/arm64: vgic: Always initialize the group of private IRQs

Christoph Hellwig (5):
      iomap: fix a use after free in iomap_dio_rw
      drm/vmwgfx: remove CONFIG_X86 ifdefs
      drm/vmwgfx: remove CONFIG_INTEL_IOMMU ifdefs v2
      drm/vmwgfx: fix the check when to use dma_alloc_coherent
      drm/vmwgfx: unwind spaghetti code in vmw_dma_select_mode

Chuck Lever (1):
      svcrdma: Remove max_sge check at connect time

Clint Taylor (1):
      drm/i915/icl: combo port vswing programming changes per BSPEC

Codrin Ciubotariu (8):
      dmaengine: at_xdmac: Fix wrongfull report of a channel as in use
      ASoC: codecs: ad193x: Remove capture support for codecs without ADC
      ASoC: codecs: ad193x: Set constraint to always have 32 sample bits
      ASoC: codecs: ad193x: Fix frame polarity for DSP_A format
      ASoC: codecs: ad193x: Add runtime support for DSP_A and I2S modes
      ASoC: codecs: ad193x: Add support to disable on-chip PLL
      ASoC: codecs: pcm186x: fix wrong usage of DECLARE_TLV_DB_SCALE()
      ASoC: codecs: pcm186x: Fix energysense SLEEP bit

Colin Ian King (5):
      selftests: cpu-hotplug: fix case where CPUs offline > CPUs present
      x86/fault: Fix sign-extend unintended sign extension
      ieee802154: mcr20a: fix indentation, remove tabs
      ASoC: fsi: fix spelling mistake "doens't" -> "doesn't"
      net/mlx4_en: fix spelling mistake: "quiting" -> "quitting"

Cong Wang (6):
      netrom: switch to sock timer API
      xfrm: destroy xfrm_state synchronously on net exit path
      net_sched: fix a race condition in tcindex_destroy()
      net_sched: fix a memory leak in cls_tcindex
      net_sched: fix two more memory leaks in cls_tcindex
      team: avoid complex list operations in team_nl_cmd_options_set()

Corentin Labbe (2):
      xtensa: Fix typo use space=3D>user space
      xtensa: rename BUILTIN_DTB to BUILTIN_DTB_SOURCE

Damien Le Moal (1):
      scsi: sd_zbc: Fix zone information messages

Dan Carpenter (9):
      clk: ti: Fix error handling in ti_clk_parse_divider_data()
      scsi: bnx2fc: Fix error handling in probe()
      scsi: 53c700: pass correct "dev" to dma_alloc_attrs()
      skge: potential memory corruption in skge_get_regs()
      lib/test_kmod.c: potential double free in error handling
      net: dsa: Fix NULL checking in dsa_slave_set_eee()
      net: dsa: bcm_sf2: potential array overflow in bcm_sf2_sw_suspend()
      ASoC: dapm: Potential small memory leak in dapm_cnew_widget()
      ASoC: cs35l36: Fix an IS_ERR() vs NULL checking bug

Dan Murphy (1):
      iio: ti-ads8688: Update buffer allocation for timestamps

Daniel Baluta (1):
      ASoC: simple-card: Fix refcount underflow

Daniel Borkmann (6):
      bpf, doc: add reviewers to maintainers entry
      ipvlan, l3mdev: fix broken l3s mode wrt local routes
      Merge branch 'bpf-lockdep-fixes'
      ipvlan: disallow userns cap_net_admin to change global mode/flags
      Merge branch 'bpf-nfp-codegen-fixes'
      bpf, doc: add bpf list as secondary entry to maintainers file

Daniel Vetter (1):
      mm: don't let userspace spam allocations warnings

Darren Hart (VMware) (1):
      Documentation/ABI: Correct mlxreg-io KernelVersion for 5.0

Darrick J. Wong (2):
      xfs: set buffer ops when repair probes for btree type
      tmpfs: fix link accounting when a tmpfile is linked in

Dave Airlie (11):
      Merge branch 'drm-fixes-5.0' of git://people.freedesktop.org/~agd5f/l=
inux into drm-fixes
      Merge branch 'drm-fixes-5.0' of git://people.freedesktop.org/~agd5f/l=
inux into drm-fixes
      Merge branch 'vmwgfx-fixes-5.0-2' of git://people.freedesktop.org/~th=
omash/linux into drm-fixes
      Merge tag 'drm-intel-fixes-2019-02-07-1' of git://anongit.freedesktop=
=2Eorg/drm/drm-intel into drm-fixes
      Merge tag 'drm-misc-fixes-2019-02-07' of git://anongit.freedesktop.or=
g/drm/drm-misc into drm-fixes
      Merge tag 'imx-drm-fixes-2019-02-12' of git://git.pengutronix.de/pza/=
linux into drm-fixes
      Merge tag 'drm-misc-fixes-2019-02-13' of git://anongit.freedesktop.or=
g/drm/drm-misc into drm-fixes
      Merge tag 'drm-intel-fixes-2019-02-13' of git://anongit.freedesktop.o=
rg/drm/drm-intel into drm-fixes
      Merge branch 'drm-fixes-5.0' of git://people.freedesktop.org/~agd5f/l=
inux into drm-fixes
      Merge tag 'drm-intel-fixes-2019-02-20' of git://anongit.freedesktop.o=
rg/drm/drm-intel into drm-fixes
      Merge branch 'drm-fixes-5.0' of git://people.freedesktop.org/~agd5f/l=
inux into drm-fixes

Dave Chinner (2):
      Revert "mm: don't reclaim inodes with many attached pages"
      Revert "mm: slowly shrink slabs with a relatively small number of obj=
ects"

Dave Watson (2):
      net: tls: Save iv in tls_rec for async crypto requests
      net: tls: Fix deadlock in free_resources tx

David Chen (2):
      r8152: Add support for MAC address pass through on RTL8153-BD
      r8152: Fix an error on RTL8153-BD MAC Address Passthrough support

David Disseldorp (1):
      scsi: target: make the pi_prot_format ConfigFS path readable

David Hildenbrand (1):
      mm: migrate: don't rely on __PageMovable() of newpage after unlocking=
 it

David Howells (3):
      assoc_array: Fix shortcut creation
      keys: Fix dependency loop between construction record and auth key
      keys: Timestamp new keys

David S. Miller (49):
      Merge branch 'master' of git://git.kernel.org/.../klassert/ipsec
      Merge tag 'mlx5-fixes-2019-01-25' of git://git.kernel.org/.../saeed/l=
inux
      Merge branch 'hns-fixes'
      Merge git://git.kernel.org/.../pablo/nf
      Merge branch 'qed-Bug-fixes'
      Merge branch 'net-various-compat-ioctl-fixes'
      Merge branch 'erspan-always-reports-output-key-to-userspace'
      Merge branch 'virtio_net-Fix-problems-around-XDP-tx-and-napi_tx'
      Merge branch 'stmmac-fixes'
      Merge branch 'ieee802154-for-davem-2019-01-31' of git://git.kernel.or=
g/.../sschmidt/wpan
      Merge tag 'mac80211-for-davem-2019-02-01' of git://git.kernel.org/...=
/jberg/mac80211
      Merge tag 'batadv-net-for-davem-20190201' of git://git.open-mesh.org/=
linux-merge
      Merge branch 'smc-fixes'
      Merge git://git.kernel.org/.../bpf/bpf
      Merge branch 'vsock-virtio-hot-unplug'
      Merge branch 'smc-fixes'
      Merge tag 'wireless-drivers-for-davem-2019-02-04' of git://git.kernel=
=2Eorg/.../kvalo/wireless-drivers
      Merge branch 's390-qeth-fixes'
      Merge git://git.kernel.org/.../pablo/nf
      Merge tag 'mlx5-fixes-2019-02-05' of git://git.kernel.org/.../saeed/l=
inux
      Merge branch 'qed-Bug-fixes'
      Merge branch 'ipv6-fixes'
      Merge branch 'r8169-revert-two-commits-due-to-a-regression'
      Merge git://git.kernel.org/.../pablo/nf
      Merge tag 'mac80211-for-davem-2019-02-12' of git://git.kernel.org/...=
/jberg/mac80211
      Merge branch 'ena-races'
      Merge branch 'net_sched-some-fixes-for-cls_tcindex'
      Merge tag 'mlx5-fixes-2019-02-13' of git://git.kernel.org/.../saeed/l=
inux
      Merge git://git.kernel.org/.../pablo/nf
      Merge branch 'net-phy-fix-locking-issue'
      Merge tag 'mac80211-for-davem-2019-02-15' of git://git.kernel.org/...=
/jberg/mac80211
      Merge branch 'net-dsa-b53-VLAN-and-L2-fixes'
      net: Add header for usage of fls64()
      Merge git://git.kernel.org/.../bpf/bpf
      Merge branch 'tcp-fix-possible-crash-in-tcp_v4_err'
      Merge branch 'netdev-page_frag_alloc-fixes'
      Merge branch 'qed-iWARP'
      Merge tag 'wireless-drivers-for-davem-2019-02-18' of git://git.kernel=
=2Eorg/.../kvalo/wireless-drivers
      Merge git://git.kernel.org/.../pablo/nf
      Merge branch 'ipv6-route-rcu'
      Merge branch '40GbE' of git://git.kernel.org/.../jkirsher/net-queue
      Merge branch 'tipc-improvement-for-wait-and-wakeup'
      Merge branch 'report-erspan-version-field-just-for-erspan-tunnels'
      Merge branch 'master' of git://git.kernel.org/.../klassert/ipsec
      Merge branch 'nic-thunderx-fix-communication-races-between-VF-PF'
      Merge tag 'mac80211-for-davem-2019-02-22' of git://git.kernel.org/...=
/jberg/mac80211
      Merge branch 'bnxt_en-firmware-message-delay-fixes'
      Merge branch 'udp-a-few-fixes'
      Merge git://git.kernel.org/.../bpf/bpf

David Sterba (1):
      btrfs: clean up pending block groups when transaction commit aborts

Davidlohr Bueso (2):
      futex: Fix barrier comment
      xsk: share the mmap_sem for page pinning

Deepa Dinamani (1):
      selftests: fix timestamping Makefile

Deepak Rawat (1):
      drm/vmwgfx: Also check for crtc status while checking for DU active

Derek Basehore (1):
      clk: Remove global clk traversal on fetch parent index

Dietmar Eggemann (1):
      ARM: 8824/1: fix a migrating irq bug when hotplug cpu

Dmitry Torokhov (7):
      pinctrl: cherryview: fix Strago DMI workaround
      Input: cap11xx - switch to using set_brightness_blocking()
      Input: ps2-gpio - flush TX work when closing port
      Input: matrix_keypad - use flush_delayed_work()
      Input: qt2160 - switch to using brightness_set_blocking()
      Revert "Input: elan_i2c - add ACPI ID for touchpad in ASUS Aspire F5-=
573G"
      Input: apanel - switch to using brightness_set_blocking()

Dmitry V. Levin (1):
      parisc: Fix ptrace syscall number modification

Dmitry Voytik (1):
      arm64: dts: rockchip: enable usb-host regulators at boot on rk3328-ro=
ck64

Doug Smythies (1):
      cpuidle: poll_state: Fix default time limit

Douglas Gilbert (1):
      scsi: scsi_debug: fix write_same with virtual_gb problem

Eli Cooper (1):
      netfilter: ipv6: Don't preserve original oif for loopback address

Enric Balletbo i Serra (1):
      arm64: dts: rockchip: fix graph_port warning on rk3399 bob kevin and =
excavator

Eric Anholt (1):
      drm/sched: Always trace the dependencies we wait on, to fix a race.

Eric Biggers (3):
      KEYS: allow reaching the keys quotas exactly
      KEYS: user: Align the payload buffer
      KEYS: always initialize keyring_index_key::desc_len

Eric Dumazet (12):
      rds: fix refcount bug in rds_sock_addref
      dccp: fool proof ccid_hc_[rt]x_parse_options()
      mISDN: fix a race in dev_expire_timer()
      rxrpc: bad unlock balance in rxrpc_recvmsg
      vxlan: test dev->flags & IFF_UP before calling netif_rx()
      net/x25: do not hold the cpu too long in x25_new_lci()
      batman-adv: fix uninit-value in batadv_interface_tx()
      net: fix possible overflow in __sk_mem_raise_allocated()
      tcp: clear icsk_backoff in tcp_write_queue_purge()
      tcp: tcp_v4_err() should be more careful
      net/x25: fix a race in x25_bind()
      tcp: repaired skbs must init their tso_segs

Eric W. Biederman (6):
      signal: Make siginmask safe when passed a signal of 0
      btrfs: On error always free subvol_name in btrfs_mount
      signal: Always attempt to allocate siginfo for SIGSTOP
      signal: Always notice exiting tasks
      signal: Better detection of synchronous signals
      signal: Restore the stop PTRACE_EVENT_EXIT

Erik Schmauss (1):
      ACPI: Set debug output flags independent of ACPICA

Eugene Loh (1):
      kallsyms: Handle too long symbols in kallsyms.c

Eugeniy Paltsev (5):
      ARCv2: Enable unaligned access in early ASM code
      ARCv2: lib: memcpy: fix doing prefetchw outside of buffer
      ARC: fix actionpoints configuration detection
      ARC: U-boot: check arguments paranoidly
      ARC: enable uboot support unconditionally

Fathi Boudra (2):
      selftests: net: use LDLIBS instead of LDFLAGS
      selftests: timers: use LDLIBS instead of LDFLAGS

Felix Fietkau (3):
      batman-adv: release station info tidstats
      mac80211: ensure that mgmt tx skbs have tailroom for encryption
      mac80211: allocate tailroom for forwarded mesh packets

Feras Daoud (1):
      IB/ipoib: Fix for use-after-free in ipoib_cm_tx_start

Fernando Fernandez Mancera (1):
      netfilter: nfnetlink_osf: add missing fmatch check

Filipe Manana (1):
      Btrfs: fix deadlock when allocating tree block during leaf/node split

Florian Fainelli (7):
      net: systemport: Fix WoL with password after deep sleep
      net: dsa: b53: Fix default VLAN ID
      net: dsa: b53: Properly account for VLAN filtering
      net: systemport: Fix reception of BPDUs
      net: dsa: bcm_sf2: Do not assume DSA master supports WoL
      net: dsa: b53: Do not program CPU port's PVID
      Documentation: networking: switchdev: Update port parent ID section

Florian Westphal (15):
      selftests: xfrm: add block rules with adjacent/overlapping subnets
      xfrm: policy: use hlist rcu variants on inexact insert, part 2
      xfrm: policy: increment xfrm_hash_generation on hash rebuild
      xfrm: policy: delete inexact policies from inexact list on hash rebui=
ld
      xfrm: policy: fix reinsertion on node merge
      selftests: xfrm: alter htresh to trigger move of policies to hash tab=
le
      xfrm: policy: fix infinite loop when merging src-nodes
      xfrm: refine validation of template and selector families
      netfilter: nft_compat: use refcnt_t type for nft_xt reference count
      netfilter: nft_compat: make lists per netns
      netfilter: nft_compat: destroy function must not have side effects
      netfilter: ebtables: compat: un-break 32bit setsockopt when no rules =
are present
      selftests: netfilter: add simple masq/redirect test cases
      netfilter: nft_compat: don't use refcount_inc on newly allocated entry
      netfilter: nat: fix spurious connection timeouts

Francesco Ruggeri (1):
      netfilter: compat: initialize all fields in xt_init

Gabriel Fernandez (1):
      Input: st-keyscan - fix potential zalloc NULL dereference

Gao Xiang (1):
      staging: erofs: keep corrupted fs from crashing kernel in erofs_namei=
()

Geert Uytterhoeven (3):
      arm64: dts: renesas: r8a774a1: Enable DMA for SCIF2
      arm64: dts: renesas: r8a7796: Enable DMA for SCIF2
      arm64: dts: renesas: r8a77965: Enable DMA for SCIF2

George Amanakis (1):
      tun: move the call to tun_set_real_num_queues

George Wilkie (1):
      team: use operstate consistently for linkup

Gerald Schaefer (1):
      iommu/vt-d: Fix memory leak in intel_iommu_put_resv_regions()

Gilad Ben-Yossef (1):
      crypto: ccree - fix resume race condition on init

Govindarajulu Varadarajan (1):
      enic: fix checksum validation for IPv6

Greg Kroah-Hartman (11):
      debugfs: fix debugfs_rename parameter checking
      debugfs: return error values, not NULL
      debugfs: debugfs_lookup() should return NULL if not found
      Revert "staging: erofs: keep corrupted fs from crashing kernel in ero=
fs_namei()"
      Merge tag 'fixes-for-v5.0-rc4' of git://git.kernel.org/.../balbi/usb =
into usb-linus
      relay: check return of create_buf_file() properly
      blk-mq: protect debugfs_create_files() from failures
      serial: fix race between flush_to_ldisc and tty_open
      sctp: walk the list of asoc safely
      Merge tag 'iio-fixes-5.0a' of git://git.kernel.org/.../jic23/iio into=
 staging-linus
      rpc: properly check debugfs dentry before using it

Guennadi Liakhovetski (1):
      ASoC: regulator notifier registration should be managed

Guenter Roeck (1):
      hwmon: (nct6775) Fix fan6 detection for NCT6793D

Guido G=C3=BCnther (1):
      dt-bindings: imx8mq: Number clocks consecutively

Guo Ren (6):
      riscv: fixup max_low_pfn with PFN_DOWN.
      csky: Fixup _PAGE_GLOBAL bit for 610 tlb entry
      csky: Fixup wrong pt_regs size
      csky: coding convention: Use task_stack_page
      csky: Fixup io-range page attribute for mmap("/dev/mem")
      csky: Fixup dead loop in show_stack

Gustavo A. R. Silva (4):
      usb: gadget: udc: net2272: Fix bitwise and boolean operations
      drm/amd/powerplay: Fix missing break in switch
      tty: serial: 8250_mtk: Fix potential NULL pointer dereference
      perf tests evsel-tp-sched: Fix bitwise operator

Guy Shattah (1):
      net/mlx5e: Use the inner headers to determine tc/pedit offload limita=
tion on decap flows

Hangbin Liu (4):
      geneve: should not call rt6_lookup() when ipv6 was disabled
      sit: check if IPv6 enabled before calling ip6_err_gen_icmpv6_unreach()
      net: vrf: remove MTU limits for vrf device
      Revert "bridge: do not add port to router list when receives query wi=
th source 0.0.0.0"

Hans Wippel (1):
      net/smc: allow 16 byte pnetids in netlink policy

Hans de Goede (2):
      iio: adc: axp288: Fix TS-pin handling
      libata: Add NOLPM quirk for SAMSUNG MZ7TE512HMHP-000L1 SSD

Harald Freudenberger (1):
      s390/zcrypt: fix specification exception on z196 during ap probe

Harini Katakam (1):
      net: macb: Apply RXUBR workaround only to versions with errata

Hauke Mehrtens (2):
      net: Fix for_each_netdev_feature on Big endian
      net: dsa: Remove documentation for port_fdb_prepare

He Kuang (1):
      perf top: Fix wrong hottest instruction highlighted

Hedi Berriche (1):
      x86/platform/UV: Use efi_runtime_lock to serialise BIOS calls

Heiko Schocher (1):
      ARM: dts: am335x-shc.dts: fix wrong cd pin level

Heiner Kallweit (5):
      Revert "r8169: remove unneeded mmiowb barriers"
      Revert "r8169: make use of xmit_more and __netdev_sent_queue"
      net: phy: fix interrupt handling in non-started states
      net: phy: don't use locking in phy_is_started
      net: phy: fix potential race in the phylib state machine

Helge Deller (1):
      CREDITS/MAINTAINERS: Retire parisc-linux.org email domain

Herbert Xu (2):
      mac80211: Use linked list instead of rhashtable walk for mesh tables
      mac80211: Free mpath object when rhashtable insertion fails

Heyi Guo (1):
      irqchip/gic-v4: Fix occasional VLPI drop

Hoang Le (1):
      tipc: fix skb may be leaky in tipc_link_input

Huacai Chen (2):
      cacheinfo: Keep the old value if of_property_read_u32 fails
      MIPS: Loongson: Introduce and use loongson_llsc_mb()

Huang Rui (1):
      drm/amdgpu: fix the incorrect external id for raven series

Huang Zijiang (1):
      net: hns: Fix object reference leaks in hns_dsaf_roce_reset()

Hui Wang (1):
      ALSA: hda/realtek: Disable PC beep in passthrough on alc285

Huy Nguyen (1):
      net/mlx5: No command allowed when command interface is not ready

Ian Kent (1):
      autofs: fix error return in autofs_fill_super()

Ilan Peer (1):
      mac80211: Fix Tx aggregation session tear down with ITXQs

Ilya Dryomov (1):
      libceph: handle an empty authorize reply

Ingo Molnar (3):
      Merge tag 'perf-urgent-for-mingo-5.0-20190121' of git://git.kernel.or=
g/.../acme/linux into perf/urgent
      Merge tag 'perf-urgent-for-mingo-5.0-20190205' of git://git.kernel.or=
g/.../acme/linux into perf/urgent
      perf/core: Fix impossible ring-buffer sizes warning

J. Bruce Fields (1):
      Revert "nfsd4: return default lease period"

Jack Morgenstein (1):
      IB/mlx4: Fix using wrong function to destroy sqp AHs under SRIOV

Jacob Wen (2):
      l2tp: fix reading optional fields of L2TPv3
      l2tp: copy 4 more bytes to linear part if necessary

Jakub Kicinski (1):
      tools: bpftool: fix crash with un-owned prog arrays

Jakub Sitnicki (1):
      sk_msg: Always cancel strp work before freeing the psock

James Bottomley (2):
      scsi: aic94xx: fix module loading
      scsi: sd: fix entropy gathering for most rotational disks

James Morse (4):
      arm64: kprobe: Always blacklist the KVM world-switch code
      arm64: hyp-stub: Forbid kprobing of the hyp-stub
      arm64: hibernate: Clean the __hyp_text to PoC after resume
      KVM: arm64: Forbid kprobing of the VHE world-switch code

James Schulman (2):
      ASoC: cs35l36: Add support for Cirrus CS35L36 Amplifier
      ASoC: cs35l36: Add device tree documentation for CS35L36

Jan Kara (3):
      mm: migrate: make buffer_migrate_page_norefs() actually succeed
      fs/drop_caches.c: avoid softlockups in drop_pagecache_sb()
      blktrace: Show requests without sector

Jan Sokolowski (1):
      ixgbe: don't do any AF_XDP zero-copy transmit if netif is not OK

Jani Nikula (2):
      drm/i915/opregion: fix version check
      drm/i915/opregion: rvda is relative from opregion base in opregion 2.=
1+

Jann Horn (6):
      fuse: call pipe_buf_release() under pipe lock
      kvm: fix kvm_ioctl_create_device() reference counting (CVE-2019-6974)
      netfilter: nf_nat_snmp_basic: add missing length checks in ASN.1 cbs
      mm: page_alloc: fix ref bias in page_frag_alloc() for 1-byte allocs
      MAINTAINERS: mark CAIF as orphan
      net: socket: add check for negative optlen in compat setsockopt

Jason Gunthorpe (2):
      RDMA/device: Expose ib_device_try_get(()
      IB/mlx5: Fix how advise_mr() launches async work

Jason Kridner (1):
      pinctrl: mcp23s08: spi: Fix regmap allocation for mcp23s18

Jason Wang (2):
      vhost: fix OOB in get_rx_bufs()
      vhost: correctly check the return value of translate_desc() in log_us=
ed()

Jay Cornwall (1):
      drm/amdgpu: Implement doorbell self-ring for NBIO 7.4

Jean-Philippe Brucker (1):
      arm64: kexec_file: handle empty command-line

Jeff Kirsher (1):
      ixgbe: fix older devices that do not support IXGBE_MRQC_L3L4TXSWEN

Jenny TC (1):
      ASoC: Intel: Boards: Add Maxim98373 support

Jens Axboe (5):
      Merge branch 'md-fixes' of https://github.com/liu-song-6/linux into f=
or-linus
      ide: ensure atapi sense request aren't preempted
      Merge branch 'nvme-5.0' of git://git.infradead.org/nvme into for-linus
      Merge branch 'md-fixes' of https://github.com/liu-song-6/linux into f=
or-linus
      Merge branch 'nvme-5.0' of git://git.infradead.org/nvme into for-linus

Jeremy Soller (1):
      ALSA: hda/realtek - Headset microphone and internal speaker support f=
or System76 oryp5

Jernej Skrabec (2):
      ARM: dts: sun8i: h3: Add ethernet0 alias to Beelink X2
      arm64: dts: allwinner: a64: Fix USB OTG regulator

Jerry Snitselaar (2):
      iommu/amd: Call free_iova_fast with pfn in map_sg
      iommu/amd: Unmap all mapped pages in error path of map_sg

Jesper Dangaard Brouer (1):
      MAINTAINERS: Add entry for XDP (eXpress Data Path)

Jiada Wang (1):
      ASoC: rsnd: gen: fix SSI9 4/5/6/7 busif related register address

Jianchao Wang (2):
      blk-mq: fix a hung issue when fsync
      blk-mq: insert rq with DONTPREP to hctx dispatch list when requeue

Jiong Wang (2):
      nfp: bpf: fix code-gen bug on BPF_ALU | BPF_XOR | BPF_K
      nfp: bpf: fix ALU32 high bits clearance bug

Jiri Olsa (4):
      perf ordered_events: Fix crash in ordered_events__free
      bpftool: Fix prog dump by tag
      perf symbols: Filter out hidden symbols from labels
      perf/x86: Add check_period PMU callback

Jisheng Zhang (2):
      i3c: fix missing detach if failed to retrieve i3c dev
      i3c: master: dw: fix deadlock

Joerg Roedel (1):
      iommu/mediatek: Use correct fwspec in mtk_iommu_add_device()

Johan Hovold (4):
      staging: speakup: fix tty-operation NULL derefs
      dt-bindings: sound: msm8916-wcd-analog: fix example regulator names
      ASoC: msm8916-wcd-analog: add missing license information
      ASoC: msm8916-wcd-digital: convert license header to SPDX

Johan Jonker (1):
      ARM: dts: rockchip: remove qos_cif1 from rk3188 power-domain

Johannes Berg (11):
      decnet: fix DN_IFREQ_SIZE
      Revert "socket: fix struct ifreq size in compat ioctl"
      Revert "kill dev_ifsioc()"
      net: socket: fix SIOCGIFNAME in compat
      net: socket: make bond ioctls go through compat_ifreq_ioctl()
      cfg80211: call disconnect_wk when AP stops
      cfg80211: pmsr: fix MAC address setting
      cfg80211: pmsr: fix abort locking
      mac80211: call drv_ibss_join() on restart
      cfg80211: pmsr: record netlink port ID
      cfg80211: prevent speculation on cfg80211_classify8021d() return

Johannes Weiner (4):
      psi: fix aggregation idle shut-off
      psi: clarify the Kconfig text for the default-disable option
      x86/resctrl: Avoid confusion over the new X86_RESCTRL config
      psi: avoid divide-by-zero crash inside virtual machines

John David Anglin (1):
      dsa: mv88e6xxx: Ensure all pending interrupts are handled prior to ex=
it

John Garry (1):
      scsi: libsas: Fix rphy phy_identifier for PHYs with end devices attac=
hed

John Johansen (1):
      apparmor: Fix aa_label_build() error handling for failed merges

Jonathan Bakker (2):
      Input: pwm-vibra - prevent unbalanced regulator
      Input: bma150 - register input device after setting private data

Jonathan Neusch=C3=A4fer (1):
      init/Kconfig: fix grammar by moving a closing parenthesis

Joonas Lahtinen (1):
      drm/i915: Prevent a race during I915_GEM_MMAP ioctl with WC set

Jose Abreu (4):
      net: stmmac: Fallback to Platform Data clock in Watchdog conversion
      net: stmmac: Send TSO packets always from Queue 0
      net: stmmac: Disable EEE mode earlier in XMIT callback
      net: stmmac: Fix a race in EEE enable callback

Josef Bacik (1):
      btrfs: don't end the transaction for delayed refs in throttle

Josh Elsasser (1):
      net: set default network namespace in init_dummy_netdev()

Josh Poimboeuf (1):
      cpu/hotplug: Fix "SMT disabled by BIOS" detection for KVM

Jouke Witteveen (1):
      Documentation: bring operstate documentation up-to-date

Juergen Gross (1):
      x86/mm: Make set_pmd_at() paravirt aware

Julia Lawall (1):
      drm/imx: imx-ldb: add missing of_node_puts

Julian Wiedmann (4):
      s390/qeth: release cmd buffer in error paths
      s390/qeth: fix use-after-free in error path
      s390/qeth: cancel close_dev work before removing a card
      s390/qeth: conclude all event processing before offlining a card

Julien Thierry (3):
      KVM: arm/arm64: vgic: Make vgic_irq->irq_lock a raw_spinlock
      KVM: arm/arm64: vgic: Make vgic_dist->lpi_list_lock a raw_spinlock
      KVM: arm/arm64: vgic: Make vgic_cpu->ap_list_lock a raw_spinlock

Jun-Ru Chang (1):
      MIPS: Remove function size check in get_frame_info()

Kai-Heng Feng (1):
      sky2: Increase D3 delay again

KaiChieh Chuang (2):
      ASoC: mediatek: use %pOFn instead of device_node.name
      ASoC: mediatek: btcvsd fix rx stream assign

Kairui Song (1):
      x86/kexec: Don't setup EFI info if EFI runtime is not enabled

Kal Conley (1):
      net/packet: fix 4gb buffer limit due to overflow check

Kalash Nainwal (1):
      net: Set rtm_table to RT_TABLE_COMPAT for ipv6 for tables > 255

Kan Liang (2):
      x86/cpu: Add Atom Tremont (Jacobsville)
      perf/x86/intel/uncore: Add Node ID mask

Karsten Graul (7):
      net/smc: prevent races between smc_lgr_terminate() and smc_conn_free()
      net/smc: don't wait for send buffer space when data was already sent
      net/smc: recvmsg and splice_read should return 0 after shutdown
      net/smc: do not wait under send_lock
      net/smc: call smc_cdc_msg_send() under send_lock
      net/smc: use device link provided in qp_context
      net/smc: fix use of variable in cleared area

Kees Cook (2):
      selftests/seccomp: Enhance per-arch ptrace syscall skip tests
      exec: load_script: Do not exec truncated interpreter path

Keith Busch (3):
      nvme: lock NS list changes while handling command effects
      nvme-pci: fix rapid add remove sequence
      nvme-pci: add missing unlock for reset error

Kirill A. Shutemov (1):
      x86/boot/compressed/64: Do not corrupt EDX on EFER.LME=3D1 setting

Kirill Marinushkin (2):
      ASoC: pcm3060: Add soft reset on probe
      ASoC: pcm3060: Add clock select

Koen Vandeputte (2):
      ARM: cns3xxx: Fix writing to wrong PCI config registers after alignme=
nt
      ARM: cns3xxx: Use actual size reads for PCIe

Konstantin Khlebnikov (1):
      inet_diag: fix reporting cgroup classid and fallback to priority

Kuninori Morimoto (1):
      ASoC: simple-card: fixup refcount_t underflow

Kyle Tso (1):
      usb: typec: tcpm: Correct the PPS out_volt calculation

Leo (Hanghong) Ma (1):
      drm/amd/display: Fix MST reboot/poweroff sequence

Leonard Crestez (2):
      PCI: imx: Fix probe failure without power domain
      PCI: imx: Fix checking pd_pcie_phy device link addition

Leonid Iziumtsev (1):
      dmaengine: imx-dma: fix wrong callback invoke

Li RongQing (2):
      ipv6: propagate genlmsg_reply return code
      mac80211_hwsim: propagate genlmsg_reply return code

Lijun Ou (1):
      RDMA/hns: Update the kernel header file of hns

Linus Torvalds (127):
      Merge git://git.kernel.org/.../davem/net
      Merge tag 'gpio-v5.0-3' of git://git.kernel.org/.../linusw/linux-gpio
      Merge tag 'iommu-fixes-v5.0-rc4' of git://git.kernel.org/.../joro/iom=
mu
      Merge tag 'sound-5.0-rc5' of git://git.kernel.org/.../tiwai/sound
      Merge tag 'nfs-for-5.0-3' of git://git.linux-nfs.org/projects/anna/li=
nux-nfs
      Merge tag 'linux-kselftest-5.0-rc5' of git://git.kernel.org/.../shuah=
/linux-kselftest
      Merge tag 'pci-v5.0-fixes-3' of git://git.kernel.org/.../helgaas/pci
      Merge branch 'linus' of git://git.kernel.org/.../herbert/crypto-2.6
      Merge tag 'clk-fixes-for-linus' of git://git.kernel.org/.../clk/linux
      x86: explicitly align IO accesses in memcpy_{to,from}io
      Merge tag 'i3c/fixes-for-5.0-rc5' of git://git.kernel.org/.../i3c/lin=
ux
      Merge tag 'mmc-v5.0-rc4' of git://git.kernel.org/.../ulfh/mmc
      Merge tag 'acpi-5.0-rc5' of git://git.kernel.org/.../rafael/linux-pm
      Merge tag 'pm-5.0-rc5' of git://git.kernel.org/.../rafael/linux-pm
      Merge tag 'iomap-5.0-fixes-1' of git://git.kernel.org/pub/scm/fs/xfs/=
xfs-linux
      Merge tag 'for-linus' of git://git.kernel.org/.../rdma/rdma
      Merge tag 'apparmor-pr-2019-02-01' of git://git.kernel.org/.../jj/lin=
ux-apparmor
      Merge tag '5.0-rc4-smb3-fixes' of git://git.samba.org/sfrench/cifs-2.6
      Merge tag 'arm64-fixes' of git://git.kernel.org/.../arm64/linux
      Merge tag 'xtensa-20190201' of git://github.com/jcmvbkbc/linux-xtensa
      Merge branch 'akpm' (patches from Andrew)
      Merge tag 'scsi-fixes' of git://git.kernel.org/.../jejb/scsi
      Merge tag 'for-linus-20190202' of git://git.kernel.dk/linux-block
      Merge tag 'riscv-for-linus-5.0-rc5' of git://git.kernel.org/.../palme=
r/riscv-linux
      Merge tag 'devicetree-fixes-for-5.0-3' of git://git.kernel.org/.../ro=
bh/linux
      Merge tag 'for-5.0-rc4-tag' of git://git.kernel.org/.../kdave/linux
      Merge branch 'efi-urgent-for-linus' of git://git.kernel.org/.../tip/t=
ip
      Merge branch 'perf-urgent-for-linus' of git://git.kernel.org/.../tip/=
tip
      Merge branch 'smp-urgent-for-linus' of git://git.kernel.org/.../tip/t=
ip
      Merge branch 'x86-urgent-for-linus' of git://git.kernel.org/.../tip/t=
ip
      Linux 5.0-rc5
      Merge tag 'pinctrl-v5.0-2' of git://git.kernel.org/.../linusw/linux-p=
inctrl
      Merge tag 'fuse-fixes-5.0-rc6' of git://git.kernel.org/.../mszeredi/f=
use
      Merge tag 'trace-v5.0-rc3' of git://git.kernel.org/.../rostedt/linux-=
trace
      Merge tag 'for_linus' of git://git.kernel.org/.../mst/vhost
      Merge tag 'sound-5.0-rc6' of git://git.kernel.org/.../tiwai/sound
      Merge branch 'for-linus' of git://git.kernel.org/.../hid/hid
      Merge tag 'for-5.0/dm-fixes-2' of git://git.kernel.org/.../device-map=
per/linux-dm
      Merge tag 'nfsd-5.0-1' of git://linux-nfs.org/~bfields/linux
      Merge tag 'for-linus' of git://git.kernel.org/pub/scm/virt/kvm/kvm
      Merge tag 'platform-drivers-x86-v5.0-2' of git://git.infradead.org/li=
nux-platform-drivers-x86
      Merge tag 'drm-fixes-2019-02-08' of git://anongit.freedesktop.org/drm=
/drm
      Merge tag 'xfs-5.0-fixes-1' of git://git.kernel.org/pub/scm/fs/xfs/xf=
s-linux
      Merge tag 'usb-5.0-rc6' of git://git.kernel.org/.../gregkh/usb
      Merge tag 'tty-5.0-rc6' of git://git.kernel.org/.../gregkh/tty
      Merge tag 'staging-5.0-rc6' of git://git.kernel.org/.../gregkh/staging
      Merge tag 'driver-core-5.0-rc6' of git://git.kernel.org/.../gregkh/dr=
iver-core
      Merge tag 'char-misc-5.0-rc6' of git://git.kernel.org/.../gregkh/char=
-misc
      Merge git://git.kernel.org/.../davem/net
      Merge tag 'acpi-5.0-rc6' of git://git.kernel.org/.../rafael/linux-pm
      Merge tag 'pci-v5.0-fixes-4' of git://git.kernel.org/.../helgaas/pci
      Merge tag 'iommu-fixes-v5.0-rc5' of git://git.kernel.org/.../joro/iom=
mu
      Merge tag 'scsi-fixes' of git://git.kernel.org/.../jejb/scsi
      Merge branch 'for-linus' of git://git.kernel.org/.../ebiederm/user-na=
mespace
      Merge tag 'powerpc-5.0-4' of git://git.kernel.org/.../powerpc/linux
      Merge tag 'arm64-fixes' of git://git.kernel.org/.../arm64/linux
      Merge tag 'armsoc-fixes-5.0' of git://git.kernel.org/.../soc/soc
      Merge tag 'for-linus-5.0-rc6-tag' of git://git.kernel.org/.../xen/tip
      Merge tag 'mtd/fixes-for-5.0-rc6' of git://git.infradead.org/linux-mtd
      Merge tag 'for-linus-20190209' of git://git.kernel.dk/linux-block
      Merge tag 'mips_fixes_5.0_3' of git://git.kernel.org/.../mips/linux
      Merge branch 'i2c/for-current' of git://git.kernel.org/.../wsa/linux
      Merge branch 'locking-urgent-for-linus' of git://git.kernel.org/.../t=
ip/tip
      Merge branch 'perf-urgent-for-linus' of git://git.kernel.org/.../tip/=
tip
      Merge branch 'irq-urgent-for-linus' of git://git.kernel.org/.../tip/t=
ip
      Merge branch 'x86-urgent-for-linus' of git://git.kernel.org/.../tip/t=
ip
      Merge tag 'dmaengine-fix-5.0-rc6' of git://git.infradead.org/users/vk=
oul/slave-dma
      Linux 5.0-rc6
      Merge branch 'for-linus' of git://git.kernel.org/.../mattst88/alpha
      Merge tag 's390-5.0-3' of git://git.kernel.org/.../s390/linux
      Merge branch 'fixes' of git://git.kernel.org/.../evalenti/linux-soc-t=
hermal
      Merge tag 'ext4_for_linus_stable' of git://git.kernel.org/.../tytso/e=
xt4
      Merge tag 'sound-5.0-rc7' of git://git.kernel.org/.../tiwai/sound
      Merge tag 'riscv-for-linus-5.0-rc7' of git://git.kernel.org/.../palme=
r/riscv-linux
      Merge tag 'hwmon-for-v5.0-rc7' of git://git.kernel.org/.../groeck/lin=
ux-staging
      Merge branch 'akpm' (patches from Andrew)
      Merge tag 'trace-v5.0-rc4' of git://git.kernel.org/.../rostedt/linux-=
trace
      Revert "exec: load_script: don't blindly truncate shebang string"
      Merge branch 'for-linus' of git://git.kernel.org/.../ebiederm/user-na=
mespace
      Merge git://git.kernel.org/.../davem/net
      Merge branch 'linus' of git://git.kernel.org/.../herbert/crypto-2.6
      Merge tag 'drm-fixes-2019-02-15-1' of git://anongit.freedesktop.org/d=
rm/drm
      Merge tag 'mmc-v5.0-rc5' of git://git.kernel.org/.../ulfh/mmc
      Merge tag 'for-5.0/dm-fixes-3' of git://git.kernel.org/.../device-map=
per/linux-dm
      Merge tag 'for-linus-20190215' of git://git.kernel.dk/linux-block
      Merge tag 'scsi-fixes' of git://git.kernel.org/.../jejb/scsi
      Merge tag 'compiler-attributes-for-linus-v5.0-rc7' of git://github.co=
m/ojeda/linux
      Merge tag 'auxdisplay-for-linus-v5.0-rc7' of git://github.com/ojeda/l=
inux
      Merge tag 'nfs-for-5.0-4' of git://git.linux-nfs.org/projects/anna/li=
nux-nfs
      Merge tag 'nfsd-5.0-2' of git://linux-nfs.org/~bfields/linux
      Merge tag 'armsoc-fixes' of git://git.kernel.org/.../soc/soc
      Merge tag 'for-linus' of git://git.kernel.org/pub/scm/virt/kvm/kvm
      Merge branch 'for-linus' of git://git.kernel.org/.../dtor/input
      Merge branch 'i2c/for-current' of git://git.kernel.org/.../wsa/linux
      Merge tag 'csky-for-linus-5.0-rc6' of git://github.com/c-sky/csky-lin=
ux
      Merge tag 'powerpc-5.0-5' of git://git.kernel.org/.../powerpc/linux
      Merge branch 'perf-urgent-for-linus' of git://git.kernel.org/.../tip/=
tip
      Merge branch 'x86-urgent-for-linus' of git://git.kernel.org/.../tip/t=
ip
      Merge branch 'efi-urgent-for-linus' of git://git.kernel.org/.../tip/t=
ip
      Linux 5.0-rc7
      Merge tag 'trace-v5.0-rc4-3' of git://git.kernel.org/.../rostedt/linu=
x-trace
      Merge tag 'for-linus' of git://git.armlinux.org.uk/~rmk/linux-arm
      Merge tag 'mailbox-fixes-v5.0-rc7' of git://git.linaro.org/landing-te=
ams/working/fujitsu/integration
      Merge git://git.kernel.org/.../davem/net
      Merge branch 'fixes-v5.1-rc6' of git://git.kernel.org/.../jmorris/lin=
ux-security
      Merge tag 'mtd/fixes-for-5.0-rc8' of git://git.infradead.org/linux-mtd
      Merge tag 'gpio-v5.0-4' of git://git.kernel.org/.../linusw/linux-gpio
      Merge tag 'pinctrl-v5.0-3' of git://git.kernel.org/.../linusw/linux-p=
inctrl
      Merge tag 'sound-5.0' of git://git.kernel.org/.../tiwai/sound
      Merge tag 'docs-5.0-fix' of git://git.lwn.net/linux
      Merge branch 'akpm' (patches from Andrew)
      Merge tag 'arm64-fixes' of git://git.kernel.org/.../arm64/linux
      Merge tag 'ceph-for-5.0-rc8' of git://github.com/ceph/ceph-client
      Merge tag 'clk-fixes-for-linus' of git://git.kernel.org/.../clk/linux
      Merge tag 'for-linus' of git://git.kernel.org/.../rdma/rdma
      Merge tag 'drm-fixes-2019-02-22' of git://anongit.freedesktop.org/drm=
/drm
      Merge tag 'kbuild-fixes-v5.0-2' of git://git.kernel.org/.../masahiroy=
/linux-kbuild
      Merge branch 'parisc-5.0-1' of git://git.kernel.org/.../deller/parisc=
-linux
      Merge tag 'arc-5.0-final' of git://git.kernel.org/.../vgupta/arc
      Merge tag 'armsoc-fixes' of git://git.kernel.org/.../soc/soc
      Merge tag 'pm-5.0' of git://git.kernel.org/.../rafael/linux-pm
      Merge branch 'fixes-v5.0-rc7' of git://git.kernel.org/.../jmorris/lin=
ux-security
      Merge tag 'scsi-fixes' of git://git.kernel.org/.../jejb/scsi
      Merge tag 'powerpc-5.0-6' of git://git.kernel.org/.../powerpc/linux
      Merge git://git.kernel.org/.../davem/net
      Merge tag 'for-linus' of git://git.kernel.org/pub/scm/virt/kvm/kvm
      Linux 5.0-rc8

Linus Walleij (2):
      Merge tag 'gpio-5.0-rc4-fixes-for-linus' of git://git.kernel.org/.../=
brgl/linux into fixes
      net: phy: realtek: Dummy IRQ calls for RTL8366RB

Liu Bo (3):
      blk-iolatency: fix IO hang due to negative inflight counter
      Blk-iolatency: warn on negative inflight IO counter
      blk-mq: remove duplicated definition of blk_mq_freeze_queue

Lorenzo Bianconi (8):
      net: ip_gre: always reports o_key to userspace
      net: ip6_gre: always reports o_key to userspace
      mt76x0: eeprom: fix chan_vs_power map in mt76x0_get_power_info
      net: ipv4: use a dedicated counter for icmp_v4 redirect packets
      net: ip6_gre: initialize erspan_ver just for erspan tunnels
      net: ip_gre: do not report erspan_ver for gre or gretap
      net: ip6_gre: do not report erspan_ver for ip6gre or ip6gretap
      net: ip6_gre: fix possible NULL pointer dereference in ip6erspan_set_=
version

Loys Ollivier (1):
      arm64: dts: meson: Fix mmc cd-gpios polarity

Lu Baolu (1):
      iommu/vt-d: Leave scalable mode default off

Lubomir Rintel (5):
      Revert "Input: olpc_apsp - enable the SP clock"
      Revert "clk: mmp2: add SP clock"
      Revert "dt-bindings: marvell,mmp2: Add clock id for the SP clock"
      irqchip/mmp: Only touch the PJ4 IRQ & FIQ bits on enable/disable
      gpio: pxa: avoid attempting to set pin direction via pinctrl on MMP2

Luca Coelho (1):
      iwlwifi: make IWLWIFI depend on CFG80211

Lucas De Marchi (1):
      drm/i915: always return something on DDI clock selection

Lucas Stach (1):
      gpu: ipu-v3: pre: don't trigger update if buffer address doesn't chan=
ge

Lukas Bulwahn (1):
      MAINTAINERS: unify reference to xen-devel list

Lukas Wunner (3):
      mmc: bcm2835: Fix DMA channel leak on probe error
      dmaengine: bcm2835: Fix interrupt race on RT
      dmaengine: bcm2835: Fix abort of transactions

Luwei Kang (1):
      KVM: x86: Recompute PID.ON when clearing PID.SN

Lyude Paul (1):
      drm/i915: Block fbdev HPD processing during suspend

Maciej Kwiecien (1):
      sctp: don't compare hb_timer expire date before starting it

Madalin Bucur (1):
      soc: fsl: qbman: avoid race in clearing QMan interrupt

Magnus Karlsson (3):
      xsk: add missing smp_rmb() in xsk_mmap
      i40e: fix potential RX buffer starvation for AF_XDP
      ixgbe: fix potential RX buffer starvation for AF_XDP

Manish Chopra (7):
      qed: Fix bug in tx promiscuous mode settings
      qed: Fix LACP pdu drops for VFs
      qed: Fix VF probe failure while FLR
      qed: Fix system crash in ll2 xmit
      qed: Fix stack out of bounds bug
      qed: Fix EQ full firmware assert.
      qed*: Advance drivers version to 8.37.0.20

Mao Wenan (2):
      net: crypto set sk to NULL when af_alg_release.
      net: set static variable an initial value in atl2_probe()

Marc Gonzalez (1):
      ARM: tango: Improve ARCH_MULTIPLATFORM compatibility

Marc Zyngier (7):
      arm64: KVM: Don't generate UNDEF when LORegion feature is present
      irqchip/gic-v3-its: Plug allocation race for devices sharing a DevID
      irqchip/gic-v3-its: Gracefully fail on LPI exhaustion
      net: dsa: Fix lockdep false positive splat
      arm/arm64: KVM: Allow a VCPU to fully reset itself
      arm/arm64: KVM: Don't panic on failure to properly reset system regis=
ters
      arm: KVM: Add missing kvm_stage2_has_pmd() helper

Maria Pasechnik (1):
      net/mlx5e: Fix NULL pointer derefernce in set channels error flow

Mark Bloch (2):
      RDMA/mlx5: Fix check for supported user flags when creating a QP
      RDMA/mlx5: Fix flow creation on representors

Mark Brown (6):
      Merge branch 'for-5.0' of https://git.kernel.org/.../broonie/sound in=
to asoc-5.1
      Merge branch 'for-5.0' of https://git.kernel.org/.../broonie/sound in=
to asoc-5.1 for refcount fix
      Merge branch 'for-5.0' of https://git.kernel.org/.../broonie/sound in=
to asoc-5.1
      Merge branch 'for-5.0' of https://git.kernel.org/.../broonie/sound in=
to asoc-5.1
      Merge branch 'asoc-5.0' into asoc-linus
      Merge branch 'asoc-5.1' into asoc-next

Mark Rutland (2):
      perf/core: Don't WARN() for impossible ring-buffer sizes
      arm64: fix SSBS sanitization

Martin Blumenstingl (5):
      ARM: dts: meson8b: odroidc1: mark the SD card detection GPIO active-l=
ow
      ARM: dts: meson8b: ec100: mark the SD card detection GPIO active-low
      ARM: dts: meson8m2: mxiii-plus: mark the SD card detection GPIO activ=
e-low
      mmc: meson-gx: fix interrupt name
      pinctrl: meson: meson8b: fix the sdxc_a data 1..3 pins

Martin KaFai Lau (2):
      bpf: Fix syscall's stackmap lookup potential deadlock
      bpf: Fix narrow load on a bpf_sock returned from sk_lookup()

Martin Kelly (1):
      tools: iio: iio_generic_buffer: make num_loops signed

Martin Kepplinger (1):
      mtd: rawnand: gpmi: fix MX28 bus master lockup problem

Martin Schwidefsky (1):
      s390/suspend: fix stack setup in swsusp_arch_suspend

Martin Wilck (1):
      scsi: core: reset host byte in DID_NEXUS_FAILURE case

Martin Willi (1):
      esp: Skip TX bytes accounting when sending from a request socket

Martynas Pumputis (2):
      bpf, selftests: fix handling of sparse CPU allocations
      netfilter: nf_nat: skip nat clash resolution for same-origin entries

Masahiro Yamada (3):
      arch: unexport asm/shmparam.h for all architectures
      Rename include/{uapi =3D> }/asm-generic/shmparam.h really
      sh: fix build error for invisible CONFIG_BUILTIN_DTB_SOURCE

Masato Suzuki (1):
      scsi: sd_zbc: Fix sd_zbc_report_zones() buffer allocation

Mathias Thore (1):
      ucc_geth: Reset BQL queue when stopping device

Mathieu Desnoyers (1):
      ARM: 8834/1: Fix: kprobes: optimized kprobes illegal instruction

Mathieu Malaterre (1):
      ASoC: Use __printf markup to silence compiler

Matt Ranostay (1):
      iio: chemical: atlas-ph-sensor: correct IIO_TEMP values to millicelsi=
us

Matteo Croce (1):
      geneve: change NET_UDP_TUNNEL dependency to select

Matthew Wilcox (1):
      drm: Use array_size() when creating lease

Matti Kurkela (1):
      Input: elantech - enable 3rd button support on Fujitsu CELSIUS H780

Mauro Ciancio (1):
      Input: elan_i2c - add ACPI ID for touchpad in Lenovo V330-15ISK

Max Filippov (7):
      xtensa: SMP: fix ccount_timer_shutdown
      xtensa: SMP: fix secondary CPU initialization
      xtensa: smp_lx200_defconfig: fix vectors clash
      xtensa: SMP: mark each possible CPU as present
      drivers/irqchip: xtensa: add warning to irq_retrigger
      drivers/irqchip: xtensa-mx: fix mask and unmask
      xtensa: SMP: limit number of possible CPUs by NR_CPUS

Maxime Chevallier (1):
      net: phy: marvell10g: Fix Multi-G advertisement to only advertise 10G

Meelis Roos (1):
      alpha: Fix Eiger NR_IRQS to 128

Mel Gorman (1):
      mm, page_alloc: fix a division by zero error when boosting watermarks=
 v2

Michael Chan (3):
      bnxt_en: Disable interrupts when allocating CP rings or NQs.
      bnxt_en: Fix typo in firmware message timeout logic.
      bnxt_en: Wait longer for the firmware message response to complete.

Michael Ellerman (1):
      powerpc/64s: Fix possible corruption on big endian due to pgd/pud_pre=
sent()

Michael J. Ruhl (1):
      IB/hfi1: Remove overly conservative VM_EXEC flag check

Michael S. Tsirkin (1):
      virtio: drop internal struct from UAPI

Michal Hocko (6):
      Revert "mm, memory_hotplug: initialize struct pages for the full memo=
ry section"
      mm, memory_hotplug: is_mem_section_removable do not pass the end of a=
 zone
      mm, memory_hotplug: __offline_pages fix wrong locking
      proc, oom: do not report alien mms when setting oom_score_adj
      mm: handle lru_add_drain_all for UP properly
      mm, memory_hotplug: fix off-by-one in is_pageblock_removable

Michal Kalderon (2):
      qed: Fix iWARP buffer size provided for syn packet processing.
      qed: Fix iWARP syn packet mac address validation.

Michal Soltys (1):
      bonding: fix PACKET_ORIGDEV regression

Miguel Ojeda (4):
      auxdisplay: ht16k33: fix potential user-after-free on module unload
      lib/crc32.c: mark crc32_le_base/__crc32c_le_base aliases as __pure
      Compiler Attributes: add support for __copy (gcc >=3D 9)
      include/linux/module.h: copy __init/__exit attrs to init/cleanup_modu=
le

Mike Marciniszyn (1):
      IB/hfi1: Add limit test for RC/UC send via loopback

Mike Marshall (1):
      aio: initialize kiocb private in case any filesystems expect it.

Mike Snitzer (1):
      dm: don't use bio_trim() afterall

Mikhail Zaslonko (1):
      mm, memory_hotplug: test_pages_in_a_zone do not pass the end of zone

Miklos Szeredi (3):
      fuse: handle zero sized retrieve correctly
      cuse: fix ioctl
      fuse: decrement NR_WRITEBACK_TEMP on the right page

Mikulas Patocka (2):
      dm: add memory barrier before waitqueue_active
      dm crypt: don't overallocate the integrity tag space

Ming Lu (1):
      scsi: libfc: free skb when receiving invalid flogi resp

Moni Shoua (1):
      net/mlx5: Take lock with IRQs disabled to avoid deadlock

Murali Karicheri (1):
      net: netcp: Fix ethss driver probe issue

Nagadheeraj Rottela (1):
      crypto: cavium/nitrox - Invoke callback after DMA unmap

Naoya Horiguchi (1):
      mm: hwpoison: use do_send_sig_info() instead of force_sig()

Naresh Kamboju (1):
      selftests: netfilter: fix config fragment CONFIG_NF_TABLES_INET

Nate Dailey (1):
      md/raid1: don't clear bitmap bits on interrupted recovery.

Nathan Chancellor (3):
      drm/amdkfd: Fix if preprocessor statement above kfd_fill_iolink_info_=
for_cpu
      ASoC: codecs: jz4725b: Remove unnecessary const qualifier
      arm64/neon: Disable -Wincompatible-pointer-types when building with C=
lang

Neo Hou (2):
      gpio: sprd: Fix the incorrect data register
      gpio: sprd: Fix incorrect irq type setting for the async EIC

Nicholas Kazlauskas (3):
      drm/amd/display: Attach VRR properties for eDP connectors
      drm/amd/display: Expose connector VRR range via debugfs
      drm/amd/display: Fix negative cursor pos programming

Nicolas Morey-Chaisemartin (1):
      xprtrdma: Make sure Send CQ is allocated on an existing compvec

Nicolas Saenz Julienne (1):
      fpga: stratix10-soc: fix wrong of_node_put() in init function

Nikos Tsironis (1):
      dm thin: fix bug where bio that overwrites thin block ignores FUA

Nir Dotan (1):
      ip6mr: Fix notifiers call on mroute_clean_tables()

Oliver O'Halloran (1):
      powerpc/papr_scm: Use the correct bind address

Olivier Moysan (9):
      ASoC: stm32: i2s: add power management
      SoC: stm32: i2s: manage clock power
      ASoC: stm32: i2s: fix IRQ clearing
      ASoC: stm32: i2s: fix 16 bit format support
      ASoC: stm32: i2s: fix stream count management
      ASoC: stm32: i2s: fix dma configuration
      ASoC: stm32: i2s: remove useless callback
      ASoC: stm32: i2s: fix race condition in irq handler
      ASoC: stm32: i2s: skip useless write in slave mode

Or Gerlitz (3):
      net/mlx5e: Move to use common phys port names for vport representors
      net/mlx5e: Unblock setting vid 0 for VFs through the uplink rep
      net/mlx5e: Properly set steering match levels for offloaded TC decap =
rules

Oscar Salvador (2):
      mm, memory_hotplug: don't bail out in do_migrate_range() prematurely
      mm,memory_hotplug: fix scan_movable_pages() for gigantic hugepages

Pablo Neira Ayuso (3):
      netfilter: nf_tables: unbind set in rule from commit path
      netfilter: nft_compat: use-after-free when deleting targets
      netfilter: nf_tables: fix flush after rule deletion in the same batch

Palmer Dabbelt (3):
      RISC-V: defconfig: Move CONFIG_PCI{,E_XILINX}
      RISC-V: defconfig: Add CRYPTO_DEV_VIRTIO=3Dy
      Revert "RISC-V: Make BSS section as the last section in vmlinux.lds.S"

Pan Bian (1):
      autofs: drop dentry reference only when it is never used

Paolo Abeni (9):
      bpftool: fix percpu maps updating
      vsock: cope with memory allocation failure at socket creation time
      ipv6: route: enforce RCU protection in rt6_update_exception_stamp_rt()
      ipv6: route: enforce RCU protection in ip6_route_check_nh_onlink()
      ipv6: route: purge exception on removal
      udpv6: add the required annotation to mib type
      fou6: fix proto error handler argument type
      udpv6: fix possible user after free in error handler
      udp: fix possible user after free in error handler

Paolo Bonzini (3):
      KVM: x86: work around leak of uninitialized stack contents (CVE-2019-=
7222)
      Merge tag 'kvm-arm-fixes-for-5.0' of git://git.kernel.org/.../kvmarm/=
kvmarm into kvm-master
      Merge tag 'kvm-s390-master-5.0' of git://git.kernel.org/.../kvms390/l=
inux into kvm-master

Paul Burton (5):
      MIPS: VDSO: Use same -m%-float cflag as the kernel proper
      MIPS: VDSO: Include $(ccflags-vdso) in o32,n32 .lds builds
      MIPS: Use lower case for addresses in nexys4ddr.dts
      MIPS: eBPF: Always return sign extended 32b values
      MIPS: eBPF: Remove REG_32BIT_ZERO_EX

Paul Cercueil (1):
      MIPS: DTS: jz4740: Correct interrupt number of DMA core

Paul Elder (1):
      usb: gadget: musb: fix short isoc packets with inventra dma

Paul Kocialkowski (5):
      arm64: dts: allwinner: a64: Fix the video engine compatible
      clk: sunxi-ng: v3s: Fix TCON reset de-assert bit
      drm/sun4i: tcon: Prepare and enable TCON channel 0 clock at init
      i2c: bcm2835: Clear current buffer pointers and counts after a transf=
er
      net: phy: xgmiitorgmii: Support generic PHY status read

Pavel Shilovsky (4):
      CIFS: Fix possible oops and memory leaks in async IO
      CIFS: Fix trace command logging for SMB2 reads and writes
      CIFS: Do not count -ENODATA as failure for query directory
      CIFS: Do not consider -ENODATA as stat failure for reads

Pawe=C5=82 Chmiel (1):
      Input: pwm-vibra - stop regulator after disabling pwm, not before

Peng Hao (1):
      ARM: pxa: ssp: unneeded to free devm_ allocated data

Peter Seiderer (1):
      tlv320aic32x4: delay i2c access by 1 ms after hardware reset

Peter Shier (1):
      KVM: nVMX: unconditionally cancel preemption timer in free_nested (CV=
E-2019-7221)

Peter Ujfalusi (2):
      ARM: dts: am335x-evmsk: Fix PHY mode for ethernet
      ARM: dts: am335x-evm: Fix PHY mode for ethernet

Peter Zijlstra (2):
      perf/x86/intel: Delay memory deallocation until x86_pmu_dead_cpu()
      x86/mm/cpa: Fix set_mce_nospec()

Petr Machata (2):
      net: cls_flower: Remove filter from mask before freeing it
      mlxsw: __mlxsw_sp_port_headroom_set(): Fix a use of local variable

Petr Vorel (2):
      apparmor: Fix warning about unused function apparmor_ipv6_postroute
      doc: Mention MSG_ZEROCOPY implementation for UDP

Philip Yang (1):
      drm/amdgpu: use spin_lock_irqsave to protect vm_manager.pasid_idr

Philipp Zabel (1):
      drm/imx: ignore plane updates on disabled crtcs

Pierre Morel (1):
      s390: vsie: Use effective CRYCBD.31 to check CRYCBD validity

Pierre-Louis Bossart (20):
      ASoC: core: don't increase component module refcount unconditionally
      ASoC: Intel: Skylake: set .ignore_module_refcount field in component
      ASoC: hdac_hdmi: use devm_kzalloc for all structures
      ASoC: Intel: bxt-match: remove prefix for SOF files
      ASoC: Intel: byt-match.c: remove prefix for SOF files
      ASoC: Intel: cht-match: remove prefix for SOF files
      ASoC: Intel: cnl-match: remove prefix for SOF files
      ASoC: Intel: glk-match: remove prefix for SOF files
      ASoC: Intel: hda-match: remove prefix for SOF files
      ASoC: Intel: hsw-bdw-match: remove prefix for SOF files
      ASoC: Intel: icl-match: remove prefix for SOF files
      ASoC: Intel: soc-acpi: bxt-match: remove asoc_plat_name field
      ASoC: Intel: soc-acpi: byt-match: remove asoc_plat_name field
      ASoC: Intel: soc-acpi: cht-match: remove asoc_plat_name field
      ASoC: Intel: soc-acpi: glk-match: remove asoc_plat_name field
      ASoC: Intel: soc-acpi: hsw-bdw-match: remove asoc_plat_name field
      ASoC: Intel: soc-acpi: icl-match: remove asoc_plat_name field
      ASoC: Intel: soc-acpi: cnl-match.c: remove asoc_plat_name field
      ASoC: soc-acpi: remove asoc_plat_name field
      ASoC: soc-acpi: remove new_mach_data field

Piotr Jaroszynski (1):
      iomap: get/put the page in iomap_page_create/release()

Qian Cai (6):
      x86_64: increase stack size for KASAN_EXTRA
      mm/hotplug: invalid PFNs from pfn_to_online_page()
      efi/arm64: Fix debugfs crash by adding a terminator for ptdump marker
      Revert "mm: use early_pfn_to_nid in page_ext_init"
      slub: fix SLAB_CONSISTENCY_CHECKS + KASAN_SW_TAGS
      slub: fix a crash with SLUB_DEBUG + KASAN_SW_TAGS

Quentin Perret (1):
      tracing: Fix number of entries in trace header

Raed Salem (1):
      net/mlx5e: FPGA, fix Innova IPsec TX offload data path performance

Rafael J. Wysocki (4):
      Merge branch 'pm-cpuidle-fixes'
      Merge branch 'acpi-misc'
      gpu: drm: radeon: Set DPM_FLAG_NEVER_SKIP when enabling PM-runtime
      Merge branch 'pm-cpufreq-fixes'

Rahul Verma (1):
      qed: Change verbosity for coalescing message.

Rajneesh Bhardwaj (1):
      x86/CPU: Add Icelake model number

Raju Rangoju (2):
      cxgb4: Export sge_host_page_size to ulds
      iw_cxgb4: cq/qp mask depends on bar2 pages in a host page

Rakesh Pillai (1):
      mac80211: Restore vif beacon interval if start ap fails

Ralph Campbell (1):
      numa: change get_mempolicy() to use nr_node_ids instead of MAX_NUMNOD=
ES

Randy Dunlap (1):
      mtd: rawnand: fix kernel-doc warnings

Ravi Bangoria (1):
      perf mem/c2c: Fix perf_mem_events to support powerpc

Rayagonda Kokatanur (1):
      mailbox: bcm-flexrm-mailbox: Fix FlexRM ring flush timeout issue

Ren=C3=A9 van Dorst (1):
      gpio: MT7621: use a per instance irq_chip structure

Rob Herring (1):
      dt-bindings: Fix dt_binding_check target for in tree builds

Robin Murphy (2):
      ARM: 8835/1: dma-mapping: Clear DMA ops on teardown
      mm/debug.c: fix __dump_page() for poisoned pages

Rodrigo Siqueira (1):
      drm/vkms: Fix license inconsistent

Roger Quadros (1):
      gpio: pcf857x: Fix interrupts on multiple instances

Roman Li (2):
      drm/amd/display: Fix fclk idle state
      drm/amd/display: Raise dispclk value for dce11

Ronnie Sahlberg (2):
      cifs: fix computation for MAX_SMB2_HDR_SIZE
      cifs: limit amount of data we request for xattrs to CIFSMaxBufSize

Ross Lagerwall (1):
      Revert "scsi: libfc: Add WARN_ON() when deleting rports"

Rundong Ge (1):
      net: dsa: slave: Don't propagate flag changes on down slave interfaces

Russell King (8):
      ARM: iop32x/n2100: fix PCI IRQ mapping
      Revert "net: phy: marvell: avoid pause mode on SGMII-to-Copper for 88=
e151x"
      MAINTAINERS: add maintainer for SFF/SFP/SFP+ support
      ARM: OMAP2+: fix lack of timer interrupts on CPU1 after hotplug
      net: sfp: do not probe SFP module before we're attached
      net: phylink: avoid resolving link state too early
      net: dsa: fix unintended change of bridge interface STP state
      net: marvell: mvneta: fix DMA debug warning

Ryder Lee (1):
      pinctrl: mediatek: fix Kconfig build errors for moore core

S.j. Wang (1):
      ASoC: fsl_esai: fix register setting issue in RIGHT_J mode

Saeed Mahameed (2):
      net/mlx4_en: Force CHECKSUM_NONE for short ethernet frames
      net/mlx5e: XDP, fix redirect resources availability check

Salil Mehta (1):
      net: hns: Fixes the missing put_device in positive leg for roce reset

Sandeep Patil (1):
      mm: proc: smaps_rollup: fix pss_locked calculation

Sandy Huang (1):
      drm/rockchip: rgb: update SPDX license identifier

Scott Mayhew (1):
      sunrpc: fix 4 more call sites that were using stack memory with a sca=
tterlist

Sean Christopherson (1):
      KVM: nVMX: Restore a preemption timer consistency check

Sean Tranchetti (1):
      af_key: unconditionally clone on broadcast

Sean Young (1):
      selftests: Use lirc.h from kernel tree, not from system

Sebastian Andrzej Siewior (1):
      net: dp83640: expire old TX-skb

Sebastian Ott (1):
      Revert "s390/pci: remove bit_lock usage in interrupt handler"

Sergei Trofimovich (1):
      alpha: fix page fault handling for r16-r18 targets

Sergej Sawazki (2):
      ASoC: wm8741: Add digital mute callback
      ASoC: wm8741: Set OSR mode in hw_params()

Shakeel Butt (1):
      mm, oom: fix use-after-free in oom_kill_process

Shawn Guo (1):
      ARM: dts: vf610-bk4: fix incorrect #address-cells for dspi3

Shay Agroskin (1):
      net/mlx5e: Fix wrong private flag usage causing checksum disable

Shubhrajyoti Datta (1):
      i2c: cadence: Fix the hold bit setting

Sinan Kaya (3):
      mfd: Fix unmet dependency warning for MFD_TPS68470
      platform/x86: Fix unmet dependency warning for ACPI_CMPC
      platform/x86: Fix unmet dependency warning for SAMSUNG_Q10

Siva Rebbagondla (1):
      MAINTAINERS: add entry for redpine wireless driver

Souptick Joarder (1):
      arch/arm/xen: Remove duplicate header

Srinivas Kandagatla (1):
      arm64: dts: add msm8996 compatible to gicv3

Stanislav Fomichev (1):
      bpf/test_run: fix unkillable BPF_PROG_TEST_RUN

Stanislaw Gruszka (1):
      mt76x0u: fix suspend/resume

Stefan Agner (1):
      Input: snvs_pwrkey - allow selecting driver for i.MX 7D

Stefan Haberland (1):
      s390/dasd: fix using offset into zero size array error

Stefan O'Rear (1):
      riscv: Add pte bit to distinguish swap from invalid

Stefano Garzarella (2):
      vsock/virtio: fix kernel panic after device hot-unplug
      vsock/virtio: reset connected sockets on device removal

Steffen Maier (1):
      scsi: zfcp: fix sysfs block queue limit output for max_segment_size

Stephane Eranian (2):
      perf core: Fix perf_proc_update_handler() bug
      perf tools: Handle TOPOLOGY headers with no CPU

Stephen Boyd (1):
      Merge tag 'sunxi-clk-fixes-for-5.0' of https://git.kernel.org/.../sun=
xi/linux into clk-fixes

Steve French (1):
      cifs: update internal module version number

Steve Longerbeam (1):
      gpu: ipu-v3: Fix CSI offsets for imx53

Stuart Henderson (2):
      ASoC: wm_adsp: Update cached error state on trigger
      ASoC: wm_adsp: Add support for multiple compressed buffers

Su Yanjun (1):
      vti4: Fix a ipip packet processing bug in 'IPCOMP' virtual tunnel

Sudarsana Reddy Kalluru (3):
      qed: Assign UFP TC value to vlan priority in UFP mode.
      qed: Consider TX tcs while deriving the max num_queues for PF.
      qede: Fix system crash on configuring channels.

Sudeep Holla (2):
      ARM: dts: imx: replace gpio-key,wakeup with wakeup-source property
      firmware: arm_scmi: provide the mandatory device release callback

Suravee Suthikulpanit (1):
      iommu/amd: Fix IOMMU page flush when detach device from a domain

Suzuki K Poulose (1):
      KVM: arm64: Relax the restriction on using stage2 PUD huge mapping

Sven Eckelmann (2):
      batman-adv: Avoid WARN on net_device without parent in netns
      batman-adv: Force mac header to start of data on xmit

Sylwester Nawrocki (31):
      ASoC: doc: Fix typos in dpcm.rst
      ASoC: samsung: i2s: Fix prescaler setting for the secondary DAI
      ASoC: dmaengine: Improve of_node test in dmaengine_pcm_request_chan_o=
f()
      ASoC: dmaengine: Extend use of chan_names provided in custom DMA conf=
ig
      ASoC: samsung: dmaengine: Allow to specify custom DMA device
      ASoC: samsung: i2s: Convert to single component with multiple DAIs
      ASoC: samsung: i2s: Restore support for the secondary PCM
      ASoC: samsung: i2s: Move clk supplier data to common driver data stru=
cture
      ASoC: samsung: i2s: Add widgets and routes for DPCM support
      ASoC: samsung: i2s: Move core clk to the driver common data structure
      ASoC: samsung: i2s: Move opclk data to common driver data structure
      ASoC: samsung: i2s: Move registers cache to common driver data struct=
ure
      ASoC: samsung: i2s: Move SFR pointer to common driver data structure
      ASoC: samsung: i2s: Drop spinlock pointer from i2s_dai data structure
      ASoC: samsung: i2s: Move IP variant data to common driver data struct=
ure
      ASoC: samsung: i2s: Move quirks data to common driver data structure
      ASoC: samsung: i2s: Get rid of a static spinlock
      ASoC: samsung: odroid: Add support for secondary CPU DAI
      ASoC: samsung: Specify DMA channel names through custom DMA config
      ASoC: samsung: i2s: Simplify pri_dai, sec_dai pointers usage
      ASoC: samsung: i2s: Change indentation in SAMSUNG_I2S_FMTS definition
      ASoC: samsung: i2s: Comments clean up
      ASoC: samsung: i2s: Convert to SPDX License Indentifier
      ASoC: dmaengine: Remove unused SND_DMAENGINE_PCM_FLAG_CUSTOM_CHANNEL_=
NAME flag
      ASoC: samsung: i2s: Prevent potential NULL platform data dereference
      ASoC: samsung: odroid: Ensure proper sample rate on pri/sec PCM
      ASoC: samsung: odroid: Add missing DAPM routes
      ASoC: samsung: i2s: Fix secondary platform device unregistration
      ASoC: samsung: i2s: Fix multiple "IIS multi" devices initialization
      ASoC: samsung: odroid: Fix of_node refcount unbalance
      ASoC: samsung: odroid: Prevent uninitialized variable use

Takashi Iwai (6):
      Merge tag 'asoc-fix-v5.0-rc6' of git://git.kernel.org/.../broonie/sou=
nd into for-linus
      ASoC: fsl: Fix of-node refcount unbalance in fsl_ssi_probe_from_dt()
      ASoC: simple-card: Fix missing of_node_put() at simple_dai_link_of()
      ASoC: simple-card: Fix of-node refcount unbalance in DAI-link parser
      ASoC: qcom: Fix of-node refcount unbalance in apq8016_sbc_parse_of()
      ASoC: qcom: Fix of-node refcount unbalance in qcom_snd_parse_of()

Taniya Das (1):
      clk: qcom: gcc: Use active only source for CPUSS clocks

Tariq Toukan (1):
      net/mlx5: Fix a compilation warning in events.c

Tejas Joglekar (1):
      usb: dwc3: gadget: Handle 0 xfer length for OUT EP

Tetsuo Handa (3):
      block: pass no-op callback to INIT_WORK().
      oom, oom_reaper: do not enqueue same task twice
      fs: ratelimit __find_get_block_slow() failure message.

Thadeu Lima de Souza Cascardo (1):
      selftests: fib_tests: sleep after changing carrier. again.

Theodore Ts'o (1):
      Revert "ext4: use ext4_write_inode() when fsyncing w/o a journal"

Thierry Reding (2):
      mailbox: Export mbox_flush()
      ARM: tegra: Restore DT ABI on Tegra124 Chromebooks

Thinh Nguyen (1):
      PCI: Work around Synopsys duplicate Device ID (HAPS USB3, NXP i.MX)

Thomas Gleixner (2):
      Merge tag 'irqchip-5.0-3' of git://git.kernel.org/.../maz/arm-platfor=
ms into irq/urgent
      futex: Handle early deadlock return correctly

Thomas Hellstrom (4):
      drm/vmwgfx: Return error code from vmw_execbuf_copy_fence_user
      drm/vmwgfx: Fix an uninitialized fence handle value
      drm/vmwgfx: Fix setting of dma masks
      drm/vmwgfx: Improve on IOMMU detection

Thomas Lendacky (1):
      x86/microcode/amd: Don't falsely trick the late loading mechanism

Thomas Petazzoni (1):
      ARM: dts: armada-xp: fix Armada XP boards NAND description

Tina Zhang (1):
      drm/modes: Prevent division by zero htotal

Tiwei Bie (1):
      virtio: support VIRTIO_F_ORDER_PLATFORM

Tobias Brunner (1):
      xfrm: Fix inbound traffic via XFRM interfaces across network namespac=
es

Toke H=C3=B8iland-J=C3=B8rgensen (1):
      mac80211: Change default tx_sk_pacing_shift to 7

Tomas Winkler (2):
      mei: me: add ice lake point device id.
      samples: mei: use /dev/mei0 instead of /dev/mei

Tomi Valkeinen (3):
      drm/omap: dsi: Fix crash in DSI debug dumps
      drm/omap: dsi: Fix OF platform depopulate
      drm/omap: dsi: Hack-fix DSI bus flags

Tomonori Sakita (1):
      net: altera_tse: fix msgdma_tx_completion on non-zero fill_level case

Tonghao Zhang (2):
      net/mlx5e: Update hw flows when encap source mac changed
      net/mlx5e: Don't overwrite pedit action when multiple pedit used

Tony Jones (2):
      perf script: Fix crash when processing recorded stat data
      perf script python: Add Python3 support to tests/attr.py

Tony Lindgren (10):
      ARM: dts: omap4-droid4: Fix typo in cpcap IRQ flags
      ARM: dts: Remove unnecessary idle flags for omap5 uart3
      clocksource: timer-ti-dm: Fix pwm dmtimer usage of fck reparenting
      ARM: dts: omap3-gta04: Fix graph_port warning
      ARM: OMAP5+: Fix inverted nirq pin interrupts with irq_set_type
      bus: ti-sysc: Fix timer handling with drop pm_runtime_irq_safe()
      ARM: dts: Configure clock parent for pwm vibra
      Merge branch 'pwm-dmtimer-fixes' into omap-for-v5.0/fixes-v2
      i2c: omap: Use noirq system sleep pm ops to idle device for suspend
      Merge branch 'am335x-phy-fixes' into omap-for-v5.0/fixes-v2

Tony Luck (1):
      x86/MCE: Initialize mce.bank in the case of a fatal error in mce_no_w=
ay_out()

Toshiaki Makita (8):
      virtio_net: Don't enable NAPI when interface is down
      virtio_net: Don't call free_old_xmit_skbs for xdp_frames
      virtio_net: Fix not restoring real_num_rx_queues
      virtio_net: Fix out of bounds access of sq
      virtio_net: Don't process redirected XDP frames when XDP is disabled
      virtio_net: Use xdp_return_frame to free xdp_frames on destroying vqs
      virtio_net: Differentiate sk_buff and xdp_frame on freeing
      virtio_net: Account for tx bytes and packets on sending xdp_frames

Trond Myklebust (2):
      NFS: Fix up return value on fatal errors in nfs_page_async_flush()
      nfsd: Fix error return values for nfsd4_clone_file_range()

Tung Nguyen (2):
      tipc: improve function tipc_wait_for_cond()
      tipc: improve function tipc_wait_for_rcvmsg()

Tuong Lien (1):
      tipc: fix link session and re-establish issues

Tvrtko Ursulin (1):
      drm/i915/pmu: Fix enable count array size and bounds checking

Ulf Hansson (1):
      wlcore: sdio: Fixup power on/off sequence

Ursula Braun (7):
      net/smc: fix another sizeof to int comparison
      net/smc: preallocated memory for rdma work requests
      net/smc: fix sender_free computation
      net/smc: delete rkey first before switching to unused
      net/smc: correct state change for peer closing
      net/smc: fix byte_order for rx_curs_confirmed
      net/smc: fix smc_poll in SMC_INIT state

Vadim Lomovtsev (8):
      net: thunderx: correct typo in macro name
      net: thunderx: replace global nicvf_rx_mode_wq work queue for all VFs=
 to private for each of them.
      net: thunderx: make CFG_DONE message to run through generic send-ack =
sequence
      net: thunderx: add nicvf_send_msg_to_pf result check for set_rx_mode_=
task
      net: thunderx: rework xcast message structure to make it fit into 64 =
bit
      net: thunderx: add mutex to protect mailbox from concurrent calls for=
 same VF
      net: thunderx: move link state polling function to VF
      net: thunderx: remove link change polling code and info from nicpf

Vaibhav Jain (1):
      scsi: cxlflash: Prevent deadlock when adapter probe fails

Ville Syrj=C3=A4l=C3=A4 (2):
      drm/i915: Fix skl srckey mask bits
      drm/i915: Try to sanitize bogus DPLL state left over by broken SNB BI=
OSen

Vincent Chen (1):
      RISC-V: Add _TIF_NEED_RESCHED check for kernel thread when CONFIG_PRE=
EMPT=3Dy

Vincent Guittot (2):
      PM-runtime: Fix deadlock with ktime_get()
      PM-runtime: Fix deadlock when canceling hrtimer

Vincent Whitchurch (3):
      mic: vop: Fix broken virtqueues
      mic: vop: Fix use-after-free on remove
      mic: vop: Fix crash on remove

Vineet Gupta (3):
      ARC: uacces: remove lp_start, lp_end from clobber list
      ARCv2: support manual regfile save on interrupts
      ARCv2: don't assume core 0x54 has dual issue

Vinod Koul (1):
      Merge branch 'fix/brcm' into fixes

Viorel Suman (2):
      ASoC: fsl_spdif: fix TXCLK_DF mask
      ASoC: fsl_spdif: fix sysclk_df type

Vitaly Kuznetsov (2):
      x86/kvm/nVMX: read from MSR_IA32_VMX_PROCBASED_CTLS2 only when it is =
available
      x86/kvm/mmu: fix switch between root and guest MMUs

Vivien Didelot (1):
      net: ethernet: freescale: set FEC ethtool regs version

Vladimir Kondratiev (1):
      mips: cm: reprime error cause

Vladimir Murzin (1):
      arm64: Relax GIC version check during early boot

Vladis Dronov (1):
      HID: debug: fix the ring buffer implementation

Waiman Long (4):
      fs/dcache: Fix incorrect nr_dentry_unused accounting in shrink_dcache=
_sb()
      fs: Don't need to put list_lru into its own cacheline
      fs/dcache: Track & report number of negative dentries
      Documentation: Fix grammatical error in sysctl/fs.txt & clarify negat=
ive dentry

Wei Huang (1):
      x86/boot/compressed/64: Set EFER.LME=3D1 in 32-bit trampoline before =
returning to long mode

Wei Yongjun (5):
      ASoC: mediatek: mt8183: make some functions static
      ASoC: cros_ec_codec: Make symbol 'cros_ec_dai' static
      ASoC: cs35l36: Make some symbols static
      mac80211: mesh: fix missing unlock on error in table_path_del()
      ASoC: wm8741: Make function 'wm8741_mute' static

Wen Yang (2):
      ASoC: stm32: sai: add missing put_device()
      SoC: imx-sgtl5000: add missing put_device()

Will Deacon (1):
      arm64: ptdump: Don't iterate kernel page tables using PTRS_PER_PXX

Willem de Bruijn (3):
      bpf: only adjust gso_size on bytestream protocols
      net: validate untrusted gso packets without csum offload
      net: avoid false positives in untrusted gso validation

Xiaoyao Li (1):
      kvm: vmx: Fix entry number check for add_atomic_switch_msr()

Xin Long (3):
      sctp: check and update stream->out_curr when allocating stream_out
      sctp: call gso_reset_checksum when computing checksum in sctp_gso_seg=
ment
      sctp: set stream ext to NULL after freeing it in sctp_stream_outq_mig=
rate

Yafang Shao (1):
      bpf: sock recvbuff must be limited by rmem_max in bpf_setsockopt()

Yan, Zheng (1):
      ceph: avoid repeatedly adding inode to mdsc->snap_flush_list

Yang Wei (18):
      net: i825xx: replace dev_kfree_skb_irq by dev_consume_skb_irq for dro=
p profiles
      net: alteon: replace dev_kfree_skb_irq by dev_consume_skb_irq
      net: amd8111e: replace dev_kfree_skb_irq by dev_consume_skb_irq
      net: apple: replace dev_kfree_skb_irq by dev_consume_skb_irq for drop=
 profiles
      net: ti: replace dev_kfree_skb_irq by dev_consume_skb_irq for drop pr=
ofiles
      net: 8139cp: replace dev_kfree_skb_irq by dev_consume_skb_irq for dro=
p profiles
      net: caif: call dev_consume_skb_any when skb xmit done
      net: b44: replace dev_kfree_skb_xxx by dev_consume_skb_xxx for drop p=
rofiles
      net: defxx: replace dev_kfree_skb_irq by dev_consume_skb_irq for drop=
 profiles
      net: tulip: de2104x: replace dev_kfree_skb_irq by dev_consume_skb_irq=
 for drop profiles
      net: dscc4: replace dev_kfree_skb_irq by dev_consume_skb_irq for drop=
 profiles
      net: smsc: epic100: replace dev_kfree_skb_irq by dev_consume_skb_irq =
for drop profiles
      net: fec_mpc52xx: replace dev_kfree_skb_irq by dev_consume_skb_irq fo=
r drop profiles
      net: fsl_ucc_hdlc: replace dev_kfree_skb_irq by dev_consume_skb_irq f=
or drop profiles
      net: sun: replace dev_kfree_skb_irq by dev_consume_skb_irq for drop p=
rofiles
      net: tehuti: replace dev_kfree_skb_irq by dev_consume_skb_irq for dro=
p profiles
      net: via-velocity: replace dev_kfree_skb_irq by dev_consume_skb_irq f=
or drop profiles
      net: broadcom: replace dev_kfree_skb_irq by dev_consume_skb_irq for d=
rop profiles

Yangtao Li (1):
      cpufreq: scmi: Fix use-after-free in scmi_cpufreq_exit()

Yao Liu (1):
      nfs: Fix NULL pointer dereference of dev_name

Yifeng Li (1):
      mips: loongson64: remove unreachable(), fix loongson_poweroff().

Yishai Hadas (3):
      IB/uverbs: Fix OOPs upon device disassociation
      IB/uverbs: Fix ioctl query port to consider device disassociation
      IB/uverbs: Fix OOPs in uverbs_user_mmap_disassociate

Yizhuo (1):
      ARM: OMAP2+: Variable "reg" in function omap4_dsi_mux_pads() could be=
 uninitialized

Yohei Kanemaru (1):
      ipv6: sr: clear IP6CB(skb) on SRH ip4ip6 encapsulation

Yong Zhi (3):
      ASoC: Intel: Headset button support in broxton machine driver
      ASoC: Intel: Add Geminilake Dialog Maxim machine driver
      ASoC: Intel: glk: Add DAI links for Multi-Playback

Yonghong Song (2):
      bpf: btf: allow typedef func_proto
      tools/bpf: fix test_btf for typedef func_proto case

Yonglong Liu (3):
      net: hns: Fix for missing of_node_put() after of_parse_phandle()
      net: hns: Restart autoneg need return failed when autoneg off
      net: hns: Fix wrong read accesses via Clause 45 MDIO protocol

Yu Zhang (2):
      kvm: x86: Return LA57 feature based on hardware capability
      KVM: MMU: record maximum physical address width in kvm_mmu_extended_r=
ole

Yu Zhao (1):
      mm/gup: fix gup_pmd_range() for dax

YueHaibing (3):
      ASoC: cs35l36: Remove unused including <linux/version.h>
      ASoC: stm32: sai: remove set but not used variables 'mask, cr1'
      mdio_bus: Fix use-after-free on device_register fails

Yufen Yu (1):
      floppy: check_events callback should not return a negative number

Zachary Hays (1):
      mmc: block: handle complete_work on separate workqueue

Zenghui Yu (1):
      irqchip/gic-v3-its: Fix ITT_entry_size accessor

ZhangXiaoxu (1):
      ipvs: Fix signed integer overflow when setsockopt timeout

Zhenzhong Duan (1):
      x86/speculation: Remove redundant arch_smt_update() invocation

Zhiqiang Liu (1):
      net: fix IPv6 prefix route residue

Zhou Yanjie (1):
      DTS: CI20: Fix bugs in ci20's device tree.

shaoyunl (1):
      drm/amdgpu: Update sdma golden setting for vega20

 .clang-format                                      |   43 +-
 CREDITS                                            |   20 +-
 Documentation/ABI/stable/sysfs-driver-mlxreg-io    |    6 +-
 Documentation/ABI/testing/sysfs-block              |    9 +
 Documentation/ABI/testing/sysfs-block-zram         |   11 +-
 Documentation/admin-guide/README.rst               |   32 +-
 Documentation/admin-guide/kernel-parameters.txt    |    7 +-
 Documentation/block/bfq-iosched.txt                |    7 +
 Documentation/block/null_blk.txt                   |    3 +-
 Documentation/block/queue-sysfs.txt                |    7 +
 Documentation/blockdev/zram.txt                    |   74 +-
 Documentation/bpf/bpf_design_QA.rst                |   11 +-
 Documentation/core-api/xarray.rst                  |   15 +-
 Documentation/devicetree/bindings/Makefile         |    6 +-
 .../devicetree/bindings/arm/cpu-capacity.txt       |    2 +-
 .../devicetree/bindings/arm/idle-states.txt        |    2 +-
 Documentation/devicetree/bindings/arm/sp810.txt    |    2 +-
 Documentation/devicetree/bindings/arm/topology.txt |    2 +-
 .../devicetree/bindings/clock/marvell,mmp2.txt     |    2 +-
 .../devicetree/bindings/display/arm,pl11x.txt      |    2 +-
 .../devicetree/bindings/display/msm/gpu.txt        |    1 -
 .../devicetree/bindings/gpio/gpio-mvebu.txt        |    2 -
 .../bindings/interrupt-controller/arm,gic-v3.txt   |    2 +-
 .../devicetree/bindings/reset/socfpga-reset.txt    |    3 +-
 .../devicetree/bindings/reset/uniphier-reset.txt   |   25 +-
 .../devicetree/bindings/serio/olpc,ap-sp.txt       |    4 -
 .../devicetree/bindings/soc/qcom/qcom,glink.txt    |    2 +-
 .../devicetree/bindings/soc/qcom/qcom,smp2p.txt    |    4 +-
 .../devicetree/bindings/sound/adi,adau1977.txt     |   13 +-
 Documentation/devicetree/bindings/sound/ak4458.txt |    2 +-
 .../bindings/sound/audio-graph-scu-card.txt        |  123 -
 .../devicetree/bindings/sound/cs35l36.txt          |  168 +
 Documentation/devicetree/bindings/sound/cs4341.txt |   22 +
 .../bindings/sound/davinci-mcasp-audio.txt         |   17 +
 .../devicetree/bindings/sound/fsl,micfil.txt       |   32 +
 .../bindings/sound/google,cros-ec-codec.txt        |   26 +
 .../bindings/sound/ingenic,jz4725b-codec.txt       |   20 +
 .../bindings/sound/ingenic,jz4740-codec.txt        |   20 +
 Documentation/devicetree/bindings/sound/mt6358.txt |   18 +
 .../devicetree/bindings/sound/mt8183-afe-pcm.txt   |   36 +
 .../devicetree/bindings/sound/mtk-btcvsd-snd.txt   |   24 +
 .../bindings/sound/qcom,msm8916-wcd-analog.txt     |    7 +-
 .../devicetree/bindings/sound/qcom,wcd9335.txt     |   10 +-
 .../bindings/sound/rockchip,rk3328-codec.txt       |   23 +
 .../devicetree/bindings/sound/sgtl5000.txt         |    9 +
 .../devicetree/bindings/sound/simple-scu-card.txt  |   94 -
 .../devicetree/bindings/sound/sprd-pcm.txt         |   23 +
 .../bindings/sound/xlnx,audio-formatter.txt        |   29 +
 .../devicetree/bindings/sound/xlnx,spdif.txt       |   28 +
 Documentation/driver-model/bus.txt                 |    8 +-
 Documentation/fb/fbcon.txt                         |    8 +
 .../features/core/cBPF-JIT/arch-support.txt        |    1 +
 .../features/core/eBPF-JIT/arch-support.txt        |    1 +
 .../core/generic-idle-thread/arch-support.txt      |    1 +
 .../features/core/jump-labels/arch-support.txt     |    1 +
 .../features/core/tracehook/arch-support.txt       |    1 +
 .../features/debug/KASAN/arch-support.txt          |    1 +
 .../debug/gcov-profile-all/arch-support.txt        |    1 +
 Documentation/features/debug/kgdb/arch-support.txt |    1 +
 .../debug/kprobes-on-ftrace/arch-support.txt       |    1 +
 .../features/debug/kprobes/arch-support.txt        |    1 +
 .../features/debug/kretprobes/arch-support.txt     |    1 +
 .../features/debug/optprobes/arch-support.txt      |    1 +
 .../features/debug/stackprotector/arch-support.txt |    1 +
 .../features/debug/uprobes/arch-support.txt        |    1 +
 .../debug/user-ret-profiler/arch-support.txt       |    1 +
 .../features/io/dma-contiguous/arch-support.txt    |    1 +
 .../locking/cmpxchg-local/arch-support.txt         |    1 +
 .../features/locking/lockdep/arch-support.txt      |    1 +
 .../locking/queued-rwlocks/arch-support.txt        |    1 +
 .../locking/queued-spinlocks/arch-support.txt      |    1 +
 .../locking/rwsem-optimized/arch-support.txt       |    1 +
 .../features/perf/kprobes-event/arch-support.txt   |    1 +
 .../features/perf/perf-regs/arch-support.txt       |    1 +
 .../features/perf/perf-stackdump/arch-support.txt  |    1 +
 .../sched/membarrier-sync-core/arch-support.txt    |    1 +
 .../features/sched/numa-balancing/arch-support.txt |    1 +
 .../seccomp/seccomp-filter/arch-support.txt        |    1 +
 .../time/arch-tick-broadcast/arch-support.txt      |    1 +
 .../features/time/clockevents/arch-support.txt     |    1 +
 .../time/context-tracking/arch-support.txt         |    1 +
 .../features/time/irq-time-acct/arch-support.txt   |    1 +
 .../time/modern-timekeeping/arch-support.txt       |    1 +
 .../features/time/virt-cpuacct/arch-support.txt    |    1 +
 .../features/vm/ELF-ASLR/arch-support.txt          |    1 +
 .../features/vm/PG_uncached/arch-support.txt       |    1 +
 Documentation/features/vm/THP/arch-support.txt     |    1 +
 Documentation/features/vm/TLB/arch-support.txt     |    1 +
 .../features/vm/huge-vmap/arch-support.txt         |    1 +
 .../features/vm/ioremap_prot/arch-support.txt      |    1 +
 .../features/vm/numa-memblock/arch-support.txt     |    1 +
 .../features/vm/pte_special/arch-support.txt       |    1 +
 Documentation/filesystems/sysfs.txt                |    4 +-
 Documentation/networking/dsa/dsa.txt               |   10 +-
 Documentation/networking/index.rst                 |   26 +-
 Documentation/networking/msg_zerocopy.rst          |    2 +-
 Documentation/networking/operstates.txt            |   14 +-
 Documentation/networking/rxrpc.txt                 |   45 -
 Documentation/networking/snmp_counter.rst          |  130 +-
 Documentation/networking/switchdev.txt             |   10 +-
 Documentation/networking/timestamping.txt          |    4 +-
 Documentation/process/applying-patches.rst         |  117 +-
 Documentation/sound/soc/dpcm.rst                   |   10 +-
 Documentation/sysctl/fs.txt                        |   28 +-
 Documentation/trace/coresight-cpu-debug.txt        |    2 +-
 .../translations/it_IT/admin-guide/README.rst      |    2 +-
 .../virtual/kvm/amd-memory-encryption.rst          |    2 +-
 Documentation/x86/resctrl_ui.txt                   |    2 +-
 MAINTAINERS                                        |  150 +-
 Makefile                                           |   10 +-
 arch/alpha/include/asm/irq.h                       |    6 +-
 arch/alpha/mm/fault.c                              |    2 +-
 arch/arc/Kconfig                                   |   20 +-
 arch/arc/configs/nps_defconfig                     |    1 -
 arch/arc/configs/vdk_hs38_defconfig                |    1 -
 arch/arc/configs/vdk_hs38_smp_defconfig            |    2 -
 arch/arc/include/asm/Kbuild                        |    4 -
 arch/arc/include/asm/arcregs.h                     |   20 +-
 arch/arc/include/asm/bitops.h                      |    6 +-
 arch/arc/include/asm/cache.h                       |   11 +
 arch/arc/include/asm/entry-arcv2.h                 |   54 +
 arch/arc/include/asm/perf_event.h                  |    3 +-
 arch/arc/include/asm/uaccess.h                     |    8 +-
 arch/arc/kernel/entry-arcv2.S                      |    4 +-
 arch/arc/kernel/head.S                             |   16 +-
 arch/arc/kernel/intc-arcv2.c                       |    2 +
 arch/arc/kernel/perf_event.c                       |  241 +-
 arch/arc/kernel/setup.c                            |  144 +-
 arch/arc/kernel/troubleshoot.c                     |   30 +-
 arch/arc/lib/memcpy-archs.S                        |   14 -
 arch/arc/lib/memset-archs.S                        |   40 +-
 arch/arc/mm/fault.c                                |   13 +-
 arch/arc/mm/init.c                                 |    3 +-
 arch/arc/plat-hsdk/Kconfig                         |    1 +
 arch/arm/Kconfig                                   |    1 +
 arch/arm/boot/dts/am335x-evm.dts                   |    2 +-
 arch/arm/boot/dts/am335x-evmsk.dts                 |    4 +-
 arch/arm/boot/dts/am335x-shc.dts                   |    2 +-
 arch/arm/boot/dts/armada-xp-db.dts                 |   46 +-
 arch/arm/boot/dts/armada-xp-gp.dts                 |   13 +-
 arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts    |   85 +-
 arch/arm/boot/dts/da850-evm.dts                    |   31 +-
 arch/arm/boot/dts/da850-lcdk.dts                   |   38 +-
 arch/arm/boot/dts/da850.dtsi                       |    2 +-
 arch/arm/boot/dts/imx6q-pistachio.dts              |    2 +-
 arch/arm/boot/dts/imx6sll-evk.dts                  |    2 +-
 arch/arm/boot/dts/imx6sx.dtsi                      |    2 +-
 arch/arm/boot/dts/kirkwood-dnskw.dtsi              |    4 +-
 arch/arm/boot/dts/meson.dtsi                       |    2 +-
 arch/arm/boot/dts/meson8b-ec100.dts                |    3 +-
 arch/arm/boot/dts/meson8b-odroidc1.dts             |    4 +-
 arch/arm/boot/dts/meson8m2-mxiii-plus.dts          |    3 +-
 arch/arm/boot/dts/motorola-cpcap-mapphone.dtsi     |    2 +-
 arch/arm/boot/dts/omap3-gta04.dtsi                 |    4 -
 arch/arm/boot/dts/omap3-n900.dts                   |    2 +-
 arch/arm/boot/dts/omap3-n950-n9.dtsi               |   42 +-
 arch/arm/boot/dts/omap4-droid4-xt894.dts           |   11 +
 arch/arm/boot/dts/omap5-board-common.dtsi          |    9 +-
 arch/arm/boot/dts/omap5-cm-t54.dts                 |   12 +-
 arch/arm/boot/dts/omap5-l4.dtsi                    |    2 -
 arch/arm/boot/dts/r8a7743.dtsi                     |   36 +-
 arch/arm/boot/dts/rk3188.dtsi                      |    1 -
 arch/arm/boot/dts/sun6i-a31.dtsi                   |    1 +
 arch/arm/boot/dts/sun8i-h3-beelink-x2.dts          |    2 +-
 arch/arm/boot/dts/tegra124-nyan.dtsi               |   17 +-
 arch/arm/boot/dts/vf610-bk4.dts                    |    4 +-
 arch/arm/include/asm/irq.h                         |    1 -
 arch/arm/include/asm/kvm_host.h                    |   10 +
 arch/arm/include/asm/stage2_pgtable.h              |    5 +
 arch/arm/include/asm/xen/page-coherent.h           |   94 +
 arch/arm/kernel/irq.c                              |   62 -
 arch/arm/kernel/smp.c                              |    2 +-
 arch/arm/kvm/coproc.c                              |    4 +-
 arch/arm/kvm/reset.c                               |   24 +
 arch/arm/mach-cns3xxx/pcie.c                       |    4 +-
 arch/arm/mach-davinci/board-da830-evm.c            |    4 +-
 arch/arm/mach-davinci/board-da850-evm.c            |    4 +-
 arch/arm/mach-davinci/board-dm355-evm.c            |    4 +-
 arch/arm/mach-davinci/board-dm644x-evm.c           |    4 +-
 arch/arm/mach-davinci/board-omapl138-hawk.c        |    4 +-
 arch/arm/mach-integrator/impd1.c                   |    8 +-
 arch/arm/mach-iop32x/n2100.c                       |    3 +-
 arch/arm/mach-omap2/cpuidle44xx.c                  |   16 +-
 arch/arm/mach-omap2/display.c                      |    7 +-
 arch/arm/mach-omap2/omap-wakeupgen.c               |   36 +-
 arch/arm/mach-socfpga/socfpga.c                    |    4 +
 arch/arm/mach-tango/pm.c                           |    6 +-
 arch/arm/mach-tango/pm.h                           |    7 +
 arch/arm/mach-tango/setup.c                        |    2 +
 arch/arm/mm/dma-mapping.c                          |    2 +
 arch/arm/plat-pxa/ssp.c                            |    3 -
 arch/arm/probes/kprobes/opt-arm.c                  |    2 +-
 arch/arm/xen/mm.c                                  |    1 -
 .../boot/dts/allwinner/sun50i-a64-orangepi-win.dts |    1 +
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi      |    2 +-
 .../arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi |    3 +-
 .../boot/dts/amlogic/meson-gxbb-nanopi-k2.dts      |    3 +-
 .../boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts    |    3 +-
 .../arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts |    3 +-
 arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi   |    3 +-
 .../boot/dts/amlogic/meson-gxbb-vega-s95.dtsi      |    3 +-
 arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi  |    3 +-
 .../dts/amlogic/meson-gxl-s905x-hwacom-amazetv.dts |    3 +-
 .../dts/amlogic/meson-gxl-s905x-libretech-cc.dts   |    3 +-
 .../dts/amlogic/meson-gxl-s905x-nexbox-a95x.dts    |    3 +-
 .../boot/dts/amlogic/meson-gxl-s905x-p212.dtsi     |    3 +-
 .../boot/dts/amlogic/meson-gxm-khadas-vim2.dts     |    3 +-
 .../arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts |    3 +-
 arch/arm64/boot/dts/amlogic/meson-gxm-rbox-pro.dts |    3 +-
 arch/arm64/boot/dts/freescale/imx8mq-evk.dts       |   44 +-
 arch/arm64/boot/dts/freescale/imx8mq.dtsi          |    2 +
 .../dts/marvell/armada-8040-clearfog-gt-8k.dts     |    2 +-
 arch/arm64/boot/dts/marvell/armada-8040-mcbin.dtsi |    2 +-
 arch/arm64/boot/dts/marvell/armada-ap806.dtsi      |   17 +
 arch/arm64/boot/dts/qcom/msm8996.dtsi              |    2 +-
 arch/arm64/boot/dts/renesas/r8a774a1.dtsi          |    3 +
 arch/arm64/boot/dts/renesas/r8a7796.dtsi           |    3 +
 arch/arm64/boot/dts/renesas/r8a77965.dtsi          |    3 +
 arch/arm64/boot/dts/rockchip/rk3328-rock64.dts     |    2 +
 arch/arm64/boot/dts/rockchip/rk3399-gru-bob.dts    |    2 +-
 arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts  |    2 +-
 .../dts/rockchip/rk3399-sapphire-excavator.dts     |    2 +-
 arch/arm64/configs/defconfig                       |    4 +
 arch/arm64/include/asm/asm-prototypes.h            |    2 +-
 arch/arm64/include/asm/cache.h                     |    4 +
 arch/arm64/include/asm/device.h                    |    3 -
 arch/arm64/include/asm/kvm_host.h                  |   11 +
 arch/arm64/include/asm/memory.h                    |   11 +
 arch/arm64/include/asm/mmu.h                       |   44 +
 arch/arm64/include/asm/neon-intrinsics.h           |    4 +
 arch/arm64/include/asm/pgtable-prot.h              |    4 +-
 arch/arm64/include/asm/xen/page-coherent.h         |   76 +
 arch/arm64/kernel/cpu_errata.c                     |    2 +-
 arch/arm64/kernel/cpufeature.c                     |    9 +-
 arch/arm64/kernel/head.S                           |    4 +-
 arch/arm64/kernel/hibernate.c                      |    4 +-
 arch/arm64/kernel/hyp-stub.S                       |    2 +
 arch/arm64/kernel/kaslr.c                          |    9 +-
 arch/arm64/kernel/machine_kexec_file.c             |    8 +-
 arch/arm64/kernel/probes/kprobes.c                 |    6 +-
 arch/arm64/kernel/ptrace.c                         |   15 +-
 arch/arm64/kernel/setup.c                          |    4 +-
 arch/arm64/kvm/hyp/switch.c                        |    5 +
 arch/arm64/kvm/hyp/sysreg-sr.c                     |    5 +
 arch/arm64/kvm/reset.c                             |   50 +-
 arch/arm64/kvm/sys_regs.c                          |   50 +-
 arch/arm64/mm/dma-mapping.c                        |    4 +-
 arch/arm64/mm/dump.c                               |   59 +-
 arch/arm64/mm/flush.c                              |    6 +-
 arch/arm64/mm/kasan_init.c                         |    2 -
 arch/c6x/include/asm/Kbuild                        |    1 +
 arch/csky/include/asm/io.h                         |   25 +
 arch/csky/include/asm/pgalloc.h                    |   43 +-
 arch/csky/include/asm/pgtable.h                    |    9 +-
 arch/csky/include/asm/processor.h                  |    4 +-
 arch/csky/kernel/dumpstack.c                       |    4 +
 arch/csky/kernel/module.c                          |   38 +-
 arch/csky/kernel/ptrace.c                          |    3 +-
 arch/csky/kernel/smp.c                             |    3 +-
 arch/csky/mm/ioremap.c                             |   14 +
 arch/h8300/Makefile                                |    2 -
 arch/h8300/include/asm/Kbuild                      |    1 +
 arch/hexagon/include/asm/Kbuild                    |    1 +
 arch/ia64/Makefile                                 |    2 -
 arch/m68k/emu/nfblock.c                            |   10 +-
 arch/m68k/include/asm/Kbuild                       |    1 +
 arch/microblaze/include/asm/Kbuild                 |    1 +
 arch/mips/Kconfig                                  |   16 +
 arch/mips/bcm47xx/setup.c                          |   31 +
 arch/mips/boot/dts/ingenic/ci20.dts                |    8 +-
 arch/mips/boot/dts/ingenic/jz4740.dtsi             |    2 +-
 arch/mips/boot/dts/xilfpga/nexys4ddr.dts           |    8 +-
 arch/mips/cavium-octeon/setup.c                    |    2 +-
 arch/mips/configs/ath79_defconfig                  |    1 +
 arch/mips/include/asm/atomic.h                     |    6 +
 arch/mips/include/asm/barrier.h                    |   36 +
 arch/mips/include/asm/bitops.h                     |    5 +
 arch/mips/include/asm/futex.h                      |    3 +
 .../include/asm/mach-lantiq/falcon/falcon_irq.h    |    2 -
 .../mips/include/asm/mach-lantiq/xway/lantiq_irq.h |    2 -
 arch/mips/include/asm/pgtable.h                    |    2 +
 arch/mips/jazz/jazzdma.c                           |    5 +-
 arch/mips/kernel/mips-cm.c                         |    2 +-
 arch/mips/kernel/process.c                         |    7 +-
 arch/mips/lantiq/irq.c                             |   77 +-
 arch/mips/lantiq/xway/dma.c                        |    6 +-
 arch/mips/loongson64/Platform                      |   23 +
 arch/mips/loongson64/common/reset.c                |    7 +-
 arch/mips/mm/tlbex.c                               |   10 +
 arch/mips/net/ebpf_jit.c                           |   24 +-
 arch/mips/pci/msi-octeon.c                         |    4 +-
 arch/mips/pci/pci-octeon.c                         |   10 +-
 arch/mips/vdso/Makefile                            |    5 +-
 arch/nds32/Makefile                                |    8 -
 arch/openrisc/Makefile                             |    3 -
 arch/openrisc/include/asm/Kbuild                   |    1 +
 arch/openrisc/include/asm/uaccess.h                |    8 +-
 arch/parisc/kernel/ptrace.c                        |   29 +-
 arch/powerpc/include/asm/book3s/64/pgtable.h       |   26 +-
 arch/powerpc/include/uapi/asm/perf_regs.h          |    1 +
 arch/powerpc/kernel/head_8xx.S                     |    3 +-
 arch/powerpc/kernel/signal_64.c                    |    7 +-
 arch/powerpc/kernel/trace/ftrace.c                 |    7 -
 arch/powerpc/mm/pgtable-book3s64.c                 |   22 +
 arch/powerpc/perf/perf_regs.c                      |    6 +
 arch/powerpc/platforms/4xx/ocm.c                   |    6 +-
 arch/powerpc/platforms/chrp/setup.c                |    3 +-
 arch/powerpc/platforms/pasemi/dma_lib.c            |    2 +-
 arch/powerpc/platforms/powernv/npu-dma.c           |    2 +-
 arch/powerpc/platforms/powernv/pci-ioda.c          |    5 +-
 arch/powerpc/platforms/powernv/pci.c               |    2 +
 arch/powerpc/platforms/pseries/papr_scm.c          |    5 +-
 arch/powerpc/platforms/pseries/pci.c               |    2 +
 arch/powerpc/sysdev/fsl_rmu.c                      |    7 +-
 arch/riscv/Kconfig                                 |    6 +-
 arch/riscv/configs/defconfig                       |    8 +-
 arch/riscv/include/asm/module.h                    |   28 +-
 arch/riscv/include/asm/page.h                      |    2 +-
 arch/riscv/include/asm/pgtable-bits.h              |    6 +
 arch/riscv/include/asm/pgtable.h                   |    8 +-
 arch/riscv/include/asm/processor.h                 |    2 +-
 arch/riscv/include/asm/ptrace.h                    |    5 +
 arch/riscv/include/asm/syscall.h                   |   10 +
 arch/riscv/include/asm/thread_info.h               |    6 +
 arch/riscv/include/asm/unistd.h                    |    2 +
 arch/riscv/kernel/asm-offsets.c                    |    1 +
 arch/riscv/kernel/entry.S                          |   22 +-
 arch/riscv/kernel/module-sections.c                |   30 +-
 arch/riscv/kernel/ptrace.c                         |    9 +-
 arch/riscv/kernel/setup.c                          |   11 +-
 arch/riscv/kernel/smp.c                            |   43 +-
 arch/riscv/kernel/smpboot.c                        |    6 +-
 arch/riscv/mm/init.c                               |    3 +-
 arch/s390/include/asm/mmu_context.h                |    7 +-
 arch/s390/kernel/early.c                           |    4 +-
 arch/s390/kernel/setup.c                           |    2 +
 arch/s390/kernel/smp.c                             |   11 +-
 arch/s390/kernel/swsusp.S                          |    4 +-
 arch/s390/kernel/vdso.c                            |    5 +-
 arch/s390/kvm/vsie.c                               |    2 +-
 arch/s390/pci/pci.c                                |    4 +-
 arch/sh/boot/dts/Makefile                          |    2 +-
 arch/unicore32/include/asm/Kbuild                  |    1 +
 arch/x86/Kconfig                                   |   10 +-
 arch/x86/boot/compressed/head_64.S                 |   10 +
 arch/x86/boot/compressed/pgtable.h                 |    2 +-
 arch/x86/entry/entry_64_compat.S                   |    6 +-
 arch/x86/events/core.c                             |   14 +
 arch/x86/events/intel/core.c                       |   25 +-
 arch/x86/events/intel/uncore_snbep.c               |    4 +-
 arch/x86/events/perf_event.h                       |   16 +-
 arch/x86/ia32/ia32_aout.c                          |    6 +-
 arch/x86/include/asm/intel-family.h                |    5 +-
 arch/x86/include/asm/kvm_host.h                    |    2 +
 arch/x86/include/asm/mmu_context.h                 |   18 +
 arch/x86/include/asm/page_64_types.h               |    4 +
 arch/x86/include/asm/pgtable.h                     |    2 +-
 arch/x86/include/asm/resctrl_sched.h               |    4 +-
 arch/x86/include/asm/uaccess.h                     |    2 +-
 arch/x86/include/asm/uv/bios.h                     |    8 +-
 arch/x86/kernel/cpu/Makefile                       |    2 +-
 arch/x86/kernel/cpu/bugs.c                         |    4 +-
 arch/x86/kernel/cpu/mce/core.c                     |    1 +
 arch/x86/kernel/cpu/microcode/amd.c                |    2 +-
 arch/x86/kernel/cpu/resctrl/Makefile               |    4 +-
 arch/x86/kernel/crash.c                            |    1 +
 arch/x86/kernel/hpet.c                             |    4 -
 arch/x86/kernel/kexec-bzimage64.c                  |    5 +
 arch/x86/kernel/kvm.c                              |    7 +-
 arch/x86/kernel/tsc.c                              |   30 +-
 arch/x86/kvm/Makefile                              |    4 -
 arch/x86/kvm/cpuid.c                               |    4 +
 arch/x86/kvm/hyperv.c                              |    7 +-
 arch/x86/kvm/lapic.c                               |    2 +
 arch/x86/kvm/mmu.c                                 |   19 +-
 arch/x86/kvm/svm.c                                 |   34 +-
 arch/x86/kvm/trace.h                               |    2 +-
 arch/x86/kvm/vmx/evmcs.c                           |    7 +-
 arch/x86/kvm/vmx/nested.c                          |   30 +-
 arch/x86/kvm/vmx/vmx.c                             |  183 +-
 arch/x86/kvm/vmx/vmx.h                             |   10 +-
 arch/x86/kvm/x86.c                                 |   17 +-
 arch/x86/lib/iomem.c                               |   33 +-
 arch/x86/lib/kaslr.c                               |    4 +-
 arch/x86/mm/fault.c                                |    2 +-
 arch/x86/mm/mem_encrypt_identity.c                 |    4 +-
 arch/x86/mm/pageattr.c                             |   50 +-
 arch/x86/platform/uv/bios_uv.c                     |   23 +-
 arch/x86/xen/enlighten_pv.c                        |    5 +-
 arch/x86/xen/time.c                                |   12 +-
 arch/xtensa/Kconfig                                |    4 +-
 arch/xtensa/boot/dts/Makefile                      |    6 +-
 arch/xtensa/configs/audio_kc705_defconfig          |    2 +-
 arch/xtensa/configs/cadence_csp_defconfig          |    2 +-
 arch/xtensa/configs/generic_kc705_defconfig        |    2 +-
 arch/xtensa/configs/nommu_kc705_defconfig          |    2 +-
 arch/xtensa/configs/smp_lx200_defconfig            |    3 +-
 arch/xtensa/kernel/head.S                          |    5 +-
 arch/xtensa/kernel/smp.c                           |   41 +-
 arch/xtensa/kernel/time.c                          |    2 +-
 block/bfq-wf2q.c                                   |   11 +-
 block/blk-core.c                                   |   26 +-
 block/blk-flush.c                                  |    2 +-
 block/blk-iolatency.c                              |   56 +-
 block/blk-mq-debugfs-zoned.c                       |    2 -
 block/blk-mq-debugfs.c                             |    6 +-
 block/blk-mq.c                                     |   15 +-
 block/blk-mq.h                                     |    1 -
 block/blk-wbt.c                                    |    4 +-
 crypto/adiantum.c                                  |    4 +
 crypto/af_alg.c                                    |    4 +-
 crypto/authenc.c                                   |   14 +-
 crypto/authencesn.c                                |    2 +-
 crypto/sm3_generic.c                               |    2 +-
 drivers/acpi/Kconfig                               |    1 +
 drivers/acpi/Makefile                              |    3 +-
 drivers/acpi/arm64/iort.c                          |    5 +-
 drivers/acpi/bus.c                                 |   27 +-
 drivers/acpi/internal.h                            |    4 +
 drivers/acpi/nfit/core.c                           |   86 +-
 drivers/acpi/nfit/intel.c                          |    8 +-
 drivers/acpi/numa.c                                |    6 +-
 drivers/acpi/pmic/intel_pmic_xpower.c              |   41 +-
 drivers/acpi/power.c                               |   22 +
 drivers/android/binder.c                           |   37 +-
 drivers/android/binder_internal.h                  |    9 +
 drivers/android/binderfs.c                         |  296 +-
 drivers/ata/Kconfig                                |    2 +-
 drivers/ata/ahci.h                                 |    2 +
 drivers/ata/ahci_mvebu.c                           |   87 +-
 drivers/ata/libahci_platform.c                     |   13 +
 drivers/ata/libata-core.c                          |    1 +
 drivers/ata/pata_macio.c                           |    9 +-
 drivers/ata/sata_fsl.c                             |    4 +-
 drivers/ata/sata_inic162x.c                        |   22 +-
 drivers/atm/he.c                                   |   41 +-
 drivers/atm/idt77252.c                             |   16 +-
 drivers/auxdisplay/ht16k33.c                       |    2 +-
 drivers/base/cacheinfo.c                           |    6 +-
 drivers/base/power/main.c                          |    3 +
 drivers/base/power/runtime.c                       |   23 +-
 drivers/base/regmap/regmap-irq.c                   |    8 +-
 drivers/block/floppy.c                             |    2 +-
 drivers/block/loop.c                               |   35 +-
 drivers/block/nbd.c                                |    5 +-
 drivers/block/null_blk.h                           |    1 +
 drivers/block/rbd.c                                |    9 +-
 drivers/block/skd_main.c                           |    4 +-
 drivers/block/zram/zram_drv.c                      |   90 +-
 drivers/block/zram/zram_drv.h                      |    5 +-
 drivers/bus/ti-sysc.c                              |    6 +-
 drivers/char/ipmi/ipmi_msghandler.c                |  173 +-
 drivers/char/ipmi/ipmi_ssif.c                      |   25 +-
 drivers/char/mwave/mwavedd.c                       |    7 +
 drivers/clk/Kconfig                                |    1 -
 drivers/clk/at91/at91sam9x5.c                      |    5 +-
 drivers/clk/at91/sama5d2.c                         |    4 +-
 drivers/clk/at91/sama5d4.c                         |    2 +-
 drivers/clk/clk-versaclock5.c                      |    4 +-
 drivers/clk/clk.c                                  |   16 +-
 drivers/clk/imx/clk-frac-pll.c                     |    5 +-
 drivers/clk/imx/clk-imx8qxp-lpcg.c                 |    2 +
 drivers/clk/mmp/clk-of-mmp2.c                      |    4 -
 drivers/clk/qcom/Kconfig                           |    1 +
 drivers/clk/qcom/gcc-sdm845.c                      |   14 +-
 drivers/clk/socfpga/clk-pll-s10.c                  |    2 +-
 drivers/clk/socfpga/clk-s10.c                      |   20 +-
 drivers/clk/sunxi-ng/ccu-sun6i-a31.c               |    4 +-
 drivers/clk/sunxi-ng/ccu-sun8i-v3s.c               |    2 +-
 drivers/clk/tegra/clk-tegra124-dfll-fcpu.c         |    4 +-
 drivers/clk/ti/divider.c                           |   11 +-
 drivers/clk/zynqmp/clkc.c                          |    4 +-
 drivers/clocksource/timer-ti-dm.c                  |    5 +-
 drivers/cpufreq/cpufreq.c                          |   12 +-
 drivers/cpufreq/scmi-cpufreq.c                     |    8 +-
 drivers/cpufreq/scpi-cpufreq.c                     |    4 +-
 drivers/cpuidle/poll_state.c                       |    2 +-
 drivers/crypto/Kconfig                             |    1 +
 drivers/crypto/amcc/crypto4xx_core.c               |    6 +-
 drivers/crypto/bcm/cipher.c                        |   44 +-
 drivers/crypto/caam/caamalg.c                      |    2 +-
 drivers/crypto/caam/caamhash.c                     |   15 +-
 drivers/crypto/caam/desc.h                         |    1 +
 drivers/crypto/caam/error.h                        |    9 +
 drivers/crypto/cavium/cpt/cptpf_main.c             |    4 +-
 drivers/crypto/cavium/cpt/cptvf_main.c             |    7 +-
 drivers/crypto/cavium/nitrox/nitrox_lib.c          |    6 +-
 drivers/crypto/cavium/nitrox/nitrox_reqmgr.c       |   10 +-
 drivers/crypto/ccp/ccp-dev-v5.c                    |    6 +-
 drivers/crypto/ccree/cc_aead.c                     |   40 +-
 drivers/crypto/ccree/cc_driver.c                   |    7 +-
 drivers/crypto/ccree/cc_pm.c                       |   13 +-
 drivers/crypto/ccree/cc_pm.h                       |    3 +
 drivers/crypto/hisilicon/sec/sec_algs.c            |    4 +-
 drivers/crypto/hisilicon/sec/sec_drv.c             |   15 +-
 drivers/crypto/ixp4xx_crypto.c                     |    6 +-
 drivers/crypto/mediatek/mtk-platform.c             |   16 +-
 drivers/crypto/qat/qat_common/adf_admin.c          |   12 +-
 drivers/crypto/qat/qat_common/qat_algs.c           |   24 +-
 drivers/crypto/qat/qat_common/qat_asym_algs.c      |   68 +-
 drivers/crypto/talitos.c                           |   26 +-
 drivers/dma/at_xdmac.c                             |   19 +-
 drivers/dma/bcm2835-dma.c                          |   70 +-
 drivers/dma/dmatest.c                              |   32 +-
 drivers/dma/imx-dma.c                              |    8 +-
 drivers/dma/imx-sdma.c                             |    8 +-
 drivers/dma/mediatek/mtk-hsdma.c                   |    4 +-
 drivers/dma/mxs-dma.c                              |    6 +-
 drivers/dma/xgene-dma.c                            |    4 +-
 drivers/dma/xilinx/xilinx_dma.c                    |   14 +-
 drivers/dma/xilinx/zynqmp_dma.c                    |    6 +-
 drivers/edac/altera_edac.h                         |    4 +-
 drivers/firewire/sbp2.c                            |    5 +-
 drivers/firmware/arm_scmi/bus.c                    |    9 +-
 drivers/firmware/efi/arm-runtime.c                 |    5 +-
 drivers/firmware/efi/efi.c                         |    4 -
 drivers/firmware/efi/libstub/arm-stub.c            |    3 -
 drivers/firmware/efi/runtime-wrappers.c            |    7 +
 drivers/fpga/stratix10-soc.c                       |    5 +-
 drivers/gpio/gpio-altera-a10sr.c                   |    4 +-
 drivers/gpio/gpio-eic-sprd.c                       |   14 +-
 drivers/gpio/gpio-mt7621.c                         |   20 +-
 drivers/gpio/gpio-pca953x.c                        |    2 +-
 drivers/gpio/gpio-pcf857x.c                        |   26 +-
 drivers/gpio/gpio-pxa.c                            |    1 +
 drivers/gpio/gpio-vf610.c                          |    5 +
 drivers/gpio/gpiolib-acpi.c                        |   22 +-
 drivers/gpio/gpiolib.c                             |    9 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c   |    1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |   12 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c        |   20 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c            |    1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c             |   25 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_prime.c          |   59 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c            |    9 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c             |   10 +-
 drivers/gpu/drm/amd/amdgpu/dce_virtual.c           |   17 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c              |   48 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c              |   14 +-
 drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c              |    2 +-
 drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c             |   13 +
 drivers/gpu/drm/amd/amdgpu/psp_v11_0.c             |   28 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c             |    7 +-
 drivers/gpu/drm/amd/amdgpu/soc15.c                 |    6 +-
 drivers/gpu/drm/amd/amdkfd/Kconfig                 |    4 +-
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c              |    8 +
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c          |   21 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |   49 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c  |   22 +-
 drivers/gpu/drm/amd/display/dc/core/dc_link.c      |   12 +-
 drivers/gpu/drm/amd/display/dc/dc_link.h           |    3 +-
 drivers/gpu/drm/amd/display/dc/dc_stream.h         |    1 -
 drivers/gpu/drm/amd/display/dc/dce/dce_clk_mgr.c   |   21 +-
 .../amd/display/dc/dce100/dce100_hw_sequencer.h    |    4 +
 .../amd/display/dc/dce110/dce110_hw_sequencer.c    |    7 +-
 .../drm/amd/display/dc/dce80/dce80_hw_sequencer.c  |    2 +-
 .../gpu/drm/amd/display/dc/dce80/dce80_resource.c  |   19 +-
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp.c   |    2 +-
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubp.c  |    2 +-
 .../drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c  |   23 +-
 .../drm/amd/display/modules/power/power_helpers.c  |    2 +
 drivers/gpu/drm/amd/include/kgd_pp_interface.h     |   13 +-
 drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c        |   24 +-
 drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c  |    1 +
 drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c   |    8 +-
 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c |   12 +-
 .../amd/powerplay/hwmgr/vega10_processpptables.c   |   22 +-
 drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c |   21 +
 drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c |   34 +-
 drivers/gpu/drm/amd/powerplay/inc/hwmgr.h          |    2 +-
 drivers/gpu/drm/bridge/tc358767.c                  |   48 +-
 drivers/gpu/drm/drm_atomic_uapi.c                  |    3 +-
 drivers/gpu/drm/drm_dp_helper.c                    |    2 +
 drivers/gpu/drm/drm_fb_helper.c                    |  133 +-
 drivers/gpu/drm/drm_lease.c                        |    3 +-
 drivers/gpu/drm/drm_mode_object.c                  |    4 +-
 drivers/gpu/drm/drm_modes.c                        |    2 +-
 drivers/gpu/drm/drm_pci.c                          |    5 +-
 drivers/gpu/drm/i915/gvt/handlers.c                |    1 +
 drivers/gpu/drm/i915/gvt/hypercall.h               |    2 +-
 drivers/gpu/drm/i915/gvt/kvmgt.c                   |   30 +-
 drivers/gpu/drm/i915/gvt/mpt.h                     |    2 +-
 drivers/gpu/drm/i915/gvt/scheduler.c               |   75 +-
 drivers/gpu/drm/i915/gvt/scheduler.h               |    1 +
 drivers/gpu/drm/i915/i915_debugfs.c                |   12 +-
 drivers/gpu/drm/i915/i915_gem.c                    |   12 +-
 drivers/gpu/drm/i915/i915_gem_gtt.c                |   15 +-
 drivers/gpu/drm/i915/i915_gpu_error.c              |   23 +-
 drivers/gpu/drm/i915/i915_pmu.c                    |   22 +-
 drivers/gpu/drm/i915/i915_pmu.h                    |    2 +
 drivers/gpu/drm/i915/i915_reg.h                    |   18 +-
 drivers/gpu/drm/i915/i915_sysfs.c                  |    4 +-
 drivers/gpu/drm/i915/intel_ddi.c                   |  240 +-
 drivers/gpu/drm/i915/intel_display.c               |   50 +-
 drivers/gpu/drm/i915/intel_dp.c                    |    4 +-
 drivers/gpu/drm/i915/intel_drv.h                   |   10 +
 drivers/gpu/drm/i915/intel_fbdev.c                 |   45 +-
 drivers/gpu/drm/i915/intel_lrc.c                   |    7 +-
 drivers/gpu/drm/i915/intel_opregion.c              |   38 +-
 drivers/gpu/drm/i915/intel_psr.c                   |    6 +
 drivers/gpu/drm/i915/intel_ringbuffer.h            |    9 +-
 drivers/gpu/drm/i915/intel_sprite.c                |    2 +-
 drivers/gpu/drm/imx/imx-ldb.c                      |   25 +-
 drivers/gpu/drm/imx/ipuv3-plane.c                  |    4 +-
 drivers/gpu/drm/meson/meson_crtc.c                 |   23 +-
 drivers/gpu/drm/meson/meson_drv.c                  |   14 +-
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c              |    2 +-
 drivers/gpu/drm/msm/adreno/adreno_gpu.c            |    1 -
 drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c          |   26 +-
 drivers/gpu/drm/msm/msm_drv.h                      |    6 +-
 drivers/gpu/drm/msm/msm_gem.c                      |    8 +-
 drivers/gpu/drm/msm/msm_gem_vma.c                  |    5 +-
 drivers/gpu/drm/msm/msm_gpu.c                      |    2 +-
 drivers/gpu/drm/msm/msm_gpu.h                      |    3 +-
 drivers/gpu/drm/msm/msm_rd.c                       |    7 +-
 drivers/gpu/drm/nouveau/nouveau_backlight.c        |    3 +
 drivers/gpu/drm/nouveau/nvkm/engine/device/base.c  |   33 +
 drivers/gpu/drm/nouveau/nvkm/engine/falcon.c       |    7 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/therm/base.c   |    7 +-
 drivers/gpu/drm/omapdrm/dss/dsi.c                  |   27 +-
 drivers/gpu/drm/qxl/qxl_drv.c                      |    4 -
 drivers/gpu/drm/qxl/qxl_prime.c                    |   14 -
 drivers/gpu/drm/radeon/ci_dpm.c                    |    5 +-
 drivers/gpu/drm/radeon/radeon_kms.c                |    1 +
 drivers/gpu/drm/radeon/si_dpm.c                    |    5 +-
 drivers/gpu/drm/rockchip/rockchip_rgb.c            |   15 +-
 drivers/gpu/drm/rockchip/rockchip_rgb.h            |   11 +-
 drivers/gpu/drm/scheduler/sched_entity.c           |    7 +-
 drivers/gpu/drm/sun4i/sun4i_backend.c              |    5 +-
 drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c             |    4 +
 drivers/gpu/drm/sun4i/sun4i_tcon.c                 |    2 +
 drivers/gpu/drm/virtio/virtgpu_drv.c               |    4 -
 drivers/gpu/drm/virtio/virtgpu_drv.h               |    4 -
 drivers/gpu/drm/virtio/virtgpu_prime.c             |   14 -
 drivers/gpu/drm/vkms/vkms_crc.c                    |    3 +-
 drivers/gpu/drm/vkms/vkms_crtc.c                   |    8 +-
 drivers/gpu/drm/vkms/vkms_drv.c                    |    7 +-
 drivers/gpu/drm/vkms/vkms_drv.h                    |    2 +
 drivers/gpu/drm/vkms/vkms_gem.c                    |    8 +-
 drivers/gpu/drm/vkms/vkms_output.c                 |    8 +-
 drivers/gpu/drm/vkms/vkms_plane.c                  |    8 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.c                |   81 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c            |    2 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c                |    6 +-
 drivers/gpu/ipu-v3/ipu-common.c                    |    8 +-
 drivers/gpu/ipu-v3/ipu-pre.c                       |    6 +
 drivers/gpu/vga/Kconfig                            |    1 +
 drivers/hid/hid-core.c                             |   23 +-
 drivers/hid/hid-debug.c                            |  120 +-
 drivers/hid/hid-ids.h                              |    3 +
 drivers/hid/i2c-hid/i2c-hid-core.c                 |    2 +
 drivers/hv/channel.c                               |    9 +-
 drivers/hv/hv_balloon.c                            |   10 +-
 drivers/hv/ring_buffer.c                           |   31 +-
 drivers/hv/vmbus_drv.c                             |   91 +-
 drivers/hwmon/lm80.c                               |    4 +-
 drivers/hwmon/nct6775.c                            |   15 +-
 drivers/hwmon/occ/common.c                         |   24 +-
 drivers/hwmon/tmp421.c                             |    2 +-
 drivers/i2c/busses/i2c-bcm2835.c                   |   12 +
 drivers/i2c/busses/i2c-cadence.c                   |    9 +-
 drivers/i2c/busses/i2c-omap.c                      |   13 +-
 drivers/i2c/busses/i2c-tegra.c                     |   15 +-
 drivers/i2c/i2c-dev.c                              |    6 +
 drivers/i3c/master.c                               |    2 +-
 drivers/i3c/master/dw-i3c-master.c                 |   25 +-
 drivers/i3c/master/i3c-master-cdns.c               |    4 +-
 drivers/ide/ide-atapi.c                            |    9 +-
 drivers/ide/ide-io.c                               |   61 +-
 drivers/ide/ide-park.c                             |    2 +
 drivers/ide/ide-probe.c                            |   23 +-
 drivers/ide/ide-proc.c                             |    2 +-
 drivers/iio/adc/axp288_adc.c                       |   76 +-
 drivers/iio/adc/ti-ads8688.c                       |    3 +-
 drivers/iio/adc/ti_am335x_adc.c                    |    5 +-
 drivers/iio/chemical/atlas-ph-sensor.c             |    7 +-
 drivers/infiniband/core/cma.c                      |    5 +-
 drivers/infiniband/core/core_priv.h                |    1 -
 drivers/infiniband/core/device.c                   |   13 +-
 drivers/infiniband/core/nldev.c                    |    4 -
 drivers/infiniband/core/rdma_core.h                |    2 +
 drivers/infiniband/core/umem_odp.c                 |    3 +
 drivers/infiniband/core/uverbs_cmd.c               |   11 +-
 drivers/infiniband/core/uverbs_ioctl.c             |   62 +-
 drivers/infiniband/core/uverbs_main.c              |   26 +-
 drivers/infiniband/core/uverbs_std_types_device.c  |    8 +-
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.c         |    4 +-
 drivers/infiniband/hw/bnxt_re/qplib_res.c          |    8 +-
 drivers/infiniband/hw/cxgb3/cxio_hal.c             |    6 +-
 drivers/infiniband/hw/cxgb4/device.c               |   15 +-
 drivers/infiniband/hw/cxgb4/qp.c                   |    5 +-
 drivers/infiniband/hw/hfi1/file_ops.c              |    2 +-
 drivers/infiniband/hw/hfi1/init.c                  |   29 +-
 drivers/infiniband/hw/hfi1/pio.c                   |    9 +-
 drivers/infiniband/hw/hfi1/sdma.c                  |   27 +-
 drivers/infiniband/hw/hfi1/ud.c                    |    1 -
 drivers/infiniband/hw/hns/hns_roce_alloc.c         |   11 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c         |   10 +-
 drivers/infiniband/hw/hns/hns_roce_srq.c           |   10 +-
 drivers/infiniband/hw/i40iw/i40iw_utils.c          |    4 +-
 drivers/infiniband/hw/mlx4/mad.c                   |    6 +-
 drivers/infiniband/hw/mlx5/flow.c                  |    3 +-
 drivers/infiniband/hw/mlx5/odp.c                   |   10 +-
 drivers/infiniband/hw/mlx5/qp.c                    |   16 +-
 drivers/infiniband/hw/mthca/mthca_memfree.c        |    5 +-
 drivers/infiniband/hw/mthca/mthca_provider.c       |    4 +-
 drivers/infiniband/hw/ocrdma/ocrdma_hw.c           |   14 +-
 drivers/infiniband/hw/ocrdma/ocrdma_stats.c        |    4 +-
 drivers/infiniband/hw/ocrdma/ocrdma_verbs.c        |    6 +-
 drivers/infiniband/hw/qedr/verbs.c                 |    4 +-
 drivers/infiniband/hw/qib/qib_ud.c                 |    1 -
 drivers/infiniband/hw/vmw_pvrdma/pvrdma.h          |   35 +-
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c     |    4 +-
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_qp.c       |    6 +
 drivers/infiniband/sw/rdmavt/qp.c                  |    7 +-
 drivers/infiniband/ulp/ipoib/ipoib.h               |    1 -
 drivers/infiniband/ulp/ipoib/ipoib_cm.c            |    3 +-
 drivers/infiniband/ulp/srp/ib_srp.c                |   10 -
 drivers/input/joystick/xpad.c                      |    3 +
 drivers/input/keyboard/Kconfig                     |    2 +-
 drivers/input/keyboard/cap11xx.c                   |   35 +-
 drivers/input/keyboard/matrix_keypad.c             |    2 +-
 drivers/input/keyboard/qt2160.c                    |   69 +-
 drivers/input/keyboard/st-keyscan.c                |    4 +-
 drivers/input/misc/apanel.c                        |   24 +-
 drivers/input/misc/bma150.c                        |    9 +-
 drivers/input/misc/pwm-vibra.c                     |   19 +-
 drivers/input/misc/uinput.c                        |    5 +-
 drivers/input/mouse/elan_i2c_core.c                |    2 +-
 drivers/input/mouse/elantech.c                     |    9 +
 drivers/input/serio/olpc_apsp.c                    |   17 +-
 drivers/input/serio/ps2-gpio.c                     |    1 +
 drivers/input/touchscreen/Kconfig                  |    2 +-
 drivers/input/touchscreen/raspberrypi-ts.c         |    4 +-
 drivers/iommu/amd_iommu.c                          |   19 +-
 drivers/iommu/intel-iommu.c                        |   10 +-
 drivers/iommu/mtk_iommu_v1.c                       |    9 +-
 drivers/iommu/of_iommu.c                           |    2 +-
 drivers/irqchip/irq-csky-apb-intc.c                |   77 +-
 drivers/irqchip/irq-gic-v3-its.c                   |  126 +-
 drivers/irqchip/irq-gic-v3-mbi.c                   |    2 +-
 drivers/irqchip/irq-madera.c                       |    2 -
 drivers/irqchip/irq-mmp.c                          |    6 +-
 drivers/irqchip/irq-stm32-exti.c                   |    1 +
 drivers/irqchip/irq-xtensa-mx.c                    |   40 +-
 drivers/irqchip/irq-xtensa-pic.c                   |    6 +-
 drivers/isdn/hardware/avm/b1.c                     |    2 +-
 drivers/isdn/hardware/mISDN/hfcsusb.c              |    3 +-
 drivers/isdn/i4l/isdn_tty.c                        |    6 +-
 drivers/isdn/mISDN/timerdev.c                      |    2 +-
 drivers/leds/leds-lp5523.c                         |    4 +-
 drivers/mailbox/bcm-flexrm-mailbox.c               |    4 +-
 drivers/mailbox/mailbox.c                          |    1 +
 drivers/md/dm-crypt.c                              |   27 +-
 drivers/md/dm-rq.c                                 |    2 +-
 drivers/md/dm-thin-metadata.c                      |    4 +-
 drivers/md/dm-thin-metadata.h                      |    2 +-
 drivers/md/dm-thin.c                               |   65 +-
 drivers/md/dm.c                                    |   41 +-
 drivers/md/md.c                                    |    7 +-
 drivers/md/raid1.c                                 |   28 +-
 drivers/md/raid5-cache.c                           |   33 +-
 drivers/md/raid5.c                                 |    8 +-
 drivers/media/pci/intel/ipu3/ipu3-cio2.c           |    4 +-
 .../media/platform/mtk-vcodec/mtk_vcodec_util.c    |    2 +-
 drivers/media/platform/vim2m.c                     |    4 +-
 drivers/media/v4l2-core/v4l2-ioctl.c               |   24 +-
 drivers/mfd/Kconfig                                |    3 +-
 drivers/mfd/ab8500-core.c                          |    2 +-
 drivers/mfd/axp20x.c                               |  126 +-
 drivers/mfd/bd9571mwv.c                            |    1 +
 drivers/mfd/cros_ec_dev.c                          |    1 +
 drivers/mfd/db8500-prcmu.c                         |    4 +-
 drivers/mfd/exynos-lpass.c                         |    4 +-
 drivers/mfd/madera-core.c                          |    5 +-
 drivers/mfd/max77620.c                             |    2 +-
 drivers/mfd/mc13xxx-core.c                         |    4 +-
 drivers/mfd/mt6397-core.c                          |    3 +-
 drivers/mfd/qcom_rpm.c                             |    4 +
 drivers/mfd/rave-sp.c                              |    2 +-
 drivers/mfd/stmpe.c                                |   12 +-
 drivers/mfd/ti_am335x_tscadc.c                     |    5 +-
 drivers/mfd/tps65218.c                             |   24 +-
 drivers/mfd/tps6586x.c                             |   24 +
 drivers/mfd/twl-core.c                             |    4 +-
 drivers/mfd/wm5110-tables.c                        |    2 +
 drivers/misc/genwqe/card_utils.c                   |    4 +-
 drivers/misc/ibmvmc.c                              |    7 +-
 drivers/misc/mei/client.c                          |    5 +-
 drivers/misc/mei/hbm.c                             |   12 +-
 drivers/misc/mei/hw-me-regs.h                      |    4 +
 drivers/misc/mei/pci-me.c                          |    6 +-
 drivers/misc/mic/vop/vop_main.c                    |   82 +-
 drivers/misc/pvpanic.c                             |    4 +
 drivers/mmc/core/block.c                           |   10 +-
 drivers/mmc/core/host.c                            |    2 +-
 drivers/mmc/host/Kconfig                           |    4 +-
 drivers/mmc/host/bcm2835.c                         |    2 +
 drivers/mmc/host/dw_mmc-bluefield.c                |    5 -
 drivers/mmc/host/meson-gx-mmc.c                    |   33 +-
 drivers/mmc/host/mtk-sd.c                          |    2 +-
 drivers/mmc/host/sdhci-iproc.c                     |    5 +-
 drivers/mmc/host/sdhci.c                           |    5 +-
 drivers/mmc/host/sunxi-mmc.c                       |   26 +-
 drivers/mtd/devices/powernv_flash.c                |    2 +-
 drivers/mtd/mtdcore.c                              |    3 +-
 drivers/mtd/mtdcore.h                              |    2 +-
 drivers/mtd/mtdpart.c                              |   39 +-
 drivers/mtd/nand/raw/denali.c                      |    2 +-
 drivers/mtd/nand/raw/fsmc_nand.c                   |   21 -
 drivers/mtd/nand/raw/gpmi-nand/gpmi-lib.c          |   13 +-
 drivers/mtd/nand/raw/jz4740_nand.c                 |    2 +-
 drivers/mtd/nand/raw/nand_base.c                   |    1 +
 drivers/mtd/nand/raw/nand_bbt.c                    |    2 +-
 drivers/mtd/nand/raw/qcom_nandc.c                  |   20 +-
 drivers/mtd/nand/spi/core.c                        |   46 +-
 drivers/net/Kconfig                                |    6 +-
 drivers/net/bonding/bond_main.c                    |   38 +-
 drivers/net/caif/caif_serial.c                     |    5 +-
 drivers/net/can/dev.c                              |   27 +-
 drivers/net/can/flexcan.c                          |    4 +-
 drivers/net/dsa/b53/b53_common.c                   |   90 +-
 drivers/net/dsa/b53/b53_priv.h                     |    3 +
 drivers/net/dsa/b53/b53_srab.c                     |    3 -
 drivers/net/dsa/bcm_sf2.c                          |   12 +-
 drivers/net/dsa/microchip/ksz_common.c             |    2 -
 drivers/net/dsa/mt7530.c                           |    1 -
 drivers/net/dsa/mv88e6xxx/chip.c                   |  141 +-
 drivers/net/dsa/mv88e6xxx/chip.h                   |    5 +
 drivers/net/dsa/mv88e6xxx/global1_atu.c            |   21 +-
 drivers/net/dsa/mv88e6xxx/port.h                   |   10 +
 drivers/net/dsa/mv88e6xxx/serdes.c                 |    2 +-
 drivers/net/dsa/realtek-smi.c                      |   18 +-
 drivers/net/ethernet/aeroflex/greth.c              |   12 +-
 drivers/net/ethernet/alacritech/slicoss.c          |   12 +-
 drivers/net/ethernet/alteon/acenic.c               |    2 +-
 drivers/net/ethernet/altera/altera_msgdma.c        |    3 +-
 drivers/net/ethernet/altera/altera_tse_main.c      |    4 +-
 drivers/net/ethernet/amazon/ena/ena_com.c          |   61 +-
 drivers/net/ethernet/amazon/ena/ena_netdev.c       |   10 +-
 drivers/net/ethernet/amazon/ena/ena_netdev.h       |    2 +-
 drivers/net/ethernet/amd/amd8111e.c                |    2 +-
 drivers/net/ethernet/amd/xgbe/xgbe-common.h        |    2 -
 drivers/net/ethernet/amd/xgbe/xgbe-dev.c           |   22 +-
 drivers/net/ethernet/apm/xgene-v2/main.c           |    8 +-
 drivers/net/ethernet/apple/bmac.c                  |    2 +-
 drivers/net/ethernet/atheros/alx/main.c            |    7 +-
 drivers/net/ethernet/atheros/atl1c/atl1c_main.c    |    4 +-
 drivers/net/ethernet/atheros/atlx/atl2.c           |    4 +-
 drivers/net/ethernet/broadcom/b44.c                |    4 +-
 drivers/net/ethernet/broadcom/bcm63xx_enet.c       |    8 +-
 drivers/net/ethernet/broadcom/bcmsysport.c         |   33 +-
 drivers/net/ethernet/broadcom/bcmsysport.h         |    2 +
 drivers/net/ethernet/broadcom/bgmac.c              |   12 +-
 drivers/net/ethernet/broadcom/bnx2.c               |    4 +-
 drivers/net/ethernet/broadcom/bnx2x/bnx2x.h        |    2 +-
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.h    |    2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c          |   40 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.h          |    2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_dcb.c      |    4 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c  |    4 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_hsi.h      |    5 +-
 drivers/net/ethernet/broadcom/sb1250-mac.c         |    2 +-
 drivers/net/ethernet/broadcom/tg3.c                |   22 +-
 drivers/net/ethernet/cadence/macb.h                |    3 +
 drivers/net/ethernet/cadence/macb_main.c           |   36 +-
 drivers/net/ethernet/cavium/Kconfig                |    1 -
 drivers/net/ethernet/cavium/thunder/nic.h          |   14 +-
 drivers/net/ethernet/cavium/thunder/nic_main.c     |  149 +-
 drivers/net/ethernet/cavium/thunder/nicvf_main.c   |  128 +-
 drivers/net/ethernet/cavium/thunder/nicvf_queues.c |    2 +-
 drivers/net/ethernet/cavium/thunder/thunder_bgx.c  |    2 +-
 drivers/net/ethernet/cavium/thunder/thunder_bgx.h  |    2 +-
 drivers/net/ethernet/chelsio/cxgb3/sge.c           |   14 +-
 drivers/net/ethernet/chelsio/cxgb3/t3_hw.c         |    6 +-
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ptp.c     |    8 +-
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_uld.c     |    3 +-
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_uld.h     |    1 +
 drivers/net/ethernet/chelsio/cxgb4/sge.c           |    2 +-
 drivers/net/ethernet/chelsio/cxgb4/t4_hw.c         |    2 +-
 drivers/net/ethernet/chelsio/cxgb4vf/sge.c         |    2 +-
 drivers/net/ethernet/cisco/enic/enic_main.c        |    3 +-
 drivers/net/ethernet/dec/tulip/de2104x.c           |    2 +-
 drivers/net/ethernet/emulex/benet/be_cmds.c        |   68 +-
 drivers/net/ethernet/emulex/benet/be_ethtool.c     |   18 +-
 drivers/net/ethernet/emulex/benet/be_main.c        |   18 +-
 drivers/net/ethernet/faraday/ftgmac100.c           |   14 +-
 drivers/net/ethernet/faraday/ftmac100.c            |    7 +-
 drivers/net/ethernet/freescale/dpaa/dpaa_eth.c     |    6 +
 drivers/net/ethernet/freescale/dpaa2/Kconfig       |    5 +-
 drivers/net/ethernet/freescale/fec_main.c          |    6 +-
 drivers/net/ethernet/freescale/fec_mpc52xx.c       |    2 +-
 drivers/net/ethernet/freescale/ucc_geth.c          |    2 +
 drivers/net/ethernet/hisilicon/hix5hd2_gmac.c      |    4 +-
 drivers/net/ethernet/hisilicon/hns/hns_ae_adapt.c  |    6 +-
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c |    5 +
 drivers/net/ethernet/hisilicon/hns/hns_enet.c      |   22 +-
 drivers/net/ethernet/hisilicon/hns/hns_ethtool.c   |   16 +-
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c    |    5 +-
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.c |    5 +-
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_cmd.c   |    5 +-
 drivers/net/ethernet/hisilicon/hns_mdio.c          |    2 +-
 .../net/ethernet/huawei/hinic/hinic_hw_api_cmd.c   |   16 +-
 drivers/net/ethernet/huawei/hinic/hinic_hw_eqs.c   |    8 +-
 drivers/net/ethernet/huawei/hinic/hinic_hw_io.c    |    6 +-
 drivers/net/ethernet/huawei/hinic/hinic_hw_qp.c    |   10 +-
 drivers/net/ethernet/huawei/hinic/hinic_hw_wq.c    |    8 +-
 drivers/net/ethernet/i825xx/82596.c                |    2 +-
 drivers/net/ethernet/ibm/emac/mal.c                |    4 +-
 drivers/net/ethernet/ibm/ibmveth.c                 |    2 -
 drivers/net/ethernet/intel/Kconfig                 |    2 +-
 drivers/net/ethernet/intel/e1000/e1000_ethtool.c   |    8 +-
 drivers/net/ethernet/intel/e1000e/netdev.c         |    4 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c        |   31 +-
 drivers/net/ethernet/intel/i40e/i40e_txrx.c        |    4 +-
 drivers/net/ethernet/intel/i40e/i40e_xsk.c         |    5 +
 drivers/net/ethernet/intel/igb/igb.h               |    2 +-
 drivers/net/ethernet/intel/igb/igb_ethtool.c       |    4 +-
 drivers/net/ethernet/intel/igb/igb_main.c          |   14 +-
 drivers/net/ethernet/intel/ixgb/ixgb_main.c        |    8 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c      |   19 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c       |   15 +-
 drivers/net/ethernet/marvell/mv643xx_eth.c         |    7 +-
 drivers/net/ethernet/marvell/mvneta.c              |    2 +-
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c    |    6 +-
 drivers/net/ethernet/marvell/octeontx2/af/cgx.c    |    4 +-
 drivers/net/ethernet/marvell/octeontx2/af/common.h |    2 +-
 drivers/net/ethernet/marvell/pxa168_eth.c          |   18 +-
 drivers/net/ethernet/marvell/skge.c                |    6 +-
 drivers/net/ethernet/marvell/sky2.c                |    2 +-
 drivers/net/ethernet/mediatek/mtk_eth_soc.c        |   34 +-
 drivers/net/ethernet/mellanox/mlx4/alloc.c         |    8 +-
 drivers/net/ethernet/mellanox/mlx4/cq.c            |    6 +-
 drivers/net/ethernet/mellanox/mlx4/en_netdev.c     |    2 +-
 drivers/net/ethernet/mellanox/mlx4/en_rx.c         |   22 +-
 drivers/net/ethernet/mellanox/mlx4/fw.c            |   75 +-
 drivers/net/ethernet/mellanox/mlx4/icm.c           |  101 +-
 drivers/net/ethernet/mellanox/mlx4/icm.h           |   22 +-
 drivers/net/ethernet/mellanox/mlx5/core/alloc.c    |    4 +-
 drivers/net/ethernet/mellanox/mlx5/core/cmd.c      |   28 +-
 drivers/net/ethernet/mellanox/mlx5/core/en.h       |    1 +
 .../net/ethernet/mellanox/mlx5/core/en/tc_tun.c    |    6 +-
 .../net/ethernet/mellanox/mlx5/core/en/tc_tun.h    |    2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c   |    6 +-
 drivers/net/ethernet/mellanox/mlx5/core/en/xdp.h   |   17 +
 .../net/ethernet/mellanox/mlx5/core/en_ethtool.c   |   12 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c  |    4 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_rep.c   |   59 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_rep.h   |    1 +
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c    |   13 +
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c    |   52 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_tx.c    |    6 +
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.c  |   22 +-
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.h  |    1 +
 .../ethernet/mellanox/mlx5/core/eswitch_offloads.c |   17 +-
 drivers/net/ethernet/mellanox/mlx5/core/events.c   |   17 +-
 drivers/net/ethernet/mellanox/mlx5/core/health.c   |    2 +-
 drivers/net/ethernet/mellanox/mlx5/core/lag.c      |   21 +
 .../net/ethernet/mellanox/mlx5/core/mlx5_core.h    |    3 +
 drivers/net/ethernet/mellanox/mlx5/core/qp.c       |    5 +-
 drivers/net/ethernet/mellanox/mlxsw/Kconfig        |    1 +
 drivers/net/ethernet/mellanox/mlxsw/pci.c          |   16 +-
 drivers/net/ethernet/mellanox/mlxsw/pci_hw.h       |    3 +-
 drivers/net/ethernet/mellanox/mlxsw/spectrum.c     |   19 +-
 .../ethernet/mellanox/mlxsw/spectrum_acl_ctcam.c   |   10 +-
 .../net/ethernet/mellanox/mlxsw/spectrum_acl_erp.c |    2 -
 drivers/net/ethernet/mellanox/mlxsw/spectrum_fid.c |    4 +-
 drivers/net/ethernet/mellanox/mlxsw/spectrum_nve.c |    4 +-
 .../ethernet/mellanox/mlxsw/spectrum_switchdev.c   |   35 +-
 drivers/net/ethernet/microchip/lan743x_main.c      |   11 +-
 drivers/net/ethernet/myricom/myri10ge/myri10ge.c   |    6 +-
 drivers/net/ethernet/netronome/nfp/bpf/jit.c       |   17 +-
 .../net/ethernet/netronome/nfp/nfp_net_common.c    |   12 +-
 drivers/net/ethernet/ni/nixge.c                    |   12 +-
 .../net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c   |   12 +-
 drivers/net/ethernet/pasemi/pasemi_mac.c           |    6 +-
 drivers/net/ethernet/qlogic/qed/qed.h              |    2 +-
 drivers/net/ethernet/qlogic/qed/qed_cxt.c          |   16 +-
 drivers/net/ethernet/qlogic/qed/qed_dev.c          |    8 +-
 drivers/net/ethernet/qlogic/qed/qed_iwarp.c        |   21 +-
 drivers/net/ethernet/qlogic/qed/qed_iwarp.h        |    1 -
 drivers/net/ethernet/qlogic/qed/qed_l2.c           |   20 +-
 drivers/net/ethernet/qlogic/qed/qed_l2.h           |    3 +
 drivers/net/ethernet/qlogic/qed/qed_ll2.c          |   24 +-
 drivers/net/ethernet/qlogic/qed/qed_sp.h           |    1 +
 drivers/net/ethernet/qlogic/qed/qed_sp_commands.c  |    3 +
 drivers/net/ethernet/qlogic/qed/qed_spq.c          |   15 +-
 drivers/net/ethernet/qlogic/qed/qed_sriov.c        |   10 +-
 drivers/net/ethernet/qlogic/qed/qed_vf.c           |   10 +
 drivers/net/ethernet/qlogic/qede/qede.h            |    5 +-
 drivers/net/ethernet/qlogic/qede/qede_fp.c         |   13 +
 drivers/net/ethernet/qlogic/qede/qede_main.c       |    3 +
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_ctx.c    |   28 +-
 drivers/net/ethernet/qualcomm/emac/emac-mac.c      |    2 +-
 drivers/net/ethernet/realtek/8139cp.c              |    2 +-
 drivers/net/ethernet/realtek/r8169.c               |   30 +-
 drivers/net/ethernet/renesas/ravb_main.c           |   12 +-
 drivers/net/ethernet/samsung/sxgbe/sxgbe_main.c    |   12 +-
 drivers/net/ethernet/sfc/ef10.c                    |   29 +-
 drivers/net/ethernet/sfc/falcon/nic.c              |    4 +-
 drivers/net/ethernet/sfc/nic.c                     |    4 +-
 drivers/net/ethernet/sgi/meth.c                    |    4 +-
 drivers/net/ethernet/smsc/epic100.c                |    2 +-
 drivers/net/ethernet/socionext/netsec.c            |    4 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c     |    4 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c |    9 +-
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c |    6 +-
 .../net/ethernet/stmicro/stmmac/stmmac_ethtool.c   |   36 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |  108 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c   |   10 +
 drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c    |    2 +
 drivers/net/ethernet/sun/cassini.c                 |   17 +-
 drivers/net/ethernet/sun/cassini.h                 |   15 +-
 drivers/net/ethernet/sun/sunbmac.c                 |    2 +-
 drivers/net/ethernet/sun/sunhme.c                  |    2 +-
 drivers/net/ethernet/tehuti/tehuti.c               |    2 +-
 drivers/net/ethernet/ti/cpmac.c                    |    2 +-
 drivers/net/ethernet/ti/netcp_core.c               |    2 +-
 drivers/net/ethernet/tundra/tsi108_eth.c           |    8 +-
 drivers/net/ethernet/via/via-velocity.c            |    2 +-
 drivers/net/ethernet/xilinx/ll_temac_main.c        |   12 +-
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c  |   12 +-
 drivers/net/fddi/defxx.c                           |    8 +-
 drivers/net/fddi/skfp/skfddi.c                     |    8 +-
 drivers/net/geneve.c                               |   10 +-
 drivers/net/hyperv/hyperv_net.h                    |   12 +-
 drivers/net/hyperv/netvsc.c                        |    4 +-
 drivers/net/hyperv/netvsc_drv.c                    |  145 +-
 drivers/net/hyperv/rndis_filter.c                  |   36 +-
 drivers/net/ieee802154/mcr20a.c                    |    6 +-
 drivers/net/ipvlan/ipvlan_main.c                   |   10 +-
 drivers/net/macvlan.c                              |    2 +-
 drivers/net/phy/asix.c                             |    8 +-
 drivers/net/phy/bcm87xx.c                          |    2 +
 drivers/net/phy/cortina.c                          |    1 +
 drivers/net/phy/dp83640.c                          |   13 +-
 drivers/net/phy/marvell.c                          |   53 +-
 drivers/net/phy/marvell10g.c                       |    6 +-
 drivers/net/phy/mdio-hisi-femac.c                  |   16 +-
 drivers/net/phy/mdio_bus.c                         |    2 +-
 drivers/net/phy/meson-gxl.c                        |    1 +
 drivers/net/phy/micrel.c                           |    2 +
 drivers/net/phy/phy.c                              |   33 +-
 drivers/net/phy/phy_device.c                       |   17 +
 drivers/net/phy/phylink.c                          |   19 +-
 drivers/net/phy/realtek.c                          |    7 +
 drivers/net/phy/rockchip.c                         |    9 +-
 drivers/net/phy/sfp-bus.c                          |    2 +
 drivers/net/phy/sfp.c                              |   30 +-
 drivers/net/phy/sfp.h                              |    2 +
 drivers/net/phy/teranetics.c                       |    1 +
 drivers/net/phy/xilinx_gmii2rgmii.c                |    5 +-
 drivers/net/ppp/pppoe.c                            |    1 +
 drivers/net/team/team.c                            |   31 +-
 drivers/net/tun.c                                  |   14 +-
 drivers/net/usb/aqc111.c                           |   15 +
 drivers/net/usb/asix_devices.c                     |    9 +-
 drivers/net/usb/cdc_ether.c                        |   34 +-
 drivers/net/usb/qmi_wwan.c                         |    5 +-
 drivers/net/usb/r8152.c                            |    5 +-
 drivers/net/virtio_net.c                           |  181 +-
 drivers/net/vmxnet3/vmxnet3_drv.c                  |    8 +-
 drivers/net/vrf.c                                  |    3 +
 drivers/net/vxlan.c                                |   14 +-
 drivers/net/wan/dscc4.c                            |    2 +-
 drivers/net/wan/fsl_ucc_hdlc.c                     |   71 +-
 drivers/net/wireless/ath/ath10k/ce.c               |    7 +-
 drivers/net/wireless/ath/ath10k/core.c             |    2 +-
 drivers/net/wireless/ath/ath10k/mac.c              |    8 +-
 drivers/net/wireless/ath/ath10k/pci.c              |    3 +-
 drivers/net/wireless/ath/ath10k/wmi.c              |    2 +-
 drivers/net/wireless/ath/wcn36xx/dxe.c             |   17 +-
 drivers/net/wireless/ath/wil6210/txrx_edma.c       |    8 +-
 drivers/net/wireless/broadcom/b43/dma.c            |    6 +-
 drivers/net/wireless/broadcom/b43legacy/dma.c      |    6 +-
 .../wireless/broadcom/brcm80211/brcmfmac/pcie.c    |   16 +-
 drivers/net/wireless/intel/iwlwifi/Kconfig         |    3 +-
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c       |   39 +-
 drivers/net/wireless/mac80211_hwsim.c              |    7 +-
 drivers/net/wireless/mediatek/mt76/mt76x0/eeprom.c |   40 +-
 drivers/net/wireless/mediatek/mt76/mt76x0/eeprom.h |    2 +-
 drivers/net/wireless/mediatek/mt76/mt76x0/phy.c    |   10 +-
 drivers/net/wireless/mediatek/mt76/mt76x0/usb.c    |   46 +-
 drivers/net/wireless/ralink/rt2x00/rt2x00mmio.c    |    6 +-
 drivers/net/wireless/ti/wlcore/sdio.c              |   15 +-
 drivers/net/wireless/virt_wifi.c                   |    4 +-
 drivers/ntb/hw/mscc/ntb_hw_switchtec.c             |    8 +-
 drivers/nvdimm/dimm.c                              |    6 +
 drivers/nvdimm/dimm_devs.c                         |   22 +-
 drivers/nvdimm/nd-core.h                           |    4 +-
 drivers/nvdimm/nd.h                                |    1 +
 drivers/nvme/host/core.c                           |   27 +-
 drivers/nvme/host/fabrics.c                        |    2 +
 drivers/nvme/host/multipath.c                      |    5 +-
 drivers/nvme/host/nvme.h                           |    6 +
 drivers/nvme/host/pci.c                            |  126 +-
 drivers/nvme/host/rdma.c                           |   64 +-
 drivers/nvme/host/tcp.c                            |   35 +-
 drivers/nvme/target/rdma.c                         |   15 +-
 drivers/nvme/target/tcp.c                          |    2 +-
 drivers/of/dynamic.c                               |    3 -
 drivers/of/fdt.c                                   |    4 -
 drivers/of/overlay.c                               |    3 -
 drivers/of/pdt.c                                   |    1 -
 drivers/of/property.c                              |    1 +
 drivers/opp/core.c                                 |   63 +-
 drivers/pci/Kconfig                                |   22 +-
 drivers/pci/controller/dwc/pci-imx6.c              |   11 +-
 drivers/pci/controller/dwc/pci-meson.c             |    1 +
 drivers/pci/controller/dwc/pcie-armada8k.c         |   16 -
 drivers/pci/controller/pcie-iproc-msi.c            |    6 +-
 drivers/pci/msi.c                                  |   22 +-
 drivers/pci/pci.c                                  |    3 +-
 drivers/pci/quirks.c                               |    5 +-
 drivers/pci/switch/switchtec.c                     |    8 +-
 drivers/phy/marvell/phy-berlin-sata.c              |    5 +-
 drivers/phy/qualcomm/phy-ath79-usb.c               |    4 +-
 drivers/phy/ti/Kconfig                             |    1 +
 drivers/phy/ti/phy-gmii-sel.c                      |    4 +-
 drivers/pinctrl/intel/pinctrl-cherryview.c         |    8 +-
 drivers/pinctrl/mediatek/Kconfig                   |    3 +
 drivers/pinctrl/meson/pinctrl-meson8b.c            |    2 +-
 drivers/pinctrl/pinctrl-mcp23s08.c                 |    7 +-
 drivers/pinctrl/qcom/pinctrl-qcs404.c              |    2 +-
 drivers/pinctrl/sunxi/pinctrl-sun50i-h6.c          |    2 +-
 drivers/pinctrl/sunxi/pinctrl-sunxi.c              |   44 +-
 drivers/pinctrl/sunxi/pinctrl-sunxi.h              |    2 +-
 drivers/platform/x86/Kconfig                       |    8 +-
 drivers/ptp/ptp_chardev.c                          |    3 +-
 drivers/rapidio/devices/tsi721.c                   |   22 +-
 drivers/rapidio/devices/tsi721_dma.c               |    8 +-
 drivers/remoteproc/remoteproc_virtio.c             |    9 +-
 drivers/reset/Kconfig                              |   20 +-
 drivers/reset/Makefile                             |    3 +-
 drivers/reset/core.c                               |   42 +
 drivers/reset/reset-hsdk.c                         |    1 +
 drivers/reset/reset-simple.c                       |   13 +-
 drivers/reset/reset-socfpga.c                      |   88 +
 ...reset-uniphier-usb3.c =3D> reset-uniphier-glue.c} |   50 +-
 drivers/s390/block/dasd_eckd.c                     |    8 +
 drivers/s390/char/sclp_config.c                    |    2 +
 drivers/s390/crypto/ap_bus.c                       |    3 +-
 drivers/s390/net/ism_drv.c                         |   15 +-
 drivers/s390/net/qeth_core.h                       |    3 +-
 drivers/s390/net/qeth_core_main.c                  |   31 +-
 drivers/s390/net/qeth_l2_main.c                    |    8 +-
 drivers/s390/net/qeth_l3_main.c                    |    3 +
 drivers/s390/scsi/zfcp_aux.c                       |    1 -
 drivers/s390/scsi/zfcp_scsi.c                      |    2 +
 drivers/s390/virtio/virtio_ccw.c                   |   12 +-
 drivers/scsi/3w-sas.c                              |    5 +-
 drivers/scsi/53c700.c                              |    2 +-
 drivers/scsi/a100u2w.c                             |    8 +-
 drivers/scsi/aacraid/linit.c                       |    9 +-
 drivers/scsi/aic94xx/aic94xx_init.c                |    8 +-
 drivers/scsi/arcmsr/arcmsr_hba.c                   |   18 +-
 drivers/scsi/be2iscsi/be_main.c                    |    4 +-
 drivers/scsi/be2iscsi/be_mgmt.c                    |   11 +-
 drivers/scsi/bfa/bfad_bsg.c                        |    6 +-
 drivers/scsi/bnx2fc/bnx2fc_hwi.c                   |   49 +-
 drivers/scsi/bnx2fc/bnx2fc_io.c                    |    4 +-
 drivers/scsi/bnx2fc/bnx2fc_tgt.c                   |   44 +-
 drivers/scsi/bnx2i/bnx2i_hwi.c                     |    8 +-
 drivers/scsi/csiostor/csio_attr.c                  |    2 +-
 drivers/scsi/csiostor/csio_wr.c                    |    4 +-
 drivers/scsi/cxgbi/cxgb3i/cxgb3i.c                 |    9 +-
 drivers/scsi/cxgbi/cxgb4i/cxgb4i.c                 |   28 +-
 drivers/scsi/cxgbi/libcxgbi.c                      |    7 +-
 drivers/scsi/cxgbi/libcxgbi.h                      |    5 +-
 drivers/scsi/cxlflash/main.c                       |    2 +
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c             |   12 +-
 drivers/scsi/isci/init.c                           |   14 +-
 drivers/scsi/libfc/fc_lport.c                      |    6 +-
 drivers/scsi/libfc/fc_rport.c                      |    1 -
 drivers/scsi/libiscsi.c                            |    6 +
 drivers/scsi/libsas/sas_expander.c                 |    2 +
 drivers/scsi/lpfc/lpfc_bsg.c                       |    4 +-
 drivers/scsi/lpfc/lpfc_init.c                      |   14 +-
 drivers/scsi/lpfc/lpfc_mbox.c                      |    6 +-
 drivers/scsi/lpfc/lpfc_nvme.c                      |   16 +-
 drivers/scsi/lpfc/lpfc_nvme.h                      |    2 +-
 drivers/scsi/lpfc/lpfc_nvmet.c                     |    8 +-
 drivers/scsi/lpfc/lpfc_nvmet.h                     |    2 +-
 drivers/scsi/lpfc/lpfc_sli.c                       |   35 +-
 drivers/scsi/megaraid/megaraid_mbox.c              |   15 +-
 drivers/scsi/megaraid/megaraid_sas_base.c          |   28 +-
 drivers/scsi/megaraid/megaraid_sas_fusion.c        |    8 +-
 drivers/scsi/mesh.c                                |    5 +-
 drivers/scsi/mvumi.c                               |    9 +-
 drivers/scsi/pm8001/pm8001_sas.c                   |    6 +-
 drivers/scsi/qedf/qedf_main.c                      |   29 +-
 drivers/scsi/qedi/qedi_iscsi.c                     |    3 +
 drivers/scsi/qedi/qedi_iscsi.h                     |    1 +
 drivers/scsi/qedi/qedi_main.c                      |   39 +-
 drivers/scsi/qla1280.c                             |    2 +-
 drivers/scsi/qla2xxx/qla_attr.c                    |    4 +-
 drivers/scsi/qla2xxx/qla_bsg.c                     |    4 +-
 drivers/scsi/qla2xxx/qla_def.h                     |    2 +
 drivers/scsi/qla2xxx/qla_gs.c                      |   14 +-
 drivers/scsi/qla2xxx/qla_init.c                    |   12 +-
 drivers/scsi/qla2xxx/qla_isr.c                     |    1 +
 drivers/scsi/qla2xxx/qla_os.c                      |    2 +-
 drivers/scsi/qla4xxx/ql4_init.c                    |    4 +-
 drivers/scsi/qla4xxx/ql4_mbx.c                     |   18 +-
 drivers/scsi/qla4xxx/ql4_nx.c                      |    4 +-
 drivers/scsi/qla4xxx/ql4_os.c                      |   12 +-
 drivers/scsi/scsi_debug.c                          |   41 +-
 drivers/scsi/scsi_lib.c                            |    5 +-
 drivers/scsi/scsi_pm.c                             |   26 +-
 drivers/scsi/sd.c                                  |   18 +-
 drivers/scsi/sd_zbc.c                              |   20 +-
 drivers/scsi/smartpqi/smartpqi_init.c              |   34 +-
 drivers/scsi/ufs/ufs.h                             |    2 +-
 drivers/scsi/ufs/ufshcd.c                          |   12 +-
 drivers/soc/fsl/qbman/dpaa_sys.c                   |    2 +-
 drivers/soc/fsl/qbman/qman.c                       |    9 +-
 drivers/soc/fsl/qe/qe_tdm.c                        |   55 -
 drivers/soc/renesas/Kconfig                        |    2 +-
 drivers/soc/renesas/r8a774c0-sysc.c                |   23 +-
 drivers/spi/spi-pic32-sqi.c                        |    6 +-
 drivers/staging/android/ion/ion.c                  |    2 +-
 drivers/staging/mt7621-eth/mtk_eth_soc.c           |    3 +-
 drivers/staging/octeon/ethernet-mdio.c             |    2 +-
 drivers/staging/rtl8188eu/core/rtw_security.c      |    6 +-
 drivers/staging/rtl8188eu/os_dep/usb_intf.c        |    1 +
 drivers/staging/rtl8723bs/include/ieee80211.h      |    6 +-
 drivers/staging/rtl8723bs/os_dep/sdio_intf.c       |    2 +-
 drivers/staging/speakup/spk_ttyio.c                |    6 +-
 .../interface/vchiq_arm/vchiq_2835_arm.c           |    6 +-
 .../vc04_services/interface/vchiq_arm/vchiq_core.c |    1 +
 drivers/staging/vt6655/device_main.c               |   19 +-
 drivers/staging/wilc1000/host_interface.c          |    5 +-
 drivers/staging/wilc1000/wilc_wlan.c               |    7 +-
 drivers/target/iscsi/iscsi_target.c                |    2 +-
 drivers/target/target_core_configfs.c              |    8 +-
 drivers/target/target_core_user.c                  |   89 +-
 drivers/thermal/cpu_cooling.c                      |    2 +-
 drivers/thermal/intel/int340x_thermal/Kconfig      |    2 +-
 .../int340x_thermal/processor_thermal_device.c     |   30 +-
 drivers/thermal/of-thermal.c                       |    4 +-
 drivers/tty/n_hdlc.c                               |    1 +
 drivers/tty/serial/8250/8250_core.c                |   17 +-
 drivers/tty/serial/8250/8250_mtk.c                 |    3 +
 drivers/tty/serial/8250/8250_pci.c                 |    9 +-
 drivers/tty/serial/Kconfig                         |   12 +
 drivers/tty/serial/Makefile                        |    1 +
 drivers/tty/serial/earlycon-riscv-sbi.c            |   31 +
 drivers/tty/serial/fsl_lpuart.c                    |    2 +-
 drivers/tty/serial/lantiq.c                        |   36 +-
 drivers/tty/serial/qcom_geni_serial.c              |    4 +-
 drivers/tty/serial/serial_core.c                   |   18 +-
 drivers/tty/serial/sh-sci.c                        |    9 +-
 drivers/tty/tty_io.c                               |   23 +-
 drivers/tty/vt/vt.c                                |   50 +-
 drivers/usb/chipidea/ci_hdrc_imx.c                 |    3 +-
 drivers/usb/class/cdc-acm.c                        |    7 +
 drivers/usb/core/generic.c                         |    9 +-
 drivers/usb/core/ledtrig-usbport.c                 |   17 +-
 drivers/usb/core/quirks.c                          |    3 +-
 drivers/usb/dwc2/gadget.c                          |    2 +-
 drivers/usb/dwc3/dwc3-exynos.c                     |    4 +-
 drivers/usb/dwc3/gadget.c                          |    6 +-
 drivers/usb/gadget/function/f_sourcesink.c         |    2 +-
 drivers/usb/gadget/udc/bdc/bdc_core.c              |   13 +-
 drivers/usb/gadget/udc/net2272.c                   |    2 +-
 drivers/usb/host/ehci-mv.c                         |    1 +
 drivers/usb/host/uhci-hcd.c                        |    6 +-
 drivers/usb/host/xhci-mem.c                        |    8 +-
 drivers/usb/musb/musb_gadget.c                     |   13 +-
 drivers/usb/musb/musbhsdma.c                       |   21 +-
 drivers/usb/phy/Kconfig                            |    2 +-
 drivers/usb/phy/phy-am335x.c                       |    5 +-
 drivers/usb/serial/ftdi_sio.c                      |   15 +-
 drivers/usb/serial/keyspan_usa26msg.h              |    1 +
 drivers/usb/serial/keyspan_usa28msg.h              |    1 +
 drivers/usb/serial/keyspan_usa49msg.h              |    1 +
 drivers/usb/serial/keyspan_usa67msg.h              |    1 +
 drivers/usb/serial/keyspan_usa90msg.h              |    1 +
 drivers/usb/serial/pl2303.c                        |    1 +
 drivers/usb/serial/pl2303.h                        |    2 +
 drivers/usb/serial/usb-serial-simple.c             |    3 +-
 drivers/usb/storage/scsiglue.c                     |    8 +-
 drivers/usb/storage/unusual_devs.h                 |   12 +
 drivers/usb/typec/tcpm/tcpm.c                      |    3 +-
 drivers/usb/usbip/README                           |    7 -
 drivers/vfio/pci/trace.h                           |    8 +-
 drivers/vfio/pci/vfio_pci_nvlink2.c                |   36 +-
 drivers/vfio/vfio_iommu_type1.c                    |    2 +-
 drivers/vhost/net.c                                |    6 +-
 drivers/vhost/scsi.c                               |   22 +-
 drivers/vhost/vhost.c                              |  112 +-
 drivers/vhost/vhost.h                              |    7 +-
 drivers/vhost/vsock.c                              |    4 +-
 drivers/video/backlight/88pm860x_bl.c              |    2 +-
 drivers/video/backlight/pwm_bl.c                   |   28 +-
 drivers/video/console/vgacon.c                     |    7 +-
 drivers/video/fbdev/core/fbcon.c                   |    7 +
 drivers/video/fbdev/core/fbmem.c                   |   19 +-
 drivers/video/fbdev/da8xx-fb.c                     |    6 +-
 drivers/video/fbdev/offb.c                         |   18 +-
 drivers/video/fbdev/omap2/omapfb/omapfb-ioctl.c    |    2 +
 drivers/video/logo/Kconfig                         |    9 -
 drivers/virtio/virtio_balloon.c                    |   98 +-
 drivers/virtio/virtio_mmio.c                       |    9 +-
 drivers/virtio/virtio_pci_common.c                 |    8 +-
 drivers/virtio/virtio_ring.c                       |   15 +-
 drivers/watchdog/mt7621_wdt.c                      |    1 +
 drivers/watchdog/rt2880_wdt.c                      |    1 +
 drivers/watchdog/tqmx86_wdt.c                      |    8 +-
 drivers/xen/events/events_base.c                   |    2 +-
 drivers/xen/pvcalls-back.c                         |    9 +-
 drivers/xen/pvcalls-front.c                        |  104 +-
 drivers/xen/swiotlb-xen.c                          |    4 +-
 fs/afs/flock.c                                     |    4 +-
 fs/afs/inode.c                                     |    3 +-
 fs/afs/protocol_yfs.h                              |   11 +
 fs/afs/rxrpc.c                                     |   53 +-
 fs/afs/server_list.c                               |    4 +-
 fs/afs/yfsclient.c                                 |    2 +-
 fs/aio.c                                           |    1 +
 fs/autofs/expire.c                                 |    3 +-
 fs/autofs/inode.c                                  |    4 +-
 fs/binfmt_script.c                                 |   57 +-
 fs/block_dev.c                                     |   28 +-
 fs/btrfs/ctree.c                                   |   76 +-
 fs/btrfs/ctree.h                                   |    7 +
 fs/btrfs/disk-io.c                                 |   12 +
 fs/btrfs/extent-tree.c                             |   21 +-
 fs/btrfs/inode.c                                   |    5 +-
 fs/btrfs/ioctl.c                                   |   49 +-
 fs/btrfs/super.c                                   |    3 +
 fs/btrfs/transaction.c                             |   24 +-
 fs/btrfs/volumes.c                                 |   16 +-
 fs/buffer.c                                        |   19 +-
 fs/ceph/addr.c                                     |    5 +-
 fs/ceph/caps.c                                     |    2 +
 fs/ceph/quota.c                                    |   13 -
 fs/ceph/snap.c                                     |    3 +-
 fs/ceph/super.c                                    |    4 +-
 fs/cifs/cifs_debug.c                               |    1 +
 fs/cifs/cifsfs.h                                   |    2 +-
 fs/cifs/cifsglob.h                                 |   20 +
 fs/cifs/cifssmb.c                                  |   65 +-
 fs/cifs/connect.c                                  |   28 +-
 fs/cifs/dfs_cache.c                                |    1 +
 fs/cifs/file.c                                     |   56 +-
 fs/cifs/inode.c                                    |   10 +
 fs/cifs/smb2file.c                                 |    8 +-
 fs/cifs/smb2inode.c                                |   17 +
 fs/cifs/smb2misc.c                                 |    7 +
 fs/cifs/smb2ops.c                                  |   72 +-
 fs/cifs/smb2pdu.c                                  |  108 +-
 fs/cifs/smb2pdu.h                                  |   19 +-
 fs/cifs/trace.c                                    |   10 -
 fs/cifs/trace.h                                    |   10 -
 fs/cifs/transport.c                                |  113 +-
 fs/dcache.c                                        |   38 +-
 fs/debugfs/inode.c                                 |   36 +-
 fs/direct-io.c                                     |    5 +-
 fs/drop_caches.c                                   |    8 +-
 fs/ext4/fsync.c                                    |   13 +-
 fs/fs-writeback.c                                  |   40 +-
 fs/fuse/dev.c                                      |    4 +-
 fs/fuse/file.c                                     |    2 +-
 fs/fuse/inode.c                                    |    2 +-
 fs/gfs2/glops.c                                    |    1 -
 fs/gfs2/log.c                                      |    4 +-
 fs/gfs2/lops.c                                     |  190 +-
 fs/gfs2/lops.h                                     |    4 +-
 fs/gfs2/ops_fstype.c                               |    1 -
 fs/gfs2/recovery.c                                 |  123 +
 fs/gfs2/recovery.h                                 |    2 +
 fs/gfs2/rgrp.c                                     |    2 +-
 fs/gfs2/super.c                                    |    1 -
 fs/hugetlbfs/inode.c                               |   61 +-
 fs/inode.c                                         |    7 +-
 fs/iomap.c                                         |   37 +-
 fs/nfs/nfs4file.c                                  |    8 +-
 fs/nfs/nfs4idmap.c                                 |   31 +-
 fs/nfs/super.c                                     |    5 +
 fs/nfs/write.c                                     |   20 +-
 fs/nfsd/nfsctl.c                                   |    4 +-
 fs/nfsd/vfs.c                                      |    6 +-
 fs/notify/inotify/inotify_user.c                   |    6 +-
 fs/proc/base.c                                     |    4 -
 fs/proc/generic.c                                  |    4 +-
 fs/proc/internal.h                                 |    1 +
 fs/proc/proc_net.c                                 |   20 +
 fs/proc/task_mmu.c                                 |   22 +-
 fs/pstore/ram.c                                    |   12 +-
 fs/sysfs/dir.c                                     |    3 +-
 fs/sysfs/file.c                                    |    6 +-
 fs/sysfs/group.c                                   |    3 +-
 fs/sysfs/symlink.c                                 |    3 +-
 fs/xfs/scrub/repair.c                              |   11 +-
 fs/xfs/xfs_aops.c                                  |    2 +
 fs/xfs/xfs_buf.c                                   |   19 +-
 include/{uapi =3D> }/asm-generic/shmparam.h          |    0
 include/drm/drm_dp_helper.h                        |    7 +
 include/drm/drm_dp_mst_helper.h                    |    3 +-
 include/dt-bindings/clock/imx8mq-clock.h           |   26 +-
 include/dt-bindings/clock/marvell,mmp2.h           |    1 -
 .../dt-bindings/reset/amlogic,meson-axg-reset.h    |    3 +-
 include/keys/request_key_auth-type.h               |   36 +
 include/keys/user-type.h                           |    2 +-
 include/kvm/arm_vgic.h                             |    6 +-
 include/linux/acpi.h                               |    7 +
 include/linux/backing-dev-defs.h                   |    1 +
 include/linux/bcma/bcma_soc.h                      |    1 +
 include/linux/blk_types.h                          |    2 +-
 include/linux/blktrace_api.h                       |    8 +-
 include/linux/bpf_verifier.h                       |    1 +
 include/linux/bpfilter.h                           |   15 +-
 include/linux/ceph/libceph.h                       |    6 +-
 include/linux/ceph/osd_client.h                    |    1 -
 include/linux/compiler-clang.h                     |    5 +-
 include/linux/compiler-gcc.h                       |    6 +-
 include/linux/compiler-intel.h                     |    4 +-
 include/linux/compiler.h                           |    4 +-
 include/linux/compiler_attributes.h                |   14 +
 include/linux/cpu.h                                |    2 -
 include/linux/dcache.h                             |    7 +-
 include/linux/dma-mapping.h                        |    9 -
 include/linux/efi.h                                |    7 -
 include/linux/fb.h                                 |    1 +
 include/linux/filter.h                             |   21 +-
 include/linux/fs.h                                 |    9 +-
 include/linux/hid-debug.h                          |    9 +-
 include/linux/hid.h                                |    3 +-
 include/linux/hyperv.h                             |    5 +-
 include/linux/ide.h                                |    2 +
 include/linux/if_arp.h                             |    1 +
 include/linux/interrupt.h                          |    1 +
 include/linux/irqchip/arm-gic-v3.h                 |    2 +-
 include/linux/key-type.h                           |   22 +-
 include/linux/libnvdimm.h                          |    2 +-
 include/linux/memblock.h                           |    3 -
 include/linux/memory_hotplug.h                     |   18 +-
 include/linux/mfd/cros_ec_commands.h               |   94 +
 include/linux/mfd/ingenic-tcu.h                    |    2 +-
 include/linux/mfd/madera/core.h                    |    7 +
 include/linux/mfd/ti_am335x_tscadc.h               |    4 +
 include/linux/mfd/tmio.h                           |    2 +-
 include/linux/mmc/card.h                           |    1 +
 include/linux/mmzone.h                             |    6 +
 include/linux/module.h                             |    6 +-
 include/linux/netdev_features.h                    |   24 +-
 include/linux/netdevice.h                          |    8 +
 include/linux/of.h                                 |    1 -
 include/linux/pci-dma-compat.h                     |    2 +-
 include/linux/perf_event.h                         |    5 +
 include/linux/phy.h                                |   29 +-
 include/linux/phy/phy.h                            |    1 +
 include/linux/pm_opp.h                             |    5 +
 include/linux/pm_runtime.h                         |    2 +-
 include/linux/qcom_scm.h                           |    1 +
 include/linux/qed/qed_chain.h                      |   31 +
 include/linux/reset.h                              |   15 +-
 include/linux/sched.h                              |   11 +-
 include/linux/sched/coredump.h                     |    1 +
 include/linux/sched/wake_q.h                       |    6 +-
 include/linux/signal.h                             |    2 +-
 include/linux/skbuff.h                             |    9 +-
 include/linux/stmmac.h                             |    1 +
 include/linux/umh.h                                |    2 +
 include/linux/virtio_config.h                      |   13 +-
 include/linux/virtio_net.h                         |   19 +
 include/linux/xarray.h                             |  227 +-
 include/net/af_rxrpc.h                             |   16 -
 include/net/ax25.h                                 |   12 +
 include/net/inetpeer.h                             |    1 +
 include/net/ip_fib.h                               |    2 +-
 include/net/l3mdev.h                               |    3 +-
 include/net/netfilter/nf_flow_table.h              |    1 -
 include/net/netfilter/nf_tables.h                  |   17 +-
 include/net/phonet/pep.h                           |    5 +-
 include/net/sock.h                                 |    2 +-
 include/net/tls.h                                  |    2 +
 include/net/xfrm.h                                 |   12 +-
 include/rdma/ib_verbs.h                            |   24 +-
 include/sound/cs35l36.h                            |   43 +
 include/sound/dmaengine_pcm.h                      |    4 -
 include/sound/simple_card_utils.h                  |    4 +-
 include/sound/soc-acpi.h                           |   33 +-
 include/sound/soc-dapm.h                           |   27 +-
 include/sound/soc-topology.h                       |    8 +-
 include/sound/soc.h                                |   73 +-
 include/trace/events/afs.h                         |    2 +
 .../linux/android/{binder_ctl.h =3D> binderfs.h}     |   10 +-
 include/uapi/linux/audit.h                         |    2 +
 include/uapi/linux/blkzoned.h                      |    1 +
 include/uapi/linux/in.h                            |    2 +-
 include/uapi/linux/inet_diag.h                     |   16 +-
 include/uapi/linux/input.h                         |    6 +-
 include/uapi/linux/ptp_clock.h                     |    2 +-
 include/uapi/linux/virtio_config.h                 |    6 +
 include/uapi/linux/virtio_ring.h                   |   10 -
 include/uapi/rdma/hns-abi.h                        |    5 +
 include/uapi/rdma/vmw_pvrdma-abi.h                 |    1 +
 include/xen/arm/page-coherent.h                    |   97 +-
 init/Kconfig                                       |   14 +-
 init/initramfs.c                                   |    6 +-
 init/main.c                                        |    3 +-
 kernel/bpf/btf.c                                   |   17 +-
 kernel/bpf/cgroup.c                                |    3 +-
 kernel/bpf/hashtab.c                               |    4 +-
 kernel/bpf/lpm_trie.c                              |    1 +
 kernel/bpf/map_in_map.c                            |   17 +-
 kernel/bpf/percpu_freelist.c                       |   41 +-
 kernel/bpf/percpu_freelist.h                       |    4 +
 kernel/bpf/stackmap.c                              |   20 +-
 kernel/bpf/syscall.c                               |   12 +-
 kernel/bpf/verifier.c                              |   72 +-
 kernel/cpu.c                                       |   38 +-
 kernel/dma/swiotlb.c                               |    2 +
 kernel/events/core.c                               |   30 +-
 kernel/events/ring_buffer.c                        |    3 +
 kernel/exit.c                                      |   15 +-
 kernel/fork.c                                      |   14 +-
 kernel/futex.c                                     |   45 +-
 kernel/irq/irqdesc.c                               |    2 +-
 kernel/irq/manage.c                                |    3 +
 kernel/locking/rtmutex.c                           |   37 +-
 kernel/locking/rwsem-xadd.c                        |   11 +-
 kernel/relay.c                                     |    4 +-
 kernel/sched/core.c                                |   19 +-
 kernel/sched/fair.c                                |    1 +
 kernel/sched/psi.c                                 |   23 +-
 kernel/seccomp.c                                   |    4 +
 kernel/signal.c                                    |   66 +-
 kernel/smp.c                                       |    2 -
 kernel/sys.c                                       |    3 +-
 kernel/time/posix-cpu-timers.c                     |    1 +
 kernel/trace/bpf_trace.c                           |   14 +-
 kernel/trace/trace.c                               |    2 +
 kernel/trace/trace_kprobe.c                        |   22 +-
 kernel/trace/trace_probe_tmpl.h                    |    6 +-
 kernel/trace/trace_uprobe.c                        |    9 +-
 kernel/umh.c                                       |   33 +-
 kernel/workqueue.c                                 |   23 +
 kernel/workqueue_internal.h                        |    6 +-
 lib/assoc_array.c                                  |    8 +-
 lib/crc32.c                                        |    4 +-
 lib/int_sqrt.c                                     |    2 +-
 lib/sbitmap.c                                      |   13 +-
 lib/test_kmod.c                                    |    2 +-
 lib/test_rhashtable.c                              |   23 +-
 lib/test_xarray.c                                  |   57 +-
 lib/xarray.c                                       |   92 +-
 mm/backing-dev.c                                   |    1 +
 mm/debug.c                                         |    4 +-
 mm/gup.c                                           |    3 +-
 mm/hugetlb.c                                       |   84 +-
 mm/kasan/Makefile                                  |    3 +
 mm/kasan/common.c                                  |   82 +-
 mm/kasan/tags.c                                    |    2 +-
 mm/kmemleak.c                                      |   10 +-
 mm/memblock.c                                      |   11 +-
 mm/memory-failure.c                                |   19 +-
 mm/memory.c                                        |   26 +-
 mm/memory_hotplug.c                                |   85 +-
 mm/mempolicy.c                                     |    6 +-
 mm/migrate.c                                       |   25 +-
 mm/mincore.c                                       |   94 +-
 mm/oom_kill.c                                      |   12 +-
 mm/page_alloc.c                                    |   40 +-
 mm/page_ext.c                                      |    4 +-
 mm/rmap.c                                          |    8 +-
 mm/shmem.c                                         |   10 +-
 mm/slab.c                                          |   21 +-
 mm/slab.h                                          |    7 +-
 mm/slab_common.c                                   |    3 +-
 mm/slub.c                                          |   61 +-
 mm/swap.c                                          |   17 +-
 mm/usercopy.c                                      |    9 +-
 mm/userfaultfd.c                                   |   11 +-
 mm/util.c                                          |    4 +-
 mm/vmscan.c                                        |   10 -
 net/ax25/ax25_ip.c                                 |    4 +-
 net/ax25/ax25_route.c                              |   19 +-
 net/batman-adv/bat_v_elp.c                         |    3 +
 net/batman-adv/hard-interface.c                    |    5 +-
 net/batman-adv/soft-interface.c                    |    4 +
 net/bpf/test_run.c                                 |   45 +-
 net/bpfilter/bpfilter_kern.c                       |   76 +-
 net/bpfilter/bpfilter_umh_blob.S                   |    2 +-
 net/bridge/br_fdb.c                                |    5 +
 net/bridge/br_forward.c                            |   10 +-
 net/bridge/br_multicast.c                          |    9 +-
 net/bridge/br_netfilter_hooks.c                    |    2 +-
 net/bridge/br_netfilter_ipv6.c                     |    1 +
 net/bridge/br_private.h                            |    1 +
 net/bridge/br_vlan.c                               |   26 +-
 net/bridge/netfilter/ebtables.c                    |   15 +-
 net/bridge/netfilter/nft_reject_bridge.c           |    1 +
 net/can/bcm.c                                      |   27 +
 net/can/gw.c                                       |   30 +-
 net/ceph/ceph_common.c                             |   11 +-
 net/ceph/debugfs.c                                 |    2 +-
 net/ceph/messenger.c                               |   20 +-
 net/ceph/osd_client.c                              |    4 +-
 net/compat.c                                       |    6 +-
 net/core/dev.c                                     |    7 +-
 net/core/filter.c                                  |   48 +-
 net/core/lwt_bpf.c                                 |    1 +
 net/core/neighbour.c                               |   15 +-
 net/core/skbuff.c                                  |   11 +-
 net/core/skmsg.c                                   |    3 +-
 net/core/sock.c                                    |    2 +-
 net/dccp/ccid.h                                    |    4 +-
 net/decnet/dn_dev.c                                |    2 +-
 net/dsa/master.c                                   |    4 +
 net/dsa/port.c                                     |    7 +-
 net/dsa/slave.c                                    |   17 +-
 net/ipv4/bpfilter/sockopt.c                        |   58 +-
 net/ipv4/devinet.c                                 |    2 +-
 net/ipv4/esp4.c                                    |    2 +-
 net/ipv4/fib_frontend.c                            |    4 +-
 net/ipv4/fib_trie.c                                |   15 +-
 net/ipv4/fou.c                                     |   12 +-
 net/ipv4/gre_demux.c                               |   17 +
 net/ipv4/inet_diag.c                               |   10 +-
 net/ipv4/inetpeer.c                                |    1 +
 net/ipv4/ip_gre.c                                  |   66 +-
 net/ipv4/ip_input.c                                |    1 +
 net/ipv4/ip_sockglue.c                             |   12 +-
 net/ipv4/ip_tunnel.c                               |    8 +-
 net/ipv4/ip_vti.c                                  |   50 +
 net/ipv4/netfilter/ipt_CLUSTERIP.c                 |    2 +-
 net/ipv4/netfilter/nf_nat_l3proto_ipv4.c           |    1 +
 net/ipv4/netfilter/nf_nat_snmp_basic_main.c        |    7 +-
 net/ipv4/route.c                                   |    7 +-
 net/ipv4/tcp.c                                     |    4 +-
 net/ipv4/tcp_ipv4.c                                |    5 +-
 net/ipv4/tcp_output.c                              |    1 +
 net/ipv4/tcp_timer.c                               |    2 +-
 net/ipv4/udp.c                                     |   24 +-
 net/ipv4/udp_impl.h                                |    1 +
 net/ipv4/udplite.c                                 |    1 +
 net/ipv6/addrconf.c                                |   11 +-
 net/ipv6/af_inet6.c                                |   14 +-
 net/ipv6/datagram.c                                |   11 +-
 net/ipv6/esp6.c                                    |    2 +-
 net/ipv6/fou6.c                                    |   19 +-
 net/ipv6/icmp.c                                    |    8 +-
 net/ipv6/ip6_gre.c                                 |   92 +-
 net/ipv6/ip6mr.c                                   |    7 +-
 net/ipv6/netfilter.c                               |    4 +-
 net/ipv6/netfilter/nf_nat_l3proto_ipv6.c           |    1 +
 net/ipv6/route.c                                   |   46 +-
 net/ipv6/seg6.c                                    |    4 +-
 net/ipv6/seg6_iptunnel.c                           |    2 +
 net/ipv6/sit.c                                     |    3 +-
 net/ipv6/udp.c                                     |   38 +-
 net/ipv6/udp_impl.h                                |    1 +
 net/ipv6/udplite.c                                 |    1 +
 net/ipv6/xfrm6_tunnel.c                            |    2 +-
 net/key/af_key.c                                   |   42 +-
 net/l2tp/l2tp_core.c                               |    9 +-
 net/l2tp/l2tp_core.h                               |   20 +
 net/l2tp/l2tp_ip.c                                 |    3 +
 net/l2tp/l2tp_ip6.c                                |    3 +
 net/mac80211/agg-tx.c                              |    4 +-
 net/mac80211/cfg.c                                 |   10 +-
 net/mac80211/main.c                                |    4 +-
 net/mac80211/mesh.h                                |    6 +
 net/mac80211/mesh_pathtbl.c                        |  157 +-
 net/mac80211/rx.c                                  |   13 +-
 net/mac80211/tx.c                                  |   12 +-
 net/mac80211/util.c                                |    6 +-
 net/netfilter/ipvs/Kconfig                         |    1 +
 net/netfilter/ipvs/ip_vs_core.c                    |   10 +-
 net/netfilter/ipvs/ip_vs_ctl.c                     |   23 +
 net/netfilter/nf_conntrack_core.c                  |   16 +
 net/netfilter/nf_flow_table_core.c                 |    5 +-
 net/netfilter/nf_tables_api.c                      |  102 +-
 net/netfilter/nfnetlink_osf.c                      |    4 +
 net/netfilter/nft_compat.c                         |  180 +-
 net/netfilter/nft_dynset.c                         |   18 +-
 net/netfilter/nft_flow_offload.c                   |   13 +-
 net/netfilter/nft_immediate.c                      |    6 +-
 net/netfilter/nft_lookup.c                         |   18 +-
 net/netfilter/nft_objref.c                         |   18 +-
 net/netfilter/x_tables.c                           |    2 +-
 net/netrom/nr_timer.c                              |   20 +-
 net/openvswitch/flow.c                             |    8 +-
 net/openvswitch/flow_netlink.c                     |    2 +-
 net/packet/af_packet.c                             |    9 +-
 net/phonet/pep.c                                   |   32 +-
 net/rds/bind.c                                     |    6 +-
 net/rds/ib_send.c                                  |    4 +-
 net/rds/message.c                                  |    4 +-
 net/rds/rds.h                                      |    4 -
 net/rds/send.c                                     |    2 +-
 net/rose/rose_route.c                              |    5 +
 net/rxrpc/af_rxrpc.c                               |   70 -
 net/rxrpc/ar-internal.h                            |   19 +-
 net/rxrpc/call_object.c                            |   97 -
 net/rxrpc/conn_client.c                            |    5 +-
 net/rxrpc/recvmsg.c                                |    3 +-
 net/rxrpc/sendmsg.c                                |   24 +-
 net/sched/act_tunnel_key.c                         |   19 +-
 net/sched/cls_api.c                                |    3 +-
 net/sched/cls_flower.c                             |   25 +-
 net/sched/cls_tcindex.c                            |   80 +-
 net/sched/sch_cake.c                               |    5 +-
 net/sched/sch_cbs.c                                |    3 +-
 net/sched/sch_drr.c                                |    7 +-
 net/sched/sch_dsmark.c                             |    3 +-
 net/sched/sch_generic.c                            |    2 +-
 net/sched/sch_hfsc.c                               |    9 +-
 net/sched/sch_htb.c                                |    3 +-
 net/sched/sch_prio.c                               |    3 +-
 net/sched/sch_qfq.c                                |   20 +-
 net/sched/sch_tbf.c                                |    3 +-
 net/sctp/diag.c                                    |    1 +
 net/sctp/ipv6.c                                    |    8 +-
 net/sctp/offload.c                                 |    1 +
 net/sctp/protocol.c                                |    7 +-
 net/sctp/sm_make_chunk.c                           |   11 +-
 net/sctp/socket.c                                  |    4 +-
 net/sctp/stream.c                                  |   82 +-
 net/sctp/transport.c                               |    3 +-
 net/smc/af_smc.c                                   |   15 +-
 net/smc/smc.h                                      |    6 +-
 net/smc/smc_cdc.c                                  |   23 +-
 net/smc/smc_cdc.h                                  |   53 +-
 net/smc/smc_clc.c                                  |    2 +-
 net/smc/smc_close.c                                |    9 +-
 net/smc/smc_core.c                                 |    6 +-
 net/smc/smc_core.h                                 |   20 +
 net/smc/smc_ib.c                                   |    6 +-
 net/smc/smc_llc.c                                  |    3 +-
 net/smc/smc_pnet.c                                 |    2 +-
 net/smc/smc_tx.c                                   |   64 +-
 net/smc/smc_wr.c                                   |   46 +-
 net/smc/smc_wr.h                                   |    1 +
 net/socket.c                                       |   82 +-
 net/sunrpc/auth.c                                  |    3 +
 net/sunrpc/auth_gss/auth_gss.c                     |   12 +-
 net/sunrpc/auth_gss/gss_krb5_seqnum.c              |   49 +-
 net/sunrpc/clnt.c                                  |   20 +-
 net/sunrpc/debugfs.c                               |    2 +-
 net/sunrpc/xprt.c                                  |    3 +-
 net/sunrpc/xprtrdma/svc_rdma_sendto.c              |  105 +-
 net/sunrpc/xprtrdma/svc_rdma_transport.c           |    9 +-
 net/sunrpc/xprtrdma/verbs.c                        |   13 +-
 net/sunrpc/xprtsock.c                              |   22 +
 net/tipc/link.c                                    |   17 +-
 net/tipc/msg.h                                     |   22 +
 net/tipc/netlink_compat.c                          |   54 +-
 net/tipc/node.c                                    |   11 +-
 net/tipc/socket.c                                  |   11 +-
 net/tipc/topsrv.c                                  |    2 +-
 net/tls/tls_sw.c                                   |    6 +-
 net/unix/af_unix.c                                 |   57 +-
 net/unix/diag.c                                    |    3 +-
 net/vmw_vsock/virtio_transport.c                   |   29 +-
 net/vmw_vsock/vmci_transport.c                     |    4 +
 net/wireless/ap.c                                  |    2 +
 net/wireless/core.c                                |    2 +
 net/wireless/core.h                                |    2 +
 net/wireless/nl80211.c                             |    4 +-
 net/wireless/pmsr.c                                |   26 +-
 net/wireless/reg.c                                 |   13 +-
 net/wireless/sme.c                                 |    2 +-
 net/wireless/util.c                                |   35 +-
 net/x25/af_x25.c                                   |   19 +-
 net/xdp/xdp_umem.c                                 |   27 +-
 net/xdp/xsk.c                                      |   20 +-
 net/xfrm/xfrm_interface.c                          |    4 +-
 net/xfrm/xfrm_policy.c                             |   67 +-
 net/xfrm/xfrm_state.c                              |   30 +-
 net/xfrm/xfrm_user.c                               |   15 +-
 samples/bpf/Makefile                               |    1 +
 samples/bpf/asm_goto_workaround.h                  |   16 +
 samples/bpf/test_cgrp2_attach2.c                   |   14 +-
 samples/bpf/test_current_task_under_cgroup_user.c  |    2 +-
 samples/bpf/xdp1_user.c                            |    2 +-
 samples/mei/mei-amt-version.c                      |    2 +-
 samples/seccomp/Makefile                           |    1 +
 scripts/Kbuild.include                             |    4 -
 scripts/coccinelle/api/alloc/alloc_cast.cocci      |    8 +-
 scripts/coccinelle/api/alloc/zalloc-simple.cocci   |   11 +-
 scripts/gcc-plugins/arm_ssp_per_task_plugin.c      |   23 +-
 scripts/kallsyms.c                                 |    4 +-
 scripts/kconfig/Makefile                           |    2 +-
 scripts/mod/modpost.c                              |    2 +-
 security/apparmor/domain.c                         |    5 +-
 security/apparmor/lsm.c                            |    2 +
 security/keys/internal.h                           |   13 +-
 security/keys/key.c                                |    5 +-
 security/keys/keyctl.c                             |    1 +
 security/keys/keyring.c                            |    4 +-
 security/keys/proc.c                               |    3 +-
 security/keys/process_keys.c                       |    1 +
 security/keys/request_key.c                        |   73 +-
 security/keys/request_key_auth.c                   |   18 +-
 security/lsm_audit.c                               |   10 +-
 security/security.c                                |    7 +
 security/selinux/ss/policydb.c                     |    3 +-
 security/yama/yama_lsm.c                           |    4 +-
 sound/aoa/soundbus/i2sbus/core.c                   |    4 +-
 sound/pci/hda/patch_realtek.c                      |   42 +-
 sound/soc/Kconfig                                  |    1 +
 sound/soc/Makefile                                 |    1 +
 sound/soc/codecs/Kconfig                           |   67 +-
 sound/soc/codecs/Makefile                          |   14 +
 sound/soc/codecs/ad193x.c                          |   76 +-
 sound/soc/codecs/ad193x.h                          |    8 +
 sound/soc/codecs/adau1977.c                        |   12 +-
 sound/soc/codecs/adau7002.c                        |   45 +
 sound/soc/codecs/ak4118.c                          |    1 +
 sound/soc/codecs/ak4458.c                          |   79 +-
 sound/soc/codecs/cros_ec_codec.c                   |  441 ++
 sound/soc/codecs/cs35l36.c                         | 1957 ++++++++
 sound/soc/codecs/cs35l36.h                         |  446 ++
 sound/soc/codecs/cs4271.c                          |    4 +-
 sound/soc/codecs/cs4341.c                          |  346 ++
 sound/soc/codecs/cs47l24.c                         |   52 +-
 sound/soc/codecs/da7219-aad.c                      |    2 +-
 sound/soc/codecs/da7219.c                          |  197 +-
 sound/soc/codecs/da7219.h                          |    2 +
 sound/soc/codecs/dmic.c                            |    4 +-
 sound/soc/codecs/es8316.c                          |  200 +-
 sound/soc/codecs/es8316.h                          |    7 +
 sound/soc/codecs/hdac_hdmi.c                       |   87 +-
 sound/soc/codecs/jz4725b.c                         |  598 +++
 sound/soc/codecs/jz4740.c                          |   26 +-
 sound/soc/codecs/max98090.c                        |   15 -
 sound/soc/codecs/max98373.c                        |    6 +-
 sound/soc/codecs/max9860.c                         |    3 +-
 sound/soc/codecs/max98927.c                        |    8 +-
 sound/soc/codecs/msm8916-wcd-analog.c              |    3 +
 sound/soc/codecs/msm8916-wcd-digital.c             |   23 +-
 sound/soc/codecs/mt6351.c                          |    4 +-
 sound/soc/codecs/mt6358.c                          | 2336 +++++++++
 sound/soc/codecs/mt6358.h                          | 2314 +++++++++
 sound/soc/codecs/nau8824.c                         |    2 +-
 sound/soc/codecs/nau8825.c                         |    1 +
 sound/soc/codecs/pcm186x.c                         |    8 +-
 sound/soc/codecs/pcm3060.c                         |   35 +
 sound/soc/codecs/pcm3060.h                         |    5 +
 sound/soc/codecs/pcm512x.c                         |   37 +-
 sound/soc/codecs/rk3328_codec.c                    |  519 ++
 sound/soc/codecs/rk3328_codec.h                    |  210 +
 sound/soc/codecs/rl6347a.c                         |    4 +-
 sound/soc/codecs/rt274.c                           |   19 +-
 sound/soc/codecs/rt286.c                           |    8 +-
 sound/soc/codecs/rt298.c                           |   12 +-
 sound/soc/codecs/rt5514.c                          |    1 +
 sound/soc/codecs/rt5640.c                          |    6 +-
 sound/soc/codecs/rt5645.c                          |   66 +-
 sound/soc/codecs/rt5651.c                          |   67 +-
 sound/soc/codecs/rt5651.h                          |    1 +
 sound/soc/codecs/rt5670.c                          |   54 -
 sound/soc/codecs/rt5677.c                          |    8 +-
 sound/soc/codecs/rt5682.c                          |    8 +
 sound/soc/codecs/sgtl5000.c                        |   19 +-
 sound/soc/codecs/ssm2602.c                         |   71 +-
 sound/soc/codecs/tlv320aic31xx.c                   |   16 +-
 sound/soc/codecs/tlv320aic32x4.c                   |   31 +-
 sound/soc/codecs/tlv320aic32x4.h                   |    1 +
 sound/soc/codecs/tlv320aic3x.c                     |   25 +-
 sound/soc/codecs/tscs42xx.c                        |    2 +-
 sound/soc/codecs/wcd-clsh-v2.c                     |  576 +++
 sound/soc/codecs/wcd-clsh-v2.h                     |   49 +
 sound/soc/codecs/wcd9335.c                         | 5244 ++++++++++++++++=
++++
 sound/soc/codecs/wcd9335.h                         |  640 +++
 sound/soc/codecs/wm5102.c                          |   64 +-
 sound/soc/codecs/wm5110.c                          |   80 +-
 sound/soc/codecs/wm8741.c                          |   22 +-
 sound/soc/codecs/wm8770.c                          |   18 +-
 sound/soc/codecs/wm8904.c                          |   21 +-
 sound/soc/codecs/wm8962.c                          |    9 +-
 sound/soc/codecs/wm8995.c                          |   29 +-
 sound/soc/codecs/wm8996.c                          |    9 +-
 sound/soc/codecs/wm8997.c                          |   60 +-
 sound/soc/codecs/wm8998.c                          |   60 +-
 sound/soc/codecs/wm_adsp.c                         |  498 +-
 sound/soc/codecs/wm_adsp.h                         |    4 +-
 sound/soc/fsl/Kconfig                              |    9 +
 sound/soc/fsl/Makefile                             |    2 +
 sound/soc/fsl/fsl-asoc-card.c                      |    1 +
 sound/soc/fsl/fsl_esai.c                           |    7 +-
 sound/soc/fsl/fsl_micfil.c                         |  826 +++
 sound/soc/fsl/fsl_micfil.h                         |  283 ++
 sound/soc/fsl/fsl_sai.c                            |    8 +-
 sound/soc/fsl/fsl_spdif.c                          |   12 +-
 sound/soc/fsl/fsl_spdif.h                          |    2 +-
 sound/soc/fsl/fsl_ssi.c                            |    6 +-
 sound/soc/fsl/imx-sgtl5000.c                       |   12 +-
 sound/soc/fsl/imx-spdif.c                          |    4 +-
 sound/soc/generic/Kconfig                          |   17 -
 sound/soc/generic/Makefile                         |    4 -
 sound/soc/generic/audio-graph-card.c               |  481 +-
 sound/soc/generic/audio-graph-scu-card.c           |  501 --
 sound/soc/generic/simple-card-utils.c              |   25 +-
 sound/soc/generic/simple-card.c                    |  479 +-
 sound/soc/generic/simple-scu-card.c                |  474 --
 sound/soc/intel/atom/sst-atom-controls.c           |    2 +-
 sound/soc/intel/atom/sst-mfld-platform-pcm.c       |    2 +-
 sound/soc/intel/atom/sst/sst_acpi.c                |   45 +-
 sound/soc/intel/atom/sst/sst_drv_interface.c       |    2 +-
 sound/soc/intel/atom/sst/sst_loader.c              |    2 +-
 sound/soc/intel/baytrail/sst-baytrail-ipc.c        |    3 +-
 sound/soc/intel/baytrail/sst-baytrail-pcm.c        |    2 +-
 sound/soc/intel/boards/Kconfig                     |    1 +
 sound/soc/intel/boards/bdw-rt5677.c                |   14 +
 sound/soc/intel/boards/broadwell.c                 |   16 +
 sound/soc/intel/boards/bxt_da7219_max98357a.c      |  114 +-
 sound/soc/intel/boards/bxt_rt298.c                 |   13 +
 sound/soc/intel/boards/bytcht_da7213.c             |    8 +
 sound/soc/intel/boards/bytcht_es8316.c             |  336 +-
 sound/soc/intel/boards/bytcr_rt5640.c              |   23 +-
 sound/soc/intel/boards/bytcr_rt5651.c              |  180 +-
 sound/soc/intel/boards/cht_bsw_max98090_ti.c       |   12 +
 sound/soc/intel/boards/cht_bsw_nau8824.c           |   12 +
 sound/soc/intel/boards/cht_bsw_rt5645.c            |    9 +
 sound/soc/intel/boards/cht_bsw_rt5672.c            |   30 +-
 sound/soc/intel/boards/glk_rt5682_max98357a.c      |   23 +-
 sound/soc/intel/boards/haswell.c                   |   15 +
 sound/soc/intel/boards/kbl_da7219_max98927.c       |  207 +-
 sound/soc/intel/common/soc-acpi-intel-bxt-match.c  |   25 +-
 sound/soc/intel/common/soc-acpi-intel-byt-match.c  |   92 +-
 sound/soc/intel/common/soc-acpi-intel-cht-match.c  |   70 +-
 sound/soc/intel/common/soc-acpi-intel-cnl-match.c  |    5 +-
 sound/soc/intel/common/soc-acpi-intel-glk-match.c  |   10 +-
 sound/soc/intel/common/soc-acpi-intel-hda-match.c  |    2 +-
 .../intel/common/soc-acpi-intel-hsw-bdw-match.c    |   20 +-
 sound/soc/intel/common/soc-acpi-intel-icl-match.c  |    5 +-
 sound/soc/intel/common/soc-acpi-intel-kbl-match.c  |   19 +
 sound/soc/intel/haswell/sst-haswell-ipc.c          |    2 +-
 sound/soc/intel/haswell/sst-haswell-pcm.c          |    4 +-
 sound/soc/intel/skylake/skl-messages.c             |    2 +-
 sound/soc/intel/skylake/skl-pcm.c                  |    3 +-
 sound/soc/intel/skylake/skl-topology.c             |    2 +-
 sound/soc/mediatek/Kconfig                         |   19 +
 sound/soc/mediatek/Makefile                        |    1 +
 sound/soc/mediatek/common/Makefile                 |    2 +
 sound/soc/mediatek/common/mtk-btcvsd.c             | 1364 +++++
 sound/soc/mediatek/mt8183/Makefile                 |   13 +
 sound/soc/mediatek/mt8183/mt8183-afe-clk.c         |  611 +++
 sound/soc/mediatek/mt8183/mt8183-afe-clk.h         |   38 +
 sound/soc/mediatek/mt8183/mt8183-afe-common.h      |  108 +
 sound/soc/mediatek/mt8183/mt8183-afe-pcm.c         | 1237 +++++
 sound/soc/mediatek/mt8183/mt8183-dai-adda.c        |  501 ++
 sound/soc/mediatek/mt8183/mt8183-dai-hostless.c    |  118 +
 sound/soc/mediatek/mt8183/mt8183-dai-i2s.c         | 1040 ++++
 sound/soc/mediatek/mt8183/mt8183-dai-pcm.c         |  318 ++
 sound/soc/mediatek/mt8183/mt8183-dai-tdm.c         |  639 +++
 sound/soc/mediatek/mt8183/mt8183-interconnection.h |   33 +
 sound/soc/mediatek/mt8183/mt8183-reg.h             | 1666 +++++++
 sound/soc/pxa/Makefile                             |    1 -
 sound/soc/qcom/Kconfig                             |    4 +-
 sound/soc/qcom/apq8016_sbc.c                       |   21 +-
 sound/soc/qcom/apq8096.c                           |   71 +-
 sound/soc/qcom/common.c                            |   10 +-
 sound/soc/qcom/sdm845.c                            |    2 +
 sound/soc/samsung/dma.h                            |    3 +-
 sound/soc/samsung/dmaengine.c                      |   16 +-
 sound/soc/samsung/i2s.c                            |  725 +--
 sound/soc/samsung/odroid.c                         |  206 +-
 sound/soc/samsung/pcm.c                            |    2 +-
 sound/soc/samsung/s3c2412-i2s.c                    |    2 +-
 sound/soc/samsung/s3c24xx-i2s.c                    |    2 +-
 sound/soc/samsung/spdif.c                          |    2 +-
 sound/soc/sh/fsi.c                                 |    2 +-
 sound/soc/sh/rcar/core.c                           |   40 +-
 sound/soc/sh/rcar/gen.c                            |   24 +
 sound/soc/sh/rcar/rsnd.h                           |   27 +
 sound/soc/sh/rcar/src.c                            |  125 +-
 sound/soc/sh/rcar/ssiu.c                           |   24 +-
 sound/soc/soc-compress.c                           |  177 +-
 sound/soc/soc-core.c                               |  262 +-
 sound/soc/soc-dapm.c                               |  271 +-
 sound/soc/soc-generic-dmaengine-pcm.c              |   13 +-
 sound/soc/soc-pcm.c                                |    4 +
 sound/soc/soc-topology.c                           |  174 +-
 sound/soc/sprd/Kconfig                             |    6 +
 sound/soc/sprd/Makefile                            |    4 +
 sound/soc/sprd/sprd-pcm-dma.c                      |  562 +++
 sound/soc/sprd/sprd-pcm-dma.h                      |   15 +
 sound/soc/stm/stm32_i2s.c                          |  136 +-
 sound/soc/stm/stm32_sai.c                          |   11 +-
 sound/soc/stm/stm32_sai_sub.c                      |    8 +-
 sound/soc/sunxi/sun4i-codec.c                      |  149 +-
 sound/soc/sunxi/sun50i-codec-analog.c              |    4 +-
 sound/soc/ti/davinci-mcasp.c                       |  175 +-
 sound/soc/xilinx/Kconfig                           |   14 +
 sound/soc/xilinx/Makefile                          |    4 +
 sound/soc/xilinx/xlnx_formatter_pcm.c              |  708 +++
 sound/soc/xilinx/xlnx_spdif.c                      |  339 ++
 sound/sparc/dbri.c                                 |    4 +-
 tools/arch/powerpc/include/uapi/asm/perf_regs.h    |    1 +
 tools/arch/powerpc/include/uapi/asm/unistd.h       |  404 --
 tools/arch/riscv/include/uapi/asm/bitsperlong.h    |   25 +
 tools/arch/x86/include/asm/cpufeatures.h           |    2 +
 tools/arch/x86/include/asm/disabled-features.h     |    8 +-
 tools/bpf/bpftool/Makefile                         |    9 +-
 tools/bpf/bpftool/btf_dumper.c                     |   13 +-
 tools/bpf/bpftool/common.c                         |    6 +-
 tools/bpf/bpftool/json_writer.c                    |    7 +-
 tools/bpf/bpftool/json_writer.h                    |    5 -
 tools/bpf/bpftool/map.c                            |   33 +-
 tools/bpf/bpftool/prog.c                           |    5 +-
 tools/iio/iio_generic_buffer.c                     |    2 +-
 tools/include/uapi/asm-generic/unistd.h            |    4 +-
 tools/include/uapi/asm/bitsperlong.h               |    4 +
 tools/include/uapi/drm/i915_drm.h                  |    8 +
 tools/include/uapi/linux/fs.h                      |   60 +-
 tools/include/uapi/linux/if_link.h                 |   19 +
 tools/include/uapi/linux/in.h                      |   10 +-
 tools/include/uapi/linux/kvm.h                     |   19 +
 tools/include/uapi/linux/mount.h                   |   58 +
 tools/include/uapi/linux/pkt_sched.h               | 1163 +++++
 tools/include/uapi/linux/prctl.h                   |    8 +
 tools/include/uapi/linux/vhost.h                   |  113 +-
 tools/lib/bpf/.gitignore                           |    1 +
 tools/lib/bpf/README.rst                           |   14 +
 tools/lib/bpf/bpf.c                                |   19 +-
 tools/lib/traceevent/event-parse-api.c             |    4 +-
 tools/lib/traceevent/event-parse-local.h           |    4 +-
 tools/lib/traceevent/event-parse.c                 |  129 +-
 tools/lib/traceevent/event-parse.h                 |   17 +-
 tools/lib/traceevent/plugin_kvm.c                  |    2 +-
 tools/lib/traceevent/trace-seq.c                   |   17 +-
 tools/perf/Documentation/perf-c2c.txt              |   16 +-
 tools/perf/Documentation/perf-mem.txt              |    2 +-
 tools/perf/Makefile.perf                           |    8 +-
 tools/perf/arch/arm/tests/Build                    |    1 +
 tools/perf/arch/arm/tests/arch-tests.c             |    4 +
 tools/perf/arch/arm/tests/vectors-page.c           |   24 +
 tools/perf/arch/powerpc/Makefile                   |   15 +-
 .../perf/arch/powerpc/entry/syscalls/mksyscalltbl  |   22 +-
 tools/perf/arch/powerpc/entry/syscalls/syscall.tbl |  427 ++
 tools/perf/arch/powerpc/include/perf_regs.h        |    3 +-
 tools/perf/arch/powerpc/util/Build                 |    1 +
 tools/perf/arch/powerpc/util/mem-events.c          |   11 +
 tools/perf/arch/powerpc/util/perf_regs.c           |    1 +
 tools/perf/builtin-script.c                        |    9 +-
 tools/perf/builtin-stat.c                          |    3 +-
 tools/perf/builtin-top.c                           |    7 +-
 tools/perf/builtin-trace.c                         |   40 +-
 tools/perf/check-headers.sh                        |    2 +-
 tools/perf/perf-read-vdso.c                        |    6 +-
 tools/perf/tests/attr.py                           |   32 +-
 tools/perf/tests/evsel-tp-sched.c                  |    2 +-
 tools/perf/tests/shell/lib/probe_vfs_getname.sh    |    3 +-
 tools/perf/tests/tests.h                           |    5 +
 tools/perf/trace/beauty/mount_flags.sh             |    4 +-
 tools/perf/trace/beauty/prctl_option.sh            |    2 +-
 tools/perf/ui/browsers/annotate.c                  |   16 +-
 tools/perf/util/annotate.c                         |    8 +-
 tools/perf/util/c++/clang.cpp                      |    2 +-
 tools/perf/util/callchain.c                        |   32 +-
 tools/perf/util/callchain.h                        |    1 +
 tools/perf/util/cpumap.c                           |   11 +-
 tools/perf/util/{find-vdso-map.c =3D> find-map.c}    |    7 +-
 tools/perf/util/machine.c                          |    2 +-
 tools/perf/util/mem-events.c                       |    2 +-
 tools/perf/util/ordered-events.c                   |    6 +-
 tools/perf/util/setup.py                           |    2 +
 tools/perf/util/strbuf.c                           |    1 -
 tools/perf/util/symbol-elf.c                       |   23 +-
 tools/perf/util/symbol.c                           |    1 +
 tools/perf/util/vdso.c                             |    6 +-
 tools/testing/nvdimm/dimm_devs.c                   |    4 +-
 tools/testing/selftests/Makefile                   |    1 +
 tools/testing/selftests/bpf/.gitignore             |    1 +
 tools/testing/selftests/bpf/Makefile               |    5 +-
 tools/testing/selftests/bpf/bpf_util.h             |   30 +-
 tools/testing/selftests/bpf/cgroup_helpers.c       |    6 +-
 tools/testing/selftests/bpf/test_btf.c             |   38 +-
 tools/testing/selftests/bpf/test_cgroup_storage.c  |    2 +-
 tools/testing/selftests/bpf/test_dev_cgroup.c      |    2 +-
 tools/testing/selftests/bpf/test_lpm_map.c         |   10 +
 tools/testing/selftests/bpf/test_netcnt.c          |    2 +-
 tools/testing/selftests/bpf/test_progs.c           |   30 +
 .../selftests/bpf/test_skb_cgroup_id_user.c        |    2 +-
 tools/testing/selftests/bpf/test_sock.c            |    2 +-
 tools/testing/selftests/bpf/test_sock_addr.c       |   55 +-
 tools/testing/selftests/bpf/test_socket_cookie.c   |    2 +-
 tools/testing/selftests/bpf/test_tcpbpf_user.c     |    2 +-
 tools/testing/selftests/bpf/test_tcpnotify_user.c  |    2 +-
 tools/testing/selftests/bpf/test_verifier.c        |  120 +
 .../selftests/cpu-hotplug/cpu-on-off-test.sh       |   13 +-
 .../selftests/drivers/net/mlxsw/rtnetlink.sh       |   20 +
 tools/testing/selftests/drivers/net/mlxsw/vxlan.sh |   18 +
 .../selftests/filesystems/binderfs/.gitignore      |    1 +
 .../selftests/filesystems/binderfs/Makefile        |    6 +
 .../selftests/filesystems/binderfs/binderfs_test.c |  275 +
 .../testing/selftests/filesystems/binderfs/config  |    3 +
 tools/testing/selftests/gpio/gpio-mockup-chardev.c |    9 +-
 tools/testing/selftests/ir/Makefile                |    2 +
 tools/testing/selftests/kvm/lib/kvm_util.c         |    9 +-
 tools/testing/selftests/kvm/x86_64/evmcs_test.c    |    6 +
 tools/testing/selftests/net/Makefile               |    2 +-
 tools/testing/selftests/net/fib_tests.sh           |    1 +
 .../selftests/net/forwarding/bridge_vlan_aware.sh  |   47 +-
 .../selftests/net/forwarding/vxlan_bridge_1d.sh    |    2 +-
 tools/testing/selftests/net/ip_defrag.c            |   96 +-
 tools/testing/selftests/net/ip_defrag.sh           |    9 +-
 tools/testing/selftests/net/xfrm_policy.sh         |  153 +-
 tools/testing/selftests/netfilter/Makefile         |    2 +-
 tools/testing/selftests/netfilter/config           |    2 +-
 tools/testing/selftests/netfilter/nft_nat.sh       |  762 +++
 .../selftests/networking/timestamping/Makefile     |    3 -
 .../networking/timestamping/txtimestamp.c          |    2 +-
 tools/testing/selftests/proc/.gitignore            |    1 +
 tools/testing/selftests/proc/Makefile              |    1 +
 tools/testing/selftests/proc/setns-dcache.c        |  129 +
 tools/testing/selftests/rtc/rtctest.c              |  109 +-
 tools/testing/selftests/seccomp/Makefile           |    2 +-
 tools/testing/selftests/seccomp/seccomp_bpf.c      |   82 +-
 .../selftests/tc-testing/tc-tests/actions/ife.json |   88 +-
 .../tc-testing/tc-tests/actions/tunnel_key.json    |   31 +-
 tools/testing/selftests/timers/Makefile            |    2 +-
 tools/testing/selftests/vm/gup_benchmark.c         |    1 +
 tools/testing/selftests/x86/mpx-mini-test.c        |    2 +-
 tools/testing/selftests/x86/protection_keys.c      |   41 +-
 tools/testing/selftests/x86/unwind_vdso.c          |    1 -
 tools/thermal/tmon/Makefile                        |    2 +-
 tools/vm/page_owner_sort.c                         |    4 +-
 virt/kvm/arm/arm.c                                 |   10 +
 virt/kvm/arm/mmu.c                                 |    9 +-
 virt/kvm/arm/psci.c                                |   36 +-
 virt/kvm/arm/vgic/vgic-debug.c                     |    4 +-
 virt/kvm/arm/vgic/vgic-init.c                      |   30 +-
 virt/kvm/arm/vgic/vgic-its.c                       |   22 +-
 virt/kvm/arm/vgic/vgic-mmio-v2.c                   |   14 +-
 virt/kvm/arm/vgic/vgic-mmio-v3.c                   |   12 +-
 virt/kvm/arm/vgic/vgic-mmio.c                      |   34 +-
 virt/kvm/arm/vgic/vgic-v2.c                        |    4 +-
 virt/kvm/arm/vgic/vgic-v3.c                        |    8 +-
 virt/kvm/arm/vgic/vgic.c                           |  118 +-
 virt/kvm/kvm_main.c                                |   12 +-
 2137 files changed, 52369 insertions(+), 14309 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/audio-graph-scu=
-card.txt
 create mode 100644 Documentation/devicetree/bindings/sound/cs35l36.txt
 create mode 100644 Documentation/devicetree/bindings/sound/cs4341.txt
 create mode 100644 Documentation/devicetree/bindings/sound/fsl,micfil.txt
 create mode 100644 Documentation/devicetree/bindings/sound/google,cros-ec-=
codec.txt
 create mode 100644 Documentation/devicetree/bindings/sound/ingenic,jz4725b=
-codec.txt
 create mode 100644 Documentation/devicetree/bindings/sound/ingenic,jz4740-=
codec.txt
 create mode 100644 Documentation/devicetree/bindings/sound/mt6358.txt
 create mode 100644 Documentation/devicetree/bindings/sound/mt8183-afe-pcm.=
txt
 create mode 100644 Documentation/devicetree/bindings/sound/mtk-btcvsd-snd.=
txt
 create mode 100644 Documentation/devicetree/bindings/sound/rockchip,rk3328=
-codec.txt
 delete mode 100644 Documentation/devicetree/bindings/sound/simple-scu-card=
=2Etxt
 create mode 100644 Documentation/devicetree/bindings/sound/sprd-pcm.txt
 create mode 100644 Documentation/devicetree/bindings/sound/xlnx,audio-form=
atter.txt
 create mode 100644 Documentation/devicetree/bindings/sound/xlnx,spdif.txt
 create mode 100644 arch/arm/mach-tango/pm.h
 create mode 100644 drivers/reset/reset-socfpga.c
 rename drivers/reset/{reset-uniphier-usb3.c =3D> reset-uniphier-glue.c} (7=
3%)
 create mode 100644 drivers/tty/serial/earlycon-riscv-sbi.c
 delete mode 100644 drivers/usb/usbip/README
 rename include/{uapi =3D> }/asm-generic/shmparam.h (100%)
 create mode 100644 include/keys/request_key_auth-type.h
 create mode 100644 include/sound/cs35l36.h
 rename include/uapi/linux/android/{binder_ctl.h =3D> binderfs.h} (83%)
 create mode 100644 samples/bpf/asm_goto_workaround.h
 create mode 100644 sound/soc/codecs/cros_ec_codec.c
 create mode 100644 sound/soc/codecs/cs35l36.c
 create mode 100644 sound/soc/codecs/cs35l36.h
 create mode 100644 sound/soc/codecs/cs4341.c
 create mode 100644 sound/soc/codecs/jz4725b.c
 create mode 100644 sound/soc/codecs/mt6358.c
 create mode 100644 sound/soc/codecs/mt6358.h
 create mode 100644 sound/soc/codecs/rk3328_codec.c
 create mode 100644 sound/soc/codecs/rk3328_codec.h
 create mode 100644 sound/soc/codecs/wcd-clsh-v2.c
 create mode 100644 sound/soc/codecs/wcd-clsh-v2.h
 create mode 100644 sound/soc/codecs/wcd9335.c
 create mode 100644 sound/soc/codecs/wcd9335.h
 create mode 100644 sound/soc/fsl/fsl_micfil.c
 create mode 100644 sound/soc/fsl/fsl_micfil.h
 delete mode 100644 sound/soc/generic/audio-graph-scu-card.c
 delete mode 100644 sound/soc/generic/simple-scu-card.c
 create mode 100644 sound/soc/mediatek/common/mtk-btcvsd.c
 create mode 100644 sound/soc/mediatek/mt8183/Makefile
 create mode 100644 sound/soc/mediatek/mt8183/mt8183-afe-clk.c
 create mode 100644 sound/soc/mediatek/mt8183/mt8183-afe-clk.h
 create mode 100644 sound/soc/mediatek/mt8183/mt8183-afe-common.h
 create mode 100644 sound/soc/mediatek/mt8183/mt8183-afe-pcm.c
 create mode 100644 sound/soc/mediatek/mt8183/mt8183-dai-adda.c
 create mode 100644 sound/soc/mediatek/mt8183/mt8183-dai-hostless.c
 create mode 100644 sound/soc/mediatek/mt8183/mt8183-dai-i2s.c
 create mode 100644 sound/soc/mediatek/mt8183/mt8183-dai-pcm.c
 create mode 100644 sound/soc/mediatek/mt8183/mt8183-dai-tdm.c
 create mode 100644 sound/soc/mediatek/mt8183/mt8183-interconnection.h
 create mode 100644 sound/soc/mediatek/mt8183/mt8183-reg.h
 create mode 100644 sound/soc/sprd/Kconfig
 create mode 100644 sound/soc/sprd/Makefile
 create mode 100644 sound/soc/sprd/sprd-pcm-dma.c
 create mode 100644 sound/soc/sprd/sprd-pcm-dma.h
 create mode 100644 sound/soc/xilinx/xlnx_formatter_pcm.c
 create mode 100644 sound/soc/xilinx/xlnx_spdif.c
 delete mode 100644 tools/arch/powerpc/include/uapi/asm/unistd.h
 create mode 100644 tools/arch/riscv/include/uapi/asm/bitsperlong.h
 create mode 100644 tools/include/uapi/linux/mount.h
 create mode 100644 tools/include/uapi/linux/pkt_sched.h
 create mode 100644 tools/perf/arch/arm/tests/vectors-page.c
 create mode 100644 tools/perf/arch/powerpc/entry/syscalls/syscall.tbl
 create mode 100644 tools/perf/arch/powerpc/util/mem-events.c
 rename tools/perf/util/{find-vdso-map.c =3D> find-map.c} (71%)
 create mode 100644 tools/testing/selftests/filesystems/binderfs/.gitignore
 create mode 100644 tools/testing/selftests/filesystems/binderfs/Makefile
 create mode 100644 tools/testing/selftests/filesystems/binderfs/binderfs_t=
est.c
 create mode 100644 tools/testing/selftests/filesystems/binderfs/config
 create mode 100755 tools/testing/selftests/netfilter/nft_nat.sh
 create mode 100644 tools/testing/selftests/proc/setns-dcache.c

--Y7xTucakfITjPcLV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlx30zIACgkQJNaLcl1U
h9CYlgf+O27AehQyI01YHhUuQeZw97pnhkmy9UdqKOTtd3vFbs7HajYjdpg49vZD
7Bh5FfcIOTHh5yFV6ICTTmciJj0A5HrWxhVHsAvLH//AUqe8ROtUjqwGyjix7MeC
jkTBPwd654hU2ZsAdh68ggCMLOU8gF7K7QLVtsUxQJv2FmWFuibBdQaWmgwtp2Zq
+w39H70LZZppm9h78Wo4J0pPkQ6qLynOGPhMClzjSHWUteIhgfi+CzCKOkOrhG5X
N6iBRdxKxqAoUvXxdlQxKZVpSfBjaa1bTpy87qqVgENQKTJgI0pTWnB95NOKwoSN
B5hq3JCWFOJZkbnRBGshsgF07sTcvQ==
=31Jz
-----END PGP SIGNATURE-----

--Y7xTucakfITjPcLV--

--===============1770474234393986745==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1770474234393986745==--
