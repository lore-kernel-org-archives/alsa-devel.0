From: Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] ASoC updates for v4.7
Date: Mon, 16 May 2016 12:11:42 +0100
Message-ID: <20160516111142.GG2953@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8404745490696553811=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 67E422619BE
 for <alsa-devel@alsa-project.org>; Mon, 16 May 2016 13:11:59 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiawi@suse.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============8404745490696553811==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="vA66WO2vHvL/CRSR"
Content-Disposition: inline


--vA66WO2vHvL/CRSR
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The following changes since commit af9cc93c0dee5fc1f9fa32cd9d79a456738a21be:

  Merge tag 'asoc-fix-v4.6-rc5' of git://git.kernel.org/pub/scm/linux/kerne=
l/git/broonie/sound into for-linus (2016-04-27 17:30:49 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc=
-v4.7

for you to fetch changes up to 515511a7920c69aebf7f5fef0cb8e1df6767f34c:

  Merge remote-tracking branch 'asoc/topic/hdmi' into asoc-next (2016-05-13=
 14:27:16 +0100)

The diffstat looks terrible because it picks up a couple of -rcs from
Linus as well as the actual new changes.

----------------------------------------------------------------
ASoC: Updates for v4.7

The updates this time around are almost all driver code:

 - Further slow progress on the topology code.
 - Substantial updates and improvements for the da7219, es8328, fsl-ssi
   Intel and rcar drivers.

----------------------------------------------------------------
Adam Borowski (1):
      perf/x86/amd: Set the size of event map array to PERF_COUNT_HW_MAX

Adam Thomson (9):
      ASoC: da7219: Update PLL ranges and dividers to improve locking
      ASoC: da7219: Disallow unsupported 32KHz clock setting in set_dai_sys=
clk()
      ASoC: da7218: Update PLL ranges and dividers to improve locking
      ASoC: da7219: Add initial ACPI id for device
      ASoC: da7213: Add DAI DAPM event to control DAI clocks
      ASoC: da7213: Add checking of SRM lock status before enabling DAI
      ASoC: da7213: Default PC counter to free-running when DAI disabled
      ASoC: da7213: Update PLL ranges to improve locking at frequency bound=
ary
      ASoC: da7213: Allow PLL disable/bypass when using 32KHz sysclk

Adrian Hunter (1):
      mmc: sdhci-acpi: Reduce Baytrail eMMC/SD/SDIO hangs

Alex Deucher (4):
      Revert "drm/amdgpu: disable runtime pm on PX laptops without dGPU pow=
er control"
      drm/amdgpu: print a message if ATPX dGPU power control is missing
      drm/radeon: make sure vertical front porch is at least 1
      drm/amdgpu: make sure vertical front porch is at least 1

Alex Thorlton (1):
      x86/platform/UV: Bring back the call to map_low_mmrs in uv_system_init

Alexander Duyck (2):
      net: Disable segmentation if checksumming is not supported
      vxlan: Add checksum check to the features check function

Alexander Kurz (1):
      ARM: mach-imx: sdhci-esdhc-imx: initialize DMA mask

Alexander Potapenko (1):
      lib/stackdepot.c: allow the stack trace hash to be zero

Alexander Shishkin (1):
      perf/x86/intel/pt: Don't die on VMXON

Alexandre Bounine (1):
      rapidio/mport_cdev: fix uapi type definitions

Alexei Starovoitov (3):
      bpf: fix refcnt overflow
      bpf: fix check_map_func_compatibility logic
      samples/bpf: fix trace_output example

Alexey Brodkin (2):
      ARC: support generic per-device coherent dma mem
      ARC: add support for reserved memory defined by device tree

Ananth N Mavinakayanahalli (1):
      Ananth has moved

Andi Kleen (2):
      perf/x86/intel: Add model number for Skylake Server to perf
      perf/x86: Add model numbers for Kabylake CPUs

Andrea Arcangeli (1):
      mm: thp: kvm: fix memory corruption in KVM with THP enabled

Andreas Larsson (1):
      MAINTAINERS: net: Change maintainer for GRETH 10/100/1G Ethernet MAC =
device driver

Andrew Gabbasov (1):
      udf: Fix conversion of 'dstring' fields to UTF8

Andrey Ryabinin (1):
      kcov: don't profile branches in kcov

Andy Gross (2):
      Revert "dts: msm8974: Add blsp2_bam dma node"
      Revert "dts: msm8974: Add dma channels for blsp2_i2c1 node"

Andy Lutomirski (1):
      Revert "x86/mm/32: Set NX in __supported_pte_mask before enabling pag=
ing"

Anna-Maria Gleixner (1):
      net: mvneta: Remove superfluous SMP function call

Anton Blanchard (1):
      powerpc: Fix bad inline asm constraint in create_zero_mask()

Antonio Quartulli (2):
      batman-adv: fix DAT candidate selection (must use vid)
      batman-adv: B.A.T.M.A.N V - make sure iface is reactivated upon NETDE=
V_UP event

Arnaud Mouiche (6):
      ASoC: fsl_ssi: Real hardware channels max number is 32
      ASoC: fsl_ssi: The IPG/5 limitation concerns the bitclk, not the sysc=
lk.
      ASoC: fsl_ssi: Save a dev reference for dev_err() purpose.
      ASoC: fsl_ssi: Fix samples being dropped at Playback startup
      ASoC: fsl_ssi: Fix channel slipping in Playback at startup
      ASoC: fsl_ssi: Fix channel slipping on capture (or playback) restart =
in full duplex.

Arnd Bergmann (7):
      Merge tag 'qcom-fixes-for-4.6-rc2' of git://git.kernel.org/.../agross=
/linux into fixes
      Merge tag 'samsung-fixes-4.6' of git://git.kernel.org/.../krzk/linux =
into fixes
      Merge tag 'omap-for-v4.6/fixes-rc5-signed' of git://git.kernel.org/..=
=2E/tmlind/linux-omap into fixes
      Merge tag 'renesas-fixes2-for-v4.6' of git://git.kernel.org/.../horms=
/renesas into fixes
      ARM: davinci: only use NVMEM when available
      net/smscx5xx: use the device tree for mac address
      byteswap: try to avoid __builtin_constant_p gcc bug

Ashish Samant (1):
      fuse: Fix return value from fuse_get_user_pages()

Ashutosh Dixit (1):
      misc: mic: Fix for double fetch security bug in VOP driver

Atsushi Kumagai (2):
      kexec: update VMCOREINFO for compound_order/dtor
      kexec: export OFFSET(page.compound_head) to find out compound tail pa=
ge

Ayala Beker (1):
      iwlwifi: mvm: avoid to WARN about gscan capabilities

Azael Avalos (1):
      toshiba_acpi: Fix regression caused by hotkey enabling value

Babu Moger (1):
      sparc/PCI: Fix for panic while enabling SR-IOV

Bard Liao (1):
      ASoC: rt5645: polling jd status in all conditions

Bert Kenward (1):
      MAINTAINERS: net: update sfc maintainers

Bin Liu (1):
      Revert "usb: musb: musb_host: Enable HCD_BH flag to handle urb return=
 in bottom half"

Boqun Feng (1):
      locking/lockdep: Fix ->irq_context calculation

Borislav Petkov (1):
      sparc/defconfigs: Remove CONFIG_IPV6_PRIVACY

Brijesh Singh (1):
      ata: add AMD Seattle platform driver

Caleb Crome (1):
      ASoC: fsl_ssi: add CCSR_SSI_SOR to volatile register list

Charles Keepax (9):
      ASoC: wm_adsp: Fix some subtle races on compressed stream
      ASoC: wm_adsp: Show avail in bytes to match other messages
      ASoC: cs47l24: Fix a couple of small whitespace errors
      ASoC: cs47l24: Add support for audio trace firmware
      ASoC: wm_adsp: Factor out fetching of stream errors from the DSP
      ASoC: wm_adsp: Improve DSP error handling
      ASoC: wm_adsp: Add support for TLV based binary controls
      ASoC: wm_adsp: Move compr_attach/attached functions
      ASoC: wm_adsp: Detach compressed stream on free

Charmaine Lee (2):
      drm/vmwgfx: Enable SVGA_3D_CMD_DX_SET_PREDICATION
      drm/vmwgfx: use vmw_cmd_dx_cid_check for query commands.

Chen Yu (1):
      x86/tsc: Read all ratio bits from MSR_PLATFORM_INFO

Chen-Yu Tsai (1):
      mmc: sunxi: Disable eMMC HS-DDR (MMC_CAP_1_8V_DDR) for Allwinner A80

Chris Wilson (1):
      drm/i915: Avoid stalling on pending flips for legacy cursor updates

Christoph Hellwig (1):
      IB/iser: Fix max_sectors calculation

Christophe Jaillet (1):
      ps3_gelic: fix memcpy parameter

Chunyu Hu (1):
      tracing: Don't display trigger file for events that can't be enabled

Colin Ian King (1):
      net: dsa: mv88e6xxx: fix uninitialized error return

Craig Gallek (1):
      soreuseport: Fix TCP listener hash collision

Dan Carpenter (4):
      md/raid0: fix uninitialized variable bug
      firmware: qemu_fw_cfg.c: potential unintialized variable
      virtio: Silence uninitialized variable warning
      ASoC: hdac_hdmi: Potential NULL deref in hdac_hdmi_get_spk_alloc()

Dan Streetman (1):
      mm/zswap: provide unique zpool name

Dan Williams (2):
      libnvdimm, pfn: fix memmap reservation sizing
      nfit: fix translation of command status results

Daniel Baluta (1):
      iio: imu: mpu6050: Fix name/chip_id when using ACPI

Dave Airlie (6):
      Merge branch 'drm-etnaviv-fixes' of git://git.pengutronix.de:/git/lst=
/linux into drm-fixes
      Merge branch 'drm-vmwgfx-fixes' of git://people.freedesktop.org/~syeh=
/repos_linux into drm-fixes
      Merge branch 'drm-fixes-4.6' of git://people.freedesktop.org/~agd5f/l=
inux into drm-fixes
      drm/amdgpu: set metadata pointer to NULL after freeing.
      Merge branch 'drm-fixes-4.6' of git://people.freedesktop.org/~agd5f/l=
inux into drm-fixes
      Merge tag 'drm-intel-fixes-2016-05-02' of git://anongit.freedesktop.o=
rg/drm-intel into drm-fixes

Dave Gerlach (1):
      ARM: OMAP3: Fix external abort on 36xx waking from off mode idle

David Ahern (1):
      net: ipv6: Delete host routes on an ifdown

David Rivshin (5):
      drivers: net: cpsw: fix parsing of phy-handle DT property in dual_ema=
c config
      drivers: net: cpsw: fix segfault in case of bad phy-handle
      drivers: net: cpsw: don't ignore phy-mode if phy-handle is used
      dt: cpsw: phy-handle, phy_id, and fixed-link are mutually exclusive
      drivers: net: cpsw: use of_phy_connect() in fixed-link case

David S. Miller (19):
      sparc: Write up preadv2/pwritev2 syscalls.
      Merge branch 'bridge-mdb-fixes'
      Merge branch 'macsec-fixes'
      Merge branch 'mlx5-fixes'
      ipv6: Revert optional address flusing on ifdown.
      Revert "ipv6: Revert optional address flusing on ifdown."
      Merge branch 'bnxt_en-fixes'
      sparc64: Fix bootup regressions on some Kconfig combinations.
      Merge tag 'wireless-drivers-for-davem-2016-04-25' of git://git.kernel=
=2Eorg/.../kvalo/wireless-drivers
      Merge tag 'batman-adv-fix-for-davem' of git://git.open-mesh.org/linux=
-merge
      Merge tag 'mac80211-for-davem-2016-04-27' of git://git.kernel.org/...=
/jberg/mac80211
      Merge branch 'gre-lwt-fixes'
      Merge branch 'pegasus-sizes'
      Merge branch 'cpsw-phy-handle-fixes'
      Merge branch 'bpf-fixes'
      Merge tag 'batman-adv-fix-for-davem' of git://git.open-mesh.org/linux=
-merge
      Merge branch 'mlx5-fixes'
      Merge branch 'tunnel-csum-and-sg-offloads'
      Merge branch 'rds-fixes'

Dean Luick (1):
      IB/hfi1: Use kernel default llseek for ui device

Dharageswari.R (2):
      ASoC: Intel: Skylake: Fix the NULL pointer exception in dsp_clean up
      ASoC: Intel: Skylake: Prevent sending Set DMA Control IPC if the widg=
et is "On"

Dmitry V. Levin (1):
      parisc: fix a bug when syscall number of tracee is __NR_Linux_syscalls

Doug Ledford (1):
      IB/core: Fix oops in ib_cache_gid_set_default_gid

Elad Raz (3):
      switchdev: Adding complete operation to deferred switchdev ops
      bridge: mdb: Common function for mdb entry translation
      bridge: mdb: Marking port-group as offloaded

Eli Cohen (1):
      net/mlx5_core: Remove static from local variable

Eric Dumazet (1):
      net/mlx4_en: fix spurious timestamping callbacks

Eric Engestrom (3):
      Documentation: dt: arc: fix spelling mistakes
      Documentation: networking: fix spelling mistakes
      MAINTAINERS: fix Rajendra Nayak's address

Eric W. Biederman (1):
      propogate_mnt: Handle the first propogated copy being a slave

Evgeny Voevodin (1):
      ARCv2: Enable LOCKDEP

Fabio Estevam (3):
      ASoC: fsl_sai: Introduce a compatible string for MX6UL
      ASoC: fsl_sai: Allow setting the SAI MCLK direction
      MAINTAINERS: Add myself as reviewer of FSL/NXP SoC sound drivers

Flora Cui (2):
      drm/ttm: fix kref count mess in ttm_bo_move_to_lru_tail
      drm/amdgpu: disable vm interrupts with vm_fault_stop=3D2

Florian Fainelli (1):
      net: macb: Probe MDIO bus before registering netdev

Florian Meier (1):
      ASoC: pcm5102a: Add support for PCM5102A codec

Florian Westphal (1):
      RDMA/nes: don't leak skb if carrier down

Frank Rowand (1):
      .mailmap: add Frank Rowand

Franklin S Cooper Jr (2):
      ARM: dts: am33xx: Fix GPMC dma properties
      ARM: dts: am437x: Fix GPMC dma properties

Gal Pressman (1):
      net/mlx5: Unmap only the relevant IO memory mapping

Geert Uytterhoeven (2):
      ARM: shmobile: timer: Fix preset_lpj leading to too short delays
      arm64: dts: r8a7795: Don't disable referenced optional scif clock

Gerald Schaefer (2):
      s390/mm: fix asce_bits handling with dynamic pagetable levels
      numa: fix /proc/<pid>/numa_maps for THP

Greg Kroah-Hartman (3):
      Merge tag 'iio-fixes-for-4.6c' of git://git.kernel.org/.../jic23/iio =
into staging-linus
      Merge tag 'usb-serial-4.6-rc6' of git://git.kernel.org/.../johan/usb-=
serial into usb-linus
      Merge tag 'iio-fixes-for-4.6d' of git://git.kernel.org/.../jic23/iio =
into staging-linus

Grygorii Strashko (1):
      MAINTAINERS: net: add entry for TI Ethernet Switch drivers

Gustavo Padovan (1):
      drm/virtio: send vblank event after crtc updates

H. Nikolaus Schaller (2):
      Input: twl6040-vibra - fix atomic schedule panic
      ARM: dts: omap5: fix range of permitted wakeup pinmux registers

Hamish Martin (1):
      tipc: only process unicast on intended node

Hans Verkuil (2):
      [media] davinci_vpfe: Revert "staging: media: davinci_vpfe: remove,un=
necessary ret variable"
      [media] v4l2-dv-timings.h: fix polarity for 4k formats

Hans de Goede (1):
      ARM: dts: sun8i-q8-common: Do not set constraints on dc1sw regulator

Hariprasad S (1):
      RDMA/iw_cxgb4: Fix bar2 virt addr calculation for T4 chips

Heikki Krogerus (1):
      device property: Avoid potential dereferences of invalid pointers

Heinrich Schuchardt (2):
      ASoC: fsl: imx-pcm-fiq: use correct format specifier
      ASoC: au1x: use correct format specifier

Horia Geant? (1):
      crypto: talitos - fix AEAD tcrypt tests

Howard Cochran (1):
      writeback: Fix performance regression in wb_over_bg_thresh()

Hugh Dickins (2):
      huge pagecache: mmap_sem is unlocked when truncation splits pmd
      mm, cma: prevent nr_isolated_* counters from going negative

Ilya Dryomov (3):
      libceph: make authorizer destruction independent of ceph_auth_client
      rbd: fix rbd map vs notify races
      rbd: report unsupported features to syslog

Imre Deak (2):
      drm/i915: Fix system resume if PCI device remained enabled
      drm/i915/ddi: Fix eDP VDD handling during booting and suspend/resume

Ingo Molnar (1):
      Merge tag 'efi-urgent' of git://git.kernel.org/.../mfleming/efi into =
efi/urgent

Ivan Babrou (1):
      net: dummy: remove note about being Y by default

Ivaylo Dimitrov (2):
      ARM: dts: omap3: Fix ISP syscon register offset
      ARM: dts: omap3-n900: Specify peripherals LDO regulators initial mode

James Liao (1):
      Revert "soc: mediatek: SCPSYS: Fix double enabling of regulators"

James Morse (2):
      ARM: cpuidle: Pass on arm_cpuidle_suspend()'s return value
      kcov: don't trace the code coverage code

Jan Beulich (1):
      xen/evtchn: fix ring resize when binding new events

Jann Horn (1):
      bpf: fix double-fdput in replace_map_fd_with_map_ptr()

Jasem Mutlaq (1):
      USB: serial: cp210x: add Straizona Focusers device ids

Jason Baron (1):
      mm: update min_free_kbytes from khugepaged after core initialization

Jason Gunthorpe (1):
      IB/security: Restrict use of the write() interface

Javier Martinez Canillas (2):
      i2c: exynos5: Fix possible ABBA deadlock by keeping I2C clock prepared
      ASoC: cs42l56: Use IS_ENABLED() instead of checking for built-in or m=
odule

Jean-Philippe Brucker (2):
      ARM: 8571/1: nommu: fix PMSAv7 setup
      ARM: 8572/1: nommu: change memory reserve for the vectors

Jeeja KP (4):
      ASoC: Intel: Bxtn: Add Broxton DSP support
      ASoC: Intel: Skylake: Suspend PCMs when marked as active suspend
      ASoC: Intel: Boards: remove ignore_suspend for WoV streams
      ASoC: Intel: Skylake: Fix memory leak in nhlt init

Jim Lodes (1):
      ASoC: davinci-mcasp: Fix overwriting of ahclkx

Jiri Benc (5):
      cxgbi: fix uninitialized flowi6
      gre: do not assign header_ops in collect metadata mode
      gre: build header correctly for collect metadata tunnels
      gre: reject GUE and FOU in collect metadata mode
      gre: do not pull header in ICMP error processing

Johan Hovold (1):
      Revert "USB / PM: Allow USB devices to remain runtime-suspended when =
sleeping"

Johannes Berg (1):
      mac80211: fix statistics leak if dev_alloc_name() fails

Johannes Weiner (1):
      mm: memcontrol: let v2 cgroups follow changes in system swappiness

John Keeping (11):
      ASoC: rockchip: Revert "ASoC: rockchip: i2s: remove unused variables"
      ASoC: rockchip: Revert "ASoC: rockchip: i2s: separate capture and pla=
yback"
      ASoC: es8328: Move clock setup to hw_params
      ASoC: es8328: Fix ADC format setup
      ASoC: es8328: Fix mask for VMIDSEL
      ASoC: es8328: Use single R/W for regmap
      ASoC: es8328: Move sample size setup to hw_params
      ASoC: es8328: Support more sample formats
      ASoC: es8328: Support more sample rates
      ASoC: es8328: Set symmetric rates
      ASoC: dapm: deprecate MICBIAS widget type

John Lin (1):
      ASoC: rt5645: Add dmi_system_id "Google Setzer"

John Paul Adrian Glaubitz (2):
      sparc: Implement and wire up modalias_show for vio.
      sparc: Implement and wire up vio_hotplug for vio.

Jon Cooper (1):
      sfc: disable RSS when unsupported

Jonas Eymann (1):
      crypto: talitos - fix crash in talitos_cra_init()

Joonas Lahtinen (1):
      ASoC: Intel: Fix printk formatting

Joonsoo Kim (1):
      lib/stackdepot: avoid to return 0 handle

Jose Abreu (2):
      ASoC: dwc: Unmask I2S interrupts only for enabled channels
      ASoC: dwc: Use fifo depth to program FCR

Josh Boyer (1):
      x86/efi-bgrt: Switch all pr_err() to pr_notice() for invalid BGRT

Jubin John (1):
      IB/rdmavt: Fix send scheduling

Jyri Sarha (3):
      ALSA: pcm: add IEC958 channel status helper for hw_params
      ALSA: pcm: Allow 32 bit sample format in IEC958 channel status helper
      ASoC: hdmi-codec: Add hdmi-codec for external HDMI-encoders

K. Y. Srinivasan (1):
      Drivers: hv: vmbus: Fix signaling logic in hv_need_to_signal_on_read()

Kalle Valo (1):
      Merge tag 'iwlwifi-for-kalle-2016-04-12_2' of https://git.kernel.org/=
=2E../iwlwifi/iwlwifi-fixes

Kan Liang (1):
      perf/x86/intel: Fix incorrect lbr_sel_mask value

Keerthy (2):
      ARM: dts: dra7: Correct clock tree for sys_32k_ck
      ARM: DRA7: clockdomain: Implement timer workaround for errata i874

Keith Busch (1):
      x86/apic: Handle zero vector gracefully in clear_vector_irq()

Kevin Hilman (7):
      Merge tag 'v4.6-soc-fixes' of https://github.com/mbgg/linux-mediatek =
into fixes
      Merge tag 'omap-for-v4.6/fixes-rc2-v2-signed' of git://git.kernel.org=
/.../tmlind/linux-omap into fixes
      Merge tag 'renesas-fixes-for-v4.6' of git://git.kernel.org/.../horms/=
renesas into fixes
      Merge tag 'omap-for-v4.6/fixes-rc3' of git://git.kernel.org/.../tmlin=
d/linux-omap into fixes
      Merge tag 'imx-fixes-4.6' of git://git.kernel.org/.../shawnguo/linux =
into fixes
      Merge tag 'omap-for-v4.6/dt-ti81xx-signed' of git://git.kernel.org/..=
=2E/tmlind/linux-omap into fixes
      Merge tag 'sunxi-fixes-for-4.6' of https://git.kernel.org/.../mripard=
/linux into fixes

Khalid Aziz (1):
      sparc64: recognize and support Sonoma CPU type

Kirill A. Shutemov (1):
      thp: keep huge zero page pinned until tlb flush

Knut Wohlrab (1):
      Input: zforce_ts - fix dual touch recognition

Konstantin Khlebnikov (2):
      mm/huge_memory: replace VM_NO_THP VM_BUG_ON with actual VMA check
      mm/memory-failure: fix race with compound page split/merge

Krzysztof Kozlowski (3):
      iio: ak8975: Fix NULL pointer exception on early interrupt
      ARM: EXYNOS: Properly skip unitialized parent clock in power domain on
      mailmap: fix Krzysztof Kozlowski's misspelled name

Laszlo Ersek (1):
      efi: Fix out-of-bounds read in variable_matches()

Leo Yan (2):
      thermal: hisilicon: increase temperature resolution
      thermal: use %d to print S32 parameters

Linus L=C3=BCssing (1):
      batman-adv: Fix broadcast/ogm queue limit on a removed interface

Linus Torvalds (66):
      Merge branch 'linus' of git://git.kernel.org/.../herbert/crypto-2.6
      devpts: more pty driver interface cleanups
      Merge tag 'fixes-for-linus' of git://git.kernel.org/.../arm/arm-soc
      Merge git://git.kernel.org/.../davem/net
      Merge tag 'platform-drivers-x86-v4.6-3' of git://git.infradead.org/us=
ers/dvhart/linux-platform-drivers-x86
      Merge tag 'nios2-v4.6-fix' of git://git.kernel.org/.../lftan/nios2
      Merge tag 'arc-4.6-rc6-fixes' of git://git.kernel.org/.../vgupta/arc
      Merge branch 'i2c/for-current' of git://git.kernel.org/.../wsa/linux
      Merge branch 'for-4.6-fixes' of git://git.kernel.org/.../tj/cgroup
      Merge branch 'for-4.6-fixes' of git://git.kernel.org/.../tj/wq
      Merge branch 'for-linus' of git://git.kernel.org/.../s390/linux
      Merge branch 'for-linus' of git://git.kernel.org/.../sage/ceph-client
      Merge tag 'sound-4.6-rc6' of git://git.kernel.org/.../tiwai/sound
      Merge tag 'media/v4.6-4' of git://git.kernel.org/.../mchehab/linux-me=
dia
      Merge branch 'efi-urgent-for-linus' of git://git.kernel.org/.../tip/t=
ip
      Merge branch 'locking-urgent-for-linus' of git://git.kernel.org/.../t=
ip/tip
      Merge branch 'perf-urgent-for-linus' of git://git.kernel.org/.../tip/=
tip
      Merge branch 'x86-urgent-for-linus' of git://git.kernel.org/.../tip/t=
ip
      Merge branch 'akpm' (patches from Andrew)
      Merge tag 'for-linus' of git://git.kernel.org/.../dledford/rdma
      Merge branch 'drm-fixes' of git://people.freedesktop.org/~airlied/lin=
ux
      Merge tag 'mmc-v4.6-rc4' of git://git.linaro.org/people/ulf.hansson/m=
mc
      Merge tag 'pm+acpi-4.6-rc6' of git://git.kernel.org/.../rafael/linux-=
pm
      Merge tag 'edac_fix_for_4.6' of git://git.kernel.org/.../bp/bp
      Merge tag 'powerpc-4.6-4' of git://git.kernel.org/.../powerpc/linux
      Merge branch 'fixes' of git://git.kernel.org/.../evalenti/linux-soc-t=
hermal
      Linux 4.6-rc6
      Merge git://git.kernel.org/.../davem/sparc
      Merge git://git.kernel.org/.../davem/net
      Merge tag 'gpio-v4.6-4' of git://git.kernel.org/.../linusw/linux-gpio
      Merge branch 'for_linus' of git://git.kernel.org/.../jack/linux-fs
      Merge tag 'md/4.6-rc6-fix' of git://git.kernel.org/.../shli/md
      Minimal fix-up of bad hashing behavior of hash_64()
      Merge tag 'clk-fixes-for-linus' of git://git.kernel.org/.../clk/linux
      Merge branch 'for-linus' of git://git.kernel.org/.../jikos/hid
      Merge branch 'for-linus' of git://git.kernel.org/.../mszeredi/fuse
      Merge git://git.kernel.org/.../davem/net
      Merge tag 'trace-fixes-v4.6-rc6' of git://git.kernel.org/.../rostedt/=
linux-trace
      Merge tag 'for-linus-4.6-rc6-tag' of git://git.kernel.org/.../xen/tip
      Merge branch 'for-linus' of git://git.kernel.org/.../jmorris/linux-se=
curity
      Merge branch 'for-linus' of git://git.kernel.org/.../dtor/input
      Merge tag 'for_linus' of git://git.kernel.org/.../mst/vhost
      Merge branch 'for-linus' of git://git.kernel.org/.../ebiederm/user-na=
mespace
      Merge tag 'fixes-for-linus' of git://git.kernel.org/.../arm/arm-soc
      Merge tag 'asm-generic-4.6' of git://git.kernel.org/.../arnd/asm-gene=
ric
      Merge branch 'libnvdimm-fixes' of git://git.kernel.org/.../nvdimm/nvd=
imm
      mailmap: add John Paul Adrian Glaubitz
      Merge branch 'akpm' (patches from Andrew)
      Merge branch 'drm-fixes' of git://people.freedesktop.org/~airlied/lin=
ux
      Merge tag 'powerpc-4.6-5' of git://git.kernel.org/.../powerpc/linux
      Merge tag 'arc-4.6-rc7-fixes' of git://git.kernel.org/.../vgupta/arc
      Merge branch 'parisc-4.6-5' of git://git.kernel.org/.../deller/parisc=
-linux
      Merge branch 'efi-urgent-for-linus' of git://git.kernel.org/.../tip/t=
ip
      Merge branch 'perf-urgent-for-linus' of git://git.kernel.org/.../tip/=
tip
      Merge branch 'sched-urgent-for-linus' of git://git.kernel.org/.../tip=
/tip
      Merge tag 'pm+acpi-4.6-rc7' of git://git.kernel.org/.../rafael/linux-=
pm
      Merge branch 'x86-urgent-for-linus' of git://git.kernel.org/.../tip/t=
ip
      Merge branch 'for-linus' of git://git.kernel.dk/linux-block
      Merge tag 'for-linus' of git://git.kernel.org/.../dledford/rdma
      Merge branch 'for-4.6-fixes' of git://git.kernel.org/.../tj/libata
      Merge tag 'media/v4.6-5' of git://git.kernel.org/.../mchehab/linux-me=
dia
      Merge branch 'fixes' of git://git.armlinux.org.uk/~rmk/linux-arm
      Merge tag 'usb-4.6-rc7' of git://git.kernel.org/.../gregkh/usb
      Merge tag 'staging-4.6-rc7' of git://git.kernel.org/.../gregkh/staging
      Merge tag 'char-misc-4.6-rc7' of git://git.kernel.org/.../gregkh/char=
-misc
      Linux 4.6-rc7

Linus Walleij (2):
      Revert "gpio: rcar: Add Runtime PM handling for interrupts"
      Revert "gpio: rcar: Fine-grained Runtime PM support"

Lothar Wa=C3=9Fmann (1):
      clk: imx6q: fix typo in CAN clock definition

Lucas Stach (1):
      drm/etnaviv: don't move linear memory window on 3D cores without MC2.0

Lyude (1):
      drm/dp/mst: Restore primary hub guid on resume

Majd Dibbiny (2):
      net/mlx5_core: Add ConnectX-5 to list of supported devices
      net/mlx5: Add pci shutdown callback

Manish Chopra (1):
      qlcnic: Update version to 5.3.64

Maor Gottlieb (1):
      net/mlx5_core: Fix soft lockup in steering error flow

Marcelo Ricardo Leitner (1):
      net: fix net_gso_ok for new GSO types.

Marek Lindner (1):
      batman-adv: init neigh node last seen field

Marek Szyprowski (2):
      [media] media: exynos4-is: fix deadlock on driver probe
      [media] media: s3c-camif: fix deadlock on driver probe()

Marek Vasut (2):
      iio:adc:at91-sama5d2: Repair crash on module removal
      net: stmmac: socfpga: Remove re-registration of reset controller

Mark Brown (18):
      Merge branch 'topic/dmaengine' of git://git.kernel.org/.../broonie/so=
und into asoc-bcm2835
      Merge branch 'topic/hda' of git://git.kernel.org/.../broonie/sound in=
to asoc-hdmi
      Merge tag 'asoc-fix-v4.6-rc5' into asoc-intel
      Merge branch 'topic/arizona' of git://git.kernel.org/.../broonie/soun=
d into asoc-adsp
      ASoC: da7129: Add missing include of acpi.h
      Merge branch 'topic/dai-link' of git://git.kernel.org/.../broonie/sou=
nd into asoc-intel
      Merge remote-tracking branches 'asoc/fix/davinci', 'asoc/fix/fsl-ssi'=
, 'asoc/fix/rockchip' and 'asoc/fix/rt286' into asoc-linus
      Merge remote-tracking branch 'asoc/topic/dapm' into asoc-next
      Merge remote-tracking branch 'asoc/topic/dmaengine' into asoc-next
      Merge remote-tracking branch 'asoc/topic/imx' into asoc-next
      Merge remote-tracking branch 'asoc/topic/intel' into asoc-next
      Merge remote-tracking branch 'asoc/topic/pcm5102' into asoc-next
      Merge remote-tracking branch 'asoc/topic/rt5645' into asoc-next
      Merge remote-tracking branches 'asoc/topic/adsp', 'asoc/topic/ak4624'=
, 'asoc/topic/atmel' and 'asoc/topic/au1x' into asoc-next
      Merge remote-tracking branches 'asoc/topic/bcm2835', 'asoc/topic/cs42=
l56', 'asoc/topic/da7213', 'asoc/topic/da7218' and 'asoc/topic/da7219' into=
 asoc-next
      Merge remote-tracking branches 'asoc/topic/davinci' and 'asoc/topic/d=
wc' into asoc-next
      Merge remote-tracking branches 'asoc/topic/es8328', 'asoc/topic/find-=
dai', 'asoc/topic/fsl', 'asoc/topic/fsl-sai' and 'asoc/topic/fsl-ssi' into =
asoc-next
      Merge remote-tracking branch 'asoc/topic/hdmi' into asoc-next

Martin Schwidefsky (1):
      s390/sclp_ctl: fix potential information leak with /dev/sclp

Masahiro Yamada (1):
      arm64: dts: uniphier: fix I2C nodes of PH1-LD20

Mathias Krause (1):
      proc: prevent accessing /proc/<PID>/environ until it's ready

Matt Fleming (1):
      MAINTAINERS: Remove asterisk from EFI directory names

Matt Ranostay (1):
      iio: imu: mpu6050: fix possible NULL dereferences

Matthew Finlay (3):
      net/mlx5: Kconfig: Fix MLX5_EN/VXLAN build issue
      net/mlx5e: Implement a mlx5e workqueue
      net/mlx5e: Use workqueue for vxlan ops

Matthias Reichl (4):
      ASoC: bcm2835: add 24bit support
      ASoC: bcm2835: setup clock only if CPU is clock master
      ASoC: dmaengine_pcm: Add support for packed transfers
      ASoC: bcm2835: Add S16_LE support via packed DMA transfers

Matti Gottlieb (1):
      iwlwifi: mvm: fix accessing Null pointer during fw dump collection

Mauro Carvalho Chehab (1):
      [media] media-device: fix builds when USB or PCI is compiled as module

Mengdong Lin (3):
      ASoC: Change DAI link's be_id to a generic id
      ASoC: Export snd_soc_find_dai()
      ASoC: Add kerneldoc comments for snd_soc_find_dai

Michael Chan (3):
      bnxt_en: Don't fallback to INTA on VF.
      bnxt_en: Limit RX BD pages to be no bigger than 32K.
      bnxt_en: Divide a page into 32K buffers for the aggregation ring if n=
ecessary.

Michael Ellerman (1):
      i2c: cpm: Fix build break due to incompatible pointer types

Michael Neuling (2):
      cxl: Keep IRQ mappings on context teardown
      cxl: Poll for outstanding IRQs when detaching a context

Michal Schmidt (1):
      cxgb3: fix out of bounds read

Micha=C5=82 Pecio (1):
      md/raid0: remove empty line printk from dump_zones

Mika Kahola (1):
      drm/i915: Fix eDP low vswing for Broadwell

Mika Westerberg (1):
      i2c: ismt: Add Intel DNV PCI ID

Mike Manning (1):
      USB: serial: cp210x: add ID for Link ECU

Mike Marciniszyn (1):
      IB/hfi1: Fix missing lock/unlock in verbs drain callback

Miklos Szeredi (1):
      fuse: update mailing list in MAINTAINERS

Mimi Zohar (1):
      ima: fix the string representation of the LSM/IMA hook enumeration or=
dering

Minchan Kim (3):
      mm: vmscan: reclaim highmem zone if buffer_heads is over limit
      mm: call swap_slot_free_notify() with page lock held
      mm/hwpoison: fix wrong num_poisoned_pages accounting

Mitko Haralanov (4):
      IB/hfi1: Prevent NULL pointer deferences in caching code
      IB/hfi1: Fix deadlock caused by locking with wrong scope
      IB/hfi1: Prevent unpinning of wrong pages
      IB/hfi1: Don't attempt to free resources if initialization failed

Mousumi Jana (1):
      ASoC: Intel: Skylake: Fix memory leak during init instance

Nazar Mokrynskyi (1):
      HID: Fix boot delay for Creative SB Omni Surround 5.1 with quirk

Neil Armstrong (1):
      net: ethernet: davinci_emac: Fix devioctl while in fixed link

Neil Horman (1):
      netem: Segment GSO packets on enqueue

Nick Dyer (1):
      Input: atmel_mxt_ts - use mxt_acquire_irq in mxt_soft_reset

Nicolas Dichtel (1):
      ipv6/ila: fix nlsize calculation for lwtunnel

Nishanth Menon (3):
      ARM: OMAP: DRA7: wakeupgen: Skip SAR save for wakeupgen
      ARM: OMAP: DRA7: Provide proper class to omap2_set_globals_tap
      ARM: OMAP: Catch callers of revision information prior to it being po=
pulated

Oleksij Rempel (1):
      ath9k: ar5008_hw_cmn_spur_mitigate: add missing mask_m & mask_p initi=
alisation

Oren Givon (1):
      iwlwifi: add device IDs for the 8265 device

Paolo Abeni (2):
      ipv4/fib: don't warn when primary address is missing if in_dev is dead
      ip_tunnel: fix preempt warning in ip tunnel creation/updating

Pardha Saradhi K (1):
      ASoC: Intel: Skylake: Add more SSP DAIs

Peter Rosin (1):
      ASoC: atmel_ssc_dai: read DSP mode A data on rising edges of bclk

Peter Ujfalusi (5):
      ASoC: davinci-mcasp: Do not allow multiple streams in one direction
      ASoC: davinci-mcasp: Use defines for clkdiv IDs
      ASoC: davinci-mcasp: Change __davinci_mcasp_set_clkdiv() first parame=
ter
      ASoC: davinci-mcasp: Restructure the davinci_mcasp_calc_clk_div()
      ASoC: davinci-mcasp: Calculate AUXCLK divider when setting up master =
clocks

Peter Zijlstra (5):
      perf/core: Make sysctl_perf_cpu_time_max_percent conform to documenta=
tion
      lockdep: Fix lock_chain::base size
      nohz/full, sched/rt: Fix missed tick-reenabling bug in sched_can_stop=
_tick()
      perf/core: Fix perf_event_open() vs. execve() race
      perf/x86/amd/iommu: Do not register a task ctx for uncore like PMUs

Petko Manolov (2):
      pegasus: fixes URB buffer allocation size;
      pegasus: fixes reported packet length

Petr Kulhavy (2):
      ASoC: davinci-mcbsp: add binding for McBSP
      ASoC: Davinci: McBSP: add device tree support for McBSP

Philipp Zabel (4):
      ASoC: hdmi-codec: Add ELD control
      ASoC: hdmi-codec: Add ELD control
      gpu: ipu-v3: Fix imx-ipuv3-crtc module autoloading
      modpost: fix module autoloading for OF devices with generic compatibl=
e property

Ping Cheng (2):
      HID: wacom: Add support for DTK-1651
      HID: wacom: add missed stylus_in_proximity line back

Prarit Bhargava (1):
      ACPICA: Dispatcher: Update thread ID for recursive method calls

Rafael J. Wysocki (6):
      Revert "cpufreq: governor: Fix negative idle_time when configured wit=
h CONFIG_HZ_PERIODIC"
      Merge branch 'pm-cpufreq-fixes'
      cpufreq: intel_pstate: Fix HWP on boot CPU after system resume
      intel_pstate: Fix intel_pstate_get()
      Merge branches 'acpica-fixes' and 'device-properties-fixes'
      Merge branches 'pm-opp-fixes', 'pm-cpufreq-fixes' and 'pm-cpuidle-fix=
es'

Ramesh Babu (1):
      ASoC: Intel: Add Broxton-P machine driver

Rana Shahout (1):
      net/mlx5e: Fix MLX5E_100BASE_T define

Randy Dunlap (1):
      ASoC: intel: add function stub when ACPI is not enabled

Ricardo Ribalda Delgado (2):
      [media] media: vb2: Fix regression on poll() for RW mode
      [media] vb2-memops: Fix over allocation of frame vectors

Richard Fitzgerald (6):
      ASoC: arizona: Do not create OUT4R widget for CS47L24/WM1831
      ASoC: arizona: Prefer lower FRATIO in pseudo-fractional mode
      ASoC: arizona: No need to update_bits when writing AEC clock control
      ASoC: wm_adsp: free memory when unloaded or closed
      ASoC: arizona: call wm_adsp2_remove when codec driver is removed
      ASoC: wm_adsp: factor out freeing of alg regions

Richard Leitner (1):
      iio: ak8975: fix maybe-uninitialized warning

Roger Quadros (1):
      ARM: dts: am57xx-beagle-x15: remove extcon_usb1

Romain Perier (1):
      nios2: memset: use the right constraint modifier for the %4 output op=
erand

Roman Pen (1):
      workqueue: fix ghost PENDING flag while doing MQ IO

Ross Lagerwall (3):
      xen: Fix page <-> pfn conversion on 32 bit systems
      xen/balloon: Fix crash when ballooning on x86 32 bit PAE
      xen/qspinlock: Don't kick CPU if IRQ is not initialized

Rui Salvaterra (1):
      powerpc: wire up preadv2 and pwritev2 syscalls

Russell King (1):
      maintainers: update rmk's email address(es)

Sabrina Dubroca (9):
      macsec: add missing NULL check after kmalloc
      macsec: take rtnl lock before for_each_netdev
      macsec: don't put a NULL rxsa
      macsec: fix rx_sa refcounting with decrypt callback
      macsec: add consistency check to netlink dumps
      macsec: fix memory leaks around rx_handler (un)registration
      macsec: fix SA leak if initialization fails
      macsec: add missing macsec prefix in uapi
      macsec: fix netlink attribute validation

Saeed Mahameed (3):
      net/mlx5e: Device's mtu field is u16 and not int
      net/mlx5e: Fix minimum MTU
      net/mlx5e: Use vport MTU rather than physical port MTU

Sagi Grimberg (3):
      IB/core: Don't drain non-existent rq queue-pair
      IB/mlx5: Expose correct max_sge_rd limit
      MAINTAINERS: Update iser/isert maintainer contact info

Sakari Ailus (2):
      [media] videobuf2-core: Check user space planes array in dqbuf
      [media] videobuf2-v4l2: Verify planes array in buffer dequeueing

Sara Sharon (1):
      iwlwifi: 8000: fix MODULE_FIRMWARE input

Sascha Hauer (1):
      ARM: SoCFPGA: Fix secondary CPU startup in thumb2 kernel

Sebastian Ott (1):
      s390/pci: fix use after free in dma_init

Sergei Shtylyov (2):
      pxa168_eth: fix mdiobus_scan() error check
      macb: fix mdiobus_scan() error check

Shaohua Li (2):
      MD: make bio mergeable
      raid5: delete unnecessary warnning

Shashank Sharma (1):
      drm/i915: Fake HDMI live status

Shreyas NC (1):
      ASoC: Intel: Skylake: Use UUID in binary format

Sinclair Yeh (1):
      drm/vmwgfx: Fix order of operation

Sjoerd Simons (2):
      ARM: dts: r8a7791: Don't disable referenced optional clocks
      Revert "ARM: dts: porter: Enable SCIF_CLK frequency and pins"

Sowmini Varadhan (3):
      sparc/pci: Refactor dev_archdata initialization into pci_init_dev_arc=
hdata
      RDS:TCP: Synchronize rds_tcp_accept_one with rds_send_xmit when reset=
ting t_sock
      RDS: TCP: Synchronize accept() and connect() paths on t_conn_lock.

Srinivas Kandagatla (3):
      libahci: save port map for forced port map
      ata: ahci-platform: Add ports-implemented DT bindings.
      ARM: dts: apq8064: add ahci ports-implemented mask

Srinivas Pandruvada (2):
      perf/x86/intel/rapl: Add missing Haswell model
      cpufreq: intel_pstate: Fix processing for turbo activation ratio

Stanislav Meduna (1):
      nvmem: mxs-ocotp: fix buffer overflow in read

Stanislaw Gruszka (1):
      myri10ge: fix sleeping with bh disabled

Stephen Boyd (2):
      Merge tag 'imx-clk-fixes-4.6' of git://git.kernel.org/.../shawnguo/li=
nux into clk-fixes
      ASoC: ak4642: Remove CLK_IS_ROOT

Stephen Rothwell (1):
      ASoC: Intel: fix up for DAI link's be_id change

Steve Capper (1):
      mm: exclude HugeTLB pages from THP page_mapped() logic

Steve Wise (3):
      iw_cxgb4: initialize ibdev.iwcm->ifname for port mapping
      iw_cxgb3: initialize ibdev.iwcm->ifname for port mapping
      iw_cxgb4: handle draining an idle qp

Subhransu S. Prusty (9):
      ALSA: hda - add helper to get channels from cap bits
      ASoC: hdac_hdmi: parse eld for channel map capability
      ASoC: hdac_hdmi: Add multichannel support
      ASoC: skl_rt286: Fix to support hdmi channel map support
      ASoC: Intel: boards: Update skl_nau88l25_max98357a driver to support =
chmap
      ASoC: Intel: boards: Update skl_nau88l25_ssm4567 driver to support ch=
map
      ASoC: hdac_hdmi: Register chmap controls and ops
      ASoC: Intel: Skylake: Add multichannel support for HDMI
      ASoC: Intel: Skylake: Update channel map based on runtime params

Sudeep Holla (2):
      drivers: firmware: psci: unify enable-method binding on ARM {64,32}-b=
it systems
      cpufreq: st: enable selective initialization based on the platform

Sven Eckelmann (5):
      batman-adv: Check skb size before using encapsulated ETH+VLAN header
      batman-adv: Deactivate TO_BE_ACTIVATED hardif on shutdown
      batman-adv: Reduce refcnt of removed router when updating route
      batman-adv: Fix reference counting of vlan object for tt_local_entry
      batman-adv: Fix reference counting of hardif_neigh_node object for ne=
igh_node

Tal Shorer (1):
      usb: musb: gadget: nuke endpoint before setting its descriptor to NULL

Tanmay Jagdale (1):
      i2c: xlp9xx: add support for Broadcom Vulcan

Tejun Heo (2):
      cgroup, cpuset: replace cpuset_post_attach_flush() with cgroup_subsys=
->post_attach callback
      memcg: relocate charge moving from ->attach to ->post_attach

Tim Bingham (1):
      net: Implement net_dbg_ratelimited() for CONFIG_DYNAMIC_DEBUG case

Timur Tabi (1):
      net: phy: at803x: only the AT8030 needs a hardware reset on link chan=
ge

Tomi Valkeinen (2):
      ARM: dts: omap5-board-common: fix ldo1_reg and ldo4_reg ranges
      ARM: dts: omap5-cm-t54: fix ldo1_reg and ldo4_reg ranges

Tony Lindgren (4):
      ARM: dts: Add clocks for dm814x ADPLL
      Merge branch 'fixes-rc2' into omap-for-v4.6/fixes
      Merge tag 'for-v4.6-rc/omap-fixes-b' of git://git.kernel.org/.../pjw/=
omap-pending into omap-for-v4.6/fixes
      Revert "ARM: OMAP: Catch callers of revision information prior to it =
being populated"

Tony Luck (1):
      EDAC: i7core, sb_edac: Don't return NOTIFY_BAD from mce_decoder callb=
ack

Ville Syrj=C3=A4l=C3=A4 (2):
      drm/i915: Make RPS EI/thresholds multiple of 25 on SNB-BDW
      gpiolib-acpi: Duplicate con_id string when adding it to the crs looku=
p list

Vineet Gupta (3):
      ARC: Add missing io barriers to io{read,write}{16,32}be()
      ARC: Fix PAE40 boot failures due to PTE truncation
      ARC: support HIGHMEM even without PAE40

Vinod Koul (6):
      ASoC: Intel: Atom: fix boot warning
      ASoC: rt298: fix null deref on acpi driver data
      ASoC: rt298: Add DMI match for Broxton-P reference platform
      ALSA: hdac: add link pm and ref counting
      ASoC: Intel: Skylake: add link management
      ASoC: hdac_hdmi: add link management

Viresh Kumar (1):
      PM / OPP: Remove useless check

Vitaly Prosyak (1):
      drm/radeon: fix vertical bars appear on monitor (v2)

Vladimir Murzin (1):
      ARM: 8573/1: domain: move {set,get}_domain under config guard

Vladimir Zapolskiy (2):
      usb: musb: jz4740: fix error check of usb_get_phy()
      rapidio: fix potential NULL pointer dereference

Vladis Dronov (1):
      [media] usbvision: revert commit 588afcc1

Vlastimil Babka (2):
      mm: wake kcompactd before kswapd's short sleep
      mm: fix kcompactd hang during memory offlining

Wang Shanker (1):
      net: l2tp: fix reversed udp6 checksum flags

Wang YanQing (1):
      x86/sysfb_efi: Fix valid BAR address range check

Woojung Huh (2):
      lan78xx: fix statistics counter error
      lan78xx: workaround of forced 100 Full/Half duplex mode error

Xishi Qiu (1):
      Documentation/sysctl/vm.txt: update numa_zonelist_order description

Yakir Yang (1):
      i2c: rk3x: add support for rk3228

Yang Shi (1):
      mm: thp: correct split_huge_pages file permission

Yury Norov (1):
      asm-generic: use compat version for preadv2 and pwritev2

cpaul@redhat.com (1):
      drm/dp/mst: Get validated port ref in drm_dp_update_payload_part1()

xuejiufei (1):
      ocfs2/dlm: return zero if deref_done message is successfully handled

 .mailmap                                           |   5 +
 .../devicetree/bindings/arc/archs-pct.txt          |   2 +-
 Documentation/devicetree/bindings/arc/pct.txt      |   2 +-
 Documentation/devicetree/bindings/arm/cpus.txt     |   1 -
 .../devicetree/bindings/ata/ahci-platform.txt      |   4 +
 Documentation/devicetree/bindings/i2c/i2c-rk3x.txt |   4 +-
 Documentation/devicetree/bindings/net/cpsw.txt     |   6 +-
 .../devicetree/bindings/sound/davinci-mcbsp.txt    |  51 +++
 .../devicetree/bindings/sound/fsl-sai.txt          |   9 +-
 .../devicetree/bindings/sound/pcm5102a.txt         |  13 +
 Documentation/networking/altera_tse.txt            |   6 +-
 Documentation/networking/ipvlan.txt                |   6 +-
 Documentation/networking/pktgen.txt                |   6 +-
 Documentation/networking/vrf.txt                   |   2 +-
 Documentation/networking/xfrm_sync.txt             |   6 +-
 Documentation/sysctl/vm.txt                        |  19 +-
 MAINTAINERS                                        |  77 ++--
 Makefile                                           |   4 +-
 arch/arc/Kconfig                                   |  15 +
 arch/arc/include/asm/io.h                          |  27 +-
 arch/arc/include/asm/irqflags-arcv2.h              |  36 +-
 arch/arc/include/asm/mmzone.h                      |  43 ++
 arch/arc/include/asm/page.h                        |  15 +-
 arch/arc/include/asm/pgtable.h                     |  13 +-
 arch/arc/kernel/entry-arcv2.S                      |  10 +-
 arch/arc/kernel/entry-compact.S                    |   3 +
 arch/arc/mm/init.c                                 |  58 ++-
 arch/arm/boot/dts/am33xx.dtsi                      |   2 +-
 arch/arm/boot/dts/am4372.dtsi                      |   2 +-
 arch/arm/boot/dts/am57xx-beagle-x15.dts            |  17 -
 arch/arm/boot/dts/dm814x-clocks.dtsi               | 243 ++++++++++--
 arch/arm/boot/dts/dra62x-clocks.dtsi               |  26 ++
 arch/arm/boot/dts/dra7xx-clocks.dtsi               |  18 +-
 arch/arm/boot/dts/omap3-n900.dts                   |   9 +
 arch/arm/boot/dts/omap34xx.dtsi                    |   2 +-
 arch/arm/boot/dts/omap5-board-common.dtsi          |   4 +-
 arch/arm/boot/dts/omap5-cm-t54.dts                 |   4 +-
 arch/arm/boot/dts/omap5.dtsi                       |   2 +-
 arch/arm/boot/dts/qcom-apq8064.dtsi                |   3 +-
 arch/arm/boot/dts/qcom-msm8974.dtsi                |  14 +-
 arch/arm/boot/dts/r8a7791-koelsch.dts              |   1 +
 arch/arm/boot/dts/r8a7791-porter.dts               |  14 +-
 arch/arm/boot/dts/r8a7791.dtsi                     |   5 +-
 arch/arm/boot/dts/sun8i-q8-common.dtsi             |   2 -
 arch/arm/include/asm/domain.h                      |  11 +
 arch/arm/kernel/head-nommu.S                       |   2 +-
 arch/arm/kvm/mmu.c                                 |   2 +-
 arch/arm/mach-davinci/board-mityomapl138.c         |   5 +
 arch/arm/mach-davinci/common.c                     |   5 +
 arch/arm/mach-exynos/pm_domains.c                  |   2 +-
 .../mach-imx/devices/platform-sdhci-esdhc-imx.c    |   5 +-
 arch/arm/mach-omap2/clockdomains7xx_data.c         |   2 +-
 arch/arm/mach-omap2/io.c                           |   3 +-
 arch/arm/mach-omap2/omap-wakeupgen.c               |   7 +
 arch/arm/mach-omap2/pm34xx.c                       |  23 +-
 arch/arm/mach-shmobile/timer.c                     |  28 +-
 arch/arm/mach-socfpga/headsmp.S                    |   1 +
 arch/arm/mm/nommu.c                                |  15 +-
 arch/arm64/boot/dts/renesas/r8a7795.dtsi           |   1 -
 .../boot/dts/socionext/uniphier-ph1-ld20-ref.dts   |   1 -
 .../boot/dts/socionext/uniphier-ph1-ld20.dtsi      |  20 +-
 arch/nios2/lib/memset.c                            |   2 +-
 arch/parisc/kernel/syscall.S                       |   2 +-
 arch/powerpc/include/asm/systbl.h                  |   2 +
 arch/powerpc/include/asm/unistd.h                  |   2 +-
 arch/powerpc/include/asm/word-at-a-time.h          |   2 +-
 arch/powerpc/include/uapi/asm/unistd.h             |   2 +
 arch/s390/include/asm/mmu.h                        |   2 +-
 arch/s390/include/asm/mmu_context.h                |  28 +-
 arch/s390/include/asm/pgalloc.h                    |   4 +-
 arch/s390/include/asm/processor.h                  |   2 +-
 arch/s390/include/asm/tlbflush.h                   |   9 +-
 arch/s390/mm/init.c                                |   3 +-
 arch/s390/mm/mmap.c                                |   6 +-
 arch/s390/mm/pgalloc.c                             |  85 ++--
 arch/s390/pci/pci_dma.c                            |  16 +-
 arch/sparc/configs/sparc32_defconfig               |   1 -
 arch/sparc/configs/sparc64_defconfig               |   1 -
 arch/sparc/include/asm/spitfire.h                  |   1 +
 arch/sparc/include/uapi/asm/unistd.h               |   4 +-
 arch/sparc/kernel/cherrs.S                         |  14 +-
 arch/sparc/kernel/cpu.c                            |   6 +
 arch/sparc/kernel/cpumap.c                         |   1 +
 arch/sparc/kernel/fpu_traps.S                      |  11 +-
 arch/sparc/kernel/head_64.S                        |  32 +-
 arch/sparc/kernel/misctrap.S                       |  12 +-
 arch/sparc/kernel/pci.c                            |  42 +-
 arch/sparc/kernel/setup_64.c                       |   7 +-
 arch/sparc/kernel/spiterrs.S                       |  18 +-
 arch/sparc/kernel/systbls_32.S                     |   2 +-
 arch/sparc/kernel/systbls_64.S                     |   4 +-
 arch/sparc/kernel/utrap.S                          |   3 +-
 arch/sparc/kernel/vio.c                            |  18 +
 arch/sparc/kernel/vmlinux.lds.S                    |   4 +
 arch/sparc/kernel/winfixup.S                       |   3 +-
 arch/sparc/mm/init_64.c                            |   3 +
 arch/x86/events/amd/core.c                         |   2 +-
 arch/x86/events/amd/iommu.c                        |   1 +
 arch/x86/events/intel/core.c                       |   3 +
 arch/x86/events/intel/lbr.c                        |   6 +-
 arch/x86/events/intel/pt.c                         |  75 +++-
 arch/x86/events/intel/pt.h                         |   3 +
 arch/x86/events/intel/rapl.c                       |   1 +
 arch/x86/include/asm/perf_event.h                  |   4 +
 arch/x86/kernel/apic/vector.c                      |   3 +-
 arch/x86/kernel/apic/x2apic_uv_x.c                 |   4 +-
 arch/x86/kernel/head_32.S                          |   6 -
 arch/x86/kernel/sysfb_efi.c                        |  14 +-
 arch/x86/kernel/tsc_msr.c                          |   2 +-
 arch/x86/kvm/mmu.c                                 |   4 +-
 arch/x86/kvm/vmx.c                                 |   4 +
 arch/x86/mm/setup_nx.c                             |   5 +-
 arch/x86/platform/efi/efi-bgrt.c                   |  18 +-
 arch/x86/xen/spinlock.c                            |   6 +
 drivers/acpi/acpica/dsmethod.c                     |   3 +
 drivers/acpi/nfit.c                                |   5 +-
 drivers/ata/Kconfig                                |   8 +
 drivers/ata/Makefile                               |   1 +
 drivers/ata/ahci_platform.c                        |   3 +
 drivers/ata/ahci_seattle.c                         | 210 ++++++++++
 drivers/ata/libahci.c                              |   1 +
 drivers/base/power/opp/core.c                      |   3 -
 drivers/base/property.c                            |   2 +-
 drivers/block/rbd.c                                |  52 ++-
 drivers/clk/imx/clk-imx6q.c                        |   2 +-
 drivers/cpufreq/cpufreq.c                          |  26 +-
 drivers/cpufreq/cpufreq_governor.c                 |   8 +-
 drivers/cpufreq/intel_pstate.c                     |  31 +-
 drivers/cpufreq/sti-cpufreq.c                      |   4 +
 drivers/cpuidle/cpuidle-arm.c                      |   2 +-
 drivers/crypto/talitos.c                           |  87 +++--
 drivers/edac/i7core_edac.c                         |   2 +-
 drivers/edac/sb_edac.c                             |   2 +-
 drivers/firmware/efi/vars.c                        |  37 +-
 drivers/firmware/psci.c                            |   2 +-
 drivers/firmware/qemu_fw_cfg.c                     |   2 +-
 drivers/gpio/gpio-rcar.c                           |  65 +---
 drivers/gpio/gpiolib-acpi.c                        |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c   |  11 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |   8 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c         |   1 +
 drivers/gpu/drm/amd/amdgpu/atombios_encoders.c     |   4 +
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c              |   5 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c              |   5 +-
 drivers/gpu/drm/drm_dp_mst_topology.c              |  20 +
 drivers/gpu/drm/etnaviv/etnaviv_gpu.c              |  31 +-
 drivers/gpu/drm/i915/i915_drv.c                    |  32 +-
 drivers/gpu/drm/i915/i915_reg.h                    |   9 +-
 drivers/gpu/drm/i915/intel_ddi.c                   |  22 +-
 drivers/gpu/drm/i915/intel_display.c               |   3 +
 drivers/gpu/drm/i915/intel_dp.c                    |   4 +-
 drivers/gpu/drm/i915/intel_drv.h                   |   2 +
 drivers/gpu/drm/i915/intel_hdmi.c                  |  12 +-
 drivers/gpu/drm/radeon/atombios_encoders.c         |   4 +
 drivers/gpu/drm/radeon/evergreen.c                 | 154 +++++++-
 drivers/gpu/drm/radeon/evergreen_reg.h             |  46 +++
 drivers/gpu/drm/ttm/ttm_bo.c                       |  17 +-
 drivers/gpu/drm/virtio/virtgpu_display.c           |  12 +
 drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c            |  10 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_fb.c                 |   6 +-
 drivers/gpu/ipu-v3/ipu-common.c                    |   7 +-
 drivers/hid/hid-ids.h                              |   1 +
 drivers/hid/usbhid/hid-quirks.c                    |   1 +
 drivers/hid/wacom_wac.c                            |   6 +
 drivers/hv/ring_buffer.c                           |  26 +-
 drivers/i2c/busses/Kconfig                         |   4 +-
 drivers/i2c/busses/i2c-cpm.c                       |   4 +-
 drivers/i2c/busses/i2c-exynos5.c                   |  24 +-
 drivers/i2c/busses/i2c-ismt.c                      |   2 +
 drivers/i2c/busses/i2c-rk3x.c                      |   1 +
 drivers/iio/adc/at91-sama5d2_adc.c                 |   2 +
 drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c          |  30 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c          |   3 +-
 drivers/iio/magnetometer/ak8975.c                  |   6 +-
 drivers/infiniband/core/cache.c                    |   3 +-
 drivers/infiniband/core/ucm.c                      |   4 +
 drivers/infiniband/core/ucma.c                     |   3 +
 drivers/infiniband/core/uverbs_main.c              |   5 +
 drivers/infiniband/core/verbs.c                    |   3 +-
 drivers/infiniband/hw/cxgb3/iwch_provider.c        |   2 +
 drivers/infiniband/hw/cxgb4/cq.c                   |   2 +-
 drivers/infiniband/hw/cxgb4/provider.c             |   2 +
 drivers/infiniband/hw/cxgb4/qp.c                   |  24 +-
 drivers/infiniband/hw/mlx5/main.c                  |   6 +-
 drivers/infiniband/hw/nes/nes_nic.c                |   3 -
 drivers/infiniband/hw/qib/qib_file_ops.c           |   5 +
 drivers/infiniband/sw/rdmavt/qp.c                  |   4 +-
 drivers/infiniband/ulp/iser/iscsi_iser.c           |  14 +-
 drivers/input/misc/twl6040-vibra.c                 |  16 +-
 drivers/input/touchscreen/atmel_mxt_ts.c           |  28 +-
 drivers/input/touchscreen/zforce_ts.c              |   4 +-
 drivers/md/md.c                                    |   2 +
 drivers/md/raid0.c                                 |   2 +-
 drivers/md/raid5.c                                 |   2 -
 drivers/media/media-device.c                       |   8 +-
 drivers/media/platform/exynos4-is/media-dev.c      |  13 +-
 drivers/media/platform/s3c-camif/camif-core.c      |  12 +-
 drivers/media/usb/usbvision/usbvision-video.c      |   7 -
 drivers/media/v4l2-core/videobuf2-core.c           |  20 +-
 drivers/media/v4l2-core/videobuf2-memops.c         |   2 +-
 drivers/media/v4l2-core/videobuf2-v4l2.c           |  20 +-
 drivers/misc/cxl/context.c                         |   7 +
 drivers/misc/cxl/cxl.h                             |   2 +
 drivers/misc/cxl/irq.c                             |   1 -
 drivers/misc/cxl/native.c                          |  31 ++
 drivers/misc/mic/vop/vop_vringh.c                  |   5 +
 drivers/mmc/host/Kconfig                           |   1 +
 drivers/mmc/host/sdhci-acpi.c                      |  81 ++++
 drivers/mmc/host/sunxi-mmc.c                       |   5 +
 drivers/net/Kconfig                                |   5 +-
 drivers/net/dsa/mv88e6xxx.c                        |   2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c          |  53 ++-
 drivers/net/ethernet/broadcom/bnxt/bnxt.h          |  13 +
 drivers/net/ethernet/cadence/macb.c                |  34 +-
 drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c    |   3 +-
 drivers/net/ethernet/marvell/mvneta.c              |   6 +-
 drivers/net/ethernet/marvell/pxa168_eth.c          |   2 +
 drivers/net/ethernet/mellanox/mlx4/en_tx.c         |   6 +-
 drivers/net/ethernet/mellanox/mlx5/core/Kconfig    |   1 +
 drivers/net/ethernet/mellanox/mlx5/core/en.h       |   3 +-
 .../net/ethernet/mellanox/mlx5/core/en_ethtool.c   |   8 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c  | 106 +++--
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.c  |  48 +--
 drivers/net/ethernet/mellanox/mlx5/core/main.c     |  25 +-
 drivers/net/ethernet/mellanox/mlx5/core/port.c     |  10 +-
 drivers/net/ethernet/mellanox/mlx5/core/uar.c      |   6 +-
 drivers/net/ethernet/mellanox/mlx5/core/vport.c    |  40 ++
 drivers/net/ethernet/mellanox/mlx5/core/vxlan.c    |  50 ++-
 drivers/net/ethernet/mellanox/mlx5/core/vxlan.h    |  11 +-
 drivers/net/ethernet/myricom/myri10ge/myri10ge.c   |   4 +-
 drivers/net/ethernet/qlogic/qlcnic/qlcnic.h        |   4 +-
 drivers/net/ethernet/sfc/ef10.c                    |  15 +-
 .../net/ethernet/stmicro/stmmac/dwmac-socfpga.c    |  50 +--
 drivers/net/ethernet/ti/cpsw.c                     |  67 ++--
 drivers/net/ethernet/ti/cpsw.h                     |   1 +
 drivers/net/ethernet/ti/davinci_emac.c             |   5 +-
 drivers/net/ethernet/toshiba/ps3_gelic_wireless.c  |   2 +-
 drivers/net/macsec.c                               |  65 ++--
 drivers/net/phy/at803x.c                           |  40 +-
 drivers/net/usb/lan78xx.c                          |  44 ++-
 drivers/net/usb/pegasus.c                          |  10 +-
 drivers/net/usb/smsc75xx.c                         |  12 +-
 drivers/net/usb/smsc95xx.c                         |  12 +-
 drivers/net/wireless/ath/ath9k/ar5008_phy.c        |   8 +-
 drivers/net/wireless/ath/ath9k/ar9002_phy.c        |   5 -
 drivers/net/wireless/intel/iwlwifi/iwl-8000.c      |   2 +-
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c       |  26 +-
 drivers/net/wireless/intel/iwlwifi/mvm/fw-dbg.c    |   6 +-
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c        |   2 +
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c      |  10 +
 drivers/nvdimm/pmem.c                              |  13 +-
 drivers/nvmem/mxs-ocotp.c                          |   4 +-
 drivers/platform/x86/toshiba_acpi.c                |   2 +-
 drivers/rapidio/devices/rio_mport_cdev.c           | 119 +++---
 drivers/s390/char/sclp_ctl.c                       |  12 +-
 drivers/scsi/cxgbi/libcxgbi.c                      |   1 +
 drivers/soc/mediatek/mtk-scpsys.c                  |  11 +-
 drivers/staging/media/davinci_vpfe/vpfe_video.c    |  54 ++-
 drivers/staging/rdma/hfi1/TODO                     |   2 +-
 drivers/staging/rdma/hfi1/file_ops.c               |  91 ++---
 drivers/staging/rdma/hfi1/mmu_rb.c                 |  40 +-
 drivers/staging/rdma/hfi1/mmu_rb.h                 |   3 +-
 drivers/staging/rdma/hfi1/qp.c                     |   2 +
 drivers/staging/rdma/hfi1/user_exp_rcv.c           |  11 +-
 drivers/staging/rdma/hfi1/user_sdma.c              |  33 +-
 drivers/thermal/hisi_thermal.c                     |   4 +-
 drivers/thermal/thermal_core.c                     |   2 +-
 drivers/tty/pty.c                                  |  18 +-
 drivers/tty/tty_io.c                               |   6 +-
 drivers/usb/core/port.c                            |   6 -
 drivers/usb/core/usb.c                             |   8 +-
 drivers/usb/musb/jz4740.c                          |   4 +-
 drivers/usb/musb/musb_gadget.c                     |   6 +-
 drivers/usb/musb/musb_host.c                       |   2 +-
 drivers/usb/serial/cp210x.c                        |   4 +
 drivers/virtio/virtio_ring.c                       |   2 +-
 drivers/xen/balloon.c                              |  16 +
 drivers/xen/evtchn.c                               |  20 +-
 fs/ceph/mds_client.c                               |   6 +-
 fs/devpts/inode.c                                  |  53 +--
 fs/fuse/file.c                                     |   2 +-
 fs/ocfs2/dlm/dlmmaster.c                           |   2 +
 fs/pnode.c                                         |  25 +-
 fs/proc/base.c                                     |   3 +-
 fs/proc/task_mmu.c                                 |  33 +-
 fs/udf/super.c                                     |   4 +-
 fs/udf/udfdecl.h                                   |   2 +-
 fs/udf/unicode.c                                   |  16 +-
 include/acpi/acpi_bus.h                            |   4 +-
 include/linux/bpf.h                                |   3 +-
 include/linux/ceph/auth.h                          |  10 +-
 include/linux/ceph/osd_client.h                    |   1 -
 include/linux/cgroup-defs.h                        |   1 +
 include/linux/cpuset.h                             |   6 -
 include/linux/devpts_fs.h                          |   6 +-
 include/linux/hash.h                               |  20 +-
 include/linux/huge_mm.h                            |   5 +
 include/linux/if_ether.h                           |   5 +
 include/linux/lockdep.h                            |   8 +-
 include/linux/mfd/syscon/imx6q-iomuxc-gpr.h        |   6 +
 include/linux/mlx5/device.h                        |  11 +
 include/linux/mlx5/driver.h                        |   7 +-
 include/linux/mlx5/port.h                          |   6 +-
 include/linux/mlx5/vport.h                         |   2 +
 include/linux/mm.h                                 |   4 +
 include/linux/net.h                                |  10 +-
 include/linux/netdevice.h                          |   2 +-
 include/linux/of.h                                 |   2 +-
 include/linux/page-flags.h                         |  22 ++
 include/linux/swap.h                               |   4 +
 include/linux/tty_driver.h                         |   4 +-
 include/media/videobuf2-core.h                     |   8 +
 include/net/switchdev.h                            |   4 +
 include/net/vxlan.h                                |   4 +-
 include/rdma/ib.h                                  |  16 +
 include/sound/dmaengine_pcm.h                      |  12 +
 include/sound/hdaudio_ext.h                        |  13 +
 include/sound/hdmi-codec.h                         | 100 +++++
 include/sound/pcm_iec958.h                         |   2 +
 include/sound/soc-dapm.h                           |   3 +-
 include/sound/soc.h                                |   5 +-
 include/uapi/asm-generic/unistd.h                  |   4 +-
 include/uapi/linux/if_macsec.h                     |   4 +-
 include/{ =3D> uapi}/linux/rio_mport_cdev.h          | 144 +++----
 include/uapi/linux/swab.h                          |  24 +-
 include/uapi/linux/v4l2-dv-timings.h               |  30 +-
 include/xen/page.h                                 |   4 +-
 kernel/bpf/inode.c                                 |   7 +-
 kernel/bpf/syscall.c                               |  24 +-
 kernel/bpf/verifier.c                              |  77 ++--
 kernel/cgroup.c                                    |   7 +-
 kernel/cpuset.c                                    |   4 +-
 kernel/events/core.c                               |  55 ++-
 kernel/kcov.c                                      |   3 +-
 kernel/kexec_core.c                                |   7 +-
 kernel/locking/lockdep.c                           |  37 +-
 kernel/locking/lockdep_proc.c                      |   2 +
 kernel/sched/core.c                                |  29 +-
 kernel/trace/trace_events.c                        |   9 +-
 kernel/workqueue.c                                 |  29 ++
 lib/stackdepot.c                                   |  10 +-
 mm/compaction.c                                    |  14 +-
 mm/huge_memory.c                                   |  16 +-
 mm/memcontrol.c                                    |  37 +-
 mm/memory-failure.c                                |  10 +-
 mm/memory.c                                        |  51 ++-
 mm/migrate.c                                       |   8 +-
 mm/page-writeback.c                                |   6 +-
 mm/page_alloc.c                                    |   2 +-
 mm/page_io.c                                       |   6 +-
 mm/swap.c                                          |   5 +
 mm/vmscan.c                                        |  30 +-
 mm/zswap.c                                         |   8 +-
 net/batman-adv/bat_v.c                             |  12 +
 net/batman-adv/distributed-arp-table.c             |  17 +-
 net/batman-adv/hard-interface.c                    |   6 +-
 net/batman-adv/originator.c                        |  17 +-
 net/batman-adv/routing.c                           |   9 +
 net/batman-adv/send.c                              |   6 +
 net/batman-adv/soft-interface.c                    |   8 +-
 net/batman-adv/translation-table.c                 |  42 +-
 net/batman-adv/types.h                             |   7 +
 net/bridge/br_mdb.c                                | 124 +++---
 net/bridge/br_multicast.c                          |   8 +-
 net/bridge/br_private.h                            |   4 +-
 net/ceph/auth.c                                    |   8 +-
 net/ceph/auth_none.c                               |  71 ++--
 net/ceph/auth_none.h                               |   3 +-
 net/ceph/auth_x.c                                  |  21 +-
 net/ceph/auth_x.h                                  |   1 +
 net/ceph/osd_client.c                              |   6 +-
 net/core/dev.c                                     |   2 +-
 net/ipv4/fib_frontend.c                            |   6 +-
 net/ipv4/inet_hashtables.c                         |   2 +
 net/ipv4/ip_gre.c                                  |  30 +-
 net/ipv4/ip_tunnel.c                               |   4 +-
 net/ipv6/addrconf.c                                |  48 +--
 net/ipv6/ila/ila_lwt.c                             |   3 +-
 net/l2tp/l2tp_core.c                               |   4 +-
 net/mac80211/iface.c                               |   4 +-
 net/rds/tcp.c                                      |   3 +-
 net/rds/tcp.h                                      |   4 +
 net/rds/tcp_connect.c                              |   8 +
 net/rds/tcp_listen.c                               |  54 ++-
 net/sched/sch_netem.c                              |  61 ++-
 net/switchdev/switchdev.c                          |   6 +
 net/tipc/node.c                                    |   5 +
 samples/bpf/trace_output_kern.c                    |   1 -
 scripts/mod/file2alias.c                           |  69 ++--
 security/integrity/ima/ima_policy.c                |   4 +-
 sound/core/pcm_dmaengine.c                         |  11 +-
 sound/core/pcm_iec958.c                            |  65 +++-
 sound/hda/ext/hdac_ext_bus.c                       |   3 +
 sound/hda/ext/hdac_ext_controller.c                |  66 ++++
 sound/hda/local.h                                  |  10 +
 sound/soc/atmel/atmel_ssc_dai.c                    |   4 +-
 sound/soc/au1x/dbdma2.c                            |   4 +-
 sound/soc/bcm/bcm2835-i2s.c                        |  27 +-
 sound/soc/codecs/Kconfig                           |  10 +
 sound/soc/codecs/Makefile                          |   4 +
 sound/soc/codecs/ak4642.c                          |   4 +-
 sound/soc/codecs/arizona.c                         |  32 +-
 sound/soc/codecs/cs42l56.c                         |   2 +-
 sound/soc/codecs/cs47l24.c                         |  46 ++-
 sound/soc/codecs/da7213.c                          |  99 ++++-
 sound/soc/codecs/da7213.h                          |  35 +-
 sound/soc/codecs/da7218.c                          |  32 +-
 sound/soc/codecs/da7218.h                          |  21 +-
 sound/soc/codecs/da7219.c                          |  38 +-
 sound/soc/codecs/da7219.h                          |  20 +-
 sound/soc/codecs/es8328.c                          | 194 ++++++---
 sound/soc/codecs/es8328.h                          |  23 +-
 sound/soc/codecs/hdac_hdmi.c                       | 195 +++++++++-
 sound/soc/codecs/hdmi-codec.c                      | 432 +++++++++++++++++=
++++
 sound/soc/codecs/pcm5102a.c                        |  69 ++++
 sound/soc/codecs/rt298.c                           |  19 +-
 sound/soc/codecs/rt5645.c                          |  16 +-
 sound/soc/codecs/wm5102.c                          |   4 +
 sound/soc/codecs/wm5110.c                          |   6 +
 sound/soc/codecs/wm_adsp.c                         | 292 ++++++++++----
 sound/soc/codecs/wm_adsp.h                         |   1 +
 sound/soc/davinci/Kconfig                          |   6 +-
 sound/soc/davinci/davinci-i2s.c                    |  80 ++--
 sound/soc/davinci/davinci-mcasp.c                  |  92 +++--
 sound/soc/davinci/davinci-mcasp.h                  |   5 +
 sound/soc/dwc/designware_i2s.c                     |  14 +-
 sound/soc/fsl/fsl_sai.c                            |  24 +-
 sound/soc/fsl/fsl_ssi.c                            |  81 +++-
 sound/soc/fsl/imx-pcm-fiq.c                        |   2 +-
 sound/soc/intel/Kconfig                            |  16 +
 sound/soc/intel/atom/sst-atom-controls.c           |   2 +-
 sound/soc/intel/boards/Makefile                    |   2 +
 sound/soc/intel/boards/broadwell.c                 |   2 +-
 sound/soc/intel/boards/bxt_rt298.c                 | 353 +++++++++++++++++
 sound/soc/intel/boards/bytcr_rt5640.c              |   2 +-
 sound/soc/intel/boards/bytcr_rt5651.c              |   2 +-
 sound/soc/intel/boards/cht_bsw_max98090_ti.c       |   2 +-
 sound/soc/intel/boards/cht_bsw_rt5645.c            |   2 +-
 sound/soc/intel/boards/cht_bsw_rt5672.c            |   2 +-
 sound/soc/intel/boards/haswell.c                   |   2 +-
 sound/soc/intel/boards/skl_nau88l25_max98357a.c    |  87 ++++-
 sound/soc/intel/boards/skl_nau88l25_ssm4567.c      |  86 +++-
 sound/soc/intel/boards/skl_rt286.c                 |  59 ++-
 sound/soc/intel/common/sst-acpi.h                  |   9 +
 sound/soc/intel/haswell/sst-haswell-pcm.c          |   2 +-
 sound/soc/intel/skylake/Makefile                   |   2 +-
 sound/soc/intel/skylake/bxt-sst.c                  | 328 ++++++++++++++++
 sound/soc/intel/skylake/skl-messages.c             | 122 +++++-
 sound/soc/intel/skylake/skl-nhlt.c                 |  15 +-
 sound/soc/intel/skylake/skl-pcm.c                  | 119 +++++-
 sound/soc/intel/skylake/skl-sst-dsp.c              |   2 -
 sound/soc/intel/skylake/skl-sst-dsp.h              |  15 +-
 sound/soc/intel/skylake/skl-sst.c                  |  13 +-
 sound/soc/intel/skylake/skl-topology.c             |  27 +-
 sound/soc/intel/skylake/skl-topology.h             |   2 +-
 sound/soc/intel/skylake/skl-tplg-interface.h       |   2 +-
 sound/soc/intel/skylake/skl.c                      |  39 +-
 sound/soc/intel/skylake/skl.h                      |   6 +-
 sound/soc/rockchip/rockchip_i2s.c                  |  87 +++--
 sound/soc/soc-core.c                               |  14 +-
 sound/soc/soc-generic-dmaengine-pcm.c              |  57 +--
 461 files changed, 7248 insertions(+), 2394 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/davinci-mcbsp.t=
xt
 create mode 100644 Documentation/devicetree/bindings/sound/pcm5102a.txt
 create mode 100644 arch/arc/include/asm/mmzone.h
 create mode 100644 drivers/ata/ahci_seattle.c
 create mode 100644 include/sound/hdmi-codec.h
 rename include/{ =3D> uapi}/linux/rio_mport_cdev.h (74%)
 create mode 100644 sound/soc/codecs/hdmi-codec.c
 create mode 100644 sound/soc/codecs/pcm5102a.c
 create mode 100644 sound/soc/intel/boards/bxt_rt298.c
 create mode 100644 sound/soc/intel/skylake/bxt-sst.c

--vA66WO2vHvL/CRSR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXOarsAAoJECTWi3JdVIfQeHYH/0VdjIx3XS7YO7ANFCu42rvf
FEqBrNEE4p5MX3YqCd3CWhBWtRwJtZAp76fzLEjWVWiT1LYfJq4PmeEnVTyJ9Wus
K9bfiy5Mo3Ohxt9Q9UUQq5bkM3kU3Yty61kE00Z+iDHV+TgnMDdnqN4aQ8X3eqYE
vdgrWc9NSVCm0d44cpgnnSeM57TDcy5kCEyQ5lLA7i5hDW4Eh/Jzh/pTSDn0dNcD
cKEeYejhNpDmlRkMRBrd+sbY//F5M2kbAbEpJmrlTuWQ3IgC1wNghBJjiBRFDU8v
tJXR1NL0XlqcWunP6NZo0iUM3debVpSyOws8ybJUIJUMVk1hbeB22fHkqy8UOFI=
=e0nU
-----END PGP SIGNATURE-----

--vA66WO2vHvL/CRSR--

--===============8404745490696553811==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8404745490696553811==--
