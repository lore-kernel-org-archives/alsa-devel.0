From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 00/13] ASoC: Move IO and kcontrols to the
	component level
Date: Tue, 18 Mar 2014 09:02:03 +0100
Message-ID: <1395129736-11938-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-224.synserver.de (smtp-out-230.synserver.de
 [212.40.185.230])
 by alsa0.perex.cz (Postfix) with ESMTP id 5C38A261ADE
 for <alsa-devel@alsa-project.org>; Tue, 18 Mar 2014 09:01:36 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Brian Austin <brian.austin@cirrus.com>, Lars-Peter Clausen <lars@metafoo.de>, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, Paul Handrigan <Paul.Handrigan@cirrus.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Hi,

This series is the first step towards full componentisation of the ASoC core. It
moves both the IO abstraction layers within ASoC as well as the standard set of
kcontrols to the component level. This for example means we can get rid of
constructs like

	if (w->codec)
		snd_soc_read(....)
	else if(w->platform)
		snd_soc_platform_read(...)

Moving the kcontrols to the component level means we can use the same
implementation also for other non-CODEC components. E.g. there seems to be an
increasing amount of CPU components that have basic signal processing and things
like volume controls etc. whose register layout is similar to those used in
CODECs. Currently each CPU component driver re-implements these controls by
hand.

The first two patches introduce two new helper functions which hide the actual
implementation on how the CODEC or platform struct that register a control can
be obtained from the control. This means that when the actual implementation is
changed only the two helper functions need to be updated and not every single
driver. The patches that follow that are just cleanups removing unused IO stuff
and move all IO functions to soc-io.c. The next step is to make platforms also
components. And then finally first the IO abstraction layers in ASoC are unified
at the component level and then on top of that the kcontrol helpers are moved to
the component level.

The series depends on quite a few topic branches related to changes to the core
and cleanups for individual drivers. It is probably best to place it on top of
asoc-v3.15-2. The patch that moves the kcontrols to the component level also has
a runtime dependency on the not yet applied patches that move the ams-delta and
mfld_machine controls to the card level.

- Lars

Lars-Peter Clausen (13):
  ASoC: Add snd_soc_kcontrol_codec() helper function
  ASoC: Add snd_soc_kcontrol_platform() helper function
  ASoC: Prepare SOC_SINGLE_XR_SX controls for regmap
  ASoC: Move IO functions to soc-io.c
  ASoC: Drop ASoC level caching from hw_write/hw_read
  ASoC: Remove IO register modifier callbacks
  ASoC: Add helper function to cast component back to CODEC
  ASoC: Track which components have been registered with
    snd_soc_register_component()
  ASoC: Let snd_soc_platform subclass snd_soc_component
  ASoC: Move IO abstraction to the component level
  ASoC: Move standard kcontrol helpers to the component level
  ASoC: Remove snd_soc_update_bits_locked()
  ASoC: dapm: Rename soc_widget_update_bits_locked() to
    soc_widget_update_bits()

 include/sound/soc-dapm.h          |   1 +
 include/sound/soc.h               | 114 +++++++--
 sound/soc/codecs/88pm860x-codec.c |   8 +-
 sound/soc/codecs/ab8500-codec.c   |  12 +-
 sound/soc/codecs/adav80x.c        |   4 +-
 sound/soc/codecs/ak4641.c         |   4 +-
 sound/soc/codecs/cs4270.c         |   2 +-
 sound/soc/codecs/cs4271.c         |   4 +-
 sound/soc/codecs/cs42l51.c        |   4 +-
 sound/soc/codecs/da7210.c         |   4 +-
 sound/soc/codecs/da7213.c         |   4 +-
 sound/soc/codecs/da732x.c         |   4 +-
 sound/soc/codecs/da9055.c         |   2 +-
 sound/soc/codecs/lm4857.c         |   4 +-
 sound/soc/codecs/max9768.c        |   4 +-
 sound/soc/codecs/max98088.c       |  12 +-
 sound/soc/codecs/max98090.c       |   4 +-
 sound/soc/codecs/max98095.c       |  16 +-
 sound/soc/codecs/pcm1681.c        |   4 +-
 sound/soc/codecs/rt5631.c         |   4 +-
 sound/soc/codecs/sgtl5000.c       |   4 +-
 sound/soc/codecs/sta32x.c         |   4 +-
 sound/soc/codecs/tas5086.c        |   4 +-
 sound/soc/codecs/tlv320aic23.c    |   4 +-
 sound/soc/codecs/tlv320dac33.c    |   4 +-
 sound/soc/codecs/twl4030.c        |  10 +-
 sound/soc/codecs/twl6040.c        |   8 +-
 sound/soc/codecs/wl1273.c         |  12 +-
 sound/soc/codecs/wm2000.c         |   8 +-
 sound/soc/codecs/wm8350.c         |   4 +-
 sound/soc/codecs/wm8400.c         |   2 +-
 sound/soc/codecs/wm8580.c         |   2 +-
 sound/soc/codecs/wm8731.c         |   4 +-
 sound/soc/codecs/wm8753.c         |   4 +-
 sound/soc/codecs/wm8804.c         |   4 +-
 sound/soc/codecs/wm8903.c         |   4 +-
 sound/soc/codecs/wm8904.c         |  14 +-
 sound/soc/codecs/wm8955.c         |   4 +-
 sound/soc/codecs/wm8958-dsp2.c    |  32 +--
 sound/soc/codecs/wm8960.c         |   4 +-
 sound/soc/codecs/wm8962.c         |   8 +-
 sound/soc/codecs/wm8983.c         |   4 +-
 sound/soc/codecs/wm8985.c         |   4 +-
 sound/soc/codecs/wm8990.c         |   2 +-
 sound/soc/codecs/wm8991.c         |   2 +-
 sound/soc/codecs/wm8994.c         |  10 +-
 sound/soc/codecs/wm8996.c         |   4 +-
 sound/soc/codecs/wm9081.c         |   4 +-
 sound/soc/codecs/wm_adsp.c        |   4 +-
 sound/soc/codecs/wm_hubs.c        |   2 +-
 sound/soc/intel/sst-haswell-pcm.c |   8 +-
 sound/soc/soc-cache.c             |   2 -
 sound/soc/soc-core.c              | 520 ++++++++++++++++----------------------
 sound/soc/soc-dapm.c              |  91 +------
 sound/soc/soc-io.c                | 220 +++++++++++++---
 55 files changed, 644 insertions(+), 592 deletions(-)

-- 
1.8.0
