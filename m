From: Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] ASoC updates for v4.11
Date: Mon, 20 Feb 2017 10:39:10 -0800
Message-ID: <20170220183910.h6omxmuru35wqhci@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3894958014770557694=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C5B2D266917
 for <alsa-devel@alsa-project.org>; Mon, 20 Feb 2017 19:39:21 +0100 (CET)
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


--===============3894958014770557694==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="d3gioibysear4o5b"
Content-Disposition: inline


--d3gioibysear4o5b
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The following changes since commit 566cf877a1fcb6d6dc0126b076aad062054c2637:

  Linux 4.10-rc6 (2017-01-29 14:25:17 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc=
-v4.11

for you to fetch changes up to 141dee78c40ac2c43aa4ff306688d625e1c731de:

  Merge remote-tracking branches 'asoc/topic/wm8753' and 'asoc/topic/zte' i=
nto asoc-next (2017-02-19 16:37:07 +0000)

----------------------------------------------------------------
ASoC: Updates for v4.11

Another release that's mainly focused on drivers rather than core
changes, highlights include:

 - A huge batch of updates to the Intel drivers, mainly around
   DisplayPort and HDMI with some additional board support too.
 - Channel mapping support for HDMI.
 - Support for AllWinner A31 and A33, Everest Semiconductor ES8328,
   Nuvoton NAU8540.

----------------------------------------------------------------
Adam Thomson (1):
      ASoC: da7218: Set DAI output pin high impedance when not in use

Alexander Shiyan (1):
      ASoC: wm8753: Add control to allow swapping HiFi DAC channels

Alexandre Belloni (1):
      ASoC: fsl_sai: support more than 2 channels

Alexandrov Stansilav (2):
      ASoC: rt5640: Add "10EC3276" ACPI ID
      ASoC: Intel: Atom: Add HP Pavilion x2 10-p000 machine entry

Andy Shevchenko (4):
      ASoC: Intel: remove redundant select SND_SOC_INTEL_SST
      ASoC: Intel: rename SND_SST_MFLD_PLATFORM to SND_SST_ATOM_HIFI2_PLATF=
ORM
      ASoC: Intel: select DW_DMAC_CORE since it's mandatory
      ASoC: Intel: remove ignored dependencies

Arnaud Pouliquen (3):
      DRM: add help to get ELD speaker allocation
      ASoC: core: add optional pcm_new callback for DAI driver
      ASoC: hdmi-codec: add channel mapping control

Arnd Bergmann (1):
      ASoC: fix ES8328_I2C/SPI dependencies

Axel Lin (1):
      ASoC: rt5665: Make SND_SOC_RT5665 entry sort in Kconfig and Makefile

Baoyou Xie (2):
      ASoC: zx-i2s: Add the info of pclk to the binding document for zx2967=
 family
      ASoC: zx-i2s: introduce pclk for zx2967 family

Bard Liao (2):
      ASoC: rt5640: move DAC2 Power to rt5640_dapm_widgets
      ASoC: rt5645: set high voltage for capless power

Bjorn Andersson (2):
      ASoC: qcom: lpass-cpu: Remove unnecessary clock checks
      ASoC: qcom: Drop __func__ usage from log prints

Charles Keepax (6):
      ASoC: wm_adsp: Add mechanism to preload firmware on a core
      ASoC: Fixup some small kernel-doc typos
      ASoC: arizona: Propagate errors from arizona_spk_init
      ASoC: wm_adsp: Correct some missing locking
      ASoC: wm_adsp: Set booted/running flags at the end of bring up
      ASoC: wm_adsp: Fixup wm_adsp2_boot_work error paths

Chen-Yu Tsai (1):
      ASoC: sun4i-codec: Add "Right Mixer" to "Line Out Mono Diff." route

Corentin Labbe (3):
      ASoC: rt5514-spi: Remove unneeded linux/miscdevice.h include
      ASoC: rt5677: Remove unneeded linux/miscdevice.h include
      ASoC: wm0010: Remove unneeded linux/miscdevice.h include

Daniel Baluta (1):
      ASoC: Drop unnecessary debugfs ifdef

Enric Balletbo i Serra (1):
      ASoC: mt8173-max98090: remove the call to snd_soc_jack_add_pins.

Fabian Frederick (2):
      ASoC: samsung: include gpio consumer.h
      ASoC: samsung: add GPIOLIB dependency

Garlic Tseng (2):
      ASoC: mediatek: add power-domain get/put ctrl for mt2701
      ASoC: mediatek: add power-domains for mt2701-afe-pcm.txt

Harunobu Kurokawa (1):
      ASoC: ak4642: Replace mdelay function to msleep

Icenowy Zheng (1):
      ASoC: sunxi: allow the analog codec driver to be built on ARM64

Jeeja KP (39):
      ASoC: Intel: Skylake: Update link_index and format in pipe params
      ASoC: Intel: Skylake: Configure DMA in PRE_PMD handler of Mixer
      ASoC: Intel: Skylake: Add helper function to setup host/link dma
      ASoC: Intel: Skylake: Removed unused skl_get_format()
      ASoC: Intel: Skylake: Clean up manifest info
      ASoC: Intel: Common: Update dsp register poll implementation
      ASoC: Intel: bxtn: Use DSP poll API to poll FW status
      ALSA: hda: check stream decoupled register state
      ASoC: Intel: Skylake: Don't reset pass-through pipe in BE prepare
      ASoC: Intel: Skylake: set the resume point to LPIB
      ASoC: hdac_hdmi: Enable pin and converter in prepare
      ASoC: hdac_hdmi: Register widget event handlers
      ASoC: Intel: Skylake: Use set_tdm_slot to set the dma channel
      ASoC: hdac_hdmi: Move channel info from pin to PCM structure
      ASoC: Intel: bxt: add channel map support in rt298 machine
      ASoC: Intel: Skylake: Add route change to rt286 machine
      ASoC: Intel: bxt: Add route change to da7219_max98357a machine
      ASoC: Intel: bxt: add channel map support in bxt_da7219_max98357a mac=
hine
      ASoC: hdac_hdmi: Begin to add support for DP Multi-stream audio
      ASoC: Intel: bxt: Add route change to rt298 machine
      ASoC: Intel: Skylake: Add route change to nau88l25_max98357a machine
      ASoC: Intel: Skylake: Add route change to nau88l25_ssm4567 machine
      ASoC: hdac_hdmi: Add support to handle MST capable pin
      ASoC: hdac_hdmi: Add MST verb support
      ASoC: hdac_hdmi: Handle MST pin jack detection at boot/resume
      ASoc: hdac_hdmi: Configure pin verbs for MST
      ASoC: hdac_hdmi: Add support for multiple ports to a PCM
      ASoC: hdac_hdmi: Use ASoC jack instead of snd_jack
      ASoC: Intel: Skylake: Create ASoC jack for hdmi in rt286 machine
      ASoC: Intel: Skylake: Create ASoC jack for hdmi in skl_nau88l25_max98=
357a machine
      ASoC: Intel: Skylake: Create ASoC jack for hdmi in nau88l25_ssm4567 m=
achine
      ASoC: Intel: bxt: Create ASoC jack for hdmi in bxt_rt298 machine
      ASoC: Intel: bxt: Create ASoC jack for hdmi in bxt_da7219_max98357 ma=
chine
      ASoC: hdac_hdmi: Add machine pin widget for each port
      ASoC: Intel: Skylake: Add jack port initialize in rt286 machine
      ASoC: Intel: Skylake: Add jack port initialize in nau88l25_max98357a =
machine
      ASoC: Intel: Skylake: Add jack port initialize in nau88l25_ssm4567 ma=
chine
      ASoC: Intel: bxt: Add jack port initialize in da7219_max98357a machine
      ASoC: Intel: bxt: Add jack port initialize in bxt_rt298 machine

John Hsu (2):
      ASoC: nau8540: new codec driver
      ASoC: nau8825: automatic BCLK and LRC divde in master mode

Jose Abreu (2):
      ASoC: dwc: Add record capability in PIO mode
      ASoC: dwc: Enable 24 bit sample size in PIO mode

J=C3=B6rg Krause (3):
      ASoC: wm8731: Adjust clk definitions so that simple card can work
      ASoC: mxs-saif: fix setting SAIF1 register
      ASoC: mxs-saif: fix setting master base rate

Krzysztof Kozlowski (1):
      ASoC: samsung: Remove tests of member address

Kuninori Morimoto (13):
      ASoC: add Component level pcm_new/pcm_free
      ASoC: remove .delay from snd_soc_platform_driver
      ASoC: remove .bespoke_trigger from snd_soc_platform_driver
      ASoC: remove snd_soc_platform_trigger()
      ASoC: rsnd: fixup for_each_rsnd_mod_array{s} iterator increment
      ASoC: rsnd: fixup for_each_rsnd_mod_array{s} iterator increment
      ASoC: simple-card: use devm_get_clk_from_child()
      ASoC: cq93vc: remove MFD_DAVINCI_VOICECODEC dependency from CQ0093VC
      ASoC: soc-core: remove OF adjusting for snd_soc_of_parse_audio_routing
      ASoC: soc-core: remove OF adjusting for snd_soc_of_parse_audio_simple=
_widgets
      ASoC: soc-core: remove OF adjusting for snd_soc_of_parse_audio_prefix
      ASoC: soc-core: remove OF adjusting for snd_soc_of_parse_card_name
      ASoC: rsnd: fixup reset timing of sync convert_rate

Lars-Peter Clausen (2):
      ASoC: pxa2xx-ac97: Remove unused DAI ID defines
      ASoC: mpc5200_psc_ac97: Remove unused DAI ID defines

Liam Girdwood (1):
      ASoC: core: Add API to use DMI name in sound card long name

Linus Walleij (2):
      ASoC: dapm: handle probe deferrals
      ASoC: dapm: fix some pointer error handling

Marcus Cooper (4):
      ASoC: sun4i-spdif: remove legacy dapm components
      ASoC: sun4i-spdif: Add quirks to the spdif driver
      ASoC: sunxi: Add bindings for sun8i to SPDIF
      ASoC: sun4i-spdif: Add support for the H3 SoC

Marek Szyprowski (5):
      ASoC: samsung: i2s: Remove virtual device for secondary DAI
      ASoC: samsung: i2s: Ensure proper runtime PM state of I2S device
      ASoC: samsung: i2s: Move saving and restoring regs to runtime pm oper=
ations
      ASoC: samsung: i2s: Let runtime PM operations to control op_clk too
      ASoC: samsung: i2s: Provide I2S device for registered clocks

Mark Brown (26):
      Merge branch 'topic/hda-ext-decouple' of git://git.kernel.org/.../bro=
onie/sound into asoc-intel
      Merge tag 'v4.10-rc1' into asoc-samsung
      Merge tag 'v4.10-rc1' into asoc-intel
      Merge branch 'topic/hdac-hdmi' of git://git.kernel.org/.../broonie/so=
und into asoc-intel
      Merge branch 'fix/intel' of git://git.kernel.org/.../broonie/sound in=
to asoc-intel
      Merge tag 'asoc-fix-v4.10-rc3' into asoc-linus
      Merge remote-tracking branch 'asoc/fix/dapm' into asoc-linus
      Merge remote-tracking branch 'asoc/fix/intel' into asoc-linus
      Merge remote-tracking branch 'asoc/fix/rcar' into asoc-linus
      Merge remote-tracking branches 'asoc/fix/fsl-mxs-saif' and 'asoc/fix/=
sunxi' into asoc-linus
      Merge remote-tracking branch 'asoc/topic/component' into asoc-next
      Merge remote-tracking branch 'asoc/topic/dmaengine' into asoc-next
      Merge remote-tracking branch 'asoc/topic/intel' into asoc-next
      Merge remote-tracking branch 'asoc/topic/pcm3168a' into asoc-next
      Merge remote-tracking branch 'asoc/topic/rcar' into asoc-next
      Merge remote-tracking branches 'asoc/topic/adau17x1', 'asoc/topic/ads=
p', 'asoc/topic/ak4642', 'asoc/topic/amd' and 'asoc/topic/arizona' into aso=
c-next
      Merge remote-tracking branches 'asoc/topic/atmel', 'asoc/topic/chmap'=
, 'asoc/topic/cq93vc' and 'asoc/topic/da7218' into asoc-next
      Merge remote-tracking branches 'asoc/topic/davinci', 'asoc/topic/debu=
gfs' and 'asoc/topic/doc' into asoc-next
      Merge remote-tracking branches 'asoc/topic/dwc', 'asoc/topic/es8328',=
 'asoc/topic/fsl', 'asoc/topic/fsl-sai' and 'asoc/topic/graph' into asoc-ne=
xt
      Merge remote-tracking branches 'asoc/topic/img' and 'asoc/topic/max98=
090' into asoc-next
      Merge remote-tracking branches 'asoc/topic/max9867', 'asoc/topic/mtk'=
, 'asoc/topic/nau8540', 'asoc/topic/nau8825' and 'asoc/topic/omap' into aso=
c-next
      Merge remote-tracking branches 'asoc/topic/pxa', 'asoc/topic/qcom' an=
d 'asoc/topic/rockchip' into asoc-next
      Merge remote-tracking branches 'asoc/topic/rt5514', 'asoc/topic/rt564=
0', 'asoc/topic/rt5645', 'asoc/topic/rt5659' and 'asoc/topic/rt5660' into a=
soc-next
      Merge remote-tracking branches 'asoc/topic/rt5665', 'asoc/topic/rt567=
7', 'asoc/topic/samsung', 'asoc/topic/simple' and 'asoc/topic/sunxi' into a=
soc-next
      Merge remote-tracking branches 'asoc/topic/tlv320aic3x', 'asoc/topic/=
topology', 'asoc/topic/wm0010', 'asoc/topic/wm8731' and 'asoc/topic/wm8741'=
 into asoc-next
      Merge remote-tracking branches 'asoc/topic/wm8753' and 'asoc/topic/zt=
e' into asoc-next

Matt Ranostay (1):
      ASoC: omap-mcbsp: Add PM QoS support for McBSP to prevent glitches

Mengdong Lin (1):
      ASoC: Intel: Use DMI name for sound card long name in Broadwell machi=
ne driver

Myl=C3=A8ne Josserand (6):
      ASoC: sun4i-i2s: Increase DMA max burst to 8
      ASoC: sun8i-codec-analog: Add amplifier event to fix first delay
      ASoC: Add sun8i digital audio codec
      ASoC: codecs: Add sun8i-a33 binding documentation
      ASoC: sun4i-i2s: Add quirks to handle a31 compatible
      ASoC: sun4i-i2s: Update binding documentation to include A31

Nicholas Mc Guire (6):
      ASoC: rt5640: use msleep() for long delays
      ASoC: rt5659: use msleep() for long delays
      ASoC: rt5659: declare rt5659_i2c_driver static
      ASoC: rt5659: drop double const
      ASoC: rt5660: remove double const
      ASoC: rt5660: use msleep() for long delay

Peter Rosin (2):
      misc: atmel-ssc: register as sound DAI if #sound-dai-cells is present
      ASoC: atmel: tse850: rely on the ssc to register as a cpu dai by itse=
lf

Peter Ujfalusi (1):
      ASoC: tlv320aic3x: Add delay after power on and register sync

Pierre-Louis Bossart (16):
      ASoC: Intel: boards: remove .pm_ops in all Atom/DPCM machine drivers
      ASoC: Intel: atom: fix frame polarity
      ASoC: Intel: cht_bsw_rt5645: add Baytrail MCLK support
      ASoC: Intel: add support for Realtek 5651 on Cherrytrail
      ASoC: codecs: rt5670: add quirk for Lenovo Thinkpad 10
      ASoC: rt5645: add support for RT5648
      ASoC: Intel: Atom: add machine driver for baytrail-rt5645 hardware
      ASoC: Intel: cht_bsw_rt5645: harden ACPI device detection
      ASoC: Intel: Baytrail: add quirk for Lenovo Thinkpad 10
      ASoc: rt5645: add ACPI ID 10EC3270
      ASoC: Intel: cht-bsw-rt5645: add quirks for SSP0/AIF1/AIF2 routing
      ASoC: Intel: cht-bsw-rt5645: select ASRC source based on routing quirk
      ASoC: Intel: add support for ALC3270 codec
      ASoC: Intel: cht-bsw-rt5645: fix DAI formats
      ASoC: rt5645: fix error handling for gpio detection
      ASoC: cht-bsw-rt5645: fix unused variable compiler warning

Romain Perier (4):
      ASoC: es8328-i2c: Add compatible for ES8388
      ASoC: es8328: Add support for slave mode
      ASoC: Allow to select ES8328_I2C and ES8328_SPI directly
      ASoC: rockchip: Add machine driver for RK3288 boards that use analog/=
HDMI

Sandeep Tayal (1):
      ASoC: hdac_hdmi: use audio component framework to read ELD

Sebastien Guiriec (1):
      ASoC: Intel: Atom: Configure media_loop1 and sprot_loop in stereo

Senthilnathan Veppur (1):
      ASoC: Intel: Skylake: Check device type to get endpoint configuration

Sergej Sawazki (1):
      ASoC: wm8741: Remove unused WM8741_NUM_RATES macro

Shailendra Verma (1):
      ASoC: davinci - Fix possible NULL derefrence.

Subhransu S. Prusty (1):
      ASoC: Intel: Skylake: Report Platform ID info from NHLT

Sylwester Nawrocki (2):
      ASoC: Revert "samsung: Remove unneeded initialization of chan_name"
      ASoC: Revert "Drop SND_DMAENGINE_PCM_FLAG_CUSTOM_CHANNEL_NAME flag"

Vincent Abriou (1):
      ASoC: hdmi-codec: remove HDMI device unregister

Vinod Koul (17):
      ASoC: Intel: Skylake: remove unused 'ret'
      ASoC: Intel: sst: remove unused 'ops'
      ASoC: Intel: sst: remove unused 'msg_high'
      ASoC: topology: remove unused 'err'
      ASoC: hdac_hdmi: remove unused 'dai_map'
      ASoC: max98090: remove superflous check for 'micbias'
      ASoC: AMD: remove unused =E2=80=98dma_buffer=E2=80=99
      ASoC: adau17x1: remove unused =E2=80=98ret=E2=80=99
      ASoC: max9867: remove unused =E2=80=98ret=E2=80=99
      ASoC: pcm3168a: remove unused =E2=80=98format=E2=80=99
      ASoC: img: remove unused =E2=80=98format=E2=80=99
      ASoC: Intel: sst: remove unused =E2=80=98ret_val=E2=80=99
      ASoC: samsung: smdk_wm8580: remove unused =E2=80=98bfs=E2=80=99
      ASoC: zx296702-i2s: remove unused =E2=80=98format=E2=80=99
      ASoC: rt298: Add DMI match for Geminilake reference platform
      ASoC: Intel: Skylake: Add Geminlake IDs
      ASoC: hdac_hdmi: Add device id for Geminilake

Wei Yongjun (1):
      ASoC: sun4i-spdif: drop unnessary snd_soc_unregister_component()

Yong Zhi (1):
      ASoC: Intel: boards: Remove ignore_suspend for WoV streams

kbuild test robot (1):
      ASoC: rt5659: fix platform_no_drv_owner.cocci warnings

youling257 (1):
      ASoC: Intel: bytcr_rt5640: quirks for Insyde devices

 .../devicetree/bindings/misc/atmel-ssc.txt         |    2 +
 .../bindings/sound/axentia,tse850-pcm5142.txt      |   11 +-
 Documentation/devicetree/bindings/sound/es8328.txt |    2 +-
 .../devicetree/bindings/sound/mt2701-afe-pcm.txt   |    2 +
 .../devicetree/bindings/sound/nau8540.txt          |   16 +
 .../bindings/sound/rockchip,rk3288-hdmi-analog.txt |   36 +
 .../devicetree/bindings/sound/sun4i-i2s.txt        |    5 +
 .../devicetree/bindings/sound/sun8i-a33-codec.txt  |   63 +
 .../bindings/sound/sunxi,sun4i-spdif.txt           |    1 +
 .../devicetree/bindings/sound/zte,zx-i2s.txt       |   14 +-
 arch/arm/mach-s3c64xx/dev-audio.c                  |    4 +-
 drivers/misc/atmel-ssc.c                           |   50 +
 include/drm/drm_edid.h                             |   13 +
 include/linux/atmel-ssc.h                          |    1 +
 include/linux/platform_data/asoc-s3c.h             |    6 +-
 include/sound/dmaengine_pcm.h                      |    6 +
 include/sound/simple_card_utils.h                  |   11 +-
 include/sound/soc-dai.h                            |    3 +
 include/sound/soc.h                                |   52 +-
 sound/hda/ext/hdac_ext_stream.c                    |   15 +-
 sound/soc/amd/acp-pcm-dma.c                        |    3 -
 sound/soc/atmel/tse850-pcm5142.c                   |   23 +-
 sound/soc/codecs/Kconfig                           |   25 +-
 sound/soc/codecs/Makefile                          |    6 +-
 sound/soc/codecs/adau17x1.c                        |    3 +-
 sound/soc/codecs/ak4642.c                          |    2 +-
 sound/soc/codecs/arizona.h                         |    1 +
 sound/soc/codecs/cs47l24.c                         |    8 +-
 sound/soc/codecs/da7218.c                          |    3 +-
 sound/soc/codecs/es8328-i2c.c                      |    2 +
 sound/soc/codecs/es8328.c                          |   20 +-
 sound/soc/codecs/hdac_hdmi.c                       | 1327 ++++++++++++----=
----
 sound/soc/codecs/hdac_hdmi.h                       |    5 +-
 sound/soc/codecs/hdmi-codec.c                      |  403 +++++-
 sound/soc/codecs/max98090.c                        |    2 +-
 sound/soc/codecs/max9867.c                         |    5 +-
 sound/soc/codecs/nau8540.c                         |  835 ++++++++++++
 sound/soc/codecs/nau8540.h                         |  222 ++++
 sound/soc/codecs/nau8825.c                         |   20 +-
 sound/soc/codecs/pcm3168a.c                        |    2 -
 sound/soc/codecs/rt298.c                           |    7 +
 sound/soc/codecs/rt5514-spi.c                      |    1 -
 sound/soc/codecs/rt5640.c                          |   13 +-
 sound/soc/codecs/rt5645.c                          |   14 +-
 sound/soc/codecs/rt5659.c                          |   91 +-
 sound/soc/codecs/rt5660.c                          |    6 +-
 sound/soc/codecs/rt5670.c                          |    1 +
 sound/soc/codecs/rt5677-spi.c                      |    1 -
 sound/soc/codecs/tlv320aic3x.c                     |    6 +
 sound/soc/codecs/wm0010.c                          |    1 -
 sound/soc/codecs/wm5102.c                          |    7 +-
 sound/soc/codecs/wm5110.c                          |   10 +-
 sound/soc/codecs/wm8731.h                          |    2 +-
 sound/soc/codecs/wm8741.c                          |    2 -
 sound/soc/codecs/wm8753.c                          |    3 +-
 sound/soc/codecs/wm8997.c                          |    6 +-
 sound/soc/codecs/wm8998.c                          |    6 +-
 sound/soc/codecs/wm_adsp.c                         |   77 +-
 sound/soc/codecs/wm_adsp.h                         |   11 +
 sound/soc/davinci/davinci-evm.c                    |   13 +-
 sound/soc/dwc/designware_i2s.c                     |    9 +-
 sound/soc/dwc/designware_pcm.c                     |   99 +-
 sound/soc/dwc/local.h                              |    9 +-
 sound/soc/fsl/efika-audio-fabric.c                 |    1 -
 sound/soc/fsl/fsl_sai.c                            |    4 +-
 sound/soc/fsl/mpc5200_psc_ac97.c                   |    1 -
 sound/soc/fsl/mpc5200_psc_ac97.h                   |   13 -
 sound/soc/generic/simple-card-utils.c              |    8 +-
 sound/soc/generic/simple-card.c                    |    4 +-
 sound/soc/generic/simple-scu-card.c                |    4 +-
 sound/soc/img/img-parallel-out.c                   |    2 -
 sound/soc/intel/Kconfig                            |   51 +-
 sound/soc/intel/Makefile                           |    2 +-
 sound/soc/intel/atom/Makefile                      |    7 +-
 sound/soc/intel/atom/sst-atom-controls.c           |   10 +-
 sound/soc/intel/atom/sst-mfld-platform-pcm.c       |    5 +-
 sound/soc/intel/atom/sst/sst_acpi.c                |   52 +-
 sound/soc/intel/atom/sst/sst_ipc.c                 |    2 -
 sound/soc/intel/atom/sst/sst_stream.c              |    2 -
 sound/soc/intel/boards/broadwell.c                 |    2 +
 sound/soc/intel/boards/bxt_da7219_max98357a.c      |   76 +-
 sound/soc/intel/boards/bxt_rt298.c                 |   78 +-
 sound/soc/intel/boards/bytcr_rt5640.c              |   15 +-
 sound/soc/intel/boards/bytcr_rt5651.c              |    3 +-
 sound/soc/intel/boards/cht_bsw_rt5645.c            |  397 +++++-
 sound/soc/intel/boards/skl_nau88l25_max98357a.c    |   34 +-
 sound/soc/intel/boards/skl_nau88l25_ssm4567.c      |   33 +-
 sound/soc/intel/boards/skl_rt286.c                 |   30 +-
 sound/soc/intel/common/sst-dsp.c                   |   52 +-
 sound/soc/intel/skylake/bxt-sst.c                  |   64 +-
 sound/soc/intel/skylake/skl-messages.c             |    7 +
 sound/soc/intel/skylake/skl-nhlt.c                 |   58 +-
 sound/soc/intel/skylake/skl-pcm.c                  |  174 +--
 sound/soc/intel/skylake/skl-sst-dsp.h              |    4 +-
 sound/soc/intel/skylake/skl-sst-ipc.h              |    5 +-
 sound/soc/intel/skylake/skl-topology.c             |   97 +-
 sound/soc/intel/skylake/skl-topology.h             |   19 +
 sound/soc/intel/skylake/skl-tplg-interface.h       |   12 -
 sound/soc/intel/skylake/skl.c                      |   12 +
 sound/soc/intel/skylake/skl.h                      |    5 +-
 sound/soc/mediatek/mt2701/mt2701-afe-pcm.c         |    2 +
 sound/soc/mediatek/mt8173/mt8173-max98090.c        |   14 +-
 sound/soc/mxs/mxs-saif.c                           |   34 +-
 sound/soc/omap/mcbsp.h                             |    3 +
 sound/soc/omap/omap-mcbsp.c                        |   48 +-
 sound/soc/pxa/e740_wm9705.c                        |    3 -
 sound/soc/pxa/e750_wm9705.c                        |    2 -
 sound/soc/pxa/e800_wm9712.c                        |    2 -
 sound/soc/pxa/em-x270.c                            |    2 -
 sound/soc/pxa/mioa701_wm9713.c                     |    1 -
 sound/soc/pxa/palm27x.c                            |    2 -
 sound/soc/pxa/pxa2xx-ac97.c                        |    2 -
 sound/soc/pxa/pxa2xx-ac97.h                        |   17 -
 sound/soc/pxa/tosa.c                               |    2 -
 sound/soc/pxa/zylonite.c                           |    1 -
 sound/soc/qcom/lpass-apq8016.c                     |   15 +-
 sound/soc/qcom/lpass-cpu.c                         |  107 +-
 sound/soc/qcom/lpass-platform.c                    |  106 +-
 sound/soc/qcom/storm.c                             |   22 +-
 sound/soc/rockchip/Kconfig                         |    9 +
 sound/soc/rockchip/Makefile                        |    2 +
 sound/soc/rockchip/rk3288_hdmi_analog.c            |  299 +++++
 sound/soc/samsung/Kconfig                          |    2 +
 sound/soc/samsung/dmaengine.c                      |    8 +-
 sound/soc/samsung/i2s.c                            |  206 ++-
 sound/soc/samsung/s3c2412-i2s.c                    |    2 +
 sound/soc/samsung/s3c24xx-i2s.c                    |    2 +
 sound/soc/samsung/smdk_wm8580.c                    |    5 +-
 sound/soc/samsung/tm2_wm5110.c                     |    1 +
 sound/soc/sh/rcar/core.c                           |    2 -
 sound/soc/sh/rcar/rsnd.h                           |    4 +-
 sound/soc/sh/rcar/src.c                            |    6 +-
 sound/soc/soc-ac97.c                               |    2 +-
 sound/soc/soc-core.c                               |  225 +++-
 sound/soc/soc-dapm.c                               |   62 +
 sound/soc/soc-generic-dmaengine-pcm.c              |   12 +-
 sound/soc/soc-ops.c                                |    2 +-
 sound/soc/soc-pcm.c                                |   55 +-
 sound/soc/soc-topology.c                           |   19 +-
 sound/soc/sunxi/Kconfig                            |   13 +-
 sound/soc/sunxi/Makefile                           |    1 +
 sound/soc/sunxi/sun4i-codec.c                      |    1 +
 sound/soc/sunxi/sun4i-i2s.c                        |   61 +-
 sound/soc/sunxi/sun4i-spdif.c                      |   60 +-
 sound/soc/sunxi/sun8i-codec-analog.c               |   30 +-
 sound/soc/sunxi/sun8i-codec.c                      |  498 ++++++++
 sound/soc/zte/zx-i2s.c                             |   43 +-
 147 files changed, 5466 insertions(+), 1521 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/nau8540.txt
 create mode 100644 Documentation/devicetree/bindings/sound/rockchip,rk3288=
-hdmi-analog.txt
 create mode 100644 Documentation/devicetree/bindings/sound/sun8i-a33-codec=
=2Etxt
 create mode 100644 sound/soc/codecs/nau8540.c
 create mode 100644 sound/soc/codecs/nau8540.h
 delete mode 100644 sound/soc/fsl/mpc5200_psc_ac97.h
 delete mode 100644 sound/soc/pxa/pxa2xx-ac97.h
 create mode 100644 sound/soc/rockchip/rk3288_hdmi_analog.c
 create mode 100644 sound/soc/sunxi/sun8i-codec.c

--d3gioibysear4o5b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlirN84ACgkQJNaLcl1U
h9CLvwf+MqEZM7xbiss5adtDHktRD6Qbqi6h+kozNAk5sFF+yOA8zUDtbls4NS+W
C2LTX2NVNLQoSMxPH92hfq7PL8Dgp+aofZr8Dyvn48eULy3CHYcXS3hUSvKPw5pA
Rz8mFfMx8BSKXLuXv4vylhb8LbfbNq5sj5lO9WE8TrS43ObhuhXrGo9bJEJByALT
+tPNrGMsTcY1OccZewL7gkQ2mVzu4mdpJDsXbzeNuRAhSowTkW4wvNX0sFR9xErj
8hS3cY2oAS0rJGUZxgaRZIv0tc/VcTZsd2KW7Rz0hOrtHbNvyzaMupVnmo7x2Vcl
QbXA5i4GP1jparoVlScozgr2moJqAQ==
=sClb
-----END PGP SIGNATURE-----

--d3gioibysear4o5b--

--===============3894958014770557694==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3894958014770557694==--
