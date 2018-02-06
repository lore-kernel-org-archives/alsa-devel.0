From: Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] Extra ASoC updates for v4.16
Date: Tue, 6 Feb 2018 11:44:39 +0000
Message-ID: <20180206114439.GC5681@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5550467208063754707=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id EE3D1267222
 for <alsa-devel@alsa-project.org>; Tue,  6 Feb 2018 12:44:42 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============5550467208063754707==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="32u276st3Jlj2kUU"
Content-Disposition: inline


--32u276st3Jlj2kUU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This pull request is for things that arrived in the last week of the
v4.15 cycle, I'm sending it directly since Takashi still seems to be on
holiday (I'd thought he'd be back this week).  There's some random new
development in here and also a bunch of bugfixes.

The I/O fix mentioned in the tag below is pretty important and would be
especially good to have fixed in -rc1, it was reported right at the end
of the v4.15 cycle so didn't make Takashi's early pull request and
causes a power regression on some of the OMAP platforms.  If this
request is a problem I can do a smaller one with just that in it.

Unfortunately I can't figure out how to generate a sensible git pull
request for this since it ended up containing both v4.15-rc9 and my
prior pull requests.  When I use your tree as the reference git pull
goes with your -rc9 tag so the diffstat contains way more stuff than
you'll actually get but that seems to be the best alternative.

The following changes since commit 0c5b9b5d9adbad4b60491f9ba0d2af38904bb4b9:

  Linux 4.15-rc9 (2018-01-21 13:51:26 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-v4.16-4

for you to fetch changes up to e0a663f24d532c7ad9ff34cc1aa96bf94c75ef44:

  Merge remote-tracking branch 'asoc/topic/wm8998' into asoc-next (2018-01-26 15:27:56 +0000)

----------------------------------------------------------------
ASoC: Updates for v4.16

With the merge window having been delayed for another week here's
another batch of updates that came in during that week.  There's a few
important fixes in here, mainly a fix for I/O on a number of devices
caused by some of the component rework and a fix for a potential issue
if more than one component in a link provides compressed operations.

----------------------------------------------------------------
Charles Keepax (3):
      ASoC: compress: Correct handling of copy callback
      ASoC: compress: Remove some extraneous blank lines
      ASoC: compress: Fixup error messages

Fabio Estevam (1):
      ASoC: sgtl5000: Clarify a bit about the ER1 meaning

Harsha Priya (1):
      ASoC: Intel: kbl: Enable mclk and ssp sclk early

Jeffy Chen (1):
      ASoC: rockchip: Use dummy_dai for rt5514 dsp dailink

Kuninori Morimoto (4):
      ASoC: soc-core: snd_soc_rtdcom_lookup() cares component driver name
      ASoC: soc-pcm: don't call flush_delayed_work() many times in soc_pcm_private_free()
      ASoC: ak4613: call dummy write for PW_MGMT1/3 when Playback
      ASoC: soc-pcm: rename .pmdown_time to .use_pmdown_time for Component

Ladislav Michl (2):
      ASoC: sam9g20_wm8731: use dev_*() logging functions
      ASoC: sam9x5_wm8731: Drop 'ASoC' prefix from error messages

Mark Brown (35):
      Merge branches 'topic/twl4030' and 'topic/twl6040' of https://git.kernel.org/.../broonie/sound into asoc-twl-breakage
      Merge branch 'fix/compress' of https://git.kernel.org/.../broonie/sound into asoc-compress
      Merge remote-tracking branch 'asoc/fix/core' into asoc-linus
      Merge remote-tracking branch 'asoc/fix/intel' into asoc-linus
      Merge remote-tracking branch 'asoc/fix/rockchip' into asoc-linus
      Merge remote-tracking branches 'asoc/fix/compress' and 'asoc/fix/mtk' into asoc-linus
      Merge remote-tracking branch 'asoc/topic/core' into asoc-next
      Merge remote-tracking branch 'asoc/topic/intel' into asoc-next
      Merge remote-tracking branch 'asoc/topic/pcm' into asoc-next
      Merge remote-tracking branch 'asoc/topic/pcm186x' into asoc-next
      Merge remote-tracking branch 'asoc/topic/pcm512x' into asoc-next
      Merge remote-tracking branch 'asoc/topic/qcom' into asoc-next
      Merge remote-tracking branch 'asoc/topic/rcar' into asoc-next
      Merge remote-tracking branch 'asoc/topic/rockchip' into asoc-next
      Merge remote-tracking branch 'asoc/topic/twl-breakage' into asoc-next
      Merge remote-tracking branches 'asoc/topic/88pm860x', 'asoc/topic/ak4613', 'asoc/topic/amd', 'asoc/topic/atmel' and 'asoc/topic/au1x' into asoc-next
      Merge remote-tracking branches 'asoc/topic/bcm2835', 'asoc/topic/codecs', 'asoc/topic/compress' and 'asoc/topic/cq93vc' into asoc-next
      Merge remote-tracking branches 'asoc/topic/cs35l32', 'asoc/topic/cs35l34', 'asoc/topic/cs42l52', 'asoc/topic/cs42l56' and 'asoc/topic/cs42l73' into asoc-next
      Merge remote-tracking branches 'asoc/topic/cs47l24', 'asoc/topic/cx20442', 'asoc/topic/da7213', 'asoc/topic/da7218' and 'asoc/topic/dai-drv' into asoc-next
      Merge remote-tracking branches 'asoc/topic/davinci', 'asoc/topic/debugfs', 'asoc/topic/disconnect', 'asoc/topic/dmic' and 'asoc/topic/ep93xx' into asoc-next
      Merge remote-tracking branches 'asoc/topic/eukrea-tlv320', 'asoc/topic/fsl', 'asoc/topic/fsl-ssi' and 'asoc/topic/fsl_asrc' into asoc-next
      Merge remote-tracking branches 'asoc/topic/hdac_hdmi', 'asoc/topic/hisilicon', 'asoc/topic/iio' and 'asoc/topic/max98373' into asoc-next
      Merge remote-tracking branches 'asoc/topic/max98926', 'asoc/topic/max98927', 'asoc/topic/mc13783', 'asoc/topic/msm8916' and 'asoc/topic/mt8173' into asoc-next
      Merge remote-tracking branches 'asoc/topic/mtk', 'asoc/topic/mxs', 'asoc/topic/mxs-sgtl5000', 'asoc/topic/nau8540' and 'asoc/topic/nau8824' into asoc-next
      Merge remote-tracking branches 'asoc/topic/nau8825' and 'asoc/topic/nuc900' into asoc-next
      Merge remote-tracking branches 'asoc/topic/rl6231' and 'asoc/topic/rt5514' into asoc-next
      Merge remote-tracking branches 'asoc/topic/rt5645', 'asoc/topic/sam9g20_wm8731', 'asoc/topic/sam9x5_wm8731', 'asoc/topic/samsung' and 'asoc/topic/sgtl5000' into asoc-next
      Merge remote-tracking branches 'asoc/topic/si476x', 'asoc/topic/simple', 'asoc/topic/spdif', 'asoc/topic/st-dfsdm' and 'asoc/topic/stm32' into asoc-next
      Merge remote-tracking branches 'asoc/topic/sun4i-i2s', 'asoc/topic/sun8i-codec', 'asoc/topic/sunxi', 'asoc/topic/symmetry' and 'asoc/topic/tas5720' into asoc-next
      Merge remote-tracking branches 'asoc/topic/tas6424', 'asoc/topic/tfa9879', 'asoc/topic/tlv320aic31xx', 'asoc/topic/tlv320aic32x4' and 'asoc/topic/tlv320aic3x' into asoc-next
      Merge remote-tracking branches 'asoc/topic/tlv320dac33', 'asoc/topic/ts3a227e' and 'asoc/topic/tscs42xx' into asoc-next
      Merge remote-tracking branches 'asoc/topic/uda1380', 'asoc/topic/uniphier' and 'asoc/topic/utils' into asoc-next
      Merge remote-tracking branches 'asoc/topic/ux500', 'asoc/topic/wm0010', 'asoc/topic/wm2000', 'asoc/topic/wm5102' and 'asoc/topic/wm5110' into asoc-next
      Merge remote-tracking branches 'asoc/topic/wm8350', 'asoc/topic/wm8400', 'asoc/topic/wm8903', 'asoc/topic/wm8994' and 'asoc/topic/wm8997' into asoc-next
      Merge remote-tracking branch 'asoc/topic/wm8998' into asoc-next

Matthias Kaehlcke (1):
      ASoC: dmic: Fix check of return value from read of 'num-channels'

Mylene JOSSERAND (1):
      ASoC: sun8i-codec: Add ADC support for a33

Ryan Lee (1):
      ASoC: max98373 Changed SPDX header in C++ comments style

Ryder Lee (1):
      ASoC: mediatek: fix double free in mt2701_afe_pcm_dev_probe()

Sriram Periyasamy (2):
      ASoC: Intel: Skylake: Add ssp clock driver
      ASoC: Intel: Skylake: Add extended I2S config blob support in Clock driver

Tony Lindgren (1):
      ASoC: Fix twl4030 and 6040 regression by adding back read and write

 .../ABI/testing/sysfs-bus-iio-dfsdm-adc-stm32      |   16 +
 .../bindings/iio/adc/sigma-delta-modulator.txt     |   13 +
 .../bindings/iio/adc/st,stm32-dfsdm-adc.txt        |  128 +
 Documentation/devicetree/bindings/sound/dmic.txt   |    2 +
 .../devicetree/bindings/sound/max98373.txt         |   40 +
 .../devicetree/bindings/sound/mt2701-afe-pcm.txt   |  266 +-
 .../bindings/sound/mxs-audio-sgtl5000.txt          |   33 +-
 .../devicetree/bindings/sound/nau8825.txt          |    4 +-
 .../devicetree/bindings/sound/pcm186x.txt          |   42 +
 .../devicetree/bindings/sound/renesas,rsnd.txt     |   15 +-
 .../devicetree/bindings/sound/simple-card.txt      |    3 +
 .../devicetree/bindings/sound/st,stm32-adfsdm.txt  |   63 +
 .../devicetree/bindings/sound/st,stm32-sai.txt     |   12 +-
 .../devicetree/bindings/sound/sun4i-i2s.txt        |    2 +
 .../devicetree/bindings/sound/tas5720.txt          |    4 +-
 .../devicetree/bindings/sound/tfa9879.txt          |    8 +-
 .../devicetree/bindings/sound/ti,tas6424.txt       |   20 +
 .../devicetree/bindings/sound/tlv320aic31xx.txt    |    9 +-
 .../devicetree/bindings/sound/tlv320aic3x.txt      |   10 +-
 .../devicetree/bindings/sound/tscs42xx.txt         |   16 +
 .../devicetree/bindings/sound/uniphier,evea.txt    |   26 +
 .../devicetree/bindings/vendor-prefixes.txt        |    1 +
 Documentation/driver-api/iio/hw-consumer.rst       |   51 +
 Documentation/driver-api/iio/index.rst             |    1 +
 MAINTAINERS                                        |   14 +
 drivers/acpi/utils.c                               |   41 +-
 drivers/gpio/gpio-merrifield.c                     |   11 +-
 drivers/iio/adc/Kconfig                            |   37 +
 drivers/iio/adc/Makefile                           |    3 +
 drivers/iio/adc/sd_adc_modulator.c                 |   68 +
 drivers/iio/adc/stm32-dfsdm-adc.c                  | 1205 +++++++++
 drivers/iio/adc/stm32-dfsdm-core.c                 |  302 +++
 drivers/iio/adc/stm32-dfsdm.h                      |  310 +++
 drivers/iio/buffer/Kconfig                         |   10 +
 drivers/iio/buffer/Makefile                        |    1 +
 drivers/iio/buffer/industrialio-buffer-cb.c        |   11 +
 drivers/iio/buffer/industrialio-hw-consumer.c      |  247 ++
 drivers/iio/inkern.c                               |   17 +-
 include/acpi/acpi_bus.h                            |    3 +
 include/linux/acpi.h                               |    6 +
 include/linux/iio/adc/stm32-dfsdm-adc.h            |   18 +
 include/linux/iio/consumer.h                       |   37 +
 include/linux/iio/hw-consumer.h                    |   21 +
 include/linux/iio/iio.h                            |   28 -
 include/linux/iio/types.h                          |   28 +
 include/sound/hdaudio_ext.h                        |    4 +-
 include/sound/pcm.h                                |    8 +
 include/sound/rt5514.h                             |    2 +
 include/sound/rt5645.h                             |    3 +
 include/sound/soc-acpi-intel-match.h               |    1 +
 include/sound/soc-acpi.h                           |   14 +-
 include/sound/soc-dai.h                            |    5 +-
 include/sound/soc.h                                |   11 +-
 include/uapi/sound/asound.h                        |    9 +
 include/uapi/sound/snd_sst_tokens.h                |   17 +-
 sound/core/pcm_misc.c                              |   19 +-
 sound/hda/ext/hdac_ext_bus.c                       |    2 +-
 sound/soc/Kconfig                                  |    1 +
 sound/soc/Makefile                                 |    1 +
 sound/soc/amd/acp-pcm-dma.c                        |   35 +-
 sound/soc/atmel/atmel-classd.c                     |    6 -
 sound/soc/atmel/sam9g20_wm8731.c                   |   17 +-
 sound/soc/atmel/sam9x5_wm8731.c                    |   12 +-
 sound/soc/au1x/ac97c.c                             |    6 +-
 sound/soc/bcm/bcm2835-i2s.c                        |   20 +-
 sound/soc/cirrus/ep93xx-ac97.c                     |    6 +-
 sound/soc/codecs/88pm860x-codec.c                  |    9 +-
 sound/soc/codecs/Kconfig                           |   46 +-
 sound/soc/codecs/Makefile                          |   13 +-
 sound/soc/codecs/ak4613.c                          |   78 +
 sound/soc/codecs/cq93vc.c                          |   10 +-
 sound/soc/codecs/cs35l32.c                         |   18 +-
 sound/soc/codecs/cs35l34.c                         |   19 +-
 sound/soc/codecs/cs42l52.c                         |   13 +-
 sound/soc/codecs/cs42l56.c                         |   13 +-
 sound/soc/codecs/cs42l73.c                         |   15 +-
 sound/soc/codecs/cs47l24.c                         |   12 +-
 sound/soc/codecs/cx20442.c                         |   46 +-
 sound/soc/codecs/da7213.c                          |    7 +-
 sound/soc/codecs/da7218.c                          |    9 +-
 sound/soc/codecs/dmic.c                            |   24 +-
 sound/soc/codecs/hdac_hdmi.c                       |  358 ++-
 sound/soc/codecs/max98373.c                        |  976 +++++++
 sound/soc/codecs/max98373.h                        |  213 ++
 sound/soc/codecs/max98926.c                        |    2 +-
 sound/soc/codecs/max98927.c                        |    1 -
 sound/soc/codecs/mc13783.c                         |    9 +-
 sound/soc/codecs/msm8916-wcd-analog.c              |    8 +-
 sound/soc/codecs/nau8540.c                         |   98 +-
 sound/soc/codecs/nau8540.h                         |   20 +
 sound/soc/codecs/nau8824.c                         |   18 +-
 sound/soc/codecs/nau8825.c                         |  101 +-
 sound/soc/codecs/nau8825.h                         |    3 +-
 sound/soc/codecs/pcm186x-i2c.c                     |   69 +
 sound/soc/codecs/pcm186x-spi.c                     |   69 +
 sound/soc/codecs/pcm186x.c                         |  719 ++++++
 sound/soc/codecs/pcm186x.h                         |  220 ++
 sound/soc/codecs/pcm512x-spi.c                     |    4 +
 sound/soc/codecs/rl6231.c                          |   93 +-
 sound/soc/codecs/rt5514-spi.c                      |    1 +
 sound/soc/codecs/rt5514.c                          |   85 +
 sound/soc/codecs/rt5514.h                          |    5 +-
 sound/soc/codecs/rt5645.c                          |  187 +-
 sound/soc/codecs/rt5645.h                          |    6 +
 sound/soc/codecs/sgtl5000.c                        |    7 +-
 sound/soc/codecs/si476x.c                          |    9 +-
 sound/soc/codecs/sn95031.c                         |  936 -------
 sound/soc/codecs/sn95031.h                         |  133 -
 sound/soc/codecs/spdif_receiver.c                  |    5 +-
 sound/soc/codecs/spdif_transmitter.c               |    5 +-
 sound/soc/codecs/tas5720.c                         |   61 +-
 sound/soc/codecs/tas5720.h                         |   31 +
 sound/soc/codecs/tas6424.c                         |  707 +++++
 sound/soc/codecs/tas6424.h                         |  144 ++
 sound/soc/codecs/tfa9879.c                         |    1 +
 sound/soc/codecs/tlv320aic31xx.c                   |  310 +--
 sound/soc/codecs/tlv320aic31xx.h                   |  335 +--
 sound/soc/codecs/tlv320aic32x4.c                   |  182 +-
 sound/soc/codecs/tlv320aic32x4.h                   |  308 ++-
 sound/soc/codecs/tlv320aic3x.c                     |   15 +-
 sound/soc/codecs/tlv320dac33.c                     |   32 +-
 sound/soc/codecs/ts3a227e.c                        |    2 +-
 sound/soc/codecs/tscs42xx.c                        | 1456 +++++++++++
 sound/soc/codecs/tscs42xx.h                        | 2693 ++++++++++++++++++++
 sound/soc/codecs/twl4030.c                         |    9 +-
 sound/soc/codecs/twl6040.c                         |   18 +-
 sound/soc/codecs/uda1380.c                         |   42 +-
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
 sound/soc/davinci/davinci-mcasp.c                  |   19 +
 sound/soc/fsl/eukrea-tlv320.c                      |    1 -
 sound/soc/fsl/fsl-asoc-card.c                      |    4 +-
 sound/soc/fsl/fsl_asrc.h                           |    2 +-
 sound/soc/fsl/fsl_dma.c                            |    4 +-
 sound/soc/fsl/fsl_ssi.c                            | 1367 +++++-----
 sound/soc/fsl/fsl_ssi.h                            |  427 ++--
 sound/soc/fsl/fsl_ssi_dbg.c                        |   59 +-
 sound/soc/hisilicon/hi6210-i2s.c                   |    1 -
 sound/soc/intel/Kconfig                            |  118 +-
 sound/soc/intel/Makefile                           |    2 +-
 sound/soc/intel/atom/sst/sst_acpi.c                |    3 +
 sound/soc/intel/atom/sst/sst_stream.c              |    8 +-
 sound/soc/intel/boards/Kconfig                     |  196 +-
 sound/soc/intel/boards/bytcht_da7213.c             |    4 +-
 sound/soc/intel/boards/bytcht_es8316.c             |   26 +-
 sound/soc/intel/boards/bytcr_rt5640.c              |    4 +-
 sound/soc/intel/boards/bytcr_rt5651.c              |   50 +-
 sound/soc/intel/boards/cht_bsw_rt5645.c            |   13 +-
 sound/soc/intel/boards/cht_bsw_rt5672.c            |    4 +-
 sound/soc/intel/boards/haswell.c                   |    2 +-
 sound/soc/intel/boards/kbl_rt5663_max98927.c       |   97 +-
 .../soc/intel/boards/kbl_rt5663_rt5514_max98927.c  |    2 +-
 sound/soc/intel/boards/mfld_machine.c              |  428 ----
 sound/soc/intel/common/sst-dsp.c                   |    4 +-
 sound/soc/intel/skylake/Makefile                   |    5 +
 sound/soc/intel/skylake/bxt-sst.c                  |    2 +-
 sound/soc/intel/skylake/cnl-sst.c                  |    2 +-
 sound/soc/intel/skylake/skl-i2s.h                  |   95 +
 sound/soc/intel/skylake/skl-messages.c             |   23 +
 sound/soc/intel/skylake/skl-nhlt.c                 |  175 +-
 sound/soc/intel/skylake/skl-pcm.c                  |   14 +-
 sound/soc/intel/skylake/skl-ssp-clk.c              |  429 ++++
 sound/soc/intel/skylake/skl-ssp-clk.h              |  117 +
 sound/soc/intel/skylake/skl-sst-dsp.c              |   14 +-
 sound/soc/intel/skylake/skl-sst-dsp.h              |    4 +
 sound/soc/intel/skylake/skl-sst-utils.c            |    6 +-
 sound/soc/intel/skylake/skl-sst.c                  |    2 +-
 sound/soc/intel/skylake/skl-topology.c             |   45 +-
 sound/soc/intel/skylake/skl.c                      |  150 +-
 sound/soc/intel/skylake/skl.h                      |   28 +
 sound/soc/mediatek/mt2701/mt2701-afe-clock-ctrl.c  |  552 ++--
 sound/soc/mediatek/mt2701/mt2701-afe-clock-ctrl.h  |   15 +-
 sound/soc/mediatek/mt2701/mt2701-afe-common.h      |   87 +-
 sound/soc/mediatek/mt2701/mt2701-afe-pcm.c         |  215 +-
 sound/soc/mediatek/mt2701/mt2701-reg.h             |   42 +-
 sound/soc/mediatek/mt8173/mt8173-afe-pcm.c         |    6 +-
 sound/soc/mediatek/mt8173/mt8173-rt5650-rt5514.c   |    2 -
 sound/soc/mediatek/mt8173/mt8173-rt5650-rt5676.c   |    2 -
 sound/soc/mediatek/mt8173/mt8173-rt5650.c          |    2 -
 sound/soc/mxs/mxs-sgtl5000.c                       |   25 +-
 sound/soc/nuc900/nuc900-ac97.c                     |   11 +-
 sound/soc/omap/ams-delta.c                         |    4 +-
 sound/soc/qcom/apq8016_sbc.c                       |   10 +-
 sound/soc/rockchip/rk3399_gru_sound.c              |   22 +-
 sound/soc/rockchip/rockchip_i2s.c                  |   11 +-
 sound/soc/samsung/bells.c                          |   40 +-
 sound/soc/sh/rcar/core.c                           |  143 +-
 sound/soc/sh/rcar/dma.c                            |   18 -
 sound/soc/sh/rcar/rsnd.h                           |   15 +-
 sound/soc/sh/rcar/ssi.c                            |  163 +-
 sound/soc/soc-acpi.c                               |   73 +-
 sound/soc/soc-compress.c                           |   81 +-
 sound/soc/soc-core.c                               |  155 +-
 sound/soc/soc-io.c                                 |    6 +
 sound/soc/soc-ops.c                                |    4 +-
 sound/soc/soc-pcm.c                                |    7 +-
 sound/soc/soc-utils.c                              |    2 +-
 sound/soc/stm/Kconfig                              |   12 +
 sound/soc/stm/Makefile                             |    3 +
 sound/soc/stm/stm32_adfsdm.c                       |  347 +++
 sound/soc/stm/stm32_sai.c                          |  114 +-
 sound/soc/sunxi/sun4i-codec.c                      |   29 +-
 sound/soc/sunxi/sun4i-i2s.c                        |   57 +-
 sound/soc/sunxi/sun8i-codec.c                      |   82 +-
 sound/soc/uniphier/Kconfig                         |   19 +
 sound/soc/uniphier/Makefile                        |    3 +
 sound/soc/uniphier/evea.c                          |  567 +++++
 sound/soc/ux500/mop500.c                           |    4 +
 sound/soc/ux500/ux500_pcm.c                        |    5 +
 218 files changed, 16235 insertions(+), 5223 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-dfsdm-adc-stm32
 create mode 100644 Documentation/devicetree/bindings/iio/adc/sigma-delta-modulator.txt
 create mode 100644 Documentation/devicetree/bindings/iio/adc/st,stm32-dfsdm-adc.txt
 create mode 100644 Documentation/devicetree/bindings/sound/max98373.txt
 create mode 100644 Documentation/devicetree/bindings/sound/pcm186x.txt
 create mode 100644 Documentation/devicetree/bindings/sound/st,stm32-adfsdm.txt
 create mode 100644 Documentation/devicetree/bindings/sound/ti,tas6424.txt
 create mode 100644 Documentation/devicetree/bindings/sound/tscs42xx.txt
 create mode 100644 Documentation/devicetree/bindings/sound/uniphier,evea.txt
 create mode 100644 Documentation/driver-api/iio/hw-consumer.rst
 create mode 100644 drivers/iio/adc/sd_adc_modulator.c
 create mode 100644 drivers/iio/adc/stm32-dfsdm-adc.c
 create mode 100644 drivers/iio/adc/stm32-dfsdm-core.c
 create mode 100644 drivers/iio/adc/stm32-dfsdm.h
 create mode 100644 drivers/iio/buffer/industrialio-hw-consumer.c
 create mode 100644 include/linux/iio/adc/stm32-dfsdm-adc.h
 create mode 100644 include/linux/iio/hw-consumer.h
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
 create mode 100644 sound/soc/codecs/tscs42xx.c
 create mode 100644 sound/soc/codecs/tscs42xx.h
 delete mode 100644 sound/soc/intel/boards/mfld_machine.c
 create mode 100644 sound/soc/intel/skylake/skl-i2s.h
 create mode 100644 sound/soc/intel/skylake/skl-ssp-clk.c
 create mode 100644 sound/soc/intel/skylake/skl-ssp-clk.h
 create mode 100644 sound/soc/stm/stm32_adfsdm.c
 create mode 100644 sound/soc/uniphier/Kconfig
 create mode 100644 sound/soc/uniphier/Makefile
 create mode 100644 sound/soc/uniphier/evea.c

--32u276st3Jlj2kUU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlp5lSYACgkQJNaLcl1U
h9CvDAf9GBgwNDhrFC1vBWCQgjKcgFHoZNqklimGTsr888/RNVfl+AIcMkLkP3XL
eUFHR1ZJBdeIZg+zrA985X6bJzBUWjxFmjzuahEvydtAHjpdZqCGx3AluNayWeQ0
nuljQaci3k40dEtsiEhk/bqHWraw3MPNFuAGn1tuwnvL7wugWcRqAkxMKk3Xe1ZD
7aurQmqRnLC1DL9jCmbnw8Qk/6YtvkwNfTvoFK4PGqeVp60KeajKqv5mu0b1prbv
uPvw/tim8w92uGaLhLfK9F/d+fQ8dzyNI7dqlKuNrAslkZMWReIYL5yxY0oQr79F
pCcxl8MzT2ituTik5TiYKOg1aYwm3w==
=KJrX
-----END PGP SIGNATURE-----

--32u276st3Jlj2kUU--

--===============5550467208063754707==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5550467208063754707==--
