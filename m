From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/6] ASoC: ad1980: Stay in 20bit mode
	for	architectures other than blackfin
Date: Fri, 27 Aug 2010 19:06:32 +0100
Message-ID: <20100827180632.GA30429@sirena.org.uk>
References: <1282655384-13357-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 72C79103882
	for <alsa-devel@alsa-project.org>;
	Fri, 27 Aug 2010 20:06:35 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1282655384-13357-1-git-send-email-u.kleine-koenig@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Uwe Kleine-K??nig <u.kleine-koenig@pengutronix.de>
Cc: alsa-devel@alsa-project.org, Sonic Zhang <sonic.zhang@analog.com>, Sascha Hauer <s.hauer@pengutronix.de>, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Tue, Aug 24, 2010 at 03:09:39PM +0200, Uwe Kleine-K??nig wrote:
> From: Sascha Hauer <s.hauer@pengutronix.de>
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> Signed-off-by: Uwe Kleine-K??nig <u.kleine-koenig@pengutronix.de>

Please remember to CC maintainers on patches.

> ---
>  sound/soc/codecs/ad1980.c |   10 +++++++++-
>  1 files changed, 9 insertions(+), 1 deletions(-)
> 
> diff --git a/sound/soc/codecs/ad1980.c b/sound/soc/codecs/ad1980.c
> index 70cfaec..35c0580 100644
> --- a/sound/soc/codecs/ad1980.c
> +++ b/sound/soc/codecs/ad1980.c
> @@ -168,13 +168,21 @@ retry:
>  	}
>  
>  	soc_ac97_ops.reset(codec->ac97);
> +
> +#ifdef SND_BF5XX_SOC_AD1980
>  	/* Set bit 16slot in register 74h, then every slot will has only 16
>  	 * bits. This command is sent out in 20bit mode, in which case the
> -	 * first nibble of data is eaten by the addr. (Tag is always 16 bit)*/
> +	 * first nibble of data is eaten by the addr. (Tag is always 16 bit).
> +	 *
> +	 * This seems to be blackfin specific. On other systems we want 20bit
> +	 * mode.
> +	 */
>  	ac97_write(codec, AC97_AD_SERIAL_CFG, 0x9900);
> +#endif

If you're going to ifdef this out you should be ifdefing it based on the
architecture or the AC'97 controller rather than a specific machine
driver.

>  	if (ac97_read(codec, AC97_RESET)  != 0x0090)
>  		goto err;
> +
>  	return 0;

Random whitespace change...
