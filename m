From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 0/5] BYT/CHT-Realtek remaining fixes
Date: Fri,  8 Sep 2017 12:43:51 -0500
Message-ID: <20170908174356.23788-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 278D5266DF0
 for <alsa-devel@alsa-project.org>; Fri,  8 Sep 2017 19:44:02 +0200 (CEST)
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

This last batch for the week is about simplification of the
MCLK-related code for byt/cht-realtek machine drivers and fixes for
rt5651. This is mostly a v2 of patches I submitted earlier, with
improvements suggested by Andy Shevchenko, a fixed mistake on quirk
management flagged by Vinod Koul and better commit messages. No new
functionality otherwise.

Pierre-Louis Bossart (5):
  ASoC: Intel: boards: use devm_clk_get() unconditionally
  ASoC: Intel: bytcr-rt5651: fix capture routes
  ASoC: Intel: bytcr_rt5651: add MCLK support and fix quirks
  ASoC: Intel: bytcr_rt5651: filter codec name
  ASoC: Intel: bytcr_rt5640: simplify MCLK quirk tests

 sound/soc/intel/boards/bytcr_rt5640.c   |   8 +-
 sound/soc/intel/boards/bytcr_rt5651.c   | 277 ++++++++++++++++++++++++++++----
 sound/soc/intel/boards/cht_bsw_rt5645.c |  14 +-
 sound/soc/intel/boards/cht_bsw_rt5672.c |  27 +---
 4 files changed, 265 insertions(+), 61 deletions(-)

-- 
2.9.3
