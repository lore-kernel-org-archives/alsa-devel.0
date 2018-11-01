From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 0/7] ASoC: Intel: cleanups
Date: Thu, 1 Nov 2018 16:12:48 +0200
Message-ID: <20181101141248.GW10650@smile.fi.intel.com>
References: <20181101010718.2878-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id E351E2677D0
 for <alsa-devel@alsa-project.org>; Thu,  1 Nov 2018 15:12:52 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20181101010718.2878-1-pierre-louis.bossart@linux.intel.com>
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
Cc: tiwai@suse.de, vinod.koul@intel.com, alsa-devel@alsa-project.org, broonie@kernel.org, liam.r.girdwood@linux.intel.com
List-Id: alsa-devel@alsa-project.org

On Wed, Oct 31, 2018 at 08:07:11PM -0500, Pierre-Louis Bossart wrote:
> This patchset contain 4 different cleanups:
> a) change of pdata definition to avoid using SST-specific structures
> and allow for machine driver reuse w/ SOF. No new features, just
> different data structures.
> b) removal of remaining GFP_ATOMIC usages
> c) Cleanup of machine driver tables for APL (missing SOF information
> and quirk for APL RVP/LeafHill CRB boards). These boards are used
> outside of Intel so it's worth sharing the fixes for the general
> public.
> d) typo
> 

Looks like a nice clean up!
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

P.S. Nevertheless, please consider comments to the quirk adding patch

> Bard liao (1):
>   ASoC: Intel: common: add SOF information for APL RVP
> 
> Pierre-Louis Bossart (6):
>   ASoC: acpi: define common interface for machine driver configuration
>   ASoC: Intel: use standard interface for Hdaudio machine driver
>   ASoC: Intel: use standard interface for Atom machine drivers
>   ASoC: Intel: boards: fix Skylake typo
>   ASoC: Intel: remove GFP_ATOMIC, use GFP_KERNEL
>   ASoC: Intel: common: add quirk for APL RVP boards
> 
>  include/sound/soc-acpi.h                      | 14 +++++++
>  sound/soc/intel/atom/sst/sst_acpi.c           |  4 ++
>  sound/soc/intel/atom/sst/sst_pvt.c            |  4 +-
>  sound/soc/intel/boards/bytcr_rt5640.c         |  6 +--
>  sound/soc/intel/boards/bytcr_rt5651.c         |  6 +--
>  sound/soc/intel/boards/cht_bsw_rt5645.c       |  6 +--
>  sound/soc/intel/boards/cht_bsw_rt5672.c       |  2 +-
>  sound/soc/intel/boards/glk_rt5682_max98357a.c |  2 +-
>  sound/soc/intel/boards/kbl_da7219_max98927.c  |  8 ++--
>  sound/soc/intel/boards/kbl_rt5663_max98927.c  |  4 +-
>  sound/soc/intel/boards/skl_hda_dsp_generic.c  | 22 +++++------
>  .../soc/intel/boards/skl_nau88l25_max98357a.c |  4 +-
>  sound/soc/intel/boards/skl_nau88l25_ssm4567.c |  4 +-
>  .../intel/common/soc-acpi-intel-bxt-match.c   | 38 +++++++++++++++++++
>  sound/soc/intel/skylake/skl.c                 | 10 ++---
>  15 files changed, 87 insertions(+), 47 deletions(-)
> 
> -- 
> 2.17.1
> 

-- 
With Best Regards,
Andy Shevchenko
