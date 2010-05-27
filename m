From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH] imx-ssi.c: fix I2S slave setup
Date: Thu, 27 May 2010 10:24:17 +0200
Message-ID: <20100527082417.GB23664@pengutronix.de>
References: <1274891873-3704-1-git-send-email-eric@eukrea.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 456821039F1
	for <alsa-devel@alsa-project.org>;
	Thu, 27 May 2010 10:24:20 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1274891873-3704-1-git-send-email-eric@eukrea.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Eric =?iso-8859-15?Q?B=E9nard?= <eric@eukrea.com>
Cc: alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Wed, May 26, 2010 at 06:37:53PM +0200, Eric B=E9nard wrote:
> * without this fix, the waveform on the SSI port are not real
> I2S signal (at least on i.MX27's SSI4)
> =

> * original Freescale's driver has
> 	if (((fmt & SND_SOC_DAIFMT_FORMAT_MASK) =3D=3D SND_SOC_DAIFMT_I2S)
> 	    && ssi_mode->network_mode) {
> 		scr &=3D ~SSI_SCR_I2S_MODE_MASK;
> 		scr |=3D SSI_SCR_I2S_MODE_SLAVE;
> 	}
> So as now the SSI is set in network mode as a default when running in
> I2S format, it seems reasonable to also set I2S_MODE_SLAVE
> =

> Signed-off-by: Eric B=E9nard <eric@eukrea.com>
> ---
>  sound/soc/imx/imx-ssi.c |    4 +---
>  1 files changed, 1 insertions(+), 3 deletions(-)
> =

> diff --git a/sound/soc/imx/imx-ssi.c b/sound/soc/imx/imx-ssi.c
> index 80b4fee..c5e1626 100644
> --- a/sound/soc/imx/imx-ssi.c
> +++ b/sound/soc/imx/imx-ssi.c
> @@ -83,8 +83,6 @@ static int imx_ssi_set_dai_tdm_slot(struct snd_soc_dai =
*cpu_dai,
>  /*
>   * SSI DAI format configuration.
>   * Should only be called when port is inactive (i.e. SSIEN =3D 0).
> - * Note: We don't use the I2S modes but instead manually configure the
> - * SSI for I2S because the I2S mode is only a register preset.
>   */
>  static int imx_ssi_set_dai_fmt(struct snd_soc_dai *cpu_dai, unsigned int=
 fmt)
>  {
> @@ -98,7 +96,7 @@ static int imx_ssi_set_dai_fmt(struct snd_soc_dai *cpu_=
dai, unsigned int fmt)
>  	case SND_SOC_DAIFMT_I2S:
>  		/* data on rising edge of bclk, frame low 1clk before data */
>  		strcr |=3D SSI_STCR_TFSI | SSI_STCR_TEFS | SSI_STCR_TXBIT0;
> -		scr |=3D SSI_SCR_NET;
> +		scr |=3D SSI_SCR_NET | SSI_SCR_I2S_MODE_SLAVE;

You should also zero out the SSI_I2S_MODE_MASK in the scr =3D readl()...
above.
Otherwise I'm ok with this patch.

Sascha


-- =

Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
