From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v3] ASoC: da7210: Add support for PLL and
	SRM
Date: Wed, 1 Feb 2012 11:50:35 +0000
Message-ID: <20120201115035.GC5648@opensource.wolfsonmicro.com>
References: <1328095529.15257.7.camel@matrix>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5269108791855747688=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 801EE103B96
	for <alsa-devel@alsa-project.org>; Wed,  1 Feb 2012 12:50:38 +0100 (CET)
In-Reply-To: <1328095529.15257.7.camel@matrix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ashish Chavan <ashish.chavan@kpitcummins.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, alsa-devel <alsa-devel@alsa-project.org>, lrg <lrg@ti.com>, "kuninori.morimoto.gx" <kuninori.morimoto.gx@renesas.com>, David Dajun Chen <david.chen@diasemi.com>
List-Id: alsa-devel@alsa-project.org


--===============5269108791855747688==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7gGkHNMELEOhSGF6"
Content-Disposition: inline


--7gGkHNMELEOhSGF6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 01, 2012 at 04:55:29PM +0530, Ashish Chavan wrote:

> +static const u32 da7210_pll_div[][COL_CNT] = {
> +	/* for MASTER mode, fs = 44.1Khz */
> +	{ 12000000, 0xE8, 0x6C, 0x2, },		/* MCLK=12Mhz */

Even better than defines to index into the array would be an array of
structs with named members...

> +	if (da7210->mclk_rate) {
> +		/* PLL mode, disable PLL bypass */
> +		snd_soc_update_bits(codec, DA7210_PLL_DIV3, DA7210_PLL_BYP, 0);
> +	} else {
> +		/* PLL bypass mode, enable PLL bypass */
> +		snd_soc_update_bits(codec, DA7210_PLL_DIV3, DA7210_PLL_BYP,
> +							    DA7210_PLL_BYP);
> +	}

This is really weird - if anything it looks the wrong way round.
mclk_rate is what's set by set_sysclk() so if the user has configured
MCLK we will never use it even if it's at a suitable rate but if the
user hasn't configured one we rely on it directly.  If anything I'd
expect this code to enable the PLL only if the MCLK is not a suitable
rate.

The normal pattern is that set_sysclk() specifies the clock the bulk of
the device will be using, when used with the PLL that'd be the PLL
output not the PLL input.  Alternatively just specify the MCLK always
and let the driver figure out when to use the PLL.

> +	if (da7210->master) {
> +		/* In PLL master mode, use master mode PLL dividers */
> +		switch (fout) {
> +		case 2822400:
> +			row_idx = MASTER_2822400_DIV_OFFSET;
> +			break;
> +		case 3072000:
> +			row_idx = MASTER_3072000_DIV_OFFSET;
> +			break;
> +		default:
> +			dev_err(codec_dai->dev,
> +				"Unsupported PLL output frequency %d\n", fout);
> +			return -EINVAL;
> +		}
> +	} else {
> +		/* In PLL slave mode, use SRM mode PLL dividers */
> +		row_idx = SLAVE_SRM_DIV_OFFSET;
> +	}

You need checks elsewhere to make sure that the user doesn't try to
reconfigure master/slave while the PLL is active.

--7gGkHNMELEOhSGF6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPKSb/AAoJEBus8iNuMP3dIkoP/20D7UCnaf9UW40vKnjekQ4e
sYVeFt+sOuGfCr6bf7dbJo1txWo0bn/lMe/LdvlyTX6fFopnP+xhgDN5LlRmtXb4
pJwyLP39ohxzp/8lmB4WUWnWvIVbdTl5CTInWfleP7Mi6JogpUedRWgkxkf3vp3G
+P9rRMn84f65cJt5PzrPE1H+ClheNbh3wHou6Nh+9qv6jIzjQrBcIBiytg0qpS+C
xM9U63D/X3Zr35/dcA0L4l+NoKe3IcoZDr3eqHlkEcT966IFhnDHd51tLpYy+qMA
WAcAv0mwwWTQ1mqfV31Ix0rLd9O9gcKJiF1ArPcZwl5sd26C/0DAKO+YouLGaBZz
cPq3Z83D2A2ZBsTTxkQw28cROxx4v1r/6P4AzcmAitob85XwpaU+qzQjULqjCW9E
ugkv79nFhxtyi6PtLSEeAideBIQuAAN38H5e1foXCJRkim5ySHBu3LdF7Useop8v
8bkCUzHrn9PGZcqWUaLAXJrnBtGLpkJa9SeEhHHpZnwN4UUKjlAL3IHnoac87npp
flixBLKaWPu/nvC5woRJxjRXvt6YdzpPzi9zqYUtUkI7sLKjQHr1XxF/QB5xcnVy
ERV66OH6e4n1daVqSw1GinsUM4wz43cFm5RAEtrlMNDufvGoGoPaqdMGcw4Qu1BM
WrXyRojuGX8/Bpk5NYzO
=PkAD
-----END PGP SIGNATURE-----

--7gGkHNMELEOhSGF6--

--===============5269108791855747688==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5269108791855747688==--
