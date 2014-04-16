From: Markus Pargmann <mpa@pengutronix.de>
Subject: Re: [PATCH v3 09/18] ASoC: fsl-ssi: Only enable
	baudclk when used
Date: Wed, 16 Apr 2014 10:43:31 +0200
Message-ID: <20140416084331.GD6159@pengutronix.de>
References: <1397482548-28463-1-git-send-email-mpa@pengutronix.de>
 <1397482548-28463-10-git-send-email-mpa@pengutronix.de>
 <20140414152850.GB7197@MrMyself>
 <20140416072738.GC6159@pengutronix.de>
 <20140416080826.GA13449@MrMyself>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8106562684200051255=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id B1A52261A7E
 for <alsa-devel@alsa-project.org>; Wed, 16 Apr 2014 10:43:46 +0200 (CEST)
In-Reply-To: <20140416080826.GA13449@MrMyself>
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


--===============8106562684200051255==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="76DTJ5CE0DCVQemd"
Content-Disposition: inline


--76DTJ5CE0DCVQemd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Nicolin,

On Wed, Apr 16, 2014 at 04:08:29PM +0800, Nicolin Chen wrote:
> Hi Markus,
>=20
> Please allow me to drop some content.
>=20
> On Wed, Apr 16, 2014 at 09:27:38AM +0200, Markus Pargmann wrote:
> > On Mon, Apr 14, 2014 at 11:28:51PM +0800, Nicolin Chen wrote:
> > > On Mon, Apr 14, 2014 at 03:35:39PM +0200, Markus Pargmann wrote:
> > > > +static bool fsl_ssi_is_i2s_master(struct fsl_ssi_private *ssi_priv=
ate)
> > > > +{
> > > > +	return (ssi_private->dai_fmt & SND_SOC_DAIFMT_MASTER_MASK) =3D=3D
> > > > +		SND_SOC_DAIFMT_CBS_CFS;
> > > > +}
>=20
> > > > @@ -496,6 +503,12 @@ static int fsl_ssi_startup(struct snd_pcm_subs=
tream *substream,
> > > >  		spin_unlock_irqrestore(&ssi_private->baudclk_lock, flags);
> > > >  	}
> > > > =20
> > > > +	if (fsl_ssi_is_i2s_master(ssi_private)) {
> > > > +		ret =3D clk_prepare_enable(ssi_private->baudclk);
> > > > +		if (ret)
> > > > +			return ret;
> > > > +	}
>=20
> > > > +static void fsl_ssi_shutdown(struct snd_pcm_substream *substream,
> > > > +		struct snd_soc_dai *dai)
> > > > +{
> > > > +	struct snd_soc_pcm_runtime *rtd =3D substream->private_data;
> > > > +	struct fsl_ssi_private *ssi_private =3D
> > > > +		snd_soc_dai_get_drvdata(rtd->cpu_dai);
> > > > +
> > > > +	if (fsl_ssi_is_i2s_master(ssi_private))
> > > > +		clk_disable_unprepare(ssi_private->baudclk);
> > > > +}
>=20
> > > > @@ -576,6 +600,11 @@ static int fsl_ssi_set_dai_fmt(struct snd_soc_=
dai *cpu_dai, unsigned int fmt)
> > > > =20
> > > >  	ssi_private->dai_fmt =3D fmt;
> > > > =20
> > > > +	if (fsl_ssi_is_i2s_master(ssi_private) && IS_ERR(ssi_private->bau=
dclk)) {
> > > > +		dev_err(cpu_dai->dev, "no baudclk needed for master mode\n");
> > > > +		return -EINVAL;
> > > > +	}
> > > > +
> > >=20
> > > I was wondering what if machine driver doesn't set fmt to master duri=
ng
> > > its probe(), in another word -- before fsl_ssi_startup(), but leave t=
hat
> > > into its hw_params() via snd_soc_dai_set_fmt() which then would run a=
fter
> > > fsl_ssi_startup() while having no baud clock enabled in this case.
> > >=20
> > > A better solution may be to wrap clk_prepare_enable() and master mode
> > > clock dividing code into fsl_ssi_hw_params(), a bit like the ESAI dri=
ver
> > > even though it doesn't contain the clk_prepare_enable() part currentl=
y,
> > > and then to put clk_disable_unprepare() into hw_free() for symmetry.
> > >=20
> > > Any suggestion?
> >=20
> > Yes this is a problem. Although I am not really convinced of the concept
> > of setting up the DAIs in hw_params, we should support it as there are
> > some users.
>=20
> I think it might be an old fashion way. I saw quite a lot machine drivers
> doing the DAI format setting in its hw_params(). Even in the current tree
> we can also grep some out by using:
>=20
> find ./sound/soc/ -name "*.c" |xargs grep "snd_soc_dai_set_fmt"
>=20
> So it should be plausible considering there might be some special cases,
> using CBS_CFS for 44.1KHz groups and CBM_CFM for 48KHz groups for example.
>=20
> > Is there always exactly one hw_free call for one hw_params call? There
> > is a comment above the function:
> > "Frees resources allocated by hw_params, can be called multiple times",
>=20
> That's a good question. IIRC, snd_pcm_release_substream() would call its
> hw_free() right before calling snd_pcm_close(). So there would be at least
> twice for hw_free()'s execution.
>=20
> > so I am not sure if we can directly use clk_prepare_enable or if we need
> > to remember the clock state?
>=20
> We need to if applying that. Or put them into trigger() as an alternative
> approach even if it sounds weird to me.

Unfortunately trigger() is not an option, it also may be called multiple
times for one command due to strange error handling in the layers above.
For example a failing START command in the DMA driver may lead to a
STOP command in the fsl-ssi driver without a previous START command.

So it seems the only option is to save the clock state? I will move it
to hw_params() and hw_free().

Thanks,

Markus

--=20
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--76DTJ5CE0DCVQemd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJTTkKzAAoJEEpcgKtcEGQQuLcP/iBLKblscRSaCw6PYGCWP+Ck
Y9qgJG9l8/AovkMNLYK4UZSCzmuqxPepqlm6yej0R+Sqr6yidxMh3C/eJEz3XE7C
CabE0tpd8OfiPh8e79lfm+cus6G3hO3v7hqK4HOvbgDdfxeij3Kpzcg1v/vaLan3
SkqS7sJFnA4fL5G2WM8dl0euKGHuZWd/ZHkkiKhysAV+qlcXrEvjla4zU9tSfDfb
ATN5FPN0I58LqU0ZyfezMaz6KnCWOQGCNc3kFtn2AUYdMTd2tR3CBuFwHWys5hCt
gWZwnDnN4VNqxtaOU1vRIVOFolOzkZMyS9xFQrNwO7aikLLl4mseUKyP4Zj42XMq
KFVXmV2EQVYhQmJ72YEdtKFALfnBXmClGBSoWVzkuw78Cg1Mgqnv0ZPS5F8W2qtc
PxZpzp3Pufoo0WI97L5YB1vWbg4Oa00547xv3Zt7ph8YbkNzd3GnE6IAS+9slSmA
OXE34gT8S38VIi9vlV82BzMXURgTajcfCaDQBgwTIUJJgMbt9I75FMMMExevF9Ug
Cur9q6AjTul73GkMnd29OxzV4do6oPMTl2hSEGRDo2+4HzP9sKWsGXh63a6GRrn9
RuJJhltqmpSovCcmtuRrAGEuyk1H7rerxK7jo/Gt7XtA50hY5D5aQgcoqfA6uxZm
c15ET8gxExfwxn+XjTiU
=oKYI
-----END PGP SIGNATURE-----

--76DTJ5CE0DCVQemd--

--===============8106562684200051255==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8106562684200051255==--
