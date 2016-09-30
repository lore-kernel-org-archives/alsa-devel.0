From: Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] ASoC updates for v4.9
Date: Fri, 30 Sep 2016 09:22:55 -0700
Message-ID: <20160930162255.w7z4ysjtiagn4ofj@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3423890584442178075=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C80592668F1
 for <alsa-devel@alsa-project.org>; Fri, 30 Sep 2016 18:23:09 +0200 (CEST)
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


--===============3423890584442178075==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ps6nwmesa4wbqj7j"
Content-Disposition: inline


--ps6nwmesa4wbqj7j
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The following changes since commit 08895a8b6b06ed2323cd97a36ee40a116b3db8ed:

  Linux 4.8-rc8 (2016-09-25 18:47:13 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc=
-v4.9

for you to fetch changes up to 513e43efafe329dad7b5794583b67ac898dcbdca:

  Merge remote-tracking branches 'asoc/topic/tpa6130a2', 'asoc/topic/ux500'=
, 'asoc/topic/wm8960', 'asoc/topic/wm8962' and 'asoc/topic/wm8991' into aso=
c-next (2016-09-29 12:44:49 -0700)

----------------------------------------------------------------
ASoC: Updates for v4.9

Apart from the cleanups done by Morimoto-san this has very much been a
driver focused release with very little generic change:

 - A big factoring out of the simple-card code to allow it to be shared
   more with the rcar generic card from Kuninori Morimoto.
 - Removal of some operations duplicated on the CODEC level, again by
   Kuninori Morimoto.
 - Lots more machine support for x86 systems.
 - New drivers for Nuvoton NAU88C10, Realtek RT5660 and RT5663.

----------------------------------------------------------------
Adam Thomson (9):
      ASoC: da7213: Improve driver efficiency with regards to MCLK usage
      ASoC: da7213: Refactor sysclk(), pll() functions to improve handling
      ASoC: da7213: Improve 32KHz mode PLL locking
      ASoC: da7219: Make more efficient use of MCLK within driver
      ASoC: da7218: Remove 32KHz PLL mode from driver
      ASoC: da7218: Improve driver efficiency with regards to MCLK usage
      ASoC: da7219: Support HP detect procedure when MCLK not present
      ASoC: da7219: Reset codec gracefully, if still active
      ASoC: da7219: Disable AAD if codec is not a wake-up source

Arnaud Pouliquen (2):
      ASoC: sti: suppress inappropriate DT fields
      ASoC: sti: suppress inappropriate fields for sti sound card

Arnd Bergmann (3):
      ASoC: rockchip: use SPI dependency for rt5514
      ASoC: rt5663: refine error handling
      ASoC: cq93vc: duplicated callback function goes to component

Axel Lin (4):
      ASoC: cs53l30: Constify cs53l30_mclk_coeffs and cs53l30_mclkx_coeffs =
tables
      ASoC: cs53l30: Constify cs53l30_mclk_coeffs and cs53l30_mclkx_coeffs =
tables
      ASoC: cs42l73: Constify cs42l73_mclk_coeffs and cs42l73_mclkx_coeffs =
tables
      ASoC: nau8810: Fix memory leak in nau8810_eq_put error path

Baoyou Xie (3):
      ASoC: atmel-pdmic: mark symbols static where possible
      ASoC: mediatek: mark symbols static where possible
      ASoC: fix W=3D1 build warnings

Bard Liao (1):
      ASoC: add rt5663 codec driver

Bhaktipriya Shridhar (1):
      ASoC: tlv320dac33: Remove deprecated create_singlethread_workqueue

Charles Keepax (13):
      ASoC: arizona: Connect ASRCs to both clock domains
      ASoC: arizona: Correct handling of FLL theta in synchroniser mode
      ASoC: arizona: Allow specification of base for arizona_is_enabled_fll
      ASoC: arizona: Avoid changing SYNC_ENA whilst the FLL_ENA is set
      ASoC: wm_adsp: Separate concept of booted and running
      ASoC: wm_adsp: Move control cache sync out of preloader
      ASoC: arizona: Attach SYSCLK to DSP preloaders
      ASoC: wm_adsp: Make DSP preloader a supply widget
      ASoC: wm_adsp: Use usleep_range for short delay
      ASoC: wm_adsp: Put DSP into low power state between loading and runni=
ng
      ASoC: wm_adsp: Allow preloader to do the final shutdown of the DSP
      ASoC: arizona: Add debug prints for output power up/down times
      ASoC: arizona: Add output power up/down delays for speaker path

Chen-Yu Tsai (3):
      ASoC: dapm: Fix possible uninitialized variable in snd_soc_dapm_get_v=
olsw()
      ASoC: dapm: Fix value setting for _ENUM_DOUBLE MUX's second channel
      ASoC: dapm: Fix kcontrol creation for output driver widget

Cheng-Yi Chiang (1):
      ASoC: rockchip: Support headset button function on rk3399

Christophe JAILLET (1):
      ASoC: omap-pcm: off-by-one in 'omap_pcm_limit_supported_formats'

Colin Ian King (13):
      ASoC: Intel: sst: fix ix spelling mistake: "capablities" -> "capabili=
tes"
      ASoC: tas5086: fix typo: "Inavlid" -> "Invalid"
      ASoC: wm8962: fix spelling mistake "mesurement" -> "measurement"
      ASoC: hdac_hdmi: fix spelling mistake "montior" -> "monitor"
      ASoC: fsl_esai: fix spelling mistake "Transmition" -> "Transmission"
      ASoC: ux500: fix spelling mistake "Unsopported" -> "Unsupported"
      ASoC: Intel: sst: fix to spelling mistake: "susupend" -> "suspend"
      ASoC: Intel: Skylake: add missing \n to end of dev_* messages
      ASoC: max98926: add missing \n to end of dev_err/dev_dbg messages
      ASoC: samsung: add missing \n to end of pr_err messages
      ASoC: Intel: atom: add missing \n to end of dev_err/dev_dbg messages
      ASoC: Intel: remove status, it is shadowing status of a higher scope
      ASoC: Intel: Skylake: fix memory leak of module on error exit path

Danny Milosavljevic (3):
      ASoC: sun4i-codec: Rename some sun7i-only registers
      ASoC: sun4i-codec: Add custom regmap configs
      ASoC: sun4i-codec: Rename sun4i_codec_widgets for consistency

Dharageswari R (6):
      ASoC: Intel: Skylake: modify snd_skl_get_module_info args
      ASoC: Intel: Skylake: Unload all the loadable modules
      ASoC: Intel: Skylake: Add module instance id generation APIs
      ASoC: Intel: Skylake: Use private instance id of modules in IPC
      ASoC: Intel: Skylake: Update to use instance ids generated
      ASoC: Intel: Skylake: Add table for module id for quick ref

Fabio Estevam (4):
      ASoC: fsl_sai: Use 'np' variable
      ASoC: fsl_asrc: Propagate the real error code
      ASoC: fsl_asrc: Remove unneeded driver registration message
      ASoC: fsl_asrc: Use np variable

Guneshwor Singh (2):
      ALSA - hda: Add support for parsing new HDA capabilities
      ALSA - hda: Add support for link audio time reporting

Harsha Priya (1):
      ASoC: Intel: Atom: Fix message handling during drop stream

Hsin-Yu Chao (1):
      ASoC: da7219: software reset codec at probe

Irina Tirdea (2):
      ASoC: Intel: bytcr_rt5640: add MCLK support
      AsoC: Intel: Add quirks for MinnowBoard MAX

Jaswinder Jassal (1):
      ASoC: core: fix shift used for second item in snd_soc_get_enum_double

Jeeja KP (2):
      ASoC: Intel: Skylake: Fix DMA control config size
      ASoC: dpcm: Don't apply symmetry for BE with hw param fixup

John Hsu (3):
      ASoC: nau8810: Add driver for Nuvoton codec chip NAU88C10
      ASoC: nau8810: fix compile warning in loopback switch control
      ASoC: nau8825: fix bug in FLL parameter

John Keeping (2):
      ASoC: rt5677: Add ACPI support
      ASoC: Intel: boards: Add bdw-rt5677 machine driver

Julia Lawall (5):
      ASoC: use of_property_read_bool
      ASoC: constify snd_soc_codec_driver structures
      ASoC: constify snd_pcm_ops structures
      ASoC: ac97: constify gpio_chip structures
      ASoC: constify gpio_chip structures

Kranthi G (1):
      ASoC: Intel: Skylake: add support for tplg manifest load

Kuninori Morimoto (203):
      ASoC: simple-card: use asoc_simple_card_parse_clk()
      ASoC: rsrc-card: use asoc_simple_card_parse_clk()
      ASoC: simple-card-utils: add asoc_simple_card_parse_clk()
      ASoC: simple-card-utils: add asoc_simple_card_parse_dai()
      ASoC: simple-card: use asoc_simple_card_parse_dai()
      ASoC: rsrc-card: use asoc_simple_card_parse_dai()
      ASoC: simple-card: remove asoc_simple_card_sub_parse_of()
      ASoC: hdmi-codec: enable multi probe for same device
      ASoC: codec duplicated callback function goes to component on sun4i-c=
odec
      ASoC: codec duplicated callback function goes to component on pistach=
io-internal-dac
      ASoC: remove codec duplicated callback function
      ASoC: codec duplicated callback function goes to component on wm8985
      ASoC: codec duplicated callback function goes to component on wm8978
      ASoC: codec duplicated callback function goes to component on wm8974
      ASoC: codec duplicated callback function goes to component on wm8903
      ASoC: codec duplicated callback function goes to component on wm8804
      ASoC: codec duplicated callback function goes to component on wm8776
      ASoC: codec duplicated callback function goes to component on wm8770
      ASoC: codec duplicated callback function goes to component on wm8753
      ASoC: codec duplicated callback function goes to component on wm8750
      ASoC: codec duplicated callback function goes to component on wm8741
      ASoC: codec duplicated callback function goes to component on wm8737
      ASoC: codec duplicated callback function goes to component on wm8731
      ASoC: codec duplicated callback function goes to component on wm8728
      ASoC: codec duplicated callback function goes to component on wm8711
      ASoC: codec duplicated callback function goes to component on wm8580
      ASoC: codec duplicated callback function goes to component on wm8523
      ASoC: codec duplicated callback function goes to component on wm8510
      ASoC: codec duplicated callback function goes to component on tlv320a=
ic3x
      ASoC: codec duplicated callback function goes to component on tlv320a=
ic31xx
      ASoC: codec duplicated callback function goes to component on tlv320a=
ic23
      ASoC: codec duplicated callback function goes to component on tfa9879
      ASoC: codec duplicated callback function goes to component on tas5720
      ASoC: codec duplicated callback function goes to component on tas571x
      ASoC: codec duplicated callback function goes to component on tas5086
      ASoC: codec duplicated callback function goes to component on tas2552
      ASoC: codec duplicated callback function goes to component on sti-sas
      ASoC: codec duplicated callback function goes to component on sta350
      ASoC: codec duplicated callback function goes to component on sta32x
      ASoC: codec duplicated callback function goes to component on ssm4567
      ASoC: codec duplicated callback function goes to component on ssm2602
      ASoC: codec duplicated callback function goes to component on spdif_t=
ransmitter
      ASoC: codec duplicated callback function goes to component on spdif_r=
eceiver
      ASoC: codec duplicated callback function goes to component on sgtl5000
      ASoC: codec duplicated callback function goes to component on rt5631
      ASoC: codec duplicated callback function goes to component on rt5616
      ASoC: codec duplicated callback function goes to component on pcm512x
      ASoC: codec duplicated callback function goes to component on pcm3168a
      ASoC: codec duplicated callback function goes to component on pcm179x
      ASoC: codec duplicated callback function goes to component on pcm1681
      ASoC: codec duplicated callback function goes to component on max9860
      ASoC: codec duplicated callback function goes to component on inno_rk=
3036
      ASoC: codec duplicated callback function goes to component on gtm601
      ASoC: codec duplicated callback function goes to component on es8328
      ASoC: codec duplicated callback function goes to component on cs53l30
      ASoC: codec duplicated callback function goes to component on cs4349
      ASoC: codec duplicated callback function goes to component on cs42xx8
      ASoC: codec duplicated callback function goes to component on cs42l73
      ASoC: codec duplicated callback function goes to component on cs42l56
      ASoC: codec duplicated callback function goes to component on cs42l52
      ASoC: codec duplicated callback function goes to component on cs42l51
      ASoC: codec duplicated callback function goes to component on cs4271
      ASoC: codec duplicated callback function goes to component on cs4270
      ASoC: codec duplicated callback function goes to component on cs4265
      ASoC: codec duplicated callback function goes to component on cs35l33
      ASoC: codec duplicated callback function goes to component on cs35l32
      ASoC: codec duplicated callback function goes to component on bt-sco
      ASoC: codec duplicated callback function goes to component on ak5386
      ASoC: codec duplicated callback function goes to component on ak4642
      ASoC: codec duplicated callback function goes to component on ak4613
      ASoC: codec duplicated callback function goes to component on ak4554
      ASoC: codec duplicated callback function goes to component on ak4104
      ASoC: codec duplicated callback function goes to component on adau7002
      ASoC: codec duplicated callback function goes to component on adau1701
      ASoC: codec duplicated callback function goes to component on ac97
      ASoC: codec duplicated callback function goes to component on ad1980
      ASoC: codec duplicated callback function goes to component on ad73311
      ASoC: codec duplicated callback function goes to component on adau1373
      ASoC: codec duplicated callback function goes to component on ad1836
      ASoC: codec duplicated callback function goes to component on ad193x
      ASoC: codec duplicated callback function goes to component on 88pm860=
x-codec
      ASoC: codec duplicated callback function goes to component on atmel-c=
lassd
      ASoC: codec duplicated callback function goes to component on atmel-p=
dmic
      ASoC: codec duplicated callback function goes to component on ab8500-=
codec
      ASoC: codec duplicated callback function goes to component on adau1761
      ASoC: codec duplicated callback function goes to component on adau1781
      ASoC: codec duplicated callback function goes to component on adau1977
      ASoC: codec duplicated callback function goes to component on adav80x
      ASoC: codec duplicated callback function goes to component on ads117x
      ASoC: codec duplicated callback function goes to component on ak4535
      ASoC: codec duplicated callback function goes to component on ak4641
      ASoC: codec duplicated callback function goes to component on ak4671
      ASoC: codec duplicated callback function goes to component on alc5632
      ASoC: codec duplicated callback function goes to component on cs47l24
      ASoC: codec duplicated callback function goes to component on cx20442
      ASoC: codec duplicated callback function goes to component on da7210
      ASoC: codec duplicated callback function goes to component on da7213
      ASoC: codec duplicated callback function goes to component on da7218
      ASoC: codec duplicated callback function goes to component on da7219
      ASoC: codec duplicated callback function goes to component on da732x
      ASoC: codec duplicated callback function goes to component on da9055
      ASoC: codec duplicated callback function goes to component on dmic
      ASoC: codec duplicated callback function goes to component on hdmi-co=
dec
      ASoC: codec duplicated callback function goes to component on isabelle
      ASoC: codec duplicated callback function goes to component on jz4740
      ASoC: codec duplicated callback function goes to component on lm49453
      ASoC: codec duplicated callback function goes to component on wm98088
      ASoC: codec duplicated callback function goes to component on wm98095
      ASoC: codec duplicated callback function goes to component on wm98357a
      ASoC: codec duplicated callback function goes to component on wm9850
      ASoC: codec duplicated callback function goes to component on wm9867
      ASoC: codec duplicated callback function goes to component on max98925
      ASoC: codec duplicated callback function goes to component on max98926
      ASoC: codec duplicated callback function goes to component on mc13783
      ASoC: codec duplicated callback function goes to component on ml26124
      ASoC: codec duplicated callback function goes to component on nau8825
      ASoC: codec duplicated callback function goes to component on pcm3008
      ASoC: codec duplicated callback function goes to component on rt286
      ASoC: codec duplicated callback function goes to component on rt298
      ASoC: codec duplicated callback function goes to component on rt5514
      ASoC: codec duplicated callback function goes to component on rt5640
      ASoC: codec duplicated callback function goes to component on rt5645
      ASoC: codec duplicated callback function goes to component on rt5651
      ASoC: codec duplicated callback function goes to component on rt5659
      ASoC: codec duplicated callback function goes to component on rt5670
      ASoC: codec duplicated callback function goes to component on rt5677
      ASoC: codec duplicated callback function goes to component on si476x
      ASoC: codec duplicated callback function goes to component on sn95031
      ASoC: codec duplicated callback function goes to component on ssm2518
      ASoC: codec duplicated callback function goes to component on sta529
      ASoC: codec duplicated callback function goes to component on stac9766
      ASoC: codec duplicated callback function goes to component on tlv320a=
ic26
      ASoC: codec duplicated callback function goes to component on tlv320a=
ic32x4
      ASoC: codec duplicated callback function goes to component on tlv320d=
ac33
      ASoC: codec duplicated callback function goes to component on twl4030
      ASoC: codec duplicated callback function goes to component on twl6040
      ASoC: codec duplicated callback function goes to component on uda134x
      ASoC: codec duplicated callback function goes to component on uda1380
      ASoC: codec duplicated callback function goes to component on wl1273
      ASoC: codec duplicated callback function goes to component on wm0010
      ASoC: codec duplicated callback function goes to component on wm1250-=
ev1
      ASoC: codec duplicated callback function goes to component on wm2000
      ASoC: codec duplicated callback function goes to component on wm2200
      ASoC: codec duplicated callback function goes to component on wm5100
      ASoC: codec duplicated callback function goes to component on wm5102
      ASoC: codec duplicated callback function goes to component on wm5110
      ASoC: codec duplicated callback function goes to component on wm8350
      ASoC: codec duplicated callback function goes to component on wm8400
      ASoC: codec duplicated callback function goes to component on wm8727
      ASoC: codec duplicated callback function goes to component on wm8782
      ASoC: codec duplicated callback function goes to component on wm8900
      ASoC: codec duplicated callback function goes to component on wm8940
      ASoC: codec duplicated callback function goes to component on wm8955
      ASoC: codec duplicated callback function goes to component on wm8961
      ASoC: codec duplicated callback function goes to component on wm8971
      ASoC: codec duplicated callback function goes to component on wm8983
      ASoC: codec duplicated callback function goes to component on wm8988
      ASoC: codec duplicated callback function goes to component on wm8990
      ASoC: codec duplicated callback function goes to component on wm8991
      ASoC: codec duplicated callback function goes to component on wm8995
      ASoC: codec duplicated callback function goes to component on wm8996
      ASoC: codec duplicated callback function goes to component on wm8997
      ASoC: codec duplicated callback function goes to component on wm8998
      ASoC: codec duplicated callback function goes to component on wm9081
      ASoC: codec duplicated callback function goes to component on wm9705
      ASoC: codec duplicated callback function goes to component on wm9712
      ASoC: codec duplicated callback function goes to component on wm9713
      ASoC: lpass-platform: don't use snd_soc_pcm_set_drvdata()
      ASoC: remove snd_soc_pcm_set/get_drvdata()
      ASoC: simple-card-utils: add asoc_simple_card_init_dai()
      ASoC: simple-card: use asoc_simple_card_init_dai()
      ASoC: simple-card-utils: add asoc_simple_card_canonicalize_dailink()
      ASoC: simple-card: use asoc_simple_card_canonicalize_dailink()
      ASoC: rsrc-card: use asoc_simple_card_init_dai()
      ASoC: rsrc-card: use asoc_simple_card_canonicalize_dailink()
      ASoC: simple-card-utils: add asoc_simple_card_canonicalize_cpu()
      ASoC: simple-card: use asoc_simple_card_canonicalize_cpu()
      ASoC: rsrc-card: use asoc_simple_card_canonicalize_cpu()
      ASoC: simple-card-utils: add asoc_simple_card_clean_reference()
      ASoC: simple-card: use asoc_simple_card_clean_reference()
      ASoC: rsrc-card: use asoc_simple_card_clean_reference()
      ASoC: rsrc-card: remove board specific compatible
      ASoC: rsrc-card: rename rsrc-card to simple-scu-card phase1
      ASoC: rsrc-card: rename rsrc-card to simple-scu-card phase2
      ASoC: rsrc-card: rename rsrc-card to simple-scu-card phase3
      ASoC: simple-scu-card: remove unused definitions
      ASoC: simple-scu-card: is GPL v2
      ASoC: simple-scu-card: tidyup codec daifmt handling method
      ASoC: simple-scu-card: tidyup asoc_simple_card_parse_links() method
      ASoC: simple-scu-card: depends on CONFIG_OF
      ASoC: simple-scu-card: add 2 CPU 1 Codec example
      ASoC: simple-scu-card: code sync: move asoc_simple_card_of_match
      ASoC: simple-scu-card: code sync: tidyup TDM setting position
      ASoC: simple-card: call of_node_put() for dai_link
      ASoC: simple-card: tidyup mclk-fs of_property_read_u32() usage
      ASoC: simple-card: code sync: tidyup simple_priv_to_xxx() macro
      ASoC: simple-card: code sync: use simple_priv_to_props() macro
      ASoC: simple-card: is GPL v2
      ASoC: simple-card: code sync: tidyup white line
      ASoC: simple-card: code sync: use tag
      ASoC: simple-card: code sync: rename num_link to num
      ASoC: simple-card: use kzalloc() for dai_props / dai_link
      ASoC: rsnd: add SNDRV_PCM_TRIGGER_SUSPEND/RESUME

Marcel Ziswiler (1):
      ASoC: tegra: add tegra sgtl5000 machine driver

Marcus Cooper (2):
      ASoC: sunxi: Add bindings for sun6i to SPDIF
      ASoC: sunxi: compatibility for sun6i to SPDIF

Marek Vasut (6):
      ASoC: fsl_asrc: use flat regmap cache
      ASoC: fsl_esai: use flat regmap cache
      ASoC: fsl_spdif: use flat regmap cache
      ASoC: fsl_ssi: use flat regmap cache
      ASoC: fsl_ssi: Remove .num_reg_defaults_raw from regmap_config
      ASoC: trivial: system spelling fix

Mark Brown (30):
      Merge branch 'fix/simple' of git://git.kernel.org/.../broonie/sound i=
nto asoc-simple
      Merge branch 'topic/hda-link-time' of git://git.kernel.org/.../tiwai/=
sound into asoc-intel
      Merge branch 'topic/rt5640' of git://git.kernel.org/.../broonie/sound=
 into asoc-intel
      Merge branch 'fix/omap' of git://git.kernel.org/.../broonie/sound int=
o asoc-omap
      Merge branch 'topic/simple' of git://git.kernel.org/.../broonie/sound=
 into asoc-rcar
      Merge tag 'asoc-fix-v4.8-rc4' into asoc-arizona
      Merge branch 'topic/rt5663' of git://git.kernel.org/.../broonie/sound=
 into asoc-rt5660
      ASoC: hdac_hdmi: Drop use of audio component framework to read ELD
      Merge branch 'topic/codec-component' of git://git.kernel.org/.../broo=
nie/sound into asoc-sunxi
      Merge branch 'fix/da7219' of git://git.kernel.org/.../broonie/sound i=
nto asoc-da7219
      ASoC: fsl: Fix lockups with recent cache changes
      Merge remote-tracking branch 'asoc/fix/dapm' into asoc-linus
      Merge remote-tracking branch 'asoc/fix/intel' into asoc-linus
      Merge remote-tracking branches 'asoc/fix/arizona', 'asoc/fix/da7219',=
 'asoc/fix/nau8825', 'asoc/fix/rt5514' and 'asoc/fix/shift' into asoc-linus
      Merge remote-tracking branch 'asoc/fix/tpa6130a2' into asoc-linus
      Merge remote-tracking branch 'asoc/topic/dapm' into asoc-next
      Merge remote-tracking branch 'asoc/topic/intel' into asoc-next
      Merge remote-tracking branch 'asoc/topic/pcm' into asoc-next
      Merge remote-tracking branch 'asoc/topic/rcar' into asoc-next
      Merge remote-tracking branches 'asoc/topic/ac97', 'asoc/topic/ak4104'=
, 'asoc/topic/arizona', 'asoc/topic/atmel' and 'asoc/topic/codec-component'=
 into asoc-next
      Merge remote-tracking branches 'asoc/topic/cs35l30', 'asoc/topic/cs42=
l73', 'asoc/topic/cs53l30' and 'asoc/topic/da7213' into asoc-next
      Merge remote-tracking branches 'asoc/topic/da7218', 'asoc/topic/da721=
9' and 'asoc/topic/dpcm' into asoc-next
      Merge remote-tracking branches 'asoc/topic/dwc', 'asoc/topic/fsl', 'a=
soc/topic/gpio-chip' and 'asoc/topic/hdmi' into asoc-next
      Merge remote-tracking branches 'asoc/topic/max98371', 'asoc/topic/max=
9867', 'asoc/topic/max98926' and 'asoc/topic/mtk' into asoc-next
      Merge remote-tracking branches 'asoc/topic/nau8810', 'asoc/topic/of-b=
ool', 'asoc/topic/omap' and 'asoc/topic/platform-drvdata' into asoc-next
      Merge remote-tracking branches 'asoc/topic/qcom', 'asoc/topic/rockchi=
p' and 'asoc/topic/rt5616' into asoc-next
      Merge remote-tracking branches 'asoc/topic/rt5659', 'asoc/topic/rt566=
0', 'asoc/topic/rt5677' and 'asoc/topic/samsung' into asoc-next
      Merge remote-tracking branches 'asoc/topic/sgtl5000', 'asoc/topic/sim=
ple', 'asoc/topic/stac9766', 'asoc/topic/sti' and 'asoc/topic/sunxi' into a=
soc-next
      Merge remote-tracking branches 'asoc/topic/tas5086', 'asoc/topic/tegr=
a', 'asoc/topic/tlv320aic31xx', 'asoc/topic/tlv320dac33' and 'asoc/topic/to=
pology' into asoc-next
      Merge remote-tracking branches 'asoc/topic/tpa6130a2', 'asoc/topic/ux=
500', 'asoc/topic/wm8960', 'asoc/topic/wm8962' and 'asoc/topic/wm8991' into=
 asoc-next

Markus Elfring (1):
      ASoC: max98371: Delete unnecessary assignment for the field "owner"

Mengdong Lin (3):
      ASoC: topology: ABI - Add the types for BE DAI
      ASoC: topology: Add support for configuring existing BE DAIs
      ASoC: topology: ABI - Add sig_bits to stream caps

Nariman Poushin (1):
      ASoC: arizona: Don't change the FLLn_GAIN before entering FREERUN

Nicolas Iooss (2):
      ASoC: simple-card-utils: add __printf attribute
      ASoC: Intel: Atom: add a missing star in a memcpy call

Nicolin Chen (5):
      ASoC: cs53l30: Do not ignore errors if mclk is specified
      ASoC: rt5659: Add mclk controls
      ASoC: tegra_rt5640: Correct a copy and paste typo in the comments
      ASoC: rt5659: Enable IRQ output for GPIO1 pin
      ASoC: rt5659: Fix incorrect register addresses

Nikita Yushchenko (5):
      ASoC: tpa6130a2: fix volume setting when no stream is running
      ASoC: simple-card: add support for aux devices
      ASoC: tpa6130a2: unmerge power enable error path from power disable p=
ath
      ASoC: tlv320aic31xx: add explicit support for tlv320dac31xx
      ASoC: tlv320aic31xx: do not declare support for mono DAI

Oder Chiou (2):
      ASoC: rt5514: make the volume TLV to match the units 0.01dB
      ASoC: rt5660: add rt5660 codec driver

Peter Meerwald-Stadler (2):
      ASoC: dapm: Fix typos in comment
      ASoC: atmel-pdmic: Fix typos in comments and error messages

Peter Robinson (1):
      ASoC: sunxi: depend on ARCH_SUNXI

Peter Ujfalusi (2):
      ASoC: omap-mcbsp: Enable TX/RX under and overflow interrupts
      ASoC: davinci-mcasp: off-by-one in davinci_mcasp_hw_rule_format()

Pierre-Louis Bossart (17):
      ASoC: rt5640: add internal clock source support
      ASoC: Intel: bytcr-rt5640: add Asus T100TAF quirks
      ASoC: Intel: bytcr_rt5640: quirk for mono speaker
      ASoC: Intel: bytcr_rt5640: enable differential mic quirk
      ASoC: Intel: Atom: auto-detection of Baytrail-CR
      ASoC: Intel: Atom: add definitions for modem/SSP0 interface
      ASoC: Intel: atom: enable configuration of SSP0
      ASoC: Intel: bytcr_rt5640: add SSP2_AIF2 routing
      ASoC: Intel: bytcr_rt56040: additional routing quirks
      ASoC: Intel: bytcr_rt5640: fix dai/clock setup for SSP0 routing
      ASoC: Intel: bytcr_rt5640: default routing and quirks on Baytrail-CR
      ASoC: Intel: bytcr_rt5640: add IN3 map
      ASoC: Intel: bytcr_rt5640: Add quirk for Teclast X98 Air 3G tablet
      ASoC: Intel: bytcr_rt5640: log quirks
      ASoC: Intel: atom: fix 0-day warnings
      ASoC: Intel: bytcr_rt5640: quirk for Acer Aspire SWS-012
      ASoC: Intel: Atom: fix IOSF_MBI dependency

Ramesh Babu (2):
      ASoC: Intel: Skylake: Add library loading IPCs
      ASoC: Intel: Skylake: Add library loading support

Randy Li (1):
      ASoC: exynos: organize the asoc audio into a menu

Richard Fitzgerald (1):
      ASoC: arizona: Wait for resume before enabling FLL

Richard Leitner (1):
      ASoC: sgtl5000: add headphone and LINEOUT mute controls

Samaga Krishna (1):
      ASoC: Intel: Skylake: Add 32bit support

Sandeep Tayal (1):
      ASoC: hdac_hdmi: use audio component framework to read ELD

Senthilnathan Veppur (2):
      ASoC: Intel: Skylake: add additional args to module parsing
      ASoC: Intel: Skylake: Add module processing domain support

Shreyas NC (4):
      ASoC: uapi: Intel: Skylake: Define vendor specific tokens
      ASoC: Intel: Skylake: Parse vendor tokens to build module data
      ASoC: Intel: Skylake: Remove dfw config and associated structures
      ASoC: Intel: Skylake: Parse manifest data

Srinivas Kandagatla (2):
      ASoC: qcom: apq8016-sbc: add board specific dapm mic widgets
      ASoC: qcom: apq8016-sbc: add support to routing via DT

Sugar Zhang (2):
      ASoC: rockchip: i2s: restore register during runtime_suspend/resume c=
ycle
      ASoC: rockchip: spdif: restore register during runtime_suspend/resume=
 cycle

Sylwester Nawrocki (15):
      ASoC: dwc: Drop DMA channel names assignment
      ASoC: samsung: Drop usage of struct s3c_dma_params from i2s.c
      ASoC: samsung: Drop usage of struct s3c_dma_params from s3c24xx-i2s.c
      ASoC: samsung: Drop usage of struct s3c_dma_params from s3c2412-i2s.c
      ASoC: samsung: Drop usage of struct s3c_dma_params from ac97.c
      ASoC: samsung: Drop usage of struct s3c_dma_params from spdif.c
      ASoC: samsung: Drop usage of of struct s3c_dma_params from pcm.c
      ASoC: samsung: Remove unused now unused struct s3c_dma_params
      ASoC: L3 bus: Add default gpio ops
      ARM: S3C24XX: Specify audio codec platform_data for mini2440 board
      ASoC: uda134x: Optionally initialize L3 ops to default GPIO ops
      ASoC: s3c24xx_uda134x: Remove unused power() callback
      ASoC: s3c24xx_uda134x: Drop initialization of codec's platform data
      ASoC: samsung: Convert s3c24xx_uda134x to use devm_snd_soc_register_c=
ard()
      ASoC: samsung: s3c24xx_uda134x: debug/error trace cleanup

Takashi Sakamoto (11):
      ASoC: rt5616: add static qualifier for file local symbols
      ASoC: sst-bxt-da7219_max98357a: fix obsoleted initializers for array
      ASoC: sst-bxt-rt298: fix obsoleted initializers for array
      ASOC: tpa6130a2: add static qualifier for file local symbols
      ASoC: wm8991: fix wrong usage of DECLARE_TLV_DB_LINEAR()
      ASoC: wm8991: remove unused variable
      ASoC: stac9766: fix wrong usage of DECLARE_TLV_DB_LINEAR()
      ASoC: da7219: fix inappropriate condition statement
      ASoC: max9867: remove usage of obsoleted TLV-related macro
      ASoC: rt5616: remove usage of obsoleted TLV-related macro
      ASoC: wm8960: remove usage of obsoleted TLV-related macro

Vinod Koul (13):
      ASoC: Intel: Skylake: Move modules query to runtime
      ASoC: Intel: Skylake: modify skl_get_dsp_ops()
      ASoC: Intel: Skylake: split fw and dsp initialization
      ASoC: Intel: Skylake: Parse UUIDs once
      ASoC: Intel: Bxt: Parse UUIDs once
      ASoC: Intel: Skylake: Fix a comment style
      ALSA: hda - move bus_parse_capabilities to core
      ALSA: convert users to core bus_parse_capabilities
      ALSA - Ext hda: remove bus_parse_capabilities
      ASoC: Intel: Skylake: Populate modules after loading
      ASoC: Intel: Skylake: remove module id query at runtime
      ASoC: Intel: Skylake: check manifest size
      ASoC: Intel: Skylake: Fix the inverted logic check

Vishal Thanki (1):
      ASoC: ak4104: Limit the supported sample rates

Wei Yongjun (6):
      ASoC: atmel-pdmic: add missing clk_disable_unprepare() on error in at=
mel_pdmic_cpu_dai_startup()
      ASoC: topology: Fix error return code in soc_tplg_dapm_widget_create()
      ASoC: omap-abe-twl6040: Use devm_snd_soc_register_card()
      ASoC: samsung: i2s: Add missing clk_disable_unprepare() on error in s=
amsung_i2s_probe()
      ASoC: sti: fix missing clk_disable_unprepare() on error in uni_player=
_start()
      ASoC: rt5663: fix sparse warnings

Wonjoon Lee (1):
      ASoC: rk3399_gru_sound: fix recording pop at first attempt

Xing Zheng (2):
      ASoC: rockchip: Add machine driver for RK3399 GRU Boards
      ASoC: rockchip: Add support rt5514 dsp summy dailink

Yong Zhi (1):
      ASoC: Intel: Add DMIC channel constraint for bxt machine

kbuild test robot (2):
      ASoC: Intel: Skylake: fix noderef.cocci warnings
      ASoC: rt5663: fix platform_no_drv_owner.cocci warnings

=E5=BD=AD=E4=B8=9C=E6=9E=97 (1):
      ASoC: dpcm: print dai_link name of BE other than FE.

 .../devicetree/bindings/sound/nau8810.txt          |   16 +
 .../bindings/sound/nvidia,tegra-audio-sgtl5000.txt |   42 +
 .../devicetree/bindings/sound/qcom,apq8016-sbc.txt |   30 +
 .../bindings/sound/renesas,rsrc-card.txt           |   75 -
 .../bindings/sound/rockchip,rk3399-gru-sound.txt   |   22 +
 Documentation/devicetree/bindings/sound/rt5659.txt |    3 +
 Documentation/devicetree/bindings/sound/rt5660.txt |   47 +
 Documentation/devicetree/bindings/sound/rt5663.txt |   30 +
 .../devicetree/bindings/sound/simple-card.txt      |   37 +
 .../devicetree/bindings/sound/simple-scu-card.txt  |  110 +
 .../devicetree/bindings/sound/st,sti-asoc-card.txt |   52 +-
 .../bindings/sound/sunxi,sun4i-spdif.txt           |    3 +
 .../devicetree/bindings/sound/tlv320aic31xx.txt    |    9 +-
 arch/arm/mach-s3c24xx/mach-mini2440.c              |   19 +
 include/sound/da7219.h                             |    2 +
 include/sound/hda_register.h                       |   36 +
 include/sound/hdaudio.h                            |   13 +
 include/sound/hdaudio_ext.h                        |   12 -
 include/sound/l3.h                                 |   15 +-
 include/sound/rt5660.h                             |   31 +
 include/sound/s3c24xx_uda134x.h                    |    1 -
 include/sound/simple_card_utils.h                  |   35 +
 include/sound/soc.h                                |   19 -
 include/uapi/sound/Kbuild                          |    1 +
 include/uapi/sound/asoc.h                          |   35 +-
 include/uapi/sound/snd_sst_tokens.h                |  214 ++
 sound/hda/ext/hdac_ext_controller.c                |   91 +-
 sound/hda/ext/hdac_ext_stream.c                    |   46 +-
 sound/hda/hdac_controller.c                        |   75 +
 sound/pci/hda/hda_controller.c                     |  203 +-
 sound/pci/hda/hda_controller.h                     |    3 +
 sound/pci/hda/hda_intel.c                          |   17 +
 sound/soc/amd/acp-pcm-dma.c                        |    2 +-
 sound/soc/atmel/atmel-classd.c                     |    6 +-
 sound/soc/atmel/atmel-pcm-pdc.c                    |    2 +-
 sound/soc/atmel/atmel-pdmic.c                      |   20 +-
 sound/soc/codecs/88pm860x-codec.c                  |   14 +-
 sound/soc/codecs/Kconfig                           |   18 +
 sound/soc/codecs/Makefile                          |    6 +
 sound/soc/codecs/ab8500-codec.c                    |   24 +-
 sound/soc/codecs/ac97.c                            |   10 +-
 sound/soc/codecs/ad1836.c                          |   14 +-
 sound/soc/codecs/ad193x.c                          |   14 +-
 sound/soc/codecs/ad1980.c                          |   14 +-
 sound/soc/codecs/ad73311.c                         |   10 +-
 sound/soc/codecs/adau1373.c                        |   14 +-
 sound/soc/codecs/adau1701.c                        |   15 +-
 sound/soc/codecs/adau1761.c                        |   14 +-
 sound/soc/codecs/adau1781.c                        |   14 +-
 sound/soc/codecs/adau1977.c                        |   14 +-
 sound/soc/codecs/adau7002.c                        |   10 +-
 sound/soc/codecs/adav80x.c                         |   14 +-
 sound/soc/codecs/ads117x.c                         |   10 +-
 sound/soc/codecs/ak4104.c                          |   15 +-
 sound/soc/codecs/ak4535.c                          |   14 +-
 sound/soc/codecs/ak4554.c                          |   10 +-
 sound/soc/codecs/ak4613.c                          |   14 +-
 sound/soc/codecs/ak4641.c                          |   14 +-
 sound/soc/codecs/ak4642.c                          |   14 +-
 sound/soc/codecs/ak4671.c                          |   14 +-
 sound/soc/codecs/ak5386.c                          |   10 +-
 sound/soc/codecs/alc5632.c                         |   14 +-
 sound/soc/codecs/arizona.c                         |   78 +-
 sound/soc/codecs/arizona.h                         |   17 +-
 sound/soc/codecs/bt-sco.c                          |   10 +-
 sound/soc/codecs/cq93vc.c                          |    6 +-
 sound/soc/codecs/cs35l32.c                         |   15 +-
 sound/soc/codecs/cs35l33.c                         |   15 +-
 sound/soc/codecs/cs4265.c                          |   15 +-
 sound/soc/codecs/cs4270.c                          |   14 +-
 sound/soc/codecs/cs4271.c                          |   14 +-
 sound/soc/codecs/cs42l51.c                         |   14 +-
 sound/soc/codecs/cs42l52.c                         |   15 +-
 sound/soc/codecs/cs42l56.c                         |   15 +-
 sound/soc/codecs/cs42l73.c                         |   19 +-
 sound/soc/codecs/cs42xx8.c                         |   14 +-
 sound/soc/codecs/cs4349.c                          |   15 +-
 sound/soc/codecs/cs47l24.c                         |   26 +-
 sound/soc/codecs/cs53l30.c                         |   23 +-
 sound/soc/codecs/cx20442.c                         |   10 +-
 sound/soc/codecs/da7210.c                          |   15 +-
 sound/soc/codecs/da7213.c                          |  145 +-
 sound/soc/codecs/da7213.h                          |   12 +-
 sound/soc/codecs/da7218.c                          |   49 +-
 sound/soc/codecs/da7218.h                          |    2 -
 sound/soc/codecs/da7219-aad.c                      |  108 +-
 sound/soc/codecs/da7219-aad.h                      |   11 +-
 sound/soc/codecs/da7219.c                          |   95 +-
 sound/soc/codecs/da7219.h                          |    8 +
 sound/soc/codecs/da732x.c                          |   14 +-
 sound/soc/codecs/da9055.c                          |   15 +-
 sound/soc/codecs/dmic.c                            |   10 +-
 sound/soc/codecs/es8328.c                          |   14 +-
 sound/soc/codecs/gtm601.c                          |   10 +-
 sound/soc/codecs/hdac_hdmi.c                       |    2 +-
 sound/soc/codecs/hdmi-codec.c                      |   79 +-
 sound/soc/codecs/inno_rk3036.c                     |   14 +-
 sound/soc/codecs/isabelle.c                        |   14 +-
 sound/soc/codecs/jz4740.c                          |   14 +-
 sound/soc/codecs/l3.c                              |   71 +-
 sound/soc/codecs/lm49453.c                         |   14 +-
 sound/soc/codecs/max98088.c                        |   14 +-
 sound/soc/codecs/max98095.c                        |   14 +-
 sound/soc/codecs/max98357a.c                       |   10 +-
 sound/soc/codecs/max98371.c                        |    1 -
 sound/soc/codecs/max9850.c                         |   14 +-
 sound/soc/codecs/max9860.c                         |   14 +-
 sound/soc/codecs/max9867.c                         |   19 +-
 sound/soc/codecs/max98925.c                        |   14 +-
 sound/soc/codecs/max98926.c                        |   20 +-
 sound/soc/codecs/mc13783.c                         |   14 +-
 sound/soc/codecs/ml26124.c                         |   14 +-
 sound/soc/codecs/nau8810.c                         |  884 ++++++
 sound/soc/codecs/nau8810.h                         |  281 ++
 sound/soc/codecs/nau8825.c                         |   16 +-
 sound/soc/codecs/pcm1681.c                         |   14 +-
 sound/soc/codecs/pcm179x.c                         |   14 +-
 sound/soc/codecs/pcm3008.c                         |   10 +-
 sound/soc/codecs/pcm3168a.c                        |   14 +-
 sound/soc/codecs/pcm512x.c                         |   14 +-
 sound/soc/codecs/rt286.c                           |   14 +-
 sound/soc/codecs/rt298.c                           |   14 +-
 sound/soc/codecs/rt5514-spi.c                      |    2 +-
 sound/soc/codecs/rt5514.c                          |   20 +-
 sound/soc/codecs/rt5514.h                          |    4 +-
 sound/soc/codecs/rt5616.c                          |   23 +-
 sound/soc/codecs/rt5631.c                          |   14 +-
 sound/soc/codecs/rt5640.c                          |   17 +-
 sound/soc/codecs/rt5640.h                          |    1 +
 sound/soc/codecs/rt5645.c                          |   14 +-
 sound/soc/codecs/rt5651.c                          |   14 +-
 sound/soc/codecs/rt5659.c                          |   41 +-
 sound/soc/codecs/rt5659.h                          |    7 +-
 sound/soc/codecs/rt5660.c                          | 1353 ++++++++
 sound/soc/codecs/rt5660.h                          |  847 ++++++
 sound/soc/codecs/rt5663.c                          | 3218 ++++++++++++++++=
++++
 sound/soc/codecs/rt5663.h                          | 1121 +++++++
 sound/soc/codecs/rt5670.c                          |   14 +-
 sound/soc/codecs/rt5677.c                          |   69 +-
 sound/soc/codecs/sgtl5000.c                        |   17 +-
 sound/soc/codecs/si476x.c                          |   10 +-
 sound/soc/codecs/sn95031.c                         |   14 +-
 sound/soc/codecs/spdif_receiver.c                  |   10 +-
 sound/soc/codecs/spdif_transmitter.c               |   10 +-
 sound/soc/codecs/ssm2518.c                         |   14 +-
 sound/soc/codecs/ssm2602.c                         |   14 +-
 sound/soc/codecs/ssm4567.c                         |   14 +-
 sound/soc/codecs/sta32x.c                          |   14 +-
 sound/soc/codecs/sta350.c                          |   14 +-
 sound/soc/codecs/sta529.c                          |    6 +-
 sound/soc/codecs/stac9766.c                        |   14 +-
 sound/soc/codecs/sti-sas.c                         |    8 +-
 sound/soc/codecs/tas2552.c                         |   14 +-
 sound/soc/codecs/tas5086.c                         |   16 +-
 sound/soc/codecs/tas571x.c                         |   14 +-
 sound/soc/codecs/tas5720.c                         |   14 +-
 sound/soc/codecs/tfa9879.c                         |   15 +-
 sound/soc/codecs/tlv320aic23.c                     |   14 +-
 sound/soc/codecs/tlv320aic26.c                     |   14 +-
 sound/soc/codecs/tlv320aic31xx.c                   |  218 +-
 sound/soc/codecs/tlv320aic31xx.h                   |    2 +
 sound/soc/codecs/tlv320aic32x4.c                   |   14 +-
 sound/soc/codecs/tlv320aic3x.c                     |   14 +-
 sound/soc/codecs/tlv320dac33.c                     |   31 +-
 sound/soc/codecs/tpa6130a2.c                       |   49 +-
 sound/soc/codecs/twl4030.c                         |   14 +-
 sound/soc/codecs/twl6040.c                         |   14 +-
 sound/soc/codecs/uda134x.c                         |   17 +-
 sound/soc/codecs/uda1380.c                         |   14 +-
 sound/soc/codecs/wl1273.c                          |   14 +-
 sound/soc/codecs/wm0010.c                          |   12 +-
 sound/soc/codecs/wm1250-ev1.c                      |   13 +-
 sound/soc/codecs/wm2000.c                          |   16 +-
 sound/soc/codecs/wm2200.c                          |   16 +-
 sound/soc/codecs/wm5100.c                          |   18 +-
 sound/soc/codecs/wm5102.c                          |   27 +-
 sound/soc/codecs/wm5110.c                          |   28 +-
 sound/soc/codecs/wm8350.c                          |   16 +-
 sound/soc/codecs/wm8400.c                          |   16 +-
 sound/soc/codecs/wm8510.c                          |   16 +-
 sound/soc/codecs/wm8523.c                          |   16 +-
 sound/soc/codecs/wm8580.c                          |   16 +-
 sound/soc/codecs/wm8711.c                          |   16 +-
 sound/soc/codecs/wm8727.c                          |   12 +-
 sound/soc/codecs/wm8728.c                          |   16 +-
 sound/soc/codecs/wm8731.c                          |   16 +-
 sound/soc/codecs/wm8737.c                          |   16 +-
 sound/soc/codecs/wm8741.c                          |   12 +-
 sound/soc/codecs/wm8750.c                          |   16 +-
 sound/soc/codecs/wm8753.c                          |   16 +-
 sound/soc/codecs/wm8770.c                          |   16 +-
 sound/soc/codecs/wm8776.c                          |   16 +-
 sound/soc/codecs/wm8782.c                          |   12 +-
 sound/soc/codecs/wm8804.c                          |   10 +-
 sound/soc/codecs/wm8900.c                          |   16 +-
 sound/soc/codecs/wm8903.c                          |   18 +-
 sound/soc/codecs/wm8904.c                          |    2 +-
 sound/soc/codecs/wm8940.c                          |   16 +-
 sound/soc/codecs/wm8955.c                          |   16 +-
 sound/soc/codecs/wm8960.c                          |    7 +-
 sound/soc/codecs/wm8961.c                          |   16 +-
 sound/soc/codecs/wm8962.c                          |    6 +-
 sound/soc/codecs/wm8971.c                          |   16 +-
 sound/soc/codecs/wm8974.c                          |   16 +-
 sound/soc/codecs/wm8978.c                          |   16 +-
 sound/soc/codecs/wm8983.c                          |   16 +-
 sound/soc/codecs/wm8985.c                          |   16 +-
 sound/soc/codecs/wm8988.c                          |   14 +-
 sound/soc/codecs/wm8990.c                          |   16 +-
 sound/soc/codecs/wm8991.c                          |   44 +-
 sound/soc/codecs/wm8993.c                          |    2 +-
 sound/soc/codecs/wm8994.c                          |    2 +-
 sound/soc/codecs/wm8995.c                          |   14 +-
 sound/soc/codecs/wm8996.c                          |   18 +-
 sound/soc/codecs/wm8997.c                          |   16 +-
 sound/soc/codecs/wm8998.c                          |   26 +-
 sound/soc/codecs/wm9081.c                          |   16 +-
 sound/soc/codecs/wm9090.c                          |    2 +-
 sound/soc/codecs/wm9705.c                          |   16 +-
 sound/soc/codecs/wm9712.c                          |   16 +-
 sound/soc/codecs/wm9713.c                          |   16 +-
 sound/soc/codecs/wm_adsp.c                         |   88 +-
 sound/soc/codecs/wm_adsp.h                         |    7 +-
 sound/soc/davinci/davinci-mcasp.c                  |    2 +-
 sound/soc/dwc/designware_i2s.c                     |    2 -
 sound/soc/fsl/fsl_asrc.c                           |   12 +-
 sound/soc/fsl/fsl_asrc_dma.c                       |    2 +-
 sound/soc/fsl/fsl_esai.c                           |    8 +-
 sound/soc/fsl/fsl_sai.c                            |    6 +-
 sound/soc/fsl/fsl_spdif.c                          |    2 +-
 sound/soc/fsl/fsl_ssi.c                            |    2 +-
 sound/soc/generic/Kconfig                          |    8 +
 sound/soc/generic/Makefile                         |    2 +
 sound/soc/generic/simple-card-utils.c              |  141 +
 sound/soc/generic/simple-card.c                    |  305 +-
 sound/soc/generic/simple-scu-card.c                |  345 +++
 sound/soc/img/pistachio-internal-dac.c             |   14 +-
 sound/soc/intel/Kconfig                            |   12 +
 sound/soc/intel/atom/sst-atom-controls.c           |   32 +-
 sound/soc/intel/atom/sst-atom-controls.h           |    6 +
 sound/soc/intel/atom/sst-mfld-platform-pcm.c       |    2 +-
 sound/soc/intel/atom/sst/sst.c                     |    5 +-
 sound/soc/intel/atom/sst/sst_acpi.c                |   97 +-
 sound/soc/intel/atom/sst/sst_ipc.c                 |    3 +
 sound/soc/intel/atom/sst/sst_pvt.c                 |   14 +-
 sound/soc/intel/boards/Makefile                    |    2 +
 sound/soc/intel/boards/bdw-rt5677.c                |  347 +++
 sound/soc/intel/boards/bxt_da7219_max98357a.c      |   75 +-
 sound/soc/intel/boards/bxt_rt298.c                 |   14 +-
 sound/soc/intel/boards/bytcr_rt5640.c              |  507 ++-
 sound/soc/intel/common/sst-acpi.c                  |    1 +
 sound/soc/intel/haswell/sst-haswell-pcm.c          |    2 +-
 sound/soc/intel/skylake/bxt-sst.c                  |  118 +-
 sound/soc/intel/skylake/skl-messages.c             |   67 +-
 sound/soc/intel/skylake/skl-pcm.c                  |   60 +-
 sound/soc/intel/skylake/skl-sst-cldma.c            |    4 +-
 sound/soc/intel/skylake/skl-sst-dsp.h              |   18 +-
 sound/soc/intel/skylake/skl-sst-ipc.c              |   41 +-
 sound/soc/intel/skylake/skl-sst-ipc.h              |   12 +-
 sound/soc/intel/skylake/skl-sst-utils.c            |  176 +-
 sound/soc/intel/skylake/skl-sst.c                  |   49 +-
 sound/soc/intel/skylake/skl-topology.c             |  918 +++++-
 sound/soc/intel/skylake/skl-topology.h             |   15 +-
 sound/soc/intel/skylake/skl-tplg-interface.h       |   95 +-
 sound/soc/intel/skylake/skl.c                      |    6 +-
 sound/soc/intel/skylake/skl.h                      |    2 +
 sound/soc/kirkwood/kirkwood-dma.c                  |    2 +-
 sound/soc/mediatek/common/mtk-afe-fe-dai.c         |    5 +-
 sound/soc/omap/mcbsp.c                             |    3 +-
 sound/soc/omap/omap-abe-twl6040.c                  |   14 +-
 sound/soc/omap/omap-pcm.c                          |    2 +-
 sound/soc/qcom/apq8016_sbc.c                       |   20 +
 sound/soc/qcom/lpass-platform.c                    |   16 +-
 sound/soc/qcom/lpass.h                             |    2 +
 sound/soc/rockchip/Kconfig                         |   12 +
 sound/soc/rockchip/Makefile                        |    2 +
 sound/soc/rockchip/rk3399_gru_sound.c              |  397 +++
 sound/soc/rockchip/rockchip_i2s.c                  |   10 +-
 sound/soc/rockchip/rockchip_spdif.c                |   12 +-
 sound/soc/samsung/Kconfig                          |   57 +-
 sound/soc/samsung/ac97.c                           |   34 +-
 sound/soc/samsung/dma.h                            |   20 +-
 sound/soc/samsung/dmaengine.c                      |   31 -
 sound/soc/samsung/i2s.c                            |   56 +-
 sound/soc/samsung/idma.c                           |    1 -
 sound/soc/samsung/pcm.c                            |   26 +-
 sound/soc/samsung/s3c-i2s-v2.c                     |    3 +-
 sound/soc/samsung/s3c-i2s-v2.h                     |    4 +-
 sound/soc/samsung/s3c2412-i2s.c                    |   24 +-
 sound/soc/samsung/s3c24xx-i2s.c                    |   24 +-
 sound/soc/samsung/s3c24xx_uda134x.c                |  134 +-
 sound/soc/samsung/smdk_wm8580pcm.c                 |    1 -
 sound/soc/samsung/smdk_wm8994pcm.c                 |    1 -
 sound/soc/samsung/spdif.c                          |   12 +-
 sound/soc/sh/Kconfig                               |    6 -
 sound/soc/sh/rcar/Makefile                         |    3 -
 sound/soc/sh/rcar/core.c                           |    4 +
 sound/soc/sh/rcar/rsrc-card.c                      |  486 ---
 sound/soc/sh/rcar/ssi.c                            |    2 +-
 sound/soc/soc-ac97.c                               |    2 +-
 sound/soc/soc-core.c                               |   15 +-
 sound/soc/soc-dapm.c                               |   23 +-
 sound/soc/soc-ops.c                                |    2 +-
 sound/soc/soc-pcm.c                                |   13 +-
 sound/soc/soc-topology.c                           |  115 +-
 sound/soc/soc-utils.c                              |    2 +-
 sound/soc/sti/sti_uniperif.c                       |  130 +-
 sound/soc/sti/uniperif.h                           |   28 +-
 sound/soc/sti/uniperif_player.c                    |   83 +-
 sound/soc/sti/uniperif_reader.c                    |   46 +-
 sound/soc/sunxi/Kconfig                            |    1 +
 sound/soc/sunxi/sun4i-codec.c                      |   60 +-
 sound/soc/sunxi/sun4i-spdif.c                      |   17 +-
 sound/soc/tegra/Kconfig                            |   11 +
 sound/soc/tegra/Makefile                           |    2 +
 sound/soc/tegra/tegra_rt5640.c                     |    2 +-
 sound/soc/tegra/tegra_sgtl5000.c                   |  212 ++
 sound/soc/ux500/ux500_msp_dai.c                    |    6 +-
 318 files changed, 15145 insertions(+), 3112 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/nau8810.txt
 create mode 100644 Documentation/devicetree/bindings/sound/nvidia,tegra-au=
dio-sgtl5000.txt
 delete mode 100644 Documentation/devicetree/bindings/sound/renesas,rsrc-ca=
rd.txt
 create mode 100644 Documentation/devicetree/bindings/sound/rockchip,rk3399=
-gru-sound.txt
 create mode 100644 Documentation/devicetree/bindings/sound/rt5660.txt
 create mode 100644 Documentation/devicetree/bindings/sound/rt5663.txt
 create mode 100644 Documentation/devicetree/bindings/sound/simple-scu-card=
=2Etxt
 create mode 100644 include/sound/rt5660.h
 create mode 100644 include/uapi/sound/snd_sst_tokens.h
 create mode 100644 sound/soc/codecs/nau8810.c
 create mode 100644 sound/soc/codecs/nau8810.h
 create mode 100644 sound/soc/codecs/rt5660.c
 create mode 100644 sound/soc/codecs/rt5660.h
 create mode 100644 sound/soc/codecs/rt5663.c
 create mode 100644 sound/soc/codecs/rt5663.h
 create mode 100644 sound/soc/generic/simple-scu-card.c
 create mode 100644 sound/soc/intel/boards/bdw-rt5677.c
 create mode 100644 sound/soc/rockchip/rk3399_gru_sound.c
 delete mode 100644 sound/soc/sh/rcar/rsrc-card.c
 create mode 100644 sound/soc/tegra/tegra_sgtl5000.c

--ps6nwmesa4wbqj7j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAABCAAGBQJX7pFeAAoJECTWi3JdVIfQaqAH/24o8eyDd2Byer5B4S2WMo3b
8vU+bn1Noc2SzvVFe0DbXtpTLu4PeCZr6g7+QpJJ2f+X4HAGgkysdva39MmlstRS
NCtnsTNjKnGwpZkuIXpus/BQTrIolAweORgbGHR/+Pqal6/H15grMJB4LKDjclUY
/2B45PfbF3/v7LlVpWo4z3jhHx0IE/ORvkhLSFXkWr8yKKtxbGg3looixnJPjv7+
xqZo14QNWEvg9tatH8XwmJxLG2vs7I2L5G7bkTpgF7Qb0vzpZbA9ZGqX9r4VxGz2
6dS1LGdUCDMkZY8zOOquHEmnsLhsHFeVEwoR3f4FUIKrVgtj6kkzpd2Y1JrOAoM=
=3muU
-----END PGP SIGNATURE-----

--ps6nwmesa4wbqj7j--

--===============3423890584442178075==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3423890584442178075==--
