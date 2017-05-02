From: Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] ASoC updates for v4.12
Date: Tue, 2 May 2017 11:57:17 +0900
Message-ID: <20170502025717.626ydj4xt3uu25mr@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2099262759967424691=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 8CA6626691F
 for <alsa-devel@alsa-project.org>; Tue,  2 May 2017 04:57:24 +0200 (CEST)
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


--===============2099262759967424691==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="amrkqr4cnb3fko3x"
Content-Disposition: inline


--amrkqr4cnb3fko3x
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The following changes since commit 5a7ad1146caa895ad718a534399e38bd2ba721b7:

  Linux 4.11-rc8 (2017-04-23 16:53:00 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc=
-v4.12

for you to fetch changes up to 20d5c84bef067b7e804a163e2abca16c47125bad:

  Merge remote-tracking branches 'asoc/topic/wm8960', 'asoc/topic/wm8978' a=
nd 'asoc/topic/zte-tdm' into asoc-next (2017-04-30 22:16:48 +0900)

----------------------------------------------------------------
ASoC: Updates for v4.12

A quiet release for the core, but lots of new drivers this time around:

 - A new, generalized, API for hooking up jacks which makes it easier to
   write generic machine drivers for simple cases.
 - Continuing fixes for issues with the x86 CPU drivers.
 - New drivers for Cirrus CS35L35, DIO DIO2125, Everest ES7132,
   HiSilicon hi6210, Maxim MAX98927, MT2701 systems with WM8960, Nuvoton
   NAU8824, Odroid systems, ST STM32 SAI controllers and x86 systems with
   DA7213

----------------------------------------------------------------
Adrian Dinu (1):
      ASoC: Add space around '=3D'

Adriana Constantinescu (1):
      ASoC: omap: Remove unnecessary 'out of memory' message

Alexander Sverdlin (1):
      ASoC: cs4271: configure reset GPIO as output

Alin Grigorean (1):
      ASoC: fsl: Remove unneeded init of static variable

Andy Green (1):
      ASoC: hisilicon: Add hi6210 i2s audio driver

Andy Shevchenko (1):
      ASoC: Intel: bdw-rt5677: Use devm_gpiod_get()

Arnaud Pouliquen (1):
      ASoC: STI: Fix null ptr deference in IRQ handler

Arnd Bergmann (2):
      ASoC: mediatek: add I2C dependency for CS42XX8
      ASoC: Intel: Skylake: fix uninitialized pointer use

Axel Lin (1):
      ASoC: cs35l35: Fix display revision id

B, Jayachandran (1):
      ALSA: hda: Fix LLCH register read

Baoyou Xie (2):
      ASoC: zx-tdm: add bindings doc for zte's tdm controller
      ASoC: zx-tdm: add zte's tdm controller driver

Bard Liao (9):
      ASoC: rt5665: increase button detection accuracy
      ASoC: rt5665: enable TDM if more than 2 channels
      ASoC: rt5665: enhance jack type detection function
      ASoC: rt5665: move set_pll to codec level
      ASoC: rt5665: move set_sysclk to codec level
      ASoC: rt5665: set i2s pin share configuration
      ASoC: rt5665: fix wrong pre div reg of IF2 and IF3
      ASoC: jack: add snd_soc_codec_set_jack
      ASoC: rt5665: move rt5665_set_jack_detect to .set_jack

Bhumika Goyal (5):
      ASoC: pxa: constify snd_soc_ops structures
      ASoC: fsl: constify snd_soc_ops structures
      ASoC: mediatek: constify snd_soc_ops structures
      ASoC: omap: constify snd_soc_ops structures
      ASoC: blackfin: constify snd_soc_ops structures

Brian Austin (2):
      ASoC: Add support for Cirrus Logic CS35L35 Amplifier
      ASoC: cs35l35: Add bindings file for CS35L35

Bryce Ferguson (1):
      ASoC: Add AU1761 audio codec as selectable option

Calin Cruceru (1):
      ASoC: samsung: Remove extra blank lines

Charles Keepax (12):
      ASoC: cs35l35: Add missing return in probe
      ASoC: cs35l35: Add device tree binding for I2S drive configuration
      ASoC: cs35l35: Add for configuring drive mode in unused slots
      ASoC: cs35l35: Add local variable for dev in probe
      ASoC: cs35l35: Add IRQF_SHARED to IRQ flags
      ASoC: cs35l35: Stash dev pointer directly rather than CODEC pointer
      ASoC: cs35l35: Clear reset_gpio on the error path in probe
      ASoC: cs35l35: Improve power down time
      ASoC: cs35l35: Correct handling of PDN_DONE with external boost
      ASoC: cs35l35: Add DT binding to specify usage of an external boost s=
upply
      ASoC: cs35l35: Correct some register defaults
      ASoC: cs35l35: Allow user to configure IMON SCALE

Codrut Grosu (17):
      ASoC: tegra: Remove unnecessary 'out of memory' message
      ASoC: pxa-ssp: Added blank line after declarations
      ASoC: pxa: Remove space before semicolon
      ASoC: pxa: Remove unneeded else after return statement
      ASoC: pxa: The open brace is placed with the previous line
      ASoC: pxa: Add space around ':' and '('
      ASoC: pxa: Remove spaces before tabs
      ASoC: pxa: Remove unneeded return statement in void function
      ASoC: pxa-ssp: Line up *s in block comments
      ASoC: tegra: Add blank line after declarations
      ASoC: txx9: Added blank line after declarations
      ASoC: ux500: Added */ to the next line
      ASoC: ux500: Remove unuseful break after return
      ASoC: ux500: Added blank line after declarations
      ASoC: sirf: Added blank line after declarations
      ASoC: pxa: Add space around '=3D'
      ASoC: txx9: Added requiered spaces.

Colin Ian King (6):
      ASoC: Intel: Skylake: fix spelling mistake: "allocationf" -> "allocat=
ion"
      ASoC: cs35l35: trivial fix to indentation
      ASoC: intel: remove unused variable data and associated code
      ASoC: Intel: bxtn: fix spelling mistake: "Timout" -> "Timeout"
      ASoC: topology: use j for internal loop counter
      ASoC: wm5100: fix spelling mistake: "micropone" -> "microphone"

Dan Carpenter (4):
      ASoC: cs35l35: returning uninitialized in probe()
      ASoC: Intel: Skylake: Uninitialized variable in probe_codec()
      ASoC: Intel: Skylake: Fix a couple user after free bugs
      ASoC: sti: Fix error handling if of_clk_get() fails

Daniel Baluta (8):
      ASoC: codec: wm8960: Refactor sysclk freq search
      ASoC: codec: wm8960: Relax bit clock computation
      ASoC: imx-wm8962: Let codec driver enable/disable its MCLK
      ASoC: imx-wm8962: Fix codec_clk cleanup
      ASoC: codec: wm9860: Refactor PLL out freq search
      ASoC: codec: wm8960: Stop when a matching PLL freq is found
      ASoC: codec: wm9860: avoid maybe-uninitialized warning
      ASoC: codec: wm8960: Relax bit clock computation when using PLL

Dharageswari R (1):
      ASoC: Intel: Skylake: Fix parameter overwrite for KPB Module

Dmitry Torokhov (1):
      ASoC: jack - check status of GPIO-based pins on resume

Douglas Anderson (3):
      ASoC: rt5514: Mark rt5514_i2c_driver as static
      ASoC: rt5514: Avoid relying on uninitialized "val" value
      ASoC: rt5514: Unconfuse the rt5514 at probe / resume time

Fabio Estevam (11):
      ASoC: tas2552: Improve DT binding document example
      ASoC: fsl_ssi: Remove FSLSSI_I2S_RATES definition
      ASoC: fsl_ssi: Use the tolower() function
      ASoC: sgtl5000: Allow LRCLK pad drive strength to be changed
      ASoC: tas2552: Return the real error code
      ASoC: tas2552: Describe the possible I2C addresses
      ASoC: tas2552: Fix typos in the binding doc
      ASoC: fsl ssi doc: Move optional properties to the correct section
      ASoC: fsl_esai: Remove unneeded definition
      ASoC: imx-wm8962: Remove global variables
      ASoC: tas2552: Propagate the error code in suspend/resume

G Kranthi (5):
      ASoC: Intel: Skylake: Disable notifications at boot after DSP FW init
      ASoC: Intel: Skylake: Remove get dsp_ops in cleanup routine
      ASoC: Intel: Skylake: Add 16-bit constraint to FE bxt_rt298 machine
      ASoC: Intel: Skylake: Move sst common initialization to a helper func=
tion
      ASoC: Intel: Skylake: Modify arguments to reuse module transfer funct=
ion

Guneshwor Singh (2):
      ASoC: Intel: Skylake: Fix not to stop src pipe in pre pmd event handl=
er
      ASoC: Intel: Skylake: Return negative error code

Hardik T Shah (1):
      ASoC: Intel: Skylake: Fix DMA position reporting for capture stream

Harsha Priya (1):
      ASoC: Intel: Update bxt_da7219_max98357a to add a new

Hiroyuki Yokoyama (1):
      ASoC: rcar: enable PCM RATE untile 192000

Icenowy Zheng (2):
      ASoC: sun8i-codec-analog: split out mic2
      ASoC: sun8i-codec-analog: split out line in

Javier Martinez Canillas (8):
      ASoC: max9867: export OF device ID as module aliases
      ASoC: cs53l30: Set .of_match_table to OF device ID table
      ASoc: rt5645: Add OF device ID table
      ASoC: ssm4567: Add OF device ID table
      ASoC: sta529: Add OF device ID table
      ASoC: uda1380: Add OF device ID table
      ASoC: wm8978: Add OF device ID table
      ASoC: rt5677: Add OF device ID table

Jeeja KP (13):
      ASoC: Intel: bxtn: Store the FW/Library context at boot
      ASoC: Intel: bxtn: optimize ROM init retries
      ASoC: Intel: Skylake: Fix to delete DSP pipe after stopping pipe
      ASoC: Intel: bxtn: Disable interrupt when DSP is in D3
      ASoC: Intel: bxtn: Update DSP core state in D0
      ASoC: Intel: bxtn: Reload the firmware in case of D3 failure
      ASoC: Intel: Skylake: Remove BE prepare ops
      ASoC: Intel: Skylake: Fix module load when module size > DMA buffer s=
ize
      ASoC: Intel: Skylake: Use the sig_bits to define dai bps capability
      ASoC: hdac_hdmi: Update sig_bits based on converter capability
      ASoC: Intel: Skylake: Rearrangement of code to cleanup SKL SST library
      ASoC: Intel: Skylake: Fix module state after unbind and delete
      ASoC: Intel: Skylake: Add support for deferred DSP module bind

Jerome Brunet (5):
      ASoC: es7134: add es7134 DAC driver
      ASoC: es7134: add dt-bindings for the es7134 dac
      ASoC: dio2125: add dio2125 amp driver
      ASoC: dio2125: add dt-bindings
      ASoC: dio2125: use gpiod_set_value_cansleep

Jianqun Xu (1):
      ASoC: rockchip: add bindings for rk3368 i2s

John Hsu (4):
      ASoC: nau8540: fix tab conversion problem
      ASoC: nau8824: new driver
      ASoC: nau8824: rename controls to match DAPM controls
      ASoC: nau8824: leave Class D gain at chip default

John Stultz (5):
      ASoC: add hi6210-i2s DT bindings
      ASoC: Improve hi6210-i2s DT bindings
      ASoC: hisilicon: Add error returns even for cases that shouldn't happ=
en.
      ASoC: hisilicon: Address style nit to use break in final default of s=
witch statement
      ASoC: hisilicon: Use devm_snd_soc_register_component

Jose Abreu (1):
      ASoC: dwc: Disallow building designware_pcm as a module

Kuninori Morimoto (15):
      ASoC: simple-card: use defined dev on probe()
      ASoC: simple-scu-card: use defined dev on probe()
      ASoC: simple-card: add new simple_priv_to_card() macro
      ASoC: simple-scu-card: add new simple_priv_to_card() macro
      ASoC: core: remove pointless auxiliary from snd_soc_component
      ASoC: rcar: ssi: don't set SSICR.CKDV =3D 000 with SSIWSR.CONT
      ASoC: rcar: remove rsnd_kctrl_remove()
      ASoC: rcar: fixup of_clk_add_provider() usage for multi clkout
      ASoC: rcar: call missing of_clk_del_provider() when remove
      ASoC: soc-core: verify Sound Card normality
      ASoC: rsnd: tidyup src->convert_rate reset timing
      ASoC: rsnd: merge rsnd_kctrl_new_m/s/e into rsnd_kctrl_new()
      ASoC: ak4613: use snd_soc_update_bits() to avoid Reserve bit on I/O C=
TRL
      ASoC: rsnd: rsnd_mod_make_sure() is not under DEBUG
      ASoC: rsnd: enable clock-frequency for both 44.1kHz/48kHz

Linus Walleij (3):
      ASoC: ux500: drop platform DAI assignments
      ASoC: wm8903: add regulator handling
      ASoC: qcom: move clock names into LPASS variant struct

Liviu Dudau (1):
      ASoC: TLV320AIC23: Unquote NULL from control name

Lucas Stach (1):
      ASoC: imx-pcm-dma: simplify pcm_config

Marek Vasut (1):
      ASoC: rsnd: Fix possible NULL pointer dereference

Mark Brown (24):
      Merge branch 'fix/sun8i' of git://git.kernel.org/.../broonie/sound in=
to asoc-sunxi
      Merge branch 'topic/hda' of git://git.kernel.org/.../broonie/sound in=
to asoc-intel
      Merge branch 'fix/rcar' of git://git.kernel.org/.../broonie/sound int=
o asoc-rcar
      Merge branch 'topic/jack' of git://git.kernel.org/.../broonie/sound i=
nto asoc-rt5665
      Merge remote-tracking branches 'asoc/fix/intel', 'asoc/fix/topology' =
and 'asoc/fix/sti' into asoc-linus
      Merge tag 'asoc-fix-v4.11-rc7' into asoc-linus
      Merge remote-tracking branch 'asoc/fix/rcar' into asoc-linus
      Merge remote-tracking branch 'asoc/fix/cs4271' into asoc-linus
      Merge remote-tracking branch 'asoc/topic/core' into asoc-next
      Merge remote-tracking branch 'asoc/topic/intel' into asoc-next
      Merge remote-tracking branch 'asoc/topic/rcar' into asoc-next
      Merge remote-tracking branch 'asoc/topic/rt5665' into asoc-next
      Merge remote-tracking branches 'asoc/topic/adsp', 'asoc/topic/ak4613'=
, 'asoc/topic/au1761' and 'asoc/topic/blackfin' into asoc-next
      Merge remote-tracking branches 'asoc/topic/cs35l35', 'asoc/topic/cs53=
l30', 'asoc/topic/da7213', 'asoc/topic/dio2125' and 'asoc/topic/dwc' into a=
soc-next
      Merge remote-tracking branches 'asoc/topic/es7134', 'asoc/topic/es832=
8', 'asoc/topic/fsl', 'asoc/topic/fsl-asrc' and 'asoc/topic/fsl-esai' into =
asoc-next
      Merge remote-tracking branches 'asoc/topic/fsl-ssi', 'asoc/topic/hi62=
20' and 'asoc/topic/imx' into asoc-next
      Merge remote-tracking branches 'asoc/topic/max9878', 'asoc/topic/max9=
8927', 'asoc/topic/mtk' and 'asoc/topic/nau8540' into asoc-next
      Merge remote-tracking branches 'asoc/topic/nau8824', 'asoc/topic/omap=
', 'asoc/topic/pxa' and 'asoc/topic/qcom' into asoc-next
      Merge remote-tracking branches 'asoc/topic/rockchip', 'asoc/topic/rt5=
514', 'asoc/topic/rt5645' and 'asoc/topic/rt5677' into asoc-next
      Merge remote-tracking branches 'asoc/topic/samsung', 'asoc/topic/sgtl=
5000', 'asoc/topic/simple', 'asoc/topic/sirf' and 'asoc/topic/ssm4567' into=
 asoc-next
      Merge remote-tracking branches 'asoc/topic/sta529', 'asoc/topic/sti',=
 'asoc/topic/stm', 'asoc/topic/sunxi' and 'asoc/topic/tas2552' into asoc-ne=
xt
      Merge remote-tracking branches 'asoc/topic/tegra', 'asoc/topic/tlv320=
aic23', 'asoc/topic/topology', 'asoc/topic/twl6040' and 'asoc/topic/txx9' i=
nto asoc-next
      Merge remote-tracking branches 'asoc/topic/uda1380', 'asoc/topic/unre=
gister', 'asoc/topic/ux500', 'asoc/topic/wm5100' and 'asoc/topic/wm8903' in=
to asoc-next
      Merge remote-tracking branches 'asoc/topic/wm8960', 'asoc/topic/wm897=
8' and 'asoc/topic/zte-tdm' into asoc-next

Mayuresh Kulkarni (1):
      ASoC: wm_adsp: add support for DSP region lock

Mousumi Jana (1):
      ASoC: topology: Fix to store enum text values

Myl=E8ne Josserand (5):
      ASoC: sun8i-codec: Remove analog "HP" widget
      ASoC: sun8i-codec: Update mixer to use SOC_DAPM_DOUBLE
      ASoC: sun8i-codec: Convert to SOC_MIXER_ARRAY
      ASoC: sun8i-codec: Fix space on audio-routing widget
      ASoC: sun8i-codec: Convert to use SND_SOC_DAPM_AIF_IN

Nicole Faerber (1):
      ASoC: codecs: rt5670: add Thinkpad Tablet 10 quirk

Peter Ujfalusi (1):
      ASoC: twl6040: Add control for HS and HF mono to stereo selection

Pierre-Louis Bossart (7):
      ASoC: da7213: add ACPI support
      ASoC: Intel: add machine driver for BYT/CHT + DA7213
      ASoC: Intel: Atom: enable BYT/CHT+DA7213 machine driver
      ASoC: Intel: boards: add card for MinnowBoardMax/Up I2S access
      ASoC: Intel: Enable bytcht_nocodec machine driver
      ASoC: Intel: Atom: update Thinkpad 10 quirk
      ASoC: bytcr_rt5640: log quirk configuration errors

Richard Fitzgerald (1):
      ASoC: wm_adsp: Add support for ADSP2V2

Romain Perier (5):
      ASoC: es8328: Let device auto detect ratios in slave mode
      ASoC: es8328: Simplify rates definition
      ASoC: es8328: Enabling support for 192k
      ASoC: rockchip: Enable 192khz in hw_params operation
      ASoC: rockchip: Enable 192khz in hw_params operation

Ryan Lee (1):
      ASoC: Add support for Maxim Integrated MAX98927 Amplifier

Ryder Lee (2):
      ASoC: mediatek: Add mt2701-wm8960 machine driver
      ASoC: mediatek: add bindings for wm8960 codec machine driver

Sodhi, VunnyX (1):
      ASoC: Intel: Skylake: Add loadable module support on KBL platform

Stefan Agner (1):
      ASoC: fsl_asrc_dma: use correct direction enum type

Subhransu S. Prusty (3):
      ASoC: Intel: Skylake: Commonize library load
      ASoC: Intel: Skylake: Register dsp_fw_ops for kabylake
      ASoC: Intel: Skylake: Modify load_lib_ipc arguments for a nowait vers=
ion

Sylwester Nawrocki (2):
      ASoC: Add Odroid sound DT bindings documentation
      ASoC: samsung: Add Odroid ASoC machine driver

Takashi Iwai (6):
      ASoC: intel: Don't print FW version repeatedly
      ASoC: Provide a dummy wrapper of snd_soc_set_dmi_name()
      ASoC: Call snd_soc_set_dmi_name() unconditionally
      ASoC: bytcr_rt5640: Allow quirk set via module option
      ASoC: intel: Fix PM and non-atomic crash in bytcr drivers
      ASoC: bytcr_rt5640: Fix a typo and quirk parameter type

Takashi Sakamoto (2):
      ASoC: Intel: Skylake: use a helper macro to rounding-up calculation
      ASoC: Intel: Skylake: code cleanup for pin fixup limitation

Vinod Koul (4):
      ASoC: Intel: Skylake: Don't unload module when in use
      ASoC: Intel: Skylake: Remove redundant vmixer handler
      ASoC: Intel: Skylake: remove hard coded ACPI path
      ASoC: Intel: Skylake: Fix unused variable warning

Wolfram Sang (2):
      ASoC: rsnd: drop useles self-assignments
      ASoC: rsnd: check return value of init function

kbuild test robot (2):
      ASoC: cs35l35: fix semicolon.cocci warnings
      ASoC: rsnd: fix semicolon.cocci warnings

olivier moysan (2):
      ASoC: stm32: add bindings for SAI
      ASoC: stm32: add SAI driver

 .../devicetree/bindings/sound/cs35l35.txt          |  180 ++
 .../devicetree/bindings/sound/dioo,dio2125.txt     |   12 +
 .../devicetree/bindings/sound/everest,es7134.txt   |   10 +
 .../devicetree/bindings/sound/fsl,ssi.txt          |   34 +-
 .../bindings/sound/hisilicon,hi6210-i2s.txt        |   42 +
 .../devicetree/bindings/sound/max98925.txt         |   22 -
 .../devicetree/bindings/sound/max98926.txt         |   32 -
 .../devicetree/bindings/sound/max9892x.txt         |   41 +
 .../devicetree/bindings/sound/mt2701-wm8960.txt    |   24 +
 .../devicetree/bindings/sound/nau8824.txt          |   88 +
 .../devicetree/bindings/sound/rockchip-i2s.txt     |    1 +
 .../devicetree/bindings/sound/samsung,odroid.txt   |   57 +
 .../devicetree/bindings/sound/sgtl5000.txt         |    9 +
 .../devicetree/bindings/sound/st,stm32-sai.txt     |   89 +
 .../devicetree/bindings/sound/tas2552.txt          |   10 +-
 Documentation/devicetree/bindings/sound/wm8903.txt |   13 +
 .../devicetree/bindings/sound/zte,tdm.txt          |   30 +
 include/sound/cs35l35.h                            |  108 ++
 include/sound/soc.h                                |   14 +-
 sound/hda/hdac_controller.c                        |    2 +-
 sound/soc/Kconfig                                  |    2 +
 sound/soc/Makefile                                 |    2 +
 sound/soc/blackfin/bfin-eval-adau1373.c            |    2 +-
 sound/soc/blackfin/bfin-eval-adav80x.c             |    2 +-
 sound/soc/codecs/Kconfig                           |   30 +-
 sound/soc/codecs/Makefile                          |   10 +
 sound/soc/codecs/ak4613.c                          |   10 +-
 sound/soc/codecs/cs35l35.c                         | 1580 +++++++++++++++++
 sound/soc/codecs/cs35l35.h                         |  294 ++++
 sound/soc/codecs/cs4271.c                          |    2 +-
 sound/soc/codecs/cs53l30.c                         |    1 +
 sound/soc/codecs/da7213.c                          |   13 +
 sound/soc/codecs/dio2125.c                         |  120 ++
 sound/soc/codecs/es7134.c                          |  116 ++
 sound/soc/codecs/es8328.c                          |   51 +-
 sound/soc/codecs/hdac_hdmi.c                       |    4 +-
 sound/soc/codecs/max9867.c                         |    4 +-
 sound/soc/codecs/max98927.c                        |  841 +++++++++
 sound/soc/codecs/max98927.h                        |  272 +++
 sound/soc/codecs/nau8540.c                         | 1224 ++++++-------
 sound/soc/codecs/nau8540.h                         |  310 ++--
 sound/soc/codecs/nau8824.c                         | 1831 ++++++++++++++++=
++++
 sound/soc/codecs/nau8824.h                         |  466 +++++
 sound/soc/codecs/rt5514.c                          |   36 +-
 sound/soc/codecs/rt5645.c                          |   10 +
 sound/soc/codecs/rt5665.c                          |  222 ++-
 sound/soc/codecs/rt5665.h                          |    2 -
 sound/soc/codecs/rt5670.c                          |   21 +
 sound/soc/codecs/rt5677.c                          |    7 +
 sound/soc/codecs/sgtl5000.c                        |   19 +-
 sound/soc/codecs/ssm4567.c                         |    9 +
 sound/soc/codecs/sta529.c                          |    7 +
 sound/soc/codecs/tas2552.c                         |    6 +-
 sound/soc/codecs/tlv320aic23.c                     |    7 +-
 sound/soc/codecs/twl6040.c                         |    8 +
 sound/soc/codecs/uda1380.c                         |    7 +
 sound/soc/codecs/wm5100.c                          |    2 +-
 sound/soc/codecs/wm8903.c                          |   31 +
 sound/soc/codecs/wm8960.c                          |  195 ++-
 sound/soc/codecs/wm8978.c                          |    7 +
 sound/soc/codecs/wm_adsp.c                         |  324 +++-
 sound/soc/codecs/wm_adsp.h                         |   24 +
 sound/soc/dwc/Kconfig                              |    4 +-
 sound/soc/dwc/Makefile                             |    6 +-
 sound/soc/dwc/{designware_i2s.c =3D> dwc-i2s.c}      |    0
 sound/soc/dwc/{designware_pcm.c =3D> dwc-pcm.c}      |    3 -
 sound/soc/fsl/eukrea-tlv320.c                      |    2 +-
 sound/soc/fsl/fsl_asrc_dma.c                       |    2 +-
 sound/soc/fsl/fsl_esai.c                           |    5 +-
 sound/soc/fsl/fsl_ssi.c                            |   27 +-
 sound/soc/fsl/imx-mc13783.c                        |    2 +-
 sound/soc/fsl/imx-pcm-dma.c                        |   28 -
 sound/soc/fsl/imx-pcm-fiq.c                        |    2 +-
 sound/soc/fsl/imx-wm8962.c                         |   72 +-
 sound/soc/fsl/mpc8610_hpcd.c                       |    2 +-
 sound/soc/fsl/mx27vis-aic32x4.c                    |    2 +-
 sound/soc/fsl/p1022_ds.c                           |    2 +-
 sound/soc/fsl/p1022_rdk.c                          |    2 +-
 sound/soc/fsl/phycore-ac97.c                       |    2 +-
 sound/soc/fsl/wm1133-ev1.c                         |    2 +-
 sound/soc/generic/simple-card.c                    |   43 +-
 sound/soc/generic/simple-scu-card.c                |   37 +-
 sound/soc/hisilicon/Kconfig                        |    5 +
 sound/soc/hisilicon/Makefile                       |    1 +
 sound/soc/hisilicon/hi6210-i2s.c                   |  618 +++++++
 sound/soc/hisilicon/hi6210-i2s.h                   |  276 +++
 sound/soc/intel/Kconfig                            |   24 +
 sound/soc/intel/atom/sst/sst_acpi.c                |   41 +-
 sound/soc/intel/atom/sst/sst_ipc.c                 |    4 +-
 sound/soc/intel/boards/Makefile                    |    4 +
 sound/soc/intel/boards/bdw-rt5677.c                |    5 +-
 sound/soc/intel/boards/broadwell.c                 |    3 -
 sound/soc/intel/boards/bxt_da7219_max98357a.c      |   97 +-
 sound/soc/intel/boards/bxt_rt298.c                 |    3 +
 sound/soc/intel/boards/bytcht_da7213.c             |  283 +++
 sound/soc/intel/boards/bytcht_nocodec.c            |  208 +++
 sound/soc/intel/boards/bytcr_rt5640.c              |  113 +-
 sound/soc/intel/boards/bytcr_rt5651.c              |    2 -
 sound/soc/intel/haswell/sst-haswell-ipc.c          |    6 -
 sound/soc/intel/skylake/bxt-sst.c                  |  118 +-
 sound/soc/intel/skylake/skl-messages.c             |   16 +-
 sound/soc/intel/skylake/skl-nhlt.c                 |    7 +-
 sound/soc/intel/skylake/skl-pcm.c                  |  118 +-
 sound/soc/intel/skylake/skl-sst-cldma.c            |   26 +-
 sound/soc/intel/skylake/skl-sst-cldma.h            |    2 +-
 sound/soc/intel/skylake/skl-sst-dsp.c              |    6 +-
 sound/soc/intel/skylake/skl-sst-dsp.h              |   40 +-
 sound/soc/intel/skylake/skl-sst-ipc.c              |   76 +-
 sound/soc/intel/skylake/skl-sst-ipc.h              |   17 +-
 sound/soc/intel/skylake/skl-sst-utils.c            |  140 +-
 sound/soc/intel/skylake/skl-sst.c                  |  175 +-
 sound/soc/intel/skylake/skl-topology.c             |  247 ++-
 sound/soc/intel/skylake/skl-topology.h             |   17 +-
 sound/soc/intel/skylake/skl.c                      |    2 +-
 sound/soc/intel/skylake/skl.h                      |    1 +
 sound/soc/mediatek/Kconfig                         |   10 +
 sound/soc/mediatek/mt2701/Makefile                 |    1 +
 sound/soc/mediatek/mt2701/mt2701-afe-pcm.c         |   16 +
 sound/soc/mediatek/mt2701/mt2701-cs42448.c         |    2 +-
 sound/soc/mediatek/mt2701/mt2701-wm8960.c          |  176 ++
 sound/soc/mediatek/mt8173/mt8173-max98090.c        |    2 +-
 sound/soc/mediatek/mt8173/mt8173-rt5650-rt5514.c   |    2 +-
 sound/soc/mediatek/mt8173/mt8173-rt5650-rt5676.c   |    2 +-
 sound/soc/mediatek/mt8173/mt8173-rt5650.c          |    2 +-
 sound/soc/omap/am3517evm.c                         |    2 +-
 sound/soc/omap/n810.c                              |    2 +-
 sound/soc/omap/omap-abe-twl6040.c                  |    2 +-
 sound/soc/omap/omap-twl4030.c                      |    2 +-
 sound/soc/omap/omap3pandora.c                      |    2 +-
 sound/soc/omap/osk5912.c                           |    2 +-
 sound/soc/omap/rx51.c                              |    7 +-
 sound/soc/pxa/brownstone.c                         |    2 +-
 sound/soc/pxa/corgi.c                              |    2 +-
 sound/soc/pxa/e750_wm9705.c                        |    2 +-
 sound/soc/pxa/e800_wm9712.c                        |    2 +-
 sound/soc/pxa/em-x270.c                            |    2 +-
 sound/soc/pxa/hx4700.c                             |    2 +-
 sound/soc/pxa/imote2.c                             |    2 +-
 sound/soc/pxa/magician.c                           |    4 +-
 sound/soc/pxa/mioa701_wm9713.c                     |    2 +-
 sound/soc/pxa/mmp-pcm.c                            |    1 -
 sound/soc/pxa/mmp-sspa.c                           |    1 -
 sound/soc/pxa/poodle.c                             |    2 +-
 sound/soc/pxa/pxa-ssp.c                            |   15 +-
 sound/soc/pxa/pxa2xx-ac97.c                        |    5 +-
 sound/soc/pxa/pxa2xx-i2s.c                         |    8 +-
 sound/soc/pxa/pxa2xx-pcm.c                         |    2 +-
 sound/soc/pxa/raumfeld.c                           |    8 +-
 sound/soc/pxa/spitz.c                              |    6 +-
 sound/soc/pxa/tosa.c                               |    4 +-
 sound/soc/pxa/z2.c                                 |    6 +-
 sound/soc/pxa/zylonite.c                           |    2 +-
 sound/soc/qcom/lpass-apq8016.c                     |   12 +
 sound/soc/qcom/lpass-cpu.c                         |   22 +-
 sound/soc/qcom/lpass-ipq806x.c                     |    6 +
 sound/soc/qcom/lpass.h                             |    2 +
 sound/soc/rockchip/rk3288_hdmi_analog.c            |    3 +
 sound/soc/samsung/Kconfig                          |    8 +
 sound/soc/samsung/Makefile                         |    2 +
 sound/soc/samsung/bells.c                          |    1 -
 sound/soc/samsung/i2s-regs.h                       |    2 -
 sound/soc/samsung/i2s.c                            |    1 -
 sound/soc/samsung/odroid.c                         |  219 +++
 sound/soc/samsung/s3c-i2s-v2.c                     |    1 -
 sound/soc/sh/rcar/adg.c                            |   75 +-
 sound/soc/sh/rcar/core.c                           |  111 +-
 sound/soc/sh/rcar/dvc.c                            |   24 +-
 sound/soc/sh/rcar/rsnd.h                           |   55 +-
 sound/soc/sh/rcar/src.c                            |    3 +-
 sound/soc/sh/rcar/ssi.c                            |    9 +
 sound/soc/sirf/sirf-audio-port.c                   |    1 +
 sound/soc/sirf/sirf-audio.c                        |    1 +
 sound/soc/sirf/sirf-usp.c                          |    3 +
 sound/soc/soc-core.c                               |   27 +-
 sound/soc/soc-jack.c                               |   48 +
 sound/soc/soc-topology.c                           |    6 +-
 sound/soc/sti/uniperif.h                           |    1 +
 sound/soc/sti/uniperif_player.c                    |   37 +-
 sound/soc/sti/uniperif_reader.c                    |   24 +-
 sound/soc/stm/Kconfig                              |    8 +
 sound/soc/stm/Makefile                             |    6 +
 sound/soc/stm/stm32_sai.c                          |  115 ++
 sound/soc/stm/stm32_sai.h                          |  200 +++
 sound/soc/stm/stm32_sai_sub.c                      |  884 ++++++++++
 sound/soc/sunxi/sun8i-codec-analog.c               |  168 +-
 sound/soc/sunxi/sun8i-codec.c                      |   10 +-
 sound/soc/tegra/tegra20_ac97.c                     |    1 -
 sound/soc/tegra/tegra20_das.c                      |    2 +-
 sound/soc/tegra/tegra20_i2s.c                      |    1 -
 sound/soc/tegra/tegra20_spdif.c                    |    5 +-
 sound/soc/tegra/tegra30_ahub.c                     |    5 +-
 sound/soc/tegra/tegra30_i2s.c                      |    1 -
 sound/soc/tegra/tegra_alc5632.c                    |    4 +-
 sound/soc/tegra/tegra_max98090.c                   |    4 +-
 sound/soc/tegra/tegra_rt5640.c                     |    4 +-
 sound/soc/tegra/tegra_sgtl5000.c                   |    4 +-
 sound/soc/tegra/tegra_wm8753.c                     |    4 +-
 sound/soc/tegra/tegra_wm8903.c                     |    4 +-
 sound/soc/tegra/tegra_wm9712.c                     |    4 +-
 sound/soc/tegra/trimslice.c                        |    4 +-
 sound/soc/txx9/txx9aclc.c                          |    5 +-
 sound/soc/ux500/mop500.c                           |    4 -
 sound/soc/ux500/ux500_msp_dai.c                    |    4 +-
 sound/soc/ux500/ux500_msp_i2s.c                    |    1 -
 sound/soc/zte/Kconfig                              |    8 +
 sound/soc/zte/Makefile                             |    1 +
 sound/soc/zte/zx-tdm.c                             |  461 +++++
 207 files changed, 12860 insertions(+), 1973 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/cs35l35.txt
 create mode 100644 Documentation/devicetree/bindings/sound/dioo,dio2125.txt
 create mode 100644 Documentation/devicetree/bindings/sound/everest,es7134.=
txt
 create mode 100644 Documentation/devicetree/bindings/sound/hisilicon,hi621=
0-i2s.txt
 delete mode 100644 Documentation/devicetree/bindings/sound/max98925.txt
 delete mode 100644 Documentation/devicetree/bindings/sound/max98926.txt
 create mode 100644 Documentation/devicetree/bindings/sound/max9892x.txt
 create mode 100644 Documentation/devicetree/bindings/sound/mt2701-wm8960.t=
xt
 create mode 100644 Documentation/devicetree/bindings/sound/nau8824.txt
 create mode 100644 Documentation/devicetree/bindings/sound/samsung,odroid.=
txt
 create mode 100644 Documentation/devicetree/bindings/sound/st,stm32-sai.txt
 create mode 100644 Documentation/devicetree/bindings/sound/zte,tdm.txt
 create mode 100644 include/sound/cs35l35.h
 create mode 100644 sound/soc/codecs/cs35l35.c
 create mode 100644 sound/soc/codecs/cs35l35.h
 create mode 100644 sound/soc/codecs/dio2125.c
 create mode 100644 sound/soc/codecs/es7134.c
 create mode 100644 sound/soc/codecs/max98927.c
 create mode 100644 sound/soc/codecs/max98927.h
 create mode 100644 sound/soc/codecs/nau8824.c
 create mode 100644 sound/soc/codecs/nau8824.h
 rename sound/soc/dwc/{designware_i2s.c =3D> dwc-i2s.c} (100%)
 rename sound/soc/dwc/{designware_pcm.c =3D> dwc-pcm.c} (98%)
 create mode 100644 sound/soc/hisilicon/Kconfig
 create mode 100644 sound/soc/hisilicon/Makefile
 create mode 100644 sound/soc/hisilicon/hi6210-i2s.c
 create mode 100644 sound/soc/hisilicon/hi6210-i2s.h
 create mode 100644 sound/soc/intel/boards/bytcht_da7213.c
 create mode 100644 sound/soc/intel/boards/bytcht_nocodec.c
 create mode 100644 sound/soc/mediatek/mt2701/mt2701-wm8960.c
 create mode 100644 sound/soc/samsung/odroid.c
 create mode 100644 sound/soc/stm/Kconfig
 create mode 100644 sound/soc/stm/Makefile
 create mode 100644 sound/soc/stm/stm32_sai.c
 create mode 100644 sound/soc/stm/stm32_sai.h
 create mode 100644 sound/soc/stm/stm32_sai_sub.c
 create mode 100644 sound/soc/zte/zx-tdm.c

--amrkqr4cnb3fko3x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlkH9YwACgkQJNaLcl1U
h9ALVwf/YwHMXEUlf6GOhjoOMZ4dPqI8KD0iLps5b5kOkduxOARtTC8/o2ZWOi/B
NkKrcRRyij0BkkHvZApG5jMyxD+cgTNvpWeaxMSLomQFFUEmsCEKFxyYehvW/2Qd
/giwrx2cjTu+HDGSGFsq1OQLB0Hmc+SxM2EI08Ir8BO8EIz4jzh9b8279TwLilWL
I2IXR3bgfDrn0IH7CtBZEtGWDyzPBKhPz0pemQGH6D63IeWplL8aStuFITgMujv+
FM/sLZRzGFagGnud52OISczdkQxqHkDxPXZf4iMKJuZszlHGh02Aw8++2dsTxjIF
oU1mySpNQPPS9V65Y3aPlx/k4phxzA==
=Fv41
-----END PGP SIGNATURE-----

--amrkqr4cnb3fko3x--

--===============2099262759967424691==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2099262759967424691==--
