From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 5/6] ASoC: ad1980: verify cache at
	probe	time
Date: Fri, 27 Aug 2010 19:23:47 +0100
Message-ID: <20100827182347.GE30429@sirena.org.uk>
References: <1282655384-13357-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<1282655384-13357-5-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 2E32924679
	for <alsa-devel@alsa-project.org>;
	Fri, 27 Aug 2010 20:23:48 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1282655384-13357-5-git-send-email-u.kleine-koenig@pengutronix.de>
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
Cc: alsa-devel@alsa-project.org, Sonic Zhang <sonic.zhang@analog.com>, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Tue, Aug 24, 2010 at 03:09:43PM +0200, Uwe Kleine-K??nig wrote:

> Signed-off-by: Uwe Kleine-K??nig <u.kleine-koenig@pengutronix.de>

Pretty much the same comments apply to this as applied to the
immediately preceeding patch - doing it at driver level seems like the
wrong approacg and please always remember to CC maintainers on patches.
Also...

> ---
>  sound/soc/codecs/ad1980.c |   13 +++++++++++++
>  1 files changed, 13 insertions(+), 0 deletions(-)
> 
> diff --git a/sound/soc/codecs/ad1980.c b/sound/soc/codecs/ad1980.c
> index 864e65d..a3e78d4 100644
> --- a/sound/soc/codecs/ad1980.c
> +++ b/sound/soc/codecs/ad1980.c
> @@ -288,6 +288,19 @@ static int ad1980_soc_probe(struct platform_device *pdev)
>  	snd_soc_add_controls(codec, ad1980_snd_ac97_controls,
>  				ARRAY_SIZE(ad1980_snd_ac97_controls));
>  
> +#if AC97_USE_CACHE
> +	pr_debug("%s: cache verify\n", __func__);
> +	for (vendor_id2 = 0; vendor_id2 < 0x80; vendor_id2 += 2) {

...this should probably be selected separately and...

> +
> +		u16 *cache = codec->reg_cache;
> +		ret = soc_ac97_ops.read(codec->ac97, vendor_id2);
> +		if (ret != cache[vendor_id2 >> 1])
> +			pr_debug("%s: %02x -> %04x\n",
> +					__func__, vendor_id2, ret);

...this seems like the wrong priority if there are any inconsistencies.
Note that if the chip includes anything that might reasonably vary (like
revision information or status readback) you probably want to handle
that too.

> +	}
> +	pr_debug("%s: /cache verify\n", __func__);
> +#endif
> +
>  	return 0;
>  
>  reset_err:
> -- 
> 1.7.1
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

-- 
"You grabbed my hand and we fell into it, like a daydream - or a fever."
