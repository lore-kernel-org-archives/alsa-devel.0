From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 0/9] Add Cannonlake Audio DSP support
Date: Thu, 3 Aug 2017 10:28:52 +0530
Message-ID: <20170803045851.GD3053@localhost>
References: <20170802162120.8935-1-guneshwor.o.singh@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id B42FF2664EB
 for <alsa-devel@alsa-project.org>; Thu,  3 Aug 2017 06:55:53 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20170802162120.8935-1-guneshwor.o.singh@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Guneshwor Singh <guneshwor.o.singh@intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Patches Audio <patches.audio@intel.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Aug 02, 2017 at 09:51:11PM +0530, Guneshwor Singh wrote:
> Cannonlake (CNL) audio is similar to Broxton with a substantial difference
> in ipc registers. This series enables CNL support by adding required dsp
> library functions and ipc register programming. CNL has 4 dsp cores,
> additional core support is also added here.
> 
> To accommodate the above changes in the current code, existing helper
> functions, common functions that are reusable and dsp ops are modified.

Acked-By: Vinod Koul <vinod.koul@intel.com>

> 
> Dharageswari R (1):
>   ASoC: Intel: Skylake: Add num of cores in dsp ops
> 
> Guneshwor Singh (7):
>   ASoC: Intel: Skylake: Use num_core to allocate instead of macro
>   ASoC: Intel: cnl: Add cnl dsp functions and registers
>   ASoC: Intel: Skylake: Move platform specific init to platform
>     dsp_init()
>   ASoC: Intel: cnl: Unstatify common ipc functions
>   ASoC: Intel: cnl: Add sst library functions for cnl platform
>   ASoC: Intel: cnl: add dsp ops for cannonlake
>   ASoC: Intel: cnl: add pci id for cnl
> 
> Pardha Saradhi K (1):
>   ASoC: Intel: Skylake: Add dsp cores management
> 
>  sound/soc/intel/skylake/Makefile        |   5 +-
>  sound/soc/intel/skylake/bxt-sst.c       |   5 +-
>  sound/soc/intel/skylake/cnl-sst-dsp.c   | 274 ++++++++++++++++++
>  sound/soc/intel/skylake/cnl-sst-dsp.h   | 112 ++++++++
>  sound/soc/intel/skylake/cnl-sst.c       | 495 ++++++++++++++++++++++++++++++++
>  sound/soc/intel/skylake/skl-messages.c  |  31 ++
>  sound/soc/intel/skylake/skl-sst-dsp.c   |   2 +-
>  sound/soc/intel/skylake/skl-sst-ipc.c   |   6 +-
>  sound/soc/intel/skylake/skl-sst-ipc.h   |  12 +-
>  sound/soc/intel/skylake/skl-sst-utils.c |   6 +-
>  sound/soc/intel/skylake/skl-sst.c       |   6 +-
>  sound/soc/intel/skylake/skl-topology.c  |  26 +-
>  sound/soc/intel/skylake/skl.c           |  11 +
>  sound/soc/intel/skylake/skl.h           |   1 +
>  14 files changed, 970 insertions(+), 22 deletions(-)
>  create mode 100644 sound/soc/intel/skylake/cnl-sst-dsp.c
>  create mode 100644 sound/soc/intel/skylake/cnl-sst-dsp.h
>  create mode 100644 sound/soc/intel/skylake/cnl-sst.c
> 
> -- 
> 2.13.0
> 

-- 
~Vinod
