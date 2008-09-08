From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 5/5] Separate common pxa2xx-pcm code
Date: Mon, 8 Sep 2008 11:33:22 +0100
Message-ID: <20080908103321.GE790@sirena.org.uk>
References: <20080908085339.GA31573@doriath.ww600.siemens.net>
	<1220864773-31745-1-git-send-email-dbaryshkov@gmail.com>
	<1220864773-31745-2-git-send-email-dbaryshkov@gmail.com>
	<1220864773-31745-3-git-send-email-dbaryshkov@gmail.com>
	<1220864773-31745-4-git-send-email-dbaryshkov@gmail.com>
	<1220864773-31745-5-git-send-email-dbaryshkov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 3F8FD103824
	for <alsa-devel@alsa-project.org>;
	Mon,  8 Sep 2008 12:33:24 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1220864773-31745-5-git-send-email-dbaryshkov@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Dmitry Baryshkov <dbaryshkov@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Sep 08, 2008 at 01:06:13PM +0400, Dmitry Baryshkov wrote:

> +#include <linux/platform_device.h>
> +#include <sound/ac97_codec.h>

ac97_codec.h should've been added earlier on in the patch series - this
patch doesn't add a new requirement for ac97.

The same thing appears to apply to platform_device.h if it's required at
all.

>  config SND_PXA2XX_LIB
>  	tristate
> -	select SND_AC97_CODEC
> +	select SND_AC97_CODEC if SND_PXA2XX_LIB_AC97
> +
> +config SND_PXA2XX_LIB_AC97
> +	bool
>  
>  config SND_PXA2XX_AC97
>  	tristate "AC97 driver for the Intel PXA2xx chip"
>  	depends on ARCH_PXA
>  	select SND_PXA2XX_PCM
> -	select SND_PXA2XX_LIB
> +	select SND_PXA2XX_LIB_AC97
>  	help
>  	  Say Y or M if you want to support any AC97 codec attached to
>  	  the PXA2xx AC97 interface.

>  obj-$(CONFIG_SND_PXA2XX_LIB)	+= snd-pxa2xx-lib.o
> -snd-pxa2xx-lib-objs		:= pxa2xx-ac97-lib.o
> +snd-pxa2xx-lib-y		:= pxa2xx-pcm-lib.o
> +snd-pxa2xx-lib-$(CONFIG_SND_PXA2XX_LIB_AC97)	+= pxa2xx-ac97-lib.o

> +EXPORT_SYMBOL(__pxa2xx_pcm_hw_params);

Hrm.  The existing ASoC stuff is all EXPORT_SYMBOL_GPL(), as much on the
basis of potential churn as anything else.  Especially for the __
functions it might be nice to preserve that.

> +EXPORT_SYMBOL(pxa2xx_pcm_free_dma_buffers);
> +
> +MODULE_AUTHOR("Nicolas Pitre");
> +MODULE_DESCRIPTION("Intel PXA2xx sound library");
> +MODULE_LICENSE("GPL");

Probably as well to drop the Intel here :)
