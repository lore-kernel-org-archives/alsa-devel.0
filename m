From: Markus Pargmann <mpa@pengutronix.de>
Subject: Re: [PATCH v3 09/18] ASoC: fsl-ssi: Only enable
	baudclk when used
Date: Wed, 16 Apr 2014 09:27:38 +0200
Message-ID: <20140416072738.GC6159@pengutronix.de>
References: <1397482548-28463-1-git-send-email-mpa@pengutronix.de>
 <1397482548-28463-10-git-send-email-mpa@pengutronix.de>
 <20140414152850.GB7197@MrMyself>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3743137022731430377=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id AA6312616E9
 for <alsa-devel@alsa-project.org>; Wed, 16 Apr 2014 09:27:49 +0200 (CEST)
In-Reply-To: <20140414152850.GB7197@MrMyself>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <Guangyu.Chen@freescale.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Alexander Shiyan <shc_work@mail.ru>, Mark Brown <broonie@kernel.org>, Timur Tabi <timur@tabi.org>, "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>, kernel@pengutronix.de, Sascha Hauer <s.hauer@pengutronix.de>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============3743137022731430377==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8X7/QrJGcKSMr1RN"
Content-Disposition: inline


--8X7/QrJGcKSMr1RN
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Apr 14, 2014 at 11:28:51PM +0800, Nicolin Chen wrote:
> On Mon, Apr 14, 2014 at 03:35:39PM +0200, Markus Pargmann wrote:
> > From: Sascha Hauer <s.hauer@pengutronix.de>
> >=20
> > Enable baudclk only when it is used. The baudclock is only needed in ma=
ster
> > mode and only when thr driver is active, so move enabling to fsl_ssi_st=
artup
> > and disabling to fsl_ssi_shutdown.
> >=20
> > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > ---
> >  sound/soc/fsl/fsl_ssi.c | 37 ++++++++++++++++++++++++++++++-------
> >  1 file changed, 30 insertions(+), 7 deletions(-)
> >=20
> > diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
> > index f2255cb..d6d3f0a3 100644
> > --- a/sound/soc/fsl/fsl_ssi.c
> > +++ b/sound/soc/fsl/fsl_ssi.c
> > @@ -236,6 +236,12 @@ static bool fsl_ssi_is_ac97(struct fsl_ssi_private=
 *ssi_private)
> >  	return !!(ssi_private->dai_fmt & SND_SOC_DAIFMT_AC97);
> >  }
> > =20
> > +static bool fsl_ssi_is_i2s_master(struct fsl_ssi_private *ssi_private)
> > +{
> > +	return (ssi_private->dai_fmt & SND_SOC_DAIFMT_MASTER_MASK) =3D=3D
> > +		SND_SOC_DAIFMT_CBS_CFS;
> > +}
> > +
> >  /**
> >   * fsl_ssi_isr: SSI interrupt handler
> >   *
> > @@ -489,6 +495,7 @@ static int fsl_ssi_startup(struct snd_pcm_substream=
 *substream,
> >  	struct fsl_ssi_private *ssi_private =3D
> >  		snd_soc_dai_get_drvdata(rtd->cpu_dai);
> >  	unsigned long flags;
> > +	int ret;
> > =20
> >  	if (!dai->active && !fsl_ssi_is_ac97(ssi_private)) {
> >  		spin_lock_irqsave(&ssi_private->baudclk_lock, flags);
> > @@ -496,6 +503,12 @@ static int fsl_ssi_startup(struct snd_pcm_substrea=
m *substream,
> >  		spin_unlock_irqrestore(&ssi_private->baudclk_lock, flags);
> >  	}
> > =20
> > +	if (fsl_ssi_is_i2s_master(ssi_private)) {
> > +		ret =3D clk_prepare_enable(ssi_private->baudclk);
> > +		if (ret)
> > +			return ret;
> > +	}
> > +
> >  	/* When using dual fifo mode, it is safer to ensure an even period
> >  	 * size. If appearing to an odd number while DMA always starts its
> >  	 * task from fifo0, fifo1 would be neglected at the end of each
> > @@ -508,6 +521,17 @@ static int fsl_ssi_startup(struct snd_pcm_substrea=
m *substream,
> >  	return 0;
> >  }
> > =20
> > +static void fsl_ssi_shutdown(struct snd_pcm_substream *substream,
> > +		struct snd_soc_dai *dai)
> > +{
> > +	struct snd_soc_pcm_runtime *rtd =3D substream->private_data;
> > +	struct fsl_ssi_private *ssi_private =3D
> > +		snd_soc_dai_get_drvdata(rtd->cpu_dai);
> > +
> > +	if (fsl_ssi_is_i2s_master(ssi_private))
> > +		clk_disable_unprepare(ssi_private->baudclk);
> > +}
> > +
> >  /**
> >   * fsl_ssi_hw_params - program the sample size
> >   *
> > @@ -576,6 +600,11 @@ static int fsl_ssi_set_dai_fmt(struct snd_soc_dai =
*cpu_dai, unsigned int fmt)
> > =20
> >  	ssi_private->dai_fmt =3D fmt;
> > =20
> > +	if (fsl_ssi_is_i2s_master(ssi_private) && IS_ERR(ssi_private->baudclk=
)) {
> > +		dev_err(cpu_dai->dev, "no baudclk needed for master mode\n");
> > +		return -EINVAL;
> > +	}
> > +
>=20
> I was wondering what if machine driver doesn't set fmt to master during
> its probe(), in another word -- before fsl_ssi_startup(), but leave that
> into its hw_params() via snd_soc_dai_set_fmt() which then would run after
> fsl_ssi_startup() while having no baud clock enabled in this case.
>=20
> A better solution may be to wrap clk_prepare_enable() and master mode
> clock dividing code into fsl_ssi_hw_params(), a bit like the ESAI driver
> even though it doesn't contain the clk_prepare_enable() part currently,
> and then to put clk_disable_unprepare() into hw_free() for symmetry.
>=20
> Any suggestion?

Yes this is a problem. Although I am not really convinced of the concept
of setting up the DAIs in hw_params, we should support it as there are
some users.

Is there always exactly one hw_free call for one hw_params call? There
is a comment above the function:
"Frees resources allocated by hw_params, can be called multiple times",
so I am not sure if we can directly use clk_prepare_enable or if we need
to remember the clock state?

Thanks,

Markus

--=20
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--8X7/QrJGcKSMr1RN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJTTjDpAAoJEEpcgKtcEGQQQLUP/1hudX/G+mUyroNnOVZwLNF4
XhdLx8CGBjNPLRXP5MGp42kyuPtAKwqAB1R6EPod5D8LZyIpY571hZ8bqbvMwg7V
RtDsL2wLEBG/Y6bRsG9fI0mEZe/ccpqEtpMKbkUBwBsZRiDfaTgnAvgCQuSalpKA
nX2NUMemgWQY/CHwo9JaEPTfssrHEUpaXvjnqZoYAy9NQFkUBGikEsHtzTE6azIY
icHukjQEoNvIY13XH+BqJb7AR0HcRsyMwDNxjpbcFrAUz9lHDopdI95vVQ+5/XSI
hTw1gd4hP+Q8lgisUa9nY9oqFWxfSpQTwZk6XIF+cH6U+2OsFmuL0CCzduoi91DE
LcbrUGeJFEN5YRrA5ESrLzw+YVfJtMaeVtp+cfvHfaGelEOf4GUAiF+HRUzWAFM2
X7sqqzpK5X857Ov9HJAJ+pTRcUZsMRHaNvt9Pl4j5Hy0WXKk4QipQGHaIjOpBCms
WE2DBDSMFoCxgBlsslvqbh1Cz6//Y5VlX3lksea7QaLlN4DYuVbc1WDdgEr8e/hM
VP3L+l7mP95VZ/F3LnS5YUFXcm7V65R1QMVGw57b9+7xQY6o4TuXkXE2c1/HYDd6
G9BMXdgk0ADIf8aISxP6v8wHz2EHFt1sSjPN/y1+RDgpQvhret+yT9nGwhVRgfkM
aUvql1jsgxdHK2hKYohv
=ZIw8
-----END PGP SIGNATURE-----

--8X7/QrJGcKSMr1RN--

--===============3743137022731430377==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3743137022731430377==--
