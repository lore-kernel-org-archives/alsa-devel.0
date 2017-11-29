From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [RFC PATCH v2 5/7] ASoC: Intel: boards: align
 Kconfig dependencies for Haswell/Broadwell
Date: Wed, 29 Nov 2017 16:01:41 +0530
Message-ID: <20171129103140.GB32417@localhost>
References: <20171129014551.30552-1-pierre-louis.bossart@linux.intel.com>
 <20171129014551.30552-6-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id B1B43266A74
 for <alsa-devel@alsa-project.org>; Wed, 29 Nov 2017 11:28:10 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20171129014551.30552-6-pierre-louis.bossart@linux.intel.com>
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
Cc: alsa-devel@alsa-project.org, arnd@arndb.de, tiwai@suse.de, linux-kernel@vger.kernel.org, liam.r.girdwood@linux.intel.com, broonie@kernel.org, andriy.shevchenko@linux.intel.com, torvalds@linux-foundation.org
List-Id: alsa-devel@alsa-project.org

On Tue, Nov 28, 2017 at 07:45:49PM -0600, Pierre-Louis Bossart wrote:
> Make sure that the same I2C/I2C_DESIGNWARE_PLATFORM are selected.
> The latter might actually need to be moved to the SOC side of things,
> it really has no place in a machine driver dependency

not really, given that we will come with platforms where I2C may not be used
for audio, we should keep this in machine or better move to codecs as it
belongs to them, machine being second best :)

> 
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---
>  sound/soc/intel/boards/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/intel/boards/Kconfig b/sound/soc/intel/boards/Kconfig
> index df41a6016217..a1e169c86526 100644
> --- a/sound/soc/intel/boards/Kconfig
> +++ b/sound/soc/intel/boards/Kconfig
> @@ -42,7 +42,7 @@ config SND_SOC_INTEL_HASWELL_MACH
>  
>  config SND_SOC_INTEL_BDW_RT5677_MACH
>  	tristate "ASoC Audio driver for Intel Broadwell with RT5677 codec"
> -	depends on X86_INTEL_LPSS && GPIOLIB && I2C
> +	depends on X86_INTEL_LPSS && I2C && I2C_DESIGNWARE_PLATFORM && GPIOLIB
>  	select SND_SOC_RT5677
>  	help
>  	  This adds support for Intel Broadwell platform based boards with
> -- 
> 2.14.1
> 

-- 
~Vinod
