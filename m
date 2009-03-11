From: Daniel Mack <daniel@caiaq.de>
Subject: Re: [PATCH 3/3][RFC] ASoC: pxa-ssp: Don't
	use	SSCR0_SerClkDiv and SSCR0_SCR
Date: Wed, 11 Mar 2009 19:44:16 +0100
Message-ID: <20090311184416.GA29865@buzzloop.caiaq.de>
References: <1236795420-12175-1-git-send-email-philipp.zabel@gmail.com>
	<1236795420-12175-3-git-send-email-philipp.zabel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 2F34D1038A2
	for <alsa-devel@alsa-project.org>; Wed, 11 Mar 2009 19:44:22 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1236795420-12175-3-git-send-email-philipp.zabel@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Philipp Zabel <philipp.zabel@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Mar 11, 2009 at 07:17:00PM +0100, Philipp Zabel wrote:
> As soon as CONFIG_PXA25x is enabled, those macros only handle the PXA25x_SSP
> case, which is wrong most of the time (and always wrong on >=PXA27x).

Ah, I just (while reading this header file) wondered how this is
supposed to work :)

> @@ -287,10 +287,17 @@ static void ssp_set_scr(struct ssp_priv *priv, u32 div)
>  {
>  	struct ssp_dev *dev = &priv->dev;
>  	struct ssp_device *ssp = dev->ssp;
> -	u32 sscr0 = ssp_read_reg(dev->ssp, SSCR0) & ~SSCR0_SCR;
> +	u32 sscr0 = ssp_read_reg(dev->ssp, SSCR0);
>  
>  	priv->scr_div = div;
> -	ssp_write_reg(ssp, SSCR0, (sscr0 | SSCR0_SerClkDiv(div)));
> +	if (ssp->type == PXA25x_SSP) {
> +		sscr0 &= ~0x0000ff00;        /* SSCR0_SCR */
> +		sscr0 |= ((div - 2)/2) << 8; /* SSCR0_SerClkDiv(div) */
> +	} else {
> +		sscr0 &= ~0x000fff00;        /* SSCR0_SCR */
> +		sscr0 |= (div - 1) << 8;     /* SSCR0_SerClkDiv(div) */
> +	}
> +	ssp_write_reg(ssp, SSCR0, sscr0);
>  }

Then we need something like ssp_get_scr() as well to cover my special
case which uses SSCR0_SCR and SSCR0_SerClkDiv() again as you proposed ;)

Daniel
