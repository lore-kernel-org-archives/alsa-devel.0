From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH v3 1/1] ASoC: mxs-saif: add record function
Date: Fri, 9 Sep 2011 15:30:51 +0200
Message-ID: <20110909133051.GS1912@pengutronix.de>
References: <1315399910-6525-1-git-send-email-b29396@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5370174072769730981=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id EFD8F24133
	for <alsa-devel@alsa-project.org>;
	Fri,  9 Sep 2011 15:30:52 +0200 (CEST)
In-Reply-To: <1315399910-6525-1-git-send-email-b29396@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Dong Aisheng <b29396@freescale.com>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, s.hauer@pengutronix.de, lrg@ti.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============5370174072769730981==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mln0rGgUGuXEqmuI"
Content-Disposition: inline


--mln0rGgUGuXEqmuI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 07, 2011 at 08:51:50PM +0800, Dong Aisheng wrote:
> 1. add different clkmux mode handling
> SAIF can use two instances to implement full duplex (playback &
> recording) and record saif may work on EXTMASTER mode which is
> using other saif's BITCLK&LRCLK.
>=20
> The clkmux mode could be set in pdata->init() in mach-specific code.
> For generic saif driver, it only needs to know who is his master
> and the master id is also provided in mach-specific code.
>=20
> 2. support playback and capture simutaneously however the sample
> rates can not be different due to hw limitation.
>=20
> Signed-off-by: Dong Aisheng <b29396@freescale.com>

One thing I see...

> @@ -422,20 +503,39 @@ static int mxs_saif_trigger(struct snd_pcm_substrea=
m *substream, int cmd,
>  			__raw_readl(saif->base + SAIF_DATA);
>  		}
> =20
> -		dev_dbg(cpu_dai->dev, "CTRL 0x%x STAT 0x%x\n",
> +		master_saif->ongoing =3D 1;
> +
> +		dev_dbg(saif->dev, "CTRL 0x%x STAT 0x%x\n",
>  			__raw_readl(saif->base + SAIF_CTRL),
>  			__raw_readl(saif->base + SAIF_STAT));
> =20
> +		dev_dbg(master_saif->dev, "CTRL 0x%x STAT 0x%x\n",
> +			__raw_readl(master_saif->base + SAIF_CTRL),
> +			__raw_readl(master_saif->base + SAIF_STAT));
>  		break;
>  	case SNDRV_PCM_TRIGGER_SUSPEND:
>  	case SNDRV_PCM_TRIGGER_STOP:
>  	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
>  		dev_dbg(cpu_dai->dev, "stop\n");
> =20
> -		clk_disable(saif->clk);
> -		if (!saif->mclk_in_use)
> +		/* wait a while for the current sample to complete */
> +		delay =3D USEC_PER_SEC / master_saif->cur_rate;
> +
> +		if (!master_saif->mclk_in_use) {
> +			__raw_writel(BM_SAIF_CTRL_RUN,
> +				master_saif->base + SAIF_CTRL + MXS_CLR_ADDR);
> +			udelay(delay);
> +		}
> +		clk_disable(master_saif->clk);
> +
> +		if (saif !=3D master_saif) {
>  			__raw_writel(BM_SAIF_CTRL_RUN,
>  				saif->base + SAIF_CTRL + MXS_CLR_ADDR);
> +			udelay(delay);

I think we should use usleep_range for both udelays here? Having a rate
of 8000, we'd burn 250us here.

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--mln0rGgUGuXEqmuI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk5qFQsACgkQD27XaX1/VRuODACbBhuxy0jTQsIk87ZOejCFMPvF
83UAnjKluZUE6LKwuP5sXpk4KpYu8JS/
=30fm
-----END PGP SIGNATURE-----

--mln0rGgUGuXEqmuI--

--===============5370174072769730981==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5370174072769730981==--
