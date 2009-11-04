From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC ADS117x ADC driver
Date: Wed, 4 Nov 2009 18:25:47 +0000
Message-ID: <20091104182546.GE25044@sirena.org.uk>
References: <1257356962.2887.488.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 3B83024427
	for <alsa-devel@alsa-project.org>; Wed,  4 Nov 2009 19:25:48 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1257356962.2887.488.camel@odin>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel <alsa-devel@alsa-project.org>, Graeme Gregory <gg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Wed, Nov 04, 2009 at 05:49:22PM +0000, Liam Girdwood wrote:

> @@ -261,3 +265,4 @@ config SND_SOC_WM9713
>  # Amp
>  config SND_SOC_MAX9877
>  	tristate
> +

Extra whitespace.

> +#define ADS117X_RATES (SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_11025 |\
> +		SNDRV_PCM_RATE_16000 | SNDRV_PCM_RATE_22050 |\
> +		SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000 )

There's SNDRV_PCM_RATE_8000_48000

> +       ret = snd_soc_init_card(socdev);
> +       if (ret < 0) {
> +               printk(KERN_ERR "ads117x: failed to register card\n");
> +               goto card_err;

I just last night did a patch pulling the snd_soc_init_card() stuff into
the core in preparation for multi-CODEC support.  Since there's no way
you'd have known about that churn I'll take a look at updating the
driver myself.

> +static int __init ads117x_modinit(void)
> +{
> +	return snd_soc_register_dai(&ads117x_dai);
> +}
> +module_init(ads117x_modinit);
> +
> +static void __exit ads117x_exit(void)
> +{
> +	snd_soc_unregister_dai(&ads117x_dai);
> +}
> +module_exit(ads117x_exit);

This should be using standard device model stuff - I know there are some
older drivers that have not yet been updated but the goal is to reduce
that number, it's down to only 11 now.
