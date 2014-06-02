From: kevin.strasser@linux.intel.com
Subject: Re: [PATCH] ASoC: intel: The Baytrail/MAX98090 driver
 depends on I2C
Date: Sun, 1 Jun 2014 18:30:03 -0700 (PDT)
Message-ID: <65206.10.254.34.105.1401672603.squirrel@linux.intel.com>
References: <1401650018-31023-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 621B2265205
 for <alsa-devel@alsa-project.org>; Mon,  2 Jun 2014 03:30:40 +0200 (CEST)
In-Reply-To: <1401650018-31023-1-git-send-email-broonie@kernel.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

Hi Mark,

> From: Mark Brown <broonie@linaro.org>
>
> Signed-off-by: Mark Brown <broonie@linaro.org>
> ---
>  sound/soc/intel/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
> index cd3498736e91..c30fedb3e149 100644
> --- a/sound/soc/intel/Kconfig
> +++ b/sound/soc/intel/Kconfig
> @@ -52,7 +52,7 @@ config SND_SOC_INTEL_BYT_RT5640_MACH
>
>  config SND_SOC_INTEL_BYT_MAX98090_MACH
>  	tristate "ASoC Audio driver for Intel Baytrail with MAX98090 codec"
> -	depends on SND_SOC_INTEL_SST && X86_INTEL_LPSS
> +	depends on SND_SOC_INTEL_SST && X86_INTEL_LPSS && I2C

I think the dependency on I2C is specific to the MAX98090 codec.
Can we add this to the codec config entry instead?

Thanks,
Kevin

>  	select SND_SOC_INTEL_BAYTRAIL
>  	select SND_SOC_MAX98090
>  	help
> --
> 2.0.0.rc4
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
