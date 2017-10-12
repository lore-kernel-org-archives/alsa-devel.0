From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH v2 0/9] Baytrail-Cherrytrail updates
Date: Thu, 12 Oct 2017 18:37:56 -0500
Message-ID: <20171012233805.30055-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id CA835266EEB
 for <alsa-devel@alsa-project.org>; Fri, 13 Oct 2017 01:38:14 +0200 (CEST)
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
Cc: tiwai@suse.de, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, liam.r.girdwood@linux.intel.com, vinod.koul@intel.com, broonie@kernel.org, andriy.shevchenko@linux.intel.com
List-Id: alsa-devel@alsa-project.org

As discussed on the alsa-devel mailing list, here is a set of patches to fix

1. previous feedback on bytcht_rt5651 - no new functionality beyond
what was already reviewed
2. cosmetic issues (variables in reverse xmas tree order, etc)
3. unnecessary clock tests
4. addition of a helper to remove duplicate code across machine drivers

The last two patches were not included in the first pass,
they correct an off-by-one issue which has no functional impact
and remove the hard-codec compressed dailinks which don't currently
work with the mainline code+publicly available firmware.

Pierre-Louis Bossart (9):
  ASoC: Intel: bytcr_rt5651: add MCLK, quirks and cleanups
  ASoC: Intel: bytcr_rt5640: cosmetic fixes
  ASoC: Intel: cht_bsw_rt5645: cosmetic fixes
  ASoC: Intel: bytcht_da7213: cosmetic fixes
  ASoC: Intel: bytcht_es8316: remove useless code
  ASoC: Add helper to find codec_dai from dai_name
  ASoC: Intel: boards: use helper to get codec_dai
  ASoC: Intel: boards: fix off-by-one dailink id
  ASoC: Intel: boards: remove hard-coded compressed dailinks

 include/sound/soc.h                             |  14 ++
 sound/soc/intel/boards/bxt_da7219_max98357a.c   |  16 +-
 sound/soc/intel/boards/bytcht_da7213.c          |  17 +-
 sound/soc/intel/boards/bytcht_es8316.c          |  25 +--
 sound/soc/intel/boards/bytcht_nocodec.c         |  10 +-
 sound/soc/intel/boards/bytcr_rt5640.c           | 105 ++++-------
 sound/soc/intel/boards/bytcr_rt5651.c           | 236 +++++++++++++++++++++---
 sound/soc/intel/boards/cht_bsw_max98090_ti.c    |  24 +--
 sound/soc/intel/boards/cht_bsw_rt5645.c         | 103 ++++-------
 sound/soc/intel/boards/cht_bsw_rt5672.c         |  24 +--
 sound/soc/intel/boards/skl_nau88l25_max98357a.c |  16 +-
 sound/soc/intel/boards/skl_nau88l25_ssm4567.c   |  16 +-
 12 files changed, 318 insertions(+), 288 deletions(-)

-- 
2.11.0
