From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH v2 3/3] ALSA SoC: Add Texas Instruments
 TLV320AIC26 codec driver
Date: Thu, 17 Jul 2008 11:02:15 -0500
Message-ID: <487F6D07.40503@freescale.com>
References: <20080712083929.15025.47682.stgit@trillian.secretlab.ca>
	<20080712083939.15025.31192.stgit@trillian.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	by alsa0.perex.cz (Postfix) with ESMTP id 60186243C8
	for <alsa-devel@alsa-project.org>;
	Thu, 17 Jul 2008 18:02:21 +0200 (CEST)
In-Reply-To: <20080712083939.15025.31192.stgit@trillian.secretlab.ca>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org, liam.girdwood@wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

Grant Likely wrote:

> +	aic26->codec.reg_cache_size = sizeof(aic26->reg_cache);
> +	aic26->codec.reg_cache = aic26->reg_cache;

...

> +	/* Register the sysfs files for debugging */
> +	/* Create SysFS files */
> +	rc = device_create_file(&spi->dev, &dev_attr_regs);
> +	rc |= device_create_file(&spi->dev, &dev_attr_regs_cache);
> +	rc |= device_create_file(&spi->dev, &dev_attr_keyclick);
> +	if (rc)
> +		dev_info(&spi->dev, "error creating sysfs files\n");

I believe ASoC creates sysfs entries if you use reg_cache and reg_cache_size, so
you should not be creating your own sysfs entries if you use these variables.

> +
> +#if defined(CONFIG_SND_SOC_OF)
> +	/* Tell the of_soc helper about this codec */
> +	of_snd_soc_register_codec(&aic26_soc_codec_dev, aic26, &aic26_dai,
> +				  spi->dev.archdata.of_node);
> +#endif

I haven't paid any attention to the of_soc helper, because it's for ASoC V1
only.  However, I don't understand why you need to reference it in the codec
driver.  My CS4270 codec driver knows nothing about OF and works fine in
arch/powerpc.

-- 
Timur Tabi
Linux kernel developer at Freescale
