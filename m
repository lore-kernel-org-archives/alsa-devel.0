From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 0/6] ASoC: PCM format type conversion fixes
Date: Wed, 25 Jul 2018 23:17:16 +0200
Message-ID: <20180725211722.18944-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 3473226775C
 for <alsa-devel@alsa-project.org>; Wed, 25 Jul 2018 23:17:27 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Nicolin Chen <nicoleotsuka@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>, Timur Tabi <timur@kernel.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

Hi,

the PCM format is a fixed type with __bitwise, and it needs cast or
other trick to deal with integer.  This is a series of such fixes for
ASoC.


Takashi

===

Takashi Iwai (6):
  ALSA: pcm: Add snd_mask_set_format() helper for standard usages
  ASoC: doc: Replace open code with params_set_format()
  ASoC: intel: Fix snd_pcm_format_t handling
  ASoC: fsl: Use snd_mask_set_format()
  ASoC: pcm186x: Declare PCM format with snd_pcm_format_t
  ASoC: dmaengine: Use standard pcm_format_to_bits() macro

 Documentation/sound/soc/dpcm.rst                    |  4 +---
 include/sound/pcm_params.h                          | 10 ++++++++--
 sound/soc/codecs/pcm186x.c                          |  2 +-
 sound/soc/fsl/fsl-asoc-card.c                       |  2 +-
 sound/soc/intel/boards/bdw-rt5677.c                 |  4 +---
 sound/soc/intel/boards/bxt_da7219_max98357a.c       |  2 +-
 sound/soc/intel/boards/bxt_rt298.c                  |  2 +-
 sound/soc/intel/boards/kbl_da7219_max98357a.c       |  2 +-
 sound/soc/intel/boards/kbl_rt5663_max98927.c        |  4 ++--
 sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c |  4 ++--
 sound/soc/intel/boards/skl_nau88l25_max98357a.c     |  2 +-
 sound/soc/intel/boards/skl_nau88l25_ssm4567.c       |  2 +-
 sound/soc/intel/boards/skl_rt286.c                  |  2 +-
 sound/soc/soc-generic-dmaengine-pcm.c               |  2 +-
 14 files changed, 23 insertions(+), 21 deletions(-)

-- 
2.18.0
