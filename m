From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH v2 5/6] ARM: DaVinci: ASoC: Add
	machine	driver support for DM646x
Date: Thu, 16 Apr 2009 13:51:24 +0100
Message-ID: <20090416125124.GP16318@sirena.org.uk>
References: <1239921918-27019-1-git-send-email-naresh@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id ED3A224378
	for <alsa-devel@alsa-project.org>;
	Thu, 16 Apr 2009 14:51:24 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1239921918-27019-1-git-send-email-naresh@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Naresh Medisetty <naresh@ti.com>
Cc: alsa-devel@alsa-project.org, Steve Chen <schen@mvista.com>, davinci-linux-open-source@linux.davincidsp.com, Pavel Kiryukhin <pkiryukhin@ru.mvista.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Apr 16, 2009 at 06:45:18PM -0400, Naresh Medisetty wrote:

> +static struct snd_soc_dai_link dm6467_evm_dai[] = {
> +	{
> +		.name = "TLV320AIC3X",
> +		.stream_name = "AIC3X",
> +		.cpu_dai = davinci_iis_mcasp_dai,

It'd be better to refer to the element in the array here.  It'd also be
better if your DAI driver provided constants which the machine drivers
could use to get the array indexes rather than hard coding them.

> +		.name = "MCASP S/PDIF",

McASP instead?  These names are mostly for human consumption.

> +/* davinci dm6467 evm audio machine driver */
> +static struct snd_soc_card dm6467_snd_soc_card_evm = {
> +		.name = "DaVinci DM6467 EVM",
> +		.platform = &davinci_soc_platform,
> +		.dai_link = dm6467_evm_dai,
> +		.num_links = 2,

ARRAY_SIZE().

>  /* evm audio private data */
>  static struct aic3x_setup_data evm_aic3x_setup = {
> -	.i2c_bus = 0,
> +	.i2c_bus = 1,
>  	.i2c_address = 0x1b,
>  };

This looks like a separate bug fix which should be split out and sent
for merge in 2.6.30?

>  static void __exit evm_exit(void)
>  {
>  	platform_device_unregister(evm_snd_device);
> +
>  }

Extra blank line added here.
