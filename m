From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/2] ASoC: Blackfin: new machine driver for
	ADAV801/ADAV803 codecs
Date: Sat, 7 Aug 2010 19:21:32 +0100
Message-ID: <8508D31F-DADB-4F0B-A140-DF27A05504F2@opensource.wolfsonmicro.com>
References: <1281194864-23311-1-git-send-email-vapier@gentoo.org>
	<1281194864-23311-2-git-send-email-vapier@gentoo.org>
	(sfid-20100807_162745_613759_835C1C17)
Mime-Version: 1.0 (iPad Mail 7B405)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A93B71037FE
	for <alsa-devel@alsa-project.org>;
	Sat,  7 Aug 2010 20:21:13 +0200 (CEST)
In-Reply-To: <1281194864-23311-2-git-send-email-vapier@gentoo.org>
	(sfid-20100807_162745_613759_835C1C17)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mike Frysinger <vapier@gentoo.org>
Cc: Cliff Cai <cliff.cai@analog.com>, "uclinux-dist-devel@blackfin.uclinux.org" <uclinux-dist-devel@blackfin.uclinux.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Yi Li <yi.li@analog.com>
List-Id: alsa-devel@alsa-project.org

On 7 Aug 2010, at 16:27, Mike Frysinger <vapier@gentoo.org> wrote:

> +config SND_BF5XX_SOC_ADAV80X
> +	tristate "SoC ADAV801/3 Audio support"
> +	depends on SND_BF5XX_I2S && (SPI_MASTER || I2C)
> +	select SND_BF5XX_SOC_I2S
> +	select SND_SOC_ADAV80X
> +	help
> +	  Say Y if you want to add support for ADAV80X SoC audio.

This help text is really not terribly descriptive - this is support for that CODEC on a particular board, not support for the CODEC itself. 

As with the other Blackfin machine drivers you really should look at reporting the particular reference board this is on rather than providing a single driver which assumes a particular hookup for the system. Things like this...

> +	/* For the ADAV80X evaluation board, use the on board crystal
> +	   as XIN, and use XIN as source for PLL1 */
> +	ret = snd_soc_dai_set_pll(codec_dai, ADAV80X_CLK_PLL1,
> +			ADAV80X_CLK_XIN, 27000000, clk);

...aren't going to be true for every system.

> +	/* If you want to use XIN as clock source */
> +	/* ret = snd_soc_dai_set_pll(codec_dai, 0, ADAV80X_CLK_XIN,
> +		27000000, 0); */

This should probably be highlighted by an ifdef or even Kconfig option. Some sort comment explaining why people might want to choose one option or the other would also be useful.
