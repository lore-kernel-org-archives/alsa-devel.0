From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 00/14] BYT/CHT codec/machine drivers update
Date: Mon, 28 Aug 2017 06:38:25 -0500
Message-ID: <d5b1f491-523a-734c-76fd-86991039353c@linux.intel.com>
References: <20170822203239.19891-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by alsa0.perex.cz (Postfix) with ESMTP id 7DE91266884
 for <alsa-devel@alsa-project.org>; Mon, 28 Aug 2017 13:38:22 +0200 (CEST)
In-Reply-To: <20170822203239.19891-1-pierre-louis.bossart@linux.intel.com>
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
Cc: tiwai@suse.de, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

Mark, please don't merge this for now. There were a couple of minor 
comments sent privately to me and I need to address them. I will send an 
update later this week. Thanks.

On 8/22/17 3:32 PM, Pierre-Louis Bossart wrote:
> Finally took the time to cleanup known fixes for codec and machine
> drivers. I tested on Baytrail/Cherrytrail and w/ RT5640, 45 and 72.
>
> This should be the last batch of fixes before we move on to the
> integration of SOF (Sound Open Firmware) support in the mainline.
>
> This batch contains two patches already submitted by Thierry Escande
> on alsa-devel but never merged.
>
> Fang, Yang A (1):
>   ASoC: ts3a227e: add acpi table
>
> Pierre-Louis Bossart (12):
>   ASoC: Intel: boards: use devm_clk_get() unconditionally
>   ASoC: intel: cht_bsw_max98090: add support for clock framework
>   ASoC: Intel: cht_bsw_max98090: Fix I2S config + unused code
>   ASoC: Intel: atom: add support for Baytrail Chromebooks
>   ASoC: Intel: bytcr-rt5651: fix capture routes
>   ASoC: Intel: bytcr_rt5651: add MCLK support
>   ASoC: Intel: bytcr_rt5651: filter codec name
>   ASoC: codecs: rt5645: add quirks for Asus T100HA
>   ASoC: Intel: bytcr_rt5640: simplify MCLK quirk tests
>   ASoC: codecs: rt5670: add jack detection quirk for Dell Venue 5585
>   ASoC: Intel: cht_bsw_rt5672: use actual HID in suspend/resume
>   ASoC: Intel: cht_bsw_rt5672: fix card name
>
> Thierry Escande (1):
>   ASoc: cht_bsw_max98090_ti: Fix jack initialization
>
>  sound/soc/codecs/rt5645.c                    |  20 ++
>  sound/soc/codecs/rt5670.c                    |  16 ++
>  sound/soc/codecs/ts3a227e.c                  |  10 +
>  sound/soc/intel/atom/sst/sst_acpi.c          |   8 +
>  sound/soc/intel/boards/bytcr_rt5640.c        |   8 +-
>  sound/soc/intel/boards/bytcr_rt5651.c        | 278 ++++++++++++++++++++++++---
>  sound/soc/intel/boards/cht_bsw_max98090_ti.c | 157 ++++++++++++---
>  sound/soc/intel/boards/cht_bsw_rt5645.c      |  14 +-
>  sound/soc/intel/boards/cht_bsw_rt5672.c      |  36 ++--
>  9 files changed, 460 insertions(+), 87 deletions(-)
>
