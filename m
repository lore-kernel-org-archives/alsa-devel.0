From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 3.2
Date: Tue, 4 Oct 2011 15:16:34 +0100
Message-ID: <20111004141633.GE6934@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 3958E24640
	for <alsa-devel@alsa-project.org>;
	Tue,  4 Oct 2011 16:16:37 +0200 (CEST)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

The following changes since commit 02890535269338a6d2034ad3ce8b22beb24b449a:

  ASoC: ssm2602: Support setting the oscillator and the clock output state (2011-09-27 13:30:48 +0100)

are available in the git repository at:
  git://opensource.wolfsonmicro.com/linux-2.6-asoc.git for-3.2

One MFD change for wm1811 which is here to avoid collisions with wm1811.

Arnd Bergmann (5):
      ASoC: use a valid device for dev_err() in Zylonite
      ASoC: omap_mcpdm_remove cannot be __devexit
      ASoC: imx: eukrea_tlv320 needs i2c
      ASoC: sh: use correct __iomem annotations
      ASoC: samsung: WM8994 depends on MFD_WM8994

Axel Lin (41):
      ASoC: Remove unused "control_data" field of struct wm8940_priv
      ASoC: Remove unused "control_data" field of struct wm8960_priv
      ASoC: Remove unused "control_data" field of struct wm8978_priv
      ASoC: Remove unused "control_data" field of struct wm9081_priv
      ASoC: Remove unused "control_data" field of struct wm9090_priv
      ASoC: Remove unused "control_data" field of struct wm8904_priv
      ASoC: Fix setting adau1373_dai->master for SND_SOC_DAIFMT_CBS_CFS
      ASoC: adau1701: Initialize codec->control_data before using it
      ASoC: Remove unused "control_data" field of struct alc5623_priv
      ASoC: Remove unused "control_data" field of struct cs4270_private
      ASoC: Remove unused "control_data" field of struct cs42l51_private
      ASoC: Remove unused "control_data" field of struct max98088_priv
      ASoC: Remove unused "control_data" field of struct max98095_priv
      ASoC: Remove unused "control_data" field of struct ak4671_priv
      ASoC: adau1701: Fix prototype for adau1701_set_sysclk
      ASoC: tlv320dac33: Add guarding parentheses to macros
      ASoC: Remove unused "control_data" field of struct cs4271_private
      ASoC: Remove unused "control_data" field of struct aic3x_priv
      ASoC: Add missed regulator_unregister_notifier and regulator_bulk_free in wm8995_remove
      ASoC: sn95031: Do not use static variable for channel_index
      ASoC: tlv320aic3x: Use driver_data field of struct i2c_device_id to identify models
      ASoC: Fix setting update bits for WM8753_LADC and WM8753_RADC
      ASoC: wm8782: Add __devexit_p at necessary place
      ASoC: kirkwood-i2s: Add __devexit_p at necessary place
      ASoC: samsung: Add __devexit_p at necessary places
      ASoC: tegra: Staticise tegra_i2s_dai and tegra_spdif_dai
      ASoC: Staticise samsung_spdif_dai
      ASoC: Staticise sh4_ssi_dai
      ASoC: Remove unused rate variable in magician_playback_hw_params
      ASoC: Remove unused srate variable in tegra_spdif_hw_params
      ASoC: Remove needless codec->dapm.bias_level assignment to SND_SOC_BIAS_OFF
      ASoC: Staticise simtec_audio_resume()
      ASoC: Staticise ep93xx_ac97_dai
      ASoC: txx9: Add __exit_p at necessary place
      ASoC: Fix setting update bits for WM8741_DACRMSB_ATTENUATION
      ASoC: samsung: s3c-i2s-v2.c needs module.h
      ASoC: wm8711: Use snd_soc_update_bits for read-modify-write
      ASoC: wm8971: Use snd_soc_update_bits for read-modify-write
      ASoC: wm8988: Use snd_soc_update_bits for read-modify-write
      ASoC: wm8994: Slightly optimize configure_clock
      ASoC: wm8995: Slightly optimize configure_clock

Jarkko Nikula (5):
      ASoC: Davinci: Fix FS polarity for I2S format
      ASoC: omap-mcbsp: Fix FS polarity for LEFT_J, DSP_A and DSP_B formats
      ASoC: omap-mcbsp: Prepare for init time DAI format setting
      ASoC: omap: Convert bunch of machine drivers to use init time DAI format
      ASoC: omap: Use single hw_params callback in sdp3430 and zoom2

Karl Tsou (1):
      ASoC: Add DRC control for WM8996

Mark Brown (12):
      ASoC: Add device ID for WM9093 to WM9090 driver
      ASoC: Allow DAI formats to be specified in the dai_link
      ASoC: Use dai_fmt in speyside_wm8962
      ASoC: Also count neighbour checks for supplies
      ASoC: Staticise non-exported symbols in rt5631
      ASoC: Remove unused function check_vdac_to_outmix from rt5631
      Merge branch 'for-3.1' into for-3.2
      Merge branch 'for-3.1' into for-3.2
      ASoC: Instantiate DAPM widgets before we do the DAI link init
      ASoC: Fix typo in 24.576MHz rate in WM5100
      mfd: Add WM1811 support
      ASoC: Add WM1811 support

Peter Ujfalusi (5):
      ASoC: twl6040: One workqueue should be enough
      ASoC: twl6040: correct loop counters for HS/HF ramp code
      ASoC: twl6040: Shift 2 identifies the HS output in out_drv_event
      ASoC: twl6040: Simplify code in out_drv_event for pending work check
      ASoC: omap-pcm: Fix the no period wakeup implementation

Ryan Mallon (2):
      ASoC: max98088 codec: Catch driver bugs for eq channel name
      ASoC: max98095 codec: Catch driver bugs for biquad channel name

Susan Gao (1):
      ASoC: Fix a bug in WM8962 DSP_A and DSP_B settings

Ujfalusi, Peter (1):
      ASoC: sdp4430: Fix string for FM input name

 drivers/mfd/wm8994-core.c            |   27 ++++++++++
 include/linux/mfd/wm8994/core.h      |    1 +
 include/linux/mfd/wm8994/registers.h |    4 ++
 include/sound/soc-dai.h              |   34 ++++++------
 include/sound/soc.h                  |    2 +
 sound/soc/codecs/adau1373.c          |    2 +-
 sound/soc/codecs/adau1701.c          |    3 +-
 sound/soc/codecs/ak4671.c            |    2 -
 sound/soc/codecs/alc5623.c           |    2 -
 sound/soc/codecs/cs4270.c            |    6 +--
 sound/soc/codecs/cs4271.c            |    5 --
 sound/soc/codecs/cs42l51.c           |    6 +--
 sound/soc/codecs/max98088.c          |   36 ++++++++-----
 sound/soc/codecs/max98095.c          |   34 ++++++++----
 sound/soc/codecs/rt5631.c            |   20 +------
 sound/soc/codecs/sn95031.c           |    3 +-
 sound/soc/codecs/tlv320aic3x.c       |   16 ++----
 sound/soc/codecs/tlv320dac33.c       |    6 +-
 sound/soc/codecs/twl6040.c           |   81 ++++++++++++------------------
 sound/soc/codecs/wm5100.c            |    6 +--
 sound/soc/codecs/wm8711.c            |    6 +--
 sound/soc/codecs/wm8741.c            |    2 +-
 sound/soc/codecs/wm8753.c            |    4 +-
 sound/soc/codecs/wm8782.c            |    2 +-
 sound/soc/codecs/wm8904.c            |    2 -
 sound/soc/codecs/wm8940.c            |    3 -
 sound/soc/codecs/wm8960.c            |    3 -
 sound/soc/codecs/wm8962.c            |    4 +-
 sound/soc/codecs/wm8971.c            |   27 +++-------
 sound/soc/codecs/wm8978.c            |    3 -
 sound/soc/codecs/wm8988.c            |   15 ++----
 sound/soc/codecs/wm8994.c            |   94 +++++++++++++++++++++++++++++----
 sound/soc/codecs/wm8995.c            |   19 ++++---
 sound/soc/codecs/wm8996.c            |    9 +++-
 sound/soc/codecs/wm9081.c            |    3 -
 sound/soc/codecs/wm9090.c            |    4 +-
 sound/soc/davinci/davinci-i2s.c      |    5 ++-
 sound/soc/ep93xx/ep93xx-ac97.c       |    2 +-
 sound/soc/imx/Kconfig                |    1 +
 sound/soc/kirkwood/kirkwood-i2s.c    |    2 +-
 sound/soc/omap/am3517evm.c           |   22 +-------
 sound/soc/omap/igep0020.c            |   23 +--------
 sound/soc/omap/n810.c                |   19 +------
 sound/soc/omap/omap-mcbsp.c          |   21 ++++++--
 sound/soc/omap/omap-pcm.c            |    8 +++
 sound/soc/omap/omap3evm.c            |   23 +--------
 sound/soc/omap/omap3pandora.c        |   20 ++------
 sound/soc/omap/osk5912.c             |   23 +--------
 sound/soc/omap/overo.c               |   23 +--------
 sound/soc/omap/rx51.c                |   20 +-------
 sound/soc/omap/sdp3430.c             |   70 ++-----------------------
 sound/soc/omap/sdp4430.c             |    6 +-
 sound/soc/omap/zoom2.c               |   70 ++-----------------------
 sound/soc/pxa/magician.c             |    3 +-
 sound/soc/pxa/zylonite.c             |    8 ++--
 sound/soc/samsung/Kconfig            |    6 ++
 sound/soc/samsung/ac97.c             |    2 +-
 sound/soc/samsung/i2s.c              |    2 +-
 sound/soc/samsung/pcm.c              |    2 +-
 sound/soc/samsung/s3c-i2s-v2.c       |    1 +
 sound/soc/samsung/s3c2412-i2s.c      |    2 +-
 sound/soc/samsung/s3c24xx-i2s.c      |    2 +-
 sound/soc/samsung/s3c24xx_simtec.c   |    2 +-
 sound/soc/samsung/spdif.c            |    4 +-
 sound/soc/samsung/speyside_wm8962.c  |   19 +------
 sound/soc/sh/fsi.c                   |   10 ++--
 sound/soc/sh/ssi.c                   |    2 +-
 sound/soc/soc-core.c                 |   27 +++++++++-
 sound/soc/soc-dapm.c                 |    2 +
 sound/soc/tegra/tegra_i2s.c          |    2 +-
 sound/soc/tegra/tegra_spdif.c        |    5 +-
 sound/soc/txx9/txx9aclc-generic.c    |    2 +-
 72 files changed, 389 insertions(+), 568 deletions(-)
