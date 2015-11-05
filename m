From: Mengdong Lin <mengdong.lin@linux.intel.com>
Subject: Re: [PATCH v2 00/13] ASoC: topology: Add support for
 PCM, BE & CC links
Date: Thu, 5 Nov 2015 18:15:39 +0800
Message-ID: <563B2C4B.4030901@linux.intel.com>
References: <cover.1446717205.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 3FC74260557
 for <alsa-devel@alsa-project.org>; Thu,  5 Nov 2015 11:00:13 +0100 (CET)
In-Reply-To: <cover.1446717205.git.mengdong.lin@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, broonie@kernel.org
Cc: tiwai@suse.de, mengdong.lin@intel.com, liam.r.girdwood@linux.intel.com, vinod.koul@intel.com, jeeja.kp@intel.com, subhransu.s.prusty@intel.com
List-Id: alsa-devel@alsa-project.org

Hi Mark,

Sorry, please over look this thread now.

I should wait for your comments on the other thread "[PATCH v2 0/2] 
ASoC: Change the PCM runtime array to a list" at first. The 2 patches
are preparation to support dynamic PCM in topology.

Thanks
Mengdong

On 11/05/2015 05:58 PM, mengdong.lin@linux.intel.com wrote:
> From: Mengdong Lin <mengdong.lin@linux.intel.com>
>
> This series allows the topology core to create PCM devices dynamically,
> as well as configure BE and CC DAI links.
>
> Mengdong Lin (12):
>    ASoC: Vendor drivers get a link's runtime by snd_soc_get_pcm_runtime()
>    ASoC: Change the PCM runtime array to a list
>    ASoC: Define soc_init_dai_link() to wrap link intialization.
>    ASoC: Change 2nd argument of soc_bind_dai_link() to DAI link pointer
>    ASoC: Implement DAI links in a list & define API to add a link
>    ASoC: Add add_dai_link ops for a soc card
>    ASoC: soc_bind_dai_link() directly returns success for a bound DAI
>      link
>    ASoC: Bind new DAI links after probing components
>    ASoC: The soc card can have auxiliary components
>    ASoC: Support adding a DAI dynamically
>    ASoC: topology: Add PCM DAIs dynamically when loading them
>    ASoC: topology: Add support for FE DAI links
>
> Vedang Patel (1):
>    ASoC: topology: Add support for BE and CC DAI Links
>
>   include/sound/soc-dai.h                      |   1 +
>   include/sound/soc-topology.h                 |  22 +-
>   include/sound/soc.h                          |  38 +-
>   sound/soc/fsl/fsl-asoc-card.c                |   5 +-
>   sound/soc/fsl/imx-wm8962.c                   |  10 +-
>   sound/soc/generic/simple-card.c              |  12 +-
>   sound/soc/intel/atom/sst-mfld-platform-pcm.c |  12 +-
>   sound/soc/intel/boards/cht_bsw_max98090_ti.c |   7 +-
>   sound/soc/intel/boards/cht_bsw_rt5645.c      |   7 +-
>   sound/soc/intel/boards/cht_bsw_rt5672.c      |   7 +-
>   sound/soc/pxa/mioa701_wm9713.c               |   6 +-
>   sound/soc/samsung/bells.c                    |  40 +-
>   sound/soc/samsung/littlemill.c               |  32 +-
>   sound/soc/samsung/odroidx2_max98090.c        |   9 +-
>   sound/soc/samsung/snow.c                     |   9 +-
>   sound/soc/samsung/speyside.c                 |  12 +-
>   sound/soc/samsung/tobermory.c                |  21 +-
>   sound/soc/sh/rcar/core.c                     |   2 +-
>   sound/soc/sh/rcar/rsrc-card.c                |   6 +-
>   sound/soc/soc-core.c                         | 629 ++++++++++++++++++---------
>   sound/soc/soc-dapm.c                         |   7 +-
>   sound/soc/soc-pcm.c                          |  22 +-
>   sound/soc/soc-topology.c                     | 284 ++++++++++--
>   sound/soc/tegra/tegra_wm8903.c               |   3 +-
>   24 files changed, 879 insertions(+), 324 deletions(-)
>
