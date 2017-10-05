From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 0/6] Baytrail-Cherrytrail updates
Date: Thu,  5 Oct 2017 13:52:37 -0500
Message-ID: <20171005185243.4174-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id AF22F2675B1
 for <alsa-devel@alsa-project.org>; Thu,  5 Oct 2017 20:52:51 +0200 (CEST)
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
Cc: tiwai@suse.de, vinod.koul@intel.com, broonie@kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

As discussed on the alsa-devel mailing list, here is a set of patches to fix

1. previous feedback on bytcht_rt5651 - no new functionality beyond
what was already reviewed
2. cosmetic issues (variables in reverse xmas tree order, etc)
3. unnecessary clock tests

Since the changes are very small, I grouped them by machine
driver instead of generating more patches. let me know if a different
split is needed.

The last patch addresses Andy's comment that we should not use
strncmp(a,b,strlen(b)) when strcmp(a,b) is fine. This change is
applied across all machine drivers.

Pierre-Louis Bossart (6):
  ASoC: Intel: bytcr_rt5651: add MCLK support and fix quirks
  ASoC: Intel: bytcr_rt5651: filter codec name and fix variable
    declarations
  ASoC: Intel: bytcr_rt5640: cosmetic fixes
  ASoC: Intel: cht_bsw_rt5645: cosmetic fixes
  ASoC: Intel: bytcht_da7213: cosmetic fixes
  ASoC: Intel: boards: use strcmp with constant literals

 sound/soc/intel/boards/bxt_da7219_max98357a.c   |   3 +-
 sound/soc/intel/boards/bytcht_da7213.c          |   6 +-
 sound/soc/intel/boards/bytcht_es8316.c          |   3 +-
 sound/soc/intel/boards/bytcr_rt5640.c           |  79 ++++----
 sound/soc/intel/boards/bytcr_rt5651.c           | 257 ++++++++++++++++++++++--
 sound/soc/intel/boards/cht_bsw_max98090_ti.c    |   3 +-
 sound/soc/intel/boards/cht_bsw_rt5645.c         |  79 ++++----
 sound/soc/intel/boards/cht_bsw_rt5672.c         |   3 +-
 sound/soc/intel/boards/skl_nau88l25_max98357a.c |   3 +-
 sound/soc/intel/boards/skl_nau88l25_ssm4567.c   |   3 +-
 10 files changed, 324 insertions(+), 115 deletions(-)

-- 
2.11.0
