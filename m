From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v2] ASoC: Intel: Boards: Add GLK Realtek
 Maxim I2S machine driver
Date: Mon, 18 Jun 2018 13:38:07 -0500
Message-ID: <4a16a1f5-3c97-b37f-378d-6c5649e58a45@linux.intel.com>
References: <1529346458-31911-1-git-send-email-naveen.m@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by alsa0.perex.cz (Postfix) with ESMTP id D3BDC266E91
 for <alsa-devel@alsa-project.org>; Mon, 18 Jun 2018 20:38:09 +0200 (CEST)
In-Reply-To: <1529346458-31911-1-git-send-email-naveen.m@intel.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Naveen Manohar <naveen.m@intel.com>, alsa-devel@alsa-project.org
Cc: Harsha Priya <harshapriya.n@intel.com>, broonie@kernel.org, pierre-louis.bossart@intel.com
List-Id: alsa-devel@alsa-project.org



On 06/18/2018 01:27 PM, Naveen Manohar wrote:
> Patch adds Geminilake I2S machine driver which uses following codecs:
> RT5682 and MAX98357A.
>
> v2: reverse xmas tree alignment of var declaration, add Acked-by.
this should go below the --- which is missing below the tags.
some editor issue here maybe?
>
> Signed-off-by: Naveen Manohar <naveen.m@intel.com>
> Signed-off-by: Harsha Priya <harshapriya.n@intel.com>
> Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>
> diff --git a/sound/soc/intel/boards/Kconfig b/sound/soc/intel/boards/Kconfig
> index 2479748..cccda87 100644
> --- a/sound/soc/intel/boards/Kconfig
> +++ b/sound/soc/intel/boards/Kconfig
> @@ -281,6 +281,20 @@ config SND_SOC_INTEL_KBL_DA7219_MAX98357A_MACH
>   	  Say Y if you have such a device.
>   	  If unsure select "N".
>   
> +config SND_SOC_INTEL_GLK_RT5682_MAX98357A_MACH
> +	tristate "GLK with RT5682 and MAX98357A in I2S Mode"
> +	depends on MFD_INTEL_LPSS && I2C && ACPI
> +	select SND_SOC_RT5682
> +	select SND_SOC_MAX98357A
> +	select SND_SOC_DMIC
> +	select SND_SOC_HDAC_HDMI
> +	select SND_HDA_DSP_LOADER
> +	help
> +	   This adds support for ASoC machine driver for Geminilake platforms
> +	   with RT5682 + MAX98357A I2S audio codec.
> +	   Say Y if you have such a device.
> +	   If unsure select "N".
> +
>   endif ## SND_SOC_INTEL_SKYLAKE
>   
>   endif ## SND_SOC_INTEL_MACH
> diff --git a/sound/soc/intel/boards/Makefile b/sound/soc/intel/boards/Makefile
> index 92b5507..87ef8b4 100644
> --- a/sound/soc/intel/boards/Makefile
> +++ b/sound/soc/intel/boards/Makefile
> @@ -6,6 +6,7 @@ snd-soc-sst-bdw-rt5677-mach-objs := bdw-rt5677.o
>   snd-soc-sst-broadwell-objs := broadwell.o
>   snd-soc-sst-bxt-da7219_max98357a-objs := bxt_da7219_max98357a.o
>   snd-soc-sst-bxt-rt298-objs := bxt_rt298.o
> +snd-soc-sst-glk-rt5682_max98357a-objs := glk_rt5682_max98357a.o
>   snd-soc-sst-bytcr-rt5640-objs := bytcr_rt5640.o
>   snd-soc-sst-bytcr-rt5651-objs := bytcr_rt5651.o
>   snd-soc-sst-cht-bsw-rt5672-objs := cht_bsw_rt5672.o
> @@ -27,6 +28,7 @@ obj-$(CONFIG_SND_SOC_INTEL_BYT_RT5640_MACH) += snd-soc-sst-byt-rt5640-mach.o
>   obj-$(CONFIG_SND_SOC_INTEL_BYT_MAX98090_MACH) += snd-soc-sst-byt-max98090-mach.o
>   obj-$(CONFIG_SND_SOC_INTEL_BXT_DA7219_MAX98357A_MACH) += snd-soc-sst-bxt-da7219_max98357a.o
>   obj-$(CONFIG_SND_SOC_INTEL_BXT_RT298_MACH) += snd-soc-sst-bxt-rt298.o
> +obj-$(CONFIG_SND_SOC_INTEL_GLK_RT5682_MAX98357A_MACH) += snd-soc-sst-glk-rt5682_max98357a.o
>   obj-$(CONFIG_SND_SOC_INTEL_BROADWELL_MACH) += snd-soc-sst-broadwell.o
>   obj-$(CONFIG_SND_SOC_INTEL_BDW_RT5677_MACH) += snd-soc-sst-bdw-rt5677-mach.o
>   obj-$(CONFIG_SND_SOC_INTEL_BYTCR_RT5640_MACH) += snd-soc-sst-bytcr-rt5640.o
> diff --git a/sound/soc/intel/boards/glk_rt5682_max98357a.c b/sound/soc/intel/boards/glk_rt5682_max98357a.c
> new file mode 100644
> index 0000000..680382f
> --- /dev/null
> +++ b/sound/soc/intel/boards/glk_rt5682_max98357a.c
> @@ -0,0 +1,644 @@
>
