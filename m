From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH V2 1/3] new ad1836 codec driver based
	on	asoc
Date: Thu, 13 Aug 2009 15:18:48 +0100
Message-ID: <20090813141848.GD31504@sirena.org.uk>
References: <1250135972-19366-1-git-send-email-21cnbao@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id BC9F31038D7
	for <alsa-devel@alsa-project.org>;
	Thu, 13 Aug 2009 16:18:49 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1250135972-19366-1-git-send-email-21cnbao@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Barry Song <21cnbao@gmail.com>
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Aug 13, 2009 at 11:59:32AM +0800, Barry Song wrote:
> There has been an ad1836 driver in sound/blackfin based on traditional alsa.
> The new driver is based on asoc. The architecture of ad1836 codec driver is
> very much like ad1938.

> Signed-off-by: Barry Song <21cnbao@gmail.com>

This is pretty much there - the issues below are very small so I'll
apply this and fix up everything except the driver name as I do.

> --- a/sound/soc/codecs/Kconfig
> +++ b/sound/soc/codecs/Kconfig
> @@ -68,6 +68,9 @@ config SND_SOC_AC97_CODEC
>  	tristate
>  	select SND_AC97_CODEC
>  
> +config SND_SOC_AD1836
> +	tristate
> +
>  config SND_SOC_AD1938
>  	tristate

Sorry, missed this first time round - this should also add to
SND_SOC_ALL_CODECS.

> +static struct spi_driver ad1836_spi_driver = {
> +	.driver = {
> +		.name	= "ad1836-spi",

I thought the conclusion from the discussion earlier was that this
should have the -spi dropped (or did that discussion cross in the post
with the patch)?

> +struct snd_soc_codec_device soc_codec_dev_ad1836 = {
> +	.probe = 	ad1836_probe,
> +	.remove = 	ad1836_remove,
> +	/* The power management of ad1836 is very simple. There are
> +	 * only adc&dac 2 components to control. Dapm handles them.
> +	 */
> +	.suspend =      NULL,
> +	.resume =       NULL,

I'll remove the suspend/resume methods here.
