From: Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] ASoC updates for v4.16
Date: Fri, 12 Jan 2018 12:57:51 +0000
Message-ID: <20180112125751.GB6606@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0862917775367633725=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id A4493266E07
 for <alsa-devel@alsa-project.org>; Fri, 12 Jan 2018 13:57:53 +0100 (CET)
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


--===============0862917775367633725==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mojUlQ0s9EVzWg2t"
Content-Disposition: inline


--mojUlQ0s9EVzWg2t
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The following changes since commit ba6c29592545635f7c476cbef0db0c4f39495f23:

  ASoC: TSCS42xx: Add support for Tempo Semiconductor's TSCS42xx audio CODE=
C (2018-01-05 12:37:41 +0000)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/as=
oc-v4.16-2

for you to fetch changes up to 4ac71d1b68365915bcde14d0ff8fda186ad377ac:

  Merge remote-tracking branches 'asoc/topic/wm8994', 'asoc/topic/wm8997' a=
nd 'asoc/topic/wm8998' into asoc-next (2018-01-12 12:29:46 +0000)

----------------------------------------------------------------
ASoC: Updates for v4.16

Some more updates for v4.16, the big things here are the ST DFSDM driver
and the IIO patches required to support that and even more in the
neverending series of code quality improvements for x86, including
Pierre's work to improve the Kconfig.  The unused SN95031 driver and
associated board support are also removed, they haven't been buildable
for a considerable time without anyone noticing.

----------------------------------------------------------------
Aaron Ma (1):
      Input: elantech - add new icbody type 15

Al Viro (2):
      sget(): handle failures of register_shrinker()
      fix "netfilter: xt_bpf: Fix XT_BPF_MODE_FD_PINNED mode of 'xt_bpf_inf=
o_v1'"

Alejandro Mery (3):
      ARM: davinci: Use platform_device_register_full() to create pdev for =
dm365's eDMA
      ARM: davinci: Add dma_mask to dm365's eDMA device
      ARM: davinci: fix mmc entries in dm365's dma_slave_map

Alexey Brodkin (2):
      ARC: Fix detection of dual-issue enabled
      ARC: [plat-hsdk] Switch DisplayLink driver from fbdev to DRM

Aliaksei Karaliou (2):
      xfs: quota: fix missed destroy of qi_tree_lock
      xfs: quota: check result of register_shrinker()

Andrea Arcangeli (1):
      userfaultfd: clear the vma->vm_userfaultfd_ctx if UFFD_EVENT_FORK fai=
ls

Andrew Morton (1):
      kernel/exit.c: export abort() to modules

Andrey Ryabinin (1):
      x86/mm: Set MODULES_END to 0xffffffffff000000

Anshuman Khandual (1):
      mm/mprotect: add a cond_resched() inside change_pmd_range()

Anthony Kim (1):
      Input: hideep - fix compile error due to missing include file

Antoine Tenart (3):
      crypto: inside-secure - free requests even if their handling failed
      crypto: inside-secure - fix request allocations in invalidation path
      crypto: inside-secure - do not use areq->result for partial results

Ard Biesheuvel (1):
      efi/capsule-loader: Reinstate virtual capsule mapping

Arnaud Pouliquen (12):
      docs: driver-api: add iio hw consumer section
      IIO: hw_consumer: add devm_iio_hw_consumer_alloc
      IIO: inkern: API for manipulating channel attributes
      IIO: Add DT bindings for sigma delta adc modulator
      IIO: ADC: add sigma delta modulator support
      IIO: add DT bindings for stm32 DFSDM filter
      IIO: ADC: add stm32 DFSDM core support
      IIO: ADC: add STM32 DFSDM sigma delta ADC support
      IIO: ADC: add stm32 DFSDM support for PDM microphone
      IIO: consumer: allow to set buffer sizes
      ASoC: add bindings for stm32 DFSDM filter
      ASoC: stm32: add DFSDM DAI support

Arnd Bergmann (13):
      Merge tag 'v4.15-rockchip-dts32fixes-1' of ssh://gitolite.kernel.org/=
=2E../mmind/linux-rockchip into fixes
      Merge tag 'v4.15-rockchip-dts64fixes-1' of ssh://gitolite.kernel.org/=
=2E../mmind/linux-rockchip into fixes
      Merge tag 'at91-ab-4.15-dt-fixes' of ssh://gitolite.kernel.org/.../ab=
elloni/linux into fixes
      Merge tag 'davinci-fixes-for-v4.15' of ssh://gitolite.kernel.org/.../=
nsekhar/linux-davinci into fixes
      ARM: dts: ls1021a: fix incorrect clock references
      ARM: dts: tango4: remove bogus interrupt-controller property
      crypto: chelsio - select CRYPTO_GF128MUL
      Merge tag 'renesas-fixes-for-v4.15' of ssh://gitolite.kernel.org/.../=
horms/renesas into fixes
      Merge tag 'sunxi-fixes-for-4.15' of ssh://gitolite.kernel.org/.../sun=
xi/linux into fixes
      ASoC: ux500: add MODULE_LICENSE tag
      ASoC: stm32: select IIO_BUFFER
      IIO: ADC: stm32-dfsdm: avoid unused-variable warning
      IIO: ADC: stm32-dfsdm: avoid unused-variable warning

Baoquan He (1):
      mm/sparse.c: wrong allocation for mem_section

Bard Liao (1):
      ASoC: mt8173: remove unnecessary micbias widget in route

Bogdan Mirea (2):
      arm64: dts: renesas: salvator-x: Remove renesas, no-ether-link proper=
ty
      arm64: dts: renesas: ulcb: Remove renesas, no-ether-link property

Boris Brezillon (1):
      mtd: nand: pxa3xx: Fix READOOB implementation

Chen-Yu Tsai (1):
      ARM: dts: sunxi: Convert to CCU index macros for HDMI controller

Chris Mason (1):
      btrfs: fix refcount_t usage when deleting btrfs_delayed_nodes

Christian Borntraeger (2):
      KVM: s390: fix cmma migration for multiple memory slots
      KVM: s390: prevent buffer overrun on memory hotplug during migration

Christophe JAILLET (2):
      ASoC: Intel: sst: Fix the return value of 'sst_send_byte_stream_mrfld=
()'
      ASoC: Intel: sst: Fix some style

Colin Ian King (1):
      ASoC: TSCS42xx: make functions pll_event and dac_event static

Dan Carpenter (1):
      afs: Potential uninitialized variable in afs_extract_data()

Darrick J. Wong (1):
      xfs: fix s_maxbytes overflow problems

Dave Airlie (4):
      Merge tag 'omapdrm-4.15-fixes' of git://git.kernel.org/.../tomba/linu=
x into drm-fixes
      Merge branch 'drm-armada-fixes-4.15' of git://git.armlinux.org.uk/~rm=
k/linux-arm into drm-fixes
      Merge branch 'drm-fixes-4.15' of git://people.freedesktop.org/~agd5f/=
linux into drm-fixes
      Merge tag 'drm-intel-fixes-2018-01-04' of git://anongit.freedesktop.o=
rg/drm/drm-intel into drm-fixes

Dave Young (2):
      x86/efi: Fix kernel param add_efi_memmap regression
      mm: check pfn_valid first in zero_resv_unavail

David Howells (3):
      fscache: Fix the default for fscache_maybe_release_page()
      afs: Fix unlink
      afs: Fix missing error handling in afs_write_end()

David Lechner (1):
      ARM: dts: da850-lego-ev3: Fix battery voltage gpio

David Woodhouse (1):
      x86/alternatives: Add missing '\n' at end of ALTERNATIVE inline asm

Dhinakaran Pandiyan (1):
      drm/i915/psr: Fix register name mess up.

Dmitry Torokhov (1):
      Input: elants_i2c - do not clobber interrupt trigger on x86

Eric Biggers (3):
      crypto: chacha20poly1305 - validate the digest size
      crypto: pcrypt - fix freeing pcrypt instances
      capabilities: fix buffer overread on very short xattr

Eric W. Biederman (1):
      pid: Handle failure to allocate the first pid in a pid namespace

Eugeniy Paltsev (4):
      ARC: [plat-hsdk]: Set initial core pll output frequency
      ARC: [plat-hsdk]: Get rid of core pll frequency set in platform code
      ARC: [plat-axs103]: Set initial core pll output frequency
      ARC: [plat-axs103] refactor the quad core DT quirk code

Guenter Roeck (1):
      ASoC: fsl_ssi: Fix build error

Hans Verkuil (1):
      omapdrm/dss/hdmi4_cec: fix interrupt handling

Heiko Carstens (1):
      s390/sclp: disable FORTIFY_SOURCE for early sclp code

Heiko Stuebner (3):
      ARM: dts: rockchip: add cpu0-regulator on rk3066a-marsboard
      arm64: dts: rockchip: fix trailing 0 in rk3328 tsadc interrupts
      arm64: dts: rockchip: limit rk3328-rock64 gmac speed to 100MBit for n=
ow

Helge Deller (6):
      parisc: Show unhashed hardware inventory
      parisc: Show initial kernel memory layout unhashed
      parisc: Show unhashed HPA of Dino chip
      parisc: Show unhashed EISA EEPROM address
      parisc: Fix alignment of pa_tlb_lock in assembly on 32-bit SMP kernel
      parisc: qemu idle sleep support

Icenowy Zheng (1):
      arm64: allwinner: a64: add Ethernet PHY regulator for several boards

Jacek Anaszewski (1):
      leds: core: Fix regression caused by commit 2b83ff96f51d

Jagan Teki (1):
      arm64: allwinner: a64-sopine: Fix to use dcdc1 regulator instead of v=
cc3v3

James Hogan (1):
      lib/mpi: Fix umul_ppmm() for MIPS64r6

Jan Engelhardt (1):
      crypto: n2 - cure use after free

Javier Martinez Canillas (1):
      ARM: dts: exynos: Enable Mixer node for Exynos5800 Peach Pi machine

Jean-Philippe Brucker (1):
      iommu/arm-smmu-v3: Don't free page table ops twice

Jeffy Chen (1):
      mailmap: update Mark Yao's email address

Jeremy Cline (1):
      ASoC: Replace snd_soc_acpi_check_hid with acpi_dev_present

Jim Mattson (1):
      kvm: vmx: Scrub hardware GPRs at VM-exit

Joel Stanley (1):
      ARM: dts: aspeed-g4: Correct VUART IRQ number

John Johansen (1):
      apparmor: fix regression in mount mediation when feature set is pinned

John Keeping (1):
      ASoC: rockchip: i2s: fix playback after runtime resume

John Sperbeck (1):
      powerpc/mm: Fix SEGV on mapped region to return SEGV_ACCERR

Jonathan Cameron (1):
      crypto: af_alg - Fix race around ctx->rcvused by making it atomic_t

Josh Poimboeuf (2):
      x86/dumpstack: Fix partial register dumps
      x86/dumpstack: Print registers for first stack frame

Kees Cook (1):
      exec: Weaken dumpability for secureexec

Keyon Jie (1):
      ASoC: Intel: bytcr-rt5651: add quirk for IN3P which may also be used

Klaus Goger (1):
      arm64: dts: rockchip: remove vdd_log from rk3399-puma

Lars-Peter Clausen (1):
      iio: Add hardware consumer buffer support

Linus Torvalds (26):
      Merge branch 'for-linus' of git://git.kernel.org/.../jmorris/linux-se=
curity
      Merge branch 'afs-fixes' of git://git.kernel.org/.../dhowells/linux-fs
      Merge branch 'for-linus' of git://git.kernel.org/.../ebiederm/user-na=
mespace
      Merge branch 'x86-pti-for-linus' of git://git.kernel.org/.../tip/tip
      Merge tag 'armsoc-fixes' of git://git.kernel.org/.../arm/arm-soc
      Merge tag 'drm-fixes-for-v4.15-rc7' of git://people.freedesktop.org/~=
airlied/linux
      Merge branch 'akpm' (patches from Andrew)
      Merge branch 'linus' of git://git.kernel.org/.../herbert/crypto-2.6
      Merge tag 'for-linus-4.15-rc7-tag' of git://git.kernel.org/.../xen/tip
      Merge branch 'for-linus' of git://git.kernel.org/.../s390/linux
      Merge branch 'efi-urgent-for-linus' of git://git.kernel.org/.../tip/t=
ip
      Merge branch 'x86-pti-for-linus' of git://git.kernel.org/.../tip/tip
      Merge tag 'mfd-fixes-4.15-1' of git://git.kernel.org/.../lee/mfd
      Merge tag 'xfs-4.15-fixes-10' of git://git.kernel.org/pub/scm/fs/xfs/=
xfs-linux
      Merge tag 'for-4.15-rc7-tag' of git://git.kernel.org/.../kdave/linux
      Merge tag 'arc-4.15-rc7' of git://git.kernel.org/.../vgupta/arc
      Merge tag 'iommu-v4.15-rc7' of git://github.com/awilliam/linux-vfio
      Merge branch 'for-linus' of git://git.kernel.org/.../dtor/input
      Merge tag 'powerpc-4.15-6' of git://git.kernel.org/.../powerpc/linux
      Merge tag 'for-linus' of git://git.kernel.org/pub/scm/virt/kvm/kvm
      Merge branch 'for-linus' of git://git.kernel.org/.../viro/vfs
      Merge tag 'for-linus-20180107' of git://git.infradead.org/linux-mtd
      Merge tag 'led_fixes_for_4.15-rc7' of git://git.kernel.org/.../j.anas=
zewski/linux-leds
      Merge tag 'apparmor-pr-2018-01-07' of git://git.kernel.org/.../jj/lin=
ux-apparmor
      Merge branch 'parisc-4.15-3' of git://git.kernel.org/.../deller/paris=
c-linux
      Linux 4.15-rc7

Lucas De Marchi (1):
      drm/i915: Apply Display WA #1183 on skl, kbl, and cfl

Mark Brown (29):
      Merge branch 'fix/intel' of https://git.kernel.org/.../broonie/sound =
into asoc-intel
      Merge branch 'topic/iio' of https://git.kernel.org/.../broonie/sound =
into asoc-st-dfsdm
      Merge remote-tracking branch 'asoc/fix/intel' into asoc-linus
      Merge remote-tracking branch 'asoc/fix/rockchip' into asoc-linus
      Merge remote-tracking branch 'asoc/fix/mtk' into asoc-linus
      Merge remote-tracking branch 'asoc/topic/core' into asoc-next
      Merge remote-tracking branch 'asoc/topic/intel' into asoc-next
      Merge remote-tracking branch 'asoc/topic/pcm186x' into asoc-next
      Merge remote-tracking branch 'asoc/topic/pcm512x' into asoc-next
      Merge remote-tracking branch 'asoc/topic/qcom' into asoc-next
      Merge remote-tracking branch 'asoc/topic/rcar' into asoc-next
      Merge remote-tracking branch 'asoc/topic/rockchip' into asoc-next
      Merge remote-tracking branches 'asoc/topic/88pm860x', 'asoc/topic/amd=
', 'asoc/topic/atmel', 'asoc/topic/codecs' and 'asoc/topic/compress' into a=
soc-next
      Merge remote-tracking branches 'asoc/topic/cq93vc', 'asoc/topic/cs35l=
32', 'asoc/topic/cs35l34' and 'asoc/topic/cs42l52' into asoc-next
      Merge remote-tracking branches 'asoc/topic/cs42l56', 'asoc/topic/cs42=
l73', 'asoc/topic/cs47l24', 'asoc/topic/cx20442' and 'asoc/topic/da7213' in=
to asoc-next
      Merge remote-tracking branches 'asoc/topic/da7218', 'asoc/topic/dai-d=
rv', 'asoc/topic/davinci', 'asoc/topic/disconnect' and 'asoc/topic/ep93xx' =
into asoc-next
      Merge remote-tracking branches 'asoc/topic/eukrea-tlv320', 'asoc/topi=
c/fsl', 'asoc/topic/fsl-ssi' and 'asoc/topic/fsl_asrc' into asoc-next
      Merge remote-tracking branches 'asoc/topic/hdac_hdmi', 'asoc/topic/hi=
silicon', 'asoc/topic/iio' and 'asoc/topic/max98373' into asoc-next
      Merge remote-tracking branches 'asoc/topic/max98926', 'asoc/topic/max=
98927', 'asoc/topic/mc13783', 'asoc/topic/msm8916' and 'asoc/topic/mt8173' =
into asoc-next
      Merge remote-tracking branches 'asoc/topic/mtk', 'asoc/topic/nau8540'=
, 'asoc/topic/nau8824', 'asoc/topic/nau8825' and 'asoc/topic/nuc900' into a=
soc-next
      Merge remote-tracking branch 'asoc/topic/rl6231' into asoc-next
      Merge remote-tracking branches 'asoc/topic/rt5514', 'asoc/topic/rt564=
5', 'asoc/topic/samsung' and 'asoc/topic/si476x' into asoc-next
      Merge remote-tracking branches 'asoc/topic/simple', 'asoc/topic/spdif=
', 'asoc/topic/st-dfsdm', 'asoc/topic/stm32' and 'asoc/topic/sun4i-i2s' int=
o asoc-next
      Merge remote-tracking branches 'asoc/topic/sunxi', 'asoc/topic/symmet=
ry', 'asoc/topic/tas5720', 'asoc/topic/tas6424' and 'asoc/topic/tfa9879' in=
to asoc-next
      Merge remote-tracking branches 'asoc/topic/tlv320aic31xx', 'asoc/topi=
c/tlv320aic32x4', 'asoc/topic/tlv320aic3x', 'asoc/topic/tlv320dac33' and 'a=
soc/topic/ts3a227e' into asoc-next
      Merge remote-tracking branches 'asoc/topic/tscs42xx', 'asoc/topic/twl=
4030', 'asoc/topic/twl6040' and 'asoc/topic/uda1380' into asoc-next
      Merge remote-tracking branches 'asoc/topic/uniphier', 'asoc/topic/uti=
ls', 'asoc/topic/ux500', 'asoc/topic/wm0010' and 'asoc/topic/wm2000' into a=
soc-next
      Merge remote-tracking branches 'asoc/topic/wm5102', 'asoc/topic/wm511=
0', 'asoc/topic/wm8350', 'asoc/topic/wm8400' and 'asoc/topic/wm8903' into a=
soc-next
      Merge remote-tracking branches 'asoc/topic/wm8994', 'asoc/topic/wm899=
7' and 'asoc/topic/wm8998' into asoc-next

Markus Heiser (1):
      docs: fix, intel_guc_loader.c has been moved to intel_guc_fw.c

Martin Schwidefsky (1):
      s390: fix preemption race in disable_sacf_uaccess

Masahiro Yamada (1):
      arm64: dts: uniphier: fix gpio-ranges property of PXs3 SoC

Matt Fleming (1):
      MAINTAINERS: Remove Matt Fleming as EFI co-maintainer

Matthew Wilcox (1):
      mm/debug.c: provide useful debugging information for VM_BUG

Matthias Kaehlcke (2):
      ASoC: rockchip: i2s: Support mono capture
      ASoC: codecs: dmic: Make number of channels configurable

Maxime Ripard (1):
      ARM: dts: sun8i: a711: Reinstate the PMIC compatible

Nick Desaulniers (1):
      x86/process: Define cpu_tss_rw in same section as declaration

Nikolay Borisov (1):
      btrfs: Fix flush bio leak

Ofer Heifetz (1):
      crypto: inside-secure - per request invalidation

Oleg Nesterov (1):
      kernel/acct.c: fix the acct->needcheck check in check_free_space()

Oleksandr Andrushchenko (1):
      Input: xen-kbdfront - do not advertise multi-touch pressure support

Olof Johansson (1):
      Input: joystick/analog - riscv has get_cycles()

Peter Rosin (1):
      ARM: dts: at91: disable the nxp,se97b SMBUS timeout on the TSE-850

Peter Zijlstra (1):
      x86/events/intel/ds: Use the proper cache flush method for mapping ds=
 buffers

Pierre-Louis Bossart (13):
      ASoC: acpi: fix machine driver selection based on quirk
      ASoC: acpi: add missing includes for non-ACPI platforms
      ASoC: Intel: bytcr_rt5651: fix Kiano DMI quirk
      ASoC: Intel: bytcr-rt5651: enable MinnowBoard Turbot quirks
      ASoC: Intel: bytcr-rt5651: add support for Line In
      ASoC: Intel: Fix Kconfig with top-level selector
      ASoC: Intel: Kconfig: Simplify-clarify ACPI/PCI dependencies
      ASoC: Intel: document what Kconfig options do
      ASoC: Intel: Fix nested/unnecessary Kconfig dependencies
      ASoC: Intel: boards: align Kconfig dependencies for Haswell/Broadwell
      ASoC: Intel: boards: align Kconfig configurations for HiFi2
      ASoC: Intel: boards: align/fix SKL/BXT/KBL Kconfigs
      ASoC: rt5645: add fallback case for jack detection support

Radim Kr=C4=8Dm=C3=A1=C5=99 (1):
      Merge tag 'kvm-s390-master-4.15-2' of git://git.kernel.org/.../kvms39=
0/linux

Randy Dunlap (1):
      documentation/gpu/i915: fix docs build error after file rename

Rob Herring (1):
      ARM: dts: rockchip: fix rk3288 iep-IOMMU interrupts property cells

Robin Murphy (1):
      iommu/arm-smmu-v3: Cope with duplicated Stream IDs

Russell King (5):
      drm/armada: fix leak of crtc structure
      drm/armada: fix SRAM powerdown
      drm/armada: fix UV swap code
      drm/armada: improve efficiency of armada_drm_plane_calc_addrs()
      drm/armada: fix YUV planar format framebuffer offsets

Ryan Lee (3):
      ASoC: max98373: Added missing blank lines
      ASoC: max98373: Added TDM off if parameters are all zeroes
      ASoC: max98373: Modified control names for TLV controls

Sebastian Ott (1):
      s390/pci: handle insufficient resources during dma tlb flush

Sergey Matyukevich (1):
      arm64: dts: orange-pi-zero-plus2: fix sdcard detect

Sergey Senozhatsky (2):
      arc: do not use __print_symbol()
      mm/zsmalloc.c: include fs.h

Sinan Kaya (1):
      mfd: rtsx: Release IRQ during shutdown

Stefan Br=C3=BCns (1):
      sunxi-rsb: Include OF based modalias in device uevent

Stefan Haberland (1):
      s390/dasd: fix wrongly assigned configuration data

Steven Eckhoff (1):
      ASoC: TSCS42xx: Fix control names

Tetsuo Handa (1):
      mm,vmscan: Make unregister_shrinker() no-op if register_shrinker() fa=
iled.

Thomas Gleixner (7):
      x86/pti: Enable PTI by default
      x86/pti: Make sure the user/kernel PTEs match
      x86/pti: Switch to kernel CR3 at early in entry_SYSCALL_compat()
      x86/mm: Map cpu_entry_area at the same place on 4/5 level
      x86/kaslr: Fix the vaddr_end mess
      x86/tlb: Drop the _GPL from the cpu_tlbstate export
      x86/pti: Rename BUG_CPU_INSECURE to BUG_CPU_MELTDOWN

Tom Lendacky (1):
      x86/cpu, x86/pti: Do not enable PTI on AMD processors

Ville Syrj=C3=A4l=C3=A4 (2):
      drm/i915: Disable DC states around GMBUS on GLK
      drm/i915: Put all non-blocking modesets onto an ordered wq

Vineet Gupta (3):
      ARC: uaccess: dont use "l" gcc inline asm constraint modifier
      ARC: handle gcc generated __builtin_trap()
      ARC: handle gcc generated __builtin_trap for older compiler

Vinod Koul (4):
      ASoC: Intel: kconfig: add some comments for if symbols
      ASoC: Intel: kconfig: drop boiler plate text from config items
      ASoC: Intel: remove mfld_machine
      ASoC: sn95031: remove this code

Wei Yongjun (4):
      xen/pvcalls: use GFP_ATOMIC under spin lock
      ASoC: mediatek: mt2701: fix return value check in mt2701_afe_pcm_dev_=
probe()
      ASoC: stm32: fix a typo in stm32_adfsdm_probe()
      IIO: ADC: fix return value check in stm32_dfsdm_adc_probe()

Xiongwei Song (1):
      drm/ttm: check the return value of kzalloc

Yue Hin Lau (1):
      drm/amd/display: call set csc_default if enable adjustment is false

Zhen Lei (1):
      Input: ims-pcu - fix typo in the error message

kbuild test robot (1):
      IIO: ADC: stm32_dfsdm_stop_filter() can be static

 .mailmap                                           |    1 +
 .../ABI/testing/sysfs-bus-iio-dfsdm-adc-stm32      |   16 +
 Documentation/admin-guide/kernel-parameters.rst    |    1 +
 Documentation/admin-guide/kernel-parameters.txt    |   18 +-
 Documentation/admin-guide/thunderbolt.rst          |    2 +-
 Documentation/arm64/silicon-errata.txt             |    1 +
 Documentation/cgroup-v2.txt                        |    7 +
 Documentation/core-api/genericirq.rst              |   16 +-
 Documentation/devicetree/bindings/arm/ccn.txt      |    2 +-
 .../devicetree/bindings/arm/omap/crossbar.txt      |    2 +-
 .../bindings/arm/tegra/nvidia,tegra20-mc.txt       |    2 +-
 .../devicetree/bindings/clock/axi-clkgen.txt       |    2 +-
 .../bindings/clock/brcm,bcm2835-aux-clock.txt      |    2 +-
 .../devicetree/bindings/clock/exynos4-clock.txt    |    2 +-
 .../devicetree/bindings/clock/exynos5250-clock.txt |    2 +-
 .../devicetree/bindings/clock/exynos5410-clock.txt |    2 +-
 .../devicetree/bindings/clock/exynos5420-clock.txt |    2 +-
 .../devicetree/bindings/clock/exynos5440-clock.txt |    2 +-
 .../bindings/clock/ti-keystone-pllctrl.txt         |    2 +-
 .../devicetree/bindings/clock/zx296702-clk.txt     |    4 +-
 .../devicetree/bindings/crypto/fsl-sec4.txt        |    4 +-
 .../bindings/devfreq/event/rockchip-dfi.txt        |    2 +-
 .../devicetree/bindings/display/atmel,lcdc.txt     |    4 +-
 .../devicetree/bindings/dma/qcom_hidma_mgmt.txt    |    4 +-
 Documentation/devicetree/bindings/dma/zxdma.txt    |    2 +-
 Documentation/devicetree/bindings/eeprom/at25.txt  |   13 +-
 .../devicetree/bindings/gpio/gpio-altera.txt       |    2 +-
 .../devicetree/bindings/gpio/gpio-pca953x.txt      |    2 +-
 Documentation/devicetree/bindings/hwmon/jc42.txt   |    4 +
 .../devicetree/bindings/i2c/i2c-jz4780.txt         |    2 +-
 .../bindings/iio/adc/sigma-delta-modulator.txt     |   13 +
 .../bindings/iio/adc/st,stm32-dfsdm-adc.txt        |  128 ++
 .../devicetree/bindings/iio/pressure/hp03.txt      |    2 +-
 .../bindings/input/touchscreen/bu21013.txt         |    2 +-
 .../bindings/interrupt-controller/arm,gic.txt      |    4 +-
 .../interrupt-controller/img,meta-intc.txt         |    2 +-
 .../bindings/interrupt-controller/img,pdc-intc.txt |    2 +-
 .../interrupt-controller/st,spear3xx-shirq.txt     |    2 +-
 .../devicetree/bindings/mailbox/altera-mailbox.txt |    6 +-
 .../bindings/mailbox/brcm,iproc-pdc-mbox.txt       |    2 +-
 .../devicetree/bindings/media/exynos5-gsc.txt      |    2 +-
 .../devicetree/bindings/media/mediatek-vcodec.txt  |    2 +-
 .../devicetree/bindings/media/rcar_vin.txt         |    2 +-
 .../devicetree/bindings/media/samsung-fimc.txt     |    2 +-
 .../devicetree/bindings/media/sh_mobile_ceu.txt    |    2 +-
 .../devicetree/bindings/media/video-interfaces.txt |   10 +-
 .../bindings/memory-controllers/ti/emif.txt        |    2 +-
 .../bindings/mfd/ti-keystone-devctrl.txt           |    2 +-
 .../devicetree/bindings/misc/brcm,kona-smc.txt     |    2 +-
 .../devicetree/bindings/mmc/brcm,kona-sdhci.txt    |    2 +-
 .../devicetree/bindings/mmc/brcm,sdhci-iproc.txt   |    2 +-
 .../devicetree/bindings/mmc/ti-omap-hsmmc.txt      |    4 +-
 Documentation/devicetree/bindings/mtd/gpmc-nor.txt |    6 +-
 .../devicetree/bindings/mtd/jedec,spi-nor.txt      |    2 -
 Documentation/devicetree/bindings/mtd/mtk-nand.txt |    2 +-
 .../devicetree/bindings/net/altera_tse.txt         |    4 +-
 Documentation/devicetree/bindings/net/mdio.txt     |    2 +-
 .../devicetree/bindings/net/socfpga-dwmac.txt      |    2 +-
 Documentation/devicetree/bindings/nios2/nios2.txt  |    2 +-
 .../devicetree/bindings/pci/altera-pcie.txt        |    2 +-
 .../devicetree/bindings/pci/fsl,imx6q-pcie.txt     |    2 +-
 .../devicetree/bindings/pci/hisilicon-pcie.txt     |    2 +-
 .../devicetree/bindings/phy/sun4i-usb-phy.txt      |    2 +-
 .../bindings/pinctrl/brcm,cygnus-pinmux.txt        |    2 +-
 .../devicetree/bindings/pinctrl/pinctrl-atlas7.txt |    4 +-
 .../devicetree/bindings/pinctrl/pinctrl-sirf.txt   |    2 +-
 .../bindings/pinctrl/rockchip,pinctrl.txt          |    4 +-
 .../devicetree/bindings/regulator/regulator.txt    |    2 +-
 .../devicetree/bindings/serial/efm32-uart.txt      |    2 +-
 .../bindings/serio/allwinner,sun4i-ps2.txt         |    2 +-
 .../bindings/soc/ti/keystone-navigator-qmss.txt    |    2 +-
 .../devicetree/bindings/sound/adi,axi-i2s.txt      |    2 +-
 .../devicetree/bindings/sound/adi,axi-spdif-tx.txt |    2 +-
 Documentation/devicetree/bindings/sound/ak4613.txt |    2 +-
 Documentation/devicetree/bindings/sound/ak4642.txt |    2 +-
 Documentation/devicetree/bindings/sound/da7218.txt |    2 +-
 Documentation/devicetree/bindings/sound/da7219.txt |    2 +-
 Documentation/devicetree/bindings/sound/dmic.txt   |    2 +
 .../devicetree/bindings/sound/max98371.txt         |    2 +-
 .../devicetree/bindings/sound/max98373.txt         |   40 +
 .../devicetree/bindings/sound/max9867.txt          |    2 +-
 .../devicetree/bindings/sound/mt2701-afe-pcm.txt   |  266 ++--
 .../devicetree/bindings/sound/nau8825.txt          |    4 +-
 .../devicetree/bindings/sound/pcm186x.txt          |   42 +
 .../devicetree/bindings/sound/renesas,fsi.txt      |    2 +-
 .../devicetree/bindings/sound/renesas,rsnd.txt     |   15 +-
 .../devicetree/bindings/sound/rockchip-spdif.txt   |    2 +-
 .../devicetree/bindings/sound/simple-card.txt      |    3 +
 .../devicetree/bindings/sound/st,sti-asoc-card.txt |    8 +-
 .../devicetree/bindings/sound/st,stm32-adfsdm.txt  |   63 +
 .../devicetree/bindings/sound/st,stm32-sai.txt     |   12 +-
 .../devicetree/bindings/sound/sun4i-i2s.txt        |    2 +
 .../devicetree/bindings/sound/tas5720.txt          |    4 +-
 .../devicetree/bindings/sound/tfa9879.txt          |    8 +-
 .../devicetree/bindings/sound/ti,tas6424.txt       |   20 +
 .../devicetree/bindings/sound/tlv320aic31xx.txt    |    9 +-
 .../devicetree/bindings/sound/tlv320aic3x.txt      |   10 +-
 .../devicetree/bindings/sound/uniphier,evea.txt    |   26 +
 .../devicetree/bindings/spi/efm32-spi.txt          |    2 +-
 .../devicetree/bindings/spi/fsl-imx-cspi.txt       |   18 +-
 .../devicetree/bindings/thermal/thermal.txt        |   12 +-
 Documentation/devicetree/bindings/ufs/ufs-qcom.txt |    4 +-
 .../devicetree/bindings/ufs/ufshcd-pltfrm.txt      |    2 +-
 .../devicetree/bindings/usb/am33xx-usb.txt         |    2 +
 Documentation/devicetree/bindings/usb/ehci-st.txt  |    2 +-
 Documentation/devicetree/bindings/usb/ohci-st.txt  |    2 +-
 .../bindings/watchdog/ingenic,jz4740-wdt.txt       |    2 +-
 Documentation/driver-api/dmaengine/client.rst      |    2 +-
 Documentation/driver-api/iio/hw-consumer.rst       |   51 +
 Documentation/driver-api/iio/index.rst             |    1 +
 Documentation/driver-api/pci.rst                   |    3 -
 Documentation/filesystems/overlayfs.txt            |   34 +
 Documentation/gpu/i915.rst                         |    5 +-
 Documentation/locking/crossrelease.txt             |  874 ------------
 Documentation/media/dvb-drivers/frontends.rst      |   30 +
 Documentation/media/dvb-drivers/index.rst          |    1 +
 Documentation/printk-formats.txt                   |   31 +-
 Documentation/scsi/scsi_mid_low_api.txt            |    6 +-
 Documentation/sysctl/vm.txt                        |    7 -
 Documentation/virtual/kvm/api.txt                  |   15 +-
 Documentation/vm/zswap.txt                         |   22 +-
 Documentation/x86/x86_64/mm.txt                    |   37 +-
 MAINTAINERS                                        |   75 +-
 Makefile                                           |    5 +-
 arch/alpha/include/uapi/asm/Kbuild                 |    2 +
 arch/arc/boot/dts/axc003.dtsi                      |    8 +
 arch/arc/boot/dts/axc003_idu.dtsi                  |    8 +
 arch/arc/boot/dts/hsdk.dts                         |    8 +
 arch/arc/configs/hsdk_defconfig                    |    5 +-
 arch/arc/include/asm/uaccess.h                     |    5 +-
 arch/arc/include/uapi/asm/Kbuild                   |    1 +
 arch/arc/kernel/setup.c                            |    2 +-
 arch/arc/kernel/stacktrace.c                       |    2 +-
 arch/arc/kernel/traps.c                            |   14 +
 arch/arc/kernel/troubleshoot.c                     |    3 +
 arch/arc/plat-axs10x/axs10x.c                      |   18 +-
 arch/arc/plat-hsdk/platform.c                      |   42 -
 arch/arm/boot/dts/am33xx.dtsi                      |    2 +
 arch/arm/boot/dts/am4372.dtsi                      |    6 +-
 arch/arm/boot/dts/am437x-cm-t43.dts                |    4 +-
 arch/arm/boot/dts/armada-385-db-ap.dts             |    1 +
 arch/arm/boot/dts/armada-385-linksys.dtsi          |    1 +
 arch/arm/boot/dts/armada-385-synology-ds116.dts    |    2 +
 arch/arm/boot/dts/armada-388-gp.dts                |    2 +
 arch/arm/boot/dts/aspeed-g4.dtsi                   |    2 +-
 arch/arm/boot/dts/at91-tse850-3.dts                |    1 +
 arch/arm/boot/dts/bcm-nsp.dtsi                     |    4 +-
 arch/arm/boot/dts/bcm283x.dtsi                     |    1 +
 arch/arm/boot/dts/bcm958623hr.dts                  |    4 -
 arch/arm/boot/dts/bcm958625hr.dts                  |    4 -
 arch/arm/boot/dts/da850-lego-ev3.dts               |    4 +-
 arch/arm/boot/dts/dm814x.dtsi                      |    2 +
 arch/arm/boot/dts/exynos5800-peach-pi.dts          |    4 +
 arch/arm/boot/dts/imx53.dtsi                       |    9 -
 arch/arm/boot/dts/logicpd-som-lv-37xx-devkit.dts   |    3 +-
 arch/arm/boot/dts/logicpd-som-lv.dtsi              |   17 +-
 arch/arm/boot/dts/ls1021a-qds.dts                  |    2 +-
 arch/arm/boot/dts/ls1021a-twr.dts                  |    2 +-
 arch/arm/boot/dts/meson.dtsi                       |   18 +-
 arch/arm/boot/dts/nspire.dtsi                      |    1 +
 arch/arm/boot/dts/omap3-beagle-xm.dts              |    1 +
 arch/arm/boot/dts/omap3-beagle.dts                 |    1 +
 arch/arm/boot/dts/omap3-cm-t3x.dtsi                |    2 +
 arch/arm/boot/dts/omap3-evm-common.dtsi            |    1 +
 arch/arm/boot/dts/omap3-gta04.dtsi                 |    1 +
 arch/arm/boot/dts/omap3-igep0020-common.dtsi       |    1 +
 arch/arm/boot/dts/omap3-igep0030-common.dtsi       |    1 +
 arch/arm/boot/dts/omap3-lilly-a83x.dtsi            |    1 +
 arch/arm/boot/dts/omap3-overo-base.dtsi            |    1 +
 arch/arm/boot/dts/omap3-pandora-common.dtsi        |    1 +
 arch/arm/boot/dts/omap3-tao3530.dtsi               |    1 +
 arch/arm/boot/dts/omap3.dtsi                       |    1 +
 arch/arm/boot/dts/omap4-droid4-xt894.dts           |    1 +
 arch/arm/boot/dts/omap4-duovero.dtsi               |    1 +
 arch/arm/boot/dts/omap4-panda-common.dtsi          |    1 +
 arch/arm/boot/dts/omap4-var-som-om44.dtsi          |    1 +
 arch/arm/boot/dts/omap4.dtsi                       |    5 +-
 arch/arm/boot/dts/omap5-board-common.dtsi          |    2 +
 arch/arm/boot/dts/omap5-cm-t54.dts                 |    2 +
 arch/arm/boot/dts/omap5.dtsi                       |    1 +
 arch/arm/boot/dts/r8a7790.dtsi                     |    1 +
 arch/arm/boot/dts/r8a7792.dtsi                     |    1 +
 arch/arm/boot/dts/r8a7793.dtsi                     |    1 +
 arch/arm/boot/dts/r8a7794.dtsi                     |    1 +
 arch/arm/boot/dts/rk3066a-marsboard.dts            |    4 +
 arch/arm/boot/dts/rk3288.dtsi                      |    2 +-
 arch/arm/boot/dts/sun4i-a10.dtsi                   |    4 +-
 arch/arm/boot/dts/sun5i-a10s.dtsi                  |    4 +-
 arch/arm/boot/dts/sun6i-a31.dtsi                   |    4 +-
 arch/arm/boot/dts/sun7i-a20.dtsi                   |    4 +-
 arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts          |    1 +
 arch/arm/boot/dts/tango4-common.dtsi               |    1 -
 arch/arm/boot/dts/vf610-zii-dev-rev-c.dts          |    6 +-
 arch/arm/include/asm/kvm_arm.h                     |    3 +-
 arch/arm/include/asm/kvm_host.h                    |    5 +
 arch/arm/include/asm/pgtable-3level.h              |    1 -
 arch/arm/include/uapi/asm/Kbuild                   |    1 +
 arch/arm/kernel/entry-header.S                     |    4 +-
 arch/arm/kernel/traps.c                            |    1 -
 arch/arm/lib/csumpartialcopyuser.S                 |    4 +
 arch/arm/mach-davinci/dm365.c                      |   29 +-
 arch/arm/mach-meson/platsmp.c                      |    2 +-
 arch/arm/mach-omap2/cm_common.c                    |    6 +-
 arch/arm/mach-omap2/omap-secure.c                  |   21 +
 arch/arm/mach-omap2/omap-secure.h                  |    4 +
 arch/arm/mach-omap2/omap_device.c                  |   10 +-
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         |    1 +
 arch/arm/mach-omap2/pm.h                           |    4 -
 arch/arm/mach-omap2/pm34xx.c                       |   13 +-
 arch/arm/mach-omap2/prcm-common.h                  |    1 +
 arch/arm/mach-omap2/prm33xx.c                      |   12 -
 arch/arm/mach-omap2/sleep34xx.S                    |   26 +-
 arch/arm64/Kconfig                                 |   12 +-
 arch/arm64/Makefile                                |    3 -
 arch/arm64/boot/dts/Makefile                       |    2 +-
 .../boot/dts/allwinner/sun50i-a64-bananapi-m64.dts |    1 +
 .../arm64/boot/dts/allwinner/sun50i-a64-pine64.dts |    1 +
 .../dts/allwinner/sun50i-a64-sopine-baseboard.dts  |    3 +-
 .../boot/dts/allwinner/sun50i-a64-sopine.dtsi      |   11 +-
 .../allwinner/sun50i-h5-orangepi-zero-plus2.dts    |    2 +-
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi        |    4 +-
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi         |    6 +-
 arch/arm64/boot/dts/renesas/salvator-common.dtsi   |    1 -
 arch/arm64/boot/dts/renesas/ulcb.dtsi              |    1 -
 arch/arm64/boot/dts/rockchip/rk3328-rock64.dts     |    2 +
 arch/arm64/boot/dts/rockchip/rk3328.dtsi           |    2 +-
 arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi      |   11 -
 .../arm64/boot/dts/socionext/uniphier-ld11-ref.dts |    1 -
 .../arm64/boot/dts/socionext/uniphier-ld20-ref.dts |    1 -
 .../arm64/boot/dts/socionext/uniphier-pxs3-ref.dts |    3 +-
 arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi   |    4 +-
 arch/arm64/include/asm/assembler.h                 |   10 +
 arch/arm64/include/asm/cacheflush.h                |    2 +-
 arch/arm64/include/asm/cpufeature.h                |    3 +
 arch/arm64/include/asm/cputype.h                   |    2 +
 arch/arm64/include/asm/efi.h                       |    4 +-
 arch/arm64/include/asm/kvm_arm.h                   |    3 +-
 arch/arm64/include/asm/kvm_host.h                  |    1 +
 arch/arm64/include/asm/mmu_context.h               |   46 +-
 arch/arm64/include/asm/module.h                    |   46 +-
 arch/arm64/include/asm/perf_event.h                |    2 +
 arch/arm64/include/asm/pgtable.h                   |   42 +-
 arch/arm64/include/uapi/asm/bpf_perf_event.h       |    9 +
 arch/arm64/kernel/Makefile                         |    3 -
 arch/arm64/kernel/cpu-reset.S                      |    1 +
 arch/arm64/kernel/cpu_ops.c                        |    6 +-
 arch/arm64/kernel/cpufeature.c                     |    3 +-
 arch/arm64/kernel/efi-entry.S                      |    2 +
 arch/arm64/kernel/fpsimd.c                         |   57 +-
 arch/arm64/kernel/ftrace-mod.S                     |   18 -
 arch/arm64/kernel/ftrace.c                         |   14 +-
 arch/arm64/kernel/head.S                           |    1 +
 arch/arm64/kernel/hw_breakpoint.c                  |    2 +-
 arch/arm64/kernel/module-plts.c                    |   50 +-
 arch/arm64/kernel/module.lds                       |    1 +
 arch/arm64/kernel/perf_event.c                     |    6 -
 arch/arm64/kernel/process.c                        |    9 +
 arch/arm64/kernel/relocate_kernel.S                |    1 +
 arch/arm64/kvm/debug.c                             |   21 +
 arch/arm64/kvm/handle_exit.c                       |   57 +-
 arch/arm64/kvm/hyp-init.S                          |    1 +
 arch/arm64/kvm/hyp/debug-sr.c                      |    3 +
 arch/arm64/kvm/hyp/switch.c                        |   37 +-
 arch/arm64/mm/context.c                            |   28 +-
 arch/arm64/mm/dump.c                               |    2 +-
 arch/arm64/mm/fault.c                              |    5 +-
 arch/arm64/mm/init.c                               |    3 +-
 arch/arm64/mm/pgd.c                                |    2 +-
 arch/blackfin/include/uapi/asm/Kbuild              |    1 +
 arch/c6x/include/uapi/asm/Kbuild                   |    1 +
 arch/cris/include/uapi/asm/Kbuild                  |    1 +
 arch/frv/include/uapi/asm/Kbuild                   |    2 +
 arch/h8300/include/uapi/asm/Kbuild                 |    1 +
 arch/hexagon/include/uapi/asm/Kbuild               |    1 +
 arch/ia64/include/uapi/asm/Kbuild                  |    1 +
 arch/m32r/include/uapi/asm/Kbuild                  |    1 +
 arch/m32r/kernel/traps.c                           |    1 -
 arch/m68k/configs/stmark2_defconfig                |    1 -
 arch/m68k/include/uapi/asm/Kbuild                  |    1 +
 arch/m68k/kernel/vmlinux-nommu.lds                 |    2 +
 arch/m68k/kernel/vmlinux-std.lds                   |    2 +
 arch/m68k/kernel/vmlinux-sun3.lds                  |    2 +
 arch/metag/include/uapi/asm/Kbuild                 |    1 +
 arch/microblaze/include/asm/mmu_context_mm.h       |    1 +
 arch/microblaze/include/uapi/asm/Kbuild            |    1 +
 arch/mips/include/asm/Kbuild                       |    1 -
 arch/mips/include/asm/pgtable.h                    |    2 +-
 arch/mips/include/asm/serial.h                     |   22 +
 arch/mips/include/uapi/asm/Kbuild                  |    1 +
 arch/mips/kvm/mips.c                               |    7 +-
 arch/mn10300/include/uapi/asm/Kbuild               |    1 +
 arch/nios2/include/uapi/asm/Kbuild                 |    1 +
 arch/openrisc/include/uapi/asm/Kbuild              |    1 +
 arch/parisc/boot/compressed/misc.c                 |    4 +-
 arch/parisc/include/asm/ldcw.h                     |    2 +
 arch/parisc/include/asm/thread_info.h              |    5 +
 arch/parisc/include/uapi/asm/Kbuild                |    1 +
 arch/parisc/kernel/drivers.c                       |    2 +-
 arch/parisc/kernel/entry.S                         |   25 +-
 arch/parisc/kernel/hpmc.S                          |    1 +
 arch/parisc/kernel/pacache.S                       |    9 +-
 arch/parisc/kernel/process.c                       |   39 +
 arch/parisc/kernel/unwind.c                        |    1 -
 arch/parisc/lib/delay.c                            |    2 -
 arch/parisc/mm/init.c                              |   10 +-
 arch/powerpc/include/asm/book3s/64/pgtable.h       |    1 -
 arch/powerpc/include/asm/kvm_ppc.h                 |    1 +
 arch/powerpc/include/asm/machdep.h                 |    1 +
 arch/powerpc/include/asm/mmu_context.h             |    5 +-
 arch/powerpc/include/asm/setup.h                   |    1 +
 arch/powerpc/include/uapi/asm/Kbuild               |    1 +
 arch/powerpc/kernel/cpu_setup_power.S              |    2 +
 arch/powerpc/kernel/fadump.c                       |   22 -
 arch/powerpc/kernel/misc_64.S                      |    2 +
 arch/powerpc/kernel/process.c                      |   14 +-
 arch/powerpc/kernel/setup-common.c                 |   27 +
 arch/powerpc/kvm/book3s_64_mmu_hv.c                |   37 +-
 arch/powerpc/kvm/book3s_hv.c                       |    3 +-
 arch/powerpc/kvm/book3s_xive.c                     |    7 +-
 arch/powerpc/kvm/powerpc.c                         |    7 +-
 arch/powerpc/mm/fault.c                            |    7 +-
 arch/powerpc/mm/hash_native_64.c                   |   15 +-
 arch/powerpc/net/bpf_jit_comp64.c                  |    6 +-
 arch/powerpc/perf/core-book3s.c                    |   12 +-
 arch/powerpc/perf/imc-pmu.c                        |   17 +-
 arch/powerpc/platforms/ps3/setup.c                 |   15 +
 arch/powerpc/platforms/pseries/setup.c             |    1 +
 arch/powerpc/sysdev/fsl_msi.c                      |    4 +-
 arch/powerpc/xmon/xmon.c                           |   10 +-
 arch/riscv/include/asm/Kbuild                      |    1 +
 arch/riscv/include/asm/asm.h                       |   12 +-
 arch/riscv/include/asm/atomic.h                    |  103 +-
 arch/riscv/include/asm/barrier.h                   |   36 +-
 arch/riscv/include/asm/bitops.h                    |    2 +-
 arch/riscv/include/asm/bug.h                       |    6 +-
 arch/riscv/include/asm/cacheflush.h                |   30 +-
 arch/riscv/include/asm/io.h                        |   18 +-
 arch/riscv/include/asm/mmu.h                       |    4 +
 arch/riscv/include/asm/mmu_context.h               |   45 +
 arch/riscv/include/asm/pgtable.h                   |   58 +-
 arch/riscv/include/asm/spinlock.h                  |   11 +-
 arch/riscv/include/asm/timex.h                     |    3 +-
 arch/riscv/include/asm/tlbflush.h                  |    7 +-
 arch/riscv/include/asm/vdso-syscalls.h             |   28 +
 arch/riscv/include/asm/vdso.h                      |    4 +
 arch/riscv/include/uapi/asm/Kbuild                 |    1 +
 arch/riscv/kernel/head.S                           |    3 -
 arch/riscv/kernel/riscv_ksyms.c                    |    3 +
 arch/riscv/kernel/setup.c                          |   16 +-
 arch/riscv/kernel/smp.c                            |   55 +
 arch/riscv/kernel/sys_riscv.c                      |   33 +-
 arch/riscv/kernel/syscall_table.c                  |    2 +
 arch/riscv/kernel/vdso/Makefile                    |    7 +-
 arch/riscv/kernel/vdso/clock_getres.S              |   26 +
 arch/riscv/kernel/vdso/clock_gettime.S             |   26 +
 arch/riscv/kernel/vdso/flush_icache.S              |   31 +
 arch/riscv/kernel/vdso/getcpu.S                    |   26 +
 arch/riscv/kernel/vdso/gettimeofday.S              |   26 +
 arch/riscv/kernel/vdso/vdso.lds.S                  |    7 +-
 arch/riscv/lib/delay.c                             |    1 +
 arch/riscv/mm/Makefile                             |    1 +
 arch/riscv/mm/cacheflush.c                         |   23 +
 arch/riscv/mm/ioremap.c                            |    2 +-
 arch/s390/Kbuild                                   |    1 +
 arch/s390/Makefile                                 |    5 +-
 arch/s390/appldata/Makefile                        |    1 +
 arch/s390/appldata/appldata_base.c                 |    1 +
 arch/s390/appldata/appldata_mem.c                  |    1 +
 arch/s390/appldata/appldata_net_sum.c              |    1 +
 arch/s390/appldata/appldata_os.c                   |    1 +
 arch/s390/boot/compressed/vmlinux.scr              |    1 +
 arch/s390/boot/install.sh                          |    5 +-
 arch/s390/crypto/aes_s390.c                        |    7 +-
 arch/s390/crypto/arch_random.c                     |    6 +-
 arch/s390/crypto/crc32-vx.c                        |    1 +
 arch/s390/crypto/des_s390.c                        |    7 +-
 arch/s390/crypto/ghash_s390.c                      |    1 +
 arch/s390/crypto/paes_s390.c                       |    6 +-
 arch/s390/crypto/prng.c                            |    1 +
 arch/s390/crypto/sha.h                             |    7 +-
 arch/s390/crypto/sha1_s390.c                       |    7 +-
 arch/s390/crypto/sha256_s390.c                     |    7 +-
 arch/s390/crypto/sha512_s390.c                     |    7 +-
 arch/s390/crypto/sha_common.c                      |    7 +-
 arch/s390/hypfs/Makefile                           |    1 +
 arch/s390/hypfs/inode.c                            |    2 +-
 arch/s390/include/asm/Kbuild                       |    1 +
 arch/s390/include/asm/alternative.h                |    1 +
 arch/s390/include/asm/ap.h                         |    5 +-
 arch/s390/include/asm/bugs.h                       |    1 +
 arch/s390/include/asm/cpu_mf.h                     |    5 +-
 arch/s390/include/asm/elf.h                        |   15 +-
 arch/s390/include/asm/kprobes.h                    |   15 +-
 arch/s390/include/asm/kvm_host.h                   |    5 +-
 arch/s390/include/asm/kvm_para.h                   |    7 +-
 arch/s390/include/asm/livepatch.h                  |    8 +-
 arch/s390/include/asm/mmu_context.h                |    2 +-
 arch/s390/include/asm/perf_event.h                 |    1 +
 arch/s390/include/asm/pgtable.h                    |    2 +-
 arch/s390/include/asm/ptrace.h                     |   11 +-
 arch/s390/include/asm/segment.h                    |    1 +
 arch/s390/include/asm/switch_to.h                  |   27 +-
 arch/s390/include/asm/syscall.h                    |    5 +-
 arch/s390/include/asm/sysinfo.h                    |    5 +-
 arch/s390/include/asm/topology.h                   |    1 +
 arch/s390/include/asm/vga.h                        |    1 +
 arch/s390/include/uapi/asm/Kbuild                  |    1 +
 arch/s390/include/uapi/asm/bpf_perf_event.h        |    9 +
 arch/s390/include/uapi/asm/kvm.h                   |    4 -
 arch/s390/include/uapi/asm/kvm_para.h              |    4 -
 arch/s390/include/uapi/asm/kvm_perf.h              |    4 -
 arch/s390/include/uapi/asm/perf_regs.h             |    1 +
 arch/s390/include/uapi/asm/ptrace.h                |  125 +-
 arch/s390/include/uapi/asm/sthyi.h                 |    1 +
 arch/s390/include/uapi/asm/virtio-ccw.h            |    6 +-
 arch/s390/include/uapi/asm/vmcp.h                  |    1 +
 arch/s390/include/uapi/asm/zcrypt.h                |   14 -
 arch/s390/kernel/alternative.c                     |    1 +
 arch/s390/kernel/compat_linux.c                    |    1 +
 arch/s390/kernel/debug.c                           |    2 +-
 arch/s390/kernel/dis.c                             |   10 +-
 arch/s390/kernel/dumpstack.c                       |    1 +
 arch/s390/kernel/entry.S                           |   15 +-
 arch/s390/kernel/ipl.c                             |    1 +
 arch/s390/kernel/kprobes.c                         |   15 +-
 arch/s390/kernel/lgr.c                             |    1 +
 arch/s390/kernel/module.c                          |   15 +-
 arch/s390/kernel/nmi.c                             |    1 +
 arch/s390/kernel/perf_cpum_cf.c                    |    5 +-
 arch/s390/kernel/perf_cpum_sf.c                    |    5 +-
 arch/s390/kernel/perf_event.c                      |    5 +-
 arch/s390/kernel/perf_regs.c                       |    1 +
 arch/s390/kernel/ptrace.c                          |    8 +
 arch/s390/kernel/setup.c                           |    1 +
 arch/s390/kernel/smp.c                             |    1 +
 arch/s390/kernel/stacktrace.c                      |    1 +
 arch/s390/kernel/sthyi.c                           |    5 +-
 arch/s390/kernel/syscalls.S                        |    6 +-
 arch/s390/kernel/time.c                            |    1 +
 arch/s390/kernel/topology.c                        |    1 +
 arch/s390/kernel/vdso.c                            |    5 +-
 arch/s390/kernel/vdso32/clock_getres.S             |    5 +-
 arch/s390/kernel/vdso32/clock_gettime.S            |    5 +-
 arch/s390/kernel/vdso32/gettimeofday.S             |    5 +-
 arch/s390/kernel/vdso64/clock_getres.S             |    5 +-
 arch/s390/kernel/vdso64/clock_gettime.S            |    5 +-
 arch/s390/kernel/vdso64/gettimeofday.S             |    5 +-
 arch/s390/kernel/vdso64/note.S                     |    1 +
 arch/s390/kernel/vtime.c                           |    1 +
 arch/s390/kvm/Makefile                             |    5 +-
 arch/s390/kvm/diag.c                               |    5 +-
 arch/s390/kvm/gaccess.h                            |    5 +-
 arch/s390/kvm/guestdbg.c                           |    5 +-
 arch/s390/kvm/intercept.c                          |    5 +-
 arch/s390/kvm/interrupt.c                          |    5 +-
 arch/s390/kvm/irq.h                                |    5 +-
 arch/s390/kvm/kvm-s390.c                           |   27 +-
 arch/s390/kvm/kvm-s390.h                           |    5 +-
 arch/s390/kvm/priv.c                               |   18 +-
 arch/s390/kvm/sigp.c                               |    5 +-
 arch/s390/kvm/vsie.c                               |    5 +-
 arch/s390/lib/uaccess.c                            |    2 +-
 arch/s390/mm/cmm.c                                 |    1 +
 arch/s390/mm/gmap.c                                |    1 +
 arch/s390/mm/mmap.c                                |   16 +-
 arch/s390/mm/pgalloc.c                             |    2 -
 arch/s390/mm/pgtable.c                             |    1 +
 arch/s390/net/Makefile                             |    1 +
 arch/s390/net/bpf_jit_comp.c                       |   11 +-
 arch/s390/numa/Makefile                            |    1 +
 arch/s390/pci/Makefile                             |    1 +
 arch/s390/pci/pci.c                                |    1 +
 arch/s390/pci/pci_debug.c                          |    1 +
 arch/s390/pci/pci_dma.c                            |   22 +-
 arch/s390/pci/pci_insn.c                           |    4 +
 arch/s390/tools/gen_opcode_table.c                 |    1 +
 arch/score/include/uapi/asm/Kbuild                 |    1 +
 arch/sh/include/uapi/asm/Kbuild                    |    1 +
 arch/sparc/include/asm/pgtable_64.h                |    2 +-
 arch/sparc/include/uapi/asm/Kbuild                 |    1 +
 arch/sparc/lib/Makefile                            |    2 +-
 arch/sparc/lib/hweight.S                           |    4 +-
 arch/sparc/mm/fault_32.c                           |    2 +-
 arch/sparc/mm/fault_64.c                           |    2 +-
 arch/sparc/net/bpf_jit_comp_64.c                   |    6 +-
 arch/tile/include/asm/pgtable.h                    |    1 -
 arch/tile/include/uapi/asm/Kbuild                  |    1 +
 arch/um/include/asm/Kbuild                         |    1 +
 arch/um/include/asm/mmu_context.h                  |    3 +-
 arch/um/kernel/trap.c                              |    2 +-
 arch/unicore32/include/asm/mmu_context.h           |    5 +-
 arch/unicore32/include/uapi/asm/Kbuild             |    1 +
 arch/unicore32/kernel/traps.c                      |    1 -
 arch/x86/Kconfig                                   |    3 +-
 arch/x86/Kconfig.debug                             |    1 +
 arch/x86/boot/compressed/Makefile                  |    1 +
 arch/x86/boot/compressed/head_64.S                 |   16 +-
 arch/x86/boot/compressed/misc.c                    |   16 +
 arch/x86/boot/compressed/pagetable.c               |    3 +
 arch/x86/boot/compressed/pgtable_64.c              |   28 +
 arch/x86/boot/genimage.sh                          |   32 +-
 arch/x86/crypto/salsa20_glue.c                     |    7 -
 arch/x86/entry/calling.h                           |  145 ++
 arch/x86/entry/entry_32.S                          |   14 +-
 arch/x86/entry/entry_64.S                          |  237 +++-
 arch/x86/entry/entry_64_compat.S                   |   32 +-
 arch/x86/entry/vdso/vclock_gettime.c               |    2 +-
 arch/x86/entry/vsyscall/vsyscall_64.c              |   38 +-
 arch/x86/events/intel/core.c                       |    5 +-
 arch/x86/events/intel/ds.c                         |  146 +-
 arch/x86/events/perf_event.h                       |   23 +-
 arch/x86/include/asm/alternative.h                 |    4 +-
 arch/x86/include/asm/asm.h                         |    2 +
 arch/x86/include/asm/cpu_entry_area.h              |   81 ++
 arch/x86/include/asm/cpufeature.h                  |    2 +
 arch/x86/include/asm/cpufeatures.h                 |    5 +-
 arch/x86/include/asm/desc.h                        |   14 +-
 arch/x86/include/asm/disabled-features.h           |    8 +-
 arch/x86/include/asm/espfix.h                      |    7 +-
 arch/x86/include/asm/fixmap.h                      |    7 +-
 arch/x86/include/asm/hypervisor.h                  |   25 +-
 arch/x86/include/asm/intel_ds.h                    |   36 +
 arch/x86/include/asm/invpcid.h                     |   53 +
 arch/x86/include/asm/irqdomain.h                   |    2 +-
 arch/x86/include/asm/irqflags.h                    |    3 +
 arch/x86/include/asm/kdebug.h                      |    1 +
 arch/x86/include/asm/kmemcheck.h                   |    1 -
 arch/x86/include/asm/kvm_emulate.h                 |    2 -
 arch/x86/include/asm/kvm_host.h                    |   19 +-
 arch/x86/include/asm/mmu.h                         |    4 +-
 arch/x86/include/asm/mmu_context.h                 |  113 +-
 arch/x86/include/asm/paravirt.h                    |    9 +
 arch/x86/include/asm/pgalloc.h                     |   11 +
 arch/x86/include/asm/pgtable.h                     |   38 +-
 arch/x86/include/asm/pgtable_32_types.h            |   15 +-
 arch/x86/include/asm/pgtable_64.h                  |   92 ++
 arch/x86/include/asm/pgtable_64_types.h            |   59 +-
 arch/x86/include/asm/processor-flags.h             |    5 +
 arch/x86/include/asm/processor.h                   |   82 +-
 arch/x86/include/asm/pti.h                         |   14 +
 arch/x86/include/asm/segment.h                     |   12 +
 arch/x86/include/asm/stacktrace.h                  |    3 +
 arch/x86/include/asm/suspend_32.h                  |    8 +-
 arch/x86/include/asm/suspend_64.h                  |   19 +-
 arch/x86/include/asm/switch_to.h                   |   13 +-
 arch/x86/include/asm/thread_info.h                 |    2 +-
 arch/x86/include/asm/tlbflush.h                    |  347 +++--
 arch/x86/include/asm/trace/irq_vectors.h           |   16 +-
 arch/x86/include/asm/traps.h                       |    1 -
 arch/x86/include/asm/unwind.h                      |   20 +-
 arch/x86/include/asm/vsyscall.h                    |    1 +
 arch/x86/include/uapi/asm/Kbuild                   |    1 +
 arch/x86/include/uapi/asm/processor-flags.h        |    7 +-
 arch/x86/kernel/apic/apic.c                        |    2 +
 arch/x86/kernel/apic/apic_flat_64.c                |    2 +-
 arch/x86/kernel/apic/apic_noop.c                   |    2 +-
 arch/x86/kernel/apic/io_apic.c                     |    2 +-
 arch/x86/kernel/apic/msi.c                         |    8 +-
 arch/x86/kernel/apic/probe_32.c                    |    2 +-
 arch/x86/kernel/apic/vector.c                      |   24 +-
 arch/x86/kernel/apic/x2apic_cluster.c              |    2 +-
 arch/x86/kernel/asm-offsets.c                      |   10 +
 arch/x86/kernel/asm-offsets_32.c                   |    9 +-
 arch/x86/kernel/asm-offsets_64.c                   |    4 +
 arch/x86/kernel/cpu/amd.c                          |    7 +-
 arch/x86/kernel/cpu/common.c                       |  103 +-
 arch/x86/kernel/cpu/microcode/amd.c                |    4 +
 arch/x86/kernel/cpu/microcode/intel.c              |   13 -
 arch/x86/kernel/doublefault.c                      |   36 +-
 arch/x86/kernel/dumpstack.c                        |   98 +-
 arch/x86/kernel/dumpstack_32.c                     |    6 +
 arch/x86/kernel/dumpstack_64.c                     |   12 +
 arch/x86/kernel/head_64.S                          |   30 +-
 arch/x86/kernel/ioport.c                           |    2 +-
 arch/x86/kernel/irq.c                              |   12 -
 arch/x86/kernel/irq_64.c                           |    4 +-
 arch/x86/kernel/ldt.c                              |  198 ++-
 arch/x86/kernel/machine_kexec_32.c                 |    4 +-
 arch/x86/kernel/paravirt_patch_64.c                |    2 -
 arch/x86/kernel/process.c                          |   21 +-
 arch/x86/kernel/process_32.c                       |    2 +-
 arch/x86/kernel/process_64.c                       |   14 +-
 arch/x86/kernel/setup.c                            |    5 +-
 arch/x86/kernel/smpboot.c                          |   21 +-
 arch/x86/kernel/stacktrace.c                       |    8 +-
 arch/x86/kernel/tls.c                              |   11 +-
 arch/x86/kernel/traps.c                            |   77 +-
 arch/x86/kernel/unwind_orc.c                       |   88 +-
 arch/x86/kernel/vmlinux.lds.S                      |   17 +
 arch/x86/kvm/cpuid.h                               |    2 +-
 arch/x86/kvm/emulate.c                             |   93 +-
 arch/x86/kvm/ioapic.c                              |   34 +-
 arch/x86/kvm/lapic.c                               |   12 +-
 arch/x86/kvm/mmu.c                                 |    8 +-
 arch/x86/kvm/svm.c                                 |   30 +-
 arch/x86/kvm/vmx.c                                 |   95 +-
 arch/x86/kvm/x86.c                                 |  139 +-
 arch/x86/lib/delay.c                               |    4 +-
 arch/x86/lib/x86-opcode-map.txt                    |   13 +-
 arch/x86/mm/Makefile                               |    9 +-
 arch/x86/mm/cpu_entry_area.c                       |  166 +++
 arch/x86/mm/debug_pagetables.c                     |   80 +-
 arch/x86/mm/dump_pagetables.c                      |  141 +-
 arch/x86/mm/extable.c                              |    6 +-
 arch/x86/mm/fault.c                                |    4 +-
 arch/x86/mm/init.c                                 |   82 +-
 arch/x86/mm/init_32.c                              |    6 +
 arch/x86/mm/ioremap.c                              |    4 +-
 arch/x86/mm/kasan_init_64.c                        |   23 +-
 arch/x86/mm/kaslr.c                                |   32 +-
 arch/x86/mm/kmemcheck/error.c                      |    1 -
 arch/x86/mm/kmemcheck/error.h                      |    1 -
 arch/x86/mm/kmemcheck/opcode.c                     |    1 -
 arch/x86/mm/kmemcheck/opcode.h                     |    1 -
 arch/x86/mm/kmemcheck/pte.c                        |    1 -
 arch/x86/mm/kmemcheck/pte.h                        |    1 -
 arch/x86/mm/kmemcheck/selftest.c                   |    1 -
 arch/x86/mm/kmemcheck/selftest.h                   |    1 -
 arch/x86/mm/kmemcheck/shadow.h                     |    1 -
 arch/x86/mm/kmmio.c                                |   12 +-
 arch/x86/mm/mem_encrypt.c                          |    4 +-
 arch/x86/mm/pgtable.c                              |    5 +-
 arch/x86/mm/pgtable_32.c                           |    1 +
 arch/x86/mm/pti.c                                  |  388 ++++++
 arch/x86/mm/tlb.c                                  |   64 +-
 arch/x86/pci/broadcom_bus.c                        |    2 +-
 arch/x86/pci/fixup.c                               |   27 +-
 arch/x86/platform/efi/efi_64.c                     |    5 +-
 arch/x86/platform/efi/quirks.c                     |   13 +-
 arch/x86/platform/uv/tlb_uv.c                      |    2 +-
 arch/x86/platform/uv/uv_irq.c                      |    2 +-
 arch/x86/platform/uv/uv_nmi.c                      |    4 +-
 arch/x86/power/cpu.c                               |  112 +-
 arch/x86/xen/apic.c                                |    2 +-
 arch/x86/xen/enlighten.c                           |   81 ++
 arch/x86/xen/enlighten_pv.c                        |   42 +-
 arch/x86/xen/mmu_pv.c                              |   14 +-
 arch/x86/xen/setup.c                               |    6 +-
 arch/x86/xen/xen-asm_64.S                          |   14 +
 arch/xtensa/include/uapi/asm/Kbuild                |    1 +
 block/bio.c                                        |    4 +-
 block/blk-map.c                                    |   38 +-
 block/blk-sysfs.c                                  |    5 +-
 block/blk-throttle.c                               |    8 +-
 block/blk-wbt.c                                    |    7 +-
 block/bounce.c                                     |    6 +-
 block/genhd.c                                      |    9 +-
 block/kyber-iosched.c                              |   37 +-
 crypto/af_alg.c                                    |   44 +-
 crypto/algif_aead.c                                |   66 +-
 crypto/algif_skcipher.c                            |   31 +-
 crypto/asymmetric_keys/pkcs7_parser.c              |    4 +-
 crypto/asymmetric_keys/pkcs7_trust.c               |    2 +-
 crypto/asymmetric_keys/pkcs7_verify.c              |    9 +-
 crypto/asymmetric_keys/public_key.c                |    7 +-
 crypto/asymmetric_keys/x509_cert_parser.c          |    2 +
 crypto/asymmetric_keys/x509_public_key.c           |    8 +-
 crypto/chacha20poly1305.c                          |    6 +-
 crypto/hmac.c                                      |    6 +-
 crypto/mcryptd.c                                   |   23 +-
 crypto/pcrypt.c                                    |   19 +-
 crypto/rsa_helper.c                                |    2 +-
 crypto/salsa20_generic.c                           |    7 -
 crypto/shash.c                                     |    5 +-
 crypto/skcipher.c                                  |   11 +-
 drivers/Makefile                                   |    1 +
 drivers/acpi/apei/erst.c                           |    2 +-
 drivers/acpi/cppc_acpi.c                           |   25 +-
 drivers/acpi/device_pm.c                           |    2 +-
 drivers/acpi/device_sysfs.c                        |    4 +
 drivers/acpi/ec.c                                  |   69 +-
 drivers/acpi/internal.h                            |    1 +
 drivers/acpi/nfit/core.c                           |    9 +-
 drivers/acpi/scan.c                                |   21 +
 drivers/android/binder.c                           |   84 +-
 drivers/ata/ahci_mtk.c                             |    6 +-
 drivers/ata/ahci_qoriq.c                           |   12 +
 drivers/ata/libata-core.c                          |   12 +-
 drivers/ata/pata_pdc2027x.c                        |   16 +-
 drivers/atm/ambassador.c                           |    2 +-
 drivers/atm/fore200e.c                             |    4 +-
 drivers/atm/lanai.c                                |    8 +-
 drivers/atm/suni.c                                 |    2 +-
 drivers/auxdisplay/Kconfig                         |    1 +
 drivers/base/Kconfig                               |   25 +-
 drivers/base/cacheinfo.c                           |   13 +
 drivers/base/isa.c                                 |   10 +-
 drivers/base/power/main.c                          |   15 +
 drivers/base/power/runtime.c                       |    3 +-
 drivers/block/null_blk.c                           |    9 +-
 drivers/bus/arm-cci.c                              |    7 +-
 drivers/bus/arm-ccn.c                              |   25 +-
 drivers/bus/sunxi-rsb.c                            |    1 +
 drivers/char/ipmi/ipmi_si_intf.c                   |   44 +-
 drivers/char/ipmi/ipmi_si_parisc.c                 |    2 +
 drivers/char/ipmi/ipmi_si_pci.c                    |    7 +-
 drivers/clk/clk.c                                  |    8 +-
 drivers/clk/sunxi/clk-sun9i-mmc.c                  |   12 +
 drivers/cpufreq/Kconfig                            |    2 +
 drivers/cpufreq/cpufreq_governor.c                 |   19 +-
 drivers/cpufreq/imx6q-cpufreq.c                    |   11 +-
 drivers/cpufreq/mediatek-cpufreq.c                 |    4 +
 drivers/crypto/chelsio/Kconfig                     |    1 +
 drivers/crypto/inside-secure/safexcel.c            |    1 +
 drivers/crypto/inside-secure/safexcel_cipher.c     |   85 +-
 drivers/crypto/inside-secure/safexcel_hash.c       |   89 +-
 drivers/crypto/n2_core.c                           |    3 +
 drivers/dax/device.c                               |   12 +
 drivers/dma/at_hdmac.c                             |    4 +-
 drivers/dma/dma-jz4740.c                           |    4 +-
 drivers/dma/dmatest.c                              |   55 +-
 drivers/dma/fsl-edma.c                             |   28 +-
 drivers/dma/ioat/init.c                            |    2 +-
 drivers/firmware/arm_scpi.c                        |  216 +--
 drivers/firmware/efi/capsule-loader.c              |   45 +-
 drivers/firmware/efi/efi.c                         |    5 +-
 drivers/firmware/efi/esrt.c                        |   17 +-
 drivers/firmware/efi/runtime-map.c                 |   10 +-
 drivers/firmware/google/vpd.c                      |   48 +-
 drivers/firmware/qemu_fw_cfg.c                     |    3 +-
 drivers/gpio/gpio-74x164.c                         |    4 +-
 drivers/gpio/gpio-bcm-kona.c                       |    3 +-
 drivers/gpio/gpio-brcmstb.c                        |    4 +-
 drivers/gpio/gpio-davinci.c                        |    2 +-
 drivers/gpio/gpio-pca953x.c                        |    2 +-
 drivers/gpio/gpio-reg.c                            |    4 +-
 drivers/gpio/gpio-tegra.c                          |    4 +-
 drivers/gpio/gpio-xgene-sb.c                       |    2 +-
 drivers/gpio/gpiolib-acpi.c                        |    2 +-
 drivers/gpio/gpiolib-devprop.c                     |   17 +-
 drivers/gpio/gpiolib-of.c                          |    3 +-
 drivers/gpio/gpiolib.c                             |   27 +-
 drivers/gpio/gpiolib.h                             |    3 +-
 drivers/gpu/drm/amd/acp/Makefile                   |   21 +
 drivers/gpu/drm/amd/amdgpu/Makefile                |   22 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu.h                |   18 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c  |   47 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c             |    4 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |    3 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c            |    2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c             |    2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_powerplay.c      |    3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c            |    2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_queue_mgr.c      |    6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h          |   24 +-
 drivers/gpu/drm/amd/amdgpu/cik.c                   |  111 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c              |   16 +
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c              |    2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c              |    2 +-
 drivers/gpu/drm/amd/amdkfd/Makefile                |   22 +-
 drivers/gpu/drm/amd/amdkfd/kfd_module.c            |    3 +-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c   |    4 +-
 .../gpu/drm/amd/amdkfd/kfd_process_queue_manager.c |   18 +
 drivers/gpu/drm/amd/display/Makefile               |   21 +
 drivers/gpu/drm/amd/display/amdgpu_dm/Makefile     |   21 +
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |   44 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h  |    2 +
 .../amd/display/amdgpu_dm/amdgpu_dm_mst_types.c    |   51 +
 .../amd/display/amdgpu_dm/amdgpu_dm_mst_types.h    |    1 +
 drivers/gpu/drm/amd/display/dc/Makefile            |   21 +
 drivers/gpu/drm/amd/display/dc/basics/Makefile     |   21 +
 .../gpu/drm/amd/display/dc/basics/log_helpers.c    |    5 +
 drivers/gpu/drm/amd/display/dc/bios/Makefile       |   21 +
 drivers/gpu/drm/amd/display/dc/bios/bios_parser.c  |    4 +-
 drivers/gpu/drm/amd/display/dc/calcs/Makefile      |   21 +
 drivers/gpu/drm/amd/display/dc/calcs/dcn_calcs.c   |    9 +
 drivers/gpu/drm/amd/display/dc/core/dc.c           |   15 +-
 drivers/gpu/drm/amd/display/dc/core/dc_debug.c     |   22 +
 drivers/gpu/drm/amd/display/dc/core/dc_link.c      |  104 +-
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c   |  106 +-
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c  |   56 +-
 drivers/gpu/drm/amd/display/dc/core/dc_stream.c    |    9 +-
 drivers/gpu/drm/amd/display/dc/dc_helper.c         |   22 +
 drivers/gpu/drm/amd/display/dc/dce/Makefile        |   21 +
 drivers/gpu/drm/amd/display/dc/dce/dce_audio.c     |   10 +-
 .../drm/amd/display/dc/dce/dce_stream_encoder.c    |    3 +
 drivers/gpu/drm/amd/display/dc/dce100/Makefile     |   21 +
 .../drm/amd/display/dc/dce100/dce100_resource.c    |    2 +-
 .../drm/amd/display/dc/dce100/dce100_resource.h    |   23 +
 drivers/gpu/drm/amd/display/dc/dce110/Makefile     |   21 +
 .../amd/display/dc/dce110/dce110_hw_sequencer.c    |   58 +-
 .../drm/amd/display/dc/dce110/dce110_resource.c    |   14 +-
 .../display/dc/dce110/dce110_timing_generator.c    |    8 +-
 .../display/dc/dce110/dce110_timing_generator_v.c  |   23 +
 drivers/gpu/drm/amd/display/dc/dce112/Makefile     |   21 +
 drivers/gpu/drm/amd/display/dc/dce120/Makefile     |   23 +-
 drivers/gpu/drm/amd/display/dc/dce80/Makefile      |   21 +
 drivers/gpu/drm/amd/display/dc/dcn10/Makefile      |   21 +
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp.c   |    9 +-
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp.h   |    2 +-
 .../gpu/drm/amd/display/dc/dcn10/dcn10_dpp_cm.c    |    6 +-
 .../drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c  |    2 +
 .../gpu/drm/amd/display/dc/dcn10/dcn10_resource.c  |    6 +-
 .../amd/display/dc/dcn10/dcn10_timing_generator.c  |    3 -
 drivers/gpu/drm/amd/display/dc/dml/Makefile        |   21 +
 drivers/gpu/drm/amd/display/dc/gpio/Makefile       |   21 +
 drivers/gpu/drm/amd/display/dc/i2caux/Makefile     |   21 +
 drivers/gpu/drm/amd/display/dc/inc/core_status.h   |    2 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/dpp.h        |    2 +-
 .../gpu/drm/amd/display/dc/inc/hw/link_encoder.h   |   22 +
 .../gpu/drm/amd/display/dc/inc/hw/stream_encoder.h |   22 +
 drivers/gpu/drm/amd/display/dc/inc/hw/transform.h  |    7 -
 drivers/gpu/drm/amd/display/dc/irq/Makefile        |   21 +
 drivers/gpu/drm/amd/display/dc/virtual/Makefile    |   21 +
 .../gpu/drm/amd/display/modules/freesync/Makefile  |   21 +
 drivers/gpu/drm/amd/lib/Makefile                   |   21 +
 drivers/gpu/drm/amd/powerplay/Makefile             |   22 +-
 drivers/gpu/drm/amd/powerplay/hwmgr/Makefile       |   22 +-
 .../gpu/drm/amd/powerplay/hwmgr/pp_overdriver.c    |   24 +-
 drivers/gpu/drm/amd/powerplay/inc/smu72.h          |   24 +-
 drivers/gpu/drm/amd/powerplay/inc/smu72_discrete.h |   24 +-
 drivers/gpu/drm/amd/powerplay/smumgr/Makefile      |   22 +-
 drivers/gpu/drm/amd/scheduler/gpu_sched_trace.h    |   24 +-
 drivers/gpu/drm/arm/hdlcd_crtc.c                   |    3 +-
 drivers/gpu/drm/arm/hdlcd_drv.c                    |    9 +-
 drivers/gpu/drm/arm/malidp_crtc.c                  |   16 +-
 drivers/gpu/drm/arm/malidp_drv.c                   |   34 +-
 drivers/gpu/drm/arm/malidp_hw.c                    |   46 +-
 drivers/gpu/drm/arm/malidp_hw.h                    |   65 +-
 drivers/gpu/drm/arm/malidp_planes.c                |   21 +-
 drivers/gpu/drm/armada/armada_crtc.c               |   47 +-
 drivers/gpu/drm/armada/armada_crtc.h               |    2 +
 drivers/gpu/drm/armada/armada_overlay.c            |   38 +-
 drivers/gpu/drm/bridge/adv7511/adv7511.h           |   13 +-
 drivers/gpu/drm/bridge/adv7511/adv7511_cec.c       |   32 +-
 drivers/gpu/drm/bridge/adv7511/adv7511_drv.c       |   17 +-
 drivers/gpu/drm/bridge/analogix/analogix_dp_core.c |    2 +
 drivers/gpu/drm/bridge/lvds-encoder.c              |   48 +-
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c          |   25 +
 drivers/gpu/drm/bridge/tc358767.c                  |   73 +-
 drivers/gpu/drm/drm_atomic_helper.c                |    2 +-
 drivers/gpu/drm/drm_connector.c                    |   65 +-
 drivers/gpu/drm/drm_crtc_internal.h                |    1 +
 drivers/gpu/drm/drm_edid.c                         |   64 +-
 drivers/gpu/drm/drm_fb_helper.c                    |    4 +
 drivers/gpu/drm/drm_lease.c                        |   26 +-
 drivers/gpu/drm/drm_mm.c                           |    8 +-
 drivers/gpu/drm/drm_mode_config.c                  |    5 +
 drivers/gpu/drm/drm_plane.c                        |   43 +-
 drivers/gpu/drm/drm_syncobj.c                      |   77 +-
 drivers/gpu/drm/exynos/exynos_drm_drv.c            |   46 +-
 drivers/gpu/drm/exynos/exynos_drm_drv.h            |    5 -
 drivers/gpu/drm/exynos/exynos_drm_gem.c            |   15 +
 drivers/gpu/drm/exynos/exynos_drm_gem.h            |    2 +
 drivers/gpu/drm/i915/gvt/cfg_space.c               |   21 +
 drivers/gpu/drm/i915/gvt/cmd_parser.c              |    2 +-
 drivers/gpu/drm/i915/gvt/display.c                 |    3 +
 drivers/gpu/drm/i915/gvt/execlist.c                |    6 +
 drivers/gpu/drm/i915/gvt/gtt.c                     |    6 +-
 drivers/gpu/drm/i915/gvt/handlers.c                |   92 +-
 drivers/gpu/drm/i915/gvt/mmio.h                    |    2 +
 drivers/gpu/drm/i915/gvt/scheduler.c               |   55 +-
 drivers/gpu/drm/i915/gvt/scheduler.h               |    3 +
 drivers/gpu/drm/i915/i915_drv.c                    |    3 +
 drivers/gpu/drm/i915/i915_drv.h                    |    3 +
 drivers/gpu/drm/i915/i915_gem.c                    |   40 +-
 drivers/gpu/drm/i915/i915_gem_userptr.c            |    6 +-
 drivers/gpu/drm/i915/i915_gemfs.c                  |    3 +-
 drivers/gpu/drm/i915/i915_reg.h                    |    5 +-
 drivers/gpu/drm/i915/i915_sw_fence.c               |    3 +-
 drivers/gpu/drm/i915/intel_breadcrumbs.c           |   23 +-
 drivers/gpu/drm/i915/intel_cdclk.c                 |   35 +-
 drivers/gpu/drm/i915/intel_ddi.c                   |    5 +
 drivers/gpu/drm/i915/intel_display.c               |   70 +-
 drivers/gpu/drm/i915/intel_drv.h                   |    2 +-
 drivers/gpu/drm/i915/intel_fbdev.c                 |   10 +-
 drivers/gpu/drm/i915/intel_hdmi.c                  |    3 +-
 drivers/gpu/drm/i915/intel_i2c.c                   |    4 +-
 drivers/gpu/drm/i915/intel_lpe_audio.c             |    2 +-
 drivers/gpu/drm/i915/intel_pm.c                    |   13 -
 drivers/gpu/drm/i915/intel_psr.c                   |   16 +-
 drivers/gpu/drm/i915/intel_runtime_pm.c            |   11 +
 drivers/gpu/drm/i915/intel_uncore.c                |   13 +
 drivers/gpu/drm/i915/intel_uncore.h                |    1 +
 drivers/gpu/drm/imx/imx-drm-core.c                 |   11 +-
 drivers/gpu/drm/nouveau/nouveau_bo.c               |    5 +-
 drivers/gpu/drm/nouveau/nouveau_drm.c              |    2 +-
 drivers/gpu/drm/nouveau/nouveau_drv.h              |   11 +-
 drivers/gpu/drm/nouveau/nouveau_fbcon.c            |    2 +-
 drivers/gpu/drm/nouveau/nouveau_mem.c              |    6 +-
 drivers/gpu/drm/nouveau/nouveau_ttm.c              |   39 +-
 drivers/gpu/drm/nouveau/nouveau_vmm.c              |    2 +-
 drivers/gpu/drm/nouveau/nvkm/engine/device/base.c  |    2 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/bios/dp.c      |    9 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c |    2 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/pci/base.c     |    7 +
 drivers/gpu/drm/omapdrm/displays/Kconfig           |    1 +
 drivers/gpu/drm/omapdrm/dss/dpi.c                  |    4 +-
 drivers/gpu/drm/omapdrm/dss/hdmi4_cec.c            |   48 +-
 drivers/gpu/drm/omapdrm/dss/hdmi4_core.c           |   23 +-
 drivers/gpu/drm/omapdrm/omap_dmm_tiler.c           |    3 +-
 drivers/gpu/drm/radeon/cik.c                       |   24 -
 drivers/gpu/drm/rockchip/dw-mipi-dsi.c             |    3 +-
 drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c             |   20 +
 drivers/gpu/drm/sun4i/sun4i_tcon.c                 |    4 +-
 drivers/gpu/drm/ttm/ttm_page_alloc.c               |  139 +-
 drivers/gpu/drm/vc4/vc4_bo.c                       |    3 +-
 drivers/gpu/drm/vc4/vc4_gem.c                      |    4 +-
 drivers/gpu/drm/vc4/vc4_hdmi.c                     |    3 +-
 drivers/gpu/drm/vc4/vc4_irq.c                      |    7 +
 drivers/hid/hid-core.c                             |    2 +-
 drivers/hid/hid-cp2112.c                           |   15 +-
 drivers/hid/hid-holtekff.c                         |    8 +-
 drivers/hv/channel.c                               |   10 +-
 drivers/hv/channel_mgmt.c                          |    7 +-
 drivers/hv/vmbus_drv.c                             |    2 +
 drivers/hwmon/hwmon.c                              |   21 +-
 drivers/hwmon/jc42.c                               |   21 +
 drivers/hwmon/pmbus/pmbus_core.c                   |   21 +-
 drivers/hwtracing/stm/ftrace.c                     |    6 +-
 drivers/i2c/busses/i2c-cht-wc.c                    |    2 +-
 drivers/i2c/busses/i2c-i801.c                      |    3 +
 drivers/i2c/busses/i2c-piix4.c                     |    2 +-
 drivers/i2c/busses/i2c-stm32.h                     |    3 +-
 drivers/i2c/busses/i2c-stm32f4.c                   |    3 +-
 drivers/i2c/busses/i2c-stm32f7.c                   |    3 +-
 drivers/i2c/i2c-boardinfo.c                        |    2 +
 drivers/iio/adc/Kconfig                            |   37 +
 drivers/iio/adc/Makefile                           |    3 +
 drivers/iio/adc/cpcap-adc.c                        |    2 +-
 drivers/iio/adc/meson_saradc.c                     |   52 +-
 drivers/iio/adc/sd_adc_modulator.c                 |   68 +
 drivers/iio/adc/stm32-dfsdm-adc.c                  | 1216 +++++++++++++++++
 drivers/iio/adc/stm32-dfsdm-core.c                 |  308 +++++
 drivers/iio/adc/stm32-dfsdm.h                      |  310 +++++
 drivers/iio/buffer/Kconfig                         |   10 +
 drivers/iio/buffer/Makefile                        |    1 +
 drivers/iio/buffer/industrialio-buffer-cb.c        |   11 +
 drivers/iio/buffer/industrialio-hw-consumer.c      |  247 ++++
 drivers/iio/health/max30102.c                      |    2 +-
 drivers/iio/industrialio-core.c                    |    4 +-
 drivers/iio/inkern.c                               |   17 +-
 drivers/iio/proximity/sx9500.c                     |    9 +
 drivers/infiniband/Kconfig                         |    2 +-
 drivers/infiniband/core/cma.c                      |    3 +-
 drivers/infiniband/core/device.c                   |    4 +-
 drivers/infiniband/core/iwcm.c                     |    2 +-
 drivers/infiniband/core/nldev.c                    |    2 +-
 drivers/infiniband/core/security.c                 |   60 +-
 drivers/infiniband/core/umem.c                     |    2 +-
 drivers/infiniband/core/uverbs_cmd.c               |   10 +-
 drivers/infiniband/core/verbs.c                    |    3 +-
 drivers/infiniband/hw/cxgb4/cq.c                   |   16 +-
 drivers/infiniband/hw/cxgb4/iw_cxgb4.h             |    2 -
 drivers/infiniband/hw/cxgb4/qp.c                   |   94 +-
 drivers/infiniband/hw/cxgb4/t4.h                   |    6 +
 drivers/infiniband/hw/hfi1/hfi.h                   |    1 -
 drivers/infiniband/hw/hfi1/pcie.c                  |   30 +-
 drivers/infiniband/hw/hfi1/rc.c                    |    2 +-
 drivers/infiniband/hw/hns/hns_roce_alloc.c         |   23 -
 drivers/infiniband/hw/hns/hns_roce_device.h        |    4 +-
 drivers/infiniband/hw/hns/hns_roce_hem.c           |   25 +-
 drivers/infiniband/hw/hns/hns_roce_hem.h           |    1 +
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c         |   22 +-
 drivers/infiniband/hw/i40iw/i40iw_cm.c             |   31 +-
 drivers/infiniband/hw/i40iw/i40iw_ctrl.c           |   43 +-
 drivers/infiniband/hw/i40iw/i40iw_d.h              |    6 +-
 drivers/infiniband/hw/mlx4/qp.c                    |   26 +-
 drivers/infiniband/hw/mlx5/cmd.c                   |   11 -
 drivers/infiniband/hw/mlx5/cmd.h                   |    2 -
 drivers/infiniband/hw/mlx5/main.c                  |   43 +-
 drivers/infiniband/hw/mlx5/mlx5_ib.h               |    4 +
 drivers/infiniband/hw/mlx5/mr.c                    |    1 +
 drivers/infiniband/hw/vmw_pvrdma/pvrdma.h          |    6 +-
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_cq.c       |    7 +-
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c     |   17 +-
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_qp.c       |   14 +-
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_srq.c      |    7 +-
 drivers/infiniband/ulp/ipoib/ipoib_cm.c            |    1 +
 drivers/infiniband/ulp/ipoib/ipoib_ib.c            |    7 +-
 drivers/input/joystick/analog.c                    |    2 +-
 drivers/input/misc/ims-pcu.c                       |    2 +-
 drivers/input/misc/xen-kbdfront.c                  |    2 -
 drivers/input/mouse/elantech.c                     |    2 +-
 drivers/input/touchscreen/elants_i2c.c             |   10 +-
 drivers/input/touchscreen/hideep.c                 |    3 +-
 drivers/iommu/amd_iommu.c                          |    2 +-
 drivers/iommu/arm-smmu-v3.c                        |   17 +-
 drivers/iommu/intel-iommu.c                        |    8 +-
 drivers/iommu/intel_irq_remapping.c                |    2 +-
 drivers/irqchip/irq-gic-v3-its.c                   |    4 +-
 drivers/irqchip/irq-renesas-intc-irqpin.c          |    6 +-
 drivers/leds/led-core.c                            |    1 +
 drivers/md/bcache/alloc.c                          |    2 +-
 drivers/md/bcache/btree.c                          |    5 +-
 drivers/md/bcache/extents.c                        |    2 +-
 drivers/md/bcache/journal.c                        |    7 +-
 drivers/md/bcache/request.c                        |   13 +-
 drivers/md/dm-bufio.c                              |    8 +-
 drivers/md/dm-cache-target.c                       |   12 +-
 drivers/md/dm-mpath.c                              |   67 +-
 drivers/md/dm-snap.c                               |   48 +-
 drivers/md/dm-table.c                              |    5 +-
 drivers/md/dm-thin.c                               |   22 +-
 drivers/md/md.c                                    |    4 +-
 drivers/md/raid1.c                                 |    4 +
 drivers/md/raid10.c                                |    4 +
 drivers/md/raid5-cache.c                           |   22 +-
 drivers/md/raid5.c                                 |    2 +-
 drivers/media/common/siano/smscoreapi.c            |   66 +-
 drivers/media/dvb-core/dvb_ca_en50221.c            |   68 +-
 drivers/media/dvb-core/dvb_frontend.c              |   13 +-
 drivers/media/dvb-core/dvb_net.c                   |   15 +-
 drivers/media/dvb-frontends/af9013.h               |   24 +-
 drivers/media/dvb-frontends/ascot2e.h              |    9 +
 drivers/media/dvb-frontends/cxd2820r.h             |   24 +-
 drivers/media/dvb-frontends/drx39xyj/bsp_i2c.h     |   12 +-
 drivers/media/dvb-frontends/drx39xyj/drx_driver.h  |  878 ++++++------
 drivers/media/dvb-frontends/drx39xyj/drxj.c        |  248 ++--
 drivers/media/dvb-frontends/drx39xyj/drxj.h        |  220 ++--
 drivers/media/dvb-frontends/drxk.h                 |   13 +-
 drivers/media/dvb-frontends/drxk_hard.c            |   32 +-
 drivers/media/dvb-frontends/dvb-pll.h              |   13 +-
 drivers/media/dvb-frontends/helene.h               |   30 +-
 drivers/media/dvb-frontends/horus3a.h              |    9 +
 drivers/media/dvb-frontends/ix2505v.c              |    6 +-
 drivers/media/dvb-frontends/ix2505v.h              |   28 +-
 drivers/media/dvb-frontends/l64781.c               |    2 +-
 drivers/media/dvb-frontends/m88ds3103.h            |  155 +--
 drivers/media/dvb-frontends/mb86a20s.h             |   17 +-
 drivers/media/dvb-frontends/mn88472.h              |   16 +-
 drivers/media/dvb-frontends/rtl2830.h              |    1 -
 drivers/media/dvb-frontends/rtl2832.h              |    1 -
 drivers/media/dvb-frontends/rtl2832_sdr.h          |    6 +-
 drivers/media/dvb-frontends/sp887x.c               |    6 +-
 drivers/media/dvb-frontends/stb6000.h              |   11 +-
 drivers/media/dvb-frontends/stv0299.c              |    2 +-
 drivers/media/dvb-frontends/tda10071.h             |    1 -
 drivers/media/dvb-frontends/tda826x.h              |   11 +-
 drivers/media/dvb-frontends/tua6100.c              |    2 +-
 drivers/media/dvb-frontends/tua6100.h              |    2 +-
 drivers/media/dvb-frontends/zd1301_demod.h         |   13 +-
 drivers/media/dvb-frontends/zl10036.c              |    8 +-
 drivers/media/dvb-frontends/zl10036.h              |   16 +-
 drivers/media/i2c/Kconfig                          |    1 +
 drivers/media/i2c/et8ek8/Kconfig                   |    1 +
 drivers/media/i2c/imx274.c                         |    5 +-
 drivers/media/i2c/lm3560.c                         |    1 +
 drivers/media/i2c/m5mols/m5mols_capture.c          |    5 +
 drivers/media/i2c/m5mols/m5mols_controls.c         |    1 +
 drivers/media/i2c/m5mols/m5mols_core.c             |   20 +-
 drivers/media/i2c/ov5647.c                         |    4 +-
 drivers/media/i2c/s5k6a3.c                         |    3 +
 drivers/media/i2c/s5k6aa.c                         |    5 +
 drivers/media/i2c/tvp514x.c                        |   12 +-
 drivers/media/pci/netup_unidvb/netup_unidvb_core.c |    8 +-
 drivers/media/pci/solo6x10/solo6x10-enc.c          |    2 +-
 drivers/media/pci/sta2x11/sta2x11_vip.c            |   11 +
 drivers/media/pci/tw68/tw68-risc.c                 |   33 +-
 drivers/media/platform/davinci/vpif.c              |    3 +-
 drivers/media/platform/davinci/vpif_capture.c      |   27 +-
 drivers/media/platform/davinci/vpif_display.c      |   16 +-
 drivers/media/platform/exynos4-is/fimc-capture.c   |    3 +
 drivers/media/platform/exynos4-is/media-dev.c      |   11 +-
 drivers/media/platform/exynos4-is/mipi-csis.c      |    2 +-
 .../media/platform/mtk-vcodec/vdec/vdec_h264_if.c  |    1 +
 .../media/platform/mtk-vcodec/vdec/vdec_vp8_if.c   |    1 -
 .../media/platform/mtk-vcodec/venc/venc_h264_if.c  |    4 +-
 .../media/platform/mtk-vcodec/venc/venc_vp8_if.c   |    2 +-
 drivers/media/platform/mtk-vpu/mtk_vpu.c           |    3 +-
 drivers/media/platform/pxa_camera.c                |    9 +-
 drivers/media/platform/rcar_fdp1.c                 |    2 +-
 drivers/media/platform/rcar_jpu.c                  |    4 +-
 drivers/media/platform/s3c-camif/camif-core.c      |    1 +
 drivers/media/platform/sh_veu.c                    |    2 +-
 drivers/media/platform/soc_camera/soc_scale_crop.c |   21 +-
 drivers/media/platform/sti/hva/hva-h264.c          |   18 +-
 drivers/media/platform/ti-vpe/vpe.c                |    2 +-
 drivers/media/platform/vim2m.c                     |    2 +-
 drivers/media/platform/vsp1/vsp1_dl.c              |    1 +
 drivers/media/radio/radio-si476x.c                 |   18 +-
 drivers/media/radio/radio-wl1273.c                 |    2 +-
 drivers/media/rc/img-ir/img-ir-hw.c                |    2 +-
 drivers/media/rc/imon.c                            |   40 +-
 drivers/media/rc/ir-jvc-decoder.c                  |    2 +-
 drivers/media/rc/ir-lirc-codec.c                   |    4 +-
 drivers/media/rc/ir-nec-decoder.c                  |    3 +-
 drivers/media/rc/ir-sanyo-decoder.c                |    2 +-
 drivers/media/rc/ir-sharp-decoder.c                |    2 +-
 drivers/media/rc/ir-xmp-decoder.c                  |    2 +-
 drivers/media/rc/rc-ir-raw.c                       |    2 +-
 drivers/media/rc/rc-main.c                         |   78 +-
 drivers/media/rc/sir_ir.c                          |   40 +-
 drivers/media/rc/st_rc.c                           |    6 +-
 drivers/media/rc/streamzap.c                       |    6 +-
 drivers/media/tuners/mt2063.c                      |    6 +-
 drivers/media/usb/dvb-usb/cinergyT2-fe.c           |    2 +-
 drivers/media/usb/dvb-usb/dib0700_devices.c        |    8 +-
 drivers/media/usb/dvb-usb/dibusb-common.c          |   16 +-
 drivers/media/usb/dvb-usb/friio-fe.c               |    2 +-
 drivers/media/usb/dvb-usb/friio.c                  |    2 +-
 drivers/media/usb/gspca/ov519.c                    |    2 +-
 drivers/media/usb/pwc/pwc-dec23.c                  |    7 +-
 drivers/media/usb/siano/smsusb.c                   |    4 +-
 drivers/media/usb/ttusb-budget/dvb-ttusb-budget.c  |    6 +-
 drivers/media/usb/usbtv/usbtv-core.c               |    1 +
 drivers/media/v4l2-core/tuner-core.c               |    4 +-
 drivers/media/v4l2-core/v4l2-async.c               |    3 +-
 drivers/media/v4l2-core/v4l2-dv-timings.c          |   10 +-
 drivers/media/v4l2-core/v4l2-fwnode.c              |   10 +-
 drivers/media/v4l2-core/v4l2-mem2mem.c             |    2 +
 drivers/media/v4l2-core/videobuf-core.c            |    2 +-
 drivers/media/v4l2-core/videobuf-dma-sg.c          |    5 +-
 drivers/media/v4l2-core/videobuf2-core.c           |   56 +-
 drivers/media/v4l2-core/videobuf2-memops.c         |    2 +-
 drivers/media/v4l2-core/videobuf2-v4l2.c           |   10 +-
 drivers/mfd/arizona-irq.c                          |    4 +-
 drivers/mfd/cros_ec_spi.c                          |   53 +-
 drivers/mfd/rtsx_pcr.c                             |    3 +
 drivers/mfd/twl4030-audio.c                        |    9 +-
 drivers/mfd/twl6040.c                              |   12 +-
 drivers/misc/cxl/pci.c                             |   12 +-
 drivers/misc/eeprom/at24.c                         |   41 +-
 drivers/misc/pti.c                                 |    2 +-
 drivers/mmc/core/block.c                           |   67 +-
 drivers/mmc/core/bus.c                             |    3 +
 drivers/mmc/core/card.h                            |    2 +
 drivers/mmc/core/debugfs.c                         |    1 +
 drivers/mmc/core/mmc.c                             |    6 +-
 drivers/mmc/core/quirks.h                          |    8 +
 drivers/mmc/core/sd.c                              |    2 +-
 drivers/mmc/host/sdhci-msm.c                       |   14 +
 drivers/mmc/host/sdhci.c                           |   28 +-
 drivers/mtd/mtdcore.c                              |    2 +-
 drivers/mtd/mtdsuper.c                             |    6 +-
 drivers/mtd/nand/brcmnand/brcmnand.c               |    2 +-
 drivers/mtd/nand/gpio.c                            |    6 +-
 drivers/mtd/nand/gpmi-nand/gpmi-nand.c             |    6 +-
 drivers/mtd/nand/pxa3xx_nand.c                     |    1 +
 drivers/net/bonding/bond_netlink.c                 |    2 +-
 drivers/net/can/flexcan.c                          |    9 +-
 drivers/net/can/peak_canfd/peak_canfd.c            |    9 +-
 drivers/net/can/peak_canfd/peak_pciefd_main.c      |    5 +-
 drivers/net/can/sja1000/peak_pci.c                 |    5 +-
 drivers/net/can/ti_hecc.c                          |    3 +
 drivers/net/can/usb/ems_usb.c                      |    2 +
 drivers/net/can/usb/esd_usb2.c                     |    2 +
 drivers/net/can/usb/kvaser_usb.c                   |   13 +-
 drivers/net/can/usb/mcba_usb.c                     |    4 +-
 drivers/net/can/usb/usb_8dev.c                     |    2 +
 drivers/net/dsa/bcm_sf2.c                          |    1 -
 drivers/net/dsa/bcm_sf2_cfp.c                      |    4 +-
 drivers/net/dsa/mv88e6xxx/chip.c                   |   34 +-
 drivers/net/dsa/mv88e6xxx/port.c                   |    1 +
 drivers/net/ethernet/aquantia/atlantic/aq_cfg.h    |    5 +-
 .../net/ethernet/aquantia/atlantic/aq_ethtool.c    |   16 +-
 drivers/net/ethernet/aquantia/atlantic/aq_hw.h     |   29 +-
 drivers/net/ethernet/aquantia/atlantic/aq_nic.c    |   82 +-
 drivers/net/ethernet/aquantia/atlantic/aq_nic.h    |    2 +-
 .../net/ethernet/aquantia/atlantic/aq_pci_func.c   |    5 +-
 .../ethernet/aquantia/atlantic/hw_atl/hw_atl_a0.c  |   17 +-
 .../ethernet/aquantia/atlantic/hw_atl/hw_atl_b0.c  |   29 +-
 .../aquantia/atlantic/hw_atl/hw_atl_llh_internal.h |    6 +
 .../aquantia/atlantic/hw_atl/hw_atl_utils.c        |   80 +-
 .../aquantia/atlantic/hw_atl/hw_atl_utils.h        |    6 +-
 drivers/net/ethernet/aquantia/atlantic/ver.h       |    6 +-
 drivers/net/ethernet/arc/emac.h                    |    2 +
 drivers/net/ethernet/arc/emac_main.c               |  164 ++-
 drivers/net/ethernet/arc/emac_rockchip.c           |   13 +-
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c    |    4 +-
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c   |   14 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c          |    9 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c  |    4 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c       |   55 +-
 drivers/net/ethernet/broadcom/tg3.c                |   21 +-
 drivers/net/ethernet/broadcom/tg3.h                |    7 +-
 drivers/net/ethernet/cavium/liquidio/lio_main.c    |    2 +-
 drivers/net/ethernet/cavium/thunder/nicvf_queues.c |    3 +-
 drivers/net/ethernet/freescale/fec_main.c          |    6 +
 drivers/net/ethernet/freescale/gianfar.c           |   11 +-
 drivers/net/ethernet/intel/e1000/e1000_hw.c        |    6 +-
 drivers/net/ethernet/intel/e1000e/ich8lan.h        |    3 +-
 drivers/net/ethernet/intel/e1000e/netdev.c         |    9 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c        |    1 -
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c |    2 +-
 drivers/net/ethernet/marvell/mvmdio.c              |    3 +-
 drivers/net/ethernet/marvell/mvneta.c              |    8 +-
 drivers/net/ethernet/marvell/mvpp2.c               |   50 +-
 drivers/net/ethernet/marvell/skge.c                |    1 -
 drivers/net/ethernet/mediatek/mtk_eth_soc.c        |   11 +-
 drivers/net/ethernet/mellanox/mlx4/en_port.c       |   57 +-
 drivers/net/ethernet/mellanox/mlx4/en_selftest.c   |    2 +-
 drivers/net/ethernet/mellanox/mlx4/mlx4_en.h       |    3 +
 .../net/ethernet/mellanox/mlx4/resource_tracker.c  |    1 -
 drivers/net/ethernet/mellanox/mlx5/core/cmd.c      |    4 +-
 drivers/net/ethernet/mellanox/mlx5/core/en.h       |    9 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_dcbnl.c |   10 +-
 .../net/ethernet/mellanox/mlx5/core/en_ethtool.c   |   10 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c  |   63 +-
 drivers/net/ethernet/mellanox/mlx5/core/eq.c       |   20 +-
 drivers/net/ethernet/mellanox/mlx5/core/fpga/sdk.c |    6 +
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.c  |   16 +-
 drivers/net/ethernet/mellanox/mlx5/core/health.c   |    2 +-
 .../net/ethernet/mellanox/mlx5/core/ipoib/ipoib.c  |    2 +-
 drivers/net/ethernet/mellanox/mlx5/core/lag.c      |   56 +
 drivers/net/ethernet/mellanox/mlx5/core/main.c     |   75 +-
 drivers/net/ethernet/mellanox/mlx5/core/qp.c       |    4 +-
 drivers/net/ethernet/mellanox/mlx5/core/rl.c       |   22 +-
 drivers/net/ethernet/mellanox/mlx5/core/vxlan.c    |   64 +-
 drivers/net/ethernet/mellanox/mlx5/core/vxlan.h    |    1 +
 drivers/net/ethernet/mellanox/mlxsw/spectrum.c     |   18 +
 .../net/ethernet/mellanox/mlxsw/spectrum_router.c  |  124 +-
 drivers/net/ethernet/netronome/nfp/bpf/main.c      |   55 +-
 drivers/net/ethernet/netronome/nfp/bpf/main.h      |    8 +
 drivers/net/ethernet/netronome/nfp/nfp_net_repr.c  |   15 +-
 drivers/net/ethernet/nvidia/forcedeth.c            |    4 +-
 drivers/net/ethernet/qualcomm/emac/emac-phy.c      |    7 +-
 drivers/net/ethernet/qualcomm/emac/emac.c          |    6 +-
 drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c |    1 +
 .../net/ethernet/qualcomm/rmnet/rmnet_handlers.c   |    8 +-
 drivers/net/ethernet/renesas/ravb_main.c           |   27 +-
 drivers/net/ethernet/renesas/sh_eth.c              |   41 +-
 drivers/net/ethernet/sfc/tx.c                      |    5 +-
 drivers/net/ethernet/stmicro/stmmac/common.h       |    2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c  |    4 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c  |    3 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c |    5 +-
 drivers/net/ethernet/stmicro/stmmac/enh_desc.c     |    3 +-
 drivers/net/ethernet/stmicro/stmmac/norm_desc.c    |    2 +-
 .../net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c  |    6 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |    3 +-
 drivers/net/ethernet/via/via-rhine.c               |    4 +-
 drivers/net/ethernet/xilinx/Kconfig                |    1 +
 drivers/net/hippi/rrunner.c                        |    2 +-
 drivers/net/ipvlan/ipvlan_core.c                   |    1 +
 drivers/net/phy/at803x.c                           |    4 -
 drivers/net/phy/marvell.c                          |   18 +-
 drivers/net/phy/marvell10g.c                       |    5 +-
 drivers/net/phy/mdio-xgene.c                       |   21 +-
 drivers/net/phy/mdio_bus.c                         |    1 +
 drivers/net/phy/meson-gxl.c                        |   74 +-
 drivers/net/phy/micrel.c                           |    7 +-
 drivers/net/phy/phy.c                              |    9 +-
 drivers/net/phy/phy_device.c                       |   10 +-
 drivers/net/phy/phylink.c                          |    3 +
 drivers/net/phy/sfp.c                              |   41 +-
 drivers/net/tap.c                                  |   14 +-
 drivers/net/thunderbolt.c                          |   57 +-
 drivers/net/tun.c                                  |   24 +-
 drivers/net/usb/qmi_wwan.c                         |    4 +
 drivers/net/usb/usbnet.c                           |    5 +-
 drivers/net/virtio_net.c                           |    2 +-
 drivers/net/vxlan.c                                |   23 +-
 drivers/net/wan/lmc/lmc_main.c                     |   13 +-
 drivers/net/wireless/ath/ath9k/channel.c           |    2 +-
 .../wireless/broadcom/brcm80211/brcmfmac/sdio.c    |    4 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/txq.h    |    4 +
 drivers/net/wireless/intel/iwlwifi/fw/dbg.h        |    2 -
 drivers/net/wireless/intel/iwlwifi/iwl-trans.h     |    4 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c  |    2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h       |    3 +
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c       |    1 +
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c      |   18 +-
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c       |   53 +-
 .../net/wireless/intel/iwlwifi/mvm/time-event.c    |   24 +-
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c        |    3 +-
 drivers/net/wireless/intel/iwlwifi/mvm/utils.c     |   13 +-
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c      |    2 +
 .../net/wireless/intel/iwlwifi/pcie/trans-gen2.c   |    6 +
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c    |   10 +
 drivers/net/wireless/mac80211_hwsim.c              |    3 +-
 drivers/net/wireless/st/cw1200/sta.c               |    4 +-
 drivers/net/wireless/ti/wl1251/main.c              |    2 +-
 drivers/net/wireless/ti/wlcore/cmd.c               |    5 +-
 drivers/net/xen-netback/interface.c                |    2 +-
 drivers/net/xen-netfront.c                         |   18 +
 drivers/nvdimm/btt.c                               |  201 ++-
 drivers/nvdimm/btt.h                               |   47 +-
 drivers/nvdimm/pfn_devs.c                          |   20 +-
 drivers/nvme/host/core.c                           |   30 +-
 drivers/nvme/host/fabrics.h                        |   30 +
 drivers/nvme/host/fc.c                             |   22 +-
 drivers/nvme/host/multipath.c                      |    2 +-
 drivers/nvme/host/nvme.h                           |    2 +-
 drivers/nvme/host/pci.c                            |   17 +-
 drivers/nvme/host/rdma.c                           |  266 ++--
 drivers/nvme/target/fc.c                           |    9 +-
 drivers/nvme/target/loop.c                         |   25 +-
 drivers/nvmem/meson-mx-efuse.c                     |    4 +-
 drivers/of/dynamic.c                               |    4 +-
 drivers/of/of_mdio.c                               |    3 +
 drivers/of/overlay.c                               |   84 +-
 drivers/of/unittest.c                              |    1 -
 drivers/parisc/dino.c                              |   10 +-
 drivers/parisc/eisa_eeprom.c                       |    2 +-
 drivers/parisc/lba_pci.c                           |   33 +
 drivers/pci/host/pci-hyperv.c                      |    8 +-
 drivers/pci/host/pcie-rcar.c                       |    8 +-
 drivers/pci/pci-driver.c                           |    9 +-
 drivers/phy/motorola/phy-cpcap-usb.c               |    2 +-
 drivers/phy/renesas/Kconfig                        |    2 +
 drivers/phy/rockchip/phy-rockchip-typec.c          |    2 +
 drivers/phy/tegra/xusb.c                           |   58 +-
 drivers/pinctrl/intel/pinctrl-cherryview.c         |   16 +
 drivers/pinctrl/intel/pinctrl-denverton.c          |    2 +-
 drivers/pinctrl/mvebu/pinctrl-armada-37xx.c        |   13 +-
 drivers/pinctrl/pinctrl-gemini.c                   |    2 +-
 drivers/pinctrl/pinctrl-single.c                   |    5 +-
 drivers/pinctrl/stm32/pinctrl-stm32.c              |    2 +-
 drivers/pinctrl/sunxi/pinctrl-sun50i-a64.c         |    2 +-
 drivers/pinctrl/sunxi/pinctrl-sun50i-h5.c          |    6 +-
 drivers/pinctrl/sunxi/pinctrl-sun9i-a80.c          |    6 +-
 drivers/platform/x86/asus-wireless.c               |    1 +
 drivers/platform/x86/dell-laptop.c                 |   17 +
 drivers/platform/x86/dell-wmi.c                    |    2 +
 drivers/s390/Makefile                              |    1 +
 drivers/s390/block/Kconfig                         |    1 +
 drivers/s390/block/dasd.c                          |   11 +-
 drivers/s390/block/dasd_3990_erp.c                 |   10 +
 drivers/s390/block/dasd_devmap.c                   |    1 +
 drivers/s390/block/dasd_diag.c                     |    1 +
 drivers/s390/block/dasd_eckd.c                     |   17 +-
 drivers/s390/block/dasd_fba.c                      |    1 +
 drivers/s390/block/dasd_int.h                      |    2 +-
 drivers/s390/block/dcssblk.c                       |    1 +
 drivers/s390/block/scm_blk.c                       |    1 +
 drivers/s390/block/xpram.c                         |    1 +
 drivers/s390/char/Kconfig                          |    1 +
 drivers/s390/char/Makefile                         |    2 +
 drivers/s390/char/defkeymap.map                    |    1 +
 drivers/s390/char/fs3270.c                         |    1 +
 drivers/s390/char/hmcdrv_mod.c                     |    1 +
 drivers/s390/char/monreader.c                      |    1 +
 drivers/s390/char/monwriter.c                      |    1 +
 drivers/s390/char/raw3270.c                        |    1 +
 drivers/s390/char/sclp_async.c                     |    1 +
 drivers/s390/char/tape_34xx.c                      |    1 +
 drivers/s390/char/tape_3590.c                      |    1 +
 drivers/s390/char/tape_class.c                     |    1 +
 drivers/s390/char/tape_core.c                      |    1 +
 drivers/s390/char/tty3270.c                        |    1 +
 drivers/s390/char/vmlogrdr.c                       |    1 +
 drivers/s390/char/vmur.c                           |    1 +
 drivers/s390/char/zcore.c                          |    2 +-
 drivers/s390/cio/blacklist.h                       |    1 +
 drivers/s390/cio/ccwgroup.c                        |    1 +
 drivers/s390/cio/chp.c                             |    1 +
 drivers/s390/cio/chsc.c                            |    1 +
 drivers/s390/cio/chsc_sch.c                        |    1 +
 drivers/s390/cio/cio.c                             |    1 +
 drivers/s390/cio/cmf.c                             |   15 +-
 drivers/s390/cio/css.c                             |    3 +-
 drivers/s390/cio/device.c                          |    3 +-
 drivers/s390/cio/device_fsm.c                      |    1 +
 drivers/s390/cio/device_ops.c                      |    3 +-
 drivers/s390/cio/eadm_sch.c                        |    1 +
 drivers/s390/cio/isc.c                             |    1 +
 drivers/s390/cio/qdio_main.c                       |    8 +-
 drivers/s390/cio/qdio_setup.c                      |    1 +
 drivers/s390/cio/scm.c                             |    1 +
 drivers/s390/cio/vfio_ccw_drv.c                    |    1 +
 drivers/s390/crypto/ap_bus.c                       |   15 +-
 drivers/s390/crypto/ap_bus.h                       |   15 +-
 drivers/s390/crypto/pkey_api.c                     |    6 +-
 drivers/s390/crypto/zcrypt_api.c                   |   19 +-
 drivers/s390/crypto/zcrypt_api.h                   |   15 +-
 drivers/s390/crypto/zcrypt_card.c                  |   11 +-
 drivers/s390/crypto/zcrypt_cca_key.h               |   15 +-
 drivers/s390/crypto/zcrypt_cex2a.c                 |   15 +-
 drivers/s390/crypto/zcrypt_cex2a.h                 |   15 +-
 drivers/s390/crypto/zcrypt_cex4.c                  |    1 +
 drivers/s390/crypto/zcrypt_error.h                 |   15 +-
 drivers/s390/crypto/zcrypt_msgtype50.c             |   15 +-
 drivers/s390/crypto/zcrypt_msgtype50.h             |   15 +-
 drivers/s390/crypto/zcrypt_msgtype6.c              |   15 +-
 drivers/s390/crypto/zcrypt_msgtype6.h              |   15 +-
 drivers/s390/crypto/zcrypt_pcixcc.c                |   15 +-
 drivers/s390/crypto/zcrypt_pcixcc.h                |   15 +-
 drivers/s390/crypto/zcrypt_queue.c                 |   11 +-
 drivers/s390/net/Kconfig                           |    1 +
 drivers/s390/net/ctcm_main.c                       |    1 +
 drivers/s390/net/fsm.c                             |    1 +
 drivers/s390/net/lcs.c                             |   15 +-
 drivers/s390/net/netiucv.c                         |   16 +-
 drivers/s390/net/qeth_core.h                       |    9 +-
 drivers/s390/net/qeth_core_main.c                  |   47 +-
 drivers/s390/net/qeth_core_sys.c                   |    1 +
 drivers/s390/net/qeth_l2_main.c                    |    5 +-
 drivers/s390/net/qeth_l3.h                         |    2 +-
 drivers/s390/net/qeth_l3_main.c                    |   44 +-
 drivers/s390/net/qeth_l3_sys.c                     |   75 +-
 drivers/s390/net/smsgiucv.c                        |   15 +-
 drivers/s390/net/smsgiucv_app.c                    |    1 +
 drivers/s390/scsi/Makefile                         |    1 +
 drivers/s390/scsi/zfcp_aux.c                       |    1 +
 drivers/s390/virtio/Makefile                       |    5 +-
 drivers/s390/virtio/virtio_ccw.c                   |    5 +-
 drivers/scsi/aacraid/aacraid.h                     |    2 +
 drivers/scsi/aacraid/commsup.c                     |   43 +-
 drivers/scsi/aacraid/linit.c                       |    5 +-
 drivers/scsi/aacraid/rx.c                          |   15 +-
 drivers/scsi/aacraid/src.c                         |   20 +-
 drivers/scsi/bfa/bfad_bsg.c                        |    6 +-
 drivers/scsi/bfa/bfad_im.c                         |    6 +-
 drivers/scsi/bfa/bfad_im.h                         |   10 +
 drivers/scsi/libfc/fc_lport.c                      |    4 +
 drivers/scsi/libsas/sas_expander.c                 |   10 +-
 drivers/scsi/lpfc/lpfc_mem.c                       |    2 +-
 drivers/scsi/osd/osd_initiator.c                   |    4 +-
 drivers/scsi/scsi_debugfs.c                        |    6 +-
 drivers/scsi/scsi_devinfo.c                        |   33 +-
 drivers/scsi/scsi_lib.c                            |   12 +-
 drivers/scsi/scsi_scan.c                           |   13 +-
 drivers/scsi/scsi_sysfs.c                          |   10 +-
 drivers/scsi/scsi_transport_spi.c                  |   12 +-
 drivers/scsi/sd.c                                  |    4 +-
 drivers/scsi/storvsc_drv.c                         |    3 +-
 drivers/scsi/ufs/ufshcd.c                          |    7 +-
 drivers/soc/amlogic/meson-gx-socinfo.c             |    4 +-
 drivers/spi/spi-armada-3700.c                      |    8 +
 drivers/spi/spi-atmel.c                            |    2 +-
 drivers/spi/spi-rspi.c                             |    4 +-
 drivers/spi/spi-sun4i.c                            |    2 +-
 drivers/spi/spi-xilinx.c                           |   11 +
 drivers/staging/android/ion/Kconfig                |    2 +-
 drivers/staging/android/ion/ion.c                  |    4 +-
 drivers/staging/android/ion/ion_cma_heap.c         |   15 +-
 drivers/staging/ccree/ssi_hash.c                   |   11 +-
 drivers/staging/comedi/drivers/ni_atmio.c          |    5 +
 .../staging/lustre/lnet/klnds/socklnd/socklnd.c    |   23 +-
 drivers/staging/lustre/lnet/lnet/lib-socket.c      |    8 +-
 drivers/staging/lustre/lustre/llite/file.c         |    2 +-
 drivers/staging/lustre/lustre/llite/llite_lib.c    |   14 +-
 .../staging/media/atomisp/include/linux/atomisp.h  |   34 +-
 .../media/atomisp/pci/atomisp2/atomisp_cmd.c       |    2 +-
 .../atomisp/pci/atomisp2/atomisp_compat_css20.c    |    2 +-
 .../atomisp/pci/atomisp2/atomisp_compat_ioctl32.h  |   16 +-
 .../media/atomisp/pci/atomisp2/atomisp_subdev.h    |    2 +-
 .../atomisp2/css2400/base/circbuf/src/circbuf.c    |   26 +-
 .../camera/pipe/interface/ia_css_pipe_binarydesc.h |   34 +-
 .../camera/pipe/interface/ia_css_pipe_util.h       |    2 +-
 .../css2400/camera/util/interface/ia_css_util.h    |   18 +-
 .../css_2401_csi2p_system/host/csi_rx_private.h    |    2 +-
 .../css_2401_csi2p_system/host/ibuf_ctrl_private.h |    4 +-
 .../css2400/css_2401_csi2p_system/host/isys_irq.c  |    2 +-
 .../css_2401_csi2p_system/host/isys_irq_private.h  |    4 +-
 .../host/isys_stream2mmio_private.h                |    4 +-
 .../css_2401_csi2p_system/host/pixelgen_private.h  |    2 +-
 .../css_2401_csi2p_system/isys_dma_global.h        |    4 +-
 .../css_2401_csi2p_system/pixelgen_global.h        |    2 +-
 .../css2400/css_2401_csi2p_system/system_global.h  |    8 +-
 .../atomisp/pci/atomisp2/css2400/css_api_version.h |    2 +-
 .../css2400/hive_isp_css_common/host/gp_timer.c    |    2 +-
 .../hive_isp_css_include/host/csi_rx_public.h      |    4 +-
 .../hive_isp_css_include/host/ibuf_ctrl_public.h   |    4 +-
 .../css2400/hive_isp_css_include/host/isp_op1w.h   |   98 +-
 .../css2400/hive_isp_css_include/host/isp_op2w.h   |   78 +-
 .../host/isys_stream2mmio_public.h                 |    4 +-
 .../hive_isp_css_include/host/pixelgen_public.h    |    4 +-
 .../hive_isp_css_include/host/ref_vector_func.h    |  144 +-
 .../css2400/hive_isp_css_include/math_support.h    |    2 +-
 .../css2400/hive_isp_css_include/string_support.h  |    8 +-
 .../css2400/hive_isp_css_shared/host/tag.c         |    4 +-
 .../media/atomisp/pci/atomisp2/css2400/ia_css.h    |    2 +-
 .../media/atomisp/pci/atomisp2/css2400/ia_css_3a.h |   38 +-
 .../pci/atomisp2/css2400/ia_css_acc_types.h        |  216 +--
 .../atomisp/pci/atomisp2/css2400/ia_css_buffer.h   |   32 +-
 .../atomisp/pci/atomisp2/css2400/ia_css_control.h  |   22 +-
 .../pci/atomisp2/css2400/ia_css_device_access.h    |    2 +-
 .../atomisp/pci/atomisp2/css2400/ia_css_dvs.h      |   52 +-
 .../atomisp/pci/atomisp2/css2400/ia_css_env.h      |   40 +-
 .../atomisp/pci/atomisp2/css2400/ia_css_err.h      |   18 +-
 .../pci/atomisp2/css2400/ia_css_event_public.h     |   68 +-
 .../atomisp/pci/atomisp2/css2400/ia_css_firmware.h |   14 +-
 .../atomisp/pci/atomisp2/css2400/ia_css_frac.h     |   10 +-
 .../pci/atomisp2/css2400/ia_css_frame_format.h     |   62 +-
 .../pci/atomisp2/css2400/ia_css_frame_public.h     |  120 +-
 .../pci/atomisp2/css2400/ia_css_input_port.h       |   32 +-
 .../atomisp/pci/atomisp2/css2400/ia_css_irq.h      |  112 +-
 .../atomisp/pci/atomisp2/css2400/ia_css_metadata.h |   24 +-
 .../atomisp/pci/atomisp2/css2400/ia_css_mipi.h     |   10 +-
 .../atomisp/pci/atomisp2/css2400/ia_css_mmu.h      |    4 +-
 .../atomisp/pci/atomisp2/css2400/ia_css_morph.h    |    6 +-
 .../pci/atomisp2/css2400/ia_css_pipe_public.h      |  128 +-
 .../atomisp/pci/atomisp2/css2400/ia_css_prbs.h     |   12 +-
 .../pci/atomisp2/css2400/ia_css_properties.h       |    6 +-
 .../atomisp/pci/atomisp2/css2400/ia_css_shading.h  |    6 +-
 .../atomisp/pci/atomisp2/css2400/ia_css_stream.h   |    4 +-
 .../pci/atomisp2/css2400/ia_css_stream_format.h    |   90 +-
 .../pci/atomisp2/css2400/ia_css_stream_public.h    |  148 +--
 .../atomisp/pci/atomisp2/css2400/ia_css_timer.h    |   30 +-
 .../atomisp/pci/atomisp2/css2400/ia_css_tpg.h      |    8 +-
 .../atomisp/pci/atomisp2/css2400/ia_css_types.h    |  258 ++--
 .../atomisp/pci/atomisp2/css2400/ia_css_version.h  |    6 +-
 .../css2400/isp/kernels/aa/aa_2/ia_css_aa2_types.h |    6 +-
 .../isp/kernels/anr/anr_1.0/ia_css_anr_types.h     |    6 +-
 .../isp/kernels/anr/anr_2/ia_css_anr2_types.h      |    4 +-
 .../isp/kernels/anr/anr_2/ia_css_anr_param.h       |    2 +-
 .../bayer_ls/bayer_ls_1.0/ia_css_bayer_ls_param.h  |    2 +-
 .../css2400/isp/kernels/bh/bh_2/ia_css_bh_types.h  |    4 +-
 .../css2400/isp/kernels/bnlm/ia_css_bnlm_types.h   |   36 +-
 .../isp/kernels/bnr/bnr2_2/ia_css_bnr2_2_types.h   |   34 +-
 .../isp/kernels/cnr/cnr_2/ia_css_cnr2_types.h      |   20 +-
 .../conversion_1.0/ia_css_conversion_types.h       |    8 +-
 .../isp/kernels/crop/crop_1.0/ia_css_crop_param.h  |    2 +-
 .../isp/kernels/crop/crop_1.0/ia_css_crop_types.h  |    2 +-
 .../isp/kernels/csc/csc_1.0/ia_css_csc_types.h     |    8 +-
 .../isp/kernels/ctc/ctc2/ia_css_ctc2_param.h       |   12 +-
 .../isp/kernels/ctc/ctc2/ia_css_ctc2_types.h       |   10 +-
 .../isp/kernels/ctc/ctc_1.0/ia_css_ctc_types.h     |   38 +-
 .../isp/kernels/de/de_1.0/ia_css_de_types.h        |   10 +-
 .../css2400/isp/kernels/de/de_2/ia_css_de2_types.h |   10 +-
 .../isp/kernels/dp/dp_1.0/ia_css_dp_types.h        |    8 +-
 .../css2400/isp/kernels/dpc2/ia_css_dpc2_types.h   |    6 +-
 .../isp/kernels/dvs/dvs_1.0/ia_css_dvs_param.h     |    2 +-
 .../isp/kernels/dvs/dvs_1.0/ia_css_dvs_types.h     |    2 +-
 .../isp/kernels/eed1_8/ia_css_eed1_8_types.h       |   82 +-
 .../isp/kernels/fc/fc_1.0/ia_css_formats_types.h   |    6 +-
 .../isp/kernels/fpn/fpn_1.0/ia_css_fpn_types.h     |   14 +-
 .../isp/kernels/gc/gc_1.0/ia_css_gc_types.h        |   32 +-
 .../css2400/isp/kernels/gc/gc_2/ia_css_gc2_types.h |   14 +-
 .../css2400/isp/kernels/hdr/ia_css_hdr_types.h     |   26 +-
 .../ipu2_io_ls/bayer_io_ls/ia_css_bayer_io.host.c  |    2 +-
 .../yuv444_io_ls/ia_css_yuv444_io.host.c           |    2 +-
 .../kernels/macc/macc1_5/ia_css_macc1_5_types.h    |   16 +-
 .../isp/kernels/macc/macc_1.0/ia_css_macc_types.h  |   12 +-
 .../css2400/isp/kernels/ob/ob2/ia_css_ob2_types.h  |   12 +-
 .../isp/kernels/ob/ob_1.0/ia_css_ob_types.h        |   26 +-
 .../output/output_1.0/ia_css_output_param.h        |    2 +-
 .../output/output_1.0/ia_css_output_types.h        |    8 +-
 .../kernels/qplane/qplane_2/ia_css_qplane_types.h  |    2 +-
 .../isp/kernels/raw/raw_1.0/ia_css_raw_types.h     |    2 +-
 .../isp/kernels/ref/ref_1.0/ia_css_ref_param.h     |    2 +-
 .../isp/kernels/ref/ref_1.0/ia_css_ref_types.h     |    2 +-
 .../isp/kernels/s3a/s3a_1.0/ia_css_s3a_types.h     |   98 +-
 .../kernels/s3a_stat_ls/ia_css_s3a_stat_ls_param.h |    2 +-
 .../css2400/isp/kernels/sc/sc_1.0/ia_css_sc.host.h |    4 +-
 .../isp/kernels/sc/sc_1.0/ia_css_sc_types.h        |   42 +-
 .../kernels/sdis/common/ia_css_sdis_common_types.h |  104 +-
 .../isp/kernels/sdis/sdis_1.0/ia_css_sdis_types.h  |   20 +-
 .../isp/kernels/sdis/sdis_2/ia_css_sdis2_types.h   |   40 +-
 .../isp/kernels/tdf/tdf_1.0/ia_css_tdf_types.h     |   38 +-
 .../isp/kernels/tnr/tnr3/ia_css_tnr3_types.h       |   26 +-
 .../isp/kernels/tnr/tnr_1.0/ia_css_tnr_types.h     |   10 +-
 .../isp/kernels/vf/vf_1.0/ia_css_vf_param.h        |    4 +-
 .../isp/kernels/vf/vf_1.0/ia_css_vf_types.h        |    4 +-
 .../isp/kernels/wb/wb_1.0/ia_css_wb_types.h        |   14 +-
 .../isp/kernels/xnr/xnr_1.0/ia_css_xnr.host.c      |    2 +-
 .../isp/kernels/xnr/xnr_1.0/ia_css_xnr_param.h     |    2 +-
 .../isp/kernels/xnr/xnr_1.0/ia_css_xnr_types.h     |   20 +-
 .../isp/kernels/xnr/xnr_3.0/ia_css_xnr3_types.h    |   30 +-
 .../isp/kernels/ynr/ynr_1.0/ia_css_ynr_types.h     |   28 +-
 .../isp/kernels/ynr/ynr_2/ia_css_ynr2_types.h      |   40 +-
 .../yuv_ls/yuv_ls_1.0/ia_css_yuv_ls_param.h        |    2 +-
 .../atomisp/pci/atomisp2/css2400/memory_realloc.c  |    2 +-
 .../runtime/binary/interface/ia_css_binary.h       |    2 +-
 .../atomisp2/css2400/runtime/binary/src/binary.c   |    2 +-
 .../pci/atomisp2/css2400/runtime/bufq/src/bufq.c   |    2 +-
 .../css2400/runtime/debug/interface/ia_css_debug.h |   30 +-
 .../css2400/runtime/debug/src/ia_css_debug.c       |   10 +-
 .../pci/atomisp2/css2400/runtime/event/src/event.c |    4 +-
 .../atomisp2/css2400/runtime/eventq/src/eventq.c   |    2 +-
 .../css2400/runtime/frame/interface/ia_css_frame.h |   22 +-
 .../pci/atomisp2/css2400/runtime/frame/src/frame.c |    2 +-
 .../pci/atomisp2/css2400/runtime/ifmtr/src/ifmtr.c |    2 +-
 .../css2400/runtime/inputfifo/src/inputfifo.c      |    2 +-
 .../isp_param/interface/ia_css_isp_param_types.h   |    6 +-
 .../css2400/runtime/isp_param/src/isp_param.c      |    2 +-
 .../css2400/runtime/isys/interface/ia_css_isys.h   |    6 +-
 .../css2400/runtime/isys/src/csi_rx_rmgr.c         |    2 +-
 .../css2400/runtime/isys/src/ibuf_ctrl_rmgr.c      |    2 +-
 .../css2400/runtime/isys/src/isys_dma_rmgr.c       |    2 +-
 .../atomisp2/css2400/runtime/isys/src/isys_init.c  |    2 +-
 .../runtime/isys/src/isys_stream2mmio_rmgr.c       |    2 +-
 .../pci/atomisp2/css2400/runtime/isys/src/rx.c     |    2 +-
 .../css2400/runtime/isys/src/virtual_isys.c        |    8 +-
 .../runtime/pipeline/interface/ia_css_pipeline.h   |   28 +-
 .../css2400/runtime/pipeline/src/pipeline.c        |    8 +-
 .../css2400/runtime/queue/interface/ia_css_queue.h |   22 +-
 .../css2400/runtime/queue/src/queue_access.c       |    2 +-
 .../pci/atomisp2/css2400/runtime/rmgr/src/rmgr.c   |    4 +-
 .../atomisp2/css2400/runtime/rmgr/src/rmgr_vbuf.c  |   26 +-
 .../runtime/spctrl/interface/ia_css_spctrl.h       |   20 +-
 .../runtime/spctrl/interface/ia_css_spctrl_comm.h  |   14 +-
 .../atomisp2/css2400/runtime/spctrl/src/spctrl.c   |    4 +-
 .../pci/atomisp2/css2400/runtime/timer/src/timer.c |    2 +-
 .../media/atomisp/pci/atomisp2/css2400/sh_css.c    |   68 +-
 .../atomisp/pci/atomisp2/css2400/sh_css_internal.h |   22 +-
 .../atomisp/pci/atomisp2/css2400/sh_css_legacy.h   |    2 +-
 .../atomisp/pci/atomisp2/css2400/sh_css_mipi.c     |    4 +-
 .../atomisp/pci/atomisp2/css2400/sh_css_params.h   |    4 +-
 .../media/atomisp/pci/atomisp2/css2400/sh_css_sp.c |   18 +-
 .../atomisp/pci/atomisp2/css2400/sh_css_struct.h   |    2 +-
 drivers/staging/octeon-usb/octeon-hcd.c            |    6 +-
 drivers/staging/pi433/rf69.c                       |    2 +-
 drivers/staging/rtl8188eu/os_dep/ioctl_linux.c     |   14 +-
 drivers/target/target_core_pscsi.c                 |    4 +-
 drivers/tee/optee/core.c                           |    1 -
 drivers/thunderbolt/nhi.c                          |    2 +-
 drivers/tty/n_tty.c                                |    4 +-
 drivers/tty/serdev/serdev-ttyport.c                |   26 +-
 drivers/tty/serial/8250/8250_early.c               |   14 +-
 drivers/tty/serial/8250/8250_pci.c                 |    3 +
 drivers/usb/chipidea/ci_hdrc_msm.c                 |    2 +-
 drivers/usb/common/ulpi.c                          |    4 +-
 drivers/usb/core/config.c                          |   32 +-
 drivers/usb/core/devio.c                           |   14 +-
 drivers/usb/core/hub.c                             |    9 +
 drivers/usb/core/quirks.c                          |    9 +-
 drivers/usb/dwc2/core.h                            |    4 +
 drivers/usb/dwc2/gadget.c                          |   42 +-
 drivers/usb/dwc2/params.c                          |   29 +-
 drivers/usb/dwc3/dwc3-of-simple.c                  |    5 +-
 drivers/usb/dwc3/gadget.c                          |    4 +-
 drivers/usb/gadget/composite.c                     |    7 +-
 drivers/usb/gadget/function/f_fs.c                 |   15 +-
 drivers/usb/gadget/legacy/Kconfig                  |    2 +-
 drivers/usb/gadget/udc/bdc/bdc_core.c              |    1 -
 drivers/usb/gadget/udc/core.c                      |    8 +-
 drivers/usb/gadget/udc/renesas_usb3.c              |    2 +-
 drivers/usb/host/ehci-dbg.c                        |    2 +-
 drivers/usb/host/xhci-debugfs.c                    |   16 +-
 drivers/usb/host/xhci-mem.c                        |   22 +-
 drivers/usb/host/xhci-pci.c                        |    3 +
 drivers/usb/host/xhci-ring.c                       |   18 +-
 drivers/usb/host/xhci.c                            |    6 +-
 drivers/usb/musb/da8xx.c                           |   10 +-
 drivers/usb/serial/ftdi_sio.c                      |    1 +
 drivers/usb/serial/ftdi_sio_ids.h                  |    6 +
 drivers/usb/serial/option.c                        |   20 +
 drivers/usb/serial/qcserial.c                      |    3 +
 drivers/usb/serial/usb_debug.c                     |    2 +
 drivers/usb/storage/uas-detect.h                   |    4 +
 drivers/usb/storage/unusual_devs.h                 |    7 +
 drivers/usb/storage/unusual_uas.h                  |    7 +
 drivers/usb/typec/Kconfig                          |   54 +-
 drivers/usb/typec/ucsi/Kconfig                     |    1 -
 drivers/usb/usbip/stub_dev.c                       |    3 +-
 drivers/usb/usbip/stub_main.c                      |    5 +-
 drivers/usb/usbip/stub_rx.c                        |   47 +-
 drivers/usb/usbip/stub_tx.c                        |   13 +-
 drivers/usb/usbip/usbip_common.c                   |   16 +-
 drivers/usb/usbip/usbip_common.h                   |    1 +
 drivers/usb/usbip/vhci_hcd.c                       |   13 +-
 drivers/usb/usbip/vhci_rx.c                        |   23 +-
 drivers/usb/usbip/vhci_sysfs.c                     |   25 +-
 drivers/usb/usbip/vhci_tx.c                        |    3 +-
 drivers/vhost/net.c                                |   20 +-
 drivers/virtio/virtio.c                            |    2 +
 drivers/virtio/virtio_balloon.c                    |    3 +-
 drivers/virtio/virtio_mmio.c                       |   22 +-
 drivers/xen/Kconfig                                |    2 +-
 drivers/xen/balloon.c                              |   65 +-
 drivers/xen/pvcalls-front.c                        |    6 +-
 fs/9p/vfs_super.c                                  |    6 +-
 fs/adfs/super.c                                    |    4 +-
 fs/affs/amigaffs.c                                 |    2 +-
 fs/affs/bitmap.c                                   |    6 +-
 fs/affs/super.c                                    |   16 +-
 fs/afs/dir.c                                       |   37 +-
 fs/afs/inode.c                                     |    4 +
 fs/afs/internal.h                                  |    5 +-
 fs/afs/rxrpc.c                                     |    2 +-
 fs/afs/security.c                                  |   18 +-
 fs/afs/super.c                                     |   18 +-
 fs/afs/write.c                                     |    8 +-
 fs/autofs4/root.c                                  |   17 +-
 fs/autofs4/waitq.c                                 |    1 -
 fs/befs/ChangeLog                                  |    2 +-
 fs/befs/linuxvfs.c                                 |    4 +-
 fs/btrfs/compression.c                             |    9 +-
 fs/btrfs/compression.h                             |    5 +-
 fs/btrfs/ctree.c                                   |   18 +-
 fs/btrfs/ctree.h                                   |    3 +-
 fs/btrfs/delayed-inode.c                           |   45 +-
 fs/btrfs/disk-io.c                                 |   22 +-
 fs/btrfs/extent-tree.c                             |   15 +-
 fs/btrfs/extent_io.c                               |    4 +-
 fs/btrfs/extent_io.h                               |    8 +-
 fs/btrfs/file.c                                    |  130 +-
 fs/btrfs/free-space-cache.c                        |    3 +-
 fs/btrfs/inode.c                                   |   36 +-
 fs/btrfs/ioctl.c                                   |    6 +-
 fs/btrfs/relocation.c                              |    3 +-
 fs/btrfs/send.c                                    |  124 +-
 fs/btrfs/super.c                                   |   63 +-
 fs/btrfs/tests/extent-io-tests.c                   |    6 +-
 fs/btrfs/tests/inode-tests.c                       |   12 +-
 fs/btrfs/tree-checker.c                            |   27 +-
 fs/btrfs/tree-checker.h                            |   14 +-
 fs/btrfs/tree-log.c                                |    2 +-
 fs/btrfs/volumes.c                                 |   37 +-
 fs/ceph/mds_client.c                               |   42 +-
 fs/ceph/super.c                                    |    8 +-
 fs/cifs/cifs_fs_sb.h                               |    2 +-
 fs/cifs/cifsfs.c                                   |   12 +-
 fs/cifs/cifsglob.h                                 |    4 +-
 fs/cifs/inode.c                                    |    2 +-
 fs/cifs/smb2ops.c                                  |    3 +-
 fs/cifs/smb2pdu.c                                  |   30 +-
 fs/cifs/xattr.c                                    |    8 +-
 fs/coda/inode.c                                    |    4 +-
 fs/cramfs/Kconfig                                  |    1 +
 fs/cramfs/inode.c                                  |    4 +-
 fs/ecryptfs/main.c                                 |    8 +-
 fs/efs/super.c                                     |    4 +-
 fs/exec.c                                          |   16 +-
 fs/ext2/balloc.c                                   |    4 +-
 fs/ext2/ialloc.c                                   |    4 +-
 fs/ext2/super.c                                    |   20 +-
 fs/ext4/extents.c                                  |    1 +
 fs/ext4/ialloc.c                                   |    2 +
 fs/ext4/inode.c                                    |   13 +-
 fs/ext4/namei.c                                    |    4 +
 fs/ext4/super.c                                    |   52 +-
 fs/f2fs/checkpoint.c                               |   10 +-
 fs/f2fs/f2fs.h                                     |    2 +-
 fs/f2fs/gc.c                                       |    2 +-
 fs/f2fs/recovery.c                                 |   10 +-
 fs/f2fs/super.c                                    |   28 +-
 fs/fat/fatent.c                                    |    6 +-
 fs/fat/inode.c                                     |   10 +-
 fs/fat/misc.c                                      |    2 +-
 fs/fat/namei_msdos.c                               |    2 +-
 fs/freevxfs/vxfs_super.c                           |    4 +-
 fs/fs-writeback.c                                  |    2 +-
 fs/fuse/inode.c                                    |   12 +-
 fs/gfs2/ops_fstype.c                               |   16 +-
 fs/gfs2/super.c                                    |   10 +-
 fs/gfs2/trans.c                                    |    2 +-
 fs/hfs/mdb.c                                       |    4 +-
 fs/hfs/super.c                                     |   16 +-
 fs/hfsplus/super.c                                 |   22 +-
 fs/hpfs/dir.c                                      |    1 -
 fs/hpfs/dnode.c                                    |    2 -
 fs/hpfs/map.c                                      |    2 +-
 fs/hpfs/super.c                                    |    9 +-
 fs/hugetlbfs/inode.c                               |    4 +-
 fs/inode.c                                         |   10 +-
 fs/isofs/inode.c                                   |    2 +-
 fs/jffs2/fs.c                                      |    4 +-
 fs/jffs2/os-linux.h                                |    2 +-
 fs/jffs2/super.c                                   |    4 +-
 fs/jfs/super.c                                     |   10 +-
 fs/kernfs/mount.c                                  |    2 +-
 fs/libfs.c                                         |    6 +-
 fs/lockd/host.c                                    |   24 +-
 fs/lockd/mon.c                                     |    3 +-
 fs/lockd/svc.c                                     |   38 +-
 fs/lockd/svcsubs.c                                 |    2 +-
 fs/locks.c                                         |    2 +-
 fs/mbcache.c                                       |    3 +
 fs/minix/inode.c                                   |    4 +-
 fs/namei.c                                         |   15 +-
 fs/namespace.c                                     |    1 +
 fs/ncpfs/inode.c                                   |    4 +-
 fs/nfs/client.c                                    |   11 +
 fs/nfs/dir.c                                       |    2 +-
 fs/nfs/inode.c                                     |    2 +-
 fs/nfs/internal.h                                  |    2 +-
 fs/nfs/nfs4client.c                                |   17 +-
 fs/nfs/nfs4state.c                                 |    4 +-
 fs/nfs/super.c                                     |   22 +-
 fs/nfs/write.c                                     |    2 +
 fs/nfs_common/grace.c                              |   10 +-
 fs/nfsd/auth.c                                     |    3 +
 fs/nfsd/export.c                                   |   10 +-
 fs/nfsd/netns.h                                    |    3 +
 fs/nfsd/nfs4idmap.c                                |    4 +-
 fs/nfsd/nfs4state.c                                |  279 ++--
 fs/nfsd/nfsctl.c                                   |    3 +
 fs/nfsd/nfssvc.c                                   |   14 +-
 fs/nilfs2/segment.c                                |    2 +-
 fs/nilfs2/super.c                                  |   24 +-
 fs/nilfs2/the_nilfs.c                              |    6 +-
 fs/notify/fsnotify.c                               |    2 +-
 fs/nsfs.c                                          |    2 +-
 fs/ntfs/super.c                                    |   32 +-
 fs/ocfs2/file.c                                    |    2 +-
 fs/ocfs2/super.c                                   |   28 +-
 fs/ocfs2/xattr.c                                   |    2 +-
 fs/openpromfs/inode.c                              |    4 +-
 fs/orangefs/super.c                                |    8 +-
 fs/overlayfs/Kconfig                               |   10 +
 fs/overlayfs/dir.c                                 |    3 +-
 fs/overlayfs/namei.c                               |   18 +-
 fs/overlayfs/overlayfs.h                           |    2 +-
 fs/overlayfs/ovl_entry.h                           |    2 +
 fs/overlayfs/readdir.c                             |    7 +-
 fs/overlayfs/super.c                               |   97 +-
 fs/proc/base.c                                     |    5 +-
 fs/proc/inode.c                                    |    2 +-
 fs/proc/root.c                                     |    2 +-
 fs/proc_namespace.c                                |    8 +-
 fs/qnx4/inode.c                                    |    4 +-
 fs/qnx6/inode.c                                    |    4 +-
 fs/quota/dquot.c                                   |   22 +-
 fs/reiserfs/inode.c                                |    2 +-
 fs/reiserfs/journal.c                              |    6 +-
 fs/reiserfs/prints.c                               |    4 +-
 fs/reiserfs/super.c                                |   19 +-
 fs/reiserfs/xattr.c                                |   10 +-
 fs/romfs/super.c                                   |    4 +-
 fs/squashfs/super.c                                |    4 +-
 fs/statfs.c                                        |    6 +-
 fs/super.c                                         |   43 +-
 fs/sysfs/mount.c                                   |    2 +-
 fs/sysv/inode.c                                    |    2 +-
 fs/sysv/super.c                                    |    2 +-
 fs/ubifs/file.c                                    |    2 +-
 fs/ubifs/io.c                                      |    2 +-
 fs/ubifs/super.c                                   |   20 +-
 fs/ubifs/ubifs.h                                   |    4 +-
 fs/udf/super.c                                     |    6 +-
 fs/ufs/balloc.c                                    |    8 +-
 fs/ufs/ialloc.c                                    |   10 +-
 fs/ufs/super.c                                     |   30 +-
 fs/userfaultfd.c                                   |   20 +-
 fs/xfs/libxfs/xfs_alloc.c                          |    4 +-
 fs/xfs/libxfs/xfs_attr.c                           |   20 +-
 fs/xfs/libxfs/xfs_attr_leaf.c                      |    9 +-
 fs/xfs/libxfs/xfs_attr_leaf.h                      |    3 +-
 fs/xfs/libxfs/xfs_bmap.c                           |    8 +-
 fs/xfs/libxfs/xfs_defer.c                          |   39 +-
 fs/xfs/libxfs/xfs_defer.h                          |    5 +-
 fs/xfs/libxfs/xfs_ialloc.c                         |   10 +-
 fs/xfs/libxfs/xfs_ialloc.h                         |    1 -
 fs/xfs/libxfs/xfs_iext_tree.c                      |    4 +-
 fs/xfs/libxfs/xfs_refcount.c                       |   52 +-
 fs/xfs/libxfs/xfs_rmap.c                           |   99 +-
 fs/xfs/libxfs/xfs_rmap.h                           |   16 +-
 fs/xfs/scrub/inode.c                               |   14 +-
 fs/xfs/scrub/quota.c                               |    4 +-
 fs/xfs/scrub/scrub.c                               |    1 -
 fs/xfs/scrub/trace.c                               |    1 -
 fs/xfs/xfs_aops.c                                  |   12 +-
 fs/xfs/xfs_bmap_item.c                             |   23 +-
 fs/xfs/xfs_bmap_item.h                             |    3 +-
 fs/xfs/xfs_buf.c                                   |   15 +-
 fs/xfs/xfs_dquot.c                                 |   14 +-
 fs/xfs/xfs_dquot_item.c                            |   40 +-
 fs/xfs/xfs_extfree_item.c                          |    2 +-
 fs/xfs/xfs_fsops.c                                 |    5 +
 fs/xfs/xfs_icache.c                                |   35 +-
 fs/xfs/xfs_icache.h                                |    1 +
 fs/xfs/xfs_inode.c                                 |   82 +-
 fs/xfs/xfs_inode.h                                 |    3 +-
 fs/xfs/xfs_iomap.c                                 |    4 +-
 fs/xfs/xfs_log.c                                   |    6 +-
 fs/xfs/xfs_log_recover.c                           |   75 +-
 fs/xfs/xfs_qm.c                                    |   50 +-
 fs/xfs/xfs_refcount_item.c                         |   21 +-
 fs/xfs/xfs_refcount_item.h                         |    3 +-
 fs/xfs/xfs_reflink.c                               |   23 +-
 fs/xfs/xfs_super.c                                 |   17 +-
 fs/xfs/xfs_super.h                                 |    2 +-
 fs/xfs/xfs_symlink.c                               |   15 +-
 fs/xfs/xfs_trace.c                                 |    1 -
 include/acpi/acpi_bus.h                            |    1 +
 include/acpi/acpi_drivers.h                        |    1 +
 include/asm-generic/mm_hooks.h                     |    5 +-
 include/asm-generic/pgtable.h                      |   17 +-
 include/crypto/if_alg.h                            |    6 +-
 include/crypto/internal/hash.h                     |    8 +
 include/crypto/mcryptd.h                           |    1 +
 include/drm/drm_connector.h                        |   10 +
 include/drm/drm_edid.h                             |    5 +-
 include/drm/drm_mode_config.h                      |   18 +-
 include/drm/ttm/ttm_page_alloc.h                   |   32 +-
 include/kvm/arm_arch_timer.h                       |    5 +-
 include/linux/bio.h                                |    2 +
 include/linux/blk_types.h                          |    9 +-
 include/linux/blkdev.h                             |   25 +-
 include/linux/bpf.h                                |   10 +
 include/linux/bpf_verifier.h                       |    4 +-
 include/linux/compiler.h                           |   47 +-
 include/linux/completion.h                         |   45 -
 include/linux/cpuhotplug.h                         |    2 +-
 include/linux/cred.h                               |    1 +
 include/linux/debugfs.h                            |    2 +
 include/linux/dma-mapping.h                        |    2 -
 include/linux/efi.h                                |    4 +-
 include/linux/fs.h                                 |   19 +-
 include/linux/fscache.h                            |    2 +-
 include/linux/gpio/driver.h                        |   33 +-
 include/linux/hugetlb.h                            |    8 -
 include/linux/hyperv.h                             |    1 +
 include/linux/idr.h                                |    1 +
 include/linux/iio/adc/stm32-dfsdm-adc.h            |   18 +
 include/linux/iio/consumer.h                       |   37 +
 include/linux/iio/hw-consumer.h                    |   21 +
 include/linux/iio/iio.h                            |   28 -
 include/linux/iio/timer/stm32-lptim-trigger.h      |    5 +-
 include/linux/iio/types.h                          |   28 +
 include/linux/intel-pti.h                          |   43 +
 include/linux/ipv6.h                               |    3 +-
 include/linux/irq.h                                |   17 +
 include/linux/irqdesc.h                            |   15 +-
 include/linux/irqdomain.h                          |    2 +-
 include/linux/kallsyms.h                           |    6 -
 include/linux/kmemcheck.h                          |    1 -
 include/linux/kvm_host.h                           |    5 +-
 include/{lib =3D> linux}/libgcc.h                    |    0
 include/linux/lockdep.h                            |  125 --
 include/linux/mfd/rtsx_pci.h                       |    2 +-
 include/linux/migrate.h                            |    2 +-
 include/linux/mlx5/driver.h                        |    7 +-
 include/linux/mlx5/mlx5_ifc.h                      |    8 +-
 include/linux/mm.h                                 |   14 +
 include/linux/oom.h                                |    9 +
 include/linux/pci.h                                |    3 +
 include/linux/perf_event.h                         |    6 +-
 include/linux/pm.h                                 |    1 +
 include/linux/pti.h                                |   50 +-
 include/linux/ptr_ring.h                           |    9 +
 include/linux/rbtree.h                             |    2 +
 include/linux/rculist_nulls.h                      |   38 -
 include/linux/rwlock_types.h                       |    3 -
 include/linux/sched.h                              |   17 +-
 include/linux/sched/coredump.h                     |    1 +
 include/linux/serdev.h                             |    2 +-
 include/linux/skbuff.h                             |    3 +-
 include/linux/spi/spi.h                            |    2 +-
 include/linux/spinlock.h                           |    5 -
 include/linux/spinlock_types.h                     |    3 -
 include/linux/string.h                             |    5 +-
 include/linux/sunrpc/cache.h                       |    2 +-
 include/linux/sysfs.h                              |    6 +
 include/linux/tcp.h                                |    3 +-
 include/linux/tick.h                               |    1 +
 include/linux/timer.h                              |    4 +-
 include/linux/trace.h                              |    2 +-
 include/linux/usb/usbnet.h                         |    1 +
 include/net/cfg80211.h                             |    1 -
 include/net/gue.h                                  |   18 +-
 include/net/ip.h                                   |    1 +
 include/net/mac80211.h                             |    8 +-
 include/net/pkt_cls.h                              |    5 +-
 include/net/red.h                                  |   13 +-
 include/net/sch_generic.h                          |    1 +
 include/net/sctp/checksum.h                        |   13 +-
 include/net/sctp/sctp.h                            |    5 +
 include/net/sctp/stream_sched.h                    |    5 +
 include/net/sctp/structs.h                         |    3 +-
 include/net/sock.h                                 |   11 +-
 include/net/tc_act/tc_sample.h                     |    1 -
 include/net/tcp.h                                  |    5 +-
 include/net/xfrm.h                                 |    3 +
 include/scsi/libsas.h                              |    2 +-
 include/sound/hdaudio_ext.h                        |    4 +-
 include/sound/pcm.h                                |    8 +
 include/sound/rt5514.h                             |    2 +
 include/sound/rt5645.h                             |    3 +
 include/sound/soc-acpi-intel-match.h               |    1 +
 include/sound/soc-acpi.h                           |    4 +-
 include/sound/soc-dai.h                            |    5 +-
 include/sound/soc.h                                |    6 +-
 include/trace/events/clk.h                         |    4 +-
 include/trace/events/kvm.h                         |    7 +-
 include/trace/events/preemptirq.h                  |   11 +-
 include/trace/events/rxrpc.h                       |   86 +-
 include/trace/events/tcp.h                         |   97 +-
 include/trace/events/xdp.h                         |    1 +
 include/uapi/asm-generic/bpf_perf_event.h          |    9 +
 include/uapi/linux/bcache.h                        |    2 +-
 include/uapi/linux/bfs_fs.h                        |    2 +-
 include/uapi/linux/bpf_perf_event.h                |    5 +-
 include/uapi/linux/kfd_ioctl.h                     |   22 +-
 include/uapi/linux/kvm.h                           |    4 +-
 include/uapi/linux/pkt_sched.h                     |    1 -
 include/uapi/linux/rtnetlink.h                     |    1 +
 include/uapi/linux/rxrpc.h                         |    1 +
 include/uapi/linux/usb/ch9.h                       |    3 +
 include/uapi/linux/vm_sockets_diag.h               |    1 +
 include/uapi/sound/asound.h                        |    9 +
 include/uapi/sound/snd_sst_tokens.h                |   17 +-
 include/xen/balloon.h                              |    5 +
 init/Kconfig                                       |    6 +-
 init/main.c                                        |   16 +-
 ipc/mqueue.c                                       |    2 +-
 kernel/acct.c                                      |    2 +-
 kernel/bpf/core.c                                  |    3 +-
 kernel/bpf/hashtab.c                               |    2 +
 kernel/bpf/inode.c                                 |   40 +-
 kernel/bpf/offload.c                               |   15 +
 kernel/bpf/syscall.c                               |    2 +-
 kernel/bpf/verifier.c                              |  283 ++--
 kernel/cgroup/debug.c                              |    4 +-
 kernel/cgroup/stat.c                               |    8 +-
 kernel/cpu.c                                       |   26 +-
 kernel/debug/kdb/kdb_io.c                          |    2 +-
 kernel/events/core.c                               |    7 +-
 kernel/exit.c                                      |    9 +
 kernel/fork.c                                      |    3 +-
 kernel/futex.c                                     |    4 +-
 kernel/groups.c                                    |    5 +-
 kernel/irq/debug.h                                 |    5 +
 kernel/irq/debugfs.c                               |    1 +
 kernel/irq/generic-chip.c                          |   11 +-
 kernel/irq/internals.h                             |    2 +-
 kernel/irq/irqdomain.c                             |   13 +-
 kernel/irq/matrix.c                                |    4 +-
 kernel/irq/msi.c                                   |   64 +-
 kernel/kallsyms.c                                  |    8 +-
 kernel/kcov.c                                      |    4 +-
 kernel/locking/lockdep.c                           |  651 +--------
 kernel/locking/spinlock.c                          |   13 +-
 kernel/module.c                                    |    6 +-
 kernel/pid.c                                       |    8 +-
 kernel/printk/printk.c                             |    3 -
 kernel/sched/core.c                                |   22 +-
 kernel/sched/cpufreq_schedutil.c                   |    2 +-
 kernel/sched/fair.c                                |  102 +-
 kernel/sched/rt.c                                  |    8 +-
 kernel/sched/wait.c                                |    2 +-
 kernel/time/Kconfig                                |    1 +
 kernel/time/posix-timers.c                         |   29 +-
 kernel/time/tick-sched.c                           |   32 +-
 kernel/time/timer.c                                |   35 +-
 kernel/trace/Kconfig                               |    1 +
 kernel/trace/blktrace.c                            |   30 +-
 kernel/trace/bpf_trace.c                           |   27 +-
 kernel/trace/ring_buffer.c                         |   18 +-
 kernel/trace/trace.c                               |   54 +-
 kernel/trace/trace_stack.c                         |    4 +
 kernel/uid16.c                                     |    1 +
 kernel/workqueue.c                                 |   33 +-
 lib/Kconfig.debug                                  |   33 -
 lib/ashldi3.c                                      |    2 +-
 lib/ashrdi3.c                                      |    2 +-
 lib/asn1_decoder.c                                 |   49 +-
 lib/cmpdi2.c                                       |    2 +-
 lib/kobject_uevent.c                               |   16 +-
 lib/lshrdi3.c                                      |    2 +-
 lib/mpi/longlong.h                                 |   18 +-
 lib/muldi3.c                                       |    2 +-
 lib/nlattr.c                                       |   22 +-
 lib/oid_registry.c                                 |   16 +-
 lib/rbtree.c                                       |   10 +
 lib/test_bpf.c                                     |   43 +
 lib/test_printf.c                                  |  108 +-
 lib/timerqueue.c                                   |    8 +-
 lib/ucmpdi2.c                                      |    2 +-
 lib/vsprintf.c                                     |  194 ++-
 mm/backing-dev.c                                   |   17 +-
 mm/debug.c                                         |   28 +-
 mm/early_ioremap.c                                 |    2 +-
 mm/frame_vector.c                                  |   14 +
 mm/gup.c                                           |   64 +
 mm/huge_memory.c                                   |   36 +-
 mm/hugetlb.c                                       |   12 +-
 mm/kasan/report.c                                  |    8 +-
 mm/kmemcheck.c                                     |    1 -
 mm/kmemleak.c                                      |    2 +
 mm/madvise.c                                       |    4 +-
 mm/memcontrol.c                                    |    2 +-
 mm/memory.c                                        |    3 +-
 mm/mmap.c                                          |   18 +-
 mm/mprotect.c                                      |    6 +-
 mm/oom_kill.c                                      |   11 +-
 mm/page-writeback.c                                |    5 +-
 mm/page_alloc.c                                    |   26 +-
 mm/percpu.c                                        |    4 +
 mm/shmem.c                                         |   10 +-
 mm/slab.c                                          |   23 +-
 mm/sparse.c                                        |    2 +-
 mm/vmscan.c                                        |    3 +
 mm/zsmalloc.c                                      |    1 +
 net/9p/trans_fd.c                                  |    1 -
 net/batman-adv/bat_iv_ogm.c                        |    4 +-
 net/batman-adv/bat_v.c                             |    2 +-
 net/batman-adv/fragmentation.c                     |    2 +
 net/batman-adv/tp_meter.c                          |    4 +-
 net/bridge/br_netlink.c                            |   11 +-
 net/core/dev.c                                     |    4 +-
 net/core/net_namespace.c                           |    2 +-
 net/core/netprio_cgroup.c                          |    1 -
 net/core/skbuff.c                                  |   17 +-
 net/dccp/minisocks.c                               |    6 +
 net/dccp/proto.c                                   |    5 +
 net/dsa/dsa2.c                                     |   25 +-
 net/dsa/slave.c                                    |    1 -
 net/ipv4/devinet.c                                 |    2 +-
 net/ipv4/fib_frontend.c                            |    9 +-
 net/ipv4/fib_semantics.c                           |    8 +-
 net/ipv4/igmp.c                                    |   44 +-
 net/ipv4/inet_timewait_sock.c                      |    6 +-
 net/ipv4/ip_gre.c                                  |    3 +-
 net/ipv4/ip_tunnel.c                               |    4 +-
 net/ipv4/netfilter/arp_tables.c                    |    1 -
 net/ipv4/netfilter/ip_tables.c                     |    1 -
 net/ipv4/netfilter/ipt_CLUSTERIP.c                 |    3 +-
 net/ipv4/raw.c                                     |   15 +-
 net/ipv4/tcp.c                                     |    1 +
 net/ipv4/tcp_bbr.c                                 |   12 +-
 net/ipv4/tcp_input.c                               |   22 +-
 net/ipv4/tcp_ipv4.c                                |   61 +-
 net/ipv4/tcp_minisocks.c                           |    6 +
 net/ipv4/tcp_rate.c                                |   10 +-
 net/ipv4/tcp_recovery.c                            |   28 +-
 net/ipv4/tcp_timer.c                               |    2 +
 net/ipv4/xfrm4_input.c                             |   12 +-
 net/ipv6/af_inet6.c                                |    1 -
 net/ipv6/ip6_gre.c                                 |   58 +-
 net/ipv6/ip6_output.c                              |   12 +-
 net/ipv6/ip6_tunnel.c                              |   11 +-
 net/ipv6/ipv6_sockglue.c                           |    1 +
 net/ipv6/mcast.c                                   |   25 +-
 net/ipv6/netfilter/ip6_tables.c                    |    1 -
 net/ipv6/netfilter/ip6t_MASQUERADE.c               |    8 +-
 net/ipv6/route.c                                   |   20 +-
 net/ipv6/sit.c                                     |    1 +
 net/ipv6/tcp_ipv6.c                                |   13 +-
 net/ipv6/xfrm6_input.c                             |   10 +-
 net/kcm/kcmsock.c                                  |   68 +-
 net/mac80211/ht.c                                  |    7 +-
 net/mac80211/mesh_hwmp.c                           |   15 +-
 net/mac80211/mlme.c                                |    2 +-
 net/mac80211/tx.c                                  |   29 +-
 net/netfilter/nf_conntrack_h323_asn1.c             |  128 +-
 net/netfilter/nf_conntrack_netlink.c               |   13 +-
 net/netfilter/nf_conntrack_proto_tcp.c             |    3 +
 net/netfilter/nf_tables_api.c                      |    7 +
 net/netfilter/nfnetlink_cthelper.c                 |   10 +
 net/netfilter/nfnetlink_log.c                      |    5 +
 net/netfilter/nfnetlink_queue.c                    |    5 +
 net/netfilter/nft_exthdr.c                         |    2 +
 net/netfilter/x_tables.c                           |    9 +
 net/netfilter/xt_bpf.c                             |   20 +-
 net/netfilter/xt_osf.c                             |    7 +
 net/netlink/af_netlink.c                           |    3 +
 net/openvswitch/datapath.c                         |    2 +-
 net/openvswitch/flow.c                             |   15 +-
 net/openvswitch/flow_netlink.c                     |   16 +-
 net/packet/af_packet.c                             |   37 +-
 net/packet/internal.h                              |    1 -
 net/rds/rdma.c                                     |    2 +-
 net/rds/send.c                                     |    3 +
 net/rxrpc/af_rxrpc.c                               |   24 +-
 net/rxrpc/ar-internal.h                            |  103 +-
 net/rxrpc/call_accept.c                            |    2 +-
 net/rxrpc/call_event.c                             |  229 ++--
 net/rxrpc/call_object.c                            |   62 +-
 net/rxrpc/conn_client.c                            |   54 +-
 net/rxrpc/conn_event.c                             |  124 +-
 net/rxrpc/conn_object.c                            |   76 +-
 net/rxrpc/input.c                                  |   76 +-
 net/rxrpc/misc.c                                   |   19 +-
 net/rxrpc/net_ns.c                                 |   33 +-
 net/rxrpc/output.c                                 |   43 +-
 net/rxrpc/recvmsg.c                                |   12 +-
 net/rxrpc/sendmsg.c                                |  126 +-
 net/rxrpc/sysctl.c                                 |   60 +-
 net/sched/act_meta_mark.c                          |    1 -
 net/sched/act_meta_skbtcindex.c                    |    1 -
 net/sched/act_sample.c                             |   14 +-
 net/sched/cls_api.c                                |   20 +-
 net/sched/cls_bpf.c                                |  116 +-
 net/sched/cls_u32.c                                |    1 -
 net/sched/sch_api.c                                |    2 +
 net/sched/sch_cbq.c                                |    9 +-
 net/sched/sch_choke.c                              |    3 +
 net/sched/sch_generic.c                            |    7 +-
 net/sched/sch_gred.c                               |    3 +
 net/sched/sch_ingress.c                            |   15 +-
 net/sched/sch_red.c                                |   33 +-
 net/sched/sch_sfq.c                                |    4 +
 net/sctp/chunk.c                                   |   11 +
 net/sctp/debug.c                                   |    3 +
 net/sctp/outqueue.c                                |   19 +-
 net/sctp/protocol.c                                |    1 +
 net/sctp/socket.c                                  |   17 +-
 net/sctp/stream.c                                  |   79 +-
 net/sctp/stream_sched.c                            |   25 +-
 net/sctp/stream_sched_prio.c                       |    7 +-
 net/sctp/stream_sched_rr.c                         |    7 +-
 net/sctp/ulpqueue.c                                |   24 +-
 net/socket.c                                       |  110 +-
 net/strparser/strparser.c                          |    2 +-
 net/sunrpc/auth_gss/gss_rpc_xdr.c                  |    1 +
 net/sunrpc/auth_gss/svcauth_gss.c                  |    5 +-
 net/sunrpc/cache.c                                 |    2 +-
 net/sunrpc/clnt.c                                  |    5 +
 net/sunrpc/svcauth_unix.c                          |    6 +-
 net/sunrpc/xprt.c                                  |   28 +-
 net/sunrpc/xprtrdma/rpc_rdma.c                     |    6 +-
 net/sunrpc/xprtrdma/transport.c                    |    2 +
 net/sunrpc/xprtrdma/verbs.c                        |    2 +-
 net/sunrpc/xprtrdma/xprt_rdma.h                    |    1 +
 net/sunrpc/xprtsock.c                              |    2 +
 net/tipc/bearer.c                                  |    5 +-
 net/tipc/group.c                                   |   49 +-
 net/tipc/monitor.c                                 |    6 +-
 net/tipc/server.c                                  |    3 +-
 net/tipc/socket.c                                  |    4 +-
 net/tipc/udp_media.c                               |    4 -
 net/vmw_vsock/hyperv_transport.c                   |    2 +-
 net/vmw_vsock/vmci_transport.c                     |   14 +-
 net/wireless/Kconfig                               |    7 +
 net/wireless/Makefile                              |   39 +-
 net/wireless/certs/sforshee.hex                    |   86 ++
 net/wireless/certs/sforshee.x509                   |  Bin 680 -> 0 bytes
 net/wireless/nl80211.c                             |    6 +-
 net/xfrm/xfrm_input.c                              |   69 +-
 net/xfrm/xfrm_policy.c                             |    9 +-
 net/xfrm/xfrm_state.c                              |    1 +
 net/xfrm/xfrm_user.c                               |   26 +-
 samples/bpf/bpf_load.c                             |   14 +-
 scripts/bloat-o-meter                              |    7 +-
 scripts/checkpatch.pl                              |   24 +-
 scripts/faddr2line                                 |   21 +-
 scripts/kernel-doc                                 |    2 +-
 security/Kconfig                                   |   11 +
 security/apparmor/apparmorfs.c                     |    2 +-
 security/apparmor/include/audit.h                  |   12 +-
 security/apparmor/include/lib.h                    |    2 +-
 security/apparmor/mount.c                          |   12 +-
 security/commoncap.c                               |   21 +-
 security/keys/key.c                                |    1 -
 security/keys/keyctl.c                             |   24 +-
 security/keys/request_key.c                        |   48 +-
 sound/core/pcm.c                                   |    2 +
 sound/core/pcm_misc.c                              |   19 +-
 sound/core/rawmidi.c                               |   15 +-
 sound/core/seq/seq_timer.c                         |    2 +-
 sound/hda/ext/hdac_ext_bus.c                       |    2 +-
 sound/hda/hdac_i915.c                              |    2 +-
 sound/pci/hda/patch_conexant.c                     |   29 +
 sound/pci/hda/patch_hdmi.c                         |    6 +-
 sound/pci/hda/patch_realtek.c                      |   57 +-
 sound/soc/Kconfig                                  |    1 +
 sound/soc/Makefile                                 |    1 +
 sound/soc/amd/acp-pcm-dma.c                        |   42 +-
 sound/soc/atmel/Kconfig                            |    2 +-
 sound/soc/atmel/atmel-classd.c                     |    6 -
 sound/soc/cirrus/ep93xx-ac97.c                     |    6 +-
 sound/soc/codecs/88pm860x-codec.c                  |    9 +-
 sound/soc/codecs/Kconfig                           |   38 +-
 sound/soc/codecs/Makefile                          |   11 +-
 sound/soc/codecs/cq93vc.c                          |   10 +-
 sound/soc/codecs/cs35l32.c                         |   18 +-
 sound/soc/codecs/cs35l34.c                         |   19 +-
 sound/soc/codecs/cs42l52.c                         |   13 +-
 sound/soc/codecs/cs42l56.c                         |   13 +-
 sound/soc/codecs/cs42l73.c                         |   13 +-
 sound/soc/codecs/cs47l24.c                         |   12 +-
 sound/soc/codecs/cx20442.c                         |   44 +-
 sound/soc/codecs/da7213.c                          |    7 +-
 sound/soc/codecs/da7218.c                          |   11 +-
 sound/soc/codecs/dmic.c                            |   24 +-
 sound/soc/codecs/hdac_hdmi.c                       |  358 +++--
 sound/soc/codecs/max98373.c                        |  976 ++++++++++++++
 sound/soc/codecs/max98373.h                        |  212 +++
 sound/soc/codecs/max98926.c                        |    2 +-
 sound/soc/codecs/max98927.c                        |    1 -
 sound/soc/codecs/mc13783.c                         |    9 +-
 sound/soc/codecs/msm8916-wcd-analog.c              |   10 +-
 sound/soc/codecs/msm8916-wcd-digital.c             |    4 +-
 sound/soc/codecs/nau8540.c                         |   98 +-
 sound/soc/codecs/nau8540.h                         |   20 +
 sound/soc/codecs/nau8824.c                         |   18 +-
 sound/soc/codecs/nau8825.c                         |  102 +-
 sound/soc/codecs/nau8825.h                         |    3 +-
 sound/soc/codecs/pcm186x-i2c.c                     |   69 +
 sound/soc/codecs/pcm186x-spi.c                     |   69 +
 sound/soc/codecs/pcm186x.c                         |  719 ++++++++++
 sound/soc/codecs/pcm186x.h                         |  220 ++++
 sound/soc/codecs/pcm512x-spi.c                     |    4 +
 sound/soc/codecs/rl6231.c                          |   93 +-
 sound/soc/codecs/rt5514-spi.c                      |   16 +-
 sound/soc/codecs/rt5514.c                          |   87 +-
 sound/soc/codecs/rt5514.h                          |    5 +-
 sound/soc/codecs/rt5645.c                          |  189 ++-
 sound/soc/codecs/rt5645.h                          |    6 +
 sound/soc/codecs/rt5663.c                          |    4 +
 sound/soc/codecs/rt5663.h                          |    4 +
 sound/soc/codecs/si476x.c                          |    9 +-
 sound/soc/codecs/sn95031.c                         |  936 -------------
 sound/soc/codecs/sn95031.h                         |  133 --
 sound/soc/codecs/spdif_receiver.c                  |    5 +-
 sound/soc/codecs/spdif_transmitter.c               |    5 +-
 sound/soc/codecs/tas5720.c                         |   61 +-
 sound/soc/codecs/tas5720.h                         |   31 +
 sound/soc/codecs/tas6424.c                         |  707 ++++++++++
 sound/soc/codecs/tas6424.h                         |  144 ++
 sound/soc/codecs/tfa9879.c                         |    1 +
 sound/soc/codecs/tlv320aic31xx.c                   |  310 ++---
 sound/soc/codecs/tlv320aic31xx.h                   |  335 ++---
 sound/soc/codecs/tlv320aic32x4.c                   |  182 +--
 sound/soc/codecs/tlv320aic32x4.h                   |  308 +++--
 sound/soc/codecs/tlv320aic3x.c                     |   15 +-
 sound/soc/codecs/tlv320dac33.c                     |   45 +-
 sound/soc/codecs/ts3a227e.c                        |    2 +-
 sound/soc/codecs/tscs42xx.c                        |   50 +-
 sound/soc/codecs/twl4030.c                         |   15 +-
 sound/soc/codecs/twl6040.c                         |   20 +-
 sound/soc/codecs/uda1380.c                         |   44 +-
 sound/soc/codecs/wm0010.c                          |    5 +-
 sound/soc/codecs/wm2000.c                          |    6 +-
 sound/soc/codecs/wm2200.c                          |    9 +-
 sound/soc/codecs/wm5102.c                          |   11 +-
 sound/soc/codecs/wm5110.c                          |   12 +-
 sound/soc/codecs/wm8350.c                          |   10 +-
 sound/soc/codecs/wm8400.c                          |    9 +-
 sound/soc/codecs/wm8903.c                          |   12 +-
 sound/soc/codecs/wm8994.c                          |   10 +-
 sound/soc/codecs/wm8997.c                          |   11 +-
 sound/soc/codecs/wm8998.c                          |   12 +-
 sound/soc/codecs/wm_adsp.c                         |   12 +-
 sound/soc/davinci/davinci-mcasp.c                  |   19 +
 sound/soc/fsl/eukrea-tlv320.c                      |    1 -
 sound/soc/fsl/fsl-asoc-card.c                      |    4 +-
 sound/soc/fsl/fsl_asrc.h                           |    6 +-
 sound/soc/fsl/fsl_dma.c                            |    4 +-
 sound/soc/fsl/fsl_ssi.c                            | 1393 ++++++++++------=
----
 sound/soc/fsl/fsl_ssi.h                            |  427 +++---
 sound/soc/fsl/fsl_ssi_dbg.c                        |   59 +-
 sound/soc/hisilicon/hi6210-i2s.c                   |    1 -
 sound/soc/intel/Kconfig                            |  116 +-
 sound/soc/intel/Makefile                           |    2 +-
 sound/soc/intel/atom/sst/sst_acpi.c                |    3 +
 sound/soc/intel/atom/sst/sst_stream.c              |    8 +-
 sound/soc/intel/boards/Kconfig                     |  194 ++-
 sound/soc/intel/boards/bytcr_rt5651.c              |   46 +-
 sound/soc/intel/boards/cht_bsw_rt5645.c            |    7 +
 sound/soc/intel/boards/haswell.c                   |    2 +-
 sound/soc/intel/boards/kbl_rt5663_max98927.c       |    4 +-
 .../soc/intel/boards/kbl_rt5663_rt5514_max98927.c  |    4 +-
 sound/soc/intel/boards/mfld_machine.c              |  428 ------
 sound/soc/intel/common/sst-dsp.c                   |    4 +-
 sound/soc/intel/skylake/bxt-sst.c                  |    2 +-
 sound/soc/intel/skylake/cnl-sst.c                  |    2 +-
 sound/soc/intel/skylake/skl-i2s.h                  |   64 +
 sound/soc/intel/skylake/skl-messages.c             |   22 +
 sound/soc/intel/skylake/skl-nhlt.c                 |  173 ++-
 sound/soc/intel/skylake/skl-pcm.c                  |   14 +-
 sound/soc/intel/skylake/skl-ssp-clk.h              |   79 ++
 sound/soc/intel/skylake/skl-sst-dsp.c              |   14 +-
 sound/soc/intel/skylake/skl-sst-dsp.h              |    4 +
 sound/soc/intel/skylake/skl-sst-utils.c            |    6 +-
 sound/soc/intel/skylake/skl-sst.c                  |    2 +-
 sound/soc/intel/skylake/skl-topology.c             |   46 +-
 sound/soc/intel/skylake/skl.c                      |  150 ++-
 sound/soc/intel/skylake/skl.h                      |   22 +
 sound/soc/mediatek/mt2701/mt2701-afe-clock-ctrl.c  |  552 +++-----
 sound/soc/mediatek/mt2701/mt2701-afe-clock-ctrl.h  |   15 +-
 sound/soc/mediatek/mt2701/mt2701-afe-common.h      |   87 +-
 sound/soc/mediatek/mt2701/mt2701-afe-pcm.c         |  213 +--
 sound/soc/mediatek/mt2701/mt2701-reg.h             |   42 +-
 sound/soc/mediatek/mt8173/mt8173-afe-pcm.c         |    6 +-
 sound/soc/mediatek/mt8173/mt8173-rt5650-rt5514.c   |    2 -
 sound/soc/mediatek/mt8173/mt8173-rt5650-rt5676.c   |    2 -
 sound/soc/mediatek/mt8173/mt8173-rt5650.c          |    2 -
 sound/soc/nuc900/nuc900-ac97.c                     |   11 +-
 sound/soc/omap/ams-delta.c                         |    4 +-
 sound/soc/qcom/apq8016_sbc.c                       |   10 +-
 sound/soc/rockchip/rk3399_gru_sound.c              |    3 +-
 sound/soc/rockchip/rockchip_i2s.c                  |   11 +-
 sound/soc/rockchip/rockchip_spdif.c                |   18 +-
 sound/soc/samsung/bells.c                          |   40 +-
 sound/soc/sh/rcar/adg.c                            |    6 +-
 sound/soc/sh/rcar/core.c                           |  147 ++-
 sound/soc/sh/rcar/dma.c                            |  104 +-
 sound/soc/sh/rcar/rsnd.h                           |   15 +-
 sound/soc/sh/rcar/ssi.c                            |  161 ++-
 sound/soc/sh/rcar/ssiu.c                           |    5 +-
 sound/soc/soc-acpi.c                               |   40 +-
 sound/soc/soc-compress.c                           |    4 +-
 sound/soc/soc-core.c                               |   31 +-
 sound/soc/soc-ops.c                                |    4 +-
 sound/soc/soc-utils.c                              |    2 +-
 sound/soc/stm/Kconfig                              |   12 +
 sound/soc/stm/Makefile                             |    3 +
 sound/soc/stm/stm32_adfsdm.c                       |  347 +++++
 sound/soc/stm/stm32_sai.c                          |  114 +-
 sound/soc/sunxi/sun4i-codec.c                      |   29 +-
 sound/soc/sunxi/sun4i-i2s.c                        |   57 +-
 sound/soc/uniphier/Kconfig                         |   19 +
 sound/soc/uniphier/Makefile                        |    3 +
 sound/soc/uniphier/evea.c                          |  567 ++++++++
 sound/soc/ux500/mop500.c                           |    4 +
 sound/soc/ux500/ux500_pcm.c                        |    5 +
 sound/usb/mixer.c                                  |   30 +-
 sound/usb/quirks.c                                 |    7 +-
 tools/arch/arm/include/uapi/asm/kvm.h              |    7 +
 tools/arch/arm64/include/uapi/asm/bpf_perf_event.h |    9 +
 tools/arch/arm64/include/uapi/asm/kvm.h            |    7 +
 tools/arch/s390/include/uapi/asm/bpf_perf_event.h  |    9 +
 tools/arch/s390/include/uapi/asm/kvm.h             |    4 -
 tools/arch/s390/include/uapi/asm/kvm_perf.h        |    4 -
 tools/arch/s390/include/uapi/asm/perf_regs.h       |   44 +
 tools/arch/s390/include/uapi/asm/ptrace.h          |  457 +++++++
 tools/arch/x86/include/asm/cpufeatures.h           |  538 ++++----
 tools/arch/x86/include/asm/disabled-features.h     |    8 +-
 tools/bpf/bpftool/Documentation/Makefile           |    2 +-
 tools/bpf/bpftool/Makefile                         |    7 +-
 tools/bpf/bpftool/main.c                           |   36 +-
 tools/bpf/bpftool/main.h                           |    5 +-
 tools/bpf/bpftool/map.c                            |    8 +-
 tools/bpf/bpftool/prog.c                           |    2 +
 tools/hv/hv_kvp_daemon.c                           |   70 +-
 tools/include/linux/compiler.h                     |   21 +-
 tools/include/linux/kmemcheck.h                    |    1 -
 tools/include/linux/lockdep.h                      |    1 +
 tools/include/uapi/asm-generic/bpf_perf_event.h    |    9 +
 tools/include/uapi/asm-generic/mman.h              |    1 +
 tools/include/uapi/asm/bpf_perf_event.h            |    7 +
 tools/include/uapi/drm/drm.h                       |   41 +
 tools/include/uapi/drm/i915_drm.h                  |   33 +-
 tools/include/uapi/linux/bpf_perf_event.h          |    6 +-
 tools/include/uapi/linux/kcmp.h                    |    1 +
 tools/include/uapi/linux/kvm.h                     |    5 +-
 tools/include/uapi/linux/perf_event.h              |    1 +
 tools/include/uapi/linux/prctl.h                   |   10 +
 tools/kvm/kvm_stat/kvm_stat                        |   74 +-
 tools/kvm/kvm_stat/kvm_stat.txt                    |    4 +-
 tools/objtool/Makefile                             |    8 +-
 tools/objtool/arch/x86/decode.c                    |    2 +-
 tools/objtool/arch/x86/lib/x86-opcode-map.txt      |   15 +-
 tools/objtool/builtin-orc.c                        |    4 +-
 tools/objtool/orc_dump.c                           |    7 +-
 tools/objtool/orc_gen.c                            |    2 +
 tools/perf/Makefile.config                         |    9 +-
 tools/perf/arch/s390/Makefile                      |    1 +
 tools/perf/arch/s390/include/perf_regs.h           |    2 +-
 tools/perf/arch/s390/util/dwarf-regs.c             |   32 +-
 tools/perf/bench/numa.c                            |   56 +-
 tools/perf/builtin-help.c                          |    4 +-
 tools/perf/builtin-record.c                        |   42 +-
 tools/perf/builtin-report.c                        |    3 +
 tools/perf/builtin-script.c                        |   31 +-
 tools/perf/builtin-top.c                           |   36 +-
 tools/perf/builtin-trace.c                         |    6 +-
 tools/perf/check-headers.sh                        |    2 +
 tools/perf/jvmti/jvmti_agent.c                     |   16 +-
 tools/perf/jvmti/jvmti_agent.h                     |    7 +-
 tools/perf/jvmti/libjvmti.c                        |  147 ++-
 .../perf/tests/shell/trace+probe_libc_inet_pton.sh |    7 +-
 tools/perf/tests/shell/trace+probe_vfs_getname.sh  |    6 +-
 tools/perf/tests/task-exit.c                       |    4 +
 tools/perf/trace/beauty/mmap.c                     |    3 +
 tools/perf/util/annotate.c                         |   18 +-
 tools/perf/util/evlist.c                           |   14 +-
 tools/perf/util/evlist.h                           |    2 +
 tools/perf/util/evsel.c                            |   14 +-
 tools/perf/util/evsel.h                            |    1 +
 tools/perf/util/intel-pt-decoder/inat.h            |   10 +
 .../perf/util/intel-pt-decoder/x86-opcode-map.txt  |   15 +-
 tools/perf/util/machine.c                          |    3 +
 tools/perf/util/mmap.h                             |    2 +-
 tools/perf/util/parse-events.c                     |    2 +
 tools/perf/util/parse-events.h                     |    3 +
 tools/perf/util/pmu.c                              |    5 +
 tools/power/cpupower/bench/system.c                |    2 +-
 .../cpupower/utils/idle_monitor/cpuidle_sysfs.c    |    9 +-
 tools/testing/selftests/bpf/Makefile               |    5 +-
 tools/testing/selftests/bpf/test_progs.c           |    8 +-
 tools/testing/selftests/bpf/test_verifier.c        |  629 ++++++++-
 tools/testing/selftests/bpf/test_verifier_log.c    |    7 +
 tools/testing/selftests/net/config                 |    1 +
 tools/testing/selftests/x86/ldt_gdt.c              |   12 +-
 tools/usb/usbip/libsrc/vhci_driver.c               |   24 +-
 tools/usb/usbip/src/utils.c                        |    9 +-
 tools/virtio/ringtest/ptr_ring.c                   |   29 +-
 tools/vm/slabinfo-gnuplot.sh                       |    2 +-
 virt/kvm/arm/arch_timer.c                          |   43 +-
 virt/kvm/arm/arm.c                                 |   17 +-
 virt/kvm/arm/hyp/timer-sr.c                        |   48 +-
 virt/kvm/arm/hyp/vgic-v2-sr.c                      |    4 -
 virt/kvm/arm/mmio.c                                |    6 +-
 virt/kvm/arm/mmu.c                                 |   10 +-
 virt/kvm/arm/vgic/vgic-irqfd.c                     |    3 +-
 virt/kvm/arm/vgic/vgic-its.c                       |    4 +-
 virt/kvm/arm/vgic/vgic-v3.c                        |    2 +-
 virt/kvm/arm/vgic/vgic-v4.c                        |    6 +-
 virt/kvm/arm/vgic/vgic.c                           |    8 +-
 virt/kvm/kvm_main.c                                |   31 +
 2467 files changed, 35148 insertions(+), 19492 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-dfsdm-adc-stm32
 create mode 100644 Documentation/devicetree/bindings/iio/adc/sigma-delta-m=
odulator.txt
 create mode 100644 Documentation/devicetree/bindings/iio/adc/st,stm32-dfsd=
m-adc.txt
 create mode 100644 Documentation/devicetree/bindings/sound/max98373.txt
 create mode 100644 Documentation/devicetree/bindings/sound/pcm186x.txt
 create mode 100644 Documentation/devicetree/bindings/sound/st,stm32-adfsdm=
=2Etxt
 create mode 100644 Documentation/devicetree/bindings/sound/ti,tas6424.txt
 create mode 100644 Documentation/devicetree/bindings/sound/uniphier,evea.t=
xt
 create mode 100644 Documentation/driver-api/iio/hw-consumer.rst
 delete mode 100644 Documentation/locking/crossrelease.txt
 create mode 100644 Documentation/media/dvb-drivers/frontends.rst
 create mode 100644 arch/arm64/include/uapi/asm/bpf_perf_event.h
 delete mode 100644 arch/arm64/kernel/ftrace-mod.S
 create mode 100644 arch/mips/include/asm/serial.h
 create mode 100644 arch/riscv/include/asm/vdso-syscalls.h
 create mode 100644 arch/riscv/kernel/vdso/clock_getres.S
 create mode 100644 arch/riscv/kernel/vdso/clock_gettime.S
 create mode 100644 arch/riscv/kernel/vdso/flush_icache.S
 create mode 100644 arch/riscv/kernel/vdso/getcpu.S
 create mode 100644 arch/riscv/kernel/vdso/gettimeofday.S
 create mode 100644 arch/riscv/mm/cacheflush.c
 create mode 100644 arch/s390/include/uapi/asm/bpf_perf_event.h
 create mode 100644 arch/x86/boot/compressed/pgtable_64.c
 create mode 100644 arch/x86/include/asm/cpu_entry_area.h
 create mode 100644 arch/x86/include/asm/intel_ds.h
 create mode 100644 arch/x86/include/asm/invpcid.h
 delete mode 100644 arch/x86/include/asm/kmemcheck.h
 create mode 100644 arch/x86/include/asm/pti.h
 create mode 100644 arch/x86/mm/cpu_entry_area.c
 delete mode 100644 arch/x86/mm/kmemcheck/error.c
 delete mode 100644 arch/x86/mm/kmemcheck/error.h
 delete mode 100644 arch/x86/mm/kmemcheck/opcode.c
 delete mode 100644 arch/x86/mm/kmemcheck/opcode.h
 delete mode 100644 arch/x86/mm/kmemcheck/pte.c
 delete mode 100644 arch/x86/mm/kmemcheck/pte.h
 delete mode 100644 arch/x86/mm/kmemcheck/selftest.c
 delete mode 100644 arch/x86/mm/kmemcheck/selftest.h
 delete mode 100644 arch/x86/mm/kmemcheck/shadow.h
 create mode 100644 arch/x86/mm/pti.c
 create mode 100644 drivers/iio/adc/sd_adc_modulator.c
 create mode 100644 drivers/iio/adc/stm32-dfsdm-adc.c
 create mode 100644 drivers/iio/adc/stm32-dfsdm-core.c
 create mode 100644 drivers/iio/adc/stm32-dfsdm.h
 create mode 100644 drivers/iio/buffer/industrialio-hw-consumer.c
 create mode 100644 include/linux/iio/adc/stm32-dfsdm-adc.h
 create mode 100644 include/linux/iio/hw-consumer.h
 create mode 100644 include/linux/intel-pti.h
 delete mode 100644 include/linux/kmemcheck.h
 rename include/{lib =3D> linux}/libgcc.h (100%)
 create mode 100644 include/uapi/asm-generic/bpf_perf_event.h
 delete mode 100644 mm/kmemcheck.c
 create mode 100644 net/wireless/certs/sforshee.hex
 delete mode 100644 net/wireless/certs/sforshee.x509
 create mode 100644 sound/soc/codecs/max98373.c
 create mode 100644 sound/soc/codecs/max98373.h
 create mode 100644 sound/soc/codecs/pcm186x-i2c.c
 create mode 100644 sound/soc/codecs/pcm186x-spi.c
 create mode 100644 sound/soc/codecs/pcm186x.c
 create mode 100644 sound/soc/codecs/pcm186x.h
 delete mode 100644 sound/soc/codecs/sn95031.c
 delete mode 100644 sound/soc/codecs/sn95031.h
 create mode 100644 sound/soc/codecs/tas6424.c
 create mode 100644 sound/soc/codecs/tas6424.h
 delete mode 100644 sound/soc/intel/boards/mfld_machine.c
 create mode 100644 sound/soc/intel/skylake/skl-i2s.h
 create mode 100644 sound/soc/intel/skylake/skl-ssp-clk.h
 create mode 100644 sound/soc/stm/stm32_adfsdm.c
 create mode 100644 sound/soc/uniphier/Kconfig
 create mode 100644 sound/soc/uniphier/Makefile
 create mode 100644 sound/soc/uniphier/evea.c
 create mode 100644 tools/arch/arm64/include/uapi/asm/bpf_perf_event.h
 create mode 100644 tools/arch/s390/include/uapi/asm/bpf_perf_event.h
 create mode 100644 tools/arch/s390/include/uapi/asm/perf_regs.h
 create mode 100644 tools/arch/s390/include/uapi/asm/ptrace.h
 delete mode 100644 tools/include/linux/kmemcheck.h
 create mode 100644 tools/include/uapi/asm-generic/bpf_perf_event.h
 create mode 100644 tools/include/uapi/asm/bpf_perf_event.h

--mojUlQ0s9EVzWg2t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlpYsM4ACgkQJNaLcl1U
h9CE/Qf/fTxkgiLRH356pgHBGHM1Tz9t9GPfXHHE7FerknwVi7y8ItXRmUhiFo5K
fDCuoyePdSDfO19Ts6vWzYHtcEYFmnndVJWWrELNZ0aglq1bkbKsn1q+zSE3W1tH
rDzGyzcge8UNTzros/65n8NeKkNPtfAkievQBmb+iqeDySuWGknYjVxIE8hHr5th
Qo+tWfpy+/wkoulEVrQ/aXwm0KgbrGgdxv5br4MvYQuS8FPpv94LQ/KnA4i+1usa
kDFbhNAbzHPsv7Qx1xr9lCMObaNjDqp1XoIRagsVZXw2NB/oDCzVREZYpJ3nXYGm
qSn51lSN8UhzaOrO6zIeXEP6HeQa9g==
=GHFu
-----END PGP SIGNATURE-----

--mojUlQ0s9EVzWg2t--

--===============0862917775367633725==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0862917775367633725==--
