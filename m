From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 00/30] ASoC: Move jack registration to the card
	level
Date: Wed,  4 Mar 2015 10:33:15 +0100
Message-ID: <1425461626-21103-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-196.synserver.de (smtp-out-198.synserver.de
 [212.40.185.198])
 by alsa0.perex.cz (Postfix) with ESMTP id EE2FD264EFF
 for <alsa-devel@alsa-project.org>; Wed,  4 Mar 2015 10:33:50 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Anatol Pomozov <anatol.pomozov@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Stephen Warren <swarren@wwwdotorg.org>, Vinod Koul <vinod.koul@intel.com>, Jie Yang <yang.jie@linux.intel.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Yang A Fang <yang.a.fang@intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Sean Cross <xobs@kosagi.com>, Dylan Reid <dgreid@chromium.org>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org

Audio jacks are typically card level elements and when initially introduced
the API to register a jack took a card as its parameter. Back at that time
there was only one CODEC per card and DAPM support was only available at the
CODEC level and all DAPM elements, including the card level elements, were
registered with the CODEC's DAPM context. So naturally for all its DAPM
operations the jack API used the CODEC's DAPM context. With the
multi-component patchset support for multiple CODECs per card was introduced
and since it was no longer clear which DAPM context to use for the jack
operations the jack API was updated to take a CODEC instead of a card to
make it unambiguous again. Shortly after DAPM support was decoupled from the
CODECs and became available at the card level as well.  Since then card
drivers have been updated to register their card level DAPM elements with
the card's DAPM context, but the jack API is still CODEC centric and uses
the CODEC's DAPM context. This leaves us with some issues.

The DAPM pins that are managed by the jack detection logic are part of the
card DAPM context but are accessed through a CODEC DAPM context. Currently
this works fine and is more of an inelegance, but might break in the future
if we take a more hierarchical approach to DAPM contexts.

Furthermore with componentization progressing systems that do not register a
snd_soc_codec might appear, while these system may still want to able to
register a jack.

This patchset introduces a new function called snd_soc_card_jack_register()
which allows to register the jacks at the card level again and updates all
the existing card drivers to use the new API.

- Lars

Lars-Peter Clausen (30):
  ASoC: sn95031: Pass CODEC to sn95031_jack_detection()
  ASoC: Allow to register jacks at the card level
  ASoC: simple-card: Register jacks at the card level
  ASoC: imx-es8328: Register jacks at the card level
  ASoC: wm1133-ev: Register jacks at the card level
  ASoC: broadwell: Register jacks at the card level
  ASoC: byt-max98090: Register jacks at the card level
  ASoC: cht_bsw_rt5645: Register jacks at the card level
  ASoC: mfld_machine: Register jacks at the card level
  ASoC: ams-deltea: Register jacks at the card level
  ASoC: omap-abe-twl6040: Register jacks at the card level
  ASoC: omap-twl4030: Register jacks at the card level
  ASoC: rx51: Register jacks at the card level
  ASoC: hx4700: Register jacks at the card level
  ASoC: palm27x: Register jacks at the card level
  ASoC: ttc-dkb: Register jacks at the card level
  ASoC: z2: Register jacks at the card level
  ASoC: h1980_uda1380: Register jacks at the card level
  ASoC: littlemill: Register jacks at the card level
  ASoC: lowland: Register jacks at the card level
  ASoC: rx1950_uda1380: Register jacks at the card level
  ASoC: smartq: Register jacks at the card level
  ASoC: speyside: Register jacks at the card level
  ASoC: tobermory: Register jacks at the card level
  ASoC: tegra_alc5632: Register jacks at the card level
  ASoC: tegra_max98090: Register jacks at the card level
  ASoC: tegra_rt5640: Register jacks at the card level
  ASoC: tegra_rt5677: Register jacks at the card level
  ASoC: tegra_wm8903: Register jacks at the card level
  ASoC: Remove snd_soc_jack_new()

 include/sound/soc.h                |  8 +++++---
 sound/soc/codecs/sn95031.c         | 14 +++++++------
 sound/soc/codecs/sn95031.h         |  3 ++-
 sound/soc/fsl/imx-es8328.c         |  6 +++---
 sound/soc/fsl/wm1133-ev1.c         | 12 +++++------
 sound/soc/generic/simple-card.c    | 20 +++++++++---------
 sound/soc/intel/broadwell.c        | 12 +++--------
 sound/soc/intel/byt-max98090.c     | 11 +++-------
 sound/soc/intel/cht_bsw_rt5645.c   | 12 +++++------
 sound/soc/intel/mfld_machine.c     | 24 +++++++++-------------
 sound/soc/omap/ams-delta.c         |  4 ++--
 sound/soc/omap/omap-abe-twl6040.c  | 10 ++++-----
 sound/soc/omap/omap-twl4030.c      | 12 ++++-------
 sound/soc/omap/rx51.c              |  6 +++---
 sound/soc/pxa/hx4700.c             | 11 +++-------
 sound/soc/pxa/palm27x.c            | 11 +++-------
 sound/soc/pxa/ttc-dkb.c            | 15 ++++++--------
 sound/soc/pxa/z2.c                 | 10 +++------
 sound/soc/samsung/h1940_uda1380.c  |  9 ++------
 sound/soc/samsung/littlemill.c     | 12 +++++------
 sound/soc/samsung/lowland.c        | 14 ++++---------
 sound/soc/samsung/rx1950_uda1380.c |  9 ++------
 sound/soc/samsung/smartq_wm8987.c  | 11 ++++------
 sound/soc/samsung/speyside.c       | 14 ++++---------
 sound/soc/samsung/tobermory.c      | 13 ++++--------
 sound/soc/soc-jack.c               | 42 +++++++++++++++++++++++---------------
 sound/soc/tegra/tegra_alc5632.c    |  9 ++++----
 sound/soc/tegra/tegra_max98090.c   | 22 +++++++++-----------
 sound/soc/tegra/tegra_rt5640.c     | 10 +++------
 sound/soc/tegra/tegra_rt5677.c     | 14 ++++++-------
 sound/soc/tegra/tegra_wm8903.c     | 18 ++++++++--------
 31 files changed, 167 insertions(+), 231 deletions(-)

-- 
1.8.0
