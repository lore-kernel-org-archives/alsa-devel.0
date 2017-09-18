From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 0/7] BYT/CHT clocks/max98090 updates
Date: Mon, 18 Sep 2017 09:06:25 +0530
Message-ID: <20170918033625.GF30097@localhost>
References: <20170908051309.19028-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 031A3266F88
 for <alsa-devel@alsa-project.org>; Mon, 18 Sep 2017 05:32:39 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20170908051309.19028-1-pierre-louis.bossart@linux.intel.com>
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
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, liam.r.girdwood@linux.intel.com, broonie@kernel.org, jarkko.nikula@linux.intel.com, andriy.shevchenko@linux.intel.com
List-Id: alsa-devel@alsa-project.org

On Fri, Sep 08, 2017 at 12:13:02AM -0500, Pierre-Louis Bossart wrote:
> This patchset corrects issues with an earlier submission (missing
> signoffs, error case not consistent) and enables the cht_bsw_max98090
> machine driver on Baytrail. This should help distributions solve
> problems with Baytrail Chromebooks which required a specific build.
> These patches were tested on Lenovo 100s ('orco'/Baytrail) and Acer
> R11 ('cyan'/Cherrytrail), using the same build based on
> CONFIG_SND_SOC_INTEL_CHT_BSW_MAX98090_TI_MACH=m.  Playback on
> speakers/headphone and capture from internal mic work fine. UCM files
> are available at
> https://github.com/plbossart/UCM/tree/master/byt-max98090
> 
> Thanks to Jarkko Nikula and Andy Shevchenko for their comments on an
> initial version reviewed internally at Intel.

Acked-By: Vinod Koul <vinod.koul@intel.com>

> 
> Fang, Yang A (1):
>   ASoC: ts3a227e: add acpi table
> 
> Pierre-Louis Bossart (5):
>   ASoC: max98090: reduce verbosity on PLL unlock
>   ASoC: Intel: cht_bsw_max98090: Fix I2S config + unused code
>   ASoC: Intel: cht_bsw_max98090: add support for Baytrail
>   ASoC: Intel: atom: use cht_bsw_max98090 for Baytrail Chromebooks
>   ASoC: Intel: cht_bsw_max98090: add gpio-based jack detection
> 
> Thierry Escande (1):
>   ASoc: Intel: cht_bsw_max98090_ti: Fix jack initialization
> 
>  sound/soc/codecs/max98090.c                  |   2 +-
>  sound/soc/codecs/ts3a227e.c                  |  10 ++
>  sound/soc/intel/atom/sst/sst_acpi.c          |   8 ++
>  sound/soc/intel/boards/cht_bsw_max98090_ti.c | 185 ++++++++++++++++++++++++---
>  4 files changed, 186 insertions(+), 19 deletions(-)
> 
> -- 
> 2.9.3
> 

-- 
~Vinod
