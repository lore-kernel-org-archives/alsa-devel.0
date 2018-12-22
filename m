From: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH] ASoC: Intel: fix unmet dependencies in Kconfig
Date: Fri, 21 Dec 2018 16:39:45 -0800
Message-ID: <c4588b86-0746-f05a-6b3f-304d170ecca3@infradead.org>
References: <20181221204955.30993-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181221204955.30993-1-pierre-louis.bossart@linux.intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, alsa-devel@alsa-project.org
Cc: tiwai@suse.de, broonie@kernel.org, linux-kernel@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>, Linux Next Mailing List <linux-next@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On 12/21/18 12:49 PM, Pierre-Louis Bossart wrote:
> Remove warnings by selecting SND_HDA_INTEL_DSP_DETECTION_XYZ only when
> SND_HDA_INTEL is part of the config.
> 
> Fixes: c337104b1a16 ('ALSA: HD-Audio: SKL+: abort probe if DSP is present and Skylake driver selected')
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  sound/soc/intel/Kconfig | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
> index 2fd1b61e8331..555cdb1d87d4 100644
> --- a/sound/soc/intel/Kconfig
> +++ b/sound/soc/intel/Kconfig
> @@ -188,12 +188,12 @@ config SND_SOC_INTEL_SKYLAKE_COMMON
>  	select SND_SOC_TOPOLOGY
>  	select SND_SOC_INTEL_SST
>  	select SND_SOC_HDAC_HDA if SND_SOC_INTEL_SKYLAKE_HDAUDIO_CODEC
> -	select SND_HDA_INTEL_DSP_DETECTION_SKL if SND_SOC_INTEL_SKL
> -	select SND_HDA_INTEL_DSP_DETECTION_APL if SND_SOC_INTEL_APL
> -	select SND_HDA_INTEL_DSP_DETECTION_KBL if SND_SOC_INTEL_KBL
> -	select SND_HDA_INTEL_DSP_DETECTION_GLK if SND_SOC_INTEL_GLK
> -	select SND_HDA_INTEL_DSP_DETECTION_CNL if SND_SOC_INTEL_CNL
> -	select SND_HDA_INTEL_DSP_DETECTION_CFL if SND_SOC_INTEL_CFL
> +	select SND_HDA_INTEL_DSP_DETECTION_SKL if SND_SOC_INTEL_SKL && SND_HDA_INTEL
> +	select SND_HDA_INTEL_DSP_DETECTION_APL if SND_SOC_INTEL_APL && SND_HDA_INTEL
> +	select SND_HDA_INTEL_DSP_DETECTION_KBL if SND_SOC_INTEL_KBL && SND_HDA_INTEL
> +	select SND_HDA_INTEL_DSP_DETECTION_GLK if SND_SOC_INTEL_GLK && SND_HDA_INTEL
> +	select SND_HDA_INTEL_DSP_DETECTION_CNL if SND_SOC_INTEL_CNL && SND_HDA_INTEL
> +	select SND_HDA_INTEL_DSP_DETECTION_CFL if SND_SOC_INTEL_CFL && SND_HDA_INTEL
>  	select SND_SOC_ACPI_INTEL_MATCH
>  	help
>  	  If you have a Intel Skylake/Broxton/ApolloLake/KabyLake/
> 


-- 
~Randy
