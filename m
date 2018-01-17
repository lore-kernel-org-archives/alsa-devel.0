From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH] ASoC: Intel: remove select on non-existing
 SND_SOC_INTEL_COMMON
Date: Wed, 17 Jan 2018 13:14:23 -0600
Message-ID: <661ab8ca-2799-0a46-de45-50d6d46f3afd@linux.intel.com>
References: <20180117184324.3475-1-clabbe.montjoie@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id CBDE7266E0C
 for <alsa-devel@alsa-project.org>; Wed, 17 Jan 2018 20:14:28 +0100 (CET)
In-Reply-To: <20180117184324.3475-1-clabbe.montjoie@gmail.com>
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
To: Corentin Labbe <clabbe.montjoie@gmail.com>, broonie@kernel.org, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 1/17/18 12:43 PM, Corentin Labbe wrote:
> SND_SST_ATOM_HIFI2_PLATFORM_PCI select SND_SOC_INTEL_COMMON which do not
> exists anymore.
> So remove this select.
> 
> Fixes: c6059879be29 ("ASoC: Intel: Fix Kconfig with top-level selector")
> Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>

Yes indeed, it's the only place this remains. Thanks for the patch.

Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

> ---
>   sound/soc/intel/Kconfig | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
> index b0bd1938b71e..f2c9e8c5970a 100644
> --- a/sound/soc/intel/Kconfig
> +++ b/sound/soc/intel/Kconfig
> @@ -77,7 +77,6 @@ config SND_SST_ATOM_HIFI2_PLATFORM_PCI
>   	depends on X86 && PCI
>   	select SND_SST_IPC_PCI
>   	select SND_SOC_COMPRESS
> -	select SND_SOC_INTEL_COMMON
>   	help
>   	  If you have a Intel Medfield or Merrifield/Edison platform, then
>   	  enable this option by saying Y or m. Distros will typically not
> 
