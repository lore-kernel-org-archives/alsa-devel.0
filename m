From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v3 2/2] ASoC: kirkwood: fix loss of
 external clock at probe time
Date: Fri, 18 Oct 2013 21:12:59 +0200
Message-ID: <20131018191259.GF10079@pengutronix.de>
References: <20131018203555.4d974251@armhf>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id B19EF261B29
 for <alsa-devel@alsa-project.org>; Fri, 18 Oct 2013 21:13:13 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20131018203555.4d974251@armhf>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jean-Francois Moine <moinejf@free.fr>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, alsa-devel@alsa-project.org, Jason Cooper <jason@lakedaemon.net>, Mark Brown <broonie@kernel.org>, Russell King <rmk+kernel@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hello,

On Fri, Oct 18, 2013 at 08:35:55PM +0200, Jean-Francois Moine wrote:
> diff --git a/sound/soc/kirkwood/kirkwood-i2s.c b/sound/soc/kirkwood/kirkw=
ood-i2s.c
> index 8ac89f5..2bbbab5 100644
> --- a/sound/soc/kirkwood/kirkwood-i2s.c
> +++ b/sound/soc/kirkwood/kirkwood-i2s.c
> @@ -496,15 +496,13 @@ static int kirkwood_i2s_dev_probe(struct platform_d=
evice *pdev)
>  		return err;
>  =

>  	priv->extclk =3D devm_clk_get(&pdev->dev, "extclk");
> -	if (!IS_ERR(priv->extclk)) {
> -		if (priv->extclk =3D=3D priv->clk) {
> -			devm_clk_put(&pdev->dev, priv->extclk);
> -			priv->extclk =3D ERR_PTR(-EINVAL);
> -		} else {
> -			dev_info(&pdev->dev, "found external clock\n");
> -			clk_prepare_enable(priv->extclk);
> -			soc_dai =3D &kirkwood_i2s_dai_extclk;
> -		}
> +	if (IS_ERR(priv->extclk)) {
> +		if (PTR_ERR(priv->extclk) =3D=3D -EPROBE_DEFER)
> +			return -EPROBE_DEFER;
Maybe the better logic here is:
		if (!PTR_ERR(priv->extclk) =3D=3D -ENOENT)
			return PTR_ERR(priv->extclk);

?

> +	} else {
> +		dev_info(&pdev->dev, "found external clock\n");
> +		clk_prepare_enable(priv->extclk);
> +		soc_dai =3D kirkwood_i2s_dai_extclk;
Another todo (that is already in the patched code) is that you should
check the return value of clk_prepare_enable.

Best regards
Uwe

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
