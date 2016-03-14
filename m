From: Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] ASoC updates for v4.6
Date: Mon, 14 Mar 2016 11:45:42 +0000
Message-ID: <20160314114542.GB3683@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1589416065007799639=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 2501526078A
 for <alsa-devel@alsa-project.org>; Mon, 14 Mar 2016 12:45:53 +0100 (CET)
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


--===============1589416065007799639==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="V0207lvV8h4k8FAm"
Content-Disposition: inline


--V0207lvV8h4k8FAm
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The following changes since commit f6cede5b49e822ebc41a099fe41ab4989f64e2cb:

  Linux 4.5-rc7 (2016-03-06 14:48:03 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc=
-v4.6

for you to fetch changes up to d4a6360f19c1c551afcba42be98df04651fab31b:

  Merge remote-tracking branches 'asoc/topic/sunxi', 'asoc/topic/topology' =
and 'asoc/topic/wm8974' into asoc-next (2016-03-13 15:17:56 +0700)

----------------------------------------------------------------
ASoC: Updates for v4.6

The main thing in terms of the core this time around has been some
additional framework work for dynamic topologies (though we *still*
don't appear to have a stable ABI for the topology code, it's probably
worth considering if this will ever happen...).  Otherwise the work has
almost all been in the drivers:

 - HDMI support for Sky Lake, along with other fixes and enhancements
   for the Intel drivers.
 - Lots of improvements to the Renesas drivers.
 - Capture support for Qualcomm drivers.
 - Support for TI DaVinci DRA7xxx devices.
 - New machine drivers for Freescale systems with Cirrus CODECs,
   Mediatek systems with RT5650 CODECs.
 - New CPU drivers for Allwinner S/PDIF controllers
 - New CODEC drivers for Maxim MAX9867 and MAX98926 and Realtek RT5514.

----------------------------------------------------------------
Alan Cox (1):
      ASoC: Intel: Skylake: remove bogus comparison of an array with NULL

Andreas Irest=E5l (4):
      ASoC: adau17x1: Cache writes when core clock is disabled
      ASoC: adau17x1: Correct typos in file headers
      ASoC: adau17x1: Add adau17x1 bindings document
      ASoC: adau17x1: Add basic DT support for adau17x1

Andrzej Hajda (1):
      ASoC: max9867: fix type of variable containing error codes

Antonio Ospite (1):
      ASoC: rk3036: fix missing dependency on REGMAP_MMIO

Arnd Bergmann (3):
      ASoC: s3c24xx: use const snd_soc_component_driver pointer
      ASoC: pxa: remove unused variable
      ASoC: rockchip: use __maybe_unused to hide st_irq_syscfg_resume

Axel Lin (7):
      ASoC: rt5659: Staticise rt5659_i2c_shutdown
      ASoC: max98926: Fix blr_clk_ratio calculation
      ASoC: max98926: Constify max98926_reg and max98926_regmap
      ASoC: max9867: Add CONFIG_SND_SOC_MAX9867 to build
      ASoC: max9867: Make max9867_i2c_id NULL terminated
      ASoC: max9867: Constify max9867_reg and max9867_regmap
      ASoC: max9867: Use params_width instead of open-coded

Bard Liao (4):
      ASoC: rt298: enable IRQ for jack detection
      ASoC: rt298: Don't enable IRQ in i2c_probe
      ASoC: rt5640: Set PLL src according to source
      ASoC: rt5640: add supplys for dac power

Caesar Wang (4):
      ASoC: rt5616: add mclk property for rt5616 document
      ASoC: rt5616: trivial: fix the typo
      ASoC: rt5616: add the mclk for the codec driver
      ASoC: rt5616: allow to build with CONFIG_SND_SOC_RT5616

Carlo Caione (1):
      ASoC: cht_bsw_rt5645: Enable jack detection

Charles Keepax (14):
      ASoC: wm5110: Fix up snd_soc_register_platform error path
      ASoC: wm_adsp: Use more generic naming for regions and caps definitio=
ns
      ASoC: wm_adsp: Add debug audio trace firmware
      ASoC: wm_adsp: Move setting of DSP speed into CODEC specific code
      ASoC: wm5110: Add support for audio trace firmware
      ASoC: wm5102: Add support for the audio trace firmware
      ASoC: wm_adsp: Add missing const from region definitions
      ASoC: wm_adsp: Return sample rate in wm_adsp_compr_pointer
      ASoC: arizona: Add support for SNDRV_PCM_RATE_KNOT
      ASoC: wm_adsp: Avoid narrow race condition on compr pointer
      ASoC: wm_adsp: Explicitly set the control access flags in all cases
      ASoC: wm_adsp: Fixup some odd line wrapping
      ASoC: wm_adsp: wm_coeff_{read|write}_control should use passed length
      ASoC: wm_adsp: Use correct local length in error message

Damien.Horsley (1):
      ASoC: pcm3168a: Call clk_set_rate in pcm3168a_set_dai_sysclk

Dan Carpenter (1):
      ASoC: max9867: silence and array overflow warning

Dharageswari.R (3):
      ASoC: Intel: Skylake: Get node id using helper
      ASoC: Intel: Skylake: Add skl_tplg_be_get_cpr_module() helper
      ASoC: Intel: Skylake: Add MCLK configuration

Fabio Estevam (1):
      ASoC: hdac_hdmi: Remove 'edev' NULL check

Felipe F. Tonello (1):
      ASoC: fsl-asoc-card: add cs4271 and cs4272 support

Florian Vaussard (2):
      ASoC: ads117x: Add bindings documentation for TI ADS117x ADC
      ASoC: ads117x: Add device tree compatible string

Jacob Siverskog (3):
      ASoC: pcm179x: Split into core and SPI parts
      ASoC: pcm179x: Add I2C interface driver
      ASoC: pcm179x: Support continuous rates

Jayachandran B (1):
      ASoC: Intel: Skylake: Unstatify skl_dsp_enable_core

Jeeja KP (16):
      ASoC: Intel: Skylake: Allow module parameter set after bind
      ASoC: Intel: Skylake: Add shutdown callback
      ASoC: Intel: Skylake: Fill BE blob with default params
      ASoC: hdac_hdmi: Add jack reporting
      ASoC: hdac_hdmi: Add PM support
      ASoC: Intel: boards: Enable HDMI and DP on skl_rt286 machine
      ASoC: Intel: boards: Enable HDMI and DP on nau88l2 machine
      ASoC: Intel: boards: Remove WoV sink in skl_rt286
      ASoC: Intel: boards: Remove WoV sink in nau88125_ssm4567 machine
      ASoC: Intel: boards: Remove WoV sink in nau88125_max98357a machine
      ASoC: Intel: Skylake: correct direction in blob query
      ASoC: Intel: Skylake: Add IVI feedback path in nau88125_ssm4567 machi=
ne
      ASoC: Intel: Skylake: remove IVI codec loop in skl_nau88l25_ssm4567 m=
achine
      ASoC: Intel: add dmabuffer to common sst_dsp
      ASoC: Intel: Skylake: Move Skylake dsp ops & loader ops
      ASoC: hdac_hdmi: Add broxton device ID

Jianqun Xu (1):
      ASoC: rockchip: add bindings for rk3399 i2s

John Hsu (1):
      ASoC: nau8825: fix issue that pop noise when start playback

John Lin (3):
      ASoC: rt5645: improve headphone pop when system resumes from S3
      ASoC: rt5645: extend delay time for headphone pop noise
      ASoC: rt5616: add missing mute control for HPVOL

Koro Chen (3):
      ASoC: mediatek: Add machine driver for ALC5650 codec
      ASoC: mediatek: Add I03/I04 widgets and corresponding routes
      ASoC: mediatek: Add machine driver for rt5650 rt5514 codec

Kuninori Morimoto (59):
      ASoC: rsnd: remove unsed *parent
      ASoC: rsnd: use rsnd_mod_init() for ADG
      ASoC: rsnd: add debug message for rsnd_mod_call()
      ASoC: rsnd: don't update status if rsnd_mod_call() doesn't match
      ASoC: rsnd: try to connect connected mod is not error
      ASoC: rsnd: always call probe/remove for MUX
      ASoC: rsnd: don't overwrite io on rsnd_cmd_init()
      ASoC: rsnd: select each SRC correctly for CMD data path
      ASoC: rsnd: each mod has status again for CTU/MUX support
      ASoC: rsnd: attach Audio-DMAC-periperi correctly
      ASoC: rsnd: ctu: add rsnd_mix_activation()
      ASoC: rsnd: ctu: add rsnd_ctu_halt()
      ASoC: rsnd: ctu: settings matches to datasheet
      ASoC: rsnd: tidyup Playback/Capture sequence
      ASoC: rsnd: disable SRC.out/in in same time
      ASoC: rsnd: don't auto-recover when under/over run error
      ASoC: rsnd: add .irq callback
      ASoC: soc-pcm: copy dpcm->hw_params and call be_hw_params_fixup every=
 time
      ASoC: rsnd: rsnd_ssi_is_multi_slave() macro uses rsnd_ssi_multi_slave=
s()
      ASoC: rsnd: rename RSND_DVC_CHANNELS to RSND_MAX_CHANNELS
      ASoC: rsnd: setup SRC_ROUTE_MODE0 before SRC_SRCIR
      ASoC: rsnd: indicates status failed SSI
      ASoC: rsnd: SSI function parameter uses "mod" instead of "ssi"
      ASoC: rsnd: fixup forever loop bug on SSI
      ASoC: rsnd: add missing .irq callback for DMA
      ASoC: rsnd: tidyup SSI init/start sequence
      ASoC: rsnd: Parent SSI attach is not needed if not clock master
      ASoC: rsnd: move rsnd_ssi_irq() position
      ASoC: rsnd: judge multi SSI in runtime
      ASoC: rsnd: judge work SSI in runtime
      regmap: add regmap_update_bits_base()
      regmap: merge regmap_update_bits() into macro
      regmap: merge regmap_update_bits_async() into macro
      regmap: merge regmap_update_bits_check() into macro
      regmap: merge regmap_update_bits_check_async() into macro
      regmap: add regmap_field_update_bits_base()
      regmap: merge regmap_field_write() into macro
      regmap: merge regmap_field_update_bits() into macro
      regmap: add regmap_fields_update_bits_base()
      regmap: merge regmap_fields_write() into macro
      regmap: merge regmap_fields_update_bits() into macro
      regmap: add regmap_field_force_xxx() macros
      regmap: add regmap_fields_force_xxx() macros
      ASoC: rsnd: rsnd_write() / rsnd_bset() uses regmap _force_ function
      ASoC: rsnd: don't call update callback if it was NULL
      ASoC: rsrc-card: add convert channels support
      ASoC: rsnd: tidyup rsnd_ssiu_init_gen2()
      ASoC: rsnd: add CTU basic support
      ASoC: rsnd: add rsnd_runtime_channel_xxx()
      ASoC: rsnd: add CTU support
      ASoC: rsrc-card: tidyup convert-channels explain
      ASoC: rsnd: don't enable SRC Sync mode when Capture with CMD
      ASoC: rsnd: SRC sync mode is not related to clock master mode
      ASoC: rsnd: SRC function parameter uses "mod" instead of "src"
      ASoC: rsnd: rename rsnd_enable_sync_convert() to rsnd_src_sync_is_ena=
bled()
      ASoC: rsnd: add rsnd_src_get_in/out_rate()
      ASoC: rsnd: SRC TIMSEL support for Capture
      ASoC: rsnd: CMD TIMSEL support for Capture
      ASoC: rsnd: add simplified module explanation

Lars-Peter Clausen (1):
      ASoC: ssm4567: Reset device before regcache_sync()

Lukas Wunner (1):
      ASoC: Intel: Use acpi_dev_present()

Maciej S. Szmigiero (1):
      ASoC: fsl_ssi: remove explicit register defaults

Mans Rullgard (2):
      ASoC: wm8974: configure pll and mclk divider automatically
      ASoC: mxs-saif: check BUSY bit in hw_params() only if not mclk_in_use

Marcus Cooper (2):
      ASoC: sunxi: add sun4i SPDIF transceiver
      ASoC: sunxi: Add support for the SPDIF block

Mark Brown (31):
      regmap: Add explict native endian flag to DT bindings
      MIPS: dt: Explicitly specify native endian behaviour for syscon
      regmap: mmio: Convert to regmap_bus and fix accessor usage
      regmap: Return an error if a caller attempts to do an unsupported raw=
 read
      regmap: cache: Fall back to register by register read for cache defau=
lts
      Merge branch 'fix/mmio' of git://git.kernel.org/.../broonie/regmap in=
to regmap-mmio
      Merge branch 'fix/intel' of git://git.kernel.org/.../broonie/sound in=
to asoc-intel
      Merge branch 'topic/drm' of git://git.kernel.org/.../broonie/sound in=
to asoc-hdac
      Merge tag 'asoc-fix-v4.5-rc4' into asoc-qcom
      Merge branch 'topic/mmio' of git://git.kernel.org/.../broonie/regmap =
into asoc-fsl-ssl
      Merge tag 'v4.5-rc5' into asoc-mtk
      Merge branch 'topic/hdac' of git://git.kernel.org/.../broonie/sound i=
nto asoc-intel
      Merge branch 'topic/update-bits' of git://git.kernel.org/.../broonie/=
regmap into asoc-rcar
      Merge tag 'asoc-fix-v4.5-rc6' into asoc-linus
      Merge remote-tracking branch 'asoc/topic/core' into asoc-next
      Merge remote-tracking branch 'asoc/topic/core-pcm' into asoc-next
      Merge remote-tracking branch 'asoc/topic/dapm' into asoc-next
      Merge remote-tracking branch 'asoc/topic/intel' into asoc-next
      Merge remote-tracking branch 'asoc/topic/pcm' into asoc-next
      Merge remote-tracking branch 'asoc/topic/pcm179x' into asoc-next
      Merge remote-tracking branch 'asoc/topic/pcm3168a' into asoc-next
      Merge remote-tracking branch 'asoc/topic/rt5645' into asoc-next
      Merge remote-tracking branches 'asoc/topic/ab8500', 'asoc/topic/adau1=
7x1', 'asoc/topic/ads117x', 'asoc/topic/adsp' and 'asoc/topic/arizona' into=
 asoc-next
      Merge remote-tracking branches 'asoc/topic/atmel', 'asoc/topic/bcm283=
5' and 'asoc/topic/cs42xx8' into asoc-next
      Merge remote-tracking branches 'asoc/topic/davinci', 'asoc/topic/fsl-=
card' and 'asoc/topic/fsl-mpc5200' into asoc-next
      Merge remote-tracking branches 'asoc/topic/fsl-sai', 'asoc/topic/fsl-=
ssl', 'asoc/topic/hdac' and 'asoc/topic/max9867' into asoc-next
      Merge remote-tracking branches 'asoc/topic/max98926', 'asoc/topic/mtk=
', 'asoc/topic/mxs-saif', 'asoc/topic/nau8825' and 'asoc/topic/omap' into a=
soc-next
      Merge remote-tracking branches 'asoc/topic/pxa' and 'asoc/topic/qcom'=
 into asoc-next
      Merge remote-tracking branches 'asoc/topic/rcar', 'asoc/topic/rockchi=
p', 'asoc/topic/rt298', 'asoc/topic/rt5514' and 'asoc/topic/rt5616' into as=
oc-next
      Merge remote-tracking branches 'asoc/topic/rt5640', 'asoc/topic/rt565=
9', 'asoc/topic/samsung' and 'asoc/topic/ssm4567' into asoc-next
      Merge remote-tracking branches 'asoc/topic/sunxi', 'asoc/topic/topolo=
gy' and 'asoc/topic/wm8974' into asoc-next

Martin Sperl (1):
      ASoC: bcm2835: move to use the clock framework

Mengdong Lin (4):
      ALSA: pcm: Add snd_pcm_rate_range_to_bits()
      ASoC: topology: Add FE DAIs dynamically
      ASoC: topology: Add FE DAI links dynamically
      ASoC: topology: Fix setting of stream rates, rate_min and rate_max

Nicolin Chen (1):
      ASoC: fsl-asoc-card: Don't add DAPM routes for ASRC if it doesn't exi=
st

Oder Chiou (1):
      ASoC: rt5514: add rt5514 codec driver

PC Liao (2):
      ASoC: mediatek: Enable 33bit memory address to support 4GB DRAM
      ASoC: mediatek: remove soft reset and add second I2S clock

Peter Ujfalusi (4):
      ASoC: davinci-mcasp: Discourage use of fck_parent for clock reparenti=
ng
      ASoC: davinci-mcasp: dai format runtime reconfiguration
      ASoC: davinci: Kconfig: Update the edma-pcm section's dependency and =
help
      ASoC: omap-hdmi-audio: Support for DRA7xx family

Philipp Zabel (1):
      ASoC: mediatek: address dai link array entries by enum

Pierre-Louis Bossart (5):
      ASoC: Intel: common: filter ACPI devices with _STA return value
      ASoC: Intel: common: add translation from HID to codec-name
      ASoC: Intel: bytcr_rt5640: change quirk position
      ASoC: Intel: bytcr_rt5640: use HID translation util
      ASoC: Intel: Atom: add support for CHT w/ RT5640

Rajan Vaja (1):
      ASoC: dapm: Remove unneeded variable ret returning 0

Ramesh Babu (1):
      ASoC: hdac_hdmi: Fix to keep codec power active during enumeration.

Richard Fitzgerald (2):
      ASoC: cs47l24: Add voice control compressed stream
      ASoC: arizona: Make logging of FLL calculations clearer

Sathya Prakash M R (1):
      ASoC: Intel: boards: Add IV feedback route for nau88l25_ssm4567 machi=
ne

Sathyanarayana Nujella (1):
      ASoC: Intel: boards: Enable HDMI and DP on SKL nau88l25_max98357 mach=
ine

Senthilnathan Veppur (1):
      ASoC: Intel: Bxtn: Add Broxton PCI ID

Songjun Wu (1):
      ASoC: atmel_ssc_dai: distinguish the different SSC

Srinivas Kandagatla (14):
      ASoC: qcom: use snd_dma_alloc/free* apis
      ASoC: qcom: add wrdma register details to lpass_variant
      ASoC: qcom: rename rdmactl_audif_start to dmactrl_audif_start
      ASoC: qcom: pass direction to dma allocation
      ASoC: qcom: ipq806x: add error in dma allocation.
      ASoC: qcom: rename rdma_ch_bit_map to dma_ch_bit_map
      ASoC: qcom: ipq806x: add wrdma related register offsets
      ASoC: qcom: add mic related i2s control register defines
      ASoC: qcom: add wrdma register definitions
      ASoC: qcom: add generic bit masks for RDMA and WRDMA
      ASoC: qcom: apq8016: set the correct max register for regmap
      ASoC: qcom: add mic support
      ASoC: qcom: apq8016-sbc: add mic support
      ASoC: qcom: apq8016: add wrdma support

Stephen Boyd (1):
      ASoC: qcom: Don't specify LE device endianness

Subhransu S. Prusty (15):
      ASoC: hdac_hdmi: Add hotplug notification and read ELD
      ASoC: hdac_hdmi: Apply constraints based on ELD
      drm/edid: Add API to help find connection type
      ASoC: hdac_hdmi: Enable DP1.2 and all converters/pins
      ASoC: hdac_hdmi: create dais based on number of cvts
      ASoC: hdac_hdmi: Create widget/route based on nodes enumerated
      ASoC: hdac_hdmi: Enable playback on all enumerated ports
      ASoC: hdac_hdmi: Add infoframe support for dp audio
      ASoC: hdac_hdmi: Fix possible memory leak in hw_params
      ASoC: hdac_hdmi: Don't fail in dai startup to make userland happy
      ASoC: hdac_hdmi: Fix to reconfigure registers in runtime resume
      ASoC: Intel: Skylake: Fix possible memory corruption in codec dai dma=
 params
      ASoC: Intel: Skylake: Add HDMI FE and BE cpu dais
      ASoC: hdac_hdmi: Fix to wait for D3 before powering off codec
      ASoC: hdac_hdmi: Fix infoframe programming

Sudip Mukherjee (6):
      ASoC: topology: fix build warning
      ASoC: fix memory leak
      ASoC: intel: remove unused variable
      ASoC: pcm3168a: remove unused variable
      ASoC: rt5640: remove unused variable
      ASoC: qcom: fix build error

Sugar Zhang (3):
      ASoC: rockchip: i2s: add default values for registers
      ASoC: rt5640: add master clock handling for rt5640
      ASoC: rockchip: add bindings for spdif controller

Vinod Koul (5):
      ASoC: Intel: Skylake: Update the delay check
      ASoC: Intel: Skylake: Generate topology name for NHLT table header
      ASoC: Intel: Skylake: Add i915 enabling in skl probe
      ASoC: Intel: Skylake: Move module id defines
      ASoC: Intel: Skylake: Fix whitepsace issues

Wolfram Sang (2):
      ASoC: sh: rcar: core: don't open code of_device_get_match_data()
      ASoC: sh: rcar: rsrc-card: don't open code of_device_get_match_data()

Xing Zheng (1):
      ASoC: rt5616: Add support sample rate to 192KHz

Xiubo Li (3):
      ASoC: ab8500: remove the useless 'break' after 'return'
      ASoC: fsl_sai: Use usleep_range() instead of msleep()
      ASoC: fsl-mpc5200: Use usleep_range() instead of msleep()

Zidan Wang (1):
      ASoC: cs42xx8: fix the noise in the right dac channel with mono playb=
ack

anish kumar (3):
      ASoC: Add max98926 codec driver
      ASoC: Add max9867 codec driver
      ASoC: max9867: Changed the if-else case to switch case

 .../devicetree/bindings/regmap/regmap.txt          |   11 +-
 .../devicetree/bindings/sound/adi,adau17x1.txt     |   24 +
 .../devicetree/bindings/sound/fsl-asoc-card.txt    |    9 +
 .../devicetree/bindings/sound/max9867.txt          |   17 +
 .../devicetree/bindings/sound/max98926.txt         |   32 +
 .../bindings/sound/mt8173-rt5650-rt5514.txt        |   15 +
 .../devicetree/bindings/sound/mt8173-rt5650.txt    |   15 +
 .../devicetree/bindings/sound/pcm179x.txt          |   11 +-
 .../devicetree/bindings/sound/renesas,rsnd.txt     |  340 ++++++
 .../bindings/sound/renesas,rsrc-card.txt           |    1 +
 .../devicetree/bindings/sound/rockchip-i2s.txt     |    1 +
 .../devicetree/bindings/sound/rockchip-spdif.txt   |    8 +-
 Documentation/devicetree/bindings/sound/rt5514.txt |   25 +
 Documentation/devicetree/bindings/sound/rt5616.txt |    6 +
 Documentation/devicetree/bindings/sound/rt5640.txt |    3 +
 .../bindings/sound/sunxi,sun4i-spdif.txt           |   39 +
 .../devicetree/bindings/sound/ti,ads117x.txt       |   11 +
 arch/mips/boot/dts/brcm/bcm6328.dtsi               |    2 +-
 arch/mips/boot/dts/brcm/bcm6368.dtsi               |    2 +-
 arch/mips/boot/dts/brcm/bcm7125.dtsi               |    2 +-
 arch/mips/boot/dts/brcm/bcm7346.dtsi               |    2 +-
 arch/mips/boot/dts/brcm/bcm7358.dtsi               |    2 +-
 arch/mips/boot/dts/brcm/bcm7360.dtsi               |    2 +-
 arch/mips/boot/dts/brcm/bcm7362.dtsi               |    2 +-
 arch/mips/boot/dts/brcm/bcm7420.dtsi               |    2 +-
 arch/mips/boot/dts/brcm/bcm7425.dtsi               |    2 +-
 arch/mips/boot/dts/brcm/bcm7435.dtsi               |    2 +-
 drivers/base/regmap/regcache.c                     |   41 +-
 drivers/base/regmap/regmap-mmio.c                  |  259 +++--
 drivers/base/regmap/regmap.c                       |  211 +---
 drivers/misc/atmel-ssc.c                           |    1 +
 include/drm/drm_edid.h                             |   12 +
 include/linux/platform_data/adau17x1.h             |    2 +-
 include/linux/regmap.h                             |   85 +-
 include/sound/pcm.h                                |    2 +
 include/sound/soc-topology.h                       |   21 +-
 include/sound/soc.h                                |    2 +-
 include/trace/events/asoc.h                        |    8 +-
 sound/core/pcm_misc.c                              |   30 +
 sound/soc/atmel/atmel_ssc_dai.c                    |   27 +-
 sound/soc/bcm/bcm2835-i2s.c                        |  284 +----
 sound/soc/codecs/Kconfig                           |   38 +-
 sound/soc/codecs/Makefile                          |   10 +
 sound/soc/codecs/ab8500-codec.c                    |    9 +-
 sound/soc/codecs/adau1761-i2c.c                    |   14 +-
 sound/soc/codecs/adau1761-spi.c                    |   14 +-
 sound/soc/codecs/adau1761.c                        |   10 +-
 sound/soc/codecs/adau1781-i2c.c                    |   10 +
 sound/soc/codecs/adau1781-spi.c                    |   10 +
 sound/soc/codecs/adau1781.c                        |    2 +-
 sound/soc/codecs/adau17x1.h                        |    6 +-
 sound/soc/codecs/ads117x.c                         |   12 +
 sound/soc/codecs/arizona.c                         |   71 +-
 sound/soc/codecs/arizona.h                         |    4 +-
 sound/soc/codecs/cs42l51.c                         |    8 +-
 sound/soc/codecs/cs42xx8.c                         |   10 +-
 sound/soc/codecs/cs47l24.c                         |  123 +-
 sound/soc/codecs/da732x.c                          |    8 +-
 sound/soc/codecs/hdac_hdmi.c                       | 1219 ++++++++++++++++=
++--
 sound/soc/codecs/hdac_hdmi.h                       |    6 +
 sound/soc/codecs/max98088.c                        |    2 +-
 sound/soc/codecs/max98095.c                        |    4 +-
 sound/soc/codecs/max9867.c                         |  546 +++++++++
 sound/soc/codecs/max9867.h                         |   83 ++
 sound/soc/codecs/max98926.c                        |  606 ++++++++++
 sound/soc/codecs/max98926.h                        |  848 ++++++++++++++
 sound/soc/codecs/nau8825.c                         |  169 ++-
 sound/soc/codecs/nau8825.h                         |   16 +-
 sound/soc/codecs/pcm179x-i2c.c                     |   73 ++
 sound/soc/codecs/pcm179x-spi.c                     |   72 ++
 sound/soc/codecs/pcm179x.c                         |   56 +-
 sound/soc/codecs/pcm179x.h                         |    9 +-
 sound/soc/codecs/pcm3168a.c                        |    8 +-
 sound/soc/codecs/rt298.c                           |    7 +-
 sound/soc/codecs/rt298.h                           |    8 +
 sound/soc/codecs/rt5514.c                          |  982 ++++++++++++++++
 sound/soc/codecs/rt5514.h                          |  252 ++++
 sound/soc/codecs/rt5616.c                          |  414 ++++---
 sound/soc/codecs/rt5640.c                          |   91 +-
 sound/soc/codecs/rt5640.h                          |    2 +
 sound/soc/codecs/rt5645.c                          |   15 +-
 sound/soc/codecs/rt5659.c                          |    2 +-
 sound/soc/codecs/ssm4567.c                         |    5 +
 sound/soc/codecs/tlv320dac33.c                     |    9 +-
 sound/soc/codecs/wl1273.c                          |   13 +-
 sound/soc/codecs/wm5102.c                          |   93 +-
 sound/soc/codecs/wm5110.c                          |   75 +-
 sound/soc/codecs/wm8753.c                          |    6 +-
 sound/soc/codecs/wm8904.c                          |    4 +-
 sound/soc/codecs/wm8958-dsp2.c                     |    8 +-
 sound/soc/codecs/wm8974.c                          |   93 ++
 sound/soc/codecs/wm8983.c                          |   14 +-
 sound/soc/codecs/wm8985.c                          |   14 +-
 sound/soc/codecs/wm8994.c                          |    4 +-
 sound/soc/codecs/wm8996.c                          |    2 +-
 sound/soc/codecs/wm8997.c                          |    2 +-
 sound/soc/codecs/wm8998.c                          |    2 +-
 sound/soc/codecs/wm9081.c                          |    8 +-
 sound/soc/codecs/wm9713.c                          |    2 +-
 sound/soc/codecs/wm_adsp.c                         |  139 ++-
 sound/soc/codecs/wm_adsp.h                         |    8 +-
 sound/soc/davinci/Kconfig                          |    3 +-
 sound/soc/davinci/davinci-mcasp.c                  |   12 +
 sound/soc/fsl/Kconfig                              |    4 +-
 sound/soc/fsl/fsl-asoc-card.c                      |   26 +-
 sound/soc/fsl/fsl_sai.c                            |    3 +-
 sound/soc/fsl/mpc5200_psc_ac97.c                   |    3 +-
 sound/soc/intel/Kconfig                            |    4 +
 sound/soc/intel/atom/sst/sst_acpi.c                |    4 +
 sound/soc/intel/atom/sst/sst_ipc.c                 |    2 -
 sound/soc/intel/boards/bytcr_rt5640.c              |   50 +-
 sound/soc/intel/boards/cht_bsw_max98090_ti.c       |   17 +-
 sound/soc/intel/boards/cht_bsw_rt5645.c            |   34 +-
 sound/soc/intel/boards/mfld_machine.c              |   16 +-
 sound/soc/intel/boards/skl_nau88l25_max98357a.c    |  122 +-
 sound/soc/intel/boards/skl_nau88l25_ssm4567.c      |  130 ++-
 sound/soc/intel/boards/skl_rt286.c                 |  113 +-
 sound/soc/intel/common/sst-acpi.h                  |    3 +
 sound/soc/intel/common/sst-dsp-priv.h              |    1 +
 sound/soc/intel/common/sst-match-acpi.c            |   45 +-
 sound/soc/intel/skylake/skl-messages.c             |  124 +-
 sound/soc/intel/skylake/skl-nhlt.c                 |   34 +
 sound/soc/intel/skylake/skl-pcm.c                  |  106 +-
 sound/soc/intel/skylake/skl-sst-dsp.c              |   14 +-
 sound/soc/intel/skylake/skl-sst-dsp.h              |    7 +-
 sound/soc/intel/skylake/skl-sst.c                  |    3 -
 sound/soc/intel/skylake/skl-topology.c             |  210 +++-
 sound/soc/intel/skylake/skl-topology.h             |   27 +
 sound/soc/intel/skylake/skl-tplg-interface.h       |    3 +-
 sound/soc/intel/skylake/skl.c                      |   88 ++
 sound/soc/intel/skylake/skl.h                      |   15 +-
 sound/soc/mediatek/Kconfig                         |   22 +-
 sound/soc/mediatek/Makefile                        |    2 +
 sound/soc/mediatek/mt8173-rt5650-rt5514.c          |  258 +++++
 sound/soc/mediatek/mt8173-rt5650-rt5676.c          |   18 +-
 sound/soc/mediatek/mt8173-rt5650.c                 |  236 ++++
 sound/soc/mediatek/mtk-afe-common.h                |    1 +
 sound/soc/mediatek/mtk-afe-pcm.c                   |   47 +-
 sound/soc/mxs/mxs-saif.c                           |    2 +-
 sound/soc/omap/n810.c                              |   18 +-
 sound/soc/omap/omap-hdmi-audio.c                   |    1 +
 sound/soc/omap/rx51.c                              |   18 +-
 sound/soc/pxa/brownstone.c                         |    2 -
 sound/soc/pxa/corgi.c                              |   12 +-
 sound/soc/pxa/magician.c                           |    6 +-
 sound/soc/pxa/poodle.c                             |   12 +-
 sound/soc/pxa/spitz.c                              |   12 +-
 sound/soc/pxa/tosa.c                               |   12 +-
 sound/soc/qcom/Kconfig                             |    7 +-
 sound/soc/qcom/apq8016_sbc.c                       |   10 +-
 sound/soc/qcom/lpass-apq8016.c                     |   31 +-
 sound/soc/qcom/lpass-cpu.c                         |  147 ++-
 sound/soc/qcom/lpass-ipq806x.c                     |   11 +-
 sound/soc/qcom/lpass-lpaif-reg.h                   |  116 +-
 sound/soc/qcom/lpass-platform.c                    |  244 ++--
 sound/soc/qcom/lpass.h                             |   10 +-
 sound/soc/rockchip/rockchip_i2s.c                  |   13 +
 sound/soc/rockchip/rockchip_spdif.c                |   17 +-
 sound/soc/samsung/i2s.c                            |   21 +-
 sound/soc/samsung/s3c-i2s-v2.c                     |    2 +-
 sound/soc/samsung/s3c-i2s-v2.h                     |    2 +-
 sound/soc/sh/rcar/adg.c                            |  218 ++--
 sound/soc/sh/rcar/cmd.c                            |   18 +-
 sound/soc/sh/rcar/core.c                           |  160 ++-
 sound/soc/sh/rcar/ctu.c                            |  281 ++++-
 sound/soc/sh/rcar/dma.c                            |   56 +-
 sound/soc/sh/rcar/dvc.c                            |   33 +-
 sound/soc/sh/rcar/gen.c                            |   56 +-
 sound/soc/sh/rcar/mix.c                            |    4 +-
 sound/soc/sh/rcar/rsnd.h                           |  115 +-
 sound/soc/sh/rcar/rsrc-card.c                      |   27 +-
 sound/soc/sh/rcar/src.c                            |  171 ++-
 sound/soc/sh/rcar/ssi.c                            |  334 +++---
 sound/soc/sh/rcar/ssiu.c                           |   20 +-
 sound/soc/soc-core.c                               |    8 +-
 sound/soc/soc-dapm.c                               |   12 +-
 sound/soc/soc-pcm.c                                |   24 +-
 sound/soc/soc-topology.c                           |  240 ++--
 sound/soc/sunxi/Kconfig                            |    8 +
 sound/soc/sunxi/Makefile                           |    1 +
 sound/soc/sunxi/sun4i-spdif.c                      |  550 +++++++++
 181 files changed, 10507 insertions(+), 2285 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/adi,adau17x1.txt
 create mode 100644 Documentation/devicetree/bindings/sound/max9867.txt
 create mode 100644 Documentation/devicetree/bindings/sound/max98926.txt
 create mode 100644 Documentation/devicetree/bindings/sound/mt8173-rt5650-r=
t5514.txt
 create mode 100644 Documentation/devicetree/bindings/sound/mt8173-rt5650.t=
xt
 create mode 100644 Documentation/devicetree/bindings/sound/rt5514.txt
 create mode 100644 Documentation/devicetree/bindings/sound/sunxi,sun4i-spd=
if.txt
 create mode 100644 Documentation/devicetree/bindings/sound/ti,ads117x.txt
 create mode 100644 sound/soc/codecs/hdac_hdmi.h
 create mode 100755 sound/soc/codecs/max9867.c
 create mode 100755 sound/soc/codecs/max9867.h
 create mode 100644 sound/soc/codecs/max98926.c
 create mode 100644 sound/soc/codecs/max98926.h
 create mode 100644 sound/soc/codecs/pcm179x-i2c.c
 create mode 100644 sound/soc/codecs/pcm179x-spi.c
 create mode 100644 sound/soc/codecs/rt5514.c
 create mode 100644 sound/soc/codecs/rt5514.h
 create mode 100644 sound/soc/mediatek/mt8173-rt5650-rt5514.c
 create mode 100644 sound/soc/mediatek/mt8173-rt5650.c
 create mode 100644 sound/soc/sunxi/sun4i-spdif.c

--V0207lvV8h4k8FAm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJW5qRlAAoJECTWi3JdVIfQemYH/3qu8EAZ5TQMQnwgXHY6Y/eV
Pn98uQAJoSjdKSm/ubUtb63ZncDPGpMUGL3htdUPjwJB7BOIPv/fGp711rNwXFlj
LD5z5v74ULg7fwZujsXX3v71S4sPOYEa7ld5xYFDa99FKSwd355aWWBepiXkuenK
ePmPC5PsQzqW42HWg4Oxpfj1kflJz/+o86QOtAPPpnerFHVObqs0y5T3LTClGS50
WamzxjTWLkdsrk6EKmEOtKjBDURBmoGkxJPT1eEtwgaP3WCyZvWkNjyr3Nr4CwYn
6UUcrwD7NBc8OpIsnnGQDCh+V+nd6Wxgm2waenpcGwxUILz+4TP3muAdCwBjc0M=
=pqRN
-----END PGP SIGNATURE-----

--V0207lvV8h4k8FAm--

--===============1589416065007799639==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1589416065007799639==--
