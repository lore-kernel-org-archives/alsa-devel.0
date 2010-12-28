From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC 4/4] ASoC SST: Add makefiles and kconfigs
	changes
Date: Tue, 28 Dec 2010 15:00:23 +0000
Message-ID: <20101228150022.GF31883@opensource.wolfsonmicro.com>
References: <1293538315-31950-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 6018F1038E5
	for <alsa-devel@alsa-project.org>; Tue, 28 Dec 2010 16:00:11 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1293538315-31950-1-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: " Koul, Vinod" <vinod.koul@intel.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, Harsha Priya <priya.harsha@intel.com>, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Tue, Dec 28, 2010 at 05:41:55PM +0530,  Koul, Vinod wrote:

> @@ -55,6 +55,7 @@ source "sound/soc/samsung/Kconfig"
>  source "sound/soc/s6000/Kconfig"
>  source "sound/soc/sh/Kconfig"
>  source "sound/soc/txx9/Kconfig"
> +source "sound/soc/mid-x86/Kconfig"

Here and elsewhere keep the lists sorted.

>  	select SND_SOC_WM9713 if SND_SOC_AC97_BUS
> -        help
> +        select SND_SOC_MSIC if INTEL_SCU_IPC
> +	help

Random indentation change as well as the sorting issue here.

>            Normally ASoC codec drivers are only built if a machine driver which
>            uses them is also built since they are only usable with a machine
>            driver.  Selecting this option will allow these drivers to be built
> @@ -321,6 +322,8 @@ config SND_SOC_WM9712
>  
>  config SND_SOC_WM9713
>  	tristate
> +config SND_SOC_MSIC
> +	tristate
>  

Sorting and a missing blank line.

> index 6a1e17b..07cedc0 100644
> --- a/sound/soc/codecs/Makefile
> +++ b/sound/soc/codecs/Makefile
> @@ -1,3 +1,4 @@
> +EXTRA_CFLAGS += -DDEBUG
>  snd-soc-88pm860x-objs := 88pm860x-codec.o

This shouldn't be here.

> @@ -0,0 +1,20 @@
> +#config SND_MID_PLATFORM
> +#	tristate "SoC Platform Audio driver for Intel MID chips"
> +#	default y
> +#	help
> +#	  Say Y if you want to add support for SoC platform driver for Intel MID

Remove this if you're not going to use it.

> +config SND_MID_MACHINE
> +	tristate "SOC Machine Audio driver for Intel MID chips"
> +	select SND_SOC_MSIC
> +	select SND_MID_PLATFORM
> +	default n
> +	help
> +	  Say Y if you want to add support for SoC machine driver for Intel MID

No need to specify default n, it is the default.

> +++ b/sound/soc/mid-x86/Makefile
> @@ -0,0 +1,9 @@
> +EXTRA_CFLAGS += -DDEBUG

Omit this too.
