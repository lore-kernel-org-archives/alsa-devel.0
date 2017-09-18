From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 0/5] BYT/CHT-Realtek remaining fixes
Date: Mon, 18 Sep 2017 09:04:29 +0530
Message-ID: <20170918033429.GD30097@localhost>
References: <20170908174356.23788-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id 06188266819
 for <alsa-devel@alsa-project.org>; Mon, 18 Sep 2017 05:30:44 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20170908174356.23788-1-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: tiwai@suse.de, liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, andriy.shevchenko@linux.intel.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

On Fri, Sep 08, 2017 at 12:43:51PM -0500, Pierre-Louis Bossart wrote:
> This last batch for the week is about simplification of the
> MCLK-related code for byt/cht-realtek machine drivers and fixes for
> rt5651. This is mostly a v2 of patches I submitted earlier, with
> improvements suggested by Andy Shevchenko, a fixed mistake on quirk
> management flagged by Vinod Koul and better commit messages. No new
> functionality otherwise.

Acked-By: Vinod Koul <vinod.koul@intel.com>

> 
> Pierre-Louis Bossart (5):
>   ASoC: Intel: boards: use devm_clk_get() unconditionally
>   ASoC: Intel: bytcr-rt5651: fix capture routes
>   ASoC: Intel: bytcr_rt5651: add MCLK support and fix quirks
>   ASoC: Intel: bytcr_rt5651: filter codec name
>   ASoC: Intel: bytcr_rt5640: simplify MCLK quirk tests
> 
>  sound/soc/intel/boards/bytcr_rt5640.c   |   8 +-
>  sound/soc/intel/boards/bytcr_rt5651.c   | 277 ++++++++++++++++++++++++++++----
>  sound/soc/intel/boards/cht_bsw_rt5645.c |  14 +-
>  sound/soc/intel/boards/cht_bsw_rt5672.c |  27 +---
>  4 files changed, 265 insertions(+), 61 deletions(-)
> 
> -- 
> 2.9.3
> 

-- 
~Vinod
