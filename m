From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v2 2/2] ASoC: Intel:Add Cherrytrail &
 Braswell machine driver cht_bsw_rt5645
Date: Tue, 3 Feb 2015 11:49:27 -0800
Message-ID: <20150203194927.GB4489@intel.com>
References: <1422746560-91398-1-git-send-email-yang.a.fang@intel.com>
 <1422991551-28544-1-git-send-email-yang.a.fang@intel.com>
 <1422991551-28544-2-git-send-email-yang.a.fang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 90359260433
 for <alsa-devel@alsa-project.org>; Tue,  3 Feb 2015 20:51:37 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1422991551-28544-2-git-send-email-yang.a.fang@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: yang.a.fang@intel.com
Cc: alsa-devel@alsa-project.org, harshapriya.n@intel.com, praveen.k.jain@intel.com, lgirdwood@gmail.com, kevin.strasser@intel.com, denny.iriawan@intel.com, broonie@kernel.org, mengdong.lin@intel.com, bardliao@realtek.com
List-Id: alsa-devel@alsa-project.org

On Tue, Feb 03, 2015 at 11:25:51AM -0800, yang.a.fang@intel.com wrote:
> From: "Fang, Yang A" <yang.a.fang@intel.com>
> 
> Add machine driver for two Intel Cherryview-based platforms, Cherrytrail
> and Braswell, with RT5645 codec
> 
> Signed-off-by: Fang, Yang A <yang.a.fang@intel.com>
> ---
>  sound/soc/intel/Kconfig          |   11 ++
>  sound/soc/intel/Makefile         |    2 +
>  sound/soc/intel/cht_bsw_rt5645.c |  322 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 335 insertions(+)
>  create mode 100644 sound/soc/intel/cht_bsw_rt5645.c
> 
> diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
> index f06fcf1..12093fd 100644
> --- a/sound/soc/intel/Kconfig
> +++ b/sound/soc/intel/Kconfig
> @@ -110,3 +110,14 @@ config SND_SOC_INTEL_CHT_BSW_RT5672_MACH
>            platforms with RT5672 audio codec.
>            Say Y if you have such a device
>            If unsure select "N".
> +
> +config SND_SOC_INTEL_CHT_BSW_RT5645_MACH
> +	tristate "ASoC Audio driver for Intel Cherrytrail & Braswell with RT5645 codec"
> +	depends on X86_INTEL_LPSS
> +	select SND_SOC_RT5645
> +	select SND_SST_MFLD_PLATFORM
> +	select SND_SST_IPC_ACPI
> +	help
> +	  This adds support for ASoC machine driver for Intel(R) Cherrytrail & Braswell
> +	  platforms with RT5645 audio codec.
> +	  If unsure select "N".
> diff --git a/sound/soc/intel/Makefile b/sound/soc/intel/Makefile
> index e928ec3..a8e53c4 100644
> --- a/sound/soc/intel/Makefile
> +++ b/sound/soc/intel/Makefile
> @@ -28,6 +28,7 @@ snd-soc-sst-byt-max98090-mach-objs := byt-max98090.o
>  snd-soc-sst-broadwell-objs := broadwell.o
>  snd-soc-sst-bytcr-dpcm-rt5640-objs := bytcr_dpcm_rt5640.o
>  snd-soc-sst-cht-bsw-rt5672-objs := cht_bsw_rt5672.o
> +snd-soc-sst-cht-bsw-rt5645-objs := cht_bsw_rt5645.o
>  
>  obj-$(CONFIG_SND_SOC_INTEL_HASWELL_MACH) += snd-soc-sst-haswell.o
>  obj-$(CONFIG_SND_SOC_INTEL_BYT_RT5640_MACH) += snd-soc-sst-byt-rt5640-mach.o
> @@ -35,6 +36,7 @@ obj-$(CONFIG_SND_SOC_INTEL_BYT_MAX98090_MACH) += snd-soc-sst-byt-max98090-mach.o
>  obj-$(CONFIG_SND_SOC_INTEL_BROADWELL_MACH) += snd-soc-sst-broadwell.o
>  obj-$(CONFIG_SND_SOC_INTEL_BYTCR_RT5640_MACH) += snd-soc-sst-bytcr-dpcm-rt5640.o
>  obj-$(CONFIG_SND_SOC_INTEL_CHT_BSW_RT5672_MACH) += snd-soc-sst-cht-bsw-rt5672.o
> +obj-$(CONFIG_SND_SOC_INTEL_CHT_BSW_RT5645_MACH) += snd-soc-sst-cht-bsw-rt5645.o
>  
>  # DSP driver
>  obj-$(CONFIG_SND_SST_IPC) += sst/
> diff --git a/sound/soc/intel/cht_bsw_rt5645.c b/sound/soc/intel/cht_bsw_rt5645.c
> new file mode 100644
> index 0000000..02d2377
> --- /dev/null
> +++ b/sound/soc/intel/cht_bsw_rt5645.c
> @@ -0,0 +1,322 @@
> +/*
> + *  cht-bsw-rt5645.c - ASoc Machine driver for Intel Cherryview-based platforms
> + *                     Cherrytrail and Braswell, with RT5645 codec.
> + *
> + *  Copyright (C) 2014 Intel Corp
nitpick, this should be 2014-15. Otherwise looks good

Acked-by: VInod Koul <vinod.koul@intel.com>

-- 
~Vinod
