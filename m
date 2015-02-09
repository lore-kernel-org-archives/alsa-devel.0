From: Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] ASoC updates for v3.20
Date: Mon, 9 Feb 2015 15:17:48 +0800
Message-ID: <20150209071748.GF23228@finisterre.sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8345031961775606669=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 6CBA1260506
 for <alsa-devel@alsa-project.org>; Mon,  9 Feb 2015 08:18:22 +0100 (CET)
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


--===============8345031961775606669==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="iBwuxWUsK/REspAd"
Content-Disposition: inline


--iBwuxWUsK/REspAd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 5c2b06369dafd796ebb4f17dab543d3da500245e:

  ASoC: Intel: fix sst firmware path for cht-bsw-rt5672 (2015-02-05 20:16:21 +0000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-v3.20-3

for you to fetch changes up to f4c2e9bcb0be4ee1c8722853e4faaaf6a9423d72:

  Merge remote-tracking branches 'asoc/topic/wm8804', 'asoc/topic/wm8904', 'asoc/topic/wm8960', 'asoc/topic/wm8988' and 'asoc/topic/xtfpga' into asoc-next (2015-02-09 15:10:34 +0800)

----------------------------------------------------------------
ASoC: Final updates for v3.20

A few more updates for v3.20 that have accumilated over the second half
of last week.  One new (relatively simple) driver for the Maxim
max98357a and some other driver specific fixes and enhancements.  I did
apply a few patches that haven't been in -next just now before sending
this, all fixes except for one simple device ID addition patch.

----------------------------------------------------------------
Bard Liao (4):
      ASoC: rt286: Fix potencial crash in jd function
      ASoC: rt286: Add customize setting for Dell Dino
      ASoC: rt286: Add rt288 codec support
      ASoC: rt5670: Set use_single_rw flag for regmap

Christian Engelmayer (1):
      ASoC: Intel: sst: Fix firmware name size handling

Fang, Yang A (2):
      ASoC: rt5645: add API to select ASRC clock source
      ASoC: Intel: Add Cherrytrail & Braswell machine driver cht_bsw_rt5645

Jie Yang (1):
      ASoC: Intel: add a status for runtime suspend/resume

Kenneth Westfield (2):
      ASoC: max98357a: Document MAX98357A bindings
      ASoC: max98357a: Add MAX98357A codec driver

Kevin Strasser (1):
      ASoC: Intel: fix sst firmware path

Kuninori Morimoto (1):
      ASoC: core: indicate unregister debug message once

Mark Brown (21):
      Merge branch 'topic/rt5645' of git://git.kernel.org/.../broonie/sound into asoc-intel
      Merge branch 'fix/intel' of git://git.kernel.org/.../broonie/sound into asoc-intel
      ASoC: max98357a: Fix build in !CONFIG_OF case
      Merge tag 'asoc-v3.19-rc2' into asoc-linus
      Merge remote-tracking branches 'asoc/fix/ac97', 'asoc/fix/atmel', 'asoc/fix/intel', 'asoc/fix/rt286', 'asoc/fix/rt5640', 'asoc/fix/samsung', 'asoc/fix/sgtl5000', 'asoc/fix/sta32x', 'asoc/fix/tlv320aic3x' and 'asoc/fix/wm8731' into asoc-linus
      Merge remote-tracking branch 'asoc/topic/core' into asoc-next
      Merge remote-tracking branch 'asoc/topic/dapm' into asoc-next
      Merge remote-tracking branch 'asoc/topic/dmaengine' into asoc-next
      Merge remote-tracking branch 'asoc/topic/pcm512x' into asoc-next
      Merge remote-tracking branch 'asoc/topic/w-codec' into asoc-next
      Merge remote-tracking branches 'asoc/topic/ad193x', 'asoc/topic/alc5632', 'asoc/topic/atmel' and 'asoc/topic/au1x' into asoc-next
      Merge remote-tracking branches 'asoc/topic/bt-sco', 'asoc/topic/cs35l32', 'asoc/topic/cs42l52' and 'asoc/topic/cs42l56' into asoc-next
      Merge remote-tracking branches 'asoc/topic/cs42l73', 'asoc/topic/dai' and 'asoc/topic/davinci' into asoc-next
      Merge remote-tracking branches 'asoc/topic/doc', 'asoc/topic/dwc', 'asoc/topic/fsi', 'asoc/topic/fsl' and 'asoc/topic/fsl-asrc' into asoc-next
      Merge remote-tracking branches 'asoc/topic/fsl-spdif', 'asoc/topic/imx', 'asoc/topic/intel', 'asoc/topic/jz4740' and 'asoc/topic/max98357a' into asoc-next
      Merge remote-tracking branches 'asoc/topic/mxs-saif' and 'asoc/topic/nuc900' into asoc-next
      Merge remote-tracking branches 'asoc/topic/pxa', 'asoc/topic/rcar' and 'asoc/topic/rt286' into asoc-next
      Merge remote-tracking branches 'asoc/topic/rt5670', 'asoc/topic/rt5677', 'asoc/topic/rx51', 'asoc/topic/samsung' and 'asoc/topic/sh' into asoc-next
      Merge remote-tracking branches 'asoc/topic/simple', 'asoc/topic/sta32x', 'asoc/topic/tdm-slot', 'asoc/topic/tegra' and 'asoc/topic/tlv320aic3x' into asoc-next
      Merge remote-tracking branches 'asoc/topic/ts3a227e', 'asoc/topic/ts3a277e' and 'asoc/topic/txx9' into asoc-next
      Merge remote-tracking branches 'asoc/topic/wm8804', 'asoc/topic/wm8904', 'asoc/topic/wm8960', 'asoc/topic/wm8988' and 'asoc/topic/xtfpga' into asoc-next

Paul Bolle (1):
      ASoC: samsung: Remove goni or aquila with the WM8994

Rickard Strandqvist (1):
      ASoC: intel: sst-haswell-ipc: Remove unused functions

Sylwester Nawrocki (2):
      ARM: dts: Exynos4 and Odroid X2/U3 sound device nodes update
      ARM: dts: Switch Odroid X2/U2 to simple-audio-card

Zubair Lutfullah Kakakhel (3):
      ASoC: jz4740: Add dynamic sampling rate support to jz4740-i2s
      ASoC: jz4740: Add binding documentation for jz4740-i2s
      ASoC: jz4740: Add DT support to jz4740-i2s driver

kbuild test robot (1):
      ASoC: Intel: fix platform_no_drv_owner.cocci warnings

 .mailmap                                           |    1 +
 Documentation/ABI/testing/sysfs-class-mei          |   15 +
 .../ABI/testing/sysfs-platform-dell-laptop         |   60 --
 Documentation/devicetree/bindings/arm/arm-boards   |    2 +-
 Documentation/devicetree/bindings/arm/fw-cfg.txt   |   72 ++
 Documentation/devicetree/bindings/graph.txt        |    2 +-
 Documentation/devicetree/bindings/i2c/i2c-st.txt   |    2 +-
 .../devicetree/bindings/i2c/trivial-devices.txt    |    1 +
 .../devicetree/bindings/input/gpio-keys.txt        |   10 +-
 .../devicetree/bindings/input/stmpe-keypad.txt     |    2 +
 .../devicetree/bindings/net/davinci_emac.txt       |    3 +-
 .../devicetree/bindings/sound/cdns,xtfpga-i2s.txt  |   18 +
 .../devicetree/bindings/sound/designware-i2s.txt   |   31 +
 .../bindings/sound/ingenic,jz4740-i2s.txt          |   23 +
 .../devicetree/bindings/sound/max98357a.txt        |   14 +
 .../bindings/sound/nvidia,tegra-audio-rt5677.txt   |   67 ++
 .../devicetree/bindings/sound/pcm512x.txt          |   28 +-
 .../devicetree/bindings/sound/samsung-i2s.txt      |   22 +
 .../devicetree/bindings/sound/simple-card.txt      |    5 +
 .../devicetree/bindings/sound/st,sta32x.txt        |   92 ++
 .../devicetree/bindings/sound/tlv320aic3x.txt      |   10 +-
 .../devicetree/bindings/sound/ts3a227e.txt         |    5 +
 Documentation/devicetree/bindings/sound/wm8904.txt |    2 +-
 .../devicetree/bindings/vendor-prefixes.txt        |    4 +-
 Documentation/kernel-parameters.txt                |    1 +
 Documentation/networking/ip-sysctl.txt             |    2 +
 Documentation/target/tcm_mod_builder.py            |   49 +-
 Documentation/thermal/cpu-cooling-api.txt          |   15 +-
 MAINTAINERS                                        |  142 ++-
 Makefile                                           |    3 +-
 arch/alpha/kernel/pci.c                            |    8 +-
 arch/alpha/mm/fault.c                              |    2 +
 arch/arc/mm/fault.c                                |    2 +
 arch/arm/boot/dts/armada-370-db.dts                |   24 -
 arch/arm/boot/dts/at91sam9263.dtsi                 |    2 +
 arch/arm/boot/dts/berlin2q-marvell-dmp.dts         |    2 +
 arch/arm/boot/dts/berlin2q.dtsi                    |   63 +-
 arch/arm/boot/dts/dra7-evm.dts                     |   10 +-
 arch/arm/boot/dts/dra7.dtsi                        |    6 +
 arch/arm/boot/dts/exynos4.dtsi                     |   13 +-
 arch/arm/boot/dts/exynos4412-odroid-common.dtsi    |   27 +-
 arch/arm/boot/dts/exynos4412-odroidu3.dts          |    8 +-
 arch/arm/boot/dts/exynos4412-odroidx2.dts          |    8 +-
 arch/arm/boot/dts/exynos5250.dtsi                  |    2 +-
 arch/arm/boot/dts/exynos5420-arndale-octa.dts      |    4 +
 arch/arm/boot/dts/exynos5420.dtsi                  |    6 +-
 arch/arm/boot/dts/imx25.dtsi                       |   10 +-
 arch/arm/boot/dts/imx51-babbage.dts                |   22 +-
 arch/arm/boot/dts/imx6qdl.dtsi                     |    4 +-
 arch/arm/boot/dts/imx6sx-sdb.dts                   |   15 +
 arch/arm/boot/dts/ls1021a.dtsi                     |    1 +
 arch/arm/boot/dts/omap3-n900.dts                   |    4 +-
 arch/arm/boot/dts/rk3288-evb.dtsi                  |   30 +
 arch/arm/boot/dts/sama5d3xmb.dtsi                  |    2 +-
 arch/arm/boot/dts/sama5d4.dtsi                     |    2 +-
 arch/arm/boot/dts/ste-nomadik-nhk15.dts            |    8 +-
 arch/arm/boot/dts/sun4i-a10.dtsi                   |   20 +-
 arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts   |    6 +
 arch/arm/boot/dts/sun5i-a10s.dtsi                  |    8 +-
 arch/arm/boot/dts/sun5i-a13-hsg-h702.dts           |    4 +
 arch/arm/boot/dts/sun5i-a13-olinuxino-micro.dts    |    4 +
 arch/arm/boot/dts/sun5i-a13-olinuxino.dts          |    4 +
 arch/arm/boot/dts/sun5i-a13.dtsi                   |    9 +-
 arch/arm/boot/dts/sun6i-a31.dtsi                   |    6 -
 arch/arm/boot/dts/sun7i-a20-bananapi.dts           |    6 +
 arch/arm/boot/dts/sun7i-a20-hummingbird.dts        |    8 +
 arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts    |    3 +
 arch/arm/boot/dts/sun7i-a20.dtsi                   |    8 -
 arch/arm/boot/dts/sun8i-a23-ippo-q8h-v5.dts        |    4 +
 arch/arm/boot/dts/sun8i-a23.dtsi                   |    9 -
 arch/arm/boot/dts/sun9i-a80-optimus.dts            |    5 +
 arch/arm/boot/dts/sun9i-a80.dtsi                   |   10 -
 arch/arm/boot/dts/tegra20-seaboard.dts             |    2 +-
 arch/arm/boot/dts/vf610-twr.dts                    |   15 +
 arch/arm/configs/exynos_defconfig                  |   18 +-
 arch/arm/configs/multi_v7_defconfig                |    1 +
 arch/arm/configs/omap2plus_defconfig               |    2 +-
 arch/arm/include/asm/kvm_emulate.h                 |   10 +
 arch/arm/include/asm/kvm_host.h                    |    3 -
 arch/arm/include/asm/kvm_mmu.h                     |   77 +-
 arch/arm/include/uapi/asm/unistd.h                 |    1 +
 arch/arm/kernel/calls.S                            |    1 +
 arch/arm/kernel/entry-header.S                     |   13 +-
 arch/arm/kernel/perf_event.c                       |   10 +-
 arch/arm/kernel/perf_regs.c                        |    8 +
 arch/arm/kernel/setup.c                            |   16 +-
 arch/arm/kernel/smp.c                              |   12 +
 arch/arm/kvm/arm.c                                 |   10 -
 arch/arm/kvm/coproc.c                              |   70 +-
 arch/arm/kvm/coproc.h                              |    6 +-
 arch/arm/kvm/coproc_a15.c                          |    2 +-
 arch/arm/kvm/coproc_a7.c                           |    2 +-
 arch/arm/kvm/mmu.c                                 |  164 ++-
 arch/arm/kvm/trace.h                               |   39 +
 arch/arm/mach-at91/board-dt-sama5.c                |   18 +
 arch/arm/mach-imx/clk-imx6q.c                      |    2 +-
 arch/arm/mach-imx/clk-imx6sx.c                     |    3 +
 arch/arm/mach-mvebu/coherency.c                    |   14 +-
 arch/arm/mach-omap2/board-generic.c                |   18 +
 arch/arm/mach-omap2/common.h                       |    2 +
 arch/arm/mach-omap2/control.h                      |    4 +
 arch/arm/mach-omap2/omap-headsmp.S                 |   21 +
 arch/arm/mach-omap2/omap-smp.c                     |   13 +-
 arch/arm/mach-omap2/omap4-common.c                 |   32 +
 arch/arm/mach-omap2/omap_hwmod.c                   |   10 +-
 arch/arm/mach-omap2/omap_hwmod.h                   |    1 +
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c         |    5 +
 arch/arm/mach-omap2/omap_hwmod_54xx_data.c         |    1 +
 arch/arm/mach-omap2/prcm-common.h                  |    1 +
 arch/arm/mach-omap2/prm44xx.c                      |    5 +-
 arch/arm/mach-omap2/prm_common.c                   |   14 +-
 arch/arm/mach-omap2/timer.c                        |   44 +-
 arch/arm/mach-omap2/twl-common.c                   |    7 +-
 arch/arm/mach-rockchip/rockchip.c                  |   27 +
 arch/arm/mach-shmobile/board-ape6evm.c             |   20 +
 arch/arm/mach-shmobile/board-lager.c               |   13 +
 arch/arm/mach-shmobile/setup-r8a7740.c             |    7 +
 arch/arm/mach-shmobile/setup-r8a7778.c             |    9 +-
 arch/arm/mach-shmobile/setup-r8a7779.c             |    9 +-
 arch/arm/mach-shmobile/setup-rcar-gen2.c           |    2 +
 arch/arm/mach-shmobile/setup-sh73a0.c              |    3 +
 arch/arm/mach-shmobile/timer.c                     |   12 +
 arch/arm/mm/dma-mapping.c                          |   53 +-
 arch/arm/mm/dump.c                                 |    9 +-
 arch/arm/mm/init.c                                 |    4 +-
 arch/arm/mm/mmu.c                                  |    4 +-
 arch/arm64/Makefile                                |    1 +
 arch/arm64/boot/dts/Makefile                       |    2 -
 arch/arm64/boot/dts/arm/juno.dts                   |    2 +-
 arch/arm64/configs/defconfig                       |    9 +-
 arch/arm64/include/asm/arch_timer.h                |    1 +
 arch/arm64/include/asm/cpu.h                       |    5 +
 arch/arm64/include/asm/dma-mapping.h               |   11 +-
 arch/arm64/include/asm/kvm_emulate.h               |   12 +
 arch/arm64/include/asm/kvm_host.h                  |    3 -
 arch/arm64/include/asm/kvm_mmu.h                   |   34 +-
 arch/arm64/include/asm/pgtable.h                   |    5 +-
 arch/arm64/include/asm/processor.h                 |    4 +-
 arch/arm64/include/asm/unistd.h                    |    2 +-
 arch/arm64/include/asm/unistd32.h                  |    2 +
 arch/arm64/kernel/cpuinfo.c                        |   10 +
 arch/arm64/kernel/efi.c                            |    2 +-
 arch/arm64/kernel/module.c                         |    1 +
 arch/arm64/kernel/perf_regs.c                      |    8 +
 arch/arm64/kernel/setup.c                          |    1 +
 arch/arm64/kernel/smp_spin_table.c                 |    1 +
 arch/arm64/kernel/suspend.c                        |   14 +-
 arch/arm64/kvm/hyp.S                               |    1 +
 arch/arm64/kvm/reset.c                             |    1 -
 arch/arm64/kvm/sys_regs.c                          |   75 +-
 arch/arm64/mm/dump.c                               |    1 +
 arch/arm64/mm/init.c                               |    8 +-
 arch/avr32/kernel/module.c                         |   13 +-
 arch/avr32/mm/fault.c                              |    2 +
 arch/blackfin/mach-bf533/boards/stamp.c            |    1 +
 arch/cris/arch-v32/drivers/sync_serial.c           |    2 +-
 arch/cris/kernel/module.c                          |    2 +-
 arch/cris/mm/fault.c                               |    2 +
 arch/frv/mb93090-mb00/pci-frv.c                    |    2 +-
 arch/frv/mm/fault.c                                |    2 +
 arch/ia64/include/asm/unistd.h                     |    2 +-
 arch/ia64/include/uapi/asm/unistd.h                |    1 +
 arch/ia64/kernel/acpi.c                            |    9 +-
 arch/ia64/kernel/entry.S                           |    1 +
 arch/ia64/kernel/module.c                          |    6 +-
 arch/ia64/mm/fault.c                               |    2 +
 arch/ia64/pci/pci.c                                |   48 +-
 arch/m32r/mm/fault.c                               |    2 +
 arch/m68k/include/asm/unistd.h                     |    2 +-
 arch/m68k/include/uapi/asm/unistd.h                |    1 +
 arch/m68k/kernel/syscalltable.S                    |    1 +
 arch/m68k/mm/fault.c                               |    2 +
 arch/metag/mm/fault.c                              |    2 +
 arch/microblaze/mm/fault.c                         |    2 +
 arch/microblaze/pci/pci-common.c                   |   13 +-
 arch/mips/mm/fault.c                               |    2 +
 arch/mips/net/bpf_jit.c                            |    2 +-
 arch/mn10300/mm/fault.c                            |    2 +
 arch/mn10300/unit-asb2305/pci-asb2305.c            |    2 +-
 arch/mn10300/unit-asb2305/pci.c                    |   47 +-
 arch/nios2/kernel/cpuinfo.c                        |    1 +
 arch/nios2/kernel/entry.S                          |   20 +-
 arch/nios2/kernel/module.c                         |    2 +-
 arch/nios2/kernel/signal.c                         |    2 +-
 arch/nios2/mm/fault.c                              |    2 +
 arch/openrisc/mm/fault.c                           |    2 +
 arch/parisc/include/asm/ldcw.h                     |   13 +-
 arch/parisc/kernel/module.c                        |    6 +-
 arch/parisc/mm/fault.c                             |    2 +
 arch/powerpc/crypto/sha1.c                         |    1 +
 arch/powerpc/include/asm/kexec.h                   |   10 +
 arch/powerpc/include/asm/systbl.h                  |    1 +
 arch/powerpc/include/asm/thread_info.h             |   13 +-
 arch/powerpc/include/asm/unistd.h                  |    2 +-
 arch/powerpc/include/uapi/asm/unistd.h             |    1 +
 arch/powerpc/kernel/machine_kexec_64.c             |    2 +-
 arch/powerpc/kernel/pci-common.c                   |   12 +-
 arch/powerpc/kernel/smp.c                          |    9 +-
 arch/powerpc/mm/copro_fault.c                      |    2 +-
 arch/powerpc/mm/fault.c                            |    2 +
 arch/powerpc/net/bpf_jit_comp.c                    |    2 +-
 arch/powerpc/platforms/powernv/opal-wrappers.S     |    1 -
 arch/powerpc/platforms/powernv/setup.c             |    2 +-
 arch/powerpc/platforms/pseries/lpar.c              |    8 +-
 arch/powerpc/xmon/xmon.c                           |    1 +
 arch/s390/hypfs/hypfs_vm.c                         |    2 +-
 arch/s390/include/asm/irqflags.h                   |    2 +-
 arch/s390/include/asm/timex.h                      |   10 +-
 arch/s390/include/uapi/asm/unistd.h                |    3 +-
 arch/s390/kernel/module.c                          |   10 +-
 arch/s390/kernel/syscalls.S                        |    1 +
 arch/s390/kernel/uprobes.c                         |   69 +-
 arch/s390/kernel/vtime.c                           |    2 -
 arch/s390/mm/fault.c                               |    6 +
 arch/s390/mm/pgtable.c                             |    5 +-
 arch/s390/net/bpf_jit.S                            |   28 +-
 arch/s390/net/bpf_jit_comp.c                       |   17 +-
 arch/score/mm/fault.c                              |    2 +
 arch/sh/mm/fault.c                                 |    2 +
 arch/sparc/kernel/pci.c                            |    5 +-
 arch/sparc/mm/fault_32.c                           |    2 +
 arch/sparc/mm/fault_64.c                           |    2 +
 arch/sparc/net/bpf_jit_comp.c                      |    4 +-
 arch/tile/kernel/module.c                          |    4 +-
 arch/tile/mm/fault.c                               |    2 +
 arch/um/Kconfig.common                             |    1 +
 arch/um/kernel/trap.c                              |    2 +
 arch/x86/Kconfig                                   |    6 +-
 arch/x86/boot/Makefile                             |    1 +
 arch/x86/boot/compressed/Makefile                  |    2 +-
 arch/x86/boot/compressed/misc.c                    |    9 +-
 arch/x86/crypto/Makefile                           |    2 +-
 arch/x86/crypto/aes_ctrby8_avx-x86_64.S            |   46 +-
 arch/x86/crypto/sha-mb/sha1_mb.c                   |    2 +-
 arch/x86/include/asm/acpi.h                        |    1 +
 arch/x86/include/asm/desc.h                        |   20 +-
 arch/x86/include/asm/mmu_context.h                 |   20 +-
 arch/x86/include/asm/vgtod.h                       |    6 +-
 arch/x86/kernel/acpi/boot.c                        |   35 +-
 arch/x86/kernel/cpu/Makefile                       |    1 +
 arch/x86/kernel/cpu/mkcapflags.sh                  |    2 +-
 arch/x86/kernel/cpu/mshyperv.c                     |    1 +
 arch/x86/kernel/cpu/perf_event_intel.c             |    1 +
 arch/x86/kernel/cpu/perf_event_intel_ds.c          |    4 +-
 arch/x86/kernel/cpu/perf_event_intel_rapl.c        |   46 +-
 arch/x86/kernel/cpu/perf_event_intel_uncore.c      |    9 +-
 arch/x86/kernel/cpu/perf_event_intel_uncore.h      |   20 +-
 .../x86/kernel/cpu/perf_event_intel_uncore_snbep.c |   17 +
 arch/x86/kernel/ftrace.c                           |    2 +-
 arch/x86/kernel/irq.c                              |    2 +-
 arch/x86/kernel/kprobes/core.c                     |   20 +-
 arch/x86/kernel/perf_regs.c                        |   90 ++
 arch/x86/kernel/tls.c                              |   25 +-
 arch/x86/kernel/tsc.c                              |    2 +-
 arch/x86/kvm/emulate.c                             |   31 +-
 arch/x86/kvm/lapic.c                               |    3 +
 arch/x86/kvm/mmu.c                                 |    2 +-
 arch/x86/kvm/vmx.c                                 |   88 +-
 arch/x86/lib/insn.c                                |    2 +-
 arch/x86/mm/fault.c                                |    2 +
 arch/x86/mm/init.c                                 |   41 +-
 arch/x86/mm/mpx.c                                  |    6 +
 arch/x86/mm/pat.c                                  |    7 +-
 arch/x86/pci/i386.c                                |    2 +-
 arch/x86/pci/xen.c                                 |   49 +-
 arch/x86/tools/calc_run_size.pl                    |   39 -
 arch/x86/tools/calc_run_size.sh                    |   42 +
 arch/x86/um/sys_call_table_32.c                    |    2 +-
 arch/x86/um/sys_call_table_64.c                    |    2 +-
 arch/x86/vdso/vma.c                                |   45 +-
 arch/x86/xen/enlighten.c                           |   22 +-
 arch/x86/xen/p2m.c                                 |   20 +-
 arch/x86/xen/setup.c                               |   42 +-
 arch/x86/xen/time.c                                |   18 +-
 arch/xtensa/mm/fault.c                             |    2 +
 block/blk-core.c                                   |   21 +-
 block/blk-mq-sysfs.c                               |   25 +-
 block/blk-mq-tag.c                                 |   14 +-
 block/blk-mq-tag.h                                 |    1 +
 block/blk-mq.c                                     |   81 +-
 block/blk-mq.h                                     |    1 +
 block/blk-timeout.c                                |    3 +
 crypto/aes_generic.c                               |    1 +
 crypto/af_alg.c                                    |    3 +
 crypto/ansi_cprng.c                                |    1 +
 crypto/blowfish_generic.c                          |    1 +
 crypto/camellia_generic.c                          |    1 +
 crypto/cast5_generic.c                             |    1 +
 crypto/cast6_generic.c                             |    1 +
 crypto/crc32c_generic.c                            |    1 +
 crypto/crct10dif_generic.c                         |    1 +
 crypto/des_generic.c                               |    7 +-
 crypto/ghash-generic.c                             |    1 +
 crypto/krng.c                                      |    1 +
 crypto/salsa20_generic.c                           |    1 +
 crypto/serpent_generic.c                           |    1 +
 crypto/sha1_generic.c                              |    1 +
 crypto/sha256_generic.c                            |    2 +
 crypto/sha512_generic.c                            |    2 +
 crypto/tea.c                                       |    1 +
 crypto/tgr192.c                                    |    1 +
 crypto/twofish_generic.c                           |    1 +
 crypto/wp512.c                                     |    1 +
 drivers/Kconfig                                    |    2 -
 drivers/Makefile                                   |    6 +-
 drivers/acpi/acpi_processor.c                      |   25 +-
 drivers/acpi/device_pm.c                           |    2 +-
 drivers/acpi/int340x_thermal.c                     |   11 +-
 drivers/acpi/pci_irq.c                             |    1 -
 drivers/acpi/processor_core.c                      |   56 +-
 drivers/acpi/processor_idle.c                      |    2 -
 drivers/acpi/scan.c                                |   13 +-
 drivers/acpi/video.c                               |   27 +
 drivers/ata/Kconfig                                |    1 +
 drivers/ata/ahci.c                                 |    1 -
 drivers/ata/ahci_xgene.c                           |   14 +-
 drivers/ata/libahci.c                              |    2 +-
 drivers/ata/libata-core.c                          |   36 +-
 drivers/ata/libata-eh.c                            |    1 +
 drivers/ata/libata-scsi.c                          |   10 +-
 drivers/ata/libata-sff.c                           |   12 +
 drivers/ata/sata_dwc_460ex.c                       |   26 +-
 drivers/ata/sata_sil24.c                           |    2 +-
 drivers/base/power/domain.c                        |    3 +-
 drivers/base/power/opp.c                           |   39 +-
 drivers/block/null_blk.c                           |    2 +-
 drivers/block/nvme-core.c                          |  177 +++-
 drivers/block/rbd.c                                |   25 +-
 drivers/block/virtio_blk.c                         |    2 +-
 drivers/bus/arm-cci.c                              |    3 +
 drivers/bus/mvebu-mbus.c                           |   13 +
 drivers/char/agp/ali-agp.c                         |    2 +-
 drivers/char/agp/amd64-agp.c                       |    2 +-
 drivers/char/agp/ati-agp.c                         |    2 +-
 drivers/char/agp/backend.c                         |    2 +-
 drivers/char/agp/intel-agp.c                       |    2 +-
 drivers/char/agp/intel-gtt.c                       |    2 +-
 drivers/char/agp/nvidia-agp.c                      |    2 +-
 drivers/char/agp/via-agp.c                         |    2 +-
 drivers/char/ipmi/ipmi_msghandler.c                |   46 +-
 drivers/char/ipmi/ipmi_ssif.c                      |    4 +-
 drivers/clk/at91/clk-slow.c                        |   27 +
 drivers/clk/berlin/bg2q.c                          |    1 -
 drivers/clk/clk-ppc-corenet.c                      |    2 +-
 drivers/clk/clk.c                                  |    2 +-
 drivers/clk/rockchip/clk-cpu.c                     |   10 +-
 drivers/clk/rockchip/clk-rk3188.c                  |   27 +-
 drivers/clk/rockchip/clk-rk3288.c                  |   28 +-
 drivers/clocksource/arm_arch_timer.c               |    2 +-
 drivers/clocksource/bcm_kona_timer.c               |    9 +-
 drivers/clocksource/exynos_mct.c                   |    4 +-
 drivers/clocksource/sh_tmu.c                       |    2 +-
 drivers/cpufreq/cpufreq-dt.c                       |   11 +
 drivers/cpufreq/cpufreq.c                          |    6 +
 drivers/cpuidle/governors/ladder.c                 |    7 +-
 drivers/cpuidle/governors/menu.c                   |   25 +-
 drivers/dma/dw/core.c                              |    2 -
 drivers/dma/dw/platform.c                          |    5 +
 drivers/gpio/gpio-crystalcove.c                    |    2 +-
 drivers/gpio/gpio-dln2.c                           |  156 ++-
 drivers/gpio/gpio-grgpio.c                         |    3 +-
 drivers/gpio/gpiolib-of.c                          |   10 +-
 drivers/gpio/gpiolib-sysfs.c                       |   92 +-
 drivers/gpio/gpiolib.c                             |   58 +-
 drivers/gpio/gpiolib.h                             |    1 +
 drivers/gpu/drm/Makefile                           |    2 +-
 drivers/gpu/drm/amd/amdkfd/Makefile                |    3 +-
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c           |  320 +++---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c            |   26 +-
 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.c  |  106 +-
 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.h  |    1 +
 drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c       |    6 +-
 drivers/gpu/drm/amd/amdkfd/kfd_interrupt.c         |  176 ----
 drivers/gpu/drm/amd/amdkfd/kfd_module.c            |   27 +-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c       |    2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_pasid.c             |    4 +-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h              |   50 +-
 drivers/gpu/drm/amd/amdkfd/kfd_process.c           |    9 +
 .../gpu/drm/amd/amdkfd/kfd_process_queue_manager.c |   12 +-
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c          |   10 +-
 drivers/gpu/drm/amd/include/kgd_kfd_interface.h    |   17 +-
 drivers/gpu/drm/drm_atomic_helper.c                |    2 +-
 drivers/gpu/drm/drm_fb_helper.c                    |   38 +-
 drivers/gpu/drm/drm_irq.c                          |   60 ++
 drivers/gpu/drm/exynos/exynos_drm_drv.c            |   12 -
 drivers/gpu/drm/exynos/exynos_hdmi.c               |    8 +-
 drivers/gpu/drm/exynos/exynos_mixer.c              |   11 +-
 drivers/gpu/drm/i2c/tda998x_drv.c                  |   52 +-
 drivers/gpu/drm/i915/i915_drv.c                    |   20 +-
 drivers/gpu/drm/i915/i915_drv.h                    |   10 +-
 drivers/gpu/drm/i915/i915_gem.c                    |   64 +-
 drivers/gpu/drm/i915/i915_gem_context.c            |   48 +-
 drivers/gpu/drm/i915/i915_gem_execbuffer.c         |    3 -
 drivers/gpu/drm/i915/i915_irq.c                    |   44 +-
 drivers/gpu/drm/i915/i915_reg.h                    |    3 +
 drivers/gpu/drm/i915/intel_display.c               |   10 +-
 drivers/gpu/drm/i915/intel_drv.h                   |    1 +
 drivers/gpu/drm/i915/intel_panel.c                 |    2 +-
 drivers/gpu/drm/i915/intel_pm.c                    |   42 +-
 drivers/gpu/drm/i915/intel_ringbuffer.c            |    3 +
 drivers/gpu/drm/i915/intel_runtime_pm.c            |   27 -
 drivers/gpu/drm/msm/adreno/adreno_gpu.c            |    6 +-
 drivers/gpu/drm/msm/hdmi/hdmi_connector.c          |   53 +-
 drivers/gpu/drm/msm/mdp/mdp4/mdp4_crtc.c           |   11 +-
 drivers/gpu/drm/msm/mdp/mdp5/mdp5_crtc.c           |   12 +-
 drivers/gpu/drm/msm/mdp/mdp5/mdp5_kms.c            |   12 +-
 drivers/gpu/drm/msm/mdp/mdp_kms.c                  |    9 +-
 drivers/gpu/drm/msm/mdp/mdp_kms.h                  |    2 +-
 drivers/gpu/drm/msm/msm_atomic.c                   |   69 +-
 drivers/gpu/drm/msm/msm_drv.c                      |    1 +
 drivers/gpu/drm/msm/msm_drv.h                      |    4 +
 drivers/gpu/drm/msm/msm_fbdev.c                    |    3 +-
 drivers/gpu/drm/msm/msm_gem.c                      |    3 +-
 drivers/gpu/drm/nouveau/core/core/event.c          |    4 +-
 drivers/gpu/drm/nouveau/core/core/notify.c         |    2 +-
 drivers/gpu/drm/nouveau/core/engine/device/nve0.c  |   33 +
 .../gpu/drm/nouveau/core/subdev/bios/shadowramin.c |    6 +-
 drivers/gpu/drm/nouveau/core/subdev/fb/ramnvaa.c   |   65 +-
 drivers/gpu/drm/nouveau/core/subdev/mc/nv4c.c      |    8 -
 drivers/gpu/drm/nouveau/nouveau_bo.c               |    4 +-
 drivers/gpu/drm/nouveau/nouveau_display.c          |    9 -
 drivers/gpu/drm/nouveau/nouveau_gem.c              |   38 +-
 drivers/gpu/drm/nouveau/nouveau_ttm.c              |    3 +-
 drivers/gpu/drm/radeon/atombios_crtc.c             |    8 +-
 drivers/gpu/drm/radeon/atombios_dp.c               |    4 +
 drivers/gpu/drm/radeon/cik.c                       |   11 +
 drivers/gpu/drm/radeon/cik_sdma.c                  |   11 +-
 drivers/gpu/drm/radeon/cikd.h                      |    2 +
 drivers/gpu/drm/radeon/dce3_1_afmt.c               |    2 +-
 drivers/gpu/drm/radeon/kv_dpm.c                    |   10 +-
 drivers/gpu/drm/radeon/ni.c                        |   10 +
 drivers/gpu/drm/radeon/ni_dma.c                    |    7 +-
 drivers/gpu/drm/radeon/nid.h                       |   24 +
 drivers/gpu/drm/radeon/r100.c                      |   10 +-
 drivers/gpu/drm/radeon/r300.c                      |   16 +-
 drivers/gpu/drm/radeon/radeon.h                    |    9 +-
 drivers/gpu/drm/radeon/radeon_asic.c               |   42 +-
 drivers/gpu/drm/radeon/radeon_asic.h               |   12 +-
 drivers/gpu/drm/radeon/radeon_device.c             |    2 +
 drivers/gpu/drm/radeon/radeon_gart.c               |   54 +-
 drivers/gpu/drm/radeon/radeon_gem.c                |   28 +-
 drivers/gpu/drm/radeon/radeon_kfd.c                |   78 +-
 drivers/gpu/drm/radeon/radeon_object.c             |    3 -
 drivers/gpu/drm/radeon/radeon_pm.c                 |   33 +
 drivers/gpu/drm/radeon/radeon_state.c              |    2 +-
 drivers/gpu/drm/radeon/radeon_vm.c                 |    6 +-
 drivers/gpu/drm/radeon/rs400.c                     |   14 +-
 drivers/gpu/drm/radeon/rs600.c                     |   14 +-
 drivers/gpu/drm/radeon/si.c                        |   10 +
 drivers/gpu/drm/radeon/si_dma.c                    |    9 +-
 drivers/gpu/drm/radeon/si_dpm.c                    |   39 +
 drivers/gpu/drm/radeon/sid.h                       |   18 +
 drivers/gpu/drm/tegra/dc.c                         |   48 +-
 drivers/gpu/drm/tegra/drm.c                        |   16 +-
 drivers/gpu/drm/tegra/gem.c                        |   52 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.c                |   28 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.h                |   25 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_fence.c              |   18 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_fifo.c               |   36 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_ioctl.c              |    8 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_irq.c                |   25 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c                |    2 -
 drivers/hid/Kconfig                                |    3 +-
 drivers/hid/hid-core.c                             |    1 +
 drivers/hid/hid-ids.h                              |    1 +
 drivers/hid/hid-input.c                            |    3 +
 drivers/hid/hid-kye.c                              |    4 +
 drivers/hid/hid-logitech-dj.c                      |   16 +-
 drivers/hid/hid-logitech-hidpp.c                   |   41 +
 drivers/hid/hid-roccat-pyra.c                      |    8 +-
 drivers/hid/i2c-hid/i2c-hid.c                      |    5 -
 drivers/hid/usbhid/hid-quirks.c                    |    1 +
 drivers/hwmon/Kconfig                              |   10 +
 drivers/hwmon/Makefile                             |    1 +
 drivers/hwmon/i5500_temp.c                         |  149 +++
 drivers/i2c/busses/Kconfig                         |    1 +
 drivers/i2c/busses/i2c-s3c2410.c                   |   23 +-
 drivers/i2c/busses/i2c-sh_mobile.c                 |   12 +-
 drivers/i2c/i2c-core.c                             |    2 +
 drivers/i2c/i2c-slave-eeprom.c                     |    4 +-
 drivers/iio/adc/ad799x.c                           |   15 +-
 drivers/iio/inkern.c                               |    3 +
 drivers/infiniband/hw/mlx4/main.c                  |    3 +-
 drivers/input/evdev.c                              |   60 +-
 drivers/input/input.c                              |   22 +-
 drivers/input/keyboard/Kconfig                     |    1 +
 drivers/input/keyboard/gpio_keys.c                 |  114 +--
 drivers/input/keyboard/hil_kbd.c                   |    6 +-
 drivers/input/keyboard/stmpe-keypad.c              |  141 +--
 drivers/input/mouse/alps.c                         |   84 +-
 drivers/input/mouse/elantech.c                     |   18 +
 drivers/input/mouse/synaptics.c                    |    7 +-
 drivers/input/mouse/trackpoint.c                   |    4 +
 drivers/input/mouse/trackpoint.h                   |    5 +
 drivers/input/serio/i8042-x86ia64io.h              |   47 +
 drivers/input/serio/i8042.c                        |   14 +
 drivers/input/touchscreen/atmel_mxt_ts.c           |   99 +-
 drivers/input/touchscreen/edt-ft5x06.c             |    4 +-
 drivers/iommu/intel-iommu.c                        |   12 +-
 drivers/iommu/ipmmu-vmsa.c                         |    6 +-
 drivers/iommu/rockchip-iommu.c                     |    1 -
 drivers/iommu/tegra-gart.c                         |    3 +-
 drivers/irqchip/irq-atmel-aic-common.c             |    4 +-
 drivers/irqchip/irq-gic-v3-its.c                   |    2 +-
 drivers/irqchip/irq-hip04.c                        |    2 +-
 drivers/irqchip/irq-mtk-sysirq.c                   |    4 +-
 drivers/irqchip/irq-omap-intc.c                    |   26 +-
 drivers/isdn/hardware/eicon/message.c              |    2 +-
 drivers/leds/leds-netxbig.c                        |   12 +-
 drivers/mcb/mcb-internal.h                         |    1 +
 drivers/mcb/mcb-pci.c                              |   27 +-
 drivers/md/dm-cache-metadata.c                     |  104 +-
 drivers/md/dm-cache-target.c                       |   89 +-
 drivers/md/dm-thin.c                               |   35 +-
 drivers/md/dm.c                                    |   11 +-
 drivers/media/pci/cx23885/cx23885-cards.c          |   23 +-
 drivers/media/pci/cx23885/cx23885-core.c           |    4 +-
 drivers/media/pci/cx23885/cx23885-dvb.c            |   11 +
 drivers/media/pci/cx23885/cx23885.h                |    1 +
 drivers/media/platform/omap3isp/ispvideo.c         |    7 +-
 drivers/media/platform/soc_camera/atmel-isi.c      |    5 +-
 drivers/media/platform/soc_camera/mx2_camera.c     |    3 +-
 drivers/media/platform/soc_camera/mx3_camera.c     |    3 +-
 drivers/media/platform/soc_camera/omap1_camera.c   |    3 +-
 drivers/media/platform/soc_camera/pxa_camera.c     |    3 +-
 drivers/media/platform/soc_camera/rcar_vin.c       |    4 +-
 .../platform/soc_camera/sh_mobile_ceu_camera.c     |    4 +-
 drivers/media/usb/dvb-usb/cxusb.c                  |    2 +-
 drivers/media/usb/pvrusb2/pvrusb2-v4l2.c           |   24 +-
 drivers/media/v4l2-core/videobuf2-core.c           |   19 +-
 drivers/mfd/da9052-core.c                          |    3 +-
 drivers/mfd/rtsx_usb.c                             |   12 -
 drivers/mfd/stmpe.c                                |    4 +
 drivers/mfd/stmpe.h                                |    3 +
 drivers/mfd/tps65218.c                             |   12 +
 drivers/misc/cxl/context.c                         |   82 +-
 drivers/misc/cxl/file.c                            |   14 +-
 drivers/misc/mei/hw-me.c                           |   12 +
 drivers/mmc/core/mmc.c                             |    2 +-
 drivers/mmc/host/sdhci-acpi.c                      |    2 +
 drivers/mmc/host/sdhci-pci.c                       |   25 +
 drivers/mmc/host/sdhci-pci.h                       |    3 +
 drivers/mmc/host/sdhci-pxav3.c                     |   15 +-
 drivers/mmc/host/sdhci.c                           |   80 +-
 drivers/net/bonding/bond_main.c                    |    2 +-
 drivers/net/caif/caif_virtio.c                     |    2 -
 drivers/net/can/c_can/c_can.c                      |    3 +
 drivers/net/can/c_can/c_can_platform.c             |   29 +-
 drivers/net/can/dev.c                              |    8 +-
 drivers/net/can/m_can/m_can.c                      |    5 +
 drivers/net/can/usb/kvaser_usb.c                   |   57 +-
 drivers/net/ethernet/8390/ne2k-pci.c               |    6 +-
 drivers/net/ethernet/Kconfig                       |   12 -
 drivers/net/ethernet/Makefile                      |    1 -
 drivers/net/ethernet/allwinner/sun4i-emac.c        |    4 +-
 drivers/net/ethernet/altera/altera_tse_main.c      |   15 +-
 drivers/net/ethernet/amd/xgbe/xgbe-common.h        |    9 +-
 drivers/net/ethernet/amd/xgbe/xgbe-dev.c           |    4 +-
 drivers/net/ethernet/atheros/alx/main.c            |   24 +-
 drivers/net/ethernet/broadcom/bgmac.c              |   12 +-
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c    |    2 +-
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c   |    8 +-
 drivers/net/ethernet/broadcom/tg3.c                |   57 +-
 drivers/net/ethernet/brocade/bna/bnad_debugfs.c    |    2 +-
 drivers/net/ethernet/cadence/at91_ether.c          |   10 +-
 drivers/net/ethernet/chelsio/cxgb4vf/adapter.h     |    4 +
 .../net/ethernet/chelsio/cxgb4vf/cxgb4vf_main.c    |  144 ++-
 drivers/net/ethernet/chelsio/cxgb4vf/t4vf_common.h |    2 +-
 drivers/net/ethernet/chelsio/cxgb4vf/t4vf_hw.c     |   56 +-
 drivers/net/ethernet/cisco/enic/enic_main.c        |   20 +-
 drivers/net/ethernet/dnet.c                        |   18 +-
 drivers/net/ethernet/emulex/benet/be_main.c        |   47 +-
 drivers/net/ethernet/freescale/fec.h               |    2 +
 drivers/net/ethernet/freescale/fec_main.c          |   10 +-
 drivers/net/ethernet/intel/Kconfig                 |   11 +
 drivers/net/ethernet/intel/e100.c                  |    2 +-
 drivers/net/ethernet/intel/i40e/Makefile           |    2 +-
 drivers/net/ethernet/intel/i40e/i40e_debugfs.c     |    4 +-
 drivers/net/ethernet/intel/i40e/i40e_osdep.h       |    4 +-
 drivers/net/ethernet/intel/i40e/i40e_txrx.c        |  104 +-
 drivers/net/ethernet/intel/i40e/i40e_txrx.h        |    1 +
 drivers/net/ethernet/intel/igb/e1000_82575.c       |    2 +-
 drivers/net/ethernet/marvell/mv643xx_eth.c         |   59 +-
 drivers/net/ethernet/mellanox/mlx4/en_netdev.c     |   13 +-
 drivers/net/ethernet/mellanox/mlx4/en_tx.c         |   12 +-
 drivers/net/ethernet/mellanox/mlx4/main.c          |   16 +-
 drivers/net/ethernet/mellanox/mlx4/mr.c            |    9 +-
 drivers/net/ethernet/micrel/ksz884x.c              |    6 -
 drivers/net/ethernet/myricom/myri10ge/myri10ge.c   |    4 +-
 drivers/net/ethernet/neterion/s2io.c               |   11 +-
 .../net/ethernet/qlogic/netxen/netxen_nic_main.c   |    5 +-
 drivers/net/ethernet/qlogic/qla3xxx.c              |    8 +-
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_main.c   |    9 +-
 drivers/net/ethernet/realtek/8139too.c             |    4 +-
 drivers/net/ethernet/renesas/sh_eth.c              |  201 ++--
 drivers/net/ethernet/renesas/sh_eth.h              |    6 +
 drivers/net/ethernet/s6gmac.c                      | 1058 --------------------
 drivers/net/ethernet/samsung/sxgbe/sxgbe_main.c    |   21 +-
 .../net/ethernet/samsung/sxgbe/sxgbe_platform.c    |    8 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |   19 +-
 .../net/ethernet/stmicro/stmmac/stmmac_platform.c  |    1 -
 drivers/net/ethernet/sun/sunvnet.c                 |    1 +
 drivers/net/ethernet/ti/cpsw.c                     |   79 +-
 drivers/net/ethernet/ti/cpsw_ale.c                 |   10 +-
 drivers/net/ethernet/ti/cpsw_ale.h                 |    2 +-
 drivers/net/ethernet/ti/davinci_emac.c             |   96 +-
 drivers/net/ethernet/xilinx/ll_temac_main.c        |    2 +
 drivers/net/ethernet/xilinx/xilinx_axienet.h       |    2 -
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c  |    6 +-
 drivers/net/ethernet/xilinx/xilinx_emaclite.c      |    1 +
 drivers/net/hyperv/hyperv_net.h                    |    1 +
 drivers/net/hyperv/netvsc.c                        |   15 +-
 drivers/net/ipvlan/ipvlan_core.c                   |    6 +-
 drivers/net/phy/micrel.c                           |   18 +-
 drivers/net/team/team.c                            |   16 +-
 drivers/net/usb/kaweth.c                           |    2 +-
 drivers/net/usb/qmi_wwan.c                         |   10 +-
 drivers/net/usb/r8152.c                            |   47 +-
 drivers/net/virtio_net.c                           |    2 -
 drivers/net/vxlan.c                                |   34 +-
 drivers/net/wireless/ath/ath9k/main.c              |    7 +-
 drivers/net/wireless/brcm80211/brcmfmac/bcmsdh.c   |    4 +-
 drivers/net/wireless/ipw2x00/Kconfig               |    3 +-
 drivers/net/wireless/iwlwifi/iwl-7000.c            |    6 +-
 drivers/net/wireless/iwlwifi/iwl-8000.c            |    2 +-
 drivers/net/wireless/iwlwifi/iwl-drv.c             |    2 +-
 drivers/net/wireless/iwlwifi/iwl-fh.h              |    1 +
 drivers/net/wireless/iwlwifi/iwl-fw-file.h         |    6 +
 drivers/net/wireless/iwlwifi/mvm/fw-api-scan.h     |    9 +-
 drivers/net/wireless/iwlwifi/mvm/mac80211.c        |   35 +-
 drivers/net/wireless/iwlwifi/mvm/scan.c            |   72 +-
 drivers/net/wireless/iwlwifi/mvm/tx.c              |   19 +-
 drivers/net/wireless/iwlwifi/mvm/utils.c           |    2 +-
 drivers/net/wireless/iwlwifi/pcie/drv.c            |    8 +-
 drivers/net/wireless/iwlwifi/pcie/trans.c          |   17 +-
 drivers/net/wireless/rtlwifi/pci.c                 |   32 +-
 drivers/net/xen-netback/xenbus.c                   |    1 +
 drivers/net/xen-netfront.c                         |   71 +-
 drivers/of/overlay.c                               |   11 -
 drivers/of/platform.c                              |   11 +-
 drivers/of/unittest-data/tests-overlay.dtsi        |   55 +
 drivers/of/unittest.c                              |   39 +
 drivers/parisc/lba_pci.c                           |    5 +-
 drivers/pci/bus.c                                  |   43 +
 drivers/pci/pci.c                                  |   40 +-
 drivers/pci/pci.h                                  |    1 +
 drivers/pci/quirks.c                               |   14 +
 drivers/pci/setup-bus.c                            |   56 +-
 drivers/phy/phy-miphy28lp.c                        |    3 +-
 drivers/phy/phy-omap-control.c                     |    7 +-
 drivers/phy/phy-sun4i-usb.c                        |    3 +-
 drivers/phy/phy-ti-pipe3.c                         |   10 +-
 drivers/pinctrl/core.c                             |    5 +-
 drivers/pinctrl/pinctrl-at91.c                     |  108 +-
 drivers/pinctrl/pinctrl-rockchip.c                 |  102 +-
 drivers/pinctrl/pinctrl-st.c                       |    5 +-
 drivers/pinctrl/pinctrl-xway.c                     |    2 -
 drivers/pinctrl/qcom/pinctrl-msm.c                 |    4 +-
 drivers/platform/x86/dell-laptop.c                 | 1055 +------------------
 drivers/powercap/intel_rapl.c                      |    1 +
 drivers/regulator/core.c                           |    4 +-
 drivers/regulator/s2mps11.c                        |   61 +-
 drivers/reset/reset-sunxi.c                        |    4 +
 drivers/rtc/rtc-s5m.c                              |    1 +
 drivers/s390/crypto/ap_bus.c                       |   10 +-
 drivers/s390/net/qeth_core_main.c                  |  117 ++-
 drivers/s390/net/qeth_l2_main.c                    |  220 ++--
 drivers/s390/net/qeth_l3_main.c                    |   50 +-
 drivers/scsi/fnic/fnic.h                           |    2 +-
 drivers/scsi/fnic/fnic_scsi.c                      |   15 +
 drivers/scsi/ipr.c                                 |   92 ++
 drivers/scsi/ipr.h                                 |    1 +
 drivers/scsi/qla2xxx/qla_os.c                      |    4 +-
 drivers/scsi/scsi.c                                |   13 +-
 drivers/scsi/scsi_debug.c                          |    4 +-
 drivers/scsi/scsi_error.c                          |    4 +-
 drivers/scsi/scsi_lib.c                            |   15 +-
 drivers/scsi/sd.c                                  |    5 +-
 drivers/spi/spi-dw-mid.c                           |    1 -
 drivers/spi/spi-dw.c                               |    6 +-
 drivers/spi/spi-img-spfi.c                         |    8 +-
 drivers/spi/spi-pxa2xx.c                           |    2 +-
 drivers/spi/spi-sh-msiof.c                         |    7 +-
 drivers/staging/lustre/lustre/llite/namei.c        |    2 +-
 drivers/staging/lustre/lustre/llite/vvp_io.c       |    2 +-
 drivers/staging/media/tlg2300/Kconfig              |    1 +
 drivers/staging/nvec/nvec.c                        |    9 +-
 drivers/staging/vt6655/baseband.c                  |    2 +-
 drivers/staging/vt6655/channel.c                   |    8 +
 drivers/staging/vt6655/device_main.c               |   13 +-
 drivers/staging/vt6655/rxtx.c                      |    5 +-
 drivers/target/iscsi/iscsi_target.c                |   12 +-
 drivers/target/iscsi/iscsi_target_core.h           |    4 +-
 drivers/target/target_core_device.c                |   54 +-
 drivers/target/target_core_file.c                  |   12 +-
 drivers/target/target_core_iblock.c                |    3 +-
 drivers/target/target_core_pr.c                    |   12 +
 drivers/target/target_core_rd.c                    |    1 -
 drivers/target/target_core_sbc.c                   |   15 -
 drivers/target/target_core_spc.c                   |    5 +-
 drivers/target/target_core_user.c                  |    1 -
 drivers/thermal/cpu_cooling.c                      |  360 +++----
 drivers/thermal/db8500_cpufreq_cooling.c           |   20 +-
 drivers/thermal/imx_thermal.c                      |   17 +-
 drivers/thermal/int340x_thermal/Makefile           |    1 +
 drivers/thermal/int340x_thermal/acpi_thermal_rel.c |   24 +-
 drivers/thermal/int340x_thermal/int3400_thermal.c  |    1 -
 drivers/thermal/int340x_thermal/int3402_thermal.c  |    1 -
 drivers/thermal/int340x_thermal/int3403_thermal.c  |    4 +
 .../int340x_thermal/processor_thermal_device.c     |  311 ++++++
 drivers/thermal/intel_powerclamp.c                 |    1 +
 drivers/thermal/of-thermal.c                       |    2 +-
 drivers/thermal/rcar_thermal.c                     |   17 +-
 drivers/thermal/rockchip_thermal.c                 |    1 -
 drivers/thermal/samsung/Kconfig                    |    2 +-
 drivers/thermal/samsung/exynos_thermal_common.c    |   12 +-
 drivers/thermal/samsung/exynos_tmu.c               |    5 +-
 drivers/thermal/thermal_core.c                     |    6 +-
 drivers/thermal/thermal_core.h                     |    4 +-
 drivers/thermal/ti-soc-thermal/ti-thermal-common.c |   17 +-
 drivers/tty/n_tty.c                                |    9 +-
 drivers/tty/serial/8250/8250_pci.c                 |   29 +-
 drivers/tty/serial/samsung.c                       |   56 +-
 drivers/tty/serial/serial_core.c                   |    4 +-
 drivers/tty/tty_io.c                               |    7 +-
 drivers/usb/chipidea/core.c                        |    2 +-
 drivers/usb/chipidea/host.c                        |    1 +
 drivers/usb/core/otg_whitelist.h                   |    5 +
 drivers/usb/core/quirks.c                          |    4 +
 drivers/usb/dwc2/core_intr.c                       |    6 +-
 drivers/usb/dwc2/gadget.c                          |   10 +-
 drivers/usb/dwc3/dwc3-pci.c                        |    4 +
 drivers/usb/dwc3/gadget.c                          |    6 +-
 drivers/usb/gadget/function/f_hid.c                |    5 +-
 drivers/usb/gadget/function/f_midi.c               |    2 +-
 drivers/usb/gadget/function/f_uac1.c               |    2 +-
 drivers/usb/gadget/legacy/inode.c                  |    2 +
 drivers/usb/gadget/udc/atmel_usba_udc.c            |   19 +-
 drivers/usb/gadget/udc/bdc/bdc_ep.c                |    3 +-
 drivers/usb/host/ehci-sched.c                      |   14 +-
 drivers/usb/host/ehci-tegra.c                      |    2 +-
 drivers/usb/host/pci-quirks.c                      |   18 +-
 drivers/usb/host/xhci-pci.c                        |    2 +
 drivers/usb/host/xhci.c                            |    9 +
 drivers/usb/musb/Kconfig                           |    4 +
 drivers/usb/musb/blackfin.c                        |    2 +-
 drivers/usb/musb/musb_cppi41.c                     |    4 +-
 drivers/usb/musb/musb_debugfs.c                    |   34 +-
 drivers/usb/musb/musb_host.c                       |    1 -
 drivers/usb/phy/phy-mv-usb.c                       |    5 +-
 drivers/usb/phy/phy.c                              |   14 +-
 drivers/usb/serial/console.c                       |   16 +-
 drivers/usb/serial/cp210x.c                        |    4 +-
 drivers/usb/serial/generic.c                       |    4 +-
 drivers/usb/serial/keyspan.c                       |   20 +-
 drivers/usb/serial/option.c                        |   11 +-
 drivers/usb/serial/qcserial.c                      |    1 -
 drivers/usb/storage/uas-detect.h                   |   33 +-
 drivers/usb/storage/unusual_devs.h                 |    9 +-
 drivers/usb/storage/unusual_uas.h                  |   53 +-
 drivers/vfio/pci/vfio_pci.c                        |    4 +-
 drivers/vhost/net.c                                |    2 +-
 drivers/vhost/scsi.c                               |   24 +-
 drivers/vhost/vhost.c                              |   10 +-
 drivers/video/fbdev/broadsheetfb.c                 |    8 +-
 drivers/video/fbdev/core/fb_defio.c                |    5 +-
 drivers/video/fbdev/omap2/dss/hdmi_pll.c           |    2 -
 drivers/video/fbdev/omap2/dss/pll.c                |    3 +-
 drivers/video/fbdev/omap2/dss/sdi.c                |    2 +
 drivers/video/fbdev/simplefb.c                     |    2 +-
 drivers/video/logo/logo.c                          |   17 +-
 drivers/virtio/virtio_pci_common.c                 |   10 +-
 drivers/virtio/virtio_pci_common.h                 |    1 -
 drivers/virtio/virtio_pci_legacy.c                 |   12 +-
 drivers/watchdog/cadence_wdt.c                     |    1 -
 drivers/watchdog/imx2_wdt.c                        |   40 +-
 drivers/watchdog/meson_wdt.c                       |    1 -
 fs/btrfs/backref.c                                 |   13 +-
 fs/btrfs/ctree.h                                   |    1 +
 fs/btrfs/delayed-inode.c                           |    8 +
 fs/btrfs/extent-tree.c                             |   14 +-
 fs/btrfs/extent_io.c                               |    2 +-
 fs/btrfs/inode.c                                   |    4 +-
 fs/btrfs/scrub.c                                   |    6 +-
 fs/btrfs/super.c                                   |   14 +-
 fs/btrfs/transaction.c                             |    2 +-
 fs/ceph/addr.c                                     |    2 +-
 fs/cifs/cifsglob.h                                 |    6 +-
 fs/cifs/ioctl.c                                    |   21 +-
 fs/cifs/netmisc.c                                  |   12 +-
 fs/cifs/readdir.c                                  |   10 +-
 fs/cifs/smb2misc.c                                 |   12 +-
 fs/cifs/smb2ops.c                                  |    3 +-
 fs/cifs/smb2pdu.h                                  |    2 +-
 fs/cifs/smb2transport.c                            |    2 +-
 fs/ext4/extents.c                                  |    4 +-
 fs/ext4/file.c                                     |  220 ++--
 fs/ext4/resize.c                                   |   24 +-
 fs/ext4/super.c                                    |    2 +-
 fs/fcntl.c                                         |    5 +-
 fs/fuse/dev.c                                      |   51 +-
 fs/fuse/dir.c                                      |   31 +-
 fs/fuse/fuse_i.h                                   |    2 +
 fs/fuse/inode.c                                    |    5 +-
 fs/gfs2/quota.c                                    |   49 +-
 fs/isofs/rock.c                                    |    3 +
 fs/kernfs/dir.c                                    |   12 +-
 fs/lockd/svc.c                                     |    8 +-
 fs/locks.c                                         |    2 +-
 fs/nfs/direct.c                                    |    6 +
 fs/nfs/inode.c                                     |    5 +-
 fs/nfs/internal.h                                  |    2 -
 fs/nfs/nfs4client.c                                |   44 +-
 fs/nfs/nfs4proc.c                                  |   21 +-
 fs/nfsd/nfs4state.c                                |    2 +-
 fs/notify/fanotify/fanotify_user.c                 |   10 +-
 fs/ocfs2/dlm/dlmrecovery.c                         |    5 +-
 fs/ocfs2/namei.c                                   |   43 +-
 fs/quota/dquot.c                                   |   83 +-
 fs/quota/quota.c                                   |  162 ++-
 fs/udf/dir.c                                       |   31 +-
 fs/udf/file.c                                      |    2 +-
 fs/udf/inode.c                                     |   14 +
 fs/udf/namei.c                                     |   17 +-
 fs/udf/symlink.c                                   |   57 +-
 fs/udf/udfdecl.h                                   |    3 +-
 fs/udf/unicode.c                                   |   28 +-
 fs/xfs/xfs_qm.h                                    |    4 +-
 fs/xfs/xfs_qm_syscalls.c                           |  156 ++-
 fs/xfs/xfs_quotaops.c                              |    8 +-
 include/acpi/processor.h                           |    8 +-
 include/asm-generic/tlb.h                          |    8 +-
 include/drm/drmP.h                                 |    4 +
 include/drm/drm_gem.h                              |    7 -
 include/dt-bindings/interrupt-controller/arm-gic.h |    4 +-
 include/dt-bindings/sound/samsung-i2s.h            |    8 +
 include/dt-bindings/thermal/thermal.h              |    2 +-
 include/linux/acpi.h                               |    4 +-
 include/linux/audit.h                              |    4 +
 include/linux/blk-mq.h                             |    8 +-
 include/linux/blk_types.h                          |    2 +
 include/linux/ceph/osd_client.h                    |    4 +-
 include/linux/compiler.h                           |   12 +-
 include/linux/cpu_cooling.h                        |    6 +-
 include/linux/cpuidle.h                            |    3 -
 include/linux/fs.h                                 |    2 +-
 include/linux/genetlink.h                          |    4 +
 include/linux/i2c.h                                |    6 +
 include/linux/kdb.h                                |   62 +-
 include/linux/kernel.h                             |    2 +-
 include/linux/libata.h                             |    2 +
 include/linux/mfd/samsung/s2mps13.h                |    2 +
 include/linux/mfd/stmpe.h                          |   22 +-
 include/linux/mm.h                                 |    8 +-
 include/linux/mmc/sdhci.h                          |    1 +
 include/linux/module.h                             |    2 +-
 include/linux/moduleloader.h                       |    4 +-
 include/linux/netdevice.h                          |   26 +-
 include/linux/netlink.h                            |    4 +-
 include/linux/nfs_fs_sb.h                          |    3 +
 include/linux/oom.h                                |    5 -
 include/linux/pagemap.h                            |   13 +-
 include/linux/pci.h                                |    3 +
 include/linux/perf_event.h                         |   18 +-
 include/linux/perf_regs.h                          |   16 +
 include/linux/phy/omap_control_phy.h               |    6 +-
 include/linux/pm_domain.h                          |    8 +
 include/linux/printk.h                             |   15 +-
 include/linux/quota.h                              |   47 +-
 include/linux/quotaops.h                           |    4 +-
 include/linux/rmap.h                               |   10 +
 include/linux/thermal.h                            |    2 +-
 include/linux/time.h                               |   13 +
 include/linux/writeback.h                          |    1 -
 include/net/genetlink.h                            |   14 +-
 include/net/ip.h                                   |   11 +-
 include/net/mac80211.h                             |    7 +-
 include/net/neighbour.h                            |    1 -
 include/net/vxlan.h                                |   28 +-
 include/sound/pcm.h                                |   22 +-
 include/sound/rcar_snd.h                           |    1 +
 include/sound/rt5677.h                             |    3 +
 include/sound/simple_card.h                        |    1 +
 include/sound/soc-dapm.h                           |    4 +-
 include/sound/soc.h                                |    4 +
 include/sound/sta32x.h                             |   18 +-
 include/target/target_core_backend.h               |    1 -
 include/target/target_core_backend_configfs.h      |    2 -
 include/target/target_core_base.h                  |    3 -
 include/trace/events/kvm.h                         |   16 +-
 include/uapi/asm-generic/fcntl.h                   |    2 +-
 include/uapi/linux/can/netlink.h                   |    1 +
 include/uapi/linux/in6.h                           |    3 +-
 include/uapi/linux/kfd_ioctl.h                     |   37 +-
 include/uapi/linux/libc-compat.h                   |    3 +
 include/uapi/linux/openvswitch.h                   |    4 +
 include/uapi/linux/uinput.h                        |    4 +-
 include/uapi/linux/virtio_ring.h                   |    7 +
 include/xen/interface/nmi.h                        |   51 +
 kernel/audit.c                                     |   10 +-
 kernel/auditfilter.c                               |   23 +-
 kernel/auditsc.c                                   |   49 +-
 kernel/bpf/core.c                                  |    2 +-
 kernel/bpf/syscall.c                               |   25 +-
 kernel/cgroup.c                                    |    2 +-
 kernel/debug/debug_core.c                          |   52 +-
 kernel/debug/kdb/kdb_bp.c                          |   37 +-
 kernel/debug/kdb/kdb_debugger.c                    |    4 +
 kernel/debug/kdb/kdb_main.c                        |  269 +++--
 kernel/debug/kdb/kdb_private.h                     |    3 +-
 kernel/events/core.c                               |   34 +-
 kernel/exit.c                                      |   12 +-
 kernel/kprobes.c                                   |    2 +-
 kernel/locking/mutex-debug.c                       |    2 +-
 kernel/module.c                                    |   91 +-
 kernel/params.c                                    |    3 +
 kernel/range.c                                     |   10 +-
 kernel/sched/core.c                                |   18 +-
 kernel/sched/deadline.c                            |   25 +-
 kernel/sched/fair.c                                |    6 +-
 kernel/sys.c                                       |    4 +
 kernel/time/ntp.c                                  |    7 +
 kernel/time/time.c                                 |    4 +
 kernel/trace/ftrace.c                              |   53 +-
 kernel/trace/trace.c                               |    1 -
 kernel/trace/trace_events.c                        |   69 +-
 kernel/trace/trace_kdb.c                           |    4 +-
 kernel/workqueue.c                                 |   25 +-
 lib/Kconfig.kgdb                                   |   25 +
 lib/assoc_array.c                                  |    1 +
 mm/Kconfig.debug                                   |    9 -
 mm/filemap.c                                       |   29 +-
 mm/gup.c                                           |    4 +-
 mm/ksm.c                                           |    2 +-
 mm/memcontrol.c                                    |   21 +-
 mm/memory.c                                        |   45 +-
 mm/mmap.c                                          |   13 +-
 mm/page-writeback.c                                |   43 +-
 mm/page_alloc.c                                    |   82 +-
 mm/rmap.c                                          |   42 +-
 mm/vmscan.c                                        |   26 +-
 net/batman-adv/fragmentation.c                     |    4 +-
 net/batman-adv/gateway_client.c                    |    2 +-
 net/batman-adv/multicast.c                         |   11 +-
 net/batman-adv/network-coding.c                    |    2 +-
 net/batman-adv/originator.c                        |    7 +-
 net/batman-adv/routing.c                           |    6 +-
 net/bluetooth/6lowpan.c                            |    1 -
 net/bluetooth/bnep/core.c                          |    3 +
 net/bluetooth/cmtp/core.c                          |    3 +
 net/bluetooth/hci_event.c                          |   16 +-
 net/bluetooth/hidp/core.c                          |    3 +-
 net/bridge/br_input.c                              |    3 +-
 net/ceph/auth_x.c                                  |    2 +-
 net/ceph/mon_client.c                              |    2 +-
 net/core/dev.c                                     |  195 ++--
 net/core/neighbour.c                               |   44 +
 net/core/skbuff.c                                  |    1 +
 net/dsa/slave.c                                    |    1 +
 net/ipv4/geneve.c                                  |    6 +-
 net/ipv4/ip_forward.c                              |    3 +-
 net/ipv4/ip_sockglue.c                             |    8 +-
 net/ipv4/netfilter/nft_redir_ipv4.c                |    8 +-
 net/ipv4/ping.c                                    |    5 +-
 net/ipv4/route.c                                   |    9 +-
 net/ipv4/tcp_output.c                              |    4 +-
 net/ipv4/udp_diag.c                                |    4 +-
 net/ipv6/datagram.c                                |   10 +-
 net/ipv6/ip6_fib.c                                 |   45 +-
 net/ipv6/netfilter/nft_redir_ipv6.c                |    8 +-
 net/ipv6/route.c                                   |   13 +-
 net/ipv6/tcp_ipv6.c                                |   45 +-
 net/ipv6/xfrm6_policy.c                            |   10 +-
 net/llc/sysctl_net_llc.c                           |    8 +-
 net/mac80211/key.c                                 |   12 +-
 net/mac80211/mlme.c                                |    2 +-
 net/mac80211/pm.c                                  |   29 +-
 net/mac80211/rx.c                                  |    2 +-
 net/mpls/mpls_gso.c                                |    5 +-
 net/netfilter/ipvs/ip_vs_ftp.c                     |   10 +-
 net/netfilter/nf_conntrack_core.c                  |   20 +-
 net/netfilter/nf_tables_api.c                      |   14 +-
 net/netfilter/nfnetlink.c                          |    7 +-
 net/netfilter/nft_nat.c                            |    8 +-
 net/netlink/af_netlink.c                           |   48 +-
 net/netlink/af_netlink.h                           |    9 +-
 net/netlink/genetlink.c                            |   64 +-
 net/openvswitch/actions.c                          |    3 +-
 net/openvswitch/datapath.c                         |    6 +-
 net/openvswitch/flow.c                             |    5 +-
 net/openvswitch/flow_netlink.c                     |   13 +-
 net/openvswitch/vport-geneve.c                     |    3 +
 net/openvswitch/vport-gre.c                        |   18 +-
 net/openvswitch/vport-vxlan.c                      |    2 +
 net/openvswitch/vport.c                            |    7 +-
 net/packet/af_packet.c                             |   13 +-
 net/sched/cls_bpf.c                                |   15 +-
 net/sctp/associola.c                               |    1 -
 net/sctp/socket.c                                  |    8 +-
 net/socket.c                                       |    3 -
 net/sunrpc/xdr.c                                   |    6 +-
 net/tipc/bcast.c                                   |    5 +-
 net/wireless/Kconfig                               |    2 +-
 net/wireless/nl80211.c                             |    9 +-
 net/wireless/reg.c                                 |   56 +-
 net/wireless/util.c                                |    6 +
 samples/bpf/test_maps.c                            |    4 +-
 scripts/Makefile.clean                             |   16 +-
 scripts/recordmcount.pl                            |    1 -
 security/keys/gc.c                                 |    4 +-
 sound/core/pcm_lib.c                               |   85 ++
 sound/core/seq/seq_dummy.c                         |   31 -
 sound/firewire/amdtp.c                             |   71 +-
 sound/firewire/amdtp.h                             |    5 +-
 sound/firewire/bebob/bebob_stream.c                |    7 -
 sound/firewire/fireworks/fireworks_stream.c        |    5 -
 sound/firewire/fireworks/fireworks_transaction.c   |    2 +-
 sound/pci/hda/hda_controller.c                     |   24 +-
 sound/pci/hda/hda_intel.c                          |    5 +-
 sound/pci/hda/hda_priv.h                           |    1 +
 sound/pci/hda/patch_hdmi.c                         |    2 +
 sound/pci/hda/patch_sigmatel.c                     |    4 +-
 sound/soc/Kconfig                                  |    1 +
 sound/soc/Makefile                                 |    1 +
 sound/soc/adi/axi-i2s.c                            |    2 +
 sound/soc/atmel/Kconfig                            |    2 +-
 sound/soc/atmel/atmel-pcm-dma.c                    |   12 +-
 sound/soc/atmel/atmel_ssc_dai.c                    |  132 ++-
 sound/soc/atmel/sam9g20_wm8731.c                   |   31 +-
 sound/soc/au1x/db1200.c                            |   19 +-
 sound/soc/au1x/dbdma2.c                            |    6 -
 sound/soc/au1x/dma.c                               |    6 -
 sound/soc/codecs/88pm860x-codec.c                  |    4 +-
 sound/soc/codecs/Kconfig                           |   10 +-
 sound/soc/codecs/Makefile                          |    2 +
 sound/soc/codecs/ad193x.c                          |    4 +-
 sound/soc/codecs/ak4671.c                          |    2 +-
 sound/soc/codecs/alc5623.c                         |    8 +-
 sound/soc/codecs/alc5632.c                         |   12 +-
 sound/soc/codecs/arizona.c                         |   78 +-
 sound/soc/codecs/arizona.h                         |    5 +
 sound/soc/codecs/bt-sco.c                          |    2 +-
 sound/soc/codecs/cs35l32.c                         |    4 +-
 sound/soc/codecs/cs42l52.c                         |    4 +-
 sound/soc/codecs/cs42l56.c                         |    4 +-
 sound/soc/codecs/cs42l73.c                         |    4 +-
 sound/soc/codecs/da732x.c                          |    4 +-
 sound/soc/codecs/max98357a.c                       |  138 +++
 sound/soc/codecs/mc13783.c                         |   10 +-
 sound/soc/codecs/pcm3008.c                         |    4 +-
 sound/soc/codecs/pcm512x-i2c.c                     |    4 +
 sound/soc/codecs/pcm512x-spi.c                     |    4 +
 sound/soc/codecs/pcm512x.c                         |  934 ++++++++++++++++-
 sound/soc/codecs/pcm512x.h                         |  109 +-
 sound/soc/codecs/rt286.c                           |   88 +-
 sound/soc/codecs/rt286.h                           |    7 +
 sound/soc/codecs/rt5631.c                          |   28 +-
 sound/soc/codecs/rt5640.c                          |   12 +-
 sound/soc/codecs/rt5645.c                          |  255 ++++-
 sound/soc/codecs/rt5645.h                          |   87 +-
 sound/soc/codecs/rt5651.c                          |   18 +-
 sound/soc/codecs/rt5670.c                          |  138 ++-
 sound/soc/codecs/rt5670.h                          |   80 +-
 sound/soc/codecs/rt5677.c                          |  270 ++++-
 sound/soc/codecs/sgtl5000.c                        |   27 +-
 sound/soc/codecs/sn95031.c                         |   33 +-
 sound/soc/codecs/sta32x.c                          |  534 ++++++----
 sound/soc/codecs/sta32x.h                          |    2 +-
 sound/soc/codecs/tlv320aic31xx.c                   |    9 +-
 sound/soc/codecs/tlv320aic3x.c                     |  349 +++++--
 sound/soc/codecs/tlv320dac33.c                     |    9 +-
 sound/soc/codecs/ts3a227e.c                        |   41 +-
 sound/soc/codecs/twl4030.c                         |   55 +-
 sound/soc/codecs/twl6040.c                         |    4 +-
 sound/soc/codecs/wm2000.c                          |    2 +-
 sound/soc/codecs/wm5100.c                          |    5 +-
 sound/soc/codecs/wm5102.c                          |   23 +-
 sound/soc/codecs/wm5110.c                          |   20 +-
 sound/soc/codecs/wm8350.c                          |    2 +-
 sound/soc/codecs/wm8400.c                          |    9 +-
 sound/soc/codecs/wm8731.c                          |    5 +-
 sound/soc/codecs/wm8750.c                          |    2 +-
 sound/soc/codecs/wm8770.c                          |    8 +-
 sound/soc/codecs/wm8804.c                          |    4 +-
 sound/soc/codecs/wm8900.c                          |    2 +-
 sound/soc/codecs/wm8903.c                          |    2 +-
 sound/soc/codecs/wm8904.c                          |   58 +-
 sound/soc/codecs/wm8955.c                          |    2 +-
 sound/soc/codecs/wm8958-dsp2.c                     |    2 +-
 sound/soc/codecs/wm8960.c                          |   53 +-
 sound/soc/codecs/wm8961.c                          |    4 +-
 sound/soc/codecs/wm8962.c                          |    6 +-
 sound/soc/codecs/wm8988.c                          |    6 +-
 sound/soc/codecs/wm8990.c                          |    9 +-
 sound/soc/codecs/wm8991.c                          |    9 +-
 sound/soc/codecs/wm8993.c                          |    2 +-
 sound/soc/codecs/wm8994.c                          |   23 +-
 sound/soc/codecs/wm8995.c                          |   20 +-
 sound/soc/codecs/wm8996.c                          |    8 +-
 sound/soc/codecs/wm8997.c                          |   11 +-
 sound/soc/codecs/wm9081.c                          |    2 +-
 sound/soc/codecs/wm9090.c                          |    2 +-
 sound/soc/codecs/wm9705.c                          |   16 +-
 sound/soc/codecs/wm9712.c                          |   12 +-
 sound/soc/codecs/wm9713.c                          |   14 +-
 sound/soc/codecs/wm_adsp.c                         |    6 +-
 sound/soc/codecs/wm_hubs.c                         |   10 +-
 sound/soc/davinci/Kconfig                          |    3 +-
 sound/soc/davinci/davinci-evm.c                    |    6 -
 sound/soc/davinci/davinci-mcasp.c                  |  103 +-
 sound/soc/dwc/Kconfig                              |    1 +
 sound/soc/dwc/designware_i2s.c                     |  360 +++++--
 sound/soc/fsl/eukrea-tlv320.c                      |   23 +-
 sound/soc/fsl/fsl_asrc.c                           |    5 +-
 sound/soc/fsl/fsl_asrc.h                           |    3 -
 sound/soc/fsl/fsl_esai.c                           |    2 +-
 sound/soc/fsl/fsl_esai.h                           |    2 +-
 sound/soc/fsl/fsl_sai.c                            |    2 +-
 sound/soc/fsl/fsl_spdif.c                          |   17 +-
 sound/soc/fsl/fsl_ssi.c                            |   10 +-
 sound/soc/fsl/fsl_utils.c                          |   27 -
 sound/soc/fsl/fsl_utils.h                          |    3 -
 sound/soc/fsl/imx-mc13783.c                        |    5 +-
 sound/soc/fsl/imx-spdif.c                          |    1 +
 sound/soc/fsl/imx-ssi.c                            |    5 +-
 sound/soc/fsl/imx-wm8962.c                         |    1 +
 sound/soc/fsl/mx27vis-aic32x4.c                    |   12 +-
 sound/soc/fsl/wm1133-ev1.c                         |   16 +-
 sound/soc/generic/simple-card.c                    |   41 +-
 sound/soc/intel/Kconfig                            |   15 +-
 sound/soc/intel/Makefile                           |    2 +
 sound/soc/intel/broadwell.c                        |   10 -
 sound/soc/intel/byt-rt5640.c                       |   12 +-
 sound/soc/intel/bytcr_dpcm_rt5640.c                |    1 -
 sound/soc/intel/cht_bsw_rt5645.c                   |  326 ++++++
 sound/soc/intel/cht_bsw_rt5672.c                   |   15 +-
 sound/soc/intel/sst-baytrail-pcm.c                 |    6 -
 sound/soc/intel/sst-dsp.c                          |    3 +-
 sound/soc/intel/sst-firmware.c                     |    3 +
 sound/soc/intel/sst-haswell-dsp.c                  |   17 +-
 sound/soc/intel/sst-haswell-ipc.c                  |  173 +---
 sound/soc/intel/sst-haswell-ipc.h                  |   31 -
 sound/soc/intel/sst-haswell-pcm.c                  |  167 +--
 sound/soc/intel/sst-mfld-platform-pcm.c            |    7 -
 sound/soc/intel/sst/sst.h                          |    3 +-
 sound/soc/intel/sst/sst_acpi.c                     |    9 +-
 sound/soc/intel/sst/sst_loader.c                   |    3 +-
 sound/soc/jz4740/jz4740-i2s.c                      |   21 +-
 sound/soc/mxs/mxs-saif.c                           |   10 +-
 sound/soc/mxs/mxs-saif.h                           |    1 -
 sound/soc/mxs/mxs-sgtl5000.c                       |   27 +-
 sound/soc/nuc900/nuc900-pcm.c                      |    6 -
 sound/soc/omap/ams-delta.c                         |   18 +-
 sound/soc/omap/omap-hdmi-audio.c                   |    1 -
 sound/soc/omap/omap-mcbsp.c                        |    2 +-
 sound/soc/omap/omap-twl4030.c                      |   20 +-
 sound/soc/omap/rx51.c                              |    8 +-
 sound/soc/pxa/Kconfig                              |    2 +-
 sound/soc/pxa/corgi.c                              |   16 +-
 sound/soc/pxa/e740_wm9705.c                        |   20 +-
 sound/soc/pxa/e750_wm9705.c                        |   20 +-
 sound/soc/pxa/hx4700.c                             |    8 +-
 sound/soc/pxa/magician.c                           |   21 +-
 sound/soc/pxa/mioa701_wm9713.c                     |    2 +-
 sound/soc/pxa/palm27x.c                            |   15 +-
 sound/soc/pxa/raumfeld.c                           |   35 +-
 sound/soc/pxa/spitz.c                              |   23 +-
 sound/soc/pxa/ttc-dkb.c                            |    4 -
 sound/soc/pxa/zylonite.c                           |   12 +-
 sound/soc/rockchip/rockchip_i2s.c                  |    9 +-
 sound/soc/rockchip/rockchip_i2s.h                  |    2 +-
 sound/soc/samsung/Kconfig                          |   15 +-
 sound/soc/samsung/Makefile                         |    2 -
 sound/soc/samsung/arndale_rt5631.c                 |    1 -
 sound/soc/samsung/goni_wm8994.c                    |  304 ------
 sound/soc/samsung/h1940_uda1380.c                  |   15 +-
 sound/soc/samsung/i2s.c                            |  362 ++++---
 sound/soc/samsung/jive_wm8750.c                    |   34 +-
 sound/soc/samsung/neo1973_wm8753.c                 |   25 +-
 sound/soc/samsung/odroidx2_max98090.c              |    6 +-
 sound/soc/samsung/rx1950_uda1380.c                 |   15 +-
 sound/soc/samsung/s3c24xx_simtec.c                 |   20 +-
 sound/soc/samsung/s3c24xx_uda134x.c                |   12 +-
 sound/soc/samsung/smartq_wm8987.c                  |   16 +-
 sound/soc/samsung/smdk_wm8580.c                    |   26 +-
 sound/soc/samsung/smdk_wm8580pcm.c                 |   19 +-
 sound/soc/samsung/smdk_wm8994pcm.c                 |   16 +-
 sound/soc/sh/dma-sh7760.c                          |    6 -
 sound/soc/sh/fsi.c                                 |   15 +-
 sound/soc/sh/migor.c                               |   12 +-
 sound/soc/sh/rcar/adg.c                            |   14 +-
 sound/soc/sh/rcar/core.c                           |  111 +-
 sound/soc/sh/rcar/dvc.c                            |   63 +-
 sound/soc/sh/rcar/gen.c                            |   15 +
 sound/soc/sh/rcar/rsnd.h                           |   81 +-
 sound/soc/sh/rcar/src.c                            |  269 +++--
 sound/soc/sh/rcar/ssi.c                            |  100 +-
 sound/soc/sh/siu_pcm.c                             |    1 -
 sound/soc/soc-ac97.c                               |   36 +-
 sound/soc/soc-compress.c                           |    9 +-
 sound/soc/soc-core.c                               |  223 +++--
 sound/soc/soc-dapm.c                               |  125 +--
 sound/soc/soc-devres.c                             |    2 +-
 sound/soc/soc-generic-dmaengine-pcm.c              |   15 +-
 sound/soc/soc-pcm.c                                |    7 +-
 sound/soc/tegra/Kconfig                            |   10 +
 sound/soc/tegra/Makefile                           |    2 +
 sound/soc/tegra/tegra_rt5677.c                     |  347 +++++++
 sound/soc/txx9/txx9aclc.c                          |    6 -
 sound/soc/ux500/mop500_ab8500.c                    |   16 +-
 sound/soc/xtensa/Kconfig                           |    7 +
 sound/soc/xtensa/Makefile                          |    3 +
 sound/soc/xtensa/xtfpga-i2s.c                      |  675 +++++++++++++
 sound/usb/caiaq/audio.c                            |    2 +-
 sound/usb/mixer.c                                  |    1 +
 tools/include/asm-generic/bitops.h                 |    2 +
 tools/include/asm-generic/bitops/arch_hweight.h    |    1 +
 tools/include/asm-generic/bitops/const_hweight.h   |    1 +
 tools/include/asm-generic/bitops/hweight.h         |    7 +
 tools/include/linux/bitops.h                       |    7 +-
 tools/lib/api/fs/debugfs.c                         |    2 +-
 tools/lib/api/fs/fs.c                              |    2 +-
 tools/lib/lockdep/preload.c                        |    4 +-
 tools/perf/MANIFEST                                |    6 +
 tools/perf/Makefile.perf                           |   11 +-
 tools/perf/arch/powerpc/util/skip-callchain-idx.c  |   19 +-
 tools/perf/bench/sched-pipe.c                      |    2 +-
 tools/perf/builtin-annotate.c                      |    2 +-
 tools/perf/builtin-diff.c                          |   46 +-
 tools/perf/builtin-list.c                          |   13 +-
 tools/perf/builtin-report.c                        |   24 +-
 tools/perf/builtin-top.c                           |    5 +-
 tools/perf/config/Makefile                         |    2 +-
 tools/perf/config/Makefile.arch                    |   26 +-
 tools/perf/perf-sys.h                              |    1 -
 tools/perf/scripts/perl/Perf-Trace-Util/Context.c  |    5 +-
 tools/perf/tests/dwarf-unwind.c                    |   36 +-
 tools/perf/tests/hists_cumulate.c                  |   66 +-
 tools/perf/tests/hists_filter.c                    |    2 +-
 tools/perf/tests/hists_output.c                    |   10 +-
 tools/perf/ui/browsers/hists.c                     |    2 +-
 tools/perf/ui/hist.c                               |    3 +
 tools/perf/ui/tui/setup.c                          |   26 +-
 tools/perf/util/annotate.c                         |   18 +-
 tools/perf/util/annotate.h                         |    8 +-
 tools/perf/util/cache.h                            |    2 +
 tools/perf/util/callchain.c                        |   30 +
 tools/perf/util/callchain.h                        |    2 +
 tools/perf/util/evlist.c                           |    2 +-
 tools/perf/util/hist.c                             |   18 +-
 tools/perf/util/hist.h                             |    2 +-
 tools/perf/util/hweight.c                          |   31 -
 tools/perf/util/include/asm/hweight.h              |    8 -
 tools/perf/util/machine.c                          |    4 +-
 tools/perf/util/map.h                              |   16 +
 tools/perf/util/probe-event.c                      |   44 +-
 tools/perf/util/probe-finder.c                     |   18 +-
 tools/perf/util/python-ext-sources                 |    2 +-
 tools/perf/util/symbol.c                           |   31 +-
 tools/perf/util/symbol.h                           |    1 +
 tools/perf/util/unwind-libunwind.c                 |   28 +-
 tools/power/cpupower/utils/cpupower.c              |    2 +-
 tools/power/cpupower/utils/helpers/sysfs.c         |    2 +-
 tools/testing/selftests/exec/execveat.c            |   23 +-
 tools/testing/selftests/mqueue/mq_perf_tests.c     |    3 +-
 tools/testing/selftests/vm/Makefile                |    2 +-
 virt/kvm/kvm_main.c                                |   26 +-
 1267 files changed, 17993 insertions(+), 11058 deletions(-)
 delete mode 100644 Documentation/ABI/testing/sysfs-platform-dell-laptop
 create mode 100644 Documentation/devicetree/bindings/arm/fw-cfg.txt
 create mode 100644 Documentation/devicetree/bindings/sound/cdns,xtfpga-i2s.txt
 create mode 100644 Documentation/devicetree/bindings/sound/designware-i2s.txt
 create mode 100644 Documentation/devicetree/bindings/sound/ingenic,jz4740-i2s.txt
 create mode 100644 Documentation/devicetree/bindings/sound/max98357a.txt
 create mode 100644 Documentation/devicetree/bindings/sound/nvidia,tegra-audio-rt5677.txt
 create mode 100644 Documentation/devicetree/bindings/sound/st,sta32x.txt
 delete mode 100644 arch/x86/tools/calc_run_size.pl
 create mode 100644 arch/x86/tools/calc_run_size.sh
 delete mode 100644 drivers/gpu/drm/amd/amdkfd/kfd_interrupt.c
 create mode 100644 drivers/hwmon/i5500_temp.c
 delete mode 100644 drivers/net/ethernet/s6gmac.c
 create mode 100644 drivers/thermal/int340x_thermal/processor_thermal_device.c
 create mode 100644 include/dt-bindings/sound/samsung-i2s.h
 create mode 100644 include/xen/interface/nmi.h
 create mode 100644 sound/soc/codecs/max98357a.c
 create mode 100644 sound/soc/intel/cht_bsw_rt5645.c
 delete mode 100644 sound/soc/samsung/goni_wm8994.c
 create mode 100644 sound/soc/tegra/tegra_rt5677.c
 create mode 100644 sound/soc/xtensa/Kconfig
 create mode 100644 sound/soc/xtensa/Makefile
 create mode 100644 sound/soc/xtensa/xtfpga-i2s.c
 create mode 100644 tools/include/asm-generic/bitops/arch_hweight.h
 create mode 100644 tools/include/asm-generic/bitops/const_hweight.h
 create mode 100644 tools/include/asm-generic/bitops/hweight.h
 delete mode 100644 tools/perf/util/hweight.c
 delete mode 100644 tools/perf/util/include/asm/hweight.h

--iBwuxWUsK/REspAd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU2F8bAAoJECTWi3JdVIfQyj8H/1D4uarHgCrkDT9h1Z28XpD9
G58vwt9jxN3gYrWRwAH3a1ppU8YwcX+/FGxdAen3F0ooGYe65bgKrLL6EsI4s6XK
CBmwHfb3A12cW4+99TRVnC9SzTFNKWc1qLxun6xGvo8pd+vA0q2ImUeYie2+f1Wv
zwmu2jme0wrusc+onQXk8NqdTnxJCPff1PgeCG4EoOz6asfq+M3x2ULvvIdOv00a
OzT+bKnNVQG4JN6Up3D2SxDbFJEO+DE3HXmrfA4VuyT2R4guSg3UAg+qYgrqGkPB
JaBfhaojhSfoM8NHZ8zmp8QoL0nQ0LfyVPppBSRP8rQT/Y8m/7N5t4gAYXjtXVw=
=4HBH
-----END PGP SIGNATURE-----

--iBwuxWUsK/REspAd--

--===============8345031961775606669==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8345031961775606669==--
