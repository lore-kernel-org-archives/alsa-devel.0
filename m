From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] tlv320aic3x symmetric rates
Date: Wed, 18 Aug 2010 10:19:29 +0100
Message-ID: <20100818091928.GA5719@sirena.org.uk>
References: <AANLkTimG1yR48_hZiKJrG_kuXK0d5EHXA8DnCun4Eq2A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id D25B82447A
	for <alsa-devel@alsa-project.org>;
	Wed, 18 Aug 2010 11:19:29 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <AANLkTimG1yR48_hZiKJrG_kuXK0d5EHXA8DnCun4Eq2A@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Randolph Chung <rchung42@gmail.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Wed, Aug 18, 2010 at 05:09:45PM +0800, Randolph Chung wrote:
> The tlv320aic3x codec driver only supports symmetric rates for
> capture/playback. Set the flag in the DAI accordingly.
> 
> Signed-off-by: Randolph Chung <tausq@parisc-linux.org>

Please remember to always CC maintainers on patches.

> diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
> index 71a6990..63cad43 100644
> --- a/sound/soc/codecs/tlv320aic3x.c
> +++ b/sound/soc/codecs/tlv320aic3x.c
> @@ -1116,6 +1116,7 @@ struct snd_soc_dai aic3x_dai = {
>                 .rates = AIC3X_RATES,
>                 .formats = AIC3X_FORMATS,},
>         .ops = &aic3x_dai_ops,
> +       .symmetric_rates = 1,
>  };
>  EXPORT_SYMBOL_GPL(aic3x_dai);
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> 

-- 
"You grabbed my hand and we fell into it, like a daydream - or a fever."
