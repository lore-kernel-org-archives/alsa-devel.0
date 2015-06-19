From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH] ASoC: Intel Kconfig: add
	SND_SOC_INTEL_BOARDS option
Date: Fri, 19 Jun 2015 13:38:06 +0530
Message-ID: <20150619080806.GJ28601@localhost>
References: <1434657579-21581-1-git-send-email-michele.curti@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 28CEF26053B
 for <alsa-devel@alsa-project.org>; Fri, 19 Jun 2015 10:06:36 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1434657579-21581-1-git-send-email-michele.curti@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Michele Curti <michele.curti@gmail.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, lgirdwood@gmail.com, broonie@kernel.org, jarkko.nikula@linux.intel.com
List-Id: alsa-devel@alsa-project.org

On Thu, Jun 18, 2015 at 09:59:39PM +0200, Michele Curti wrote:
> Machine drivers under boards folder must be available for both
> SND_SST_MFLD_PLATFORM and SND_SOC_INTEL_SST.  This patch adds a
> new kernel option SND_SOC_INTEL_BOARD to permit this.

I dont think we need another config option, we should rather use SND_SOC :)

Also Liam, do we need a prompt for SND_SOC_INTEL_SST, i am thinking of
removing that one and have it selected by respective machine drivers?

-- 
~Vinod


> 
> Signed-off-by: Michele Curti <michele.curti@gmail.com>
> ---
>  sound/soc/intel/Kconfig  | 5 +++++
>  sound/soc/intel/Makefile | 2 +-
>  2 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
> index f3060a4..c442cd7 100644
> --- a/sound/soc/intel/Kconfig
> +++ b/sound/soc/intel/Kconfig
> @@ -10,7 +10,11 @@ config SND_MFLD_MACHINE
>            Say Y if you have such a device
>            If unsure select "N".
>  
> +config SND_SOC_INTEL_BOARDS
> +	tristate
> +
>  config SND_SST_MFLD_PLATFORM
> +	select SND_SOC_INTEL_BOARDS
>  	tristate
>  
>  config SND_SST_IPC
> @@ -28,6 +32,7 @@ config SND_SST_IPC_ACPI
>  config SND_SOC_INTEL_SST
>  	tristate "ASoC support for Intel(R) Smart Sound Technology"
>  	select SND_SOC_INTEL_SST_ACPI if ACPI
> +	select SND_SOC_INTEL_BOARDS
>  	depends on (X86 || COMPILE_TEST)
>  	depends on DW_DMAC_CORE
>  	help
> diff --git a/sound/soc/intel/Makefile b/sound/soc/intel/Makefile
> index 3853ec2..4c4bf74 100644
> --- a/sound/soc/intel/Makefile
> +++ b/sound/soc/intel/Makefile
> @@ -7,4 +7,4 @@ obj-$(CONFIG_SND_SOC_INTEL_BAYTRAIL) += baytrail/
>  obj-$(CONFIG_SND_SST_MFLD_PLATFORM) += atom/
>  
>  # Machine support
> -obj-$(CONFIG_SND_SOC_INTEL_SST) += boards/
> +obj-$(CONFIG_SND_SOC_INTEL_BOARDS) += boards/
> -- 
> 2.4.3
> 

-- 
