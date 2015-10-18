From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 00/18] ALSA: Add helper function to add single
	value constraint
Date: Sun, 18 Oct 2015 15:39:15 +0200
Message-ID: <1445175573-11784-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-200.synserver.de (smtp-out-225.synserver.de
 [212.40.185.225])
 by alsa0.perex.cz (Postfix) with ESMTP id D8813261691
 for <alsa-devel@alsa-project.org>; Sun, 18 Oct 2015 15:39:39 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Vinod Koul <vinod.koul@intel.com>, Mengdong Lin <mengdong.lin@intel.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Yang A Fang <yang.a.fang@intel.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org

Apologies if you got this series twice, forgot to Cc the mailinglist on
the first try.

This series introduces a new helper function which can be used to constrain
a configuration parameter to a single. So far the recommended and most
efficient way to do this was to set a min-max constraint with the same
value for minimum and maximum. It is not necessarily immediately obvious
though that this is the right way to do things and some driver have come up
with different ways to achieve the same effect, e.g. by installing a list
constraint with a single item. This is less efficient since list
constraints are dynamic constraints which needed to be re-evaluated
multiple times at runtime while a min-max constraint is a static
constraint.

The function introduced in this patch series is called
snd_pcm_hw_constraint_single() which hopefully is semantically more
expressive and makes it clear that this is the function to use when setting
a single value constraint.

All existing drivers that want to set a single value constraint are update
to use the new helper function.

- Lars

Lars-Peter Clausen (18):
  ALSA: Add helper function to add single value constraint
  ALSA: korg1212: Use snd_pcm_hw_constraint_single()
  ALAA: lx6464es: Use snd_pcm_hw_constraint_single()
  ALSA: rme32: Use snd_pcm_hw_constraint_single()
  ALSA: rme96: Use snd_pcm_hw_constraint_single()
  ALSA: rme9652: Use snd_pcm_hw_constraint_single()
  ASoC: adav80x: Use snd_pcm_hw_constraint_single()
  ASoC: twl4030: Use snd_pcm_hw_constraint_single()
  ASoC: uda134x: Use snd_pcm_hw_constraint_single()
  ASoC: wl1273: Use snd_pcm_hw_constraint_single()
  ASoC: n810: Use snd_pcm_hw_constraint_single()
  ASoC: rx51: Use snd_pcm_hw_constraint_single()
  ASoC: pcm: Use snd_pcm_hw_constraint_single()
  ASoC: ux500: Use snd_pcm_hw_constraint_single()
  ASoC: bytcr_rt5640: Use snd_pcm_hw_constraint_single()
  ASoC: cht_bsw_max98090: Use snd_pcm_hw_constraint_single()
  ASoC: cht_bsw_rt5645: Use snd_pcm_hw_constraint_single()
  ASoC: cht_bsw_rt5672: Use snd_pcm_hw_constraint_single()

 include/sound/pcm.h                          | 16 ++++++++++++++++
 sound/pci/korg1212/korg1212.c                |  8 +++++---
 sound/pci/lx6464es/lx6464es.c                |  4 ++--
 sound/pci/rme32.c                            |  4 ++--
 sound/pci/rme96.c                            |  8 ++++----
 sound/pci/rme9652/hdspm.c                    |  9 ++++-----
 sound/soc/codecs/adav80x.c                   |  4 ++--
 sound/soc/codecs/twl4030.c                   | 13 +++++--------
 sound/soc/codecs/uda134x.c                   |  6 ++----
 sound/soc/codecs/wl1273.c                    |  9 ++++-----
 sound/soc/intel/boards/bytcr_rt5640.c        | 14 ++------------
 sound/soc/intel/boards/cht_bsw_max98090_ti.c | 14 ++------------
 sound/soc/intel/boards/cht_bsw_rt5645.c      | 14 ++------------
 sound/soc/intel/boards/cht_bsw_rt5672.c      | 14 ++------------
 sound/soc/omap/n810.c                        |  3 +--
 sound/soc/omap/rx51.c                        |  3 +--
 sound/soc/soc-pcm.c                          | 10 ++++------
 sound/soc/ux500/ux500_msp_dai.c              |  4 ++--
 18 files changed, 62 insertions(+), 95 deletions(-)

-- 
2.1.4
