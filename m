From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH V1 06/13] Allow a custom ASOC fabric	driver
	with soc-of-simple
Date: Thu, 14 May 2009 11:41:40 +0100
Message-ID: <20090514104140.GE28291@sirena.org.uk>
References: <20090514015729.28145.30483.stgit@terra>
	<20090514015912.28145.22291.stgit@terra>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 49B7D2442D
	for <alsa-devel@alsa-project.org>;
	Thu, 14 May 2009 12:41:42 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20090514015912.28145.22291.stgit@terra>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jon Smirl <jonsmirl@gmail.com>
Cc: grant.likely@secretlab.ca, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, May 13, 2009 at 09:59:12PM -0400, Jon Smirl wrote:

> Allow a custom ASOC fabric driver with soc-of-simple. Register multiple DAIs. If no custom fabric driver, supply a default one so that ASOC binding will complete.

Hrm.  I'm not sure the way you're providing a default behaviour here is
going to work (see comments below).  Would it not be better to have
something in the OF tree that specifies non-default behaviour?
Obviously that opens the whole can of worms with OpenFirmware not being
able to cope with machine drivers well, though that's probably going to
have to be dealt with at some point.

Also, note that it's spelt 'ASoC'.  I'm fairly sure I've mentioned this
to you before.

> +#define SOC_OF_SIMPLE_MAX_DAI 2
> +

Why not make this dynamic?  It's also surprising to see this in the
header, it should be an implementation detail.

> +int of_snd_soc_register_cpu_dai(struct device_node *node,
> +				 struct snd_soc_dai *cpu_dai, int count);
> +

ASoC is moving towards having all DAIs register equivalently.  Might be
as well to consider supporting this here too, though the core isn't
quite there yet.

> +int of_snd_soc_register_default_fabric(void);

> +#include <sound/soc-of-simple.h>
>  
>  static int __init alsa_sound_last_init(void)
>  {
>  	int idx, ok = 0;
> -	
> +
> +#if defined(CONFIG_SND_SOC_OF_SIMPLE)
> +	of_snd_soc_register_default_fabric();
> +#endif 	

This approach relies on having things built in or being able to load the
modules before the alsa_sound_last_init() is called.  That's not
something that's going to be reliably doable for all systems - netbooted
development systems are a common example here.

>  #if defined(CONFIG_SND_SOC_OF_SIMPLE)
>  	/* Tell the of_soc helper about this codec */
> -	of_snd_soc_register_codec(&aic26_soc_codec_dev, aic26, &aic26_dai,
> +	of_snd_soc_register_codec(&aic26_soc_codec_dev, aic26, &aic26_dai, 1,
>  				  spi->dev.archdata.of_node);
>  #endif

If, as previously discussed, this were merged with the core you could
pick most of this data out of the snd_soc_codec.

> +	of_soc->card.name = (char *)template_name;

This cast is suspect..

> -	if ((!of_soc->device.codec_data) || (!of_soc->platform_node))
> +	if ((!of_soc->device.codec_data) || (!of_soc->cpu_dai_node) ||
> +									!of_soc->card.platform || !of_soc->card.name)

Looks like something went very wrong with the indentation here.

> +	pr_info("registering ASoC platform driver: %s\n", platform->name);

pr_debug().
