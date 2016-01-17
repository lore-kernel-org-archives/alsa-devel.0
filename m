From: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
Subject: Re: [PATCH] ALSA: at73c213: manage SSC clock
Date: Sun, 17 Jan 2016 14:43:19 +0000
Message-ID: <yw1xegdgtgfs.fsf@unicorn.mansr.com>
References: <1452969349-9810-1-git-send-email-mans@mansr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1452969349-9810-1-git-send-email-mans@mansr.com> (Mans
	Rullgard's message of "Sat, 16 Jan 2016 18:35:49 +0000")
Sender: linux-kernel-owner@vger.kernel.org
To: Hans-Christian Egtvedt <egtvedt@samfundet.no>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

Mans Rullgard <mans@mansr.com> writes:

> Since commit 49af54ff0fc7 ("misc: atmel-ssc: prepare clock only when
> request") the SSC driver expects clients to manage the SSC clock.
> Update this driver accordingly.
>
> Signed-off-by: Mans Rullgard <mans@mansr.com>
> ---
>  sound/spi/at73c213.c | 8 ++++++++
>  1 file changed, 8 insertions(+)

On second thoughts, please disregard this patch.  It's better to enable
the clock only when it is actually required.

> diff --git a/sound/spi/at73c213.c b/sound/spi/at73c213.c
> index 39522367897c..3b2d0b2be421 100644
> --- a/sound/spi/at73c213.c
> +++ b/sound/spi/at73c213.c
> @@ -981,6 +981,8 @@ static int snd_at73c213_probe(struct spi_device *=
spi)
>  		goto out_card;
>  	}
>
> +	clk_enable(chip->ssc->clk);
> +
>  	retval =3D snd_at73c213_dev_init(card, spi);
>  	if (retval)
>  		goto out_ssc;
> @@ -998,6 +1000,7 @@ static int snd_at73c213_probe(struct spi_device =
*spi)
>  	goto out;
>
>  out_ssc:
> +	clk_disable(chip->ssc->clk);
>  	ssc_free(chip->ssc);
>  out_card:
>  	snd_card_free(card);
> @@ -1066,6 +1069,9 @@ out:
>  	/* Stop DAC master clock. */
>  	clk_disable(chip->board->dac_clk);
>
> +	/* Stop SSC clock. */
> +	clk_disable(chip->ssc->clk);
> +
>  	ssc_free(chip->ssc);
>  	snd_card_free(card);
>
> @@ -1080,6 +1086,7 @@ static int snd_at73c213_suspend(struct device *=
dev)
>  	struct snd_at73c213 *chip =3D card->private_data;
>
>  	ssc_writel(chip->ssc->regs, CR, SSC_BIT(CR_TXDIS));
> +	clk_disable(chip->ssc->clk);
>  	clk_disable(chip->board->dac_clk);
>
>  	return 0;
> @@ -1091,6 +1098,7 @@ static int snd_at73c213_resume(struct device *d=
ev)
>  	struct snd_at73c213 *chip =3D card->private_data;
>
>  	clk_enable(chip->board->dac_clk);
> +	clk_enable(chip->ssc->clk);
>  	ssc_writel(chip->ssc->regs, CR, SSC_BIT(CR_TXEN));
>
>  	return 0;
> --=20
> 2.7.0
>

--=20
M=E5ns Rullg=E5rd
